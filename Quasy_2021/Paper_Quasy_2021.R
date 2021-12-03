##### Packages #####

library(tidyverse)
library(reshape2)

##### Import data #####

# Set working directory to source file location!

dateinamenliste_csv <- list.files(path = "../annotations", pattern='*.csv')
dateinamenliste_csv <- map_chr(dateinamenliste_csv, function(x){str_glue("../annotations", x, .sep = "/")})

df_liste_csv <- lapply(dateinamenliste_csv, read_csv2, show_col_types = F)
verben <- sapply(dateinamenliste_csv, str_sub, 16, -5)

names(df_liste_csv) <- verben

df_csv <- bind_rows(df_liste_csv, .id = "Verb") %>%
  select(1:25) # without Misc 2.


##### data wrangling #####

# creating one pattern column
for(i in 6:20){
  df_csv[,i] <- ifelse(is.na(df_csv[,i]), "", colnames(df_csv)[i])
}

# main df
df_all_verbs_cat <- unite(df_csv, pattern, 6:20, sep = "", remove = T)

# factorizing
df_all_verbs_cat$pattern <- factor(df_all_verbs_cat$pattern)
df_all_verbs_cat$Stimulus_Type <- factor(df_all_verbs_cat$Stimulus_Type)
df_all_verbs_cat$Stimulus_PP <- factor(df_all_verbs_cat$Stimulus_PP)
df_all_verbs_cat$Verb <- factor(df_all_verbs_cat$Verb)
df_all_verbs_cat$Control <- ifelse(is.na(df_all_verbs_cat$Control), F, T)
df_all_verbs_cat$Other_stimulus_adjunct <- ifelse(is.na(df_all_verbs_cat$Other_stimulus_adjunct), F, T)
df_all_verbs_cat$not_of_interest <- ifelse(is.na(df_all_verbs_cat$not_of_interest), F, T)
df_all_verbs_cat$`non-psych` <- ifelse(is.na(df_all_verbs_cat$`non-psych`), F, T)

# vector: not of interest/non psych if applicable else pattern
all_pat <- ifelse(df_all_verbs_cat$not_of_interest, "not of interest", ifelse(df_all_verbs_cat$`non-psych`, "non-psych", as.character(df_all_verbs_cat$pattern))) %>%
  factor() %>%
  fct_relevel("sein_zu-Inf", "tough", "Acc/Dat-EXP_V", "EXP_V_refl_Gen-STM", 
            "NoAux_V-PII", "Nom-EXP_V", "refl_V-PII_zeigen", "X-CAUS_V_Y-EXP_PP",
            "X_lassen_refl_V", "wirken/scheinen_V-PII", "sein_V-PII", "werden_V-PII",
            "X_V_refl", "X-STM_V", "X-STM_V_Y-EXP", "non-psych", "not of interest")

# df: verb and all_pat for each example
df.all_pat <- data.frame(verb = df_all_verbs_cat$Verb, pat = all_pat)

# data for table 1: verbs x patterns
pattern_counts <- as_data_frame(table(df.all_pat))
pattern_counts <- pivot_wider(pattern_counts, names_from = pat, values_from = n)

# pattern shares for each verb
pattern_counts_prop <- prop.table(as.matrix(pattern_counts[2:18]), 1)
row.names(pattern_counts_prop) <- pattern_counts$verb

# example verbs for section 2.3
pattern_counts_example_verbs <- filter(df.all_pat, df.all_pat$verb == "wundern" | df.all_pat$verb == "beeindrucken" | df.all_pat$verb == "irritieren" | df.all_pat$verb == "begeistern" | df.all_pat$verb == "schockieren") 
colnames(pattern_counts_example_verbs)[2] <- "Pattern"

##### Plots #####


# Figure 3

variation_accusative <- ggplot(pattern_counts_example_verbs, aes(y = verb, fill = Pattern)) + 
  geom_bar() +
  theme(axis.text.y = element_text(family = "serif"), legend.key.size = unit(3.5, "mm"), legend.text = element_text(size = 9)) +
  scale_fill_manual(values = c("honeydew", "pink", "blue", "orange", "white", "aquamarine", "grey", "cyan", "yellow", "brown", "darkblue", "green", "red", "black"))

#ggsave("variation_accusative.pdf", plot = variation_accusative, device = "pdf", width = 15, height = 7, units = "cm")

# Figure 3

only_refl_pass_verbs <- filter(pattern_counts, pattern_counts$"X_V_refl" > 0 | pattern_counts$"werden_V-PII" > 0 | pattern_counts$"sein_V-PII" > 0) %>%
  pivot_longer(2:18, names_to = "Pattern", values_to = "count")

