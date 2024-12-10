import gleam/bool
import gleam/dict.{type Dict}
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{None, Some}
import gleam/set.{type Set}
import gleam/string
import simplifile

pub type Point =
  #(Int, Int)

pub type Elevations =
  Dict(Int, Set(Point))

pub fn main() {
  let assert Ok(content) = simplifile.read("inputs/day10.txt")
  content
  |> parse
  |> process
  |> int.to_string
  |> io.println
}

pub fn parse(content: String) {
  let lines = content |> string.trim |> string.split("\n")
  use elevations, line, y <- list.index_fold(lines, dict.new())

  use elevations, num_str, x <- list.index_fold(
    string.to_graphemes(line),
    elevations,
  )
  let assert Ok(elevation) = int.parse(num_str)

  use existing <- dict.upsert(elevations, elevation)
  case existing {
    Some(points) -> set.insert(points, #(x, y))
    None -> set.new() |> set.insert(#(x, y))
  }
}

pub fn process(elevations: Elevations) {
  let assert Ok(trailheads) = dict.get(elevations, 0)
  use total, trailhead <- set.fold(trailheads, 0)
  walk_trail(elevations, 0, trailhead)
  |> list.unique
  |> list.length
  |> int.add(total)
}

pub fn walk_trail(elevations: Elevations, elevation: Int, point: Point) {
  use <- bool.guard(when: elevation == 9, return: [point])

  let assert Ok(possible_points) = dict.get(elevations, elevation + 1)
  let next_points = set.intersection(possible_points, neighboring_points(point))

  use destinations, next_point <- set.fold(next_points, [])
  list.append(destinations, walk_trail(elevations, elevation + 1, next_point))
}

pub fn neighboring_points(point: Point) {
  let #(x, y) = point
  set.from_list([#(x - 1, y), #(x + 1, y), #(x, y - 1), #(x, y + 1)])
}
