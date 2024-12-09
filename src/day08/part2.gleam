import day08/part1.{type Point, type State}
import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/pair
import simplifile

pub fn main() {
  let assert Ok(content) = simplifile.read("inputs/day08.txt")
  content
  |> part1.parse
  |> process
  |> int.to_string
  |> io.println
}

pub fn process(state: State) {
  state |> build_antinodes |> list.unique |> list.length
}

pub fn build_antinodes(state: State) {
  use antinodes, _frequency, points <- dict.fold(state.frequencies, [])
  let pairs = list.combination_pairs(points)
  use antinodes, pair <- list.fold(pairs, antinodes)

  antinodes
  |> list.append(antinodes_for_pair(pair, state.width, state.height))
  |> list.append(antinodes_for_pair(pair.swap(pair), state.width, state.height))
}

pub fn antinodes_for_pair(pair: #(Point, Point), width: Int, height: Int) {
  let #(#(x1, y1), #(x2, y2)) = pair
  let next_point = #(x2 + x2 - x1, y2 + y2 - y1)
  case x2, y2 {
    x, y if x >= 0 && x < width && y >= 0 && y < height -> [
      pair.1,
      ..antinodes_for_pair(#(pair.1, next_point), width, height)
    ]
    _, _ -> []
  }
}
