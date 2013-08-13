class GitHubUrlFormatter
  def git_to_api git_path
    "https://api.github.com/repos/#{username_in git_path}/#{repo_in git_path}/contents"
  end

  def github_to_raw github_path
    "https://raw.github.com/#{username_in github_path}/#{repo_in github_path}/master/vimrc"
  end

  private

  def username_in git_path
    git_path.match(/.+?github\.com\/(\w+)\/.*/)[1]
  end

  def repo_in git_path
    git_path.match(/.+?github\.com\/.+?\/(\w+).*/)[1]
  end
end
