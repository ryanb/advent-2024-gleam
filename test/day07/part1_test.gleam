import day07/part1.{Add, Multiply, Problem} as solution
import glacier/should

pub fn parse_test() {
  let expected_problem = Problem(target: 25, parts: [5, 20])
  solution.parse("25: 5 20\n")
  |> should.equal([expected_problem])
}

pub fn is_possible_test() {
  let problem = Problem(target: 25, parts: [5, 20])
  solution.is_possible(problem)
  |> should.equal(True)
}

pub fn calculate_1_test() {
  solution.calculate([5, 20], [Add])
  |> should.equal(25)
}

pub fn calculate_2_test() {
  solution.calculate([5, 20], [Multiply])
  |> should.equal(100)
}

pub fn operator_combinations_test() {
  solution.operator_combinations(2, [[]])
  |> should.equal([
    [Add, Add],
    [Add, Multiply],
    [Multiply, Add],
    [Multiply, Multiply],
  ])
}
