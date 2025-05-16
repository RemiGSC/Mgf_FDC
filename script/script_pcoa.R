library(vegan)
library(ape)
library(tidyverse)

OTU_abundance <-
  read_tsv(file = "C:/Users/remi.gschwind/Desktop/Metagenomique_fonctionnelle/Ecriture/data/embark_281124_motusv3.0.tsv")

OTU_abundance <- data.frame(t(as.matrix(OTU_abundance)))
names(OTU_abundance) <- OTU_abundance[1, ]
# Removing first line (containing species names)
OTU_abundance <- OTU_abundance[2:nrow(OTU_abundance), ]

row.names(OTU_abundance) <- gsub(pattern = "preprocessed/Sample_UK-3137-",
                                 replacement = "",
                                 x = row.names(OTU_abundance))

row.names(OTU_abundance) <- gsub(pattern = "/.*",
                                 replacement = "",
                                 x = row.names(OTU_abundance))

# "as.is = TRUE" is mandatory
OTU_abundance <- type.convert(OTU_abundance,
                              as.is = TRUE)
str(OTU_abundance)

OTU_dist <- 
  vegdist(OTU_abundance,
          method = "bray")

OTU_dist2 <- 
  data.frame(as.matrix(OTU_dist)) |>
  as_tibble()
# Change with real names
rownames(OTU_dist2) <- colnames(OTU_dist2)

OTU_dist2 |>
  rownames_to_column(var="Name") |>
  gather(key="Variable",
         value="Value",
         -1) |>
  ggplot(aes(Name, Variable, fill = Value)) + 
  geom_tile() +
  theme_minimal() +
  theme(legend.position="none")

OTU_dist2 |>
  rownames_to_column(var="Name") |>
  gather(key="Variable",
         value="Value",
         -1) |>
  ggplot(aes(Name, Variable, fill = Value)) +
  geom_tile() +
  theme_minimal() +
  ylab("") +
  xlab("") +
  theme(legend.position="none",
        axis.text.x = element_text(angle = 90,
                                   vjust = 0.5,
                                   hjust=1))

# Réalisation de la PCoA
pcoa_result <- pcoa(OTU_dist2)

# Visualisation dans un graphique 2D
data.frame(Axis1 = pcoa_result$vectors[,1], Axis2 = pcoa_result$vectors[,2]) %>%
  ggplot(aes(x = Axis1, y = Axis2)) +
  geom_point() +
  labs(x = "Axe 1", y = "Axe 2", title = "PCoA des échantillons")

# Créer un dataframe avec les coordonnées des points et les noms des échantillons
df_pcoa <- data.frame(
  Axis1 = pcoa_result$vectors[,1],
  Axis2 = pcoa_result$vectors[,2],
  Label = rownames(pcoa_result$vectors))  # Assurez-vous que les noms de ligne correspondent aux noms de vos échantillons)

# Créer le graphique PCoA avec les labels
ggplot(df_pcoa, aes(x = Axis1, y = Axis2, label = Label)) +
  geom_point() +
  geom_text(hjust = 0, nudge_x = 0.02) +  # Ajuster les positions des labels
  labs(x = "Axe 1", y = "Axe 2", title = "PCoA des échantillons")




groupes <- c("freshwater" , "wastewater" , "freshwater" , "freshwater" , "freshwater" ,
             "sediment", "fish" , "freshwater" , "freshwater" , "wwtp_in", 
             "soil" , "freshwater" , "soil" , "wwtp_out" , "freshwater" ,
             "sediment", "freshwater" , "sediment" , "wwtp_out" , "wwtp_in" ,
             "wwtp_out" , "soil" , "soil" , "soil" , "soil" ,
             "freshwater" , "freshwater" , "freshwater" , "freshwater" , "wwtp_in" ,
             "freshwater" , "wwtp_out" , "wwtp_out" , "wwtp_in" , "wwtp_in" ,
             "soil" , "soil" , "soil" , "wwtp_in" , "wwtp_in" ,
             "wwtp_out" , "soil" , "soil" , "freshwater" , "freshwater" ,
             "saltwater" , "saltwater" , "saltwater") 
