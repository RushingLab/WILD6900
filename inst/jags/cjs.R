sink("inst/jags/cjs.jags")
cat("
model{
  # Priors
   phi ~ dbeta(1, 1)
   p ~ dbeta(1, 1)

  # Likelihood
  for(i in 1:nInd){
   # Known to be alive on first occasion
   z[i, f1[i]] <- 1

   for(t in (f1[i] + 1):nOcc){
    # State model
    z[i, t] ~ dbern(phi * z[i, t - 1])

    # Observation model
    y[i, t] ~ dbern(p * z[i, t])
   } # end t loop
  } # end i loop
} # end model
    ", fill = TRUE)
sink()
