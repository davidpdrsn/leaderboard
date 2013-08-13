require 'spec_helper'
require 'github_url_formatter'

describe GitHubUrlFormatter do
  let(:formatter) { GitHubUrlFormatter.new }

  describe "#git_to_api" do
    it "turns an .git url into an api url" do
      url = formatter.git_to_api 'https://github.com/davidpdrsn/dotfiles.git'
      url.should eq 'https://api.github.com/repos/davidpdrsn/dotfiles/contents'
    end
  end

  describe "#git_to_api" do
    it "turns a github url into a raw url" do
      url = formatter.github_to_raw 'https://github.com/davidpdrsn/dotfiles/blob/master/vimrc'
      url.should eq 'https://raw.github.com/davidpdrsn/dotfiles/master/vimrc'
    end
  end
end
