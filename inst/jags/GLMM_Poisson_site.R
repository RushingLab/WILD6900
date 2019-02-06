sink("inst/jags/GLMM_Poisson_site.jags")
cat("
    model {

    # Priors
    for (j in 1:nsite){
    alpha[j] ~ dnorm(mu, tau.alpha)		# 4. Random site effects
    }
    mu ~ dnorm(0, 0.01)				# Hyperparameter 1
    tau.alpha <- 1 / (sd.alpha*sd.alpha)	# Hyperparameter 2
    sd.alpha ~ dunif(0, 2)
    for (p in 1:3){
    beta[p] ~ dnorm(0, 0.01)
    }

    tau.year <- 1 / (sd.year*sd.year)
    sd.year ~ dunif(0, 1)				# Hyperparameter 3

    # Likelihood
    for (i in 1:nyear){
    eps[i] ~ dnorm(0, tau.year)            # 4. Random year effects
    for (j in 1:nsite){
    C[i,j] ~ dpois(lambda[i,j])         # 1. Distribution for random part
    lambda[i,j] <- exp(log.lambda[i,j]) # 2. Link function
    log.lambda[i,j] <- alpha[j] + beta[1] * year[i] + beta[2] * pow(year[i],2) + beta[3] * pow(year[i],3) + eps[i]    # 3. Linear predictor including random site and random year effects
    }  #j
    }  #i
    }
    ",fill = TRUE)
sink()
