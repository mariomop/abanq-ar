/***************************************************************************
                              dat_procesose_mod.qs
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
	function establecerDirectorio() { return this.ctx.oficial_establecerDirectorio(); }
	function actualizarControles() { return this.ctx.oficial_actualizarControles(); }
	function exportar() { return this.ctx.oficial_exportar(); }
	function bufferChanged( fN ) { return this.ctx.oficial_bufferChanged( fN ); }
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

	this.iface.actualizarControles();

	connect( this.child( "pbExaminar" ), "clicked()", this, "iface.establecerDirectorio" );
	connect( this.child( "pbnExportar" ), "clicked()", this, "iface.exportar" );
	connect( this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged" );
	
	this.child("fdbModulo").setFilter("idmodulo <> 'sys'");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_establecerDirectorio() 
{
	var util:FLUtil = new FLUtil();
	this.child( "fdbDirCSV" ).setValue( FileDialog.getExistingDirectory( util.translate( "scripts", "Texto CSV (*.csv)" ), util.translate( "scripts", "Elegir Directorio" ) ) );
}


function oficial_actualizarControles() 
{
	var curModulo:FLSqlCursor = this.child( "fdbModulo" ).cursor();
	var pbnExportar:Object = this.child( "pbnExportar" );

	if ( curModulo.table() == "dat_void" )
		pbnExportar.enabled = false;
	else
		pbnExportar.enabled = true;
}


function oficial_exportar() 
{
	var util:FLUtil = new FLUtil();
	
	var cursor:FLSqlCursor = this.cursor();
	var dir:String = cursor.valueBuffer( "dircsv" );
	var idModulo:String = cursor.valueBuffer( "idmodulo" );
	var tabla:String, fichero:String;

	if ( !dir || dir == "" || !idModulo || idModulo == "" )
		return ;
	
	if ( !File.isDir(dir)) {
		MessageBox.critical
		( util.translate( "scripts", "El directorio indicado no es válido" ),
		MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
		
	this.setDisabled( true );
	
	var numTablas:Number = util.sqlSelect( "flfiles", "count(nombre)", "nombre like '%.mtd' AND idmodulo = '" + idModulo + "'");
	util.createProgressDialog( util.translate( "scripts", "Exportando tablas..." ),	numTablas );
	util.setProgress(1);
	var paso:Number = 0;
			
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("flfiles");
	q.setSelect("nombre");
	q.setFrom("flfiles");
	q.setWhere("nombre like '%.mtd' AND idmodulo = '" + idModulo + "'");
	
	if (!q.exec()) return;
	
	while (q.next()) {
	
		util.setLabelText(util.translate( "scripts", "Exportando tabla " ) + tabla.toUpperCase());
		
		tabla = q.value(0).toString().split(".");
		tabla = tabla[0];
		
		fichero = dir + "/" + tabla + ".csv";
		
		formRecorddat_procesose_tab.iface.pub_exportarTabla(tabla, fichero);
		util.setProgress(paso++);
	}

	util.destroyProgressDialog();
	this.setDisabled( false );
	
	this.iface.actualizarControles();
	
	MessageBox.information
	( util.translate( "scripts", "Proceso finalizado" ),
	MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
}

function oficial_bufferChanged( fN )
{
	switch ( fN ) {
	case "idmodulo":
		this.iface.actualizarControles();
		break;
	case "dircsv":
		this.iface.actualizarControles();
		break;
	}
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////