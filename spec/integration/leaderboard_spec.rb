require 'spec_helper'
require 'leaderboard'

describe "the integrated leaderboard class" do
  context "when given a filepath" do
    it "parses a vimrc and finds all the leader commands" do
      leaderboard = Leaderboard.new("spec/fixtures/my_vimrc").parse

      leaderboard.should include({ mapping: 'at', command: ':CtrlPTag<cr>' })
      leaderboard.should include({ mapping: 'cc', command: ':CtrlPClearAllCache<cr>' })
    end
  end

  context "when given a url" do
    it "parses a vimrc and finds all the leader commands", requires_network: true do
      leaderboard = Leaderboard.new("https://raw.github.com/davidpdrsn/dotfiles/master/vimrc").parse

      leaderboard.should include({ mapping: 'at', command: ':CtrlPTag<cr>' })
      leaderboard.should include({ mapping: 'cc', command: ':CtrlPClearAllCache<cr>' })
    end
  end

  context "when given a path to a git repo" do
    it "parses a vimrc and finds all the leader commands", requires_network: true do
      leaderboard = Leaderboard.new("https://github.com/davidpdrsn/dotfiles.git").parse

      leaderboard.should include({ mapping: 'at', command: ':CtrlPTag<cr>' })
      leaderboard.should include({ mapping: 'cc', command: ':CtrlPClearAllCache<cr>' })
    end
  end
end
