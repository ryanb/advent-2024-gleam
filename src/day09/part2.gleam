import gleam/bool
import gleam/int
import gleam/io
import gleam/list
import gleam/string
import simplifile

pub type Gap {
  Gap(start: Int, length: Int)
}

pub type File {
  File(id: Int, start: Int, length: Int)
}

pub type State {
  State(files: List(File), gaps: List(Gap))
}

pub fn main() {
  let assert Ok(content) = simplifile.read("inputs/day09.txt")
  content
  |> parse
  |> process
  |> int.to_string
  |> io.println
}

pub fn parse(content: String) {
  content
  |> string.trim
  |> string.to_graphemes
  |> parse_recursive(
    State(files: [], gaps: []),
    id: 0,
    position: 0,
    is_gap: False,
  )
}

pub fn parse_recursive(
  numbers,
  state,
  id id: Int,
  position position: Int,
  is_gap is_gap: Bool,
) {
  use <- bool.guard(when: list.is_empty(numbers), return: state)
  let assert [number_str, ..rest] = numbers
  let assert Ok(number) = int.parse(number_str)
  case is_gap {
    True -> {
      let gap = Gap(start: position, length: number)
      parse_recursive(
        rest,
        State(..state, gaps: state.gaps |> list.append([gap])),
        id:,
        position: position + number,
        is_gap: False,
      )
    }
    False -> {
      let file = File(id:, start: position, length: number)
      parse_recursive(
        rest,
        State(..state, files: [file, ..state.files]),
        id: id + 1,
        position: position + number,
        is_gap: True,
      )
    }
  }
}

pub fn process(state: State) {
  let moved_files = move_files(state.files, state.gaps)
  let moved_ids = list.map(moved_files, fn(file) { file.id })
  state.files
  |> list.filter(fn(file) { !list.contains(moved_ids, file.id) })
  |> list.append(moved_files)
  |> list.map(file_checksum)
  |> int.sum
}

pub fn move_files(files: List(File), gaps: List(Gap)) {
  use <- bool.guard(when: files == [] || gaps == [], return: [])
  let assert [file, ..rest_files] = files
  let #(left_gaps, right_gaps) =
    list.split_while(gaps, fn(gap) {
      gap.start >= file.start || gap.length < file.length
    })

  case right_gaps {
    [] -> move_files(rest_files, gaps)
    [gap, ..rest_gaps] -> {
      let new_file = File(..file, start: gap.start)
      case gap.length > file.length {
        True -> {
          let new_gap =
            Gap(
              start: gap.start + file.length,
              length: gap.length - file.length,
            )
          let filled_gaps = list.append(left_gaps, [new_gap, ..rest_gaps])
          [new_file, ..move_files(rest_files, filled_gaps)]
        }
        False -> [
          new_file,
          ..move_files(rest_files, list.append(left_gaps, rest_gaps))
        ]
      }
    }
  }
}

pub fn file_checksum(file: File) {
  list.range(file.start, file.start + file.length - 1)
  |> list.map(fn(num) { num * file.id })
  |> int.sum
}
