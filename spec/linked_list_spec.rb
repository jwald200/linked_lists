RSpec.describe Node do
  describe 'attributes' do
    it 'has attributes #value and #next_node' do
      expect(Node.new).to have_attributes(value: nil, next_node: nil)
    end
  end
end

RSpec.describe LinkedList do
  let(:linked_list) { LinkedList.new }

  describe '#append' do
    it 'adds a new node to the end of the list' do
      node = linked_list.append('last item')
      expect(linked_list.tail).to eq(node)
    end
  end

  describe '#prepend' do
    it 'adds a new node to the start of the list' do
      node = linked_list.prepend('first item')

      expect(linked_list.head).to eq(node)
    end

    context 'linked_list has nodes' do
      it 'set its next_node to point to the first' do
        first_node = linked_list.append('first item')
        current_node = linked_list.prepend('current item')


        expect(current_node.next_node).to eq(first_node)
      end
    end
  end

  describe '#size' do
    it 'returns the total number of nodes in the list' do
      3.times { |n| linked_list.append(n)}

      expect(linked_list.size).to eq 3
    end

    it 'returns 0 when it has no nodes' do
      expect(linked_list.size).to be_zero
    end

    it 'returns 1 when it only has 1 node' do
      linked_list.append("some node")

      expect(linked_list.size).to be 1
    end
  end

  describe '#at' do
    it 'returns the node at the given index' do
      3.times { |n| linked_list.append("#{n} node")}

      expect(linked_list.at(1).value).to eq('1 node')
    end
  end


  describe '#contains?' do
    it 'returns true if the passed in value is in the list and otherwise returns false.' do
      linked_list.prepend('some value')

      expect(linked_list.contains?('some value')).to be true
      expect(linked_list.contains?('not found')).to be false
    end
  end

  describe '#find' do
    it 'returns the index of the node containing data, or nil if not found.' do
      linked_list.prepend('found data')

      expect(linked_list.find('not found')).to be_nil
      expect(linked_list.find('found data')).to be_zero
    end
  end

  describe '#to_s' do
    it 'represent your LinkedList objects as strings' do
      3.times { |n| linked_list.append("#{n} value")}

      expect(linked_list.to_s).to eq("( 0 value ) -> ( 1 value ) -> ( 2 value ) -> nil")
    end
  end

  describe '#pop' do
    before do
       3.times { |n| linked_list.append("#{n} value") }
       linked_list.pop
    end
    it 'removes the last element from the list' do
      expect(linked_list.tail.value).to eq('1 value')
    end

    it 'removes the next_node pointer from the new tail' do
      expect(linked_list.tail.next_node).to be_nil
    end
  end

  describe '#remove_at(index)' do
    context 'between nodes' do
      it 'updates the link of the nodes.' do
        3.times { |n| linked_list.append("#{n} value") }
        linked_list.remove_at(1)

        expect(linked_list.head.next_node).to eq(linked_list.tail)
      end
    end

    context 'head and tail' do
      it 'removes the node from list and sets tail and head  to nil' do
        linked_list.append('value')
        linked_list.remove_at(0)

        expect(linked_list.size).to be_zero
        expect(linked_list.head).to be_nil
        expect(linked_list.tail).to be_nil
      end
    end

    context 'index is head' do
      it 'sets the head to the next node.' do
        3.times { |n| linked_list.append("#{n} value") }
        linked_list.remove_at(0)

        expect(linked_list.at(0).value).to eq('1 value')
      end
    end

    context 'index is tail' do
      it 'removes the link from node before' do
        3.times { |n| linked_list.append("#{n} value") }
        linked_list.remove_at(2)

        expect(linked_list.at(1).next_node).to be_nil
      end
    end

  end
end
