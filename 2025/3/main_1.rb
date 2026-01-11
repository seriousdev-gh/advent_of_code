# frozen_string_literal: true

p(
  File
  .readlines(File.join(__dir__, 'input.txt'), chomp: true)
  .map do |bank|
    max = '0' * 12
    (0..(bank.length - 1)).each do |i|
    end

    max.to_i
  end
  .sum
)
