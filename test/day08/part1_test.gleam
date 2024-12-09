import day08/part1 as solution
import glacier/should
import gleam/dict

pub fn parse_line_test() {
  let frequencies = dict.new()
  solution.parse_line(frequencies, ".e0", 0)
  |> should.equal(
    dict.insert(frequencies, "e", [#(1, 0)])
    |> dict.insert("0", [#(2, 0)]),
  )
}

pub fn antinodes_for_pair_1_test() {
  solution.antinodes_for_pair(#(#(0, 0), #(1, 1)), 3, 3)
  |> should.equal([#(2, 2)])
}

pub fn antinodes_for_pair_2_test() {
  solution.antinodes_for_pair(#(#(1, 1), #(0, 0)), 3, 3)
  |> should.equal([])
}
