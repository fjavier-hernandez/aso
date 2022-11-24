# Gestión de procesos con Powershell

La teoría para gestionar procesos ya se ha impartido en las secciones anteriores por lo que esta sección se centra en las herramientas y comandos para gestionar los procesos en PowerShell.

!!! note "Nota"
    Para encontrar los comandos relacionados con procesos en Power-Shell podemos utilizar:
    `get-command *process*`

``` pwsh
PS /Users/aso> get-command *process*

CommandType     Name                                               Version    Source
-----------     ----                                               -------    ------
Alias           Start-ASRSwitchProcessServerJob                    5.2.0      Az.RecoveryServices
Cmdlet          Debug-Process                                      7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          Enter-PSHostProcess                                7.2.2.500  Microsoft.PowerShell.Core
Cmdlet          Exit-PSHostProcess                                 7.2.2.500  Microsoft.PowerShell.Core
Cmdlet          Get-Process                                        7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          Get-PSHostProcessInfo                              7.2.2.500  Microsoft.PowerShell.Core
Cmdlet          Start-AzRecoveryServicesAsrSwitchProcessServerJob  5.2.0      Az.RecoveryServices
Cmdlet          Start-Process                                      7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          Stop-Process                                       7.0.0.0    Microsoft.PowerShell.Management
Cmdlet          Wait-Process                                       7.0.0.0    Microsoft.PowerShell.Management
```

!!! note "Nota"
    Para obtener información de cada comando: `Get-Help`

``` pwsh
    PS /Users/aso> get-help Get-Process 

NAME
    Get-Process
    
SYNTAX
    Get-Process [[-Name] <string[]>] [-Module] [-FileVersionInfo] [<CommonParameters>]
    
    Get-Process [[-Name] <string[]>] -IncludeUserName [<CommonParameters>]
    
    Get-Process -Id <int[]> [-Module] [-FileVersionInfo] [<CommonParameters>]
    
    Get-Process -Id <int[]> -IncludeUserName [<CommonParameters>]
    
    Get-Process -InputObject <Process[]> [-Module] [-FileVersionInfo] [<CommonParameters>]
    
    Get-Process -InputObject <Process[]> -IncludeUserName [<CommonParameters>]
    

ALIASES
    gps
    

REMARKS
    Get-Help cannot find the Help files for this cmdlet on this computer. It is displaying only partial help.
        -- To download and install Help files for the module that includes this cmdlet, use Update-Help.
        -- To view the Help topic for this cmdlet online, type: "Get-Help Get-Process -Online" or
           go to https://go.microsoft.com/fwlink/?LinkID=2096814.
```

## Obtener procesos

Para obtener los procesos que se están ejecutando en el equipo local, se ejecuta `Get-Process` sin parámetros.

``` pwsh
PS /Users/aso> Get-Process         

 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
      0     0,00      24,09      31,56     406   1 accountsd
      0     0,00       8,14       0,48     488   1 adprivacyd
      0     0,00       8,18       0,41     475   1 AirPlayUIAgent
      0     0,00      11,19       2,09     425   1 akd
      0     0,00       4,88       0,17     453   1 AMPDeviceDiscov
      0     0,00       7,43       0,50     590   1 AMPLibraryAgent
      0     0,00       9,42       1,02     480   1 amsaccountsd
      0     0,00      10,34       2,69     410   1 amsengagementd
      0     0,00       1,68       0,03     500   1 APFSUserAgent
      0     0,00      28,80      28,01     600   1 AppleSpell
      0     0,00       9,23       0,44     398   1 AppSSOAgent
      0     0,00      11,14       5,90     538   1 appstoreagent
      0     0,00       8,06       0,73     472   1 askpermissiond
      0     0,00       6,64       0,42     566   1 AssetCacheLocat
      0     0,00      22,21      12,86     483   1 assistantd
      0     0,00      22,71       9,10     718   1 assistant_servi
      0     0,00       3,09       0,28     605   1 AudioComponentR
      0     0,00      24,00       0,47    1273   1 avatarsd
      0     0,00       5,79       0,18     386   1 backgroundtaskm
      0     0,00       8,36       1,92     418   1 bird
```
!!! note "Nota"
    - En la salida del comando anterior hay mucha información desordenada a analizar.
    - Puede ayudar a ver la información si **se organizan los procesos de mayor a menor consumo de CPU, y solo los 10 primeros**.

