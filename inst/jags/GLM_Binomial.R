sink("inst/jags/GLM_Binomial.jags")
cat("
model {

  # Priors
  alpha ~ dnorm(0, 0.33)
  beta1 ~ dnorm(0, 0.33)
  beta2 ~ dnorm(0, 0.33)

# Likelihood
for (i in 1:nyears){
   C[i] ~ dbin(p[i], N[i])          # 1. Distribution for random part
   logit(p[i]) <- alpha + beta1 * year[i] + beta2 * pow(year[i],2) # link function and linear predictor
   }
}
",fill = TRUE)
sink()