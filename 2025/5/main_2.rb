# frozen_string_literal: true

p(
  File
  .readlines(File.join(__dir__, 'input.txt'), chomp: true)
  .then do |lines|
    s = lines.find_index ''
    ranges = lines[...s]
             .map { it.split('-') }
             .map { (_1.to_i.._2.to_i) }
             .sort_by(&:begin)

    new_ranges = [ranges.delete_at(0)]

    ranges.each do |range|
      if new_ranges.last.end < range.begin
        new_ranges << range
      else
        range_end = [new_ranges.last.end, range.end].max
        new_ranges[-1] = (new_ranges.last.begin..range_end)
      end
    end

    new_ranges.sum(&:size)
  end
)
