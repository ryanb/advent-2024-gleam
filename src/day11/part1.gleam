import gleam/bool
import gleam/int
import gleam/io
import gleam/list
import gleam/string
import simplifile

pub fn main() {
  let assert Ok(content) = simplifile.read("inputs/day11.txt")
  content
  |> parse
  |> process
  |> int.to_string
  |> io.println
}

pub fn parse(content: String) {
  let stones = content |> string.trim |> string.split(" ")
  use stone_str <- list.map(stones)
  let assert Ok(stone) = int.parse(stone_str)
  stone
}

pub fn process(stones: List(Int)) {
  list.range(1, 25)
  |> list.fold(stones, fn(stones, _) {
    stones |> list.map(blink) |> list.flatten
  })
  |> list.length
}

pub fn blink(stone: Int) {
  use <- bool.guard(when: stone == 0, return: [1])

  let assert Ok(digits) = int.digits(stone, 10)
  case list.length(digits) % 2 {
    0 -> {
      let #(left, right) = list.split(digits, list.length(digits) / 2)
      let assert Ok(left_stone) = int.undigits(left, 10)
      let assert Ok(right_stone) = int.undigits(right, 10)
      [left_stone, right_stone]
    }
    1 -> [stone * 2024]
    _ -> panic
  }
}
