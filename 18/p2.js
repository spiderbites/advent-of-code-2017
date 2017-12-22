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

const buildRegisters = (filepath, id) => {
  let data = fs.readFileSync(filepath, {encoding: 'utf8'})
  data = data.split('\n').map(line => line.split(' '))
  let registers = data.reduce((registers, command) => {
    if (isNaN(parseInt(command[1], 10))) {
      registers[command[1]] = 0
    }
    return registers
  }, {})
  registers.p = id
  return registers
}

const instructions = buildInstructions(input)

class Program {
  constructor(id) {
    this.id = id
    this.registers = buildRegisters(input, id)
    this.currentInstruction = 0
    this.otherProgram = null
    this.sendCount = 0
    this.isWaiting = false
    this.queue = []
  }

  addOtherProgram(p) {
    this.otherProgram = p
  }

  addToQueue(value) {
    this.queue.splice(0, 0, value)
  }

  snd(register) {
    this.otherProgram.addToQueue(this.registers[register])
    this.sendCount++
  }

  rcv(register) {
    if (done) return
    if (this.queue.length === 0) {
      this.isWaiting = true
    } else {
      this.isWaiting = false
      this.registers[register] = this.queue.pop()
      this.currentInstruction++
    }
  }

  set(x, y) {
    if (y in this.registers) {
      this.registers[x] = this.registers[y]
    } else {
      this.registers[x] = y
    }
  }

  add(x, y) {
    if (y in this.registers) {
      this.registers[x] += this.registers[y]
    } else {
      this.registers[x] += y
    }
  }

  mul(x, y) {
    if (y in this.registers) {
      this.registers[x] *= this.registers[y]
    } else {
      this.registers[x] *= y
    }
  }

  mod(x, y) {
    if (y in this.registers) {
      this.registers[x] %= this.registers[y]
    } else {
      this.registers[x] %= y
    }
  }

  jgz(x, y) {
    if (x in this.registers) {
      if (this.registers[x] > 0) {
        if (y in this.registers) {
          this.currentInstruction += this.registers[y]
        } else {
          this.currentInstruction += y
        }
      } else {
        this.currentInstruction++
      }
    } else {
      if (x > 0) {
        if (y in this.registers) {
          this.currentInstruction += this.registers[y]
        } else {
          this.currentInstruction += y
        }
      } else {
        this.currentInstruction++
      }
    }
  }

  run() {
    const [command, x, y] = instructions[this.currentInstruction]

    switch (command) {
      case 'snd':
        this.snd(x)
        break;
      case 'set':
        this.set(x, y)
        break;
      case 'add':
        this.add(x, y)
        break;
      case 'mul':
        this.mul(x, y)
        break;
      case 'mod':
        this.mod(x, y)
        break;
      case 'rcv':
        this.rcv(x)
        break;
      case 'jgz':
        this.jgz(x, y)
        break;
    }

    if (command !== 'jgz' && command !== 'rcv') {
      this.currentInstruction++
    }
  }
}


let done = false

const p0 = new Program(0)
const p1 = new Program(1)

p0.addOtherProgram(p1)
p1.addOtherProgram(p0)

while (!(p0.isWaiting && p1.isWaiting)) {
  p0.run()
  p1.run()
}

done = true

console.log(`p1 send count: ${p1.sendCount}`)