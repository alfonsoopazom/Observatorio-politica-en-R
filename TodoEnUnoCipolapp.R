
#install.packages("dplyr")

#install.packages("sqldf")
#Actalizacion de paquetes 
#update.packages()

library(readr)
library(dplyr)#manejo de ficheros
library(purrr)
library(tidyr)
library(stringr)
library(tidytext)
library(tm)
library(colorspace)
library(plotly)
library(sqldf)


carpeta = "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp"
carpeta_base = paste(carpeta,"Bases",sep="/")
nombres = dir(carpeta_base)
nombres = as.data.frame(nombres)

pat ="(RT|via)(((?:\\b\\W*|)@\\w+)+)|,|:|(https|http)://t.co/[A-Za-z\\d]+|&amp;|http\\w*|@\\w+|(\\w+\\.|)\\w+\\.\\w+(/\\w+)*"
patref ="@[A-Za-z0-9]*[^\\s:_.<]"
patHashtag="#[A-Za-z0-9????]*"

Sys.setenv("plotly_username"="observatorio2019")
Sys.setenv("plotly_api_key"="BObHnm3fSEoIg5SCk3a2")


if(dir.exists(paste(carpeta, "Resultados", sep = "/")))
{}else
{
  dir.create(paste(carpeta, "Resultados", sep = "/"))
  #ubicacion carpeta resultados
  ubicacion_resultados <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados"
  
  #If para crear los directorios dentro de la carpeta Resultados
  if((dir.exists(paste( ubicacion_resultados, "Evolucion", sep = "/")))
     &(dir.exists(paste( ubicacion_resultados, "Comunidad", sep = "/")))
     &(dir.exists(paste( ubicacion_resultados, "Efectos", sep = "/")))
     &(dir.exists(paste( ubicacion_resultados, "CaracteristicasTecnicas", sep = "/")))
     &(dir.exists(paste( ubicacion_resultados, "DeterminantesSemanticos", sep = "/")))
     &(dir.exists(paste( ubicacion_resultados, "ResultadosGenerales", sep = "/"))))
  {}else
  {
    dir.create(paste( ubicacion_resultados, "Evolucion", sep = "/"))
    dir.create(paste( ubicacion_resultados, "Comunidad", sep = "/"))
    dir.create(paste( ubicacion_resultados, "Efectos", sep = "/"))
    dir.create(paste( ubicacion_resultados, "CaracteristicasTecnicas", sep = "/"))
    dir.create(paste( ubicacion_resultados, "DeterminantesSemanticos", sep = "/"))
    dir.create(paste( ubicacion_resultados, "ResultadosGenerales", sep = "/"))
    
    #Variables con las rutas de las SubDirectorios
    ubicacion_evolucion <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/Evolucion"
    ubicacion_comunidad  <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/Comunidad"
    ubicacion_efectos <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/Efectos"
    ubicacion_CaracTecnicas <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/CaracteristicasTecnicas"
    ubicacion_determinantes <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/DeterminantesSemanticos"
    #Carpeta donde se guardaran las copias de los archivos
    ubicacion_ResultadosGenerales <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/ResultadosGenerales"
    
    #if de las carpetas EVOLUCION Y SENTIDO
    if((dir.exists(paste( ubicacion_evolucion, "Histograma", sep = "/")))
       & (dir.exists(paste( ubicacion_evolucion, "Grafico Torta", sep = "/"))))
    {}else
    {
      dir.create(paste( ubicacion_evolucion, "Histograma", sep = "/"))
      ubicacion_histograma <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/Evolucion/Histograma"
    }
    
    # if de las carpetas DETERMINANTES SEMANTICOS
    if((dir.exists(paste( ubicacion_determinantes, "Nube", sep = "/")))
       & (dir.exists(paste( ubicacion_determinantes, "Bigrama", sep = "/"))))
    {}else
    {
      dir.create(paste( ubicacion_determinantes, "Nube", sep = "/"))
      dir.create(paste( ubicacion_determinantes, "Bigrama", sep = "/"))
      
      ubicacion_nube <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/DeterminantesSemanticos/Nube"
      ubicacion_bigrama <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/DeterminantesSemanticos/Bigrama"
      
    }
    # if de las carpetas COMUNIDADES 
    if((dir.exists(paste(  ubicacion_comunidad, "Referentes", sep = "/")))
       & (dir.exists(paste(  ubicacion_comunidad, "Influenciadores", sep = "/")))
       & (dir.exists(paste(  ubicacion_comunidad, "Movilizadores", sep = "/")))
       & (dir.exists(paste(  ubicacion_comunidad, "Activistas", sep = "/")))
       & (dir.exists(paste(  ubicacion_comunidad, "CategorizarSexo", sep = "/")))
       & (dir.exists(paste(  ubicacion_comunidad, "Masificadores", sep = "/"))))
    {}else
    {
      dir.create(paste(  ubicacion_comunidad, "Referentes", sep = "/"))
      dir.create(paste(  ubicacion_comunidad, "Influenciadores", sep = "/"))
      dir.create(paste(  ubicacion_comunidad, "Movilizadores", sep = "/"))
      dir.create(paste(  ubicacion_comunidad, "CategorizarSexo", sep = "/"))
      dir.create(paste(  ubicacion_comunidad, "Masificadores", sep = "/"))
      dir.create(paste(  ubicacion_comunidad, "Activistas", sep = "/"))
      
      # Rutas de las carpetas 
      ubicacion_referentes <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/Comunidad/Referentes"
      ubicacion_influenciadores <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/Comunidad/Influenciadores"
      ubicacion_Movilizadores <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/Comunidad/Movilizadores"
      ubicacion_sexo <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/Comunidad/CategorizarSexo"
      ubicacion_masificadores <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/Comunidad/Masificadores"
      ubicacion_activistas <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/Comunidad/Activistas"
      
    }
    # if de las carpetas EFECTOS Y EXITOS
    if((dir.exists(paste( ubicacion_efectos, "Valoracion", sep = "/")))
       & (dir.exists(paste( ubicacion_efectos, "Categorizacion", sep = "/")))
       & (dir.exists(paste( ubicacion_efectos, "MuestraTotal", sep = "/"))))
    {}else
    {
      dir.create(paste(ubicacion_efectos, "Valoracion", sep = "/"))
      dir.create(paste(ubicacion_efectos, "Categorizacion", sep = "/"))
      dir.create(paste(ubicacion_efectos, "MuestraTotal", sep = "/"))
      
      ubicacion_Valoracion <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/Efectos/Valoracion"
      ubicacion_categorizacion <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/Efectos/Categorizacion"
      ubicacion_muestraTotal <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/Efectos/MuestraTotal"
      
      
    }
    # if de las carpetas CARACTERISTICAS TECNICAS 
    if((dir.exists(paste(ubicacion_CaracTecnicas, "Caracteres", sep = "/")))
       & (dir.exists(paste(ubicacion_CaracTecnicas, "Multimedia", sep = "/")))
       & (dir.exists(paste(ubicacion_CaracTecnicas, "Dispositivos", sep = "/")))
       & (dir.exists(paste(ubicacion_CaracTecnicas, "PorcentajeGeoreferencia", sep = "/")))
       & (dir.exists(paste(ubicacion_CaracTecnicas, "RankingGeoreferencia", sep = "/")))
    )
    {}else
    {
      dir.create(paste(ubicacion_CaracTecnicas, "Caracteres", sep = "/"))
      dir.create(paste(ubicacion_CaracTecnicas, "Multimedia", sep = "/"))
      dir.create(paste(ubicacion_CaracTecnicas, "Dispositivos", sep = "/"))
      dir.create(paste(ubicacion_CaracTecnicas, "PorcentajeGeoreferencia", sep = "/"))
      dir.create(paste(ubicacion_CaracTecnicas, "RankingGeoreferencia", sep = "/"))
      
      ubicacion_caracteres <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/CaracteristicasTecnicas/Caracteres"
      ubicacion_multimedia <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/CaracteristicasTecnicas/Multimedia"
      ubicacion_dispositivos <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/CaracteristicasTecnicas/Dispositivos"
      ubicacion_PorcentajeGeo <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/CaracteristicasTecnicas/PorcentajeGeoreferencia"
      ubicacion_RankingGeo <- "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/CaracteristicasTecnicas/RankingGeoreferencia"
      
      
      # Crear las subcarpetas de Caracteristicas tecnicas 
    }
  }
}


