## Update

This is a small update to writeLog 0.1.0 (version 0.1.1). There are no changes
to the R code.

* Corrected the author's given name in `DESCRIPTION`.
* README: added a command-line usage example showing that the version can be
  passed as an argument, so users no longer need to edit their code for each
  new version. Removed the Development section.

## R CMD check results

0 errors | 0 warnings | 1 note

The only note appears on win-builder (R-devel) and is the standard incoming
check:

```
Maintainer: 'Jeff Wu <zifan.jeffwu@gmail.com>'
Days since last update: 5
```

This update is submitted soon after 0.1.0 because it corrects the author's
name and improves the documentation.

## Test environments

* Local: Windows 11, R 4.5.3 (`R CMD check --as-cran`): 0 errors, 0 warnings,
  0 notes
* win-builder: Windows, R-devel: 1 note (above)
* R-hub: Linux, Windows and macOS, R-devel: all OK
* GitHub Actions: Linux (ubuntu-latest, R release): 0 errors, 0 warnings,
  0 notes
