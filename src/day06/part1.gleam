import gleam/dict.{type Dict}
import gleam/int
import gleam/io
import gleam/list.{Continue, Stop}
import gleam/set.{type Set}
import gleam/string
import simplifile

pub type Point =
  #(Int, Int)

pub type Points =
  Set(Point)

pub type Grid =
  Dict(Point, String)

pub type State {
  State(grid: Grid, visited: Points, current: Point, direction: Point)
}

pub fn main() {
  let assert Ok(content) = simplifile.read("inputs/day06.txt")
  content
  |> parse
  |> process
  |> int.to_string
  |> io.println
}

pub fn parse(content) {
  let state =
    State(grid: dict.new(), visited: set.new(), current: #(0, 0), direction: #(
      0,
      -1,
    ))
  content
  |> string.trim()
  |> string.split("\n")
  |> list.index_fold(state, parse_line)
}

pub fn parse_line(state: State, line: String, y: Int) {
  line
  |> string.to_graphemes
  |> list.index_fold(state, fn(state, char, x) {
    let point = #(x, y)
    case char {
      "^" ->
        State(
          ..state,
          grid: dict.insert(state.grid, point, "."),
          current: point,
        )
      _ -> State(..state, grid: dict.insert(state.grid, point, char))
    }
  })
}

pub fn process(state: State) {
  let final_state = walk(state)
  set.size(final_state.visited)
}

pub fn walk(state: State) {
  case step(state) {
    Continue(next_state) -> walk(next_state)
    Stop(next_state) -> next_state
  }
}

pub fn step(state: State) {
  let next_point = move_point(state.current, state.direction)
  let next_char = dict.get(state.grid, next_point)
  case next_char {
    Ok("#") -> Continue(State(..state, direction: turn_right(state.direction)))
    Ok(".") ->
      Continue(
        State(
          ..state,
          visited: set.insert(state.visited, state.current),
          current: next_point,
        ),
      )
    _ -> Stop(State(..state, visited: set.insert(state.visited, state.current)))
  }
}

pub fn turn_right(direction: Point) {
  case direction {
    #(-1, 0) -> #(0, -1)
    #(0, -1) -> #(1, 0)
    #(1, 0) -> #(0, 1)
    #(0, 1) -> #(-1, 0)
    _ -> panic
  }
}

pub fn move_point(point: Point, direction: Point) {
  #(point.0 + direction.0, point.1 + direction.1)
}
