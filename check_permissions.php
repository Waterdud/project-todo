<?php
/**
 * Check Permissions Script
 * Kontrollib failide õigusi ja seadistust
 */

header('Content-Type: text/html; charset=UTF-8');

?>
<!DOCTYPE html>
<html lang="et">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Õiguste Kontroll / Permissions Check</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f5f5;
            padding: 20px;
            line-height: 1.6;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }
        h1 {
            color: #333;
            border-bottom: 3px solid #888;
            padding-bottom: 10px;
        }
        .check-item {
            padding: 15px;
            margin: 10px 0;
            border-radius: 5px;
            border-left: 4px solid #ccc;
        }
        .success {
            background-color: #d4edda;
            border-left-color: #28a745;
            color: #155724;
        }
        .warning {
            background-color: #fff3cd;
            border-left-color: #ffc107;
            color: #856404;
        }
        .error {
            background-color: #f8d7da;
            border-left-color: #dc3545;
            color: #721c24;
        }
        .info {
            background-color: #d1ecf1;
            border-left-color: #17a2b8;
            color: #0c5460;
        }
        code {
            background-color: #f4f4f4;
            padding: 2px 6px;
            border-radius: 3px;
            font-family: 'Courier New', monospace;
        }
        .fix-command {
            background-color: #2d2d2d;
            color: #f8f8f2;
            padding: 10px;
            border-radius: 5px;
            margin: 10px 0;
            font-family: 'Courier New', monospace;
            overflow-x: auto;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🔧 Süsteemi Kontrollimine / System Check</h1>

        <?php
        $checks = [];
        $hasErrors = false;

        // Check 1: PHP Version
        $phpVersion = phpversion();
        if (version_compare($phpVersion, '7.0.0', '>=')) {
            $checks[] = [
                'type' => 'success',
                'title' => 'PHP Versioon',
                'message' => "PHP versioon: <code>$phpVersion</code> ✓"
            ];
        } else {
            $checks[] = [
                'type' => 'error',
                'title' => 'PHP Versioon',
                'message' => "PHP versioon: <code>$phpVersion</code> (nõutav 7.0+)"
            ];
            $hasErrors = true;
        }

        // Check 2: tasks.xml exists
        $tasksFile = __DIR__ . '/tasks.xml';
        if (file_exists($tasksFile)) {
            $checks[] = [
                'type' => 'success',
                'title' => 'tasks.xml Fail',
                'message' => "Fail <code>tasks.xml</code> on olemas ✓"
            ];
        } else {
            $checks[] = [
                'type' => 'error',
                'title' => 'tasks.xml Fail',
                'message' => "Fail <code>tasks.xml</code> ei leitud!"
            ];
            $hasErrors = true;
        }

        // Check 3: tasks.xml readable
        if (file_exists($tasksFile)) {
            if (is_readable($tasksFile)) {
                $checks[] = [
                    'type' => 'success',
                    'title' => 'Lugemise Õigused',
                    'message' => "<code>tasks.xml</code> on loetav ✓"
                ];
            } else {
                $checks[] = [
                    'type' => 'error',
                    'title' => 'Lugemise Õigused',
                    'message' => "<code>tasks.xml</code> ei ole loetav!"
                ];
                $hasErrors = true;
            }
        }

        // Check 4: tasks.xml writable
        if (file_exists($tasksFile)) {
            if (is_writable($tasksFile)) {
                $checks[] = [
                    'type' => 'success',
                    'title' => 'Kirjutamise Õigused',
                    'message' => "<code>tasks.xml</code> on kirjutatav ✓"
                ];
            } else {
                $checks[] = [
                    'type' => 'error',
                    'title' => 'Kirjutamise Õigused',
                    'message' => "<code>tasks.xml</code> ei ole kirjutatav! Salvestamine ei tööta."
                ];
                $hasErrors = true;

                // Provide fix command
                $checks[] = [
                    'type' => 'info',
                    'title' => 'Parandus / Fix',
                    'message' => 'Käivitage terminalis:<div class="fix-command">chmod 666 tasks.xml</div>või Windowsis: <div class="fix-command">icacls tasks.xml /grant Users:F</div>'
                ];
            }
        }

        // Check 5: save_task.php exists
        $saveTaskFile = __DIR__ . '/save_task.php';
        if (file_exists($saveTaskFile)) {
            $checks[] = [
                'type' => 'success',
                'title' => 'save_task.php Fail',
                'message' => "Fail <code>save_task.php</code> on olemas ✓"
            ];
        } else {
            $checks[] = [
                'type' => 'error',
                'title' => 'save_task.php Fail',
                'message' => "Fail <code>save_task.php</code> ei leitud!"
            ];
            $hasErrors = true;
        }

        // Check 6: SimpleXML extension
        if (extension_loaded('simplexml')) {
            $checks[] = [
                'type' => 'success',
                'title' => 'SimpleXML',
                'message' => "SimpleXML laiendus on saadaval ✓"
            ];
        } else {
            $checks[] = [
                'type' => 'error',
                'title' => 'SimpleXML',
                'message' => "SimpleXML laiendus puudub!"
            ];
            $hasErrors = true;
        }

        // Check 7: DOM extension
        if (extension_loaded('dom')) {
            $checks[] = [
                'type' => 'success',
                'title' => 'DOM',
                'message' => "DOM laiendus on saadaval ✓"
            ];
        } else {
            $checks[] = [
                'type' => 'error',
                'title' => 'DOM',
                'message' => "DOM laiendus puudub!"
            ];
            $hasErrors = true;
        }

        // Check 8: Current directory permissions
        if (is_writable(__DIR__)) {
            $checks[] = [
                'type' => 'success',
                'title' => 'Kausta Õigused',
                'message' => "Praegune kaust on kirjutatav ✓"
            ];
        } else {
            $checks[] = [
                'type' => 'warning',
                'title' => 'Kausta Õigused',
                'message' => "Praegune kaust ei ole kirjutatav (võib põhjustada probleeme)"
            ];
        }

        // Display all checks
        foreach ($checks as $check) {
            echo "<div class='check-item {$check['type']}'>";
            echo "<strong>{$check['title']}:</strong><br>";
            echo $check['message'];
            echo "</div>";
        }

        // Summary
        echo "<hr style='margin: 30px 0; border: none; border-top: 2px solid #eee;'>";

        if (!$hasErrors) {
            echo "<div class='check-item success'>";
            echo "<h2 style='margin: 0;'>✅ Kõik Kontrolld Läbitud!</h2>";
            echo "<p>Süsteem on valmis töötama. Võite sulgeda selle akna ja kasutada rakendust.</p>";
            echo "</div>";
        } else {
            echo "<div class='check-item error'>";
            echo "<h2 style='margin: 0;'>❌ Leiti Vigu!</h2>";
            echo "<p>Parandage ülalpool näidatud vead enne jätkamist.</p>";
            echo "</div>";
        }

        // Additional info
        echo "<div class='check-item info'>";
        echo "<strong>📍 Projekti Asukoht:</strong><br>";
        echo "<code>" . __DIR__ . "</code><br><br>";
        echo "<strong>🌐 Serveri Info:</strong><br>";
        echo "PHP: <code>$phpVersion</code><br>";
        echo "Server: <code>" . $_SERVER['SERVER_SOFTWARE'] . "</code>";
        echo "</div>";
        ?>

        <div style="text-align: center; margin-top: 30px;">
            <a href="tasks.xml" style="display: inline-block; padding: 12px 24px; background-color: #888; color: white; text-decoration: none; border-radius: 5px; font-weight: 500;">← Tagasi Avalehele</a>
        </div>
    </div>
</body>
</html>
