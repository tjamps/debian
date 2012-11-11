#!/bin/bash
# Enables fancy colors for bash :)

# cecho : color echo
function cecho() {
	# Available colors
	# Reset
	Color_Off='\e[0m'       # Text Reset

	# Regular Colors
	Black='\e[0;30m'        # Black
	Red='\e[0;31m'          # Red
	Green='\e[0;32m'        # Green
	Yellow='\e[0;33m'       # Yellow
	Blue='\e[0;34m'         # Blue
	Purple='\e[0;35m'       # Purple
	Cyan='\e[0;36m'         # Cyan
	White='\e[0;37m'        # White

	# Bold
	BBlack='\e[1;30m'       # Black
	BRed='\e[1;31m'         # Red
	BGreen='\e[1;32m'       # Green
	BYellow='\e[1;33m'      # Yellow
	BBlue='\e[1;34m'        # Blue
	BPurple='\e[1;35m'      # Purple
	BCyan='\e[1;36m'        # Cyan
	BWhite='\e[1;37m'       # White

	# Underline
	UBlack='\e[4;30m'       # Black
	URed='\e[4;31m'         # Red
	UGreen='\e[4;32m'       # Green
	UYellow='\e[4;33m'      # Yellow
	UBlue='\e[4;34m'        # Blue
	UPurple='\e[4;35m'      # Purple
	UCyan='\e[4;36m'        # Cyan
	UWhite='\e[4;37m'       # White

	# Background
	On_Black='\e[40m'       # Black
	On_Red='\e[41m'         # Red
	On_Green='\e[42m'       # Green
	On_Yellow='\e[43m'      # Yellow
	On_Blue='\e[44m'        # Blue
	On_Purple='\e[45m'      # Purple
	On_Cyan='\e[46m'        # Cyan
	On_White='\e[47m'       # White

	# High Intensity
	IBlack='\e[0;90m'       # Black
	IRed='\e[0;91m'         # Red
	IGreen='\e[0;92m'       # Green
	IYellow='\e[0;93m'      # Yellow
	IBlue='\e[0;94m'        # Blue
	IPurple='\e[0;95m'      # Purple
	ICyan='\e[0;96m'        # Cyan
	IWhite='\e[0;97m'       # White

	# Bold High Intensity
	BIBlack='\e[1;90m'      # Black
	BIRed='\e[1;91m'        # Red
	BIGreen='\e[1;92m'      # Green
	BIYellow='\e[1;93m'     # Yellow
	BIBlue='\e[1;94m'       # Blue
	BIPurple='\e[1;95m'     # Purple
	BICyan='\e[1;96m'       # Cyan
	BIWhite='\e[1;97m'      # White

	# High Intensity backgrounds
	On_IBlack='\e[0;100m'   # Black
	On_IRed='\e[0;101m'     # Red
	On_IGreen='\e[0;102m'   # Green
	On_IYellow='\e[0;103m'  # Yellow
	On_IBlue='\e[0;104m'    # Blue
	On_IPurple='\e[10;95m'  # Purple
	On_ICyan='\e[0;106m'    # Cyan
	On_IWhite='\e[0;107m'   # White

	if [ $# -lt 2 ]; then
		echo "Usage: cecho color message"
		echo 
		echo "Supported colors"
		echo -e "${Black}Taste the rainbow !${Color_Off}  ${Red}Taste the rainbow !${Color_Off}  ${Green}Taste the rainbow !${Color_Off}  ${Yellow}Taste the rainbow !${Color_Off}"
		echo -e "${Blue}Taste the rainbow !${Color_Off}  ${Purple}Taste the rainbow !${Color_Off}  ${Cyan}Taste the rainbow !${Color_Off}  ${White}Taste the rainbow !${Color_Off}"

		echo -e "${BBlack}Taste the rainbow !${Color_Off}  ${BRed}Taste the rainbow !${Color_Off}  ${BGreen}Taste the rainbow !${Color_Off}  ${BYellow}Taste the rainbow !${Color_Off}"
		echo -e "${BBlue}Taste the rainbow !${Color_Off}  ${BPurple}Taste the rainbow !${Color_Off}  ${BCyan}Taste the rainbow !${Color_Off}  ${BWhite}Taste the rainbow !${Color_Off}"

		echo -e "${UBlack}Taste the rainbow !${Color_Off}  ${URed}Taste the rainbow !${Color_Off}  ${UGreen}Taste the rainbow !${Color_Off}  ${UYellow}Taste the rainbow !${Color_Off}"
		echo -e "${UBlue}Taste the rainbow !${Color_Off}  ${UPurple}Taste the rainbow !${Color_Off}  ${UCyan}Taste the rainbow !${Color_Off}  ${UWhite}Taste the rainbow !${Color_Off}"

		echo -e "${IBlack}Taste the rainbow !${Color_Off}  ${IRed}Taste the rainbow !${Color_Off}  ${IGreen}Taste the rainbow !${Color_Off}  ${IYellow}Taste the rainbow !${Color_Off}"
		echo -e "${IBlue}Taste the rainbow !${Color_Off}  ${IPurple}Taste the rainbow !${Color_Off}  ${ICyan}Taste the rainbow !${Color_Off}  ${IWhite}Taste the rainbow !${Color_Off}"

		echo -e "${BIBlack}Taste the rainbow !${Color_Off}  ${BIRed}Taste the rainbow !${Color_Off}  ${BIGreen}Taste the rainbow !${Color_Off}  ${BIYellow}Taste the rainbow !${Color_Off}"
		echo -e "${BIBlue}Taste the rainbow !${Color_Off}  ${BIPurple}Taste the rainbow !${Color_Off}  ${BICyan}Taste the rainbow !${Color_Off}  ${BIWhite}Taste the rainbow !${Color_Off}"

		echo -e "${On_Black}Taste the rainbow !${Color_Off}  ${On_Red}Taste the rainbow !${Color_Off}  ${On_Green}Taste the rainbow !${Color_Off}  ${On_Yellow}Taste the rainbow !${Color_Off}"
		echo -e "${On_Blue}Taste the rainbow !${Color_Off}  ${On_Purple}Taste the rainbow !${Color_Off}  ${On_Cyan}Taste the rainbow !${Color_Off}  ${On_White}Taste the rainbow !${Color_Off}"

		echo -e "${On_IBlack}Taste the rainbow !${Color_Off}  ${On_IRed}Taste the rainbow !${Color_Off}  ${On_IGreen}Taste the rainbow !${Color_Off}  ${On_IYellow}Taste the rainbow !${Color_Off}"
		echo -e "${On_IBlue}Taste the rainbow !${Color_Off}  ${On_IPurple}Taste the rainbow !${Color_Off}  ${On_ICyan}Taste the rainbow !${Color_Off}  ${On_IWhite}Taste the rainbow !${Color_Off}"

		# EXIT_FAILURE
		return 1
	fi

	color="$1"
	color_sequence=$(eval echo \$$color)

	shift
	message="$*"
	
	echo -e "${color_sequence}${message}${Color_Off}"

	# EXIT_SUCCESS
	return 0
}
