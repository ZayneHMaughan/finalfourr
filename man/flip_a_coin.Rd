% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/flip_a_coin.R
\name{flip_a_coin}
\alias{flip_a_coin}
\title{Stochastically Determine a Binary Outcome Between Two Teams (coin flip)}
\usage{
flip_a_coin(team1, team2)
}
\arguments{
\item{team1}{A character string representing the identifier
of the first team.}

\item{team2}{A character string corresponding to the second
team’s identifier.}
}
\value{
This function does not return a structured object.
Instead, it executes a pseudo-random selection algorithm to determine a
"winner" from the two supplied teams, and subsequently emits a declarative
textual message to the console announcing the outcome.
}
\description{
Executes a rudimentary probabilistic mechanism—colloquially referred to as
a "coin flip"—to arbitrarily designate a victor
between two user-specified competitive teams.
}
\details{
This method is devoid of any analytical rigor or data-driven inference;
it is purely stochastic and serves primarily as a whimsical or
demonstrative exercise rather than a substantive evaluative tool.
}
\examples{
set.seed(348)
# Flip a coin between two teams
flip_a_coin("BYU", "Utah")

}
