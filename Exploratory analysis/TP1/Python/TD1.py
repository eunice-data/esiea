import pandas as pd
import numpy as np

from scipy.stats import chi2_contingency

# Importing the csv and loading it in a dataframe.
CSV_FILE_PATH = "../menu.csv"
menu_df = pd.read_csv(CSV_FILE_PATH)


def chisq_of_df_cols(df, c1, c2):
    groupsizes = df.groupby([c1, c2]).size()
    ctsum = groupsizes.unstack(c1)
    # fillna(0) is necessary to remove any NAs which will cause exceptions
    return(chi2_contingency(ctsum.fillna(0)))


FIELDS_OF_INTEREST = ["Calories", "Total Fat",
                      "Cholesterol", "Sodium", "Sugars", "Protein"]

chi2_results_df = pd.DataFrame(len(FIELDS_OF_INTEREST)*[len(FIELDS_OF_INTEREST)*[0]], columns=FIELDS_OF_INTEREST)

for i in range(len(FIELDS_OF_INTEREST) - 1):
    for j in range(i + 1, len(FIELDS_OF_INTEREST)):
        chi2 = chisq_of_df_cols(
            menu_df, FIELDS_OF_INTEREST[i], FIELDS_OF_INTEREST[j])[0]

        chi2_results_df.iloc[i, j] = chi2
        chi2_results_df.iloc[j, i] = chi2

chi2_results_df["index"] = FIELDS_OF_INTEREST
chi2_results_df=chi2_results_df.set_index("index")

print(chi2_results_df)
