import day05/part1.{type Data}
import gleam/int
import gleam/io
import gleam/list
import gleam/order.{Eq, Gt, Lt}
import gleam/set.{type Set}
import simplifile

pub fn main() {
  let assert Ok(content) = simplifile.read("inputs/day05.txt")
  content
  |> part1.parse
  |> process
  |> int.to_string
  |> io.println
}

pub fn process(data: Data) {
  incorrect_updates(data)
  |> list.map(fn(update) { fix_update(update, data.inverted_rules) })
  |> list.map(part1.middle_value)
  |> int.sum()
}

pub fn incorrect_updates(data: Data) {
  list.filter(data.updates, fn(update) {
    list.combination_pairs(update)
    |> list.any(fn(pair) { set.contains(data.inverted_rules, pair) })
  })
}

pub fn fix_update(update: List(Int), inverted_rules: Set(#(Int, Int))) {
  list.sort(update, fn(a, b) { sort_pages(a, b, inverted_rules) })
}

pub fn sort_pages(a: Int, b: Int, inverted_rules: Set(#(Int, Int))) {
  case set.contains(inverted_rules, #(a, b)) {
    True -> Gt
    False ->
      case set.contains(inverted_rules, #(b, a)) {
        True -> Lt
        False -> Eq
      }
  }
}
