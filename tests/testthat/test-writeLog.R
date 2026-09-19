test_that("writeLog creates the log directory and file", {
  tmp <- withr::local_tempdir()
  logDir <- file.path(tmp, "log")

  writeLog(list(a = 1:3), fileName = "basic", logDir = logDir)

  expect_true(dir.exists(logDir))
  expect_true(file.exists(file.path(logDir, "basic.txt")))
})

test_that("writeLog prefixes the file name with version", {
  tmp <- withr::local_tempdir()

  writeLog(list(a = 1), fileName = "basic", version = "v1", logDir = tmp)

  expect_true(file.exists(file.path(tmp, "v1_basic.txt")))
})

test_that("writeLog overwrites by default", {
  tmp <- withr::local_tempdir()
  path <- file.path(tmp, "basic.txt")

  writeLog(list(a = 1:3), fileName = "basic", logDir = tmp)
  writeLog(list(b = 4:6), fileName = "basic", logDir = tmp)

  lines <- readLines(path)
  expect_false(any(grepl("^a$", lines)))
  expect_true(any(grepl("^b$", lines)))
})

test_that("writeLog appends when append = TRUE and the file exists", {
  tmp <- withr::local_tempdir()
  path <- file.path(tmp, "basic.txt")

  writeLog(list(a = 1:3), fileName = "basic", logDir = tmp)
  writeLog(list(b = 4:6), fileName = "basic", logDir = tmp, append = TRUE)

  lines <- readLines(path)
  expect_true(any(grepl("^a$", lines)))
  expect_true(any(grepl("^b$", lines)))
  expect_true(any(grepl("^# appended", lines)))
})

test_that("writeLog with append = TRUE creates a fresh file when none exists", {
  tmp <- withr::local_tempdir()
  path <- file.path(tmp, "basic.txt")

  writeLog(list(a = 1:3), fileName = "basic", logDir = tmp, append = TRUE)

  lines <- readLines(path)
  expect_true(any(grepl("^# basic$", lines)))
  expect_false(any(grepl("^# appended", lines)))
})

test_that("unnamed list elements get a positional heading", {
  tmp <- withr::local_tempdir()
  path <- file.path(tmp, "basic.txt")

  writeLog(list(1:3, named = "x"), fileName = "basic", logDir = tmp)

  lines <- readLines(path)
  expect_true(any(grepl("^\\[\\[1\\]\\]$", lines)))
  expect_true(any(grepl("^named$", lines)))
})

test_that("writeLog returns x invisibly", {
  tmp <- withr::local_tempdir()
  x <- list(a = 1)

  expect_identical(withVisible(writeLog(x, logDir = tmp)), list(value = x, visible = FALSE))
})

test_that("writeLog requires a list for x", {
  tmp <- withr::local_tempdir()
  expect_error(writeLog(1:3, logDir = tmp))
})
