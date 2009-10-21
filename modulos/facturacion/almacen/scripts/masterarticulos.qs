/***************************************************************************
                 masterarticulos.qs  -  description
                             -------------------
    begin                : jue jun 28 2007
    copyright            : (C) 2007 by InfoSiAL S.L.
    email                : mail@infosial.com
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
	var curArticulo:FLSqlCursor;
	var curTarifa:FLSqlCursor;
	var curArticuloProv:FLSqlCursor;
	var curArticuloAgen:FLSqlCursor;
	var tdbRecords:FLTableDB;
	var toolButtonCopy:Object;
	function oficial( context ) { interna( context ); }
	function copiarArticulo_clicked() {
		return this.ctx.oficial_copiarArticulo_clicked();
	}
	function copiarArticulo():String {
		return this.ctx.oficial_copiarArticulo();
	}
	function copiarAnexosArticulo(nuevaReferencia:String):Boolean {
		return this.ctx.oficial_copiarAnexosArticulo(nuevaReferencia);
	}
	function copiarTablaTarifas(nuevaReferencia:String):Boolean {
		return this.ctx.oficial_copiarTablaTarifas(nuevaReferencia);
	}
	function copiarTablaArticulosProv(nuevaReferencia:String):Boolean {
		return this.ctx.oficial_copiarTablaArticulosProv(nuevaReferencia);
	}
	function copiarTablaArticulosAgen(nuevaReferencia:String):Boolean {
		return this.ctx.oficial_copiarTablaArticulosAgen(nuevaReferencia);
	}
	function datosArticuloAgen(cursor:FLSqlCursor,campo:String):Boolean {
		return this.ctx.oficial_datosArticuloAgen(cursor,campo);
	}
	function datosArticulo(cursor:FLSqlCursor,campo:String):Boolean {
		return this.ctx.oficial_datosArticulo(cursor,campo);
	}
	function datosTarifa(cursor:FLSqlCursor,campo:String):Boolean {
		return this.ctx.oficial_datosTarifa(cursor,campo);
	}
	function datosArticuloProv(cursor:FLSqlCursor,campo:String):Boolean {
		return this.ctx.oficial_datosArticuloProv(cursor,campo);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration trazabilidad */
/////////////////////////////////////////////////////////////////
//// TRAZABILIDAD ///////////////////////////////////////////////
class trazabilidad extends oficial {
    function trazabilidad( context ) { oficial ( context ); }
	function datosArticulo(cursor:FLSqlCursor,referencia:String):Boolean {
		return this.ctx.trazabilidad_datosArticulo(cursor,referencia);
	}
}
//// TRAZABILIDAD ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration actPrecios */
/////////////////////////////////////////////////////////////////
//// ACT_PRECIOS //////////////////////////////////////////////////
class actPrecios extends trazabilidad 
{
	var sep:String = "ð";
	var tablaDestino:String = "articulos";
	var crearSiNoExiste:Boolean = false;
	var corr = [];
	var pos = [];	
	var arrayNomCampos = [];
	var tableDBRecords:Object;
	
