sink("AWPE_ssm.jags")
cat("
    model{
    # Priors
    logN.est[1] ~ dnorm(0, 0.01)      # Prior for initial population size
    mean.r ~ dnorm(1, 0.001)          # Prior for the mean growth rate
    sigma.proc ~ dunif(0, 10)         # Prior for sd of state processes
    sigma2.proc <- pow(sigma.proc, 2)
    tau.proc <- pow(sigma.proc, -2)
    sigma.obs ~ dunif(0, 10)          # Prior for sd of observation processes
    sigma2.obs <- pow(sigma.obs, 2)
    tau.obs <- pow(sigma.obs, -2)


    # Likelihood
    # State process
    for (t in 1:(T-1)){
      r[t] ~ dnorm(mean.r, tau.proc)
      logN.est[t+1] <- logN.est[t] + r[t]
    }

    # Observation process
    for (t in 1:T){
      y[t] ~ dnorm(logN.est[t], tau.obs)
    }

    # Population sizes on real scale
    for (t in 1:T){
     N.est[t] <- exp(logN.est[t])
    }
    }
    ", fill = TRUE)

sink()
