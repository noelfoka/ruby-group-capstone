-- Book
CREATE TABLE book(
  ID SERIAL PRIMARY KEY,
  publish_date DATE NOT NULL,
  archived BOOLEAN NOT NULL,
  publisher VARCHAR(50) NOT NULL,
  cover_state VARCHAR(50) NOT NULL,
  author_ID INT,
  genre_ID INT,
  label_ID INT,
  FOREIGN KEY (label_ID) REFERENCES label(ID),
  FOREIGN KEY (author_ID) REFERENCES author(ID),
  FOREIGN KEY(genre_ID) REFERENCES genre(ID)
);

-- Label
CREATE TABLE label (
  ID SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  color VARCHAR,
);
