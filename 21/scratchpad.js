// Create a size * size grid of ascending nums
let size = 4
let a = Array(size)
  .fill(0)
  .map(i => new Array())

for (let i = 0; i < size * size; i++) {
  a[Math.floor(i / size)].push(i)
}

// console.log(divideGrid(init))

// 0  1  2  3      0  0  1  1
// 4  5  6  7      0  0  1  1
// 8  9  10 11     2  2  3  3
// 12 13 14 15     2  2  3  3

// 0  1  2  3      0  0  1  1
// 1  2  3  4      0  0  1  1
// 2  3  4  5      2  2  3  3
// 3  4  5  6      2  2  3  3

// rows

// 0  1  2  3      0  0  1  1
// 4  5  6  7      0  0  1  1
// 8  9  10 11     2  2  3  3
// 12 13 14 15     2  2  3  3

// 0  0
// 1  0
// 4  0
// 5  0
// 2  1
// 3  1
// 6  1
// 7  1

// 0   1   2   3   4   5     0   0   0   1   1   1
// 6   7   8   9   10  11    0   0   0   1   1   1
// 12  13  14  15  16  17    0   0   0   1   1   1
// 18  19  20  21  22  23    2   2   2   3   3   3

// index / gridsPerRow

// def build_rule_book() do
//   lines = File.read(@inputpath)
//   |> elem(1)
//   |> String.split("\n")

//   size_2_rules = Enum.filter(lines, fn(line) -> String.length(line) == @size_2_rule_length end)
//   size_3_rules = Enum.filter(lines, fn(line) -> String.length(line) == @size_3_rule_length end)

//   { Enum.map(size_2_rules, &build_rule/1), Enum.map(size_3_rules, &build_rule/1) }
// end

// def chunk_grid(grid, length) when length <= 9, do: grid

// def chunk_grid(grid, length) do
//   grid_size = cond do
//     rem(String.length(grid), 2) == 0 -> 2
//     rem(String.length(grid), 3) == 0 -> 3
//   end

//   chunk_amt = div(length, grid_size)

//   # ab cd ef gh ij kl mn op
//   # 02
//   # 13
//   # 46
//   # 57

//   # abef
//   # cdgh
//   # ijmn
//   # klop

//   chunked = String.split(grid, "", trim: true)
//   |> Enum.chunk_every(grid_size)
//   |> Enum.with_index()

//   for n <- grid_size..length do
//     Enum.take_while(chunked, fn({_, index}) -> rem(2, index) == 0 and index < n end)
//   end

//   # |> Enum.map(&Enum.join(&1))

// end

//   def p1 do
//     # build_rule_book()
//     chunk_grid(@init, String.length(@init))
//     |> IO.inspect
//   end
// end

// Q21.p1()
