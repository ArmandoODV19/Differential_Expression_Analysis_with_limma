# cargar data set de doxorubicina
dim(dox)

table(pData(dox)[,c("genotype", "treatment")])

# procesando datos
plotDensities(dox,
              group = pData(dox)[, "genotype"],
              legend = "topright")

x <- dox@assayData[["exprs"]]
p <- dox@phenoData@data
f <- dox@featureData@data

# para saber si hay sobre expresion
boxplot(x["A_51_P227777",]~p[,"genotype"],
        main = f["A_51_P227777", "symbol"])
