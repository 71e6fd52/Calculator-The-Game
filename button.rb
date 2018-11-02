class Button
  def self.parse(str)
    c = \
      case str
      when '+/-' then Opposite
      when /^\+/ then Plus
      when /^-/ then Minus
      when /^\*/ then Multiply
      when %r{^/} then Divide
      when /^\^/ then Multiply
      when /^Rev/i then Reverse
      when '<<' then Left
      when '>>' then Right
      when /=>/ then To
      when /^SUM/i then SUM
      when /^<Shift$/i then LeftShift
      when /^Shift>$/i then RightShift
      when /^Mir/i then Mirror
      when /^\[.\]/ then Modify
      when /^\d/ then Number
      when /^Sto/i then Store
      end
    c.methods.include?(:parse) ? c.parse(str) : c.new
  end
end

class Number
  attr_accessor :num

  def self.parse(str)
    m = str.match(/^(\d+)$/)
    raise 'Not Number' unless m
    new(m[1].to_i)
  end

  def initialize(num)
    @num = num
  end

  def click(now, _all)
    (now.to_s + num.to_s).to_i
  end

  def to_s
    num.to_s
  end
end

class Plus
  attr_accessor :num

  def self.parse(str)
    m = str.match(/^\+(\d+)$/)
    raise 'Not Plus' unless m
    new(m[1].to_i)
  end

  def initialize(num)
    @num = num
  end

  def click(now, _all)
    now + @num
  end

  def to_s
    "+#{num}"
  end
end

class Minus
  attr_accessor :num

  def self.parse(str)
    m = str.match(/^-(\d+)$/)
    raise 'Not Minus' unless m
    new(m[1].to_i)
  end

  def initialize(num)
    @num = num
  end

  def click(now, _all)
    now - num
  end

  def to_s
    "-#{num}"
  end
end

class Multiply
  attr_accessor :num

  def self.parse(str)
    m = str.match(/^\*(\d+)$/)
    raise 'Not Multiply' unless m
    new(m[1].to_i)
  end

  def initialize(num)
    @num = num
  end

  def click(now, _all)
    now * num
  end

  def to_s
    "*#{num}"
  end
end

class Divide
  attr_accessor :num

  def self.parse(str)
    m = str.match(%r{^/(\d+)$})
    raise 'Not Divide' unless m
    new(m[1].to_i)
  end

  def initialize(num)
    @num = num
  end

  def click(now, _all)
    now.to_f / num
  end

  def to_s
    "/#{num}"
  end
end

class Power
  attr_accessor :num

  def self.parse(str)
    m = str.match(/^\^(\d+)$/)
    raise 'Not Power' unless m
    new(m[1].to_i)
  end

  def initialize(num)
    @num = num
  end

  def click(now, _all)
    now**num
  end

  def to_s
    "^#{num}"
  end
end

class Reverse
  def click(now, _all)
    now.to_s.reverse.to_i
  end

  def to_s
    'Reverse'
  end
end

class Opposite
  def click(now, _all)
    -now
  end

  def to_s
    '+/-'
  end
end

class Left
  def click(now, _all)
    now / 10
  end

  def to_s
    '<<'
  end
end

class Right
  def click(now, _all)
    now * 10
  end

  def to_s
    '>>'
  end
end

class To
  attr_accessor :from, :to

  def self.parse(str)
    m = str.match(/^(\d+)=>(\d+)$/)
    raise 'Not To' unless m
    new(m[1], m[2])
  end

  def initialize(a, b)
    @from = a
    @to = b
  end

  def click(now, _all)
    now.to_s.gsub(@from, @to).to_i
  end

  def to_s
    "#{@from}=>#{@to}"
  end
end

class SUM
  def click(now, _all)
    rs = now.to_s.split('').collect(&:to_i).sum
    rs *= -1 if now < 0
    rs
  end

  def to_s
    'SUM'
  end
end

class LeftShift
  def click(now, _all)
    v = now.abs.to_s.split('')
    rs = v.push(v.shift).join('').to_i
    rs *= -1 if now < 0
    rs
  end

  def to_s
    '<Shift'
  end
end

class RightShift
  def click(now, _all)
    v = now.abs.to_s.split('')
    rs = v.unshift(v.pop).join('').to_i
    rs *= -1 if now < 0
    rs
  end

  def to_s
    'Shift>'
  end
end

class Mirror
  def click(now, _all)
    (now.to_s + now.to_s.reverse).to_i
    # "-1221-".to_i = -1221
  end

  def to_s
    'Mirror'
  end
end

class Modify
  attr_accessor :operation, :number

  def self.parse(str)
    m = str.match(/^\[(.)\]\s?(\d+)$/)
    raise 'Not Modify' unless m
    new(m[1], m[2].to_i)
  end

  def initialize(oper, num)
    @operation = oper
    @number = num
  end

  def click(now, all)
    all.each do |button|
      next if button.class == Modify
      button.num += @number if button.methods.include? :num=
    end
    now
  end

  def to_s
    "[#{operation}]#{number}"
  end
end

class Store
  attr_accessor :number

  LONG = true

  def click(now, _all)
    (now.to_s + @number.to_s).to_i
  end

  def long_click(now, _all)
    @number = now
  end

  def to_s
    @number.nil? ? 'Store' : @number.to_s
  end
end
