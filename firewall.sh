#!/bin/bash
# Voir 
#	http://documentation.online.net/fr/serveur-dedie/tutoriel/iptables-netfilter-configuration-firewall
function firewall_start() {
	###############################
	# INIT
	###############################
	# Suppression des anciennes règles
	iptables -F
	iptables -X

	# On vire tout le monde (-P : Policy, politique par défaut, ici DROP :))
	# Connexions entrantes
	iptables -P INPUT   DROP
	iptables -P FORWARD DROP
	iptables -P OUTPUT  DROP

	# Ne pas casser les connexions établies
	iptables -A INPUT   -m state --state RELATED,ESTABLISHED -j ACCEPT
	iptables -A OUTPUT  -m state --state RELATED,ESTABLISHED -j ACCEPT
	iptables -A FORWARD -m state --state RELATED,ESTABLISHED -j ACCEPT

	###############################
	# REGLES
	###############################
	# SSH
	iptables -A	INPUT -p tcp --dport 8066 -j ACCEPT

	# HTTP(S)
	# Sortie
	iptables -A OUTPUT -p tcp --dport 80  -j ACCEPT
	iptables -A INPUT  -p tcp --dport 80  -j ACCEPT
	iptables -A INPUT  -p tcp --dport 443 -j ACCEPT

	# DNS
	iptables -A OUTPUT -p tcp --dport 53 -j ACCEPT
	iptables -A OUTPUT -p udp --dport 53 -j ACCEPT

	# Autoriser loopback
	iptables -A INPUT  -i lo -j ACCEPT
	iptables -A INPUT  -i lo -j ACCEPT
	iptables -A OUTPUT -o lo -j ACCEPT

	# Autoriser ping
	iptables -A INPUT  -p icmp -j ACCEPT
	iptables -A OUTPUT -p icmp -j ACCEPT
}

function firewall_stop() {
	# Suppression des anciennes règles
	iptables -F
	iptables -X
	# Changement de la policy
	iptables -P INPUT   ACCEPT
	iptables -P OUTPUT  ACCEPT
	iptables -P FORWARD ACCEPT
}

function firewall_usage() {
	echo "Usage: $0 {start|stop}"
}

case "$1" in
	start)
		echo "Démarrage du firewall"
		firewall_start
		echo "Firewall démarré"
		exit 0
	;;
	stop)
		echo "Arrêt du firewall"
		firewall_stop
		echo "Firewall arrêté"
		exit 0
	;;
	*)
		echo "Argument non reconnu $1"
		firewall_usage
		exit 1	
	;;
esac
