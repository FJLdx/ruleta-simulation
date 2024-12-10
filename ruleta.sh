#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c(){
	echo -e "\n\n${redColour}[!] Saliendo...${endColour}\n"
	tput cnorm; exit 1
}

# Ctrl+C
trap ctrl_c INT

function helpPanel (){
	echo -e "\n${yellowColour}[+]${endColour} ${grayColour}Uso: ${endColour}${purpleColour}$0${endColour} \n"
	echo -e "\t${blueColour}-m)${endColour}${yellowColour} Dinero con el que se desea jugar${endColour}"
	echo -e "\t${blueColour}-t)${endColour}${yellowColour} Tecnica a utilizar${endColour}${purpleColour} (${endColour}${blueColour}martingala${endColour}${purpleColour}/${endColour}${blueColour}inverseLabrouchere${endColour}${purpleColour})${endColour}\n"
	exit 1
}

function martingala(){
	echo -e "\n${yellowColour}[+]${endColour}${grayColour} Dinero actual:${endColour}${greenColour} $money€${endColour}\n"
	echo -ne "${yellowColour}[+]${endColour}${grayColour} ¿Cuanto dinero tienes pensado apostar? ->${endColour} " && read initial_bet
	echo -ne "${yellowColour}[+]${endColour}${grayColour} ¿A que deseas apostar continuamente (par/impar)? ->${endColour} " && read par_impar

	echo -e "\n${yellowColour}[+]${endColour}${grayColour} Vamos a jugar con una cantidad inicial de${endColour}${greenColour} $initial_bet€${endColour}${grayColour} a${endColour}${blueColour} $par_impar${endColour}\n"

	backup_bet=$initial_bet
	play_counter=1
	jugadas_malas="[ "
	max_money=0

	tput civis
	while true; do
		money=$(($money-$initial_bet))
		# echo -e "\n${yellowColour}[+]${endColour}${grayColour}Acabas de apostar${endColour}${blueColour} $initial_bet€${endColour}${grayColour} y tienes:${endColour}${greenColour} $money€${endColour}"
		random_number="$(($RANDOM % 37))"
		# echo -e "${yellowColour}[+]${endColour}${grayColour} Ha salido el numero${endColour}${blueColour} $random_number${endColour}"

    # Esta definición es para cuando apostamos por numeros pares
	if [ ! "$money" -lt 0 ]; then
		if [ "$par_impar" == "par" ]; then
				if [ "$(($random_number % 2))" -eq 0 ]; then
					if [ "$random_number" -eq 0 ]; then
						# echo -e "${yellowColour}[+]${endColour}${redColour} Ha salido el 0, por lo tanto perdemos${endColour}"
						initial_bet=$(($initial_bet*2))
						jugadas_malas+="$random_number "
						# echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes${endColour} ${greenColour}$money€${endColour}"
					else
					# echo -e "${yellowColour}[+]${endColour}${greenColour} El numero que ha salido es par, ¡Ganas!${endColour}"
					reward=$(($initial_bet*2))
					# echo -e "${yellowColour}[+]${endColour}${grayColour} Ganas un total de ${endColour}${greenColour}$reward€${endColour}"
					money=$(($money+$reward))
					if [ "$money" -gt "$max_money" ]; then
						max_money="$money"
					fi
					# echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes${endColour} ${greenColour}$money€${endColour}"
					initial_bet=$backup_bet
					jugadas_malas=""
					fi
				else
					# echo -e "${yellowColour}[+]${endColour} ${redColour}El numero que ha salido es impar, ¡pierdes!${endColour}"
					initial_bet=$(($initial_bet*2))
					jugadas_malas+="$random_number "
					# echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes${endColour} ${greenColour}$money€${endColour}"

				fi
      else
        # Esta definición es para cuando apostamos por numeros impares.
      if [ "$par_impar" == "impar" ]; then
				if [ "$(($random_number % 2))" -eq 1 ]; then
					if [ "$random_number" -eq 0 ]; then
						# echo -e "${yellowColour}[+]${endColour}${redColour} Ha salido el 0, por lo tanto perdemos${endColour}"
						initial_bet=$(($initial_bet*2))
						jugadas_malas+="$random_number "
						# echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes${endColour} ${greenColour}$money€${endColour}"
					else
					# echo -e "${yellowColour}[+]${endColour}${greenColour} El numero que ha salido es impar, ¡Ganas!${endColour}"
					reward=$(($initial_bet*2))
					# echo -e "${yellowColour}[+]${endColour}${grayColour} Ganas un total de ${endColour}${greenColour}$reward€${endColour}"
					money=$(($money+$reward))
					  if [ "$money" -gt "$max_money" ]; then
						max_money="$money"
					  fi
					# echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes${endColour} ${greenColour}$money€${endColour}"
					initial_bet=$backup_bet
					jugadas_malas=""
					fi
				else
					# echo -e "${yellowColour}[+]${endColour} ${redColour}El numero que ha salido es par, ¡pierdes!${endColour}"
					initial_bet=$(($initial_bet*2))
					jugadas_malas+="$random_number "
					# echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes${endColour} ${greenColour}$money€${endColour}"

				fi
      fi
			# sleep 2
		fi
	else
		#nos quedamos sin dinero
		echo -e "\n${redColour}[+] Te has quedado sin pasta${endColour}\n"
    echo -e "${yellowColour}[+]${endColour}${grayColour}Han habido un total de:${endColour}${blueColour} $(($play_counter-1))${endColour}${grayColour} jugadas${endColour}"
		
		echo -e "\n ${yellowColour}[+]${endColour}${grayColour} A continuación se va a reprensentar la racha de malas jugadas que han salido:${endColour}"
		echo -e "${redColour}$jugadas_malas${endColour}"
		echo -e "\n${yellowColour}[+]${endColour}${grayColour} Dinero maximo alcanzado:${endColourn}${greenColour} $max_money${endColour}"
		tput cnorm; exit 0
	fi

	let play_counter+=1
	done
	tput cnorm
}

