# frozen_string_literal: true

p(
  File
  .readlines(File.join(__dir__, 'input.txt'), chomp: true)
  .map { it.split(',').map(&:to_i) }
  .then { it.product it }
  .map { |(x1, y1), (x2, y2)| ((x2 - x1).abs + 1) * ((y2 - y1).abs + 1) }
  .max
)
