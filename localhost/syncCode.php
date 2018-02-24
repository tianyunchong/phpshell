<?php
$modifyFilePath = isset($argv["1"]) ? $argv[1] : ""; //修改的文件的路径
$fromDir        = isset($argv[2]) ? $argv[2] : ""; //监听的目录
$toDir          = isset($argv[3]) ? $argv[3] : ""; //将要同步代码的目录
if (empty($modifyFilePath) || empty($fromDir) || empty($toDir)) {
    exit;
}
if (!file_exists($modifyFilePath)) {
    exit;
}
$code    = file_get_contents($modifyFilePath);
$toPath  = str_replace($fromDir, $toDir, $modifyFilePath);
$dirPath = dirname($toPath);
if (!is_dir($dirPath)) {
    mkdir($dirPath, 0777, true);
}
file_put_contents($toPath, $code);
file_put_contents("/tmp/debug.log", $modifyFilePath . "\t=>\t" . $toPath . "\n", FILE_APPEND);
