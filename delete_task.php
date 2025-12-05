<?php
/**
 * Delete Task from XML - API Endpoint
 * Kustutab ülesande tasks.xml failist
 */

// Set headers
header('Content-Type: application/json; charset=UTF-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, DELETE');
header('Access-Control-Allow-Headers: Content-Type');

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit(0);
}

// Allow POST or DELETE requests
if ($_SERVER['REQUEST_METHOD'] !== 'POST' && $_SERVER['REQUEST_METHOD'] !== 'DELETE') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Ainult POST/DELETE päringud lubatud']);
    exit;
}

// Get task ID
$taskId = null;

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $json = file_get_contents('php://input');
    $data = json_decode($json, true);
    $taskId = isset($data['id']) ? (int)$data['id'] : null;
} else {
    $taskId = isset($_GET['id']) ? (int)$_GET['id'] : null;
}

// Validate task ID
if (!$taskId || $taskId <= 0) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Vigane ülesande ID']);
    exit;
}

// Load existing XML
$xmlFile = __DIR__ . '/tasks.xml';

if (!file_exists($xmlFile)) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'tasks.xml faili ei leitud']);
    exit;
}

// Load and parse XML
libxml_use_internal_errors(true);
$xml = simplexml_load_file($xmlFile);

if ($xml === false) {
    $xmlErrors = libxml_get_errors();
    libxml_clear_errors();
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'XML faili lugemine ebaõnnestus']);
    exit;
}

// Find and delete the task
$taskFound = false;
$taskDeleted = false;

// Search through the hierarchical structure
foreach ($xml->oppeaine as $oppeaine_elem) {
    foreach ($oppeaine_elem->ylesandetyyp as $ylesandetyyp_elem) {
        $taskIndex = 0;
        foreach ($ylesandetyyp_elem->task as $task) {
            if ((int)$task->id === $taskId) {
                $taskFound = true;
                // Remove the task using unset with DOM
                unset($ylesandetyyp_elem->task[$taskIndex]);
                $taskDeleted = true;
                break 3; // Break out of all loops
            }
            $taskIndex++;
        }
    }
}

// Also check tasks directly under oppeaasta (if any)
if (!$taskFound) {
    $taskIndex = 0;
    foreach ($xml->task as $task) {
        if ((int)$task->id === $taskId) {
            $taskFound = true;
            unset($xml->task[$taskIndex]);
            $taskDeleted = true;
            break;
        }
        $taskIndex++;
    }
}

// If task not found
if (!$taskFound) {
    http_response_code(404);
    echo json_encode(['success' => false, 'message' => "Ülesannet ID-ga $taskId ei leitud"]);
    exit;
}

// Format XML nicely
$dom = new DOMDocument('1.0', 'UTF-8');
$dom->preserveWhiteSpace = false;
$dom->formatOutput = true;
$dom->loadXML($xml->asXML());

// Save to file
$saved = @file_put_contents($xmlFile, $dom->saveXML());

if ($saved === false) {
    http_response_code(500);
    echo json_encode(['success' => false, 'message' => 'Faili salvestamine ebaõnnestus. Kontrollige õigusi.']);
    exit;
}

// Success response
echo json_encode([
    'success' => true,
    'message' => "Ülesanne ID-ga $taskId edukalt kustutatud",
    'id' => $taskId
]);
?>
