import day07/part2.{Concat} as solution
import glacier/should

pub fn calculate_1_test() {
  solution.calculate([5, 20], [Concat])
  |> should.equal(520)
}
