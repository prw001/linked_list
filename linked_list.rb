class LinkedList
	def initialize
		@tail = nil
		@head = @tail
		@length = 0
	end
	private
	def to_end(node)
		while node.next_node != @tail
			node = node.next_node
		end
		return node
	end
	public
	def append(value)
		if @head == @tail
			@head = Node.new(value, @tail)
		else
			current_node = @head
			current_node = to_end(current_node)
			current_node.next_node = Node.new(value, @tail)
		end
		@length += 1
	end

	def prepend(value)
		if @length == 0
			@head = Node.new(value, @tail)
		else
			node = Node.new(value, @head)
			@head = node
		end
		@length += 1
	end

	def size
		puts @length
		return @length
	end

	def head
		puts @head
	end

	def tail
		current_node = @head
		current_node = to_end(current_node)
		puts current_node
		return current_node
	end

	def at_index(index)
		if index < 0 || index > @length - 1
			puts 'nil'
			return nil
		else 
			current_node = @head
			(index).times do 
				current_node = current_node.next_node
			end
			puts current_node.value
			return current_node.value
		end
	end

	def pop
		if @length == 0
			puts nil
			return nil
		else
			node = @head
			while node.next_node.next_node != @tail
				node = node.next_node
			end
			pop_node = node.next_node
			node.next_node = @tail
			puts pop_node
			@length -= 1
			return pop_node
		end
	end

	def contains?(value)
		if @length == 0
			return false
		else
			if find(value)
				puts true
				return true
			else
				puts false
				return false
			end
		end
	end

	def find(data)
		#returns index at which a node exists that contains 'data',
		#else returns nil
		case 
		when @head == @tail
			puts 'nil'
			return nil
		when @head.value == data
			puts 0
			return 0
		else
			current_node = @head
			index = 0
			while current_node.value != data && current_node.next_node != @tail
				index += 1
				current_node = current_node.next_node
			end
			if current_node.value == data
				puts index
				return index
			else
				puts 'nil'
				return nil
			end
		end
	end

	def to_s
		s = ''
		current_node = @head
		(@length).times do 
			s += current_node.value.to_s + " -> "
			current_node = current_node.next_node
		end
		puts s.slice(0, (s.length - 4))
	end

	def insert_at(index)
		if index < 0 || index > (@length - 1)
			puts 'nil'
			return nil
		else
			current_node = @head
			case index
			when 0
				prepend(nil)
			when (@length - 1)
				append(nil)
			else
				while (index - 1) > 0
					current_node = current_node.next_node
					index -= 1
				end
				right_hand_node = current_node.next_node
				current_node.next_node = Node.new(nil ,right_hand_node)
			end
			@length += 1
		end
	end

	def remove_at(index)
		if index < 0 || index > (@length - 1)
			puts 'nil'
			return nil
		else
			unless @length == 0 #can't remove nodes from empty list
				current_node = @head
				case index
				when 0
					@head = @head.next_node
					@length -= 1
				when (@length - 1)
					pop()
				else
					while (index) > 0
						prev_node = current_node
						current_node = current_node.next_node
						index -= 1
					end
					prev_node.next_node = current_node.next_node
					current_node.next_node = nil
					@length -= 1
					return current_node
				end
			else
				puts 'nil'
			end
		end
	end
end

class Node
	attr_reader :value
	attr_accessor :next_node
	def initialize(value = nil, next_node = nil)
		@value = value
		@next_node = next_node
	end
end


#Some tests:
list = LinkedList.new
list.size #should return 0
list.append(20)
list.find(20) #should return 0
list.append(42)
list.append(50)
list.prepend(30)
list.size #should return 4
list.find(30) #should return 0
list.append('John')
list.append('Sue')
list.to_s #should return 30 -> 20 -> 42 -> 50 -> John -> Sue
list.find('Sue') #should return 5
list.find('Mark') #should return nil
list.size #should return 6
list.pop #should return Node Object
list.pop #should return different Node Object
list.size #should return 4
list.find(27) #should return nil
list.head #should return first Node Object in list
list.tail #should return last Node Object in list
list.contains?('Sue') #should return nil \n, false
list.contains?(20) #should return index \n, true
list.to_s #should return 30 -> 20 -> 42 -> 50
list.at_index(1) #should return 20
list.at_index(0) #should return 30
list.at_index(10) #should return nil
list.at_index(-2) #should return nil
list.at_index(3) #should return 50
list.insert_at(10) #should return nil
list.insert_at(-1) #should return nil
list.insert_at(2)
list.to_s #should output 30 -> 20 ->  -> 42 -> 50
list.remove_at(2)
list.remove_at(10) #should return nil
list.remove_at(-1) #should return nil
list.to_s #should output 30 -> 20 -> 42 -> 50
list.remove_at(0)
list.remove_at(0)
list.remove_at(0)
list.to_s #should output 50
list.remove_at(0) 
list.remove_at(0) #should return nil