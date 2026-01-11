# frozen_string_literal: true

p(
  File
  .read('./2025/2/input.txt')
  .strip
  .split(',')
  .map do |r|
    b, e = r.split('-')
    (b..e).select do |id|
      next false if id.length.odd?

      (0...(id.length / 2)).all? do |i|
        id[i] == id[(id.length / 2) + i]
      end
    end
  end
  .flatten
  .map(&:to_i)
  .sum
)
