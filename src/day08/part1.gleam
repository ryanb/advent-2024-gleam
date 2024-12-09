import gleam/dict.{type Dict}
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{None, Some}
import gleam/pair
import gleam/string
import simplifile

pub type Point =
  #(Int, Int)

pub type Frequencies =
  Dict(String, List(Point))

pub type State {
  State(frequencies: Frequencies, width: Int, height: Int)
}

pub fn main() {
  let assert Ok(content) = simplifile.read("inputs/day08.txt")
  content
  |> parse
  |> process
  |> int.to_string
  |> io.println
}

pub fn parse(content: String) {
  let lines = content |> string.trim |> string.split("\n")
  let assert [line, ..] = lines
  State(
    frequencies: list.index_fold(lines, dict.new(), parse_line),
    width: string.length(line),
    height: list.length(lines),
  )
}

pub fn parse_line(frequencies: Frequencies, line: String, y: Int) {
  line
  |> string.to_graphemes
  |> list.index_fold(frequencies, fn(frequencies, letter, x) {
    case letter {
      "." -> frequencies
      _ -> parse_letter(frequencies, letter, #(x, y))
    }
  })
}

pub fn parse_letter(frequencies: Frequencies, letter: String, point: Point) {
  dict.upsert(frequencies, letter, fn(existing) {
    case existing {
      Some(points) -> [point, ..points]
      None -> [point]
    }
  })
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
  case x2 + x2 - x1, y2 + y2 - y1 {
    x, y if x >= 0 && x < width && y >= 0 && y < height -> [#(x, y)]
    _, _ -> []
  }
}
