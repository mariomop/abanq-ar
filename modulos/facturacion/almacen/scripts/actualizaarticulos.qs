/***************************************************************************
                 actualizaarticulos.qs  -  description
                             -------------------
    begin                : vie nov 13 2009
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
	var ejercicioActual:String;
	var longSubcuenta:Number;
	var bloqueoSubcuenta:Boolean;
	var posActualPuntoSubcuenta:Number;

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

/** @class_declaration actPrecios */
//////////////////////////////////////////////////////////////////
//// ACT_PRECIOS /////////////////////////////////////////////////
class actPrecios extends oficial 
{
	var sep:String = ";";
	var tablaDestino:String = "articulosactualizados";
	var corr = [];
	var pos = [];
	var arrayNomCampos = [];
	var arrayNomCamposDefecto = [];
	var arrayMasCampos = [];
	
    function actPrecios( context ) { oficial ( context ); }
	function init() {
		return this.ctx.actPrecios_init();
	}
	function importar() {
		return this.ctx.actPrecios_importar();
	}
	function preprocesarFichero(tabla:String, file, posClaveFich:String, encabezados:String):Array {
		return this.ctx.actPrecios_preprocesarFichero(tabla, file, posClaveFich, encabezados);
	}
	function leerLinea(file, numCampos):String {
		return this.ctx.actPrecios_leerLinea(file, numCampos);
	}
	function crearCorrespondencias() {
		return this.ctx.actPrecios_crearCorrespondencias();
	}
	function crearPosiciones(cabeceras:String) {
		return this.ctx.actPrecios_crearPosiciones(cabeceras);
	}
	function comprobarFichero(cabeceras:String) {
		return this.ctx.actPrecios_comprobarFichero(cabeceras);
	}
	function whereTablaDestino( linea:String ):String {
		return this.ctx.actPrecios_whereTablaDestino( linea );
	}
	function comprobarCampoDefecto(nomCampo:String):Boolean {
		return this.ctx.actPrecios_comprobarCampoDefecto(nomCampo);
	}
}
//// ACT_PRECIOS /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
//////////////////////////////////////////////////////////////////
//// DESARROLLO //////////////////////////////////////////////////
class head extends actPrecios {
    function head( context ) { actPrecios ( context ); }
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
	
	this.iface.tdbArticulos = this.child("tdbArticulos");
	this.iface.tdbArticulosSel = this.child("tdbArticulosSel");
	
	this.iface.tdbArticulos.setReadOnly(true);
	this.iface.tdbArticulosSel.setReadOnly(true);
	
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.iface.tdbArticulos.cursor(), "recordChoosed()", this, "iface.seleccionar()");
	connect(this.iface.tdbArticulosSel.cursor(), "recordChoosed()", this, "iface.quitar()");

	connect(this.child("pbnSeleccionar"), "clicked()", this, "iface.seleccionar()");
	connect(this.child("pbnSeleccionarTodos"), "clicked()", this, "iface.seleccionarTodos()");
	connect(this.child("pbnQuitar"), "clicked()", this, "iface.quitar()");
	connect(this.child("pbnQuitarTodos"), "clicked()", this, "iface.quitarTodos()");

	if (sys.isLoadedModule("flcontppal")) {
		this.iface.ejercicioActual = flfactppal.iface.pub_ejercicioActual();
		this.iface.longSubcuenta = util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + this.iface.ejercicioActual + "'");
		this.iface.bloqueoSubcuenta = false;
		this.iface.posActualPuntoSubcuenta = -1;
		this.child("fdbIdSubcuentaCom").setFilter("codejercicio = '" + this.iface.ejercicioActual + "'");
	} else {
		this.child("fdbCodSubcuentaCom").close();
		this.child("fdbIdSubcuentaCom").close();
		this.child("fdbDesSubcuentaCom").close();
	}

	this.child("fdbIvaIncluido").setValue(flfactalma.iface.pub_valorDefectoAlmacen("ivaincluido"));
	this.child("fdbCodImpuesto").setValue(flfactalma.iface.pub_valorDefectoAlmacen("codimpuesto"));
	this.child("fdbCodDivisa").setValue(flfactalma.iface.pub_valorDefectoAlmacen("coddivisa"));

	if (sys.isLoadedModule("flcontppal")) {
		this.child("fdbIdSubcuentaCom").setValue(flfactalma.iface.pub_valorDefectoAlmacen("idsubcuentacom"));
		this.child("fdbCodSubcuentaCom").setValue(flfactalma.iface.pub_valorDefectoAlmacen("codsubcuentacom"));
	}

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
				this.child("tbwActualizaArticulos").setTabEnabled("articulosCrear", true);
			else
				this.child("tbwActualizaArticulos").setTabEnabled("articulosCrear", false);
			break;
		}
		case "codsubcuentacom": {
			if (!this.iface.bloqueoSubcuenta) {
				this.iface.bloqueoSubcuenta = true;
				this.iface.posActualPuntoSubcuenta = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuentaCom", this.iface.longSubcuenta, this.iface.posActualPuntoSubcuenta);
				this.iface.bloqueoSubcuenta = false;
			}
			break;
		}
	}
}

