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
root_path=`pwd`

#**************

help() {
    echo ""
    echo "#####################################"
    echo "#  Help Menu  #"
    echo "#####################################"
    echo ""
    echo "Uso: $0 [update|tools|baic|custom]" >&2
    echo ""
    echo "         -h, -H, --help                 Execution help"
    echo ""
    echo "Para ejecutar el script tendremos que hacerlo ejecutándolo con alguna de las opciones descritas"
    echo "y proseguir seleccionando opciones de los menus que se nos presentarán."
    echo "Ejemplo Uso: "
    echo "             $0 update"
    echo "             $0 tools"
    echo ""
    echo "NOTE: tools option will open a menu to choose which tool you want to install."
    echo ""
}

custom() {

  echo ""
  echo"# Customize menu  #"
  echo ""
  echo "1. Numix Gtk theme and icon pack."
  echo "2. X-Arc theme."
  read -p "Choose an option: " OPTION

  case "$OPTION" in
           1)
		sudo add-apt-repository ppa:numix/ppa
		sudo apt-get update
		sudo apt-get install numix-gtk-theme numix-icon-theme-circle
	   ;;

           2)
		echo "WARNING: Need to install gnome-themes-standard package. Installing..."
		apt install gnome-themes-standard
		xarcV=1.4.7
		wget https://gitlab.com/LinxGem33/X-Arc-White/uploads/26bccc81678392584149afa3167f8e78/osx-arc-collection_"$xarcV"_amd64.deb
                dpkg -i $root_path/osx-arc-collection_"$xarcV"_amd64.deb
		rm -rf $root_path/osx-arc-collection_"$xarcV"_amd64.deb
	   ;;

           *) #end of options
	           echo "Not valid option!"
                   exit 1
           ;;

   esac
}

tools() {

   echo ""
   echo "#  Tools Menu  #"
   echo ""
   echo "1. Install Google Chrome."
   echo "2. Install zsh and oh-my-zsh."
   echo "3. Install Spotify."
   echo "4. Install Gnome Tweak Tool."
   echo "5. Install tilix and pokemon terminal."
   read -p "Choose an option: " OPTION

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

           5)
		  echo "(WARNING!) This will be to install python pip 3i.6!"
		  sudo apt-get install python3-pip
		  sudo apt install tilix
		  sudo pip3 install git+https://github.com/LazoCoder/Pokemon-Terminal.git
	   ;; 

           *) #fin de las opciones

		   echo "Not valid option!"
		   exit 1 
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

   echo "Installing packages: $packages"
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

    custom)
	custom
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
