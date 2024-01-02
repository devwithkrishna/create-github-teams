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
For more information, [delete-a-github-team](https://docs.github.com/en/rest/teams/teams?apiVersion=2022-11-28#delete-a-team)

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

 ## Provide a team access to specific repositories

 ```
 To add a repository to a team or update the team's permission on a repository, the authenticated user must have admin access to the repository, and must be able to see the team. The repository must be owned by the organization, or a direct fork of a repository owned by the organization. You will get a 422 Unprocessable Entity status if you attempt to add a repository to a team that is not owned by the organization.
 ```

For more information, [add-or-update-team-repository-permissions](https://docs.github.com/en/rest/teams/teams?apiVersion=2022-11-28#add-or-update-team-repository-permissions)

### How code works
* requires owner name / organization name
* requires team slug (this is retrieved using list teams and jq function matching team name)

* The credential used is ```FINE GRAINED PERSONAL ACCESS TOKEN```

|Arguments | type|description|
|----------|-----|-----------|
| organization | string| The organization name. The name is not case sensitive.|
| team_slug  | string |The slug of team name.|
| owner | string | The account owner of the repository. The name is not case sensitive.|
| repo_names | strings | The name of the repository without the .git extension. The name is not case sensitive.|
| permission | choice | permissions to be set: pull, triage, push, maintain, admin. default:push |

:pushpin: repo_names --> multiple inputs can be provided as comma seperated values Eg: a,b,c

* team slug name is retrieved using list teams api  [list-github-teams](https://docs.github.com/en/rest/teams/teams?apiVersion=2022-11-28#list-teams)

* Permissions
  -----------
  * pull / read : Can read and clone this repository. Can also open and comment on issues and pull requests.
  * push / write : Can read, clone, and push to this repository. Can also manage issues and pull requests.
  * admin : Can read, clone, and push to this repository. Can also manage issues, pull requests, and repository settings, including adding collaborators.
  * triage : Can read and clone this repository. Can also manage issues and pull requests.
  * mantain : Can read, clone, and push to this repository. They can also manage issues, pull requests, and some repository settings. 

```
 * The script provide_repo_access_for_teams.sh will accept the above parameters from github workflow and use Github rest api to add provided repositories to github teams and permissions.
 
 * Work flow file used is provide_repo_access_for_teams.yml
```

## Remove a repository from github teams

```
If the authenticated user is an organization owner or a team maintainer, they can remove any repositories from the team. To remove a repository from a team as an organization member, the authenticated user must have admin access to the repository and must be able to see the team. This does not delete the repository, it just removes it from the team.
```
For more information, [remove-a-repository-from-a-team--parameters](https://docs.github.com/en/rest/teams/teams?apiVersion=2022-11-28#remove-a-repository-from-a-team--parameters)

### How code works
* requires owner name / organization name
* requires team slug (this is retrieved using list teams and jq function matching team name)


* The credential used is ```FINE GRAINED PERSONAL ACCESS TOKEN```

|Arguments | type|description|
|----------|-----|-----------|
| organization | string| The organization name. The name is not case sensitive.|
| team_slug  | string |The slug of team name.|
| owner | string | The account owner of the repository. The name is not case sensitive.|
| repo_names | strings | The name of the repository without the .git extension. The name is not case sensitive.|

:pushpin: repo_names --> multiple inputs can be provided as comma seperated values Eg: a,b,c

* team slug name is retrieved using list teams api  [list-github-teams](https://docs.github.com/en/rest/teams/teams?apiVersion=2022-11-28#list-teams)

```
 * The script remove_repo_access_from_teams.sh will accept the above parameters from github workflow and use Github rest api to remove  repositories from github teams and permissions.
 
 * Work flow file used is remove_repo_access_from_teams.yml
```