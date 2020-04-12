<?php

$time_start = microtime(true);
echo "$time_start";

include 'MigrateUtilizador.php';
include 'MigrateMedicoesSensores.php';
include 'MigrateRondaExtra.php';
include 'MigrateRondaPlaneada.php';
include 'MigrateSistema.php';

$instanceUtilizador = new MigrateUtilizador();
$instanceMedicoesSensores = new MigrateMedicoesSensores();
$instanceRondaExtra = new MigrateRondaExtra();
$instanceRondaPlaneada = new MigrateRondaPlaneada();
$instanceSistema = new MigrateSistema();

$instanceUtilizador->startMigrateUtilizador();
$instanceMedicoesSensores->startMigrateMedicoesSensores();
$instanceRondaExtra->startMigrateRondaExtra();
$instanceRondaPlaneada->startMigrateRondaPlaneada();
$instanceSistema->startMigrateSistema();

$time_end = microtime(true);
$execution_time = $time_end - $time_start;
echo '<b>Total Execution Time:</b> '.$execution_time.' seconds';

?>
