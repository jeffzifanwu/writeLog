## Resubmission

This is a resubmission. Changes made in response to the reviewer's comments:

* Removed the single quotes around the function name in the Description field.
* `writeLog()` no longer has a default `logDir`; callers must supply a
  directory explicitly. Examples and tests write only to `tempdir()` /
  temporary directories, so nothing is written to the home filespace or the
  working directory by default.

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
* R-hub v2 (GitHub Actions): Linux (ubuntu-latest, R-devel), macOS (arm64,
  R-devel), Windows (windows-latest, R-devel) -- all 0 errors | 0 warnings |
  0 notes.
* win-builder (R-devel, x86_64-w64-mingw32, Windows Server 2022): 0 errors |
  0 warnings | 1 NOTE ("New submission", expected for a first CRAN release).
