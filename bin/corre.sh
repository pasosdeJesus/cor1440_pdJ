#!/bin/sh
# Inicia servicio

if (test -f ".env") then {
	. .env
} fi;
if (test "$RC" = "") then {
	export RC=sivel2
} fi;
if (test "$RAILS_ENV" = "") then {
	RAILS_ENV=development
} fi;
if (test "$PUERTODES" = "") then {
	PUERTODES=2300
} fi;
if (test "$IPDES" = "") then {
	IPDES=127.0.0.1
} fi;
if (test "$CONFIG_HOSTS" = "") then {
	CONFIG_HOSTS=127.0.0.1
} fi;
if (test "$RAILS_ENV" = "development") then {
	if (test "$SININD" = "") then {
		bundle exec rake sip:indices
		bin/rails assets:precompile --trace
	} fi;
	bin/rails s -b "ssl://$IPDES:$PUERTODES?key=server.key&cert=server.crt&verify_mode=peer&ca=/etc/ssl/cert.pem"
} else {
	if (test ! -f /etc/rc.d/$RC) then {
		echo "Falta script /etc/rc.d/$RC"
		exit 1;
	} fi;
	doas sh /etc/rc.d/$RC -d start
} fi;


