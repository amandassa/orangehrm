#!/bin/bash

apt-get install -y nodejs

which testrigor || npm install -g testrigor-cli --verbose

testrigor --version

git config --global --add safe.directory /var/www

BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"
COMMIT_NAME="$(git rev-parse --verify HEAD)"

# Define default values for missing variables

ORANGEHRM_TEST_SUITE_ID="fZ9vEeN353zJeAWRu"
ORANGEHRM_AUTH_TOKEN="76a9fdfb-e1a1-49b8-97ac-3c9b912dc8f9"
LOCALHOST_URL="http://0.0.0.0/"

# Paths for the test cases and rules files
TEST_CASES_PATH="src/tests/testRigor/testcases/**/*.txt"
RULES_PATH="src/tests/testRigor/rules/**/*.txt"

# # php7.4 -S 127.0.0.1:80 -t . &
# php7.4 installer/cli_install.php
# mysqldump -V
# php7.4 devTools/core/console.php i:create-test-db -p root --dump-options="--column-statistics=0"
# sudo service apache2 restart
# curl "$LOCALHOST_URL"

# Command to run the tests using the testRigor CLI
testrigor test-suite run "$ORANGEHRM_TEST_SUITE_ID" --token "$ORANGEHRM_AUTH_TOKEN" --localhost --url "$LOCALHOST_URL" --test-cases-path "$TEST_CASES_PATH" --rules-path "$RULES_PATH" --branch "$BRANCH_NAME" --commit "$COMMIT_NAME"