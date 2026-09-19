# Logging helpers underlying writeLog().

#' Build the path a log file is written to.
#'
#' @param fileName Name of the log file, without extension.
#' @param version Version label prepended to fileName, or NULL for no prefix.
#' @param logDir Directory the log lives in.
#' @return Single file path string.
#' @noRd
logPath <- function(fileName, version = NULL, logDir = "log") {
  prefix <- if (is.null(version)) "" else paste0(version, "_")
  file.path(logDir, paste0(prefix, fileName, ".txt"))
}

#' Heading block printed above the logged objects.
#'
#' On the first write this identifies the file; when appending to a file that
#' already exists it is a lighter separator, so the file keeps a single title.
#'
#' @param fileName,version As for logPath().
#' @param desc Description to print under the heading.
#' @param appending TRUE if this block is being added to an existing file.
#' @return Character vector of lines.
#' @noRd
logHeader <- function(fileName, version = NULL, desc = NULL, appending = FALSE) {
  stamp <- format(Sys.time(), "%Y-%m-%d %H:%M:%S")
  title <- if (appending) {
    c("", strrep("-", 78), paste0("# appended ", stamp))
  } else {
    label <- if (is.null(version)) "" else paste0(" (", version, ")")
    c(paste0("# ", fileName, label), paste0("# written ", stamp))
  }
  c(title, desc, "")
}

#' Print each element of a list, preceded by its list name as a heading.
#'
#' Elements without a name get a positional heading (e.g. "[[2]]") so the log
#' never has an anonymous block.
#'
#' @param x List of objects to print.
#' @return Character vector of lines.
#' @importFrom utils capture.output
#' @noRd
logBody <- function(x) {
  elementNames <- names(x)
  if (is.null(elementNames)) elementNames <- rep("", length(x))
  blank <- is.na(elementNames) | !nzchar(elementNames)
  elementNames[blank] <- paste0("[[", seq_along(x)[blank], "]]")

  unlist(lapply(seq_along(x), function(i) {
    c(elementNames[i], capture.output(print(x[[i]])), "")
  }))
}

#' Write the printed output of each element of a named list to a .txt file in
#' log/, one after another, each preceded by its list name as a heading.
#'
#' @param x Named list of objects to print/log, e.g. list(int.orig =
#'   summary(int), int.hp = halvorsenPalmquist(int)).
#' @param fileName Name of the log file, without extension (e.g. "aq_bdr").
#' @param version Version label prepended to fileName (e.g. "v1"). The file
#'   is written as logDir/version_fileName.txt; if NULL, the version prefix
#'   and its separator are dropped.
#' @param desc Description to print at the top of the log file.
#' @param logDir Directory to write the log file to. Created if missing.
#' @param append If TRUE, add to the log file when it already exists rather
#'   than overwriting it; if it does not exist, a new file is created. If
#'   FALSE (the default), any existing file is overwritten.
#' @return x, invisibly (so this can be used inline without breaking a pipe).
#' @export
#' @examples
#' tmp <- tempfile()
#' writeLog(list(one = 1:3, summary = summary(1:10)),
#'          fileName = "example", logDir = tmp)
#' readLines(file.path(tmp, "example.txt"))
writeLog <- function(x,
                      fileName = "log",
                      version = NULL,
                      desc    = NULL,
                      logDir = "log",
                      append = FALSE) {
  stopifnot(is.list(x), is.character(fileName), length(fileName) == 1)

  # Make sure the log directory exists before writing to it
  if (!dir.exists(logDir)) {
    dir.create(logDir, recursive = TRUE)
  }

  path <- logPath(fileName, version, logDir)
  # Only append if there is actually something to append to; otherwise this is
  # an ordinary first write and gets the full heading.
  appending <- append && file.exists(path)

  lines <- c(logHeader(fileName, version, desc, appending), logBody(x))
  # cat() rather than writeLines() so append= is available.
  cat(lines, file = path, sep = "\n", append = appending)

  invisible(x)
}
