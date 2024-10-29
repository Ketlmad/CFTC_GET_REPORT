
library(lubridate)
library(data.table)
library(writexl)

#=====================================
#           FINANCIAL
#=====================================

  #=====================================
  #    Futures and Options Reports
  #=====================================
 
        #=====================
        #     Directory
        #=====================
            wd<-"G:/Mickael/Projets/CFTC/R/Financial/Futures_Options_data/"
            setwd(wd)
            
        #=====================================
        #     Date of Current Report
        #=====================================
            static_date<-2016
            now_year_date<-year(Sys.Date())
            date_distance<-now_year_date-static_date
        
    
        #=====================================
        #     Build Names of Reports
        #=====================================
            
          #Create Lists
            date_CFTC_files<-list()
            list_files_Fut_Opt_CFTC<-list()
            list_data_frames_Fut_Opt_CFTC<-list()
          #Init Lists
            list_files_Fut_Opt_CFTC[[1]]<-"Fut_Opt_1995_2016"
            date_CFTC_files[[1]]<-static_date
            
          #Join file names into a list
            for (i in 2:date_distance){
              date_CFTC_files[[i]]<-static_date+i-1
              list_files_Fut_Opt_CFTC[i]<-paste("Fut_Opt_",date_CFTC_files[i],sep="")
            }
      
        #=============================================
        #     Join_ Old Reports into one List
        #=============================================
          
          # #Joining Old reports
          #   for (i in 1:length(list_files_Fut_Opt_CFTC)){
          #     list_data_frames_Fut_Opt_CFTC[[i]]<-fread(file = paste(list_files_Fut_Opt_CFTC[i],".txt",sep="")
          #                                                             ,sep = ",",header = TRUE)
          #   }                 
          # 
          # #Merge old report
          #   ALL_CFTC_Fut_Opt_Reports_1995_2020<-data.table::rbindlist(list_data_frames_Fut_Opt_CFTC)
          #   fwrite(ALL_CFTC_Fut_Opt_Reports_1995_2020,"ALL_CFTC_Fut_Opt_Reports_1995_2020.csv")
            
        #=============================================
        #     Download and read current year reports
        #=============================================
        
            #Build url and zip_file names
              CTFC_url_newest_report<-paste("https://www.cftc.gov/files/dea/history/","deahistfo",now_year_date,".zip",sep = "")
              CTFC_name_newest_report<-paste("deahistfo",now_year_date,".zip",sep="")
              
            #Temp file to download
              temp_zip <- tempfile()
              download.file(CTFC_url_newest_report,temp_zip)
              unzip (temp_zip,overwrite = TRUE)
              unlink(temp_zip)
              
            #Read and Load old report and current one
              Current_report <-fread(file = "annualof.txt",sep = ",",header = TRUE)
              Old_reports<-fread(file = "ALL_CFTC_Fut_Opt_Reports_1995_current_year.csv",sep = ",",header = TRUE)
        
        #=============================================
        #     Bind old report with new one
        #=============================================
            
            #Create a list to quickly merge old reports with current year report
              List_merge_cftc_report<-list(Old_reports,Current_report)
              
            #Merge old with new
              ALL_CFTC_Fut_Opt_Reports_1995_current_year<-rbindlist(List_merge_cftc_report)
              
            #Write Full Database
              fwrite(ALL_CFTC_Fut_Opt_Reports_1995_current_year,"ALL_CFTC_Fut_Opt_Reports_1995_current_year.csv")


  # #=====================================
  # #    Futures only Reports
  # #=====================================    
  #             
  #       #=====================
  #       #     Directory
  #       #=====================
  #           wd<-"G:/Mickael/Projets/CFTC/R/Financial/Futures_Only_data/"
  #           setwd(wd)    
  #           
  #       #=====================================
  #       #     Date of Current Report
  #       #=====================================
  #           
  #           static_date<-2016
  #           now_year_date<-year(Sys.Date())
  #           date_distance<-now_year_date-static_date
  #           
  #       #=====================================
  #       #     Build Names of Reports
  #       #=====================================
  #       
  #           #Create Lists
  #             date_CFTC_files<-list()
  #             list_files_Fut_Opt_CFTC<-list()
  #             list_data_frames_Fut_Opt_CFTC<-list()
  #           #Init Lists
  #             list_files_Fut_Opt_CFTC[[1]]<-"FinFut_2006_2016"
  #             date_CFTC_files[[1]]<-static_date
  #           
  #           #Join file names into a list
  #             for (i in 2:date_distance){
  #               date_CFTC_files[[i]]<-static_date+i-1
  #               list_files_Fut_Opt_CFTC[i]<-paste("FinFut_",date_CFTC_files[i],sep="")
  #             }
  #       
  #       #==================================================================================
  #       #     Join_ Old Reports into one List : if first time using the program
  #       #==================================================================================
  #       
  #       # #Joining Old reports
  #       #   for (i in 1:length(list_files_Fut_Opt_CFTC)){
  #       #     list_data_frames_Fut_Opt_CFTC[[i]]<-fread(file = paste(list_files_Fut_Opt_CFTC[i],".txt",sep="")
  #       #                                                             ,sep = ",",header = TRUE)
  #       #   }
  #       # 
  #       # #Merge old report
  #       #   ALL_CFTC_Fut_Only_Reports_2006_2020<-data.table::rbindlist(list_data_frames_Fut_Opt_CFTC)
  #       #   fwrite(ALL_CFTC_Fut_Only_Reports_2006_2020,"ALL_CFTC_Fut_Only_Reports_2006_2020.csv")
  # 
  #       #=============================================
  #       #     Download and read current year reports
  #       #=============================================
  #       
  #           #Build url and zip_file names
  #             CTFC_url_newest_report<-paste("https://www.cftc.gov/files/dea/history/","fut_fin_txt_",now_year_date,".zip",sep = "")
  #             CTFC_name_newest_report<-paste("FinFut_",now_year_date,".zip",sep="")
  #           
  #           #Temp file to download
  #             temp_zip <- tempfile()
  #             download.file(CTFC_url_newest_report,temp_zip)
  #             unzip (temp_zip,overwrite = TRUE)
  #             unlink(temp_zip)
  #           
  #           #Read and Load old report and current one
  #             Current_report <-fread(file = "FinFutYY.txt",sep = ",",header = TRUE)
  #             Old_reports<-fread(file = "ALL_CFTC_Fut_Opt_Reports_2006_current_year.csv.csv",sep = ",",header = TRUE)
  #           
  #       #=============================================
  #       #     Bind old report with new one
  #       #=============================================
  #       
  #           #Create a list to quickly merge old reports with current year report
  #             List_merge_cftc_report<-list(Old_reports,Current_report)
  #           
  #           #Merge old with new
  #             ALL_CFTC_Fut_Opt_Reports_2006_current_year<-rbindlist(List_merge_cftc_report)
  #           
  #           #Write Full Database
  #             fwrite(ALL_CFTC_Fut_Opt_Reports_2006_current_year,"ALL_CFTC_Fut_Only_Reports_2006_current_year.csv")
 
