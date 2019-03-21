sink("inst/jags/salamander_Nmixture_ZIP_OD.jags")
cat("
model{
    # Priors
    omega ~ dbeta(1, 1)
    lambda ~ dgamma(0.25, 0.25)
    beta0 ~ dnorm(0, 0.1)
    beta1 ~ dnorm(0, 0.1)

    tau.p <- pow(sd.p, -2)
    sd.p ~ dunif(0, 3)

    # Likelihood
    for(j in 1:J){
      z[j] ~ dbern(omega)
      N[j] ~ dpois(lambda * z[j])

      for(k in 1:K){
        y[j, k] ~ dbinom(p[j, k], N[j])
        logit(p[j, k]) <- lp[j, k]
        mu.lp[j, k] <- beta0 + beta1 * hours[j,k]
        lp[j, k] ~ dnorm(mu.lp[j, k], tau.p)

        exp[j, k] <- N[j] * p[j, k]
        E[j, k] <- pow((y[j, k] - exp[j, k]), 2) / (exp[j, k] + 0.5)

        y.rep[j, k] ~ dbinom(p[j, k], N[j])
        E.rep[j, k] <- pow((y.rep[j, k] - exp[j, k]), 2) / (exp[j, k] + 0.5)
      } # end k loop
    } # end j loop

    # Derived variables
    fit <- sum(E[,])
    fit.rep <- sum(E.rep[,])
}
    ", fill = TRUE)
sink()

