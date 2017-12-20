const fs = require('fs')

const input = 'input.txt'

const buildInstructions = (filepath) => {
  let data = fs.readFileSync(filepath, {encoding: 'utf8'})
  data = data.split('\n').map(line => line.split(' '))
  return data.map(command => {
    let integer = parseInt(command[2], 10)
    if (!isNaN(integer)) {
      command[2] = integer
    }
    return command
  })
}

const buildRegisters = (filepath) => {
  let data = fs.readFileSync(filepath, {encoding: 'utf8'})
  data = data.split('\n').map(line => line.split(' '))
  return data.reduce((registers, command) => {
    if (isNaN(parseInt(command[1], 10))) {
      registers[command[1]] = 0
    }
    return registers
  }, {})
}

let registers = buildRegisters(input)

let instructions = buildInstructions(input)

let currentInstruction = 0

let lastSoundPlayed = null

let recoveredFrequency = null

// snd X plays a sound with a frequency equal to the value of X.
const snd = register => {
  lastSoundPlayed = registers[register]
}

// set X Y sets register X to the value of Y.
const set = (x, y) => {
  if (y in registers) {
    registers[x] = registers[y]
  } else {
    registers[x] = y
  }
}

// add X Y increases register X by the value of Y.
const add = (x, y) => {
  if (y in registers) {
    registers[x] += registers[y]
  } else {
    registers[x] += y
  }
}

// mul X Y sets register X to the result of multiplying the value contained in register X by the value of Y.
const mul = (x, y) => {
  if (y in registers) {
    registers[x] *= registers[y]
  } else {
    registers[x] *= y
  }
}

// mod X Y sets register X to the remainder of dividing the value contained in register X by the value of Y (that is, it sets X to the result of X modulo Y).
const mod = (x, y) => {
  if (y in registers) {
    registers[x] %= registers[y]
  } else {
    registers[x] %= y
  }
}
// rcv X recovers the frequency of the last sound played, but only when the value of X is not zero. (If it is zero, the command does nothing.)
const rcv = (register) => {
  if (registers[register] === 0) {
    return
  }
  recoveredFrequency = lastSoundPlayed
}

// jgz X Y jumps with an offset of the value of Y, but only if the value of X is greater than zero. (An offset of 2 skips the next instruction, an offset of -1 jumps to the previous instruction, and so on.)
const jgz = (x, y) => {
  if (x in registers) {
    if (registers[x] > 0) {
      currentInstruction += y
    } else {
      currentInstruction++
    }
  } else {
    if (x > 0) {
      currentInstruction += y
    } else {
      currentInstruction++
    }
  }
}


const run = () => {
  const [command, x, y] = instructions[currentInstruction]

  switch (command) {
    case 'snd':
      snd(x)
      break;
    case 'set':
      set(x, y)
      break;
    case 'add':
      add(x, y)
      break;
    case 'mul':
      mul(x, y)
      break;
    case 'mod':
      mod(x, y)
      break;
    case 'rcv':
      rcv(x)
      break;
    case 'jgz':
      jgz(x, y)
      break;
  }

  if (command !== 'jgz') {
    currentInstruction++
  }
}

while (recoveredFrequency === null) {
  run()
}

console.log(recoveredFrequency)