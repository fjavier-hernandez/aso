#!/bin/bash
# =============================================================================
# SCRIPT: ej109.sh - Programa AGENDA
# =============================================================================
# AC109. Construye un programa denominado AGENDA que permita mediante un menú, 
# el mantenimiento de un pequeño archivo lista.txt con el nombre, dirección y teléfono de varias personas.
# Opciones del programa:
# - Añadir (añadir un registro)
# - Buscar (buscar entradas por nombre, dirección o teléfono)
# - Listar (visualizar todo el archivo)
# - Ordenar (ordenar los registros alfabéticamente)
# - Borrar (borrar el archivo)
# =============================================================================

# CONFIGURACIÓN DEL ARCHIVO DE DATOS
fichero="./lista.txt" # Archivo donde se almacenan los contactos

# VERIFICACIÓN Y CREACIÓN DEL ARCHIVO
# -f = verifica si el archivo existe y es un archivo regular
# Si el archivo no existe, lo creamos con touch
if [ ! -f $fichero ]
then 
	touch $fichero
	echo "Archivo $fichero creado."
fi

# BUCLE PRINCIPAL DEL MENÚ
# while(true) = bucle infinito que se ejecuta hasta que se use exit
while(true)
do
	# MOSTRAR MENÚ PRINCIPAL
	echo "******************AGENDA*****************"
	echo -e "1) AÑADIR\n2) BUSCAR\n3) LISTAR\n4) ORDENAR\n5) BORRAR\n0) SALIR\n"
	read -p "OPCIÓN SELECCIONADA: " opcion

	# ESTRUCTURA CASE PARA MANEJAR OPCIONES
	# case = estructura condicional múltiple más eficiente que if-elif
	case $opcion in
		0)
			# OPCIÓN SALIR
			echo "Saliendo.."
			exit
			;;
		1)
			# OPCIÓN AÑADIR CONTACTO
			echo "Vamos a añadir una nueva entrada, por favor, introduce los datos a continuación: "
			read -p "Nombre: " nombre
			read -p "Dirección: " direccion
			read -p "Teléfono: " telefono
			# Guardamos en formato: nombre#direccion#telefono
			# >> = redirección de salida en modo append (añade al final)
			echo "$nombre#$direccion#$telefono" >> $fichero
			echo "Registro añadido correctamente."
			;;
		2)
			# OPCIÓN BUSCAR CONTACTO
			echo -e "Vamos a buscar una entrada por...\n1) NOMBRE\n2) DIRECCIÓN\n3) TELÉFONO\n0) VOLVER"
			read -p "OPCIÓN SELECCIONADA: " opcion
			case $opcion in
				0)
					echo "Volviendo..."
					;;
				1)
					# BÚSQUEDA POR NOMBRE
					read -p "Nombre a buscar: " nombre
					# cat = muestra contenido del archivo
					# grep -i = búsqueda insensible a mayúsculas/minúsculas
					# -e = especifica patrón de expresión regular
					# "^$nombre#.*" = patrón que busca nombre al inicio de línea
					# tr '#' ' ' = reemplaza # por espacios
					cat $fichero | grep -i -e  "^$nombre#.*" | tr '#' ' '
					;;
				2)
					# BÚSQUEDA POR DIRECCIÓN
					read -p "Dirección a buscar: " direccion
					# ".*#$direccion#.*" = patrón que busca dirección en cualquier posición
					cat $fichero | grep ".*#$direccion#.*" | tr '#' ' '
					;;
				3)
					# BÚSQUEDA POR TELÉFONO
					read -p "Teléfono a buscar: " telefono
					cat $fichero | grep ".*#$telefono" | tr '#' ' '
					;;
			esac
			;;
		3)
			# OPCIÓN LISTAR TODOS LOS CONTACTOS
			# Muestra todo el contenido del archivo formateado
			echo "Lista de contactos:"
			cat $fichero | tr '#' ' '
			;;
		4)
			# OPCIÓN ORDENAR CONTACTOS
			# sort = ordena alfabéticamente por nombre (primer campo)
			echo "Contactos ordenados alfabéticamente:"
			sort $fichero | tr '#' ' '
			echo "Agenda ordenada correctamente."
			;;
		5)
			# OPCIÓN BORRAR AGENDA
			echo "Se va a proceder a eliminar la Agenda"
			read -p "¿Estás seguro? (s/n): " confirmacion
			if [ "$confirmacion" = "s" ] || [ "$confirmacion" = "S" ]
			then
				# rm = comando para eliminar archivos
				if rm $fichero
				then 
					echo "Se ha eliminado la Agenda"
				else 
					echo "No se ha podido eliminar la Agenda"
				fi
			else
				echo "Se ha decidido no eliminar la Agenda"
			fi
			;;
	esac
done