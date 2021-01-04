sink("inst/jags/ms3.jags")
cat("
    model {

    # -------------------------------------------------
    # Parameters:
    # phiA: survival probability at site A
    # phiB: survival probability at site B
    # phiC: survival probability at site C
    # psiAB: movement probability from site A to site B
    # psiAC: movement probability from site A to site C
    # psiBA: movement probability from site B to site A
    # psiBC: movement probability from site B to site C
    # psiCA: movement probability from site C to site A
    # psiCB: movement probability from site C to site B
    # pA: recapture probability at site A
    # pB: recapture probability at site B
    # pC: recapture probability at site C
    # -------------------------------------------------
    # States (S):
    # 1 alive at A
    # 2 alive at B
    # 3 alive at C
    # 4 dead
    # Observations (O):
    # 1 seen at A
    # 2 seen at B
    # 3 seen at C
    # 4 not seen
    # -------------------------------------------------

    # Priors and constraints
    # Survival and recapture: uniform
    phiU ~ dunif(0, 1)
    phiI ~ dunif(0, 1)
    phiR ~ dunif(0, 1)
    pU ~ dunif(0, 1)
    pI ~ dunif(0, 1)
    pR ~ dunif(0, 1)

    psiUI ~ dunif(0, 1)
    psiIR ~ dunif(0, 1)


    # Define state-transition and observation matrices
    for (i in 1:nind){
    # Define probabilities of state S(t+1) given S(t)
    for (t in f[i]:(n.occasions-1)){
    ps[1,i,t,1] <- phiU * (1 - psiUI)
    ps[1,i,t,2] <- phiU * psiUI
    ps[1,i,t,3] <- 0
    ps[1,i,t,4] <- 1-phiU
    ps[2,i,t,1] <- 0
    ps[2,i,t,2] <- phiI * (1 - psiIR)
    ps[2,i,t,3] <- phiI * psiIR
    ps[2,i,t,4] <- 1-phiI
    ps[3,i,t,1] <- 0
    ps[3,i,t,2] <- 0
    ps[3,i,t,3] <- phiR
    ps[3,i,t,4] <- 1-phiR
    ps[4,i,t,1] <- 0
    ps[4,i,t,2] <- 0
    ps[4,i,t,3] <- 0
    ps[4,i,t,4] <- 1

    # Define probabilities of O(t) given S(t)
    po[1,i,t,1] <- pU
    po[1,i,t,2] <- 0
    po[1,i,t,3] <- 0
    po[1,i,t,4] <- 1-pU
    po[2,i,t,1] <- 0
    po[2,i,t,2] <- pI
    po[2,i,t,3] <- 0
    po[2,i,t,4] <- 1-pI
    po[3,i,t,1] <- 0
    po[3,i,t,2] <- 0
    po[3,i,t,3] <- pR
    po[3,i,t,4] <- 1-pR
    po[4,i,t,1] <- 0
    po[4,i,t,2] <- 0
    po[4,i,t,3] <- 0
    po[4,i,t,4] <- 1
    } #t
    } #i

    # Likelihood
    for (i in 1:nind){
    # Define latent state at first capture
    z[i,f[i]] <- y[i,f[i]]
    for (t in (f[i]+1):n.occasions){
    # State process: draw S(t) given S(t-1)
    z[i,t] ~ dcat(ps[z[i,t-1], i, t-1,])
    # Observation process: draw O(t) given S(t)
    y[i,t] ~ dcat(po[z[i,t], i, t-1,])
    } #t
    } #i
    }
    ",fill = TRUE)
sink()
