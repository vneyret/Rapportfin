library("agricolae")

### Import
donnes <- read.table("activableR19.csv", header = TRUE, sep = ",")
dim(donnes)
names(donnes)
table(donnes$variete)




### Variables
rdt <- donnes$rendement
fac <- as.factor(donnes$variete)




### Description

moyennes <- tapply(rdt,fac,mean) # afficher
variances <- tapply(rdt,fac,var) # afficher
plot <- boxplot(rdt~fac, ylab="rendement en qx/ha") # afficher

### Démontrer les 3 hypothèse 

#indépendance
lm1 <- lm(rdt~fac)
par(mfrow=c(2,2))
plotsindep <- plot(lm1) ## (Demande à l'utilisateur + Affiche) Ok si  : 

#- Residual, Scale-Location et Constante Leverage : points éparpillés,
#- Normal Q_Q : points sur la ligne, 

#Normalité
shapiro.test(lm1$residuals) ## (Affiche) Ok si P-Value > 0,05.

#homoscédasticité
bartlett.test(rdt~fac) ## (Affiche) OK si P-Value > 0,05.



#Si les 3 conditions d'hypothèse ne sont pas validées, on ne peut pas faire d'ANOVA, demander si il veut quand même la faire.





### Table d'ANOVA

anova(lm(rdt~fac)) ## Afficher 

# Si P-Value > 0,05, alors on conserve l'hypothèse H0, on n'a pas pu mettre en évidence l'effet du facteur testé.
# Si P-Value < 0,05 alors on rejete H0, on a pu mettre en évidence un effet du facteur testé.


### Comparaison multiple de moyennes

# Si P-Value <0,05, alors on fait le teste de Tuckey, si non demander si veut le faire quand même.
TukeyHSD(aov(rdt~fac))
plot(TukeyHSD(aov(rdt~fac)))

# Si P-Value <0,05, alors on fait le teste de Newman-Keuls, si non demander si veut le faire quand même.


model<-aov(rendement~variete,data = donnes)
out <- SNK.test(model,"variete", console=TRUE, 
                main="patata")
print(SNK.test(model,"variete", group=FALSE))

## Sort le tableau avec les variétés et les lettres de groupe en face
