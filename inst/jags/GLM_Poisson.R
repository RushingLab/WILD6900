sink("inst/jags/GLM_Poisson.jags")
cat("
    model {
    
    # Priors
    alpha ~ dnorm(0, 0.33)
    beta1 ~ dnorm(0, 0.33)
    beta2 ~ dnorm(0, 0.33)
    beta3 ~ dnorm(0, 0.33)
    
    # Likelihood: Note key components of a GLM on one line each
    for (i in 1:n){
      C[i] ~ dpois(lambda[i])          # 1. Distribution for random part
      log(lambda[i]) <- alpha + beta1 * year[i] + beta2 * pow(year[i],2) + beta3 * pow(year[i],3)                      # 3. Linear predictor
    } #i
    }
    ",fill = TRUE)
sink()