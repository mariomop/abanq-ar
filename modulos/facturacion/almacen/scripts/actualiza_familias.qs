/***************************************************************************
                 actualiza_familias.qs  -  description
                             -------------------
    begin                : lun mar 15 2010
    copyright            : (C) 2010 by Silix
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
	var tdbFamilias:Object;
	var tdbFamiliasSel:Object;

    function oficial( context ) { interna( context ); }
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function seleccionar() {
		return this.ctx.oficial_seleccionar();
	}
	function seleccionarTodos() {
		return this.ctx.oficial_seleccionarTodos();
	}
	function quitar() {
		return this.ctx.oficial_quitar();
	}
	function quitarTodos() {
		return this.ctx.oficial_quitarTodos();
	}
	function refrescarTablas() {
		return this.ctx.oficial_refrescarTablas();
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration actFamilias */
///////////////////////////////////////////////////////////////////
//// ACT_FAMILIAS /////////////////////////////////////////////////
class actFamilias extends oficial 
{
	var CR:Number;
	var sep:String = ";";
	var tablaDestino:String = "familiasactualizadas";
	var corr = [];
	var pos = [];
	var arrayNomCampos = [];
	var arrayNomCamposDefecto = [];
	var arrayMasCampos = [];
	
    function actFamilias( context ) { oficial ( context ); }
	function init() {
		return this.ctx.actFamilias_init();
	}
	function importar() {
		return this.ctx.actFamilias_importar();
	}
	function preprocesarFichero(tabla:String, file, posClaveFich:String, encabezados:String):Array {
		return this.ctx.actFamilias_preprocesarFichero(tabla, file, posClaveFich, encabezados);
	}
	function leerLinea(file, numCampos):String {
		return this.ctx.actFamilias_leerLinea(file, numCampos);
	}
	function crearCorrespondencias() {
		return this.ctx.actFamilias_crearCorrespondencias();
	}
	function crearPosiciones(cabeceras:String) {
		return this.ctx.actFamilias_crearPosiciones(cabeceras);
	}
	function comprobarFichero(cabeceras:String) {
		return this.ctx.actFamilias_comprobarFichero(cabeceras);
	}
	function whereTablaDestino( linea:String ):String {
		return this.ctx.actFamilias_whereTablaDestino( linea );
	}
	function comprobarCampoDefecto(nomCampo:String):Boolean {
		return this.ctx.actFamilias_comprobarCampoDefecto(nomCampo);
	}
}
//// ACT_FAMILIAS ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
//////////////////////////////////////////////////////////////////
//// DESARROLLO //////////////////////////////////////////////////
class head extends actFamilias {
    function head( context ) { actFamilias ( context ); }
}
//// DESARROLLO //////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
//////////////////////////////////////////////////////////////////
//// INTERFACE  //////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
}

const iface = new ifaceCtx( this );
//// INTERFACE  //////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////

function interna_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	
	this.iface.tdbFamilias = this.child("tdbFamilias");
	this.iface.tdbFamiliasSel = this.child("tdbFamiliasSel");
	
	this.iface.tdbFamilias.setReadOnly(true);
	this.iface.tdbFamiliasSel.setReadOnly(true);
	
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.iface.tdbFamilias.cursor(), "recordChoosed()", this, "iface.seleccionar()");
	connect(this.iface.tdbFamiliasSel.cursor(), "recordChoosed()", this, "iface.quitar()");

	connect(this.child("pbnSeleccionar"), "clicked()", this, "iface.seleccionar()");
	connect(this.child("pbnSeleccionarTodos"), "clicked()", this, "iface.seleccionarTodos()");
	connect(this.child("pbnQuitar"), "clicked()", this, "iface.quitar()");
	connect(this.child("pbnQuitarTodos"), "clicked()", this, "iface.quitarTodos()");

	this.iface.bufferChanged("crearsinoexiste");
	this.iface.refrescarTablas();
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();

	switch (fN) {
		case "crearsinoexiste": {
			if (cursor.valueBuffer("crearsinoexiste"))
				this.child("tbwActualizaFamilias").setTabEnabled("familiasCrear", true);
			else
				this.child("tbwActualizaFamilias").setTabEnabled("familiasCrear", false);
			break;
		}
	}
}

function oficial_refrescarTablas()
{
	var filtro:String = this.cursor().valueBuffer("filtro");
	if (!filtro || filtro == "")
		filtro = "''";
	filtro = "codfamilia IN (" + filtro + ") AND ";

	var datos:String = this.cursor().valueBuffer("datos");
	if (!datos || datos == "") {
		this.iface.tdbFamilias.setFilter(filtro + "1 = 1");
		this.iface.tdbFamiliasSel.setFilter(filtro + "1 = 2");
	} else {
		this.iface.tdbFamilias.setFilter(filtro + "codfamilia NOT IN (" + datos + ")");
		this.iface.tdbFamiliasSel.setFilter("1=1 AND codfamilia IN (" + datos + ")");
	}

	this.iface.tdbFamilias.refresh();
	this.iface.tdbFamiliasSel.refresh();
}

