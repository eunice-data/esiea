# TD2 - Analyse Factorielle des Correspondances et Analyse des Correspondances Multiples

## Tâches ménagères

### Chargement des données

On importe les données dans un dataframe:\
`df <- read.csv(csv_1_path, sep=";", row.names=1)`

On résumme les données:\
`summary(df)`

| | Wife | Alternating | Husband | Jointly
| --- | --- | --- | --- | --- |
| Min. | 0.00 | 1.00 | 1.00 | 2.00
|1st Qu. | 10.00 | 11.00 | 5.00 | 4.00
|Median  | 32.00 | 14.00 | 9.00 | 15.00
|Mean    | 46.15 | 19.54 | 29.31 | 39.15
|3rd Qu. | 77.00 | 24.00 | 23.00 | 57.00
|Max.    | 156.00 | 51.00 | 160.00 | 153.00

Histogramme obtenu:
![figure1.png](https://github.com/ValentinMouret/esiea/blob/master/Exploratory%20analysis/TD2/R/pictures/bar_plot_1.png)

On remarque une ségrégation de certaines tâches, la lessive et la préparation des repas étant très majoritairement réalisées par des femmes et les réparations pour les hommes.