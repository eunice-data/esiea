dir_path <- "esiea/Exploratory analysis/TD2/"
csv_1_path <- paste(dir_path, "afc_tache_menageres.csv", sep="")

dataP <- read.csv(csv_1_path, sep=";")
dataP

barplot(t(dataP[, -1]), beside =T, names = dataP$Task, col = c("lightblue", "mistyrose","lightcyan", "lavender"), legend = colnames(dataP [,2:5]))

dataP