sink("inst/jags/fixed_ancova.jags")
cat("
    model {
    
    # Priors
    for(j in 1:J){
      alpha[j] ~ dnorm(0, 0.01)
    }

    beta ~ dnorm(0, 0.01)
    tau ~ dgamma(0.01, 0.01)
    sigma <- pow(tau, -2)
    
    # Likelihood: Note key components of a GLM on one line each
    for (i in 1:N){
      y[i] ~ dnorm(mu[i], tau)        
      mu[i] <- alpha[plot[i]] + beta * x[i]
    } #i
    }
    ",fill = TRUE)
sink()