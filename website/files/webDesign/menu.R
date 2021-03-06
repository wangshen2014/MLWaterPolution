############################################
# Semi collapsible shiny
############################################
runjs({'
        var el2 = document.querySelector(".skin-blue");
  el2.className = "skin-blue sidebar-mini";
  var clicker = document.querySelector(".sidebar-toggle");
  clicker.id = "switchState";
  '})

onclick('switchState', runjs({'
  var title = document.querySelector(".logo")
  if (title.style.visibility == "hidden") {
  title.style.visibility = "visible";
  } else {
  title.style.visibility = "hidden";
  }
  var opcions = document.querySelector(".opcions")

  if (opcions.style.display == "none") {
    opcions.style.display = "block";
  } else {
    opcions.style.display = "none";
  }
  '}))

output$Semi_collapsible_sidebar<-renderMenu({
  
  sidebarMenu(id = "tab",
              menuItem("Table", tabName = "tab1",icon = icon("table")),
              menuItem("Scenario", tabName = "tab22", icon = icon("gears")),
              conditionalPanel(condition = "input.generateMatrix >=1",    
                 sidebarMenu( menuItem("Modelling", tabName = "tab2", icon = icon("line-chart"))),
                 sidebarMenu( menuItem("Visualization", tabName = "tab3",icon = icon("eye")))
              ),
              div(class="opcions",
              conditionalPanel("input.tab == 'tab1'",
                               
                 materialSwitch(inputId = "model", label = "Do you have a model?", status = "primary"),
                 # input$model,
                   selectInput("readFunction", "Format to read", c(
                     # Base R:
                     "read.table",
                     "read.csv",
                     "read.csv2",
                     "read.delim",
                     "read.delim2",
                     
                     # foreign functions:
                     "read.spss",
                     "read.arff",
                     "read.dbf",
                     "read.dta",
                     "read.epiiinfo",
                     "read.mtp",
                     "read.octave",
                     "read.ssd",
                     "read.systat",
                     "read.xport",
                     "read_excel",
                     
                     # Advanced functions:
                     "scan",
                     "readLines"
                   )
                   ),
                   
                   # Argument selecter:
                   htmlOutput("ArgSelect"),
                   
                   # Argument field:
                   htmlOutput("ArgText"),
                   
                   # Upload data:
                   fileInput("file", "Browse file"),
                   htmlOutput('response2')
                 ),
              conditionalPanel("input.tab == 'tab2'",
                               actionBttn(inputId = "downloadBigMatrix", label = "Download BIGMATRIX", size = "sm",
                                          icon = icon("download"), color = "primary", style = "jelly")
              ),
              conditionalPanel("input.tab == 'tab22'",
                               actionBttn(inputId = "loadBigMatrix", label = "Load BIGMATRIX", size = "sm",
                                          icon = icon("upload"), color = "primary", style = "jelly")
              )
              )
              
              
  )
  
  
})

outputOptions(output, "Semi_collapsible_sidebar", suspendWhenHidden = FALSE)


