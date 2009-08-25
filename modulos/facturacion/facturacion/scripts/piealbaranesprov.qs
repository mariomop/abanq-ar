/***************************************************************************
                 piealbaranesprov.qs  -  description
                             -------------------
    begin                : vie ago 21 2009
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

/** @class_declaration pieDocumento */
/////////////////////////////////////////////////////////////////
//// PIE DE DOCUMENTO ///////////////////////////////////////////
class pieDocumento extends oficial {
	function pieDocumento( context ) { oficial ( context ); }
	function init() {
		this.ctx.pieDocumento_init();
	}
	function bufferChanged(fN:String) {
		this.ctx.pieDocumento_bufferChanged(fN);
	}
	function calculateField(fN:String):String {
		return this.ctx.pieDocumento_calculateField(fN);
	}
}
//// PIE DE DOCUMENTO  //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends pieDocumento {
    function head( context ) { pieDocumento( context ); }
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

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition pieDocumento */
//////////////////////////////////////////////////////////////////
//// PIE DE DOCUMENTO ////////////////////////////////////////////

function pieDocumento_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");

	if ( cursor.modeAccess() == cursor.Insert ) {
		cursor.setValueBuffer("baseimponible", this.iface.calculateField("baseimponible"));
	}

}

function pieDocumento_bufferChanged(fN:String)
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	switch (fN) {
		case "baseimponible":
		case "incporcentual":
 		case "inclineal":{
			cursor.setValueBuffer("totalinc", this.iface.calculateField("totalinc"));
			break;
		}
 		case "totalinc":{
			cursor.setValueBuffer("totaliva", this.iface.calculateField("totaliva"));
			cursor.setValueBuffer("totallinea", this.iface.calculateField("totallinea"));
			break;
		}
	}
}

function pieDocumento_calculateField(fN:String):String
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	var valor:String;
	switch (fN) {
		case "baseimponible": {
			valor = cursor.cursorRelation().valueBuffer("neto");
			break;
		}
		case "totalinc": {
			var incPor:Number = (cursor.valueBuffer("baseimponible") * cursor.valueBuffer("incporcentual")) / 100;
			valor = cursor.valueBuffer("inclineal") + parseFloat(incPor);
			valor = util.roundFieldValue(valor, cursor.table(), "totalinc");
			break;
		}
		case "totallinea": {
			valor = cursor.valueBuffer("baseimponible") + cursor.valueBuffer("totalinc");
			valor = util.roundFieldValue(valor, cursor.table(), "totallinea");
			break;
		}
		case "totaliva": {
			if (!cursor.valueBuffer("coniva")) {
				valor = 0;
				break;
			}
			var codImpuesto:String = util.sqlSelect("piedocumentos", "codimpuesto", "codpie = '" + cursor.valueBuffer("codpie") + "'")
			if (!codImpuesto) {
				valor = 0;
				break;
			}
			var iva:Number = parseFloat(util.sqlSelect("impuestos", "iva", "codimpuesto = '" + codImpuesto + "'"));
			if (isNaN(valor)) {
				valor = 0;
			}
			valor = (cursor.valueBuffer("totalinc") * iva) / 100;
			valor = util.roundFieldValue(valor, cursor.table(), "totaliva");
			break;
		}
	}
	return valor;
}

//// PIE DE DOCUMENTO ////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
