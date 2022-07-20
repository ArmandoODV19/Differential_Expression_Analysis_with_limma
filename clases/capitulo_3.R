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
