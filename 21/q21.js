const fs = require('fs')
const { chunk } = require('lodash')

// const init = ['.#.', '..#', '###'][
// const init = [['.', '#', '.'], ['.', '.', '#'], ['#', '#', '#']]
const init = [
  ['0-', '1-', '2-', '3-'],
  ['4-', '5-', '6-', '7-'],
  ['8-', '9-', '10-', '11-'],
  ['12-', '13-', '14-', '15-']
]
const inputPath = 'sample.txt'

const buildRule = line => {
  const [rule, result] = line.split(' => ')
  return [rule.split('/'), result.split('/')]
}

const buildRuleBook = () => {
  const SIZE_2_RULE_LENGTH = 20
  const SIZE_3_RULE_LENGTH = 34
  let size2Rules = {
    rules: [],
    results: []
  }
  let size3Rules = {
    rules: [],
    results: []
  }
  let rule
  lines = fs.readFileSync(inputPath, { encoding: 'utf8' }).split('\n')

  lines.forEach(line => {
    const [rule, result] = buildRule(line)
    switch (line.length) {
      case SIZE_2_RULE_LENGTH:
        size2Rules.rules.push(rule)
        size2Rules.results.push(result)
        break
      case SIZE_3_RULE_LENGTH:
        size3Rules.rules.push(rule)
        size3Rules.results.push(result)
        break
    }
  })

  return {
    2: size2Rules,
    3: size3Rules
  }
}

// grid as array of arrays, returns an array of arrays
// where each subarray is a broken up grid
const divideGrid = grid => {
  if (grid[0].length <= 3) return grid

  const divSize = grid[0].length % 2 === 0 ? 2 : 3

  const numGrids = grid[0].length * divSize / divSize

  let dividedGrids = Array(numGrids)
    .fill(0)
    .map(i => new Array())

  let section
  let row = 0
  for (let i = 0; i < grid.length; i++) {
    if (i % divSize === 0 && i > 0) {
      row += divSize
    }
    for (let j = 0; j < grid[i].length; j++) {
      section = Math.floor(j / divSize)
      dividedGrids[row + section].push(grid[i][j])
    }
  }

  // return dividedGrids
  return dividedGrids.map(item => item.join(''))
}

const ruleBook = buildRuleBook()

// grid is a 2d array either size 4 or 9
// take e.g.
const transform = grid => {
  const size = Math.sqrt(grid.length)
  const chunked = chunk(grid, size)
  for (let i = 0; i < ruleBook[size].rules.length; i++) {
    const rule = ruleBook[size].rules
  }
}

const matches = (grid, rule) => {
  // grid -> [[ 0, 1], ]
}

console.log(divideGrid(init))
// console.log(buildRuleBook()['2'].rules[0])

/*
ab/cd
ba/cd
ab/dc
ba/dc
cd/ab
cd/ba
dc/ab
dc/ba
*/

// ['ab', 'cd']
// ['abc', 'def', 'ghi]
const permutations = rule => {
  let rules = []
  let rotationsSet = rule.map(getRotations)
  console.log(rotationsSet)

  // rules.push(rule)
}

// console.log(permutations(['abc', 'def', 'ghi']))
// console.log(permutations(['ab', 'cd']))

function getRotations(s) {
  let rotations = [s]
  for (let i = 1; i < s.length; i++) {
    rotations.push(s.slice(i) + s.slice(0, i))
  }
  return rotations
}
