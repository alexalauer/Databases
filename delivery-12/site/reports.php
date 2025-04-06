
<?php
include 'db.php'; // Include database connection

// Initialize variables
$queryOptions = [];
$selectedQuery = '';
$results = [];

// Process the `$queries` array
$queries = [
    "General Queries" => [
        "Retrieve all movies with a rating above 4" => "SELECT title, rating FROM movies WHERE rating > 4;",
        "List all upcoming shows with their premiere date" => "SELECT title, premier_date FROM shows WHERE upcoming_release_date IS NOT NULL;",
        "Display all genres and the number of movies associated with each" => "SELECT g.name AS genre, COUNT(mg.movie_id) AS movie_count FROM genres g LEFT JOIN movie_genre mg ON g.id = mg.genre_id GROUP BY g.id, g.name;",
        "Find movies released in the past year" => "SELECT title, public_release_date FROM movies WHERE public_release_date > CURRENT_DATE - INTERVAL 1 YEAR;",
        "List shows with the highest rating" => "SELECT title, rating FROM shows WHERE rating = (SELECT MAX(rating) FROM shows);"
    ],
    "User Queries" => [
        "Retrieve reviews given by a specific user" => "SELECT r.rating, r.comments, COALESCE(m.title, 'NA') AS movie_title, COALESCE(s.title, 'NA') AS show_title FROM reviews r LEFT JOIN movies m ON r.movie_id = m.id LEFT JOIN shows s ON r.show_id = s.id WHERE r.user_id = 403;",
        "Find the user's registration date and how long they’ve been registered" => "SELECT name, registration_date, DATEDIFF(CURRENT_DATE, registration_date) AS days_registered FROM users WHERE id = 405;",
        "Display all users who have given ratings of 5" => "SELECT u.name, r.rating, COALESCE(m.title, 'NA') AS movie_title, COALESCE(s.title, 'NA') AS show_title FROM users u JOIN reviews r ON u.id = r.user_id LEFT JOIN movies m ON r.movie_id = m.id LEFT JOIN shows s ON r.show_id = s.id WHERE r.rating = 5;",
        "Find users who have registered in the last month" => "SELECT name, email, registration_date FROM users WHERE registration_date > CURRENT_DATE - INTERVAL 1 MONTH;"
    ],
    "Admin Queries" => [
        "Identify events that exceed the venue's capacity" => "SELECT e.name AS event_name, l.name AS venue_name, l.capacity FROM events e JOIN event_location el ON e.id = el.event_id JOIN locations l ON el.location_id = l.id WHERE l.capacity < (SELECT COUNT(*) FROM cast_events ce WHERE ce.event_id = e.id);",
        "Find locations hosting more than 5 events" => "SELECT l.name, COUNT(el.event_id) AS event_count FROM locations l JOIN event_location el ON l.id = el.location_id GROUP BY l.id, l.name HAVING COUNT(el.event_id) > 5;",
        "List all movies without any reviews" => "SELECT title FROM movies WHERE id NOT IN (SELECT DISTINCT movie_id FROM reviews);"
    ],
    "Exploration Queries" => [
        "Get all movies and shows by a specific genre" => "SELECT m.title AS movie_title, s.title AS show_title FROM genres g LEFT JOIN movie_genre mg ON g.id = mg.genre_id LEFT JOIN movies m ON mg.movie_id = m.id LEFT JOIN show_genre sg ON g.id = sg.genre_id LEFT JOIN shows s ON sg.show_id = s.id WHERE g.name = 'Action';",
        "Find the most common roles played by cast members" => "SELECT role, COUNT(*) AS occurrences FROM (SELECT role FROM movie_cast UNION ALL SELECT role FROM show_cast) roles GROUP BY role ORDER BY occurrences DESC;",
        "Find shows with more than 5 seasons" => "SELECT title, seasons FROM shows WHERE seasons > 5;",
        "Retrieve movies and their directors released after 2020" => "SELECT title, director FROM movies WHERE public_release_date > '2020-01-01';"
    ],
    "Event-Specific Queries" => [
        "List all events happening at a specific location" => "SELECT e.name, e.date, l.name AS location_name FROM events e JOIN event_location el ON e.id = el.event_id JOIN locations l ON el.location_id = l.id WHERE l.name = 'Heritage Convention Center';",
        "Retrieve events associated with a specific movie" => "SELECT e.name AS event_name, e.date FROM events e JOIN movie_events me ON e.id = me.event_id WHERE me.movie_id = 203;",
        "Find all events scheduled in the next 30 days" => "SELECT name, date FROM events WHERE date BETWEEN CURRENT_DATE AND CURRENT_DATE + INTERVAL 30 DAY;",
        "List all events rated 'PG-13' or higher" => "SELECT name, age_rating FROM events WHERE age_rating IN ('PG-13', 'R', 'NC-17');"
    ],
    "Interaction Queries" => [
        "Retrieve all reviews for a movie or show" => "SELECT r.rating, r.comments, u.name AS user_name FROM reviews r JOIN users u ON r.user_id = u.id WHERE r.movie_id = 203 OR r.show_id = 308;",
        "List all cast members who participated in an event" => "SELECT c.name, e.name AS event_name FROM casts c JOIN cast_events ce ON c.id = ce.cast_id JOIN events e ON ce.event_id = e.id WHERE e.id = 705;",
        "Find users who have reviewed at least 3 movies" => "SELECT u.name, COUNT(r.id) AS review_count FROM users u JOIN reviews r ON u.id = r.user_id WHERE r.movie_id IS NOT NULL GROUP BY u.id, u.name HAVING COUNT(r.id) >= 3;"
    ]
];


