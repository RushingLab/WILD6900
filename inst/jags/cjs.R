sink("inst/jags/cjs.jags")
cat("
model{
    phi ~ dbeta(1, 1)
    p ~ dbeta(1, 1)
    
    # Likelihood
    for(i in 1:N){
      z[i,f[i]] <- 1
      for (t in (f[i]+1):n.occasions){
        # State process
        z[i,t] ~ dbern(phi * z[i,t-1])

        # Observation process
        y[i,t] ~ dbern(p * z[i,t])
      } #t
   } #i
}
    ", fill = TRUE)
sink()

