library(dplyr)
library(sqldf)


carpeta<-"C:/Users/interbarometro/Desktop/ProgramasR/Muestra"
carpeta_Bases<-paste(carpeta,"Bases",sep="/")
nombres<-dir(carpeta_Bases)
nombres<-as.data.frame(nombres)


if(dir.exists(paste(carpeta, "Resultados", sep = "/")))
{}else
{
  dir.create(paste(carpeta, "Resultados", sep = "/"))    
}

for(i in 1:length(nombres[,1])){
  
  archivo_temporal<-paste(carpeta_Bases,toString(nombres$nombres[i]),sep="/")
  consulta <- read.csv(archivo_temporal,header = TRUE,sep = ",",encoding = "UTF-8")
  respuesta <- sqldf('select "screen_name","user_id","status_id","text", "retweet_text","is_retweet"  from 	consulta ')
  
  if(length(respuesta[,1])>=1000)
  {
    respuesta <- respuesta[1:1000,]
    archivo_final<-"C:/Users/interbarometro/Desktop/ProgramasR/Muestra/Resultados"
    write.csv(respuesta,file = paste(archivo_final,nombres$nombres[i],sep = "/"),row.names = FALSE)
    
  }else{
    respuesta <- respuesta[1:length(respuesta[,1]),]
    archivo_final<-"C:/Users/interbarometro/Desktop/ProgramasR/Muestra/Resultados"
    write.csv(respuesta,file = paste(archivo_final,nombres$nombres[i],sep = "/"),row.names = FALSE)
  }
}
