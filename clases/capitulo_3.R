# normalizacion

#pre procesamiento
# 1. log transformation
# 2. quantile normalize
# 3. filter

# inicia con la visualizacion con la distribucion de la
# expresion genica de las muestras
# esto se hace con la funcion plotDensities()
# el primer argumento es el ExpressionSet object

plotDensities(eset, legend = FALSE)

# legend = TRUE genera una leyenda con el nombre y color de cada muestra
plotDensities(eset, legend = TRUE)

plotDensities(leukemiasEset, legend = FALSE)

# Para mejor visualizacion se puede realizar una transformacion
# logaritmica de los datos, incrementando la distancia entre
# pequeñas medidas

# para la transformacion se utiliza la funcion log() sobre
# la matriz de expresion exprs()

exprs(eset) <- log(exprs(eset))

plotDensities(eset, legend = FALSE)

# sin embargo, la distribucion es diferente entre muestras
# para eliminar los artefactos entre las tecnicas genomicas
# se realiza una normalizacion por cuantiles con la funcion
# normalizeBetweenArrays

exprs(eset) <- normalizeBetweenArrays(exprs(eset))

# esto convierte a cada muestra para tener la misma distribucion
# basado en cuantiles

plotDensities(eset, legend = FALSE)

# por ultimo, los genes con baja expresion crea un sesgo en el data
# se puede realizar un filtro para eliminar estos genes

plotDensities(eset, legend = FALSE)
abline(v = 1.5)

keep <- rowMeans(exprs(eset)) > 1.5
eset <- eset[keep,]
plotDensities(eset, legend = FALSE)

### batch effects

# estos son artefactos que se generan a partir del hecho de que cada
#lote en el experimento es levemente diferente
# para eliminarlos es critico balancear las variables de interes en cada
# lote

# para investigar batch effects se utiliza reduccion de dimensiones
# como PCA y multidimensional scaling
# con la funcion plotMDS() genera multidimensional scaling

plotMDS(eset, labels = pData(eset)[,"Disease"], # nombre de columna
        gene.selection = "common") # aqui va common o pairwise

# si las variables se separan por PC2 indica un batch effect

# para remover batches se utiliza la funcion
# removeBatchEffect()

exprs(eset) <- removeBatchEffect(eset,
                                 batch = pData(eset)[,"batch"],
                                 covariates = pData(eset)[,"rin"])

### visualizacion de resultados

# se visualizaran los resultados de leukemia (no leukemiaEset)
# del capitulo 2
# la funcion toTable() de limma regresará los
# genes con mayor expresion diferencial
# el valor p ajustado se realiza en base con Benjamini-hochberg
# false discovery rate FDR

topTable(fit2, number = 3)

# previo a la visualizacion se realiza un resumen estadistico
# para cada gen
stats <- topTable(fit2, number = nrow(fit2), sort.by = "none")
dim(stats)

# visualizacion con histograma de valores p

hist(stats[,"P.Value"])

# volcano plot
# se realiza con la funcion de limma volcanoplot()

volcanoplot(fit2,
            highlight = 5, # subrayar top 5 significant genes
            names = fit2$genes[,"symbol"])

