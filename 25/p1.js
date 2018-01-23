const MAX_STEPS = 12302209

const machine = {
  0: 0
}

let state = 'A'

let step = 0

let currentValue = 0

let slot = 0

while (step < MAX_STEPS) {
  if (step % 1000000 === 0) {
    console.log(step)
  }
  let currentValue = machine[slot] || 0
  switch (state) {
    case 'A':
      if (currentValue === 0) {
        machine[slot] = 1
        slot++
        state = 'B'
      } else {
        machine[slot] = 0
        slot--
        state = 'D'
      }
      break
    case 'B':
      if (currentValue === 0) {
        machine[slot] = 1
        slot++
        state = 'C'
      } else {
        machine[slot] = 0
        slot++
        state = 'F'
      }
      break
    case 'C':
      if (currentValue === 0) {
        machine[slot] = 1
        slot--
        state = 'C'
      } else {
        machine[slot] = 1
        slot--
        state = 'A'
      }
      break
    case 'D':
      if (currentValue === 0) {
        machine[slot] = 0
        slot--
        state = 'E'
      } else {
        machine[slot] = 1
        slot++
        state = 'A'
      }
      break
    case 'E':
      if (currentValue === 0) {
        machine[slot] = 1
        slot--
        state = 'A'
      } else {
        machine[slot] = 0
        slot++
        state = 'B'
      }
      break
    case 'F':
      if (currentValue === 0) {
        machine[slot] = 0
        slot++
        state = 'C'
      } else {
        machine[slot] = 0
        slot++
        state = 'E'
      }
      break
  }
  step++
}

console.log(Object.values(machine).reduce((sum, v) => sum + v))
