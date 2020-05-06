#!/bin/bash
#Uso de AMPtk con datos de ITS2 (hongos) generados por Illumina MiSeq
#Karen Jiménez, 2020 

#Este script de bash busca utilizar herramientas de AMPtk para procesar datos de 
#metagenómica con ITS2 de hongos generados por secuenciación por Illumina MiSeq

#Paso preeliminar: Conectarse al clústed de CONABIO
#Para realizar este flujo de trabajo, es necesario estar conectado al clúster de 
#CONABIO. A continuación se presenta el comando y contraseña para ingresar al 
#cluster de ser necesario. El resto del script se correrá considerando que ya se
#ingresado a este cluster.

#ssh -p 45789 cirio@200.12.166.164
#pw: 6MsG9ze8auB4BZRwmPQie

#Contexto 
#Los datos a utilizar se encuentra en el directorio fastq, dentro del directorio 
#metagenomica (metagenomica/fastq). 

#Los datos a analizar son 24 muestras de suelo rizosférico recolectados en 
#sitios de bosque nativo (N) y mixto (M) de Quercus (Q) y de Juniperus (J).
#Para cada muestra tenemos un archivo fastq con las secuencias forward (R1) y 
#otro con las secuencias reverse (R2).

#Comandos a utilizar 

#Es necesario realizar el análisis dentro de un directorio personal para no
#interferir con los análisis de las demás personas utilizando el cluster. Para 
#esto es necesario crear un directorio (mkdir tu_nombre) y moverse a él
#(cd tu_nombre). En este caso, trabajaremos en el directorio ya creado "KJimenez".
#En dado caso de ubicarnos en el home del cluster, es necesario usar el comando 
#"cd KJimenez" para comenzar el análisis. Sin embargo, este script se correrá 
#considerando que ya estamos en el directorio "KJimenez"  

#1. Preprocesamiento de archivos fastq 
#Se ensamblará los reads forward y reverse, además de eliminar los primers y 
#secuencias cortas. Se buscará que las lecturas tengan un mínimo de 200 bp para 
#que se conserve la secuencia. 

#Se presenta además del comando, una pequeña explicación de que significa cada 
#uno de los flags utiliados. 

amptk illumina -i ../metagenomica/fastq -o amptk/ -f GTGARTCATCRARTYTTTG -r CCTSCSCTTANTDATATGC -l 300 --min_len 200 --full_length --cleanup

#-i, directorio donde se ubican los archivos fastq a utilizar 

#-o, Nombre del archivo de salida 

#-f, secuencia del primer forward, en este caso es: gITS7ngs

#-r, secuencia del primer reverse, en este caso es: ITS4ngsUni

#-l, longitud de las lecturas, en este caso: 300 bp

#--min_len, largo mínimo para conservar una lectura, en este caso: 200 bp 

#--full_length, conservar únicamente lecturas completas

#--cleanup, eliminación de archivos intermediarios  

#2. Agrupamiento con 97% de similitud utilizando UPARSE
#Se realiza un filtro de calidad, incluyendo las secuencias quiméricas, y se 
#agrupan las secuencias en OTUs

amptk cluster -i amptk.demux.fq.gz -o cluster -m 2 --uchime_ref ITS

#-i, Directorio donde se ubican las secuencias alineadas a utilizar 

#-o, Nombre del archivo de salida

#-m, Número mínimo de lecturas para que una OTU validad sea retenida (filtro singleton) 

#--uchime_ref, Filtrado de quimeras, en este caso: ITS

#3. Filtrado de tabla de OTUs, evitando "index bleed"
#El término "index bleed" se refiere cuando existen reads asignados a la muestra 
#incorrecta durante el proceso de secuenciación de Illumina. Es un fenómeno 
#frecuente, además con un grado variable entre varios corridas. Para minimizar 
#este fenómeno, se puede usar un control positivo (mock) artificial para medir 
#el grado de index bleed dentro de una corrida. Si la corrida no incluye un mock 
#artificial, este umbral se puede definir manualmente (en general se usa 0,005%).

amptk filter -i cluster.otu_table.txt -o filter -f cluster.cluster.otus.fa -p 0.005 --min_reads_otu 2

#-i, Tabla de OTU a analizar

#-o, Nombre de archivo de salida 

#-f, Archivo fasta con secuencias referencia para cada OTU

#-p, % porcentaje umbral de index bleed entre muestras 

#--min_reads_otu, número mínimo de lecturas para que una OTU valida sea retenida 
#(filtro singleton)

#4. Asignación taxonómica a cada OTU
#AMPtk utiliza la base de datos de secuencias de [UNITE] (https://unite.ut.ee/) 
#para asignar la taxonomía de los OTUs. Dado que es una base de datos curada, en 
#general da resultados mucho mejores que GenBank.

amptk taxonomy -i filter.final.txt -o taxonomy -f filter.filtered.otus.fa -m ../metagenomica/amptk.mapping_file.txt -d ITS2 --tax_filter Fungi

#-i, Tabla de OTUs a analizar 

#-o, Nombre de archivo de salida 

#-f, archivo fasta con secuencias referencia para cada OTU 

#-m, archivo mapeado con meta- datos asociados de las muestras 

#-d, base de datos preinstalada [ITS1, ITS2, ITS, 16S LSU, COI]

#--tax_filter, eliminación de las OTUs que no pasen el filtro. En este caso, Fungi 
#solo conservará las OTUs pertenecientes a hongos 

#Ahora tenemos una tabla de OTU en formato .biom que puedes cargar en R para 
#hacer análisis de diversidad. Esta tabla contiene la tabla de OTUs con su 
#frecuencia por muestra, su taxonomía, y los meta-datos asociados a cada muestra.

