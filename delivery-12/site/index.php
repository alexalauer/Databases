<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Database Management</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f8ff; /* Soft blue background for readability */
        }
    </style>
</head>
<body>
    <div class="container py-5">
        <h1 class="text-center mb-4">Movie Database Management</h1>
        <div class="text-center mb-4">
            <p class="lead">Welcome to the Movie Database Management System! Use the options below to manage your database.</p>
        </div>
        <div class="row g-4">
            <!-- Link to Create Movie -->
            <div class="col-md-3">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <h5 class="card-title">Add a New Movie</h5>
                        <p class="card-text">Create a new movie record in the database.</p>
                        <a href="create.php" class="btn btn-success w-100">Create</a>
                    </div>
                </div>
            </div>
            <!-- Link to Retrieve Movies -->
            <div class="col-md-3">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <h5 class="card-title">View Movies</h5>
                        <p class="card-text">Browse, filter, and search movies in the database.</p>
                        <a href="retrieve.php" class="btn btn-primary w-100">View</a>
                    </div>
                </div>
            </div>
            <!-- Link to Update Movie -->
            <div class="col-md-3">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <h5 class="card-title">Update a Movie</h5>
                        <p class="card-text">Modify existing movie records in the database.</p>
                        <a href="update.php" class="btn btn-warning w-100">Update</a>
                    </div>
                </div>
            </div>
            <!-- Link to Delete Movie -->
            <div class="col-md-3">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <h5 class="card-title">Delete a Movie</h5>
                        <p class="card-text">Remove movie records from the database.</p>
                        <a href="delete.php" class="btn btn-danger w-100">Delete</a>
                    </div>
                </div>
            </div>
            <!-- Link to Reports -->
            <div class="col-md-3">
                <div class="card h-100">
                    <div class="card-body text-center">
                        <h5 class="card-title">Generate Reports</h5>
                        <p class="card-text">View detailed reports and insights about the movies.</p>
                        <a href="reports.php" class="btn btn-info w-100">Reports</a>
                    </div>
                </div>
            </div>
        </div>
        <footer class="mt-5 text-center">
            <p class="text-muted">Movie Database Management System &copy; <?= date('Y'); ?></p>
        </footer>
    </div>
</body>
</html>
