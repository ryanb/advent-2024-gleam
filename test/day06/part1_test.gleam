import day06/part1.{State} as solution
import glacier/should
import gleam/dict
import gleam/list.{Continue, Stop}
import gleam/set

pub fn parse_test() {
  let expected_grid =
    dict.from_list([
      #(#(0, 0), "."),
      #(#(1, 0), "#"),
      #(#(0, 1), "."),
      #(#(1, 1), "."),
    ])
  let expected_state =
    State(
      grid: expected_grid,
      visited: set.new(),
      current: #(0, 1),
      direction: #(0, -1),
    )
  solution.parse(".#\n^.")
  |> should.equal(expected_state)
}

pub fn step_1_test() {
  let grid = dict.from_list([#(#(0, 0), "."), #(#(1, 0), "#")])
  let state =
    State(grid:, visited: set.new(), current: #(0, 0), direction: #(1, 0))
  let expected_state = State(..state, direction: #(0, 1))
  solution.step(state)
  |> should.equal(Continue(expected_state))
}

pub fn step_2_test() {
  let grid = dict.from_list([#(#(0, 0), ".")])
  let state =
    State(grid:, visited: set.new(), current: #(0, 0), direction: #(0, -1))
  let expected_state = State(..state, visited: set.from_list([#(0, 0)]))
  solution.step(state)
  |> should.equal(Stop(expected_state))
}

pub fn step_3_test() {
  let grid = dict.from_list([#(#(0, 0), "."), #(#(1, 0), ".")])
  let state =
    State(grid:, visited: set.new(), current: #(0, 0), direction: #(1, 0))
  let expected_state =
    State(..state, visited: set.from_list([#(0, 0)]), current: #(1, 0))
  solution.step(state)
  |> should.equal(Continue(expected_state))
}
