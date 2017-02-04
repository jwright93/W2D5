require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map.include?(key)
      link = @map[key]
      update_link!(link)
      link.val
    else
      calc!(key)
    end

  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    val = @prc.call(key)
    @store.append(key, val)
    link = @store.last
    @map[key] = link
    eject! if count > @max
    val
  end

  def update_link!(link)
    @store.remove(link.key)
    @store.append(link.key, link.val)
  end

  def eject!
    first = @store.first
    k = first.key
    @store.remove(k)
    @map.delete(k)
  end
end
