dir_path <- "esiea/Exploratory analysis/TD2/data/"
csv_1_path <- paste(dir_path, "afc_tache_menageres.csv", sep="")

df <- read.csv(csv_1_path, sep=";")

row.names(dataP) <- dataP$Task


barplot(t(dataP[, -1]),
        beside =T,
        names = dataP$Task,
        col = c("lightblue", "mistyrose","lightcyan", "lavender"),
        legend = colnames(dataP[, 2:5]))

library(FactoMineR)

res = CA(dataP[, 2:5])

plot.CA(res,
        xax = 1,
        yax = 2,
        clabel=1.5)

plot.CA(res,
        axes = c(2,3))

res$col
sum(res$col$inertia) # 1.11494
