# BDD-harjoitus Robot Frameworkilla

Tässä harjoituksessa harjoittelet end-to-end (E2E) -testien kirjoittamista käyttäen [**Robot Frameworkia**](https://robotframework.org/) ja [**Browser-kirjastoa**](https://robotframework-browser.org/). Tavoitteena on automatisoida keskeisiä käyttäjäpolkuja [SauceDemo](https://www.saucedemo.com/)-verkkosivustolla, joka on yleisesti käytetty testiympäristö web-automaatiolle.

Testit on tässä harjoituksessa tarkoitus kirjoittaa noudattaen **behavior-driven development (BDD)** -periaatteita:

> *"Behavior-driven development (BDD) involves naming software tests using domain language to describe the behavior of the code."*
>
> https://en.wikipedia.org/wiki/Behavior-driven_development


## Asennukset

Robot Framework perustuu Pythoniin ja sen käyttäminen edellyttää Pythonin sekä pip-paketinhallintajärjestelmän asennusta. Lisäksi tarvitset  **Browser**-kirjaston, joka mahdollistaa web-selainten hyödyntämisen testeissä Robot Frameworkilla. Browser-kirjasto käyttää taustalla Playwright-työkalua, joka puolestaan on toteutettu Node.js:llä, joten tarvitset myös Node.js:n asennettuna.


### 1. Asenna Robot Framework

Robot Frameworkin kotisivulta löytyy [pika-asennusohje](https://robotframework.org/?tab=1#getting-started), jonka avulla saat sen asennettua itsellesi. Laajempi, [erillinen asennusohje](https://github.com/robotframework/robotframework/blob/master/INSTALL.rst), esittelee tarkemmin eri vaihtoehtoja.

Pikaohjeen mukaan asennat Robot Frameworkin pipillä:

```sh
# Install Robot Framework with pip:
pip install robotframework

# Verify the installation:
robot --version
```


### 2. Asenna tarvittavat paketit

Tutustu [Robot Frameworkin Browser -kirjaston ohjeisiin](https://robotframework-browser.org/#installation) ja asenna se. Pika-asennusohjeen mukaan asennus onnistuu seuraavasti:

```sh
# Install Browser library from PyPi with pip:
pip install robotframework-browser

# Initialize the Browser library (installs all browsers):
rfbrowser init
```

Jos haluat käyttää vain tiettyä selainta, voit valita sen asentamalla vain sen:

```sh
# Only install Chromium:
rfbrowser init chromium
```

Kurssin lopuksi, kun et enää tarvitse selaimia, voit vapauttaa tilaa ja poistaa testiselaimet komennolla:

``` sh
# Clean old browser binaries and node dependencies:
rfbrowser clean-node
```

### 3. VS Code -laajennoksen asennus

[Robot Frameworkin ohjeissa](https://docs.robotframework.org/docs/getting_started/ide) suositellaan VS Codea sekä [Robot Code](https://marketplace.visualstudio.com/items?itemName=d-biehl.robotcode) -nimistä laajennosta testien kirjoittamiseksi ja suorittamiseksi VS Codessa. Suosittelemme perehtymään laajennokseen ja oman harkinnan mukaan asentamaan sen.


## Testien suorittaminen

Kun olet saanut Robot Frameworkin ja robotframework-browser-kirjaston asennettua, voit kokeilla suorittaa ensimmäisiä testejä. Tässä repositoriossa on valmiiksi määritelty testitiedosto [`tests/example.robot`](./tests/example.robot), joka sisältää yksinkertaisen testin. Suorita kyseinen testitiedosto komennolla:

```sh
robot tests/example.robot
```

Testin pitäisi mennä läpi onnistuneesti ja tulostaa testitulokset konsoliin. Lisäksi Robot Framework luo HTML-raportin, jonka voit avata selaimella.


## Behavior Driven Development (BDD)

BDD-syntaksista kerrotaan Robot Frameworkin dokumentaatiossa kappaleessa [BDD (Behavior Driven Development)](https://docs.robotframework.org/docs/testcase_styles/bdd).

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

Varsinaiset tekniset toimenpiteet, kuten sivuston elementtien tunnistaminen ja klikkaaminen, kirjoitetaan testitapauksen taustalle erillisiksi avainsanoiksi (keyword), joissa hyödynnetään Robot Frameworkin kirjastoja, kuten [Browser-kirjastoa](https://robotframework-browser.org/):

```robot
*** Keywords ***

The user is on the login page
    New Page     https://www.saucedemo.com/

The user enters valid credentials
    Type Text    id=user-name         standard_user
    Type Text    id=password          secret_sauce

The user clicks the login button
    Click        text=Login

The user should be redirected to the products page
    Get Url      should end with      inventory.html
```

Yllä esiintyvät *"The user..."*-alkuiset avainsanat ovat oman testitapauksen vaiheita vastaavat avainsanat. Voit ajatella niitä ikään kuin funktioina, joiden sisällä on yksi tai useampi Robot Frameworkin kirjaston avainsana. Robot Frameworkin syntaksissa avainsanat erotetaan testeistä kolmen tähden rivillä `*** Keywords ***`. Kunkin avainsanan operaatiot kirjoitetaan omille riveilleen ja ne suoritetaan testitapauksen vaiheiden mukaisessa järjestyksessä. Robot Framework perustuu Pythoniin ja noudattaa Pythonin tavoin sisennyksiä koodilohkojen erottamiseksi. Yksittäiset operaatiot koostuvat eri osista, kuten avainsanasta ja sen argumenteista, jotka erotetaan toisistaan käyttämällä useita välilyöntejä.

Yllä olevassa esimerkissä avainsanat `New Page`, `Type Text`, `Click` ja `Get Url` ovat [Browser-kirjaston avainsanoja](https://marketsquare.github.io/robotframework-browser/Browser.html), joiden avulla voidaan ohjata web-selainta ja tarkastaa sivuston tilaa. Kaikki Browser-kirjaston avainsanat on dokumentoitu sen omilla sivuilla: https://marketsquare.github.io/robotframework-browser/Browser.html.

Edellä oleva esimerkki löytyy tehtäväreposta tiedostosta [`tests/bdd_example.robot`](./tests/bdd_example.robot). Voit kokeilla suorittaa kyseisen testitiedoston komennolla:

```sh
robot tests/bdd_example.robot
```


## Omat testit

[SauceDemo](https://www.saucedemo.com/) on testauskäyttöön tarkoitettu verkkokauppa, jossa käyttäjät voivat kirjautua sisään, selata tuotteita, lisätä niitä ostoskoriin ja suorittaa ostotapahtuman. Sivusto sisältää erilaisia testattavia skenaarioita, kuten erilaisia käyttäjärooleja, kuten lukittu käyttäjätili, sekä tuotteiden lajittelutoimintoja.

Tavoitteena on automatisoida keskeisiä käyttäjäpolkuja SauceDemo-verkkosivustolla. Valitse testattavat skenaariot alla olevasta listasta ja kirjoita niihin testit Robot Frameworkilla. Voit myös keksiä lisäksi omia skenaarioita, jos haluat.

Jaa testisi eri tiedostoihin parhaaksi katsoamallasi tavalla hyödyntäen [Robot Frameworkin Project Structure -ohjetta](https://docs.robotframework.org/docs/examples/project_structure). Voit myös määritellä yhteisiä avainsanoja, jotka voivat olla käytössä useissa testitapauksissa. Tällaiset avainsanat voidaan määritellä omassa tiedostossaan ja tuoda muihin testitiedostoihin `Resource`-avainsanalla.


### Kirjautuminen

**Scenario: Successful login with a valid user**

**As a** registered user, **I want to** log in with valid credentials, **So that** I can access the products page and shop.

> **Given** the user is on the login page<br />
> **When** the user enters valid credentials<br />
> **And** the user clicks the login button<br />
> **Then** the user should be redirected to the products page

**Scenario: Login with an invalid user**

**As a** user who enters incorrect credentials, **I want to** see an error message, **So that** I understand that my login attempt failed.

> **Given** the user is on the login page<br />
> **When** the user enters an invalid username or password<br />
> **And** the user clicks the login button<br />
> **Then** an error message should be displayed

**Scenario: Login with a locked-out user**

**As a** locked-out user, **I want to** be informed that my account is locked, **So that** I know I cannot proceed and need assistance.

> **Given** the user is on the login page<br />
> **When** the user enters credentials for a locked-out user<br />
> **And** the user clicks the login button<br />
> **Then** an error message should indicate that the user is locked out


### Tuotteiden selaaminen ja lajittelu

**Scenario: Product list is displayed after login**

**As a** logged-in user, **I want to** see a list of available products, **So that** I can browse and choose what to buy.

> **Given** the user is logged in
> **When** the user navigates to the products page
> **Then** a list of products should be visible

**Scenario: Sorting products by price (low to high)**

**As a** user on the products page, **I want to** sort items by price (low to high), **So that** I can easily find the most affordable products first.

> **Given** the user is on the products page
> **When** the user selects "Price (low to high)" from the sorting dropdown
> **Then** the products should be listed in ascending order of price


### Ostoskori

**Scenario: Adding an item to the cart**

**As a** user browsing products, **I want to** add a product to my cart, **So that** I can purchase it later.

**As a** user who has added products to the cart, **I want to** see the correct number of items displayed in the cart **So that** I can verify my selections before proceeding to checkout.

> **Given** the user is on the products page<br />
> **When** the user adds a product to the cart<br />
> **Then** the cart icon should show the correct item count

**Scenario: Removing an item from the cart**

**As a** user with an item in my cart, **I want to** remove an item from the cart, **So that** I can adjust my order before checkout.

> **Given** the user has an item in the cart
> **When** the user removes the item from the cart
> **Then** the cart should be empty

**Scenario: Proceeding to checkout**

**As a** user with items in my cart, **I want to** proceed to checkout, **So that** I can complete my purchase.

> **Given** the user has items in the cart<br />
> **When** the user clicks the checkout button<br />
> **Then** the checkout page should be displayed


### Maksuprosessi

**Scenario: Completing a purchase**

**As a** customer at checkout, **I want to** enter my payment and shipping details, **So that** I can finalize my order and receive my products.

> **Given** the user is on the checkout page
> **When** the user enters valid checkout information
> **And** the user completes the purchase
> **Then** a confirmation message should be displayed


## Tehtävän automaattinen arviointi

Kun olet kirjoittanut testitapaukset ja varmistanut, että ne toimivat odotetusti, voit palauttaa tehtävän tarkastusta varten. Lisää luomasi testitiedostot versionhallintaan ja lähetä muutokset GitHubiin `git status`, `git add`, `git commit` ja `git push` -komennoilla.


## Materiaalista

Tämän tehtävän on kehittänyt Teemu Havulinna ja se on lisensoitu [Creative Commons BY-NC-SA -lisenssillä](https://creativecommons.org/licenses/by-nc-sa/4.0/).

Tehtävän luonnissa on hyödynnetty kielimalleja ja tekoälytyökaluja, kuten GitHub Copilot ja ChatGPT.