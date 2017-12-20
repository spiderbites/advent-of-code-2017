const STEPS = 394

const MAX = 2017

let buffer = [0]

let curPos = 0

const step = () => {
  curPos = (curPos + STEPS) % buffer.length
}

const insert = (num) => {
  const start = buffer.slice(0, curPos + 1)
  const end = buffer.slice(curPos + 1, buffer.length)
  buffer = [...start, num, ...end]
  curPos = curPos + 1 % buffer.length
}

for (i = 1; i <= MAX; i++) {
  step()
  insert(i)
}

const ix = buffer.findIndex(item => item === 2017)

console.log(buffer[ix+1])