#' Title
#'
#' @param mu value of the mean
#' @param sigma value of the standard deviation
#' @param df degrees of freedom
#' @param quantiles value of quantile
#' @param seuil_alpha value of probability
#' @param alternative character string specifying the alternative hypothesis, 
#'                    must be one of "two.sided" (default), "greater" or "less". 
#' @param xlab a title for the x axis
#' @param ylab a title for the y axis
#' @param ... TODO
#'
#' @return
#' @export
#'
#' @examples
#' 
#' plot_t(mu = 10, sigma = 6, df = 500)
#' plot_t(mu = 10, sigma = 1, df = 500, quantiles = 12)
#' plot_t(mu = 10, sigma = 1, df = 500, quantiles = 11, seuil_alpha = 0.05, 
#'         alternative = "two.sided")
#' plot_t(mu = 10, sigma = 1, df = 500, quantiles = 11, seuil_alpha = 0.05, 
#'         alternative = "less")
#' plot_t(mu = 10, sigma = 1, df = 500, quantiles = 11, seuil_alpha = 0.05,
#'  alternative = "greater")
#' 
plot_t <- function(mu = 0, sigma = 1, df, 
  quantiles = NULL, seuil_alpha = NULL,  
  alternative = c("two.sided", "less", "greater"), 
  xlab = "Quantiles", ylab = "Probability density", ...) {
  
  .x <- seq(-4.5*sigma+mu, 4.5*sigma+mu, l = 1000)     # Quantiles
  .d <- function (x) dt((x-mu)/sigma, df = df)/sigma   # Distribution function
  .q <- function (p) qt(p, df = df) * sigma + mu
  
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
    
    if (isTRUE(alternative == "two.sided")) {
      alpha2 <- seuil_alpha/2
      q_ref_left <- mu + sigma * qt(alpha2, df = df, lower.tail = TRUE)
      q_ref_right <- mu + sigma * qt(alpha2, df = df, lower.tail = FALSE)
      
      .x2 <- .x1 <- .x
      .x1[.x1 > q_ref_left] <- NA
      .x2[.x2 < q_ref_right] <- NA
      
      a <- a + 
        ggplot2::geom_ribbon(ggplot2::aes(x = .x1, ymin = 0, ymax = .d(.x1)), 
          fill = "red", alpha = 0.2) +
        ggplot2::geom_ribbon(ggplot2::aes(x = .x2, ymin = 0, ymax = .d(.x2)), 
          fill = "red", alpha = 0.2)
    }
    
    if (isTRUE(alternative == "less")) {
      q_ref_left <- mu + sigma * qt(seuil_alpha, df = df, lower.tail = TRUE)
      .x1 <- .x
      .x1[.x1 > q_ref_left] <- NA
      
      a <- a + 
        ggplot2::geom_ribbon(ggplot2::aes(x = .x1, ymin = 0, ymax = .d(.x1)), 
          fill = "red", alpha = 0.2)
    }
    
    if (isTRUE(alternative == "greater")) {
      q_ref_right <- mu + sigma * qt(seuil_alpha, df = df, lower.tail = FALSE)
      .x2 <- .x
      .x2[.x2 < q_ref_right] <- NA
      
      a <- a + 
        ggplot2::geom_ribbon(ggplot2::aes(x = .x2, ymin = 0, ymax = .d(.x2)), 
          fill = "red", alpha = 0.2)
    }
    
  }
  #print(a)
  a
}
