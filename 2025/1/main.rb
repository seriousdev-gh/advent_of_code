# frozen_string_literal: true

puts File.read('2025/1/input')
         .tr('RL', ' -')
         .split
         .map(&:to_i)
         .each_with_object({ a: 50, r: 0 }) {
  _2[:a] = (_2[:a] + _1) % 100
  _2[:r] += 1 if _2[:a].zero?
}
