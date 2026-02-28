---
title: "Portfoliosivusto"
description: "Tämä sivusto. Jekyll, GitHub Pages, rakennettu Claude Codella."
image: /assets/images/projects/esahakulinen-mixtape-cassette.webp
date: 2025-01-20
status: live
tagline: "esahakulinen.fi"
tech:
  - Jekyll
  - jekyll-polyglot
  - GitHub Pages
  - Claude Code
  - Markdown
  - CSS
live_url: "https://esahakulinen.fi"
permalink: /projektit/portfoliosivusto/
twin: /projects/portfolio-website/
lang: fi
results:
  - value: "Ilmainen"
    label: "Hosting-kustannus"
  - value: "Julkaistu"
    label: "Portfoliosivusto"
---

## Tausta

GitHub-repositorio on ollut olemassa vuodesta 2022. Se alkoi paikkana testata asioita ja oppia. Tammikuussa 2025 kasasin yksinkertaisen HTML-sivun: suomenkielisen kotisivun, jossa luki "Tervetuloa" eikä juuri muuta. Se pyöri yksinkertaisella `index.html`-tiedostolla, johon oli lisätty hieman CSS:ää ja JavaScriptiä.

Vuotta myöhemmin päätin tehdä siitä kunnollisen portfoliosivuston. Käytin Claude Codea koko sivuston uudelleenrakentamiseen Jekyll-projektina. Perusinfrastruktuuri, sisältökokoelmat, ulkoasut ja atominen suunnittelujärjestelmä syntyivät parissa päivässä.

## Miksi rakentaa alusta

Portfoliosivuston pystyttämiseen on monta valmista tapaa. Valmisteemoja, sivustorakentajia, malleja. Halusin rakentaa tämän alusta asti harjoituksena täysin räätälöidyn kokonaisuuden luomisesta. Suunnittelujärjestelmä, ulkoasut ja komponentit ovat kaikki itse rakennettuja.

Toisaalta en keksinyt kaikkea uudelleen. Sivusto käyttää vakio-Jekyll-lisäosia perusasioihin, ja räätälöity työ rakentuu niiden päälle.

## Teknologiavalinnat

**Jekyll**, koska kaikki on Markdown-tiedostoja Git-repositoriossa. Kirjoita tiedosto, pushaa, ja sivusto rakentuu automaattisesti. Ei tietokantaa, ei sisällönhallintajärjestelmää ylläpidettäväksi.

**GitHub Pages** hostingiin. Ilmainen, luotettava, ja julkaisu on pelkkä push main-haaraan.

**Atominen suunnittelurakenne** CSS:lle ja templaateille. Sivusto käyttää atomeja, molekyylejä ja organismeja rakennuspalikoina. Tämä tarkoittaa, että uuden sivutyypin tai komponentin lisääminen ei vaadi olemassa olevan koodin muokkaamista.

**jekyll-polyglot** monikielisyyteen. Sivusto on kaksikielinen alusta asti, ja polyglot hoitaa sivuston rakentamisen kahdesti (kerran per kieli) ja ohjaa kunkin version oikeaan URL-polkuun. Suomi saa juuriosoitteet suomenkielisillä poluilla, englanti saa `/en/`-etuliitteen englanninkielisillä poluilla. Jokainen templaatti hakee tekstinsä kielikohtaisista datatiedostoista, joten kielen lisääminen on datamuutos, ei templaattien uudelleenkirjoitus.

**Claude Code** varsinaiseen rakentamiseen. Koko Jekyll-infrastruktuuri, kaikki ulkoasut, includet ja CSS-tiedostot rakennettiin tekoälykoodaustyökaluilla. Näin myös jatkan sivuston kehittämistä.

## SEO-toteutus

Sivusto käyttää kolmea Jekyll-lisäosaa hakukoneoptimointiin:

**jekyll-seo-tag** generoi meta-tagit, Open Graph -tagit, Twitter-kortit, canonical-URL:t ja JSON-LD-rakenteisen datan automaattisesti front matterista. Head-templaatissa on vain `{% raw %}{% seo %}{% endraw %}` manuaalisten meta-tagien sijaan, mikä välttää yleisen ongelman päällekkäisistä tageista.

**jekyll-sitemap** generoi XML-sivukartan. **jekyll-feed** hoitaa RSS-syötteen.

Lisäosa-tuotannon päälle sivustolla on räätälöityjä JSON-LD-skeemoja tietyille sivutyypeille. Projektisivut saavat `CreativeWork`-skeeman, joka sisältää teknologiapinon, GitHub-URL:n ja projektin tilan. Tietoa-sivu saa `ProfilePage`-skeeman rakenteisella henkilödatalla. Kaikki sivut, joilla on murupolku, saavat `BreadcrumbList`-skeeman, joka heijastaa visuaalista murupolkua.

Kirjoittaja-asettelu käyttää jaettua lähestymistapaa. Sivulla blogikirjoitusten tekijäksi merkitään "Admin." Tekijämerkintä portfoliosivustolla tuntui turhalta toistolta; nimeni on jo URL:ssa, navigaatiossa ja tietoa-sivulla. Suurin osa internetin blogikirjoituksista on muutenkin adminin kirjoittamia. Se sopii. Taustalla rakenteinen data selvittää oikean tekijänimen `_data/authors.yml`-haun kautta, joten hakukoneet saavat oikean henkilön, vaikka sivu ei tee siitä numeroa.