``` pwsh
PS /Users/aso> Get-Process|Sort-Object CPU -Descending|Select-Object -First 10

 NPM(K)    PM(M)      WS(M)     CPU(s)      Id  SI ProcessName
 ------    -----      -----     ------      --  -- -----------
      0     0,00      52,24     643,87     561   1 suggestd
      0     0,00      23,55     267,14     457   1 CleanMyMac X He
      0     0,00      26,21     262,25     912 912 CalendarWidgetE
      0     0,00      32,32     210,93     407   1 CalendarAgent
      0     0,00      32,07     181,48     914 914 WorldClockWidge
      0     0,00      95,39     140,45     378   1 Finder
      0     0,00     586,70     135,40    5266   1 Code Helper
      0     0,00     221,30     127,45    5031   1 Code Helper (Re
      0     0,00      17,03      94,25     390 390 QuickLookUIServ
      0     0,00     114,68      93,64    5049   1 Safari
```

- En el supuesto caso que se quieran encontrar determinados procesos se pueden obtener especificando sus nombres de proceso o identificadores de proceso. 

!!! example "Ejemplo"
    El siguiente comando obtiene el proceso inactivo: `Get-Process -id 0`

!!! note "Nota"
    El proceso inactivo del sistema contiene uno o más kernel threads que ejecuta cuando ningún otro thread puede ser planificado en la CPU, es decir, **es el porcentaje que el procesador no está trabajando**.

``` pwsh
PS /Users/aso> Get-Process -id 0
Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
      0       0        0         16     0               0 Idle
```

!!! Note "Nota"
    - Es normal que los cmdlets no devuelvan datos en algunas situaciones, como por ejemplo cuando se especifica un proceso por su **id** de proceso `Get-Process` y **si no encuentra ninguna coincidencia generará un error**, porque la intención habitual consiste en recuperar un proceso en ejecución conocido.
    - Si no hay ningún proceso con ese identificador, es probable que el identificador sea incorrecto o que el proceso de interés haya terminado.

``` pwsh
PS /Users/aso> Get-Process -Id 99
Get-Process : No process with process ID 99 was found.
At line:1 char:12
+ Get-Process  <<<< -Id 99
```

!!! tip "Consejo"
    - Para evitar estos errores puede usar el parámetro `Name` del cmdlet `Get-Process` para especificar un subconjunto de procesos basado en el nombre del proceso. 
    - El parámetro `Name` puede tomar varios nombres de una lista de nombres separados por comas y admite el uso de caracteres comodín, para que pueda escribir patrones de nombre.

!!! example "Example"
    El siguiente comando obtiene el proceso cuyos nombres comienzan por "ex".

``` pwsh
PS /Users/aso> Get-Process -Name ex*

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
    234       7     5572      12484   134     2.98   1684 EXCEL
    555      15    34500      12384   134   105.25    728 explorer

```

- `Get-Process` también acepta varios valores para el parámetro Name.

``` pwsh
PS /Users/aso> Get-Process -Name exp*,power*

Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
    540      15    35172      48148   141    88.44    408 explorer
    605       9    30668      29800   155     7.11   3052 powershell

```

- Para obtener más información de un proceso se puede utilizar el comando: 

