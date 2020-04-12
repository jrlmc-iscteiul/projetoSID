<?php

class MigrateRondaExtra {
	
	private $url="127.0.0.1";
	private $databaseOrigem="mysqlmaing5";
	private $databaseDestino="mysqllogg5";
	private $username="root";
	private $password="";
	
	function startMigrateRondaExtra() {
		
		$time_startExport = microtime(true);
		
		$dataToImport = $this->getDataRondaExtra();
		
		$time_endExport = microtime(true);
		$execution_timeExport = $time_endExport - $time_startExport;
		echo '<b>Total Execution Time Export:</b> '.$execution_timeExport.' seconds <br>';
		
		
		$time_startImport = microtime(true);
		
		$idsArray = $this->putDataRondaExtra($dataToImport);
		
		$time_endImport = microtime(true);
		$execution_timeImport = $time_endImport - $time_startImport;
		echo '<b>Total Execution Time Import:</b> '.$execution_timeImport.' seconds <br>';
		
		
		$time_startClean = microtime(true);
		
		echo "tamanho vetor: " .(sizeof($idsArray)) . "<br>";
		
		if(sizeof($idsArray) != 0) {
			$this->deleteFromMysqlMainRondaExtra($idsArray);
		} 
		
		$time_endClean = microtime(true);
		$execution_timeClean = $time_endClean - $time_startClean;
		echo '<b>Total Execution Time Clean:</b> '.$execution_timeClean.' seconds <br>';
	}


	function deleteFromMysqlMainRondaExtra($array) {
		
		$conn = mysqli_connect($this->url, $this->username, $this->password, $this->databaseOrigem);
		
		if (!$conn){
			echo "Failed to connect to MySQL: " . mysqli_connect_error(); 	//mudei
			exit();
		}
				
		$ids = implode(",", $array);
		echo $ids . "<br>";
		
		$sql = "delete from logrondaextra where id in ($ids)"; 
		echo ($sql) . "<br>";
		
		if ($conn->query($sql) === TRUE) {
			echo "Delete successfully";
		} else {
			echo "Error: " . $sql . "<br>" . $conn->error;
		}
		
		$sql = "select * from logrondaextra";
		$result = mysqli_query($conn, $sql);
		
		$tentativas = 2;
		
		while (mysqli_num_rows($result)!=0 and $tentativas !=0) {
			echo "Houve algum problema na migração! <br>";
			
			$tentativas = $tentativas - 1;
			
			echo "Nº tentativas: " . $tentativas . "<br>";
			
			$this->startMigrateUtilizador();				
		} 
			
		echo "Migração completa da tabela ronda extra! <br>";

		$conn->close();
	}	


	function getDataRondaExtra() {
		
		$conn = mysqli_connect($this->url, $this->username, $this->password, $this->databaseOrigem);
		
		if (!$conn){
			
			echo "Failed to connect to MySQL: " . mysqli_connect_error();
			return null;
			
		} else {
		
			$sql = "Select * from logrondaextra"; 		
			$result = mysqli_query($conn, $sql);
			$rows = array();
			
			if ($result) {
				if (mysqli_num_rows($result)>0){
					while($r=mysqli_fetch_assoc($result)){
						array_push($rows, $r);
					}
				}	
			}
			mysqli_close ($conn);
		}
		return json_encode($rows);		
	}	


	function putDataRondaExtra($data){
		
		$data = json_decode($data);	
		$idsArray = array();
		
		$conn = mysqli_connect($this->url, $this->username, $this->password, $this->databaseDestino);
		
		if (!$conn) {
			echo "Failed to connect to MySQL: " . mysqli_connect_error();	
		} else {
			
			if($data != null) {
		
				foreach ($data as $linha) {
									
					$idLog = $linha->id;
					$diaHora = $linha->data; 
					$operacaoLog = $linha->operacao;
					$campoAlteradoLog = $linha->campoAlterado;
					$dataHoraInicio = $linha->dataHoraInicio; 
					$dataHoraFim = $linha->dataHoraFim;
					$idUtilizadorLog = $linha -> idUtilizador;
					
					$exists = "select count(*) as total from logrondaextra where id = $idLog";
					
					$resultExists = mysqli_query($conn, $exists);
					
					$data = mysqli_fetch_assoc($resultExists);
					
					echo "Existe a linha: " . $data['total'] . "<br>";
					
					if($data['total'] == 0) {
						
						echo "entrei no if - nao havia esta linha <br>";
					
						$sql = "INSERT INTO logrondaextra 
								VALUES ($idLog, '$diaHora', '$operacaoLog', '$campoAlteradoLog', '$dataHoraInicio', '$dataHoraFim', $idUtilizadorLog)";
								
						echo $sql . "<br>";
										
						if ($conn->query($sql) === TRUE) {
							echo "New record created successfully";
						} else {
							echo "Error: " . $sql . "<br>" . $conn->error;
						}
						
					} else {
						echo "esta linha ja existe <br>";
					}
					
					array_push($idsArray, $idLog);
				}
			}
			
			$conn->close();
		}

		return $idsArray;
	}
}

?>