CREATE TABLE documents (
    id SERIAL PRIMARY KEY,
    content TEXT NOT NULL,
    embedding vector(3072) -- assuming OpenAI embedding size
);

select * from documents;

delete  from documents;

truncate table documents;