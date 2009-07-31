/***************************************************************************
                      dat_articulostarifas.qs  -  description
                             -------------------
    begin                : mie ene 14 2009
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
	function calculateCounter():Number { return this.ctx.interna_calculateCounter(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	function oficial( context ) { interna( context ); }
	function agregarArticulo():Boolean {
		return this.ctx.oficial_agregarArticulo();
	}
	function eliminarArticulo() {
		return this.ctx.oficial_eliminarArticulo();
	}
	function asociarArticuloTarifa(refArticulo:String, codTarifa:String):Boolean {
		return this.ctx.oficial_asociarArticuloTarifa(refArticulo, codTarifa);
	}
	function excluirArticuloTarifa(refArticulo:String, codTarifa:String):Boolean {
		return this.ctx.oficial_excluirArticuloTarifa(refArticulo, codTarifa);
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
	var util:FLUtil = new FLUtil;

	connect(this.child("tbInsert"), "clicked()", this, "iface.agregarArticulo");
	connect(this.child("tbDelete"), "clicked()", this, "iface.eliminarArticulo");
		
	var tdbArticulos:FLTableDB = this.child("tdbArticulos");
	tdbArticulos.setReadOnly(true);

	tdbArticulos.cursor().setMainFilter("referencia IN ( SELECT referencia FROM articulostarifas WHERE iddat_articulostarifas = '" + cursor.valueBuffer("iddat_articulostarifas") + "' )");
	tdbArticulos.refresh();

}

function interna_calculateCounter():Number
{
	var util:FLUtil = new FLUtil();
	var cadena:String = util.sqlSelect("dat_articulostarifas", "iddat_articulostarifas", "1 = 1 ORDER BY iddat_articulostarifas DESC");
	var valor:Number;
	if (!cadena)
		valor = 1;
	else
		valor = parseFloat(cadena) + 1;

	return valor;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_agregarArticulo():Boolean
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	
	if (!cursor.valueBuffer("codtarifa")) {
		MessageBox.warning(util.translate("scripts", "Debe indicar una tarifa"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return;
	}
	
	var f:Object = new FLFormSearchDB("dat_seleccionarticulostarifas");
	var curArticulos:FLSqlCursor = f.cursor();
		
	if (cursor.modeAccess() != cursor.Browse)
		if (!cursor.checkIntegrity())
			return;

	curArticulos.select();
	if (!curArticulos.first())
		curArticulos.setModeAccess(curArticulos.Insert);
	else
		curArticulos.setModeAccess(curArticulos.Edit);
		
	f.setMainWidget();
	curArticulos.refreshBuffer();
	curArticulos.setValueBuffer("datos", "");
	curArticulos.setValueBuffer("filtro", "referencia NOT IN ( SELECT referencia FROM articulostarifas WHERE codtarifa = '" + cursor.valueBuffer("codtarifa") + "' )");

	var ret = f.exec( "datos" );

	if ( !f.accepted() )
		return false;


	var datos:String = new String( ret );

	if ( datos.isEmpty() )
		return false;

	var regExp:RegExp = new RegExp( "'" );
	regExp.global = true;
	datos = datos.replace( regExp, "" );

	var articulos:Array = datos.split(",");

	util.createProgressDialog( "Creando artículos por tarifas....", articulos.length );

	for (var i:Number = 0; i < articulos.length; i++) {
		util.setProgress( i );
		if (!this.iface.asociarArticuloTarifa(articulos[i], cursor.valueBuffer("codtarifa"))) {
			util.destroyProgressDialog();
			return false;
		}
	}
	util.destroyProgressDialog();

	this.child("tdbArticulos").refresh();
}

function oficial_eliminarArticulo()
{
	if (!this.child("tdbArticulos").cursor().isValid())
		return;
	
	var articulo:String = this.child("tdbArticulos").cursor().valueBuffer("referencia");
	if (!this.iface.excluirArticuloTarifa(articulo, this.cursor().valueBuffer("codtarifa")))
		return;

	this.child("tdbArticulos").refresh();
}

function oficial_excluirArticuloTarifa(refArticulo:String, codTarifa:String):Boolean
{
	var curArticulosTarifas:FLSqlCursor = new FLSqlCursor("articulostarifas");
	curArticulosTarifas.select("referencia = '" + refArticulo + "' AND codtarifa = '" + codTarifa + "'");

	if (!curArticulosTarifas.first())
		return false;

	curArticulosTarifas.setModeAccess(curArticulosTarifas.Del);
	curArticulosTarifas.refreshBuffer();

	if (!curArticulosTarifas.commitBuffer())
		return false;

	return true;
}

function oficial_asociarArticuloTarifa(refArticulo:String, codTarifa:String):Boolean
{
	var queryArticulo:FLSqlQuery = new FLSqlQuery();
	queryArticulo.setTablesList("articulos");
	queryArticulo.setSelect("pvp");
	queryArticulo.setFrom("articulos");
	queryArticulo.setWhere("referencia = '" + refArticulo + "'");

	if ( !queryArticulo.exec() || !queryArticulo.first() )
		return false;


	var curArticuloTarifa:FLSqlCursor = new FLSqlCursor("articulostarifas");
	curArticuloTarifa.setModeAccess(curArticuloTarifa.Insert);
	curArticuloTarifa.refreshBuffer();
	curArticuloTarifa.setValueBuffer("codtarifa", codTarifa);
	curArticuloTarifa.setValueBuffer("referencia", refArticulo);
	curArticuloTarifa.setValueBuffer("pvp", queryArticulo.value(0));
	curArticuloTarifa.setValueBuffer("pvpconiva", queryArticulo.value(0));
	curArticuloTarifa.setValueBuffer("iddat_articulostarifas", this.cursor().valueBuffer("iddat_articulostarifas"));

	if ( !curArticuloTarifa.commitBuffer() )
		return false;

	return true;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
