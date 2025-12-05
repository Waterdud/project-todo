<?php
/**
 * Save Task to XML - API Endpoint
 * Salvestab ülesande tasks.xml faili
 */

// Set headers
header('Content-Type: application/json; charset=UTF-8');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

// Handle preflight requests
if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') {
    exit(0);
}

// Only allow POST requests
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'message' => 'Ainult POST päringud lubatud']);
    exit;
}

// Get JSON data
$json = file_get_contents('php://input');
$data = json_decode($json, true);

// Validate input
if (!$data) {
    http_response_code(400);
    echo json_encode(['success' => false, 'message' => 'Vigased andmed']);
    exit;
}

// Extract and validate fields
$kuupaev = isset($data['kuupaev']) ? trim($data['kuupaev']) : '';
$tahtaeg = isset($data['tahtaeg']) ? trim($data['tahtaeg']) : '';
$oppeaine = isset($data['oppeaine']) ? trim($data['oppeaine']) : '';
$ylesanne = isset($data['ylesanne']) ? trim($data['ylesanne']) : '';
$info = isset($data['info']) ? trim($data['info']) : '';

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

// Return errors if any
if (!empty($errors)) {
    http_response_code(400);
    echo json_encode([
        'success' => false,
        'message' => implode(', ', $errors),
        'errors' => $errors
    ]);
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

// Generate new ID by finding max ID across all tasks in the hierarchy
$maxId = 0;
// Search through all tasks in the new hierarchical structure
foreach ($xml->oppeaine as $oppeaine_elem) {
    foreach ($oppeaine_elem->ylesandetyyp as $ylesandetyyp_elem) {
        foreach ($ylesandetyyp_elem->task as $task) {
            $taskId = (int)$task->id;
            if ($taskId > $maxId) {
                $maxId = $taskId;
            }
        }
    }
}
// Also check tasks directly under oppeaasta (if any)
foreach ($xml->task as $task) {
    $taskId = (int)$task->id;
    if ($taskId > $maxId) {
        $maxId = $taskId;
    }
}
$newId = $maxId + 1;

// Find or create the appropriate oppeaine element
$oppeaine_elem = null;
foreach ($xml->oppeaine as $elem) {
    if ((string)$elem['name'] === $oppeaine) {
        $oppeaine_elem = $elem;
        break;
    }
}

// If oppeaine doesn't exist, create it
if ($oppeaine_elem === null) {
    $oppeaine_elem = $xml->addChild('oppeaine');
    $oppeaine_elem->addAttribute('name', htmlspecialchars($oppeaine, ENT_XML1, 'UTF-8'));
}

// For now, we'll use a default task type "Kodutöö" if not specified
// You can modify this to accept task type from the form
$taskType = isset($data['taskType']) ? trim($data['taskType']) : 'Kodutöö';

// Find or create the appropriate ylesandetyyp element
$ylesandetyyp_elem = null;
foreach ($oppeaine_elem->ylesandetyyp as $elem) {
    if ((string)$elem['type'] === $taskType) {
        $ylesandetyyp_elem = $elem;
        break;
    }
}

// If ylesandetyyp doesn't exist, create it
if ($ylesandetyyp_elem === null) {
    $ylesandetyyp_elem = $oppeaine_elem->addChild('ylesandetyyp');
    $ylesandetyyp_elem->addAttribute('type', htmlspecialchars($taskType, ENT_XML1, 'UTF-8'));
}

// Create new task element under the appropriate ylesandetyyp
$newTask = $ylesandetyyp_elem->addChild('task');
$newTask->addChild('id', $newId);
$newTask->addChild('kuupaev', htmlspecialchars($kuupaev, ENT_XML1, 'UTF-8'));
$newTask->addChild('tahtaeg', htmlspecialchars($tahtaeg, ENT_XML1, 'UTF-8'));
$newTask->addChild('oppeaine', htmlspecialchars($oppeaine, ENT_XML1, 'UTF-8'));
$newTask->addChild('ylesanne', htmlspecialchars($ylesanne, ENT_XML1, 'UTF-8'));
$newTask->addChild('info', htmlspecialchars($info, ENT_XML1, 'UTF-8'));

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
    'message' => 'Ülesanne edukalt salvestatud',
    'id' => $newId,
    'task' => [
        'id' => $newId,
        'kuupaev' => $kuupaev,
        'tahtaeg' => $tahtaeg,
        'oppeaine' => $oppeaine,
        'ylesanne' => $ylesanne,
        'info' => $info
    ]
]);
?>
