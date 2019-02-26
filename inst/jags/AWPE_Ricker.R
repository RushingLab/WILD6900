sink("inst/jags/AWPE_Ricker.jags")
cat("
    model{
    # Priors
    logN.est[1] ~ dunif(0, 10)         # Prior for initial population size
    r0 ~ dgamma(1, 1)            # Prior for r0
    K ~ dgamma(0.001, 0.001)           # Prior for K

    sigma.obs ~ dgamma(1, 1)      # Prior for sd of observation processes
    tau.obs <- pow(sigma.obs, -2)

    for(t in 1:nYears){
      epsilon[t] ~ dnorm(0, tau.proc)
    }

    sigma.proc ~ dgamma(1, 1)      # Prior for sd of observation processes
    tau.proc <- pow(sigma.proc, -2)

    b <- r0/K

    # Likelihood

    for (t in 1:(nYears-1)){
      logN.est[t+1] <- logN.est[t] + r0 - b * N.est[t] + epsilon[t]
    }

    # Observation process
    for (t in 1:nYears){
      y[t] ~ dnorm(logN.est[t], tau.obs)
    }

    # Population sizes on real scale
    for (t in 1:nYears){
     N.est[t] <- exp(logN.est[t])
    }
    }
    ", fill = TRUE)

sink()
