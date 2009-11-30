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

/** @class_declaration ivaIncluido */
/////////////////////////////////////////////////////////////////
//// IVAINCLUIDO ////////////////////////////////////////////////
class ivaIncluido extends trazabilidad {
    function ivaIncluido( context ) { trazabilidad ( context ); }
	function datosArticulo(cursor:FLSqlCursor,referencia:String):Boolean {
		return this.ctx.ivaIncluido_datosArticulo(cursor,referencia);
	}
}
//// IVAINCLUIDO ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration articuloscomp */
/////////////////////////////////////////////////////////////////
//// ARTICULOSCOMP //////////////////////////////////////////////
class articuloscomp extends ivaIncluido {
	var tbnActualizarVariable:Object;
	function articuloscomp( context ) { ivaIncluido ( context ); }
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

/** @class_declaration silixSeleccionar */
/////////////////////////////////////////////////////////////////
//// SILIXSELECCIONAR ///////////////////////////////////////////
class silixSeleccionar extends pesosMedidas {
    function silixSeleccionar( context ) { pesosMedidas ( context ); }
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
		this.ctx.silixSeleccionar_seleccionTodo();
	}
	function seleccionCriterio() {
		this.ctx.silixSeleccionar_seleccionCriterio();
	}
	function seleccionNada() {
		this.ctx.silixSeleccionar_seleccionNada();
	}

	function pbnAccionPrincipal_clicked() {
		this.ctx.silixSeleccionar_pbnAccionPrincipal_clicked();
	}
	function lanzarAccion_principalProveedor(curAccion:FLSqlCursor) {
		this.ctx.silixSeleccionar_lanzarAccion_principalProveedor(curAccion);
	}
	function lanzarAccion_principalAgente(curAccion:FLSqlCursor) {
		this.ctx.silixSeleccionar_lanzarAccion_principalAgente(curAccion);
	}
	function lanzarAccion_principalDivisa(curAccion:FLSqlCursor) {
		this.ctx.silixSeleccionar_lanzarAccion_principalDivisa(curAccion);
	}
	function lanzarAccion_principalImpuesto(curAccion:FLSqlCursor) {
		this.ctx.silixSeleccionar_lanzarAccion_principalImpuesto(curAccion);
	}

	function pbnAccionAlmacen_clicked() {
		this.ctx.silixSeleccionar_pbnAccionAlmacen_clicked();
	}
	function lanzarAccion_almacenAlmacen(curAccion:FLSqlCursor) {
		this.ctx.silixSeleccionar_lanzarAccion_almacenAlmacen(curAccion);
	}
	function lanzarAccion_almacenTarifa(curAccion:FLSqlCursor) {
		this.ctx.silixSeleccionar_lanzarAccion_almacenTarifa(curAccion);
	}
	function lanzarAccion_almacenFamilia(curAccion:FLSqlCursor) {
		this.ctx.silixSeleccionar_lanzarAccion_almacenFamilia(curAccion);
	}
	function lanzarAccion_almacenFabricante(curAccion:FLSqlCursor) {
		this.ctx.silixSeleccionar_lanzarAccion_almacenFabricante(curAccion);
	}
	function lanzarAccion_almacenUnidad(curAccion:FLSqlCursor) {
		this.ctx.silixSeleccionar_lanzarAccion_almacenUnidad(curAccion);
	}
	function lanzarAccion_almacenNumSerie(curAccion:FLSqlCursor) {
		this.ctx.silixSeleccionar_lanzarAccion_almacenNumSerie(curAccion);
	}
	function lanzarAccion_almacenLote(curAccion:FLSqlCursor) {
		this.ctx.silixSeleccionar_lanzarAccion_almacenLote(curAccion);
	}

}
//// SILIXSELECCIONAR ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration actualizaArticulos */
/////////////////////////////////////////////////////////////////
//// ACTUALIZA_ARTICULOS ////////////////////////////////////////
class actualizaArticulos extends silixSeleccionar {
	var arrayNomCampos = [];

