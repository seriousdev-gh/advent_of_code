# frozen_string_literal: true

# visualize with:
# gnuplot -persist -e "
# set datafile separator ',';
# plot 'input.txt' w lp lc rgb 'red'  title 'A', \
#      'result.txt' w lp lc rgb 'blue' title 'B'"

Point       = Data.define(:x, :y)
Rectangle   = Data.define(:left, :right, :bottom, :top) do
  def area
    (right - left + 1) * (top - bottom + 1)
  end
end
LineSegment = Data.define(:left, :right, :bottom, :top) do
  def length_squared
    ((right - left)**2) + ((top - bottom)**2)
  end
end

points = File
         .readlines(File.join(__dir__, 'input.txt'), chomp: true)
         .map { Point.new(*it.split(',').map(&:to_i)) }

def line_cross_rectangle?(line, rect)
  if line.left == line.right
    # vertical line segment
    return false if line.left <= rect.left || line.left >= rect.right

    return false if line.top >= rect.top && line.bottom >= rect.top
    return false if line.top <= rect.bottom && line.bottom <= rect.bottom

    true
  elsif line.bottom == line.top
    # horizontal line segment
    return false if line.bottom <= rect.bottom || line.bottom >= rect.top

    return false if line.right >= rect.right && line.left >= rect.right
    return false if line.right <= rect.left && line.left <= rect.left

    true
  else
    raise 'unreachable'
  end
end

rectangles = []
(0...points.size).each do |i|
  ((i + 1)...points.size).each do |j|
    r1 = points[i]
    r3 = points[j]
    rectangles << Rectangle.new(*[r1.x, r3.x].minmax, *[r1.y, r3.y].minmax)
  end
end

sorted_rectangles = rectangles
                    .sort_by(&:area)
                    .reverse

points << points[0]

line_segments = points
                .each_cons(2)
                .map { |a, b| LineSegment.new(*[a.x, b.x].minmax, *[a.y, b.y].minmax) }
                .sort_by(&:length_squared)
                .reverse

res = sorted_rectangles.find do |rect|
  line_segments.none? do |line|
    line_cross_rectangle?(line, rect)
  end
end

p res&.area
