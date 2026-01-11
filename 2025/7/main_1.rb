# frozen_string_literal: true

@input = File.readlines(File.join(__dir__, 'input.txt'), chomp: true)

@splitters = Set.new
@visited = Set.new

def travel(x, y)
  return if y >= @input.length
  return if @visited.include?([x, y])

  @visited << [x, y]

  if @input[y][x] == '^'
    @splitters << [x, y]
    travel(x - 1, y + 1)
    travel(x + 1, y + 1)
  else
    travel(x, y + 1)
  end
end

travel(@input.first.index('S'), 0)

p @splitters.size
