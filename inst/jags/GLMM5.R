sink("inst/jags/GLMM5.jags")
cat("
    model {

    # Priors
    mu ~ dnorm(0, 0.01)                  # Overall intercept
    beta1 ~ dnorm(0, 0.01)               # Overall trend
    beta2 ~ dnorm(0, 0.01)               # First-year observer effect

    for (j in 1:nsite){
    alpha[j] ~ dnorm(0, tau.alpha)    # Random site effects
    }
    tau.alpha <- 1/ (sd.alpha * sd.alpha)
    sd.alpha ~ dunif(0, 3)

    for (i in 1:nyear){
    eps[i] ~ dnorm(0, tau.eps)        # Random year effects
    }
    tau.eps <- 1/ (sd.eps * sd.eps)
    sd.eps ~ dunif(0, 1)

    for (k in 1:nobs){
    gamma[k] ~ dnorm(0, tau.gamma)   # Random observer effects
    }
    tau.gamma <- 1/ (sd.gamma * sd.gamma)
    sd.gamma ~ dunif(0, 1)

    # Likelihood
    for (i in 1:nyear){
    for (j in 1:nsite){
    C[i,j] ~ dpois(lambda[i,j])
    lambda[i,j] <- exp(log.lambda[i,j])
    log.lambda[i,j] <- mu + beta1 * year[i] + beta2 * first[i,j] + alpha[j] + gamma[newobs[i,j]] + eps[i]
    }  #j
    }  #i
    }
    ",fill = TRUE)
sink()
