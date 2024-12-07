import day07/part1.{type Problem, Problem}
import gleam/int
import gleam/io
import gleam/list
import simplifile

pub type Operator {
  Add
  Multiply
  Concat
}

pub fn main() {
  let assert Ok(content) = simplifile.read("inputs/day07.txt")
  content
  |> part1.parse
  |> process
  |> int.to_string
  |> io.println
}

pub fn process(problems: List(Problem)) {
  list.filter(problems, is_possible)
  |> list.map(fn(problem) { problem.target })
  |> int.sum
}

pub fn is_possible(problem: Problem) {
  let Problem(target, parts) = problem
  operator_combinations(list.length(parts) - 1, [[]])
  |> list.any(fn(operators) {
    let result = calculate(parts, operators)
    result == target
  })
}

pub fn operator_combinations(length: Int, result: List(List(Operator))) {
  let new_result =
    list.flat_map(result, fn(operators) {
      list.map([Add, Multiply, Concat], fn(operator) {
        list.append(operators, [operator])
      })
    })
  case length {
    1 -> new_result
    _ -> operator_combinations(length - 1, new_result)
  }
}

pub fn calculate(parts: List(Int), operators: List(Operator)) {
  let assert [first, ..rest] = parts
  list.index_fold(rest, first, fn(acc, part, index) {
    let assert Ok(operator) = operators |> list.drop(index) |> list.first
    case operator {
      Add -> acc + part
      Multiply -> acc * part
      Concat -> {
        let assert Ok(result) =
          int.parse(int.to_string(acc) <> int.to_string(part))
        result
      }
    }
  })
}
