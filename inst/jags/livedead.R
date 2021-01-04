sink("livedead.bug")
cat("
    model {

    # -------------------------------------------------
    # Parameters:
    # s: true survival probability
    # F: fidelity probability
    # r: recovery probability
    # p: recapture/resighting probability
    # -------------------------------------------------
    # States (S):
    # 1 alive in study area
    # 2 alive outside study area
    # 3 recently dead and recovered
    # 4 recently dead, but not recovered, or dead (absorbing)
    # Observations (O):
    # 1 seen alive
    # 2 recovered dead
    # 3 neither seen nor recovered
    # -------------------------------------------------

    # Priors and constraints
    for (t in 1:(n.occasions-1)){
    s[t] <- mean.s
    F[t] <- mean.f
    r[t] <- mean.r
    p[t] <- mean.p
    }
    mean.s ~ dunif(0, 1)     # Prior for mean survival
    mean.f ~ dunif(0, 1)     # Prior for mean fidelity
    mean.r ~ dunif(0, 1)     # Prior for mean recovery
    mean.p ~ dunif(0, 1)     # Prior for mean recapture

    # Define state-transition and observation matrices
    for (i in 1:nind){
    # Define probabilities of state S(t+1) given S(t)
    for (t in f[i]:(n.occasions-1)){
    ps[1,i,t,1] <- s[t]*F[t]
    ps[1,i,t,2] <- s[t]*(1-F[t])
    ps[1,i,t,3] <- (1-s[t])*r[t]
    ps[1,i,t,4] <- (1-s[t])*(1-r[t])
    ps[2,i,t,1] <- 0
    ps[2,i,t,2] <- s[t]
    ps[2,i,t,3] <- (1-s[t])*r[t]
    ps[2,i,t,4] <- (1-s[t])*(1-r[t])
    ps[3,i,t,1] <- 0
    ps[3,i,t,2] <- 0
    ps[3,i,t,3] <- 0
    ps[3,i,t,4] <- 1
    ps[4,i,t,1] <- 0
    ps[4,i,t,2] <- 0
    ps[4,i,t,3] <- 0
    ps[4,i,t,4] <- 1

    # Define probabilities of O(t) given S(t)
    po[1,i,t,1] <- p[t]
    po[1,i,t,2] <- 0
    po[1,i,t,3] <- 1-p[t]
    po[2,i,t,1] <- 0
    po[2,i,t,2] <- 0
    po[2,i,t,3] <- 1
    po[3,i,t,1] <- 0
    po[3,i,t,2] <- 1
    po[3,i,t,3] <- 0
    po[4,i,t,1] <- 0
    po[4,i,t,2] <- 0
    po[4,i,t,3] <- 1
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
