const fs = require('fs')
const path = require('path')
const { chunk, flatten } = require('lodash')
const allRules = require('./all-rules')

const ON = '#'
const init = ['.#.', '..#', '###']
const inputPath = path.resolve(__dirname, 'input.txt')

const toRule = grid => grid.join('/')
const toGrid = rule => rule.split('/')

const buildRuleBook = () => {
  let rules = []
  let results = []
  const lines = fs.readFileSync(inputPath, { encoding: 'utf8' }).split('\n')

  lines.forEach(line => {
    const [initialRule, result] = line.split(' => ')
    allRules(initialRule).forEach(rule => {
      rules.push(rule)
      results.push(result)
    })
  })

  return { rules, results }
}

// grid as array of arrays, returns an array of arrays
// where each subarray is a broken up grid
const divideGrid = grid => {
  if (grid[0].length <= 3) return [grid]

  const divSize = grid[0].length % 2 === 0 ? 2 : 3

  const numGrids = grid.join('').length / divSize ** 2

  let dividedGrids = Array(numGrids)
    .fill(0)
    .map(i => new Array())

  let section
  let row = 0
  for (let i = 0; i < grid.length; i++) {
    if (i % divSize === 0 && i > 0) {
      row += grid[0].length / divSize
    }
    for (let j = 0; j < grid[i].length; j++) {
      section = Math.floor(j / divSize)
      dividedGrids[row + section].push(grid[i][j])
    }
  }
  return dividedGrids.map(item => chunk(item, divSize).map(row => row.join('')))
}

// grids is an array of grids, where each grid is an array of rows
// returns an array which contains the rows of the combined grid
const combineGrids = grids => {
  if (grids.length === 1) return grids[0]

  const gridSize = grids[0].length % 2 === 0 ? 2 : 3

  const numRows = Math.sqrt(flatten(grids).join('').length)
  let combinedGrid = Array(numRows).fill('')

  let section = 0
  for (let i = 0; i < grids.length; i++) {
    if (combinedGrid[section].length === numRows) {
      section = combinedGrid.findIndex(row => row === '')
    }
    for (let j = 0; j < grids[i].length; j++) {
      combinedGrid[section + j] += grids[i][j]
    }
  }

  return combinedGrid
}

// grid is a 2d array either size 4 or 9
const transform = grid => {
  const matchingIndex = ruleBook.rules.findIndex(rule => rule === toRule(grid))
  const result = ruleBook.results[matchingIndex]
  return toGrid(result)
}

const ruleBook = buildRuleBook()

const iterate = grid => {
  const divided = divideGrid(grid)
  const transformed = divided.map(transform)
  return combineGrids(transformed)
}

const numOn = grid => {
  return grid
    .join('')
    .split('')
    .reduce((count, pixel) => count + (pixel === ON), 0)
}

const run = () => {
  let grid = init
  for (let iter = 0; iter < iterations; iter++) {
    console.log(`iter ${iter + 1}`)
    grid = iterate(grid)
  }
  console.log(`Num On: ${numOn(grid)}`)
}

// part one:
// const iterations = 5
// part two
const iterations = 18
run()
