% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/assertions.R
\name{assert_named}
\alias{assert_named}
\title{Assert Argument is a Named List or Vector}
\usage{
assert_named(arg, optional = FALSE)
}
\arguments{
\item{arg}{A function argument to be checked}

\item{optional}{Is the checked argument optional? If set to \code{FALSE} and \code{arg}
is \code{NULL} then an error is thrown}
}
\value{
The function throws an error if \code{arg} is not a named list or vector or
returns the input invisibly otherwise
}
\description{
Assert that all elements of the argument are named.
}
\examples{
example_fun <- function(varval_list) {
  assert_named(varval_list)
}

example_fun(list(var1 = 1, var2 = "x"))

try(example_fun(list(1, "x")))

try(example_fun(list(var = 1, "x")))
}
\seealso{
Checks for valid input and returns warning or errors messages: 
\code{\link{assert_atomic_vector}()},
\code{\link{assert_character_scalar}()},
\code{\link{assert_character_vector}()},
\code{\link{assert_data_frame}()},
\code{\link{assert_date_vector}()},
\code{\link{assert_expr_list}()},
\code{\link{assert_expr}()},
\code{\link{assert_filter_cond}()},
\code{\link{assert_function}()},
\code{\link{assert_integer_scalar}()},
\code{\link{assert_list_element}()},
\code{\link{assert_list_of}()},
\code{\link{assert_logical_scalar}()},
\code{\link{assert_numeric_vector}()},
\code{\link{assert_one_to_one}()},
\code{\link{assert_param_does_not_exist}()},
\code{\link{assert_s3_class}()},
\code{\link{assert_same_type}()},
\code{\link{assert_symbol}()},
\code{\link{assert_unit}()},
\code{\link{assert_vars}()},
\code{\link{assert_varval_list}()}
}
\concept{assertion}
\keyword{assertion}
