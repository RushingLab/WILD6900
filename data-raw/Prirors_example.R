rm(list=ls())
SurvPriorDat<-read.csv("data-raw/SurvAF_PublishedKnowledge.csv")

# Functions to derive "optimal" beta priors using mean, uncertainity, and squared error
# NOTE: we could optimize for some other value (median, mode, etc.) or use some other loss function (we use squared error) and end up with different results
# Think critically, try different options, and test sensitivity of posterior distribution to different priors.

#some studies provided mean (CI) and others mean (SE) so, two functions...

#Function 1: derive Beta(a,b) from mean and confidence interval
objective.function.MeanAndCI <- function(params) {
  alpha <- params[1]
  beta <- params[2]
  calculated.quantiles <- qbeta(p=c(0.025, 0.975), shape1=alpha, shape2=beta)
  squared.error.quantiles <- sum((intended.quantiles - calculated.quantiles)^2)
  calculated.mean <- calculate.mean(alpha, beta)
  squared.error.mode <- (intended.mean - calculated.mean)^2
  return(squared.error.quantiles + squared.error.mode)
}

#Function 2: derive Beta(a,b) from mean and variance
objective.function.MeanAndVar <- function(params) {
  alpha <- params[1]
  beta <- params[2]
  calculated.var <- calculate.var(alpha, beta)
  squared.error.var <- (intended.var - calculated.var)^2
  calculated.mean <- calculate.mean(alpha, beta)
  squared.error.mean <- (intended.mean - calculated.mean)^2
  return(squared.error.var + squared.error.mean)
}

#Function 3: mean of Beta distribution
calculate.mean <- function(alpha, beta) {
  return((alpha) / (alpha+beta))}

#Function 4: variance of Beta distribution
calculate.var <- function(alpha, beta){
 return(alpha*beta/((alpha+beta)^2*(alpha+beta+1)))}


intended.mean * ((intended.mean * (1 - intended.mean) / intended.var) - 1)
(1 - intended.mean) * ((intended.mean * (1 - intended.mean) / intended.var) - 1)
#
#
# Option 1. Use means and sd of means as prior (ignores study-specific uncertainity)
#
#

starting.params <- c(150,11) #something reasonable
intended.mean<- round(mean(SurvPriorDat[,"AF"]),2)
intended.var <- round(sd(SurvPriorDat[,"AF"]),2)^2
optim.result <- optim(par=starting.params, fn=objective.function.MeanAndVar)
(alpha.means<-optim.result$par[1])
(beta.means<-optim.result$par[2])





#
#
# Option 2. Incorporate study-specific uncertainity and develop hyper- a & b
#
#

#Solve for best fit study-specific beta priors
starting.params <- c(10,1) #something reasonable (NOTE: there can be some slight sensitivity to these values. Always check!)
#for studies with mean and CI
for(ii in c(2:4,8:9,11:12,14)){
intended.mean<-SurvPriorDat[ii,"AF"]
 intended.quantiles<-c(SurvPriorDat[ii,"AFlci"], SurvPriorDat[ii,"AFuci"])
 optim.result <- optim(par=starting.params, fn=objective.function.MeanAndCI, lower=0, method="L-BFGS-B")
 optimal.alpha <- optim.result$par[1]
 optimal.beta <- optim.result$par[2]
 SurvPriorDat[ii,"AFa"]<-round(optimal.alpha,1)
 SurvPriorDat[ii,"AFb"]<-round(optimal.beta,1)
}

#for studies with mean and se
for(ii in c(1,5:7,10,13)){
 intended.mean<-SurvPriorDat[ii,"AF"]
 intended.var <- SurvPriorDat[ii,"AFse"]^2
 optim.result <- optim(par=starting.params, fn=objective.function.MeanAndVar)
 optimal.alpha <- optim.result$par[1]
 optimal.beta <- optim.result$par[2]
 SurvPriorDat[ii,"AFa"]<-round(optimal.alpha,1)
 SurvPriorDat[ii,"AFb"]<-round(optimal.beta,1)
}

SurvPriorDat

#### Generate values from each study
nsim<-5000
AFprior<-matrix(NA, nr=nsim, nc=dim(SurvPriorDat)[1])
for(j in 1:dim(SurvPriorDat)[1]){
 AFprior[,j] <- rbeta(nsim,SurvPriorDat[j,"AFa"],SurvPriorDat[j,"AFb"])
}


## results
mean(AFprior)
sd(AFprior)
quantile(AFprior, c(0.025,0.975))

#solve for hyper- a & b
intended.mean<-mean(AFprior)
intended.var <- sd(AFprior)^2
optim.result <- optim(par=starting.params, fn=objective.function.MeanAndVar)
optimal.alpha <- optim.result$par[1]
optimal.beta <- optim.result$par[2]
(alpha<-optimal.alpha)
(beta<-optimal.beta)


# plot both approaches
hist((AFprior), freq=F, main="Possible priors", breaks=seq(0,1,.005), xlab="Survival", col="grey35", bord="grey35", ylim=c(0,25), xlim=c(.6,1))
lines(seq(0,1,.001),dbeta(seq(0,1,.001), alpha,beta), col='red', lwd=2)
lines(seq(0,1,.001),dbeta(seq(0,1,.001), alpha.means,beta.means), col='blue', lwd=2)
legend("topleft", c("Simulated data", "Approach 1 prior", "Approach 2 prior"),text.col=c("grey35","blue","red"), bty='n')


#expected values for option 1
calculate.mean(alpha.means, beta.means)         # mean
sqrt(calculate.var(alpha.means, beta.means))    # sd
qbeta(c(0.025,0.975), alpha.means,beta.means)   # 2.5th and 97.5th quantiles


#expected values for option 2
calculate.mean(alpha, beta)                     # mean
sqrt(calculate.var(alpha, beta))                # sd
qbeta(c(0.025,0.975), alpha,beta)               # 2.5th and 97.5th quantiles