Oletus-OG-kuvat on asetettu sisältötyypeittäin, jotta jokaisella sivulla on jotain näytettävää jaettaessa, vaikka front matterissa ei olisi omaa kuvaa.

## Monikielisyys

Sivusto on kaksikielinen: suomi ja englanti. Suomi on oletuskieli ja sitä palvellaan juuriosoitteissa suomenkielisillä poluilla (`/blogi/`, `/projektit/`, `/tietoa/`). Englanti löytyy `/en/`-polun alta englanninkielisillä poluilla (`/en/blog/`, `/en/projects/`, `/en/about/`).

Tämän hoitaa jekyll-polyglot. Jokaisessa sisältötiedostossa on `lang`-kenttä front matterissa, ja polyglot rakentaa sivuston kahdesti, kerran per kieli, sijoittaen kunkin version oikeaan URL-polkuun. Kaikki käyttöliittymätekstit templaateissa (navigaatio, painikkeet, nimikkeet, murupolut) tulevat kielikohtaisista datatiedostoista sen sijaan, että ne kirjoitettaisiin suoraan HTML:ään. Uuden tekstin lisääminen tarkoittaa sen lisäämistä sekä `_data/fi/strings.yml`- että `_data/en/strings.yml`-tiedostoon.

Lokalisoidut URL-polut toivat mukanaan mielenkiintoisen ongelman. Polyglot normaalisti yhdistää käännökset vertaamalla niiden permalink-polkuja, mutta suomenkielinen `/blogi/tervetuloa/` ja englanninkielinen `/blog/welcome/` eivät täsmää. Ratkaisu: `twin`-kenttä jokaisen sisältötiedoston front matterissa, joka osoittaa toisen kieliversion URL-osoitteeseen. Kielivalitsin lukee tämän kentän rakentaakseen oikean linkin toiselle kielelle.

Toinen hyvä tietää polyglotista: se käsittelee kaiken renderöidyn HTML:n jälkikäteen ja kirjoittaa suhteelliset URL-osoitteet uudelleen lisäämällä kieliprefixin ei-oletuskielille. Tämä rikkoo kielivalitsimen, koska suomenkielinen URL saa `/en/`-etuliitteen. Korjaus on polyglotin oma `{% raw %}{% static_href %}{% endraw %}`-tagi, joka käskee jättää tietyn linkin rauhaan.

Kielivalitsin navigaatiossa näyttää "In English" suomenkielisellä sivulla ja "Suomeksi" englanninkielisellä. Yksi linkki, yksi klikkaus. Ei pudotusvalikkoa, ei lippuja.

Koska polyglot ei ole GitHub Pagesin oletuslisäosa, sivusto käyttää räätälöityä GitHub Actions -työnkulkua julkaisuun tavanomaisen Pages-rakennuksen sijaan.

## Sisältörakenne

Sivustolla on tällä hetkellä kaksi sisältötyyppiä: blogikirjoitukset ja projektisivut. Blogikirjoitukset ovat Markdown-tiedostoja `_posts/`-kansiossa. Projektisivut (kuten tämä) ovat `_projects/`-kansiossa. Jokaisella kokoelmalla on oma layout-templaattinsa. Jokainen sisältötiedosto on olemassa sekä suomeksi että englanniksi, kieliversio ilmaistaan front matterin `lang`-kentällä.

Lisää sisältötyyppejä voi lisätä myöhemmin. Jekyllin kokoelmajärjestelmä tekee siitä suoraviivaista, kun aika on oikea.

## Suunnittelupäätökset

Suunnittelu on tarkoituksella minimalistinen. En halunnut vahvaa visuaalista suuntaa, joka rajaisi sivuston yhteen tyyliin. Ajatus on, että tämä toimii alustana: jokin, joka voi pitää sisällään mitä tahansa sisältöä tai projektia, jonka haluan tehdä seuraavaksi, ilman että suunnittelu on tiellä. Siksi se nojaa vahvasti puhtaaseen typografiaan, avoimeen tilaan eikä juuri muuhun.

Sivusto käyttää lämmintä, toimituksellista palettia: maanläheisiä ruskeita, kermaisia taustoja ja järjestelmän sans-serif-kirjasinpinoa. Ei ladattavia web-fontteja. Design-tokenit elävät CSS-muuttujissa, ja master-tyylitiedosto (`main.css`) on auktoritatiivinen lähde todellisille arvoille.

Navigaation logo on "esaHakulinen" camelCasessa, samalla fontilla kuin muu sivusto. Favicon seuraa samaa ideaa: "eH"-monogrammi tummalla taustalla, generoitu SVG:nä (moderneille selaimille), ICO:na (vanhoille) ja PNG:nä (iOS ja Android).

Portfoliosivusto, jota on helppo päivittää, tulee päivitetyksi. Sellainen, jota on monimutkaista ylläpitää, ei tule. Joten koko juttu on rakennettu pysymään omalta tieltään.

## Seuraavaksi

Lisää projekteja ja blogikirjoituksia sitä mukaa kuin niitä syntyy. Sivusto itsessään kehittyy käytön myötä.
