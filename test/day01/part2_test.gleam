import day01/part2 as solution
import glacier/should

pub fn parse_test() {
  solution.parse("1   2\n3   4\n")
  |> should.equal([[1, 2], [3, 4]])
}

pub fn process_test() {
  solution.process([[3, 3], [5, 3], [2, 5]])
  |> should.equal(3 * 2 + 5)
}
