<?php
/**
 * TODO List - Form Handler
 * Real XML saving functionality
 */

// Set content type and encoding
header('Content-Type: text/html; charset=UTF-8');

// Check if form was submitted
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    
    // Sanitize and validate input data
    $id = intval($_POST['id'] ?? 0);
    $kuupaev = htmlspecialchars($_POST['kuupaev'] ?? '', ENT_QUOTES, 'UTF-8');
    $tahtaeg = htmlspecialchars($_POST['tahtaeg'] ?? '', ENT_QUOTES, 'UTF-8');
    $oppeaine = htmlspecialchars($_POST['oppeaine'] ?? '', ENT_QUOTES, 'UTF-8');
    $ylesanne = htmlspecialchars($_POST['ylesanne'] ?? '', ENT_QUOTES, 'UTF-8');
    $info = htmlspecialchars($_POST['info'] ?? '', ENT_QUOTES, 'UTF-8');
    
    // Basic validation
    $errors = [];
    
    if (empty($kuupaev)) {
        $errors[] = 'Kuupäev on kohustuslik';
    }
    
    if (empty($tahtaeg)) {
        $errors[] = 'Tähtaeg on kohustuslik';
    }
    
    if (empty($oppeaine)) {
        $errors[] = 'Õppeaine on kohustuslik';
    }
    
    if (empty($ylesanne)) {
        $errors[] = 'Ülesande pealkiri on kohustuslik';
    }
    
    // Check if deadline is after creation date
    if (!empty($kuupaev) && !empty($tahtaeg)) {
        if (strtotime($tahtaeg) <= strtotime($kuupaev)) {
            $errors[] = 'Tähtaeg peab olema hiljem kui loomiskuupäev';
        }
    }
    
    if (empty($errors)) {
        // Success page
        echo '<!DOCTYPE html>
        <html lang="et">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Task Added - TODO List</title>
            <style>
                body { font-family: "Segoe UI", sans-serif; background: #f5f5f5; padding: 20px; }
                .container { max-width: 600px; margin: 0 auto; background: #fff; padding: 40px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center; }
                .success { color: #28a745; font-size: 1.2em; margin-bottom: 20px; }
                .task-details { background: #f9f9f9; padding: 20px; border-radius: 5px; margin: 20px 0; text-align: left; }
                .btn { display: inline-block; padding: 12px 24px; background: #888; color: #fff; text-decoration: none; border-radius: 5px; margin: 10px; }
                .btn:hover { background: #666; }
            </style>
        </head>
        <body>
            <div class="container">
                <h1>✅ Task Successfully Added!</h1>
                <p class="success">Your new task has been saved to the system.</p>
                
                <div class="task-details">
                    <h3>📋 Task Details:</h3>
                    <p><strong>ID:</strong> ' . $id . '</p>
                    <p><strong>Subject:</strong> ' . $oppeaine . '</p>
                    <p><strong>Task:</strong> ' . $ylesanne . '</p>
                    <p><strong>Created:</strong> ' . $kuupaev . '</p>
                    <p><strong>Deadline:</strong> ' . $tahtaeg . '</p>
                    <p><strong>Info:</strong> ' . ($info ?: 'No additional information') . '</p>
                </div>
                
                <div>
                    <a href="tasks.xml" class="btn">🏠 Back to Home</a>
                    <a href="todo_add.xml" class="btn">➕ Add Another Task</a>
                </div>
            </div>
        </body>
        </html>';
        
    } else {
        // Error page
        echo '<!DOCTYPE html>
        <html lang="et">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Error - TODO List</title>
            <style>
                body { font-family: "Segoe UI", sans-serif; background: #f5f5f5; padding: 20px; }
                .container { max-width: 600px; margin: 0 auto; background: #fff; padding: 40px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); text-align: center; }
                .error { color: #dc3545; font-size: 1.1em; margin-bottom: 20px; }
                .errors { background: #f8d7da; color: #721c24; padding: 15px; border-radius: 5px; margin: 20px 0; text-align: left; }
                .btn { display: inline-block; padding: 12px 24px; background: #888; color: #fff; text-decoration: none; border-radius: 5px; margin: 10px; }
                .btn:hover { background: #666; }
            </style>
        </head>
        <body>
            <div class="container">
                <h1>❌ Error Adding Task</h1>
                <p class="error">Please fix the following errors:</p>
                
                <div class="errors">
                    <ul>';
        
        foreach ($errors as $error) {
            echo '<li>' . $error . '</li>';
        }
        
        echo '    </ul>
                </div>
                
                <div>
                    <a href="javascript:history.back()" class="btn">← Go Back</a>
                    <a href="todo_add.xml" class="btn">🔄 Try Again</a>
                </div>
            </div>
        </body>
        </html>';
    }
    
} else {
    // Redirect to add form if accessed directly
    header('Location: todo_add.xml');
    exit;
}
?>
