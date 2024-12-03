import gleam/int
import gleam/io
import gleam/list
import gleam/string
import simplifile

pub fn main() {
  let assert Ok(content) = simplifile.read("inputs/day01.txt")
  content
  |> parse
  |> process
  |> int.to_string
  |> io.println
}

pub fn parse(content) {
  content
  |> string.trim
  |> string.split("\n")
  |> list.map(parse_line)
}

fn parse_line(line) {
  line
  |> string.split("   ")
  |> list.map(fn(num_str) {
    let assert Ok(number) = int.parse(num_str)
    number
  })
}

pub fn process(rows) {
  rows
  |> list.transpose
  |> list.map(list.sort(_, by: int.compare))
  |> list.transpose
  |> list.fold(0, fn(acc, row) {
    case row {
      [left, right] if left <= right -> acc + { right - left }
      [left, right] if left > right -> acc + { left - right }
      _ -> panic
    }
  })
}
