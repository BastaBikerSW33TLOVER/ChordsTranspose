xpress = require('express');
const cors = require('cors');
const app = express();
const PORT = 3000;

app.use(cors());
app.use(express.json());

let books = [
  { title: 'Book 1', author: 'Author 1', publishedYear: 2020 },
  { title: 'Book 2', author: 'Author 2', publishedYear: 2021 }
];

// Get all books
app.get('/api/books', (req, res) => {
  res.json(books);
});

// Add a new book
app.post('/api/books', (req, res) => {
  const { title, author, publishedYear } = req.body;
  if (!title || !author || typeof publishedYear !== 'number') {
    return res.status(400).json({ error: 'Invalid book data' });
  }
  books.push({ title, author, publishedYear });
  res.status(201).json({ message: 'Book added' });
});

// Start the server
app.listen(PORT, () => {
  console.log('Server running on http://localhost:${PORT}');
});