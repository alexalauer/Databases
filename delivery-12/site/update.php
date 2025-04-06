<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Movie</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f8ff; /* Soft blue background for readability */
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
        <h1 class="text-center mb-4">Update a Movie</h1>
        <form method="POST" action="update.php" class="p-4 bg-white shadow rounded">
            <div class="mb-3">
                <label for="id" class="form-label">Movie ID</label>
                <input type="number" name="id" id="id" class="form-control" placeholder="Enter the Movie ID to update" required>
            </div>
            <div class="mb-3">
                <label for="title" class="form-label">New Title</label>
                <input type="text" name="title" id="title" class="form-control" placeholder="Enter the new title">
            </div>
            <div class="mb-3">
                <label for="public_release_date" class="form-label">New Public Release Date</label>
                <input type="date" name="public_release_date" id="public_release_date" class="form-control">
            </div>
            <div class="mb-3">
                <label for="theater_release_date" class="form-label">New Theater Release Date</label>
                <input type="date" name="theater_release_date" id="theater_release_date" class="form-control">
            </div>
            <div class="mb-3">
                <label for="rating" class="form-label">New Rating (1-5)</label>
                <input type="number" name="rating" id="rating" class="form-control" placeholder="Enter the new rating (1-5)" min="1" max="5">
            </div>
            <div class="mb-3">
                <label for="age_rating" class="form-label">New Age Rating</label>
                <select name="age_rating" id="age_rating" class="form-control">
                    <option value="">Select an Age Rating</option>
                    <option value="G">G</option>
                    <option value="PG">PG</option>
                    <option value="PG-13">PG-13</option>
                    <option value="R">R</option>
                    <option value="NC-17">NC-17</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="director" class="form-label">New Director</label>
                <input type="text" name="director" id="director" class="form-control" placeholder="Enter the new director">
            </div>
            <div class="mb-3">
                <label for="information" class="form-label">New Information</label>
                <textarea name="information" id="information" class="form-control" rows="3" placeholder="Enter any additional information"></textarea>
            </div>
            <button type="submit" class="btn btn-primary w-100">Update Movie</button>
        </form>

        <?php
        require 'db.php';

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $id = $_POST['id'];

            // Check if the movie exists
            $checkStmt = $pdo->prepare("SELECT * FROM movies WHERE id = :id");
            $checkStmt->execute(['id' => $id]);
            $movie = $checkStmt->fetch();

            if ($movie) {
                // Build the update query dynamically
                $fields = [];
                $params = ['id' => $id];

                if (!empty($_POST['title'])) {
                    $fields[] = "title = :title";
                    $params['title'] = $_POST['title'];
                }
                if (!empty($_POST['public_release_date'])) {
                    $fields[] = "public_release_date = :public_release_date";
                    $params['public_release_date'] = $_POST['public_release_date'];
                }
                if (!empty($_POST['theater_release_date'])) {
                    $fields[] = "theater_release_date = :theater_release_date";
                    $params['theater_release_date'] = $_POST['theater_release_date'];
                }
                if (!empty($_POST['rating'])) {
                    $fields[] = "rating = :rating";
                    $params['rating'] = $_POST['rating'];
                }
                if (!empty($_POST['age_rating'])) {
                    $fields[] = "age_rating = :age_rating";
                    $params['age_rating'] = $_POST['age_rating'];
                }
                if (!empty($_POST['director'])) {
                    $fields[] = "director = :director";
                    $params['director'] = $_POST['director'];
                }
                if (!empty($_POST['information'])) {
                    $fields[] = "information = :information";
                    $params['information'] = $_POST['information'];
                }

                if (!empty($fields)) {
                    $query = "UPDATE movies SET " . implode(', ', $fields) . " WHERE id = :id";
                    $stmt = $pdo->prepare($query);
                    $stmt->execute($params);
                    echo "<div class='alert alert-success mt-4'>Movie with ID {$id} has been successfully updated.</div>";
                } else {
                    echo "<div class='alert alert-warning mt-4'>No updates were provided.</div>";
                }
            } else {
                echo "<div class='alert alert-danger mt-4'>No movie found with ID {$id}.</div>";
            }
        }
        ?>
    </div>
</body>
</html>

