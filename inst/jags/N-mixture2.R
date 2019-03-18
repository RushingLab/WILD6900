sink("inst/jags/N-mixture2.jags")
cat("
    model{
    # Priors
    for(i in 1:nAlpha){
      alpha[i] ~ dnorm(0, 0.1)
    }

    for(i in 1:nBeta){
      beta[i] ~ dnorm(0, 0.1)
    }

    # Likelihood
    for(j in 1:J){
     N[j] ~ dpois(lambda[j])
     log(lambda[j]) <- sum(alpha * XN[j, ])

     for(k in 1:K){
      y[j, k] ~ dbinom(p[j, k], N[j])
      logit(p[j, k]) <- sum(beta * Xp[k, , j])
     }
    }
    
    } # End model
    ", fill = TRUE)

sink()
