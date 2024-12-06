import day05/part1.{Data} as solution
import glacier/should
import gleam/set

pub fn parse_test() {
  let expected_data =
    Data(inverted_rules: set.from_list([#(34, 12), #(78, 56)]), updates: [
      [12, 34, 56],
      [78, 90],
    ])
  solution.parse("12|34\n56|78\n\n12,34,56\n78,90\n")
  |> should.equal(expected_data)
}

pub fn middle_value_test() {
  solution.middle_value([1, 2, 3, 4, 5])
  |> should.equal(3)
}
