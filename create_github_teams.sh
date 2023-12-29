#! /bin/bash

ORGANIZATION=$1
TEAM_NAME=$2
TEAM_DESCRIPTION=$3
TEAM_PERMISSION=$4
TEAM_NOTIFICATION_SETTING=$5
TEAM_PRIVACY=$6
TEAM_OWNERS=$7
REPOSITORY_NAMES=$8

# Check if the variable is empty or not provided
if [ -z "$ORGANIZATION" ]; then
    echo "Error: Organization not provided."
    exit 1
fi

if [ -z "$TEAM_NAME" ]; then
    echo "Error: Team name is not provided"
    exit 1
fi

# Convert TEAM_OWNERS to an array
IFS=',' read -ra TEAM_OWNERS_ARRAY <<< "$TEAM_OWNERS"

# Convert REPOSITORY_NAMES to a comma-separated string
REPOSITORY_NAMES_STRING=$(IFS=, ; echo "${REPOSITORY_NAMES_ARRAY[*]}")

curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GH_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/orgs/$ORGANIZATION/teams \
  -d "{\"name\":\"$TEAM_NAME\",\"description\":\"$TEAM_DESCRIPTION\",\"maintainers\":${TEAM_OWNERS_ARRAY[@]},\"repo_names\":\"$REPOSITORY_NAMES_STRING\",\"permission\":\"$TEAM_PERMISSION\",\"notification_setting\":\"$TEAM_NOTIFICATION_SETTING\",\"privacy\":\"$TEAM_PRIVACY\"}"