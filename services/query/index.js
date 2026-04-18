const express = require('express')
const cors = require('cors')
const axios = require('axios')

const app = express()
app.use(express.json())
app.use(express.urlencoded({ extended: true }))
app.use(cors())

// In-memory store
const posts = {}

// 🔥 Handle incoming events safely
const handleEvent = (type, data) => {

  if (type === 'PostCreated') {
    const { postId, title } = data

    posts[postId] = {
      id: postId,
      title,
      comments: []
    }
  }

  if (type === 'CommentCreated') {
    const { id, content, postId, status } = data

    const post = posts[postId]

    // ✅ Prevent crash if post not yet created
    if (post) {
      post.comments.push({
        id,
        content,
        status
      })
    }
  }

  if (type === 'CommentUpdated') {
    const { id, content, postId, status } = data

    const post = posts[postId]

    if (post) {
      const comment = post.comments.find((comment) => comment.id === id)

      if (comment) {
        comment.status = status
        comment.content = content
      }
    }
  }
}

// 🔹 Get all posts
app.get('/posts', (req, res) => {
  res.send(posts)
})

// 🔹 Receive events from event-bus
app.post('/events', (req, res) => {
  const { type, data } = req.body

  handleEvent(type, data)

  res.send({})
})

// 🔹 Start server + sync past events
app.listen(4002, async () => {
  console.log('Listening on 4002')

  try {
    const res = await axios.get('http://event-bus:4005/events')

    console.log('🔄 Syncing past events...')

    for (let event of res.data) {
      console.log('Processing event:', event.type)
      handleEvent(event.type, event.data)
    }

    console.log('✅ Sync complete')
  } catch (err) {
    console.log('❌ Error fetching events:', err.message)
  }
})