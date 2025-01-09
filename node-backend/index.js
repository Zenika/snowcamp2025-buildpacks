const express = require('express')
const app = express()
const port = 3000

app.get('/greetings', (req, res) => {
  res.send('Hello Snowcamp!')
})

app.listen(port, () => {
  console.log(`Example app listening on port ${port}`)
})

