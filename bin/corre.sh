#!/bin/sh
# Inicia servicio
if (test "$RC" = "") then {
	RC=cor1440pdJ
} fi;
if (test ! -f /etc/rc.d/$RC) then {
	echo "Falta script /etc/rc.d/$RC"
	exit 1;
} fi;

doas sh /etc/rc.d/$RC -d start

