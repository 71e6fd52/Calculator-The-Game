class Proc
  attr_accessor :my_name
  alias to_s_old to_s
  def to_s
    return to_s_old if my_name.nil?
    my_name
  end
end

def proc_name(p, n)
  p.my_name = n
  p
end

def a(g)
  proc_name(->(s) { (s.to_i.to_s + g.to_i.to_s).to_i }, g.to_s)
end

def p(g)
  proc_name(->(s) { s + g }, "+#{g}")
end

def m(g)
  proc_name(->(s) { s - g }, "-#{g}")
end

def t(g)
  proc_name(->(s) { s * g }, "*#{g}")
end

def d(g)
  proc_name(->(s) { s / g.to_f }, "/#{g}")
end

def power(g)
  proc_name(->(s) { s**g }, "^#{g}")
end

def r
  a = lambda do |s|
    rs = s.to_i.to_s.reverse.to_i
    rs = -rs if s < 0
    rs
  end
  proc_name(a, 'Reverse')
end

def g
  proc_name(->(s) { -s }, '+/-')
end

def left
  proc_name(->(s) { s / 10 }, '<<')
end

def right
  proc_name(->(s) { s * 10 }, '>>')
end

def to(a, b)
  proc_name(->(s) { s.to_i.to_s.gsub(a.to_s, b.to_s).to_i }, "#{a}=>#{b}")
end

def sum
  a = lambda do |s|
    rs = s.to_i.to_s.split('').collect(&:to_i).inject(&:+).to_i
    rs = -rs if s < 0
    rs
  end
  proc_name(a, 'SUM')
end

def ls
  a = lambda do |s|
    v = s.to_i.to_s.split ''
    rs = v.push(v.shift).join('').to_i
    rs = -rs if s < 0
    rs
  end
  proc_name(a, '<Shift')
end

def rs
  a = lambda do |s|
    v = s.to_i.to_s.split ''
    rs = v.unshift(v.pop).join('').to_i
    rs = -rs if s < 0
    rs
  end
  proc_name(a, 'Shift>')
end

def mirror
  a = lambda do |s|
    rs = (s.to_s + s.to_i.to_s.reverse).to_i
    rs = -rs if s < 0
    rs
  end
  proc_name(a, 'Mirror')
end
