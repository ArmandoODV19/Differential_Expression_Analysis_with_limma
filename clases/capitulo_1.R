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

dim(eset)
# tenemos un expression object de 12625 caracteristicas y
# 22 muestras

# se puede extraer cada elemento de la matriz de forma inversa

# extraer matriz de expresion
x <- exprs(eset)

# data de caracteristicas
f <- fData(eset)

# phenotype data
p <- pData(eset)

# del expresion set object se puede extraer un elemento en especifico
# extraer el objeto 1000 y las primeras 10 columnas
eset_sub <- eset[1000, 1:10]

# de esta forma se puede graficar este gen en un boxplot
boxplot(exprs(eset)[1000,]~pData(eset)[,"Disease"],
        main = fData(eset)[1000,"symbol"])

### instalando la paqueteria limma

BiocManager::install("limma")

library(limma)

# limma utiliza un modelo lineal para evaluar la expresion diferencial
# a partir de la funcion model.matrix()
model.matrix(~<explanatory>, data = <dataframe>)

design <- model.matrix(~Disease, data = pData(eset))

# cada columna de la matriz design corresponde a un
# coeficiente en el modelo lineal

head(design)

# para saber si los datos concuerdan se utiliza la funcion colsums()
# para la matriz y table para pData. La segunda columna de ambos df
# debe coincidir

colSums(design)

table(pData(eset)[,"Disease"])

# se ajustan los coeficientes al modelo con lmFit()

fit <- lmFit(eset, design)

# calcula tstatistics con la funcion eBayes()

fit <- eBayes(fit)

# cuenta el numero de genes con expresion diferencial entre los grupos

results <- decideTests(fit[,"Diseasestable"])
summary(results)
