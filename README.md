# Leaderboard

Leaderboard is a ruby class that will parse a vimrc file and find all the leader commands. It will output them as a an array of hashes.

## Example usage

```ruby
require 'leaderboard'

leaders = Leaderboard.new '/path/to/your/vimc'

puts leaders      # your leadercommands
puts leaders.size # your number of leader commands
```
