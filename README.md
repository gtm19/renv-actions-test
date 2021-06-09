# renv-actions-test

<!-- badges: start -->

[![R-CMD-check](https://github.com/r-lib/usethis/workflows/R-CMD-check/badge.svg)](https://github.com/r-lib/usethis/actions)
<!-- badges: end -->

This repository demonstrates how to set up GitHub Actions which will run R CMD
check on packages.

## Key features

* This Action works whether or not the package [uses `renv`](https://rstudio.github.io/renv/index.html)
* It caches installed package dependencies for quicker runtime
* It is compatible with `monorepos` - allowing the developer to specify a 
subdirectory in which all packages live as a top level `paths:` filter, and then
specific subdirectories (using [dorney/paths-filter](https://github.com/dorny/paths-filter)) 
which will ensure the Action only runs when files in these specific 
subdirectories are modified

See the PRs of this repo for examples:

* [#1](https://github.com/gtm19/renv-actions-test/pull/1) does not use `renv`
* [#3](https://github.com/gtm19/renv-actions-test/pull/3) does use `renv`

## Setup

1. Create a `.github/workflows` directory in the top level of your repo / monorepo
2. Copy the [.github/workflows/R-CMD-check.yaml](.github/workflows/R-CMD-check.yaml) 
file into this `.github/workflows` directory
3. Modify the `paths:` part of the YAML file to specify the subdirectory in 
which all your packages live (or delete it altogether if there is no specific 
subdirectory where they all live):
```yaml
name: R-CMD-check
on:
  pull_request:
    branches:
      - main
      - master
    paths:
      - 'packages/**'  # << the subdirectory where your packages live goes here
```
4. Add the package directories to `matrix.path`:
```yaml
strategy:
      fail-fast: false
      matrix:
        path:  # << list the individual directories where each package lives
          - packages/app.one
          - packages/app.two
        config:
          - {os: macOS-latest, r: 'release'}
```
5. Make pull requests and stuff

## Removing a package from GitHub Actions scrutiny

Simply remove it from the `matrix.path`:
```yaml
strategy:
      fail-fast: false
      matrix:
        path:  # << list the individual directories where each package lives
        #   - packages/app.one (not checked any more)
          - packages/app.two
        config:
          - {os: macOS-latest, r: 'release'}
```

## Waiving checks for a specific PR

You can skip all checks (as long as the settings for your repo permit) for all 
actions by adding `[skip ci]` to the commit message before pushing. Read more 
[here](https://github.blog/changelog/2021-02-08-github-actions-skip-pull-request-and-push-workflows-with-skip-ci/).

An example of this can be seen on [this PR](https://github.com/gtm19/renv-actions-test/pull/4) in this repo.