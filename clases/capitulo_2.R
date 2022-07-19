# para realizar un modelo sin intercepcion
# para hacer un modelo sin intercepcion se agrega
# un cero como primer argumento del modelo

design <- model.matrix(~0 + Disease, data = pData(eset))
head(design)
colSums(design)

# para cear un contraste para hipotesis especificas, limma provve
# la funcion makeContrasts. Se puede realizar cualquier
# contraste refiriendo especificamente los nombres de la columna de
# la matriz design

cm <- makeContrasts(status = Diseaseprogres. - Diseasestable,
                    levels = design)


cm

# a continuacion se utiliza la funcion contrasts.fit() en el
# resultado del ajuste del modelo

fit <- lmFit(eset, design)
head(fit$coefficients, 3)

fit2 <- contrasts.fit(fit, contrasts = cm)
head(fit2$coefficients, 3)

# se calcula t-statistics con la funcion eBayes()

fit2 <- eBayes(fit2)

# se cuenta el numero de genes expresados diferencialmente
results <- decideTests(fit2)
summary(results)


### modelando estudios con mas de dos grupos

BiocManager::install("leukemiasEset")
library(leukemiasEset)

# para este jerccio se utilizara el data set de leukemiaeset
# ya que contiene tres grupos ALL, AML, CML

data("leukemiasEset")

dim(leukemiasEset)

# se coloca el nombre de la columna de leukemiasEset en phenoData
# para obtner el tipo de leucemias que se han descrito en el dataset
table(pData(leukemiasEset)[,"LeukemiaType"])

# para examinar cada grupo se realiza una formula que
# incluye 0 para remover la intercepcion y el nombre de la columna
# que contiene el nombre de las muestras

design <- model.matrix(~0 + LeukemiaType, # nombre columna
                       data = pData(leukemiasEset)) # data set

head(design, 3)

colSums(design)

# make contrast

cm <- makeContrasts(AMLvALL = LeukemiaTypeAML - LeukemiaTypeALL,
                    CMLvALL= LeukemiaTypeCML - LeukemiaTypeALL,
                    CMLvAML= LeukemiaTypeCML - LeukemiaTypeAML,
                    CLLvALL = LeukemiaTypeCLL - LeukemiaTypeALL,
                    NOLvALL = LeukemiaTypeNoL - LeukemiaTypeALL,
                    levels = design)
cm

# con design y contrast se puede correr the lima pipeline

fit <- lmFit(leukemiasEset, design)

fit2 <- contrasts.fit(fit, contrasts = cm)

fit2 <- eBayes(fit2)

results <- decideTests(fit2)
summary(results)

## factorial experiment design

# a balanced factorial design includes samples that experience each
# each combination of experimental variables

