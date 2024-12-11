import gleam/bool
import gleam/dict.{type Dict}
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{None, Some}
import gleam/string
import simplifile

type Stones =
  Dict(Int, Int)

pub fn main() {
  let assert Ok(content) = simplifile.read("inputs/day11.txt")
  content
  |> parse
  |> process
  |> int.to_string
  |> io.println
}

pub fn parse(content: String) -> Stones {
  let stone_strs = content |> string.trim |> string.split(" ")
  use stones, stone_str <- list.fold(stone_strs, dict.new())
  let assert Ok(stone) = int.parse(stone_str)
  increment(stones, stone, by: 1)
}

pub fn increment(stones: Stones, stone: Int, by amount: Int) -> Stones {
  use maybe <- dict.upsert(stones, stone)
  case maybe {
    Some(count) -> count + amount
    None -> amount
  }
}

pub fn process(stones: Stones) -> Int {
  list.range(1, 75)
  |> list.fold(stones, fn(stones, _) { dict.fold(stones, dict.new(), blink) })
  |> dict.values
  |> int.sum
}

pub fn blink(next_stones: Stones, stone: Int, count: Int) {
  use <- bool.lazy_guard(when: stone == 0, return: fn() {
    increment(next_stones, 1, by: count)
  })

  let assert Ok(digits) = int.digits(stone, 10)
  case list.length(digits) % 2 {
    0 -> {
      let #(left, right) = list.split(digits, list.length(digits) / 2)
      let assert Ok(left_stone) = int.undigits(left, 10)
      let assert Ok(right_stone) = int.undigits(right, 10)
      next_stones
      |> increment(left_stone, by: count)
      |> increment(right_stone, by: count)
    }
    1 -> increment(next_stones, stone * 2024, by: count)
    _ -> panic
  }
}