#=====================================
#           COMMODITIES
#=====================================
              
              #=====================================
              #    Futures and Options Reports
              #=====================================
              
                  #=====================
                  #     Directory
                  #=====================
                      wd<-"G:/Mickael/Projets/CFTC/R/Commodities/Futures_Options_data/"
                      setwd(wd)
                  
                  #=====================================
                  #     Date of Current Report
                  #=====================================
                      static_date<-2016
                      now_year_date<-year(Sys.Date())
                      date_distance<-now_year_date-static_date
                      
                  
                  #=====================================
                  #     Build Names of Reports
                  #=====================================
                  
                      #Create Lists
                        date_CFTC_files<-list()
                        list_files_Fut_Opt_CFTC<-list()
                        list_data_frames_Fut_Opt_CFTC<-list()
                        
                      #Init Lists
                        list_files_Fut_Opt_CFTC[[1]]<-"c_2006_2016"
                        date_CFTC_files[[1]]<-static_date
                        
                      #Join file names into a list
                        for (i in 2:date_distance){
                          date_CFTC_files[[i]]<-static_date+i-1
                          list_files_Fut_Opt_CFTC[i]<-paste("c_",date_CFTC_files[i],sep="")
                        }
                    
 #A LANCER ABSOLUMENT APRES UN SAUT D'ANNEE                 #=============================================
                                                            #     Join_ Old Reports into one List
                                                            #=============================================
                  
                        # #Joining Old reports
                        #   for (i in 1:length(list_files_Fut_Opt_CFTC)){
                        #     list_data_frames_Fut_Opt_CFTC[[i]]<-fread(file = paste(list_files_Fut_Opt_CFTC[i],".txt",sep="")
                        #                                                             ,sep = ",",header = TRUE)
                        #   }
                        # 
                        # #Merge old report
                        #   ALL_CFTC_Commo_Fut_Opt_Reports_2006_2020<-data.table::rbindlist(list_data_frames_Fut_Opt_CFTC)
                        #   fwrite(ALL_CFTC_Commo_Fut_Opt_Reports_2006_2020,"ALL_CFTC_Commo_Fut_Opt_Reports_2006_2021.csv")

                  #=============================================
                  #     Download and read current year reports
                  #=============================================
                  
                      #Build url and zip_file names
                        CTFC_url_newest_report<-paste("https://www.cftc.gov/files/dea/history/","com_disagg_txt_",now_year_date,".zip",sep = "")
                        CTFC_name_newest_report<-paste("deahistfo",now_year_date,".zip",sep="")
                        
                      #Temp file to download
                        temp_zip <- tempfile()
                        download.file(CTFC_url_newest_report,temp_zip)
                        unzip (temp_zip,overwrite = TRUE)
                        unlink(temp_zip)
                        
                      #Read and Load old report and current one
                        Current_report <-fread(file = "c_year.txt",sep = ",",header = TRUE)
                        Old_reports<-fread(file = "ALL_CFTC_Commo_Fut_Opt_Reports_2006_current_year.csv",sep = ",",header = TRUE)
                        
                  #=============================================
                  #     Bind old report with new one
                  #=============================================
                      
                      #Create a list to quickly merge old reports with current year report
                        List_merge_cftc_report<-list(Old_reports,Current_report)
                      
                      #Merge old with new
                        ALL_CFTC_Commo_Fut_Opt_Reports_2006_current_year<-rbindlist(List_merge_cftc_report)
                      
                      #Write Full Database
                        fwrite(ALL_CFTC_Commo_Fut_Opt_Reports_2006_current_year,"ALL_CFTC_Commo_Fut_Opt_Reports_2006_current_year.csv")
                      
              
              #=====================================
              #    Futures only Reports
              #=====================================    
              
