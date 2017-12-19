const factorA = 16807
const factorB = 48271
const divisor = 2147483647

function generate (num, factor) {
  return (num * factor) % divisor
}

function compare(a, b) {
  return a << 16 === b << 16
}

let a = 699
let b = 124

let total = 0

for (i = 0; i < 40000000; i++) {
  a = generate(a, factorA)
  b = generate(b, factorB)
  total += compare(a, b)
}

console.log(total)