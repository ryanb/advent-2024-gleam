import day09/part2.{File, Gap} as solution
import glacier/should

pub fn move_files_1_test() {
  solution.move_files(
    [
      File(id: 2, start: 5, length: 1),
      File(id: 1, start: 4, length: 1),
      File(id: 0, start: 1, length: 1),
    ],
    [Gap(start: 2, length: 1), Gap(start: 3, length: 1)],
  )
  |> should.equal([
    File(id: 2, start: 2, length: 1),
    File(id: 1, start: 3, length: 1),
  ])
}

pub fn move_files_2_test() {
  solution.move_files(
    [
      File(id: 2, start: 5, length: 2),
      File(id: 1, start: 4, length: 1),
      File(id: 0, start: 1, length: 1),
    ],
    [Gap(start: 2, length: 1), Gap(start: 3, length: 1)],
  )
  |> should.equal([File(id: 1, start: 2, length: 1)])
}
