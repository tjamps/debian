#!/bin/bash
if [ $EUID -ne 0 ]; then
	echo "Only root can run this script"
	exit 1
fi
