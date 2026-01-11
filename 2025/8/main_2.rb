# frozen_string_literal: true

Point = Data.define(:x, :y, :z)

FILE = 'input.txt'

# FILE        = 'input_test.txt'

def calc_distance_squared(p1, p2)
  ((p1.x - p2.x)**2) + ((p1.y - p2.y)**2) + ((p1.z - p2.z)**2)
end

points = File
         .readlines(File.join(__dir__, FILE), chomp: true)
         .map { Point.new(*it.split(',').map(&:to_f)) }

@connections = {}

@distances = {}

p 'Calc distances...'
points.each_with_index do |p1, i|
  @connections[i] = []

  points.each_with_index do |p2, j|
    @distances[[i, j]] =
      if i == j
        Float::MAX
      else
        calc_distance_squared(p1, p2)
      end
  end
end

@distances_sorted = @distances.sort_by { |_, v| v }.to_a

def connected?(start, target)
  visited = Set.new

  nodes_to_check = [start]

  while nodes_to_check.any?
    current_node = nodes_to_check.shift
    return true if current_node == target

    next if visited.include?(current_node)

    visited << current_node
    nodes_to_check.concat(@connections[current_node])
  end

  false
end

def connected_nodes(start, visited)
  stack = [start]

  while stack.any?
    current_node = stack.pop
    next if visited.include?(current_node)

    visited << current_node
    stack.concat(@connections[current_node])
  end
end

p 'Finding connections...'

prev_i           = -1
prev_j           = -1
@distances_sorted.each_key do |(i, j)|
  next if prev_i == j && prev_j == i # @distances contains two values for each pair of nodes

  prev_i = i
  prev_j = j

  next if @connections[i].include?(j) || @connections[j].include?(i)

  @connections[i] << j
  @connections[j] << i

  # puts "Connect #{i} #{j} => #{points[i]} -> #{points[j]}"
  visited = Set.new
  connected_nodes(i, visited)

  break if visited.size == points.size
end

p points[prev_i].x
p points[prev_j].x
p points[prev_i].x * points[prev_j].x
