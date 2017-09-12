# Load the menu csv as a dataframe.
csv_file_path <- "esiea/Analyse exploratoire/TD1/data/menu.csv"
df <- as.data.frame(read.csv(csv_file_path))

summary(df)

# Compute the Chi square test for Calories and Total Fat.
print(chisq.test(df$Calories,
                 df$Total.Fat))

# Name of the variables we are interested in computing the Chi square test.
fields_of_interest <- c("Calories", "Total.Fat",
                        "Cholesterol", "Sodium", "Sugars", "Protein")

n <- length(fields_of_interest)

function(df, fields_of_interest) {
  n <- length(fields_of_interest)
  
  # Initializing the matrix containing the chi square values.
  chi2_matrix <- matrix(0, ncol = n, nrow = n, dimnames = list(fields_of_interest, fields_of_interest))
  
  # Computing the Chi square values, and using the symmetry of the matrix.
  for (i in 1:(length(fields_of_interest) - 1)) {
    for (j in (i + 1):length(fields_of_interest)) {
      chi2 <- chisq.test(df[, fields_of_interest[i]],
                         df[, fields_of_interest[j]])$statistic
      
      chi2_matrix[i, j] <- chi2
      chi2_matrix[j, i] <- chi2
    }
  }
  
  return chi2_matrix
}

# Initializing the matrix containing the chi square values.
chi2_matrix <- matrix(0, ncol = n, nrow = n, dimnames = list(fields_of_interest, fields_of_interest))



print(chi2_matrix)

corr_matrix <- round(cor(menu_df[, fields_of_interest]), 2)
print(corr_matrix > 0.5)
print(corr_matrix)

corr_matrix <- round(cor(scale(menu_df[, fields_of_interest])), 2)
print(corr_matrix > 0.5)
print(corr_matrix)

library(rgl)
plot3d(menu_df$Calories, menu_df$Total.Fat, menu_df$Cholesterol, type ="s")
# We can see that all but 'Sugars' are correlated (with r>0,5)


list <- c("Calories", "Total.Fat", "Cholesterol")
menu_df.cr <- scale(menu_df[, list])
lims <- c(min(menu_df.cr) , max(menu_df.cr))
plot3d(menu_df.cr, type="s", xlim=lims, ylim=lims, zlim=lims )


menu_df.cr_df <- as.data.frame(menu_df.cr)
plot3d(menu_df.cr, type="s", xlim=lims, ylim=lims,zlim=lims)
plot3d(ellipse3d(cor(cbind(menu_df.cr_df$Calories, menu_df.cr_df$Total.Fat, menu_df.cr_df$Cholesterol))), col="grey", add = TRUE)

list <- c("Sodium", "Sugars", "Protein")
menu_df.cr <- scale(menu_df[, list])
lims <- c(min(menu_df.cr) , max(menu_df.cr))
menu_df.cr_df <- as.data.frame(menu_df.cr)
plot3d(menu_df.cr, type="s", xlim=lims, ylim=lims,zlim=lims)
plot3d(ellipse3d(cor(cbind(menu_df.cr_df$Sodium, menu_df.cr_df$Sugars, menu_df.cr_df$Protein))), col="grey", add = TRUE)

library(ade4)

list <- c("Calories", "Total.Fat", "Cholesterol")
acp <- dudi.pca(menu_df[, list], center=TRUE, scale = TRUE, scannf = FALSE , nf = 3)
names(acp)
acp$tab


(pve <- 100*acp$eig/sum(acp$eig))
pve <- 100*acp$eig/sum(acp$eig)
cumsum(pve)

# 15: 100% pour 3 axes
inertie <- inertia.dudi(acp , col.inertia = TRUE)
inertie
round ( acp$co ,2)
s.corcircle(acp$co , xax =1 , yax =2)
