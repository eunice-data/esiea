dir_path <- "esiea/Exploratory analysis/TD2/data/" # Chemin des data.
csv_1_path <- paste(dir_path, "afc_tache_menageres.csv", sep="") 

df <- read.csv(csv_1_path, sep=";", row.names = 1) # Import dans un dataframe.

summary(df) # On résume les données.

# On  trace le bar chart de la répartition des tâches par population.
barplot(t(dataP[, -1]),
        beside =T,
        names = df$Task,
        col = c("lightblue", "mistyrose","lightcyan", "lavender"))

t_df <- data.frame(t(df)) # Transpose the dataframe for Chi square.
chisq.test(t_df$Laundry, t_df$Main_meal)

chi2_matrix <- matrix(0, ncol = n, nrow = n, dimnames = list(colnames(t_df), colnames(t_df)))
for (i in 1:(length(colnames(t_df)) - 1)) {
  for (j in (i + 1):length(colnames(t_df))) {
    chi2 <- chisq.test(t_df[, colnames(t_df)[i]],
                       t_df[, colnames(t_df)[j]])$statistic
    
    chi2_matrix[i, j] <- chi2
    chi2_matrix[j, i] <- chi2
  }
}

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