    function actualizaArticulos( context ) { silixSeleccionar ( context ); }
	function init() {
		this.ctx.actualizaArticulos_init();
	}
	function lanzarActualizacion() {
		this.ctx.actualizaArticulos_lanzarActualizacion();
	}
}
//// ACTUALIZA_ARTICULOS ////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends actualizaArticulos {
    function head( context ) { actualizaArticulos ( context ); }
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

	connect(this.child("pbnAccionPrincipal"), "clicked()", this, "iface.pbnAccionPrincipal_clicked()");
	connect(this.child("pbnAccionAlmacen"), "clicked()", this, "iface.pbnAccionAlmacen_clicked()");

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

		this.child("pbnAccionPrincipal").setDisabled(false);
		this.child("pbnAccionAlmacen").setDisabled(false);
	}
	else {
		// Check deshabilitado
		this.child("pbnCheckOnOff").setOn(false);

		this.child("pbnSeleccionarTodo").setDisabled(true);
		this.child("pbnSeleccionarCriterio").setDisabled(true);
		this.child("pbnSeleccionarNada").setDisabled(true);

		this.child("pbnAccionPrincipal").setDisabled(true);
		this.child("pbnAccionAlmacen").setDisabled(true);
	}
}

function silixSeleccionar_seleccionTodo()
{
	var util:FLUtil = new FLUtil();

	var cursor:FLSqlCursor = new FLSqlCursor("articulos");
	cursor.setMainFilter(this.iface.tdbRecords.filter());
	cursor.select();

	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Seleccionando %1 artículos..." ).arg(cursor.size()), cursor.size() );

	while (cursor.next()) {
		this.iface.tdbRecords.setPrimaryKeyChecked(cursor.valueBuffer("referencia"), true)
		util.setProgress( ++paso );
	}
	util.destroyProgressDialog();
	this.iface.tdbRecords.refresh();
}

function silixSeleccionar_seleccionNada()
{
	this.iface.tdbRecords.clearChecked();
	this.iface.tdbRecords.refresh();
}

function silixSeleccionar_seleccionCriterio()
{
	var util:FLUtil = new FLUtil();

	var criterios:Object = new FLFormSearchDB("seleccioncriteriosarticulos");

	var curCriterios:FLSqlCursor = criterios.cursor();
	curCriterios.setModeAccess(curCriterios.Insert);
	curCriterios.refreshBuffer();

	criterios.setMainWidget();
	var seleccion = criterios.exec("seleccion");
	if (!seleccion)
		return;

	var cursor:FLSqlCursor = new FLSqlCursor("articulos");
	cursor.setMainFilter(this.iface.tdbRecords.filter());
	cursor.select(seleccion);

	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Seleccionando %1 artículos..." ).arg(cursor.size()), cursor.size() );

	while (cursor.next()) {
		this.iface.tdbRecords.setPrimaryKeyChecked(cursor.valueBuffer("referencia"), true)
		util.setProgress( ++paso );
	}
	util.destroyProgressDialog();
	this.iface.tdbRecords.refresh();
}

function silixSeleccionar_pbnAccionPrincipal_clicked()
{
	var f:Object = new FLFormSearchDB("acciones_articulosprincipal");
	var cursor:FLSqlCursor = f.cursor();

	cursor.select();
	if (!cursor.first())
		cursor.setModeAccess(cursor.Insert);
	else
		cursor.setModeAccess(cursor.Edit);

	f.setMainWidget();
	cursor.refreshBuffer();
	var commitOk:Boolean = false;
	var acpt:Boolean;
	cursor.transaction(false);
	while (!commitOk) {
		acpt = false;
		f.exec("id");
		acpt = f.accepted();
		if (!acpt) {
			if (cursor.rollback())
				commitOk = true;
		} else {
			if (cursor.commitBuffer()) {
				cursor.commit();
				commitOk = true;
			}
		}
	}
	if (!acpt)
		return;

	if ( f.child("ckbProveedor").checked )
		this.iface.lanzarAccion_principalProveedor(cursor);

	if ( f.child("ckbAgente").checked )
		this.iface.lanzarAccion_principalAgente(cursor);

	if ( f.child("ckbDivisa").checked )
		this.iface.lanzarAccion_principalDivisa(cursor);

	if ( f.child("ckbImpuesto").checked )
		this.iface.lanzarAccion_principalImpuesto(cursor);
}

