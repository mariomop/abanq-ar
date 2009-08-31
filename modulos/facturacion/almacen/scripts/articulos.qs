/***************************************************************************
                 articulos.qs  -  description
                             -------------------
    begin                : lun abr 26 2004
    copyright            : (C) 2004 by InfoSiAL S.L.
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
	function calculateField(fN:String):String { return this.ctx.interna_calculateField(fN); }
	function validateForm():Boolean {return this.ctx.interna_validateForm();}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var ejercicioActual:String;
	var longSubcuenta:Number;
	var bloqueoSubcuenta:Boolean;
	var posActualPuntoSubcuenta:Number;
	var tbnProvDefecto:Object;
	
	function oficial( context ) { interna( context ); } 
	function generarArticulosTarifas() {
		return this.ctx.oficial_generarArticulosTarifas();
	}
	function calcularStockFisico() {
		return this.ctx.oficial_calcularStockFisico();
	}
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function genCodBar(fN:String) {
		return this.ctx.oficial_genCodBar(fN);
	}
	function eliminarStock():Boolean {
		return this.ctx.oficial_eliminarStock();
	}
	function borrarDatosStock(referencia:String):Boolean {
		return this.ctx.oficial_borrarDatosStock(referencia);
	}
	function marcarProvDefecto() {
		return this.ctx.oficial_marcarProvDefecto();
	}
	function establecerProveedorDefecto(referencia:String, codProveedor:String):Boolean {
		return this.ctx.oficial_establecerProveedorDefecto(referencia, codProveedor);
	}
	function establecerDatosAlta() {
		return this.ctx.oficial_establecerDatosAlta();
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration fluxEcommerce */
/////////////////////////////////////////////////////////////////
//// FLUX ECOMMERCE //////////////////////////////////////////////////////
class fluxEcommerce extends oficial {
    function fluxEcommerce( context ) { oficial ( context ); }
	function init() {
		this.ctx.fluxEcommerce_init();
	}
	function validateForm():Boolean {
		return this.ctx.fluxEcommerce_validateForm(); 
	}
	function bufferChanged(fN:String) {
		return this.ctx.fluxEcommerce_bufferChanged(fN); 
	}
	function seleccionarImagen() {
		return this.ctx.fluxEcommerce_seleccionarImagen();
	}
	function editarAtributos() {
		return this.ctx.fluxEcommerce_editarAtributos();
	}
	function editarAtributos() {
		return this.ctx.fluxEcommerce_editarAtributos();
	}
	function actualizarPvpOferta() {
		return this.ctx.fluxEcommerce_actualizarPvpOferta();
	}
	function actualizarControlesOferta() {
		return this.ctx.fluxEcommerce_actualizarControlesOferta();
	}
	function traducirDescripcion() {
		return this.ctx.fluxEcommerce_traducirDescripcion();
	}
	function traducirDescPublica() {
		return this.ctx.fluxEcommerce_traducirDescPublica();
	}
}
//// FLUX ECOMMERCE //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration traducciones */
/////////////////////////////////////////////////////////////////
//// TRADUCCIONES ///////////////////////////////////////////////
class traducciones extends fluxEcommerce {
    function traducciones( context ) { fluxEcommerce ( context ); }
    function init() { 
		return this.ctx.traducciones_init(); 
	}
	function traducirDescripcion() {
		return this.ctx.traducciones_traducirDescripcion();
	}
}
//// TRADUCCIONES ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
class lotes extends traducciones {
    function lotes( context ) { traducciones ( context ); }
	function init() {
		return this.ctx.lotes_init();
	}
	function bufferChanged(fN:String) {
		return this.ctx.lotes_bufferChanged(fN);
	}
}
//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ivaIncluido */
//////////////////////////////////////////////////////////////////
//// IVAINCLUIDO /////////////////////////////////////////////////////
class ivaIncluido extends lotes {
    function ivaIncluido( context ) { lotes( context ); } 	
	function validateForm():Boolean {
		return this.ctx.ivaIncluido_validateForm();
	}
	function establecerDatosAlta() {
		return this.ctx.ivaIncluido_establecerDatosAlta();
	}
}
//// IVAINCLUIDO /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration articuloscomp */
/////////////////////////////////////////////////////////////////
//// ARTICULOSCOMP //////////////////////////////////////////////
class articuloscomp extends ivaIncluido {
	var COL_REFERENCIA:Number;
	var COL_DESCRIPCION:Number;
	var COL_CANTIDAD:Number;
	var COL_UNIDAD:Number;

	var curComponente_:FLSqlCursor;
	var lvwComponentes:Object;
	var lvwCompuestos:Object;
	var componenteSeleccionado:FLListViewItem;
	var compuestoSeleccionado:FLListViewItem;
	var raizComponente:FLListViewItem;
	var raizCompuesto:FLListViewItem;
	//var arrayNodos:Array;
	//var indice:Number;
	var curArticulosComp_:FLSqlCursor;
	var referenciaComp_:String;
	var idTipoOpcionArt_:String;
	var opcionesActuales:Array;
	var expansiones:Array;
	function articuloscomp( context ) { ivaIncluido ( context ); }
	function init() {
		this.ctx.articuloscomp_init();
	}
	function calcularPvp() {
		return this.ctx.articuloscomp_calcularPvp();
	}
	function pintarNodo(nodo:FLListViewItem,tipoNodo:String) {
		return this.ctx.articuloscomp_pintarNodo(nodo,tipoNodo);
	}
	function pintarNodosHijo(nodo:FLListViewItem, tipoNodo:String, idOpcion:String):Boolean {
		return this.ctx.articuloscomp_pintarNodosHijo(nodo, tipoNodo, idOpcion);
	}
	function buscarNodo(clave:String, padre) {
		return this.ctx.articuloscomp_buscarNodo(clave, padre);
	}
	function insertArticuloComp() {
		return this.ctx.articuloscomp_insertArticuloComp();
	}
	function editArticuloComp() {
		return this.ctx.articuloscomp_editArticuloComp();
	}
	function editTipoOpcion(clave:String) {
		return this.ctx.articuloscomp_editTipoOpcion(clave);
	}
	function editArticulo() {
		return this.ctx.articuloscomp_editArticulo();
	}
	function browseArticulo() {
		return this.ctx.articuloscomp_browseArticulo();
	}
	function deleteArticulo() {
		return this.ctx.articuloscomp_deleteArticulo();
	}
	function browseArticuloComp() {
		return this.ctx.articuloscomp_browseArticuloComp();
	}
	function browseArticuloCompuestos() {
		return this.ctx.articuloscomp_browseArticuloCompuestos();
	}
	function deleteArticuloComp() {
		return this.ctx.articuloscomp_deleteArticuloComp();
	}
	function cambiarSeleccionComponentes(item:FLListViewItem) {
		return this.ctx.articuloscomp_cambiarSeleccionComponentes(item);
	}
	function cambiarSeleccionCompuestos(item:FLListViewItem) {
		return this.ctx.articuloscomp_cambiarSeleccionCompuestos(item);
	}
	function crearArbolComponentes() {
		return this.ctx.articuloscomp_crearArbolComponentes();
	}
	function crearArbolCompuestos() {
		return this.ctx.articuloscomp_crearArbolCompuestos();
	}
	function establecerDatosNodo(nodo:FLListViewItem,datos:Array) {
		return this.ctx.articuloscomp_establecerDatosNodo(nodo,datos);
	}
	function establecerOpcionNodo(nodo:FLListViewItem, datos:Array) {
		return this.ctx.articuloscomp_establecerOpcionNodo(nodo, datos);
	}
// 	function buscarNodos(codigo:String,raiz:FLListViewItem,refPadre:String) {
// 		return this.ctx.articuloscomp_buscarNodos(codigo,raiz,refPadre);
// 	}
// 	function buscarSiguienteNodo(codigo:String,raiz:FLListViewItem,refPadre:String) {
// 		return this.ctx.articuloscomp_buscarSiguienteNodo(codigo,raiz,refPadre);
// 	}
	function calcularDatosNodoComponente(referencia:String, idOpcionArticulo:String):Array {
		return this.ctx.articuloscomp_calcularDatosNodoComponente(referencia, idOpcionArticulo);
	}
	function calcularOpcionesNodoComponente(referencia:String):Array {
		return this.ctx.articuloscomp_calcularOpcionesNodoComponente(referencia);
	}
	function calcularDatosNodoCompuesto(referencia:String):Array {
		return this.ctx.articuloscomp_calcularDatosNodoCompuesto(referencia);
	}
	function refrescarArbol() {
		return this.ctx.articuloscomp_refrescarArbol();
	}
	function borrarArticulo(referencia:String,id:Number):Boolean {
		return this.ctx.articuloscomp_borrarArticulo(referencia,id);
	}
	function refrescarNodos() {
		return this.ctx.articuloscomp_refrescarNodos();
	}
	function siguienteOpcion_clicked() {
		return this.ctx.articuloscomp_siguienteOpcion_clicked();
	}
	function buscarOpcionActual(idTipoOpcionArt:Number):String {
		return this.ctx.articuloscomp_buscarOpcionActual(idTipoOpcionArt);
	}
	function cambiarOpcionActual(idTipoOpcionArt:Number, valor:Number):Boolean {
		return this.ctx.articuloscomp_cambiarOpcionActual(idTipoOpcionArt, valor);
	}
	function expandido(clave:String):Boolean {
		return this.ctx.articuloscomp_expandido(clave);
	}
	function guardarExpansion(nodo:FLListViewItem) {
		return this.ctx.articuloscomp_guardarExpansion(nodo);
	}
	function guardarExpansiones() {
		return this.ctx.articuloscomp_guardarExpansiones();
	}
	function referenciaNodo(nodo:FLListViewItem):String {
		return this.ctx.articuloscomp_referenciaNodo(nodo);
	}
	function imagenComponente(idComp:String, referencia:String):String {
		return this.ctx.articuloscomp_imagenComponente(idComp, referencia);
	}
	function codigoComponente(idComp:String, referencia:String):String {
		return this.ctx.articuloscomp_codigoComponente(idComp, referencia);
	}
	function anadirComponente() {
		return this.ctx.articuloscomp_anadirComponente();
	}
	function establecerColumnas() {
		return this.ctx.articuloscomp_establecerColumnas();
	}
	function esArticuloVariable(referencia:String):Boolean {
		return this.ctx.articuloscomp_esArticuloVariable(referencia);
	}
	function tieneHijosVariables(referencia:string):Boolean {
		return this.ctx.articuloscomp_tieneHijosVariables(referencia);
	}
	function esVariable(referencia:String):Boolean {
		return this.ctx.articuloscomp_esVariable(referencia);
	}
}
//// ARTICULOSCOMP //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration funNumSerie */
//////////////////////////////////////////////////////////////////
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////////
class funNumSerie extends articuloscomp {
	var tblNS:QTable;
	var tbwNS:Object;
	function funNumSerie( context ) { articuloscomp( context ); } 
	function init() { this.ctx.funNumSerie_init(); }
	function bufferChanged(fN:String) { return this.ctx.funNumSerie_bufferChanged(fN); }
	function controlCampos() { this.ctx.funNumSerie_controlCampos(); }
	function guardarNS() { this.ctx.funNumSerie_guardarNS(); }
	function borrarNS() { this.ctx.funNumSerie_borrarNS(); }
}
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration sfamilia */
//////////////////////////////////////////////////////////////////
//// SUBFAMILIA //////////////////////////////////////////////////
class sfamilia extends funNumSerie {
    function sfamilia( context ) { funNumSerie( context ); } 
	function bufferChanged(fN:String){return this.ctx.sfamilia_bufferChanged(fN);}
	function calculateField(fN:String):Number{return this.ctx.sfamilia_calculateField(fN);}
	function validateForm():Boolean {return this.ctx.sfamilia_validateForm();}
}
//// SUBFAMILIA //////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration silixUploadimage */
//////////////////////////////////////////////////////////////////
//// SILIXUPLOADIMAGE ///////////////////////////////////////////
class silixUploadimage extends sfamilia {
    function silixUploadimage( context ) { sfamilia( context ); } 
	function seleccionarImagen() {
		return this.ctx.silixUploadimage_seleccionarImagen();
	}
}
//// SILIXUPLOADIMAGE ///////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration lineasArticulos */
/////////////////////////////////////////////////////////////////
//// LINEAS_ARTICULOS ///////////////////////////////////////////
class lineasArticulos extends silixUploadimage {
	function lineasArticulos( context ) { silixUploadimage ( context ); }
	function init() {
		this.ctx.lineasArticulos_init();
	}
	function verSalida() {
		return this.ctx.lineasArticulos_verSalida();
	}
	function verEntrada() {
		return this.ctx.lineasArticulos_verEntrada();
	}
	function calcularEntradas() {
		return this.ctx.lineasArticulos_calcularEntradas();
	}
	function calcularSalidas() {
		return this.ctx.lineasArticulos_calcularSalidas();
	}
	function imprimirSalidas() {
		return this.ctx.lineasArticulos_imprimirSalidas();
	}
	function imprimirEntradas() {
		return this.ctx.lineasArticulos_imprimirEntradas();
	}
}
//// LINEAS_ARTICULOS ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration fechas */
/////////////////////////////////////////////////////////////////
//// FECHAS /////////////////////////////////////////////////
class fechas extends lineasArticulos {

