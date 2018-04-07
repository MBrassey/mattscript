#!/usr/bin/env bash
#                 __   __                   __       __   
# .--------.---.-|  |_|  |_.-----.----.----|__.-----|  |_ 
# |        |  _  |   _|   _|__ --|  __|   _|  |  _  |   _|
# |__|__|__|___._|____|____|_____|____|__| |__|   __|____|
#                                      v1.0.0 |__| 

#Colors
reset="$(tput sgr0)"
#black="$(tput bold; tput setaf 0)"
blue="$(tput bold; tput setaf 4)"
cyan="$(tput bold; tput setaf 6)"
green="$(tput bold; tput setaf 2)"
purple="$(tput bold; tput setaf 5)"
#red="$(tput bold; tput setaf 1)"
#white="$(tput bold; tput setaf 7)"
#yellow="$(tput bold; tput setaf 3)"
#orange="$(tput bold; tput setaf 166)"
#violet="$(tput bold; tput setaf 61)"
host="${blue}$HOSTNAME${reset}"
header="${cyan}[ ${reset}${green}${reset}${cyan}mattscript @ ${reset}${host}${cyan} ]    ${reset}"

#Arguments
version=${cyan}1.0.0${reset}

license="
${cyan}${reset} mattscript v${version}

        ${purple}Copyright (C) 2018 Matthew A. Brassey${reset}

        This program is free software: you can redistribute it and/or modify
        it under the terms of the GNU General Public License as published by
        the Free Software Foundation, either version 3 of the License, or
        (at your option) any later version.

        This program is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        GNU General Public License for more details.

        You should have received a copy of the GNU General Public License
        along with this program.  If not, see <http://www.gnu.org/licenses/>.
"

help="
${cyan}Usage:${cyan}${green} ./mattscript.sh ${reset}${purple}[--help|--version]${reset}

${cyan}[options]${reset}${green}
        --license       Show license information.
        --about         What is mattscript?${reset}
"

about="
${cyan}${reset} mattscript v${version}

        Is my template for new bash scripts. 
"

#Variables
args=("$@")
endscript="false"
minutes="1"
IFS='
'

#Functions
function panel() {
       start=$SECONDS
       clear
       echo "$header"
       echo ""
       echo "$about"
       echo ""

#Sleep sequence
       completed
       secs=$((minutes * 60))
       while [ $secs -gt 0 ]; do
          echo -ne "${blue}╰────╼${reset}${green} Re-launch in:${reset} ${cyan}$secs\\033[0Ks    \\r${reset}"
          sleep 1
          : $((secs--))
       done
}

function completed(){
      duration=$(( SECONDS - start ))
      echo "${blue}╭────╼${reset}${purple} Completed in: ${reset}${cyan}$duration${reset}${cyan}s${reset}"
}

#Arguments
for ((arg=0;arg<"${#args[@]}";arg++)); do
        [ "${args[$arg]}" == "--version" ] && echo "${version}" && exit
        [ "${args[$arg]}" == "--help" ] && echo "${help}" && exit
        [ "${args[$arg]}" == "--license" ] && echo "${license}" && exit
        [ "${args[$arg]}" == "--about" ] && echo "${about}" && exit
        #[ "${args[$arg]}" == "--" ] && echo ${args[$arg]}
done

#Activate panel
while [ $endscript = "false" ]
do
        panel
done
