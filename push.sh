#!/bin/bash -x

git remote set-url --push origin `git config remote.origin.url | sed -e 's/^git:/https:/'`


if ! [ -d build/asciidoc ]; then
    echo "No new sources, so not syncing"
    exit 0
fi

# double check there were git changes
###################################################################
git diff-index --quiet HEAD
dirty=$?
if [ "$dirty" != "0" ]; then git stash; fi

git checkout master
mv build/asciidoc/html5/Binary-Repository-Manager-Feature-Matrix.html build/asciidoc/html5/index.html
for f in build/asciidoc/html5/*; do
    file=${f#build/asciidoc/html5/*}
    if ! git ls-files -i -o --exclude-standard --directory | grep -q ^$file$; then
        # Not ignored...
        cp -rf $f .
        git add -A $file
    fi
done
git commit -a -m "Changes in table, [ci skip]"
git push

# Create a tag
tagName=$(date +%s)
git tag $tagName
git push origin $tagName


exit 0