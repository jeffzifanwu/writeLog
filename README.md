# writeLog

An R package providing `writeLog()`, a helper that writes the printed
output of a named list of R objects to a `.txt` file in a log directory,
one element after another, each preceded by its list name as a heading.

## Installation

```r
# install.packages("devtools")
devtools::install_github("jeffzifanwu/writeLog")
```

## Usage

```r
library(writeLog)

writeLog(
  list(contents1 = summary(1:10), contents2 = mean(1:10)),
  fileName = "allContents",
  version  = "v1",
  desc     = "All contents",
  logDir   = "log"
)
```

This writes `log/v1_allContents.txt`, with each list element preceded by its
name (or a positional heading like `[[2]]` for unnamed elements). Pass
`append = TRUE` to add to an existing log file instead of overwriting it.

## Development

```r
devtools::document()
devtools::test()
devtools::check()
```
