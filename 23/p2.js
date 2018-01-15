function disassembled() {
  let b = 57 * 100 + 100000
  let c = 57 * 100 + 100000 + 17000

  let d = 0
  let e = 0
  let f = 0
  let g = 0
  let h = 0

  let start = true

  while (true) {
    f = 1
    d = 2

    while (start || g !== 0) {
      e = 2

      while (start || g !== 0) {
        start = false
        g = d * e - b
        if (g === 0) {
          f = 0
        }
        e++
        g = e - b
      }

      d++
      g = d - b
    }

    if (f === 0) {
      h++
    }
    g = b - c
    if (g === 0) {
      return h
    }
    b = b + 17
  }
}

console.log(disassembled())
