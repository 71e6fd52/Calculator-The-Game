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

Inf = 20

print 'Start: '
START = gets.to_i
print 'Goal: '
GOAL = gets.to_i
max_move = Inf

trans = (0..7)

list = []
STDIN.each_line do |line|
  list << Button.parse(line.chomp)
  if list.last.class == Range
    trans = list.pop
  elsif list.last.class.const_defined?(:LONG) && list.last.class.const_get(:LONG)
    list << [list.last, true]
    max_move = 0
  end
end

if max_move != Inf
  print 'Move: '
  max_move = gets.to_i
end

(1..Inf).each do |move|
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
      while sum.to_s.length >= trans.max
        from = sum.to_s[-trans.max].to_i
        sum -= from * 10**(trans.max - 1)
        sum += from * 10**(trans.min - 1)
      end
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
    if result == GOAL && used <= max_move
      puts text.join(' ')
      exit
    end
  end
  STDERR.puts "#{move} search done."
end