	var tdbEntradas:FLTableDB;
	var tdbSalidas:FLTableDB;

	var fechaDesdeEntrada:Object;
	var fechaHastaEntrada:Object;
	var fechaDesdeSalida:Object;
	var fechaHastaSalida:Object;

    function fechas( context ) { lineasArticulos ( context ); }
	function init() {
		this.ctx.fechas_init();
	}
	function actualizarFiltroEntradas() {
		return this.ctx.fechas_actualizarFiltroEntradas();
	}
	function actualizarFiltroSalidas() {
		return this.ctx.fechas_actualizarFiltroSalidas();
	}
}
//// FECHAS /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// ORDEN_CAMPOS ///////////////////////////////////////////////
class ordenCampos extends fechas {
    function ordenCampos( context ) { fechas ( context ); }
	function init() {
		this.ctx.ordenCampos_init();
	}
}
//// ORDEN_CAMPOS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration marcacion */
/////////////////////////////////////////////////////////////////
//// MARCACION //////////////////////////////////////////////////
class marcacion extends ordenCampos {
    function marcacion( context ) { ordenCampos ( context ); }
	function init() {
		this.ctx.marcacion_init();
	}
	function bufferChanged(fN:String) {
		return this.ctx.marcacion_bufferChanged(fN);
	}
	function calculateField(fN:String):Number {
		return this.ctx.marcacion_calculateField(fN);
	}
	function recalcularPvp() {
		return this.ctx.marcacion_recalcularPvp();
	}
}
//// MARCACION //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends marcacion {
    function head( context ) { marcacion ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubArticulosComp */
/////////////////////////////////////////////////////////////////
//// PUB ARTICULOS COMP /////////////////////////////////////////
class pubArticulosComp extends head {
    function pubArticulosComp( context ) { head( context ); }
	function pub_buscarOpcionActual(idTipoOpcionArt:Number):String {
		return this.buscarOpcionActual(idTipoOpcionArt);
	}
	function pub_esArticuloVariable(referencia:String):Boolean {
		return this.esArticuloVariable(referencia);
	}
}
//// PUB ARTICULOS COMP /////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends pubArticulosComp {
    function ifaceCtx( context ) { pubArticulosComp( context ); }
	function pub_establecerProveedorDefecto(referencia:String, codProveedor:String):Boolean {
		return this.establecerProveedorDefecto(referencia, codProveedor);
	}
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
/** \C El valor de --stockfis-- se calcula automáticamente para cada artículo como la suma de existencias del artículo en todos los almacenes.
\end */
function interna_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	this.iface.tbnProvDefecto = this.child("tbnProvDefecto");
	
	connect (this.iface.tbnProvDefecto, "clicked()", this, "iface.marcarProvDefecto");
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.child("pbnGenerarArticulosTarifas"), "clicked()", this, "iface.generarArticulosTarifas");
	if (this.child("tdbStocks"))
		connect(this.child("tdbStocks").cursor(), "cursorUpdated()", this, "iface.calcularStockFisico()");

	switch (cursor.modeAccess()) {
		case cursor.Insert: {
			this.iface.establecerDatosAlta();
			break;
		}
		case cursor.Browse: {
			this.child("pbnGenerarArticulosTarifas").enabled = false;
			break;
		}
		case cursor.Edit: {
			if (cursor.valueBuffer("nostock")) {
				this.child("tbwArticulo").setTabEnabled("stocks", false);
			} else {
				this.child("tbwArticulo").setTabEnabled("stocks", true);
			}
			break;
		}
	}
	this.iface.genCodBar("codbarras");
	
	this.iface.bufferChanged("secompra");
	this.iface.bufferChanged("sevende");
	
	if (sys.isLoadedModule("flcontppal")) {
		this.iface.ejercicioActual = flfactppal.iface.pub_ejercicioActual();
		this.iface.longSubcuenta = util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + this.iface.ejercicioActual + "'");
		this.iface.bloqueoSubcuenta = false;
		this.iface.posActualPuntoSubcuenta = -1;
		this.child("fdbIdSubcuentaCom").setFilter("codejercicio = '" + this.iface.ejercicioActual + "'");
	} else
		this.child("tbwArticulo").setTabEnabled("contabilidad", false);
}

function interna_calculateField(nombreCampo:String):String
{
	var util:FLUtil = new FLUtil();
	/** \D El valor de --stockfis-- se calcula sumando todas las cantidades de esa referencia en la tabla stocks, esto es, las cantidades de todos los almacenes
	\end */
	if (nombreCampo == "stockfis")
		return util.sqlSelect("stocks", "SUM(cantidad)",  "referencia='" + this.cursor().valueBuffer("referencia") + "';");
}

function interna_validateForm():Boolean 
{
	return true;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Genera las líneas de tarifas para un determinado artículo mediante el pvp base y los incrementos de cada tarifa. Cada línea contiene la referencia del artículo, el código de tarifa y el precio calculado para la tarifa.
\end */
function oficial_generarArticulosTarifas()
{
		var cursor:FLSqlCursor = this.cursor();
		var referencia:String = cursor.valueBuffer("referencia");
		var pvp:Number = cursor.valueBuffer("pvp");
		var codTarifa:String;
		var incLineal:Number;
		var incPorcentual:Number;
		var pvpTarifa:Number;

		var curArtTar:FLSqlCursor = this.child("tdbArticulosTarifas").cursor()
		var qryTarifas:FLSqlQuery = new FLSqlQuery();

/** \D Los incrementos lineal y porcentual de la tarifa sobre el precio base pueden acumularse
Las tarifas del artículo son eliminadas y regeneradas después
\end */
		qryTarifas.setTablesList("tarifas");
		qryTarifas.setSelect("codtarifa,inclineal,incporcentual");
		qryTarifas.setFrom("tarifas");
		
		qryTarifas.exec();
		while (qryTarifas.next()) {
			codTarifa = qryTarifas.value(0);
			with(curArtTar) {
				select("referencia = '" + referencia + "' AND codtarifa = '" + codTarifa + "'");
				if (first()) {
					setModeAccess(Del);
					refreshBuffer();
					commitBuffer();
				} 
			}
		}
		
		qryTarifas.exec();
		while (qryTarifas.next()) {
			codTarifa = qryTarifas.value(0);
			incLineal = parseFloat(qryTarifas.value(1));
			incPorcentual = parseFloat(qryTarifas.value(2));
			pvpTarifa = ((pvp * (100 + incPorcentual)) / 100) + incLineal;
			with(curArtTar) {
				setModeAccess(Insert);
				refreshBuffer();
				setValueBuffer("referencia", referencia);
				setValueBuffer("codtarifa", codTarifa);
				setValueBuffer("pvp", pvpTarifa);
				commitBuffer();
			}
		}
		
		this.child("tdbArticulosTarifas").refresh();
}

/** \D Informa el campo --stockfis--
\end */
function oficial_calcularStockFisico()
{
		this.child("fdbStockFisico").setValue(this.iface.calculateField("stockfis"));
}

function oficial_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	
	switch (fN) {
		case "tipocodbarras":
		case "codbarras": {
			this.iface.genCodBar(fN)
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
		case "nostock": {
			if (cursor.valueBuffer("nostock")) {
				if (this.iface.eliminarStock()) {
					this.child("tbwArticulo").setTabEnabled("stocks", false);
					this.child("tbwArticulo").setTabEnabled("lotes", false);
					this.child("tbwArticulo").setTabEnabled("series", false);
				} else {
					this.child("fdbNoStock").setValue(false);
				}
			} else {
				this.child("tbwArticulo").setTabEnabled("stocks", true);
				this.child("tbwArticulo").setTabEnabled("lotes", true);
				this.child("tbwArticulo").setTabEnabled("series", true);
			}
			break;
		}
		case "secompra": {
			if(!cursor.valueBuffer("secompra"))
				this.child("tbwArticulo").setTabEnabled("compra", false);
			else
				this.child("tbwArticulo").setTabEnabled("compra", true);
			break;
		}
		case "sevende": {
			if(!cursor.valueBuffer("sevende"))
				this.child("tbwArticulo").setTabEnabled("venta", false);
			else
				this.child("tbwArticulo").setTabEnabled("venta", true);
			break;
		}
	}
}

function oficial_genCodBar(fN:String)
{
	if (fN == "tipocodbarras" || fN == "codbarras") {
		var cursor:FLSqlCursor = this.cursor();
		var type:String = cursor.valueBuffer("tipocodbarras");
		var value:String = cursor.valueBuffer("codbarras");

		var auxCodBar:FLCodBar = new FLCodBar(0);
		var codBar:FLCodBar = new FLCodBar(value, auxCodBar.nameToType(type), 10, 1, 0, 0, true);
		var pixmap:Object = codBar.pixmap();
		if (codBar.validBarcode())
			this.child("pixmapCodBar").setPixmap(pixmap);
		else
			this.child("pixmapCodBar").setPixmap(codBar.pixmapError());
	}
}

function oficial_eliminarStock():Boolean
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	
	var referencia:String = cursor.valueBuffer("referencia");
	if (util.sqlSelect("stocks", "idstock", "referencia = '" + referencia + "'")) {
		var res:Number = MessageBox.warning(util.translate("scripts", "Existen valores de stock para este artículo.\nSi lo que desea hacer es indicar que se permiten ventas sin stock de este material, pulse Cancelar e indíquelo en la pestaña de Stocks.\nSi quiere eliminar completamente los datos de stock asociados a este artículo pulse Aceptar. Esta acción no es reversible."), MessageBox.Cancel, MessageBox.Ok);
		if (res != MessageBox.Ok) {
			return false;
		}
	}
	var curTrans:FLSqlCursor = new FLSqlCursor("stocks");
	curTrans.transaction(false);
	try {
		if (this.iface.borrarDatosStock(referencia)) {
			curTrans.commit();
		} else {
			curTrans.rollback();
			return false;
		}
	}
	catch (e) {
		curTrans.rollback();
		MessageBox.critical(util.translate("scripts", "Error al eliminar los datos de stock para el artículo %1").arg(referencia), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	return true;
}

function oficial_borrarDatosStock(referencia:String):Boolean
{
	var util:FLUtil = new FLUtil;
	if (!util.sqlDelete("stocks", "referencia = '" + referencia + "'")) {
		return false;
	}
	
	return true;
}

function oficial_marcarProvDefecto()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var curProv:FLSqlCursor = this.child("tdbArticulosProv").cursor();
	if (!curProv.valueBuffer("id"))
		return;

	var referencia:String = cursor.valueBuffer("referencia");
	var codProveedor:String = curProv.valueBuffer("codproveedor");
	if (!this.iface.establecerProveedorDefecto(referencia, codProveedor)) {
		return;
	}
	this.child("tdbArticulosProv").refresh();
}

function oficial_establecerProveedorDefecto(referencia:String, codProveedor:String):Boolean
{
	var util:FLUtil = new FLUtil;
	if (!util.sqlUpdate("articulosprov", "pordefecto", false, "referencia = '" + referencia + "'")) {
		return false;
	}

	if (!util.sqlUpdate("articulosprov", "pordefecto", true, "referencia = '" + referencia + "' AND codproveedor = '" + codProveedor + "'")) {
		return false;
	}

	return true;
}

function oficial_establecerDatosAlta()
{
debug("oficial_establecerDatosAlta " + flfactalma.iface.pub_valorDefectoAlmacen("codimpuesto"));
	this.child("fdbImpuesto").setValue(flfactalma.iface.pub_valorDefectoAlmacen("codimpuesto"));
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition fluxEcommerce */
/////////////////////////////////////////////////////////////////
//// FLUX ECOMMERCE //////////////////////////////////////////////////////
function fluxEcommerce_init()
{
	this.iface.__init();
	connect(this.child("pbnImagen"), "clicked()", this, "iface.seleccionarImagen");
	connect(this.child("pbnEditarAtributos"), "clicked()", this, "iface.editarAtributos");
	connect(this.child("pbnTradDescripcion"), "clicked()", this, "iface.traducirDescripcion");
	connect(this.child("pbnTradDescPublica"), "clicked()", this, "iface.traducirDescPublica");

	this.iface.actualizarControlesOferta();

	this.child("fdbDescPublica").setTextFormat(0);
}

function fluxEcommerce_validateForm():Boolean
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();

	if (cursor.valueBuffer("enoferta") && parseFloat(cursor.valueBuffer("pvpoferta")) > parseFloat(cursor.valueBuffer("pvp"))) {
		MessageBox.critical(util.translate("scripts","El precio de oferta no puede ser mayor que el precio normal"),
				MessageBox.Ok, MessageBox.NoButton,MessageBox.NoButton);
		return false;
	}

	if (cursor.valueBuffer("enoferta") && parseFloat(cursor.valueBuffer("pvpoferta")) == 0) {
		MessageBox.critical(util.translate("scripts","Debe indicar un precio de oferta"),
				MessageBox.Ok, MessageBox.NoButton,MessageBox.NoButton);
		return false;
	}

	return true;
}

function fluxEcommerce_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	
	switch (fN) {
		case "pvp":
		case "codtarifa":
			this.iface.actualizarPvpOferta();
		break;
		case "enoferta":
			this.iface.actualizarControlesOferta();
		break;
		default:
			return this.iface.__bufferChanged(fN);
	}
}

