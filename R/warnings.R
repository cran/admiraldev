#' Warn If a Variable Already Exists
#'
#' Warn if a variable already exists inside a dataset
#'
#' @param dataset A `data.frame`
#' @param vars `character` vector of columns to check for in `dataset`
#'
#' @return No return value, called for side effects
#'
#'
#' @keywords warnings
#' @family warnings
#'
#' @export
#'
#' @examples
#' library(dplyr, warn.conflicts = FALSE)
#' dm <- tribble(
#'   ~USUBJID,           ~ARM,
#'   "01-701-1015", "Placebo",
#'   "01-701-1016", "Placebo",
#' )
#'
#' ## No warning as `AAGE` doesn't exist in `dm`
#' warn_if_vars_exist(dm, "AAGE")
#'
#' ## Issues a warning
#' warn_if_vars_exist(dm, "ARM")
warn_if_vars_exist <- function(dataset, vars) {
  existing_vars <- vars[vars %in% colnames(dataset)]
  if (length(existing_vars) >= 1L) {
    cli::cli_warn("{cli::qty(length(existing_vars))}Variable{?s} {.val {existing_vars}}
                   already {?exists/exist} in the dataset.")
  }

  invisible(NULL)
}

#' Warn If a Vector Contains Unknown Datetime Format
#'
#' Warn if the vector contains unknown datetime format such as
#' "2003-12-15T-:15:18", "2003-12-15T13:-:19","--12-15","-----T07:15"
#'
#' @param dtc a character vector containing the dates
#' @param is_valid a logical vector indicating whether elements in `dtc` are valid
#'
#' @return No return value, called for side effects
#'
#'
#' @keywords warnings
#' @family warnings
#'
#' @export
#'
#' @examples
#'
#' ## No warning as `dtc` is a valid date format
#' warn_if_invalid_dtc(dtc = "2021-04-06")
#'
#' ## Issues a warning
#' warn_if_invalid_dtc(dtc = "2021-04-06T-:30:30")
warn_if_invalid_dtc <- function(dtc, is_valid = is_valid_dtc(dtc)) {
  if (!all(is_valid)) {
    incorrect_dtc <- dtc[!is_valid]
    incorrect_dtc_row <- rownames(as.data.frame(dtc))[!is_valid]
    tbl <- paste("Row", incorrect_dtc_row, ": --DTC =", incorrect_dtc)
    main_msg <- paste(
      "Dataset contains incorrect datetime format:",
      "--DTC may be incorrectly imputed on row(s)"
    )

    info <- paste0(
      "ISO representations of the form YYYY-MM-DDThh:mm:ss.ddd are expected, ",
      "e.g., 2003-12-15T13:15:17.123. Missing parts at the end can be omitted. ",
      "Missing parts in the middle must be represented by a dash, e.g., 2003---15.",
      sep = "\n"
    )
    cli::cli_warn(c(main_msg, "*" = tbl, "*" = info))
  }
}

#' Warn if incomplete dtc
#'
#' @param dtc A `character` vector of date-times in ISO 8601 format
#' @param n A non-negative integer
#'
#' @return A warning if `dtc` contains any partial dates
#' @export
#'
#' @keywords warnings
#' @family warnings
#'
warn_if_incomplete_dtc <- function(dtc, n) {
  is_complete_dtc <- (nchar(dtc) >= n | is.na(dtc))
  if (n == 10) {
    dt_dtm <- "date"
    funtext <- "convert_dtc_to_dt"
  } else if (n == 19) {
    dt_dtm <- "datetime"
    funtext <- "convert_dtc_to_dtm"
  }
  if (!all(is_complete_dtc)) {
    incomplete_dtc <- dtc[!is_complete_dtc]
    incomplete_dtc_row <- rownames(as.data.frame(dtc))[!is_complete_dtc]
    tbl <- paste("Row", incomplete_dtc_row, ": --DTC = ", incomplete_dtc)
    msg <- paste0(
      "Dataset contains partial ", dt_dtm, " format. ",
      "The function ", funtext, " expect a complete ", dt_dtm, ". ",
      "Please use the function `impute_dtc()` to build a complete ", dt_dtm, "."
    )
    warn(paste(msg, capture.output(print(tbl)), collapse = "\n"))
  }
}


#' Warn If Two Lists are Inconsistent
#'
#' Checks if two list inputs have the same names and same number of elements and
#' issues a warning otherwise.
#'
#' @param base A named list
#'
#' @param compare A named list
#'
#' @param list_name A string
#' the name of the list
#'
#' @param i the index id to compare the 2 lists
#'
#'
#' @return a `warning` if the 2 lists have different names or length
#'
#' @keywords warnings
#' @family warnings
#'
#' @export
#'
#' @examples
#' library(dplyr, warn.conflicts = FALSE)
#' library(rlang)
#'
#' # no warning
#' warn_if_inconsistent_list(
#'   base = exprs(DTHDOM = "DM", DTHSEQ = DMSEQ),
#'   compare = exprs(DTHDOM = "DM", DTHSEQ = DMSEQ),
#'   list_name = "Test"
#' )
#' # warning
#' warn_if_inconsistent_list(
#'   base = exprs(DTHDOM = "DM", DTHSEQ = DMSEQ, DTHVAR = "text"),
#'   compare = exprs(DTHDOM = "DM", DTHSEQ = DMSEQ),
#'   list_name = "Test"
#' )
warn_if_inconsistent_list <- function(base, compare, list_name, i = 2) {
  if (paste(sort(names(base)), collapse = " ") != paste(sort(names(compare)), collapse = " ")) {
    warn(
      paste0(
        "The variables used for traceability in `", list_name,
        "` are not consistent, please check:\n",
        paste(
          "source", i - 1, ", Variables are given as:",
          paste(sort(names(base)), collapse = " "), "\n"
        ),
        paste(
          "source", i, ", Variables are given as:",
          paste(sort(names(compare)), collapse = " ")
        )
      )
    )
  }
}

#' Suppress Specific Warnings
#'
#' Suppress certain warnings issued by an expression.
#'
#' @param expr Expression to be executed
#'
#' @param regexpr Regular expression matching warnings to suppress
#'
#' @return Return value of the expression
#'
#' @keywords warnings
#' @family warnings
#'
#' @details
#' All warnings which are issued by the expression and match the regular expression
#' are suppressed.
#'
#' @export
suppress_warning <- function(expr, regexpr) {
  withCallingHandlers(
    expr,
    warning = function(w) {
      if (any(grepl(regexpr, w$message))) {
        invokeRestart("muffleWarning")
      }
    }
  )
}
