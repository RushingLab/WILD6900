sink("inst/jags/integrated_Nocc.jags")
cat("
model{
    alpha0 ~ dnorm(0, 0.1)
    alpha1 ~ dnorm(0, 0.1)
    
    p ~ dbeta(1, 1)
    
    # Likelihood
    for(j in 1:J){
    N[j] ~ dpois(lambda[j])
    log(lambda[j]) <- alpha0 + alpha1 * x[j]
    }
    
    for(j in 1:J.count){
    for(k in 1:K.count){
    y.count[j, k] ~ dbin(p, N[j])
    }
    }
    
    for(j in 1:J.occ){
    psi[j] <- 1 - pow((1 - p), N[(J.count + j)])
    # for(k in 1:K.occ){
    y.occ[j] ~ dbern(psi[j])
    # }
    }
}
    ", fill = TRUE)
sink()

