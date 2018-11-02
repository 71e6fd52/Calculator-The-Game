#!/usr/bin/env ruby

require './button'
require 'pry'

def button_dup(a)
  a.map do |button|
    case button
    when Store
      button.number = nil
      button
    when Array
      button
    else
      button.dup
    end
  end
end

def stop(found)
  found.sort! { |a, b| a[1] <=> b[1] }
  puts found.first.first
  exit
end

Inf = 100

print 'Start: '
START = gets.to_i
print 'Goal: '
GOAL = gets.to_i
# print 'Move: '
# m = gets.to_i
MOVE = Inf

found_number = 1

list = []
STDIN.each_line do |line|
  list << Button.parse(line.chomp)
  if list.last.class.const_defined?(:LONG) && list.last.class.const_get(:LONG)
    list << [list.last, true]
    found_number = 30
  end
end

found = []

(1..MOVE).each do |move|
  list.repeated_permutation(move) do |a|
    a = button_dup(a)
    stop = false
    text = []
    used = 0
    result = a.each_with_index.inject(START) do |sum, (op, idx)|
      stop = true if sum % 1 != 0
      sum = sum.to_i
      stop = true if sum.to_s.length > 6
      break if stop
      op, long = *op if op.class == Array
      if long
        text << (op.to_s + '(long)')
        op.long_click(sum, a[(idx + 1)...a.length])
      else
        used += 1
        text << op.to_s
        op.click(sum, a[(idx + 1)...a.length])
      end
    end
    next if stop
    if result == GOAL
      found << [text.join(' '), used]
      stop found if MOVE == Inf && found.length >= found_number
    end
  end
  STDERR.puts "#{move} search done."
end
stop found
