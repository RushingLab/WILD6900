% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sim_Nmix.R
\name{sim_Nmix}
\alias{sim_Nmix}
\title{sim_Nmix}
\usage{
sim_Nmix(J = 200, K = 3, alpha = c(1, 3), beta = c(0, -5))
}
\arguments{
\item{J:}{number of sites at which counts were made}

\item{K:}{number of times that counts were made at each site}

\item{alpha:}{vector containing the intercept and slopes of log-linear regression relating abundance to the site covariate A}

\item{beta:}{ivector containing the intercept and slopes of logistic-linear regression of detection probability on B}
}
\value{
List containing the simulated data (y, XN, Xp) and the data-generating values
}
\description{
Simulate data for the N-mixture model with site-level covariats on lambda and occasion-level covariates on p
}
