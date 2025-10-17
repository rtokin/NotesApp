import { render, screen, fireEvent } from '@testing-library/react';
import Note from '../Note';

test('renders note content', () => {
  const mockNote = { id: 1, content: 'Test note content' };
  render(<Note note={mockNote} onEdit={() => {}} onDelete={() => {}} />);
  expect(screen.getByText('Test note content')).toBeInTheDocument();
});

test('shows edit mode when edit button is clicked', () => {
  const mockNote = { id: 1, content: 'Test note' };
  render(<Note note={mockNote} onEdit={() => {}} onDelete={() => {}} />);
  
  fireEvent.click(screen.getByText('Edit'));
  expect(screen.getByRole('textbox')).toBeInTheDocument();
});

test('handles missing note gracefully', () => {
  render(<Note note={null} onEdit={() => {}} onDelete={() => {}} />);
  expect(screen.getByText('Note is missing')).toBeInTheDocument();
});