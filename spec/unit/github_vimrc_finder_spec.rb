require 'spec_helper'
require 'net/http'
require 'github_vimrc_finder'

describe GitHubVimrcFinder do
  describe "#vimrc_contents" do
    it "returns the contents of the vimrc file in the root of the repo" do
      my_vimrc = Net::HTTP.get URI "https://raw.github.com/davidpdrsn/dotfiles/master/vimrc"
      finder = GitHubVimrcFinder.new 'https://github.com/davidpdrsn/dotfiles.git'
      finder.vimrc_contents.should eq my_vimrc
    end
  end
end
