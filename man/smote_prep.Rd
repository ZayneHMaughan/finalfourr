% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/smote_prep.R
\docType{data}
\name{smote_prep}
\alias{smote_prep}
\title{A specific preparation that transforms the data for predictions.}
\format{
A \code{recipe} object, typically including 11 components such as
term info, variable roles, blueprint, template data, and more.
}
\source{
\url{https://recipes.tidymodels.org/}

\url{https://workflows.tidymodels.org/}
}
\usage{
smote_prep
}
\description{
Using the \code{recipes} package, this preparation ensures that the data is in
a format suitable for the trained model to make predictions. This includes
SMOTE resampling and variable transformations.
}
\keyword{datasets}
