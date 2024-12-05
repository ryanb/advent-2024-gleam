import day03/part1.{process}
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{Some}
import gleam/regexp.{type Match}
import simplifile

pub fn main() {
  let assert Ok(content) = simplifile.read("inputs/day03.txt")
  content
  |> parse
  |> process
  |> int.to_string
  |> io.println
}

pub fn parse(content) {
  let assert Ok(re) =
    regexp.from_string("mul\\((\\d+),(\\d+)\\)|do\\(\\)|don't\\(\\)")
  regexp.scan(with: re, content:)
  |> parse_matches(active: True)
}

pub fn parse_matches(matches: List(Match), active active: Bool) {
  case matches {
    [] -> []
    [match, ..rest] ->
      case match.content {
        "do()" -> parse_matches(rest, active: True)
        "don't()" -> parse_matches(rest, active: False)
        _ if active -> [
          parse_submatches(match.submatches),
          ..parse_matches(rest, active:)
        ]
        _ -> parse_matches(rest, active:)
      }
  }
}

pub fn parse_submatches(submatches) {
  list.map(submatches, fn(submatch) {
    let assert Some(num_str) = submatch
    let assert Ok(num) = int.parse(num_str)
    num
  })
}
