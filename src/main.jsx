import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import './index.css'
import Note from './components/Note'

createRoot(document.getElementById('root')).render(
  <StrictMode>
    <Note />
  </StrictMode>,
)
