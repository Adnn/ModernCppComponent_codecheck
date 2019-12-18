# Proofreading Modern C++ Component code

This repository is used to proofread the code snippets in `Modern C++ Component`.
It is intended for its author and readers looking for a first example.

**IMPORTANT**: This repository history is currated so each commit incrementally validates more and more of the document.
The commits could be checked-out in chronological order and the `proof.sh` should hold for each.

## Usage

`proof.sh` runs different tests to validate the code in `Modern C++ Component`.
It forwards all its arguements to the first few `cmake` invocations.

In particular, `proof.sh` tests handling external dependencies by using Boost as a requirement.
Because some early steps are not yet obtaining Boost via Conan, yet already depend on it, it might be required to provide a `Boost_ROOT` definition, such as:

    ./proof.sh -DBoost_ROOT=~/projects/SDK/boost_1.67/
