sink("inst/jags/tempem.jags")
cat("
    model {

    # ---------------------------------
    # Parameters:
    # phi: survival probability
    # psiIO: probability to emigrate
    # psiOI: probability to immigrate
    # p: recapture probability
    # ---------------------------------
    # States (S):
    # 1 alive and present
    # 2 alive and absent
    # 3 dead
    # Observations (O):
    # 1 seen
    # 2 not seen
    # ---------------------------------

    # Priors and constraints
    phi ~ dunif(0, 1)
    psiIO ~ dunif(0, 1)
    psiOI ~ dunif(0, 1)
    p ~ dunif(0, 1)


    # Define state-transition and observation matrices
    # Define probabilities of state S(t+1) given S(t)
    ps[1,1] <- phi * (1-psiIO)
    ps[1,2] <- phi * psiIO
    ps[1,3] <- 1-phi
    ps[2,1] <- phi * psiOI
    ps[2,2] <- phi * (1-psiOI)
    ps[2,3] <- 1-phi
    ps[3,1] <- 0
    ps[3,2] <- 0
    ps[3,3] <- 1

    # Define probabilities of O(t) given S(t)
    po[1,1] <- p
    po[1,2] <- 1-p
    po[2,1] <- 0
    po[2,2] <- 1
    po[3,1] <- 0
    po[3,2] <- 1


    # Likelihood
    for (i in 1:nind){
    # Define latent state at first capture
    z[i,f[i]] <- y[i,f[i]]
    for (t in (f[i]+1):n.occasions){
    # State process: draw S(t) given S(t-1)
    z[i,t] ~ dcat(ps[z[i,t-1],])
    # Observation process: draw O(t) given S(t)
    y[i,t] ~ dcat(po[z[i,t], )
    } #t
    } #i
    }
    ",fill = TRUE)
sink()
