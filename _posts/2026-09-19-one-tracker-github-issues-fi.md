---
title: "Yksi tracker, ei statustiedostoja: miksi pyöritän kaikki projektini GitHub Issuesilla"
description: "Jokainen tracker, joka vaati erillisen päivityksen työn jälkeen, vanheni viikoissa. Git-historia ei vanhentunut, joten GitHub Issuesista tuli ainoa tracker."
date: 2026-09-19
categories: [Työskentelytavat]
tags: [github issues, projektinhallinta, tekoälyagentit, claude code, git]
author: "Admin"
read_time: 6
permalink: /blogi/yksi-tracker-github-issues/
twin: /blog/one-tracker-github-issues/
lang: fi
---

Heinäkuussa 2026 kävin läpi neljä omaa tuoterepositoriotani nähdäkseni, miten työtä niissä seurataan. GitHubin puolelta tulos oli lyhyt: nolla issueta ja nolla pull requestia jokaisessa repossa. Työ oli commitoitu suoraan main-haaraan.

Se ei tarkoittanut, ettei mitään seurattu. Seurantaa oli paljon, ja kaikki se oli tiedostoissa. Juuri siinä oli ongelma.

## Mitä repoista löytyi

Jokaisessa repossa oli oma järjestelmänsä sille, mitä on tehty ja mitä tulee seuraavaksi. BMAD-menetelmän sprint-status-tiedosto. YAML-muotoinen roadmap. Numeroidut sessiolokit. Statustaulukoita CLAUDE.md-tiedostossa, eli ohjetiedostossa, jonka koodausagentti lukee session alussa. Jokainen oli otettu käyttöön harkiten, ja jokainen vanheni yhdestä kolmeen viikossa.

Muutama esimerkki auditoinnista:

- Yksi sprint-status-tiedosto oli jäätynyt, ja noin 40 myöhempää committia oli jäänyt kirjaamatta. Saman repon erillinen roadmap-tiedosto oli tuoreempi, mutta sekin laahasi perässä.
- Toisessa repossa sessiolokit loppuivat numeroon 32. Sessiot numerosta 33 numeroon 45 löytyvät vain jatkuvasti päivitettävästä siirtomuistiosta ja commit-viesteistä.
- Yhdessä CLAUDE.md kuvasi projektin tilaksi "pre-code". Reposta löytyi tuolloin jo CI ja julkaistuja sivuja.
- Neljännessä suunnittelu oli tehty, mutta toteutuksen seurantaa ei koskaan aloitettu. Ei sprint-tiedostoa, ei story-tiedostoja.

Ainoa tieto, joka pysyi ajan tasalla kaikissa neljässä repossa, oli git-historia. Commit-viestit olivat johdonmukaisia. Osa niistä viittasi story-tunnisteisiin, jotka osoittivat trackeriin, joka ei enää vastannut todellisuutta.

Itse suunnitteludokumentit olivat kunnossa. PRD:t ja epicit hyväksymiskriteereineen olivat parasta materiaalia noissa repoissa. Puuttui tracker, joka pysyisi totuudenmukaisena.

## Miksi ne vanhenivat

Vika on kaksoiskirjaus (dual-write). Teet työn, ja sen jälkeen teet erillisen muutoksen, jolla kirjaat työn tehdyksi. Tracker, joka vaatii tuon toisen muutoksen, jää jossain vaiheessa ilman sitä. Kun yksi ihminen tekee töitä koodausagenttien kanssa, työ etenee nopeammin kuin kirjanpito, joten ero syntyy nopeasti.

Kun statustiedosto on kerran väärässä kohdassa väärin, se ei ole enää statustiedosto. Se on dokumentti, jonka paikkansapitävyys pitää tarkistaa koodista, ja silloin sillä ei ole enää tehtävää.

## Miten työskentelen nyt

GitHub Issues on ainoa tracker. Säännöt sen ympärillä ovat vähissä:

