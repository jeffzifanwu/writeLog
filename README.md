# logr

An R package providing `writeLog()`, a helper that writes the printed
output of a named list of R objects to a `.txt` file in a log directory,
one element after another, each preceded by its list name as a heading.

## Installation

```r
# install.packages("devtools")
devtools::install_github("jeffzifanwu/logr")
```

## Usage

```r
library(logr)

writeLog(
  list(int.orig = summary(1:10), int.hp = mean(1:10)),
  fileName = "aq_bdr",
  version  = "v1",
  desc     = "Summary and mean of 1:10",
  logDir   = "log"
)
```

This writes `log/v1_aq_bdr.txt`, with each list element preceded by its
name (or a positional heading like `[[2]]` for unnamed elements). Pass
`append = TRUE` to add to an existing log file instead of overwriting it.

## Development

```r
devtools::document()
devtools::test()
devtools::check()
```
