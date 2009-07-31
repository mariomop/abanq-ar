/***************************************************************************
                              dat_procesose_tab.qs
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
	var sep:String = "ð";
	var eol:String = "Ö";
    function oficial( context ) { interna( context ); }
	function establecerFichero() { return this.ctx.oficial_establecerFichero() ; }
	function actualizarControles() { return this.ctx.oficial_actualizarControles() ; }
	function actualizarTabla() { return this.ctx.oficial_actualizarTabla() ; }
	function exportar() { return this.ctx.oficial_exportar() ; }
	function exportarTabla(tabla, fichero, progress) { return this.ctx.oficial_exportarTabla(tabla, fichero, progress) ; }
	function bufferChanged( fN ) { return this.ctx.oficial_bufferChanged( fN ) ; }
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
	function pub_exportarTabla(tabla, fichero, progress) { return this.exportarTabla(tabla, fichero, progress) ; }
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
	var tdbTabla:FLTableDB = this.child( "tdbTabla" );

	tdbTabla.setReadOnly( true );

	this.iface.actualizarTabla();
	this.iface.actualizarControles();

	connect( this.child( "pbExaminar" ), "clicked()", this, "iface.establecerFichero" );
	connect( this.child( "pbnExportar" ), "clicked()", this, "iface.exportar" );
	connect( this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged" );
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_establecerFichero() 
{
	var util:FLUtil = new FLUtil();
	this.child( "fdbDir" ).setValue( FileDialog.getExistingDirectory( util.translate( "scripts", "Texto CSV (*.csv)" ), util.translate( "scripts", "Elegir Fichero" ) ) );
}

function oficial_actualizarControles() 
{
	
	var pbnExportar:Object = this.child( "pbnExportar" );
	var curTabla:FLSqlCursor = this.child( "tdbTabla" ).cursor();
	
	if ( curTabla.table() == "dat_void" )
		pbnExportar.enabled = false;
	else
		pbnExportar.enabled = true;
}

function oficial_actualizarTabla() 
{
	var cursor:FLSqlCursor = this.cursor();
	var codTabla:String = cursor.valueBuffer( "codtabla" );
	var tdbTabla:FLTableDB = this.child( "tdbTabla" );

	if ( !codTabla || codTabla == "" ) {
		tdbTabla.setTableName( "dat_void" );
		tdbTabla.refresh( true, true );
		return ;
	}

	tdbTabla.setTableName(codTabla);
	tdbTabla.refresh( true, true );

 	var nomFichero:Array = codTabla.toString().split(".");
	this.child("leFichero").text = nomFichero[0] + ".csv";
}

function oficial_exportar() 
{
	var util:FLUtil = new FLUtil();
	
	var cursor:FLSqlCursor = this.cursor();
	var fichero:String = cursor.valueBuffer( "dircsv" ) + "/" + this.child("leFichero").text;
	var codTabla:String = cursor.valueBuffer( "codtabla" );

	if ( !fichero || fichero == "" || !codTabla || codTabla == "" )
		return ;

	this.setDisabled( true );
	
	var resultExport:Boolean = this.iface.exportarTabla(codTabla, fichero, true);
	
	this.setDisabled( false );
	this.iface.actualizarControles();

	if (resultExport) 
		MessageBox.information
		( util.translate( "scripts", "Proceso finalizado" ),
		MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
	else
		MessageBox.information
		( util.translate( "scripts", "Se produjo un error. La tabla no se exportó" ),
		MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
}

function oficial_exportarTabla(tabla, fichero, progress)
{
	var util:FLUtil = new FLUtil();
	var file = new File( fichero );

	try {	
		file.open( File.WriteOnly );
	}
	catch (e) {
		MessageBox.warning( util.translate( "scripts", "Imposible abrir el fichero ") + file.name + util.translate( "scripts", " para escritura\nCompruebe que la ruta es válida y que los permisos de escritura son correctos"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return false;
	}
	
	var listaCampos:Array = util.nombreCampos(tabla);
	if (listaCampos.length == 0) {
		MessageBox.warning( util.translate( "scripts", "La tabla ") + tabla + util.translate( "scripts", " no tiene estructura. No se exportará"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return false;
	}
	
	var numCampos:Number = parseFloat(listaCampos[0]);
	var campos:String = ""
	var linea:String = "";
	var campoLinea:String;
	var select:String = listaCampos[1];
	for (i = 2; i <= numCampos; i++)
		select += ", " + listaCampos[i];

	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList(tabla);
	q.setSelect(select);
	q.setFrom(tabla);
	
	var paso:Number = 0;
	var numRegistros:Number;
	if (progress) {
		numRegistros = util.sqlSelect( tabla, "count(*)", "1 = 1" );
		util.createProgressDialog( util.translate( "scripts", "Exportando tabla..." ), numRegistros );
		util.setProgress(1);
	}

	for (i = 1; i <= numCampos - 1; i++)
			campos += listaCampos[i] + this.iface.sep;
	campos += listaCampos[i];
	
	file.writeLine(campos);
	
	if (!q.exec()) return;
	
	while ( q.next() ) {
		
		if (progress) util.setProgress( paso++ );
		
		linea = "";
 		for (i = 0; i < numCampos; i++) {
			campoLinea = "";
			if (!q.isNull(i)) campoLinea = q.value(i);
			linea += campoLinea + this.iface.sep;
		}
		linea += this.iface.eol;
		
		file.writeLine(linea);
	}
	
	file.close();
	
	if (progress) {
		util.setProgress( numRegistros );
		util.destroyProgressDialog();
	}
	
	return true;
	
}

function oficial_bufferChanged( fN ) 
{
	switch ( fN ) {
	case "codtabla":
		this.iface.actualizarTabla();
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
