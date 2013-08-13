require 'net/http'
require 'github_vimrc_finder'

class Leaderboard
  def initialize vimrc_path
    @vimrc_path = vimrc_path
  end

  def parse
    leader_commands_as_strings.inject [] do |mappings, line|
      mappings.push parse_command(line)
    end
  end

  def vimrc
    if @vimrc_path.match URI.regexp
      if @vimrc_path.match /.+\.git$/
        GitHubVimrcFinder.new(@vimrc_path).vimrc_contents
      else
        Net::HTTP.get URI(@vimrc_path)
      end
    else
      File.read @vimrc_path
    end
  end

  def leader_commands_as_strings
    vimrc.split("\n").select { |line| line if line =~ /^.+ <[Ll]eader>.+ .+$/ }
  end

  def mapping_in line
    line.match(/.+ <[Ll]eader>(.+?) .+/)[1]
  end

  def command_in line
    line.match(/.+ <[Ll]eader>.+? (.+)/)[1]
  end

  def parse_command line
    { mapping: mapping_in(line), command: command_in(line) }
  end
end
