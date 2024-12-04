import day02/part1 as solution
import glacier/should

pub fn parse_test() {
  solution.parse("1 2 3\n4 5 6\n")
  |> should.equal([[1, 2, 3], [4, 5, 6]])
}

pub fn is_safe_1_test() {
  solution.is_safe([1, 2, 4, 5])
  |> should.be_true()
}

pub fn is_safe_2_test() {
  solution.is_safe([5, 4, 1])
  |> should.be_true()
}

pub fn is_safe_3_test() {
  solution.is_safe([0, 2, 6])
  |> should.be_false()
}

pub fn is_safe_4_test() {
  solution.is_safe([5, 4, 0])
  |> should.be_false()
}

pub fn is_safe_5_test() {
  solution.is_safe([1, 0, 1])
  |> should.be_false()
}

pub fn is_safe_6_test() {
  solution.is_safe([1, 1, 1])
  |> should.be_false()
}
