library(tidyverse)
library(RColorBrewer)
library(stringr)
library(gridExtra) # Ajout de la librairie gridExtra

# Vos données, telles que fournies
donnees_texte <- "
\"\",\"FRA-1-SEINE\",\"FRA-2-HOSPWW\",\"GER-10-GROSSEWATER\",\"GER-11-KLINGDRINK\",\"GER-12-WANNDRINK\",\"GER-13-KLINGSED\",\"GER-14-ELBEFISH\",\"GER-15-LAKESED\",\"GER-16-WANNWATER\",\"GER-1-KREISCHAIN\",\"GER-2-GROSSESOIL\",\"GER-3-ELBEWATER\",\"GER-4-KLINGSOIL\",\"GER-5-KREISCHAOUT\",\"GER-6-LWBWATER\",\"GER-7-LWBSED\",\"GER-8-LAKEWATER\",\"GER-9-ELBESED\",\"PAK-10-CDAOUT\",\"PAK-11-QUAIN\",\"PAK-12-QUAOUT\",\"PAK-1-SHAHZAD\",\"PAK-2-NARC\",\"PAK-3-QAU\",\"PAK-4-BANI\",\"PAK-5-LAKE\",\"PAK-6-SHAHDARA\",\"PAK-7-JINNAH\",\"PAK-8-BARI\",\"PAK-9-CDAIN\",\"SWE-10-NGOTA\",\"SWE-11-NRYAOUTMP\",\"SWE-12-NRYAOUT\",\"SWE-13-NRYAIN\",\"SWE-14-NFINN\",\"SWE-15-NSOIL1\",\"SWE-16-NSOIL2\",\"SWE-17-NSOIL3\",\"SWE-1-JRYAIN\",\"SWE-2-JFINN\",\"SWE-3-JRYAOUT\",\"SWE-4-JSOIL1\",\"SWE-4-JSOIL2\",\"SWE-5-JGOTA\",\"SWE-6-JGOTAMP\",\"SWE-7-JFOTO\",\"SWE-8-JFOTO2\",\"SWE-9-NFOTO\"
\"PGNFDC1\",0,5.65479117167217e-08,0,0,0,0,0,0,0,0,0,9.09815378534738e-09,0,0,0,0,0,0,0,1.12475669684918e-08,0,0,0,0,0,0,0,0,0,3.26508407896244e-08,1.13376458412404e-08,0,1.75500146239884e-08,0,0,0,0,0,5.44074572514896e-08,0,0,0,0,0,0,0,0,0
\"SWE1FDC1\",0,1.61565462047776e-08,0,0,0,0,0,0,0,9.46306619204721e-08,0,0,0,2.11895037284733e-08,0,0,0,0,1.205882836713e-08,4.4990267873967e-08,1.14596419886371e-08,0,0,0,0,0,0,0,9.07035833879199e-08,2.50323112720454e-07,0,8.65893190256606e-08,8.77500731199422e-09,6.16763527836805e-08,0,0,0,0,2.6115579480715e-07,0,1.05896006923142e-08,0,0,0,0,0,0,9.33574206681548e-09
\"GER1FDC1\",0,2.18113373764498e-07,0,0,0,0,0,0,0,6.90803832019447e-07,0,1.00079691638821e-07,0,2.11895037284733e-08,0,0,0,0,1.39882409058708e-06,6.80477801593751e-06,5.38603173465942e-06,0,0,0,0,0,2.19102356462599e-07,0,5.62362217005103e-06,1.83171216829793e-05,0,1.62354973173114e-07,1.40400116991907e-07,6.16763527836805e-07,2.2301959408895e-08,0,0,0,8.37874841672939e-07,0,1.05896006923142e-08,0,0,0,0,0,0,0
\"GER5FDCa\",0,0,0,0,0,0,0,0,0,0,0,0,0,2.43679292877443e-06,6.91889837415402e-07,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
"

# Charger les données dans un dataframe
donnees <- read_csv(file = I(donnees_texte), quote = "\"", col_names = TRUE, na = character())

# Renommer la première colonne '...1' en 'gene'
donnees <- donnees %>%
  rename(gene = ...1)

# Transformer les données en format long
donnees_long <- donnees %>%
  pivot_longer(cols = -gene, names_to = "echantillon", values_to = "abondance") %>%
  filter(gene %in% c("GER5FDCa", "SWE1FDC1", "GER1FDC1"))

# Force 'abondance' column to be numeric
donnees_long <- donnees_long %>%
  mutate(abondance = as.numeric(abondance))

# Extraire le préfixe de l'échantillon
donnees_long <- donnees_long %>%
  mutate(prefixe_echantillon = str_extract(echantillon, "^[A-Z]{3}"))

# Définir les préfixes à tracer
prefixes_a_tracer <- c("GER", "FRA", "SWE", "PAK")

# Dossier de sortie pour les graphiques
dossier_sortie <- "C:/Users/remi.gschwind/Desktop/Metagenomique_fonctionnelle/Ecriture/data/abundance/"

# Palette de couleurs
palette_nom <- "Set1"
nombre_couleurs <- max(3, nrow(donnees))
gene_couleurs <- colorRampPalette(brewer.pal(n = min(nombre_couleurs, brewer.pal.info[palette_nom, "maxcolors"]), name = palette_nom))(nombre_couleurs)


