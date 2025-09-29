-- for Full-Text Search

-- Create a table
CREATE TABLE articles (
  id SERIAL PRIMARY KEY,
  title TEXT,
  body TEXT,
  body_vector TSVECTOR
);

-- Insrt Statements


-- Absolutely! Here's a set of 20 INSERT statements for your articles table, 
-- featuring realistic titles and bodies across diverse domains like tech, 
--health, finance, travel, and more. These examples are crafted to support 
-- Full-Text Search (FTS) by including rich, searchable content.

INSERT INTO articles (title, body) VALUES
('AI Revolution in Healthcare', 'Artificial intelligence is transforming diagnostics, patient care, and medical research.'),
('Global Warming and Its Impact', 'Climate change is accelerating due to greenhouse gas emissions and deforestation.'),
('Stock Market Trends 2025', 'Investors are focusing on tech stocks and green energy as market volatility increases.'),
('Exploring the Amazon Rainforest', 'The Amazon is home to diverse wildlife and indigenous cultures facing environmental threats.'),
('Cybersecurity Best Practices', 'Protecting data requires strong passwords, encryption, and regular software updates.'),
('The Rise of Remote Work', 'Flexible schedules and digital tools are reshaping the modern workplace.'),
('Nutrition Myths Debunked', 'Not all fats are bad, and carbs are essential for energy. Balance is key.'),
('SpaceX Mars Mission Plans', 'Elon Musk’s company aims to colonize Mars with reusable rockets and sustainable habitats.'),
('Mental Health Awareness', 'Therapy, mindfulness, and community support are vital for emotional well-being.'),
('Electric Vehicles in 2025', 'EVs are becoming mainstream with better batteries, charging infrastructure, and incentives.'),
('Blockchain Beyond Bitcoin', 'Decentralized ledgers are revolutionizing supply chains, voting systems, and identity verification.'),
('The Art of Minimalism', 'Minimalist living promotes clarity, sustainability, and intentional consumption.'),
('Traveling Through Europe', 'From Paris to Prague, European cities offer rich history, cuisine, and architecture.'),
('The Future of Education', 'Online learning platforms and AI tutors are redefining how students engage with content.'),
('Fitness Trends to Watch', 'HIIT, wearable tech, and virtual coaching are shaping the fitness industry.'),
('Smart Home Innovations', 'IoT devices like smart thermostats and voice assistants enhance convenience and energy efficiency.'),
('The Psychology of Habits', 'Understanding triggers and rewards helps build lasting behavioral change.'),
('Sustainable Fashion Movement', 'Eco-friendly materials and ethical labor practices are gaining traction in the fashion world.'),
('The Gig Economy Explained', 'Freelancers and contract workers are reshaping traditional employment models.'),
('Digital Privacy in the Age of AI', 'Data collection and surveillance raise concerns about user consent and transparency.');


Select * from articles;


-- Note: The body_vector column should be populated using to_tsvector() after 
-- insertion, either via a trigger or an UPDATE statement.


-- Optional: Populate body_vector for FTS
-- -- Populate the tsvector column

UPDATE articles SET body_vector = to_tsvector('english', body);


-- Search for articles containing "bad" and "balance"
SELECT * FROM articles
WHERE body_vector @@ to_tsquery('english', 'bad & balance');
