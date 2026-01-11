# frozen_string_literal: true

p(
  File
  .readlines(File.join(__dir__, 'input.txt'), chomp: true)
  .map { it.split.map(&:strip) }
  .transpose
  .map { it[..-2].map(&:to_i).inject(&it.last.to_sym) }
  .sum
)
