mcdo_df <- read.csv("~/esiea/Analyse exploratoire/TD1/data/menu.csv")
summary(mcdo_df)

cor(mcdo_df$Calories, mcdo_df$Total.Fat) # On calcule la corrélation entre les deux variables.

cor_of_df <- function(df, fields_of_interest) {
  "
  Function that computes the correlation for each couple of columns in a dataframe
  and returns a matrix containing the results.
  
  The computation takes into account the fact that the matrix is symmetrical, and
  that a correlation on the same vectors is 1.
  "
  n <- length(fields_of_interest)
  
  # Initializing the matrix containing the chi square values.
  cor_matrix <- matrix(1,
                       ncol = n,
                       nrow = n,
                       dimnames = list(fields_of_interest, fields_of_interest))
  
  # Computing the Chi square values, and using the symmetry of the matrix.
  for (i in 1:(n - 1)) {
    for (j in (i + 1):n) {
      temp_cor <- cor(df[, fields_of_interest[i]],
                      df[, fields_of_interest[j]])
      
      cor_matrix[i, j] <- temp_cor
      cor_matrix[j, i] <- temp_cor
    }
  }
  
  return(cor_matrix)
}


# Name of the variables we are interested in computing the Chi square test.
fields_of_interest <- c("Calories", "Total.Fat",
                        "Cholesterol", "Sodium", "Sugars", "Protein")

# Compute the chi square matrix.
(correlation_data_frame <- cor_of_df(mcdo_df[fields_of_interest], fields_of_interest))


# Same, but after scaling
(correlation_scaled_data_frame <- cor_of_df(scale(mcdo_df[fields_of_interest]), fields_of_interest))


# Difference between the two
correlation_data_frame - correlation_scaled_data_frame

correlation_data_frame>0.5

shapiro_of_df <- function(df, fields_of_interest) {
  "
  Function that computes the shapiro test's p value for each couple of columns in a dataframe
  and returns a matrix containing the results.
  
  The computation takes into account the fact that the matrix is symmetrical, and
  that a correlation on the same vectors is 1.
  "
  n <- length(fields_of_interest)
  
  # Initializing the matrix containing the chi square values.
  shapiro_array <- rep(NA, n)
  
  # Computing the Chi square values, and using the symmetry of the matrix.
  for (i in 1:n) {
    shapiro_array[i] <- shapiro.test(df[, fields_of_interest[i]])$p.value
  }
  
  return(shapiro_array)
}

(shapiro_of_df(mcdo_df, fields_of_interest)<0.05)

library(rgl)

list <- c("Calories", "Total.Fat", "Cholesterol")

plot3d(mcdo_df$Calories,
       mcdo_df$Total.Fat,
       mcdo_df$Cholesterol,
       type="s")

interesting_df <- scale(mcdo_df[, c("Calories", "Total.Fat", "Cholesterol")])

lims <- c(min(interesting_df),
          max(interesting_df))

plot3d(interesting_df,
       type = "s")

plot3d(ellipse3d(cor(cbind(interesting_df$Calories,
                           interesting_df$Total.Fat,
                           interesting_df$Cholesterol))),
                           col="grey",
                          add=TRUE)

library(ade4)
list <- c("Calories", "Total.Fat", "Cholesterol")
(acp <- dudi.pca(scale(mcdo_df[, list]),
                 center=FALSE,
                 scale=FALSE,
                 scannf = FALSE,
                 nf = 3))

names(acp)


pve <- 100 * acp$eig / sum(acp$eig) # On calcule le pourcentage d'intertie de chaque vecteur propre.
cumsum(pve)

(inertie <-inertia.dudi(acp, col.inertia=TRUE))

round(acp$co ,2)
s.corcircle(acp$co,
            xax=1,
            yax=2)


s.label(acp$li,
        xax = 1,
        yax = 2,
        label=as.character(mcdo_df$Item),
        clabel=1.5)

gcol <- c("red1", "red4","orange")
s.class(dfxy = acp$li, fac = mcdo_df$Category, col = gcol, xax =
          1, yax = 2)

scatter(acp)

list <- c("Calories", "Total.Fat", "Cholesterol", "Sodium", "Sugars", "Protein")
(acp <- dudi.pca(scale(mcdo_df[, list]),
                 center=FALSE,
                 scale=FALSE,
                 scannf = FALSE,
                 nf = 3))
(inertie <-inertia.dudi(acp, col.inertia=TRUE))

round(acp$co ,2)
s.corcircle(acp$co,
            xax=1,
            yax=2)
