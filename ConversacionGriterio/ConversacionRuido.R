#install.packages("sqldf")
#Librerias
#install.packages("readr")
#install.packages("tidyverse")

library(readr)
library(stringr)
library(sqldf)
library(RSQLite)


Sys.setlocale(category = "LC_CTYPE", locale = "C")

patref <-"@[A-Za-z0-9]*[^\\s:_.<]"
patHashtag<-"#[A-Za-z0-9áéíóú]*"

carpeta <- "/Users/alfonsoopazo/Desktop/Observatorio/ConversacionGriterio"
carpeta_bases <- paste(carpeta, "Bases", sep="/")
carpeta_cuentas <- paste(carpeta,"Cuenta",sep ="/")

#--- Archivocon la base ---#
nombres <- dir(carpeta_bases)
nombres <- as.data.frame(nombres)

#--- Archivo Cuentas ---#
cuentas <- dir(carpeta_cuentas)
cuentas <- as.data.frame(cuentas)

if(dir.exists(paste(carpeta,"Resultados",sep = "/")))
{}else{dir.create(paste(carpeta,"Resultados",sep = "/"))}

x = 1
ciclo = nrow(nombres)
n_cuentas = nrow(cuentas)

while(x <= ciclo)
{
  nombre <- substr(toString(nombres$nombres[x]),1,(str_length(nombres$nombres[x])-4)) 
  nombre_carpeta <- paste(carpeta,"Resultados",sep = "/")
  archivo_temporal <- paste(carpeta_bases,toString(nombres$nombres[x]),sep="/")
  archivo_temporal_cuentas <-paste(carpeta_cuentas,toString(cuentas$cuentas[x]), sep="/") 
  
  aux <- read.csv(archivo_temporal,header = TRUE,sep =",", encoding = "UTF-7")
  auxCuentas <- read.csv(archivo_temporal_cuentas, header = TRUE, sep =",",encoding = "UTF-7")
  
  aux <- as.data.frame(aux)
  auxCuentas <-as.data.frame(auxCuentas)
  consulta <-read.csv(archivo_temporal,header = TRUE,sep = ",",encoding = "UTF-7")
  
  #--- Arreglo de los tildes ---#
  consulta$text=gsub("<f1>","ñ",consulta$text)#ñ
  consulta$text=gsub("<e1>","á",consulta$text)#a
  consulta$text=gsub("<c1>","Á",consulta$text)#A
  consulta$text=gsub("<e9>","é",consulta$text)#e
  consulta$text=gsub("<c9>","É",consulta$text)#E
  consulta$text=gsub("<ed>","í",consulta$text)#i
  consulta$text=gsub("<cd>","Í",consulta$text)#I
  consulta$text=gsub("<f3>","ó",consulta$text)#o
  consulta$text=gsub("<d3>","Ó",consulta$text)#O
  consulta$text=gsub("<fa>","ú",consulta$text)#u
  consulta$text=gsub("<da>","Ú",consulta$text)#U
  consulta$text=gsub("<40>","@",consulta$text)#@
  
  nombre_cuenta <- toString(auxCuentas$X...cuenta)
  nombre_final <- paste0("Cuenta_",nombre_cuenta,".csv")
  
  #--- Total de filas de la  base---#
  total_filas <- sqldf('SELECT COUNT(user_id) total FROM aux')
    
  #--- menciones ---#
  menciones <-unlist(regmatches(aux$text,gregexpr(patref,aux$text)))
  menciones <- str_replace_all(menciones,'@','')
  menciones <-as.data.frame(menciones)
  
  #--- Conversacion ---#
  #Usuario x menciona en un tweet a una de las cuentas analizadas
  # El is_retweet debe ser False, por que sino, considera todas las menciones, mas la cuenta retweetteada.
  interaccion <- paste0('SELECT menciones Cuenta ,count(menciones) Cantidad 
                  FROM menciones
                  WHERE menciones ="',nombre,'"',
                  'OR menciones="',nombre,' ','"',
                  'OR menciones="',' ',nombre,'"',
                  'OR menciones="',toString(auxCuentas$X...cuenta),'"',
                  'OR menciones="',toString(auxCuentas$X...cuenta),' ','"',
                  'OR menciones="',' ',toString(auxCuentas$X...cuenta),'"',
                  'ORDER BY Cantidad
                  DESC')
  
  #print(toString(nombre))

  interaccion <- sqldf(interaccion)
  cantidadInteracciones <-interaccion$Cantidad
  cantidadGriterio <- (total_filas-cantidadInteracciones)
  porcentajeGriterio <-round((cantidadGriterio/total_filas)*100,2)
  porcentajeInteracciones <- round((cantidadInteracciones/total_filas)*100,2)

  #--- Tabla de porcentajes ---#
  
  tabla <- matrix(c(toString(auxCuentas[x,]),
                    cantidadInteracciones,
                    cantidadGriterio,
                    total_filas,
                    porcentajeInteracciones,
                    porcentajeGriterio),ncol=6)
  
  colnames(tabla) <- c("Cuenta",
                       "Cantidad_interaccion",
                       "Cantidad_griterio",
                       "Total_datos",
                       "%_Interacciones",
                       "%_Griterio")
  
    # --- ----------------------------- --- #
  write.csv(tabla, file = paste(nombre_carpeta,nombre_final,sep = "/"),row.names=FALSE)
  print(nombre_cuenta)
  
  x = x+1
}

