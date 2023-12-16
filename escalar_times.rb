require 'pp'

# From https://stackoverflow.com/a/16363159
class String
  def black;          "\e[30m#{self}\e[0m" end
  def red;            "\e[31m#{self}\e[0m" end
  def green;          "\e[32m#{self}\e[0m" end
  def brown;          "\e[33m#{self}\e[0m" end
  def blue;           "\e[34m#{self}\e[0m" end
  def magenta;        "\e[35m#{self}\e[0m" end
  def cyan;           "\e[36m#{self}\e[0m" end
  def gray;           "\e[37m#{self}\e[0m" end
  
  def bg_black;       "\e[40m#{self}\e[0m" end
  def bg_red;         "\e[41m#{self}\e[0m" end
  def bg_green;       "\e[42m#{self}\e[0m" end
  def bg_brown;       "\e[43m#{self}\e[0m" end
  def bg_blue;        "\e[44m#{self}\e[0m" end
  def bg_magenta;     "\e[45m#{self}\e[0m" end
  def bg_cyan;        "\e[46m#{self}\e[0m" end
  def bg_gray;        "\e[47m#{self}\e[0m" end
  
  def bold;           "\e[1m#{self}\e[22m" end
  def italic;         "\e[3m#{self}\e[23m" end
  def underline;      "\e[4m#{self}\e[24m" end
  def blink;          "\e[5m#{self}\e[25m" end
  def reverse_color;  "\e[7m#{self}\e[27m" end
end
  

def read_line
  c = ""
  line = ""

  loop do
    c = STDIN.getc
    break if c == "\n" or c == nil
    line += c
  end

  line.strip
end

players = []

loop do
  player = read_line

  break if player == ""

  players.push player
end

def get_greater_size(strings)
  greater = 0

  for string in strings do
    if string.length > greater then
      greater = string.length
    end
  end

  greater
end

size_of_lines = get_greater_size(players) * 2

teams = []

current_team = 0

# use floor
number_of_teams = players.length / 5 + 1;

while players.length > 0 do
  index = rand(1..players.length) - 1
  
  team_index = current_team % number_of_teams

  if teams[team_index] == nil then
    teams[team_index] = []
  end

  teams[team_index].push players[index]

  players.delete players[index]

  current_team += 1
end

current_team = 1

puts "\n"

for team in teams do
  base_message = "Time #{current_team}: #{team.length} jogadores"
  
  base_message += " " * (size_of_lines - base_message.length)
  
  puts base_message.bg_red

  for player in team do
    player_message = "- #{player}"

    player_message += " " * (size_of_lines - player_message.length)

    puts player_message.bg_gray.black
  end

  current_team += 1
end

puts "\n"
