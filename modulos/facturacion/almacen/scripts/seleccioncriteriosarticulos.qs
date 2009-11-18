/***************************************************************************
                 seleccioncriteriosarticulos.qs  -  description
                             -------------------
    begin                : vie oct 30 2009
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
	function calculateField(fN:String):String { return this.ctx.interna_calculateField(fN); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var tdbFamilias:Object;
	var tdbFabricantes:Object;
	
    function oficial( context ) { interna( context ); } 
	function bufferChanged(fN:String) {
		this.ctx.oficial_bufferChanged(fN);
	}
	function agregarFamilia() {
		this.ctx.oficial_agregarFamilia();
	}
	function agregarFabricante() {
		this.ctx.oficial_agregarFabricante();
	}
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
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	
	this.iface.tdbFamilias = this.child("tdbFamilias");
	this.iface.tdbFamilias.setReadOnly(true);
	this.iface.tdbFamilias.setCheckColumnEnabled(true);
	this.iface.tdbFamilias.refresh();
	this.iface.tdbFamilias.setOrderCols(this.iface.tdbFamilias.orderCols());
	connect(this.iface.tdbFamilias, "primaryKeyToggled(QVariant, bool)", this, "iface.agregarFamilia()");

	this.iface.tdbFabricantes = this.child("tdbFabricantes");
	this.iface.tdbFabricantes.setReadOnly(true);
	this.iface.tdbFabricantes.setCheckColumnEnabled(true);
	this.iface.tdbFabricantes.refresh();
	this.iface.tdbFabricantes.setOrderCols(this.iface.tdbFabricantes.orderCols());
	connect(this.iface.tdbFabricantes, "primaryKeyToggled(QVariant, bool)", this, "iface.agregarFabricante()");
}

function interna_calculateField(fN:String):String
{
	var cursor = this.cursor();
	var res:String;
	switch (fN) {
		case "seleccion": {
			if (cursor.valueBuffer("familias")) {
				if (res)
					res += " OR ";
				res += cursor.valueBuffer("familias");
			}
			if (cursor.valueBuffer("fabricantes")) {
				if (res)
					res += " OR ";
				res += cursor.valueBuffer("fabricantes");
			}
			break;
		}
	}
	return res;

}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	switch (fN) {
		case "familias":
		case "fabricantes":
			cursor.setValueBuffer("seleccion", this.iface.calculateField("seleccion"));
			break;
	}
}

function oficial_agregarFamilia()
{
	var cursor:FLSqlCursor = this.cursor();
	var datos:String = [];
	datos = this.iface.tdbFamilias.primarysKeysChecked();
	var lista:String = datos.join();
	cursor.setValueBuffer("familias", "articulos.codfamilia IN ('" + lista.replace(/,/g,"', '") + "')");
}

function oficial_agregarFabricante()
{
	var cursor:FLSqlCursor = this.cursor();
	var datos:String = [];
	datos = this.iface.tdbFabricantes.primarysKeysChecked();
	var lista:String = datos.join();
	cursor.setValueBuffer("fabricantes", "articulos.codfabricante IN ('" + lista.replace(/,/g,"', '") + "')");
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
