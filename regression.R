library(MASS)

#Import data and set up dataframe
phen <- read.table("phenotypes.txt", header = FALSE)
names <- c()
for(i in colnames(phen)[3:length(phen)]){names <- c(names, paste(i, "p", sep = "_"))}
names <- c("FID", "IID", names)
colnames(phen) <- names
disc_cov <- read.table("discrete_covariates.txt", header = FALSE)
disc_cov <- disc_cov[ , colSums(is.na(disc_cov)) == 0]
names <- c()
for(i in colnames(disc_cov)[3:length(disc_cov)]){names <- c(names, paste(i, "d", sep = "_"))}
names <- c("FID", "IID", names)
colnames(disc_cov) <- names
cont_cov <- read.table("continuous_covariates.txt", header = FALSE)
names <- c()
for(i in colnames(cont_cov)[3:length(cont_cov)]){names <- c(names, paste(i, "c", sep = "_"))}
names <- c("FID", "IID", names)
colnames(cont_cov) <- names
df <- merge(phen, disc_cov, by = c("IID", "FID"))
df <- merge(df, cont_cov, by = c("IID", "FID"))
colnames(df)[3] <- "Phen"
df <- df[,3:length(colnames(df))]

#Linear model and stepwise regression
full.model <- lm(Phen ~., data = df)
step.model <- stepAIC(full.model, direction = "both", trace = FALSE)

#Remove insignificant covariats
cov <- step.model$model
keep <- c("FID", "IID")
for(i in colnames(disc_cov)){if(i %in% colnames(cov)){keep <- c(keep, i)}}
disc_cov <- disc_cov[, keep]
keep <- c("FID", "IID")
for(i in colnames(cont_cov)){if(i %in% colnames(cov)){keep <- c(keep, i)}}
cont_cov <- cont_cov[, keep]

#Write covariat table
write.table(disc_cov, file = "disc_cov.txt", col.names = FALSE, row.names = FALSE, sep = "\t")
write.table(cont_cov, file = "cont_cov.txt", col.names = FALSE, row.names = FALSE, sep = "\t")



