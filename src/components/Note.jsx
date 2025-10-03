import React, { useState } from 'react';
import './Note.css';

const Note = ({ note, onEdit, onDelete }) => {
    const [isEditing, setIsEditing] = useState(false);
    const [content, setContent] = useState(note.content);

    const handleSave = () => {
        onEdit(note.id, content);
        setIsEditing(false);
    };

    return (
        <div className="note">
            {isEditing ? (
                <>
                    <textarea
                        value={content}
                        onChange={(e) => setContent(e.target.value)}
                        className="note-edit"
                    />
                    <button onClick={handleSave}>Save</button>
                    <button onClick={() => setIsEditing(false)}>Cancel</button>
                </>
            ) : (
                <>
                    <p>{content}</p>
                    <div className="note-actions">
                        <button onClick={() => setIsEditing(true)}>Edit</button>
                        <button onClick={() => onDelete(note.id)}>Delete</button>
                    </div>
                </>
            )}
        </div>
    );
};

export default Note;