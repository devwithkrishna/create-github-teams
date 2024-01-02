# CREATE GITHUB TEAMS
=================================================

## Create github teams using rest api and github workflow

``` To create a team, the authenticated user must be a member or owner of {org}. By default, organization members can create teams. Organization owners can limit team creation to organization owners. ```

For more information, see [Setting team creation permissions](https://docs.github.com/en/rest/teams/teams?apiVersion=2022-11-28#create-a-team)

### How code works
requires owner name / organization name
requires teams name

|Arguments | type|description|
|----------|-----|-----------|
|organization| string| The organization name. The name is not case sensitive.|

