/***************************************************************************
                 periodos.qs  -  description
                             -------------------
    begin                : lun oct 19 2009
    copyright            : (C) 2009 by Silix
    email                : contacto@silix.com.ar
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
	function validateForm():Boolean {return this.ctx.interna_validateForm(); }
	function calculateCounter():String {return this.ctx.interna_calculateCounter(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	function oficial( context ) { interna( context ); }
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial {
    function head( context ) { oficial ( context ); }
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
function interna_init()
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();
	if (cursor.modeAccess() == cursor.Insert) {
		var ultPeriodo:String = util.sqlSelect("periodos", "fechafin", " 1 = 1 ORDER BY fechafin DESC");
		if (ultPeriodo) {
				this.child("fdbFechaInicio").setValue(util.addDays(ultPeriodo, 1));
		} else {
				var hoy:Date = new Date();
				var fechaInicio:Date = new Date(hoy.getYear(), hoy.getMonth(), 1);
				this.child("fdbFechaInicio").setValue(fechaInicio);
		}
		var fechaInicio:Date = new Date(Date.parse(cursor.valueBuffer("fechainicio").toString().substring(0, 10)));
		var fechaFin:Date = new Date(fechaInicio.getYear(), fechaInicio.getMonth() + 1, 1);
		fechaFin = util.addDays(fechaFin, -1);
		this.child("fdbFechaFin").setValue(fechaFin);
		this.child("fdbNombre").setValue(fechaInicio.getYear() + "/" + flfactppal.iface.pub_cerosIzquierda(fechaInicio.getMonth(),2));
	}
}

function interna_validateForm():Boolean
{
	var fechaInicio:String = this.child("fdbFechaInicio").value();
	var fechaFin:String = this.child("fdbFechaFin").value();
	var util:FLUtil = new FLUtil;

	/** \C
	La fecha de inicio del período debe ser menor que la de fin
	\end */
	if (fechaInicio > fechaFin) {
		MessageBox.warning(util.translate("scripts", "La fecha de inicio del período debe ser menor que la de fin"),
			 MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

	return true;
}

function interna_calculateCounter():String
{
	var util:FLUtil = new FLUtil();

	var fecha:Date;
	var ultPeriodo:String = util.sqlSelect("periodos", "fechafin", "1=1 ORDER BY fechafin DESC");
	if (!ultPeriodo) {
		var hoy:Date = new Date();
		fecha = new Date(hoy.getYear(), hoy.getMonth(), 1);
	} else
		fecha = util.addDays(ultPeriodo, 1);

	return fecha.getYear() + "" + flfactppal.iface.pub_cerosIzquierda(fecha.getMonth(),2);
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////