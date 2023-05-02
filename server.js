const express = require('express')
const app = express()
const port = 3000

app.get('/', (req, res) => {
  res.send(`Apples are ${process.env.COLOUR || 'blue'} and juicy!`)
})

app.listen(port, () => {
  console.log(`Listening on port ${port}`)
})