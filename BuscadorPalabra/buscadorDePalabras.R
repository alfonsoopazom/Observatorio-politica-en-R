#update.packages()
#updateR()
#install.packages("RCurl")

library(RCurl)
library(readr)
library(dplyr)#manejo de ficheros
library(purrr)
library(tidyr)
library(stringr)
library(lubridate)
library(scales)
library(tidytext)
library(rtweet)
library(tm)
library(curl)
library(httr)

httr::set_config(config(ssl_verifypeer = 0L, ssl_verifyhost = 0L))

create_token ( 
  app = "Observatorio Mexico", 
  consumer_key = "ovn8zJvcJogJ9LciSavnkxpvI",
  consumer_secret = "LHDrm3YVbognzJUCKgraZG0KfOBEiCRaoX9N65owqQF19TOogE", 
  access_token = "168972283-FIXwotWeURiXXINabu0PTgwDKuGkdpFM2RqstUhx", 
  access_secret = "ETgGSDvfyS4mpsb3odpFpEHgcPWoHduJSIMOfDH5Dglwl" 
)

carpeta <- "/Users/alfonsoopazo/Desktop/Observatorio/BuscadorPalabra"
query <- "/Users/alfonsoopazo/Desktop/Observatorio/BuscadorPalabra/Cuenta/queries170.csv"
datos<- read.csv( query,header = TRUE,sep =";",encoding = "UTF-8")

if(dir.exists(paste(carpeta,"Resultados",sep = "/"))){
  
}else
{
  dir.create(paste(carpeta,"Resultados",sep = "/"))
}


for(i in 1 :as.numeric(length(datos[,1])))
{
  
  Busqueda<-toString(datos$Query[i])
  tweets <- search_tweets( Busqueda, n =1000000,since="2020-03-13", until="2020-03-15", retryonratelimit = TRUE)
  tweets<-as.data.frame(tweets)
  largo<-length(tweets[1,])
  
  if(largo>0)
  {  
    for(j in 1:length(tweets[1,]))
    {
      tweets[,j]<-as.character(tweets[,j])
      print(tweets[,j]<-as.character(tweets[,j]))
    }
    
    carpeta_descarga<-paste(carpeta,toString(datos$Carpeta[i]),sep="/")
    
    if(file.exists(carpeta_descarga))
    {}else
    {dir.create(carpeta_descarga)}
    
    archivo<-paste(carpeta_descarga,".csv",sep=paste0("/",toString(datos$Nombre_Archivo[i])))
    
    if(file.exists(archivo))
    {
      print(c("query", i))
      lista <-read.csv(archivo, header = TRUE, sep = ",")
      tweets<-rbind(tweets,lista)
    }
    
    write.csv(tweets, file =archivo,row.names=FALSE)
  }
}
print(Busqueda)

