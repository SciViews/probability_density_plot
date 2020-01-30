#' Probability density plot for the F Distribution
#'
#' @param df1,df2 degrees of freedom.
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
#' f_plot(df1 = 5, df2 = 20)
#' f_plot(df1 = 5, df2 = 20, seuil_alpha = 0.05)
#' f_plot_f(df1 = 5, df2 = 20, quantiles = 3.5)
#' 
plot_f <- function(df1, df2, quantiles = NULL, seuil_alpha = NULL, 
  xlab = "Quantiles", ylab = "Probability density" , ...) {
  
  .x <- seq(0, qf(0.999, df1 = df1, df2 = df2), 
    l = 1000)  # Quantiles
  .d <- function (x) df(x, df1 = df1, df2 = df2) # Distribution function
  .q <- function (p) qf(p, df1 = df1, df2 = df2) # Quantile for lower-tail prob
  
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
    q_ref <- qf(seuil_alpha, df1 = df1, 
      df2 = df2, lower.tail = FALSE)
    .x2 <- .x
    .x2[.x2 < q_ref] <- NA
    
    a <- a + 
      ggplot2::geom_ribbon(ggplot2::aes(x = .x2, ymin = 0, ymax = .d(.x2)), 
        fill = "red", alpha = 0.2)
  }
  #print(a)
  a
}
