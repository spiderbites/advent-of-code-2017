const factorA = 16807
const factorB = 48271
const divisor = 2147483647

let a = 699
let b = 124

function compare(x, y) {
  return x << 16 === y << 16
}

function generateA() {
  a = ((a * factorA) % divisor)
  while (a % 4 !== 0) {
    a = ((a * factorA) % divisor)
  }
}

function generateB() {
  b = ((b * factorB) % divisor)
  while (b % 8 !== 0) {
    b = ((b * factorB) % divisor)
  }
}

let total = 0
i = 0
while (i < 5000000) {
  generateA()
  generateB()
  total += compare(a, b)
  i++
}

console.log(total)