<# 
.SYNOPSIS
El script recibe un archivo de texto plano con numeros fraccionarios, y deberá calcular la suma de todos esos números; mostrando el resultado por pantalla y en un archivo.


.DESCRIPTION
Para ejecutar el Script se debe enviar una ruta valida con un archivo de texto plano que contenga numeros fraccionarios (Anteponiendo -Path), donde cada numero se encuentre separado por una coma (,). 

El script hará la suma y luego mostrará el resultado por pantalla y después en un archivo llamado salida.out, el cual será creado en el mismo directorio del script. Si el archivo ya existe, lo sobreescribirá.

Paramentros a enviar:
--------------------

-Path path_Archivo_Entrada 

El archivo de entrada puede ser una ruta tanto absoluta como relativa.

.NOTES
# ALUMNOS GRUPO 8 - Trabajo Practico 2
# Ejercicio 6
# 40231779 - Cocciardi, Agustin
# 40078823 - Biscaia, Elías
# 40388978 - Varela, Daniel
# 37841788 - Sullca, Willian
# 38056215 - Aguilera, Erik 
#>

Param( 
    [Parameter(Mandatory=$true)][string] $Path
)


$Ruta = Join-Path -Path $PWD -ChildPath $Path

$Path = $Ruta

$ruta = Test-Path $Path
if($ruta -ne $true)
	{Write-Host "La ruta del archivo de texto no es valida."
	 exit 1;
    }

$numeros = Get-Content "$Path"

if($numeros -eq $null){
    Write-Host "El archivo está vacío. Nada que operar"
    Write-Output "El resultado es: "
    Write-Output "El resultado es: " > salida.out
    exit 2
}

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
    #sleep 1
}

$denominador=1
#Empiezo a calcular el denominador
for ($i = 0; $i -lt $longitud; $i++) {
    if ($numeros[$i].Length -ne 1 -and $numeros[$i].Length -ne 2) {
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
        while($valor1 -ne 0 -or $valor2 -ne 0){
            $mayor++
            $valor1 = $mayor%$numero -as [int]
            $valor2 = $mayor%$denominador -as [int]
        }

        $denominador=$mayor
    }
}

#Empiezo a calcular el numerador
$numerador=0
for ($i = 0; $i -lt $longitud; $i++) {
    if ($numeros[$i].Length -eq 1 -or $numeros[$i].Length -eq 2) {
        $nuevoNumero= $numeros[$i] -as [int]
        $numerador+= ($denominador*$nuevoNumero)
    }
    else {
        $nuevoNumero= $numeros[$i].Split('/')
        $superior = $nuevoNumero[0] -as [int]
        $inferior = $nuevoNumero[1] -as [int]
        $auxiliar= ($denominador/$inferior)*$superior
        $numerador+=$auxiliar    
    }
    
}

if ($numerador -eq 0) {
    Write-Output "El resultado de la operacion es: 0"
    Write-Output "El resultado de la operacion es: 0" > salida.out
}
else {
    if ($numerador -lt 0) {
        $numerador*=(-1)
        $negativo=1
    }
    else {
        $negativo=0
    }
    $numero1= $numerador
    $numero2= $denominador

    while ($numero1 -ne $numero2) {
        if ($numero1 -gt $numero2) {
            $numero1-=$numero2
        }
        else {
            $numero2-=$numero1
        }
    }

    $comunDivisor=$numero1

    $numerador/=$comunDivisor
    $denominador/=$comunDivisor

    if ($negativo -eq 1) {
        $numerador*=(-1)
    }

    if($denominador -eq 1){
        Write-Output "El resultado es: $numerador"
        Write-Output "El resultado es: $numerador" > salida.out
    }
    else{
        $resultado="$numerador/$denominador"
        Write-Output "El resultado es: $resultado"
        Write-Output "El resultado es: $resultado" > salida.out
    }
    
}