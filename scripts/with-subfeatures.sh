#!/bin/bash

current_merge_state=$GIT_MERGE_AUTOEDIT
export GIT_MERGE_AUTOEDIT=no

(
    rm -rf with-subfeatures
    mkdir with-subfeatures

    cd with-subfeatures

    mkdir src
    mkdir tests

    git init
    git flow init -d

    git flow feature start add-foo
    git flow feature start add-foo-dependency feature/add-foo
    git flow feature start create-foo-dependency feature/add-foo-dependency
    touch src/foo-dependency.ext
    git add src/foo-dependency.ext
    git commit -m 'Create foo-dependency'
    git flow feature finish --no-ff create-foo-dependency
    git flow feature start test-foo-dependency feature/add-foo-dependency
    touch test/foo-dependency.ext
    git add tests/foo-dependency.ext
    git commit -m 'Test foo-dependency'
    git flow feature finish --no-ff test-foo-dependency
    git flow feature finish --no-ff add-foo-dependency
    git flow feature start create-foo feature/add-foo
    touch src/foo.ext
    git add src/foo.ext
    git commit -m 'Create foo'
    git flow feature finish --no-ff create-foo
    git flow feature start test-foo feature/add-foo
    touch tests/foo.ext
    git add tests/foo.ext
    git commit -m 'Test foo'
    git flow feature finish --no-ff test-foo
    git flow feature finish --no-ff add-foo
) >/dev/null 2>&1

if which ansi2html >/dev/null; then
    rm -f ../../script-output/with-subfeatures.html
    cd with-subfeatures
    git log --graph --all --topo-order --decorate --oneline --boundary --color=always | ansi2html --inline > ../../script-output/with-subfeatures.html
    cd ..
fi

rm -rf with-subfeatures/

export GIT_MERGE_AUTOEDIT=$current_merge_state
