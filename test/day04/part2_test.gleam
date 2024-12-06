import day04/part1
import day04/part2 as solution
import glacier/should

pub fn process_1_test() {
  part1.parse("S.M\n.A.\nS.M\n")
  |> solution.process
  |> should.equal(1)
}

pub fn count_words_test() {
  part1.parse("S.M\n.A.\nS.M\n")
  |> solution.count_words(#(1, 1))
  |> should.equal(2)
}

pub fn is_word_matching_1_test() {
  part1.parse("M.M\n.A.\nS.S\n")
  |> solution.is_word_matching(#(0, 0), #(1, 1))
  |> should.equal(True)
}
