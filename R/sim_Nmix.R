#' sim_Nmix
#'
#' Simulate data for the N-mixture model with site-level covariats on lambda and occasion-level covariates on p
#' @param J: number of sites at which counts were made
#' @param K: number of times that counts were made at each site 
#' @param alpha: vector containing the intercept and slopes of log-linear regression relating abundance to the site covariate A
#' @param beta: ivector containing the intercept and slopes of logistic-linear regression of detection probability on B
#' @return List containing the simulated data (y, XN, Xp) and the data-generating values
#'  
sim_Nmix <- function(J = 200, K = 3, alpha = c(1,3), beta = c(0, -5)){
  y <- array(dim = c(J, K))	# Array for counts
  
  # Ecological process
  # Covariate values: sort for ease of presentation
  XN <- rep(1, J)
  for(i in 1:(length(alpha)-1)){
    XN <- cbind(XN, rnorm(n = J))
  }
  
  # Relationship expected abundance ñ covariate
  lam <- exp(XN %*% alpha)
  
  # Add Poisson noise: draw N from Poisson(lambda)
  N <- rpois(n = J, lambda = lam)
  totalN <- sum(N)
  
  # Observation process
  # Relationship detection prob ñ covariate
  Xp <- rep(1, K)
  for(i in 1:(length(beta)-1)){
    Xp <- cbind(Xp, rnorm(n = K))
  }
  p <- plogis(Xp %*% beta)
  
  for(j in 2:J){
    Xp.temp <- rep(1, K)
    for(i in 1:(length(beta)-1)){
      Xp.temp <- cbind(Xp.temp, rnorm(n = K))
    }
    p <- cbind(p, plogis(Xp.temp %*% beta))
    Xp <- abind::abind(Xp, Xp.temp, along = 3)
  }

  p <- t(p)
  # Make
  for (i in 1:K){
    y[,i] <- rbinom(n = J, size = N, prob = p[,i])
  }
  
  # Return stuff
  return(list(J = J, K = K, XN = XN, Xp = Xp, 
              alpha = alpha, beta = beta, 
              lam = lam, N = N, 
              totalN = totalN, p = p, y = y,
              nAlpha = length(alpha), nBeta = length(beta)))
}