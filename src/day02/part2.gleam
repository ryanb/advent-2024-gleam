import day02/part1.{is_safe, parse}
import gleam/int
import gleam/io
import gleam/list
import simplifile

pub fn main() {
  let assert Ok(content) = simplifile.read("inputs/day02.txt")
  content
  |> parse
  |> process
  |> int.to_string
  |> io.println
}

pub fn process(rows) {
  rows
  |> list.count(where: is_safe_with_dampener)
}

pub fn is_safe_with_dampener(values) {
  is_safe(values) || is_safe_without_value(values, 0)
}

pub fn is_safe_without_value(values, index) {
  case index <= list.length(values) {
    False -> False
    True ->
      case is_safe(list_without_value(values, index)) {
        True -> True
        False -> is_safe_without_value(values, index + 1)
      }
  }
}

fn list_without_value(values, index) {
  let #(before, after) = list.split(values, index)
  list.append(before, list.drop(after, 1))
}
