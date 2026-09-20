## R CMD check results

0 errors | 0 warnings | 0 notes on a clean checkout.

* This is a new release.
* Local sandbox runs show 1 warning and 2 notes that do not reproduce on a
  normal machine: a `Sys.setlocale()` warning caused by the sandbox missing
  the `en_US.UTF-8` locale, a "future file timestamps" note caused by the
  sandbox having no network access to verify the clock, and a "hidden
  files and directories" note for a `.claude/` directory that is a local
  tool artifact, untracked and excluded via `.gitignore` (not part of the
  package source).

## Test environments

* local: Ubuntu 24.04, R 4.3.3
* (fill in before submission: `devtools::check_win_devel()`,
  `rhub::rhub_check()` results for at least Windows and macOS)
