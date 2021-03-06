% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rscm.R
\name{rscm}
\alias{rscm}
\title{Restricted Shared Component model}
\usage{
rscm(data, formula1, formula2, family = c("poisson", "poisson"),
            E1 = NULL, E2 = NULL, area = NULL, neigh = NULL,
            proj = "none", nsamp = 1000,
            priors = list(prior_gamma = c(0, 0.1),
                          prior_prec = list(tau_s = c(0.5, 0.05),
                                            tau_1 = c(0.5, 0.05),
                                            tau_2 = c(0.5, 0.05))),
            random_effects = list(shared = TRUE,
                                  specific_1 = TRUE,
                                  specific_2 = TRUE),
            ...)
}
\arguments{
\item{data}{an data frame or list containing the variables in the model.}

\item{formula1}{an object of class "formula" (or one that can be coerced to that class): a symbolic description of the model to be fitted for disease 1.}

\item{formula2}{an object of class "formula" (or one that can be coerced to that class): a symbolic description of the model to be fitted for disease 2.}

\item{family}{a vector of size two with two families. Some allowed families are: poisson, nbinomial, zeroinflatedpoisson0, zeroinflatednbinomial0. See INLA::inla.list.models().}

\item{E1}{known component, for disease 1, in the mean for the Poisson likelihoods defined as E = exp(\eqn{\eta}), where \eqn{\eta} is the linear predictor. If not provided it is set to 1.}

\item{E2}{known component, for disease 2, in the mean for the Poisson likelihoods defined as E = exp(\eqn{\eta}), where \eqn{\eta} is the linear predictor. If not provided it is set to 1.}

\item{area}{areal variable name in \code{data}.}

\item{neigh}{neighborhood structure. A \code{SpatialPolygonsDataFrame} object.}

\item{proj}{'none' or 'spock'.}

\item{nsamp}{number of desired. samples Default = 1000.}

\item{priors}{a list containing:
\itemize{
   \item prior_gamma: a vector of size two containing mean and precision for the normal distribution applied for \eqn{\gamma}
   \item prior_prec: a list with:
   \itemize{
       \item tau_s: a vector of size two containing shape and scale for the gamma distribution applied for \eqn{\tau_s}
       \item tau_1: a vector of size two containing shape and scale for the gamma distribution applied for \eqn{\tau_1}
       \item tau_2: a vector of size two containing shape and scale for the gamma distribution applied for \eqn{\tau_2}
   }
}}

\item{random_effects}{a list determining which effects should we include in the model. Default: list(shared = TRUE, specific_1 = TRUE, specific_2 = TRUE).}

\item{...}{other parameters used in ?INLA::inla}
}
\value{
\item{$sample}{a sample of size nsamp for all parameters in the model}
\item{$summary_fixed}{summary measures for the coefficients}
\item{$summary_hyperpar}{summary measures for hyperparameters}
\item{$summary_random}{summary measures for random quantities}
\item{$out}{INLA output}
\item{$time}{time elapsed for fitting the model}
}
\description{
Fit a Restricted Shared Component model for two diseases
}
\details{
The fitted model is given by
\deqn{Y_1 ~ Poisson(E_1\theta_1),}
\deqn{Y_2 ~ Poisson(E_2\theta_2),}

\deqn{log(\theta_1) = X\beta + \gamma\psi + \phi_1,}
\deqn{log(\theta_2) = X\beta + \psi + \phi_2,}

\deqn{\psi ~ ICAR(\tau_s); \phi_1 ~ ICAR(\tau_1); \phi_2 ~ ICAR(\tau_2).}

\deqn{\delta = \sqrt\gamma}
}
\examples{
library(spdep)

set.seed(123456)

##-- Spatial structure
data("neigh_RJ")

##-- Parameters
alpha_1 <- 0.5
alpha_2 <- 0.1
beta_1 <- c(-0.5, -0.2)
beta_2 <- c(-0.8, -0.4)
tau_s <- 1
tau_1 <- tau_2 <- 10
delta <- 1.5

##-- Data
data <- rshared(alpha_1 = alpha_1, alpha_2 = alpha_2,
                beta_1 = beta_1, beta_2 = beta_2,
                delta = delta,
                tau_1 = tau_1, tau_2 = tau_2, tau_s = tau_s,
                confounding = "linear",
                neigh = neigh_RJ)

##-- Models
scm_inla <- rscm(data = data,
                 formula1 = Y1 ~ X11 + X12,
                 formula2 = Y2 ~ X21 + X12,
                 family = c("nbinomial", "poisson"),
                 E1 = E1, E2 = E2,
                 area = "reg", neigh = neigh_RJ,
                 priors = list(prior_prec = list(tau_s = c(0.5, 0.05)), prior_gamma = c(0, 0.5)),
                 proj = "none", nsamp = 1000,
                 random_effects = list(shared = TRUE, specific_1 = TRUE, specific_2 = TRUE))

rscm_inla <- rscm(data = data,
                  formula1 = Y1 ~ X11 + X12,
                  formula2 = Y2 ~ X21 + X12,
                  family = c("nbinomial", "poisson"),
                  E1 = E1, E2 = E2,
                  area = "reg", neigh = neigh_RJ,
                  priors = list(prior_prec = list(tau_s = c(0.5, 0.05)), prior_gamma = c(0, 0.5)),
                  proj = "spock", nsamp = 1000,
                  random_effects = list(shared = TRUE, specific_1 = TRUE, specific_2 = TRUE))

##-- Summary
scm_inla$summary_fixed
rscm_inla$summary_fixed

scm_inla$summary_hyperpar
rscm_inla$summary_hyperpar

}
