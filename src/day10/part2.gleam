import day10/part1.{type Elevations}
import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/set
import simplifile

pub fn main() {
  let assert Ok(content) = simplifile.read("inputs/day10.txt")
  content
  |> part1.parse
  |> process
  |> int.to_string
  |> io.println
}

pub fn process(elevations: Elevations) {
  let assert Ok(trailheads) = dict.get(elevations, 0)
  use total, trailhead <- set.fold(trailheads, 0)
  part1.walk_trail(elevations, 0, trailhead)
  |> list.length
  |> int.add(total)
}
