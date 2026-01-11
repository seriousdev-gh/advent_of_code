# frozen_string_literal: true

p(
  File
  .readlines(File.join(__dir__, 'input.txt'), chomp: true)
  .then do |lines|
    res = 0
    lines.each_with_index do |line, i|
      line.chars.each_with_index do |char, j|
        next unless char == '@'

        c = 0
        (-1..1).each do |di|
          (-1..1).each do |dj|
            next if di.zero? && dj.zero?

            ni = i + di
            nj = j + dj

            c += 1 if ni >= 0 && ni < lines.size && nj >= 0 && nj < line.size && lines[ni][nj] == '@'
          end
        end
        res += 1 if c < 4
      end
    end
    res
  end
)
