#### VERSION PLUS MINIMALISTE ####
# on veut réaliser une carte par pays avec moins de précision en zoomant bien. 
# on va également ajouter un code couleur pour les différents groupes d'échantillons : non inclus en mgf, inclus mais neg, inclus et pos

library(leaflet)
library(leaflet.extras)
library(sf)
library(rnaturalearth)
library(webshot)

# Créer une icône personnalisée
icone_personnalisee <- makeIcon(
  iconUrl = "C:/Users/remi.gschwind/Downloads/location-svgrepo-com.svg",
  iconWidth = 20,
  iconHeight = 20
)

# Obtenir les frontières
france <- ne_countries(country = "France", scale = "medium", returnclass = "sf")

# Définir les limites de la carte à partir des coordonnées fournies
limites <- list(
  c(48.60488445034624, 1.303077396754893), # Coin sud-ouest (latitude, longitude)
  c(49.16394189304548, 3.1865662708463023)  # Coin nord-est (latitude, longitude)
)

# Définir les coordonnées des points remarquables
points_remarquables <- data.frame(
  nom = c("FRA-1-SEINE", "FRA-2-HOSPWW"),
  longitude = c(2.1642, 2.3323),
  latitude = c(48.8842, 48.8981)
)

# Convertir les points en objet sf
points_sf <- st_as_sf(points_remarquables, coords = c("longitude", "latitude"), crs = 4326)

# Créer la carte leaflet
carte <- leaflet(france) %>%
  addScaleBar(position = "bottomleft") %>%
  addProviderTiles("Esri.OceanBasemap") %>%
  addMarkers(data = points_sf, popup = ~nom, icon = icone_personnalisee) %>%
  fitBounds(limites[[1]][2], limites[[1]][1], limites[[2]][2], limites[[2]][1]) # Zoom avec les limites fournies
carte

carte_sans_point <- leaflet(france) %>%
  addScaleBar(position = "bottomleft") %>%
  addProviderTiles("Esri.OceanBasemap") %>%
  fitBounds(limites[[1]][2], limites[[1]][1], limites[[2]][2], limites[[2]][1]) # Zoom avec les limites fournies

# Exporter la carte en PNG
mapshot(carte_sans_point, file = "C:/Users/remi.gschwind/Desktop/Metagenomique_fonctionnelle/Ecriture/data/abundance/carte_fra.png", vwidth = 2400, vheight = 1600)

####

# Obtenir les frontières
pakistan <- ne_countries(country = "Pakistan", scale = "medium", returnclass = "sf")

# Définir les limites de la carte à partir des coordonnées fournies
limites <- list(
  c(33.10061115238485, 72.03546482044013), # Coin sud-ouest (latitude, longitude)
  c(34.344298503094414, 74.2466670195959)  # Coin nord-est (latitude, longitude)
)

# Définir les coordonnées des points remarquables
points_remarquables <- data.frame(
  nom = c("PAK-1-SHAHZAD", "PAK-2-NARC", "PAK-3-QAU", "PAK-4-BANI", "PAK-5-LAKE", 
          "PAK-6-SHAHDARA", "PAK-7-JINNAH", "PAK-8-BARI", "PAK-9-CDAIN", "PAK-10-CDAOUT", 
          "PAK-11-QUAIN", "PAK-12-QUAOUT"),
  longitude = c(73.1449, 73.0809, 73.1607, 73.0910, 73.1261, 73.1261, 73.1163, 73.1163, 
                73.0748, 73.0748, 73.0749, 73.0749),
  latitude = c(33.6608, 33.4037, 33.7367, 33.4304, 33.7025, 33.7025, 33.7442, 33.7442, 
               33.3240, 33.3240, 33.4436, 33.4436),
  categorie = c("analysé par mgf et negatif", "analysé par mgf et negatif", "non analysé par mgf",
                "non analysé par mgf", "analysé par mgf et negatif", "non analysé par mgf",
                "non analysé par mgf", "non analysé par mgf", "non analysé par mgf",
                "analysé par mgf et negatif", "non analysé par mgf", "non analysé par mgf")
)

# Définir les couleurs pour chaque catégorie
couleurs <- c("analysé par mgf et positif" = "red", "analysé par mgf et negatif" = "lightcoral", "non analysé par mgf" = "lightgrey")

# Convertir les points en objet sf
points_sf <- st_as_sf(points_remarquables, coords = c("longitude", "latitude"), crs = 4326)

