#!/bin/sh
# Inicia produccion
if (test "${SECRET_KEY_BASE}" = "") then {
	echo "Definir variable de ambiente SECRET_KEY_BASE"
	exit 1;
} fi;
if (test "${USUARIO_AP}" = "") then {
	echo "Definir usuario con el que se ejecuta en USUARIO_AP"
	exit 1;
} fi;
if (test "${DIRAP}" = "") then {
	echo "Definir directorio en DIRAP"
	exit 1;
} fi;
if (test "${CONFIG_HOSTS}" = "") then {
	echo "Definir máquina en CONFIG_HOSTS"
	exit 1;
} fi;


DOAS=`which doas`
if (test "$DOAS" = "") then {
	DOAS=sudo
} fi;
bd=`basename ${DIRAP}`
$DOAS su ${USUARIO_AP} -c "cd ${DIRAP}; RALS_ENV=production bin/rails assets:precompile"
$DOAS su - ${USUARIO_AP} -c "cd $DIRAP; RAILS_ENV=production bin/rails sip:indices"
$DOAS su - ${USUARIO_AP} -c "cd $DIRAP; echo \"Iniciando unicorn...\"; CONFIG_HOSTS=${CONFIG_HOSTS} DIRAP=$DIRAP RAILS_ENV=production SECRET_KEY_BASE=${SECRET_KEY_BASE} bundle exec /usr/local/bin/unicorn_rails -c $DIRAP/config/unicorn.conf.minimal.rb  -E production -D"


  

