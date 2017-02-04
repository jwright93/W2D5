
class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    nums = self.map.with_index { |el, i| el.hash + i }
    nums.join.gsub("-", "").to_i.hash
  end
end

class String
  def hash
    nums = self.chars.map { |el| el.ord.to_s }
    nums.join.to_i.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    stored = []
    self.each do |k, v|
      stored << [k, v]
    end
    stored.sort.hash
  end
end
