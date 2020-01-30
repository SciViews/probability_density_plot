#' Probability density plot for the Chi-Squared Distribution
#'
#' @param df degrees of freedom
#' @param quantiles value of quantile
#' @param seuil_alpha value of probability
#' @param xlab a title for the x axis
#' @param ylab a title for the y axis
#' @param ...  TODO
#'
#' @return
#' @export
#'
#' @examples
#' 
#' plot_chisq(df = 1)
#' plot_chisq(df = 3, seuil_alpha = 0.05)
#' plot_chisq(df = 10, quantiles = 34)
#' plot_chisq(df = 3, seuil_alpha = 0.05, quantiles = 34)
#' 
plot_chisq <- function(df, quantiles = NULL, seuil_alpha = NULL,
  xlab = "Quantiles", ylab = "Probability density", ...) {
  
  
  .x <- seq(0, qchisq(0.9999, df = df), l = 1000)
  .d <- function(x) dchisq(x, df = df)
  .q <- function(p) qchisq(p, df = df)
  
  a <- chart::chart(
    data = tibble::tibble(
      quantiles = .x, prob = .d(.x)), prob ~ quantiles) +
    ggplot2::geom_hline(yintercept = 0, col = "Black") +
    ggplot2::geom_ribbon(ggplot2::aes(
      x = .x, ymin = 0, ymax = .d(.x)), fill = "gray", alpha = 0.2) +
    ggplot2::geom_line() +
    ggplot2::labs(x = xlab, y = ylab, ...)
  
  if (!is.null(quantiles)) {
    a <- a +
      ggplot2::geom_vline(xintercept = quantiles, col = "Red") 
  }
  
  if (!is.null(seuil_alpha)) {
    q_ref <- qchisq(seuil_alpha, df = df, lower.tail = FALSE)
    .x2 <- .x
    .x2[.x2 < q_ref] <- NA
    
    a <- a + 
      ggplot2::geom_ribbon(ggplot2::aes(x = .x2, ymin = 0, ymax = .d(.x2)), 
        fill = "red", alpha = 0.2)
  }
  #print(a)
  a
}
