<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Create Movie</title>
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
        <h1 class="text-center mb-4">Add a New Movie</h1>
        <form method="POST" action="create.php" class="p-4 bg-white shadow rounded">
            <div class="mb-3">
                <label for="id" class="form-label">Movie ID</label>
                <input type="number" name="id" id="id" class="form-control" placeholder="Enter a unique Movie ID" required>
            </div>
            <div class="mb-3">
                <label for="title" class="form-label">Title</label>
                <input type="text" name="title" id="title" class="form-control" placeholder="Enter the movie title" required>
            </div>
            <div class="mb-3">
                <label for="public_release_date" class="form-label">Public Release Date</label>
                <input type="date" name="public_release_date" id="public_release_date" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="theater_release_date" class="form-label">Theater Release Date (Optional)</label>
                <input type="date" name="theater_release_date" id="theater_release_date" class="form-control">
            </div>
            <div class="mb-3">
                <label for="rating" class="form-label">Rating (1-5)</label>
                <input type="number" name="rating" id="rating" class="form-control" placeholder="Enter the rating (1-5)" min="1" max="5">
            </div>
            <div class="mb-3">
                <label for="age_rating" class="form-label">Age Rating</label>
                <select name="age_rating" id="age_rating" class="form-control" required>
                    <option value="">Select an Age Rating</option>
                    <option value="G">G</option>
                    <option value="PG">PG</option>
                    <option value="PG-13">PG-13</option>
                    <option value="R">R</option>
                    <option value="NC-17">NC-17</option>
                </select>
            </div>
            <div class="mb-3">
                <label for="director" class="form-label">Director</label>
                <input type="text" name="director" id="director" class="form-control" placeholder="Enter the director's name">
            </div>
            <div class="mb-3">
                <label for="information" class="form-label">Additional Information</label>
                <textarea name="information" id="information" class="form-control" rows="3" placeholder="Enter any additional information"></textarea>
            </div>
            <button type="submit" class="btn btn-success w-100">Add Movie</button>
        </form>

        <?php
        require 'db.php';

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $id = $_POST['id'];
            $title = $_POST['title'];
            $public_release_date = $_POST['public_release_date'];
            $theater_release_date = $_POST['theater_release_date'] ?? null;
            $rating = $_POST['rating'] ?? null;
            $age_rating = $_POST['age_rating'];
            $director = $_POST['director'] ?? null;
            $information = $_POST['information'] ?? null;

            try {
                $stmt = $pdo->prepare("
                    INSERT INTO movies (id, title, public_release_date, theater_release_date, director, rating, age_rating, information)
                    VALUES (:id, :title, :public_release_date, :theater_release_date, :director, :rating, :age_rating, :information)
                ");
                $stmt->execute([
                    'id' => $id,
                    'title' => $title,
                    'public_release_date' => $public_release_date,
                    'theater_release_date' => $theater_release_date,
                    'director' => $director,
                    'rating' => $rating,
                    'age_rating' => $age_rating,
                    'information' => $information,
                ]);

                echo "<div class='alert alert-success mt-4'>Movie '{$title}' has been successfully added!</div>";
            } catch (PDOException $e) {
                if ($e->getCode() === '23000') {
                    echo "<div class='alert alert-danger mt-4'>A movie with ID '{$id}' already exists.</div>";
                } else {
                    echo "<div class='alert alert-danger mt-4'>An error occurred: " . $e->getMessage() . "</div>";
                }
            }
        }
        ?>
    </div>
</body>
</html>
