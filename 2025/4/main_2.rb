# frozen_string_literal: true

p(
  File
  .readlines(File.join(__dir__, 'input.txt'), chomp: true)
  .then do |lines|
    total = 0
    removed = 0
    loop do
      removed = 0
      next_lines = lines.map(&:dup)
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
          if c < 4
            next_lines[i][j] = 'x'
            removed += 1
          end
        end
      end

      break if removed.zero?

      total += removed

      lines = next_lines
    end

    total
  end
)
