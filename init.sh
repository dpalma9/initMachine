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

OPTION=$1

#**************

help() {
    echo ""
    echo "#####################################"
    echo "#  Help Menu  #"
    echo "#####################################"
    echo ""
    echo "Uso: $0 [update|tools]" >&2
    echo ""
    echo "         -h, -H, --help                 Execution help"
    echo ""
    echo "Para ejecutar el script tendremos que hacerlo ejecutándolo con alguna de las opciones descritas"
    echo "y proseguir seleccionando opciones de los menus que se nos presentarán."
    echo "Ejemplo Uso: "
    echo "             $0 update"
    echo "             $0 tools"
    echo ""
}

tools() {
   echo ""
   echo "#  Tools Menu  #"
   echo ""
   echo "Choose an option: "
   echo "1. Install Google Chrome."
   echo "2. Install zsh and oh-my-zsh."
   echo "3. Install Spotify."
   echo "4. Install Gnome Tweak Tool."
   read -p OPTION

   case "$OPTION" in
	   1) 
		   gChrome
           ;;

           2) 
		   zsh
	   ;;

           3)
		  spotify
	   ;;

           4)
	          gnomeTool
	   ;;

   esac 
	
}

gChrome() {
   echo "Downloading Google Chrome..."
   wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
   chrome=`ls | grep google`
   sudo dpkg -i $chrome
   echo "Deleting .deb package..."
   rm -rf $chrome
}

basic() {
packages="curl wget vim apt-transport-https ca-certificates software-properties-common"

   echo "Installing basic packages..."
   sudo apt install -y $packages
}

zsh() {
  
   echo "Initializing zsh env..."
   sudo apt-get install zsh
   chsh -s $(which zsh)
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
   cp ./zsh/.zshrc ~/.zshrc
   cp ./zsh/dani.zsh-theme ~/.oh-my-zsh/themes/
}

spotify() {

   echo "Installing Spotify..."
   sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
   echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
   sudo apt-get update && sudo apt install spotify-client
}

gnomeTool() {

  echo "Installing Gnome Tweak Tool..."
  sudo apt install gnome-tweak-tool
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

    tools)
        tools
        break
    ;;

    basic)
        basic
	break
    ;;

    test)
	    echo "test"
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
