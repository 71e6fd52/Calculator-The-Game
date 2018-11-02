class Button
  def class(str)
    case str
    when /^+/ then Plus
    end
  end
end

class Plus
  attr_accessor :number

  def self.parse(str)
    m = str.match(/^+(\d+)$/)
    raise 'Not Plus' unless m
    new(m[1].to_i)
  end

  def initialize(num)
    @number = num
  end

  def click(now)
    now + num
  end
end

class Minus
  attr_accessor :number

  def self.parse(str)
    m = str.match(/^-(\d+)$/)
    raise 'Not Minus' unless m
    new(m[1].to_i)
  end

  def initialize(num)
    @number = num
  end

  def click(now)
    now - num
  end
end
