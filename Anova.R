### Import
data <- read.table("activableR19.csv", header = TRUE, sep = ",")
dim(data)
names(data)
table(data$variete)


### Variables
rdt <- data$rendement
fac <- as.factor(data$variete)


### Description
tapply(rdt,fac,mean)
tapply(rdt,fac,var)


### Graphique
boxplot(rdt~fac, ylab="rendement en qx/ha")
stripchart(rdt~fac, pch=16, vertical = TRUE)


### Démontrer les 3 hypothèse 

#indépendance
lm1 <- lm(rdt~fac)
par(mfrow=c(2,2))
plot(lm1)

#Normalité
shapiro.test(lm1$residuals) 

#homoscédasticité
bartlett.test(rdt~fac) 


### Table d'ANOVA
anova(lm(rdt~fac))

### Comparaison multiple de moyennes
TuckeyHSD(aov(rdt~fac))
plot(TukeyHSD(aov(rdt~fac)))