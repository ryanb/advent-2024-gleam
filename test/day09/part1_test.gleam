import day09/part1.{File, State} as solution
import glacier/should

pub fn parse_test() {
  solution.parse("21201")
  |> should.equal(
    State(
      files: [
        File(id: 2, position: 5),
        File(id: 1, position: 4),
        File(id: 1, position: 3),
        File(id: 0, position: 1),
        File(id: 0, position: 0),
      ],
      gaps: [2],
    ),
  )
}

pub fn move_files_test() {
  solution.move_files(
    [
      File(id: 2, position: 5),
      File(id: 1, position: 4),
      File(id: 0, position: 3),
    ],
    [2, 3],
  )
  |> should.equal([File(id: 2, position: 2), File(id: 1, position: 3)])
}
