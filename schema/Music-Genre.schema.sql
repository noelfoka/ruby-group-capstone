-- labels table
CREATE TABLE labels (
    id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    color VARCHAR(255) NOT NULL
);

-- items table (parent table for music albums)
CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    label_id INT,
    publish_date DATE NOT NULL,
    archived BOOLEAN NOT NULL,
    FOREIGN KEY (label_id) REFERENCES labels(id)
);

-- music_albums table
CREATE TABLE music_albums (
    id INT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    genre_id INT,
    author_id INT,
    label_id INT,
    publish_date DATE NOT NULL,
    archived BOOLEAN NOT NULL,
    FOREIGN KEY (id) REFERENCES items(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id),
    FOREIGN KEY (author_id) REFERENCES authors(id),
    FOREIGN KEY (label_id) REFERENCES labels(id)
);

-- genres table
CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);
