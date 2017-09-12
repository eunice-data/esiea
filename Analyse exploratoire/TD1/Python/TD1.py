import pandas as pd
import numpy as np

from scipy.stats import chi2_contingency

# Importing the csv and loading it in a dataframe.
CSV_FILE_PATH = "~/esiea/Analyse exploratoire/TD1/data/menu.csv"
MENU_DF = pd.read_csv(CSV_FILE_PATH)

# Similar to R's 'summary' function
print(MENU_DF.describe())


def chisq_of_df_cols(input_df, col_1, col_2):
    """
    Computes the chi square value for a dataframe based on two column names.
    Returns this value.
    """
    groupsizes = input_df.groupby([col_1, col_2]).size()
    ctsum = groupsizes.unstack(col_1)

    return chi2_contingency(ctsum.fillna(0))


def chisq_dataframe_of_dataframe(input_df, cols):
    n = len(cols)

    chi2_results_df = pd.DataFrame(len(cols) * [len(cols) * [0]], columns=cols)

    for i in range(n - 1):
        for j in range(i + 1, n):
            chi2 = chisq_of_df_cols(
                MENU_DF, cols[i], cols[j])[0]

            chi2_results_df.iloc[i, j] = chi2
            chi2_results_df.iloc[j, i] = chi2

    return chi2_results_df


def scale_column_df(input_df, norm_df, col_name):
    """
    Returns a dataframe where the specified col_name is the scaled version of the input dataframe's.
    """
    try:
        norm_df[col_name] = (
            input_df[col_name] - input_df[col_name].mean()) / input_df[col_name].std()
        return norm_df, None
    except Exception as exc:
        return norm_df, exc

def scale_df(input_df, col_names):
    norm_df = pd.DataFrame()

    for col_name in col_names:
        norm_df, exc = scale_column_df(input_df, norm_df, col_name)

        if exc is not None:
            print(exc)
    
    return norm_df

def main():
    fields_of_interest = ["Calories", "Total Fat",
                          "Cholesterol", "Sodium", "Sugars", "Protein"]

    chi2_results_df = chisq_dataframe_of_dataframe(MENU_DF, fields_of_interest)

    chi2_results_df["index"] = fields_of_interest
    chi2_results_df = chi2_results_df.set_index("index")

    print(chi2_results_df)

    chi2_results_df = chisq_dataframe_of_dataframe(scale_df(MENU_DF, fields_of_interest), fields_of_interest)

    chi2_results_df["index"] = fields_of_interest
    chi2_results_df = chi2_results_df.set_index("index")
    
    print(chi2_results_df)

if __name__ == '__main__':
    main()
