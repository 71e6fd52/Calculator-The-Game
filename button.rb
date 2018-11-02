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
      when /^Reverse/i then Reverse
      when '<<' then Left
      when '>>' then Right
      when /=>/ then To
      when /^\d/ then Number
      end
    c.method_defined?(:parse) ? c.parse(str) : c.new
  end
end

class Number
  attr_accessor :num

  def self.parse(str)
    m = str.match(/^([0-9.]+)$/)
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
    m = str.match(/^\+([0-9.]+)$/)
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
    m = str.match(/^-([0-9.]+)$/)
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
    m = str.match(/^\*([0-9.]+)$/)
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
    m = str.match(%r{^/([0-9.]+)$})
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
    m = str.match(/^\^([0-9.]+)$/)
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
    new(m[1].to_i, m[2].to_i)
  end

  def initialize(a, b)
    @from = a
    @to = b
  end

  def click(now, _all)
    now.to_s.gsub(@from.to_s, @to.to_s).to_i
  end

  def to_s
    "#{@from}=>#{@to}"
  end
end