function silixSeleccionar_lanzarAccion_principalProveedor(curAccion:FLSqlCursor)
{
	var util:FLUtil = new FLUtil();

	if (!curAccion.valueBuffer("codproveedor")) {
		MessageBox.critical(util.translate("scripts", "Debe indicar el proveedor que se utilizará para la asociación."), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	var datos:String = [];
	datos = this.iface.tdbRecords.primarysKeysChecked();
	var lista:String = datos.join();
	if (!lista)
		return;

	var curArticulos:FLSqlCursor = new FLSqlCursor("articulos");
	curArticulos.setMainFilter(this.iface.tdbRecords.filter());
	curArticulos.select("referencia IN ('" + lista.replace(/,/g,"', '") + "') AND secompra");

	var curArticulosProv:FLSqlCursor, referencia:String, codProveedor:String, codDivisa:String;
	codProveedor = curAccion.valueBuffer("codproveedor");
	codDivisa = util.sqlSelect("proveedores", "coddivisa", "codproveedor = '" + codProveedor + "'");
	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Ejecutando acción..." ), curArticulos.size() );

	while (curArticulos.next()) {
		curArticulos.setModeAccess(curArticulos.Browse);

		referencia = curArticulos.valueBuffer("referencia");

		curArticulosProv = new FLSqlCursor("articulosprov");
		curArticulosProv.select("referencia = '" + referencia + "' AND codproveedor = '" + codProveedor + "'");
		if (!curArticulosProv.first())
			curArticulosProv.setModeAccess(curArticulosProv.Insert);
		else
			curArticulosProv.setModeAccess(curArticulosProv.Edit);
		curArticulosProv.refreshBuffer();

		curArticulosProv.setValueBuffer("referencia", referencia);
		curArticulosProv.setValueBuffer("codproveedor", codProveedor);
		curArticulosProv.setValueBuffer("pordefecto", curAccion.valueBuffer("pordefecto"));
		curArticulosProv.setValueBuffer("coddivisa", codDivisa);

		if (!curArticulosProv.commitBuffer()) {
			MessageBox.critical(util.translate("scripts", "Se produjo un error al ejecutar la acción"), MessageBox.Ok, MessageBox.NoButton);
			util.destroyProgressDialog();
			return;
		}
		util.setProgress( ++paso );
	}
	util.destroyProgressDialog();
}

function silixSeleccionar_lanzarAccion_principalAgente(curAccion:FLSqlCursor)
{
	var util:FLUtil = new FLUtil();

	if (!curAccion.valueBuffer("codagente")) {
		MessageBox.critical(util.translate("scripts", "Debe indicar el agente que se utilizará para la asociación."), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	var datos:String = [];
	datos = this.iface.tdbRecords.primarysKeysChecked();
	var lista:String = datos.join();
	if (!lista)
		return;

	var curArticulos:FLSqlCursor = new FLSqlCursor("articulos");
	curArticulos.setMainFilter(this.iface.tdbRecords.filter());
	curArticulos.select("referencia IN ('" + lista.replace(/,/g,"', '") + "') AND sevende");

	var curArticulosAgen:FLSqlCursor, referencia:String, codAgente:String, nomAgente:String;
	codAgente = curAccion.valueBuffer("codagente");
	nomAgente = util.sqlSelect("agentes", "apellidos", "codagente = '" + codAgente + "'");
	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Ejecutando acción..." ), curArticulos.size() );

	while (curArticulos.next()) {
		curArticulos.setModeAccess(curArticulos.Browse);

		referencia = curArticulos.valueBuffer("referencia");

		curArticulosAgen = new FLSqlCursor("articulosagen");
		curArticulosAgen.select("referencia = '" + referencia + "' AND codagente = '" + codAgente + "'");
		if (!curArticulosAgen.first())
			curArticulosAgen.setModeAccess(curArticulosAgen.Insert);
		else
			curArticulosAgen.setModeAccess(curArticulosAgen.Edit);
		curArticulosAgen.refreshBuffer();

		curArticulosAgen.setValueBuffer("referencia", referencia);
		curArticulosAgen.setValueBuffer("codagente", codAgente);
		curArticulosAgen.setValueBuffer("nombre", nomAgente);
		curArticulosAgen.setValueBuffer("tipocomision", util.translate("MetaData", "Porcentual"));
		curArticulosAgen.setValueBuffer("comision", curAccion.valueBuffer("porcomision"));

		if (!curArticulosAgen.commitBuffer()) {
			MessageBox.critical(util.translate("scripts", "Se produjo un error al ejecutar la acción"), MessageBox.Ok, MessageBox.NoButton);
			util.destroyProgressDialog();
			return;
		}
		util.setProgress( ++paso );
	}
	util.destroyProgressDialog();
}

function silixSeleccionar_lanzarAccion_principalDivisa(curAccion:FLSqlCursor)
{
	var util:FLUtil = new FLUtil();

	if (!curAccion.valueBuffer("coddivisa")) {
		MessageBox.critical(util.translate("scripts", "Debe indicar la divisa que se utilizará."), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	var datos:String = [];
	datos = this.iface.tdbRecords.primarysKeysChecked();
	var lista:String = datos.join();
	if (!lista)
		return;

	var curArticulos:FLSqlCursor = new FLSqlCursor("articulos");
	curArticulos.setMainFilter(this.iface.tdbRecords.filter());
	curArticulos.select("referencia IN ('" + lista.replace(/,/g,"', '") + "')");

	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Ejecutando acción..." ), curArticulos.size() );

	while (curArticulos.next()) {
		curArticulos.setModeAccess(curArticulos.Edit);
		curArticulos.refreshBuffer();

		curArticulos.setValueBuffer("coddivisa", curAccion.valueBuffer("coddivisa"));

		if (!curArticulos.commitBuffer()) {
			MessageBox.critical(util.translate("scripts", "Se produjo un error al ejecutar la acción"), MessageBox.Ok, MessageBox.NoButton);
			util.destroyProgressDialog();
			return;
		}
		util.setProgress( ++paso );
	}
	util.destroyProgressDialog();
}

function silixSeleccionar_lanzarAccion_principalImpuesto(curAccion:FLSqlCursor)
{
	var util:FLUtil = new FLUtil();

	if (!curAccion.valueBuffer("codimpuesto")) {
		MessageBox.critical(util.translate("scripts", "Debe indicar el impuesto que se utilizará."), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	var datos:String = [];
	datos = this.iface.tdbRecords.primarysKeysChecked();
	var lista:String = datos.join();
	if (!lista)
		return;

	var curArticulos:FLSqlCursor = new FLSqlCursor("articulos");
	curArticulos.setMainFilter(this.iface.tdbRecords.filter());
	curArticulos.select("referencia IN ('" + lista.replace(/,/g,"', '") + "')");

	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Ejecutando acción..." ), curArticulos.size() );

	while (curArticulos.next()) {
		curArticulos.setModeAccess(curArticulos.Edit);
		curArticulos.refreshBuffer();

		curArticulos.setValueBuffer("codimpuesto", curAccion.valueBuffer("codimpuesto"));

		if (!curArticulos.commitBuffer()) {
			MessageBox.critical(util.translate("scripts", "Se produjo un error al ejecutar la acción"), MessageBox.Ok, MessageBox.NoButton);
			util.destroyProgressDialog();
			return;
		}
		util.setProgress( ++paso );
	}
	util.destroyProgressDialog();
}

function silixSeleccionar_pbnAccionAlmacen_clicked()
{
	var f:Object = new FLFormSearchDB("acciones_articulosalmacen");
	var cursor:FLSqlCursor = f.cursor();

	cursor.select();
	if (!cursor.first())
		cursor.setModeAccess(cursor.Insert);
	else
		cursor.setModeAccess(cursor.Edit);

	f.setMainWidget();
	cursor.refreshBuffer();
	var commitOk:Boolean = false;
	var acpt:Boolean;
	cursor.transaction(false);
	while (!commitOk) {
		acpt = false;
		f.exec("id");
		acpt = f.accepted();
		if (!acpt) {
			if (cursor.rollback())
				commitOk = true;
		} else {
			if (cursor.commitBuffer()) {
				cursor.commit();
				commitOk = true;
			}
		}
	}
	if (!acpt)
		return;

	if ( f.child("ckbAlmacen").checked )
		this.iface.lanzarAccion_almacenAlmacen(cursor);

	if ( f.child("ckbTarifa").checked )
		this.iface.lanzarAccion_almacenTarifa(cursor);

	if ( f.child("ckbFamilia").checked )
		this.iface.lanzarAccion_almacenFamilia(cursor);

	if ( f.child("ckbFabricante").checked )
		this.iface.lanzarAccion_almacenFabricante(cursor);

	if ( f.child("ckbUnidad").checked )
		this.iface.lanzarAccion_almacenUnidad(cursor);

	if ( f.child("ckbNumSerie").checked )
		this.iface.lanzarAccion_almacenNumSerie(cursor);

	if ( f.child("ckbLote").checked )
		this.iface.lanzarAccion_almacenLote(cursor);
}

function silixSeleccionar_lanzarAccion_almacenAlmacen(curAccion:FLSqlCursor)
{
	var util:FLUtil = new FLUtil();

	if (!curAccion.valueBuffer("codalmacen")) {
		MessageBox.critical(util.translate("scripts", "Debe indicar el almacén que se utilizará para la asociación."), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	var datos:String = [];
	datos = this.iface.tdbRecords.primarysKeysChecked();
	var lista:String = datos.join();
	if (!lista)
		return;

	var curArticulos:FLSqlCursor = new FLSqlCursor("articulos");
	curArticulos.setMainFilter(this.iface.tdbRecords.filter());
	curArticulos.select("referencia IN ('" + lista.replace(/,/g,"', '") + "') AND NOT nostock");

	var curStocks:FLSqlCursor, referencia:String, codAlmacen:String;
	codAlmacen = curAccion.valueBuffer("codalmacen");
	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Ejecutando acción..." ), curArticulos.size() );

	while (curArticulos.next()) {
		curArticulos.setModeAccess(curArticulos.Browse);

		referencia = curArticulos.valueBuffer("referencia");

		curStocks = new FLSqlCursor("stocks");
		curStocks.select("referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "'");
		if (!curStocks.first())
			curStocks.setModeAccess(curStocks.Insert);
		else
			curStocks.setModeAccess(curStocks.Edit);
		curStocks.refreshBuffer();

		curStocks.setValueBuffer("referencia", referencia);
		curStocks.setValueBuffer("codalmacen", codAlmacen);

		if (!curStocks.commitBuffer()) {
			MessageBox.critical(util.translate("scripts", "Se produjo un error al ejecutar la acción"), MessageBox.Ok, MessageBox.NoButton);
			util.destroyProgressDialog();
			return;
		}
		util.setProgress( ++paso );
	}
	util.destroyProgressDialog();
}

function silixSeleccionar_lanzarAccion_almacenTarifa(curAccion:FLSqlCursor)
{
	var util:FLUtil = new FLUtil();

	if (!curAccion.valueBuffer("codtarifa")) {
		MessageBox.critical(util.translate("scripts", "Debe indicar la tarifa que se utilizará para la asociación."), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	var datos:String = [];
	datos = this.iface.tdbRecords.primarysKeysChecked();
	var lista:String = datos.join();
	if (!lista)
		return;

	var curArticulos:FLSqlCursor = new FLSqlCursor("articulos");
	curArticulos.setMainFilter(this.iface.tdbRecords.filter());
	curArticulos.select("referencia IN ('" + lista.replace(/,/g,"', '") + "') AND sevende");

	var curArticulosTarifa:FLSqlCursor, referencia:String, codTarifa:String, pvpArticulo:Number, pvpTarifa:Number;
	codTarifa = curAccion.valueBuffer("codtarifa");

	var incLineal:Number = parseFloat(util.sqlSelect("tarifas","inclineal","codtarifa = '" + codTarifa + "'"));
	if (!incLineal || isNaN(incLineal))
		incLineal = 0;
	var incPorcentual:Number = util.sqlSelect("tarifas","incporcentual","codtarifa = '" + codTarifa + "'");
	if (!incPorcentual || isNaN(incPorcentual))
		incPorcentual = 0;

	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Ejecutando acción..." ), curArticulos.size() );

	while (curArticulos.next()) {
		curArticulos.setModeAccess(curArticulos.Browse);

		referencia = curArticulos.valueBuffer("referencia");
		pvpArticulo = curArticulos.valueBuffer("pvp");
		if (!pvpArticulo || isNaN(pvpArticulo))
			pvpArticulo = 0;

		pvpTarifa = ((pvpArticulo * (100 + incPorcentual)) / 100) + incLineal;
		if (!pvpTarifa || isNaN(pvpTarifa))
			pvpTarifa = 0;

		curArticulosTarifa = new FLSqlCursor("articulostarifas");
		curArticulosTarifa.select("referencia = '" + referencia + "' AND codtarifa = '" + codTarifa + "'");
		if (!curArticulosTarifa.first())
			curArticulosTarifa.setModeAccess(curArticulosTarifa.Insert);
		else
			curArticulosTarifa.setModeAccess(curArticulosTarifa.Edit);
		curArticulosTarifa.refreshBuffer();

		curArticulosTarifa.setValueBuffer("referencia", referencia);
		curArticulosTarifa.setValueBuffer("codtarifa", codTarifa);
		curArticulosTarifa.setValueBuffer("pvp", pvpTarifa);

		if (!curArticulosTarifa.commitBuffer()) {
			MessageBox.critical(util.translate("scripts", "Se produjo un error al ejecutar la acción"), MessageBox.Ok, MessageBox.NoButton);
			util.destroyProgressDialog();
			return;
		}
		util.setProgress( ++paso );
	}
	util.destroyProgressDialog();
}

function silixSeleccionar_lanzarAccion_almacenFamilia(curAccion:FLSqlCursor)
{
	var util:FLUtil = new FLUtil();

	var datos:String = [];
	datos = this.iface.tdbRecords.primarysKeysChecked();
	var lista:String = datos.join();
	if (!lista)
		return;

	var curArticulos:FLSqlCursor = new FLSqlCursor("articulos");
	curArticulos.setMainFilter(this.iface.tdbRecords.filter());
	curArticulos.select("referencia IN ('" + lista.replace(/,/g,"', '") + "')");

	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Ejecutando acción..." ), curArticulos.size() );

	while (curArticulos.next()) {
		curArticulos.setModeAccess(curArticulos.Edit);
		curArticulos.refreshBuffer();

		curArticulos.setValueBuffer("codfamilia", curAccion.valueBuffer("codfamilia"));

		if (!curArticulos.commitBuffer()) {
			MessageBox.critical(util.translate("scripts", "Se produjo un error al ejecutar la acción"), MessageBox.Ok, MessageBox.NoButton);
			util.destroyProgressDialog();
			return;
		}
		util.setProgress( ++paso );
	}
	util.destroyProgressDialog();
}

function silixSeleccionar_lanzarAccion_almacenFabricante(curAccion:FLSqlCursor)
{
	var util:FLUtil = new FLUtil();

	var datos:String = [];
	datos = this.iface.tdbRecords.primarysKeysChecked();
	var lista:String = datos.join();
	if (!lista)
		return;

	var curArticulos:FLSqlCursor = new FLSqlCursor("articulos");
	curArticulos.setMainFilter(this.iface.tdbRecords.filter());
	curArticulos.select("referencia IN ('" + lista.replace(/,/g,"', '") + "')");

	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Ejecutando acción..." ), curArticulos.size() );

	while (curArticulos.next()) {
		curArticulos.setModeAccess(curArticulos.Edit);
		curArticulos.refreshBuffer();

		curArticulos.setValueBuffer("codfabricante", curAccion.valueBuffer("codfabricante"));

		if (!curArticulos.commitBuffer()) {
			MessageBox.critical(util.translate("scripts", "Se produjo un error al ejecutar la acción"), MessageBox.Ok, MessageBox.NoButton);
			util.destroyProgressDialog();
			return;
		}
		util.setProgress( ++paso );
	}
	util.destroyProgressDialog();
}

function silixSeleccionar_lanzarAccion_almacenUnidad(curAccion:FLSqlCursor)
{
	var util:FLUtil = new FLUtil();

	var datos:String = [];
	datos = this.iface.tdbRecords.primarysKeysChecked();
	var lista:String = datos.join();
	if (!lista)
		return;

	var curArticulos:FLSqlCursor = new FLSqlCursor("articulos");
	curArticulos.setMainFilter(this.iface.tdbRecords.filter());
	curArticulos.select("referencia IN ('" + lista.replace(/,/g,"', '") + "')");

	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Ejecutando acción..." ), curArticulos.size() );

	while (curArticulos.next()) {
		curArticulos.setModeAccess(curArticulos.Edit);
		curArticulos.refreshBuffer();

		curArticulos.setValueBuffer("codunidad", curAccion.valueBuffer("codunidad"));

		if (!curArticulos.commitBuffer()) {
			MessageBox.critical(util.translate("scripts", "Se produjo un error al ejecutar la acción"), MessageBox.Ok, MessageBox.NoButton);
			util.destroyProgressDialog();
			return;
		}
		util.setProgress( ++paso );
	}
	util.destroyProgressDialog();
}

function silixSeleccionar_lanzarAccion_almacenNumSerie(curAccion:FLSqlCursor)
{
	var util:FLUtil = new FLUtil();

	var datos:String = [];
	datos = this.iface.tdbRecords.primarysKeysChecked();
	var lista:String = datos.join();
	if (!lista)
		return;

	var curArticulos:FLSqlCursor = new FLSqlCursor("articulos");
	curArticulos.setMainFilter(this.iface.tdbRecords.filter());
	curArticulos.select("referencia IN ('" + lista.replace(/,/g,"', '") + "') AND NOT nostock");

	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Ejecutando acción..." ), curArticulos.size() );

	while (curArticulos.next()) {
		curArticulos.setModeAccess(curArticulos.Edit);
		curArticulos.refreshBuffer();

		curArticulos.setValueBuffer("controlnumserie", curAccion.valueBuffer("controlnumserie"));

		if (!curArticulos.commitBuffer()) {
			MessageBox.critical(util.translate("scripts", "Se produjo un error al ejecutar la acción"), MessageBox.Ok, MessageBox.NoButton);
			util.destroyProgressDialog();
			return;
		}
		util.setProgress( ++paso );
	}
	util.destroyProgressDialog();
}

function silixSeleccionar_lanzarAccion_almacenLote(curAccion:FLSqlCursor)
{
	var util:FLUtil = new FLUtil();

	var datos:String = [];
	datos = this.iface.tdbRecords.primarysKeysChecked();
	var lista:String = datos.join();
	if (!lista)
		return;

	var curArticulos:FLSqlCursor = new FLSqlCursor("articulos");
	curArticulos.setMainFilter(this.iface.tdbRecords.filter());
	curArticulos.select("referencia IN ('" + lista.replace(/,/g,"', '") + "') AND NOT nostock");

	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Ejecutando acción..." ), curArticulos.size() );

	while (curArticulos.next()) {
		curArticulos.setModeAccess(curArticulos.Edit);
		curArticulos.refreshBuffer();

		curArticulos.setValueBuffer("porlotes", curAccion.valueBuffer("porlotes"));
		curArticulos.setValueBuffer("diasconsumo", curAccion.valueBuffer("diasconsumo"));

		if (!curArticulos.commitBuffer()) {
			MessageBox.critical(util.translate("scripts", "Se produjo un error al ejecutar la acción"), MessageBox.Ok, MessageBox.NoButton);
			util.destroyProgressDialog();
			return;
		}
		util.setProgress( ++paso );
	}
	util.destroyProgressDialog();
}

//// SILIXSELECCIONAR ///////////////////////////////////////////
////////////////////////////////////////////////////////////////

/** @class_definition actualizaArticulos */
/////////////////////////////////////////////////////////////////
//// ACTUALIZA_ARTICULOS ////////////////////////////////////////

function actualizaArticulos_init()
{
	this.iface.__init();

	connect(this.child("pbnImportar"), "clicked()", this, "iface.lanzarActualizacion");
}

function actualizaArticulos_lanzarActualizacion()
{
	var util:FLUtil = new FLUtil();
	this.iface.arrayNomCampos = [];

	var f:Object = new FLFormSearchDB("actualizaarticulos");
	var cursor:FLSqlCursor = f.cursor();

	cursor.setActivatedCheckIntegrity(false);
	cursor.select();
	if (!cursor.first())
		cursor.setModeAccess(cursor.Insert);
	else
		cursor.setModeAccess(cursor.Edit);

	f.setMainWidget();
	cursor.refreshBuffer();
	var datos:String = f.exec("datos");

	if (datos) {
		var nombreCampo:String;
		var curArticulos:FLSqlCursor = new FLSqlCursor("articulos");
		var curArtActualizados:FLSqlCursor = new FLSqlCursor("articulosactualizados");
		curArtActualizados.select("referencia IN (" + datos + ")");

		var paso:Number = 0;
		util.createProgressDialog( util.translate( "scripts", "Actualizando artículos..." ), curArtActualizados.size());

		while (curArtActualizados.next()) {

			curArticulos.select("referencia = '" + curArtActualizados.valueBuffer("referencia") + "'");
			if (!curArticulos.first()) {
				curArticulos.setModeAccess(curArticulos.Insert);
				 // Crear los siguientes campos
				this.iface.arrayNomCampos = new Array("referencia", "descripcion", "pvp", "coddivisa", "ivaincluido", "codimpuesto", "codunidad", "codfamilia", "codfabricante", "modelo", "costemaximo", "codsubcuentacom", "idsubcuentacom", "observaciones");
			} else {
				curArticulos.setModeAccess(curArticulos.Edit);
				 // Actualizar los siguientes campos
				this.iface.arrayNomCampos = new Array("pvp");
			}
			curArticulos.refreshBuffer();
			for (var i:Number = 0; i < this.iface.arrayNomCampos.length; i++) {
				nombreCampo = this.iface.arrayNomCampos[i];
				curArticulos.setValueBuffer(nombreCampo, curArtActualizados.valueBuffer(nombreCampo));
			}
			if (!curArticulos.commitBuffer())
				debug("Error al actualizar/crear el artículo " + curArtActualizados.valueBuffer("referencia") + " en el campo " + nombreCampo);

			util.setProgress( ++paso );
		}
		util.destroyProgressDialog();
	}

// 	var paso:Number = 0;
// 	var curArtActualizados:FLSqlCursor = new FLSqlCursor("articulosactualizados");
// 	curArtActualizados.select();
// 	util.createProgressDialog( util.translate( "scripts", "Terminando transacción..." ), curArtActualizados.size());
// 	while (curArtActualizados.next()) {
// 		curArtActualizados.setModeAccess(curArtActualizados.Del);
// 		curArtActualizados.commitBuffer();
// 		util.setProgress( ++paso );
// 	}
// 	util.destroyProgressDialog();
}

//// ACTUALIZA_ARTICULOS ///////////////////////////////////////
////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////