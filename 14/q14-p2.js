// Generate grid with elixir q14.exs > grid.json
// Then run node q14-2.js

const fs = require('fs')

const USED = "#"
const FREE = "."

let grid = JSON.parse(fs.readFileSync('./grid.json'))

function print() {
  for (y = 0; y < 128; y++) {
    console.log(grid[y].join(''))
  }
}

let connectionsCount = 0

for (y = 0; y < 128; y++) {
  for (x = 0; x < 128; x++) {
    const square = grid[x][y]
    if (square === USED) {
      explore_grid(x, y, connectionsCount)
      connectionsCount++
    }
  }
}

function explore_grid (x, y, region) {
  if (grid[x] === undefined || grid[x][y] === undefined || grid[x][y] !== USED) {
    return
  }
  grid[x][y] = region

  explore_grid(x - 1, y, region)
  explore_grid(x, y - 1, region)
  explore_grid(x, y + 1, region)
  explore_grid(x + 1, y, region)
}

console.log(connectionsCount)
