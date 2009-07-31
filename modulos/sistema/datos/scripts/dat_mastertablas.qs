/***************************************************************************
                            dat_mastertablas.qs
                            -------------------
   begin                : lun dic 13 2004
   copyright            : (C) 2004-2005 by InfoSiAL S.L.
   email                : mail@infosial.com
***************************************************************************/
/***************************************************************************
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; version 2 of the License.               *
 ***************************************************************************/ 
/***************************************************************************
   Este  programa es software libre. Puede redistribuirlo y/o modificarlo
   bajo  los  términos  de  la  Licencia  Pública General de GNU   en  su
   versión 2, publicada  por  la  Free  Software Foundation.
 ***************************************************************************/

/** @file */

////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_declaration interna */
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
	function vaciarTabla( tabla ) { return this.ctx.oficial_vaciarTabla( tabla ); } 
	function listaDeTablas():Array { return this.ctx.oficial_listaDeTablas(); }
	function cargarListaTablas() { return this.ctx.oficial_cargarListaTablas(); }
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

////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_definition interna */
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////

function init() {
    this.iface.init();
}

function interna_init() 
{
	this.iface.vaciarTabla( "dat_tablas" );
	this.iface.cargarListaTablas();

	this.child( "tableDBRecords" ).setEditOnly( true );
	connect(this.child("tableDBRecords"), "currentChanged()", this.child("tableDBRecords"), "refresh()");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_vaciarTabla( tabla ) 
{
	var curTabla:FLSqlCursor = new FLSqlCursor( tabla );
	with ( curTabla ) {
		setActivatedCheckIntegrity( false );
		select();
		while ( next() ) {
			setModeAccess( Del );
			refreshBuffer();
			if ( !commitBuffer() )
				break;
		}
	}
}

function oficial_listaDeTablas():Array 
{
	var lista:Array = [];
	var cur:FLSqlCursor = new FLSqlCursor( "flfiles" );
	var i = 0;

	with ( cur ) {
		select( "nombre LIKE '%.mtd'" );
		while ( next() )
			lista[ i++ ] = valueBuffer( "nombre" ).replace( "\.mtd", "" );
	}

	return lista;
}

function oficial_cargarListaTablas() 
{
	var tablas:Array = this.iface.listaDeTablas();
	var cursor:FLSqlCursor = this.cursor();

	with ( cursor ) {
		for ( i = 0; i < tablas.length; i++ ) {
			setModeAccess( Insert );
			refreshBuffer();
			setValueBuffer( "codtabla", tablas[ i ] );
			if ( !commitBuffer() )
				break;
		}
		refresh();
	}
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////