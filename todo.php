<?php
/**
 * TODO List - Vormi töötleja
 * Reaalne XML salvestamise funktsioon
 */

// Määra sisu tüüp ja kodeering
header("Content-Type: text/html; charset=UTF-8");

// Kontrolli, kas vorm on esitatud
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    // Puhasta ja valideeri sisendandmed
    $id = intval($_POST["id"] ?? 0);
    $kuupaev = htmlspecialchars($_POST["kuupaev"] ?? "", ENT_QUOTES, "UTF-8");
    $tahtaeg = htmlspecialchars($_POST["tahtaeg"] ?? "", ENT_QUOTES, "UTF-8");
    $oppeaine = htmlspecialchars($_POST["oppeaine"] ?? "", ENT_QUOTES, "UTF-8");
    $ylesanne = htmlspecialchars($_POST["ylesanne"] ?? "", ENT_QUOTES, "UTF-8");
    $info = htmlspecialchars($_POST["info"] ?? "", ENT_QUOTES, "UTF-8");

    // Põhiline valideerimine
    $errors = [];

    if (empty($kuupaev)) {
        $errors[] = "Kuupäev on kohustuslik";
    }

    if (empty($tahtaeg)) {
        $errors[] = "Tähtaeg on kohustuslik";
    }

    if (empty($oppeaine)) {
        $errors[] = "Õppeaine on kohustuslik";
    }

    if (empty($ylesanne)) {
        $errors[] = "Ülesande pealkiri on kohustuslik";
    }

    // Check if deadline is after creation date
    if (!empty($kuupaev) && !empty($tahtaeg)) {
        if (strtotime($tahtaeg) <= strtotime($kuupaev)) {
            $errors[] = "Tähtaeg peab olema hiljem kui loomiskuupäev";
        }
    }

    if (empty($errors)) {
        // Edukas leht
        echo '<!DOCTYPE html>
        <html lang="et">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Ülesanne lisatud - TODO List</title>
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
                <h1>Ülesanne edukalt lisatud!</h1>
                <p class="success">Teie uus ülesanne on süsteemi salvestatud.</p>

                <div class="task-details">
                    <h3>Ülesande üksikasjad:</h3>
                    <p><strong>ID:</strong> ' .
            $id .
            '</p>
                    <p><strong>Õppeaine:</strong> ' .
            $oppeaine .
            '</p>
                    <p><strong>Ülesanne:</strong> ' .
            $ylesanne .
            '</p>
                    <p><strong>Loodud:</strong> ' .
            $kuupaev .
            '</p>
                    <p><strong>Tähtaeg:</strong> ' .
            $tahtaeg .
            '</p>
                    <p><strong>Info:</strong> ' .
            ($info ?: "Lisainfot pole") .
            '</p>
                </div>

                <div>
                    <a href="tasks.xml" class="btn">Tagasi avalehele</a>
                    <a href="todo_add.xml" class="btn">Lisa veel ülesanne</a>
                </div>
            </div>
        </body>
        </html>';
    } else {
        // Vealeht
        echo '<!DOCTYPE html>
        <html lang="et">
        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Viga - TODO List</title>
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
                <h1>Viga ülesande lisamisel</h1>
                <p class="error">Palun parandage järgmised vead:</p>

                <div class="errors">
                    <ul>';

        foreach ($errors as $error) {
            echo "<li>" . $error . "</li>";
        }

        echo '    </ul>
                </div>

                <div>
                    <a href="javascript:history.back()" class="btn">Tagasi</a>
                    <a href="todo_add.xml" class="btn">Proovi uuesti</a>
</div>
            </div>
        </body>
        </html>';
    }
} else {
    // Suuna lisamise vormile, kui otse külastatud
    header("Location: todo_add.xml");
    exit();
}
?>
