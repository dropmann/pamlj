#### send messages to tables from anywhere in the code
#### warnings can be sent to tables or array. The table needs not to be created (like a keyed table within an array)
#### to receive a warning. The warning is stored in the parent and then passed to the tabe
#### Errors must be sent to existing (already defined) objects
#### warnings can be transient (get remove after init) when init=TRUE is passed
#### warnings and error are passed only to visible tables.
#### errors are passed directly to the jamovi object. If option final=TRUE, a `stop()` is issued

Dispatch <- R6::R6Class(
            "Dispatch",
            class=TRUE, 
            cloneable=FALSE, ## should improve performance https://r6.r-lib.org/articles/Performance.html ###
            public=list(
                        tables=NULL,
                        initialize=function(results) { 
                          
                                  self$tables<-results
                           
                        },
                        print=function() {
     
                                 print(private$.warnings)
                                 print(private$.errors)
      
                        },
                        translate=function(msg) {
                          
                          if (!exists("TRANS_WARNS")) return(msg)
                          
                          where<-unlist(lapply(TRANS_WARNS,function(x) length(grep(x$original,msg))>0))
                          where<-which(where)
                          if (is.something(where)) {
                              
                            if (length(where)>1) where<-where[1]
                            if ("new" %in% names(TRANS_WARNS[[where]]))
                               msg<-TRANS_WARNS[[where]]$new
                            if ("sub" %in% names(TRANS_WARNS[[where]]))
                               msg<-gsub(TRANS_WARNS[[where]]$original,TRANS_WARNS[[where]]$sub,msg,fixed=T)
                            if ("append" %in% names(TRANS_WARNS[[where]]))
                               msg<-paste(msg,TRANS_WARNS[[where]]$append)
                            if ("prepend" %in% names(TRANS_WARNS[[where]]))
                               msg<-paste(TRANS_WARNS[[where]]$prepend,msg)
                          }
                          return(msg)
                        }
                        
                        ),
            active=list(
                        warnings=function(obj) {

                                if (missing(obj)) return()
                                if (is.null(obj$message)) return()
                                if (isFALSE(obj$message)) return()
                                if (is.null(obj$topic)) stop("SCAFFOLD:  a message should have a topic (a table path)")
                                path<-stringr::str_split(obj$topic,"_")[[1]]
                                
                                table<-private$.find_table(path)
                                if (!is.something(table)) stop("SCAFFOLD: a message was sent to a non-existing result object: ",obj$topic)
                                state<-as.list(table$state)
                                if (!hasName(obj,"key")) obj$key<-jmvcore::toB64(obj$message)
                                
                                obj$message<-self$translate(obj$message)
                                
                                if (is.null(obj$message))
                                  return()
                                
                                if (exists("fromb64")) obj$message<-fromb64(obj$message)
                                
                                if (inherits(table,"Html")) {
                                  content<-private$.process_html(table$content,obj)
                                  content<-table$setContent(content)
                                  table$setVisible(TRUE)
                                  return()
                                }
                                init<-(hasName(obj,"initOnly") && obj[["initOnly"]]) 
                                
                                .fun<-function(table,id,msg,init) {
                                  
                                  if (table$.has("items"))
                                    for (x in table$items)
                                      .fun(x,id,msg,init)
                                  else
                                    table$setNote(obj$key,obj$message,init=init)
                                  
                                }  
                                .fun(table,obj$id,obj$message,init)
                                
                               
                        },
                        errors=function(obj) {
          
                               if (missing(obj))
                                     return(private$.errors)

                               if (!is.list(obj))
                                     stop("SCAFFOLD: Error requires a named list with `topic` and `message`")
          
                               if (!hasName(obj,"topic") | !hasName(obj,"message"))
                                    stop("SCAFFOLD:: Error requires a named list with `topic` and `message`")
  

                               if (is.null(obj$message) || obj$message==FALSE)
                                    return()
          
                               obj$message<-self$translate(obj$message)
                               if (exists("fromb64")) obj$message<-fromb64(obj$message)
                               
                               if (hasName(obj,"final") && (obj$final))
                                   stop(obj$message)
                          
                               path<-stringr::str_split(obj$topic,"_")[[1]]
                               table<-private$.find_table(path)
                   
                              if (inherits(table,"Html")) {
                                  obj$head<-"warning"
                                  table$setContent(private$.process_html(NULL,obj))
                              } else {
                                  table$setError(obj$message)
                              }
                              table$setVisible(TRUE)
                           

                       },
                       warnings_topics=function() {return(names(private$.warnings))},
                       errors_topics=function() {return(names(private$.errors))}
                      
            ),
            private = list(
                      .warnings=list(),
                      .errors=list(),
                      .process_html= function(content,obj) {

                        if (is.something(obj$head)) {
                                    switch (obj$head,
                                          "issue"     =  head <- "<h2 style='color:red;'> Warning </h2>",
                                          "warning"   =  head <- "<i style='color:red;'> Warning: </i>",
                                                         head <- obj$head
                                         )
                        } else head <-  "<i>Note:</i>"
                        
                        test<-grep(obj$message,content,fixed=TRUE)
                        if (length(test) == 0)
                                     content<-paste(content,"<div>",head,obj$message,"</div>")
                              return(content)
                       },
                      .find_table=function(path) {

                        tableobj<-self$tables
                        found<-FALSE
                        for (aname in path)
                          if (hasName(tableobj,aname)) {
                            found<-TRUE
                            tableobj<-tableobj[[aname]]
                          }
                        if (found)
                             return(tableobj)
                        else
                             return(NULL)
                        
                      }
                       
            ) #end of private
) #end of class



