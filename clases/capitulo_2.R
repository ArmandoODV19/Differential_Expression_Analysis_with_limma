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

fit2 <- contrasts.fit(fit, contrasts = cm)
