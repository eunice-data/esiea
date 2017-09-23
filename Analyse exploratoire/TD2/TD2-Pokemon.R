data_path <- "~/esiea/Analyse exploratoire/TD2/data/Pokemon.csv"

poke <- as.data.frame(read.csv(data_path,
                               na.strings=c("", "NA")))[c("Type_1", "Generation", "Legendary")]

library(ade4)
library(adegraphics)

poke$Generation <- as.factor(poke$Generation)

acmtot <- dudi.acm(poke, scannf=FALSE)

barplot(acmtot$eig)

score(acmtot, xax=1)

head(inertia.dudi(acmtot)$TOT)

scatter(acmtot)
