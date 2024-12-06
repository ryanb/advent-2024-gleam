import day05/part2 as solution
import glacier/should
import gleam/set

pub fn fix_update_test() {
  let inverted_rules = set.from_list([#(3, 2)])
  solution.fix_update([1, 3, 2], inverted_rules)
  |> should.equal([1, 2, 3])
}
