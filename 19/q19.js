const fs = require('fs')

const file = 'input.txt'

const VER = '|'
const HOR = '-'
const CORNER = '+'

const N = 'n'
const S = 's'
const E = 'e'
const W = 'w'

const EMPTY = ' '

let letters = []
let steps = -1

function buildGrid() {
  const data = fs.readFileSync(file, { encoding: 'utf8' })
  const lines = data.split('\n')
  return lines.map(line => line.split(''))
}

function findStart (grid) {
  const x = grid[0].findIndex(a => a === '|')
  return {x, y: 0}
}

function move (dir, {x, y}) {
  switch (dir) {
    case N:
      return {x, y: y-1}
    case S:
      return {x, y: y+1}
    case E:
      return {x: x+1, y}
    case W:
      return {x: x-1, y}
  }
}

function isLetter (value) {
  return ![HOR, VER, CORNER, EMPTY, undefined].includes(value)
}

function go (dir, coords) {
  steps++
  const { x, y } = coords
  const position = grid[y][x]
  console.log(`moving ${dir}, ${coords.x} ${coords.y}, ${position}`)

  if (position === EMPTY) {
    return
  } else if (position === CORNER) {
    if (dir === N || dir === S) {
      // check east
      if (grid[y][x + 1] === HOR || isLetter(grid[y][x + 1])) {
        return {direction: E, coords: {x: x + 1, y}}
      // go west
      } else {
        return {direction: W, coords: {x: x - 1, y}}
      }
    } else {
      // check north
      if (grid[y-1][x] === VER || isLetter(grid[y-1][x])) {
        return {direction: N, coords: {x, y: y - 1}}
      // go south
      } else {
        return {direction: S, coords: {x, y: y + 1}}
      }
    }
  } else if (position === VER) {
    return {direction: dir, coords: move(dir, coords)}
  } else if (position === HOR) {
    return {direction: dir, coords: move(dir, coords)}
  } else {
    // letter
    letters.push(position)
    return {direction: dir, coords: move(dir, coords)}
  }
}

const grid = buildGrid()
var coords = findStart(grid)
var direction = S
var done = false

while (!done) {
  var res = go(direction, coords)
  if (res === undefined) {
    done = true
  } else {
    direction = res.direction
    coords = res.coords
  }
}

console.log(letters.join(''))
console.log(`steps: ${steps}`)