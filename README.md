# Metagenomica
### Karen Jiménez, 2020
#### Introducción a la bioinformática e investigación reproducible para análisis genómicos

Dentro de este repositorio se encuentran los archivos solicitados para tarea 8.1. Dentro de la carpeta **bin** se encuentra el script de bash con el que se realizó el análisis de los datos. En la carpeta **data** se encuentra el archivo `.biom` que se obtuvo como resultado final del análisis. 

##### Breve explicación de los resultados obtenidos

Realizando la identificación de OTU's de hongos utilizando AMPtk con la eliminación de secuencias menores a 200 y 300 bp se encontraron resultados diferentes. Utilizando el filtro de 200 bp, se identificaron un total de 1569 OTU's. En el caso de filtro por 300 bp, se encontaron 559 OTU's.

Considero que utilizar el filtro de 300 bp es mejor por que obtenemos un menor número de OTU's en comparación con el de 200. Uno debe analizar si desea tener menos información pero de mayor veracidad a tener más información pero poco confiable. En este caso, utilizar el filtro de 300 bp podrá darnos menor número de OTU's pero con secuencias de mayor tamaño y con mayor veracidad identificarlas taxonómicamente.
