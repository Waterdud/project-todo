# TODO-lista XSLT projekti testimise juhend

## Kiire alustamine

### Samm 1: Avage avaleht
Avage fail `tasks.xml` brauseris - see on projekti **avaleht**.

### Samm 2: Testib navigeerimine
Kasutage navigeerimisnuppe lehtede vahel liikumiseks:
- **Home** - tagasi avalehele
- **Add Task** - uue ülesande lisamise vorm
- **JSON** - andmete vaatamine JSON formaadis

### Samm 3: Testib sorteerimist
Avalehel vajutage sorteerimise nuppe:
- **ID järgi** - sorteerimine ülesande numbri järgi
- **Kuupäeva järgi (Tähtaeg)** - sorteerimine tähtaja järgi
- **Aine järgi** - grupeerimine õppeainete kaupa

## Täielik testimise nimekiri

### Navigeerimine ja struktuur
- [ ] Avaleht (`tasks.xml`) laadib korrektselt
- [ ] Kõik 3 navigeerimisnuppu töötavad
- [ ] Disain kasutab ainult hall-valgeid toone
- [ ] Adaptiivsus mobiilseadmetel

### Sorteerimine (ainult XSLT!)
- [ ] **ID järgi**: `todo_sort_id.xml` - numbriline sorteerimine 1-st 6-ni
- [ ] **Kuupäeva järgi**: `todo_sort_date.xml` - sorteerimine tähtaja järgi (kõige kiireloomulisemad esimesed)
- [ ] **Aine järgi**: `todo_sort_subject.xml` - tähestikuline grupeerimine

### Lehed
- [ ] **Home**: Täielik tabel navigeerimise ja filtritega
- [ ] **Add**: Lisamise vorm väljade valideerimisega
- [ ] **JSON**: Korrektne JSON-väljund tegevuste nuppudega

### Lisafunktsioonid
- [ ] Filtreerimine aine "Matemaatika" järgi: `todo_filter_matemaatika.xml`
- [ ] Statistika avalehel (ülesannete/ainete arv)
- [ ] JSON-i kopeerimine ja allalaadimine

### Valideerimine ja standardid
- [ ] XML on kehtiv XSD skeemi (`todo.xsd`) kohaselt
- [ ] XSLT 1.0 ühilduvus
- [ ] Korrektne UTF-8 kodeering

## Mida testida disainis

### Värviskeem:
- **#ffffff** - valge taust
- **#eeeeee** - helehallid elemendid
- **#cccccc** - keskmised hallid piirid
- **#f5f5f5** - lehe taust

### Tüpograafia:
- Font: Segoe UI
- Pealkirjad väikese kaaluga (font-weight: 300)
- Adekvaatsed vahed ja ridade kõrgus

### Interaktiivsus:
- Hõljumine nuppude kohal (hover effects)
- Aktiivse sorteerimise esiletõstmine
- Ülemineku animatsioonid

## Failid testimiseks

| Fail | Otstarve | Mida testida |
|------|----------|--------------|
| `tasks.xml` | Avaleht | Põhifunktsionaalsus, navigeerimine |
| `todo_sort_*.xml` | Sorteerimine | Iga sorteerimise tüüp eraldi |
| `todo_add.xml` | Lisamine | Vorm ja olemasolevad ained |
| `todo_json.xml` | JSON eksport | JSON korrektsus, tegevuste nupud |
| `todo_filter_*.xml` | Filtreerimine | Otsing ainete järgi |

## Oodatav käitumine

### Sorteerimine ID järgi:
```
ID: 1, 2, 3, 4, 5, 6 (kasvavalt)
```

### Sorteerimine kuupäeva järgi:
```
2025-01-15 (kõige varasem tähtaeg)
2025-01-18
2025-01-20
2025-01-22
2025-01-25
2025-01-30 (kõige hilisem tähtaeg)
```

### Sorteerimine aine järgi:
```
Andmebaasid (2 ülesannet)
Matemaatika (2 ülesannet)
Programmeerimine (2 ülesannet)
```

## Võimalikud probleemid

### Kui XSLT ei rakendu:
1. Kasutage kaasaegset brauserit (Chrome, Firefox, Safari)
2. Avage HTTP-serveri kaudu (mitte file://)
3. Kontrollige UTF-8 kodeeringut

### Kui sorteerimine ei tööta:
- Veenduge, et avate õige XML-faili
- Igal sorteerimise tüübil on oma eraldi fail
- Kontrollige XPath-avaldisi XSLT-s

### Kui stiilid ei laadi:
- Kõik stiilid on XSLT-sse põimitud (ei kasuta välist CSS-i)
- Kontrollige `<style>` sektsioone igas XSLT-s

## Andmed testimiseks

Projekt sisaldab 6 test-ülesannet:
- **3 ainet**: Matemaatika, Programmeerimine, Andmebaasid
- **Kuupäevad**: 2025-01-15 kuni 2025-01-30
- **Erinevad ülesannete tüübid**: Kodutöö, Projekt, Praktikum, Kontrolltöö, Laboritöö

## Edukas testimise kriteeriumid

Funktsionaalsus: Kõik 3 sorteerimise tüüpi töötavad
Navigeerimine: Kõik lehed on nuppude kaudu kättesaadavad
Disain: Minimalistlik hall-valge liides
XSLT: Sorteerimine ilma JavaScriptita
Standardid: Kehtiv XML/XSLT kood
Lisaks: JSON eksport ja filtreerimine töötavad

---

**Testimise aeg**: ~10-15 minutit
**Soovitatud brauser**: Chrome/Firefox
**Staatus**: Valmis testimiseks