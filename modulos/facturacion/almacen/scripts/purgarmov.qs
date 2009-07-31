/***************************************************************************
                 purgarmov.qs  -  description
                             -------------------
    begin                : mar sep 26 2005
    copyright            : (C) 2005 by InfoSiAL S.L.
    email                : mail@infosial.com
 ***************************************************************************/

/***************************************************************************
 *                                                                         *
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; either version 2 of the License, or     *
 *   (at your option) any later version.                                   *
 *                                                                         *
 ***************************************************************************/

/** @file */

/** @class_declaration interna */
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
class interna {
    var ctx:Object;
    function interna( context ) { this.ctx = context; }
    function init() { this.ctx.interna_init(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
class lotes extends interna {
    function lotes( context ) { interna ( context ); }
	function main() {
		return this.ctx.lotes_main();
	}
}
//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends lotes {
    function head( context ) { lotes ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
}

const iface = new ifaceCtx( this );
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
/** \C El criterio de selección para eliminar los movimientos será escoger los movimientos asociados a los lotes no activos (En almacén = 0 y ya caducados), cuya último movimiento sea anterior a la fecha dada. El usuario determinará dicha fecha antes de proceder al borrado de los movimientos. 

El sistema recomendará hacer un backup de la base de datos antes de proceder al borrado.
\end */
function lotes_main()
{
	var util:FLUtil = new FLUtil();
	var respuesta:Number = MessageBox.warning(util.translate("scripts", "Va a realizar un borrado de movimientos de lotes.\nEsta acción no es reversible, por lo que debería realizar\nantes una copia de seguridad de su base de datos.\n¿desea continuar?"), MessageBox.Yes, MessageBox.No);
	if(respuesta != MessageBox.Yes)
		return;
		
	var dialog:Object = new Dialog(util.translate("scripts", "Purgar movimientos"), 0, "purgar");
	var dialog:Dialog = new Dialog;
	var fecha = new DateEdit;
	fecha.date = new Date();
	fecha.label = "Intruduzca una fecha límite:";
	dialog.OKButtonText = util.translate ( "scripts", "Aceptar" );
	dialog.cancelButtonText = util.translate ( "scripts", "Cancelar" );
	dialog.add( fecha );

	if(dialog.exec()){
		var respuesta:Number = MessageBox.warning(util.translate("scripts", "Va a realizar un borrado de movimientos de lotes.\nEsta acción no es reversible.\n¿desea continuar?"), MessageBox.Yes, MessageBox.No);
		if (respuesta != MessageBox.Yes)
			return;
			
		var fechaLimite = fecha.date;
		var util:FLUtil = new FLUtil();
		var qLotes:FLSqlQuery = new FLSqlQuery();
		qLotes.setTablesList("lotes");
		qLotes.setSelect("codlote");
		qLotes.setFrom("lotes");
		qLotes.setWhere("enalmacen = 0 AND caducidad < CURRENT_DATE");
		qLotes.exec();
		debug(1);
		util.createProgressDialog(util.translate("scripts", "Eliminando Movimientos"),qLotes.size());
		util.setProgress(0);
		sys.processEvents();
		var i:Number = 0;
		while (qLotes.next()) {debug(i);
			i ++;
			util.setProgress(i);
			sys.processEvents();
			if(util.sqlSelect("movilote","codlote","codlote = '" + qLotes.value(0) + "' AND fecha > '" + fechaLimite + "'")){debug("continue");
				continue;}
			util.sqlDelete("movilote","codlote = '" + qLotes.value(0) + "'");debug("elimina");
		}
		util.setProgress(qLotes.size());
		util.destroyProgressDialog();
	}debug("fin")
}
//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////