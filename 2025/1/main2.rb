# frozen_string_literal: true

state = 50
result = 0
File.read('2025/1/input')
    .tr('RL', ' -')
    .split
    .map(&:to_i)
    .each do |amount|
      while amount.positive?
        amount -= 1
        state += 1
        if state == 100
          state = 0
          result += 1
        end
      end

      while amount.negative?
        amount += 1
        state -= 1
        result += 1 if state.zero?
        state = 99 if state == -1
      end
end

p [result, state]
