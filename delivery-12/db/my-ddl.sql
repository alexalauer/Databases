# create the database for the project 




SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS event_location;
DROP TABLE IF EXISTS show_genre;
DROP TABLE IF EXISTS movie_genre;
DROP TABLE IF EXISTS show_events;
DROP TABLE IF EXISTS movie_events;
DROP TABLE IF EXISTS cast_events;
DROP TABLE IF EXISTS show_cast;
DROP TABLE IF EXISTS movie_cast;
DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS movies;
DROP TABLE IF EXISTS shows;
DROP TABLE IF EXISTS genres;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS locations;
DROP TABLE IF EXISTS casts;
DROP TABLE IF EXISTS events;
SET FOREIGN_KEY_CHECKS=1;


CREATE TABLE movies (
    id                      int PRIMARY KEY,
    title                   varchar(256) NOT NULL,
    public_release_date     date NOT NULL,
    theater_release_date    date,
    director                varchar(256),
    rating                  float CHECK (rating BETWEEN 1 AND 5),
    age_rating              varchar(5) CHECK (age_rating IN ('G', 'PG', 'PG-13', 'R', 'NC-17')) NOT NULL, 
    information             varchar(1000)
);


CREATE TABLE shows (
    id                      int PRIMARY KEY,
    title                   varchar(256) NOT NULL,
    premier_date            date NOT NULL,
    upcoming_release_date   date,
    seasons                 int,
    episodes                int,
    rating                  float CHECK (rating BETWEEN 1 AND 5),
    age_rating              varchar(5) CHECK (age_rating IN ('G', 'PG', 'PG-13', 'R', 'NC-17')) NOT NULL,
    showrunner              varchar(256),
    information             varchar(1000)
);

CREATE TABLE genres (
    id                      int PRIMARY KEY,
    name                    varchar(256) NOT NULL UNIQUE,
    description             varchar(1000)
);


CREATE TABLE users (
    id                      int PRIMARY KEY,
    name                    varchar(256) NOT NULL,
    email                   varchar(256) NOT NULL UNIQUE,
    registration_date       date NOT NULL
);

CREATE TABLE locations (
    id                      int PRIMARY KEY,
    name                    varchar(256) NOT NULL,
    address                 varchar(256) NOT NULL,
    venueURL                varchar(256),
    capacity                int,
    type                    varchar(256) CHECK (Type IN ('Movie Theater', 'Convention Hall', 'Other')),
    information             varchar(1000)
);

CREATE TABLE casts (
    id                      int PRIMARY KEY,
    name                    varchar(256) NOT NULL,
    dateofbirth             date,
    hometown                varchar(256),
    information             varchar(1000)
);

CREATE TABLE events (
    id                      int PRIMARY KEY,
    name                    varchar(256) NOT NULL,
    date                    date NOT NULL,
    description             varchar(1000),
    age_rating              varchar(5) CHECK (age_rating IN ('G', 'PG', 'PG-13', 'R', 'NC-17')) NOT NULL,
    information             varchar(1000)
);

