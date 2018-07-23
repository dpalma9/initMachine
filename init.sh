#/bin/bash!

#**************
# CABECERA
#**************
# Descripcion: Install software to workstation.
# Version: 1.0
# Autor: Daniel Palna
# Fecha creacion/modificacion: 23 Jul 2018
# Entrada: Ninguna
# Salida:
#**************



#**************
# VARS BLOCK


#**************

help() {
    echo ""
    echo "#####################################"
    echo "#  Help Menu  #"
    echo "#####################################"
    echo ""
    echo "Uso: $0 [update|tool]" >&2
    echo ""
    echo "         -h, -H, --help                 Execution help"
    echo ""
    echo "Para ejecutar el script tendremos que hacerlo ejecutándolo con alguna de las opciones descritas"
    echo "y proseguir seleccionando opciones de los menus que se nos presentarán."
    echo "Ejemplo Uso: "
    echo "             $0 update"
    echo "             $0 tool"
    echo ""
}

#**************
# CUERPO
#**************

#Ayuda del script
while true; do
case "$OPTION" in
    -[hH] | --help)
        help
        break
    ;;

    update)
        update
        break
    ;;

    tool)
        tool
        break
    ;;


    *) #Fin de las opciones
        echo ""
		echo "=========================================================================="
		echo " INFO: Por favor, revisa la ayuda del script para lanzarlo correctamente."
		echo "=========================================================================="
		echo ""
		sleep 1
		help
        exit 1
    ;;
esac
done
## fin de bucle de lectura inicial
