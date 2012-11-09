#!/bin/bash
function usage() {
	echo "Usage: `basename $0` host iterations output_file [delay]"
	echo
	echo "  host           Adresse à tester."
	echo "  iterations     Nombre d'itérations à effectuer."
	echo "  output_file    Nom du fichier de sortie (format PNG)."
	echo "  delay          Optionnel. Délai entre les requêtes (en secondes)." 
	echo 
}

# Pré-requis
for cmd in gnuplot curl;
do
	if ! which $cmd > /dev/null; then
		echo "Error: $cmd must be installed to run this script (apt-get install $cmd ?)"
		exit 1
	fi
done

# Changement de répertoire de travail
OLD_PWD=`pwd`
cd /tmp

# Verification du nombre d'arguments sur la ligne de commande
if [ $# -lt 3 ]; then
	echo "Error: missing arguments"
	usage
	exit 1
fi

# Definition de l'adresse à tester
HOST="$1"
if ! ping -c 1 `basename $HOST` > /dev/null 2>&1; then
	echo "Error: unknown host $HOST"
	exit 1
fi
echo "Host: $HOST"

# Nombre d'itérations à réaliser
ITERATIONS="$2"
# A-t-on bien un nombre en paramètre ?
if ! expr 1 + $ITERATIONS > /dev/null 2>&1; then
	echo "Error: ITERATIONS is not a number"
	usage
	exit 1
fi
# Petit malin ;)
if [ $ITERATIONS -lt 1 ]; then
	ITERATIONS=1
fi
echo "Iterations: $ITERATIONS"

# Fichier de sortie (graphique)
OUTPUT_FILE="$3"
if [ -e $OUTPUT_FILE ]; then
	echo -n "Warning : file $OUTPUT_FILE already exists. Overwrite [y/n] ? "
	read OVERWRITE
	if [ $OVERWRITE != "y" -a $OVERWRITE != "Y" ]; then
		echo "Aborting"
		exit 0
	fi
fi
# Le fichier de sortie est-il un chemin absolu ?
if [ ${OUTPUT_FILE:0:1} != "/" ]; then
	# Pas en chemin absolu, donc on ajoute le répertoire en cours
	OUTPUT_FILE="$OLD_PWD/$OUTPUT_FILE"
fi
OUTPUT_FILE=`readlink -f $OUTPUT_FILE`
# On vérifie que le fichier de sortie a bien pour extension 'png'
if ! echo $OUTPUT_FILE | grep -P "\.png$"; then
	OUTPUT_FILE="$OUTPUT_FILE.png"
fi
echo "Output file: $OUTPUT_FILE"


# Configuration de l'éventuel délai entre les requêtes
DELAY=
if [ -n "$4" ]; then
	if expr 1 + "$4" > /dev/null; then
		DELAY="$4"
		echo "Delay: $DELAY"
	fi
fi

# Fichier qui va contenir les temps de réponse de l'adresse à tester
DATA_FILE="`basename $OUTPUT_FILE`.dat"

# Fichier de script gnuplot
GNUPLOT_FILE="`basename $OUTPUT_FILE`.plt"

# man curl ;)
CURL_CMD="curl -o /dev/null -w %{time_total}\n -s -L $HOST"

# Allez au boulot
echo "Gathering data..."
rm -f $DATA_FILE
for i in `seq 1 $ITERATIONS`; do
	echo -ne "Iteration $i\r"
	# Envoi de la requête HTTP
	CURL_DATA=`$CURL_CMD`

	# La commande cURL s'est correctement déroulée
	if [ $? -eq 0 ]; then
		echo -n "$i " >> $DATA_FILE
		echo $CURL_DATA >> $DATA_FILE
		if [ -n "$DELAY" -a $ITERATIONS -gt 1 ]; then
		        sleep $DELAY
		fi
	fi
done

echo "`cat $DATA_FILE | tr ',' '.'`" > $DATA_FILE
echo "Data file generated"

# Génération du fichier gnuplot
rm -f $GNUPLOT_FILE
echo "set terminal png size 640,480" >> $GNUPLOT_FILE
echo "set output '$OUTPUT_FILE'" >> $GNUPLOT_FILE
echo "set key outside bmargin left box" >> $GNUPLOT_FILE
echo "set style fill solid border -1" >> $GNUPLOT_FILE

echo "set xlabel 'Itération'" >> $GNUPLOT_FILE
MAX_X=`expr $ITERATIONS + 1`
echo "set xrange [-1:$MAX_X]" >> $GNUPLOT_FILE
if [ $ITERATIONS -lt 20 ]; then
	echo "set xtics 1" >> $GNUPLOT_FILE
fi
echo "set ylabel 'Temps (secondes).'" >> $GNUPLOT_FILE
MAX_Y=`cat $DATA_FILE | cut -f2 -d" " | sort -r | head -1`
MAX_Y=`echo "$MAX_Y + 0.1" | bc`
echo "set yrange [0:$MAX_Y]" >> $GNUPLOT_FILE

echo "plot '$DATA_FILE' with boxes title '$HOST'" >> $GNUPLOT_FILE

if gnuplot $GNUPLOT_FILE; then
	echo "Generated plot file $OUTPUT_FILE"
fi

# M. Propre est là
rm -f $DATA_FILE $GNUPLOT_FILE

# Retour à l'ancien répertoire de travail
cd $OLD_PWD

# That's all folks !
exit 0
