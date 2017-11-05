#!/usr/bin/env ruby

require './helper'

Inf = 1.0 / 0

print 'Start: '
START = gets.to_i
print 'Goal: '
GOAL = gets.to_i
# print 'Move: '
# m = gets.to_i
MOVE = Inf

open('config.rb', 'w') do |f|
  f.puts 'LIST = ['
  STDIN.each_line do |line|
    a = line.split(' ')
    if a.size == 1
      f.puts "#{a.first},"
    else
      first = a.shift
      f.puts "#{first}(#{a.join ', '}),"
    end
  end
  f.puts '].freeze'
end

require './config'

(1..MOVE).each do |move|
  LIST.repeated_permutation(move) do |a|
    stop = false
    result = a.inject(START) do |sum, op|
      stop = true if sum % 1 != 0
      op.call(sum)
    end
    next if stop
    if result == GOAL
      puts a.join ' '
      exit if MOVE == Inf
    end
  end
end
