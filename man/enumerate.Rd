% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/quote.R
\name{enumerate}
\alias{enumerate}
\title{Enumerate Multiple Strings}
\usage{
enumerate(x, quote_fun = backquote, conjunction = "and")
}
\arguments{
\item{x}{A \code{character} vector}

\item{quote_fun}{Quoting function, defaults to \code{backquote}.}

\item{conjunction}{Character to be used in the message, defaults to "and".}
}
\value{
A \code{character} vector
}
\description{
Enumerate Multiple Strings
}
\seealso{
Helpers for working with Quotes and Quoting: 
\code{\link{backquote}()},
\code{\link{dquote}()},
\code{\link{squote}()}
}
\author{
Thomas Neitmann
}
\concept{quote}
\keyword{quote}