# Boucle pour créer un graphique par préfixe d'échantillon
for (prefixe_actuel in prefixes_a_tracer) {
  # Filtrer les données pour le préfixe d'échantillon actuel
  donnees_prefixe <- donnees_long %>%
    filter(prefixe_echantillon == prefixe_actuel)
  
  # *** Calculer la valeur maximale de l'abondance POUR CE PRÉFIXE ***
  max_abondance_prefixe <- max(donnees_prefixe$abondance, na.rm = TRUE)
  
  # Filtrage des échantillons à abondance totale nulle par préfixe
  sample_abundance_sum_prefixe <- donnees_prefixe %>%
    group_by(echantillon) %>%
    summarise(total_abundance = sum(abondance, na.rm = TRUE))
  
  echantillons_a_tracer_prefixe <- sample_abundance_sum_prefixe %>%
    filter(total_abundance > 0) %>%
    pull(echantillon)
  
  donnees_prefixe_filtree <- donnees_prefixe %>%
    filter(echantillon %in% echantillons_a_tracer_prefixe)
  
  # Liste pour stocker les graphiques individuels de ce préfixe
  liste_graphiques_prefixe <- list()
  
  # Boucle POUR CHAQUE ÉCHANTILLON du préfixe actuel (au lieu de facet_wrap)
  for (echantillon_actuel in unique(donnees_prefixe_filtree$echantillon)) {
    # Filtrer les données pour CET ÉCHANTILLON SPECIFIQUE
    donnees_echantillon <- donnees_prefixe_filtree %>%
      filter(echantillon == echantillon_actuel)
    
    # Créer un graphique ggplot2 *INDIVIDUEL* (échelle linéaire, TAILLE STANDARD, TEXTES AJUSTÉS, LEGENDE SUPPRIMÉE, RATIO ASPECT FIXE)
    p_individu <- ggplot(donnees_echantillon, aes(x = gene, y = abondance, fill = gene)) + # PAS de group=echantillon ici
      geom_col(width = 0.5) + # PAS de position="dodge" car un seul échantillon
      scale_fill_manual(values = gene_couleurs[1:nrow(donnees_echantillon)]) +
      theme_minimal() +
      labs(
        title = echantillon_actuel, # Le titre devient le nom de l'échantillon
        y = "Relative abundance",
        x = "") +
      theme( # Ajustements de thème (identiques aux précédents, sauf strip.text)
        plot.title = element_text(size = 80, hjust = 0.5), # Titre de chaque graphique individuel (centré)
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.text.x = element_blank(), # Angle pour les labels x si besoin
        axis.text.y = element_text(size = 80),
        legend.position = "none",
        aspect.ratio = 1 # Ratio d'aspect fixe (carré)
      ) +
      coord_cartesian(ylim = c(0, max_abondance_prefixe)) # Axe Y homogénéisé PAR GROUPE
    
    # Ajouter le graphique individuel à la liste
    liste_graphiques_prefixe[[echantillon_actuel]] <- p_individu
  }
  
  # *** Utiliser grid.arrange pour assembler les graphiques individuels en grille ***
  nombre_colonnes_grille <- 3 # Par défaut 3 colonnes

  
  # Dimensions FIXES pour TOUS les groupes dans ggsave()
  largeur_ggsave <- 50
  hauteur_ggsave <- 50
  
  
  # Créer le nom de fichier *AVANT* grid.arrange, car grid.arrange ne retourne pas un objet ggsave directement enregistrable
  nom_fichier <- paste0(dossier_sortie, "abundance_groupee_grille_lineaire_Set1_noTitle_textAdjusted_noLegend_fixedAspect_3colsSWE_sizeFIXED_yaxisHomogeneiseeGroupe_", prefixe_actuel, "_group.png") # Nom de fichier modifié pour yaxisHomogeneiseeGroupe
  
  # Assembler les graphiques en grille avec grid.arrange et enregistrer *directement* avec ggsave dans un bloc 'print'
  png(nom_fichier, width = largeur_ggsave, height = hauteur_ggsave, units = "in", res = 300, bg = "white") # Ouvrir le périphérique png avec DIMENSIONS FIXES (width=30, height=22) pour TOUS
  print(grid.arrange(grobs = liste_graphiques_prefixe, ncol = nombre_colonnes_grille)) # Afficher la grille avec grid.arrange, et print pour capture par png()
  dev.off() # Fermer le périphérique png, enregistrement terminé
  
  cat("Graphique groupé en grille linéaire SANS TITRE, TEXTES AJUSTÉS, SANS LEGENDE, RATIO D'ASPECT FIXE, 3 COLONNES pour SWE, TAILLE FIXE (30x22 pouces) pour TOUS et AXE Y HOMOGÉNEISÉ PAR GROUPE enregistré avec palette Set1 pour le préfixe :", prefixe_actuel, "\n")
}

cat("Processus terminé. Les graphiques groupés en grille linéaire SANS TITRE, TEXTES AJUSTÉS, SANS LEGENDE, RATIO D'ASPECT FIXE, 3 COLONNES pour SWE, TAILLE FIXE (30x22 pouces) pour TOUS et AXE Y HOMOGÉNEISÉ PAR GROUPE avec la palette Set1 ont été enregistrés dans le dossier :", dossier_sortie, "\n")