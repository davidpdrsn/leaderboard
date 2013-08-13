require 'spec_helper'
require 'leaderboard'

describe "the integrated leaderboard class" do
  it "parses a vimrc and finds all the leader commands" do
    leaderboard = Leaderboard.new("spec/fixtures/my_vimrc").parse

    leaderboard.should include({ mapping: 'at', command: ':CtrlPTag<cr>' })
    leaderboard.should include({ mapping: 'cc', command: ':CtrlPClearAllCache<cr>' })
  end
end