function oficial_seleccionar()
{
	var cursor:FLSqlCursor = this.cursor();
	var datos:String = cursor.valueBuffer("datos");
	var codFamilia:String = this.iface.tdbFamilias.cursor().valueBuffer("codfamilia");
	if (!codFamilia)
		return;

	if (!datos || datos == "")
		datos = "'" + codFamilia + "'";
	else
		datos += "," + "'" + codFamilia + "'";

	cursor.setValueBuffer("datos", datos);
	this.iface.refrescarTablas();
}

function oficial_seleccionarTodos()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	var datos:String = cursor.valueBuffer("datos");
	var codFamilia:String;

	var curLineas:FLSqlCursor = new FLSqlCursor("familiasactualizadas");
	curLineas.setMainFilter(this.iface.tdbFamilias.filter());

	if (curLineas.size() > 0) {
		curLineas.first();
		codFamilia = curLineas.valueBuffer("codfamilia");
		if (!datos || datos == "")
			datos = "'" + codFamilia + "'";
		else
			datos += "," + "'" + codFamilia + "'";

		var paso:Number = 0;
		util.createProgressDialog( util.translate( "scripts", "Seleccionando familias..." ), curLineas.size());

		while (curLineas.next()) {
			codFamilia = curLineas.valueBuffer("codfamilia");
			if (!datos || datos == "")
				datos = "'" + codFamilia + "'";
			else
				datos += "," + "'" + codFamilia + "'";
			util.setProgress( ++paso );
		}
		util.destroyProgressDialog();
	}

	cursor.setValueBuffer("datos", datos);
	this.iface.refrescarTablas();
}

function oficial_quitar()
{
	var cursor:FLSqlCursor = this.cursor();
	var datos:String = cursor.valueBuffer("datos");
	var codFamilia:String = this.iface.tdbFamiliasSel.cursor().valueBuffer("codfamilia");
	if (!codFamilia)
		return;

	if (!datos || datos == "")
		return;

	var lineas:Array = datos.split(",");
	var datosNuevos:String = "";
	for (var i:Number = 0; i < lineas.length; i++) {
		if (lineas[i] != "'" + codFamilia + "'") {
			if (datosNuevos == "") 
				datosNuevos = lineas[i];
			else
				datosNuevos += "," + lineas[i];
		}
	}

	cursor.setValueBuffer("datos", datosNuevos);
	this.iface.refrescarTablas();
}

function oficial_quitarTodos()
{
	var cursor:FLSqlCursor = this.cursor();
	cursor.setValueBuffer("datos", "");
	this.iface.refrescarTablas();
}

//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition actFamilias */
//////////////////////////////////////////////////////////////////
//// ACT_FAMILIAS ////////////////////////////////////////////////

function actFamilias_init()
{
	connect(this.child("pbnImportar"), "clicked()", this, "iface.importar");

	var util:FLUtil = new FLUtil();
	this.iface.CR = 1;
	if (util.getOS() == "WIN32")
		this.iface.CR++;

	this.iface.__init();
}