#                 #=====================
#                 #     Directory
#                 #=====================
#                     wd<-"G:/Mickael/Projets/CFTC/R/Commodities/Futures_Only_data/"
#                     setwd(wd)    
#                 
#                 #=====================================
#                 #     Date of Current Report
#                 #=====================================
#                 
#                     static_date<-2016
#                     now_year_date<-year(Sys.Date())
#                     date_distance<-now_year_date-static_date
#                     
#                 #=====================================
#                 #     Build Names of Reports
#                 #=====================================
#                 
#                     #Create Lists
#                       date_CFTC_files<-list()
#                       list_files_Fut_Opt_CFTC<-list()
#                       list_data_frames_Fut_Opt_CFTC<-list()
#                     #Init Lists
#                       list_files_Fut_Opt_CFTC[[1]]<-"f_2006_2016"
#                       date_CFTC_files[[1]]<-static_date
#                     
#                     #Join file names into a list
#                       for (i in 2:date_distance){
#                         date_CFTC_files[[i]]<-static_date+i-1
#                         list_files_Fut_Opt_CFTC[i]<-paste("f_",date_CFTC_files[i],sep="")
#                       }
#                 
# #A LANCER ABSOLUMENT APRES UN SAUT D'ANNEE                 #=============================================
#                                                            #     Join_ Old Reports into one List
#                                                            #=============================================
#                       
#                 # #Joining Old reports
#                 #   for (i in 1:length(list_files_Fut_Opt_CFTC)){
#                 #     list_data_frames_Fut_Opt_CFTC[[i]]<-fread(file = paste(list_files_Fut_Opt_CFTC[i],".txt",sep="")
#                 #                                                             ,sep = ",",header = TRUE)
#                 #   }
#                 # 
#                 # #Merge old report
#                 #   ALL_CFTC_Commo_Fut_Only_Reports_2006_2020<-data.table::rbindlist(list_data_frames_Fut_Opt_CFTC)
#                 #   fwrite(ALL_CFTC_Commo_Fut_Only_Reports_2006_2020,"ALL_CFTC_Commo_Fut_Only_Reports_2006_2021.csv")
# 
#                 #=============================================
#                 #     Download and read current year reports
#                 #=============================================
#                 
#                     #Build url and zip_file names
#                       CTFC_url_newest_report<-paste("https://www.cftc.gov/files/dea/history/","fut_disagg_txt_",now_year_date,".zip",sep = "")
#                       CTFC_name_newest_report<-paste("FinFut_",now_year_date,".zip",sep="")
#                       
#                     #Temp file to download
#                       temp_zip <- tempfile()
#                       download.file(CTFC_url_newest_report,temp_zip)
#                       unzip (temp_zip,overwrite = TRUE)
#                       unlink(temp_zip)
#                       
#                     #Read and Load old report and current one
#                       Current_report <-fread(file = "f_year.txt",sep = ",",header = TRUE)
#                       Old_reports<-fread(file = "ALL_CFTC_Commo_Fut_Only_Reports_2006_current_year.csv",sep = ",",header = TRUE)
#                       
#                 #=============================================
#                 #     Bind old report with new one
#                 #=============================================
#                 
#                     #Create a list to quickly merge old reports with current year report
#                       List_merge_cftc_report<-list(Old_reports,Current_report)
#                     
#                     #Merge old with new
#                       ALL_CFTC_Commo_Fut_Only_Reports_2006_current_year<-rbindlist(List_merge_cftc_report)
#                     
#                     #Write Full Database
#                       fwrite(ALL_CFTC_Commo_Fut_Only_Reports_2006_current_year,"ALL_CFTC_Commo_Fut_Only_Reports_2006_current_year.csv")              
#                     
                
                
              
              
                 
#=============================================
#     Subset the reports : 5 and 2 yeats ago
#============================================= 
                      
#Financial Reports                     
buffer<-ALL_CFTC_Commo_Fut_Opt_Reports_2006_current_year
Guess_date_format<-guess_formats((buffer$`Report_Date_as_YYYY-MM-DD`),c("dBY HMS", "dbY HMS", "dmyHMS", "BdY H"))             
buffer$`Report_Date_as_YYYY-MM-DD`<-as.Date(buffer$`Report_Date_as_YYYY-MM-DD`,format=Guess_date_format)
                                              


#Ordering by Date & Matiere
buffer<-buffer[order(buffer$`Report_Date_as_YYYY-MM-DD`),]

#Subset by Date
buffer<-subset(buffer,buffer$`Report_Date_as_YYYY-MM-DD`>"201-01-01") 

