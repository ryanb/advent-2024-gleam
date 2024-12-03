import day01/part1 as solution
import glacier/should

pub fn parse_test() {
  solution.parse("1   2\n3   4\n")
  |> should.equal([[1, 2], [3, 4]])
}

pub fn process_test() {
  solution.process([[1, 2], [5, 4], [3, 6]])
  |> should.equal(3)
}

pub fn process_negative_test() {
  solution.process([[2, 1]])
  |> should.equal(1)
}
