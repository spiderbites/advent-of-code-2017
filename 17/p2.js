const STEPS = 394

const MAX = 50000000

let zeroPos = 0
let bufferLength = 1
let afterZero = null
let curPos = 0

const step = (num) => {
  curPos = (curPos + STEPS) % bufferLength
  if (curPos === zeroPos) {
    afterZero = num
  } else if (curPos < zeroPos) {
    zeroPos += 1
  }
  curPos += 1
  bufferLength += 1
}

for (i = 1; i <= MAX; i++) {
  step(i)
}

console.log(afterZero)