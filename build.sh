#!/usr/bin/env sh
git checkout --orphan  gh-pages

for file in books/*; do
  gitbook build "$file" docs/"${file##*/}"
done

for file in $(find docs -name '*.html'); do
  echo "$file"
  sed -i "" "s|.gitbook/assets/|gitbook/assets/|" "$file"
done
for file in docs/*; do
  if [ -d "$file/.gitbook/assets" ]; then
    mv "$file/.gitbook/assets" "$file/gitbook/assets"
  fi
done
git add .
git commit -m"gitbook build"
git push origin gh-pages