    function actPrecios( context ) { trazabilidad ( context ); }
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
}
//// ACT_PRECIOS //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ivaIncluido */
/////////////////////////////////////////////////////////////////
//// IVAINCLUIDO ////////////////////////////////////////////////
class ivaIncluido extends actPrecios {
    function ivaIncluido( context ) { actPrecios ( context ); }
	function datosArticulo(cursor:FLSqlCursor,referencia:String):Boolean {
		return this.ctx.ivaIncluido_datosArticulo(cursor,referencia);
	}
}
//// IVAINCLUIDO ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration fluxEcommerce */
/////////////////////////////////////////////////////////////////
//// FLUX ECOMMERCE //////////////////////////////////////////////////////
class fluxEcommerce extends ivaIncluido {
    function fluxEcommerce( context ) { ivaIncluido ( context ); }
	function datosArticulo(cursor:FLSqlCursor,referencia:String):Boolean {
		return this.ctx.fluxEcommerce_datosArticulo(cursor,referencia);
	}
	function copiarAnexosArticulo(nuevaReferencia:String):Boolean {
		return this.ctx.fluxEcommerce_copiarAnexosArticulo(nuevaReferencia);
	}
	function copiarTablaAtributosArticulos(nuevaReferencia:String):Boolean {
		return this.ctx.fluxEcommerce_copiarTablaAtributosArticulos(nuevaReferencia);
	}
		function copiarAtributoArticulo(id:Number,referencia:String):Number {
		return this.ctx.fluxEcommerce_copiarAtributoArticulo(id,referencia);
	}
	function datosAtributoArticulo(cursor:FLSqlCursor,cursorNuevo:FLSqlCursor,referencia:String):Boolean {
		return this.ctx.fluxEcommerce_datosAtributoArticulo(cursor,cursorNuevo,referencia);
	}
	function copiarTablaAccesoriosArticulos(nuevaReferencia:String):Boolean {
		return this.ctx.fluxEcommerce_copiarTablaAccesoriosArticulos(nuevaReferencia);
	}
		function copiarAccesorioArticulo(id:Number,referencia:String):Number {
		return this.ctx.fluxEcommerce_copiarAccesorioArticulo(id,referencia);
	}
	function datosAccesorioArticulo(cursor:FLSqlCursor,cursorNuevo:FLSqlCursor,referencia:String):Boolean {
		return this.ctx.fluxEcommerce_datosAccesorioArticulo(cursor,cursorNuevo,referencia);
	}
}
//// FLUX ECOMMERCE //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration articuloscomp */
/////////////////////////////////////////////////////////////////
//// ARTICULOSCOMP //////////////////////////////////////////////
class articuloscomp extends fluxEcommerce {
	var tbnActualizarVariable:Object;
	function articuloscomp( context ) { fluxEcommerce ( context ); }
	function init() {
		return this.ctx.articuloscomp_init();
	}
	function copiarAnexosArticulo(nuevaReferencia:String) {
		return this.ctx.articuloscomp_copiarAnexosArticulo(nuevaReferencia);
	}
	function datosArticulo(cursor:FLSqlCursor,referencia:String):Boolean {
		return this.ctx.articuloscomp_datosArticulo(cursor,referencia);
	}
	function copiarArticuloComp(id:Number,referencia:String):Number {
		return this.ctx.articuloscomp_copiarArticuloComp(id,referencia);
	}
	function copiarTablaArticulosComp(nuevaReferencia:String):Boolean {
		return this.ctx.articuloscomp_copiarTablaArticulosComp(nuevaReferencia);
	}
	function datosArticuloComp(cursor:FLSqlCursor,cursorNuevo:FLSqlCursor,referencia:String):Boolean {
		return this.ctx.articuloscomp_datosArticuloComp(cursor,cursorNuevo,referencia);
	}
	function copiarTiposOpcionArticulo(nuevaReferencia:String):Boolean {
		return this.ctx.articuloscomp_copiarTiposOpcionArticulo(nuevaReferencia);
	}
	function copiarTipoOpcionArticulo(id:Number, referencia:String):Number {
		return this.ctx.articuloscomp_copiarTipoOpcionArticulo(id, referencia);
	}
	function datosTipoOpcionArticulo(cursor:FLSqlCursor, cursorNuevo:FLSqlCursor, referencia:String):Boolean {
		return this.ctx.articuloscomp_datosTipoOpcionArticulo(cursor, cursorNuevo, referencia);
	}
	function copiarOpcionesArticulo(idTipoOpcion:String, idTipoOpcionNueva:String):Boolean {
		return this.ctx.articuloscomp_copiarOpcionesArticulo(idTipoOpcion, idTipoOpcionNueva);
	}
	function copiarOpcionArticulo(id:String, idTipoOpcionNueva:String):Number {
		return this.ctx.articuloscomp_copiarOpcionArticulo(id, idTipoOpcionNueva);
	}
	function datosOpcionArticulo(cursor:FLSqlCursor, cursorNuevo:FLSqlCursor, idTipoOpcion:String):Boolean {
		return this.ctx.articuloscomp_datosOpcionArticulo(cursor, cursorNuevo, idTipoOpcion);
	}
	function actualizarVariables_clicked() {
		return this.ctx.articuloscomp_actualizarVariables_clicked();
	}
	function actualizarVariables():Boolean {
		return this.ctx.articuloscomp_actualizarVariables();
	}
}
//// ARTICULOSCOMP //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pesosMedidas */
/////////////////////////////////////////////////////////////////
//// PESOSMEDIDAS ///////////////////////////////////////////////
class pesosMedidas extends articuloscomp {
    function pesosMedidas( context ) { articuloscomp ( context ); }
	function datosArticulo(cursor:FLSqlCursor,referencia:String):Boolean {
		return this.ctx.pesosMedidas_datosArticulo(cursor,referencia);
	}
}
//// PESOSMEDIDAS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration subfamilias */
/////////////////////////////////////////////////////////////////
//// SUBFAMILIAS ////////////////////////////////////////////////
class subfamilias extends pesosMedidas {
    function subfamilias( context ) { pesosMedidas ( context ); }
	function datosArticulo(cursor:FLSqlCursor,referencia:String):Boolean {
		return this.ctx.subfamilias_datosArticulo(cursor,referencia);
	}
}
//// SUBFAMILIAS ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration silixSeleccionar */
/////////////////////////////////////////////////////////////////
//// SILIXSELECCIONAR ///////////////////////////////////////////
class silixSeleccionar extends subfamilias
{
    function silixSeleccionar( context ) { subfamilias ( context ); }
	function init() {
		this.ctx.silixSeleccionar_init();
	}
	function seleccionCheckOnOff() {
		this.ctx.silixSeleccionar_seleccionCheckOnOff();
	}
	function seleccionVerificarHabilitaciones() {
		this.ctx.silixSeleccionar_seleccionVerificarHabilitaciones();
	}
	function seleccionTodo() {
		return this.ctx.silixSeleccionar_seleccionTodo();
	}
	function seleccionCriterio() {
		return this.ctx.silixSeleccionar_seleccionCriterio();
	}
	function seleccionNada() {
		return this.ctx.silixSeleccionar_seleccionNada();
	}
}
//// SILIXSELECCIONAR ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// SILIXORDENCAMPOS ///////////////////////////////////////////
class silixOrdenCampos extends silixSeleccionar {
    function silixOrdenCampos( context ) { silixSeleccionar ( context ); }
	function init() {
		this.ctx.silixOrdenCampos_init();
	}
}
//// SILIXORDENCAMPOS ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends silixOrdenCampos {
    function head( context ) { silixOrdenCampos ( context ); }
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
/** \C El Al copiar un artículo se copian también sus tarifas y sus precios por proveedor.
\end */
function interna_init()
{
	this.iface.curArticulo = this.cursor();
	this.iface.tdbRecords = this.child("tableDBRecords");
	this.iface.toolButtonCopy = this.child("toolButtonCopy");
	connect(this.iface.toolButtonCopy, "clicked()", this, "iface.copiarArticulo_clicked()");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_copiarArticulo_clicked()
{
	var util:FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	
	if (!cursor.isValid())
		return;
	
	var referencia:String = this.iface.curArticulo.valueBuffer("referencia");
	cursor.transaction(false);

	if (!referencia) {
		MessageBox.information(util.translate("scripts", "No hay ningún registro seleccionado"), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	try {
		if (this.iface.copiarArticulo())
			cursor.commit();
		else
			cursor.rollback();
	}
	catch (e) {
		cursor.rollback();
		MessageBox.critical(util.translate("scripts", "Hubo un error al copiar el artículo ") + referencia + ":\n" + e, MessageBox.Ok, MessageBox.NoButton);
	}
	
	this.iface.tdbRecords.refresh();

	return true;
}

function oficial_copiarArticulo():String
{
	
	var util:FLUtil;

    var nuevaReferencia = Input.getText( "Introduzca la nueva referencia:","","Copiar Artículo");
    if (!nuevaReferencia || nuevaReferencia == "") {
		MessageBox.warning(util.translate("scripts", "Debe introducir una referencia para crear el nuevo artículo."), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	if (util.sqlSelect("articulos","referencia","referencia = '" + nuevaReferencia + "'")) {
		MessageBox.warning(util.translate("scripts", "Ya existe un artículo con esa referencia"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	var curNuevoArticulo:FLSqlCursor = new FLSqlCursor("articulos");
	curNuevoArticulo.setModeAccess(curNuevoArticulo.Insert);
	curNuevoArticulo.refreshBuffer();
	curNuevoArticulo.setValueBuffer("referencia",nuevaReferencia);

	var campos:Array = util.nombreCampos("articulos");
	var totalCampos:Number = campos[0];
	for (var i:Number = 1; i <= totalCampos; i++) {
		if (!this.iface.datosArticulo(curNuevoArticulo,campos[i]))
			return false;
	}

	if (!curNuevoArticulo.commitBuffer())
			return false;

	if (!this.iface.copiarAnexosArticulo(nuevaReferencia))
		return false;
	
	return nuevaReferencia;
}

function oficial_datosArticulo(cursor:FLSqlCursor,campo:String):Boolean 
{
	if(!campo || campo == "")
		return false;
	
	switch (campo) {
		case "referencia": {
			return true;
			break;
		}
		case "stockfis": {
			cursor.setValueBuffer(campo, 0);
			break;
		}
		default: {
			if (this.iface.curArticulo.isNull(campo)) {
				cursor.setNull(campo);
			} else {
				cursor.setValueBuffer(campo, this.iface.curArticulo.valueBuffer(campo));
			}
		}
	}
	return true;
}

function oficial_copiarAnexosArticulo(nuevaReferencia:String):Boolean
{
	if (!this.iface.copiarTablaTarifas(nuevaReferencia))
		return false;
	
	if (!this.iface.copiarTablaArticulosProv(nuevaReferencia))
		return false;

	if (!this.iface.copiarTablaArticulosAgen(nuevaReferencia))
		return false;
	
	return true;
}

function oficial_copiarTablaTarifas(nuevaReferencia:String):Boolean
{
	var util:FLUtil;

	this.iface.curTarifa = new FLSqlCursor("articulostarifas");
	this.iface.curTarifa.select("referencia = '" + this.iface.curArticulo.valueBuffer("referencia") + "'");
	
	var curTarifaNueva:FLSqlCursor = new FLSqlCursor("articulostarifas");
	var campos:Array = util.nombreCampos("articulostarifas");
	var totalCampos:Number = campos[0];

	while (this.iface.curTarifa.next()) {
		curTarifaNueva.setModeAccess(curTarifaNueva.Insert);
		curTarifaNueva.refreshBuffer();
		curTarifaNueva.setValueBuffer("referencia", nuevaReferencia);
	
		for (var i:Number = 1; i <= totalCampos; i++) {
			if (!this.iface.datosTarifa(curTarifaNueva,campos[i]))
				return false;
		}

		if (!curTarifaNueva.commitBuffer())
			return false;
	}

	return true;
}
		
function oficial_copiarTablaArticulosProv(nuevaReferencia:String):Boolean
{
	var util:FLUtil;

	this.iface.curArticuloProv = new FLSqlCursor("articulosprov");
	this.iface.curArticuloProv.select("referencia = '" + this.iface.curArticulo.valueBuffer("referencia") + "'");
	
	var curArticuloProvNuevo:FLSqlCursor = new FLSqlCursor("articulosprov");
	var campos:Array = util.nombreCampos("articulosprov");
	var totalCampos:Number = campos[0];

	while (this.iface.curArticuloProv.next()) {
		curArticuloProvNuevo.setModeAccess(curArticuloProvNuevo.Insert);
		curArticuloProvNuevo.refreshBuffer();
		curArticuloProvNuevo.setValueBuffer("referencia", nuevaReferencia);
	
		for (var i:Number = 1; i <= totalCampos; i++) {
			if (!this.iface.datosArticuloProv(curArticuloProvNuevo,campos[i]))
				return false;
		}

		if (!curArticuloProvNuevo.commitBuffer())
			return false;
	}

	return true;
}


function oficial_datosTarifa(cursor:FLSqlCursor,campo:String):Boolean
{
	if(!campo || campo == "")
		return false;
	
	switch (campo) {
		case "id":
		case "referencia": {
			return true;
			break;
		}
		default: {
			if (this.iface.curTarifa.isNull(campo)) {
				cursor.setNull(campo);
			} else {
				cursor.setValueBuffer(campo, this.iface.curTarifa.valueBuffer(campo));
			}
		}
	}
	return true;
}

function oficial_datosArticuloProv(cursor:FLSqlCursor,campo:String):Boolean
{
	if(!campo || campo == "")
		return false;

	switch (campo) {
		case "id":
		case "referencia": {
			return true;
			break;
		}
		default: {
			if (this.iface.curArticuloProv.isNull(campo)) {
				cursor.setNull(campo);
			} else {
				cursor.setValueBuffer(campo, this.iface.curArticuloProv.valueBuffer(campo));
			}
		}
	}
	return true;
}

function oficial_copiarTablaArticulosAgen(nuevaReferencia:String):Boolean
{
	var util:FLUtil;

	this.iface.curArticuloAgen = new FLSqlCursor("articulosagen");
	this.iface.curArticuloAgen.select("referencia = '" + this.iface.curArticulo.valueBuffer("referencia") + "'");
	
	var curArticuloAgenNuevo:FLSqlCursor = new FLSqlCursor("articulosagen");
	var campos:Array = util.nombreCampos("articulosagen");
	var totalCampos:Number = campos[0];

	while (this.iface.curArticuloAgen.next()) {
		curArticuloAgenNuevo.setModeAccess(curArticuloAgenNuevo.Insert);
		curArticuloAgenNuevo.refreshBuffer();
		curArticuloAgenNuevo.setValueBuffer("referencia", nuevaReferencia);
	
		for (var i:Number = 1; i <= totalCampos; i++) {
			if (!this.iface.datosArticuloAgen(curArticuloAgenNuevo,campos[i]))
				return false;
		}

		if (!curArticuloAgenNuevo.commitBuffer())
			return false;
	}

	return true;
}

function oficial_datosArticuloAgen(cursor:FLSqlCursor,campo:String):Boolean
{
	if(!campo || campo == "")
		return false;

	switch (campo) {
		case "id":
		case "referencia": {
			return true;
			break;
		}
		default: {
			if (this.iface.curArticuloAgen.isNull(campo)) {
				cursor.setNull(campo);
			} else {
				cursor.setValueBuffer(campo, this.iface.curArticuloAgen.valueBuffer(campo));
			}
		}
	}
	return true;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition trazabilidad */
/////////////////////////////////////////////////////////////////
//// TRAZABILIDAD ///////////////////////////////////////////////
function trazabilidad_datosArticulo(cursor:FLSqlCursor,referencia:String):Boolean 
{
	if (!this.iface.__datosArticulo(cursor,referencia))
		return false;

	cursor.setValueBuffer("porlotes",this.iface.curArticulo.valueBuffer("porlotes"));
	cursor.setValueBuffer("diasconsumo",this.iface.curArticulo.valueBuffer("diasconsumo"));

	return true;
}

//// TRAZABILIDAD ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition actPrecios */
/////////////////////////////////////////////////////////////////
//// ACT_PRECIOS //////////////////////////////////////////////////

function actPrecios_init()
{
	this.iface.tableDBRecords = this.child("tableDBRecords")
	connect(this.child("pbnImportar"), "clicked()", this, "iface.importar");	
	
	this.iface.__init();
}

function actPrecios_importar()
{
	var util:FLUtil = new FLUtil();
	
	var res:Object = MessageBox.information(util.translate("scripts",  "Van a realizarse el proceso de importación. Esta acción no podrá deshacerse.\nEs aconsejable tener copias de seguridad en su base de datos antes de proceder.\n\n¿Desea continuar?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
	if (res != MessageBox.Yes) return;
	
	this.iface.corr = [];
	this.iface.pos = [];	
	this.iface.arrayNomCampos = [];
	
	var fichero:String = FileDialog.getOpenFileName( util.translate( "scripts", "Texto CSV (precios.csv)" ), util.translate( "scripts", "Elegir fichero de artículos" ) );
	
	if (!fichero) return;	
	if ( !File.exists( fichero ) ) {
		MessageBox.information( util.translate( "scripts", "Ruta errónea" ),
								MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return ;
	}
	
	var file = new File( fichero );
	file.open( File.ReadOnly );
	
	var encabezados:String = file.readLine();
	
	if (!this.iface.comprobarFichero(encabezados))
		return false;
	
	this.iface.crearCorrespondencias();
	this.iface.crearPosiciones(encabezados);
	
	if (!encabezados) {
		MessageBox.information( util.translate( "scripts", "El fichero está vácío" ),
								MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return ;
	}
	
	var arrayLineas = this.iface.preprocesarFichero(this.iface.tablaDestino, file, this.iface.pos["REF"], encabezados);

	var curTab:FLSqlCursor = new FLSqlCursor(this.iface.tablaDestino);
	var referencia:String;
	var pvp:Number;
	var actualizados:Number = 0;
	var creados:Number = 0;
	var faltanFila:Number = 0;
	var faltan:String = "";
	
	util.createProgressDialog( util.translate( "scripts", "Actualizando precios..." ), arrayLineas.length);
	
	for (var i:Number = 0; i < arrayLineas.length; i++) {
		linea = arrayLineas[i];
		campos = linea.split(this.iface.sep);
		referencia = campos[this.iface.pos["REF"]];
		
		curTab.select( this.iface.whereTablaDestino( linea ) );
		
		// Edición
		if (curTab.first()) {
			actualizados++;
			curTab.setModeAccess(curTab.Edit);
			curTab.refreshBuffer();
 		}
		// No existe
		else {
			if ( this.iface.crearSiNoExiste ) {
				creados++;
				curTab.setModeAccess(curTab.Insert);
				curTab.refreshBuffer();
			} else {
				faltan += referencia + " ";
				faltanFila++;
				// 5 por fila
				if (faltanFila == 5) {
					faltan += "\n";
					faltanFila = 0;
				}
				util.setProgress(i);
				continue;
			}
		}

		for (var j:Number = 0; j < this.iface.arrayNomCampos.length; j++) {
			nomCampo = this.iface.arrayNomCampos[j];
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
		if (!curTab.commitBuffer())
			debug("Error al actualizar/crear el artículo " + referencia + " en la línea válida " + i);

		util.setProgress(i);
	}
	
	util.destroyProgressDialog();
	
	var util:FLUtil = new FLUtil();
	MessageBox.information( util.translate( "scripts", "Se actualizaron los precios de %0 artículos.\n\nSe crearon los precios de %1 articulos.").arg(actualizados).arg(creados), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
	
	if (faltan)
		MessageBox.information( util.translate( "scripts", "Los siguientes artículos no se encuentran registrados:\n\n%0\n\nPuede crearlos y repetir la actualización").arg(faltan), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
	
}

/** \D
Indica la clausula where necesaria para determinar si existe el registro destino para la linea de texto pasada
@param	linea	Linea de texto del fichero correspondiente a un registro
\end */
function actPrecios_whereTablaDestino( linea:String ):String {
	var campos:Array = linea.split(this.iface.sep);
	var referencia:String = campos[this.iface.pos["REF"]];
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
	util.createProgressDialog( util.translate( "scripts", "Preprocesando datos..." ), 30);
	
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
		if (paso == 29)
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
	this.iface.arrayNomCampos = new Array("REF","PVP");
	
	this.iface.corr["REF"] = "referencia";
	this.iface.corr["PVP"] = "pvp";
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
		this.iface.pos[campo] = i;
	}
}

/** Comprueba que la primera línea del fichero contiene un campo REF y un PVP
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
	
	for (var i:Number = 0; i < campos.length; i++) {
		campo = campos[i];
		if (campo == "REF")
			ref = true;
		if (campo == "PVP")
			pvp = true;
	}
	
	if (!ref || !pvp) {
		MessageBox.critical( util.translate( "scripts", "El fichero no es válido.\nLa primera línea debe contener los campos REF (referencia) y PVP (precio)"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return false;
	}
	
	return true;
}


//// ACT_PRECIOS /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////


/** @class_definition ivaIncluido */
/////////////////////////////////////////////////////////////////
//// IVAINCLUIDO ////////////////////////////////////////////////
function ivaIncluido_datosArticulo(cursor:FLSqlCursor,referencia:String):Boolean 
{
	if (!this.iface.__datosArticulo(cursor,referencia))
		return false	

	cursor.setValueBuffer("ivaincluido",this.iface.curArticulo.valueBuffer("ivaincluido"));
	
	return true;
}
//// IVAINCLUIDO ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition fluxEcommerce */
/////////////////////////////////////////////////////////////////
//// FLUX ECOMMERCE /////////////////////////////////////////////

function fluxEcommerce_datosArticulo(cursor:FLSqlCursor,referencia:String):Boolean 
{
	if (!this.iface.__datosArticulo(cursor,referencia))
		return false	

	cursor.setValueBuffer("codfabricante",this.iface.curArticulo.valueBuffer("codfabricante"));
	cursor.setValueBuffer("publico",this.iface.curArticulo.valueBuffer("publico"));
	cursor.setValueBuffer("descpublica",this.iface.curArticulo.valueBuffer("descpublica"));
	cursor.setValueBuffer("fechapub",this.iface.curArticulo.valueBuffer("fechapub"));
	cursor.setValueBuffer("fechaimagen",this.iface.curArticulo.valueBuffer("fechaimagen"));
	cursor.setValueBuffer("codplazoenvio",this.iface.curArticulo.valueBuffer("codplazoenvio"));
	cursor.setValueBuffer("enportada",this.iface.curArticulo.valueBuffer("enportada"));
	cursor.setValueBuffer("ordenportada",this.iface.curArticulo.valueBuffer("ordenportada"));
	cursor.setValueBuffer("enoferta",this.iface.curArticulo.valueBuffer("enoferta"));
	cursor.setValueBuffer("codtarifa",this.iface.curArticulo.valueBuffer("codtarifa"));
	cursor.setValueBuffer("pvpoferta",this.iface.curArticulo.valueBuffer("pvpoferta"));
	cursor.setValueBuffer("pvpoferta",this.iface.curArticulo.valueBuffer("pvpoferta"));
	cursor.setValueBuffer("tipoimagen",this.iface.curArticulo.valueBuffer("tipoimagen"));
	cursor.setValueBuffer("modificado",this.iface.curArticulo.valueBuffer("modificado"));

	return true;
}

function fluxEcommerce_copiarAnexosArticulo(nuevaReferencia:String):Boolean
{
	if (!this.iface.__copiarAnexosArticulo(nuevaReferencia))
		return false;
	
	if (!this.iface.copiarTablaAtributosArticulos(nuevaReferencia))
		return false;

	if (!this.iface.copiarTablaAccesoriosArticulos(nuevaReferencia))
		return false;
	
	return true;
}

function fluxEcommerce_copiarTablaAtributosArticulos(nuevaReferencia:String):Boolean
{
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("atributosart");
	q.setSelect("id");
	q.setFrom("atributosart");
	q.setWhere("referencia = '" + this.iface.curArticulo.valueBuffer("referencia") + "'");
	
	if (!q.exec())
		return false;

	while (q.next()) {
		if (!this.iface.copiarAtributoArticulo(q.value("id"),nuevaReferencia))
			return false;
	}

	return true;
}

function fluxEcommerce_copiarAtributoArticulo(id:Number,referencia:String):Number
{
	var curAtributoArticulo:FLSqlCursor = new FLSqlCursor("atributosart");
	curAtributoArticulo.select("id = " + id);
	if (!curAtributoArticulo.first())
		return false;
	curAtributoArticulo.setModeAccess(curAtributoArticulo.Edit);
	curAtributoArticulo.refreshBuffer();
	
	var curAtributoArticuloNuevo:FLSqlCursor = new FLSqlCursor("atributosart");
	curAtributoArticuloNuevo.setModeAccess(curAtributoArticuloNuevo.Insert);
	curAtributoArticuloNuevo.refreshBuffer();

	if (!this.iface.datosAtributoArticulo(curAtributoArticulo,curAtributoArticuloNuevo,referencia))
		return false;

	if (!curAtributoArticuloNuevo.commitBuffer())
		return false;

	var idNuevo:Number = curAtributoArticuloNuevo.valueBuffer("id");

	return idNuevo;
}

function fluxEcommerce_datosAtributoArticulo(cursor:FLSqlCursor,cursorNuevo:FLSqlCursor,referencia:String):Boolean
{
	cursorNuevo.setValueBuffer("referencia",referencia);
	cursorNuevo.setValueBuffer("codatributo",cursor.valueBuffer("codatributo"));
	cursorNuevo.setValueBuffer("valor",cursor.valueBuffer("valor"));
	cursorNuevo.setValueBuffer("modificado",cursor.valueBuffer("modificado"));
	
	return true;
}

function fluxEcommerce_copiarTablaAccesoriosArticulos(nuevaReferencia:String):Boolean
{
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("accesoriosart");
	q.setSelect("id");
	q.setFrom("accesoriosart");
	q.setWhere("referenciappal = '" + this.iface.curArticulo.valueBuffer("referencia") + "'");
	
	if (!q.exec())
		return false;

	while (q.next()) {
		if (!this.iface.copiarAccesorioArticulo(q.value("id"),nuevaReferencia))
			return false;
	}

	return true;
}

function fluxEcommerce_copiarAccesorioArticulo(id:Number,referencia:String):Number
{
	var curAccesorioArticulo:FLSqlCursor = new FLSqlCursor("accesoriosart");
	curAccesorioArticulo.select("id = " + id);
	if (!curAccesorioArticulo.first())
		return false;
	curAccesorioArticulo.setModeAccess(curAccesorioArticulo.Edit);
	curAccesorioArticulo.refreshBuffer();
	
	var curAccesorioArticuloNuevo:FLSqlCursor = new FLSqlCursor("accesoriosart");
	curAccesorioArticuloNuevo.setModeAccess(curAccesorioArticuloNuevo.Insert);
	curAccesorioArticuloNuevo.refreshBuffer();

	if (!this.iface.datosAccesorioArticulo(curAccesorioArticulo,curAccesorioArticuloNuevo,referencia))
		return false;

	if (!curAccesorioArticuloNuevo.commitBuffer())
		return false;

	var idNuevo:Number = curAccesorioArticuloNuevo.valueBuffer("id");

	return idNuevo;
}

function fluxEcommerce_datosAccesorioArticulo(cursor:FLSqlCursor,cursorNuevo:FLSqlCursor,referencia:String):Boolean
{
	cursorNuevo.setValueBuffer("referenciappal",referencia);
	cursorNuevo.setValueBuffer("referenciaacc",cursor.valueBuffer("referenciaacc"));
	cursorNuevo.setValueBuffer("orden",cursor.valueBuffer("orden"));
	cursorNuevo.setValueBuffer("modificado",cursor.valueBuffer("modificado"));

	return true;
}
//// FLUX ECOMMERCE /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition articuloscomp */
/////////////////////////////////////////////////////////////////
//// ARTICULOSCOMP //////////////////////////////////////////////
function articuloscomp_init()
{
	if (this.cursor().mainFilter().startsWith("1 = 1")) {debug("setAction");
		this.cursor().setAction("articuloscomponente");
	}

	this.iface.tbnActualizarVariable = this.child("tbnActualizarVariable");
	connect(this.iface.tbnActualizarVariable,"clicked()", this, "iface.actualizarVariables_clicked()");

	if (!this.iface.__init())
		return false;

	return true;
}

function articuloscomp_copiarAnexosArticulo(nuevaReferencia:String):Boolean
{
	if (!this.iface.__copiarAnexosArticulo(nuevaReferencia))
		return false;

	if (!this.iface.copiarTiposOpcionArticulo(nuevaReferencia))
		return false;
	
	if (!this.iface.copiarTablaArticulosComp(nuevaReferencia))
		return false;
	
	return true;
}

function articuloscomp_copiarTablaArticulosComp(nuevaReferencia:String):Boolean
{
		var q:FLSqlQuery = new FLSqlQuery();
		q.setTablesList("articuloscomp");
		q.setSelect("id");
		q.setFrom("articuloscomp");
		q.setWhere("refcompuesto = '" + this.iface.curArticulo.valueBuffer("referencia") + "'");
		
		if (!q.exec())
			return false;

		while (q.next()) {
			if (!this.iface.copiarArticuloComp(q.value("id"),nuevaReferencia))
				return false;
		}

	return true;
}

function articuloscomp_copiarTiposOpcionArticulo(nuevaReferencia:String):Boolean
{
		var q:FLSqlQuery = new FLSqlQuery();
		q.setTablesList("tiposopcionartcomp");
		q.setSelect("idtipoopcionart");
		q.setFrom("tiposopcionartcomp");
		q.setWhere("referencia= '" + this.iface.curArticulo.valueBuffer("referencia") + "'");
		
		if (!q.exec())
			return false;

		while (q.next()) {
			if (!this.iface.copiarTipoOpcionArticulo(q.value("idtipoopcionart"), nuevaReferencia))
				return false;
		}

	return true;
}

function articuloscomp_datosArticulo(cursor:FLSqlCursor,referencia:String):Boolean 
{
	if (!this.iface.__datosArticulo(cursor,referencia))
		return false;

	var codUnidad:String = this.iface.curArticulo.valueBuffer("codunidad");
	if (codUnidad)
		cursor.setValueBuffer("codunidad",codUnidad);
	
	return true;
}

function articuloscomp_copiarArticuloComp(id:Number,referencia:String):Number
{
	var curArticuloComp:FLSqlCursor = new FLSqlCursor("articuloscomp");
	curArticuloComp.select("id = " + id);
	if (!curArticuloComp.first())
		return false;
	curArticuloComp.setModeAccess(curArticuloComp.Edit);
	curArticuloComp.refreshBuffer();
	
	var curArticuloCompNuevo:FLSqlCursor = new FLSqlCursor("articuloscomp");
	curArticuloCompNuevo.setModeAccess(curArticuloCompNuevo.Insert);
	curArticuloCompNuevo.refreshBuffer();

	if (!this.iface.datosArticuloComp(curArticuloComp,curArticuloCompNuevo,referencia))
		return false;

	if (!curArticuloCompNuevo.commitBuffer())
		return false;
	
	var idNuevo:Number = curArticuloCompNuevo.valueBuffer("id");

	return idNuevo;
}

function articuloscomp_copiarTipoOpcionArticulo(id:Number,referencia:String):Number
{
	var curTipoOpcionArt:FLSqlCursor = new FLSqlCursor("tiposopcionartcomp");
	curTipoOpcionArt.select("idtipoopcionart = " + id);
	if (!curTipoOpcionArt.first())
		return false;
	curTipoOpcionArt.setModeAccess(curTipoOpcionArt.Edit);
	curTipoOpcionArt.refreshBuffer();
	
	var curTipoOpcionArtNuevo:FLSqlCursor = new FLSqlCursor("tiposopcionartcomp");
	curTipoOpcionArtNuevo.setModeAccess(curTipoOpcionArtNuevo.Insert);
	curTipoOpcionArtNuevo.refreshBuffer();

	if (!this.iface.datosTipoOpcionArticulo(curTipoOpcionArt, curTipoOpcionArtNuevo, referencia))
		return false;

	if (!curTipoOpcionArtNuevo.commitBuffer())
		return false;

	var idNuevo:Number = curTipoOpcionArtNuevo.valueBuffer("idtipoopcionart");

	if (!this.iface.copiarOpcionesArticulo(id, idNuevo))
		return false;

	return idNuevo;
}

function articuloscomp_copiarOpcionesArticulo(idTipoOpcion:String, idTipoOpcionNueva:String):Boolean
{
		var q:FLSqlQuery = new FLSqlQuery();
		q.setTablesList("opcionesarticulocomp");
		q.setSelect("idopcionarticulo");
		q.setFrom("opcionesarticulocomp");
		q.setWhere("idtipoopcionart = " + idTipoOpcion);
		
		if (!q.exec())
			return false;

		while (q.next()) {
			if (!this.iface.copiarOpcionArticulo(q.value("idopcionarticulo"), idTipoOpcionNueva))
				return false;
		}

	return true;
}

function articuloscomp_copiarOpcionArticulo(id:String, idTipoOpcionNueva:String):Number
{
	var curOpcionArt:FLSqlCursor = new FLSqlCursor("opcionesarticulocomp");
	curOpcionArt.select("idopcionarticulo = " + id);
	if (!curOpcionArt.first())
		return false;
	curOpcionArt.setModeAccess(curOpcionArt.Edit);
	curOpcionArt.refreshBuffer();
	
	var curOpcionArtNuevo:FLSqlCursor = new FLSqlCursor("opcionesarticulocomp");
	curOpcionArtNuevo.setModeAccess(curOpcionArtNuevo.Insert);
	curOpcionArtNuevo.refreshBuffer();

	if (!this.iface.datosOpcionArticulo(curOpcionArt, curOpcionArtNuevo, idTipoOpcionNueva))
		return false;

	if (!curOpcionArtNuevo.commitBuffer())
		return false;

	var idNuevo:Number = curOpcionArtNuevo.valueBuffer("idopcionarticulo");

	return idNuevo;
}


function articuloscomp_datosArticuloComp(cursor:FLSqlCursor,cursorNuevo:FLSqlCursor,referencia:String):Boolean
{
	var util:FLUtil = new FLUtil;

	cursorNuevo.setValueBuffer("refcompuesto", referencia);
	cursorNuevo.setValueBuffer("refcomponente", cursor.valueBuffer("refcomponente"));
	cursorNuevo.setValueBuffer("desccomponente", cursor.valueBuffer("desccomponente"));
	cursorNuevo.setValueBuffer("cantidad", cursor.valueBuffer("cantidad"));
	cursorNuevo.setValueBuffer("codunidad", cursor.valueBuffer("codunidad"));

	var idTipoOpcion:String = util.sqlSelect("tiposopcionartcomp", "idtipoopcion", "idtipoopcionart = " + cursor.valueBuffer("idtipoopcionart"));
	var idTipoOpcionArt:String;
	if (idTipoOpcion) {
		idTipoOpcionArt = util.sqlSelect("tiposopcionartcomp", "idtipoopcionart", "referencia = '" + cursorNuevo.valueBuffer("refcompuesto") + "' AND idtipoopcion = " + idTipoOpcion);
		if (idTipoOpcionArt && idTipoOpcionArt != "") {
			cursorNuevo.setValueBuffer("idtipoopcionart", idTipoOpcionArt);
		}
	}
	var idOpcion:String = util.sqlSelect("opcionesarticulocomp", "idopcion", "idopcionarticulo = " + cursor.valueBuffer("idopcionarticulo"));
	if (idOpcion) {
		var idOpcionArt:String = util.sqlSelect("opcionesarticulocomp", "idopcionarticulo", "idtipoopcionart = " + idTipoOpcionArt + " AND idopcion = " + idOpcion);
		if (idOpcionArt && idOpcionArt != "") {
			cursorNuevo.setValueBuffer("idopcionarticulo", idOpcionArt);
		}
	}
	//cursorNuevo.setValueBuffer("idopcionarticulo", cursor.valueBuffer("idopcionarticulo"));

	return true;
}

function articuloscomp_datosTipoOpcionArticulo(cursor:FLSqlCursor, cursorNuevo:FLSqlCursor, referencia:String):Boolean
{
	cursorNuevo.setValueBuffer("referencia", referencia);
	cursorNuevo.setValueBuffer("idtipoopcion", cursor.valueBuffer("idtipoopcion"));
	cursorNuevo.setValueBuffer("tipo", cursor.valueBuffer("tipo"));

	return true;
}

function articuloscomp_datosOpcionArticulo(cursor:FLSqlCursor, cursorNuevo:FLSqlCursor, idTipoOpcion:String):Boolean
{
	cursorNuevo.setValueBuffer("idtipoopcionart", idTipoOpcion);
	cursorNuevo.setValueBuffer("idopcion", cursor.valueBuffer("idopcion"));
	cursorNuevo.setValueBuffer("opcion", cursor.valueBuffer("opcion"));
	cursorNuevo.setValueBuffer("valordefecto", cursor.valueBuffer("valordefecto"));

	return true;
}

function articuloscomp_actualizarVariables_clicked()
{
	var util:FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	cursor.transaction(false);

	try {
		if (this.iface.actualizarVariables()) {
			cursor.commit();
		}
		else {
			cursor.rollback();
			return false;
		}
	}
	catch (e) {
		cursor.rollback();
		MessageBox.critical(util.translate("scripts", "Hubo un error al actualizar la propiedad variable de los artículos:\n") + e, MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	MessageBox.information(util.translate("scripts", "Los artículos se actualizaron correctamente"), MessageBox.Ok, MessageBox.NoButton);
}

function articuloscomp_actualizarVariables():Boolean
{
	var util:FLUtil;

	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("articulos");
	q.setSelect("referencia");
	q.setFrom("articulos");
	q.setWhere("1 = 1");
	
	if (!q.exec())
		return false;

	util.createProgressDialog( util.translate( "scripts", "Actualizando propiedad Variable ..." ), q.size());

	var progress:Number = 0;
	var variable:Boolean;
	while (q.next()) {
		util.setProgress(progress++);
		variable = false;
		if(formRecordarticulos.iface.pub_esArticuloVariable(q.value("referencia"))) {
			variable = true;
		}

		if(!util.sqlUpdate("articulos","variable",variable,"referencia = '" + q.value("referencia") + "'"))
			return false;	
	}

	util.destroyProgressDialog();
	return true;
}
//// ARTICULOSCOMP //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition pesosMedidas */
/////////////////////////////////////////////////////////////////
//// PESOSMEDIDAS ///////////////////////////////////////////////
function pesosMedidas_datosArticulo(cursor:FLSqlCursor,referencia:String):Boolean 
{
	if (!this.iface.__datosArticulo(cursor,referencia))
		return false;

	cursor.setValueBuffer("codunidad",this.iface.curArticulo.valueBuffer("codunidad"));

	return true;
}
//// PESOSMEDIDAS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition subfamilias */
/////////////////////////////////////////////////////////////////
//// SUBFAMILIAS ////////////////////////////////////////////////
function subfamilias_datosArticulo(cursor:FLSqlCursor,referencia:String):Boolean 
{
	if (!this.iface.__datosArticulo(cursor,referencia))
		return false;

	cursor.setValueBuffer("codsubfamilia",this.iface.curArticulo.valueBuffer("codsubfamilia"));

	return true;
}
//// SUBFAMILIAS ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition silixSeleccionar */
/////////////////////////////////////////////////////////////////
//// SILIXSELECCIONAR //////////////////////////////////////////////////

function silixSeleccionar_init()
{
	this.iface.__init();

	connect(this.child("pbnCheckOnOff"), "clicked()", this, "iface.seleccionCheckOnOff");
	connect(this.child("pbnSeleccionarTodo"), "clicked()", this, "iface.seleccionTodo");
	connect(this.child("pbnSeleccionarCriterio"), "clicked()", this, "iface.seleccionCriterio");
	connect(this.child("pbnSeleccionarNada"), "clicked()", this, "iface.seleccionNada");

	this.iface.seleccionVerificarHabilitaciones();
}

function silixSeleccionar_seleccionCheckOnOff()
{
	if ( this.iface.tdbRecords.checkColumnEnabled ) {
		// Deshabilitar check
		this.iface.tdbRecords.clearChecked();
		this.iface.tdbRecords.setCheckColumnEnabled(false);
		this.iface.tdbRecords.setOrderCols(this.iface.tdbRecords.orderCols());
		this.iface.tdbRecords.refresh();
	} else {
		// Habilitar check
		this.iface.tdbRecords.setCheckColumnEnabled(true);
		this.iface.tdbRecords.refresh();
		this.iface.tdbRecords.setOrderCols(this.iface.tdbRecords.orderCols());
	}

	this.iface.tdbRecords.setFocus();
	this.iface.seleccionVerificarHabilitaciones();
}

function silixSeleccionar_seleccionVerificarHabilitaciones()
{
	if ( this.iface.tdbRecords.checkColumnEnabled ) {
		// Check habilitado
		this.child("pbnCheckOnOff").setOn(true);

		this.child("pbnSeleccionarTodo").setDisabled(false);
		this.child("pbnSeleccionarCriterio").setDisabled(false);
		this.child("pbnSeleccionarNada").setDisabled(false);
	}
	else {
		// Check deshabilitado
		this.child("pbnCheckOnOff").setOn(false);

		this.child("pbnSeleccionarTodo").setDisabled(true);
		this.child("pbnSeleccionarCriterio").setDisabled(true);
		this.child("pbnSeleccionarNada").setDisabled(true);
	}
}

function silixSeleccionar_seleccionTodo()
{
	var cursor = new FLSqlCursor("articulos");
	cursor.setMainFilter(this.iface.tdbRecords.filter());
	var clavePrimaria = cursor.primaryKey();
	cursor.select();
	while (cursor.next()) {
		this.iface.tdbRecords.setPrimaryKeyChecked(cursor.valueBuffer(clavePrimaria), true)
	}
	this.iface.tdbRecords.refresh();
	this.iface.tdbRecords.setFocus();
}

function silixSeleccionar_seleccionNada()
{
	this.iface.tdbRecords.clearChecked();
	this.iface.tdbRecords.refresh();
	this.iface.tdbRecords.setFocus();
}

function silixSeleccionar_seleccionCriterio()
{
	var util:FLUtil = new FLUtil();
	var seleccionado;
	
	var lista = ["Familias", "Subfamilias", "Fabricantes"];

	var dialog = new Dialog(util.translate ( "scripts", "Seleccionar" ), 0);
	dialog.caption = "Selección";
	dialog.OKButtonText = util.translate ( "scripts", "Aceptar" );
	dialog.cancelButtonText = util.translate ( "scripts", "Cancelar" );
	
 	var valor = new ComboBox;
	valor.label = "Elija un criterio de selección"
	valor.itemList = lista;
	dialog.add( valor );

	if (!dialog.exec())
		return;

	var tabla:String;
	var campo:String;
	var idCampo:String;
	switch (valor.currentItem) {
		case "Familias": {
			tabla = "familias";
			campo = "descripcion";
			idCampo = "codfamilia";
			break;
		}
		case "Subfamilias": {
			tabla = "subfamilias";
			campo = "descripcion";
			idCampo = "codsubfamilia";
			break;
		}
		case "Fabricantes": {
			tabla = "fabricantes";
			campo = "nombre";
			idCampo = "codfabricante";
			break;
		}
	}

	var sel = flfactppal.iface.pub_seleccionar(tabla, campo, idCampo);
	if (sel.length == 0)
		return;
	var cursor = new FLSqlCursor("articulos");
	cursor.setMainFilter(this.iface.tdbRecords.filter());
	var clavePrimaria = cursor.primaryKey();
	var filtro:String = "";
	for (var i = 0; i < sel.length; i++) {
		if (i == 0)
			filtro = idCampo + " = '" + sel[i] + "'";
		else
			filtro = filtro + " OR " + idCampo + " = '" + sel[i] + "'";
	}

	cursor.select(filtro);
	while (cursor.next()) {
		this.iface.tdbRecords.setPrimaryKeyChecked(cursor.valueBuffer(clavePrimaria), true)
	}
	this.iface.tdbRecords.refresh();
	this.iface.tdbRecords.setFocus();
}

//// SILIXSELECCIONAR ///////////////////////////////////////////
////////////////////////////////////////////////////////////////

/** @class_definition silixOrdenCampos */
/////////////////////////////////////////////////////////////////
//// SILIXORDENCAMPOS ///////////////////////////////////////////

function silixOrdenCampos_init()
{
	this.iface.__init();

	var orden:Array = [ "descripcion", "referencia", "codunidad", "pvp", "coddivisa", "ivaincluido", "codimpuesto", "stockfis", "codfamilia", "codsubfamilia", "codfabricante", "modelo", "nostock", "secompra", "sevende", "variable", "costeultimo", "costemedio", "costemaximo", "marcacion", "variacion", "stockmin", "stockmax", "controlnumserie", "porlotes", "diasconsumo", "publico", "fechapub", "enportada", "ordenportada", "enoferta", "pvpoferta", "codbarras", "observaciones" ];

	this.iface.tdbRecords.setOrderCols(orden);
}

//// SILIXORDENCAMPOS ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////