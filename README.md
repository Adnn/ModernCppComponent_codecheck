# Proofreading Modern C++ Component code

This repository is used to proofread the code snippets in
[`Modern C++ Component`](https://github.com/Adnn/ModernCppComponent) document.
It is also intended for readers looking for a first example.

**IMPORTANT**: (A subset of) The different versions of `Modern C++ Component` document are mapped
to separate branches in this repository.

**IMPORTANT**: This repository history is currated: each commit in a given branch incrementally
validates further sections of the document (for the version matching the branch).
It means that, in each branch, the commits could be checked-out in chronological order and
`proof.sh` should hold for each commit.

## Usage

### Validating a specific section, for a given version of the document (i.e. a single commit)

`proof.sh` runs different tests to validate the code in `Modern C++ Component`.

    git checkout ${commit_sha}
    ./proof.sh


### Validating all the sections for a given version of the document (i.e. a whole branch)

`git` offers a convenient one liner to run a given command on all commit of a branch.

    git checkout ${branch}
    git rebase --exec ./proof.sh --root
