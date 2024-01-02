#! /bin/bash

# https://docs.github.com/en/rest/teams/teams?apiVersion=2022-11-28#add-or-update-team-repository-permissions

ORGANIZATION=$1
TEAM_NAME=$2
REPO_NAMES=$3
PERMISSION=$4
PER_PAGE=100

# List all teams in the organization 
  list_all_team_details=$(curl -L \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $GH_TOKEN" \
    -H "X-GitHub-Api-Version: 2022-11-28" \
    https://api.github.com/orgs/$ORGANIZATION/teams?per_page=$PER_PAGE)

echo $list_all_team_details

  # Use jq to extract the slug based on the team name
TEAM_SLUG=$(echo "$list_all_team_details" | jq -r ".[] | select(.name == \"$TEAM_NAME\") | .slug")

echo "Team name: $TEAM_NAME | Team slug name is: $TEAM_SLUG"

# Split the comma-separated values into an array
IFS=',' read -ra repo_array <<< "$REPO_NAMES"

# Iterate over each repository name
for repo_name in "${repo_array[@]}"; do
    echo "Processing repository: $repo_name"

      response=$(curl -i -L \
        -X PUT \
        -H "Accept: application/vnd.github+json" \
        -H "Authorization: Bearer $GH_TOKEN" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        "https://api.github.com/orgs/$ORGANIZATION/teams/$TEAM_SLUG/repos/$ORGANIZATION/$repo_name" \
        -d "{\"permission\":\"$PERMISSION\"}")

      # Used for debugging bash script
      # response=$(curl -i -L \
      #   -X PUT \
      #   -H "Accept: application/vnd.github+json" \
      #   -H "Authorization: Bearer $GH_TOKEN" \
      #   -H "X-GitHub-Api-Version: 2022-11-28" \
      #   "https://api.github.com/orgs/$ORGANIZATION/teams/$TEAM_SLUG/repos/$ORGANIZATION/$repo_name" \
      #   -d "{\"permission\":\"$PERMISSION\"}" \
      #   > response.txt 2>&1)
done
