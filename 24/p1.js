const fs = require('fs')
const path = require('path')
const filepath = path.resolve(__dirname, 'input.txt')

class Component {
  constructor(a, b) {
    this.a = a
    this.b = b
    this.used = false
  }

  strength() {
    return this.a + this.b
  }
}

let data = fs.readFileSync(filepath, { encoding: 'utf8' }).split('\n')
let components = data
  .map(port => port.split('/').map(p => parseInt(p, 10)))
  .map(port => new Component(port[0], port[1]))

let maxStrength = 0
let maxLength = 0

const findStrongest = (port, strength) => {
  if (strength > maxStrength) {
    maxStrength = strength
  }

  for (let component of components) {
    if (component.used) {
      continue
    }

    if (component.a === port || component.b === port) {
      component.used = true
      let nextPort = component.a === port ? component.b : component.a
      let nextStrength = strength + component.strength()
      findStrongest(nextPort, nextStrength)
      component.used = false
    }
  }
}

// findStrongest(0, 0)

const findLongestStrongest = (port, strength, length) => {
  if (length >= maxLength) {
    maxLength = length
    if (strength > maxStrength) {
      maxStrength = strength
    }
  }

  for (let component of components) {
    if (component.used) {
      continue
    }

    if (component.a === port || component.b === port) {
      component.used = true
      let nextPort = component.a === port ? component.b : component.a
      let nextStrength = strength + component.strength()
      findLongestStrongest(nextPort, nextStrength, length + 1)
      component.used = false
    }
  }
}

findLongestStrongest(0, 0, 0)

console.log(maxStrength)
