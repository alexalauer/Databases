# Upcoming Movies and TV Show Events 

# Table of Contents

- [Project Description](#project-description)
- [How to Run or Build This Project](#how-to-run-or-build-this-project)
- [How to Use This Project](#how-to-use-this-project)
- [Database Design](#database-design)
- [Contributions](#contributions)


## Project Overview

This project focuses on creating a comprehensive database that tracks upcoming movies and TV shows in Virginia, addressing the current gap in localized information. The database will connect various entities such as genres, reviews, users, locations, cast, and events to provide a cohesive view of the entertainment landscape. 

### Key Deliverables
- [Pitch Video](https://www.youtube.com/watch?v=0nnSMWsvWzw)
- [Design Video](https://www.youtube.com/watch?v=-BSVYq9oQi8)
- [GitHub Repository](https://github.com/cmsc-vcu/cmsc408-fa2024-proj-last-minute)
- [Final Video](https://www.youtube.com/watch?v=F0xzfBoDjA8)


## How to Run or Build This Project

### Deliverable 8 html

The project outline is built using Quarto. To generate the deliverable 8 HTML file from the Quarto Markdown (.qmd) file, use the following command in your terminal:

```bash
quarto render report/deliver-08.qmd

```
This command will produce an HTML file located in the 'report' folder 

### Deliverable 12 html

To generate the deliverable 12 HTML file from the Quarto Markdown (.qmd) file, use the following command in your terminal:

```bash
quarto render report/deliver-12.qmd

```

This command will produce an HTML file located in the 'report' folder

### Docker Compose Local Site

The website is built using a local connection to a database and docker compose. Compiling the folders will produce local website that has has the function described in the php files. 

To run docker compose, naviagte to the deliver-12 folder than run the following command in your terminal:

```bash
docker-compose up -d

```

# How to Use This Project

To view the assignment report, open the `deliver-08.html` and `deliver-12.html` files in a web browser. These files contains all necessary information, tasks, and examples related to the database design for upcoming movies and TV shows.

## Database Design

### Entity-Relationship Diagram (ERD)
The database includes several entities:
- **Movies**
- **TV Shows**
- **Genres**
- **Reviews**
- **Users**
- **Locations**
- **Cast**
- **Events**

And several linker tables:
- **Event_Location**
- **Show_Genre**
- **Movie_Genre**
- **Show_Events**
- **Movie_Events**

### Relational Schemas
- **Movies**: Attributes include Movie ID, Title, Release Dates, Theater Relase Date, Director, Rating, Age Rating, Special Information.
- **TV Shows**: Attributes include Show ID, Title, Premier Date, Upcoming Release Date, Seasons, Episodes, Rating, Age Rating, Showrunner, Special Information.
- **Genres**: Attributes include Genre ID, Name, Description.
- **Reviews**: Attributes include Review ID, Rating, Comments, User ID (FK), Movie ID (FK), Show ID (FK).
- **Users**: Attributes include User ID, Name, Email, Registration Date.
- **Locations**: Attributes include Location ID, Name, Address, Venue URL, Capacity, Type, Special Information.
- **Cast**: Attributes include Cast ID, Name, Date of Birth, Hometown, Special Information.
- **Events**: Attributes include Event ID, Name, Date, Description, Age Rating, Special Information.
- **Movie Cast**: Attributes include Movie Cast ID, Movie ID (FK), Role.
- **Show Cast**: Attributes include Show Cast ID, Show ID (FK), Cast ID (FK), Role. 
- **Cast Events**: Attributes include Cast Event ID, Cast ID (FK), Event ID (FK). 
- **Movie Events**: Attributes include Movie Event ID, Movie ID (FK), Event ID (FK). 
- **Show Events**: Attributes include Show Event ID, Show ID (FK), Event ID (FK).
- **Movie Genre**: Attributes include Movie Genre ID, Movie ID (FK), Genre ID (FK).
- **Show Genre**: Attributes include Show Gene ID, Show ID (FK), Genre ID (FK). 
- **Event Location**: Attributes include Event Location ID, Event ID (FK), Location ID (FK). 



## Contributions

- Team Member 1: Alexa Lauer
    
    email: lauera@vcu.edu





