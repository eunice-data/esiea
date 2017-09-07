# Load the menu csv as a dataframe.
csv_file_path <- "Exploratory analysis/TP1/menu.csv"
menu_df <- read.csv(csv_file_path)

# Prints the dataframe.
print(menu_df)

# Compute the Chi square test for Calories and Total Fat.
print(chisq.test(c(menu_df$Calories,
        menu_df$Total.Fat)))

# Name of the variables we are interested in computing the Chi square test.
fields_of_interest <- c("Calories", "Total.Fat",
                      "Cholesterol", "Sodium", "Sugars", "Protein")

n <- length(fields_of_interest)

# Initializing the matrix containing the chi square values.
chi2_matrix <- matrix(0, ncol = n, nrow = n)
dimnames(chi2_matrix) <- list(fields_of_interest, fields_of_interest)

# Computing the Chi square values, and using the symmetry of the matrix.
for (i in 1:(length(fields_of_interest) - 1)) {
    for (j in (i + 1):length(fields_of_interest)) {
        chi2 <- chisq.test(c(menu_df[, fields_of_interest[i]],
                           menu_df[, fields_of_interest[j]]))$statistic

        chi2_matrix[i, j] <- chi2
        chi2_matrix[j, i] <- chi2
    }
}

print(chi2_matrix)