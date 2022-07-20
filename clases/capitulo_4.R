# cargar data set de doxorubicina
dim(dox)

table(pData(dox)[,c("genotype", "treatment")])