country <- c("France" , "France" , 
             "Germany" , "Germany" , "Germany" , "Germany" , "Germany" , "Germany" , "Germany" , "Germany" , 
             "Germany" , "Germany" , "Germany" , "Germany" , "Germany" , "Germany" , "Germany" , "Germany" ,
             "Pakistan" , "Pakistan" , "Pakistan" , "Pakistan" , "Pakistan" , "Pakistan" ,
             "Pakistan" , "Pakistan" , "Pakistan" , "Pakistan" , "Pakistan" , "Pakistan" ,
             "Sweden" , "Sweden" , "Sweden" , "Sweden" , "Sweden" , "Sweden" , 
             "Sweden" , "Sweden" , "Sweden" , "Sweden" , "Sweden" , "Sweden" , 
             "Sweden" , "Sweden" , "Sweden" , "Sweden" , "Sweden" , "Sweden")
fdc_mgf <- c("neg" , "neg" , "nd" , "nd" , "nd" , "nd" , "nd" , "nd" , "nd" , "pos" , 
             "neg" , "pos" , "neg" , "pos" , "neg" , "nd" , "neg" , "neg" , "neg" , "nd" , 
             "nd" , "neg" , "neg" , "nd" , "nd" , "neg" , "nd" , "nd" , "nd" , "nd" , 
             "nd" , "neg" , "neg" , "neg" , "nd" , "neg" , "neg" , "neg" , "pos" , "nd" , 
             "nd" , "neg" , "neg" , "nd" , "neg" , "nd" , "nd" , "nd")

df_pcoa <- data.frame(
  Axis1 = pcoa_result$vectors[,1],
  Axis2 = pcoa_result$vectors[,2],
  Label = rownames(pcoa_result$vectors),
  Sample_type = groupes,
  mgf = fdc_mgf ,
  Country = country
)
library(RColorBrewer)
ggplot(df_pcoa, aes(x = Axis1, y = Axis2, shape = Country, color = Sample_type)) +
  geom_point(size = 3) +
  labs(x = "Axis 1", y = "Axis 2", title = "Bray curtis distance PCoA") +
  scale_color_brewer(palette = "Paired") +
  scale_shape_manual(values = c(15 , 17 , 16 , 18), labels = c("France", "Germany" , "Pakistan" , "Sweden")) +  # Ajoutez d'autres groupes si nécessaire
  theme_classic() + 
  theme(legend.text = element_text(size = 22))

library(ggplot2)

ggplot(df_pcoa, aes(x = Axis1, y = Axis2, shape = Country, color = Sample_type)) +
  geom_point(size = 3) +
  labs(x = "Axis 1", y = "Axis 2", title = "Bray curtis distance PCoA") +
  scale_color_brewer(palette = "Paired") +
  scale_shape_manual(values = c(15, 17, 16, 18), labels = c("France", "Germany", "Pakistan", "Sweden")) +
  theme_classic() +
  theme(
    legend.text = element_text(size = 22), # Taille du texte de la légende
    plot.title = element_text(size = 24, face = "bold"), # Taille et style du titre principal
    axis.title.x = element_text(size = 20), # Taille du titre de l'axe des x
    axis.title.y = element_text(size = 20), # Taille du titre de l'axe des y
    legend.title = element_text(size = 20) # Taille du titre de la légende
  )

# Supposons que votre dataframe s'appelle df_pcoa

# Liste des échantillons pour lesquels "functional metagenomics analysis" est "Yes"
echantillons_oui <- c(
  "SWE.1.JRYAIN", "SWE.4.JSOIL1", "SWE.6.JGOTAMP", "SWE.11.NRYAOUTMP", "SWE.12.NRYAOUT", "SWE.13.NRYAIN", 
  "SWE.15.NSOIL1", "SWE.16.NSOIL2", "SWE.17.NSOIL3", "GER.1.KREISCHAIN", "GER.2.GROSSESOIL", "GER.3.ELBEWATER", "GER.4.KLINGSOIL", 
  "GER.5.KREISCHAOUT", "GER.6.LWBWATER", "GER.8.LAKEWATER", "GER.9.ELBESED", "PAK.1.SHAHZAD", "PAK.2.NARC", "PAK.5.LAKE", 
  "PAK.10.CDAOUT"
)

# Créer une nouvelle colonne "functional metagenomics analysis" avec "No" par défaut
df_pcoa$functional_metagenomics_analysis <- "No"

# Mettre à jour les lignes correspondantes avec "Yes"
df_pcoa$functional_metagenomics_analysis[df_pcoa$Label %in% echantillons_oui] <- "Yes"

# Vérifier le résultat
df_pcoa

