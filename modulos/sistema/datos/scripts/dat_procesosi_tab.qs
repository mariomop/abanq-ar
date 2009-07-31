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
	var llamadaInterna:Boolean = false;
	var lineasImportadas:Number;
	var myUtil:FLUtil = new FLUtil();
    function oficial( context ) { interna( context ); } 
	function establecerFichero() { return this.ctx.oficial_establecerFichero() ;}
	function actualizarControles() { return this.ctx.oficial_actualizarControles() ;}
	function actualizarTabla() { return this.ctx.oficial_actualizarTabla() ;}
	function importar() { return this.ctx.oficial_importar() ;}
	function importarTabla(tabla, fichero, aCommitActions, progress) { return this.ctx.oficial_importarTabla(tabla, fichero, aCommitActions, progress) ;}
	function procesarSerials(tabla, camposTabla):Array { return this.ctx.oficial_procesarSerials(tabla, camposTabla) ;}
	function actualizarSerial(tabla, campoSerial) { return this.ctx.oficial_actualizarSerial(tabla, campoSerial) ;}
	function comprobarCampos(camposTabla, camposFichero):Boolean { return this.ctx.oficial_comprobarCampos(camposTabla, camposFichero) ;}
	function leerLinea(file):String { return this.ctx.oficial_leerLinea(file) ;}
	function bufferChanged( fN ) { return this.ctx.oficial_bufferChanged( fN ) ;}
	function crearProgress(label, numPasos) { return this.ctx.oficial_crearProgress(label, numPasos) ;}
	function setProgress(valor)  { return this.ctx.oficial_setProgress(valor) ;}
	function destroyProgress()  { return this.ctx.oficial_destroyProgress() ;}
	function preprocesarFichero(tabla, file)  { return this.ctx.oficial_preprocesarFichero(tabla, file) ;}
	function importarTablaImpuestos(fichero):Boolean { return this.ctx.oficial_importarTablaImpuestos(fichero) ;}
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
	function pub_importarTabla(tabla, fichero, aCommitActions, progress) { return this.importarTabla(tabla, fichero, aCommitActions, progress) ;}
	function pub_crearProgress(label, numPasos) { return this.crearProgress(label, numPasos) ;}
	function pub_setProgress(valor)  { return this.setProgress(valor) ;}
	function pub_destroyProgress()  { return this.destroyProgress() ;}
	function pub_importarTablaImpuestos(fichero) { return this.importarTablaImpuestos(fichero) ;}
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
	connect( this.child( "pbnImportar" ), "clicked()", this, "iface.importar" );
	connect( this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged" );
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_establecerFichero() 
{
	this.child( "fdbFich" ).setValue( FileDialog.getOpenFileName( this.iface.myUtil.translate( "scripts", "Texto CSV (*.csv)" ), this.iface.myUtil.translate( "scripts", "Elegir Fichero" ) ) );
}


function oficial_actualizarControles() 
{
	
	var pbnImportar:Object = this.child( "pbnImportar" );
	
	if ( this.child( "tdbTabla" ).tableName == "dat_void" )
		pbnImportar.enabled = false;
	else
		pbnImportar.enabled = true;

	if ( this.cursor().valueBuffer( "borradoprevio" ) ) {
		this.child("fdbNoExistentes").setDisabled(true);
		this.child("fdbNoExistentes").setValue(false);
	}
	else
		this.child("fdbNoExistentes").setDisabled(false);
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

}

function oficial_importar() 
{
	var cursor:FLSqlCursor = this.cursor();
	var fichero:String = cursor.valueBuffer( "fichcsv" );
	var codTabla:FLTableDB = cursor.valueBuffer( "codtabla" );
	var borradoPrevio:Boolean = cursor.valueBuffer( "borradoprevio" );

	if ( !fichero || fichero == "" || !codTabla || codTabla == "" )
		return ;

	this.setDisabled( true );
	
  	if (borradoPrevio) {
		var res = MessageBox.critical( this.iface.myUtil.translate( "scripts", "Se va a proceder a eliminar TODOS los registros de la tabla\nantes de la importación de los nuevos datos.\n\n¿Está realmente seguro?" ), MessageBox.No, MessageBox.Yes, MessageBox.NoButton );
		
		if ( res != MessageBox.Yes ) {
			this.setDisabled( false );
			return;
		}
	
		fldatosppal.iface.pub_crearProgress( this.iface.myUtil.translate( "scripts", "Vaciando tabla..."),
			this.iface.myUtil.sqlSelect( codTabla, "count(*)", "1=1" ));
		fldatosppal.iface.pub_setProgress(1);
		fldatosppal.iface.pub_vaciarTabla(codTabla, true, true);
		fldatosppal.iface.pub_destroyProgress();
	}
	
	var file = new File( fichero );
	this.iface.crearProgress( this.iface.myUtil.translate( "scripts", "Buscando dependencias..."),			
			fldatosppal.iface.pub_numLineas(file) );
	this.iface.setProgress(1);
	
	this.iface.llamadaInterna = true;
  	var resultImport = this.iface.importarTabla(codTabla, fichero);
	
	this.iface.pub_destroyProgress()
	this.child( "tdbTabla" ).refresh();
	
	this.setDisabled( false );
	this.iface.actualizarControles();

	if (resultImport == "cancel") {
		MessageBox.information
		( this.iface.myUtil.translate( "scripts", "Se canceló la importación" ),
		MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		this.close();
		return;
	}
	
	if (resultImport) {
		MessageBox.information
		( this.iface.myUtil.translate( "scripts", "Proceso finalizado. Registros importados: ") + resultImport,
		MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		this.child("pushButtonAccept").animateClick();
	}
	else {
		MessageBox.information
		( this.iface.myUtil.translate( "scripts", "Se produjo un error. La tabla no se importó correctamente" ),
		MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		this.close();
	}
}


function oficial_importarTabla(tabla, fichero, aCommitActions)
{	
	var file = new File( fichero );
	var arrayLineas = this.iface.preprocesarFichero(tabla, file);

	var listaCampos:Array = this.iface.myUtil.nombreCampos(tabla);
	if (listaCampos.length == 0) {
		MessageBox.warning( this.iface.myUtil.translate( "scripts", "La tabla ") + tabla.toUpperCase() + this.iface.myUtil.translate( "scripts", " no ha sido cargada\nCargue el módulo que contiene esta tabla y repita la importación"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return false;
	}
	
	var numCampos:Number = parseFloat(listaCampos[0]);
	var campos:String = ""
	var linea:String = "";
	var paso:Number = 0;
	var resFallo:Boolean = false;

	linea = arrayLineas[0];
	campos = linea.split(this.iface.sep);
	
	if (!this.iface.comprobarCampos(listaCampos, campos)) {
		var res = MessageBox.warning( this.iface.myUtil.translate( "scripts", "Los campos de la tabla ") + tabla.toUpperCase() + this.iface.myUtil.translate( "scripts", " no corresponden a los campos del fichero seleccionado\nComprueba que las versiones con correctas. La tabla no se importará\n\n¿Continuar la importación?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton );
		if ( res != MessageBox.Yes )
				return "cancel";
	}

/*	var arraySerial:Array = this.iface.procesarSerials(tabla, listaCampos);
	var indiceSerial:Number = 0;
	var valorSerial:Number = 0;
	if (arraySerial) {
		indiceSerial = arraySerial["indice"];
		valorSerial = arraySerial["valorUltimo"];
	}*/
	
	var curTabla:FLSqlCursor = new FLSqlCursor(tabla);
	if (aCommitActions) curTabla.setActivatedCommitActions(false);
	
	this.iface.myUtil.setLabelText(this.iface.myUtil.translate( "scripts", "Importando tabla ") + tabla.toUpperCase() + this.iface.myUtil.translate( "scripts", "\n\nProgreso total:"));
	
	for (var j = 1; j < arrayLineas.length; j++) {
		
		linea = arrayLineas[j];
		
		if (!this.iface.leerLinea) {
			MessageBox.critical( fichero + this.iface.myUtil.translate( "scripts", ": hubo un problema al leer este fichero. No se encontró el caracter de fin de línea\nCompruebe que el formato es correcto" ), MessageBox.No, MessageBox.Yes, MessageBox.NoButton );
			return false;
		}
			
		campos = linea.split(this.iface.sep);
		
		curTabla.setModeAccess(curTabla.Insert);
		curTabla.refreshBuffer();

		// En tres pasos para agilizar
// 		for (i = 0; i < indiceSerial; i++)
// 				curTabla.setValueBuffer(listaCampos[i+1], campos[i])
// 		
// 		if (arraySerial)
// 				curTabla.setValueBuffer(listaCampos[indiceSerial], valorSerial++);
// 		
// 		for (i = indiceSerial; i < numCampos; i++) {
// 			curTabla.setValueBuffer(listaCampos[i+1], campos[i])
// 		}

		this.iface.myUtil.setProgress( this.iface.lineasImportadas++ );
		
		for (i = 0; i < numCampos; i++) {
			if (campos[i]) curTabla.setValueBuffer(listaCampos[i+1], campos[i]);
		}
		if (!curTabla.commitBuffer() && !resFallo)  {
			var res = MessageBox.critical( this.iface.myUtil.translate( "scripts", "Hubo un problema en la importación de la tabla ") + tabla.toUpperCase() + this.iface.myUtil.translate( "scripts", "\n¿Desea continuar importando esta tabla?\n\nEste mensaje no se repetirá para esta tabla. Pulse cancelar para detener todo el proceso" ), MessageBox.No, MessageBox.Yes, MessageBox.Cancel );
			
			if ( res == MessageBox.Cancel )
				return "cancel";
			if ( res != MessageBox.Yes )
				return false;
			else
				resFallo = true;
		}
			
	}
	
// 	if (arraySerial) this.iface.actualizarSerial(tabla, listaCampos[indiceSerial]);
	
	if (aCommitActions) curTabla.setActivatedCommitActions(true);
	file.close();
	
	var lineasImportadas = arrayLineas.length - 1;
	return lineasImportadas.toString();
}

function oficial_procesarSerials(tabla, camposTabla):Array
{
	// Tipo serial: fieldType = 100
	var curTabla:FLSqlCursor = new FLSqlCursor(tabla);

	var campoSerial:String = "";
	var indiceSerial:Number = 0;
	
	for (i = 1; i < camposTabla.length; i++) {
	
 		if (curTabla.fieldType(camposTabla[i]) == 100) {
			campoSerial = camposTabla[i];
			indiceSerial = i;
		}
	}
	if (campoSerial == "") return false;
	
	var maxSerial:Number = this.iface.myUtil.sqlSelect( tabla, "max(" + campoSerial + ")", "1 = 1" );
	var contSerial:Number = maxSerial + 1;

	
/*	curTabla.select("1=1 ORDER BY " + campoSerial + " DESC");
	while (curTabla.next()) {
		curTabla.setModeAccess(curTabla.Edit);
		curTabla.refreshBuffer();
		curTabla.setValueBuffer(campoSerial, contSerial--);
 		curTabla.commitBuffer();
	}*/
	
	var arraySerial:Array = [];
	arraySerial["indice"] = indiceSerial;
	arraySerial["valorUltimo"] = maxSerial + 2;
	
	return arraySerial;
}

/* Después de insertar un conjunto de registros de una 
tabla con un campo serial, si el valor máximo de dicho
campo queda por delante de la secuencia de base de datos
para el mismo campo, se producirá un solapamiento en el futuro
Por ello se pone la secuencia de bd automáticamente al
valor máximo del campo
*/
function oficial_actualizarSerial(tabla, campoSerial)
{
	var nomSequence:String = tabla + "_" + campoSerial + "_seq";
	
	var lastSerial:Number = this.iface.myUtil.sqlSelect( tabla, "max(" + campoSerial + ")", "" );
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("");
	q.setFrom(nomSequence);
	
	q.setSelect("last_value");
	
	// Si el driver no es el de postgres no será necesario tocar la secuencia
	if (!q.exec()) return;
	if (!q.first()) return;
	
	var lastSequence:Number = q.value(0);
	
	q.setSelect("nextval('" + nomSequence + "')");
	for (var i = lastSequence; i < lastSerial; i++)
			q.exec();
}

// Comprueba que los nombres de campos del fichero a importar coinciden
// con los nombres de campo de las tablas

function oficial_comprobarCampos(camposTabla, camposFichero):Boolean
{
	var sonIguales:Boolean = true;
	
	// Comprobar el número de campos
	if (camposTabla.length - 1 != camposFichero.length)	{
		sonIguales = false;
		return sonIguales		
	}
	
	for (i = 0; i < camposFichero.length - 1; i++) {
		if (camposTabla[i+1].toString() != camposFichero[i].toString())	{
			sonIguales = false;
		}
	}
	// EL último campos del fichero tiene un salto de línea al final
	var ultimoCampo:String = camposFichero[i].toString();
	ultimoCampo = ultimoCampo.left(ultimoCampo.length - 1)
	
	if (camposTabla[i+1].toString() != ultimoCampo)	{
		sonIguales = false;
	}
	
	return sonIguales		
}

// Algunos registros contienen saltos de línea y ocupan
// varias líneas en el fichero csv

function oficial_leerLinea(file):String
{
	var finLinea:Boolean = false;
	var linea:String = "";
	var lineaBuffer:String = "";
	var paso:Number = 0;
	
	while (!finLinea && !file.eof) {
		lineaBuffer = file.readLine();
		linea += lineaBuffer;
		if (lineaBuffer.charAt(lineaBuffer.length - 2) == this.iface.eol) finLinea = true;
	}
	return linea;
}


/** Recorre el fichero buscando registros existentes y devuelve un
array con los registros nuevos
*/
function oficial_preprocesarFichero(tabla, file):Array
{
	try {
		file.open( File.ReadOnly );
	}
	catch (e) {
		return false;
	}
	
	var arrayLineas:Array;
	var numLineas:Number = 0;

	if (!this.iface.llamadaInterna) {
		arrayLineas[numLineas++] = file.readLine();
		while ( !file.eof )
				arrayLineas[numLineas++] = this.iface.leerLinea(file);
	
		return arrayLineas;
	}
	
	if (!this.cursor().valueBuffer("noexistentes")) {
		arrayLineas[numLineas++] = file.readLine();
		while ( !file.eof )
				arrayLineas[numLineas++] = this.iface.leerLinea(file);
		return arrayLineas;
	}
		
	// Comprueba si está duplicado el registro
	var curTabla:FLSqlCursor = new FLSqlCursor(tabla);
	var pk:String = curTabla.primaryKey();
	
	var linea:String = file.readLine();
	var campos:Array = linea.split(this.iface.sep);
	
	var indicePK:Number = -1;
	for (var i = 0; i < campos.length; i++) 
		if (campos[i] == pk) indicePK = i;
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList(tabla);
	q.setFrom(tabla);
	q.setSelect(pk);
	
	arrayLineas[numLineas++] = linea; // nombres de campos
	while ( !file.eof ) {
		linea = this.iface.leerLinea(file);
		campos = linea.split(this.iface.sep);
		q.setWhere(pk + " = '" + campos[indicePK] + "'");
		q.exec();
		if (!q.first())
			arrayLineas[numLineas++] = linea;
	}
	
	return arrayLineas;
}


// Pone el contador de líneas importadas a cero y crea el progressDialog
function oficial_crearProgress(label, numPasos)
{
	this.iface.myUtil.createProgressDialog( label, numPasos );
	this.iface.lineasImportadas = 0;
}

function oficial_setProgress(valor)
{
	this.iface.myUtil.setProgress( valor );
}

function oficial_destroyProgress()
{
	this.iface.myUtil.destroyProgressDialog();
}

function oficial_bufferChanged( fN )
{
	switch ( fN ) {
	case "codtabla":
		this.iface.actualizarTabla();
		this.iface.actualizarControles();
		break;
	case "fichcsv":
		this.iface.actualizarControles();
		break;
	case "borradoprevio":
		this.iface.actualizarControles();
		break;
	}
}

function oficial_importarTablaImpuestos(fichero)
{	
	var file = new File( fichero );
	var tabla:String = "impuestos";
	var arrayLineas = this.iface.preprocesarFichero(tabla, file);

	var listaCampos:Array = ["3", "codimpuesto", "descripcion", "iva"];
	
	var numCampos:Number = parseFloat(listaCampos[0]);
	var campos:String = ""
	var linea:String = "";
	var paso:Number = 0;
	var resFallo:Boolean = false;

	linea = arrayLineas[0];
	campos = linea.split(this.iface.sep);
	
	var curTabla:FLSqlCursor = new FLSqlCursor(tabla);
	
	this.iface.myUtil.setLabelText(this.iface.myUtil.translate( "scripts", "Importando tabla ") + tabla.toUpperCase() + this.iface.myUtil.translate( "scripts", "\n\nProgreso total:"));
	
	for (var j = 1; j < arrayLineas.length; j++) {
		
		linea = arrayLineas[j];
		
		if (!this.iface.leerLinea) {
			MessageBox.critical( fichero + this.iface.myUtil.translate( "scripts", ": hubo un problema al leer este fichero. No se encontró el caracter de fin de línea\nCompruebe que el formato es correcto" ), MessageBox.No, MessageBox.Yes, MessageBox.NoButton );
			return false;
		}
			
		campos = linea.split(this.iface.sep);
		
		curTabla.setModeAccess(curTabla.Insert);
		curTabla.refreshBuffer();

		this.iface.myUtil.setProgress( this.iface.lineasImportadas++ );
		
		for (i = 0; i < numCampos; i++) {
			if (campos[i]) curTabla.setValueBuffer(listaCampos[i+1], campos[i]);
		}
		if (!curTabla.commitBuffer() && !resFallo)  {
			var res = MessageBox.critical( this.iface.myUtil.translate( "scripts", "Hubo un problema en la importación de la tabla ") + tabla.toUpperCase() + this.iface.myUtil.translate( "scripts", "\n¿Desea continuar importando esta tabla?\n\nEste mensaje no se repetirá para esta tabla. Pulse cancelar para detener todo el proceso" ), MessageBox.No, MessageBox.Yes, MessageBox.Cancel );
			
			if ( res == MessageBox.Cancel )
				return "cancel";
			if ( res != MessageBox.Yes )
				return false;
			else
				resFallo = true;
		}
			
	}
	
	file.close();
	
	var lineasImportadas = arrayLineas.length - 1;
	return lineasImportadas.toString();
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////