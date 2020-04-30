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
- 
  

