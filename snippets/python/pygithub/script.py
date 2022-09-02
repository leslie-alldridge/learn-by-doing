# Get open PRs updated first
repo.get_pulls(state="open", sort="updated", direction="desc")

# Get GitHub build CICD results

"""
This is it: https://pygithub.readthedocs.io/en/latest/github_objects/Commit.html#github.Commit.Commit.get_statuses

Which returns a: https://pygithub.readthedocs.io/en/latest/github_objects/CommitStatus.html#github.CommitStatus.CommitStatus

Which is a form of: https://docs.github.com/en/rest/commits/statuses
"""

# Annual commits

for repo in g.get_organization(ORGANIZATION).get_repos():
    print(f"Processing {repo.full_name}...")
    commit_activity = repo.get_stats_commit_activity()

    # We have 52 weeks of commit history to total up
    annual_commits = 0
    for week in commit_activity:
        annual_commits += week.total

    print(f"Totalled {annual_commits} commits.")
