#!/bin/zsh

FILES=(
	'.xinitrc'
	'.zshrc'
	'.config/i3/config'
)

# Change backup directory
BACKUP="$HOME/.backup"
BASEDIR=$(pwd)

# Colors
RED="\033[1;31m"
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
LGREEN="\033[1;92m"
NOCOLOR="\033[0m"
BOLD="\033[1m"

if [[ $1 == "symlink" || $1 == "copy" ]]; then
	if [[ $1 == "symlink" ]]; then
		printf "${GREEN}INFO:${NOCOLOR} ${BOLD}SYMLINK${NOCOLOR} argument supplied. Starting symlink creation.\n"
	fi

	if [[ $1 == "copy" ]]; then
		printf "${GREEN}INFO:${NOCOLOR} ${BOLD}COPY${NOCOLOR} argument supplied. Starting copying files.\n"
	fi

	if ! [[ -e $BACKUP ]]; then
		printf "${GREEN}INFO:${NOCOLOR} Creating temporary directory: ${YELLOW}$BACKUP${NOCOLOR}.\n"
		mkdir $BACKUP
	fi

	for FILE in $FILES; do
		if [ -e $HOME/$FILE ]; then
			if [ -e $BACKUP/$FILE ]; then
				printf "${RED}ERROR:${NOCOLOR} Configuration file ${YELLOW}$BACKUP/$FILE${NOCOLOR} Already exists. Aborting.\n"
				exit 1
			fi
		fi
	done	
	for FILE in $FILES; do
		if [ -e $HOME/$FILE ]; then
			printf "${GREEN}INFO:${NOCOLOR} Configuration found. Backing ${YELLOW}$FILE${NOCOLOR} up to: $BACKUP/$FILE.\n" 
			
			if [[ $FILE == *\/* ]]; then
				mkdir -p $BACKUP/"${FILE%/*}"
			fi
			mv $HOME/$FILE $BACKUP/$FILE

		fi
	
		if [[ $FILE == *\/* ]]; then
			mkdir -p $HOME/"${FILE%/*}"
		fi

		if [[ $1 == "copy" ]]; then
			printf "${GREEN}INFO:${NOCOLOR} Copying file: ${RED}$FILE${NOCOLOR}\n"
			cp $BASEDIR/$FILE $HOME/$FILE
		else
			printf "${GREEN}INFO:${NOCOLOR} Creating symlink: ${RED}$FILE${NOCOLOR}\n"
			ln -sf $BASEDIR/$FILE $HOME/$FILE
		fi

	done

	if [ -z "$(ls -A $BACKUP)" ]; then
		printf "${GREEN}INFO:${NOCOLOR} No backups needed. Deleting temporary directory: ${YELLOW}$BACKUP${NOCOLOR}.\n" 
		rm -rf $BACKUP
	else
		printf "${GREEN}INFO:${NOCOLOR} Backups created in: ${YELLOW}$BACKUP${NOCOLOR}.\n"
	fi
	printf "${GREEN}INFO:${NOCOLOR} ${BOLD}Everything done. Cheers.${NOCOLOR}\n"

elif [[ $1 == "clean" ]]; then
	printf "${GREEN}INFO:${NOCOLOR} ${BOLD}CLEAN${NOCOLOR} argument supplied. Cleaning configuration and restoring backup.\n"	
	
	for FILE in $FILES; do
		if [ -e $HOME/$FILE ]; then
			printf "${GREEN}INFO:${NOCOLOR} Deleting configuration: ${RED}$FILE${NOCOLOR}\n" 
			rm -rf  $HOME/$FILE
		fi
		if [ -e $BACKUP/$FILE ]; then
			printf "${GREEN}INFO:${NOCOLOR} Found backup: ${YELLOW}$FILE${NOCOLOR}. Restoring.\n" 
			mv  $BACKUP/$FILE $HOME/$FILE
		fi
	done
	if [ -d "$BACKUP" ]; then
		if [ -z "$(ls -A $BACKUP)" ]; then
			printf "${GREEN}INFO:${NOCOLOR} Backup directory empty. Deleting: ${YELLOW}$BACKUP${NOCOLOR}.\n" 
			rm -rf $BACKUP
		else
			printf "${YELLOW}WARNING:${NOCOLOR} Backup directory not empty. Not deleting: ${YELLOW}$BACKUP${NOCOLOR}.\n"
		fi
	fi
	printf "${GREEN}INFO:${NOCOLOR} ${BOLD}Everything done. Cheers.${NOCOLOR}\n"
else
	printf "${RED}${BOLD}HELP / INFORMATION\n"
	printf "${NOCOLOR}${BOLD}Any configuration files you already have will be backed up!${NOCOLOR}\n"
	printf "Backup folder: ${YELLOW}$BACKUP${NOCOLOR}.\n"
	printf "You can change the backup folder by editing the ${YELLOW}BACKUP${NOCOLOR} variable (line 10).\n"
	printf "Be sure to set ${BOLD}chmod +x install.sh${NOCOLOR}\n\n"
	printf "${BOLD}Usage:${NOCOLOR} ./install.sh [ARGUMENT]\n\n"
	printf "${BOLD}Argument	Definition${NOCOLOR}\n"
	printf "${NOCOLOR}${LGREEN}symlink		${NOCOLOR}Creates configuration files as symlinks.\n"
	printf "${LGREEN}copy		${NOCOLOR}Copies configuration files directy.\n"
	printf "${LGREEN}clean		${NOCOLOR}Deletes all files / symlinks and restores backup files (if available).\n"	
	printf "${LGREEN}(no argument)	${NOCOLOR}Display this menu.\n"
	printf "\n"
	printf "${RED}WARNING:${NOCOLOR} Running the ${BOLD}clean${NOCOLOR} argument without having run ${BOLD}symlink${NOCOLOR} or ${BOLD}copy${NOCOLOR} before will delete your default (yellow file names below) configuration files from ${YELLOW}$HOME${NOCOLOR}!\n"
	printf "Only run the cleanup if you did run one of the other two before and want to return to your default setup.\n\n"
	printf "What files will be worked with?\n${YELLOW}"
	printf '%s\n' "${FILES[@]}"
fi	

