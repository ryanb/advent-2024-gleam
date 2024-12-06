import gleam/dict.{type Dict}
import gleam/int
import gleam/io
import gleam/list
import gleam/option.{None, Some}
import gleam/set.{type Set}
import gleam/string
import simplifile

pub type Point =
  #(Int, Int)

pub type Points =
  Set(#(Int, Int))

pub type Locations =
  Dict(String, Points)

const letters = ["X", "M", "A", "S"]

const directions = [
  #(-1, -1), #(0, -1), #(1, -1), #(-1, 0), #(1, 0), #(-1, 1), #(0, 1), #(1, 1),
]

pub fn main() {
  let assert Ok(content) = simplifile.read("inputs/day04.txt")
  content
  |> parse
  |> process
  |> int.to_string
  |> io.println
}

pub fn parse(content: String) {
  content
  |> string.split("\n")
  |> list.index_fold(dict.new(), parse_line)
}

pub fn parse_line(dict: Locations, line: String, y: Int) {
  line
  |> string.to_graphemes
  |> list.index_fold(dict, fn(dict, letter, x) {
    case list.contains(letters, letter) {
      True -> parse_letter(dict, letter, #(x, y))
      False -> dict
    }
  })
}

pub fn parse_letter(dict: Locations, letter: String, point: Point) {
  dict.upsert(dict, letter, fn(existing) {
    case existing {
      Some(points) -> points |> set.insert(point)
      None -> set.new() |> set.insert(point)
    }
  })
}

pub fn process(dict: Locations) {
  let assert Ok(start_points) = dict.get(dict, "X")
  list.fold(set.to_list(start_points), 0, fn(count, start_point) {
    list.fold(directions, count, fn(count, direction) {
      case is_word_matching(dict, start_point, direction) {
        True -> count + 1
        False -> count
      }
    })
  })
}

pub fn is_word_matching(dict: Locations, start_point: Point, direction: Point) {
  list.index_fold(letters, True, fn(matching, letter, amount) {
    case matching {
      False -> False
      True ->
        case dict.get(dict, letter) {
          Ok(points) ->
            set.contains(points, move_point(start_point, direction, amount))
          _ -> False
        }
    }
  })
}

pub fn move_point(point: Point, direction: Point, amount: Int) {
  #(point.0 + direction.0 * amount, point.1 + direction.1 * amount)
}
