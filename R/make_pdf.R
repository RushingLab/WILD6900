#' make_pdf
#'
#' Convert html slide show into pdf
#' @export

make_pdf <- function(path){
  file_name <- paste0("file://", normalizePath(paste0(path, ".html")))
  webshot::webshot(file_name, paste0(path, ".pdf"))
}
