import day04/part1 as solution
import glacier/should
import gleam/dict
import gleam/set

pub fn parse_line_test() {
  let dict = dict.new()
  solution.parse_line(dict, "DXMCS", 0)
  |> should.equal(
    dict.insert(dict, "X", set.from_list([#(1, 0)]))
    |> dict.insert("M", set.from_list([#(2, 0)]))
    |> dict.insert("S", set.from_list([#(4, 0)])),
  )
}

pub fn parse_letter_1_test() {
  let dict = dict.new()
  solution.parse_letter(dict, "a", #(1, 2))
  |> should.equal(dict.insert(dict, "a", set.from_list([#(1, 2)])))
}

pub fn parse_letter_2_test() {
  let dict = dict.new() |> dict.insert("a", set.from_list([#(1, 2)]))
  solution.parse_letter(dict, "a", #(3, 4))
  |> dict.get("a")
  |> should.equal(Ok(set.from_list([#(1, 2), #(3, 4)])))
}

pub fn is_word_matching_1_test() {
  solution.parse_line(dict.new(), "DXMCS", 0)
  |> solution.is_word_matching(#(1, 0), #(1, 0))
  |> should.be_false()
}

pub fn is_word_matching_2_test() {
  solution.parse_line(dict.new(), "DXMASC", 0)
  |> solution.is_word_matching(#(1, 0), #(1, 0))
  |> should.be_true()
}

pub fn move_point_test() {
  solution.move_point(#(1, 2), #(1, 2), 2)
  |> should.equal(#(3, 6))
}
