/***************************************************************************
                 i_masterlistapreciostarifas.qs  -  description
                             -------------------
    begin                : lun oct 27 2008
    copyright            : (C) 2008 by Silix
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
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
    function oficial( context ) { interna( context ); }
	function lanzar() {
		return this.ctx.oficial_lanzar();
	}
	function obtenerOrden(nivel:Number, cursor:FLSqlCursor):String {
		return this.ctx.oficial_obtenerOrden(nivel, cursor);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration csv */
/////////////////////////////////////////////////////////////////
//// CSV ////////////////////////////////////////////////////////
class csv extends oficial {
    function csv( context ) { oficial ( context ); }
	function init() {
		this.ctx.csv_init();
	}
	function lanzarCSV() {
		return this.ctx.csv_lanzarCSV();
	}
}
//// CSV ////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends csv {
    function head( context ) { csv ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
	function pub_lanzar() {
		return this.lanzar();
	}
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
	connect (this.child("toolButtonPrint"), "clicked()", this, "iface.lanzar()");
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_lanzar()
{
	var cursor:FLSqlCursor = this.cursor();
	var seleccion:String = cursor.valueBuffer("id");
	if (!seleccion)
		return;

	var nombreReport:String = cursor.action();
	var orderBy:String = "";
	var o:String = "";
	for (var i:Number = 1; i < 4; i++) {
		o = this.iface.obtenerOrden(i, cursor);
		if (o) {
			if (orderBy == "")
				orderBy = o;
			else
				orderBy += ", " + o;
		}
	}

	var nombreInforme:String = nombreReport;
	// si no se indica proveedor
	if (!cursor.valueBuffer("i_articulosprov_codproveedor") || cursor.valueBuffer("i_articulosprov_codproveedor") == "")
		nombreInforme = "i_listapreciostarifas_distinct";

	var whereFijo:String = "articulos.sevende AND NOT articulos.debaja";

	flfactinfo.iface.pub_lanzarInforme(cursor, nombreInforme, orderBy, "", false, false, whereFijo, nombreReport);
}

function oficial_obtenerOrden(nivel:Number, cursor:FLSqlCursor):String
{
	var ret:String = "";
	var orden:String = cursor.valueBuffer("orden" + nivel.toString());
	switch(nivel) {
		case 1: {
			// si no se indica proveedor
			if (!cursor.valueBuffer("i_articulosprov_codproveedor") || cursor.valueBuffer("i_articulosprov_codproveedor") == "")
				break;
			switch(orden) {
				case "Código": {
					ret += "articulosprov.codproveedor";
					break;
				}
				case "Nombre": {
					ret += "articulosprov.nombre";
					break;
				}
			}
			break;
		}
		break;
		case 2: {
			switch(orden) {
				case "Código": {
					ret += "familias.codfamilia";
					break;
				}
				case "Descripción": {
					ret += "familias.descripcion";
					break;
				}
			}
			break;
		}
		break;
		case 3: {
			switch(orden) {
				case "Referencia": {
					ret += "articulos.referencia";
					break;
				}
				case "Descripción": {
					ret += "articulos.descripcion";
					break;
				}
			}
			break;
		}
		break;
	}
	if (ret != "") {
		var tipoOrden:String = cursor.valueBuffer("tipoorden" + nivel.toString());
		switch(tipoOrden) {
			case "Descendente": {
				ret += " DESC";
				break;
			}
		}
	}

	if (nivel == 1 && orden != 1) {
		if (ret == "")
			ret += "articulos.referencia";
		else
			ret += ", articulos.referencia";
	}

	return ret;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition csv */
/////////////////////////////////////////////////////////////////
//// CSV ////////////////////////////////////////////////////////

function csv_init()
{
	this.iface.__init();

	connect (this.child("toolButtonCSV"), "clicked()", this, "iface.lanzarCSV()");
}

function csv_lanzarCSV()
{
	var cursor:FLSqlCursor = this.cursor();
	var seleccion:String = cursor.valueBuffer("id");
	if (!seleccion)
		return;

	var nombreReport:String = cursor.action();
	var orderBy:String = "";
	var o:String = "";
	for (var i:Number = 1; i < 4; i++) {
		o = this.iface.obtenerOrden(i, cursor);
		if (o) {
			if (orderBy == "")
				orderBy = o;
			else
				orderBy += ", " + o;
		}
	}

	var nombreInforme:String = nombreReport;
	// si no se indica proveedor
	if (!cursor.valueBuffer("i_articulosprov_codproveedor") || cursor.valueBuffer("i_articulosprov_codproveedor") == "")
		nombreInforme = "i_listaprecios_distinct";

	var whereFijo:String = "articulos.sevende AND NOT articulos.debaja";

	var cabecera:String = "Referencia;Descripción;Precio;Divisa;";
	var indices = [ 8, 9, 10, 11 ];

	flfactinfo.iface.pub_lanzarInformeCSV(cursor, nombreInforme, orderBy, "", whereFijo, nombreReport, cabecera, indices);
}

//// CSV ////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