i = 1
numArchivos = nrow(nombres)

while(i <= numArchivos)
{
  nombre = substr(toString(nombres$nombres[i]),1,(str_length(nombres$nombres[i])-4))
  nombre_carpeta = paste(carpeta,"Resultados",sep = "/")
  archivo_temporal = paste(carpeta_base,toString(nombres$nombres[i]),sep="/")
  nombreResultado = nombres$nombres[i]
  
  #Nombre Archivos csv 
  archivolink = paste("porcentajelink",nombreResultado,".csv")
  archivoRanking = paste("ranking",nombreResultado,".csv")
  archivoCaracteres = paste("caracteres",nombreResultado,".csv")
  archivoValoracion = paste("Valoracion",nombreResultado,".csv")
  archivoValoracionTweet = paste("ValoracionTweet",nombreResultado,".csv")
  archivoViralizacion = paste("viralizacion",nombreResultado,".csv")
  archivoViralizacionTweet = paste("viralizacionTweet",nombreResultado,".csv")
  archivoReferentes = paste("referentes",nombreResultado,".csv")
  archivoInfluenciadores = paste("influenciadores",nombreResultado,".csv")
  archivoGeoreferencia = paste("georeferencia",nombreResultado,".csv")
  archivoRankingGeo = paste("ranking_paises",nombreResultado,".csv")
  archivoFotos = paste("cantidad_fotos", nombreResultado,".csv")
  archivoUnionDispositivos = paste("consulta_union",nombreResultado,".csv")
  archivoGenero = paste("genero",nombreResultado,".csv")
  archivoUnionSexo= paste("union_sexo",nombreResultado,".csv")
  archivoMasificadores = paste("masificadores",nombreResultado,".csv")
  archivoActivistas = paste("activistas",nombreResultado,".csv")
  archivoCategorizacion = paste("categorizacion",nombreResultado,".csv")
  
  aux <- read.csv(archivo_temporal,header = TRUE,sep = ",",encoding = "UTF-8")
  aux <- as.data.frame(aux)
  
  temporal <- sqldf("SELECT created_at,screen_name,text FROM aux")
  tempora_nube <- temporal
  
  # --- Evolucion y Sentido --- #
  # --- Histograma --- #
  histograma <- sqldf('select  substr(created_at,1,10) FECHA,count(substr(created_at,1,10)) CANTIDAD  
                       from aux group by substr(created_at,1,10) 
                       ORDER BY substr(created_at,1,10) DESC')
  
  write.csv(histograma,file = paste(ubicacion_histograma,"histogramax1dia.csv",sep = "/"),row.names=FALSE)
  write.csv(histograma,file = paste(ubicacion_ResultadosGenerales,"histogramax1diaA.csv",sep = "/"),row.names=FALSE)
  
  # --- Reproduccion, Produccion, Interaccion --- #
  consulta_total_datos = "SELECT COUNT(user_id) totalDatos FROM aux"
  total_datos = sqldf(consulta_total_datos)
  # ===================================================== #
  #Para encontrar retweet cuya columna tiene valores boolean, si es TRUE se pone = 1 y si es FALSE se pone = 0.
  consulta_RT = "SELECT * FROM aux WHERE is_retweet = 1"
  busqueda_RT = sqldf(consulta_RT)
  
  consulta_RTAI = "SELECT * FROM busqueda_RT WHERE text NOT LIKE '@%' AND text NOT LIKE 'RT%'"
  busqueda_RTAI = sqldf(consulta_RTAI)
  
  consulta_RTNAI = "SELECT * FROM busqueda_RT WHERE text NOT LIKE '@%' AND text NOT LIKE 'RT%' AND text NOT LIKE '%@%'"
  busqueda_RTNAI = sqldf(consulta_RTNAI)
  
  consulta_total_RT = "SELECT COUNT(user_id) Retweets FROM busqueda_RT"
  total_RT = sqldf(consulta_total_RT)
  
  consulta_total_RTAI = "SELECT COUNT(user_id) RetweetsAI FROM busqueda_RTAI"
  total_RTAI = sqldf(consulta_total_RTAI)
  
  consulta_total_RTNAI = "SELECT COUNT(user_id) RetweetsNAI FROM busqueda_RTNAI"
  total_RTNAI = sqldf(consulta_total_RTNAI)
  # ===================================================== #
  consulta_AA = "SELECT * FROM aux WHERE text LIKE '@%'"
  busqueda_AA = sqldf(consulta_AA)
  
  consulta_NART = "SELECT * FROM aux WHERE text NOT LIKE '@%' AND text NOT LIKE 'RT%'"
  busqueda_NART = sqldf(consulta_NART)
  
  consulta_total_AA = "SELECT COUNT(user_id) Arroba FROM busqueda_AA"
  total_AA = sqldf(consulta_total_AA)
  
  consulta_total_NART = "SELECT COUNT(user_id) noArrRet FROM busqueda_NART"
  total_NART = sqldf(consulta_total_NART)
  # ===================================================== #
  
  # Grafico Torta #
  consulta_total = "SELECT * FROM total_AA, total_NART, total_RT, total_RTAI, total_RTNAI, total_datos"
  total = sqldf(consulta_total)
  
  #Valores para el grafico de Torta.
  AA = total$Arroba
  NART = total$noArrRet
  RT = total$Retweets
  RTAI = total$RetweetsAI
  RTNAI = total$RetweetsNAI
  N = total$totalDatos
  
  #Porcentaje para el grafico.
  RIP = matrix(c(trunc((AA/N)*100*10^2)/10^2,trunc((NART/N)*100*10^2)/10^2,trunc((RT/N)*100*10^2)/10^2,"Interaccion","Produccion","Reproduccion"),ncol = 2)
  colnames(RIP) = c("Porcentaje","Tipo")
  RIP = as.data.frame(RIP)
  
  data <- RIP[,c('Porcentaje', 'Tipo')]
  
  p <- plot_ly(data, labels = ~Tipo, values = ~Porcentaje, type = 'pie') %>%
    layout(title = 'Produccion, Interaccion y Reproduccion',
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  plotly_IMAGE(p, format = "png", out_file = "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/Evolucion/ReproduccionInteraccionProduccion.png")
  # Ubicacion resultados generales
  plotly_IMAGE(p, format = "png", out_file = "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/ResultadosGenerales/ReproduccionInteraccionProduccionA.png")
  
  # --- Determinantes Semanticos --- #
  # --- Nube --- #
  conectores<-read.csv(paste(carpeta,"conectores.csv",sep = "/"), header = FALSE)
  tempora_nube<-mutate(tempora_nube,text = str_replace_all(text,pat," "))
  lis<-unnest_tokens(tempora_nube,word,text, token="ngrams",n=1 )
  nube<-count(lis,word,sort=TRUE)
  nube<-as.data.frame(nube)
  conectores<-as.data.frame(conectores)
  largo<-length(nube[,1])
  nube2<-nube
  i<-1
  j<-1
  while(i<=largo)
  {
    while(j<=length(conectores[,1]))
    {
      if(toString(nube[i,1])==toString(conectores[j,1]))
      {
        nube<-nube[-i,]
        i<-i-1
        largo<-largo-1
        j<-largo
      }else{
        j<-j+1}
    }
    j<-1
    i<-i+1
  }
  write.csv(nube, file = paste(ubicacion_nube,"nube.csv",sep = "/"),row.names=FALSE)
  write.csv(nube, file = paste(ubicacion_ResultadosGenerales,"nubeA.csv",sep = "/"),row.names=FALSE)
  
  # --- Bigrama --- #
  lol=aux %>%
    
    mutate(text = str_replace_all(text,pat, "")) %>%
    unnest_tokens(word, text, token="ngrams",n=2 ) %>%
    count(word, sort=TRUE) %>% 
    separate(word, c("word1", "word2"), sep = " ") %>% 
    filter(!word1 %in% c(stopwords("es"),"q","d","t","cc","x","html","posted","just","online","streaming","false","na")) %>% 
    filter(!word2 %in% c(stopwords("es"),"q","d","t","cc","x","html","posted","just","online","streaming","false","na")) %>%
    filter(!str_detect(word1,"\\d+")) %>% 
    filter(!str_detect(word2,"\\d+")) %>% 
    unite(bigrama, word1, word2, sep = " ") %>%
    mutate(bigrama=reorder(bigrama,n)) %>% 
    top_n(13,n) %>%
    ungroup()
  
  # --- Guardar Bigrama --- #
  
  data_bigrama=aux %>%
    mutate(text = str_replace_all(text,pat, "")) %>%
    unnest_tokens(word, text, token="ngrams",n=2 ) %>%
    count(word, sort=TRUE) %>% 
    separate(word, c("word1", "word2"), sep = " ") %>% 
    filter(!word1 %in% c(stopwords("es"),"q","d","t","cc","x","html","posted","just","online","streaming","false","na")) %>% 
    filter(!word2 %in% c(stopwords("es"),"q","d","t","cc","x","html","posted","just","online","streaming","false","na")) %>%
    filter(!str_detect(word1,"\\d+")) %>% 
    filter(!str_detect(word2,"\\d+")) %>% 
    unite(bigrama, word1, word2, sep = " ") %>%
    mutate(bigrama=reorder(bigrama,n)) %>% 
    ungroup()
  write.csv(data_bigrama, file = paste(ubicacion_bigrama,"data_bigrama.csv",sep = "/"))
  write.csv(data_bigrama, file = paste(ubicacion_ResultadosGenerales,"data_bigramaA.csv",sep = "/"))
  
  # --- Comunidades --- #
  # --- Referentes --- #
  referentes = "SELECT Distinct(mentions_screen_name) as Menciones FROM aux"
  referentes = sqldf(referentes)
  
  write.csv(referentes, file = paste(ubicacion_referentes,archivoReferentes,sep = "/"),row.names=FALSE)
  write.csv(referentes, file = paste(ubicacion_ResultadosGenerales,archivoReferentes,sep = "/"),row.names=FALSE)
  
  # --- Influenciadores --- #
  influenciadores = "Select retweet_screen_name USUARIO,count(retweet_screen_name) CANTIDAD from aux 
                    where is_retweet 
                    group by retweet_screen_name 
                    order by 
                    count(retweet_screen_name) desc"
  influenciadores = sqldf(influenciadores)
  write.csv(influenciadores,file = paste(ubicacion_influenciadores,archivoInfluenciadores,sep = "/"),row.names = FALSE)
  write.csv(influenciadores,file = paste(ubicacion_ResultadosGenerales,archivoInfluenciadores,sep = "/"),row.names = FALSE)
  
  # --- Movilizadores --- #
  archivoMovi = paste('resumen',nombreResultado,'.csv')
  archivoRanking = paste('ranking',nombreResultado,'.csv')
  
  filas = sqldf("SELECT COUNT(DISTINCT(status_id)) Total FROM aux")
  total = filas$Total
  
  all_words <- unlist(regmatches(aux$text, gregexpr(patHashtag, aux$text)))
  all_words <- str_replace_all(all_words,'#','')
  all_words <- as.data.frame(all_words)
  
  hashtags <- sqldf('SELECT distinct(all_words) Hashtag, COUNT(all_words) Suma
                    FROM all_words GROUP BY Hashtag ORDER BY suma DESC LIMIT 5')
  
  hashtagx <- sqldf("SELECT * FROM hashtags WHERE Hashtag NOT LIKE ''")
  
  filashashtag = sqldf('SELECT COUNT(Hashtag) Total FROM hashtagx')
  
  totalhashtags = filashashtag$Total
  porcentajeHashtag = trunc((totalhashtags/total)*100*10^2)/10^2
  
  
  ranking = sqldf('SELECT Hashtag, Suma FROM hashtagx LIMIT 10')
  
  tabla = matrix(c(total,totalhashtags, porcentajeHashtag,
                   'Total Filas','Total Hashtags','% Hashgtags'), ncol = 2)
 
   colnames(tabla) = c('Valores','Datos')
  tabla = as.data.frame(tabla)
  
  # --- Grafico ranking Hashtag --- #
  #Revisar influenciadores 
  ranking = as.data.frame(ranking)
  
  I = ranking$Hashtag
  S = ranking$Suma
  
  p <- plot_ly ( ranking, y = c(S),x = c(I), type = "bar", name = "Ranking Hashtag")%>%
    layout(title ="Ranking de Hashtag", yaxis = list(title = 'Cantidad'), xaxis = list(title='Hashtag'))
  plotly_IMAGE(p, format = "png", out_file = "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/Comunidad/Movilizadores/RankingHashtag.png")
  plotly_IMAGE(p, format = "png", out_file = "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/ResultadosGenerales/RankingHashtagA.png")
  
  write.csv(tabla, file = paste(ubicacion_Movilizadores,archivoMovi,sep = "/"),row.names=FALSE)
  write.csv(ranking, file = paste(ubicacion_Movilizadores, archivoRanking, sep = "/"), row.names = FALSE)
  #Ubicacion resultados generales
  write.csv(tabla, file = paste(ubicacion_ResultadosGenerales,archivoMovi,sep = "/"),row.names=FALSE)
  write.csv(ranking, file = paste(ubicacion_ResultadosGenerales, archivoRanking, sep = "/"), row.names = FALSE)
  
  # --- Masificadores --- #
  #Usuarios que participan de  una conversacion y que tienen un gran numero de seguidores
  
  masificadores = 'SELECT distinct(screen_name) Cuenta, followers_count Cantidad_seguidores
                  FROM aux WHERE Cantidad_seguidores NOT LIKE "NA" 
                  GROUP BY Cuenta
                  ORDER BY Cantidad_seguidores DESC
                  LIMIT 20'
  masificadores = sqldf(masificadores)
  write.csv(masificadores,file = paste(ubicacion_masificadores,archivoMasificadores,sep = "/"),row.names=FALSE)

  # --- Activistas --- #
  
  activistas = 'SELECT screen_name Twitero,count(screen_name) Cantidad 
                FROM aux WHERE is_retweet = 0 
                GROUP BY screen_name 
                ORDER BY count(screen_name) desc'
  activistas = sqldf(activistas)
  write.csv(activistas, file = paste(ubicacion_activistas,archivoActivistas,sep = "/"),row.names = FALSE)
  
  
  # --- Contenidos multimedia --- #
  
  media = "SELECT urls_expanded_url Media, count(urls_expanded_url) Cantidad FROM aux WHERE Media NOT LIKE ' '"
 
  ranking_url = "SELECT urls_url url, count(urls_url) cantidad FROM aux 
                  WHERE urls_url NOT LIKE ''
                  GROUP BY urls_url
                  ORDER BY cantidad DESC
                  LIMIT 5"
  
  columnas_link = "SELECT (count(distinct(urls_url))-1) as Porcentaje FROM aux"
  
  cantidad_fotos = "SELECT count(media_type) porcentaje_fotos FROM aux WHERE  media_type != ''"
  
  media =sqldf(media)
  ranking_url = sqldf(ranking_url)
  columnas_links= sqldf(columnas_link)
  #total_filas=sqldf(total_filas)
  porcentaje_links = round((columnas_links/total_filas)*100,3)
  cantidad_fotos = sqldf(cantidad_fotos) 
  fotos = round((cantidad_fotos/total_filas)*100,3)
  
  write.csv(ranking,file = paste(ubicacion_multimedia,archivoRanking,sep = "/"),row.names = FALSE)
  write.csv(porcentaje_links, file=paste(ubicacion_multimedia,archivolink,sep="/"),row.names = FALSE)
  write.csv(fotos, file=paste(ubicacion_multimedia,archivoFotos,sep="/"),row.names = FALSE)
  #Ubicacion resultados generales
  write.csv(ranking,file = paste(ubicacion_ResultadosGenerales,archivoRanking,sep = "/"),row.names = FALSE)
  write.csv(porcentaje_links, file=paste(ubicacion_ResultadosGenerales,archivolink,sep="/"),row.names = FALSE)
  write.csv(fotos, file=paste(ubicacion_ResultadosGenerales,archivoFotos,sep="/"),row.names = FALSE)
  
  # --- Grafico Ranking URLS --- #
   
  ranking_url = as.data.frame(ranking_url)
  
  N = ranking_url$url
  U = ranking_url$cantidad
  
  p <- plot_ly ( ranking_url, y = c(U),x = c(N), type = "bar", name = "Ranking URL")%>%
    layout(title ="Ranking de URL", yaxis = list(title = 'Urls'), xaxis = list(title='Cantidad'))
  #Ruta de salida de la imagen
  plotly_IMAGE(p, format = "png", out_file = "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/CaracteristicasTecnicas/Multimedia/RankingUrl.png")
  plotly_IMAGE(p, format = "png", out_file = "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/ResultadosGenerales/RankingUrlA.png")
  
  
  # --- Efectos y exitos --- #
  # --- Categorizacion --- #
  
  categorizacion <- "SELECT COUNT(DISTINCT(user_id)) ID_Usuario FROM aux"
  categorizacion <- sqldf(categorizacion)
  
  if(categorizacion2<1000){
    categorizacionUno <- sqldf('SELECT DISTINCT(user_id), status_id, created_at, screen_name,text,source,display_text_width,
                      reply_to_status_id,reply_to_user_id,reply_to_screen_name,is_quote,is_retweet,favorite_count,
                      retweet_count,hashtags,symbols,urls_url,"urls_t.co" "urls_t.co",urls_expanded_url,
                      media_url,"media_t.co" "media_t.co",media_expanded_url,media_type,ext_media_url,"ext_media_t.co" "ext_media_t.co",ext_media_expanded_url,
                      ext_media_type,mentions_user_id,mentions_screen_name,lang,quoted_status_id,quoted_text,quoted_created_at,
                      quoted_source,quoted_favorite_count,quoted_retweet_count,quoted_user_id,quoted_screen_name,quoted_name,
                      quoted_followers_count,quoted_friends_count,quoted_statuses_count,quoted_location,quoted_description,
                      quoted_verified,retweet_status_id,retweet_text,retweet_created_at,retweet_source,retweet_favorite_count,
                      retweet_retweet_count,retweet_user_id,retweet_screen_name,retweet_name,retweet_followers_count,
                      retweet_friends_count,retweet_statuses_count,retweet_location,retweet_description,retweet_verified,place_url,
                      place_name,place_full_name,place_type,country,country_code,geo_coords,coords_coords,bbox_coords,status_url,
                      name,location,description,url,protected,followers_count,friends_count,listed_count,statuses_count,
                      favourites_count,account_created_at,verified,profile_url,profile_expanded_url,account_lang,profile_banner_url,
                      profile_background_url,profile_image_url
                      FROM 	aux')
    categorizacionUno <-sqldf(categorizacionUno)
                     
  }
  
  auxiliar <- as.data.frame(aux)
  #auxiliar[2,1]
  
  if(categorizacion == 100 || categorizacion > 100){
   
    
    for(i in 1:100)
      {
        #print(auxiliar[i,1])
        matriz<-matrix(c(auxiliar[i,1]),nrow = i,ncol = 1)
        print(matriz)
    }  
   
  }
  write.csv(matriz,file = paste(ubicacion_efectos,archivoCategorizacion,sep ="/"),row.names = FALSE)
 
  
  # --- Valoracion --- #
  Valoracion = "SELECT user_id as ID_usuario,
                max(favorite_count) as Max_favoritos,
                min(favorite_count) as Min_favoritos,
                avg(favorite_count) as Promedio FROM aux"
  
  ValoracionTweet = "SELECT  user_id as ID_usuario,
                    max(favorite_count) as Max_favoritos,
                    text as Tweet FROM aux"
  
  Valoracion = sqldf(Valoracion)
  ValoracionTweet = sqldf(ValoracionTweet)
  
  write.csv(Valoracion, file = paste(ubicacion_Valoracion,archivoValoracion,sep="/" ),row.names = FALSE)
  write.csv(ValoracionTweet, file = paste(ubicacion_Valoracion,archivoValoracionTweet,sep="/" ),row.names = FALSE)
  #Ubiacion carpeta resultados generales
  write.csv(Valoracion, file = paste(ubicacion_ResultadosGenerales,archivoValoracion,sep="/" ),row.names = FALSE)
  write.csv(ValoracionTweet, file = paste(ubicacion_ResultadosGenerales,archivoValoracionTweet,sep="/" ),row.names = FALSE)
  
  # --- Muesta Total ---#
  
  # --- Viralizacion --- #
  viralizacionTweet = "SELECT user_id as ID_usuario,
                      max(retweet_count) as Max_retweet,
                      text as Tweet
                      FROM aux"
  
  viralizacion = "SELECT user_id as ID_usuario,
                  max(retweet_count) as Max_retweet,
                  min(retweet_count) as Min_retweet,
                  avg(retweet_count) as Promedio
                  FROM aux"
  
  viralizacion = sqldf(viralizacion)
  viralizacionTweet = sqldf(viralizacionTweet)
  
  write.csv(viralizacion, file = paste(ubicacion_viralizacion,archivoViralizacion,sep="/" ),row.names = FALSE)
  write.csv(viralizacionTweet, file = paste(ubicacion_viralizacion,archivoViralizacionTweet,sep="/" ),row.names = FALSE)
  
  # --- Caracteristicas Tecnicas --- #
  # ---  + - x Caracteres  --- #
  cantidadCaracteres = "SELECT max(display_text_width) as Max_caracteres,
                        min(display_text_width) as Min_caracteres, 
                        avg(display_text_width) as Promedio FROM aux"
  cantidadCaracteres = sqldf(cantidadCaracteres)
  write.csv(cantidadCaracteres, file = paste(ubicacion_caracteres,archivoCaracteres,sep="/"),row.names = FALSE)
  write.csv(cantidadCaracteres, file = paste(ubicacion_ResultadosGenerales,archivoCaracteres,sep="/"),row.names = FALSE)
  
  # --- Contenidos multimedia --- #
  
  # ---  Categorizacion por dispositivo --- #
  consulta_dispositivos = "SELECT COUNT(source) Total FROM aux"
  dispositivos = sqldf(consulta_dispositivos)
  
  dispositivos_android = "SELECT COUNT(source) Androids FROM aux WHERE source LIKE '%Android'"
  androids = sqldf(dispositivos_android)
  
  consulta_iphone = "SELECT COUNT(source) Iphone FROM aux WHERE source LIKE '%iPhone'"
  iphone = sqldf(consulta_iphone)
  
  consulta_web = "SELECT COUNT(source) Web FROM aux WHERE source LIKE '%Web%'"
  web = sqldf(consulta_web)
  
  consulta_otros = "SELECT COUNT(source) Otros FROM aux WHERE source NOT LIKE '%Android' AND source NOT LIKE '%iPhone' AND source NOT LIKE '%Web%'"
  otros = sqldf(consulta_otros)
  
  consulta_union = "SELECT * FROM androids, iphone, web, otros, dispositivos"
  consulta_union = sqldf(consulta_union)
  todos = consulta_union
  write.csv(consulta_union, file = paste(ubicacion_dispositivos,archivoUnionDispositivos,sep = "/"),row.names = FALSE)
  write.csv(consulta_union, file = paste(ubicacion_ResultadosGenerales,archivoUnionDispositivos,sep = "/"),row.names = FALSE)
  
  A = todos$Androids
  I = todos$Iphone
  W = todos$Web
  O = todos$Otros
  TT = todos$Total
  
  porcentaje = matrix(c(trunc((A/TT)*100*10^2)/10^2,trunc((I/TT)*100*10^2)/10^2,trunc((W/TT)*100*10^2)/10^2,trunc((O/TT)*100*10^2)/10^2,'Android','Iphone','Web','Otros'),ncol = 2)
  colnames(porcentaje) = c('Porcentaje','Dispositivos')
  porcentaje = as.data.frame(porcentaje)
  
  data <- porcentaje[,c('Dispositivos', 'Porcentaje')]
  #
  p <- plot_ly(data, labels = ~Dispositivos, values = ~Porcentaje, type = 'pie') %>%
    layout(title = 'Porcentaje de Dispositivos',
           xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
           yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
  
  plotly_IMAGE(p, format = "png", out_file = "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/CaracteristicasTecnicas/Dispositivos/PorcentajeDispositivos.png")
  plotly_IMAGE(p, format = "png", out_file = "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/ResultadosGenerales/PorcentajeDispositivosA.png")
  
  # --- Georeferencia --- #
  georeferencia = "SELECT (count(distinct(location))-1) porcentaje FROM aux"
  
  # ---  Ranking de los 5 lugares mas mencionados --- #
  ranking_paises = "SELECT count(country) Cantidad, country as Paises
                    FROM aux WHERE Paises NOT LIKE ''
                    GROUP BY Paises 
                    ORDER BY Cantidad DESC
                    LIMIT 5"
                      
  georeferencia = sqldf(georeferencia)
  porcentaje_georeferencia = round((georeferencia/total_filas)*100,2)
  ranking_paises = sqldf(ranking_paises)
  
  # --- Grafico Ranking por paises --- #
  
  ranking_paises = as.data.frame(ranking_paises)
  
  P = ranking_paises$Paises
  C = ranking_paises$Cantidad
  
  p <- plot_ly ( ranking_paises, y = c(C),x = c(P), type = "bar", name = "Ranking Paises")%>%
    layout(title ="Ranking de paises", yaxis = list(title = 'Cantidad'), xaxis = list(title='Paises'))
  #Ruta de salida de la imagen
  plotly_IMAGE(p, format = "png", out_file = "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/CaracteristicasTecnicas/RankingGeoreferencia/RankingPaises.png")
  plotly_IMAGE(p, format = "png", out_file = "/Users/alfonsoopazo/Desktop/Observatorio/Cipolapp/Resultados/ResultadosGenerales/RankingPaisesA.png")
  
  #Escritura de archivos
  write.csv(porcentaje_georeferencia , file = paste(ubicacion_PorcentajeGeo,archivoGeoreferencia,sep = "/"),row.names = FALSE)
  write.csv(ranking_paises, file = paste(ubicacion_RankingGeo,archivoRankingGeo,sep="/" ),row.names = FALSE)
  #Ubicacion resultados generales
  write.csv(porcentaje_georeferencia , file = paste(ubicacion_ResultadosGenerales,archivoGeoreferencia,sep = "/"),row.names = FALSE)
  write.csv(ranking_paises, file = paste(ubicacion_ResultadosGenerales,archivoRankingGeo,sep="/" ),row.names = FALSE)
  
  #---Categorizacion por genero---#
  
  total_filas = "SELECT count(user_id) total_filas FROM aux"
  total_filas=sqldf(total_filas)
  
  genero = "SELECT sexo Sexo, count (sexo) Cantidad FROM aux
            WHERE sexo = 'f' OR sexo = 'm' OR sexo ='na'
            GROUP BY sexo
            ORDER BY Cantidad DESC  
            "
  na = "SELECT count(sexo) as NA 
        FROM aux
        WHERE sexo LIKE 'na'"
  na = sqldf(na)
  
  f = "SELECT count(sexo) as F
       FROM aux WHERE sexo LIKE 'f' "
  f = sqldf(f)
  
  m = "SELECT count(sexo) as M
      FROM aux WHERE sexo LIKE 'm' "
  m = sqldf(m)
  
  porcentaje_na = round((na/total_filas)*100,3)
  porcentaje_f = round((f/total_filas)*100,3)
  porcentaje_m = round((m/total_filas)*100,3)
  
  union_sexo = "SELECT * FROM porcentaje_na, porcentaje_f, porcentaje_m"
  union_sexo = sqldf(union_sexo)
  
  write.csv(genero,file = paste(ubicacion_sexo,archivoGenero,sep = "/"),row.names=FALSE)
  write.csv(union_sexo,file = paste(ubicacion_sexo,archivoUnionSexo,sep = "/"),row.names=FALSE)
  #Ubicacion resultados generales
  write.csv(genero,file = paste(ubicacion_ResultadosGenerales,archivoGenero,sep = "/"),row.names=FALSE)
  write.csv(union_sexo,file = paste(ubicacion_ResultadosGenerales,archivoUnionSexo,sep = "/"),row.names=FALSE)
  
  
  i = i + 1
  
}