function fluxEcommerce_seleccionarImagen()
{
	var util:FLUtil = new FLUtil();
	
	if (util.sqlSelect("opcionestv", "arquitectura", "1=1") != "Unificada") {
		MessageBox.warning(util.translate("scripts", "Sólo es posible la copia de imágenes para arquitectura unificada"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	
	var rutaDestino:String = util.sqlSelect("opcionestv", "rutaweb", "1 = 1");
	
	if (!File.exists(rutaDestino)) {
		MessageBox.warning(util.translate("scripts", "No se ha establecido la ruta a la web en las opciones generales,\no la ruta no es válida"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
		
	if (rutaDestino.right(1) != "\\" && rutaDestino.right(1) != "/")
		rutaDestino += "/";
	
	var cursor:FLSqlCursor = this.cursor();
	var archivo:String = FileDialog.getOpenFileName("*.jpg;*.png;*.gif", util.translate("scripts","Elegir Fichero"));
			
	if (!archivo)
		return;
		
	var file = new File( archivo );
	var extension:String = file.extension;
	if (extension.length > 3)
		extension = extension.right(3);

	// Abrir el fichero	de lectura
	try {
		file.open( File.ReadOnly );
	}
	catch (e) {
		MessageBox.warning(util.translate("scripts", "Se produjo el error siguiente al tratar de abrir el fichero de imagen:\n") + e, MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	
	rutaDestino += "catalogo/img_normal/" + cursor.valueBuffer("referencia") + "." + extension;

	var outfile = new File(rutaDestino);

	// Abrir el fichero	de escritura y copiar el contenido original
	try {
		outfile.open(File.WriteOnly);
		while (!file.eof)
			outfile.writeByte( file.readByte() );
	}
	catch (e) {
		MessageBox.warning(util.translate("scripts", "Se produjo el error siguiente al tratar de copiar el fichero de imagen:\n") + e, MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	
	file.close();
	outfile.close();

	if (File.exists(rutaDestino)) {
		cursor.setValueBuffer("fechaimagen", 0);
		cursor.setValueBuffer("tipoimagen", extension);
		MessageBox.information(util.translate("scripts", "Se copió correctamente la imagen en la página web"), MessageBox.Ok, MessageBox.NoButton);
	}
	else {
		MessageBox.warning(util.translate("scripts", "No se pudo copiar la imagen en la página web"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}


	return true;	
}


/** \D Abre un diálogo para la edición rápida de atributos
\end */
function fluxEcommerce_editarAtributos()
{
	var util:FLUtil = new FLUtil();
	var referencia:String = this.cursor().valueBuffer("referencia");
	var codFamilia:String = this.cursor().valueBuffer("codfamilia");
	var codAtr:Array = [];

	var q:FLSqlQuery = new FLSqlQuery();

	// Si no hay familia buscamos atributos que no pertenecen a un grupo
	if (!codFamilia) {
		q.setTablesList("atributos");
		q.setFrom("atributos");	
		q.setSelect("codatributo,nombre");
		q.setWhere("codgrupo = ''");
	}
	else {
		q.setTablesList("atributos,gruposatributos,familias");
		q.setFrom("atributos INNER JOIN gruposatributos " +
					" ON atributos.codgrupo = gruposatributos.codgrupo" + 
					" INNER JOIN familias " +
					" ON gruposatributos.codgrupo = familias.codgrupoatr");
	
		q.setSelect("atributos.codatributo,atributos.nombre");
		q.setWhere("familias.codfamilia = '" + codFamilia + "'");
	}

	if (!q.exec()) return false;
	
	var dialog = new Dialog(util.translate ( "scripts", "Atributos" ), 0);
	dialog.caption = "Edición de atributos";
	dialog.OKButtonText = util.translate ( "scripts", "Aceptar" );
	dialog.cancelButtonText = util.translate ( "scripts", "Cancelar" );
	dialog.width = 500;
	
	var bgroup:GroupBox = new GroupBox;
	dialog.add( bgroup );
	var cB:Array = [];
	var nAtr:Number = 0;	
	
	while (q.next())  {

		valor = util.sqlSelect("atributosart", "valor", "referencia = '" + referencia + "' AND codatributo = '" + q.value(0)+ "'");
		if (!valor)
			valor = "";

		cB[nAtr] = new LineEdit;
		cB[nAtr].label = q.value(1);
		cB[nAtr].text = valor;
		codAtr[nAtr] = q.value(0);
		bgroup.add( cB[nAtr] );
		nAtr ++;
	}
	if (nAtr > 0) {
		nAtr --;

		if(dialog.exec()) {

			var curTab:FLSqlCursor = this.child("tdbAtributosArt").cursor();

			for (var i:Number = 0; i <= nAtr; i++) {

				debug(cB[i].text);

				if (!cB[i].text)
					continue;

				curTab.select("referencia = '" + referencia + "' AND codatributo = '" + codAtr[i] + "'");

				if (curTab.first()) {
					curTab.setModeAccess(curTab.Edit);
					curTab.refreshBuffer();
				}
				else {
					curTab.setModeAccess(curTab.Insert);
					curTab.refreshBuffer();
					curTab.setValueBuffer("referencia", referencia);
					curTab.setValueBuffer("codatributo", codAtr[i]);
				}

				curTab.setValueBuffer("valor", cB[i].text);
				curTab.commitBuffer();
			}

			this.child("tdbAtributosArt").refresh();

		}
		else
			return;
	}
	// NO se encuentran atributos
	else {
		MessageBox.warning(util.translate("scripts", "No se encontraron atributos asociados a la familia de este artículo\nAsegúrese de que la familia tiene un grupo de atributos asociados"), MessageBox.Ok, MessageBox.NoButton);
		return;
	}
}


function fluxEcommerce_actualizarPvpOferta()
{
	var util:FLUtil = new FLUtil();

	var pvp:Number = parseFloat(this.cursor().valueBuffer("pvp"));
	var codTarifa:Number = this.cursor().valueBuffer("codtarifa");

	debug(pvp);

	var dTar:Array = flfactppal.iface.pub_ejecutarQry("tarifas", "inclineal,incporcentual", "codtarifa = '" + codTarifa + "'");

	if (dTar.result != 1)
		return;

	debug(dTar.inclineal);

	pvp = parseFloat((pvp * (100 + parseFloat(dTar.incporcentual)) / 100) + parseFloat(dTar.inclineal));
	debug(pvp);
	this.cursor().setValueBuffer("pvpoferta", pvp);
}

function fluxEcommerce_actualizarControlesOferta()
{
	var util:FLUtil = new FLUtil();

	if (this.cursor().valueBuffer("enoferta")) {
		this.child("gbxOferta").setDisabled(false);
	}
	else {
		this.child("gbxOferta").setDisabled(true);
	}
}

function fluxEcommerce_traducirDescripcion()
{
	return flfactppal.iface.pub_traducir("articulos", "descripcion", this.cursor().valueBuffer("referencia"));
}

function fluxEcommerce_traducirDescPublica()
{
	return flfactppal.iface.pub_traducir("articulos", "descpublica", this.cursor().valueBuffer("referencia"));
}

//// FLUX ECOMMERCE //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition traducciones */
/////////////////////////////////////////////////////////////////
//// TRADUCCIONES //////////////////////////////////////////////
function traducciones_init()
{
	this.iface.__init();
	connect(this.child("pbnTradDescripcion"), "clicked()", this, "iface.traducirDescripcion");
}

function traducciones_traducirDescripcion()
{
	return flfactppal.iface.pub_traducir("articulos", "descripcion", this.cursor().valueBuffer("referencia"));
}

//// TRADUCCIONES //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
/** \C
Si el artículo no tiene gestión de lotes, el campo --diasconsumo-- y la tabla de lotes activos estarán inhabilitados

En la tabla de lotes se mostrarán los lotes activos, es decir, los que tengan su campo 'En almacén' distinto de cero o su fecha de caducidad no esté cumplida
*/
function lotes_init()
{
	this.iface.__init();
	
	if (this.cursor().modeAccess() == this.cursor().Edit ) {
		if (this.cursor().valueBuffer("nostock")) {
			this.child("tbwArticulo").setTabEnabled("lotes", false);
		} else {
			this.child("tbwArticulo").setTabEnabled("lotes", true);
		}
	}

	this.child("tdbLotes").setReadOnly(true);
	
	this.child("tdbLotes").cursor().setMainFilter("(enalmacen > 0 OR caducidad > CURRENT_DATE) AND referencia = '" + this.cursor().valueBuffer("referencia") + "'");
	this.child("tdbLotes").refresh();
	if(this.cursor().valueBuffer("porlotes") == false){
		this.child("fdbDiasConsumo").setDisabled(true);
		this.child("tdbLotes").setDisabled(true);
	}
	this.iface.bufferChanged("porlotes");
}

/** \C
Si se modifica el indicador --porlotes--, los controles asociados se habilitan o inhabilitan de acuerdo con el indicador 
*/
function lotes_bufferChanged(fN:String)
{		
	switch(fN) {
		case "porlotes" : {
			if(this.cursor().valueBuffer("porlotes") == false){
				this.child("fdbDiasConsumo").setDisabled(true);
				this.child("tdbLotes").setDisabled(true);
			}
			else {
				this.child("fdbDiasConsumo").setDisabled(false);
				this.child("tdbLotes").setDisabled(false);
			}
			break;
		}
		default : return this.iface.__bufferChanged(fN);
	}
}

//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ivaIncluido */
//////////////////////////////////////////////////////////////////
//// IVAINCLUIDO /////////////////////////////////////////////////////
	
function ivaIncluido_validateForm():Boolean
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();

	if(!this.iface.__validateForm())
		return false;

	if (cursor.valueBuffer("ivaincluido") && !cursor.valueBuffer("codimpuesto")) {
		MessageBox.critical(util.translate("scripts","Si el IVA del artículo está incluído se debe especificar el tipo de IVA"),
				MessageBox.Ok, MessageBox.NoButton,MessageBox.NoButton);
		return false;
	}

	return true;
}

function ivaIncluido_establecerDatosAlta()
{
	this.iface.__establecerDatosAlta();
	this.child("fdbIvaIncluido").setValue(flfactalma.iface.pub_valorDefectoAlmacen("ivaincluido"));
}
//// IVAINCLUIDO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition articuloscomp */
/////////////////////////////////////////////////////////////////
//// ARTICULOSCOMP //////////////////////////////////////////////
function articuloscomp_init() 
{
	this.iface.__init();
	
	var util:FLUtil;

	this.iface.establecerColumnas();
	this.iface.opcionesActuales = [];
	this.iface.expansiones = [];
	this.iface.idTipoOpcionArt_ = false;
	this.iface.lvwCompuestos = this.child("lvwCompuestos");
	this.iface.lvwComponentes = this.child("lvwComponentes");
	this.iface.refrescarArbol();

	
	//this.iface.arrayNodos = new Array();
	//this.iface.indice = 0;

	connect(this.child("pbnCalcularPvpComponentes"), "clicked()", this, "iface.calcularPvp()");
	connect (this.iface.lvwComponentes, "doubleClicked(FLListViewItemInterface)", this, "iface.editArticuloComp()");
	connect (this.iface.lvwComponentes, "selectionChanged(FLListViewItemInterface)", this, "iface.cambiarSeleccionComponentes()");
	connect (this.child("toolButtonZoomComponente"), "clicked()", this, "iface.browseArticuloComp()");
	connect (this.child("toolButtonEditComponente"), "clicked()", this, "iface.editArticuloComp()");
	connect (this.child("tbnAsociarComponente"), "clicked()", this, "iface.insertArticuloComp()");
	connect (this.child("tbnQuitarComponente"), "clicked()", this, "iface.deleteArticuloComp()");
	connect (this.iface.lvwCompuestos, "doubleClicked(FLListViewItemInterface)", this, "iface.browseArticuloCompuestos()");
	connect (this.iface.lvwCompuestos, "selectionChanged(FLListViewItemInterface)", this, "iface.cambiarSeleccionCompuestos()");
	connect (this.child("toolButtonZoomCompuesto"), "clicked()", this, "iface.browseArticuloCompuestos()");
	connect (this.child("tbnSiguienteOpcion"), "clicked()", this, "iface.siguienteOpcion_clicked()");

	if (this.cursor().action() == "articuloscomponente") {
		this.child("toolButtonEditArticulo").close();
		this.child("toolButtonDeleteArticulo").close();
		this.child("toolButtonZoomArticulo").close();
		this.child("toolButtonZoomComponente").close();
		this.child("tbnAsociarComponente").close();
		this.child("tbnQuitarComponente").close();
		disconnect (this.iface.lvwCompuestos, "doubleClicked(FLListViewItemInterface)", this, "iface.browseArticuloCompuestos()");
		this.child("toolButtonZoomCompuesto").close();
		if (this.cursor().modeAccess == this.cursor().Browse) {
			disconnect (this.iface.lvwComponentes, "doubleClicked(FLListViewItemInterface)", this, "iface.editArticuloComp()");
			this.child("toolButtonEditComponente").close();
		}
	}

	if (this.iface.curComponente_)
		delete this.iface.curComponente_;
	this.iface.curComponente_ = new FLSqlCursor("articulos");
	this.iface.curComponente_.setAction("articuloscomponente");

	connect (this.child("toolButtonEditArticulo"), "clicked()", this, "iface.editArticulo()");
	connect (this.iface.curComponente_, "bufferCommited()", this, "iface.refrescarArbol()");
	connect (this.child("toolButtonDeleteArticulo"), "clicked()", this, "iface.deleteArticulo()");
	connect (this.child("toolButtonZoomArticulo"), "clicked()", this, "iface.browseArticulo()");

	this.iface.curArticulosComp_ = new FLSqlCursor("articuloscomp");
	connect(this.iface.curArticulosComp_, "bufferCommited()", this, "iface.refrescarNodos");
}

function articuloscomp_refrescarArbol()
{
	this.iface.crearArbolComponentes();
	this.iface.crearArbolCompuestos();
}

function articuloscomp_crearArbolComponentes()
{
	var util:FLUtil;
	
	this.iface.lvwComponentes.setColumnText(0, util.translate("scripts", "Referencia"));
	this.iface.lvwComponentes.addColumn(util.translate("scripts", "Descripcion"));
	this.iface.lvwComponentes.addColumn(util.translate("scripts", "Cantidad"));
	this.iface.lvwComponentes.addColumn(util.translate("scripts", "Unidad"));
	
	var referencia:String = this.child("fdbReferencia").value();

	this.iface.lvwComponentes.clear();
	var raiz = new FLListViewItem(this.iface.lvwComponentes);
	var datosNodo:Array = new Array();
	datosNodo["cantidad"] = "";
	datosNodo["descripcion"] = this.child("fdbDescripcion").value();
	datosNodo["codigo"] = referencia;
	datosNodo["unidad"] = this.child("fdbCodUnidad").value();
	datosNodo["id"] = 0;
	datosNodo["tipo"] = "componente";
	datosNodo["imagen"] = util.sqlSelect("familias","imagen","codfamilia = '" + this.child("fdbCodFamilia").value() + "'");
	this.iface.establecerDatosNodo(raiz,datosNodo);
	raiz.setExpandable(false);
	this.iface.componenteSeleccionado = raiz;
	this.iface.raizComponente = raiz;
	this.iface.pintarNodo(raiz,"componente");
	raiz.setOpen(true);
}

function articuloscomp_anadirComponente()
{
	var util:FLUtil;
	
	var referencia:String = this.child("fdbReferencia").value();

	this.iface.lvwComponentes.clear();
	var raiz = new FLListViewItem(this.iface.lvwComponentes);
	var datosNodo:Array = new Array();
	datosNodo["cantidad"] = "";
	datosNodo["descripcion"] = this.child("fdbDescripcion").value();
	datosNodo["codigo"] = referencia;
	datosNodo["unidad"] = this.child("fdbCodUnidad").value();
	datosNodo["id"] = 0;
	datosNodo["tipo"] = "componente";
	datosNodo["imagen"] = util.sqlSelect("familias","imagen","codfamilia = '" + this.child("fdbCodFamilia").value() + "'");
	this.iface.establecerDatosNodo(raiz,datosNodo);
	raiz.setExpandable(false);
	this.iface.componenteSeleccionado = raiz;
	this.iface.raizComponente = raiz;
	this.iface.pintarNodo(raiz,"componente");
	raiz.setOpen(true);
}

function articuloscomp_crearArbolCompuestos()
{
	var util:FLUtil;
	
	this.iface.lvwCompuestos.setColumnText(0, util.translate("scripts", "Referencia"));
	this.iface.lvwCompuestos.addColumn(util.translate("scripts", "Descripcion"));
	this.iface.lvwCompuestos.addColumn(util.translate("scripts", "Cantidad"));
	this.iface.lvwCompuestos.addColumn(util.translate("scripts", "Unidad"));
	
	var referencia:String = this.child("fdbReferencia").value();

	this.iface.lvwCompuestos.clear();
	var raiz = new FLListViewItem(this.iface.lvwCompuestos);
	var datosNodo:Array = new Array;
	datosNodo["cantidad"] = "";
	datosNodo["descripcion"] = this.child("fdbDescripcion").value();
	datosNodo["codigo"] = referencia;
	datosNodo["unidad"] = this.child("fdbCodUnidad").value();
	datosNodo["id"] = 0;
	datosNodo["tipo"] = "compuesto";
	datosNodo["imagen"] = util.sqlSelect("familias","imagen","codfamilia = '" + this.child("fdbCodFamilia").value() + "'");
	this.iface.establecerDatosNodo(raiz,datosNodo);
	raiz.setExpandable(false);
	this.iface.compuestoSeleccionado = raiz;
	this.iface.raizCompuesto = raiz;
	this.iface.pintarNodo(raiz,"compuesto");
	raiz.setOpen(true);
}

function articuloscomp_pintarNodo(nodo:FLListViewItem, tipoNodo:String)
{
	var util:FLUtil;
	var referencia:String = "";
	var opcionesNodo:Array = new Array();

	if (!nodo) {
		if (tipoNodo == "componente")
			nodo = this.iface.raizComponente;
		if (tipoNodo == "compuesto")
			nodo = this.iface.raizCompuesto;
	}

	referencia = nodo.text(0);
	if (!nodo || !referencia || referencia == "")
		return;

	if (!this.iface.pintarNodosHijo(nodo, tipoNodo))
		return false;

	if (tipoNodo == "componente") {
		var opcionesNodo = this.iface.calcularOpcionesNodoComponente(referencia);
		if (!opcionesNodo)
			return false;
	
		var idOpcionDefecto:String;
		var idTipoOpcion:String;
		var primerHijo:Boolean = false;
		for (var i = 0; i < opcionesNodo.length; i++) {
			if (!primerHijo){
				nodo.setExpandable(true);
				if (this.iface.expandido(nodo.key()))
					nodo.setOpen(true);
				primerHijo = true;
			}
			var nodoHijo = new FLListViewItem(nodo);
			this.iface.establecerOpcionNodo(nodoHijo, opcionesNodo[i]);
			nodoHijo.setExpandable(false);
				
			idTipoOpcion = opcionesNodo[i]["id"];
			idOpcionDefecto = this.iface.buscarOpcionActual(idTipoOpcion);
			if (idOpcionDefecto) {
				if (!this.iface.pintarNodosHijo(nodoHijo, "componente", idOpcionDefecto))
					return false;
			}
		}
	}
	return true;
}

function articuloscomp_pintarNodosHijo(nodo:FLListViewItem, tipoNodo:String, idOpcion:String):Boolean
{
	var util:FLUtil = new FLUtil;
	var datosNodo:Array = new Array();
	var referencia:String = this.iface.referenciaNodo(nodo);

	if (!nodo || !referencia || referencia == "")
		return;
	if (tipoNodo == "componente") 
		datosNodo = this.iface.calcularDatosNodoComponente(referencia, idOpcion);

	if (tipoNodo == "compuesto")
		datosNodo = this.iface.calcularDatosNodoCompuesto(referencia);

	if (!datosNodo)
		return false;

	nodo.setExpandable(false);

	var primerHijo:Boolean = false;
	for (var i = 0; i < datosNodo.length; i++) {
		if (!primerHijo) {
			nodo.setExpandable(true);
			if (this.iface.expandido(nodo.key()))
				nodo.setOpen(true);
			
			primerHijo = true;
		}
		var nodoHijo = new FLListViewItem(nodo);
		this.iface.establecerDatosNodo(nodoHijo,datosNodo[i]);
		nodoHijo.setExpandable(false);
		this.iface.pintarNodo(nodoHijo,tipoNodo);
	}
	return true;
}

/** \C la referencia del artículo asociado a un nodo se obtiene:
Si el nodo corresponde a una composición normal, de la primera columna de texto del nodo
Si el nodo corresponde a un tipo de opción (el id será TO_ + id del tipo de opción), de la tabla de tipos de opción por artículo
@param	Nodo: Nodo cuya referencia queremos conocer.
@return	Referencia
\end */
function articuloscomp_referenciaNodo(nodo:FLListViewItem):String
{
	var util:FLUtil = new FLUtil;

	var clave:String = nodo.key();
	if (clave.startsWith("TO_")) {
		this.iface.idTipoOpcionArt_ = clave.right(clave.length - 3);
		referencia = util.sqlSelect("tiposopcionartcomp", "referencia", "idtipoopcionart = " + this.iface.idTipoOpcionArt_);
	} else {
		this.iface.idTipoOpcionArt_ = false;
		referencia = nodo.text(0);
	}
	return referencia;
}

function articuloscomp_buscarNodo(clave:String, padre)
{
	if (!padre)
		padre = this.iface.raizComponente;

	var nodoAux;
	var nodoHijo;
	for (nodoAux = padre.firstChild(); nodoAux; nodoAux = nodoAux.nextSibling()) {
		if (nodoAux.key() == clave)
			return nodoAux;
		if (nodoAux.isExpandable()) {
			nodoHijo = this.iface.buscarNodo(clave, nodoAux);
			if (nodoHijo)
				return nodoHijo;
		}
	}
	return false;
}

function articuloscomp_calcularDatosNodoComponente(referencia:String, idOpcionArticulo:String):Array
{
	var util:FLUtil;
	var datosNodo = new Array;

	var masWhere:String = " AND (idopcionarticulo IS NULL OR idopcionarticulo = 0)";
	if (idOpcionArticulo && idOpcionArticulo != "")
		masWhere = " AND idopcionarticulo = " + idOpcionArticulo;

	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("articuloscomp");
	q.setSelect("id,refcomponente,desccomponente,cantidad,codunidad");
	q.setFrom("articuloscomp");
	q.setWhere("refcompuesto = '" + referencia + "'" + masWhere);
	q.setForwardOnly(true);
	
debug(q.sql());
	if (!q.exec())
		return false;
	
	var i:Number = 0;
	while (q.next()) {
		datosNodo[i] = new Array;
		datosNodo[i]["id"] = q.value("id");
		datosNodo[i]["tipo"] = "componente";
		datosNodo[i]["codigo"] = this.iface.codigoComponente(q.value("id"), q.value("refcomponente"));
		datosNodo[i]["descripcion"] = q.value("desccomponente");
		datosNodo[i]["cantidad"] = q.value("cantidad");
		datosNodo[i]["unidad"] = q.value("codunidad");
		datosNodo[i]["imagen"] = this.iface.imagenComponente(q.value("id"), q.value("refcomponente"));
		i += 1;
	}
	return datosNodo;
}

/** \D Función a sobrecargar
\end */
function articuloscomp_codigoComponente(idComp:String, referencia:String):String
{
	var codigo = referencia;
	return codigo;
}

function articuloscomp_imagenComponente(idComp:String, referencia:String):String
{
	var util:FLUtil;
	var imagen:String = util.sqlSelect("articulos INNER JOIN familias ON articulos.codfamilia = familias.codfamilia", "familias.imagen", "articulos.referencia = '" + referencia + "'", "articulos,familias");
	return imagen;
}

function articuloscomp_calcularOpcionesNodoComponente(referencia:String):Array
{
	var util:FLUtil;
	var datosNodo = new Array;


	var qryOpciones:FLSqlQuery = new FLSqlQuery();
	qryOpciones.setTablesList("tiposopcionartcomp");
	qryOpciones.setSelect("idtipoopcionart, idtipoopcion, tipo");
	qryOpciones.setFrom("tiposopcionartcomp");
	qryOpciones.setWhere("referencia = '" + referencia + "'");
	qryOpciones.setForwardOnly(true);

	if (!qryOpciones.exec())
		return false;
	
	var i:Number = 0;
	while (qryOpciones.next()) {
		datosNodo[i] = new Array;
		datosNodo[i]["id"] = qryOpciones.value("idtipoopcionart");
		datosNodo[i]["tipo"] = "componente";
		datosNodo[i]["codigo"] = "Opción";
		datosNodo[i]["descripcion"] = qryOpciones.value("tipo");
		datosNodo[i]["cantidad"] = false;
		datosNodo[i]["unidad"] = false;
		datosNodo[i]["imagen"] = false;
		i += 1;
	}
	
	return datosNodo;
}

function articuloscomp_calcularDatosNodoCompuesto(referencia:String):Array
{
	var util:FLUtil;
	datosNodo = new Array;

	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("articuloscomp,articulos");
	q.setSelect("articuloscomp.id, articuloscomp.refcompuesto, articulos.descripcion, articuloscomp.cantidad, articuloscomp.codunidad");
	q.setFrom("articuloscomp INNER JOIN articulos ON articuloscomp.refcompuesto = articulos.referencia");
	q.setWhere("articuloscomp.refcomponente = '" + referencia + "'");
	
	if (!q.exec())
		return false;
	
	var i:Number = 0;
	while (q.next()) {
		datosNodo[i] = new Array;
		datosNodo[i]["id"] = q.value("articuloscomp.id");
		datosNodo[i]["tipo"] = "compuesto";
		datosNodo[i]["codigo"] = q.value("articuloscomp.refcompuesto");
		datosNodo[i]["descripcion"] = q.value("articulos.descripcion");
		datosNodo[i]["cantidad"] = q.value("articuloscomp.cantidad");
		datosNodo[i]["unidad"] = q.value("articuloscomp.codunidad");
		datosNodo[i]["imagen"] = util.sqlSelect("articulos INNER JOIN familias ON articulos.codfamilia = familias.codfamilia","familias.imagen","articulos.referencia = '" + q.value("articuloscomp.refcompuesto") + "'","articulos,familias");
		i += 1;
	}
	
	return datosNodo;
}


function articuloscomp_establecerDatosNodo(nodo:FLListViewItem, datos:Array)
{
	var util:FLUtil;
	if (datos["codigo"] && datos["codigo"] != "") {
		nodo.setText(this.iface.COL_REFERENCIA, datos["codigo"]);
		nodo.setPixmap(this.iface.COL_REFERENCIA, datos["imagen"]);
	}

	if(datos["descripcion"] && datos["descripcion"] != "")
		nodo.setText(this.iface.COL_DESCRIPCION, datos["descripcion"]);
	
	if(datos["cantidad"] && datos["cantidad"] != "")
		nodo.setText(this.iface.COL_CANTIDAD, datos["cantidad"]);
	
	if(datos["unidad"] && datos["unidad"] != "")
		nodo.setText(this.iface.COL_UNIDAD, datos["unidad"]);
	
	if(datos["id"] && datos["id"] != "")
		nodo.setKey(datos["id"]);
}

function articuloscomp_establecerOpcionNodo(nodo:FLListViewItem, datos:Array)
{
	var util:FLUtil;
	if (datos["codigo"] && datos["codigo"] != "") {
		nodo.setText(this.iface.COL_REFERENCIA, datos["codigo"]);
		nodo.setPixmap(this.iface.COL_REFERENCIA, datos["imagen"]);
	}
	var opcionActual:String = "";
	var idOpcionActual:Number = this.iface.buscarOpcionActual(datos["id"]);
	if (idOpcionActual) {
		opcionActual = util.sqlSelect("opcionesarticulocomp", "opcion", "idopcionarticulo= " + idOpcionActual);
		if (opcionActual) {
			opcionActual = " = " + opcionActual;
		} else {
			opcionActual = "";
		}
	}

	if (datos["descripcion"] && datos["descripcion"] != "")
		nodo.setText(this.iface.COL_DESCRIPCION, datos["descripcion"] + opcionActual);
	
	if (datos["id"] && datos["id"] != "")
		nodo.setKey("TO_" + datos["id"]);
}

function articuloscomp_buscarOpcionActual(idTipoOpcionArt:Number):String
{
	var util:FLUtil = new FLUtil;
	var valor:String;
	var tamano:Number= this.iface.opcionesActuales.length;
	for (var i:Number = 0; i < tamano; i++) {
		if (this.iface.opcionesActuales[i]["tipo"] == idTipoOpcionArt)
			return this.iface.opcionesActuales[i]["valor"];
	}

	idOpcionDefecto = util.sqlSelect("opcionesarticulocomp", "idopcionarticulo", "idtipoopcionart = " + idTipoOpcionArt);
	if (idOpcionDefecto && idOpcionDefecto != "") {
		this.iface.opcionesActuales[tamano] = [];
		this.iface.opcionesActuales[tamano]["tipo"] = idTipoOpcionArt;
		this.iface.opcionesActuales[tamano]["valor"] = idOpcionDefecto;
		valor = idOpcionDefecto;
	} else {
		valor = false;
	}
	return valor;
}

function articuloscomp_cambiarOpcionActual(idTipoOpcionArt:Number, valor:Number):Boolean
{
	var util:FLUtil = new FLUtil;
	var tamano:Number= this.iface.opcionesActuales.length;
	var ok:Boolean = false;
	for (var i:Number = 0; i < tamano; i++) {
		if (this.iface.opcionesActuales[i]["tipo"] == idTipoOpcionArt) {
			this.iface.opcionesActuales[i]["valor"] = valor;
			ok = true;
			break;
		}
	}
	return ok;
}

function articuloscomp_cambiarSeleccionComponentes(item:FLListViewItem)
{
	this.iface.componenteSeleccionado = item;
}

function articuloscomp_cambiarSeleccionCompuestos(item:FLListViewItem)
{
	this.iface.compuestoSeleccionado = item;
}

function articuloscomp_insertArticuloComp()
{
	var util:FLUtil;
	
	if (this.cursor().modeAccess() == this.cursor().Insert) { 
		if (!this.child("tdbArticulosTarifas").cursor().commitBufferCursorRelation())
			return false;
	
		//this.iface.crearArbolComponentes();
		this.iface.anadirComponente();
		this.iface.crearArbolCompuestos();
	}

	if (!this.iface.componenteSeleccionado)
		return;

	var referencia:String = this.iface.referenciaNodo(this.iface.componenteSeleccionado);
	if (!referencia || referencia == "")
		return;

	this.iface.referenciaComp_ = referencia;

	disconnect(this.iface.curArticulosComp_, "bufferCommited()", this, "iface.refrescarNodos");
	delete this.iface.curArticulosComp_;
	this.iface.curArticulosComp_ = new FLSqlCursor("articuloscomp");
	connect(this.iface.curArticulosComp_, "bufferCommited()", this, "iface.refrescarNodos");

	this.iface.guardarExpansiones();
	this.iface.curArticulosComp_.insertRecord();
}

function articuloscomp_refrescarNodos()
{
	var clave:String = this.iface.componenteSeleccionado.key();
	//this.iface.crearArbolComponentes();
	this.iface.anadirComponente();
	if (clave) {
		var nodo = this.iface.buscarNodo(clave);
		if (nodo) {
			try { // setSelected publicado 01/10/07
				this.iface.lvwComponentes.setSelected(nodo, true);
				this.iface.componenteSeleccionado = nodo;
			} catch (e) {}
		} else {
			this.iface.componenteSeleccionado = this.iface.raizComponente;
		}
	}
	return;

	var util:FLUtil = new FLUtil;

// 	if (this.iface.referenciaComp_) {
// 		/// Alta de nuevo nodo
// 		if (this.iface.referenciaComp_ != this.iface.raizComponente.text(0)) {
// 			this.iface.buscarNodos(this.iface.referenciaComp_,this.iface.raizComponente,"");
// 		}
// 		else { 
// 			this.iface.indice = 0;
// 			this.iface.arrayNodos[this.iface.indice] = this.iface.raizComponente;
// 			this.iface.indice += 1;
// 		}
// 	
// 		var datosNodo:Array = new Array;
// 		datosNodo["cantidad"] = parseFloat(this.iface.curArticulosComp_.valueBuffer("cantidad"));
// 		datosNodo["descripcion"] = this.iface.curArticulosComp_.valueBuffer("desccomponente");
// 		datosNodo["codigo"] = this.iface.curArticulosComp_.valueBuffer("refcomponente");
// 		datosNodo["unidad"] = this.iface.curArticulosComp_.valueBuffer("codunidad");
// 		datosNodo["id"] = this.iface.curArticulosComp_.valueBuffer("id");
// 		var codFamilia:String = util.sqlSelect("articulos","codfamilia","referencia = '" + this.iface.curArticulosComp_.valueBuffer("refcomponente") + "'");
// 		datosNodo["imagen"] = util.sqlSelect("familias","imagen","codfamilia = '" + codFamilia + "'");
// 	
// 		for (var i = 0; i < this.iface.indice; i++) {
// 			var nodoHijo = new FLListViewItem(this.iface.arrayNodos[i]);
// 			this.iface.establecerDatosNodo(nodoHijo,datosNodo);
// 			nodoHijo.setExpandable(false);
// 			this.iface.pintarNodo(nodoHijo,"componente");
// 		}
// 
// 	} else {
// 		/// Modificación de nodo existente
// 		var q:FLSqlQuery = new FLSqlQuery();
// 		q.setTablesList("articuloscomp");
// 		q.setSelect("refcomponente, desccomponente, cantidad, codunidad, refcompuesto");
// 		q.setFrom("articuloscomp");
// 		q.setWhere("id = " + this.iface.curArticulosComp_.valueBuffer("id"));
// 		
// 		if (!q.exec())
// 			return;
// 		
// 		if (!q.first())
// 			return;
// 		this.iface.buscarNodos(this.iface.componenteSeleccionado.text(0), this.iface.raizComponente, this.iface.curArticulosComp_.valueBuffer("refcompuesto"));
// 	
// 		var datosNodo:Array = new Array;
// 		datosNodo["cantidad"] = parseFloat(q.value("cantidad"));
// 		datosNodo["descripcion"] = q.value("desccomponente");
// 		datosNodo["codigo"] = "";
// 		datosNodo["unidad"] = "";
// 		datosNodo["id"] = "";
// 		datosNodo["imagen"] = "";
// 	
// 		for (var i = 0; i < this.iface.indice; i++) {
// 			this.iface.establecerDatosNodo(this.iface.arrayNodos[i], datosNodo);
// 		}
// 	}
}

// function articuloscomp_buscarSiguienteNodo(codigo:String,raiz:FLListViewItem,refPadre:String)
// {
// 	var hijo:Object = raiz.firstChild();
// 	var copiar:Boolean = true;
// 	if(refPadre && refPadre != ""){
// 		if(refPadre != raiz.text(0)){
// 			copiar = false;
// 		}
// 	}
// 	
// 	while (hijo) {
// 		this.iface.buscarSiguienteNodo(codigo,hijo,refPadre);
// 		if (hijo.text(0) == codigo && copiar) {
// 			this.iface.arrayNodos[this.iface.indice] = hijo;
// 			this.iface.indice += 1;
// 		}
// 		hijo = hijo.nextSibling();
// 	}
// }

// function articuloscomp_buscarNodos(codigo:String,raiz:FLListViewItem,refPadre:String)
// {
// 	this.iface.indice = 0;
// 	delete this.iface.arrayNodos;
// 	this.iface.arrayNodos = new Array();
// 	this.iface.buscarSiguienteNodo(codigo,raiz,refPadre);
// }

function articuloscomp_guardarExpansiones()
{
	delete this.iface.expansiones;
	this.iface.expansiones = [];
	this.iface.guardarExpansion(this.iface.raizComponente);
}

function articuloscomp_guardarExpansion(nodo:FLListViewItem)
{
	var id:String;
	try { // isOpen publicado 01/11/07
		if (nodo.isOpen()) {
			this.iface.expansiones[this.iface.expansiones.length] = nodo.key();
	
			var nodoAux;
			for (nodoAux = nodo.firstChild(); nodoAux; nodoAux = nodoAux.nextSibling()) {
				this.iface.guardarExpansion(nodoAux);
			}
		}
	} catch (e) {}
}

function articuloscomp_expandido(clave:String):Boolean
{
debug(clave);
	for (var i:Number = 0; i < this.iface.expansiones.length; i++) {
		if (this.iface.expansiones[i] == clave)
			return true;
	}
	return false;
}

function articuloscomp_editArticuloComp()
{
	if (this.cursor().modeAccess() == this.cursor().Insert) 
		return;
	
	var util:FLUtil;
	if (!this.iface.componenteSeleccionado)
		return;

	var clave:String = this.iface.componenteSeleccionado.key();
	if (!clave || clave == 0)
		return;
	if (clave.startsWith("TO_"))
		return this.iface.editTipoOpcion(clave);
	
	disconnect(this.iface.curArticulosComp_, "bufferCommited()", this, "iface.refrescarNodos");
	delete this.iface.curArticulosComp_;
	this.iface.curArticulosComp_ = new FLSqlCursor("articuloscomp");
	this.iface.curArticulosComp_.select("id = " + clave);
	if (!this.iface.curArticulosComp_.first())
		return;

	this.iface.referenciaComp_ = false;
	connect(this.iface.curArticulosComp_, "bufferCommited()", this, "iface.refrescarNodos");

	this.iface.guardarExpansiones();
	this.iface.curArticulosComp_.editRecord();
}

function articuloscomp_editTipoOpcion(clave:String)
{
	idTipoOpcionArt = clave.right(clave.length - 3);

	var curTipoOpcion:FLSqlCursor = new FLSqlCursor("tiposopcionartcomp");
	curTipoOpcion.select("idtipoopcionart = " + idTipoOpcionArt);
	if (!curTipoOpcion.first())
		return;

	curTipoOpcion.editRecord();
}

function articuloscomp_editArticulo()
{
	if (this.cursor().modeAccess() == this.cursor().Insert)
		return;

	var util:FLUtil;
	if (!this.iface.componenteSeleccionado)
		return;

	var clave:String = this.iface.componenteSeleccionado.key();
	if (clave.startsWith("TO_"))
		return this.iface.editTipoOpcion(clave);

	var referencia:String = this.iface.referenciaNodo(this.iface.componenteSeleccionado);
	if (!referencia || referencia == "")
		return;

	delete this.iface.curComponente_;
	this.iface.curComponente_ = new FLSqlCursor("articulos");
	this.iface.curComponente_.setAction("articuloscomponente");
	this.iface.curComponente_.select("referencia = '" + referencia + "'");
	if (!this.iface.curComponente_.first())
		return;

	this.iface.curComponente_.editRecord();
}

function articuloscomp_browseArticulo()
{
	if (this.cursor().modeAccess() == this.cursor().Insert)
		return;

	var util:FLUtil;
	if(!this.iface.componenteSeleccionado)
		return;

	var clave:String = this.iface.componenteSeleccionado.key();
	if (clave.startsWith("TO_"))
		return;

	var referencia:String = this.iface.referenciaNodo(this.iface.componenteSeleccionado);
	if (!referencia || referencia == "")
		return;

	delete this.iface.curComponente_;
	this.iface.curComponente_ = new FLSqlCursor("articulos");
	this.iface.curComponente_.setAction("articuloscomponente");
	this.iface.curComponente_.select("referencia = '" + referencia + "'");
	if (!this.iface.curComponente_.first())
		return;

	this.iface.curComponente_.browseRecord();
}

function articuloscomp_deleteArticulo()
{
	if (this.cursor().modeAccess() == this.cursor().Insert)
		return;

	var util:FLUtil;
	if (!this.iface.componenteSeleccionado)
		return;

	var clave:String = this.iface.componenteSeleccionado.key();
	if (clave.startsWith("TO_"))
		return;

	var referencia:String = this.iface.referenciaNodo(this.iface.componenteSeleccionado);
	if (!referencia || referencia == "") {
		MessageBox.information(util.translate("scripts", "No hay ningún registro seleccionado"), MessageBox.Ok, MessageBox.NoButton);
		return;
	}
	
	if (!this.iface.borrarArticulo(referencia, clave))
		return;

	this.iface.guardarExpansiones();
	this.iface.refrescarNodos();

	//var nodoPadre:Object = this.iface.componenteSeleccionado.parent();
	
// 	this.iface.buscarNodos(referencia,this.iface.raizComponente,nodoPadre.text(0));
// 	for (var i = 0; i < this.iface.indice; i++) {
// 		var nodoPadre:Object = this.iface.arrayNodos[i].parent();
// 		this.iface.arrayNodos[i].del();
// 		nodoPadre.setExpandable(false);
// 	}

	//this.iface.componenteSeleccionado = nodoPadre;
}

function articuloscomp_borrarArticulo(referencia:String, id:Number):Boolean
{
	var util:FLUtil;

	if (!referencia || referencia == "") {
		MessageBox.information(util.translate("scripts", "No hay ningún registro seleccionado"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}	

	var res:Number = MessageBox.information(util.translate("scripts", "El artículo seleccionado será borrado ¿Está seguro?"), MessageBox.Yes, MessageBox.No);
	if (res != MessageBox.Yes)
		return false;
	
	if (util.sqlSelect("articuloscomp","refcomponente","refcompuesto = '" + referencia + "'")) {
		MessageBox.critical(util.translate("scripts", "El artículo seleccionado está compuesto. Antes de eliminarlo debe eliminar sus componentes"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	if (util.sqlSelect("articuloscomp","refcompuesto","refcomponente = '" + referencia + "' AND id <> " + id)) {
		MessageBox.warning(util.translate("scripts", "El artículo seleccionado es componente de otros artículos. Antes de eliminarlo debe eliminar estas composiciones"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	
	if(!util.sqlDelete("articuloscomp","id = " + id)) {
		MessageBox.warning(util.translate("scripts", "Hubo un error al eliminar el artículo"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	if (!util.sqlDelete("articulos", "referencia = '" + referencia + "'")) {
		MessageBox.warning(util.translate("scripts", "Hubo un error al eliminar el artículo"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	MessageBox.information(util.translate("scripts", "El articulo seleccionado se eliminó correctamente"), MessageBox.Ok, MessageBox.NoButton);

	return true;
}

function articuloscomp_browseArticuloComp()
{
	if (this.cursor().modeAccess() == this.cursor().Insert) 
		return;

	var util:FLUtil;
	if(!this.iface.componenteSeleccionado)
		return;
	var clave:Number = this.iface.componenteSeleccionado.key();
	if (!clave || clave == 0)
		return;
	if (clave.startsWith("TO_"))
		return;
	
	var f:Object = new FLFormSearchDB("articuloscomparbol");
	var curArticulosComp:FLSqlCursor = f.cursor();
	curArticulosComp.select("id = " + clave);
	if (!curArticulosComp.first())
		return;
	curArticulosComp.setModeAccess(curArticulosComp.Browse);
	curArticulosComp.refreshBuffer();
	f.setMainWidget();
	curArticulosComp.refreshBuffer()
	f.exec("clave");
}

function articuloscomp_browseArticuloCompuestos()
{
	if (this.cursor().modeAccess() == this.cursor().Insert)
		return;

	var util:FLUtil;
	if(!this.iface.compuestoSeleccionado)
		return;
	var id:Number = this.iface.compuestoSeleccionado.key();
	if (!id || id == 0)
		return;
	
	var f:Object = new FLFormSearchDB("articuloscomparbol");
	var curArticulosComp:FLSqlCursor = f.cursor();
	curArticulosComp.select("id = " + id);
	if (!curArticulosComp.first())
		return;
	curArticulosComp.setModeAccess(curArticulosComp.Browse);
	curArticulosComp.refreshBuffer();
	f.setMainWidget();
	curArticulosComp.refreshBuffer()
	f.exec("id");
}

function articuloscomp_deleteArticuloComp()
{
	if (this.cursor().modeAccess() == this.cursor().Insert)
		return;

	var util:FLUtil;
	if (!this.iface.componenteSeleccionado)
		return;

	var clave:String = this.iface.componenteSeleccionado.key();
	if (clave.startsWith("TO_"))
		return;

	var referencia:String = this.iface.referenciaNodo(this.iface.componenteSeleccionado);
	if (!referencia || referencia == "") {
		MessageBox.information(util.translate("scripts", "No hay ningún registro seleccionado"), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	var res:Number = MessageBox.information(util.translate("scripts", "Se eliminará la asociación del artículo " + referencia + ".\n¿Está seguro?"), MessageBox.Yes, MessageBox.No);
	if (res != MessageBox.Yes)
		return false;

	var nodoPadre:Object = this.iface.componenteSeleccionado.parent();
	var curArticulosComp:FLSqlCursor = new FLSqlCursor("articuloscomp");
	curArticulosComp.select("id = " + clave);
	if (!curArticulosComp.first())
		return;
	curArticulosComp.setModeAccess(curArticulosComp.Del);
	curArticulosComp.refreshBuffer();
	if(!curArticulosComp.commitBuffer())
		return;

// 	this.iface.buscarNodos(this.iface.componenteSeleccionado.text(0),this.iface.raizComponente,curArticulosComp.valueBuffer("refcompuesto"));
// 	for (var i = 0; i < this.iface.indice; i++) {
// 		var nodoPadre:Object = this.iface.arrayNodos[i].parent();
// 		this.iface.arrayNodos[i].del();
// 		nodoPadre.setExpandable(false);
// 	}
// 
// 	this.iface.componenteSeleccionado = nodoPadre;

	this.iface.guardarExpansiones();
	this.iface.refrescarNodos();
}

function articuloscomp_calcularPvp()
{
	var cursor:FLSqlCursor = this.cursor();
	var total:Number = flfactalma.iface.pub_pvpCompuesto(cursor.valueBuffer("referencia"));
	cursor.setValueBuffer("pvp",total);
}

function articuloscomp_siguienteOpcion_clicked()
{
// 	var cursor:FLSqlCursor = this.cursor();
// 	var util:FLUtil = new FLUtil();
// 
// debug(this.iface.componenteSeleccionado);
// 	if (!this.iface.componenteSeleccionado)
// 		return;
// 
// debug(this.iface.componenteSeleccionado.key());
// 	var id:Number = this.iface.componenteSeleccionado.key();
// 	if (!id || id == 0)
// 		return;
// 
// 	var referencia:String = this.iface.componenteSeleccionado.text(0);
// 	if (!referencia || referencia == "")
// 		return;
// 
// 	var filtroTiposOpcion:String = "((referencia IS NULL AND codfamilia IS NULL) OR (referencia = '" + referencia + "')"
// 
// 	var codFamilia:String = util.sqlSelect("articulos", "codfamilia", "referencia = '" + referencia + "'");
// 	if (codFamilia && codFamilia != "")
// 		filtroTiposOpcion += " OR (referencia IS NULL AND codfamilia = '" + codFamilia + "')";
// 	
// 	filtroTiposOpcion += ")";// AND idtipoopcion NOT IN (SELECT idtipoopcion FROM tiposopcionartcomp WHERE referencia = '" + referencia + "'"
// 
// 	var f:Object = new FLFormSearchDB("tiposopcioncomp");
// 	var curTiposOpcion:FLSqlCursor = f.cursor();
// 	
// 	curTiposOpcion.setMainFilter(filtroTiposOpcion);
// 	f.setMainWidget();
// 
// 	var idTipoOpcion:String = f.exec("idtipoopcion");
// 	if (!idTipoOpcion) {
// 		return false;
// 	}
// 	var tipo:String = util.sqlSelect("tiposopcioncomp", "tipo", "idtipoopcion = " + idTipoOpcion);
// 
// 	if (util.sqlSelect("tiposopcionartcomp", "idtipoopcion", "referencia = '" + referencia + "' AND idtipoopcion = " + idTipoOpcion)) {
// 		MessageBox.warning(util.translate("scripts", "La opción %1 ya está asociada al artículo %2").arg(tipo).arg(referencia), MessageBox.Ok, MessageBox.NoButton);
// 		return false;
// 	}
// 
// 	var ok:Boolean = false;
// 	cursor.transaction(false);
// 	try {
// 		if (!this.iface.asociarTipoOpcion(referencia, idTipoOpcion)) {
// 			cursor.rollback();
// 		} else {
// 			cursor.commit();
// 			ok = true;
// 		}
// 	} catch (e) {
// 		cursor.rollback();
// 		MessageBox.critical(util.translate("scripts", "La asociación de la opción ha fallado: ") + e, MessageBox.Ok, MessageBox.NoButton);
// 	}
// 	if (ok)
// 		this.iface.crearArbolCompuestos();

	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();

	if (!this.iface.componenteSeleccionado)
		return;

	var clave:String = this.iface.componenteSeleccionado.key();
	if (!clave.startsWith("TO_"))
		return;

	var idTipoOpcionActual:Number = parseFloat(clave.right(clave.length - 3));;
	var idOpcionActual:Number = this.iface.buscarOpcionActual(idTipoOpcionActual);
	if (!idOpcionActual)
		idOpcionActual = -1;

	var idNuevaOpcion:String = util.sqlSelect("opcionesarticulocomp", "idopcionarticulo", "idtipoopcionart = " + idTipoOpcionActual + " AND idopcionarticulo > " + idOpcionActual + " ORDER BY idopcionarticulo");
	if (!idNuevaOpcion && idOpcionActual >= 0) {
		idNuevaOpcion = util.sqlSelect("opcionesarticulocomp", "idopcionarticulo", "idtipoopcionart = " + idTipoOpcionActual + " ORDER BY idopcionarticulo");
	}
	if (!idNuevaOpcion)
		return false;

	if (!this.iface.cambiarOpcionActual(idTipoOpcionActual, idNuevaOpcion))
		return false;

	this.iface.guardarExpansiones();
	this.iface.refrescarNodos();
}

function articuloscomp_establecerColumnas()
{
	this.iface.COL_REFERENCIA = 0;
	this.iface.COL_DESCRIPCION = 1;
	this.iface.COL_CANTIDAD = 2;
	this.iface.COL_UNIDAD = 3;
}

function articuloscomp_esArticuloVariable(referencia:String):Boolean
{
	var util:FLUtil;

	var variable:Boolean = false;

	if(!referencia || referencia == "")
		return false;

	if(this.iface.esVariable(referencia))
		variable = true;

	if(!variable)
		if(this.iface.tieneHijosVariables(referencia))
			variable = true;

	return variable;
}

function articuloscomp_tieneHijosVariables(referencia:string):Boolean
{
	var util:FLUtil;
	
	var variable:Boolean = false;
	if(!referencia || referencia == "")
		return false;

	var qryAC:FLSqlQuery = new FLSqlQuery();
	qryAC.setTablesList("articuloscomp");
	qryAC.setSelect("refcomponente");
	qryAC.setFrom("articuloscomp");
	qryAC.setWhere("refcompuesto = '" + referencia + "'");
	qryAC.exec();
	while (qryAC.next()) {
		if(this.iface.esArticuloVariable(qryAC.value("refcomponente"))) {
			variable = true;
				if(!util.sqlUpdate("articulos","variable",variable,"referencia = '" + referencia + "'"))
					return false;
		}
	}

	return variable;
}

function articuloscomp_esVariable(referencia:String):Boolean
{
	var util:FLUtil;
	if(!referencia || referencia == "")
		return false;

// 	if(util.sqlSelect("articulos","variable","referencia = '" + referencia + "'"))
// 		return true;

	if(util.sqlSelect("tiposopcionartcomp","idtipoopcionart","referencia = '" + referencia + "'"))
		return true;

	return false;
}
//// ARTICULOSCOMP //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition funNumSerie */
/////////////////////////////////////////////////////////////////
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////

function funNumSerie_init()
{
	this.iface.controlCampos();
	this.iface.__init();

	if (this.cursor().modeAccess() == this.cursor().Edit ) {
		if (this.cursor().valueBuffer("nostock")) {
			this.child("tbwArticulo").setTabEnabled("series", false);
		} else {
			this.child("tbwArticulo").setTabEnabled("series", true);
		}
	}

	this.iface.tblNS = this.child("tblNS");
	this.iface.tbwNS = this.child("tbwNS");
	
	connect(this.child("pbnGuardarNS"), "clicked()", this, "iface.guardarNS()");
	connect(this.child("pbnBorrarNS"), "clicked()", this, "iface.borrarNS()");
}

function funNumSerie_bufferChanged(fN:String)
{
	switch (fN) {
		case "controlnumserie":
			this.iface.controlCampos();
		break;
	}
	
	return this.iface.__bufferChanged(fN);
}

function funNumSerie_controlCampos()
{
	var cursor:FLSqlCursor = this.cursor();
	if (cursor.valueBuffer("controlnumserie")) {
		cursor.setValueBuffer("controlstock", false);
		this.child("fdbNoStock").setDisabled(true);
		this.child("gbxNumSerie").setDisabled(false);
		this.child("gbxNumSerieRap").setDisabled(false);
	}
	else {
		this.child("fdbNoStock").setDisabled(false);
		this.child("gbxNumSerie").setDisabled(true);
		this.child("gbxNumSerieRap").setDisabled(true);
	}
}

function funNumSerie_guardarNS()
{
	var cursor:FLSqlCursor = this.cursor();
	if (cursor.modeAccess() == cursor.Insert) {
		var curAA:FLSqlCursor = this.child("tdbNumerosSerie").cursor();
		curAA.setModeAccess(curAA.Insert);
		curAA.commitBufferCursorRelation();
	}

	var util:FLUtil = new FLUtil();
	
	var referencia:String = this.cursor().valueBuffer("referencia");
	if (!referencia)
		return;
	
	var codAlmacen:String = this.cursor().valueBuffer("codalmacenns");
	if (!util.sqlSelect("almacenes", "codalmacen", "codalmacen = '" + codAlmacen + "'")) {
		MessageBox.information(util.translate("scripts", "Debe establecerse un almacén válido para los nuevos números de serie"), MessageBox.Ok, MessageBox.NoButton);
		return;
	}
	
	res = MessageBox.information(util.translate("scripts", "A continuación se introducirán los números de serie\n¿continuar?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
	if (res != MessageBox.Yes)
		return;
	
	var numSerie:String;
	var curTab:FLSqlCursor = new FLSqlCursor("numerosserie");
	
	var nuevos:Number = 0;
	var repetidos:String = "";

	for (numNS = 0; numNS < this.iface.tblNS.numRows(); numNS++) {
	
		if(!this.iface.tblNS.text(numNS, 0))
			continue;
	
		numSerie = this.iface.tblNS.text(numNS, 0);
		
		curTab.select("numserie = '" + numSerie + "' AND referencia = '" + referencia + "'");
		if (curTab.first()) {
			repetidos += "\n" + numSerie;
			this.iface.tblNS.setText(numNS, 0, "");
			continue;
		}
		else {
			curTab.setModeAccess(curTab.Insert);
			curTab.refreshBuffer();
			curTab.setValueBuffer("referencia", referencia);
			curTab.setValueBuffer("numserie", numSerie);
			curTab.setValueBuffer("codalmacen", codAlmacen);
			curTab.commitBuffer();
			nuevos++;
		}
		
		this.iface.tblNS.setText(numNS, 0, "");
	}
	
	if (repetidos)
		MessageBox.information(util.translate("scripts", "Los siguientes números de serie no se han podido introducir porque ya existen:\n\n") + repetidos, MessageBox.Ok, MessageBox.NoButton);
	
	if (nuevos) {
		MessageBox.information(util.translate("scripts", "Se insertaron %0 nuevos números de serie").arg(nuevos), MessageBox.Ok, MessageBox.NoButton);
		this.iface.tbwNS.showPage("numserie");
		this.child("tdbNumerosSerie").refresh();
	}
	else
		MessageBox.information(util.translate("scripts", "No se encontaron nuevos números de serie"), MessageBox.Ok, MessageBox.NoButton);
}

function funNumSerie_borrarNS()
{
	var util:FLUtil = new FLUtil();
	
	res = MessageBox.information(util.translate("scripts", "Se vaciará la lista\n¿continuar?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
	if (res != MessageBox.Yes)
		return;
	
	for (numNS = 0; numNS < this.iface.tblNS.numRows(); numNS++)
		this.iface.tbwNS.setText(numNS, 0, "");
}


//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition sfamilia */
/////////////////////////////////////////////////////////////////
//// SUBFAMILIA /////////////////////////////////////////////////
function sfamilia_bufferChanged(fN:String)
{
	switch (fN) {
		case "codsubfamilia":
			this.child("fdbCodFamilia").setValue(this.iface.calculateField("codfamilia"));
			break;
		default:
			this.iface.__bufferChanged(fN);
	}
}

function sfamilia_calculateField(fN:String):Number
{
	var util:FLUtil = new FLUtil();
	var valor:Number;

	switch (fN) {
		case "codfamilia": {
			valor =  util.sqlSelect("subfamilias", "codfamilia", "codsubfamilia='" + this.cursor().valueBuffer("codsubfamilia") + "';");
			break;
		}
		default: {
			valor = this.iface.__calculateField(fN);
		}
	}
	return valor;
}

function sfamilia_validateForm():Boolean 
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	if (!this.iface.__validateForm())
		return false;
	
	var codFamilia:String = cursor.valueBuffer("codfamilia");
	var codSubfamilia:String = cursor.valueBuffer("codsubfamilia");
	
	if (!codFamilia || !codSubfamilia) return true;
	
	var codFamiliaSF:String = util.sqlSelect("subfamilias", "codfamilia", "codsubfamilia='" + codSubfamilia + "';");
	
	if (codFamiliaSF != codFamilia) {
		MessageBox.critical(util.translate("scripts", "La subfamilia no pertenece a la familia"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	
	return true;
}

//// SUBFAMILIA /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////

/** @class_declaration silixUploadimage */
//////////////////////////////////////////////////////////////////
//// SILIXUPLOADIMAGE ///////////////////////////////////////////

function silixUploadimage_seleccionarImagen() {
	var util:FLUtil = new FLUtil();

	if (util.sqlSelect("opcionestv", "arquitectura", "1=1") == "Unificada") {
		return this.iface.__seleccionarImagen();
	}
	else {
		var cursor:FLSqlCursor = this.cursor();

		var rutaDestino:String;
		var archivo:String = FileDialog.getOpenFileName("*.jpg;*.png;*.gif", util.translate("scripts","Elegir Fichero"));
				
		if (!archivo)
			return;

		var file = new File( archivo );
		var extension:String = file.extension;
		if (extension.length > 3)
			extension = extension.right(3);
	
		var servidor:String = util.sqlSelect("opcionestv", "ftpserver", "1 = 1");
		var ruta:String = util.sqlSelect("opcionestv", "ftppath", "1 = 1");
		var usuario:String = util.sqlSelect("opcionestv", "ftpuser", "1 = 1");
		var password:String = util.sqlSelect("opcionestv", "ftppassword", "1 = 1");
	
		rutaDestino = ruta + cursor.valueBuffer("referencia") + "." + extension;
	
		var batchcomandos:String = "user " + usuario + " " + password + "\n" + "binary" + "\n" + "put " + archivo + " " + rutaDestino + "\nquit\n";
	
		var noVerboso:String;
		if (util.getOS() == "LINUX")
			noVerboso = ""
		else
			noVerboso = "-v ";
	
		var comando:String = "ftp -n " + noVerboso + servidor;
	
		Process.execute(comando, batchcomandos);
	
		if (Process.stderr != "") {
			MessageBox.warning(util.translate("scripts", "Se produjo el error siguiente al tratar de copiar la imagen:\n") + Process.stderr + "\nVerifique en Opciones de la Tienda Virtual que los datos del servidor FTP sean correctos", MessageBox.Ok, MessageBox.NoButton);
		}
		else {
			cursor.setValueBuffer("fechaimagen", 0);
			cursor.setValueBuffer("tipoimagen", extension);
			MessageBox.information(util.translate("scripts", "Se copió correctamente la imagen en la página web"), MessageBox.Ok, MessageBox.NoButton);
		}
	}
}

//// SILIXUPLOADIMAGE ///////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition lineasArticulos */
/////////////////////////////////////////////////////////////////
//// LINEAS_ARTICULOS ///////////////////////////////////////////

function lineasArticulos_init()
{
	this.iface.__init();

	this.child("tdbSalidasArticulos").setReadOnly(true);
	this.child("tdbEntradasArticulos").setReadOnly(true);

	connect(this.child("toolButtonZoomSalidas"), "clicked()", this, "iface.verSalida()");
	connect(this.child("toolButtonZoomEntradas"), "clicked()", this, "iface.verEntrada()");

	connect(this.child("tbnImprimirSalidas"), "clicked()", this, "iface.imprimirSalidas()");
	connect(this.child("tbnImprimirEntradas"), "clicked()", this, "iface.imprimirEntradas()");
}

function lineasArticulos_verSalida()
{
	var util:FLUtil;
	var curSalida:FLSqlCursor = this.child("tdbSalidasArticulos").cursor();

	if (!curSalida.isValid()) {
		MessageBox.warning(util.translate("scripts", "No hay ningún registro seleccionado"), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	var idDocumento:Number;
	var cursor:FLSqlCursor;

	switch (curSalida.valueBuffer("documento")) {
		case "Factura": {
			idDocumento = curSalida.valueBuffer("idfactura");
			cursor = new FLSqlCursor("facturascli");
			cursor.select("idfactura = " + idDocumento);

			if (!cursor.first())
				return;
			cursor.browseRecord();
			break;
		}
		case "Remito": {
			idDocumento = curSalida.valueBuffer("idalbaran");
			cursor = new FLSqlCursor("albaranescli");
			cursor.select("idalbaran = " + idDocumento);

			if (!cursor.first())
				return;
			cursor.browseRecord();
			break;
		}
		case "Pedido": {
			idDocumento = curSalida.valueBuffer("idpedido");
			cursor = new FLSqlCursor("pedidoscli");
			cursor.select("idpedido = " + idDocumento);

			if (!cursor.first())
				return;
			cursor.browseRecord();
			break;
		}
		case "Mov. interno": {
			idDocumento = curSalida.valueBuffer("codtrazainterna");
			cursor = new FLSqlCursor("trazabilidadinterna");
			cursor.select("codigo = '" + idDocumento + "'");

			if (!cursor.first())
				return;
			cursor.browseRecord();
			break;
		}
		break;
	}
}

function lineasArticulos_verEntrada()
{
	var util:FLUtil;
	var curEntrada:FLSqlCursor = this.child("tdbEntradasArticulos").cursor();

	if (!curEntrada.isValid()) {
		MessageBox.warning(util.translate("scripts", "No hay ningún registro seleccionado"), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	var idDocumento:Number;
	var cursor:FLSqlCursor;

	switch (curEntrada.valueBuffer("documento")) {
		case "Factura": {
			idDocumento = curEntrada.valueBuffer("idfactura");
			cursor = new FLSqlCursor("facturasprov");
			cursor.select("idfactura = " + idDocumento);

			if (!cursor.first())
				return;
			cursor.browseRecord();
			break;
		}
		case "Remito": {
			idDocumento = curEntrada.valueBuffer("idalbaran");
			cursor = new FLSqlCursor("albaranesprov");
			cursor.select("idalbaran = " + idDocumento);

			if (!cursor.first())
				return;
			cursor.browseRecord();
			break;
		}
		case "Pedido": {
			idDocumento = curEntrada.valueBuffer("idpedido");
			cursor = new FLSqlCursor("pedidosprov");
			cursor.select("idpedido = " + idDocumento);

			if (!cursor.first())
				return;
			cursor.browseRecord();
			break;
		}
		case "Mov. interno": {
			idDocumento = curEntrada.valueBuffer("codtrazainterna");
			cursor = new FLSqlCursor("trazabilidadinterna");
			cursor.select("codigo = '" + idDocumento + "'");

			if (!cursor.first())
				return;
			cursor.browseRecord();
			break;
		}
		break;
	}
}

function lineasArticulos_calcularEntradas()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	var refArticulo:String = cursor.valueBuffer("referencia");
	if (!refArticulo)
		return;

	var desde:String = this.iface.fechaDesdeEntrada.date.toString().left(10);
	var hasta:String = this.iface.fechaHastaEntrada.date.toString().left(10);
	if (desde == "" || hasta == "")
		return;

	var qryLineas:FLSqlQuery = new FLSqlQuery();
	qryLineas.setTablesList("lineasentradasarticulos");
	qryLineas.setSelect("SUM(cantidad),SUM(totalconiva)");
	qryLineas.setFrom("lineasentradasarticulos");
	qryLineas.setWhere("referencia = '" + refArticulo +"' AND fecha >= '" + desde + "' AND fecha <= '" + hasta + "'");

	qryLineas.exec();

	var cant:String = "", total:String = "";
	if (qryLineas.first()) {
		cant = util.buildNumber(qryLineas.value(0), "float", 2);
		total = util.buildNumber(qryLineas.value(1), "float", 2);
	}

	this.child("lblEntradasCantidad").setText(cant);
	this.child("lblEntradasTotal").setText(total);
}

function lineasArticulos_calcularSalidas()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	var refArticulo:String = cursor.valueBuffer("referencia");
	if (!refArticulo)
		return;

	var desde:String = this.iface.fechaDesdeSalida.date.toString().left(10);
	var hasta:String = this.iface.fechaHastaSalida.date.toString().left(10);
	if (desde == "" || hasta == "")
		return;

	var qryLineas:FLSqlQuery = new FLSqlQuery();
	qryLineas.setTablesList("lineassalidasarticulos");
	qryLineas.setSelect("SUM(cantidad),SUM(totalconiva)");
	qryLineas.setFrom("lineassalidasarticulos");
	qryLineas.setWhere("referencia = '" + refArticulo +"' AND fecha >= '" + desde + "' AND fecha <= '" + hasta + "'");

	qryLineas.exec();

	var cant:String = "", total:String = "";
	if (qryLineas.first()) {
		cant = util.buildNumber(qryLineas.value(0), "float", 2);
		total = util.buildNumber(qryLineas.value(1), "float", 2);
	}

	this.child("lblSalidasCantidad").setText(cant);
	this.child("lblSalidasTotal").setText(total);
}

function lineasArticulos_imprimirSalidas()
{
	if (sys.isLoadedModule("flfactinfo")) {

		var refArticulo:String = this.cursor().valueBuffer("referencia");
		if (!refArticulo)
			return;

		var desde:String = this.iface.fechaDesdeSalida.date.toString().left(10);
		var hasta:String = this.iface.fechaHastaSalida.date.toString().left(10);
		if (desde == "" || hasta == "")
			return;

		var orderBy:String = "fecha";

		var curImprimir:FLSqlCursor = new FLSqlCursor("i_salidasarticulos");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("i_lineassalidasarticulos_referencia", refArticulo);
		curImprimir.setValueBuffer("d_lineassalidasarticulos_fecha", desde);
		curImprimir.setValueBuffer("h_lineassalidasarticulos_fecha", hasta);
		flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_salidasarticulos", orderBy);
	} else
		flfactppal.iface.pub_msgNoDisponible("Informes");
}

function lineasArticulos_imprimirEntradas()
{
	if (sys.isLoadedModule("flfactinfo")) {

		var refArticulo:String = this.cursor().valueBuffer("referencia");
		if (!refArticulo)
			return;

		var desde:String = this.iface.fechaDesdeEntrada.date.toString().left(10);
		var hasta:String = this.iface.fechaHastaEntrada.date.toString().left(10);
		if (desde == "" || hasta == "")
			return;

		var orderBy:String = "fecha";

		var curImprimir:FLSqlCursor = new FLSqlCursor("i_entradasarticulos");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("i_lineasentradasarticulos_referencia", refArticulo);
		curImprimir.setValueBuffer("d_lineasentradasarticulos_fecha", desde);
		curImprimir.setValueBuffer("h_lineasentradasarticulos_fecha", hasta);
		flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_entradasarticulos", orderBy);
	} else
		flfactppal.iface.pub_msgNoDisponible("Informes");
}
//// LINEAS_ARTICULOS ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition fechas */
/////////////////////////////////////////////////////////////////
//// FECHAS /////////////////////////////////////////////////////

function fechas_init()
{
	this.iface.__init();

	this.iface.tdbEntradas = this.child("tdbEntradasArticulos");
	this.iface.tdbSalidas = this.child("tdbSalidasArticulos");

	this.iface.fechaDesdeEntrada = this.child("dateFromEntrada");
	this.iface.fechaHastaEntrada = this.child("dateToEntrada");
	this.iface.fechaDesdeSalida = this.child("dateFromSalida");
	this.iface.fechaHastaSalida = this.child("dateToSalida");

	var d = new Date();
	this.iface.fechaDesdeEntrada.date = new Date(d.getYear(), d.getMonth(), 1);
	this.iface.fechaHastaEntrada.date = new Date();
	this.iface.fechaDesdeSalida.date = new Date(d.getYear(), d.getMonth(), 1);
	this.iface.fechaHastaSalida.date = new Date();

	connect(this.iface.fechaDesdeEntrada, "valueChanged(const QDate&)", this, "iface.actualizarFiltroEntradas");
	connect(this.iface.fechaHastaEntrada, "valueChanged(const QDate&)", this, "iface.actualizarFiltroEntradas");
	connect(this.iface.fechaDesdeSalida, "valueChanged(const QDate&)", this, "iface.actualizarFiltroSalidas");
	connect(this.iface.fechaHastaSalida, "valueChanged(const QDate&)", this, "iface.actualizarFiltroSalidas");

	this.iface.actualizarFiltroEntradas();
	this.iface.actualizarFiltroSalidas();
}

function fechas_actualizarFiltroEntradas()
{
	var desde:String = this.iface.fechaDesdeEntrada.date.toString().left(10);
	var hasta:String = this.iface.fechaHastaEntrada.date.toString().left(10);

	if (desde == "" || hasta == "")
		return;

	this.iface.tdbEntradas.cursor().setMainFilter("fecha >= '" + desde + "' AND fecha <= '" + hasta + "'");

	this.iface.tdbEntradas.refresh();
	this.iface.tdbEntradas.cursor().last();
	this.iface.tdbEntradas.setCurrentRow(this.iface.tdbEntradas.cursor().at());

	this.iface.calcularEntradas();
}

function fechas_actualizarFiltroSalidas()
{
	var desde:String = this.iface.fechaDesdeSalida.date.toString().left(10);
	var hasta:String = this.iface.fechaHastaSalida.date.toString().left(10);

	if (desde == "" || hasta == "")
		return;

	this.iface.tdbSalidas.cursor().setMainFilter("fecha >= '" + desde + "' AND fecha <= '" + hasta + "'");

	this.iface.tdbSalidas.refresh();
	this.iface.tdbSalidas.cursor().last();
	this.iface.tdbSalidas.setCurrentRow(this.iface.tdbSalidas.cursor().at());

	this.iface.calcularSalidas();
}

//// FECHAS /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ordenCampos */
/////////////////////////////////////////////////////////////////
//// ORDEN_CAMPOS ///////////////////////////////////////////////

function ordenCampos_init()
{
	this.iface.__init();

	var ordenEntradas:Array = [ "fecha", "documento", "codigo", "nombreproveedor", "descripcion", "cantidad", "pvpunitario", "pvpsindto", "pvptotal", "totalconiva", "dtolineal", "dtopor" ];
	var ordenSalidas:Array = [ "fecha", "documento", "codigo", "nombrecliente", "descripcion", "cantidad", "pvpunitario", "pvpsindto", "pvptotal", "totalconiva", "dtolineal", "dtopor", "costounitario", "costototal", "ganancia", "utilidad" ];

	this.iface.tdbEntradas.setOrderCols(ordenEntradas);
	this.iface.tdbSalidas.setOrderCols(ordenSalidas);
}

//// ORDEN_CAMPOS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition marcacion */
/////////////////////////////////////////////////////////////////
//// MARCACION //////////////////////////////////////////////////

function marcacion_init()
{
	this.iface.__init();

	connect(this.child("tbnRecalcularPVP"), "clicked()", this, "iface.recalcularPvp");
}

function marcacion_bufferChanged(fN:String)
{
	switch (fN) {
		case "codfamilia":
		case "codsubfamilia": {
			this.child("fdbMarcacion").setValue(this.iface.calculateField("marcacion"));
			break;
		}
		case "recalcularPVP": {
			this.child("fdbPvp").setValue(this.iface.calculateField("pvp"));
			break;
		}
		case "costemaximo":
		case "marcacion":
		case "pvp": {
			this.child("fdbVariacion").setValue(this.iface.calculateField("variacion"));
			break;
		}
		default:
			this.iface.__bufferChanged(fN);
	}
}

function marcacion_calculateField(fN:String):Number
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	var valor:Number;

	switch (fN) {
		case "pvp": {
			var costoMaximo:Number = cursor.valueBuffer("costemaximo");
			if (!costoMaximo)
				costoMaximo = 0;

			var marcacion:Number = cursor.valueBuffer("marcacion");
		
			var variacion:Number = cursor.valueBuffer("variacion");

			var precio:Number = costoMaximo * (1 + (marcacion + variacion)/100);
			valor = util.roundFieldValue(precio, "articulos", "pvp");
			break;
		}
		case "variacion": {
			var costoMaximo:Number = cursor.valueBuffer("costemaximo");
			if (!costoMaximo) {
				valor = 0;
				break;
			}

			var marcacion:Number = cursor.valueBuffer("marcacion");

			var precio:Number = cursor.valueBuffer("pvp");

			var variacion:Number = ((precio/costoMaximo)-1)*100-marcacion;
			valor = util.roundFieldValue(variacion, "articulos", "variacion");
			break;
		}
		case "marcacion": {
			var codFamilia:String = cursor.valueBuffer("codfamilia");
			var codSubfamilia:String = cursor.valueBuffer("codsubfamilia");

			var marcacion:Number;
			if (!codFamilia) {
				marcacion = 0;
			}
			else if (!codSubfamilia) {
				marcacion = parseFloat(util.sqlSelect("familias", "marcacion", "codfamilia = '" + codFamilia + "'"));
			}
			else {
				marcacion = parseFloat(util.sqlSelect("subfamilias", "marcacion", "codsubfamilia = '" + codSubfamilia + "'"));
			}

			if (isNaN(marcacion))
				marcacion = 0;

			valor = util.roundFieldValue(marcacion, "articulos", "marcacion");
			break;
		}
		default: {
			valor = this.iface.__calculateField(fN);
		}
	}
	return valor;
}

function marcacion_recalcularPvp()
{
	this.cursor().setValueBuffer("variacion",0);
	this.iface.bufferChanged("recalcularPVP");
}
//// MARCACION //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////