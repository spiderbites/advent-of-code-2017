const path = require('path')
const fs = require('fs')

const inputPath = path.resolve(__dirname, 'input.txt')

const CLEAN = '.'
const INFECTED = '#'
const WEAKENED = 'W'
const FLAGGED = 'F'

const UP = 'u'
const DOWN = 'd'
const RIGHT = 'r'
const LEFT = 'l'

class Cluster {
  constructor() {
    this.map = this.buildMap()
    let center = this._findCenter()
    this.currentPosition = { x: center, y: center }
    this.direction = UP
    this.infectedCount = 0
  }

  buildMap() {
    const lines = fs.readFileSync(inputPath, { encoding: 'utf8' }).split('\n')
    let map = {}
    lines.forEach((line, y) => {
      line.split('').forEach((node, x) => {
        map[this._serializeCoords(x, line.length - y - 1)] = node
      })
    })
    return map
  }

  burst() {
    const currentNode = this._nodeAtPosition(this.currentPosition)
    if (currentNode === CLEAN) {
      this._setMap(this.currentPosition, INFECTED)
      this._turnLeft()
      this.infectedCount++
    } else {
      this._setMap(this.currentPosition, CLEAN)
      this._turnRight()
    }
    this._move()
    const newNode = this._nodeAtPosition(this.currentPosition)
    if (newNode === undefined) {
      this._setMap(this.currentPosition, CLEAN)
    }
  }

  evolvedBurst() {
    const currentNode = this._nodeAtPosition(this.currentPosition)
    switch (currentNode) {
      case CLEAN:
        this._turnLeft()
        this._setMap(this.currentPosition, WEAKENED)
        break
      case WEAKENED:
        this._setMap(this.currentPosition, INFECTED)
        this.infectedCount++
        break
      case INFECTED:
        this._setMap(this.currentPosition, FLAGGED)
        this._turnRight()
        break
      case FLAGGED:
        this._setMap(this.currentPosition, CLEAN)
        this._reverse()
        break
    }
    this._move()
    const newNode = this._nodeAtPosition(this.currentPosition)
    if (newNode === undefined) {
      this._setMap(this.currentPosition, CLEAN)
    }
  }

  _setMap({ x, y }, val) {
    this.map[this._serializeCoords(x, y)] = val
  }

  _turnRight() {
    switch (this.direction) {
      case UP:
        this.direction = RIGHT
        break
      case DOWN:
        this.direction = LEFT
        break
      case LEFT:
        this.direction = UP
        break
      case RIGHT:
        this.direction = DOWN
        break
    }
  }

  _turnLeft() {
    switch (this.direction) {
      case UP:
        this.direction = LEFT
        break
      case DOWN:
        this.direction = RIGHT
        break
      case LEFT:
        this.direction = DOWN
        break
      case RIGHT:
        this.direction = UP
        break
    }
  }

  _reverse() {
    switch (this.direction) {
      case UP:
        this.direction = DOWN
        break
      case DOWN:
        this.direction = UP
        break
      case LEFT:
        this.direction = RIGHT
        break
      case RIGHT:
        this.direction = LEFT
        break
    }
  }

  _move() {
    switch (this.direction) {
      case UP:
        this.currentPosition.y += 1
        break
      case DOWN:
        this.currentPosition.y -= 1
        break
      case LEFT:
        this.currentPosition.x -= 1
        break
      case RIGHT:
        this.currentPosition.x += 1
        break
    }
  }

  _nodeAtPosition({ x, y }) {
    return this.map[this._serializeCoords(x, y)]
  }

  _findCenter() {
    const lines = fs.readFileSync(inputPath, { encoding: 'utf8' }).split('\n')
    return Math.floor(lines.length / 2)
  }

  _serializeCoords(x, y) {
    return `${x}:${y}`
  }

  _deserializeCoords(coords) {
    const [x, y] = coords.split(':')
    return { x, y }
  }
}

function runP1() {
  let cluster = new Cluster()
  for (let i = 0; i < 10000; i++) {
    cluster.burst()
  }
  console.log(cluster.infectedCount)
}

function runP2() {
  let cluster = new Cluster()
  for (let i = 0; i < 10000000; i++) {
    cluster.evolvedBurst()
  }
  console.log(cluster.infectedCount)
}

// runP1()
// runP2()
