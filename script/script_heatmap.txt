# Nouvelles données sous forme de data.frame
data <- data.frame(
  GER5 = c(2.637268012, 1.549172065, 0.797983957, 0.751288605, 0.771341853, 0.165770153, 0.661191909, 0.479772277, 0.441344828),
  contig_ger5 = c(1.549172065, 2.722531981, 0.564160293, 0.533636659, 0.54541768, 0.126665017, 0.493448331, 0.558094662, 0.233170802),
  ftsI_coli = c(0.797983957, 0.564160293, 2.531039966, 2.393233898, 2.41440678, 0.088106989, 1.134516183, 0.450946006, 0.179588945),
  ftsI_coli_yrin = c(0.751288605, 0.533636659, 2.393233898, 2.534038851, 2.410990709, 0.086583835, 1.122185277, 0.438026549, 0.170592593),
  ftsI_coli_yrik = c(0.771341853, 0.54541768, 2.41440678, 2.410990709, 2.534038851, 0.091860705, 1.131113317, 0.433070796, 0.184425425),
  pbp_lp = c(0.165770153, 0.126665017, 0.088106989, 0.086583835, 0.091860705, 2.573865149, 0.092691919, 0.133146816, 0.188245399),
  pbp_bis_lp = c(0.661191909, 0.493448331, 1.134516183, 1.122185277, 1.131113317, 0.092691919, 2.664294165, 0.355467777, 0.171063477),
  pbpc_lp = c(0.479772277, 0.558094662, 0.450946006, 0.438026549, 0.433070796, 0.133146816, 0.355467777, 2.652382199, 0.160918019),
  pbp5_lp = c(0.441344828, 0.233170802, 0.179588945, 0.170592593, 0.184425425, 0.188245399, 0.171063477, 0.160918019, 2.656911548)
)

# Noms des lignes
rownames(data) <- c("GER5", "contig_ger5", "ftsI_coli", "ftsI_coli_yrin", "ftsI_coli_yrik", "pbp_lp", "pbp_bis_lp", "pbpc_lp", "pbp5_lp")

# Noms des colonnes (dans le même ordre que les lignes)
data <- data[, c("GER5", "contig_ger5", "ftsI_coli", "ftsI_coli_yrin", "ftsI_coli_yrik", "pbp_lp", "pbp_bis_lp", "pbpc_lp", "pbp5_lp")]

# Création de la heatmap
heatmap(as.matrix(data),
        main = "Heatmap des scores d'alignement",
        xlab = "Protéines", 
        ylab = "Protéines", 
        col = colorRampPalette(RColorBrewer::brewer.pal(9, "PuBu"))(100),
        scale = "none",
        Rowv = NA, Colv = NA,
        margins = c(10, 10),
        cexRow = 0.8, cexCol = 0.8,
        symm = TRUE)

# Création de l'image de la légende
gradient <- colorRampPalette(RColorBrewer::brewer.pal(9, "PuBu"))(100)
png("legend.png", width = 100, height = 300)
par(mar = c(0, 0, 0, 0))
image(1, seq(0, 1, length.out = 100), matrix(seq(0, 1, length.out = 100)), col = gradient, axes = FALSE)
text(1, 0, "low", pos = 1)
text(1, 1, "high", pos = 3)
dev.off()

# Ajout de l'image de la légende à la heatmap
rasterImage(png::readPNG("legend.png"), 
            xleft = par("usr")[2] + 0.1 * diff(par("usr")[1:2]),
            ybottom = par("usr")[3],
            xright = par("usr")[2] + 0.15 * diff(par("usr")[1:2]),
            ytop = par("usr")[4])