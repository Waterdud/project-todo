<?php
/**
 * Simple Router - создает XML с правильной ссылкой на XSLT
 */

// Получить параметр view
$view = isset($_GET['view']) ? $_GET['view'] : 'home';

// Маппинг видов на XSLT файлы (только нужные)
$xsltMap = [
    'home' => 'todo_home.xslt',
    'add' => 'todo_add.xslt',
    'json' => 'todo_json.xslt'
];

// Проверка существования view
if (!isset($xsltMap[$view])) {
    $view = 'home';
}

$xsltFile = $xsltMap[$view];
$xmlContent = file_get_contents(__DIR__ . '/tasks.xml');

// Заменить ссылку на stylesheet
$xmlContent = preg_replace(
    '/<\?xml-stylesheet[^?]*\?>/',
    '<?xml-stylesheet type="text/xsl" href="' . $xsltFile . '"?>',
    $xmlContent
);

// Вывести XML с правильной ссылкой на XSLT
header('Content-Type: application/xml; charset=UTF-8');
echo $xmlContent;
?>
