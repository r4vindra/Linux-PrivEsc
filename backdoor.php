<?php
// Simple RCE for executing 'whoami' only
if (isset($_GET['cmd']) && $_GET['cmd'] === 'whoami') {
    echo "<pre>";
    system('whoami');
    echo "</pre>";
} else {
    echo "Access denied.";
}
?>