``` pwsh
PS /Users/aso> Get-Process -Name pwsh |Format-List *

Name                       : pwsh
Id                         : 5289
PriorityClass              : Normal
FileVersion                : 
HandleCount                : 0
WorkingSet                 : 85704704
PagedMemorySize            : 0
PrivateMemorySize          : 0
VirtualMemorySize          : -1759395840
TotalProcessorTime         : 00:00:21.8087752
SI                         : 5289
Handles                    : 0
VM                         : 6830538752
WS                         : 85704704
PM                         : 0
NPM                        : 0
Path                       : /usr/local/microsoft/powershell/7/pwsh
CommandLine                : 
Parent                     : System.Diagnostics.Process (Code Helper (Re)
Company                    : 
CPU                        : 21,8248627
ProductVersion             : 
Description                : 
Product                    : 
__NounName                 : Process
SafeHandle                 : Microsoft.Win32.SafeHandles.SafeProcessHandle
Handle                     : 1336
BasePriority               : 0
```

### Obtener información determinada de un proceso

Para obtener informaciones en particular de un proceso podemos poner entre paréntesis el comando de obtener el proceso y a continuación un punto seguido de la información que se quiera obtener. Por ejemplo:

- Una información importante de un proceso puede ser el path donde esta guardado el proceso, y se puede obtener con:

``` pwsh
PS /Users/aso> (Get-Process -Name pwsh).path
/usr/local/microsoft/powershell/7/pwsh
```

- Para obtener el **tamaño del proceso** con:
``` pwsh
PS /Users/aso> (Get-Process -Name pwsh).ws  
68603904
```
### Procesos en remoto

- Puede usar el parámetro ComputerName de `Get-Process` para obtener procesos en equipos remotos. Por ejemplo, el comando siguiente obtiene los procesos de PowerShell en el equipo local (representado por "localhost") y en dos equipos remotos.

``` pwsh
Get-Process -Name PowerShell -ComputerName localhost, Server01, Server02

```

- La salida de este comando seria:

``` pwsh
Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
    258       8    29772      38636   130            3700 powershell
    398      24    75988      76800   572            5816 powershell
    605       9    30668      29800   155     7.11   3052 powershell

```

!!! Note "Nota"
    - Los nombres de equipo no son evidentes en este resultado, pero se almacenan en la propiedad MachineName de los objetos de proceso que devuelve `Get-Process`.
    - El siguiente comando usa el cmdlet `Format-Table` para mostrar el identificador de proceso y las propiedades ProcessName y MachineName(ComputerName) de los objetos de proceso.

``` pwsh
Get-Process -Name PowerShell -ComputerName localhost, Server01, Server01 |
    Format-Table -Property ID, ProcessName, MachineName

```

- La salida de este comando seria:

``` pwsh
  Id ProcessName MachineName
  -- ----------- -----------
3700 powershell  Server01
3052 powershell  Server02
5816 powershell  localhost

```

## Detener procesos

- El cmdlet `Stop-Process` toma un nombre o un identificador para especificar un proceso que quiere detener. Su capacidad para detener procesos dependerá de sus permisos. Algunos procesos no se pueden detener. Por ejemplo, si intenta detener el proceso inactivo, obtendrá un error:

``` pwsh
Stop-Process -Name Idle

```

- La salida de este comando seria:

``` pwsh
Stop-Process : Process 'Idle (0)' cannot be stopped due to the following error:
 Access is denied
At line:1 char:13
+ Stop-Process  <<<< -Name Idle

```

!!! tip "Consejo"
    - También puede forzar la solicitud con el parámetro `Confirm`. 
    - Este parámetro es especialmente útil si se usa un carácter comodín al especificar el nombre del proceso, ya que accidentalmente podría coincidir con algunos procesos que no se quiere detener:

``` pwsh
Stop-Process -Name t*,e* -Confirm

```

- La salida de este comando seria:

``` pwsh
Confirm
Are you sure you want to perform this action?
Performing operation "Stop-Process" on Target "explorer (408)".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help
(default is "Y"):n
Confirm
Are you sure you want to perform this action?
Performing operation "Stop-Process" on Target "taskmgr (4072)".
[Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help
(default is "Y"):n
```

### Detención de procesos que no responden

