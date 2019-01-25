sink(file="inst/jags/linear_regression.jags")
cat("
  model{
    ## Priors
    alpha ~ dnorm(0, 0.001)
    beta ~ dnorm(0, 0.001)
    tau ~ dgamma(.001,.001) # Precision
    sigma <- 1/sqrt(tau)      # Calculate sd from precision
    ## Likelihood
    for(i in 1:N){
      mu[i] <- alpha + beta * x[i]
      y[i] ~ dnorm(mu[i], tau)
    }
  } #end of model
    ", fill=TRUE)
sink()
