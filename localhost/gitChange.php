<?php
/**
 * 监听下都有哪些目录进行了修改
 * @author  tianyunchong
 */
$checkDir = array(
    '/data/cap/www2017/gc.supsite.work',
    '/data/cap/www2017/gc.supsite.api',
    '/data/cap/www2017/gc.supsite.manage',
);
foreach ($checkDir as $v) {
    $composerLib   = $v . "/vendor/xz/composerLib";
    $composerConf  = $v . '/vendor/xz/conf';
    $composerMongo = $v . '/vendor/xz/mongomodel';
    checkGitChange($composerLib);
    checkGitChange($composerConf);
    checkGitChange($composerMongo);
}
echo "检测完毕\n";

/**
 * 检测下git修改
 * @param  [type] $dirPath [description]
 * @return [type]          [description]
 */
function checkGitChange($dirPath)
{
    if (!is_dir($dirPath)) {
        return false;
    }
    $cmd = "cd " . $dirPath . ";git status";
    exec($cmd, $output);
    if (in_array("nothing to commit, working tree clean", $output)) {
        return true;
    }
    echo $dirPath . "\t发生了修改\n";
}
