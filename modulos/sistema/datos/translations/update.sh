#!/bin/sh
#***************************************************************************
#                                 update.sh
#                             -------------------
#    begin                : Mar Abr 09 2003
#    copyright            : (C) 2003 by Federico Albujer Zornoza
#    email                : mail@infosial.com
#***************************************************************************

#***************************************************************************
#*                                                                         *
#*   This program is free software; you can redistribute it and/or modify  *
#*   it under the terms of the GNU General Public License as published by  *
#*   the Free Software Foundation; either version 2 of the License, or     *
#*   (at your option) any later version.                                   *
#*                                                                         *
#*************************************************************************** 

echo -e "PREFIX =\n" > ./translations.pro
echo -e "ROOT =\n" >> ./translations.pro
echo -e "INCLUDE_PGSQL = \n" >> ./translations.pro
echo -e "LIB_PGSQL =\n" >> ./translations.pro
echo -e "\n" >> ./translations.pro

TABLAS=$(find .. -name "*.mtd" -printf "%p ")
CONSULTAS=$(find .. -name "*.qry" -printf "%p ")
CABECERAS=$(find .. -name "*.h" -printf "%p ")
FUENTES=$(find .. -name "*.cpp" -printf "%p ")
FORMULARIOS=$(find .. -name "*.ui" -printf "%p ")
SCRIPTS=$(find .. -name "*.qs" -printf "%p ")
MODULO=$(ls ../*.mod)

echo "HEADERS = $MODULO $TABLAS $CONSULTAS $CABECERAS $SCRIPTS" >> ./translations.pro
echo "SOURCES = $FUENTES" >> ./translations.pro
echo "FORMS = $FORMULARIOS" >> ./translations.pro

echo -e "TRANSLATIONS = fldatosppal.es.ts fldatosppal.fr.ts \
fldatosppal.en.ts fldatosppal.de.ts fldatosppal.ca.ts fldatosppal.gl.ts \
fldatosppal.pt.ts fldatosppal.it.ts fldatosppal.untranslated.ts" >> ./translations.pro

lupdate -noobsolete ./translations.pro
rm -fR ./translations.pro
