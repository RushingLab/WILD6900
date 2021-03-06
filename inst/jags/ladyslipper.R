sink("inst/jags/ladyslipper.jags")
cat("
    model {

    # -------------------------------------------------
    # Parameters:
    # s: survival probability
    # psiV: transitions from vegetative
    # psiF: transitions from flowering
    # psiD: transitions from dormant
    # -------------------------------------------------
    # States (S):
    # 1 vegetative
    # 2 flowering
    # 3 dormant
    # 4 dead
    # Observations (O):
    # 1 seen vegetative
    # 2 seen flowering
    # 3 not seen
    # -------------------------------------------------

    # Priors and constraints
    # Survival: uniform
    for (t in 1:(n.occasions-1)){
    s[t] ~ dunif(0, 1)
    }
    # Transitions: gamma priors
    for (i in 1:3){
    a[i] ~ dgamma(1, 1)
    psiD[i] <- a[i]/sum(a[])
    b[i] ~ dgamma(1, 1)
    psiV[i] <- b[i]/sum(b[])
    c[i] ~ dgamma(1, 1)
    psiF[i] <- c[i]/sum(c[])
    }

    # Define state-transition and observation matrices
    # Define probabilities of state S(t+1) given S(t)
    for (t in 1:(n.occasions-1)){
    ps[1,t,1] <- s[t] * psiV[1]
    ps[1,t,2] <- s[t] * psiV[2]
    ps[1,t,3] <- s[t] * psiV[3]
    ps[1,t,4] <- 1-s[t]
    ps[2,t,1] <- s[t] * psiF[1]
    ps[2,t,2] <- s[t] * psiF[2]
    ps[2,t,3] <- s[t] * psiF[3]
    ps[2,t,4] <- 1-s[t]
    ps[3,t,1] <- s[t] * psiD[1]
    ps[3,t,2] <- s[t] * psiD[2]
    ps[3,t,3] <- s[t] * psiD[3]
    ps[3,t,4] <- 1-s[t]
    ps[4,t,1] <- 0
    ps[4,t,2] <- 0
    ps[4,t,3] <- 0
    ps[4,t,4] <- 1

    # Define probabilities of O(t) given S(t)
    po[1,t,1] <- 1
    po[1,t,2] <- 0
    po[1,t,3] <- 0
    po[2,t,1] <- 0
    po[2,t,2] <- 1
    po[2,t,3] <- 0
    po[3,t,1] <- 0
    po[3,t,2] <- 0
    po[3,t,3] <- 1
    po[4,t,1] <- 0
    po[4,t,2] <- 0
    po[4,t,3] <- 1
    } #t

    # Likelihood
    for (i in 1:nind){
    # Define latent state at first capture
    z[i,f[i]] <- y[i,f[i]]
    for (t in (f[i]+1):n.occasions){
    # State process: draw S(t) given S(t-1)
    z[i,t] ~ dcat(ps[z[i,t-1], t-1,])
    # Observation process: draw O(t) given S(t)
    y[i,t] ~ dcat(po[z[i,t], t-1,])
    } #t
    } #i
    }
    ",fill=TRUE)
sink()
