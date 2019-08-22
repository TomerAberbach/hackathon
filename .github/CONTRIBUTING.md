# Contributing

## Workflow

### Branching Model

We use a branching model that is a simplified version of [Vincent Driessen's branching model](https://nvie.com/posts/a-successful-git-branching-model), also known as Git Flow.

We have two main branches that are never deleted:
* The `master` branch always reflects a production-ready state.
* The `develop` branch, which runs parallel to `master`, always contains the latest delivered development changes for the next "release". We put "release" in quotes because we do not have versioned releases. We simply merge `develop` into `master` when we believe `develop` reflects a production-ready state.

We also two types of branches which are frequently created and deleted:
* A feature branch, prefixed with `feature/`, must branch from `develop`. It can be discarded, or merged into `develop` and then deleted. A feature branch should have a cohesive goal. This includes implementing actual features, functionality which other feature branches require, or any other targeted well-scoped changes. The `develop` branch can be merged into a feature branch to pick up new changes.
* A hotfix branch, prefixed with `hotfix/`, must branch from `master`. It can be discarded, or merged into both `master` and `develop` and then deleted. A hotfix branch should only be used to fix bugs on `master`. Of course, we aim to minimize the use of hotfix branches by not introducing bugs into `master`.

The text after branch prefixes should be in dash-case.

### Issues

We mainly create issues for bugs on the two main branches, `develop` and `master`, or for new features. An intermediate step in the fixing of a bug or the development of a feature does not have an associated issue. Instead, intermediate steps are represented as [task lists](https://help.github.com/en/articles/about-task-lists) in issues comprising the entire bug or feature. Issues are displayed on the [repository's single project board](https://github.com/TomerAberbach/hackathon/projects/1) that is configured to use [automated kanban with review](https://help.github.com/en/articles/about-project-boards#templates-for-project-boards).

### Review

All merges into the two main branches are reviewed.

### Commits

We prefer commit messages in the present tense (i.e. "Adds..." over "Added...").

## Technical

### Tests

All non-trivial functionality should be tested. However, care must be taken to test the post-conditions and invariants of functions and classes, respectively, rather than irrelevant implementation details. See [Testing Rails Applications](https://guides.rubyonrails.org/testing.html) for a primer on testing in Rails.
