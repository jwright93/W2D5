class Link
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    if @next && @prev
      @next.prev = @prev
      @prev.next = @next
    end
  end
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new
    @tail = Link.new
    @head.prev = @tail
    @tail.next = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @tail.next
  end

  def last
    @head.prev
  end

  def empty?
    @tail.next == @head
  end

  def get(key)
    self.each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    new_link = Link.new(key, val)
    new_link.prev = last
    new_link.next = @head
    last.next = new_link
    @head.prev = new_link
  end

  def update(key, val)
    self.each do |node|
      node.val = val if node.key == key
    end
  end

  def remove(key)
    self.each do |node|
      node.remove if node.key == key
    end
  end

  def each
    current_node = first
    until current_node == @head
      yield(current_node)
      current_node = current_node.next
    end
  end

  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
