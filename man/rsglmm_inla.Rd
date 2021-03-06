% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rsglmm_inla.R
\name{rsglmm_inla}
\alias{rsglmm_inla}
\title{Restricted Spatial Generalized Linear Mixed model in INLA}
\usage{
rsglmm_inla(
  data,
  formula,
  family,
  E = NULL,
  n = NULL,
  W = NULL,
  proj = "none",
  nsamp = 1000,
  ...
)
}
\arguments{
\item{data}{an data frame or list containing the variables in the model.}

\item{formula}{an object of class "formula" (or one that can be coerced to that class): a symbolic description of the model to be fitted.}

\item{family}{some allowed families are: 'gaussian', 'poisson' and 'binomial'. The family availability will depend on the approach.}

\item{E}{known component, in the mean for the Poisson likelihoods defined as E = exp(\eqn{\eta}), where \eqn{\eta} is the linear predictor. If not provided it is set to 1.}

\item{n}{a vector containing the number of trials for the binomial likelihood and variantes, or the number of required successes for the nbinomial2 likelihood. Default value is set to 1..}

\item{W}{adjacency matrix.}

\item{proj}{'none', 'rhz' or 'spock'}

\item{nsamp}{number of desired. samples Default = 1000.}

\item{...}{other parameters used in ?INLA::inla}
}
\value{
\item{$unrestricted}{A list containing
                               \itemize{
                                  \item $sample a sample of size nsamp for all parameters in the model
                                  \item $summary_fixed summary measures for the coefficients
                                  \item $summary_hyperpar summary measures for hyperparameters
                                  \item $summary_random summary measures for random quantities
                                }
                             }
\item{$restricted}{A list containing
                               \itemize{
                                  \item $sample a sample of size nsamp for all parameters in the model
                                  \item $summary_fixed summary measures for the coefficients
                                  \item $summary_hyperpar summary measures for hyperparameters
                                  \item $summary_random summary measures for random quantities
                                }
                             }

\item{$out}{INLA output}
\item{$time}{time elapsed for fitting the model}
}
\description{
Fit a Restricted Spatial Generalized Linear Mixed model using INLA
}
