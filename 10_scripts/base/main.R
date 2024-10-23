library(tidyverse)
library(readr)
library(stringr)
library(janitor)

df <- read_csv("0_364/LT_0_364_NOSHOCK.csv")
head(df)
colnames(df)
unique(df$location_name)

# slice dataset to maintain only rows with location_name similar to countries names; apparently, after the row 241, it isnt anymore about countries

df_cutoff <- df %>%
    filter(location_id >= 1 & location_id <= 240)

unique(df_cutoff$location_name)
colnames(df_cutoff)

df_cutoff %>%
    select(-c(
        "sex_id",
        "age_group_id",
        "metric_id",
        "measure_id"
    ))

glimpse(df_cutoff)

# recode variables

## sex: female = 0, male = 1

df_cutoff <- df_cutoff %>%
    mutate(sex_name = case_when(
        sex_name == "female" ~ 0,
        sex_name == "male" ~ 1,
        TRUE ~ NA_real_
    ))

glimpse(df_recode)

df_cutoff <- df_cutoff %>%
    mutate(age = case_when(
        age_group_name == "<1 year" ~ 0,
        TRUE ~ NA_real_
    ))

unique(df_recode$measure_name)

df_cutoff <- df_cutoff %>%
    select(-c("sex_id"))

glimpse(df_cutoff)

df_cutoff <- df_cutoff %>%
    mutate(metrics = case_when(
        metric_name == "Probability of death" ~ "P",
        metric_name == "Years" ~ "LE",
        TRUE ~ NA_character_
    ))

glimpse(df_cutoff)

df_cutoff <- df_cutoff %>%
    select(-c(
        "metric"
    ))

glimpse(df_cutoff)

# rename variables

df_cutoff <- df_cutoff %>%
    rename(
        country = location_name,
        sex = sex_name,
        time = year_id,
        outcome_name = metric_name,
        outcome = val,
        outcome_upper = upper,
        outcome_lower = lower,
        outcome_abv = metrics
    )

glimpse(df_cutoff)

# round outcome, upper and lower to 4 decimal places

df_final <- df_cutoff %>%
    mutate(
        outcome = round(outcome, 4),
        outcome_upper = round(outcome_upper, 4),
        outcome_lower = round(outcome_lower, 4)
    )

glimpse(df_final)

df_final <- df_final %>%
    mutate(
        sex = as.factor(sex),
        outcome_abv = as.factor(outcome_abv)
    )

glimpse(df_final)

# plotting LE for Brazil, US and China regardless of sexes, 1950 to max

df_final %>%
    filter(country %in% c("Brazil", "United States of America", "China") & outcome_abv == "LE") %>%
    ggplot(aes(x = time, y = outcome, color = country)) +
    geom_line() +
    geom_smooth(aes(ymin = outcome_lower, ymax = outcome_upper), SE = FALSE, alpha = 0.2) +
    labs(
        title = "Life Expectancy at Birth in Brazil, US and China",
        x = "Year",
        y = "Life Expectancy at Birth",
        color = "Country"
    ) +
    theme_minimal()

# marginal means of differences between LE in Brazil, US and China

## comparison of variables and observations of df and df_final, after data wrangling

glimpse(df)
glimpse(df_final)

## dataframe describing structure of df and df_final

## detecting when the rate of change of LE changed in Brazil lose linearity from 1950 to max

## descripe installed packages

print(sessionInfo())
