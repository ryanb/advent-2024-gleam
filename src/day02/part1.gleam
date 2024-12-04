import gleam/int
import gleam/io
import gleam/list.{Continue, Stop}
import gleam/string
import party
import simplifile

pub fn main() {
  let assert Ok(content) = simplifile.read("inputs/day02.txt")
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
  let line_parser =
    party.sep(party.try(party.digits(), int.parse), by: party.string(" "))
  party.sep(line_parser, by: party.string("\n"))
}

pub fn process(rows) {
  list.count(rows, where: is_safe)
}

pub fn is_safe(values) {
  let assert [first, ..rest] = values
  let ascending = list.any(rest, fn(value) { value > first })
  let result =
    list.fold_until(rest, #(first, True), fn(result, current) {
      let #(previous, _) = result
      let diff = current - previous

      case diff {
        _ if ascending && diff > 0 && diff <= 3 -> Continue(#(current, True))
        _ if !ascending && diff < 0 && diff >= -3 -> Continue(#(current, True))
        _ -> Stop(#(current, False))
      }
    })
  result.1
}
