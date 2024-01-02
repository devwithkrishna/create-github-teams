# CREATE GITHUB TEAMS
=================================================

## Create github teams using rest api and github workflow

```
 To create a team, the authenticated user must be a member or owner of organization. By default, organization members can create teams. Organization owners can limit team creation to organization owners. 
```

For more information, see [Setting team creation permissions](https://docs.github.com/en/rest/teams/teams?apiVersion=2022-11-28#create-a-team)

### How code works
* requires owner name / organization name
* requires teams name

* The credential used is ```FINE GRAINED PERSONAL ACCESS TOKEN```

|Arguments | type|description|
|----------|-----|-----------|
| organization | string| The organization name. The name is not case sensitive.|
| team_name  | string |The name of the team.|
| team_description| string | The description of the team.|
| maintainers | array of strings | List GitHub IDs for organization members who will become team maintainers.|
| privacy | string | The level of privacy this team should have. Can be one of: secret, closed |
| notification_setting | string | Default: notifications_enabled Can be one of: notifications_enabled, notifications_disabled |
| permission | string | Default: pull , Can be one of: pull, push |

 * The script create_github_teams.sh will accept the above parameters from github workflow and use Github rest api to create teams.
 * Work flow file used is create_github_teams.yml


## Delete a github team using rest api and github workflow

```
To delete a team, the authenticated user must be an organization owner or team maintainer.

If you are an organization owner, deleting a parent team will delete all of its child teams as well.
```
[delete-a-github-team](https://docs.github.com/en/rest/teams/teams?apiVersion=2022-11-28#delete-a-team)

### How code works
* requires owner name / organization name
* requires team slug (this is retrieved using list teams and jq function matching team name)

* The credential used is ```FINE GRAINED PERSONAL ACCESS TOKEN```

|Arguments | type|description|
|----------|-----|-----------|
| organization | string| The organization name. The name is not case sensitive.|
| team_slug  | string |The slug of team name.|

* team slug name is retrieved using list teams api  [list-github-teams](https://docs.github.com/en/rest/teams/teams?apiVersion=2022-11-28#list-teams)

 * The script delete_github_teams.sh will accept the above parameters from github workflow and use Github rest api to delete teams.
 * Work flow file used is delete_github_teams.yml