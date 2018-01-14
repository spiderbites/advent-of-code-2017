const { zip } = require('lodash')
/*
rotate a grid by 90 degrees.
given [
  ['a', 'b', 'c'],
  ['d', 'e', 'f'],
  ['g' ,'h', 'i']
]
return [
  ['g', 'd', 'a'],
  ['h', 'e', b'],
  ['i', 'f', 'c']
]
*/
const rotate = grid => {
  return zip(...grid).map(a => a.reverse())
}

/* flip a grid about its x axis */
const flipX = grid => {
  return grid.slice().reverse()
}

// Given a rule, e.g. ab/cd, return a list of all rules that can be derived from the given rule, using "rotations" and "flips"
// id, rot90, rot180, rot270, flipX, flipX after rot90, flipX after rot180, flipX after rot270
function allRules(rule) {
  let rules = []
  let grid = rule.split('/').map(r => r.split(''))
  rules.push(grid)
  rules.push(flipX(grid))
  for (let rotation = 0; rotation < 3; rotation++) {
    grid = rotate(grid)
    rules.push(grid)
    rules.push(flipX(grid))
  }
  // return rules
  return rules.map(grid => grid.map(r => r.join('')).join('/'))
}

module.exports = allRules