function inverseLabrouchere (){
	echo -e "\n${yellowColour}[+]${endColour}${grayColour} Dinero actual:${endColour}${greenColour} $money€${endColour}\n"
	echo -ne "${yellowColour}[+]${endColour}${grayColour} ¿A que deseas apostar continuamente (par/impar)? ->${endColour} " && read par_impar

  declare -a my_secuence=(1 2 3 4)

  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Comenzamos con la secuencia${endColour}${purpleColour} [${my_secuence[@]}]${endColour}"
  
  bet=$((${my_secuence[0]} + ${my_secuence[-1]}))

  jugadas_totales=0
  bet_to_renew=$(($money+50)) # Dinero el cual una vez alcanzado hará que renovemos nuestra secuencia a [1 2 3 4] 

  echo -e "${yellowColour}[+]${endColour} El tope a renovar la secuencia está establecido por encima de los ${endColour}${blueColour}$bet_to_renew€${endColour}"

  tput civis
  while true; do
    let jugadas_totales+=1
    random_number=$(($RANDOM % 37))
    money=$(($money - $bet))
	  if [ ! "$money" -lt 0 ]; then
      echo -e "${yellowColour}[+]${endColour}${grayColour} Apostamos${endColour}${greenColour} $bet€${endColour}"
      echo -e "${yellowColour}[+]${endColour}${grayColour} Tenemos${endColour}${greenColour} $money€${endColour}"

      echo -e "\n${yellowColour}[+]${endColour}${grayColour} Ha salido el número${endColour}${blueColour} $random_number${endColour}"

      if [ "$par_impar" == "par" ]; then
        if [ "$(($random_number % 2))" -eq 0 ] && [ "$random_number" -ne 0 ]; then
          echo -e "${yellowColour}[+]${endColour}${grayColour} El numero es par, ¡Ganas!${endColour}"
          reward=$(($bet*2))
          let money+=$reward
          echo -e "${yellowColour}[+]${endColour}${grayColour} Tienes${endColour}${greenColour} $money€${endColour}"
          if [ $money -gt $bet_to_renew ]; then
            echo -e "${yellowColour}[+]${endColour}${grayColour} Se ha superado el tope establecido de${endColour}${greenColour} $bet_to_renew€${endColour}${grayColour} para renovar nuestra secuencia${endColour}"
            bet_to_renew=$(($bet_to_renew + 50))
            echo -e "${yellowColour}[+]${endColour} El tope se ha establecido en: ${endColour}${blueColour}$bet_to_renew€${endColour}"
            my_secuence=(1 2 3 4)
            bet=$((${my_secuence[0]} + ${my_secuence[-1]}))
            echo -e "${yellowColour}[+]${endColour} La secuencia ha sido restablecida a: ${endColour}${blueColour}[${my_secuence[@]}]${endColour}"
          elif [ $money -lt $(($bet_to_renew-100)) ]; then
            echo -e "${yellowColour}[+]${endColour}${grayColour} Hemos llegado a un minimo critico, se procede a reajustar el tope ${endColour}"
            bet_to_renew=$(($bet_to_renew - 50))
            echo -e "${yellowColour}[+]${endColour}${grayColour} El tope ha sido renovado a:${endColour}${blueColour} $bet_to_renew€${endColour}"
            
            my_secuence+=($bet)
            my_secuence=(${my_secuence[@]})

            echo -e "${yellowColour}[+]${endColour}${grayColour} Nuestra nueva secuencia es${endColour}${blueColour} [${my_secuence[@]}]${endColour}"
            if [ "${#my_secuence[@]}" -ne 1 ] && [ "${#my_secuence[@]}" -ne 0 ]; then
              bet=$((${my_secuence[0]} + ${my_secuence[-1]}))
            elif [ "${#my_secuence[@]}" -eq 1 ]; then
              bet=${my_secuence[0]}
            else
              echo -e "${redColour}[!] Hemos perdido nuestra secuencia${endColour}"
              my_secuence=(1 2 3 4)
              echo -e "${yellowColour}[+]${endColour}${grayColour} Restablecemos la secuencia a${endColour}${blueColour} [${my_secuence[@]}]${endColour}"
              bet=$((${my_secuence[0]} + ${my_secuence[-1]}))
            fi
          else
          
            my_secuence+=($bet)
            my_secuence=(${my_secuence[@]})

            echo -e "${yellowColour}[+]${endColour}${grayColour} Nuestra nueva secuencia es${endColour}${blueColour} [${my_secuence[@]}]${endColour}"
            if [ "${#my_secuence[@]}" -ne 1 ] && [ "${#my_secuence[@]}" -ne 0 ]; then
              bet=$((${my_secuence[0]} + ${my_secuence[-1]}))
            elif [ "${#my_secuence[@]}" -eq 1 ]; then
              bet=${my_secuence[0]}
            else
              echo -e "${redColour}[!] Hemos perdido nuestra secuencia${endColour}"
              my_secuence=(1 2 3 4)
              echo -e "${yellowColour}[+]${endColour}${grayColour} Restablecemos la secuencia a${endColour}${blueColour} [${my_secuence[@]}]${endColour}"
              bet=$((${my_secuence[0]} + ${my_secuence[-1]}))
            fi
        fi
        elif [ "$((random_number % 2))" -eq 1 ] || [ "$random_number" -eq 0 ]; then
          if [ "$((random_number % 2))" -eq 1 ]; then
            echo -e "${redColour}[!] El numero es impar, ¡Pierdes!${endColour}"
          else
            echo -e "${redColour}[!] Ha salido el 0, ¡Pierdes!${endColour}"
          fi
          if [ $money -lt $(($bet_to_renew-100)) ]; then
            echo -e "${yellowColour}[+]${endColour}${grayColour} Hemos llegado a un minimo critico, se procede a reajustar el tope ${endColour}"
            bet_to_renew=$(($bet_to_renew - 50))
            echo -e "${yellowColour}[+]${endColour}${grayColour} El tope ha sido renovado a:${endColour}${blueColour} $bet_to_renew€${endColour}"
            
            unset my_secuence[0]
            unset my_secuence[-1] 2>/dev/null

            my_secuence=(${my_secuence[@]})

            echo -e "${yellowColour}[+]${endColour}${grayColour} Nuestra nueva secuencia es${endColour}${blueColour} [${my_secuence[@]}]${endColour}"
            if [ "${#my_secuence[@]}" -ne 1 ] && [ "${#my_secuence[@]}" -ne 0 ]; then
              bet=$((${my_secuence[0]} + ${my_secuence[-1]}))
            elif [ "${#my_secuence[@]}" -eq 1 ]; then
              bet=${my_secuence[0]}
            else
              echo -e "${redColour}[!] Hemos perdido nuestra secuencia${endColour}"
              my_secuence=(1 2 3 4)
              echo -e "${yellowColour}[+]${endColour}${grayColour} Restablecemos la secuencia a${endColour}${blueColour} [${my_secuence[@]}]${endColour}"
              bet=$((${my_secuence[0]} + ${my_secuence[-1]}))
            fi
          else
            unset my_secuence[0]
            unset my_secuence[-1] 2>/dev/null

            my_secuence=(${my_secuence[@]})

            echo -e "${yellowColour}[+]${endColour}${grayColour} La secuencia se queda de la siguiente forma:${endColour}${blueColour} [${my_secuence[@]}${endColour}]"
            
            if [ "${#my_secuence[@]}" -ne 1 ] && [ "${#my_secuence[@]}" -ne 0 ]; then
              bet=$((${my_secuence[0]} + ${my_secuence[-1]}))
            elif [ "${#my_secuence[@]}" -eq 1 ]; then
              bet=${my_secuence[0]}
            else
              echo -e "${redColour}[!] Hemos perdido nuestra secuencia${endColour}"
              my_secuence=(1 2 3 4)
              echo -e "${yellowColour}[+]${endColour}${grayColour} Restablecemos la secuencia a${endColour}${blueColour} [${my_secuence[@]}]${endColour}"
              bet=$((${my_secuence[0]} + ${my_secuence[-1]}))
            fi
          fi
        fi
      fi
    else
     		#nos quedamos sin dinero
		echo -e "\n${redColour}[+] Te has quedado sin pasta${endColour}\n"
    echo -e "${yellowColour}[+]${endColour}${grayColour} En total han habido${endColour}${blueColour} $jugadas_totales${endColour}${grayColour} jugadas totales${endColour}"
		tput cnorm; exit 0
 
    fi

    # sleep 1
  done
  tput cnorm
}

while getopts "m:t:h" arg; do
	case $arg in
		m) money=$OPTARG;;
		t) technique=$OPTARG;;
		h) helpPanel;;
	esac
done

if [ $money ] && [ $technique ]; then
	if [ "$technique" == "martingala" ]; then
		martingala
  elif [ "$technique" == "inverseLabrouchere" ]; then
    inverseLabrouchere
	else
		echo -e "\n${redColour}[!] La técnica introducida no existe${endColour}"
		helpPanel
	fi
else
	helpPanel
fi
