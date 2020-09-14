I'm attempting an automated conversion from a python lesson to sandpaper.

To start, I will need to make sure I have the latest versions of the packages
I need to build the site. I can do that with {sandpaper}, which will install

 - {sandpaper} to build the site
 - {varnish} for the styling
 - {dovetail} for incorporating custom code blocks that translate to block
   quotes
 - {pegboard} for manipulating the lessons



```r
remotes::install_github("zkamvar/sandpaper", dep = TRUE, force = TRUE)
```


I will use the  {usethis} package to bring in [Programming With Python]
lesson and it will transport me to the downloaded folder.



```r
usethis::create_from_github("swcarpentry/python-novice-inflammation", open = FALSE)
```

```
## ✔ Creating '/home/zhian/Desktop/python-novice-inflammation/'
```

```
## ✔ Cloning repo from 'git@github.com:swcarpentry/python-novice-inflammation.git' into '/home/zhian/Desktop/python-novice-inflammation'
```

```
## ✔ Setting active project to '/home/zhian/Desktop/python-novice-inflammation'
```

```
## ✔ Setting active project to '<no active project>'
```


Once I'm inside, I will use a script embedded in {dovetail} to convert the
lesson:


```r
withr::with_dir("~/Desktop/python-novice-inflammation", {
  script <- system.file("convert", "convert_python.R", package = "dovetail")
  source(script)
})
```

```
## Loading required namespace: remotes
```

```
## Using github PAT from envvar GITHUB_PAT
```

```
## Skipping install of 'pegboard' from a github remote, the SHA1 (bd33ff2b) has not changed since last install.
##   Use `force = TRUE` to force installation
```

```
## 1/7: Using the dovetail package
```

```
## 2/7: Using the sandpaper package (not converting python chunks to RMarkdown)
```

```
## 3/7: Converting block quotes to dovetail chunks
```

```
## 4/7: Moving questions from yaml to body
```

```
## 5/7: Moving objectives from yaml to body
```

```
## 6/7: Moving keypoints from yaml to body
```

```
## 7/7: Writing files to disk
```

```
## Done.
```

```
## 
## To keep these changes, add and commit them to git.
## To discard these changes, use
## 
##   git checkout -- _episodes_rmd/
```


Now I will use {sandpaper} to create a new site called "pynoin" 
(PYthon NOvice INflammation)


```r
sandpaper::create_lesson("~/Desktop/pynoin", rstudio = TRUE, open = FALSE)
```

```
## ✔ Setting active project to '/home/zhian/Desktop/pynoin'
```

```
## ✔ Writing 'pynoin.Rproj'
```

```
## ✔ Adding '.Rproj.user' to '.gitignore'
```

```
## ✔ Setting active project to '<no active project>'
```

```
## [1] "~/Desktop/pynoin"
```


To complete the setup, I can copy over the episodes, data, code, and figures
into the `episodes/` directory. One of the catches is that all of the paths
assume that the resources live at the top of the directory, so we will use
sed to replace those paths. 


```r
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
```


At this piont in time, I made a booboo where the default schedule was stuck
with the initial example RMarkdown file instead of being blank, which meant
to use the file names, but I will fix this soooon


```r
withr::with_dir("~/Desktop/pynoin", {
  sched <- sandpaper::get_schedule()
  sandpaper::set_schedule(path = ".", order = sched)
  sandpaper::set_schedule(path = ".", order = sched, write = TRUE)
  gert::git_status()
  gert::git_add("episodes")
  gert::git_commit_all(message = "add episodes and schedule")
  gert::git_status()
})
```

```
## Warning in sandpaper::get_schedule(): No schedule set, using Rmd files in `episodes/` directory.
## To remove this warning, define your schedule in `config.yaml` or use `set_schedule()` to generate it.
```

```
## carpentry: cp
## title: Lesson Title
## life_cycle: pre-alpha
## license: CC-BY 4.0
## source: https://github.com/carpentries/sandpaper
## branch: main
## contact: team@carpentries.org
## 
## schedule:
## ─ 01-intro.Rmd
## ─ 02-numpy.Rmd
## ─ 03-matplotlib.Rmd
## ─ 04-loop.Rmd
## ─ 05-lists.Rmd
## ─ 06-files.Rmd
## ─ 07-cond.Rmd
## ─ 08-func.Rmd
## ─ 09-errors.Rmd
## ─ 10-defensive.Rmd
## ─ 11-debugging.Rmd
## ─ 12-cmdline.Rmd
```

```
## # A tibble: 0 x 3
## # … with 3 variables: file <chr>, status <chr>, staged <lgl>
```


[Programming With Python]: https://swcarpentry.github.io/python-novice-inflammation
