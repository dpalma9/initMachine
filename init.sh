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
    echo "Uso: $0 [update|tools|basic|custom]" >&2
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
		sudo apt install gnome-themes-standard
		xarcV=1.4.7
		wget https://gitlab.com/LinxGem33/X-Arc-White/uploads/26bccc81678392584149afa3167f8e78/osx-arc-collection_"$xarcV"_amd64.deb
                sudo dpkg -i $root_path/osx-arc-collection_"$xarcV"_amd64.deb
		rm -rf $root_path/osx-arc-collection_"$xarcV"_amd64.deb
	   ;;

           *) #end of options
	           echo "Not valid option!"
                   exit 1
           ;;

   esac
}

update() {

  echo "WARNING: Upgrading system..."
  sudo apt update
  sudo apt -V upgrade
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
   echo "6. Install Telegram."
   echo "7. Install vundle (vim plugin)."
   echo "8. Install fzf (historical)."
   read -p "Choose an option: " OPTION

   case "$OPTION" in
	   1) 
		   gChrome
           ;;

           2) 
		   zsh
		   custom_zsh
           install_powerlevel10k
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

           6)
		  teleV=1.3.10
		  echo "Installing Telegram."
		  wget https://telegram.org/dl/desktop/linux/tsetup."teleV".tar.xz
		  tar -Jxvf $root_path/tsetup."teleV".tar.xz
		  mv $root_path/Telegram $HOME
		  rm tsetup."teleV".tar.xz

           ;;

           7)
		  vundle
	   ;;

           8)
		  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
		  ~/.fzf/install
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
packages="curl wget apt-transport-https ca-certificates software-properties-common gitk"

   echo "Installing packages: $packages"
   sudo apt install -y $packages
   echo "Now, installing bashtop: "
   sudo add-apt-repository ppa:bashtop-monitor/bashtop
   sudo apt update
   sudo apt install bashtop
   echo "Visit: https://github.com/aristocratos/bashtop"
}

zsh() {
  
   echo "Initializing zsh env..."
   sudo apt-get install zsh
   command -v zsh | sudo tee -a /etc/shells
   chsh -s "$(command -v zsh)" "${USER}"
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

custom_zsh() {

   echo "Starting customizing zsh"
   cp $root_path/zsh/zshrc $HOME/.zshrc
   cp $root_path/zsh/dani.zsh-theme $HOME/.oh-my-zsh/themes/
   chown $USER:$USER $HOME/.zshrc 
   chown -R $USER:$USER $HOME/.oh-my-zsh
   echo "Now we're going to install the autosuggestions zsh plugin..."
   git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
   echo "Now we're going to install the zsh-syntax-highlighting zsh plugin..."
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
   echo "Instaling exa. Take a look to their website: https://the.exa.website/"
   sudo apt install exa
}

install_powerlevel10k() {
    read -p "Do you want to install powerlevel10k? (y/n)" confirm
    if [[ $confirm == [yY] ]]
    then
        git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
        echo "Install fonts before configure powerlevel10k."
        echo "Visit https://github.com/romkatv/powerlevel10k/blob/master/font.md#manual-font-installation"
        echo "Now type 'p10k configure' to configure powerlevel10k"
    fi
}

vundle() {

   echo "Installing Vundle..."
   git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
   echo "Visit: https://github.com/VundleVim/Vundle.vim"
   echo "Copying .vimrc config"
   cp $root_path/vim/vimrc $HOME/.vimrc
   chown $USER:$USER $HOME/.vimrc
   echo "Open vim and execute :PluginInstall"
}

spotify() {

   echo "Installing Spotify..."
   #sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 931FF8E79F0876134EDDBDCCA87FF9DF48BF1C90
   #echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
   #sudo apt-get update && sudo apt install spotify-client
   snap install spotify
}

gnomeTool() {

  guide="https://itsfoss.com/gnome-shell-extensions/"

  echo "Installing Gnome Tweak Tool..."
  sudo apt install -y gnome-tweak-tool gnome-shell-extensions
  echo "Don't forget to install the necessary plugin in Firefox or Chrome to install plugins."
  sleep 2
  echo "Visit $guide"
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