ggplot(df_pcoa, aes(x = Axis1, y = Axis2)) +
  geom_point(aes(shape = Country, color = Sample_type), size = 8) + # Taille augmentée à 6
  geom_point(data = df_pcoa[df_pcoa$functional_metagenomics_analysis == "Yes", ], 
             aes(x = Axis1, y = Axis2), 
             shape = 1, # Cercle vide
             color = "red", # Couleur du cercle
             size = 10, # Taille augmentée à 8
             stroke = 2) + # Épaisseur du trait augmentée
  labs(x = "Axis 1", y = "Axis 2", title = "Bray curtis distance PCoA") +
  scale_color_brewer(palette = "Paired") +
  scale_shape_manual(values = c(15, 17, 16, 18), labels = c("France", "Germany", "Pakistan", "Sweden")) +
  theme_classic() +
  theme(
    legend.text = element_text(size = 22),
    plot.title = element_text(size = 24, face = "bold"),
    axis.title.x = element_text(size = 20),
    axis.title.y = element_text(size = 20),
    legend.title = element_text(size = 20)
  )

head(df_pcoa)


# Liste des échantillons positifs
echantillons_positifs <- c("SWE.1.JRYAIN", "GER.1.KREISCHAIN", "GER.3.ELBEWATER", "GER.5.KREISCHAOUT")

# Liste des échantillons négatifs
echantillons_negatifs <- c("SWE.4.JSOIL1", "SWE.6.JGOTAMP", "SWE.11.NRYAOUTMP", "SWE.12.NRYAOUT", "SWE.13.NRYAIN", "SWE.15.NSOIL1", "SWE.16.NSOIL2", "SWE.17.NSOIL3", "GER.2.GROSSESOIL", "GER.4.KLINGSOIL", "GER.5.KREISCHAOUT", "GER.6.LWBWATER", "GER.8.LAKEWATER", "GER.9.ELBESED", "PAK.1.SHAHZAD", "PAK.2.NARC", "PAK.4.BANI", "PAK.5.LAKE", "PAK.10.CDAOUT")

# Modifier la colonne functional_metagenomics_analysis
df_pcoa$functional_metagenomics_analysis <- ifelse(df_pcoa$Label %in% echantillons_positifs, "Pos", 
                                                   ifelse(df_pcoa$Label %in% echantillons_negatifs, "Yes", "No"))

ggplot(df_pcoa, aes(x = Axis1, y = Axis2)) +
  geom_point(aes(shape = Country, color = Sample_type), size = 8) +
  geom_point(data = df_pcoa[df_pcoa$functional_metagenomics_analysis == "Yes", ], 
             aes(x = Axis1, y = Axis2), 
             shape = 1, 
             color = "black", # Cercles noirs
             size = 10, 
             stroke = 2) +
  geom_point(data = df_pcoa[df_pcoa$functional_metagenomics_analysis == "Pos", ], 
             aes(x = Axis1, y = Axis2), 
             shape = 1, 
             color = "red", # Cercles rouges
             size = 10, 
             stroke = 2) +
  labs(x = "Axis 1 - 24.79% variance", y = "Axis 2 - 12.32% variance") + 
  scale_color_brewer(palette = "Paired") +
  scale_shape_manual(values = c(15, 17, 16, 18), labels = c("France", "Germany", "Pakistan", "Sweden")) +
  theme_classic() +
  theme(
    legend.text = element_text(size = 22),
    plot.title = element_text(size = 24, face = "bold"),
    axis.title.x = element_text(size = 30),
    axis.title.y = element_text(size = 30),
    axis.text.x = element_text(size = 30),
    axis.text.y = element_text(size = 30),
    legend.title = element_text(size = 30)
  )

# Réalisation de la PCoA (si ce n'est pas déjà fait)
pcoa_result <- pcoa(OTU_dist)

# Extraction des valeurs propres
eigenvalues <- pcoa_result$values$Eigenvalues

# Calcul de la variance expliquée par chaque axe
variance_expliquee <- eigenvalues / sum(eigenvalues)

# Variance expliquée par l'axe 1 et l'axe 2 (en pourcentage)
variance_axe1 <- round(variance_expliquee[1] * 100, 2)
variance_axe2 <- round(variance_expliquee[2] * 100, 2)

cat(paste("Variance expliquée par l'axe 1 :", variance_axe1, "%\n"))
cat(paste("Variance expliquée par l'axe 2 :", variance_axe2, "%\n"))

summary(pcoa_result)
str(pcoa_result)