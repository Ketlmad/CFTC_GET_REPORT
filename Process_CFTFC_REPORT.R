
library(lubridate)
library(data.table)
library(writexl)

        #=====================
        #     Directory
        #=====================
            #Directories
            wd<-"G:/Mickael/Projets/CFTC/R/Commodities/Futures_Options_data/Report_by_matiere_2y_5y_all/"
            setwd(wd)   
          

        #=====================
        #     Load Data
        #=====================

        CORN<-read_xlsx("buffer_Commo_Fut_Opt_CORN.xlsx")
        WHEAT_SRW<-read_xlsx("buffer_Commo_Fut_Opt_WHEAT_SRW.xlsx")
        WHEAT_HRW<-read_xlsx("buffer_Commo_Fut_Opt_WHEAT_HRW.xlsx")
        SOYBEANS<-read_xlsx("buffer_Commo_Fut_Opt_SOYBEANS.xlsx")
        SOYBEAN_OIL<-read_xlsx("buffer_Commo_Fut_Opt_SOYBEAN_OIL.xlsx")
        SOYBEAN_MEAL<-read_xlsx("buffer_Commo_Fut_Opt_SOYBEAN_MEAL.xlsx")
                                                      
        names(CORN)
        