function oficial_refrescarTablas()
{
	var filtro:String = this.cursor().valueBuffer("filtro");
	if (!filtro || filtro == "")
		filtro = "''";
	filtro = "referencia IN (" + filtro + ") AND ";

	var datos:String = this.cursor().valueBuffer("datos");
	if (!datos || datos == "") {
		this.iface.tdbArticulos.setFilter(filtro + "1 = 1");
		this.iface.tdbArticulosSel.setFilter(filtro + "1 = 2");
	} else {
		this.iface.tdbArticulos.setFilter(filtro + "referencia NOT IN (" + datos + ")");
		this.iface.tdbArticulosSel.setFilter("1=1 AND referencia IN (" + datos + ")");
	}

	this.iface.tdbArticulos.refresh();
	this.iface.tdbArticulosSel.refresh();
}

function oficial_seleccionar()
{
	var cursor:FLSqlCursor = this.cursor();
	var datos:String = cursor.valueBuffer("datos");
	var referencia:String = this.iface.tdbArticulos.cursor().valueBuffer("referencia");
	if (!referencia)
		return;

	if (!datos || datos == "")
		datos = "'" + referencia + "'";
	else
		datos += "," + "'" + referencia + "'";

	cursor.setValueBuffer("datos", datos);
	this.iface.refrescarTablas();
}

