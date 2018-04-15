library('rvest')
library('ggplot2')

url <- "https://magiccards.info"

url_html <- read_html(url)


ons_url <- 'https://magiccards.info/on/en.html'

ons_html <- read_html(ons_url)

ons_table_raw <- html_nodes(ons_html, xpath = '/html/body/table[3]')

ons_table_complete <- as.data.frame(html_table(ons_table_raw))

head(ons_table_complete)


##get setlists

setlist <- list("rix", "xln", "hou", "ahk", "aer", "kld", "emn", "soi", "ogw", "bfz", "dtk", "frf", "ktk", "jou", "bng", "ths")

get_set_list <- function(set = "rix") {
  tmp_url <- paste('https://magiccards.info/', set[1], '/en.html', sep = '')
  tmp_html <- read_html(tmp_url)
  tmp_table_raw <- html_nodes(tmp_html, xpath = '/html/body/table[3]')
  tmp_table_complete <- as.data.frame(html_table(tmp_table_raw))
  closeAllConnections()
  return(tmp_table_complete)
}

for (i in 1:length(setlist)) {
  if (i == 1) {
    main <- get_set_list(setlist[1])
  } else {
    tmp <- get_set_list(setlist[i])
    main <- rbind(main, tmp)
    rm(tmp)
  }
}



