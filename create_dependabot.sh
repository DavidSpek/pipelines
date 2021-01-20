#!/bin/bash

rm .github/dependabot.yml
cp .github/base_dependabot.yml .github/dependabot.yml

for directory in $(dirname $(find . -type f -name "*ockerfile*") | uniq | cut -c2-); do
     yq eval -i ".updates += {\"package-ecosystem\":\"docker\",\"directory\":\"${directory}\",\"schedule\":{\"interval\":\"daily\"},\"open-pull-requests-limit\":10}" .github/dependabot.yml
done

for directory in $(dirname $(find . -type f -name "package*.json" -not -path "./*node_modules*") | uniq | cut -c2-); do
    yq eval -i ".updates += {\"package-ecosystem\":\"npm\",\"directory\":\"${directory}\",\"schedule\":{\"interval\":\"daily\"},\"open-pull-requests-limit\":10}" .github/dependabot.yml
done

for directory in $(dirname $(find . -type f -name "*requirements.txt") | uniq | cut -c2-); do
     yq eval -i ".updates += {\"package-ecosystem\":\"pip\",\"directory\":\"${directory}\",\"schedule\":{\"interval\":\"daily\"},\"open-pull-requests-limit\":10}" .github/dependabot.yml
done