# Créer la carte leaflet
carte <- leaflet(pakistan) %>%
  addScaleBar(position = "bottomleft") %>%
  addProviderTiles("Esri.OceanBasemap") %>%
  addMarkers(data = points_sf, icon = icone_personnalisee) %>%
  fitBounds(limites[[1]][2], limites[[1]][1], limites[[2]][2], limites[[2]][1]) # Zoom avec les limites fournies
carte

carte_sans_point <- leaflet(pakistan) %>%
  addScaleBar(position = "bottomleft") %>%
  addProviderTiles("Esri.OceanBasemap") %>%
  fitBounds(limites[[1]][2], limites[[1]][1], limites[[2]][2], limites[[2]][1]) # Zoom avec les limites fournies
# Exporter la carte en PNG
mapshot(carte_sans_point, file = "C:/Users/remi.gschwind/Desktop/Metagenomique_fonctionnelle/Ecriture/data/abundance/carte_pak.png", vwidth = 2400, vheight = 1600)

####

# Obtenir les frontières
allemagne1 <- ne_countries(country = "Germany", scale = "medium", returnclass = "sf")

# Définir les limites de la carte à partir des coordonnées fournies
limites <- list(
  c(50.616266305083336, 6.513066678425995), # Coin sud-ouest (latitude, longitude)
  c(51.27645441447453, 8.402060317964285)  # Coin nord-est (latitude, longitude)
)

# Définir les coordonnées des points remarquables
points_remarquables <- data.frame(
  nom = c("GER-1-KREISCHAIN", "GER-2-GROSSESOIL", "GER-3-ELBEWATER", "GER-4-KLINGSOIL", 
          "GER-5-KREISCHAOUT", "GER-6-LWBWATER", "GER-7-LWBSED", "GER-8-LAKEWATER", 
          "GER-9-ELBESED", "GER-10-GROSSEWATER", "GER-11-KLINGDRINK", "GER-12-WANNDRINK", 
          "GER-13-KLINGSED", "GER-14-ELBEFISH", "GER-15-LAKESED", "GER-16-WANNWATER"),
  longitude = c(13.6387, 13.7626, 13.5724, 13.5347, 13.6387, 13.7733, 13.7733, 
                13.7733, 13.5724, 13.7626, 13.5347, 7.3445, 13.5347, 13.5724, 
                13.8233, 7.3445),
  latitude = c(50.9622, 51.0332, 51.1117, 50.9066, 50.9622, 50.9373, 50.9373, 
               50.9373, 51.1117, 51.0332, 50.9066, 50.8800, 50.9066, 51.1117, 
               51.0156, 50.8800)
)

# Convertir les points en objet sf
points_sf <- st_as_sf(points_remarquables, coords = c("longitude", "latitude"), crs = 4326)

# Créer la carte leaflet
carte <- leaflet(allemagne1) %>%
  addScaleBar(position = "bottomleft") %>%
  addProviderTiles("Esri.OceanBasemap") %>%
  addMarkers(data = points_sf, icon = icone_personnalisee) %>%
  fitBounds(limites[[1]][2], limites[[1]][1], limites[[2]][2], limites[[2]][1]) # Zoom avec les limites fournies
carte

carte_sans_point <- leaflet(allemagne1) %>%
  addScaleBar(position = "bottomleft") %>%
  addProviderTiles("Esri.OceanBasemap") %>%
  fitBounds(limites[[1]][2], limites[[1]][1], limites[[2]][2], limites[[2]][1]) # Zoom avec les limites fournies

# Exporter la carte en PNG
mapshot(carte_sans_point, file = "C:/Users/remi.gschwind/Desktop/Metagenomique_fonctionnelle/Ecriture/data/abundance/carte_ger1.png", vwidth = 2400, vheight = 1600)


allemagne2 <- ne_countries(country = "Germany", scale = "medium", returnclass = "sf")

# Définir les limites de la carte à partir des coordonnées fournies
limites <- list(
  c(50.68217746829193, 12.64809024405969), # Coin sud-ouest (latitude, longitude)
  c(51.35676844079834, 14.606855194497479)  # Coin nord-est (latitude, longitude)
)

