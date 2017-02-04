require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    list = @store[bucket(key)]
    list.include?(key)
  end

  def set(key, val)
    list = @store[bucket(key)]
    if include?(key)
      list.update(key, val)
    else
      list.append(key, val)
      @count += 1
    end
    resize! if count > num_buckets
  end

  def get(key)
    list = @store[bucket(key)]
    list.get(key)
  end

  def delete(key)
    raise 'Key not found' unless include?(key)
    list = @store[bucket(key)]
    list.remove(key)
    @count -= 1
  end

  def each
    @store.each do |list|
      list.each do |node|
        yield(node.key, node.val)
      end
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_hash = HashMap.new(num_buckets * 2)
    self.each do |k, v|
      new_hash.set(k, v)
    end
    @store = new_hash.store
  end

  def bucket(key)
    key.hash % num_buckets
  end
end
