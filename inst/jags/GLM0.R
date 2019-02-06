sink("inst/jags/GLM0.jags")
cat("
    model {

    # Prior
    alpha ~ dnorm(0, 0.01)    # log(mean count)

    # Likelihood
    for (i in 1:nyear){
    for (j in 1:nsite){
    C[i,j] ~ dpois(lambda[i,j])
    lambda[i,j] <- exp(log.lambda[i,j])
    log.lambda[i,j] <- alpha
    }  #j
    }  #i
    }
    ",fill = TRUE)
sink()
