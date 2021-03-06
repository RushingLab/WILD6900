sink("inst/jags/ssm.jags")
cat("
model { 
    # Priors and constraints
    N.est[1] ~ dunif(0, 500)  # Initial population size

    for (t in 1:(nYears-1)){
      lambda[t] ~ dnorm(mu.lambda, tau.lambda) 
    }

    mu.lambda ~ dnorm(0, 0.1)          # Mean growth rate
    sigma.lambda ~ dgamma(0.25, 0.25)  # SD of state process
    tau.lambda <- pow(sigma.lambda, -2)
    
    sigma.obs ~ dgamma(0.25, 0.25)     # SD of observation process
    tau.obs <- pow(sigma.obs, -2)
  

    # Likelihood
    # State process
    for (t in 1:(nYears-1)){
      N.est[t+1] <- N.est[t] * lambda[t] 
    }
    # Observation process
    for (t in 1:nYears) {
      y[t] ~ dnorm(N.est[t], tau.obs)
    }
    }
    ", fill = TRUE)
sink()