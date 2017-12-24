const fs = require('fs')
const input = 'input.txt'

const buildParticles = () => {
  const lines = fs.readFileSync(input, { encoding: 'utf8' }).split('\n')
  return lines.map(parseParticle)
}

const parseParticle = line => {
  const [p, v, a] = line.split(' ').map(pos =>
    pos
      .split(/[<>]/)[1]
      .split(',')
      .map(num => parseInt(num, 10))
  )
  return { p, v, a }
}

const minAcceleration = particles => {
  const accelerations = particles.map(particle =>
    particle.a.map(Math.abs).reduce((acc, a) => acc + a)
  )
  const minAcceleration = Math.min(...accelerations)
  return accelerations.findIndex(a => a === minAcceleration)
}

let particles = buildParticles()
console.log(minAcceleration(particles))
