# LureDesigner - maly lokalni server (jen pro tento pocitac, bez instalace)
# Spousti se dvojklikem na "Spustit LureDesigner.bat".
$ErrorActionPreference = 'Stop'
$root = [System.IO.Path]::GetFullPath($PSScriptRoot).TrimEnd('\', '/') + [System.IO.Path]::DirectorySeparatorChar

$mime = @{
  '.html' = 'text/html; charset=utf-8'; '.js' = 'text/javascript; charset=utf-8'
  '.css' = 'text/css; charset=utf-8'; '.json' = 'application/json'
  '.wasm' = 'application/wasm'; '.svg' = 'image/svg+xml'; '.png' = 'image/png'
  '.jpg' = 'image/jpeg'; '.ico' = 'image/x-icon'; '.stl' = 'model/stl'
  '.glb' = 'model/gltf-binary'; '.txt' = 'text/plain; charset=utf-8'
}

# najdi volny port
$listener = $null
foreach ($port in 8123..8140) {
  $l = New-Object System.Net.HttpListener
  $l.Prefixes.Add("http://localhost:$port/")
  try { $l.Start(); $listener = $l; break } catch { $l.Close() }
}
if (-not $listener) { Write-Host 'Nepodarilo se spustit server (porty 8123-8140 jsou obsazene).'; Read-Host 'Enter = konec'; exit 1 }

$url = "http://localhost:$port/"
Write-Host ''
Write-Host "  LureDesigner bezi na $url"
Write-Host '  Prohlizec se otevre sam. Toto okno nechte otevrene, zavrenim aplikaci ukoncite.'
Write-Host ''
Start-Process $url

while ($listener.IsListening) {
  $ctx = $listener.GetContext()
  $res = $ctx.Response
  try {
    $rel = [System.Uri]::UnescapeDataString($ctx.Request.Url.AbsolutePath).TrimStart('/')
    if ($rel -eq '' -or $rel.EndsWith('/')) { $rel += 'index.html' }
    $path = [System.IO.Path]::GetFullPath((Join-Path $root $rel))
    if ($path.StartsWith($root, [System.StringComparison]::OrdinalIgnoreCase) -and (Test-Path -LiteralPath $path -PathType Leaf)) {
      $bytes = [System.IO.File]::ReadAllBytes($path)
      $ext = [System.IO.Path]::GetExtension($path).ToLower()
      $res.ContentType = if ($mime.ContainsKey($ext)) { $mime[$ext] } else { 'application/octet-stream' }
      $res.Headers.Add('Cache-Control', 'no-cache')
      $res.ContentLength64 = $bytes.Length
      $res.OutputStream.Write($bytes, 0, $bytes.Length)
    } else {
      $res.StatusCode = 404
    }
  } catch {
    try { $res.StatusCode = 500 } catch {}
  } finally {
    try { $res.Close() } catch {}
  }
}
