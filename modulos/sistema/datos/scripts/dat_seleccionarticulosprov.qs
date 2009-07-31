/**************************************************************************
                 dat_seleccionarticulosprov.qs  -  description
                             -------------------
    begin                : mar ene 13 2009
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
	var tdbArticulos:Object;
	var tdbArticulosSel:Object;
	
	function oficial( context ) { interna( context ); }
	function seleccionar() {
		return this.ctx.oficial_seleccionar();
	}
	function seleccionarTodos() {
		return this.ctx.oficial_seleccionarTodos();
	}
	function quitar() {
		return this.ctx.oficial_quitar();
	}
	function refrescarTablas() {
		return this.ctx.oficial_refrescarTablas();
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
/** \C
Este formulario muestra una lista de artículos que cumplen un determinado filtro, y permite al usuario seleccionar uno o más artículos de la lista
\end */
function interna_init()
{
	this.iface.tdbArticulos = this.child("tdbArticulos");
	this.iface.tdbArticulosSel = this.child("tdbArticulosSel");
	
	this.iface.tdbArticulos.setReadOnly(true);
	this.iface.tdbArticulosSel.setReadOnly(true);
	
	var filtro:String = this.cursor().valueBuffer("filtro");
	if (filtro && filtro != "") {
		this.iface.tdbArticulos.cursor().setMainFilter(filtro);
		this.iface.tdbArticulosSel.cursor().setMainFilter(filtro);
	}
	this.iface.refrescarTablas();

	connect(this.iface.tdbArticulos.cursor(), "recordChoosed()", this, "iface.seleccionar()");
	connect(this.iface.tdbArticulosSel.cursor(), "recordChoosed()", this, "iface.quitar()");
	connect(this.child("pbnSeleccionar"), "clicked()", this, "iface.seleccionar()");
	connect(this.child("pbnSeleccionarTodos"), "clicked()", this, "iface.seleccionarTodos()");
	connect(this.child("pbnQuitar"), "clicked()", this, "iface.quitar()");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Refresca las tablas, en función del filtro y de los datos seleccionados hasta el momento
*/
function oficial_refrescarTablas()
{
	var datos:String = this.cursor().valueBuffer("datos");
	var filtro:String = this.cursor().valueBuffer("filtro");
	if (filtro && filtro != "")
		filtro += " AND ";

	if (!datos || datos == "") {
		this.iface.tdbArticulos.cursor().setMainFilter(filtro + "1 = 1");
		this.iface.tdbArticulosSel.cursor().setMainFilter(filtro + "1 = 2");
	} else {
		this.iface.tdbArticulos.cursor().setMainFilter(filtro + "referencia NOT IN ( " + datos + " )");
		this.iface.tdbArticulosSel.cursor().setMainFilter(filtro + "referencia IN ( " + datos + " )");
	}
	this.iface.tdbArticulos.refresh();
	this.iface.tdbArticulosSel.refresh();
}

/** \D Incluye un artículo en la lista de datos
*/
function oficial_seleccionar()
{
	var cursor:FLSqlCursor = this.cursor();
	var datos:String = cursor.valueBuffer("datos");
	var refArticulo:String = this.iface.tdbArticulos.cursor().valueBuffer("referencia");

	if (!refArticulo)
		return;

	if (!datos || datos == "")
		datos = "'" + refArticulo + "'";
	else
		datos += ",'" + refArticulo + "'";
		
	cursor.setValueBuffer("datos", datos);
	
	this.iface.refrescarTablas();
}

/** \D Incluye todos los artículos del filtro en la lista de datos
*/
function oficial_seleccionarTodos()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	var datos:String = cursor.valueBuffer("datos");
	var refArticulo:String;

	util.createProgressDialog( "Agregando artículos ....", this.iface.tdbArticulos.cursor().size() );
	this.iface.tdbArticulos.cursor().first();
	for (var i:Number = 0; i < this.iface.tdbArticulos.cursor().size(); i++) {
		util.setProgress( i );

		refArticulo = this.iface.tdbArticulos.cursor().valueBuffer("referencia");
		if (!refArticulo) {
			util.destroyProgressDialog();
			return;
		}

		if (!datos || datos == "")
			datos = "'" + refArticulo + "'";
		else
			datos += ",'" + refArticulo + "'";

		this.iface.tdbArticulos.cursor().next();
	}
	cursor.setValueBuffer("datos", datos);
	util.destroyProgressDialog();
	this.iface.refrescarTablas();
}

/** \D Quita un artículo de la lista de datos
*/
function oficial_quitar()
{
	var cursor:FLSqlCursor = this.cursor();
	var datos:String = new String( cursor.valueBuffer("datos") );
	var refArticulo:String = this.iface.tdbArticulosSel.cursor().valueBuffer("referencia");

	if (!refArticulo)
		return;

	refArticulo = "'" + refArticulo + "'";

	if (!datos || datos == "")
		return;

	var articulos:Array = datos.split(",");
	var datosNuevos:String = "";
	for (var i:Number = 0; i < articulos.length; i++) {
		if (articulos[i] != refArticulo) {
			if (datosNuevos == "")
				datosNuevos = articulos[i];
			else
				datosNuevos += "," + articulos[i];
		}
	}
	cursor.setValueBuffer("datos", datosNuevos);
	this.iface.refrescarTablas();
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
