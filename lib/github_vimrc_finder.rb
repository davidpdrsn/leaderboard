require 'github_url_formatter'
require 'net/http'
require 'json'

class GitHubVimrcFinder
  def initialize git_path
    @git_path = git_path
    @formatter = GitHubUrlFormatter.new
  end

  def vimrc_contents
    Net::HTTP.get URI @formatter.github_to_raw(vimrc_path)
  end

  private

  def vimrc_path
    git_url = @formatter.git_to_api @git_path
    JSON.parse(Net::HTTP.get(URI git_url)).detect {|stuff| stuff["name"].include? 'vimrc' }['html_url']
  end
end
