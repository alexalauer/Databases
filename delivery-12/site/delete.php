<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Movie</title>
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
        <h1 class="text-center mb-4">Delete a Movie</h1>
        <form method="POST" action="delete.php" class="p-4 bg-white shadow rounded">
            <div class="mb-3">
                <label for="id" class="form-label">Movie ID</label>
                <input type="number" name="id" id="id" class="form-control" placeholder="Enter the Movie ID to delete" required>
            </div>
            <button type="submit" class="btn btn-danger w-100">Delete Movie</button>
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
                // Delete the movie
                $stmt = $pdo->prepare("DELETE FROM movies WHERE id = :id");
                $stmt->execute(['id' => $id]);
                echo "<div class='alert alert-success mt-4'>Movie with ID {$id} has been successfully deleted.</div>";
            } else {
                echo "<div class='alert alert-danger mt-4'>No movie found with ID {$id}.</div>";
            }
        }
        ?>
    </div>
</body>
</html>


