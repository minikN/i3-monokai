#!/bin/env bash

# Installation script
# by minikN
# run ./install.sh with no arguments
# to see the help menu.

# Dotfiles to install
# customize this array to
# your liking.
#
# All dotfiles are located in the 'files'
# folder.
declare -a FILES=(
	".xinitrc"
	".Xresources"
	".zshrc"
	".vimrc"
	".vim"
    ".config/.phpcsfixer"
	".config/polybar"
	".config/i3"
	".config/tuzk"
	".config/backgrounds"
	".config/scripts"
	".config/rofi"
	".config/mondo"
    ".config/tuzk"
	".config/Xresources"
)

# Change backup directory
BACKUP="$HOME/.backup"

# Do not change anything from here on out.
BASEDIR=$(pwd)

RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
BOLD="\033[1m"
RESET="\033[0m"

if [[ $1 == "symlink" || $1 == "copy" ]]; then
	if [[ $1 == "symlink" ]]; then
		printf "${GREEN}INFO:${RESET} ${BOLD}SYMLINK${RESET} argument supplied. Starting symlink creation.\n"
	fi

	if [[ $1 == "copy" ]]; then
		printf "${GREEN}INFO:${RESET} ${BOLD}COPY${RESET} argument supplied. Starting copying files.\n"
	fi

	if ! [[ -e $BACKUP ]]; then
		printf "${GREEN}INFO:${RESET} Creating temporary directory: ${YELLOW}$BACKUP${RESET}.\n"
		mkdir $BACKUP
	fi

	# Abort if backup folder exists and already has backup files
	# otherwise we would override the files (no good).
	for FILE in "${FILES[@]}"
	do
		if [ -e $HOME/$FILE ]; then
			if [ -e $BACKUP/$FILE ]; then
				printf "${RED}ERROR:${RESET} Configuration file ${YELLOW}$BACKUP/$FILE${RESET} Already exists. Aborting.\n"
				exit 1
			fi
		fi
	done

	# Installation
	for FILE in "${FILES[@]}"
	do
		if [ -e $HOME/$FILE ]; then
			printf "${GREEN}INFO:${RESET} Configuration found. Backing ${YELLOW}$FILE${RESET} up to: $BACKUP/$FILE.\n"

			if [[ $FILE == *\/* ]]; then
				mkdir -p $BACKUP/"${FILE%/*}"
			fi
			mv $HOME/$FILE $BACKUP/$FILE

		fi

		if [[ $FILE == *\/* ]]; then
			mkdir -p $HOME/"${FILE%/*}"
		fi

		if [[ $1 == "copy" ]]; then
			printf "${GREEN}INFO:${RESET} Copying file: ${RED}$FILE${RESET}\n"
			cp -r  $BASEDIR/files/$FILE $HOME/$FILE
		else
			printf "${GREEN}INFO:${RESET} Creating symlink: ${RED}$FILE${RESET}\n"
			ln -sf $BASEDIR/files/$FILE $HOME/$FILE
		fi
	done

	# Granting execute permissons
	for filename in $HOME/.config/scripts/*.sh
	do
		if [[ -e $filename ]]; then
			printf "${YELLOW}SCRIPT:${RESET} Granting execute permissions: ${RED}$filename${RESET}.\n"
			chmod +x $filename
		fi
	done

	# Handling backup folder post install
	if [ -z "$(ls -A $BACKUP)" ]; then
		printf "${GREEN}INFO:${RESET} No backups needed. Deleting temporary directory: ${YELLOW}$BACKUP${RESET}.\n"
		rm -rf $BACKUP
	else
		printf "${GREEN}INFO:${RESET} Backups created in: ${YELLOW}$BACKUP${RESET}.\n"
	fi
	printf "${GREEN}INFO:${RESET} ${BOLD}Everything done. Cheers.${RESET}\n"

elif [[ $1 == "clean" ]]; then
	printf "${GREEN}INFO:${RESET} ${BOLD}CLEAN${RESET} argument supplied. Cleaning configuration and restoring backup.\n"

	for FILE in "${FILES[@]}"
	do
		if [ -e $HOME/$FILE ]; then
			printf "${GREEN}INFO:${RESET} Deleting configuration: ${RED}$FILE${RESET}\n"
			rm -rf  $HOME/$FILE
		fi
		if [ -e $BACKUP/$FILE ]; then
			printf "${GREEN}INFO:${RESET} Found backup: ${YELLOW}$FILE${RESET}. Restoring.\n"
			mv  $BACKUP/$FILE $HOME/$FILE
		fi
	done
	if [ -d "$BACKUP" ]; then
		if [ -z "$(ls -A $BACKUP)" ]; then
			printf "${GREEN}INFO:${RESET} Backup directory empty. Deleting: ${YELLOW}$BACKUP${RESET}.\n"
			rm -rf $BACKUP
		else
			printf "${YELLOW}WARNING:${RESET} Backup directory not empty. Not deleting: ${YELLOW}$BACKUP${RESET}.\n"
		fi
	fi
	printf "${GREEN}INFO:${RESET} ${BOLD}Everything done. Cheers.${RESET}\n"
else
	printf "${RED}${BOLD}HELP / INFORMATION\n"
	printf "${RESET}${BOLD}Any configuration files you already have will be backed up!${RESET}\n"
	printf "Backup folder: ${YELLOW}$BACKUP${RESET}.\n"
	printf "You can change the backup folder by editing the ${YELLOW}BACKUP${RESET} variable (line 10).\n\n"
	printf "${BOLD}Usage:${RESET} ./install.sh [ARGUMENT]\n\n"
	printf "${BOLD}Argument	Definition${RESET}\n"
	printf "${RESET}${GREEN}symlink		${RESET}Creates configuration files as symlinks.\n"
	printf "${GREEN}copy		${RESET}Copies configuration files directly.\n"
	printf "${GREEN}clean		${RESET}Deletes all files / symlinks and restores backup files (if available).\n"
	printf "${GREEN}(no argument)	${RESET}Display this menu.\n"
	printf "\n"
	printf "${RED}WARNING:${RESET} Running the ${BOLD}clean${RESET} argument without having run ${BOLD}symlink${RESET} or ${BOLD}copy${RESET} before will delete your default (yellow file names below) configuration files from ${YELLOW}$HOME${RESET}!\n"
	printf "Only run the cleanup if you did run one of the other two before and want to return to your default setup.\n\n"
	printf "What files will be worked with?\n${YELLOW}"
	printf '%s\n' "${FILES[@]}"
fi

