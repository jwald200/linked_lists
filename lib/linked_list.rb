class Node
  attr_accessor :value, :next_node

  def initialize(value = nil, next_node = nil)
    @value = value
    @next_node = next_node
  end

  def to_s
    "( #{value} )"
  end
end

class LinkedList
  attr_reader :head, :tail

  def initialize
    reset
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
    size.zero?
  end

  def size
    to_a.size
  end

  def at(index)
    to_a[index]
  end

  def each(&block)
    return enum_for(:each) unless block_given?

    current_node = head
    while current_node
      yield(current_node)

      current_node = current_node.next_node
    end

    self
  end

  def contains?(value)
    values.include? value
  end

  def find(value)
    values.index(value)
  end

  def pop
    old_tail = tail

    if head == tail
      reset
    else
      @tail = at(size - 2)
      @tail.next_node = nil
    end

    old_tail
  end

  def shift
    old_head = head
    if head == tail
      reset
    end

    @head = at(1)
    old_head
  end

  def remove_at(index)
    node = at(index)

    if node == tail
      pop
    elsif node == head
      shift
    else
      at(index - 1).next_node = at(index + 1)
    end
  end

  def to_a
    each.to_a
  end

  def to_s
    to_a.map(&:to_s).join(' -> ') + ' -> nil'
  end

  def values
    each.map(&:value)
  end

  def reset
    @head = nil
    @tail = nil
  end
end
