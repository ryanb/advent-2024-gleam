import day02/part2 as solution
import glacier/should

pub fn is_safe_with_dampener_1_test() {
  solution.is_safe_with_dampener([1, 2, 8, 5])
  |> should.be_true()
}

pub fn is_safe_with_dampener_2_test() {
  solution.is_safe_with_dampener([1, 2, 1, 5])
  |> should.be_true()
}
