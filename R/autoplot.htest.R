#' Title
#'
#' @param object h.test object
#'
#' @return
#' @export
#'
#' @examples
#' 
#' crossbill <- tibble::tibble(cb = c(rep("left", 1895), rep("right", 1752)))
#' (crossbill_tab <- table(crossbill$cb))
#' ggplot2::autoplot(chisq.test(crossbill_tab, p = c(1/2, 1/2)))
#' 
autoplot.htest <- function(object){
  
  if (attr(object$statistic, which = "names") == "X-squared") {
    a <- plot_chisq(df = object$parameter, seuil_alpha = 0.05, 
      quantiles = object$statistic)
  }
  
  if (attr(object$statistic, which = "names") == "t") {
    a <- plot_t(mu = 0, sigma = 1, df = object$parameter, 
      quantiles = object$statistic,
      seuil_alpha = (1 - attr(object$conf.int, "conf.level")), 
      alternative = object$alternative)
  }
  
  a
}
