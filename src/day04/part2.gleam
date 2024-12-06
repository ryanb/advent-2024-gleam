import day04/part1.{type Locations, type Point}
import gleam/dict
import gleam/int
import gleam/io
import gleam/list
import gleam/set
import simplifile

const letters = ["M", "A", "S"]

const directions = [#(-1, -1), #(-1, 1), #(1, -1), #(1, 1)]

pub fn main() {
  let assert Ok(content) = simplifile.read("inputs/day04.txt")
  content
  |> part1.parse
  |> process
  |> int.to_string
  |> io.println
}

pub fn process(dict: Locations) {
  let assert Ok(center_points) = dict.get(dict, "A")
  list.fold(set.to_list(center_points), 0, fn(count, center_point) {
    case count_words(dict, center_point) {
      2 -> count + 1
      _ -> count
    }
  })
}

pub fn count_words(dict: Locations, center_point: Point) {
  list.fold(directions, 0, fn(count, direction) {
    let start_point = part1.move_point(center_point, direction, -1)
    case is_word_matching(dict, start_point, direction) {
      True -> count + 1
      False -> count
    }
  })
}

pub fn is_word_matching(dict: Locations, start_point: Point, direction: Point) {
  list.index_fold(letters, True, fn(matching, letter, amount) {
    case matching {
      False -> False
      True ->
        case dict.get(dict, letter) {
          Ok(points) ->
            set.contains(
              points,
              part1.move_point(start_point, direction, amount),
            )
          _ -> False
        }
    }
  })
}
