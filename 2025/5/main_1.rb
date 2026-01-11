# frozen_string_literal: true

p(
  File
  .readlines(File.join(__dir__, 'input.txt'), chomp: true)
  .then do |lines|
    s = lines.find_index ''
    ranges = lines[...s].map { it.split('-') }.map { (_1.to_i.._2.to_i) }
    ids = lines[(s + 1)..].map(&:to_i)

    ids.count { |id| ranges.any? { |range| range.include?(id) } }
  end
)
