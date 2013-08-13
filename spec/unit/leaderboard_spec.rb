require 'spec_helper'
require 'leaderboard'

describe Leaderboard do
  let(:leaderboard) { Leaderboard.new('spec/fixtures/vimrc') }

  describe "#vimrc" do
    it "returns the contents of a vimrc file" do
      leaderboard.vimrc.should eq "map <leader>w :write<cr>\nmap <leader>ac :CtrlPChange<cr>\n"
    end
  end

  describe "#leader_commands_as_strings" do
    it "returns an array of strings" do
      leaderboard.leader_commands_as_strings.should eq ["map <leader>w :write<cr>", "map <leader>ac :CtrlPChange<cr>"]
    end

    context "when the syntax is slightly different" do
      it "should still return an array of strings" do
        leaderboard.stub(:vimrc).and_return "noremap <Leader>w :write<cr>\n"
        leaderboard.leader_commands_as_strings.should eq ["noremap <Leader>w :write<cr>"]
      end
    end

    context "when there are semicolons in the commands" do
      it "still works" do
        leaderboard.stub(:vimrc).and_return "map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>\n"
        leaderboard.leader_commands_as_strings.should eq ["map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>"]
      end
    end
  end

  describe "#mapping_in" do
    it "finds the mapping in a leader command" do
      mapping = leaderboard.mapping_in "map <leader>w :write<cr>"
      mapping.should eq "w"
    end

    context "when the syntax is slightly different" do
      it "should still return an array of strings" do
        leaderboard.stub(:vimrc).and_return "noremap <Leader>w :write<cr>\n"
        mapping = leaderboard.mapping_in "noremap <Leader>w :write<cr>"
        mapping.should eq "w"
      end
    end

    context "when there are semicolons in the commands" do
      it "still works" do
        leaderboard.stub(:vimrc).and_return "map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>\n"
        mapping = leaderboard.mapping_in "map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>"
        mapping.should eq "gv"
      end
    end
  end

  describe "#command_in" do
    it "finds the command in a leader command" do
      command = leaderboard.command_in "map <leader>w :write<cr>"
      command.should eq ":write<cr>"
    end

    context "when the syntax is slightly different" do
      it "should still return an array of strings" do
        leaderboard.stub(:vimrc).and_return "noremap <Leader>w :write<cr>\n"
        command = leaderboard.command_in "noremap <Leader>w :write<cr>"
        command.should eq ":write<cr>"
      end
    end

    context "when there are semicolons in the commands" do
      it "still works" do
        leaderboard.stub(:vimrc).and_return "map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>\n"
        command = leaderboard.command_in "map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>"
        command.should eq ":CommandTFlush<cr>\|:CommandT app/views<cr>"
      end
    end
  end

  describe "#parse_command" do
    it "returns the leader commands as a hash with the mapping and command" do
      command = leaderboard.parse_command "map <leader>w :write<cr>"
      command.should == { mapping: 'w', command: ':write<cr>' }
    end

    context "when the syntax is slightly different" do
      it "should still return an array of strings" do
        leaderboard.stub(:vimrc).and_return "noremap <Leader>w :write<cr>\n"
        command = leaderboard.parse_command "noremap <Leader>w :write<cr>"
        command.should == { mapping: 'w', command: ':write<cr>' }
      end
    end

    context "when there are semicolons in the commands" do
      it "still works" do
        leaderboard.stub(:vimrc).and_return "map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>\n"
        command = leaderboard.parse_command "map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>"
        command.should == { mapping: 'gv', command: ":CommandTFlush<cr>\|:CommandT app/views<cr>" }
      end
    end
  end

  describe "#parse" do
    it "returns an array of hashes with the mappings and commands" do
      leaderboard.parse.should == [{ mapping: 'w', command: ':write<cr>' }, { mapping: 'ac', command: ':CtrlPChange<cr>' }]
    end
  end
end
