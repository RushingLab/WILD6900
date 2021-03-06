sink("inst/jags/GLM_Binomial.jags")
cat("
model {

  # Priors
  alpha ~ dnorm(0, 0.33)
  beta1 ~ dnorm(0, 0.33)
  beta2 ~ dnorm(0, 0.33)

# Likelihood
for (i in 1:nyears){
   C[i] ~ dbin(p[i], N[i])
   logit(p[i]) <- alpha + beta1 * year[i] + beta2 * pow(year[i],2)
   }
}
",fill = TRUE)
sink()
