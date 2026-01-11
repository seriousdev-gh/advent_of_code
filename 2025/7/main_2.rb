# frozen_string_literal: true

@input = File.readlines(File.join(__dir__, 'input.txt'), chomp: true)
@cache = {}

def travel(x, y)
  return 0 if y >= @input.length

  if @input[y][x] == '^'
    return @cache[[x, y]] if @cache.key?([x, y])

    @cache[[x, y]] = travel(x - 1, y + 1) +
                     travel(x + 1, y + 1) +
                     1
  else
    travel(x, y + 1)
  end
end

p travel(@input.first.index('S'), 0) + 1
