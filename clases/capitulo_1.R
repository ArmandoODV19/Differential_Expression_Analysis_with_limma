# en los ejercicios se utilizará información del dataset
# leukemia

leukemia <- readRDS("data/leukemia.rds")
str(leukemia)
isS4(leukemia)

# en este curso se enfocará en 3 principales data sets
# 1. matriz de expresion (x)
# 2. data de características. la cual describe la medida de
# cada característica, por lo general genes o proteínas (f)
# 3. data del fenotipo. describe cada muestra en ele studio (p)

# las filas de la matriz de expresion son cada una de las caracteristicas
# y cada columna es una de la muestras

class(x)
dim(x)

# en la matriz de caracteristicas cada fila es una caracteristica
# el numero de filas es igual al numero de filas en la matriz de
# de expresion. Las columnas corresponden al simbolo del gen
# el numero de identificacion en la base de datos y la localizacion en
# el cromosoma (el nombre de las columnas puede variar)


# la matriz del fenotipo es un df de una fila por muestra. el
# numero de filas es igual al numero de columnas en la matriz de expresion
# las columnas describe otros atributos con id, edad o si pertenece
# a tener o no la enfermedad


# para familiarizarse con el data set se realizara un boxplot
# por cada gen. La funcion boxplot() acepta una formula como
# primer argumento

boxplot(<y-axis> ~ <x-axis>, main ="<tittle>")

# para hacer un boxplot por gen se utiliza gene expression y phenotype
# en la formula

boxplot(<gene expression> ~ <phenotype>, main ="<tittle>")

# ejemplo de como graficar el primer gen de un data set
# se selecciona la primer columna de la matriz de expresion
# se selecciona la columna "er" de la matriz de fenotipo

boxplot(x[1,]~p[,"er"], main = f[1, "symbol"])

# extrayendo las matrices del objeto leukemia

x <- leukemia@assayData[["exprs"]]
p <- leukemia@phenoData@data
f <- leukemia@featureData@data

# haciendo el boxplot del primer gen

boxplot(x[1,]~p[,"Disease"], main = f[1, "symbol"])

# checando el segundo gen
boxplot(x[2,]~p[,"Disease"], main = f[2, "symbol"])


# object oriented programming
# para esto se necesita la paqueteria Biobase

BiocManager::install("Biobase")

# generando un ExpresionSet object

library(Biobase)

eset <- ExpressionSet(assayData = x,
                      phenoData = AnnotatedDataFrame(p),
                      featureData = AnnotatedDataFrame(f))
