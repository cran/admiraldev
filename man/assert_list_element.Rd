% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/assertions.R
\name{assert_list_element}
\alias{assert_list_element}
\title{Is an Element of a List of Lists/Classes Fulfilling a Condition?}
\usage{
assert_list_element(
  list,
  element,
  condition,
  message_text,
  arg_name = rlang::caller_arg(list),
  message = NULL,
  class = "assert_list_element",
  call = parent.frame(),
  ...
)
}
\arguments{
\item{list}{A list to be checked
A list of named lists or classes is expected.}

\item{element}{The name of an element of the lists/classes
A character scalar is expected.}

\item{condition}{Condition to be fulfilled
The condition is evaluated for each element of the list. The element of the
lists/classes can be referred to by its name, e.g., \code{censor == 0} to check
the \code{censor} field of a class.}

\item{message_text}{Text to be displayed in the error message above
the listing of values that do not meet the condition.
The text should describe the condition to be fulfilled,
e.g., \code{"Error in {arg_name}: the censor values must be zero."}.
If \code{message} argument is specified, that text will be displayed and \code{message_text}
is ignored.}

\item{arg_name}{string indicating the label/symbol of the object being checked.}

\item{message}{string passed to \code{cli::cli_abort(message)}.
When \code{NULL}, default messaging is used (see examples for default messages).
\code{"{arg_name}"} can be used in messaging.}

\item{class}{Subclass of the condition.}

\item{call}{The execution environment of a currently running
function, e.g. \code{call = caller_env()}. The corresponding function
call is retrieved and mentioned in error messages as the source
of the error.

You only need to supply \code{call} when throwing a condition from a
helper function which wouldn't be relevant to mention in the
message.

Can also be \code{NULL} or a \link[rlang:topic-defuse]{defused function call} to
respectively not display any call or hard-code a code to display.

For more information about error calls, see \ifelse{html}{\link[rlang:topic-error-call]{Including function calls in error messages}}{\link[rlang:topic-error-call]{Including function calls in error messages}}.}

\item{...}{Objects required to evaluate the condition
If the condition contains objects apart from the element, they have to be
passed to the function. See the second example below.}
}
\value{
An error if the condition is not met. The input otherwise.
}
\description{
Checks if the elements of a list of named lists/classes fulfill a certain
condition. If not, an error is issued and all elements of the list not
fulfilling the condition are listed.
}
\seealso{
Checks for valid input and returns warning or errors messages: 
\code{\link{assert_atomic_vector}()},
\code{\link{assert_character_scalar}()},
\code{\link{assert_character_vector}()},
\code{\link{assert_data_frame}()},
\code{\link{assert_date_vector}()},
\code{\link{assert_expr}()},
\code{\link{assert_expr_list}()},
\code{\link{assert_filter_cond}()},
\code{\link{assert_function}()},
\code{\link{assert_integer_scalar}()},
\code{\link{assert_list_of}()},
\code{\link{assert_logical_scalar}()},
\code{\link{assert_named}()},
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
