/***************************************************************************
                 g_masterfacturascli.qs  -  description
                             -------------------
    begin                : jue jul 24 2008
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
	function obtenerParamInforme():Array {
		return this.ctx.oficial_obtenerParamInforme();
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
	
	flfactgraf.iface.pub_lanzarGrafico(cursor, pI.nombreInforme, pI.orderBy, false, "facturascli");
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
	var nombreInforme:String = cursor.action();
	nombreInforme = nombreInforme.replace( "g_", "i_" );
	paramInforme.nombreInforme = nombreInforme;
	paramInforme.orderBy = "facturascli.fecha";
	
	if (cursor.valueBuffer("codintervalo")) {
		var intervalo:Array = [];
		intervalo = flfactppal.iface.pub_calcularIntervalo(cursor.valueBuffer("codintervalo"));
		cursor.setValueBuffer("d_facturascli_fecha", intervalo.desde);
		cursor.setValueBuffer("h_facturascli_fecha", intervalo.hasta);
	}
	
	return paramInforme;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
