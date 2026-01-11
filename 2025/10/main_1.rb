# frozen_string_literal: true

input = File
        .readlines(File.join(__dir__, 'input.txt'), chomp: true)

Machine = Data.define(:indicator, :buttons)

machines = input.map do |line|
  indicator, *buttons, _ = line.split

  indicator = indicator[1..-2]
  buttons   = buttons.map { |b| b[1..-2].split(',').map(&:to_i) }

  Machine.new(indicator, buttons)
end

# p machines

def solve_from_state(states, buttons)
  next_states = {}

  states.each do |state, solution|
    current_on_ids = state.chars.each_with_index.filter_map { |c, i| i if c == '#' }
    candidates     = buttons.select { it.intersect?(current_on_ids) }

    candidates.each do |button|
      next_indicator = state.dup
      button.each { |i| next_indicator[i] = state[i] == '#' ? '.' : '#' }
      next if next_states.key?(next_indicator)
      return solution + [button] if next_indicator.count('#').zero?

      next_states[next_indicator] = solution + [button]
    end
  end

  solution = solve_from_state(next_states, buttons)
  return solution if solution

  nil
end

answer = 0
machines.each_with_index do |machine, index|
  p "Solving: (#{index}) #{machine}"
  solution = solve_from_state([[machine.indicator, []]], machine.buttons)
  p solution.size
  answer += solution.size
end

p answer
