#Primera opcion
#Se necesita la conversacion generada por una cuenta en particular y un tweet en particular
#conversacion generada = RT del tweet, Comentarios del Tweet
#Segunda opcion
#Descargar los comentarios que provienen de un tweet en especifico

library(readr)
library(stringr)
library(dplyr)
library(sqldf)
library(RSQLite)

carpeta <- "/Users/alfonsoopazo/Desktop/Observatorio/SeguimientoConversacion"
base <- paste(carpeta,"Bases",sep = "/")
carpeta_cuenta <- paste(carpeta, "Cuenta", sep = "/")

#Nombre Cuenta
archivo_cuenta <-dir(carpeta_cuenta)
archivo_cuenta <-as.data.frame(archivo_cuenta)

#Nombre Base
nombre_archivo <- dir(base)
nombre_archivo <- as.data.frame(nombre_archivo)

if(dir.exists(paste(carpeta, "Resultados",sep = "/"))){
  
}else{
  dir.create(paste(carpeta,"Resultados", sep ="/"))
}

archivo <-paste(base,toString(nombre_archivo$nombre_archivo),sep = "/") 
cuenta <-paste(carpeta_cuenta,toString(archivo_cuenta$archivo_cuenta),sep = "/")

id_tweet <- "x1239331001836408832"

try(aux <-read.csv(archivo, header = TRUE,sep = ",",encoding = "UTF-8"), silent = TRUE)
try(usuario <-read.csv(cuenta,header = TRUE,sep = ",",encoding = "UTF-8"), silent = TRUE)

consulta <- sqldf(paste0(paste("SELECT screen_name Cuenta_origen, text Tweet_Analizado,retweet_count Cantidad_Retweet,
                  favorite_count Cantidad_Megustas,is_retweet
                  FROM aux
                  WHERE is_retweet = 0 AND
                  screen_name =",usuario$cuenta,sep="'"),"'","AND status_id ='x1239331001836408832'"))

consulta1 <- sqldf("SELECT reply_to_status_id ID_Tweet, quoted_status_id 'Id citado', screen_name Cuenta_Responde, text Respuesta
                   FROM aux 
                   WHERE reply_to_status_id = 'x1239331001836408832'
                   OR quoted_status_id = 'x1239331001836408832'")

consultaFinal <- sqldf("SELECT * FROM consulta,consulta1")

write.csv(consultaFinal, file = paste(carpeta,"Resultados",paste("Seguimiento",usuario$cuenta,"conversacion.csv",sep = "_"),sep = "/"), row.names = TRUE)