!!! tip "Consejo"
    - La manipulación de procesos complejos es posible si se usan algunos cmdlets de filtrado de objetos. 
    - Dado que un objeto Process tiene una propiedad Responding que es `false` cuando ya no responde, puede detener todas las aplicaciones que no respondan con el comando siguiente:

``` pwsh
Get-Process | Where-Object -FilterScript {$_.Responding -eq $false} | Stop-Process

```

### Detener procesos en remoto

El cmdlet `Stop-Process` no tiene un parámetro ComputerName. Por lo tanto, para ejecutar un comando para detener un proceso en un equipo remoto, debe usar el cmdlet `Invoke-Command`. Por ejemplo, para detener el proceso de PowerShell en el equipo remoto Server01, escriba:

``` pwsh
Invoke-Command -ComputerName Server01 {Stop-Process Powershell}

```

### Detener todas las demás sesiones de Windows PowerShell

- En ocasiones puede ser útil poder detener todas las sesiones de Windows PowerShell que se están ejecutando, excepto la sesión actual. Si una sesión usa demasiados recursos o es inaccesible (quizás se esté ejecutando de forma remota o en otra sesión de escritorio), es posible que no pueda detenerla directamente. Si intenta detener todas las sesiones que se están ejecutando, la sesión actual podría finalizar en su lugar.

- Cada sesión de Windows PowerShell tiene un PID de variable de entorno que contiene el identificador del proceso de Windows PowerShell. Puede comprobar el $PID con el identificador de la sesión actual y finalizar solo las sesiones de Windows PowerShell que tengan un identificador diferente. El siguiente comando de canalización realiza esta acción y devuelve la lista de las sesiones finalizadas (debido al uso del parámetro `PassThru`):

``` pwsh
Get-Process -Name powershell | Where-Object -FilterScript {$_.Id -ne $PID} |
    Stop-Process -PassThru

```

- La salida de este comando seria:

``` pwsh
Handles  NPM(K)    PM(K)      WS(K) VM(M)   CPU(s)     Id ProcessName
-------  ------    -----      ----- -----   ------     -- -----------
    334       9    23348      29136   143     1.03    388 powershell
    304       9    23152      29040   143     1.03    632 powershell
    302       9    20916      26804   143     1.03   1116 powershell
    335       9    25656      31412   143     1.09   3452 powershell
    303       9    23156      29044   143     1.05   3608 powershell
    287       9    21044      26928   143     1.02   3672 powershell

```

## Iniciar procesos

Se pueden iniciar procesos conociendo el path de su ejecutable. Por Ejemplo:

``` pwsh
PS /Users/aso> Start-Process -FilePath C:\windows\notepad.exe
```

!!! tip "Consejo"
    Para abrir aplicaciones se utilizaría un comando parecido pero hay que realizar a través de un protocolo. Ejemplo, si se quisiera abrir el Edge de Windows:

``` pwsh
PS /Users/aso> Start-Process Microsoft-edge://
```


### Actividades

!!! note "NOTA"
    Escribe el código de los scripts en **PowerShell** que se detallan en cada ejercicio. Deberás crear un fichero de texto para cada ejercicio con el siguiente nombre: ejXXX.sh, donde las X representan el número de ejercicio. Una vez terminada la práctica, comprime todos estos ficheros en uno y súbelos al Moodle.

309. Realiza un script en PowerShell que realice los siguientes puntos:

- Cuenta el número de procesos en ejecución en el sistema, y los muestre por pantalla.
- Ver que programas se ejecutan en el inicio de sesión y los muestre por pantalla.
- Guardar los un listado de los procesos en un csv e Imprima por pantalla el archivo.

310. Realiza un script en PowerShell que realice los siguientes puntos:
  
- Lista los procesos que tengan un alto consumo de CPU.
- Detenga el proceso con mayor consumo.
- Mostrar los procesos cuya zona de memoria para trabajar sea mayor que 100 MB y a continuación los detenga.
