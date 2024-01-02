#! /bin/bash

ORGANIZATION=$1
TEAM_NAME=$2

# Lust all teams in the organization 
list_all_team_details=$(curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GH_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/orgs/$ORGANIZATION/teams
  -d "{\"per_page\":\"100\"}")


echo $list_all_team_details

# Use jq to extract the slug based on the team name
TEAM_SLUG=$(echo "$list_all_team_details" | jq -r ".[] | select(.name == \"$TEAM_NAME\") | .slug")

#! /bin/bash

ORGANIZATION=$1
TEAM_NAME=$2

list_all_team_details=$(curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GH_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/orgs/$ORGANIZATION/teams
  -d "{\"per_page\":\"100\"}")

echo $list_all_team_details

# Use jq to extract the slug based on the team name
TEAM_SLUG=$(echo "$list_all_team_details" | jq -r ".[] | select(.name == \"$TEAM_NAME\") | .slug")

echo "Team name: $TEAM_NAME | Team slug name is: $TEAM_SLUG"

# Delete the github team 
curl -L \
  -X DELETE \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GH_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/orgs/ORG/$ORGANIZATION/$TEAM_SLUG

  