/***************************************************************************
                 translote.qs  -  description
                             -------------------
    begin                : lun sep 26 2005
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
	function init() {
		return this.ctx.lotes_init();
	}
	function validateForm():Boolean {
		return this.ctx.lotes_validateForm();
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
/** \C Las transferencias entre lotes o almacenes se realizarán desde la ventana de stocks por artículo. El --idstockorigen-- deberá ser el stock seleccionado en dicha ventana. El --codloteorigen-- deberá corresponder al tipo de artículo (referencia) del stock seleccionado. 
\end */
function lotes_init()
{
	var util:FLUtil = new FLUtil();
	var idStock:Number = this.cursor().valueBuffer("idstockorigen");

	var referencia:String = util.sqlSelect("stocks","referencia","idstock = " + idStock);
	this.child("fdbCodLoteOrigen").setFilter("referencia = '" + referencia + "'");
	this.child("fdbCodLoteDestino").setFilter("referencia = '" + referencia + "'");
	this.child("fdbIdStockDestino").setFilter("referencia = '" + referencia + "'");
	this.child("fdbIdStockOrigen").setDisabled(true);
	return;
}

function lotes_validateForm():Boolean
{
	var cursor:FLSqlCursor = this.cursor();
	var curMoviLotes:FLSqlCursor = new FLSqlCursor("movilotes");
	
	curMoviLotes.setModeAccesss(curMoviLotes.Insert)
	curMoviLotes.refresh();
	curMoviLotes.setValueBuffer("codlote",cursor.valueBuffer("codloteorigen"));
	curMoviLotes.setValueBuffer("fecha",cursor.valueBuffer("fecha"));
	curMoviLotes.setValueBuffer("tipo","Regularización");
	curMoviLotes.setValueBuffer("docorigen","NO");
	curMoviLotes.setValueBuffer("idstock",cursor.valueBuffer("idstockorigen"));
	curMoviLotes.setValueBuffer("cantidad","-" + cursor.valueBuffer("cantidad"));
	curMoviLotes.setValueBuffer("descripcion",cursor.valueBuffer("descripcion"));
	if(!curMoviLotes.commitBuffer())
		return false;
	var idMovi1:Number = curMoviLotes.valueBuffer("id");
	
	curMoviLotes.setModeAccesss(curMoviLotes.Insert)
	curMoviLotes.refresh();
	curMoviLotes.setValueBuffer("codlote",cursor.valueBuffer("codlotedestino"));
	curMoviLotes.setValueBuffer("fecha",cursor.valueBuffer("fecha"));
	curMoviLotes.setValueBuffer("tipo","Regularización");
	curMoviLotes.setValueBuffer("docorigen","NO");
	debug(cursor.valueBuffer("idstockdestino"));
	curMoviLotes.setValueBuffer("idstock",cursor.valueBuffer("idstockdestino"));
	debug("asdfas");
	curMoviLotes.setValueBuffer("cantidad",cursor.valueBuffer("cantidad"));
	curMoviLotes.setValueBuffer("descripcion",cursor.valueBuffer("descripcion"));
	curMoviLotes.setValueBuffer("idtrans",idMovi1);
	if(!curMoviLotes.commitBuffer())
		return false;
	var idMovi2:Number = curMoviLotes.valueBuffer("id");
	
	curMoviLotes.select("id = " + idMovi1);
	curMoviLotes.refresh();
	curMoviLotes.setModeAccesss(curMoviLotes.Edit)
	curMoviLotes.setValueBuffer("idtrans",idMovi2);
	if(!curMoviLotes.commitBuffer())
		return false;
	
	this.child("tdbMoviLote").refresh();
	
	return true;
}


//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////