// Handle form submission
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $selectedQuery = $_POST['query'];
    $queryOptions = explode('|', $selectedQuery);
    $queryGroup = $queryOptions[0];
    $queryKey = $queryOptions[1];

    // Execute the query
    if (isset($queries[$queryGroup][$queryKey])) {
        $sql = $queries[$queryGroup][$queryKey];
        $result = $conn->query($sql);

        // Fetch results
        if ($result && $result->num_rows > 0) {
            $results = $result->fetch_all(MYSQLI_ASSOC);
        }
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reports</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f8ff;
            color: white;
        }
        .container {
            background-color: white;
            color: black;
            border-radius: 8px;
            padding: 20px;
            margin-top: 20px;
        }
        .btn-home {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="index.php" class="btn btn-primary btn-home">Home</a>
        <h1 class="text-center mb-4">Reports</h1>
        <form method="POST" class="mb-4">
            <label for="query" class="form-label">Select a Query:</label>
            <select name="query" id="query" class="form-select">
                <option value="">-- Select a Query --</option>
                <?php foreach ($queries as $group => $groupQueries): ?>
                    <optgroup label="<?= htmlspecialchars($group) ?>">
                        <?php foreach ($groupQueries as $key => $sql): ?>
                            <option value="<?= htmlspecialchars($group . '|' . $key) ?>"
                                <?= $selectedQuery === ($group . '|' . $key) ? 'selected' : '' ?>>
                                <?= htmlspecialchars($key) ?>
                            </option>
                        <?php endforeach; ?>
                    </optgroup>
                <?php endforeach; ?>
            </select>
            <button type="submit" class="btn btn-primary mt-3">Run Query</button>
        </form>

        <!-- Display Results -->
        <?php if (!empty($results)): ?>
            <h2 class="mt-4">Query Results:</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <?php foreach (array_keys($results[0]) as $column): ?>
                            <th><?= htmlspecialchars($column) ?></th>
                        <?php endforeach; ?>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($results as $row): ?>
                        <tr>
                            <?php foreach ($row as $value): ?>
                                <td><?= htmlspecialchars($value) ?></td>
                            <?php endforeach; ?>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        <?php elseif ($_SERVER['REQUEST_METHOD'] === 'POST'): ?>
            <p class="text-danger">No results found for this query.</p>
        <?php endif; ?>
    </div>
</body>
</html>