function oficial_seleccionarTodos()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	var datos:String = cursor.valueBuffer("datos");

	var curLineas:FLSqlCursor = new FLSqlCursor("articulosactualizados");
	curLineas.setMainFilter(this.iface.tdbArticulos.filter());

	if (curLineas.size() > 0) {
		curLineas.first();
		referencia = curLineas.valueBuffer("referencia");
		if (!datos || datos == "")
			datos = "'" + referencia + "'";
		else
			datos += "," + "'" + referencia + "'";

		var paso:Number = 0;
		util.createProgressDialog( util.translate( "scripts", "Seleccionando artículos..." ), curLineas.size());

		while (curLineas.next()) {
			referencia = curLineas.valueBuffer("referencia");
			if (!datos || datos == "")
				datos = "'" + referencia + "'";
			else
				datos += "," + "'" + referencia + "'";
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
	var referencia:String = this.iface.tdbArticulosSel.cursor().valueBuffer("referencia");
	if (!referencia)
		return;

	if (!datos || datos == "")
		return;

	var lineas:Array = datos.split(",");
	var datosNuevos:String = "";
	for (var i:Number = 0; i < lineas.length; i++) {
		if (lineas[i] != "'" + referencia + "'") {
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

/** @class_definition actPrecios */
//////////////////////////////////////////////////////////////////
//// ACT_PRECIOS /////////////////////////////////////////////////

function actPrecios_init()
{
	connect(this.child("pbnImportar"), "clicked()", this, "iface.importar");
	
	this.iface.__init();
}

function actPrecios_importar()
{
	var util:FLUtil = new FLUtil();
	
	this.iface.corr = [];
	this.iface.pos = [];
	this.iface.arrayNomCampos = [];
	this.iface.arrayNomCamposDefecto = [];
	this.iface.arrayMasCampos = [];
	
	var fichero:String = FileDialog.getOpenFileName( util.translate( "scripts", "Texto CSV (*.csv)" ), util.translate( "scripts", "Elegir fichero de artículos" ) );
	
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
	
	var arrayLineas = this.iface.preprocesarFichero(this.iface.tablaDestino, file, this.iface.pos["REFERENCIA"], encabezados);

	var curTab:FLSqlCursor = new FLSqlCursor(this.iface.tablaDestino);
	var referencia:String;
	var pvpAnterior:Number;
	var pvp:Number;
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
		referencia = campos[this.iface.pos["REFERENCIA"]];
		
		q.setTablesList("articulos");
		q.setSelect("referencia,pvp,descripcion");
		q.setFrom("articulos");
		q.setWhere("referencia = '" + referencia + "'");
		q.exec();
		if (q.first()) {
			actualizados++;
			pvpAnterior = parseFloat(q.value("pvp"));
		} else {
			if (this.cursor().valueBuffer("crearsinoexiste")) {
				creados++;
				pvpAnterior = 0;
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
			// Si el campo no existe en el csv se toma el valor por defecto para ese campo (para artículos nuevos)
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
		// Se copian los campos por defecto que no se incluyen en el csv (para artículos nuevos)
		for (var j:Number = 0; j < this.iface.arrayMasCampos.length; j++) {
			nomCampo = this.iface.arrayMasCampos[j];
			curTab.setValueBuffer(nomCampo, cursor.valueBuffer(nomCampo));
		}

		curTab.setValueBuffer("pvpanterior", pvpAnterior);
		if (!curTab.valueBuffer("descripcion") || curTab.valueBuffer("descripcion") == "")
			curTab.setValueBuffer("descripcion", q.value("descripcion"))

		if (!curTab.commitBuffer())
			debug("Error al actualizar/crear el artículo " + referencia + " en la línea válida " + i);
		else {
			if (!filtro || filtro == "")
				filtro = "'" + referencia + "'";
			else
				filtro += "," + "'" + referencia + "'";
				
		}
		util.setProgress(i);
	}
	cursor.setValueBuffer("filtro", filtro);
	util.destroyProgressDialog();

	var util:FLUtil = new FLUtil();
	MessageBox.information( util.translate( "scripts", "Total de artículos: %0\n\nArtículos actualizados: %1\nArtículos importados: %2").arg(actualizados+creados).arg(actualizados).arg(creados), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );

	if (noCreados > 0)
		MessageBox.information( util.translate( "scripts", "Artículos no importados: %0\n\nPuede crearlos eligiendo la opción\n\"Crear artículos si no existen\"").arg(noCreados), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );

	this.iface.refrescarTablas();
}

/** \D
Indica la clausula where necesaria para determinar si existe el registro destino para la linea de texto pasada
@param	linea	Linea de texto del fichero correspondiente a un registro
\end */
function actPrecios_whereTablaDestino( linea:String ):String {
	var campos:Array = linea.split(this.iface.sep);
	var referencia:String = campos[this.iface.pos["REFERENCIA"]];
	var where:String = "referencia = '" + referencia + "'";

	return where;
}

/** \D Recorre el fichero buscando registros existentes y devuelve un
array con los registros a importar
@param posClaveFich Posición del campo clave en el fichero
*/
function actPrecios_preprocesarFichero(tabla:String, file, posClaveFich:String, encabezados:String):Array 
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

function actPrecios_leerLinea(file, numCampos):String
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
	
	// Eliminamos el salto de línea
	if (linea.charCodeAt( linea.length - 1 ) == 10)
		linea = linea.left(linea.length - 1);
	
	return linea;
}

function actPrecios_crearCorrespondencias()
{
	this.iface.arrayNomCampos = new Array("REFERENCIA", "PVP", "DESCRIPCION", "DIVISA", "IVA", "UNIDAD", "FAMILIA", "FABRICANTE", "MODELO", "COSTO", "OBSERVACIONES");
	this.iface.arrayNomCamposDefecto = new Array("DIVISA", "IVA", "UNIDAD", "FAMILIA", "FABRICANTE");
	this.iface.arrayMasCampos = new Array("ivaincluido", "codsubcuentacom", "idsubcuentacom");

	this.iface.corr["REFERENCIA"] = "referencia";
	this.iface.corr["PVP"] = "pvp";

	this.iface.corr["DESCRIPCION"] = "descripcion";
	this.iface.corr["DIVISA"] = "coddivisa";
	this.iface.corr["IVA"] = "codimpuesto";
	this.iface.corr["UNIDAD"] = "codunidad";
	this.iface.corr["FAMILIA"] = "codfamilia";
	this.iface.corr["FABRICANTE"] = "codfabricante";
	this.iface.corr["MODELO"] = "modelo";
	this.iface.corr["COSTO"] = "costemaximo";
	this.iface.corr["OBSERVACIONES"] = "observaciones";
}

/** Crea un array con las posiciones de los nombres de campos en el fichero
@param cabeceras String con la primera línea del fichero que contiene las cabeceras
*/
function actPrecios_crearPosiciones(cabeceras:String)
{
	// Eliminar el retorno de carro
	cabeceras = cabeceras.left(cabeceras.length - 1);
	
	var campos = cabeceras.split(this.iface.sep);
	var campo:String;
	
	for (var i:Number = 0; i < campos.length; i++) {
		campo = campos[i];
		campo = campo.toString();
		this.iface.pos[campo.toUpperCase()] = i;
	}
}

/** Comprueba que la primera línea del fichero contiene un campo REFERENCIA y un PVP
@param cabeceras String con la primera línea del fichero que contiene las cabeceras
*/
function actPrecios_comprobarFichero(cabeceras:String)
{
	var util:FLUtil = new FLUtil();
	
	// Eliminar el retorno de carro
	cabeceras = cabeceras.left(cabeceras.length - 1);
	
	var campos = cabeceras.split(this.iface.sep);
	var campo:String;
	var ref:Boolean = false;
	var pvp:Boolean = false;
	var desc:Boolean = false;
	
	for (var i:Number = 0; i < campos.length; i++) {
		campo = campos[i];
		if (campo.toUpperCase() == "REFERENCIA")
			ref = true;
		if (campo.toUpperCase() == "PVP")
			pvp = true;
		if (campo.toUpperCase() == "DESCRIPCION")
			desc = true;
	}
	
	if ( !ref || !pvp || (!desc && this.cursor().valueBuffer("crearsinoexiste")) ) {
		MessageBox.critical( util.translate( "scripts", "El fichero no es válido.\nLa cabecera debe contener los campos REFERENCIA (referencia), DESCRIPCION (descripción) y PVP (precio)"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return false;
	}
	
	return true;
}

function actPrecios_comprobarCampoDefecto(nomCampo:String):Boolean
{
	var valido:Boolean = false;
	for (var i:Number = 0; i < this.iface.arrayNomCamposDefecto.length; i++) {
		if (this.iface.arrayNomCamposDefecto[i] == nomCampo)
			valido = true;
	}
	return valido;
}
//// ACT_PRECIOS ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
