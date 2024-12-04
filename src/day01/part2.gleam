import gleam/int
import gleam/io
import gleam/list
import gleam/string
import party.{do, return}
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
  let assert Ok(rows) = string.trim(content) |> party.go(parser(), _)
  rows
}

fn parser() {
  let line_parser = {
    use left <- do(party.digits() |> party.try(int.parse))
    use _ <- do(party.whitespace())
    use right <- do(party.digits() |> party.try(int.parse))
    return([left, right])
  }
  party.sep(line_parser, by: party.string("\n"))
}

pub fn process(rows) {
  let assert [lefts, rights] = list.transpose(rows)
  list.fold(lefts, 0, fn(acc, left) {
    let count = list.count(rights, where: fn(right) { right == left })
    acc + left * count
  })
}
