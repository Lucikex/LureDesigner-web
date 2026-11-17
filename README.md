# LureDesigner

Návrhář gumových nástrah. Aplikace běží zde: https://lucikex.github.io/LureDesigner-web/

Tento repozitář obsahuje jen sestavenou aplikaci. Zdrojový kód je v repozitáři
[LureDesigner](https://github.com/Lucikex/LureDesigner).

## Spuštění na vlastním počítači (i bez internetu a při soukromém repozitáři)

Aplikace potřebuje malý lokální server, protože prohlížeč nedovolí načíst výpočetní jádro (WebAssembly)
přímo ze souboru. Nic se neinstaluje, stačí Windows.

1. Stáhněte repozitář: na GitHubu **Code → Download ZIP** (nebo `git clone`) a ZIP rozbalte.
2. Ve složce dvakrát klikněte na **`Spustit LureDesigner.bat`**.
3. Otevře se černé okno a prohlížeč s aplikací (obvykle `http://localhost:8123/`).
   Okno nechte otevřené, jeho zavřením aplikaci ukončíte.

Když Windows zobrazí „Systém Windows ochránil váš počítač“, klikněte na **Další informace → Přesto spustit**
(skript je jen tento repozitář, nic nestahuje). Server je dostupný jen z tohoto počítače.

Návrhy uložené v aplikaci (Knihovna) se ukládají v prohlížeči podle adresy, takže verze na
`localhost` a verze na GitHub Pages mají každá svou knihovnu. Návrh přenesete přes **Soubor → Stáhnout návrh (.json)** a **Načíst návrh (.json)**.

**macOS / Linux:** v rozbalené složce spusťte `python3 -m http.server 8123` a otevřete http://localhost:8123/.
