/***************************************************************************
                 i_masterentradasarticulos.qs  -  description
                             -------------------
    begin                : vie jul 10 2009
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
	function obtenerParamInforme():Array {
		return this.ctx.oficial_obtenerParamInforme();
	}
	function obtenerOrden(nivel:Number, cursor:FLSqlCursor, tabla:String):String {
		return this.ctx.oficial_obtenerOrden(nivel, cursor, tabla);
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
    function pub_obtenerOrden(nivel:Number, cursor:FLSqlCursor, tabla:String):String {
        return this.obtenerOrden(nivel, cursor, tabla);
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
	var pI = this.iface.obtenerParamInforme();
	if (!pI)
		return;
	
	flfactinfo.iface.pub_lanzarInforme(cursor, pI.nombreInforme, pI.orderBy);
}

/** \D Obtiene un array con los parámetros necesarios para establecer el informe
@return	array de parámetros o false si hay error
\end */
function oficial_obtenerParamInforme():Array
{
	var paramInforme:Array = [];
	paramInforme["nombreInforme"] = false;
	paramInforme["orderBy"] = false;
	paramInforme["groupBy"] = false;
	paramInforme["etiquetas"] = false;
	paramInforme["impDirecta"] = false;
	paramInforme["whereFijo"] = false;
	paramInforme["nombreReport"] = false;
	paramInforme["numCopias"] = false;

	var cursor:FLSqlCursor = this.cursor();
	var seleccion:String = cursor.valueBuffer("id");
	if (!seleccion)
		return false;
	paramInforme.nombreInforme = cursor.action();
	paramInforme.orderBy = "lineasentradasarticulos.referencia";
	var o:String = "";
	for (var i:Number = 1; i < 2; i++) {
		o = this.iface.obtenerOrden(i, cursor, "lineasentradasarticulos");
		if (o) {
			if (paramInforme.orderBy == "")
				paramInforme.orderBy = o;
			else
				paramInforme.orderBy += ", " + o;
		}
	}
	
	if (cursor.valueBuffer("codintervalo")) {
		var intervalo:Array = [];
		intervalo = flfactppal.iface.pub_calcularIntervalo(cursor.valueBuffer("codintervalo"));
		cursor.setValueBuffer("d_lineasentradasarticulos_fecha", intervalo.desde);
		cursor.setValueBuffer("h_lineasentradasarticulos_fecha", intervalo.hasta);
	}

	return paramInforme;
}

function oficial_obtenerOrden(nivel:Number, cursor:FLSqlCursor, tabla:String):String
{
	var ret:String = "";
	var orden:String = cursor.valueBuffer("orden" + nivel.toString());
	switch (nivel) {
		case 1: {
			switch (orden) {
				case "Fecha": {
					ret += tabla + ".fecha";
					break;
				}
				case "Proveedor": {
					ret += tabla + ".nombreproveedor";
					break;
				}
				case "Cantidad": {
					ret += tabla + ".cantidad";
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
/*
	if (nivel == 2 && orden != "Fecha") {
		if (ret == "")
			ret += tabla + ".fecha";
		else
			ret += ", " + tabla + ".fecha";
	}
*/
	return ret;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
