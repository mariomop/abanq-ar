/***************************************************************************
                      dat_articulosprov.qs  -  description
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
	function asociarArticuloProveedor(refArticulo:String, codProveedor:String):Boolean {
		return this.ctx.oficial_asociarArticuloProveedor(refArticulo, codProveedor);
	}
	function excluirArticuloProveedor(refArticulo:String, codProveedor:String):Boolean {
		return this.ctx.oficial_excluirArticuloProveedor(refArticulo, codProveedor);
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

	tdbArticulos.cursor().setMainFilter("referencia IN ( SELECT referencia FROM articulosprov WHERE iddat_articulosprov = '" + cursor.valueBuffer("iddat_articulosprov") + "' )");
	tdbArticulos.refresh();

}

function interna_calculateCounter():Number
{
	var util:FLUtil = new FLUtil();
	var cadena:String = util.sqlSelect("dat_articulosprov", "iddat_articulosprov", "1 = 1 ORDER BY iddat_articulosprov DESC");
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
	
	if (!cursor.valueBuffer("codproveedor")) {
		MessageBox.warning(util.translate("scripts", "Debe indicar un proveedor"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return;
	}
	
	var f:Object = new FLFormSearchDB("dat_seleccionarticulosprov");
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
	curArticulos.setValueBuffer("filtro", "referencia NOT IN ( SELECT referencia FROM articulosprov WHERE codproveedor = '" + cursor.valueBuffer("codproveedor") + "' )");

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

	util.createProgressDialog( "Creando artículos de proveedores....", articulos.length );

	for (var i:Number = 0; i < articulos.length; i++) {
		util.setProgress( i );
		if (!this.iface.asociarArticuloProveedor(articulos[i], cursor.valueBuffer("codproveedor"))) {
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
	if (!this.iface.excluirArticuloProveedor(articulo, this.cursor().valueBuffer("codproveedor")))
		return;

	this.child("tdbArticulos").refresh();
}

function oficial_excluirArticuloProveedor(refArticulo:String, codProveedor:String):Boolean
{
	var curArticulosProv:FLSqlCursor = new FLSqlCursor("articulosprov");
	curArticulosProv.select("referencia = '" + refArticulo + "' AND codproveedor = '" + codProveedor + "'");

	if (!curArticulosProv.first())
		return false;

	curArticulosProv.setModeAccess(curArticulosProv.Del);
	curArticulosProv.refreshBuffer();

	if (!curArticulosProv.commitBuffer())
		return false;

	return true;
}

function oficial_asociarArticuloProveedor(refArticulo:String, codProveedor:String):Boolean
{
	var queryArticulo:FLSqlQuery = new FLSqlQuery();
	queryArticulo.setTablesList("articulos");
	queryArticulo.setSelect("costemaximo");
	queryArticulo.setFrom("articulos");
	queryArticulo.setWhere("referencia = '" + refArticulo + "'");

	if ( !queryArticulo.exec() || !queryArticulo.first() )
		return false;


	var queryProveedor:FLSqlQuery = new FLSqlQuery();
	queryProveedor.setTablesList("proveedores");
	queryProveedor.setSelect("nombre,coddivisa");
	queryProveedor.setFrom("proveedores");
	queryProveedor.setWhere("codproveedor = '" + codProveedor + "'");

	if ( !queryProveedor.exec() || !queryProveedor.first() )
		return false;


	var curArtProv:FLSqlCursor = new FLSqlCursor("articulosprov");
	curArtProv.setModeAccess(curArtProv.Insert);
	curArtProv.refreshBuffer();
	curArtProv.setValueBuffer("referencia", refArticulo);
	curArtProv.setValueBuffer("codproveedor", codProveedor);
	curArtProv.setValueBuffer("nombre", queryProveedor.value(0));
	curArtProv.setValueBuffer("coddivisa", queryProveedor.value(1));
	curArtProv.setValueBuffer("coste", queryArticulo.value(0));
	curArtProv.setValueBuffer("pordefecto", true);
	curArtProv.setValueBuffer("iddat_articulosprov", this.cursor().valueBuffer("iddat_articulosprov"));

	if ( !curArtProv.commitBuffer() )
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
