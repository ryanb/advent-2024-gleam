import gleam/int
import gleam/io
import gleam/list
import gleam/set.{type Set}
import gleam/string
import party.{do, return}
import simplifile

pub type Data {
  Data(inverted_rules: Set(#(Int, Int)), updates: List(List(Int)))
}

pub fn main() {
  let assert Ok(content) = simplifile.read("inputs/day05.txt")
  content
  |> parse
  |> process
  |> int.to_string
  |> io.println
}

pub fn parse(content) {
  let assert [rules_str, updates_str] =
    content |> string.trim() |> string.split("\n\n")
  let assert Ok(inverted_rules) = party.go(inverted_rules_parser(), rules_str)
  let assert Ok(updates) = party.go(updates_parser(), updates_str)
  Data(inverted_rules: set.from_list(inverted_rules), updates:)
}

fn inverted_rules_parser() {
  let rule_parser = {
    use left <- do(party.digits() |> party.try(int.parse))
    use _ <- do(party.string("|"))
    use right <- do(party.digits() |> party.try(int.parse))
    return(#(right, left))
  }
  party.sep(rule_parser, by: party.string("\n"))
}

fn updates_parser() {
  party.digits()
  |> party.try(int.parse)
  |> party.sep(by: party.string(","))
  |> party.sep(by: party.string("\n"))
}

pub fn process(data: Data) {
  list.map(correct_updates(data), middle_value)
  |> int.sum()
}

pub fn correct_updates(data: Data) {
  list.filter(data.updates, fn(update) {
    list.combination_pairs(update)
    |> list.all(fn(pair) { !set.contains(data.inverted_rules, pair) })
  })
}

pub fn middle_value(values: List(Int)) {
  let assert Ok(index) = list.length(values) |> int.floor_divide(2)
  let assert Ok(middle) = list.take(values, index + 1) |> list.last
  middle
}