# Définir les coordonnées des points remarquables
points_remarquables <- data.frame(
  nom = c("GER-1-KREISCHAIN", "GER-2-GROSSESOIL", "GER-3-ELBEWATER", "GER-4-KLINGSOIL", 
          "GER-5-KREISCHAOUT", "GER-6-LWBWATER", "GER-7-LWBSED", "GER-8-LAKEWATER", 
          "GER-9-ELBESED", "GER-10-GROSSEWATER", "GER-11-KLINGDRINK", "GER-12-WANNDRINK", 
          "GER-13-KLINGSED", "GER-14-ELBEFISH", "GER-15-LAKESED", "GER-16-WANNWATER"),
  longitude = c(13.6387, 13.7626, 13.5724, 13.5347, 13.6387, 13.7733, 13.7733, 
                13.7733, 13.5724, 13.7626, 13.5347, 7.3445, 13.5347, 13.5724, 
                13.8233, 7.3445),
  latitude = c(50.9622, 51.0332, 51.1117, 50.9066, 50.9622, 50.9373, 50.9373, 
               50.9373, 51.1117, 51.0332, 50.9066, 50.8800, 50.9066, 51.1117, 
               51.0156, 50.8800)
)

# Convertir les points en objet sf
points_sf <- st_as_sf(points_remarquables, coords = c("longitude", "latitude"), crs = 4326)

# Créer la carte leaflet
carte <- leaflet(allemagne2) %>%
  addScaleBar(position = "bottomleft") %>%
  addProviderTiles("Esri.OceanBasemap") %>%
  addMarkers(data = points_sf, icon = icone_personnalisee) %>%
  fitBounds(limites[[1]][2], limites[[1]][1], limites[[2]][2], limites[[2]][1]) # Zoom avec les limites fournies
carte

carte_sans_point <- leaflet(allemagne2) %>%
  addScaleBar(position = "bottomleft") %>%
  addProviderTiles("Esri.OceanBasemap") %>%
  fitBounds(limites[[1]][2], limites[[1]][1], limites[[2]][2], limites[[2]][1]) # Zoom avec les limites fournies

# Exporter la carte en PNG
mapshot(carte_sans_point, file = "C:/Users/remi.gschwind/Desktop/Metagenomique_fonctionnelle/Ecriture/data/abundance/carte_ger2.png", vwidth = 2400, vheight = 1600)


####

# Obtenir les frontières
suede <- ne_countries(country = "Sweden", scale = "medium", returnclass = "sf")

# Définir les limites de la carte à partir des coordonnées fournies
limites <- list(
  c(57.30513630300529, 11.010604255191557), # Coin sud-ouest (latitude, longitude)
  c(58.09174138869237, 13.33063336097283)  # Coin nord-est (latitude, longitude)
)

# Définir les coordonnées des points remarquables
points_remarquables <- data.frame(
  nom = c("SWE-1-JRYAIN", "SWE-2-JFINN", "SWE-3-JRYAOUT", "SWE-4-JSOIL1", "SWE-5-JGOTA", 
          "SWE-6-JGOTAMP", "SWE-7-JFOTO", "SWE-8-JFOTO2", "SWE-9-NFOTO", "SWE-10-NGOTA", 
          "SWE-11-NRYAOUTMP", "SWE-12-NRYAOUT", "SWE-13-NRYAIN", "SWE-14-NFINN", 
          "SWE-15-NSOIL1", "SWE-16-NSOIL2", "SWE-17-NSOIL3"),
  longitude = c(11.8901, 12.1492, 11.8902, 12.1529, 11.9058, 11.9059, 11.6624, 11.6625, 
                11.6626, 11.9060, 11.8903, 11.8904, 11.8901, 12.1492, 12.1529, 12.1530, 
                12.1531),
  latitude = c(57.6972, 57.6339, 57.6973, 57.6085, 57.6907, 57.6908, 57.6707, 57.6708, 
               57.6709, 57.6909, 57.6972, 57.6973, 57.6974, 57.6339, 57.6085, 57.6086, 
               57.6087)
)

# Convertir les points en objet sf
points_sf <- st_as_sf(points_remarquables, coords = c("longitude", "latitude"), crs = 4326)

# Créer la carte leaflet
carte <- leaflet(suede) %>%
  addScaleBar(position = "bottomleft") %>%
  addProviderTiles("Esri.OceanBasemap") %>%
  addMarkers(data = points_sf, popup = ~nom, icon = icone_personnalisee) %>%
  fitBounds(limites[[1]][2], limites[[1]][1], limites[[2]][2], limites[[2]][1]) # Zoom avec les limites fournies
carte

carte_sans_point <- leaflet(suede) %>%
  addScaleBar(position = "bottomleft") %>%
  addProviderTiles("Esri.OceanBasemap") %>%
  fitBounds(limites[[1]][2], limites[[1]][1], limites[[2]][2], limites[[2]][1]) # Zoom avec les limites fournies

# Exporter la carte en PNG
mapshot(carte_sans_point, file = "C:/Users/remi.gschwind/Desktop/Metagenomique_fonctionnelle/Ecriture/data/abundance/carte_swe.png", vwidth = 2400, vheight = 1600)