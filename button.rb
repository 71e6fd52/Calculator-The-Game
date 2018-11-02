class Button
  def self.parse(str)
    case str
    when /^\+/ then Plus
    when /^-/ then Minus
    end.parse(str)
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

  def click(now)
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

  def click(now)
    now - num
  end

  def to_s
    "-#{num}"
  end
end
