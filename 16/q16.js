const fs = require('fs')

const file = fs.readFileSync('input.txt', {encoding: 'utf8'})
let moves = file
  .split(',')
  .map(move => [move[0], move.slice(1)])

let programs = Array.from('abcdefghijklmnop')
let length = programs.length

const spin = (num) => {
  end = programs.slice(length - num)
  start = programs.slice(0, length - num)
  programs = end.concat(start)
}

const exchange = (a, b) => {
  const tmp = programs[a]
  programs[a] = programs[b]
  programs[b] = tmp
}

const partner = (a, b) => {
  const ax = programs.indexOf(a)
  const bx = programs.indexOf(b)
  exchange(ax, bx)
}

function parseMoves () {
  return moves.map(move => {
    switch (move[0]) {
      case 's':
        return [move[0], parseInt(move[1], 10)]
      case 'x':
        return ['x', move[1].split('/').map(n => parseInt(n, 10))]
      case 'p':
        return ['p', move[1].split('/')]
    }
  })
}

moves = parseMoves()

function dance () {
  for (move of moves) {
    switch (move[0]) {
      case 's':
        spin(move[1])
        break;
      case 'x':
        exchange(...move[1])
        break;
      case 'p':
        partner(...move[1])
        break;
    }
  }
}

function equal(a1, a2) {
  for (let i = 0; i < a1.length; i++) {
    if (a1[i] !== a2[i]) return false
  }
  return true
}

function findCycle() {
  let i = 1
  const original = Array.from('abcdefghijklmnop')
  dance()
  while (true) {
    if (equal(original, programs)) {
      return i
    }
    dance()
    i++
  }
}

const cycle = findCycle()

const diff = 1000000000 % cycle

for (let i = 0; i < diff; i++) {
  dance()
}

console.log(cycle)