sink("inst/jags/GLMM1.jags")
cat("
    model {

    # Priors
    for (j in 1:nsite){
    alpha[j] ~ dnorm(mu.alpha, tau.alpha)   # Random site effects
    }
    mu.alpha ~ dnorm(0, 0.01)
    tau.alpha <- 1/ (sd.alpha * sd.alpha)
    sd.alpha ~ dunif(0, 5)

    # Likelihood
    for (i in 1:nyear){
    for (j in 1:nsite){
    C[i,j] ~ dpois(lambda[i,j])
    lambda[i,j] <- exp(log.lambda[i,j])
    log.lambda[i,j] <- alpha[j]
    }  #j
    }  #i
    }
    ",fill = TRUE)
sink()
