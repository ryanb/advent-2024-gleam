import day03/part1 as solution
import glacier/should

pub fn parse_test() {
  solution.parse("mul(1,2)foomul(3,4)")
  |> should.equal([[1, 2], [3, 4]])
}

pub fn process_test() {
  solution.process([[1, 2], [3, 4]])
  |> should.equal(14)
}
