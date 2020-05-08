# Metagenomica
### Karen Jiménez, 2020
#### Introducción a la bioinformática e investigación reproducible para análisis genómicos

Dentro de este repositorio se encuentran los archivos solicitados para las  tareas 8.1 y 8.2. Dentro de la carpeta **bin** se encuentra un script de bash, un Rmarkdown y un html con los códigos utilizados para realizar el análisis de datos. En la carpeta **data** se encuentra el archivo `.biom` que se obtuvo como resultado final del análisis en bash con el filtro de 200 bp. 

##### Breve explicación de los resultados obtenidos en bash

Realizando la identificación de OTU's de hongos utilizando AMPtk con la eliminación de secuencias menores a 200 y 300 bp se encontraron resultados diferentes. Utilizando el filtro de 200 bp, se identificaron un total de 1569 OTU's. En el caso de filtro por 300 bp, se encontaron 559 OTU's.

Considero que utilizar el filtro de 300 bp es mejor por que obtenemos un menor número de OTU's en comparación con el de 200. Uno debe analizar si desea tener menos información pero de mayor veracidad a tener más información pero poco confiable. En este caso, utilizar el filtro de 300 bp podrá darnos menor número de OTU's pero con secuencias de mayor tamaño y con mayor veracidad identificarlas taxonómicamente.

##### Breve explicación de los resultados obtenidos en R 

Respecto a los resultados del cálculo de la diversidad alfa, en la figura 1 podemos observar una gran abundancia, tanto por tratamiento como por hospedero, de los grupos de Ascomycota y Basidiomycota. Observamos un patrón diferencial, donde para *Juniperus* existe una mayor abundancia de OTU's en bosques nativos que en mixtos. Al contrario, para *Querqus* se observa que en los boques mixtos hay una mayor abundancia de OTU´s que para bosques nativos. Sin embargo, al calcular un anova de dos vias de la abundacia observada en relación con el hospedero y el tratamiento, se encontraron valores no significativos para ambos y para su interacción (0.221,0.797, 0.262, respectivamente). 

En el caso de la diversidad beta, los resultados del NMDS señalaron un nivel de estres menor a 0.15 y se encontró una solución, por lo que se espera que haya una asociación entre las muestras unas con las otras dependiendo del grupo de OTU's que comparten. En la figura 2, podemos observar que las muestras en bosque nativo se agrupan por el tipo de hospedero, contrario a lo que se observa en bosque mixto. En bosque nativo no se observa una clara separación entre las muestras de diferentes hospederos. Finalmente, al realizar el test de adonis, observamos que cuando incluímos en el análisis ambos factores podemos encontrar efectos significativos para ambos y cercanamente significativos para su interacción. 

En conclusión, para el caso de la diversidad alfa visualmente se ve un patrón a la hora de graficar, pero al realizar el anova nos muestra que no hay efectos significativo para ninguno de los factores. Al contrario, para la diversidad beta encontramos que tanto ambos factores como su interacción tienen un efecto en la abundancia de OTU's en las muestras. 
