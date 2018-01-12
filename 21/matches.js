// ../.# => ##./#../...
// .#./..#/### => #..#/..../..../#..#

function permutations(s) {
  let permutations = [s]
  for (let i = 1; i < s.length; i++) {
    permutations.push(s.slice(i).concat(s.slice(0, i)))
  }
  return permutations
}

function allRules(input) {
  // get the permutations for each rule part, e.g. 'ab/cd' -> [['ab', 'ba'], ['cd', 'dc']], aka 'rotations'
  let groups = input.split('/').map(permutations)

  // get the cartesian product of all permutations, e.g. [['ab', 'cd'], ['ab', 'dc'], ['ba', 'cd'], ['ba', 'dc']]
  groups = cartesianProduct(groups)

  // get the permutations over the cartesian product, aka 'flips'
  groups = groups.reduce((acc, group) => acc.concat(permutations(group)), [])

  return groups.map(g => g.join('/'))
}

function cartesianProduct(arrays) {
  return arrays.reduce(
    (acc, item) => {
      let ret = []
      acc.forEach(a => {
        item.forEach(b => {
          ret.push(a.concat([b]))
        })
      })
      return ret
    },
    [[]]
  )
}

console.log(allRules('ab/cd').length)
console.log(allRules('abc/def/ghi').length)
