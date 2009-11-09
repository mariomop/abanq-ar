/***************************************************************************
                 masterfamilias.qs  -  description
                             -------------------
    begin                : lun abr 26 2006
    copyright            : (C) 2004 by InfoSiAL S.L.
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

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	function oficial( context ) { interna( context ); } 
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration multiFamilia */
/////////////////////////////////////////////////////////////////
//// MULTI FAMILIA //////////////////////////////////////////////
class multiFamilia extends oficial {
    function multiFamilia( context ) { oficial ( context ); }
	function init() {
		this.ctx.multiFamilia_init();
	}
	function calculateField(fN:String):Number {
		return this.ctx.multiFamilia_calculateField(fN);
	}
	function buscarFamiliaMadre() {
		this.ctx.multiFamilia_buscarFamiliaMadre();
	}
}
//// MULTI FAMILIA //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends multiFamilia {
    function head( context ) { multiFamilia ( context ); }
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

/** \D Cuando es una nueva no mostramos nada en la lista de familias hijas
*/
function interna_init()
{
	if (this.cursor().modeAccess() == this.cursor().Insert) {
		this.child("tdbFamiliasHijas").cursor().setMainFilter("codmadre = '-1'");
		this.child("tdbFamiliasHijas").refresh();
	}
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition multiFamilia */
/////////////////////////////////////////////////////////////////
//// MULTI FAMILIA //////////////////////////////////////////////

function multiFamilia_init()
{
	this.iface.__init();
	connect(this.child("pbnBuscarFamiliaMadre"), "clicked()", this, "iface.buscarFamiliaMadre()");
	connect(this.child("fdbCodMadre"), "keyF2Pressed()", this, "iface.buscarFamiliaMadre()");
}

function multiFamilia_calculateField(fN:String):Number
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	var valor:Number;

	switch (fN) {
		case "descripcionextendida": {
			var descExtFamiliaMadre:String = "";
			if (cursor.valueBuffer("codmadre")) {
				descExtFamiliaMadre = util.sqlSelect("familias", "descripcionextendida", "codfamilia = '" + cursor.valueBuffer("codmadre") + "'");
				descExtFamiliaMadre += " > ";
			}
			valor = descExtFamiliaMadre + cursor.valueBuffer("descripcion");
			break;
		}
	}
	return valor;
}

function multiFamilia_buscarFamiliaMadre()
{
	var cursor:FLSqlCursor = this.cursor();

	var familias:Object = new FLFormSearchDB("familias");
	var curFamilias:FLSqlCursor = familias.cursor();
	curFamilias.setMainFilter("codfamilia <> '" + cursor.valueBuffer("codfamilia") + "'");

	familias.setMainWidget();
	var codFamilia:String = familias.exec("codfamilia");

	if (!codFamilia)
		return;

	cursor.setValueBuffer("codmadre", codFamilia);
}

//// MULTI FAMILIA //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
