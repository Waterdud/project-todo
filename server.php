<?php
/**
 * Simple PHP server for TODO project
 * Handles both static files and POST requests
 */

$method = $_SERVER['REQUEST_METHOD'];
$uri = $_SERVER['REQUEST_URI'];
$path = parse_url($uri, PHP_URL_PATH);

// Handle root path - redirect to main page
if ($path === '/' || $path === '') {
    header('Location: /tasks.xml');
    exit;
}

// Remove query string for file path
$filePath = __DIR__ . $path;

if ($method === 'POST' && $path === '/save_task') {
    // Handle task saving
    header('Content-Type: application/json');
    
    $input = json_decode(file_get_contents('php://input'), true);
    
    if ($input) {
        // Generate new ID
        $xmlFile = 'tasks.xml';
        $newId = 1;
        
        if (file_exists($xmlFile)) {
            $xml = simplexml_load_file($xmlFile);
            $existingIds = [];
            foreach ($xml->task as $task) {
                $existingIds[] = (int)$task->id;
            }
            $newId = max($existingIds) + 1;
        } else {
            // Create new XML structure
            $xml = new SimpleXMLElement('<?xml version="1.0" encoding="UTF-8"?><tasks></tasks>');
        }
        
        // Add new task
        $task = $xml->addChild('task');
        $task->addChild('id', $newId);
        $task->addChild('kuupaev', htmlspecialchars($input['kuupaev']));
        $task->addChild('tahtaeg', htmlspecialchars($input['tahtaeg']));
        $task->addChild('oppeaine', htmlspecialchars($input['oppeaine']));
        $task->addChild('ylesanne', htmlspecialchars($input['ylesanne']));
        $task->addChild('info', htmlspecialchars($input['info']));
        
        // Save XML file
        $dom = new DOMDocument('1.0', 'UTF-8');
        $dom->formatOutput = true;
        $dom->loadXML($xml->asXML());
        
        // Add XML stylesheet processing instruction
        $xsl = $dom->createProcessingInstruction('xml-stylesheet', 'type="text/xsl" href="todo_home.xslt"');
        $dom->insertBefore($xsl, $dom->documentElement);
        
        if ($dom->save($xmlFile)) {
            echo json_encode(['success' => true, 'id' => $newId, 'message' => 'Task saved successfully']);
        } else {
            echo json_encode(['success' => false, 'message' => 'Failed to save XML file']);
        }
    } else {
        echo json_encode(['success' => false, 'message' => 'Invalid input data']);
    }
    
} else {
    // Serve static files
    if (file_exists($filePath) && is_file($filePath)) {
        $ext = pathinfo($filePath, PATHINFO_EXTENSION);
        
        switch ($ext) {
            case 'xml':
                header('Content-Type: application/xml; charset=UTF-8');
                break;
            case 'xslt':
            case 'xsl':
                header('Content-Type: application/xslt+xml; charset=UTF-8');
                break;
            case 'css':
                header('Content-Type: text/css; charset=UTF-8');
                break;
            case 'js':
                header('Content-Type: application/javascript; charset=UTF-8');
                break;
            case 'php':
                // Execute PHP files
                include $filePath;
                return;
            default:
                header('Content-Type: text/plain; charset=UTF-8');
        }
        
        readfile($filePath);
    } else {
        // 404 Not Found
        http_response_code(404);
        echo "File not found: $path";
    }
}
?>
