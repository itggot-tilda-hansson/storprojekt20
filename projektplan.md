# Projektplan

## 1. Projektbeskrivning (Beskriv vad sidan ska kunna göra)
På sidan ska du kunna logga in med ditt egna kont för att ha tillgång till melodifestival artister. Du kan både se en lista med 2020 års artister men också alla de vinnande artister från 2001-2020, men också söka på en av alla artister som finns. Detta kan du göra om du båda är inloggad eller inte. Om du därmed loggar in på sidan får du tillgång till att du ska kunna göra en egen lista med dina favorit artister som du både kan gå in och ändra på eller ta bort.

## 2. Vyer (visa bildskisser på dina sidor)
Kommer som bilder i denna mapp
## 3. Databas med ER-diagram (Bild)
Finns bild i misc
## 4. Arkitektur (Beskriv filer och mappar - vad gör/inehåller de?)
### db
Här ligger databasen mello.db och det är genom denna som artisterna hämtas.
### misc
Här ligger ER-diagramet (ER.png) som är ett diagram över databasen och kopplingen inom den, ett schema som beskriver vilka data som kan lagras.
### public
Här ligger det som är public för alla att se och data som man kan ta del av och i denna mapp ligger en egen mapp
  ### css
  I denna mapp ligger main.css som är css:en som finns på sidan.
### .yardoc och doc
Dessa mappar har med yardoc att göra. Skapar API automatiskt, en webbsida som visar applikationens routes och funktioner. 
### views 
Här ligger alla slim filer.


  ### album.slim
  Resultatet från när du har sökt på en artist id, de id:t du har sökt på kommer nu upp som ett namp på en artist.
  
  ### all_win.slim 
Om du trycker på alla vinnare knappen så kommer alla vinnare upp på sidan, detta genom en lopp och om winner kolumnen i databasen inte är null kommer artisten upp som vinnare. 
  
  ### all.slim
  Alla artister som finns i databasen kommer upp.
  
  ### artister.slim
  Sidan med alla artister, du kan här antingen se alla, alla vinnare eller söka på en artist. 
  
  ### artists.slim
  Om du söker på en artist 'artists/:id'
  
  ### error.slim
  Om något skulle gå fel, tex fel lösenord så kommer du till denna error sida och en länk tillbaka till "/" sidan
  
  ### favorite_artist.slim
  Här väljer du dina favorit artister genom att trycka i checkbox på de artister du vill välja
  
  ### layout.slim
  Layout sidan helt enkelt, finns på varje delsida men länkar till startsidan och till sidan med alla artister.
  
  ### register_confirmation.slim
  Om du lyckas logga in kommer man till denna sidan så att man vet att man är inloggad och kan därmed gå vidare till att välja sina       favorit artister.
  
  ### start.slim
  Start sidan där du kan registrera dig eller logga in, om du inte vill logga in är det här du kan gå till att se alla artister. 
  
  ### your_favorite_artist.slim 
  Här ser du de artister du har valt som dina favorit artister, du kan också ta bort eller välja nya om du skulle vilja det.


### app.rb
Ligger inte i någon mapp men är min controller där alla routes finns med både sessions och felhantering.
### model.rb
Ligger inte heller i någon mapp men denna fil innehåller SQL kod med både validering med passwordcheck och BCrypt.
### Gemfile
Har med yardoc att göra. 
  

