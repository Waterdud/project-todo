# TODO List - XSLT Projekt

Täisfunktsionaalne ülesannete haldussüsteem, mis on realiseeritud ainult **XSLT** ja **XML** abil.

## Projekti omadused

- **100% XSLT** - Kogu sorteerimisloogika on realiseeritud XSLT-s ilma JavaScriptita
- **3 sorteerimise tüüpi**: ID, kuupäev (tähtaeg), aine (oppeaine)
- **Lehtede vahel navigeerimine**: Home, Add, JSON
- **Minimalistlik disain**: Ainult hallid ja valged toonid (#ffffff, #eeeeee, #cccccc)
- **Filtreerimine ainete järgi** - ülesannete otsing õppeainete kaupa
- **JSON eksport** - võimalus andmete eksportimiseks JSON formaadis
- **Kehtiv XML Schema** (XSD) andmestruktuuri kontrollimiseks

## Failide struktuur

```
todo-project/
├── tasks.xml               # Põhiandmed + Home leht
├── todo_home.xslt          # Avaleht (baassorteerimine)
├── todo_sort_id.xml        # XML ID järgi sorteerimiseks
├── todo_sort_id.xslt       # XSLT ID järgi sorteerimiseks
├── todo_sort_date.xml      # XML kuupäeva järgi sorteerimiseks
├── todo_sort_date.xslt     # XSLT kuupäeva järgi sorteerimiseks (tähtaeg)
├── todo_sort_subject.xml   # XML aine järgi sorteerimiseks
├── todo_sort_subject.xslt  # XSLT aine järgi sorteerimiseks
├── todo_add.xml            # XML lisamise vormi jaoks
├── todo_add.xslt           # Uue ülesande lisamise vorm
├── todo_json.xml           # XML JSON lehe jaoks
├── todo_json.xslt          # JSON eksport ja kuvamine
├── todo_filter.xslt        # Filtreerimine ainete järgi
├── todo.xsd                # XML Schema valideerimiseks
├── todo.php                # PHP vormi töötleja (valikuline)
├── style.css               # Globaalsed stiilid
└── README.md               # Dokumentatsioon
```

## Kuidas kasutada

### 1. Põhinavigatsioon
- Avage `tasks.xml` brauseris **avalehe** jaoks
- Kasutage navigeerimisnuppe lehtede vahel liikumiseks:
  - **Home** - avaleht kõigi ülesannetega
  - **Add Task** - uue ülesande lisamise vorm
  - **JSON** - andmete vaatamine JSON formaadis

### 2. Andmete sorteerimine (ainult XSLT!)
Kolm sorteerimise võimalust, mis on realiseeritud läbi eraldi XSLT-failide:

#### ID järgi (kasvavalt):
- Avage `todo_sort_id.xml`
- Või vajutage avalehel nuppu "ID järgi"

#### Tähtaja järgi (tähtaeg):
- Avage `todo_sort_date.xml`
- Või vajutage nuppu "Kuupäeva järgi (Tähtaeg)"
- Ülesanded sorteeritakse kiireloomulisematest vähem kiireloomulisteni

#### Aine järgi (oppeaine):
- Avage `todo_sort_subject.xml`
- Või vajutage nuppu "Aine järgi"
- Ülesanded grupeeritakse õppeainete kaupa

### 3. Filtreerimine ainete järgi
- Avalehel jaotises "Filtreeri aine järgi" klõpsake ükskõik millist ainet
- Näidatakse ainult valitud õppeaine ülesandeid
- Kasutage "Lähtesta" nuppu täieliku loendi juurde naasmiseks

### 4. JSON eksport
- Minge JSON lehele (`todo_json.xml`)
- Kasutage nuppe:
  - **Copy JSON** - kopeeri lõikelauale
  - **Download** - laadi alla failina
  - **Validate** - kontrolli JSON korrektsust

## Disain

Projekt kasutab **minimalistlikku disaini** värvigammaga:
- `#ffffff` - valge (sisu taust)
- `#eeeeee` - helehall (liidese elemendid)
- `#cccccc` - keskmine hall (piirid, rõhutused)
- `#f5f5f5` - väga helehall (lehe taust)

### Tüpograafia:
- Font: Segoe UI (Windowsi süsteemifont)
- Minimaalsed varjud ja efektid
- Adaptiivne disain mobiilseadmetele

## XML andmestruktuur

```xml
<tasks>
    <task>
        <id>1</id>
        <kuupaev>2025-01-15</kuupaev>      <!-- Loomise kuupäev -->
        <tahtaeg>2025-01-20</tahtaeg>       <!-- Tähtaeg -->
        <oppeaine>Matemaatika</oppeaine>    <!-- Õppeaine -->
        <info>Ülesande kirjeldus</info>     <!-- Lisainfo -->
        <ylesanne>Ülesande nimi</ylesanne>  <!-- Nimi/pealkiri -->
    </task>
</tasks>
```

## Tehniline realiseerimine

### XSLT Sorteerimine
Kõik kolm sorteerimise tüüpi on realiseeritud elemendi `<xsl:sort>` abil:

```xsl
<!-- ID järgi (numbriline sorteerimine) -->
<xsl:sort select="id" data-type="number" order="ascending"/>

<!-- Kuupäeva järgi (tekstiline kuupäevade sorteerimine formaadis YYYY-MM-DD) -->
<xsl:sort select="tahtaeg" order="ascending"/>

<!-- Aine järgi (tähestikuline sorteerimine) -->
<xsl:sort select="oppeaine" order="ascending"/>
```

### XSLT Filtreerimine
Filtreerimine ainete järgi on realiseeritud XPath-predikaatide kaudu:

```xsl
<!-- Näita ainult kindla aine ülesandeid -->
<xsl:apply-templates select="tasks/task[oppeaine = $filterSubject]"/>

<!-- Hangi unikaalsed ained -->
<xsl:for-each select="tasks/task[not(oppeaine = preceding-sibling::task/oppeaine)]">
```

### JSON genereerimine
JSON luuakse tekstilise genereerimise teel XSLT-s:

```xsl
<xsl:text>{"id": </xsl:text>
<xsl:value-of select="id"/>
<xsl:text>, "title": "</xsl:text>
<xsl:value-of select="ylesanne"/>
<xsl:text>"}</xsl:text>
```

## Nõuetele vastavus

Vähemalt 3 XSLT-malli: Home, Add, JSON
Navigeerimine lehtede vahel: Nupud kõigil lehtedel
3 sorteerimise funktsiooni: ID, kuupäev, aine (ainult XSLT)
Minimalistlik disain: Hall-valge palett
Filtreerimine ainete järgi: Otsing XSLT-s
JSON formaat: Eraldi leht transformatsiooniga
Kehtiv XML: XSD skeemiga
Iseseisvad XSLT: Kõik stiilid ja loogika XSLT sees

## Projekti käivitamine

1. **Lihtne viis**: Avage `tasks.xml` kaasaegses brauseris (Chrome, Firefox, Safari)
2. **Veebiserveriga**: Paigutage failid veebiserverisse PHP toega (vormide töötlemiseks)
3. **Lokaalselt**: Kasutage lihtsat HTTP-serverit (näiteks Python: `python -m http.server`)

## Märkused

- Kõik stiilid on XSLT-failidesse põimitud autonoomsuse jaoks
- Sorteerimine töötab ilma JavaScriptita - ainult XSLT
- Projekt vastab täielikult XML/XSLT 1.0 standarditele
- Adaptiivne disain toetab mobiilseadmeid
- Kood on dokumenteeritud ja järgib parimaid tavasid

## Funktsionaalsuse laiendamine

Uute funktsioonide lisamiseks:

1. **Uus sorteerimine**: Looge uus XSLT teistsuguse `<xsl:sort>`-ga
2. **Lisakataloogi**: Kasutage XPath-predikaate `select`-is
3. **Uued väljad**: Uuendage XSD skeemi ja kõiki XSLT-malle
4. **Stiilid**: Muutke CSS-i iga XSLT sees

---

**Autor**: TODO Projekti Meeskond
**Versioon**: 1.0
**Kuupäev**: Detsember 2025