only_refl_pass_verbs$Pattern <- if_else(only_refl_pass_verbs$Pattern == "X_V_refl", "X_V_refl", 
                                        if_else(only_refl_pass_verbs$Pattern == "werden_V-PII", "werden_V-PII", 
                                                if_else(only_refl_pass_verbs$Pattern == "sein_V-PII", "sein_V-PII", "other")))

plot_refl_pass <- ggplot(only_refl_pass_verbs, aes(y = count, x = verb, fill = Pattern)) + 
  geom_col() + 
  theme(axis.text.x = element_text(angle = 90, family = "serif", vjust = 0.2, hjust = 1)) + 
  scale_fill_manual(values = c("grey85", "#8569D5", "#3F4921", "#D3D93E"))

#ggsave("plot_refl_pass.pdf", plot = plot_refl_pass, device = "pdf", width = 15, height = 7, units = "cm")

##### Correlations Section 2.2 reflexive/passive #####

# reflexive werden
cor(pattern_counts$`X_V_refl`, pattern_counts$`werden_V-PII`)

# reflexive sein
cor(pattern_counts$`X_V_refl`, pattern_counts$`sein_V-PII`)

# reflexive combined
cor(pattern_counts$`X_V_refl`, pattern_counts$`sein_V-PII` + pattern_counts$`werden_V-PII`)

##### Data for distribution patterns table #####

pattern_counts <- relocate(pattern_counts, "verb", "X-STM_V_Y-EXP", "X-STM_V", "X_V_refl", "werden_V-PII",
                            "sein_V-PII", "wirken/scheinen_V-PII", "X_lassen_refl_V",
                            "X-CAUS_V_Y-EXP_PP", "refl_V-PII_zeigen", "Nom-EXP_V",
                            "NoAux_V-PII", "EXP_V_refl_Gen-STM", "Acc/Dat-EXP_V",
                            "tough", "sein_zu-Inf")

# for (v in 1:nrow(pattern_counts)) {
#   print(pattern_counts[v,1])
#   print(str_c(c(pattern_counts[v,2:18], sum(pattern_counts[v,2:18])), collapse = " & "))
# }


##### Reliance Calculation #####

#library(reshape2)

#Format transformation
mod_df_all_verbs_cat_strip <- as.data.frame(df_all_verbs_cat)


#false hits (hard filter, all "not of interest")
mod_df_all_verbs_cat_strip %>% mutate_if(is.logical, as.character) -> mod_df_all_verbs_cat_strip

false_hits <- filter(mod_df_all_verbs_cat_strip, not_of_interest == "TRUE" )
all_false <-table(false_hits$Verb)


#complete counts
all_counts <- table(df_all_verbs_cat$Verb)

#cleaned complete (no false hits)
real_counts <- all_counts - all_false


test_amb <- mod_df_all_verbs_cat_strip %>% group_by(Verb) %>% 
  filter(`non-psych`==F | 
           (`non-psych`==T & str_detect(Comment, "\\bpsych_ambiguous\\b")))


test_amb_exp <- filter(test_amb, pattern == "X-STM_V_Y-EXP")

test_amb_no_exp <- filter(test_amb, pattern == "X-STM_V")

counts_exp_psych <- table(test_amb_exp$Verb)

count_no_exp_psych <- table(test_amb_no_exp$Verb)
count_no_exp_psych

reliance_test_amb_exp <- round(counts_exp_psych*100/(real_counts), 2)

reliance_test_amb_no_exp <- round(count_no_exp_psych*100/(real_counts), 2)

#Figure 1

reliance_df <- data.frame(reliance_test_amb_exp)
reliance_noexp_df <- data.frame(reliance_test_amb_no_exp)

colnames(reliance_df) <- c("Verb", "Reliance_EXP")
colnames(reliance_noexp_df) <- c("Verb", "Reliance_no_EXP")

reliance_both <- cbind(reliance_df, reliance_noexp_df$Reliance_no_EXP)

glossed <- read.csv2("gloss_verbs.csv", fileEncoding = "utf-8")
verbs_glossed <- glossed[,1]

reliance_both$Verb <- verbs_glossed

colnames(reliance_both)[3] <- "intransitive"
colnames(reliance_both)[2] <- "transitive"


reliance_both_dfm <- melt(reliance_both[,c('Verb','transitive','intransitive')],id.vars = 1)

colnames(reliance_both_dfm)[3] <- "Reliance"

ggplot(reliance_both_dfm,aes(x = Verb,y = Reliance)) + 
  geom_bar(aes(fill = variable),stat = "identity",position = "dodge")+ scale_fill_manual("Patterns", values = c("transitive" = "black", "intransitive" = "grey")) + theme_bw() +
  theme(axis.text.x=element_text(size=11, angle=90, family = "serif", vjust = 0.2, hjust = 1)) + theme(
    legend.title = element_text(size = 8),
    legend.text = element_text(size = 5), legend.key.size = unit(2, "mm"))

