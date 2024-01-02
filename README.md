# CREATE GITHUB TEAMS
=================================================

## Create github teams using rest api and github workflow

```
 To create a team, the authenticated user must be a member or owner of {org}. By default, organization members can create teams. Organization owners can limit team creation to organization owners. 
```

For more information, see [Setting team creation permissions](https://docs.github.com/en/rest/teams/teams?apiVersion=2022-11-28#create-a-team)

### How code works
requires owner name / organization name
requires teams name

|Arguments | type|description|
|----------|-----|-----------|
| organization | string| The organization name. The name is not case sensitive.|
| team_name  | string |The name of the team.|
| team_description| string | The description of the team.|
| maintainers | array of strings | List GitHub IDs for organization members who will become team maintainers.|
| privacy | string | Can be one of: secret, closed |
| notification_setting | string | Default: notifications_enabled Can be one of: notifications_enabled, notifications_disabled |
| permission | string | Default: pull , Can be one of: pull, push |



