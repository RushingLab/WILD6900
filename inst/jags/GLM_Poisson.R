sink("inst/jags/GLM_Poisson.jags")
cat("
    model {

    # Priors
    alpha ~ dnorm(0, 0.33)
    beta1 ~ dnorm(0, 0.33)
    beta2 ~ dnorm(0, 0.33)
    beta3 ~ dnorm(0, 0.33)

    # Likelihooda
    for (i in 1:n){
      C[i] ~ dpois(lambda[i])
      log(lambda[i]) <- alpha + beta1 * year[i] + beta2 * pow(year[i],2) + beta3 * pow(year[i],3)
    } #i
    }
    ",fill = TRUE)
sink()
