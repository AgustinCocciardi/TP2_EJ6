<# 
.SYNOPSIS
El script recibe un archivo de texto plano con numeros fraccionarios, y deberá calcular la suma de todos esos números; mostrando el resultado por pantalla y en un archivo.


.DESCRIPTION
Para ejecutar el Script se debe enviar una ruta valida con un archivo de texto plano que contenga numeros fraccionarios (Anteponiendo -f), donde cada numero se encuentre separado por una coma (,). 

El script hará la suma y luego mostrará el resultado por pantalla y después en un archivo llamado salida.out, el cual será creado en el mismo directorio del script. Si el archivo ya existe, lo sobreescribirá.

Paramentros a enviar:
--------------------

-f path_Archivo_Entrada 

El archivo de entrada puede ser una ruta tanto absoluta como relativa.

.NOTES
INTEGRANTES - TP2 - Ejercicio 6
 * Agustin Cocciardi - 40231779
#>

Param( 
    [Parameter(Mandatory=$true)][string] $f
)

$ruta = Test-Path $f
if($ruta -ne $true)
	{Write-Host "La ruta del archivo de texto no es valida."
	 exit 1;
    }
    
$numeros = Get-Content $f
$numeros = $numeros.Split(',')

$longitud=$numeros.Length
#Reviso si hay un numero mixto y lo resuelvo
for ($i = 0; $i -lt $longitud; $i++) {
    if ($numeros[$i] -match ":") {
        $mixto = $numeros[$i].Split(':')
        $separado = $mixto[1].Split('/')
        $numerador = $mixto[0] -as [int]
        $inferior = $separado[1] -as [int]
        $superior = $separado[0] -as [int]
        $resultado = ($numerador * $inferior) + $superior
        $variable = "$resultado/$inferior"
        $numeros[$i]=$variable
    }
    #Write-Output $numeros[$i]
}

$denominador=1
#Empiezo a calcular el denominador
for ($i = 0; $i -lt $longitud; $i++) {
    $nuevoNumero= $numeros[$i].Split('/')
    $numero = $nuevoNumero[1] -as [int]
    if ($numero -gt $denominador) {
        $mayor=$numero
    }
    else {
        $mayor=$denominador
    }
    $valor1 = $mayor%$numero -as [int]
    $valor2 = $mayor%$denominador -as [int]

    Write-Host "Hora de calcular el MCM entre $numero y $denominador"
    sleep 2
    Write-Host "Resto de $mayor por $numero y por $denominador debe ser 0"
    Write-Host "Resto de $mayor por $numero = $valor1"
    Write-Host "Resto de $mayor por $denominador = $valor2"

    $salida=0
    Write-Host "$valor1 debe ser igual a $salida || $valor2 debe ser igual a $salida"

    while($valor1 -ne $salida && $valor2 -ne $salida){
        Write-Host "Entre al While porque $valor1 o $valor2 no son $salida"
        Write-Host "----"
        sleep 3
        $mayor++
        $valor1 = $mayor%$numero -as [int]
        $valor2 = $mayor%$denominador -as [int]
        Write-Host "Resto de $mayor por $numero y por $denominador debe ser 0"
        Write-Host "Resto de $mayor por $numero = $valor1"
        Write-Host "Resto de $mayor por $denominador = $valor2"
        Write-Host "$valor1 debe ser igual a $salida || $valor2 debe ser igual a $salida"
     }

    $denominador=$mayor
}

#Empiezo a calcular el numerador
$numerador=0
for ($i = 0; $i -lt $longitud; $i++) {
    $nuevoNumero= $numeros[$i].Split('/')
    $superior = $nuevoNumero[0] -as [int]
    $inferior = $nuevoNumero[1] -as [int]
    $auxiliar= ($denominador/$inferior)*$superior
    $numerador+=$auxiliar
}

if ($numerador -eq 0) {
    Write-Output "El resultado de la operacion es: 0"

}
else {
    if ($numerador -lt 0) {
        
    }
    else {
        
    }
}