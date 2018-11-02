#!/usr/bin/env ruby

require './button'

Inf = 1.0 / 0

print 'Start: '
START = gets.to_i
print 'Goal: '
GOAL = gets.to_i
# print 'Move: '
# m = gets.to_i
MOVE = Inf

list = []
STDIN.each_line do |line|
  list << Button.parse(line)
end

(1..MOVE).each do |move|
  list.repeated_permutation(move) do |a|
    stop = false
    result = a.inject(START) do |sum, op|
      stop = true if sum % 1 != 0
      sum = sum.to_i
      stop = true if sum.to_s.length > 6
      op.click(sum, list)
    end
    next if stop
    if result == GOAL
      puts a.join ' '
      exit if MOVE == Inf
    end
  end
end
