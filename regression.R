library(MASS)

#Import data and set up dataframe
phen <- read.table("phenotypes.txt", header = FALSE)
colnames(phen)[1] <- "FID"
colnames(phen)[2] <- "IID"
disc_cov <- read.table("discrete_covariates.txt", header = FALSE)
colnames(disc_cov)[1] <- "FID"
colnames(disc_cov)[2] <- "IID"
disc_cov <- disc_cov[ , colSums(is.na(disc_cov)) == 0]
cont_cov <- read.table("continuous_covariates.txt", header = FALSE)
colnames(cont_cov)[1] <- "FID"
colnames(cont_cov)[2] <- "IID"
df <- merge(phen, disc_cov, by = c("IID", "FID"))
df <- merge(df, cont_cov, by = c("IID", "FID"))
colnames(df)[3] <- "Phen"
df <- df[,3:length(colnames(df))]

#Linear model and stepwise regression
full.model <- lm(Phen ~., data = df)
step.model <- stepAIC(full.model, direction = "both", trace = FALSE)

#Remove insignificant covariats
cov <- step.model$model
for(i in colnames(disc_cov)[3:length(colnames(disc_cov))]){disc_cov <- cov[,colnames(disc_cov) == i]}
for(i in colnames(cont_cov)[3:length(colnames(cont_cov))]){cont_cov <- cov[,colnames(cont_cov) == i]}

#Write covariat table
write.table(disc_cov, file = "disc_cov.txt", sep = "\t")
write.table(cont_cov, file = "cont_cov.txt", sep = "\t")