#=============================================
#               Commodity Reports
#=============================================

    # #=============================================
    # #               Futures Only
    # #=============================================
    # 
    #   #Directory
    #     wd<-"G:/Mickael/Projets/CFTC/R/Commodities/Futures_Only_data/"
    #     setwd(wd)
    # 
    #   #Load Data
    #     buffer_Commo_Fut_only<-fread(file = "ALL_CFTC_Commo_Fut_Only_Reports_2006_current_year.csv",sep = ",",header = TRUE)
    # 
    #   #Ordering by Date & Matiere
    #     buffer_Commo_Fut_only<-buffer_Commo_Fut_only[order(buffer_Commo_Fut_only$`Report_Date_as_YYYY-MM-DD`),]
    #     buffer_Commo_Fut_only$Managed_Money_Net_Position<-buffer_Commo_Fut_only$M_Money_Positions_Long_All-buffer_Commo_Fut_only$M_Money_Positions_Short_All
    # 
    #   #Subset by Date
    #     buffer_Commo_Fut_only_2y<-subset(buffer_Commo_Fut_only,buffer_Commo_Fut_only$`Report_Date_as_YYYY-MM-DD`>Sys.Date()-365*2)
    #     buffer_Commo_Fut_only_5y<-subset(buffer_Commo_Fut_only,buffer_Commo_Fut_only$`Report_Date_as_YYYY-MM-DD`>Sys.Date()-365*5)
    # 
    #   #Subset by Matiere 2y
    #     buffer_Commo_Fut_only_2y_CORN<-subset(buffer_Commo_Fut_only_2y
    #                                            ,buffer_Commo_Fut_only_2y$Market_and_Exchange_Names=="CORN - CHICAGO BOARD OF TRADE")
    #     buffer_Commo_Fut_only_2y_WHEAT_SRW<-subset(buffer_Commo_Fut_only_2y
    #                                           ,buffer_Commo_Fut_only_2y$Market_and_Exchange_Names=="WHEAT-SRW - CHICAGO BOARD OF TRADE")
    #     buffer_Commo_Fut_only_2y_WHEAT_HRW<- subset(buffer_Commo_Fut_only_2y
    #                                                 ,buffer_Commo_Fut_only_2y$Market_and_Exchange_Names=="WHEAT-HRW - CHICAGO BOARD OF TRADE")
    #     buffer_Commo_Fut_only_2y_SOYBEANS<- subset(buffer_Commo_Fut_only_2y
    #                                                 ,buffer_Commo_Fut_only_2y$Market_and_Exchange_Names=="SOYBEANS - CHICAGO BOARD OF TRADE")
    #     buffer_Commo_Fut_only_2y_SOYBEAN_OIL<- subset(buffer_Commo_Fut_only_2y
    #                                                ,buffer_Commo_Fut_only_2y$Market_and_Exchange_Names=="SOYBEAN OIL - CHICAGO BOARD OF TRADE")
    #     buffer_Commo_Fut_only_2y_SOYBEAN_MEAL<- subset(buffer_Commo_Fut_only_2y
    #                                                   ,buffer_Commo_Fut_only_2y$Market_and_Exchange_Names=="SOYBEAN MEAL - CHICAGO BOARD OF TRADE")
    #   #Subset by Matiere 5 y
    #     buffer_Commo_Fut_only_5y_CORN<-subset(buffer_Commo_Fut_only_5y
    #                                           ,buffer_Commo_Fut_only_5y$Market_and_Exchange_Names=="CORN - CHICAGO BOARD OF TRADE")
    #     buffer_Commo_Fut_only_5y_WHEAT_SRW<-subset(buffer_Commo_Fut_only_5y
    #                                                ,buffer_Commo_Fut_only_5y$Market_and_Exchange_Names=="WHEAT-SRW - CHICAGO BOARD OF TRADE")
    #     buffer_Commo_Fut_only_5y_WHEAT_HRW<- subset(buffer_Commo_Fut_only_5y
    #                                                 ,buffer_Commo_Fut_only_5y$Market_and_Exchange_Names=="WHEAT-HRW - CHICAGO BOARD OF TRADE")
    #     buffer_Commo_Fut_only_5y_SOYBEANS<- subset(buffer_Commo_Fut_only_5y
    #                                                ,buffer_Commo_Fut_only_5y$Market_and_Exchange_Names=="SOYBEANS - CHICAGO BOARD OF TRADE")
    #     buffer_Commo_Fut_only_5y_SOYBEAN_OIL<- subset(buffer_Commo_Fut_only_5y
    #                                                   ,buffer_Commo_Fut_only_5y$Market_and_Exchange_Names=="SOYBEAN OIL - CHICAGO BOARD OF TRADE")
    #     buffer_Commo_Fut_only_5y_SOYBEAN_MEAL<- subset(buffer_Commo_Fut_only_5y
    #                                                   ,buffer_Commo_Fut_only_5y$Market_and_Exchange_Names=="SOYBEAN MEAL - CHICAGO BOARD OF TRADE")
    #   #Subset by Matiere ALL
    #     buffer_Commo_Fut_only_CORN<-subset(buffer_Commo_Fut_only
    #                                           ,buffer_Commo_Fut_only$Market_and_Exchange_Names=="CORN - CHICAGO BOARD OF TRADE")
    #     buffer_Commo_Fut_only_WHEAT_SRW<-subset(buffer_Commo_Fut_only
    #                                                ,buffer_Commo_Fut_only$Market_and_Exchange_Names=="WHEAT-SRW - CHICAGO BOARD OF TRADE")
    #     buffer_Commo_Fut_only_WHEAT_HRW<- subset(buffer_Commo_Fut_only
    #                                                 ,buffer_Commo_Fut_only$Market_and_Exchange_Names=="WHEAT-HRW - CHICAGO BOARD OF TRADE")
    #     buffer_Commo_Fut_only_SOYBEANS<- subset(buffer_Commo_Fut_only
    #                                                ,buffer_Commo_Fut_only$Market_and_Exchange_Names=="SOYBEANS - CHICAGO BOARD OF TRADE")
    #     buffer_Commo_Fut_only_SOYBEAN_OIL<- subset(buffer_Commo_Fut_only
    #                                                   ,buffer_Commo_Fut_only$Market_and_Exchange_Names=="SOYBEAN OIL - CHICAGO BOARD OF TRADE")
    #     buffer_Commo_Fut_only_SOYBEAN_MEAL<- subset(buffer_Commo_Fut_only
    #                                                    ,buffer_Commo_Fut_only$Market_and_Exchange_Names=="SOYBEAN MEAL - CHICAGO BOARD OF TRADE")
    # 
    #   #Export_data
    #     wd_export<-"G:/Mickael/Projets/CFTC/R/Commodities/Futures_Only_data/Report_by_matiere_2y_5y_all/"
    # 
    #     #2y
    #       write_xlsx(buffer_Commo_Fut_only_2y_CORN,paste(wd_export,"buffer_Commo_Fut_only_2y_CORN.xlsx",sep = ""))
    #       write_xlsx(buffer_Commo_Fut_only_2y_WHEAT_SRW,paste(wd_export,"buffer_Commo_Fut_only_2y_WHEAT_SRW.xlsx",sep = ""))
    #       write_xlsx(buffer_Commo_Fut_only_2y_WHEAT_HRW,paste(wd_export,"buffer_Commo_Fut_only_2y_WHEAT_HRW.xlsx",sep = ""))
    #       write_xlsx(buffer_Commo_Fut_only_2y_SOYBEANS,paste(wd_export,"buffer_Commo_Fut_only_2y_SOYBEANS.xlsx",sep = ""))
    #       write_xlsx(buffer_Commo_Fut_only_2y_SOYBEAN_OIL,paste(wd_export,"buffer_Commo_Fut_only_2y_SOYBEAN_OIL.xlsx",sep = ""))
    #       write_xlsx(buffer_Commo_Fut_only_2y_SOYBEAN_MEAL,paste(wd_export,"buffer_Commo_Fut_only_2y_SOYBEAN_MEAL.xlsx",sep = ""))
    # 
    #     #5y
    #       write_xlsx(buffer_Commo_Fut_only_5y_CORN,paste(wd_export,"buffer_Commo_Fut_only_5y_CORN.xlsx",sep = ""))
    #       write_xlsx(buffer_Commo_Fut_only_5y_WHEAT_SRW,paste(wd_export,"buffer_Commo_Fut_only_5y_WHEAT_SRW.xlsx",sep = ""))
    #       write_xlsx(buffer_Commo_Fut_only_5y_WHEAT_HRW,paste(wd_export,"buffer_Commo_Fut_only_5y_WHEAT_HRW.xlsx",sep = ""))
    #       write_xlsx(buffer_Commo_Fut_only_5y_SOYBEANS,paste(wd_export,"buffer_Commo_Fut_only_5y_SOYBEANS.xlsx",sep = ""))
    #       write_xlsx(buffer_Commo_Fut_only_5y_SOYBEAN_OIL,paste(wd_export,"buffer_Commo_Fut_only_5y_SOYBEAN_OIL.xlsx",sep = ""))
    #       write_xlsx(buffer_Commo_Fut_only_5y_SOYBEAN_MEAL,paste(wd_export,"buffer_Commo_Fut_only_5y_SOYBEAN_MEAL.xlsx",sep = ""))
    # 
    #     #all
    #       write_xlsx(buffer_Commo_Fut_only_CORN,paste(wd_export,"buffer_Commo_Fut_only_CORN.xlsx",sep = ""))
    #       write_xlsx(buffer_Commo_Fut_only_WHEAT_SRW,paste(wd_export,"buffer_Commo_Fut_only_WHEAT_SRW.xlsx",sep = ""))
    #       write_xlsx(buffer_Commo_Fut_only_WHEAT_HRW,paste(wd_export,"buffer_Commo_Fut_only_WHEAT_HRW.xlsx",sep = ""))
    #       write_xlsx(buffer_Commo_Fut_only_SOYBEANS,paste(wd_export,"buffer_Commo_Fut_only_SOYBEANS.xlsx",sep = ""))
    #       write_xlsx(buffer_Commo_Fut_only_SOYBEAN_OIL,paste(wd_export,"buffer_Commo_Fut_only_SOYBEAN_OIL.xlsx",sep = ""))
    #       write_xlsx(buffer_Commo_Fut_only_SOYBEAN_MEAL,paste(wd_export,"buffer_Commo_Fut_only_SOYBEAN_MEAL.xlsx",sep = ""))

        
    #=============================================
    #               Futures and Options
    #=============================================        
    
      #Directories
        wd<-"G:/Mickael/Projets/CFTC/R/Commodities/Futures_Options_data/"
        setwd(wd)                                 
       
      #Load Data                                             
        buffer_Commo_Fut_Opt<-fread(file = "ALL_CFTC_Commo_Fut_Opt_Reports_2006_current_year.csv",sep = ",",header = TRUE)
        buffer_Commo_Fut_Opt$Managed_Money_Net_Position<-buffer_Commo_Fut_Opt$M_Money_Positions_Long_All-buffer_Commo_Fut_Opt$M_Money_Positions_Short_All
        
      #Ordering by Date & Matiere
        buffer_Commo_Fut_Opt<-buffer_Commo_Fut_Opt[order(buffer_Commo_Fut_Opt$`Report_Date_as_YYYY-MM-DD`),]
        
      #Subset by commodity groups
        Ags<-c("CORN - CHICAGO BOARD OF TRADE"
                ,"WHEAT-SRW - CHICAGO BOARD OF TRADE"
                ,"WHEAT-HRW - CHICAGO BOARD OF TRADE"
                ,"SOYBEANS - CHICAGO BOARD OF TRADE"
                ,"SOYBEAN OIL - CHICAGO BOARD OF TRADE"
                ,"SOYBEAN MEAL - CHICAGO BOARD OF TRADE"
              )
          
        Energy<-c("CRUDE OIL, LIGHT SWEET-WTI - ICE FUTURES EUROPE"
          ,"GASOLINE RBOB - NEW YORK MERCANTILE EXCHANGE"
          )
        
        Softs<-c("SUGAR NO. 11 - ICE FUTURES U.S."
                  ,"COCOA - ICE FUTURES U.S."
                  ,"COTTON NO. 2 - ICE FUTURES U.S."
                  ,"COFFEE C - ICE FUTURES U.S."
                  ,"FRZN CONCENTRATED ORANGE JUICE - ICE FUTURES U.S."
                  )
                
        Metals<-c("COPPER- #1 - COMMODITY EXCHANGE INC."
                  ,"SILVER - COMMODITY EXCHANGE INC."
                  ,"PALLADIUM - NEW YORK MERCANTILE EXCHANGE"
                  ,"PLATINUM - NEW YORK MERCANTILE EXCHANGE"
                  ,"GOLD - COMMODITY EXCHANGE INC."
                  )
        
        
        Ags_sub <- subset(buffer_Commo_Fut_Opt, buffer_Commo_Fut_Opt$Market_and_Exchange_Names %in% Ags)
        Energy_sub <- subset(buffer_Commo_Fut_Opt, buffer_Commo_Fut_Opt$Market_and_Exchange_Names %in% Energy)
        Softs_sub <- subset(buffer_Commo_Fut_Opt, buffer_Commo_Fut_Opt$Market_and_Exchange_Names %in% Softs)
        Metals_sub <- subset(buffer_Commo_Fut_Opt, buffer_Commo_Fut_Opt$Market_and_Exchange_Names %in% Metals)
        
        write_xlsx(Ags_sub,"Ags_sub.xlsx")
        write_xlsx(Energy_sub,"Energy_sub.xlsx")
        write_xlsx(Softs_sub,"Softs_sub.xlsx")
        write_xlsx(Metals_sub,"Metals_sub.xlsx")
        
        
        
      #Subset by Date
        buffer_Commo_Fut_Opt_2y<-subset(buffer_Commo_Fut_Opt,buffer_Commo_Fut_Opt$`Report_Date_as_YYYY-MM-DD`>Sys.Date()-365*2) 
        buffer_Commo_Fut_Opt_5y<-subset(buffer_Commo_Fut_Opt,buffer_Commo_Fut_Opt$`Report_Date_as_YYYY-MM-DD`>Sys.Date()-365*5) 
        
      #Subset by Matiere 2y
        buffer_Commo_Fut_Opt_2y_CORN<-subset(buffer_Commo_Fut_Opt_2y
                                              ,buffer_Commo_Fut_Opt_2y$Market_and_Exchange_Names=="CORN - CHICAGO BOARD OF TRADE")
        buffer_Commo_Fut_Opt_2y_WHEAT_SRW<-subset(buffer_Commo_Fut_Opt_2y
                                                   ,buffer_Commo_Fut_Opt_2y$Market_and_Exchange_Names=="WHEAT-SRW - CHICAGO BOARD OF TRADE")
        buffer_Commo_Fut_Opt_2y_WHEAT_HRW<- subset(buffer_Commo_Fut_Opt_2y
                                                    ,buffer_Commo_Fut_Opt_2y$Market_and_Exchange_Names=="WHEAT-HRW - CHICAGO BOARD OF TRADE")
        buffer_Commo_Fut_Opt_2y_SOYBEANS<- subset(buffer_Commo_Fut_Opt_2y
                                                   ,buffer_Commo_Fut_Opt_2y$Market_and_Exchange_Names=="SOYBEANS - CHICAGO BOARD OF TRADE")    
        buffer_Commo_Fut_Opt_2y_SOYBEAN_OIL<- subset(buffer_Commo_Fut_Opt_2y
                                                      ,buffer_Commo_Fut_Opt_2y$Market_and_Exchange_Names=="SOYBEAN OIL - CHICAGO BOARD OF TRADE")       
        buffer_Commo_Fut_Opt_2y_SOYBEAN_MEAL<- subset(buffer_Commo_Fut_Opt_2y
                                                       ,buffer_Commo_Fut_Opt_2y$Market_and_Exchange_Names=="SOYBEAN MEAL - CHICAGO BOARD OF TRADE") 
      #Subset by Matiere 5 y
        buffer_Commo_Fut_Opt_5y_CORN<-subset(buffer_Commo_Fut_Opt_5y
                                              ,buffer_Commo_Fut_Opt_5y$Market_and_Exchange_Names=="CORN - CHICAGO BOARD OF TRADE")
        buffer_Commo_Fut_Opt_5y_WHEAT_SRW<-subset(buffer_Commo_Fut_Opt_5y
                                                   ,buffer_Commo_Fut_Opt_5y$Market_and_Exchange_Names=="WHEAT-SRW - CHICAGO BOARD OF TRADE")
        buffer_Commo_Fut_Opt_5y_WHEAT_HRW<- subset(buffer_Commo_Fut_Opt_5y
                                                    ,buffer_Commo_Fut_Opt_5y$Market_and_Exchange_Names=="WHEAT-HRW - CHICAGO BOARD OF TRADE")
        buffer_Commo_Fut_Opt_5y_SOYBEANS<- subset(buffer_Commo_Fut_Opt_5y
                                                   ,buffer_Commo_Fut_Opt_5y$Market_and_Exchange_Names=="SOYBEANS - CHICAGO BOARD OF TRADE")    
        buffer_Commo_Fut_Opt_5y_SOYBEAN_OIL<- subset(buffer_Commo_Fut_Opt_5y
                                                      ,buffer_Commo_Fut_Opt_5y$Market_and_Exchange_Names=="SOYBEAN OIL - CHICAGO BOARD OF TRADE")       
        buffer_Commo_Fut_Opt_5y_SOYBEAN_MEAL<- subset(buffer_Commo_Fut_Opt_5y
                                                       ,buffer_Commo_Fut_Opt_5y$Market_and_Exchange_Names=="SOYBEAN MEAL - CHICAGO BOARD OF TRADE") 
      #Subset by Matiere ALL
        buffer_Commo_Fut_Opt_CORN<-subset(buffer_Commo_Fut_Opt
                                           ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="CORN - CHICAGO BOARD OF TRADE")
        buffer_Commo_Fut_Opt_WHEAT_SRW<-subset(buffer_Commo_Fut_Opt
                                                ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="WHEAT-SRW - CHICAGO BOARD OF TRADE")
        buffer_Commo_Fut_Opt_WHEAT_HRW<- subset(buffer_Commo_Fut_Opt
                                                 ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="WHEAT-HRW - CHICAGO BOARD OF TRADE")
        buffer_Commo_Fut_Opt_SOYBEANS<- subset(buffer_Commo_Fut_Opt
                                                ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="SOYBEANS - CHICAGO BOARD OF TRADE")    
        buffer_Commo_Fut_Opt_SOYBEAN_OIL<- subset(buffer_Commo_Fut_Opt
                                                   ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="SOYBEAN OIL - CHICAGO BOARD OF TRADE")       
        buffer_Commo_Fut_Opt_SOYBEAN_MEAL<- subset(buffer_Commo_Fut_Opt
                                                    ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="SOYBEAN MEAL - CHICAGO BOARD OF TRADE")    
        
        #Energy, Metal & Softs
        buffer_Commo_Fut_Opt_WTI<- subset(buffer_Commo_Fut_Opt
                                                   ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="CRUDE OIL, LIGHT SWEET-WTI - ICE FUTURES EUROPE")  
        buffer_Commo_Fut_Opt_GASOLINE<- subset(buffer_Commo_Fut_Opt
                                          ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="GASOLINE RBOB - NEW YORK MERCANTILE EXCHANGE")  
        
        buffer_Commo_Fut_Opt_NATURAL<- subset(buffer_Commo_Fut_Opt
                                               ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="NATURAL GAS - NEW YORK MERCANTILE EXCHANGE")  
        buffer_Commo_Fut_Opt_CRUDE<- subset(buffer_Commo_Fut_Opt
                                            ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="CRUDE OIL, LIGHT SWEET - NEW YORK MERCANTILE EXCHANGE")
        
        buffer_Commo_Fut_Opt_SILVER<- subset(buffer_Commo_Fut_Opt
                                          ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="SILVER - COMMODITY EXCHANGE INC.")     
        buffer_Commo_Fut_Opt_GOLD<- subset(buffer_Commo_Fut_Opt
                                          ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="GOLD - COMMODITY EXCHANGE INC.")     
        buffer_Commo_Fut_Opt_COOPER<- subset(buffer_Commo_Fut_Opt
                                          ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="COPPER- #1 - COMMODITY EXCHANGE INC.")     
        buffer_Commo_Fut_Opt_PLATINUM<- subset(buffer_Commo_Fut_Opt
                                          ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="PLATINUM - NEW YORK MERCANTILE EXCHANGE")     
        buffer_Commo_Fut_Opt_PALADIUM<- subset(buffer_Commo_Fut_Opt
                                          ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="PALLADIUM - NEW YORK MERCANTILE EXCHANGE")     
        buffer_Commo_Fut_Opt_SUGAR<- subset(buffer_Commo_Fut_Opt
                                          ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="SUGAR NO. 11 - ICE FUTURES U.S.")     
        buffer_Commo_Fut_Opt_COFFEE<- subset(buffer_Commo_Fut_Opt
                                            ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="COFFEE C - ICE FUTURES U.S.")   
        buffer_Commo_Fut_Opt_COCOA<- subset(buffer_Commo_Fut_Opt
                                             ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="COCOA - ICE FUTURES U.S.")            
        buffer_Commo_Fut_Opt_COTTON<- subset(buffer_Commo_Fut_Opt
                                            ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="COTTON NO. 2 - ICE FUTURES U.S.")
        buffer_Commo_Fut_Opt_ORANGE_JUICE<- subset(buffer_Commo_Fut_Opt
                                             ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="FRZN CONCENTRATED ORANGE JUICE - ICE FUTURES U.S.")
        
        
        
        buffer_Commo_Fut_Opt_LEAN_HOGS<- subset(buffer_Commo_Fut_Opt
                                                ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="LEAN HOGS - CHICAGO MERCANTILE EXCHANGE")     
        buffer_Commo_Fut_Opt_LIVE_CATTLE<- subset(buffer_Commo_Fut_Opt
                                                  ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="LIVE CATTLE - CHICAGO MERCANTILE EXCHANGE")     
        buffer_Commo_Fut_Opt_FROZEN_PORK<- subset(buffer_Commo_Fut_Opt
                                                  ,buffer_Commo_Fut_Opt$Market_and_Exchange_Names=="FRZN PORK BELLIES - CHICAGO MERCANTILE EXCHANGE")   
        
      #Export_data
        wd_export<-"G:/Mickael/Projets/CFTC/R/Commodities/Futures_Options_data/Report_by_matiere_2y_5y_all/"    
      
      #2y
        write_xlsx(unique(buffer_Commo_Fut_Opt_2y_CORN        ),paste(wd_export,"buffer_Commo_Fut_Opt_2y_CORN.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_2y_WHEAT_SRW   ),paste(wd_export,"buffer_Commo_Fut_Opt_2y_WHEAT_SRW.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_2y_WHEAT_HRW   ),paste(wd_export,"buffer_Commo_Fut_Opt_2y_WHEAT_HRW.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_2y_SOYBEANS    ),paste(wd_export,"buffer_Commo_Fut_Opt_2y_SOYBEANS.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_2y_SOYBEAN_OIL ),paste(wd_export,"buffer_Commo_Fut_Opt_2y_SOYBEAN_OIL.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_2y_SOYBEAN_MEAL),paste(wd_export,"buffer_Commo_Fut_Opt_2y_SOYBEAN_MEAL.xlsx",sep = ""))
        
      #5y
        write_xlsx(unique(buffer_Commo_Fut_Opt_5y_CORN        ),paste(wd_export,"buffer_Commo_Fut_Opt_5y_CORN.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_5y_WHEAT_SRW   ),paste(wd_export,"buffer_Commo_Fut_Opt_5y_WHEAT_SRW.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_5y_WHEAT_HRW   ),paste(wd_export,"buffer_Commo_Fut_Opt_5y_WHEAT_HRW.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_5y_SOYBEANS    ),paste(wd_export,"buffer_Commo_Fut_Opt_5y_SOYBEANS.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_5y_SOYBEAN_OIL ),paste(wd_export,"buffer_Commo_Fut_Opt_5y_SOYBEAN_OIL.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_5y_SOYBEAN_MEAL),paste(wd_export,"buffer_Commo_Fut_Opt_5y_SOYBEAN_MEAL.xlsx",sep = ""))
        
      #all
        write_xlsx(unique(buffer_Commo_Fut_Opt_CORN        ),paste(wd_export,"buffer_Commo_Fut_Opt_CORN.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_WHEAT_SRW   ),paste(wd_export,"buffer_Commo_Fut_Opt_WHEAT_SRW.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_WHEAT_HRW   ),paste(wd_export,"buffer_Commo_Fut_Opt_WHEAT_HRW.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_SOYBEANS    ),paste(wd_export,"buffer_Commo_Fut_Opt_SOYBEANS.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_SOYBEAN_OIL ),paste(wd_export,"buffer_Commo_Fut_Opt_SOYBEAN_OIL.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_SOYBEAN_MEAL),paste(wd_export,"buffer_Commo_Fut_Opt_SOYBEAN_MEAL.xlsx",sep = ""))
 
        
        write_xlsx(unique(buffer_Commo_Fut_Opt_PALADIUM    ),paste(wd_export,"buffer_Commo_Fut_Opt_PALADIUM.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_GOLD ),paste(wd_export,"buffer_Commo_Fut_Opt_GOLD.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_SILVER),paste(wd_export,"buffer_Commo_Fut_Opt_SILVER.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_COOPER),paste(wd_export,"buffer_Commo_Fut_Opt_COOPER.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_PLATINUM),paste(wd_export,"buffer_Commo_Fut_Opt_PLATINUM.xlsx",sep = ""))
        
        write_xlsx(unique(buffer_Commo_Fut_Opt_SUGAR    ),paste(wd_export,"buffer_Commo_Fut_Opt_SUGAR.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_COFFEE ),paste(wd_export,"buffer_Commo_Fut_Opt_COFFEE.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_COCOA),paste(wd_export,"buffer_Commo_Fut_Opt_COCOA.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_COTTON),paste(wd_export,"buffer_Commo_Fut_Opt_COTTON.xlsx",sep = ""))
        

        write_xlsx(unique(buffer_Commo_Fut_Opt_LEAN_HOGS    ),paste(wd_export,"buffer_Commo_Fut_Opt_LEAN_HOGS.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_LIVE_CATTLE ),paste(wd_export,"buffer_Commo_Fut_Opt_LIVE_CATTLE.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_FROZEN_PORK),paste(wd_export,"buffer_Commo_Fut_Opt_FROZEN_PORK.xlsx",sep = ""))
        
        write_xlsx(unique(buffer_Commo_Fut_Opt_WTI    ),paste(wd_export,"buffer_Commo_Fut_Opt_WTI.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_CRUDE    ),paste(wd_export,"buffer_Commo_Fut_Opt_CRUDE.xlsx",sep = ""))
        
        write_xlsx(unique(buffer_Commo_Fut_Opt_GASOLINE    ),paste(wd_export,"buffer_Commo_Fut_Opt_GASOLINE.xlsx",sep = ""))
        write_xlsx(unique(buffer_Commo_Fut_Opt_ORANGE_JUICE    ),paste(wd_export,"buffer_Commo_Fut_Opt_ORANGE_JUICE.xlsx",sep = ""))
        
        
