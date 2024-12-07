import gleam/int
import gleam/io
import gleam/list
import gleam/string
import party.{do, return}
import simplifile

pub type Problem {
  Problem(target: Int, parts: List(Int))
}

pub type Operator {
  Add
  Multiply
}

pub fn main() {
  let assert Ok(content) = simplifile.read("inputs/day07.txt")
  content
  |> parse
  |> process
  |> int.to_string
  |> io.println
}

pub fn parse(content) {
  let assert Ok(problems) = string.trim(content) |> party.go(parser(), _)
  problems
}

fn parser() {
  let problem_parser = {
    use target <- do(party.digits() |> party.try(int.parse))
    use _ <- do(party.string(": "))
    use parts <- do(party.sep(
      party.digits() |> party.try(int.parse),
      by: party.string(" "),
    ))
    return(Problem(target:, parts:))
  }
  party.sep(problem_parser, by: party.string("\n"))
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
      list.map([Add, Multiply], fn(operator) {
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
    }
  })
}
