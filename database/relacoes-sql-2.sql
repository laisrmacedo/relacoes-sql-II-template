-- Active: 1674131541934@@127.0.0.1@3306

-- Prática 1
CREATE TABLE users (
  id TEXT PRIMARY KEY UNIQUE NOT NULL,
  name TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  created_at TEXT NOT NULL DEFAULT (DATETIME())
);

INSERT INTO users (
  id,
  name,
  email,
  password
)
VALUES 
  ("u001", "Fulana", "fulana@email.com", "fulana123"),
  ("u002", "Ciclano", "ciclano@email.com", "ciclano123"),
  ("u003", "Beltrana", "beltrana@email.com", "beltrana123");

-- pratica 2
CREATE TABLE follows (
  follower_id TEXT NOT NULL,
  followed_id TEXT NOT NULL,
  FOREIGN KEY (follower_id) REFERENCES users (id),  
  FOREIGN KEY (followed_id) REFERENCES users (id)  
);


INSERT INTO follows (follower_id, followed_id)
VALUES 
  ("u001", "u002"), -- Pessoa A segue B
  ("u001", "u003"), -- Pessoa A segue C
  ("u002", "u001"); -- Pessoa B segue A

DROP TABLE follows;

SELECT * FROM follows
INNER JOIN users
ON follows.follower_id = users.id;

-- Pratica 3
-- Mostra quem está seguindo e quem não seguiu 
-- A=follows /  B=users --> RIGHT JOIN
SELECT * FROM follows
RIGHT JOIN users
ON follows.follower_id = users.id;

-- tbm Mostra quem está seguindo e quem não seguiu mudando a perspectiva
-- A=users /  B=follows --> Left JOIN
SELECT * FROM users
LEFT JOIN follows
ON follows.follower_id = users.id;

-- Mostrando dados da pessoa q foi seguida
SELECT
  follows.follower_id as followerId,
  follows.followed_id as followedId,
  users.name as followerName,
  users2.name as followedName
FROM follows
RIGHT JOIN users
ON follows.follower_id = users.id
LEFT JOIN users as users2
ON follows.followed_id = users2.id