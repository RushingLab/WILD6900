sink("inst/jags/N-mixture.jags")
cat("
    model{
    # Priors
    lambda ~ dgamma(0.01, 0.01)
    p ~ dbeta(1, 1)

    # Likelihood
    for(j in 1:J){
     N[j] ~ dpois(lambda)

     for(k in 1:K){
      y[j, k] ~ dbinom(p, N[j])
     }
    }
    
    } # End model
    ", fill = TRUE)

sink()
