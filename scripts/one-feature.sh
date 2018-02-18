#!/bin/bash

current_merge_state=$GIT_MERGE_AUTOEDIT
export GIT_MERGE_AUTOEDIT=no

(
    rm -rf one-feature
    mkdir one-feature

    cd one-feature

    mkdir src
    mkdir tests

    git init
    git flow init -d

    git flow feature start add-foo
    touch src/foo-dependency.ext
    git add src/foo-dependency.ext
    git commit -m 'Create foo-dependency'
    touch tests/foo-dependency.ext
    git add tests/foo-dependency.ext
    git commit -m 'Test foo-dependency'
    touch src/foo.ext
    git add src/foo.ext
    git commit -m 'Create foo'
    touch tests/foo.ext
    git add tests/foo.ext
    git commit -m 'Test foo'
    git flow feature finish --no-ff add-foo
) >/dev/null 2>&1

if which ansi2html >/dev/null; then
    rm -f ../../script-output/one-feature.html
    cd one-feature
    git log --graph --all --topo-order --decorate --oneline --boundary --color=always | ansi2html --inline > ../../script-output/one-feature.html
    cd ..
fi

rm -rf one-feature/

export GIT_MERGE_AUTOEDIT=$current_merge_state
