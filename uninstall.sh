#!/bin/bash

#Setup script for Dotfiles
arg=$1

#echo -e "\u001b[32;1mSetting up Dotfiles...\u001b[0m"
#
#if [[ "$arg" == "-i" || "$arg" == "--install" ]]; then
#
#    echo -e "\u001b[37;1m\u001b[4mSelect an option:\u001b[0m"
#    echo -e "  \u001b[34;1m 1) for Oh-My-Zsh \u001b[0m"
#    echo -e "  \u001b[34;1m 2) for Powerlevel10K \u001b[0m"
#    echo -e "  \u001b[34;1m 3) for Custom ZSH plugins \u001b[0m"
#    echo -e "  \u001b[34;1m 4) for Vundle \u001b[0m"
#    echo -e "  \u001b[31;1m 0) to Exit \u001b[0m"
#
#    read option
#
#    case $option in
#
#    "1")echo -e "\u001b[7mInstalling Oh-My-Zsh...\u001b[0m"
#        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
#        ;;
#
#    "2")echo -e "\u001b[7mInstalling Powerlevel10K...\u001b[0m"
#        git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
#        ;;
#
#    "3")echo -e "\u001b[7m Installing Custom zsh plugins... \u001b[0m"
#        git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
#        git clone https://github.com/zdharma/fast-syntax-highlighting.git $ZSH_CUSTOM/plugins/fast-syntax-highlighting
#        git clone https://github.com/djui/alias-tips.git $ZSH_CUSTOM/plugins/alias-tips
#        ;;
#
#    "4")echo -e "\u001b[7m Installing Vundle... \u001b[0m"
#        git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#        vim +PluginUpdate +qall
#        ;;
#
#    "0")echo -e "\u001b[4m\u001b[44m Bye \u001b[0m"
#        exit 0
#        ;;
#
#    *)echo -e "\u001b[31;1m Invalid option entered. \u001b[0m"
#        exit 1
#        ;;
#    esac
#
#    exit 0
#fi

echo -e "\u001b[33;1m Restoring from backups... \u001b[0m"
#mv -iv ~/.Xresources ~/.Xresources.old
#mv -iv ~/.config/i3 ~/.config/i3.old
#mv -iv ~/.config/i3status ~/.config/i3status.old
#mv -iv ~/.config/libinput-gestures.conf ~/.config/libinput-gestures.conf.old
#mv -iv ~/.config/ranger ~/.config/ranger.old
#mv -iv ~/.dmenurc ~/.dmenurc.old
#mv -iv ~/.gitconfig ~/.gitconfig.old
rm ~/.tmux.conf
rm ~/.vimrc
rm ~/.zshrc
mv -iv ~/.tmux.conf.old ~/.tmux.conf
mv -iv ~/.vimrc.old ~/.vimrc
mv -iv ~/.zshrc ~/.zshrc.old
echo -e "\u001b[32;1m Completed. \u001b[0m"
