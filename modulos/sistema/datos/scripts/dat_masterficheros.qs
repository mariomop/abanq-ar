/***************************************************************************
                          dat_masterficheros.qs
                            -------------------
   begin                : mie mar 16 2005
   copyright            : (C) 2005 by InfoSiAL S.L.
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
	function establecerRuta() { return this.ctx.oficial_establecerRuta();}
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

function interna_init() {
	var util:FLUtil = new FLUtil();
	
	var rutaDatos:String = util.sqlSelect("dat_opciones", "rutaDatos", "");
	if (File.isDir(rutaDatos))
			this.child("leRuta").setText(rutaDatos);
	else 
			this.child("leRuta").setText(util.translate( "scripts", "RUTA NO ESTABLECIDA" ));
	
	connect( this.child( "pbnRuta" ), "clicked()", this, "iface.establecerRuta" );
	connect(this.child("tableDBRecords"), "currentChanged()", this.child("tableDBRecords"), "refresh()");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_establecerRuta()
{
	var util:FLUtil = new FLUtil();
	
	var rutaDatos:String = FileDialog.getExistingDirectory( util.translate( "scripts", "Texto CSV (*.txt;*.csv;)" ), util.translate( "scripts", "RUTA A LOS FICHEROS DE DATOS" ) );
	
	if ( !File.isDir( rutaDatos ) ) {
		MessageBox.information( util.translate( "scripts", "Ruta errónea" ),
								MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return ;
	}
	this.child("leRuta").setText(rutaDatos.toString());
	
	var curOpciones:FLSqlCursor = new FLSqlCursor("dat_opciones");
	curOpciones.select();
	if (curOpciones.first())
			curOpciones.setModeAccess(curOpciones.Edit);
	else
			curOpciones.setModeAccess(curOpciones.Insert);
	
	curOpciones.refreshBuffer();
	curOpciones.setValueBuffer("rutaDatos", rutaDatos);
	curOpciones.commitBuffer();

}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////