# cargar data set de doxorubicina
dim(dox)

table(pData(dox)[,c("genotype", "treatment")])

# procesando datos
plotDensities(dox,
              group = pData(dox)[, "genotype"],
              legend = "topright")

