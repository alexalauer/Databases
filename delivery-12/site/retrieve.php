<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Movies</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f8ff; /* A soft blue tone for better readability */
        }
        .home-btn {
            position: fixed;
            top: 20px;
            right: 20px;
        }
    </style>
</head>
<body>
    <a href="index.php" class="btn btn-secondary home-btn">Home</a>
    <div class="container py-5">
        <h1 class="text-center mb-4">Movies</h1>
        <form method="GET" action="retrieve.php" class="mb-4">
            <div class="row">
                <div class="col-md-10">
                    <input type="text" name="filter" class="form-control" placeholder="Filter by title...">
                </div>
                <div class="col-md-2">
                    <button type="submit" class="btn btn-primary w-100">Filter</button>
                </div>
            </div>
        </form>
        <table class="table table-striped table-bordered shadow">
            <thead class="table-dark">
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Public Release Date</th>
                    <th>Theater Release Date</th>
                    <th>Rating</th>
                    <th>Age Rating</th>
                    <th>Director</th>
                    <th>Information</th>
                </tr>
            </thead>
            <tbody>
                <?php
                require 'db.php'; // Include the db.php to get the connection

                // Check if a filter is applied
                $query = isset($_GET['filter']) ? 
                    "SELECT * FROM movies WHERE title LIKE ?" : 
                    "SELECT * FROM movies";

                // Prepare and execute the query
                if ($stmt = $conn->prepare($query)) {
                    if (isset($_GET['filter'])) {
                        $filter = '%' . $_GET['filter'] . '%'; // Prepare the filter
                        $stmt->bind_param('s', $filter); // Bind the filter to the statement
                    }
                    $stmt->execute(); // Execute the statement

                    // Get the result
                    $result = $stmt->get_result();

                    // Fetch and display the movies
                    while ($movie = $result->fetch_assoc()) {
                        echo "<tr>
                            <td>{$movie['id']}</td>
                            <td>{$movie['title']}</td>
                            <td>{$movie['public_release_date']}</td>
                            <td>{$movie['theater_release_date']}</td>
                            <td>{$movie['rating']}</td>
                            <td>{$movie['age_rating']}</td>
                            <td>{$movie['director']}</td>
                            <td>{$movie['information']}</td>
                        </tr>";
                    }

                    // Close the statement
                    $stmt->close();
                } else {
                    echo "Error preparing the query.";
                }

                // Close the connection (optional)
                $conn->close();
                ?>
            </tbody>
        </table>
    </div>
</body>
</html>


