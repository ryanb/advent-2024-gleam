import gleam/int
import gleam/io
import gleam/list
import gleam/option.{Some}
import gleam/regexp
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
  let assert Ok(re) = regexp.from_string("mul\\((\\d+),(\\d+)\\)")
  regexp.scan(with: re, content:)
  |> list.map(fn(match) {
    list.map(match.submatches, fn(submatch) {
      let assert Some(num_str) = submatch
      let assert Ok(num) = int.parse(num_str)
      num
    })
  })
}

pub fn process(rows) {
  list.fold(rows, 0, fn(acc, row) {
    let assert [left, right] = row
    acc + left * right
  })
}
