import day03/part2 as solution
import glacier/should

pub fn parse_1_test() {
  solution.parse("mul(1,2)foomul(3,4)")
  |> should.equal([[1, 2], [3, 4]])
}

pub fn parse_2_test() {
  solution.parse("mul(1,2)don't()foomul(3,4)do()mul(5,6)\n")
  |> should.equal([[1, 2], [5, 6]])
}