1. Yksi issue, yksi haara, yksi pull request.
2. Pull requestin kuvauksessa on `Closes #n`. Kun pull request yhdistetään, GitHub sulkee issuen.
3. Ratkaistut päätökset lisätään numeroituina merkintöinä (D-001, D-002 ja niin edelleen) siihen pull requestiin, joka toteuttaa päätöksen. Päätös ja koodi tulevat yhdessä, ja historiasta näkee, milloin.
4. CLAUDE.md on pelkkää orientaatiota: mikä projekti on, miten se ajetaan ja mistä mikäkin löytyy. Ei statusta, ei nykyistä vaihetta.
5. Asioita, jotka voi johtaa repositoriosta, ei kirjoiteta ylös. Kuinka monta lähdekooditiedostoa on, onko CI käytössä, mitkä sivut on julkaistu: repo kertoo sen jo. "Pre-code"-rivi oli johdettavissa oleva tieto, jonka joku kirjoitti ylös ja jota kukaan ei päivittänyt.

Säännössä 2 olennaista on, että issuen sulkeminen on sivuvaikutus git-tapahtumasta, joka minun piti joka tapauksessa tehdä. Erillistä vaihetta ei ole, jonka voisi jättää väliin. Avoin issue tarkoittaa yleensä yhdistämätöntä työtä, ja suljettu issue sitä, että pull request meni läpi.

## Vanhan työkalupaketin poisto

Sama auditointi löysi kolmesta repositoriosta saman agenttityökalupaketin: noin 80 skilliä per repo, BMADista ja sen lähipaketeista. Suunnitteluvaihe oli tuottanut hyviä dokumentteja. Toteutusvaihe joko ei koskaan otettu käyttöön tai kuoli varhain.

Syyskuussa 2026 poistin paketin. Yhdessä repossa se tarkoitti 3 225 tiedoston poistamista, noin 31 MB. Suunnitteludokumentit jäivät, tavallisina Markdown-tiedostoina. Periaate on kestävä repo ja kertakäyttöinen työkalu: se, minkä pitää säilyä, on repossa muodossa, jonka mikä tahansa työkalu osaa lukea, ja ympärillä olevan agenttityökalupaketin voi vaihtaa menettämättä mitään.

## Mikä ei toiminut ja mitä muuttaisin edelleen

**CI-tarkistukset ovat neuvoa-antavia.** GitHubin branch protection ei ole käytettävissä yksityisissä repoissa Free-tilauksella. Epäonnistunut tarkistus ei estä yhdistämistä, ja yhdistäminen on käsin tehtävä toimenpide, jonka teen omistajana. "Yksi issue, yksi haara, yksi pull request" on siis tapa, jota noudatan, ei sääntö, jota GitHub valvoo.

**Kokemusta on vähän.** Vanhatkin järjestelmät näyttivät ensimmäisinä viikkoina hyviltä. Muutaman viikon siisti historia todistaa vähän siitä, miten tämä toimii kuudennen kuukauden kohdalla.

**Issuet asuvat GitHubissa, eivät repossa.** Vanhat Markdown-tiedostot olivat ainakin siirrettävissä. Tehtävälista on nyt riippuvuus alustaan. Siksi päätökset ja suunnitteludokumentit pysyvät repossa, ja tehtävälista on se osa, jonka hyväksyn vuokraavani.

**Tracker ei korjaa kaikkea, mitä auditointi löysi.** Esiin tuli myös tuotantokoodia, joka oli versionhallinnan ulkopuolella: datapipeline työnkulkutyökalussa, joka ei ollut gitissä, ja paikallinen repo ilman remotea. Se, missä tehtävät asuvat, ei siirrä tuota koodia turvaan. Se on erillistä työtä.

## Testi, jota käytän

Kun katson jotakin seurantajärjestelyä nyt, kysyn, mitä se vaatii minua kirjoittamaan työn valmistumisen jälkeen. Jos vastaus on mitä tahansa, oletan sen vanhenevan muutamassa viikossa.