CREATE TABLE reviews (
    id                      int PRIMARY KEY AUTO_INCREMENT,
    rating                  float CHECK (rating BETWEEN 1 AND 5),
    comments                varchar(1000),
    user_id                 int NOT NULL,
    movie_id                int,
    show_id                 int,
    FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (movie_id) REFERENCES movies(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (show_id) REFERENCES shows(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE movie_cast (
    id                      int PRIMARY KEY AUTO_INCREMENT,
    movie_id                int NOT NULL,
    cast_id                 int NOT NULL,
    role                    varchar(256),
    UNIQUE (movie_id, cast_id),
    FOREIGN KEY (movie_id) REFERENCES movies(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (cast_id) REFERENCES casts(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE show_cast (
    id                      int PRIMARY KEY AUTO_INCREMENT,
    show_id                 int NOT NULL,
    cast_id                 int NOT NULL,
    role                    varchar(256),
    UNIQUE (show_id, cast_id),
    FOREIGN KEY (show_id) REFERENCES shows(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (cast_id) REFERENCES casts(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);



CREATE TABLE cast_events (
    id                      int PRIMARY KEY AUTO_INCREMENT,
    cast_id                 int NOT NULL,
    event_id                int NOT NULL,
    UNIQUE (cast_id, event_id),
    FOREIGN KEY (cast_id) REFERENCES casts(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (event_id) REFERENCES events(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);


CREATE TABLE movie_events (
    id                      int PRIMARY KEY AUTO_INCREMENT,
    movie_id                int NOT NULL,
    event_id                int NOT NULL,
    UNIQUE (movie_id, event_id),
    FOREIGN KEY (movie_id) REFERENCES movies(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (event_id) REFERENCES events(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE show_events (
    id                      int PRIMARY KEY AUTO_INCREMENT,
    show_id                 int NOT NULL,
    event_id                int NOT NULL,
    UNIQUE (show_id, event_id),
    FOREIGN KEY (show_id) REFERENCES shows(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (event_id) REFERENCES events(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE movie_genre (
    id                      int PRIMARY KEY AUTO_INCREMENT,
    movie_id                int NOT NULL, 
    genre_id                int NOT NULL, 
    UNIQUE (movie_id, genre_id),
    FOREIGN KEY (movie_id) REFERENCES movies(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE show_genre (
    id                      int PRIMARY KEY AUTO_INCREMENT,
    show_id                 int NOT NULL, 
    genre_id                int NOT NULL, 
    UNIQUE (show_id, genre_id),
    FOREIGN KEY (show_id) REFERENCES shows(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (genre_id) REFERENCES genres(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

CREATE TABLE event_location (
    id                      int PRIMARY KEY AUTO_INCREMENT,
    event_id                int NOT NULL,
    location_id             int NOT NULL,
    UNIQUE (event_id, location_id),
    FOREIGN KEY (event_id) REFERENCES events(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (location_id) REFERENCES locations(id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);



# Start inserting in some data 


# Data for genre 

INSERT INTO genres (id, name, description) VALUES
(101, 'Science Fiction', 'Explores futuristic concepts, advanced technology, space exploration, and often features speculative themes.'),
(102, 'Thriller', 'Designed to create suspense, excitement, and high levels of anticipation in the viewer.'),
(103, 'Horror', 'Intended to scare, shock, or disgust audiences through suspense, fear, or horror elements.'),
(104, 'Romance', 'Centers on love and emotional relationships, often with dramatic or sentimental themes.'),
(105, 'Action', 'Features high-energy sequences, stunts, and fast-paced plots often involving danger and conflict.'),
(106, 'Mystery', 'Involves solving a puzzle, crime, or other intrigue, often with clues and suspense.'),
(107, 'Drama', 'Focuses on realistic character development and emotional narratives.'),
(108, 'Fantasy', 'Features magical or supernatural elements, often in fictional universes and epic quests.');

# Data for movies 

INSERT INTO movies (id, title, public_release_date, theater_release_date, director, rating, age_rating, information) VALUES
(201, 'The Silent Horizon', '2023-07-14', '2023-08-01', 'Jordan Willis', 4.1, 'PG-13', 'A suspenseful thriller set in a dystopian world.'),
(202, 'Whispers in the Woods', '2022-10-31', '2022-11-15', 'Maria Collins', 5, 'R', 'A horror movie that explores urban legends in a remote forest.'),
(203, 'A Galactic Journey', '2024-05-05', '2024-06-10', 'Lin Zhao', 4.4, 'PG', 'A family-friendly space adventure across different planets.'),
(204, 'Love Beyond the Stars', '2021-02-14', '2021-02-28', 'Raul Hernandez', 3.8, 'PG-13', 'A romantic drama set on a space station.'),
(205, 'Echoes of the Past', '2020-09-12', NULL, 'Sophia Riedel', 4.2, 'G', 'A historical documentary exploring ancient civilizations.'),
(206, 'The Final Stand', '2023-12-20', '2024-01-05', 'Brandon Lee', 5, 'R', 'An action-packed thriller centered on a heist gone wrong.'),
(207, 'Mystery at Sunset Beach', '2022-06-15', '2022-07-01', 'Amira Patel', 3.8, 'PG', 'A detective mystery revolving around a series of strange events in a beach town.'),
(208, 'The Child Within', '2023-04-07', NULL, 'Evan Thompson', 4, 'PG', 'A heartfelt drama about family and self-discovery.'),
(209, 'Journey to the Forgotten Land', '2021-12-05', '2021-12-25', 'Lila Osman', 2.2, 'PG-13', 'An epic fantasy tale following a group of adventurers on a quest.'),
(210, 'Darkness Falls', '2019-10-25', '2019-11-01', 'Derek Mullins', 5, 'NC-17', 'A horror thriller featuring intense psychological elements.');


# Data for shows 

INSERT INTO shows (id, title, premier_date, upcoming_release_date, seasons, episodes, rating, age_rating, showrunner, information) VALUES
(301, 'Galactic Adventures', '2022-03-15', '2024-03-15', 2, 20, 4.7, 'PG', 'Liam Hudson', 'A sci-fi series following a group of explorers venturing into unknown galaxies.'),
(302, 'Secrets of the Mind', '2021-09-10', NULL, 4, 48, 5, 'PG-13', 'Maya Lin', 'A psychological thriller series that dives deep into mysteries surrounding human consciousness.'),
(303, 'Haunted Legends', '2023-01-13', '2024-01-12', 1, 10, 5, 'R', 'Oliver Reyes', 'A horror anthology series based on supernatural folklore from around the world.'),
(304, 'Starlit Hearts', '2020-06-20', NULL, 5, 60, 3.7, 'PG', 'Emma Thompson', 'A romantic drama series that explores love stories set in different eras and locations.'),
(305, 'Action Heroes', '2023-07-01', NULL, 2, 24, 4.3, 'PG-13', 'David Lee', 'An action-packed show following elite fighters who save the world from looming threats.'),
(306, 'Mystery at Maplewood', '2022-11-01', NULL, 3, 36, 3.9, 'PG', 'Sara Nguyen', 'A mystery series involving a small-town detective solving puzzling cases.'),
(307, 'Tales of Destiny', '2021-08-05', NULL, 4, 40, 4.2, 'PG-13', 'Carlos Ortega', 'A fantasy series where heroes from different realms unite to fight a dark force.'),
(308, 'Real Life Chronicles', '2022-04-22', '2024-04-20', 1, 8, 4.8, 'PG', 'Nina Carter', 'A heartfelt drama series that depicts real-life challenges and triumphs of various individuals.'),
(309, 'The Cosmic Frontier', '2019-05-05', NULL, 6, 72, 5, 'PG-13', 'Harold Becker', 'A science fiction show chronicling mankind’s journey to new planets and beyond.'),
(310, 'Urban Myths Uncovered', '2021-10-25', NULL, 3, 30, 5, 'R', 'Fiona Adams', 'A horror series examining urban legends and uncovering their origins.');



# Data for Users 

INSERT INTO users (id, name, email, registration_date) VALUES
(401, 'Alice Johnson', 'alice.johnson@example.com', '2023-01-15'),
(402, 'Bob Smith', 'bob.smith@example.com', '2023-02-20'),
(403, 'Carol White', 'carol.white@example.com', '2023-03-05'),
(404, 'David Brown', 'david.brown@example.com', '2023-04-10'),
(405, 'Eve Black', 'eve.black@example.com', '2023-05-18'),
(406, 'Frank Green', 'frank.green@example.com', '2023-06-22'),
(407, 'Grace Lee', 'grace.lee@example.com', '2023-07-30'),
(408, 'Henry Adams', 'henry.adams@example.com', '2023-08-15'),
(409, 'Ivy Clark', 'ivy.clark@example.com', '2023-09-12'),
(410, 'Jack White', 'jack.white@example.com', '2023-10-01'),
(411, 'Karen Taylor', 'karen.taylor@example.com', '2023-10-18'),
(412, 'Leo Martin', 'leo.martin@example.com', '2023-11-02'),
(413, 'Mia Wilson', 'mia.wilson@example.com', '2023-11-15'),
(414, 'Noah Scott', 'noah.scott@example.com', '2023-12-03'),
(415, 'Olivia Perez', 'olivia.perez@example.com', '2023-12-10');


# Data for Locations 

INSERT INTO locations (id, name, address, venueURL, capacity, type, information) VALUES
(501, 'Grand Cinema Complex', '1234 Elm St, Springfield, VA', 'http://grandcinema.com', 300, 'Movie Theater', 'A state-of-the-art cinema with IMAX and 3D screens.'),
(502, 'Heritage Convention Center', '5678 Oak Ave, Fairfax, VA', 'http://heritageconvention.com', 1200, 'Convention Hall', 'Popular for film conventions and large events.'),
(503, 'Downtown Theater', '910 Pine Rd, Arlington, VA', 'http://downtowntheater.com', 200, 'Movie Theater', 'A cozy theater specializing in indie films.'),
(504, 'Capitol Event Hall', '11 Capitol Way, Richmond, VA', 'http://capitoleventhall.com', 1000, 'Convention Hall', 'Hosts various entertainment events and premieres.'),
(505, 'Cinema World', '22 Cinema Ln, Alexandria, VA', 'http://cinemaworld.com', 450, 'Movie Theater', 'Known for luxurious seating and gourmet concessions.'),
(506, 'Open Air Plaza', '33 Park St, Roanoke, VA', NULL, 150, 'Other', 'An outdoor venue perfect for summer movie screenings.'),
(507, 'Cultural Arts Center', '44 Art Blvd, Charlottesville, VA', 'http://culturalartscenter.com', 800, 'Convention Hall', 'Features exhibitions, performances, and film screenings.'),
(508, 'Lakeside Pavilion', '55 Lakeview Dr, Norfolk, VA', NULL, 250, 'Other', 'An open-air venue ideal for local community events and festivals.');


# Data for casts 

INSERT INTO casts (id, name, dateofbirth, hometown, information) VALUES
(601, 'Emma Stone', '1988-11-06', 'Scottsdale, AZ', 'Known for her versatility and roles in drama and comedy.'),
(602, 'Robert Downey Jr.', '1965-04-04', 'New York, NY', 'Famous for his role as Iron Man in the Marvel Cinematic Universe.'),
(603, 'Scarlett Johansson', '1984-11-22', 'New York, NY', 'One of the highest-grossing actresses of all time, known for action and drama.'),
(604, 'Chris Evans', '1981-06-13', 'Boston, MA', 'Widely recognized as Captain America.'),
(605, 'Jennifer Lawrence', '1990-08-15', 'Louisville, KY', 'Academy Award winner known for roles in both indie films and blockbusters.'),
(606, 'Dwayne Johnson', '1972-05-02', 'Hayward, CA', 'Popular for action movies and as a former WWE star.'),
(607, 'Gal Gadot', '1985-04-30', 'Rosh HaAyin, Israel', 'Best known for her role as Wonder Woman.'),
(608, 'Tom Hanks', '1956-07-09', 'Concord, CA', 'Academy Award-winning actor known for diverse roles.'),
(609, 'Natalie Portman', '1981-06-09', 'Jerusalem, Israel', 'Academy Award winner known for both dramatic and sci-fi roles.'),
(610, 'Samuel L. Jackson', '1948-12-21', 'Washington, D.C.', 'Known for his iconic voice and numerous roles in action films.'),
(611, 'Leonardo DiCaprio', '1974-11-11', 'Los Angeles, CA', 'Academy Award-winning actor known for dramatic and environmental activism.'),
(612, 'Margot Robbie', '1990-07-02', 'Dalby, Australia', 'Famous for her roles in both independent films and big-budget productions.'),
(613, 'Zendaya', '1996-09-01', 'Oakland, CA', 'Gained prominence for her roles in teen dramas and action films.'),
(614, 'Ryan Reynolds', '1976-10-23', 'Vancouver, Canada', 'Known for his humor and roles in both action and comedy films.'),
(615, 'Keanu Reeves', '1964-09-02', 'Beirut, Lebanon', 'Loved worldwide for his roles in action and sci-fi films and humble personality.'),
(616, 'Hugh Jackman', '1968-10-12', 'Sydney, Australia', 'Known for his role as Wolverine in the X-Men series and acclaimed musical performances.'),
(617, 'Matt Damon', '1970-10-08', 'Cambridge, MA', 'Famous for roles in films such as Good Will Hunting and the Bourne series.'),
(618, 'Jared Leto', '1971-12-26', 'Bossier City, LA', 'Known for his versatility in acting and as the lead singer of Thirty Seconds to Mars.'),
(619, 'Daniel Craig', '1968-03-02', 'Chester, England', 'Best known for portraying James Bond in several films.'),
(620, 'Chris Hemsworth', '1983-08-11', 'Melbourne, Australia', 'Famous for his role as Thor in the Marvel Cinematic Universe.'),
(621, 'Vin Diesel', '1967-07-18', 'Alameda, CA', 'Known for his role as Dominic Toretto in the Fast & Furious franchise.'),
(622, 'Tom Hardy', '1977-09-15', 'Hammersmith, London, England', 'Recognized for his intense performances in films like Mad Max: Fury Road and Inception.');


# Data for Reviews 

INSERT INTO reviews (rating, comments, user_id, movie_id, show_id) VALUES
(5, 'An absolute masterpiece! The visuals and story were breathtaking.', 401, 201, NULL),
(4, 'Great thriller with an unexpected twist. Kept me on the edge of my seat.', 402, 202, NULL),
(3, 'Not bad, but felt a bit dragged at times.', 403, NULL, 301),
(4, 'Loved the world-building and character development. Can’t wait for more seasons.', 404, NULL, 309),
(5, 'Scary and thrilling! One of the best horror shows I’ve watched.', 405, NULL, 303),
(2, 'Couldn’t really connect with the story. Not for me.', 406, 204, NULL),
(4, 'A fun adventure, perfect for family movie night.', 407, 203, NULL),
(3, 'The romance was a bit clichéd, but still enjoyable.', 408, NULL, 304),
(5, 'Amazing action sequences and plot twists!', 409, NULL, 305),
(4, 'A touching story with a lot of depth. Highly recommended.', 410, NULL, 308),
(5, 'Incredible documentary, learned so much about history.', 411, 205, NULL),
(3, 'Some episodes were great, but a few fell flat.', 412, NULL, 306),
(5, 'One of the best shows I’ve ever seen. Deeply moving.', 413, NULL, 307),
(4, 'Intense and packed with action. Would recommend.', 414, 206, NULL),
(2, 'Didn’t live up to the hype. Expected more from the storyline.', 415, NULL, 302);

# Data for events 

INSERT INTO events (id, name, date, description, age_rating, information) VALUES
(701, 'Summer Film Festival', '2024-06-15', 'A week-long festival showcasing independent films from around the world.', 'PG', 'Join us for screenings, panels, and Q&As with filmmakers.'),
(702, 'Horror Movie Night', '2023-10-31', 'A night of terrifying films and chilling atmosphere for horror fans.', 'R', 'Prepare for some scares with classic and new horror films.'),
(703, 'Annual Comic Con', '2024-04-20', 'A convention for fans of comic books, movies, and pop culture.', 'PG-13', 'Meet creators, attend panels, and explore a wide range of merchandise.'),
(704, 'Classic Film Retrospective', '2024-08-10', 'Screening of classic films with discussions on their impact on cinema.', 'G', 'Enjoy timeless classics with insights from film experts.'),
(705, 'Family Movie Day', '2024-05-01', 'A day of fun family-friendly films and activities for kids.', 'G', 'Bring the whole family for an enjoyable day at the movies!'),
(706, 'Celebrity Meet and Greet', '2024-09-15', 'An exclusive event to meet popular actors and filmmakers.', 'PG-13', 'Get autographs, take photos, and ask questions in a special setting.'),
(707, 'Film and Food Festival', '2024-11-20', 'A unique festival combining films and gourmet food experiences.', 'PG', 'Enjoy films and delicious food pairings from local chefs.'),
(708, 'The Great Outdoors Film Screening', '2024-07-04', 'A celebration of nature films and documentaries.', 'G', 'Experience the beauty of nature through the lens of film.'),
(709, 'Indie Film Night', '2024-03-15', 'Showcasing new and emerging filmmakers in the indie scene.', 'PG-13', 'Support independent cinema and discover new talent.'),
(710, 'Seasonal Movie Marathon', '2024-12-10', 'A marathon of seasonal films to get you in the holiday spirit.', 'G', 'Join us for a cozy day of classic holiday films.');


# Data for movie_cast 

INSERT INTO movie_cast (movie_id, cast_id, role) VALUES
(201, 601, 'Lead Actress'), 
(201, 604, 'Supporting Actor'), 
(202, 602, 'Lead Actor'), 
(202, 606, 'Supporting Actor'),  
(203, 608, 'Lead Actor'), 
(203, 605, 'Supporting Actress'),  
(204, 607, 'Lead Actress'), 
(204, 609, 'Supporting Actress'), 
(205, 610, 'Supporting Actor'),  
(205, 611, 'Lead Actor'),  
(206, 612, 'Lead Actress'), 
(206, 613, 'Supporting Actress'), 
(207, 614, 'Lead Actor'),  
(207, 615, 'Supporting Actor'), 
(208, 615, 'Lead Actor'),
(208, 601, 'Lead Actress'),
(209, 602, 'Supporting Actor'),
(209, 603, 'Supporting Actress'),
(210, 604, 'Supporting Actress'),
(210, 605, 'Supporting Actress');


# Data for show_cast

INSERT INTO show_cast (show_id, cast_id, role) VALUES
(301, 601, 'Lead Actress'),         
(301, 603, 'Supporting Actress'), 
(301, 604, 'Cameo'),
(302, 602, 'Lead Actor'),
(302, 605, 'Supporting Actress'),
(302, 611, 'Recurring Role'),
(303, 606, 'Lead Actor'),
(303, 612, 'Supporting Actress'),
(303, 615, 'Cameo'),
(304, 607, 'Lead Actress'),
(304, 610, 'Supporting Actor'),
(304, 616, 'Recurring Role'),
(305, 613, 'Lead Actress'),
(305, 614, 'Supporting Actor'),
(305, 618, 'Guest Star'),
(306, 609, 'Lead Actress'),
(306, 617, 'Supporting Actor'),
(306, 619, 'Cameo'),
(307, 620, 'Lead Actor'),
(307, 621, 'Supporting Actor'),
(307, 622, 'Villain');


# Data for cast_events

INSERT INTO cast_events (cast_id, event_id) VALUES
(601, 701),
(602, 702),
(603, 703),
(604, 704),
(605, 705),
(606, 706),
(607, 707),
(608, 708),
(609, 709), 
(610, 710);


# Data for movie_events 

-- Summer Film Festival
INSERT INTO movie_events (movie_id, event_id) VALUES
(201, 701),  -- The Silent Horizon at Summer Film Festival
(203, 701),  -- A Galactic Journey at Summer Film Festival
(207, 701),  -- Mystery at Sunset Beach at Summer Film Festival
(208, 701);  -- The Child Within at Summer Film Festival

-- Horror Movie Night
INSERT INTO movie_events (movie_id, event_id) VALUES
(202, 702),  -- Whispers in the Woods at Horror Movie Night
(206, 702),  -- The Final Stand at Horror Movie Night
(210, 702);  -- Darkness Falls at Horror Movie Night

-- Annual Comic Con
INSERT INTO movie_events (movie_id, event_id) VALUES
(201, 703),  -- The Silent Horizon at Annual Comic Con
(204, 703),  -- Love Beyond the Stars at Annual Comic Con
(209, 703);  -- Journey to the Forgotten Land at Annual Comic Con

-- Classic Film Retrospective
INSERT INTO movie_events (movie_id, event_id) VALUES
(205, 704),  -- Echoes of the Past at Classic Film Retrospective
(206, 704);  -- The Final Stand at Classic Film Retrospective

-- Family Movie Day
INSERT INTO movie_events (movie_id, event_id) VALUES
(205, 705),  -- Echoes of the Past at Family Movie Day
(206, 705);  -- The Final Stand at Family Movie Day

-- Celebrity Meet and Greet
INSERT INTO movie_events (movie_id, event_id) VALUES
(201, 706),  -- The Silent Horizon at Celebrity Meet and Greet
(204, 706),  -- Love Beyond the Stars at Celebrity Meet and Greet
(209, 706);  -- Journey to the Forgotten Land at Celebrity Meet and Greet

-- Film and Food Festival
INSERT INTO movie_events (movie_id, event_id) VALUES
(201, 707),  -- The Silent Horizon at Film and Food Festival
(207, 707),  -- Mystery at Sunset Beach at Film and Food Festival
(208, 707),  -- The Child Within at Film and Food Festival
(203, 707);  -- A Galactic Journey at Film and Food Festival

-- The Great Outdoors Film Screening
INSERT INTO movie_events (movie_id, event_id) VALUES
(205, 708);  -- Echoes of the Past at The Great Outdoors Film Screening

-- Indie Film Night
INSERT INTO movie_events (movie_id, event_id) VALUES
(202, 709),  -- Whispers in the Woods at Indie Film Night
(209, 709);  -- Journey to the Forgotten Land at Indie Film Night

-- Seasonal Movie Marathon
INSERT INTO movie_events (movie_id, event_id) VALUES
(205, 710);  -- Echoes of the Past at Seasonal Movie Marathon


# Data for show_events

-- Annual Comic Con (PG-13-rated)
INSERT INTO show_events (show_id, event_id) VALUES
(302, 703),  -- Secrets of the Mind at Annual Comic Con
(305, 703),  -- Action Heroes at Annual Comic Con
(307, 703),  -- Tales of Destiny at Annual Comic Con
(309, 703);  -- The Cosmic Frontier at Annual Comic Con

-- Celebrity Meet and Greet (PG-13-rated)
INSERT INTO show_events (show_id, event_id) VALUES
(302, 706),  -- Secrets of the Mind at Celebrity Meet and Greet
(305, 706),  -- Action Heroes at Celebrity Meet and Greet
(307, 706),  -- Tales of Destiny at Celebrity Meet and Greet
(309, 706);  -- The Cosmic Frontier at Celebrity Meet and Greet

-- Film and Food Festival (PG-rated)
INSERT INTO show_events (show_id, event_id) VALUES
(301, 707),  -- Galactic Adventures at Film and Food Festival
(304, 707),  -- Starlit Hearts at Film and Food Festival
(306, 707),  -- Mystery at Maplewood at Film and Food Festival
(308, 707);  -- Real Life Chronicles at Film and Food Festival



# data for movie_genre

INSERT INTO movie_genre (movie_id, genre_id) VALUES
(201, 102),
(202, 103),
(203, 101),
(204, 104),
(205, 102),
(206, 105),
(207, 106),
(208, 107),
(209, 108),
(210, 103);


# data for show_genre

INSERT INTO show_genre (show_id, genre_id) VALUES
(301, 101),
(302, 102),
(303, 103),
(304, 104),
(305, 105),
(306, 106),
(307, 108),
(308, 107),
(309, 101),
(310, 103);


# data for event_location

INSERT INTO event_location (event_id, location_id) VALUES 
(701, 506), 
(702, 503),
(703, 504),
(704, 505),
(705, 508),
(706, 502),
(707, 501),
(708, 506),
(709, 503),
(710, 501);
COMMIT;
