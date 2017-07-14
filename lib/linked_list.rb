class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end
end

class LinkedList
  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    return prepend(value) if empty?

    @tail.next_node = Node.new(value)
    @tail = @tail.next_node
  end

  def prepend(value)
    @head = Node.new(value, @head)
    @tail ||= @head

    @head
  end

  def empty?
    tail.nil? || head.nil?
  end

  def size
    return 0 unless head

    size = 0
    each { |c|size += 1 }
    size
  end

  def at(index)
    loop_index = 0
    each do |node|
      return node if loop_index == index
      loop_index += 1
    end

    nil
  end

  def each(&block)
    current_node = head

    while current_node
      yield(current_node)

      current_node = current_node.next_node
    end

    self
  end

  def contains?(value)
    each { |node| return true if node.value == value }
    false
  end

  def find(value)
    index = 0

    each do |node|
      return index if node.value == value
      index += 1
    end

    nil
  end

  def pop
    one_before_tail = nil

    each do |node|
      one_before_tail = node if node.next_node == tail
    end

    @tail = one_before_tail
    old_tail = one_before_tail.next_node
    @tail.next_node = nil

    old_tail
  end

  def to_a
    array = []
    each { |node| array << node.value }
    array
  end

  def to_s
    to_a.map { |value| "( #{value} )" }.join(' -> ') +
    ' -> nil'
  end
end
