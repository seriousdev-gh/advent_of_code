# frozen_string_literal: true

p(
  File
  .read('./2025/2/input.txt')
  .strip
  .split(',')
  .map do |r|
    b, e = r.split('-')
    (b..e).grep(/^(.+)\1+$/)
  end
  .flatten
  .map(&:to_i)
  .sum
)
