const fs = require('fs')
const path = require('path')
const input = path.resolve(__dirname, 'input.txt')

const buildInstructions = filepath => {
  let data = fs.readFileSync(filepath, { encoding: 'utf8' })
  data = data.split('\n').map(line => line.split(' '))
  return data.map(command => {
    let integer = parseInt(command[2], 10)
    if (!isNaN(integer)) {
      command[2] = integer
    }
    return command
  })
}

const buildRegisters = () => {
  return { a: 0, b: 0, c: 0, d: 0, e: 0, f: 0, g: 0, h: 0 }
}

let registers = buildRegisters(input)

let instructions = buildInstructions(input)

let currentInstruction = 0

// set X Y sets register X to the value of Y.
const set = (x, y) => {
  if (y in registers) {
    registers[x] = registers[y]
  } else {
    registers[x] = y
  }
}

// sub X Y decreases register X by the value of Y.
const sub = (x, y) => {
  if (y in registers) {
    registers[x] -= registers[y]
  } else {
    registers[x] -= y
  }
}

// mul X Y sets register X to the result of multiplying the value contained in register X by the value of Y.
const mul = (x, y) => {
  mulCount++
  if (y in registers) {
    registers[x] *= registers[y]
  } else {
    registers[x] *= y
  }
}

// jnz X Y jumps with an offset of the value of Y, but only if the value of X is not zero. (An offset of 2 skips the next instruction, an offset of -1 jumps to the previous instruction, and so on.)
const jnz = (x, y) => {
  if (x in registers) {
    if (registers[x] !== 0) {
      currentInstruction += y
    } else {
      currentInstruction++
    }
  } else {
    if (x !== 0) {
      currentInstruction += y
    } else {
      currentInstruction++
    }
  }
}

const run = () => {
  const [command, x, y] = instructions[currentInstruction]

  switch (command) {
    case 'set':
      set(x, y)
      break
    case 'sub':
      sub(x, y)
      break
    case 'mul':
      mul(x, y)
      break
    case 'jnz':
      jnz(x, y)
      break
  }

  if (command !== 'jnz') {
    currentInstruction++
  }
  if (instructions[currentInstruction] === undefined) {
    done = true
  }
}

let done = false
let mulCount = 0

while (!done) {
  run()
}

console.log(mulCount)
