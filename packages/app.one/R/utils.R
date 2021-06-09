#' A stupid function to make Clippy say hello to you in the terminal
#' 
#' @param what String. What should Clippy say?
clippy_says <- function(what) {
    cowsay::say(what = what, "clippy")  
}