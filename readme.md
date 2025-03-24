# Testiautomaation harjoitus: End-to-End-testaus Robot Frameworkilla ja SauceDemolla

Tässä harjoituksessa harjoittelet end-to-end (E2E) -testien kirjoittamista käyttäen [**Robot Frameworkia**](https://robotframework.org/) ja [**Browser-kirjastoa**](https://robotframework-browser.org/). Tavoitteena on automatisoida keskeisiä käyttäjäpolkuja [SauceDemo](https://www.saucedemo.com/)-verkkosivustolla, joka on yleisesti käytetty testiympäristö web-automaatiolle.

Testit kirjoitetaan **Gherkin-tyylisiksi** testitapauksiksi, jotka noudattavat **ATDD (Acceptance Test-Driven Development)** -periaatteita. Testit kattavat kirjautumisen, tuotteiden selaamisen, ostoskorin hallinnan ja maksuprosessin. Kuvauksia ATDD:stä, sen sisällöstä sekä tavoitteista löydät esimerkiksi BrowserStackin [ATDD-artikkelista](https://www.browserstack.com/guide/what-is-atdd).


## Tavoitteet

Tämän harjoituksen aikana:

- Määrität **Robot Framework** -projektin web-automaatiota varten.
- Asennat tarvittavat kirjastot ja selaimet.
- Kirjoitat **Gherkin-tyylisiä ATDD-testejä** SauceDemon keskeisille toiminnoille.
- Suoritat testit ja validoit odotetut käyttäytymiset.


## Asennus

Robot Framework perustuu Pythoniin ja sen käyttäminen edellyttää Pythonin sekä pip-paketinhallintajärjestelmän asennusta. Lisäksi tulet tarvitsemaan **Browser**-kirjaston, joka mahdollistaa web-selainten hyödyntämisen testeissä Robot Frameworkilla. Browser-kirjasto käyttää Playwright-työkalua, joka puolestaan on toteutettu Node.js:llä, joten tarvitset myös Node.js:n asennettuna.


### 1. Asenna Robot Framework  ja luo uusi projekti

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

## Testien kirjoittaminen

SauceDemo on yksinkertainen verkkokauppa, jossa käyttäjät voivat kirjautua sisään, selata tuotteita, lisätä niitä ostoskoriin ja suorittaa ostotapahtuman. Sivusto sisältää erilaisia testattavia skenaarioita, kuten erilaisia käyttäjärooleja (esim. lukittu käyttäjä) ja lajittelutoimintoja. Tämä tekee siitä erinomaisen alustan testiautomaation opiskeluun.

Seuraavaksi kirjoitat **Gherkin-tyylisiä** testitapauksia, joilla automatisoidaan seuraavat toiminnot SauceDemossa:

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


Jokaisen testin tulee noudattaa **ATDD-lähestymistapaa**, käyttäen **Given-When-Then**-rakennetta kuvaamaan käyttäjän toimet ja odotetut lopputulokset.

## Testien suorittaminen

Kun testit on kirjoitettu, voit suorittaa ne komennolla:

```sh
robot tests/
```

Testitulokset ovat saatavilla HTML-raporttina.

## Yhteenveto

Harjoituksen lopussa olet automatisoinut koko ostosprosessin SauceDemossa käyttäen **Robot Frameworkia** ja **Browser-kirjastoa**. Tämä vahvistaa taitojasi testiautomaation, selektorien käsittelyn, dynaamisten elementtien hallinnan ja **ATDD-periaatteiden** soveltamisen osalta.


## Materiaalista

Tämän tehtävän on kehittänyt Teemu Havulinna ja se on lisensoitu [Creative Commons BY-NC-SA -lisenssillä](https://creativecommons.org/licenses/by-nc-sa/4.0/).

Tehtävän luonnissa on hyödynnetty kielimalleja ja tekoälytyökaluja, kuten GitHub Copilot ja ChatGPT.