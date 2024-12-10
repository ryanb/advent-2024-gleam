import gleam/bool
import gleam/int
import gleam/io
import gleam/list
import gleam/string
import simplifile

pub type File {
  File(id: Int, position: Int)
}

pub type State {
  State(files: List(File), gaps: List(Int))
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
  lengths: List(String),
  state: State,
  id id: Int,
  position position: Int,
  is_gap is_gap: Bool,
) {
  use <- bool.guard(when: list.is_empty(lengths), return: state)
  let assert [length_str, ..rest] = lengths
  let assert Ok(length) = int.parse(length_str)
  case is_gap {
    True ->
      parse_recursive(
        rest,
        add_gaps(state, position:, length:),
        id:,
        position: position + length,
        is_gap: False,
      )
    False ->
      parse_recursive(
        rest,
        add_files(state, id:, position:, length:),
        id: id + 1,
        position: position + length,
        is_gap: True,
      )
  }
}

pub fn add_gaps(state: State, position position: Int, length length: Int) {
  use <- bool.guard(when: length == 0, return: state)
  let gaps = list.range(position, position + length - 1)
  State(..state, gaps: list.append(state.gaps, gaps))
}

pub fn add_files(
  state: State,
  id id: Int,
  position position: Int,
  length length: Int,
) {
  use <- bool.guard(when: length == 0, return: state)
  // The range is in reverse order so later files are at the front
  let files =
    list.range(position + length - 1, position)
    |> list.map(fn(position) { File(id:, position:) })
    |> list.append(state.files)
  State(..state, files:)
}

pub fn process(state: State) {
  let files = move_files(state.files, state.gaps)
  state.files
  |> list.drop(list.length(files))
  |> list.append(files)
  |> list.map(fn(file) { file.id * file.position })
  |> int.sum
}

pub fn move_files(files: List(File), gaps: List(Int)) {
  use <- bool.guard(when: files == [] || gaps == [], return: [])
  let assert [file, ..rest_files] = files
  let assert [gap, ..rest_gaps] = gaps
  use <- bool.guard(when: file.position <= gap, return: [])
  let new_file = File(..file, position: gap)
  [new_file, ..move_files(rest_files, rest_gaps)]
}
