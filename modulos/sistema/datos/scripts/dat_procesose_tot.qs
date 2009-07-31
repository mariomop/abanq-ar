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
	function exportar() { return this.ctx.oficial_exportar(); }
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
	connect( this.child( "pbExaminar" ), "clicked()", this, "iface.establecerDirectorio" );
	connect( this.child( "pbnExportar" ), "clicked()", this, "iface.exportar" );
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


function oficial_exportar() 
{
	var util:FLUtil = new FLUtil();
	
	var cursor:FLSqlCursor = this.cursor();
	var dir:String = cursor.valueBuffer( "dircsv" );
	var tabla:String, fichero:String;

	if ( !File.isDir(dir)) {
		MessageBox.critical
		( util.translate( "scripts", "El directorio indicado no es válido" ),
		MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
		
	this.setDisabled( true );
	
	var numTablas:Number = util.sqlSelect( "flfiles", "count(nombre)",	"nombre like '%.mtd' AND idmodulo <> ''");
	util.createProgressDialog( util.translate( "scripts", "Exportando tablas... " ), numTablas );
	util.setProgress(1);
	var paso:Number = 0;
			
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("flfiles");
	q.setSelect("nombre");
	q.setFrom("flfiles");
	q.setWhere("nombre like '%.mtd' AND idmodulo <> ''");
	
	if (!q.exec()) return;
	
	while (q.next()) {
		tabla = q.value(0).toString().split(".");
		tabla = tabla[0];
		util.setLabelText(util.translate( "scripts", "Exportando tabla " ) + tabla.toUpperCase());
		
		fichero = dir + "/" + tabla + ".csv";
		
		formRecorddat_procesose_tab.iface.pub_exportarTabla(tabla, fichero);
		util.setProgress(paso++);
	}

	util.destroyProgressDialog();
	this.setDisabled( false );
	
	MessageBox.information ( util.translate( "scripts", "Proceso finalizado" ), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////