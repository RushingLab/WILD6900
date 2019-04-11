sink("inst/jags/cjs_group.jags")
cat("
    model{
    # Priors
    phi[1] ~ dbeta(1, 1)
    phi[2] ~ dbeta(1, 1)
    p ~ dbeta(1, 1)

    # Likelihood
    for(i in 1:nInd){
    # Known to be alive on first occasion
    z[i, f1[i]] <- 1

    for(t in (f1[i] + 1):nOcc){
    # State model
    z[i, t] ~ dbern(phi[sex[i]] * z[i, t - 1])

    # Observation model
    y[i, t] ~ dbern(p * z[i, t])
    } # end t loop
    } # end i loop

    # Derived parameters
    delta.phi <- phi[1] - phi[2]
    } # end model
    ", fill = TRUE)
sink()
