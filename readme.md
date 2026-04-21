[English version of this readme is available in the file readme.en.md](./readme.en.md)

# BDD-harjoitus Robot Frameworkilla

Tässä harjoituksessa harjoittelet end-to-end (E2E) -testien kirjoittamista käyttäen [**Robot Frameworkia**](https://robotframework.org/) ja [**Browser-kirjastoa**](https://robotframework-browser.org/). Tavoitteena on automatisoida keskeisiä käyttäjäpolkuja [SauceDemo](https://www.saucedemo.com/)-verkkosivustolla, joka on yleisesti käytetty harjoitteluympäristö web-automaatiolle.

Suosittelemme alkuun pääsemiseksi katsomaan [Robot Framework tutorial (youtube.com)](https://www.youtube.com/playlist?list=PLSK6YK5OGX1AuQy0tbvdKBV9mrKi46kKH) -soittolistan videot.

Testit on tässä harjoituksessa tarkoitus kirjoittaa noudattaen **behavior-driven development (BDD)** -periaatteita:

> *"Behavior-driven development (BDD) involves naming software tests using domain language to describe the behavior of the code."*
>
> https://en.wikipedia.org/wiki/Behavior-driven_development

BDD:ssä testitapaukset kirjoitetaan luonnollisella kielellä ja ne kuvaavat ohjelman toimintaa käyttäjän näkökulmasta. Robot Framework tukee BDD-testausta ja sen avulla testitapaukset voidaan kirjoittaa käyttäen luonnollista kieltä, hyödyntäen **Given-When-Then** -rakennetta:

> *Given* the user is on the login page<br />
> *When* the user enters valid credentials *and* clicks the login button<br />
> *Then* the user should be redirected to the products page


## Asennukset

Robot Framework on Python-pohjainen testiautomaatiokehys, joten sen käyttäminen edellyttää Pythonin ja pip-paketinhallintajärjestelmän asennusta. Robot Frameworkin lisäksi tarvitset Browser-kirjaston, joka mahdollistaa web-selainten ohjaamisen testeissäsi. Browser-kirjasto käyttää taustalla Playwright-työkalua, joka on toteutettu Node.js:llä, joten tarvitset myös Node.js:n asennettuna.

Tarkemmat asennusohjeet sekä tietoa valmiista devcontainers-ratkaisusta löytyvät [erillisestä installations.md](./installations.md)-tiedostosta.


## Testien suorittaminen

Kun olet saanut Robot Frameworkin ja Browser-kirjaston asennettua, voit kokeilla suorittaa ensimmäisiä testejä. Tässä repositoriossa on valmiiksi määritelty testitiedosto [`tests/example.robot`](./tests/example.robot), joka sisältää yksinkertaisen testin. Voit suorittaa kyseisen testitiedoston komennolla:

```sh
robot --outputdir=test-results/ tests/example.robot
```

Testin pitäisi mennä läpi onnistuneesti ja tulostaa testitulokset konsoliin. Lisäksi Robot Framework luo HTML-raportin, jonka voit avata selaimella. 

Raportin tarkasteleminen on erityisen hyödyllistä, mikäli testit epäonnistuvat, sillä raportti sisältää yksityiskohtaisia tietoja testitapauksista ja testien epäonnistuessa myös kuvankaappauksia.


## Behavior Driven Development (BDD)

Behavior Driven Development (BDD) on ohjelmistokehityksen menetelmä, joka korostaa ohjelmiston käyttäytymisen kuvaamista ja testaamista. BDD:ssä testitapaukset kirjoitetaan luonnollisella kielellä ja ne kuvaavat ohjelman toimintaa käyttäjän näkökulmasta. Robot Framework tukee BDD-testausta ja sen avulla testitapaukset voidaan kirjoittaa käyttäen luonnollista kieltä.

BDD-testit kirjoitetaan käyttäen **Given-When-Then** -rakennetta, joka kuvaa testattavan skenaarion tilanteen, toiminnan ja odotetun lopputuloksen. Esimerkiksi seuraava testi kuvaa käyttäjän kirjautumista verkkosivustolle:

```robot
*** Test Cases ***

Successful login with a valid user
    Given the user is on the login page
    When the user enters valid credentials
    And the user clicks the login button
    Then the user should be redirected to the products page
```

Yllä oleva testitapaus kuvaa ohjelman toimintaa "luonnollisella kielellä" eikä sisällä teknisiä yksityiskohtia, kuten sivuston elementtien nimiä tai CSS-sääntöjä. Tämän on tarkoitus tehdä testitapauksista helpommin luettavia ja ymmärrettäviä.

Varsinaiset tekniset toimenpiteet, kuten sivuston elementtien tunnistaminen ja klikkaaminen, kirjoitetaan testitapauksen taustalle erillisiksi *avainsanoiksi* (keyword). Omissa avainsanoissa puolestaan hyödynnetään Robot Frameworkin kirjastoja, kuten [Browser-kirjastoa](https://robotframework-browser.org/).

Seuraavassa esimerkissä on määritetty edellä olevan testitapauksen avainsanat, josta näkyy, miten testitapauksen eri vaiheet toteutetaan teknisesti. Avainsanan sisällä hyödynnetään Browser-kirjaston avainsanoja, kuten `New Page`, `Fill Text`, `Click` ja `Get Url`:

```robot
*** Settings ***
# Importing the Browser library adds the New Page, Click, Fill Text, and Get Url keywords:
Library          Browser

*** Keywords ***

The user is on the login page
    New Page     https://www.saucedemo.com/

The user enters valid credentials
    Fill Text    id=user-name         standard_user
    Fill Text    id=password          secret_sauce

The user clicks the login button
    Click        text=Login

The user should be redirected to the products page
    Get Url      should end with      inventory.html
```

Yllä esiintyvät *"The user..."*-alkuiset avainsanat ovat siis ylempänä esitetyn *Given-When-Then* -testitapauksen vaiheita vastaavat avainsanat. Robot Frameworkin avainsanat ovat uudelleenkäytettäviä koodilohkoja, joita voidaan kutsua testitapauksissa.

Voit omia avainsanoja ikään kuin funktioina, joiden sisällä on yksi tai useampi Robot Frameworkin kirjaston avainsana. Robot Frameworkin syntaksissa avainsanat erotetaan testeistä kolmen tähden rivillä `*** Keywords ***`. Kunkin avainsanan operaatiot kirjoitetaan omille riveilleen ja ne suoritetaan testitapauksen vaiheiden mukaisessa järjestyksessä.

Avainsanoissa kirjainkoolla ei ole merkitystä ja niiden alkuun voidaan lisätä myös tiettyjä ylimääräisiä sanoja, kuten `given`, `when`, `then` ja `and`. Esimerkiksi yllä olevassa testissä rivi `Given the user is on the login page` viittaa alempana määritettyyn avainsanaan `The user is on the login page`.

Robot Framework noudattaa Pythonin tavoin sisennyksiä koodilohkojen erottamiseksi. Yksittäiset operaatiot koostuvat eri osista, kuten avainsanasta ja sen argumenteista, jotka erotetaan toisistaan käyttämällä useita välilyöntejä. Esimerkiksi rivi `Fill Text  id=user-name  standard_user` koostuu kolmesta osasta: avainsanasta (`Fill Text`), selektorista (`id=user-name`) ja tekstistä (`standard_user`). Nämä täytyy erottaa toisistaan *kahdella tai useammalla välilyönnillä*, jotta Robot Framework ymmärtää, että kyseessä on kolme erillistä osaa.

Yllä olevassa esimerkissä avainsanat `New Page`, `Fill Text`, `Click` ja `Get Url` ovat siis [Browser-kirjaston avainsanoja](https://marketsquare.github.io/robotframework-browser/Browser.html), joiden avulla voidaan ohjata web-selainta ja tarkastaa sivuston tilaa. Kaikki Browser-kirjaston avainsanat on dokumentoitu sen omilla sivuilla: https://marketsquare.github.io/robotframework-browser/Browser.html.

Yllä oleva BDD-esimerkki löytyy kokonaisuudessaan tiedostosta [`tests/bdd_example.robot`](./tests/bdd_example.robot). Voit kokeilla suorittaa kyseisen testitiedoston komennolla:

```sh
robot --outputdir=test-results/ tests/bdd_example.robot
```

BDD-syntaksista kerrotaan Robot Frameworkin dokumentaatiossa kappaleessa [BDD (Behavior Driven Development)](https://docs.robotframework.org/docs/testcase_styles/bdd).


## Omat testit

**SauceDemo** (https://www.saucedemo.com/) on testauskäyttöön tarkoitettu verkkokauppa, jossa käyttäjät voivat kirjautua sisään, selata tuotteita, lisätä niitä ostoskoriin ja suorittaa ostotapahtuman.

Tässä harjoituksessa tavoitteena on automatisoida keskeisiä käyttäjäpolkuja [SauceDemo-verkkosivustolla](https://www.saucedemo.com/). Testattavat skenaariot löytyvät alla olevasta listasta. Voit myös halutessasi luoda lisäksi omia skenaarioita.

Jaa testisi eri tiedostoihin [tests](./tests/)-hakemiston alle parhaaksi katsoamallasi tavalla hyödyntäen [Robot Frameworkin Project Structure -ohjetta](https://docs.robotframework.org/docs/examples/project_structure). Voit myös määritellä yhteisiä avainsanoja, jotka voivat olla käytössä useissa testitapauksissa. 

Tällaiset uudelleenkäytettävät avainsanat voidaan määritellä omassa tiedostossaan ja tuoda muihin testitiedostoihin [`Resource`-avainsanalla](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html#resource-and-variable-files). Alkuun kuitenkin riittää, että saat testitapauksia kirjoitettua ja tyyli on toissijainen asia.


### Tracing

**Automaattisen arvioinnin** vuoksi testitapausten tulee tallentaa selaimen tapahtumat ns. "trace"-tiedostoon, jonka avulla tehtävän automaattinen arviointi varmistaa, että vaaditut tapaukset on käyty läpi.

Jotta trace-tiedostot tallentuvat oikein, jokaisen testitapauksen alussa tulee olla komento `New Context    tracing=True`. Komento avaa uuden "kontekstin", joiden avulla eri testit ovat toisistaan eristyksissä ja joiden avulla testejä voidaan suorittaa samassa selaimessa rinnakkain niiden häiritsemättä toisiaan. Voit lukea aiheesta lisää [Browser-kirjaston dokumentaatiosta](https://marketsquare.github.io/robotframework-browser/Browser.html#Browser%2C%20Context%20and%20Page).

Helpoiten saat uuden kontekstin luotua jokaisen testin alussa ja suljettua jokaisen testin lopussa lisäämällä seuraavat rivit jokaisen robot-tiedoston alkuun `*** Settings ***`-lohkoon:

```robot
# The following lines are required for automatic assessment of the exercise:
Test Setup          New Context    tracing=True
Test Teardown       Close Context
```

Trace-tiedostot tallentuvat projektiisi zip-tiedostoina, joita voit tarkastella [Playwrightin Trace viewer -työkalulla](https://playwright.dev/docs/trace-viewer). Työkalua voidaan käyttää paikallisesti asennettuna tai vaihtoehtoisesti osoitteessa https://trace.playwright.dev/. Katso tästä Playwrightin oma esimerkki [trace-tiedostosta](https://trace.playwright.dev/?trace=https://demo.playwright.dev/reports/todomvc/data/fa874b0d59cdedec675521c21124e93161d66533.zip) sekä [esimerkkiin liittyvä video](https://youtu.be/yP6AnTxC34s).


## Testattavat skenaariot

Testitapauksissa tarvitaan käyttäjätunnuksia, jotka löydät https://www.saucedemo.com/ -sivuston etusivulta. Huomaa, että tarvitset eri testeissä eri tunnuksia riippuen siitä, mitä ominaisuutta olet testaamassa (esim. lukittu tunnus).

Tuotteiden listauksen ja ostamiseen liittyvissä testeissä ei tule käyttää bugisia tai lukittuja tunnuksia, vaan `standard_user`-tunnus sopii niihin hyvin.


### Kirjautuminen

**Scenario: Successful login with a valid user**

**As a** registered user, **I want to** log in with valid credentials, **So that** I can access the products page and shop.

```robot
Successful login with a valid user
    Given the user is on the login page
    When the user enters valid credentials
    And the user clicks the login button
    Then the user should be redirected to the products page
```

**Scenario: Login with an invalid user**

**As a** user who enters incorrect credentials, **I want to** see an error message, **So that** I understand that my login attempt failed.

```robot
Login with an invalid user
    Given the user is on the login page
    When the user enters an invalid username or password
    And the user clicks the login button
    Then an error message should be displayed
```

**Scenario: Login with a locked-out user**

**As a** locked-out user, **I want to** be informed that my account is locked, **So that** I know I cannot proceed and need assistance.

```robot
Login with a locked-out user
    Given the user is on the login page
    When the user enters credentials for a locked-out user
    And the user clicks the login button
    Then an error message should indicate that the user is locked out
```


### Tuotteiden selaaminen ja lajittelu

**Scenario: Product list is displayed after login**

**As a** logged-in user, **I want to** see a list of available products, **So that** I can browse and choose what to buy.

```robot
Product list is displayed after login
    Given the user is logged in
    When the user navigates to the products page
    Then a list of products should be visible
```

**Scenario: Sorting products by price**

**As a** user on the products page, **I want to** sort items by price (low to high), **So that** I can easily find the most affordable products first.

```robot
Sorting products by price
    Given the user is on the products page
    When the user selects "price low to high" from the sorting dropdown
    Then the products should be listed in ascending order of price
```

💡 **Huom:** Voit olettaa, että tuotteet ja niiden hinnat eivät muutu. Sinun ei tarvitse vertailla hintoja testikoodissasi. Riittää että varmistat, että tietyt tuotteet ovat odotetuissa paikoissa lajittelun jälkeen.


### Ostoskori

**Scenario: Adding an item to the cart**

**As a** user browsing products, **I want to** add a product to my cart, **So that** I can purchase it later.

```robot
Adding an item to the cart
    Given the user is on the products page
    When the user adds a product to the cart
    Then the product should be added to the cart
```

**Scenario: Seeing the correct number of items in the cart**

**As a** user who has added products to the cart, **I want to** see the correct number of items displayed in the cart **So that** I can verify my selections before proceeding to checkout.

```robot
Seeing the correct number of items in the cart
    Given the user is on the products page
    When the user adds multiple products to the cart
    Then the cart icon should show the correct item count
```

**Scenario: Removing an item from the cart**

**As a** user with an item in my cart, **I want to** remove an item from the cart, **So that** I can adjust my order before checkout.

```robot
Removing an item from the cart
    Given the user has an item in the cart
    When the user removes the item from the cart
    Then the cart should be empty
```

**Scenario: Proceeding to checkout**

**As a** user with items in my cart, **I want to** proceed to checkout, **So that** I can complete my purchase.

```robot
Proceeding to checkout
    Given the user has items in the cart
    When the user clicks the checkout button
    Then the checkout page should be displayed
```


### Maksuprosessi

**Scenario: Completing a purchase**

**As a** customer at checkout, **I want to** enter my payment and shipping details, **So that** I can finalize my order and receive my products.

```robot
Completing a purchase
    Given the user is on the checkout page
    When the user enters valid checkout information
    And the user completes the purchase
    Then a confirmation message should be displayed
```


## Tehtävän palauttaminen

Kun olet kirjoittanut testitapaukset ja varmistanut, että ne toimivat odotetusti, voit palauttaa tehtävän automaattista arviointia varten. Lisää luomasi testitiedostot versionhallintaan ja lähetä muutokset GitHubiin `git status`, `git add`, `git commit` ja `git push` -komennoilla.

Arvioinnin tulos löytyy hetken kuluttua actions-välilehdeltä. Mikäli et saa oikeaa määrää pisteitä automaattisesta arvioinnista, varmista, että olet huomioinut ylempänä ohjeistetun "trace"-tiedostojen luomisen.


## Lisenssit

[Sauce Labs Sample Application](https://www.saucedemo.com/) on julkaistu [MIT-lisenssillä](https://github.com/saucelabs/sample-app-web/blob/main/LICENSE).

Robot Framework on lisensoitu [Apache 2.0 -lisenssillä](https://github.com/robotframework/robotframework/blob/master/LICENSE.txt).

Browser-kirjasto on lisensoitu [Apache 2.0 -lisenssillä](https://github.com/MarketSquare/robotframework-browser/blob/main/LICENSE).


## Materiaalista

Tämän tehtävän on kehittänyt Teemu Havulinna ja se on lisensoitu [Creative Commons BY-NC-SA -lisenssillä](https://creativecommons.org/licenses/by-nc-sa/4.0/).

Tehtävän luonnissa on hyödynnetty kielimalleja ja tekoälytyökaluja, kuten GitHub Copilot ja ChatGPT.
