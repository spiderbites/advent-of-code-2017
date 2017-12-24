const fs = require('fs')
const input = 'input.txt'

const buildParticles = () => {
  const lines = fs.readFileSync(input, { encoding: 'utf8' }).split('\n')
  return lines.map(parseParticle)
}

const particlesByPosition = particles => {
  return particles.reduce((acc, particle, index) => {
    let serialized = serializePosition(particle.p)
    acc[serialized]
      ? acc[serialized].push(particle)
      : (acc[serialized] = [particle])
    return acc
  }, {})
}

const serializePosition = p => {
  return `${p[0]}${p[1]}${p[2]}`
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

const tick = particle => {
  particle.v[0] += particle.a[0]
  particle.v[1] += particle.a[1]
  particle.v[2] += particle.a[2]

  particle.p[0] += particle.v[0]
  particle.p[1] += particle.v[1]
  particle.p[2] += particle.v[2]

  return particle
}

const runTick = particles => {
  const newParticles = Object.values(particles).map(particleList =>
    tick(particleList[0])
  )
  return removeCollisions(particlesByPosition(newParticles))
}

const removeCollisions = particlesByPosition => {
  for (key in particlesByPosition) {
    if (particlesByPosition[key].length > 1) {
      delete particlesByPosition[key]
    }
  }
  return particlesByPosition
}

let particles = buildParticles()
let byPosition = particlesByPosition(particles)

for (let i = 0; i < 100; i++) {
  byPosition = runTick(byPosition)
  console.log(Object.keys(byPosition).length)
}
