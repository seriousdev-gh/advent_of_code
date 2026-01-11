# frozen_string_literal: true

lines         = File.readlines(File.join(__dir__, 'input.txt'), chomp: true)
length        = lines.map(&:length).max
lines         = lines.map { it.ljust(length + 1) }
*numbers, ops = lines

s = 0
answer = ops.scan(/[+*]\s*/).sum do |op|
  len = op.length
  res = numbers.map { it[s...(s + len)].chars }.transpose[..-2].map { it.join.to_i }.inject(&op[0].to_sym)
  s += len

  res
end

p answer
