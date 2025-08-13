#!/bin/bash

# Install testrigor CLI if not present
which testrigor || npm install -g testrigor-cli --verbose

testrigor --version

git config --global --add safe.directory /var/www

BRANCH_NAME="$(git rev-parse --abbrev-ref HEAD)"
COMMIT_NAME="$(git rev-parse --verify HEAD)"

# Define default values for missing variables

ORANGEHRM_TEST_SUITE_ID="$SUITE_ID"
ORANGEHRM_AUTH_TOKEN="$AUTH_TOKEN"
LOCALHOST_URL="http://127.0.0.1"

# Paths for the test cases and rules files
TEST_CASES_PATH="src/tests/testRigor/testcases/**/*.txt"
RULES_PATH="src/tests/testRigor/rules/**/*.txt"

# Setup OrangeHRM for testing
# php -S 127.0.0.1:80 -t . &
php installer/cli_install.php
mysqldump -V
php devTools/core/console.php i:create-test-db -p root --dump-options="--column-statistics=0"
sudo service apache2 restart
curl "$LOCALHOST_URL"

# Command to run the tests using the testRigor CLI
testrigor test-suite run "$ORANGEHRM_TEST_SUITE_ID" --token "$ORANGEHRM_AUTH_TOKEN" --localhost --url "$LOCALHOST_URL" --test-cases-path "$TEST_CASES_PATH" --rules-path "$RULES_PATH" --branch "$BRANCH_NAME" --commit "$COMMIT_NAME"