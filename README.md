# compare-finos-metadata-projects
Compare revisions of projects.json from FINOS metadata repo

# Usage (using GitHub repo):

Script has 2 args:

- 1st: commit SHA to compare from
- 2nd: commit SHA to compare to (optional and defaults to HEAD).

This gets `from` SHA projects.json and `to` SHA proejcts.json (defaulting to current one `HEAD`).

Then it removes comments, whitespace lines, sorts keys and finally creates a compared JSON result: `projects.json.diff` - so updating our `finos/shared.yaml` is easier.

# Usage (using GitLab repo):

- You need to get a version for Gitlab and GitHub, save them as `projects_gitlab.json` and `projects_gthub.json`.