function actFamilias_importar()
{
	var util:FLUtil = new FLUtil();
	
	this.iface.corr = [];
	this.iface.pos = [];
	this.iface.arrayNomCampos = [];
	this.iface.arrayNomCamposDefecto = [];
	this.iface.arrayMasCampos = [];
	
	var fichero:String = FileDialog.getOpenFileName( util.translate( "scripts", "Texto CSV (*.csv)" ), util.translate( "scripts", "Elegir fichero de familias" ) );
	
	if (!fichero) return;
	if ( !File.exists( fichero ) ) {
		MessageBox.information( util.translate( "scripts", "Ruta errónea" ), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
	
	var file = new File( fichero );
	file.open( File.ReadOnly );
	
	var encabezados:String = file.readLine();
	
	if (!this.iface.comprobarFichero(encabezados))
		return false;
	
	this.iface.crearCorrespondencias();
	this.iface.crearPosiciones(encabezados);
	
	if (!encabezados) {
		MessageBox.information( util.translate( "scripts", "El fichero está vacío" ), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
	
	var arrayLineas = this.iface.preprocesarFichero(this.iface.tablaDestino, file, this.iface.pos["CODIGO"], encabezados);

	var curTab:FLSqlCursor = new FLSqlCursor(this.iface.tablaDestino);
	var codFamilia:String;
	var marcacionAnterior:Number;
	var marcacion:Number;
	var actualizados:Number = 0;
	var creados:Number = 0;
	var noCreados:Number = 0;
	
	var q:FLSqlQuery = new FLSqlQuery();
	var cursor:FLSqlCursor = this.cursor();
	var filtro:String = cursor.valueBuffer("filtro");

	util.createProgressDialog( util.translate( "scripts", "Importando fichero..." ), arrayLineas.length);
	
	for (var i:Number = 0; i < arrayLineas.length; i++) {
		linea = arrayLineas[i];
		campos = linea.split(this.iface.sep);
		codFamilia = campos[this.iface.pos["CODIGO"]];
		
		q.setTablesList("familias");
		q.setSelect("codfamilia,marcacion,descripcion");
		q.setFrom("familias");
		q.setWhere("codfamilia = '" + codFamilia + "'");
		q.exec();
		if (q.first()) {
			actualizados++;
			marcacionAnterior = parseFloat(q.value("marcacion"));
		} else {
			if (this.cursor().valueBuffer("crearsinoexiste")) {
				creados++;
				marcacionAnterior = 0;
			} else {
				noCreados++;
				util.setProgress(i);
				continue;
			}
		}
		
		curTab.select( this.iface.whereTablaDestino( linea ) );

		if (curTab.first())
			curTab.setModeAccess(curTab.Edit);
		else
			curTab.setModeAccess(curTab.Insert);
		curTab.refreshBuffer();

		// Se copian los campos del csv
		for (var j:Number = 0; j < this.iface.arrayNomCampos.length; j++) {
			nomCampo = this.iface.arrayNomCampos[j];
			var existeColumna;
			try { existeColumna = this.iface.pos[nomCampo]; }
			catch (e) { }
			// Si el campo no existe en el csv se toma el valor por defecto para ese campo (para familias nuevas)
			if (isNaN(existeColumna)) {
				if ( this.iface.comprobarCampoDefecto(nomCampo) )
					curTab.setValueBuffer(this.iface.corr[nomCampo], cursor.valueBuffer(this.iface.corr[nomCampo]));
			} else {
				// Control de campos numéricos cuando el dato está vacío
				tipoCampo = curTab.fieldType(this.iface.corr[nomCampo]);
				if (tipoCampo >= 17 && tipoCampo <= 19)
					if (!campos[this.iface.pos[nomCampo]])
						campos[this.iface.pos[nomCampo]] = 0;
					else {
						valor = campos[this.iface.pos[nomCampo]];
						valor = valor.toString().replace(",",".");
						campos[this.iface.pos[nomCampo]] = valor;
					}
				curTab.setValueBuffer(this.iface.corr[nomCampo], campos[this.iface.pos[nomCampo]]);
			}
		}
		// Se copian los campos por defecto que no se incluyen en el csv (para familias nuevas)
		for (var j:Number = 0; j < this.iface.arrayMasCampos.length; j++) {
			nomCampo = this.iface.arrayMasCampos[j];
			curTab.setValueBuffer(nomCampo, cursor.valueBuffer(nomCampo));
		}

		curTab.setValueBuffer("marcacionanterior", marcacionAnterior);
		if (!curTab.valueBuffer("descripcion") || curTab.valueBuffer("descripcion") == "")
			curTab.setValueBuffer("descripcion", q.value("descripcion"))

		if (!curTab.commitBuffer())
			debug("Error al actualizar/crear la familia " + codFamilia + " en la línea válida " + i);
		else {
			if (!filtro || filtro == "")
				filtro = "'" + codFamilia + "'";
			else
				filtro += "," + "'" + codFamilia + "'";
				
		}
		util.setProgress(i);
	}
	cursor.setValueBuffer("filtro", filtro);
	util.destroyProgressDialog();

	var util:FLUtil = new FLUtil();
	MessageBox.information( util.translate( "scripts", "Total de familias: %0\n\nFamilias actualizadas: %1\nFamilias importadas: %2").arg(actualizados+creados).arg(actualizados).arg(creados), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );

	if (noCreados > 0)
		MessageBox.information( util.translate( "scripts", "Familias no importadas: %0\n\nPuede crearlas eligiendo la opción\n\"Crear familias si no existen\"").arg(noCreados), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );

	this.iface.refrescarTablas();
}

/** \D
Indica la clausula where necesaria para determinar si existe el registro destino para la linea de texto pasada
@param	linea	Linea de texto del fichero correspondiente a un registro
\end */
function actFamilias_whereTablaDestino( linea:String ):String {
	var campos:Array = linea.split(this.iface.sep);
	var codFamilia:String = campos[this.iface.pos["CODIGO"]];
	var where:String = "codfamilia = '" + codFamilia + "'";

	return where;
}

/** \D Recorre el fichero buscando registros existentes y devuelve un
array con los registros a importar
@param posClaveFich Posición del campo clave en el fichero
*/
function actFamilias_preprocesarFichero(tabla:String, file, posClaveFich:String, encabezados:String):Array 
{
	var arrayLineas:Array = [];

	var i:Number = 0;
	var j:Number = 0;
	var bufferLinea:String;
	var arrayBuffer = [];
	
	var campos:Array = encabezados.split(this.iface.sep);
	var numCampos:Number = campos.length;
	var campoClave:String;
	var numLineas:Number = 0;

	var util:FLUtil = new FLUtil();
	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Preprocesando datos..." ), 1000);
	
	while ( !file.eof ) {
		linea = this.iface.leerLinea(file, numCampos);
		campos = linea.split(this.iface.sep);
		campoClave = campos[posClaveFich];
		if (!campoClave || campoClave.toString().length < 2 ) continue;
		
		if (campos.length != numCampos) {
			debug("Se ignora la línea " + parseInt(numLineas - 1) + ". No contiene un registro válido")
			continue;
		}
		
		arrayLineas[numLineas++] = linea;
		util.setProgress(paso++);
		if (paso == 999)
			paso = 1;
	}
	util.destroyProgressDialog();
	
	file.close();
	
	return arrayLineas;
}

function actFamilias_leerLinea(file, numCampos):String
{
	var regExp:RegExp = new RegExp( "\"" );
	regExp.global = true;
		
	contCampos = 0;
	var linea:String = "";
	
	while (contCampos < numCampos) {
		bufferLinea = file.readLine().replace( regExp, "" );
		if (bufferLinea.length < 2 || bufferLinea.left(1) == "#") continue;
		linea += bufferLinea;
		arrayBuffer = bufferLinea.split(this.iface.sep);
		contCampos += arrayBuffer.length;
	}
	
	// Eliminar el retorno de carro
	linea = linea.left(linea.length - this.iface.CR);
	
	return linea;
}

function actFamilias_crearCorrespondencias()
{
	this.iface.arrayNomCampos = new Array("CODIGO", "MARCACION", "DESCRIPCION", "MADRE", "UNIDAD");
	this.iface.arrayNomCamposDefecto = new Array("MARCACION", "MADRE", "UNIDAD");
	this.iface.arrayMasCampos = new Array("");

	this.iface.corr["CODIGO"] = "codfamilia";
	this.iface.corr["MARCACION"] = "marcacion";

	this.iface.corr["DESCRIPCION"] = "descripcion";
	this.iface.corr["MADRE"] = "codmadre";
	this.iface.corr["UNIDAD"] = "codunidad";
}

/** Crea un array con las posiciones de los nombres de campos en el fichero
@param cabeceras String con la primera línea del fichero que contiene las cabeceras
*/
function actFamilias_crearPosiciones(cabeceras:String)
{
	// Eliminar el retorno de carro
	cabeceras = cabeceras.left(cabeceras.length - this.iface.CR);
	
	var campos = cabeceras.split(this.iface.sep);
	var campo:String;
	
	for (var i:Number = 0; i < campos.length; i++) {
		campo = campos[i];
		campo = campo.toString();
		this.iface.pos[campo.toUpperCase()] = i;
	}
}

/** Comprueba que la primera línea del fichero contiene un campo CODIGO y un MARCACION
@param cabeceras String con la primera línea del fichero que contiene las cabeceras
*/
function actFamilias_comprobarFichero(cabeceras:String)
{
	var util:FLUtil = new FLUtil();
	
	// Eliminar el retorno de carro
	cabeceras = cabeceras.left(cabeceras.length - this.iface.CR);
	
	var campos = cabeceras.split(this.iface.sep);
	var campo:String;
	var cod:Boolean = false;
	var marca:Boolean = false;
	var desc:Boolean = false;
	
	for (var i:Number = 0; i < campos.length; i++) {
		campo = campos[i];
		if (campo.toUpperCase() == "CODIGO")
			cod = true;
		if (campo.toUpperCase() == "MARCACION")
			marca = true;
		if (campo.toUpperCase() == "DESCRIPCION")
			desc = true;
	}
	
	if ( !cod || !marca || (!desc && this.cursor().valueBuffer("crearsinoexiste")) ) {
		MessageBox.critical( util.translate( "scripts", "El fichero no es válido.\nLa cabecera debe contener los campos CODIGO (código), DESCRIPCION (descripción) y MARCACION (marcación)"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return false;
	}
	
	return true;
}

function actFamilias_comprobarCampoDefecto(nomCampo:String):Boolean
{
	var valido:Boolean = false;
	for (var i:Number = 0; i < this.iface.arrayNomCamposDefecto.length; i++) {
		if (this.iface.arrayNomCamposDefecto[i] == nomCampo)
			valido = true;
	}
	return valido;
}
//// ACT_FAMILIAS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
