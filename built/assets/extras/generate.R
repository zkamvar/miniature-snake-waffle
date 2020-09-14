#' I'm attempting an automated conversion from a python lesson to sandpaper.
#'
#' To start, I will need to make sure I have the latest versions of the packages
#' I need to build the site. I can do that with {sandpaper}, which will install
#' 
#'  - {sandpaper} to build the site
#'  - {varnish} for the styling
#'  - {dovetail} for incorporating custom code blocks that translate to block
#'    quotes
#'  - {pegboard} for manipulating the lessons
#'
#+eval = FALSE
remotes::install_github("zkamvar/sandpaper", dep = TRUE, force = TRUE)
#'
#' I will use the  {usethis} package to bring in [Programming With Python]
#' lesson and it will transport me to the downloaded folder.
#'
usethis::create_from_github("swcarpentry/python-novice-inflammation", open = FALSE)
#' 
#' Once I'm inside, I will use a script embedded in {dovetail} to convert the
#' lesson:
withr::with_dir("~/Desktop/python-novice-inflammation", {
  script <- system.file("convert", "convert_python.R", package = "dovetail")
  source(script)
})
#'
#' Now I will use {sandpaper} to create a new site called "pynoin" 
#' (PYthon NOvice INflammation)
sandpaper::create_lesson("~/Desktop/pynoin", rstudio = TRUE, open = FALSE)
#'
#' To complete the setup, I can copy over the episodes, data, code, and figures
#' into the `episodes/` directory. One of the catches is that all of the paths
#' assume that the resources live at the top of the directory, so we will use
#' sed to replace those paths. 
src <- "~/Desktop/python-novice-inflammation/"
withr::with_dir("~/Desktop/pynoin", {
  # Copying the episodes
  fs::file_delete("episodes/01-introduction.Rmd")
  to_copy <- fs::dir_ls(fs::path(src, "_episodes"), glob = "*Rmd")
  purrr::walk(to_copy, ~fs::file_copy(.x, "episodes"))
  # copying the data, code, and figures
  fs::dir_copy(fs::path(src, "data"), "episodes")
  fs::dir_copy(fs::path(src, "code"), "episodes")
  fs::dir_copy(fs::path(src, "fig"), "episodes")
})
#'
#' At this piont in time, I made a booboo where the default schedule was stuck
#' with the initial example RMarkdown file instead of being blank, which meant
#' to use the file names, but I will fix this soooon
withr::with_dir("~/Desktop/pynoin", {
  sched <- sandpaper::get_schedule()
  sandpaper::set_schedule(path = ".", order = sched)
  sandpaper::set_schedule(path = ".", order = sched, write = TRUE)
  gert::git_status()
  gert::git_add("episodes")
  gert::git_commit_all(message = "add episodes and schedule")
  gert::git_status()
})
#'
#' [Programming With Python]: https://swcarpentry.github.io/python-novice-inflammation
