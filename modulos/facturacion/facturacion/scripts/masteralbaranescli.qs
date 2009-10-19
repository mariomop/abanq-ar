/***************************************************************************
                 masteralbaranescli.qs  -  description
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
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	/** \D @var pbnAAlbaran Botón de asociar a remito \end */
	var pbnAAlbaran:Object;
	var pbnGFactura:Object;
	var tdbRecords:FLTableDB;
	var curFactura:FLSqlCursor;
	var curLineaFactura:FLSqlCursor;
	
    function oficial( context ) { interna( context ); } 
	function procesarEstado() {
		return this.ctx.oficial_procesarEstado();
	}
	function pbnGenerarFactura_clicked() {
		return this.ctx.oficial_pbnGenerarFactura_clicked();
	}
	function generarFactura(where:String, curAlbaran:FLSqlCursor, datosAgrupacion):Number {
		return this.ctx.oficial_generarFactura(where, curAlbaran, datosAgrupacion);
	}
	function copiaLineasAlbaran(idAlbaran:Number, idFactura:Number):Boolean {
		return this.ctx.oficial_copiaLineasAlbaran(idAlbaran, idFactura);
	}
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.oficial_commonCalculateField(fN, cursor);
	}
	function restarCantidad(idLineaPedido:Number, idLineaAlbaran:Number) {
		return this.ctx.oficial_restarCantidad(idLineaPedido, idLineaAlbaran);
	}
	function asociarAAlbaran() {
		return this.ctx.oficial_asociarAAlbaran();
	}
	function whereAgrupacion(curAgrupar:FLSqlCursor):String {
		return this.ctx.oficial_whereAgrupacion(curAgrupar);
	}
	function copiaLineaAlbaran(curLineaAlbaran:FLSqlCursor, idFactura:Number):Number {
		return this.ctx.oficial_copiaLineaAlbaran(curLineaAlbaran, idFactura);
	}
	function totalesFactura():Boolean {
		return this.ctx.oficial_totalesFactura();
	}
	function datosFactura(curAlbaran:FLSqlCursor, where:String, datosAgrupacion:Array):Boolean {
		return this.ctx.oficial_datosFactura(curAlbaran, where, datosAgrupacion);
	}
	function datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean {
		return this.ctx.oficial_datosLineaFactura(curLineaAlbaran);
	}
	function dameDatosAgrupacionPedidos(curAgruparPedidos:FLSqlCursor):Array {
		return this.ctx.oficial_dameDatosAgrupacionPedidos(curAgruparPedidos);
	}
	function validarFactura(idFactura:String):Boolean {
		return this.ctx.oficial_validarFactura(idFactura);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
class lotes extends oficial {
    function lotes( context ) { oficial ( context ); }
	function copiaLineaAlbaran(curLineaAlbaran:FLSqlCursor, idFactura:Number):Number {
		return this.ctx.lotes_copiaLineaAlbaran(curLineaAlbaran, idFactura);
	}
}
//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ivaIncluido */
//////////////////////////////////////////////////////////////////
//// IVAINCLUIDO /////////////////////////////////////////////////////
class ivaIncluido extends lotes {
    function ivaIncluido( context ) { lotes( context ); } 	
	function datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean {
		return this.ctx.ivaIncluido_datosLineaFactura(curLineaAlbaran);
	}
}
//// IVAINCLUIDO /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration fluxEcommerce */
/////////////////////////////////////////////////////////////////
//// FLUX ECOMMERCE //////////////////////////////////////////////////////
class fluxEcommerce extends ivaIncluido {
    function fluxEcommerce( context ) { ivaIncluido ( context ); }
	function datosFactura(curAlbaran:FLSqlCursor, where:String, datosAgrupacion:Array):Boolean {
		return this.ctx.fluxEcommerce_datosFactura(curAlbaran, where, datosAgrupacion);
	}
}
//// FLUX ECOMMERCE //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_declaration funNumSerie */
/////////////////////////////////////////////////////////////////
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////
class funNumSerie extends fluxEcommerce {
	function funNumSerie( context ) { fluxEcommerce ( context ); }
	function datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean {
		return this.ctx.funNumSerie_datosLineaFactura(curLineaAlbaran);
	}
}
//// FUN_NUMEROS_SERIE //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_declaration funNumAcomp */
//////////////////////////////////////////////////////////////////
//// FUN_NUM_ACOMP /////////////////////////////////////////////////////

class funNumAcomp extends funNumSerie {
	function funNumAcomp( context ) { funNumSerie( context ); } 	
	function copiaLineaAlbaran(curLineaAlbaran:FLSqlCursor, idFactura:Number):Number {
		return this.ctx.funNumAcomp_copiaLineaAlbaran(curLineaAlbaran, idFactura);
	}
}

//// FUN_NUM_ACOMP /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration fechas */
/////////////////////////////////////////////////////////////////
//// FECHAS /////////////////////////////////////////////////
class fechas extends funNumAcomp {
	var fechaDesde:Object;
	var fechaHasta:Object;
	var ejercicio:String;

    function fechas( context ) { funNumAcomp ( context ); }
	function init() {
		this.ctx.fechas_init();
	}
	function actualizarFiltro() {
		return this.ctx.fechas_actualizarFiltro();
	}
}
//// FECHAS /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_declaration lineasArticulos */
/////////////////////////////////////////////////////////////////
//// LINEAS_ARTICULOS ///////////////////////////////////////////
class lineasArticulos extends fechas {
	function lineasArticulos( context ) { fechas ( context ); }
	function datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean {
		return this.ctx.lineasArticulos_datosLineaFactura(curLineaAlbaran);
	}
}
//// LINEAS_ARTICULOS ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_declaration totalesIva */
/////////////////////////////////////////////////////////////////
//// TOTALES CON IVA ////////////////////////////////////////////
class totalesIva extends lineasArticulos {
    function totalesIva( context ) { lineasArticulos ( context ); }
	function datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean {
		return this.ctx.totalesIva_datosLineaFactura(curLineaAlbaran);
	}
}
//// TOTALES CON IVA ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration silixExtensiones */
/////////////////////////////////////////////////////////////////
//// SILIX EXTENSIONES //////////////////////////////////////////
class silixExtensiones extends totalesIva {
    function silixExtensiones( context ) { totalesIva ( context ); }
	function datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean {
		return this.ctx.silixExtensiones_datosLineaFactura(curLineaAlbaran);
	}
	function copiaLineasAlbaran(idAlbaran:Number, idFactura:Number):Boolean {
		return this.ctx.silixExtensiones_copiaLineasAlbaran(idAlbaran, idFactura);
	}
}
//// SILIX EXTENSIONES //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration impresiones */
/////////////////////////////////////////////////////////////////
//// IMPRESIONES ////////////////////////////////////////////////
class impresiones extends silixExtensiones {
	var tbnImprimir:Object;
	var tbnImprimirQuick:Object;

    function impresiones( context ) { silixExtensiones ( context ); }
	function init() { this.ctx.impresiones_init(); }
	function imprimir(codAlbaran:String) {
		return this.ctx.impresiones_imprimir(codAlbaran);
	}
	function imprimirQuick(codAlbaran:String, impresora:String) {
		return this.ctx.impresiones_imprimirQuick(codAlbaran, impresora);
	}
}
//// IMPRESIONES ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ordenCampos */
/////////////////////////////////////////////////////////////////
//// ORDEN_CAMPOS ///////////////////////////////////////////////
class ordenCampos extends impresiones {
    function ordenCampos( context ) { impresiones ( context ); }
	function init() {
		this.ctx.ordenCampos_init();
	}
}
//// ORDEN_CAMPOS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration tipoVenta */
/////////////////////////////////////////////////////////////////
//// TIPO DE VENTA //////////////////////////////////////////////
class tipoVenta extends ordenCampos {
	function tipoVenta( context ) { ordenCampos ( context ); }
	function datosFactura(curAlbaran:FLSqlCursor, where:String, datosAgrupacion:Array):Boolean {
		return this.ctx.tipoVenta_datosFactura(curAlbaran, where, datosAgrupacion);
	}
}
//// TIPO DE VENTA  /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pieDocumento */
/////////////////////////////////////////////////////////////////
//// PIE DE DOCUMENTO ///////////////////////////////////////////
class pieDocumento extends tipoVenta {
	var curPieFactura:FLSqlCursor;

	function pieDocumento( context ) { tipoVenta ( context ); }
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.pieDocumento_commonCalculateField(fN, cursor);
	}
	function copiaPiesAlbaran(idAlbaran:Number, idFactura:Number):Boolean {
		return this.ctx.pieDocumento_copiaPiesAlbaran(idAlbaran, idFactura);
	}
	function copiaPieAlbaran(curPieAlbaran:FLSqlCursor, idFactura:Number):Number {
		return this.ctx.pieDocumento_copiaPieAlbaran(curPieAlbaran, idFactura);
	}
	function datosPieFactura(curPieAlbaran:FLSqlCursor):Boolean {
		return this.ctx.pieDocumento_datosPieFactura(curPieAlbaran);
	}
	function datosFactura(curAlbaran:FLSqlCursor, where:String, datosAgrupacion:Array):Boolean {
		return this.ctx.pieDocumento_datosFactura(curAlbaran, where, datosAgrupacion);
	}
}
//// PIE DE DOCUMENTO  //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration periodosFiscales */
/////////////////////////////////////////////////////////////////
//// PERIODOS FISCALES //////////////////////////////////////////
class periodosFiscales extends pieDocumento {
	function periodosFiscales( context ) { pieDocumento ( context ); }
	function datosFactura(curAlbaran:FLSqlCursor, where:String, datosAgrupacion:Array):Boolean {
		return this.ctx.periodosFiscales_datosFactura(curAlbaran, where, datosAgrupacion);
	}
}
//// PERIODOS FISCALES //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends periodosFiscales {
    function head( context ) { periodosFiscales ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
	function pub_whereAgrupacion(curAgrupar:FLSqlCursor):String {
		return this.whereAgrupacion(curAgrupar);
	}
	function pub_generarFactura(where:String, curAlbaran:FLSqlCursor, datosAgrupacion:Array):Number {
		return this.generarFactura(where, curAlbaran, datosAgrupacion);
	}
	function pub_commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.commonCalculateField(fN, cursor);
	}
	function pub_restarCantidad(idLineaPedido:Number, idLineaAlbaran:Number) {
		return this.restarCantidad(idLineaPedido, idLineaAlbaran);
	}
	function pub_imprimir(codAlbaran:String) {
		return this.imprimir(codAlbaran);
	}
	function pub_imprimirQuick(codAlbaran:String, impresora:String) {
		return this.imprimirQuick(codAlbaran, impresora);
	}
}
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

const iface = new ifaceCtx( this );

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
/** \C
Este es el formulario maestro de albaranes a cliente.
\end */
function interna_init()
{
	this.iface.pbnAAlbaran = this.child("pbnAsociarAAlbaran");
	this.iface.pbnGFactura = this.child("pbnGenerarFactura");
	this.iface.tdbRecords = this.child("tableDBRecords");

	connect(this.iface.pbnAAlbaran, "clicked()", this, "iface.asociarAAlbaran");
	connect(this.iface.pbnGFactura, "clicked()", this, "iface.pbnGenerarFactura_clicked");
	connect(this.iface.tdbRecords, "currentChanged()", this, "iface.procesarEstado");

	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	if (codEjercicio)
		this.cursor().setMainFilter("codejercicio='" + codEjercicio + "'");

	this.iface.procesarEstado();
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_procesarEstado()
{
	if (this.cursor().isValid() && this.cursor().valueBuffer("ptefactura") == true)
		this.iface.pbnGFactura.enabled = true;
	else
		this.iface.pbnGFactura.enabled = false;
}

/** \C
Al pulsar el botón de generar factura se creará la factura correspondiente al remito.
\end */
function oficial_pbnGenerarFactura_clicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	if (!this.cursor().isValid()) {
		this.iface.procesarEstado();
		return;
	}
	if (cursor.valueBuffer("ptefactura") == false) {
		MessageBox.warning(util.translate("scripts", "Ya existe la factura correspondiente a este remito"), MessageBox.Ok, MessageBox.NoButton);
		this.iface.procesarEstado();
		return;
	}
	var res:Number = MessageBox.warning(util.translate("scripts", "Se generará una factura a partir del remito seleccionado.\n¿Desea continuar?"), MessageBox.Yes, MessageBox.No);
	if (res != MessageBox.Yes)
		return;

	this.iface.pbnGFactura.setEnabled(false);

	var where:String = "idalbaran = " + cursor.valueBuffer("idalbaran");

	cursor.transaction(false);
	try {
		if (this.iface.generarFactura(where, cursor))
			cursor.commit();
		else
			cursor.rollback();
	}
	catch (e) {
		cursor.rollback();
		MessageBox.critical(util.translate("scripts", "Hubo un error en la generación de la factura:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
	}
	
	this.iface.tdbRecords.refresh();
	this.iface.procesarEstado();
}

/** \D
Genera la factura asociada a uno o más albaranes
@param where: Sentencia where para la consulta de búsqueda de los albaranes a agrupar
@param curAlbaran: Cursor con los datos principales que se copiarán del remito a la factura
@param datosAgrupacion: Array con los datos indicados en el formulario de agrupación de albaranes
@return True: Copia realizada con éxito, False: Error
\end */
function oficial_generarFactura(where:String, curAlbaran:FLSqlCursor, datosAgrupacion:Array):Number
{
	if (!this.iface.curFactura)
		this.iface.curFactura = new FLSqlCursor("facturascli");
	
	this.iface.curFactura.setModeAccess(this.iface.curFactura.Insert);
	this.iface.curFactura.refreshBuffer();
	
	if (!this.iface.datosFactura(curAlbaran, where, datosAgrupacion)) {
		return false;
	}
	
	if (!this.iface.curFactura.commitBuffer()) {
		return false;
	}
	
	var idFactura:Number = this.iface.curFactura.valueBuffer("idfactura");
	
	var curAlbaranes:FLSqlCursor = new FLSqlCursor("albaranescli");
	curAlbaranes.select(where);
	var idAlbaran:Number;
	while (curAlbaranes.next()) {
		curAlbaranes.setModeAccess(curAlbaranes.Edit);
		curAlbaranes.refreshBuffer();
		idAlbaran = curAlbaranes.valueBuffer("idalbaran");
		if (!this.iface.copiaLineasAlbaran(idAlbaran, idFactura)) {
			return false;
		}
		curAlbaranes.setValueBuffer("idfactura", idFactura);
		curAlbaranes.setValueBuffer("ptefactura", false);
		if (!curAlbaranes.commitBuffer()) {
			return false;
		}
		// Crea los pies de factura a partir de los pies de remito
		if (!this.iface.copiaPiesAlbaran(idAlbaran, idFactura)) {
			return false;
		}
	}

	this.iface.curFactura.select("idfactura = " + idFactura);
	if (this.iface.curFactura.first()) {
/*
		if (!formRecordfacturascli.iface.pub_actualizarLineasIva(idFactura))
			return false;
*/
			
		this.iface.curFactura.setModeAccess(this.iface.curFactura.Edit);
		this.iface.curFactura.refreshBuffer();
		
		if (!this.iface.totalesFactura())
			return false;
		
		if (this.iface.curFactura.commitBuffer() == false)
			return false;
	}
	if (!this.iface.validarFactura(idFactura)) {
		return false;
	}
	return idFactura;
}

function oficial_validarFactura(idFactura:String):Boolean
{
	var util:FLUtil = new FLUtil;

	return true;
}

/** \D Informa los datos de una factura a partir de los de uno o varios albaranes
@param	curAlbaran: Cursor que contiene los datos a incluir en la factura
@param where: Sentencia where para la consulta de búsqueda de los albaranes a agrupar
@param datosAgrupacion: Array con los datos indicados en el formulario de agrupación de albaranes
@return	True si el cálculo se realiza correctamente, false en caso contrario
\end */
function oficial_datosFactura(curAlbaran:FLSqlCursor, where:String, datosAgrupacion:Array):Boolean
{
	var util:FLUtil = new FLUtil();
	var fecha:String;
	var hora:String;
	if (datosAgrupacion) {
		fecha = datosAgrupacion["fecha"];
		hora = datosAgrupacion["hora"];
	} else {
		var hoy:Date = new Date();
		fecha = hoy.toString();
		hora = hoy.toString().right(8);
	}
		
	var codEjercicio:String = curAlbaran.valueBuffer("codejercicio");
	var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(fecha, codEjercicio, "facturascli");
	if (!datosDoc.ok)
		return false;
	if (datosDoc.modificaciones == true) {
		codEjercicio = datosDoc.codEjercicio;
		fecha = datosDoc.fecha;
	}
	
	var codDir:Number = util.sqlSelect("dirclientes", "id", "codcliente = '" + curAlbaran.valueBuffer("codcliente") + "' AND domfacturacion = 'true'");
	with (this.iface.curFactura) {
		setValueBuffer("codejercicio", codEjercicio);
		setValueBuffer("fecha", fecha);
		setValueBuffer("hora", hora);
		setValueBuffer("codagente", curAlbaran.valueBuffer("codagente"));
		setValueBuffer("codalmacen", curAlbaran.valueBuffer("codalmacen"));
		setValueBuffer("codpago", curAlbaran.valueBuffer("codpago"));
		setValueBuffer("codtarifa", curAlbaran.valueBuffer("codtarifa"));
		setValueBuffer("coddivisa", curAlbaran.valueBuffer("coddivisa"));
		setValueBuffer("tasaconv", curAlbaran.valueBuffer("tasaconv"));
		setValueBuffer("codcliente", curAlbaran.valueBuffer("codcliente"));
		setValueBuffer("cifnif", curAlbaran.valueBuffer("cifnif"));
		setValueBuffer("nombrecliente", curAlbaran.valueBuffer("nombrecliente"));
		if (!codDir) {
			codDir = curAlbaran.valueBuffer("coddir")
			if (codDir == 0) {
				this.setNull("coddir");
			} else 
				setValueBuffer("coddir", curAlbaran.valueBuffer("coddir"));
			setValueBuffer("direccion", curAlbaran.valueBuffer("direccion"));
			setValueBuffer("codpostal", curAlbaran.valueBuffer("codpostal"));
			setValueBuffer("ciudad", curAlbaran.valueBuffer("ciudad"));
			setValueBuffer("provincia", curAlbaran.valueBuffer("provincia"));
			setValueBuffer("apartado", curAlbaran.valueBuffer("apartado"));
			setValueBuffer("codpais", curAlbaran.valueBuffer("codpais"));
		} else {
			setValueBuffer("coddir", codDir);
			setValueBuffer("direccion", util.sqlSelect("dirclientes","direccion","id = " + codDir));
			setValueBuffer("codpostal", util.sqlSelect("dirclientes","codpostal","id = " + codDir));
			setValueBuffer("ciudad", util.sqlSelect("dirclientes","ciudad","id = " + codDir));
			setValueBuffer("provincia", util.sqlSelect("dirclientes","provincia","id = " + codDir));
			setValueBuffer("apartado", util.sqlSelect("dirclientes","apartado","id = " + codDir));
			setValueBuffer("codpais", util.sqlSelect("dirclientes","codpais","id = " + codDir));
		}
		setValueBuffer("observaciones", curAlbaran.valueBuffer("observaciones"));
		setValueBuffer("automatica", true);
	}
	return true;
}

/** \D Copia los datos de una línea de remito en una línea de factura
@param	curLineaAlbaran: Cursor que contiene los datos a incluir en la línea de factura
@return	True si la copia se realiza correctamente, false en caso contrario
\end */
function oficial_datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean
{
	with (this.iface.curLineaFactura) {
		setValueBuffer("referencia", curLineaAlbaran.valueBuffer("referencia"));
		setValueBuffer("descripcion", curLineaAlbaran.valueBuffer("descripcion"));
		setValueBuffer("pvpunitario", curLineaAlbaran.valueBuffer("pvpunitario"));
		setValueBuffer("pvpsindto", curLineaAlbaran.valueBuffer("pvpsindto"));
		setValueBuffer("cantidad", curLineaAlbaran.valueBuffer("cantidad"));
		setValueBuffer("pvptotal", curLineaAlbaran.valueBuffer("pvptotal"));
		setValueBuffer("codimpuesto", curLineaAlbaran.valueBuffer("codimpuesto"));
		setValueBuffer("iva", curLineaAlbaran.valueBuffer("iva"));
		setValueBuffer("dtolineal", curLineaAlbaran.valueBuffer("dtolineal"));
		setValueBuffer("dtopor", curLineaAlbaran.valueBuffer("dtopor"));
		setValueBuffer("porcomision", curLineaAlbaran.valueBuffer("porcomision"));
		setValueBuffer("idalbaran", curLineaAlbaran.valueBuffer("idalbaran"));
	}
	return true;
}

/** \D Informa los datos de una factura referentes a totales (I.V.A., neto, etc.)
@return	True si el cálculo se realiza correctamente, false en caso contrario
\end */
function oficial_totalesFactura():Boolean
{
	with (this.iface.curFactura) {
		setValueBuffer("neto", formfacturascli.iface.pub_commonCalculateField("neto", this));
		setValueBuffer("totaliva", formfacturascli.iface.pub_commonCalculateField("totaliva", this));
		setValueBuffer("total", formfacturascli.iface.pub_commonCalculateField("total", this));
		setValueBuffer("totaleuros", formfacturascli.iface.pub_commonCalculateField("totaleuros", this));
		setValueBuffer("comision", formfacturascli.iface.pub_commonCalculateField("comision", this));
	}
	return true;
}

/** \D
Copia las líneas de un remito como líneas de su factura asociada
@param idAlbaran: Identificador del remito
@param idFactura: Identificador de la factura
@return	Verdadero si no hay error, falso en caso contrario
\end */
function oficial_copiaLineasAlbaran(idAlbaran:Number, idFactura:Number):Boolean
{
	var curLineaAlbaran:FLSqlCursor = new FLSqlCursor("lineasalbaranescli");
	curLineaAlbaran.select("idalbaran = " + idAlbaran);
	
	while (curLineaAlbaran.next()) {
		curLineaAlbaran.setModeAccess(curLineaAlbaran.Browse);
		if (!this.iface.copiaLineaAlbaran(curLineaAlbaran, idFactura))
			return false;
	}
	return true;
}

/** \D
Copia una línea de remito en su factura asociada
@param curLineaAlbaran: Cursor posicionado en la línea de remito a copiar
@param idFactura: Identificador de la factura
@return	Identificador de la línea de factura si no hay error, falso en caso contrario
\end */
function oficial_copiaLineaAlbaran(curLineaAlbaran:FLSqlCursor, idFactura:Number):Number
{
	if (!this.iface.curLineaFactura)
		this.iface.curLineaFactura = new FLSqlCursor("lineasfacturascli");
	
	with (this.iface.curLineaFactura) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idfactura", idFactura);
	}
	
	if (!this.iface.datosLineaFactura(curLineaAlbaran))
		return false;
		
	if (!this.iface.curLineaFactura.commitBuffer())
			return false;
	
	return this.iface.curLineaFactura.valueBuffer("idlinea");
}

function oficial_commonCalculateField(fN:String, cursor:FLSqlCursor):String
{
	var util:FLUtil = new FLUtil();
	var valor:String;

	/** \C
	El --código-- se construye como la concatenación de --codserie--, --codejercicio-- y --numero--
	\end */
	if (fN == "codigo")
			valor = flfacturac.iface.pub_construirCodigo(cursor.valueBuffer("codserie"), cursor.valueBuffer("codejercicio"), cursor.valueBuffer("numero"));

	switch (fN) {
		/** \C
		El --total-- es el --neto-- más el --totaliva--
		\end */
		case "total": {
			var neto:Number = parseFloat(cursor.valueBuffer("neto"));
			var totalIva:Number = parseFloat(cursor.valueBuffer("totaliva"));
			valor = neto + totalIva;
			valor = parseFloat(util.roundFieldValue(valor, "albaranescli", "total"));
			break;
		}
		case "comision": {
			valor = util.sqlSelect("lineasalbaranescli", "SUM((porcomision*pvptotal)/100)", "idalbaran = " + cursor.valueBuffer("idalbaran"));
			valor = parseFloat(util.roundFieldValue(valor, "albaranescli", "comision"));
			break;
		}
		/** \C
		El --totaleuros-- es el producto del --total-- por la --tasaconv--
		\end */
		case "totaleuros": {
			var total:Number = parseFloat(cursor.valueBuffer("total"));
			var tasaConv:Number = parseFloat(cursor.valueBuffer("tasaconv"));
			valor = total * tasaConv;
			valor = parseFloat(util.roundFieldValue(valor, "albaranescli", "totaleuros"));
			break;
		}
		/** \C
		El --neto-- es la suma del pvp total de las líneas de remito
		\end */
		case "neto": {
			valor = util.sqlSelect("lineasalbaranescli", "SUM(pvptotal)", "idalbaran = " + cursor.valueBuffer("idalbaran"));
			valor = parseFloat(util.roundFieldValue(valor, "albaranescli", "neto"));
			break;
		}
		/** \C
		El --totaliva-- es la suma del iva correspondiente a las líneas de remito
		\end */
		case "totaliva": {
			if (formfacturascli.iface.pub_sinIVA(cursor)) {
				valor = 0;
			} else {
				valor = util.sqlSelect("lineasalbaranescli", "SUM((pvptotal * iva) / 100)", "idalbaran = " + cursor.valueBuffer("idalbaran"));
			}
			valor = parseFloat(util.roundFieldValue(valor, "albaranescli", "totaliva"));
			break;
		}
		/** \C
		El --coddir-- corresponde a la dirección del cliente marcada como dirección de facturación
		\end */
		case "coddir": {
			valor = util.sqlSelect("dirclientes", "id", "codcliente = '" + cursor.valueBuffer("codcliente") + "' AND domenvio = 'true'");
			if (!valor) {
				valor = "";
			}
			break;
		}
		case "provincia": {
			valor = util.sqlSelect("dirclientes", "provincia", "id = " + cursor.valueBuffer("coddir"));
			if (!valor)
				valor = cursor.valueBuffer("provincia");
			break;
		}
		case "codpais": {
			valor = util.sqlSelect("dirclientes", "codpais", "id = " + cursor.valueBuffer("coddir"));
			if (!valor)
				valor = cursor.valueBuffer("codpais");
			break;
		}
		case "codtarifa": {
			valor = util.sqlSelect("clientes c INNER JOIN gruposclientes gc ON c.codgrupo = gc.codgrupo", "gc.codtarifa", "codcliente = '" + cursor.valueBuffer("codcliente") + "'", "clientes,gruposclientes");
			if (!valor)
				valor = "";
			break;
		}
	}
	return valor;
}

/** \C
Al pulsar el botón de asociar a remito se abre la ventana de agrupar pedidos de cliente
\end */
function oficial_asociarAAlbaran()
{
	var util:FLUtil = new FLUtil;
	var f:Object = new FLFormSearchDB("agruparpedidoscli");
	var cursor:FLSqlCursor = f.cursor();
	var where:String;
	var codCliente:String;
	var codAlmacen:String;

	cursor.setActivatedCheckIntegrity(false);
	cursor.select();
	if (!cursor.first())
			cursor.setModeAccess(cursor.Insert);
	else
			cursor.setModeAccess(cursor.Edit);

	f.setMainWidget();
	cursor.refreshBuffer();
	var acpt:String = f.exec("id");

	if (acpt) {
		cursor.commitBuffer();
		var curAgruparPedidos:FLSqlCursor = new FLSqlCursor("agruparpedidoscli");
		curAgruparPedidos.select();
		if (curAgruparPedidos.first()) {
				where = this.iface.whereAgrupacion(curAgruparPedidos);
				var excepciones = curAgruparPedidos.valueBuffer("excepciones");
				if (!excepciones.isEmpty())
						where += " AND idpedido NOT IN (" + excepciones + ")";

				var qryAgruparPedidos = new FLSqlQuery;
				qryAgruparPedidos.setTablesList("pedidoscli");
				qryAgruparPedidos.setSelect("codcliente,codalmacen");
				qryAgruparPedidos.setFrom("pedidoscli");
				qryAgruparPedidos.setWhere(where + " GROUP BY codcliente,codalmacen");
				if (!qryAgruparPedidos.exec())
						return;
						
				var totalClientes:Number = qryAgruparPedidos.size();
				util.createProgressDialog(util.translate("scripts", "Generando remitos"), totalClientes);
				util.setProgress(1);
				var j:Number = 0; 
				
				var curPedido :FLSqlCursor= new FLSqlCursor("pedidoscli");
				var whereAlbaran:String;
				var datosAgrupacion:Array = [];
				while (qryAgruparPedidos.next()) {
						codCliente = qryAgruparPedidos.value(0);
						codAlmacen = qryAgruparPedidos.value(1);
						whereAlbaran = where;
						if(codCliente && codCliente != "")
							whereAlbaran += " AND codcliente = '" + codCliente + "'";
						if(codAlmacen && codAlmacen != "")
							whereAlbaran += " AND codalmacen = '" + codAlmacen + "'";
						curPedido.transaction(false);
						try {
							curPedido.select(whereAlbaran);
							if (!curPedido.first()) {
								curPedido.rollback();
								util.destroyProgressDialog();
								return;
							}
			
							datosAgrupacion = this.iface.dameDatosAgrupacionPedidos(curAgruparPedidos);
							if (formpedidoscli.iface.pub_generarAlbaran(whereAlbaran, curPedido, datosAgrupacion)) {
							curPedido.commit();
							} else {
								curPedido.rollback();
								util.destroyProgressDialog();
								return;
							
							}
						} catch (e) {
							curPedido.rollback();
							MessageBox.critical(util.translate("scripts", "Error al generar el remito:") + e, MessageBox.Ok, MessageBox.NoButton);
						}
							util.setProgress(++j);
				}		
				util.setProgress(totalClientes);
				util.destroyProgressDialog();
			}
			f.close();
			this.iface.tdbRecords.refresh();
	}
}

/** \D
Construye un array con los datos del remito a generar especificados en el formulario de agrupación de pedidos
@param curAgruparPedidos: Cursor de la tabla agruparpedidoscli que contiene los valores
@return Array
\end */
function oficial_dameDatosAgrupacionPedidos(curAgruparPedidos:FLSqlCursor):Array
{
	var res:Array = [];
	res["fecha"] = curAgruparPedidos.valueBuffer("fecha");
	res["hora"] = curAgruparPedidos.valueBuffer("hora");
	return res;
}


/** \D
Construye la sentencia WHERE de la consulta que buscará los pedidos a agrupar
@param curAgrupar: Cursor de la tabla agruparpedidoscli que contiene los valores de los criterios de búsqueda
@return Sentencia where
\end */
function oficial_whereAgrupacion(curAgrupar:FLSqlCursor):String
{
		var codCliente:String = curAgrupar.valueBuffer("codcliente");
		var nombreCliente:String = curAgrupar.valueBuffer("nombrecliente");
		var cifNif:String = curAgrupar.valueBuffer("cifnif");
		var codAlmacen:String = curAgrupar.valueBuffer("codalmacen");
		var codPago:String = curAgrupar.valueBuffer("codpago");
		var codAgente:String = curAgrupar.valueBuffer("codagente");
		var codDivisa:String = curAgrupar.valueBuffer("coddivisa");
		var fechaDesde:String = curAgrupar.valueBuffer("fechadesde");
		var fechaHasta:String = curAgrupar.valueBuffer("fechahasta");
		var where:String = "servido <> 'Sí'";
		if (codCliente && !codCliente.isEmpty())
				where += " AND codcliente = '" + codCliente + "'";
		if (cifNif && !cifNif.isEmpty())
				where += " AND cifnif = '" + cifNif + "'";
		if (codAlmacen && !codAlmacen.isEmpty())
				where = where + " AND codalmacen = '" + codAlmacen + "'";
		where = where + " AND fecha >= '" + fechaDesde + "'";
		where = where + " AND fecha <= '" + fechaHasta + "'";
		if (codPago && !codPago.isEmpty() != "")
				where = where + " AND codpago = '" + codPago + "'";
		if (codAgente && !codAgente.isEmpty() != "")
				where = where + " AND codagente = '" + codAgente + "'";
		if (codDivisa && !codDivisa.isEmpty())
				where = where + " AND coddivisa = '" + codDivisa + "'";

		return where;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
function lotes_copiaLineaAlbaran(curLineaAlbaran:FLSqlCursor, idFactura:Number):Number
{
	var idLineaFactura:Number = this.iface.__copiaLineaAlbaran(curLineaAlbaran, idFactura);
	if (!idLineaFactura)
		return false;

	var util:FLUtil = new FLUtil();
	if (util.sqlSelect("articulos", "porlotes", "referencia = '" + curLineaAlbaran.valueBuffer("referencia") + "'")) {

		var idLineaAlbaran:Number = curLineaAlbaran.valueBuffer("idlinea");
		if(!idLineaAlbaran)
			return false;

		var hoy:Date = new Date();
		var fecha:String = hoy.toString();

		var cant:Number;
		var curMoviLoteOrigen:FLSqlCursor = new FLSqlCursor("movilote");
		var curMoviLoteAutomatico:FLSqlCursor = new FLSqlCursor("movilote");

		curMoviLoteOrigen.select("idlineaac = " + idLineaAlbaran);
		while(curMoviLoteOrigen.next()) {

			cant = curMoviLoteOrigen.valueBuffer("cantidad") - curMoviLoteOrigen.valueBuffer("cantidad_automatica");
			if (cant != 0) {
				with (curMoviLoteAutomatico) {
					setModeAccess(Insert);
					refreshBuffer();
					setValueBuffer("codlote", curMoviLoteOrigen.valueBuffer("codlote"));
					setValueBuffer("idstock", curMoviLoteOrigen.valueBuffer("idstock"));
					setValueBuffer("cantidad", cant);
					setValueBuffer("descripcion", curMoviLoteOrigen.valueBuffer("descripcion"));
					setValueBuffer("fecha", fecha);
					setValueBuffer("tipo", "Salida");
					setValueBuffer("docorigen", "FC");
					setValueBuffer("idlineafc", idLineaFactura);
	
					setValueBuffer("automatico", true);
					setValueBuffer("idmovilote_orig", curMoviLoteOrigen.valueBuffer("id"));
	
					if (!commitBuffer())
						return false;
				}
	
				cant += curMoviLoteOrigen.valueBuffer("cantidad_automatica");
				with (curMoviLoteOrigen) {
					setModeAccess(Edit);
					refreshBuffer();
					setValueBuffer("cantidad_automatica", cant);
					if (!commitBuffer())
						return false;
				}
			}
		}
	}

	return idLineaFactura;
}
//// LOTES /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ivaIncluido */
//////////////////////////////////////////////////////////////////
//// IVAINCLUIDO /////////////////////////////////////////////////////
/** \D Copia los datos de una línea de remito en una línea de factura
@param	curLineaAlbaran: Cursor que contiene los datos a incluir en la línea de factura
@return	True si la copia se realiza correctamente, false en caso contrario
\end */
function ivaIncluido_datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean
{
	if(!this.iface.__datosLineaFactura(curLineaAlbaran))
		return false;

	with (this.iface.curLineaFactura) {
		setValueBuffer("ivaincluido", curLineaAlbaran.valueBuffer("ivaincluido"));
		setValueBuffer("pvpunitarioiva", curLineaAlbaran.valueBuffer("pvpunitarioiva"));
	}
	return true;
}


//// IVAINCLUIDO /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_definition fluxEcommerce */
/////////////////////////////////////////////////////////////////
//// FLUX ECOMMERCE //////////////////////////////////////////////////////

function fluxEcommerce_datosFactura(curAlbaran:FLSqlCursor,where:String,datosAgrupacion:Array):Boolean
{
	if (!this.iface.__datosFactura(curAlbaran, where, datosAgrupacion))
		return false;
		
	var codDirEnv:Number;
	with (this.iface.curFactura) {
		setValueBuffer("nombre", curAlbaran.valueBuffer("nombre"));
		setValueBuffer("apellidos", curAlbaran.valueBuffer("apellidos"));
		setValueBuffer("empresa", curAlbaran.valueBuffer("empresa"));
		if (codDirEnv == 0) {
			setNull("coddirenv");
		} else {
			setValueBuffer("coddirenv", curPedido.valueBuffer("coddirenv"));
		}
		setValueBuffer("nombreenv", curAlbaran.valueBuffer("nombreenv"));
		setValueBuffer("apellidosenv", curAlbaran.valueBuffer("apellidosenv"));
		setValueBuffer("empresaenv", curAlbaran.valueBuffer("empresaenv"));
		setValueBuffer("direccionenv", curAlbaran.valueBuffer("direccionenv"));
		setValueBuffer("codpostalenv", curAlbaran.valueBuffer("codpostalenv"));
		setValueBuffer("ciudadenv", curAlbaran.valueBuffer("ciudadenv"));
		setValueBuffer("provinciaenv", curAlbaran.valueBuffer("provinciaenv"));
		setValueBuffer("apartadoenv", curAlbaran.valueBuffer("apartadoenv"));
		setValueBuffer("codpaisenv", curAlbaran.valueBuffer("codpaisenv"));
		setValueBuffer("codenvio", curAlbaran.valueBuffer("codenvio"));
	}
	
	return true;
}

//// FLUX ECOMMERCE //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition funNumSerie */
/////////////////////////////////////////////////////////////////
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////

/** \D Copia los datos de una línea de remito en una línea de factura
@param	curLineaAlbaran: Cursor que contiene los datos a incluir en la línea de factura
@return	True si la copia se realiza correctamente, false en caso contrario
\end */
function funNumSerie_datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean
{
	if(!this.iface.__datosLineaFactura(curLineaAlbaran))
		return false;

	with (this.iface.curLineaFactura) {
		setValueBuffer("numserie", curLineaAlbaran.valueBuffer("numserie"));
	}
	return true;
}

//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition funNumAcomp */
/////////////////////////////////////////////////////////////////
//// FUN_NUM_ACOMP /////////////////////////////////////////////////

/** \D Si la línea es de un compuesto, crea las líneas de factura por NS si procede
@param	curLineaAlbaran: Cursor que contiene los datos a incluir en la línea de factura
@return	True si la copia se realiza correctamente, false en caso contrario
\end */
function funNumAcomp_copiaLineaAlbaran(curLineaAlbaran:FLSqlCursor, idFactura:Number):Number
{
	var idLinea = this.iface.__copiaLineaAlbaran(curLineaAlbaran, idFactura);
	if(!idLinea)
		return false;
	
	var util:FLUtil = new FLUtil;
	
	var curLNA:FLSqlCursor = new FLSqlCursor("lineasalbaranesclins");
	var curLNF:FLSqlCursor = new FLSqlCursor("lineasfacturasclins");
	
	curLNA.select("idlineaalbaran = " + curLineaAlbaran.valueBuffer("idlinea"));
	while(curLNA.next()) {
		
		if (!curLNA.valueBuffer("numserie")) {
			MessageBox.warning(util.translate("scripts", "No es posible generar la factura.\n\nEl remito contiene componentes de artículos compuestos\ncuyo número de serie no se ha establecido"), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
		
		curLNF.setModeAccess(curLNF.Insert);
		curLNF.refreshBuffer();
		curLNF.setValueBuffer("idlineafactura", idLinea);
		curLNF.setValueBuffer("referencia", curLNA.valueBuffer("referencia"));
		curLNF.setValueBuffer("numserie", curLNA.valueBuffer("numserie"));
 		curLNF.commitBuffer();
	}
	
	return true;
}

//// FUN_NUM_ACOMP /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition fechas */
/////////////////////////////////////////////////////////////////
//// FECHAS /////////////////////////////////////////////////////

function fechas_init()
{
	this.iface.__init();

	this.iface.fechaDesde = this.child("dateFrom");
	this.iface.fechaHasta = this.child("dateTo");

	var d = new Date();
	this.iface.fechaDesde.date = new Date(d.getYear(), d.getMonth(), 1);
	this.iface.fechaHasta.date = new Date();

	connect(this.iface.fechaDesde, "valueChanged(const QDate&)", this, "iface.actualizarFiltro");
	connect(this.iface.fechaHasta, "valueChanged(const QDate&)", this, "iface.actualizarFiltro");

	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	if (codEjercicio) {
		this.iface.ejercicio = codEjercicio;
		this.iface.actualizarFiltro();
	}

	this.iface.procesarEstado();
}

function fechas_actualizarFiltro()
{
	var desde:String = this.iface.fechaDesde.date.toString().left(10);
	var hasta:String = this.iface.fechaHasta.date.toString().left(10);

	if (desde == "" || hasta == "")
		return;

	this.cursor().setMainFilter("codejercicio = '" + this.iface.ejercicio + "' AND  fecha >= '" + desde + "' AND fecha <= '" + hasta + "'");

	this.iface.tdbRecords.refresh();
	this.cursor().last();
	this.iface.tdbRecords.setCurrentRow(this.cursor().at());
}

//// FECHAS /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition lineasArticulos */
/////////////////////////////////////////////////////////////////
//// LINEAS_ARTICULOS ///////////////////////////////////////////

function lineasArticulos_datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean
{
	if(!this.iface.__datosLineaFactura(curLineaAlbaran))
		return false;

	with (this.iface.curLineaFactura) {
		setValueBuffer("idlineaalbaran", curLineaAlbaran.valueBuffer("idlinea"));
	}
	return true;
}

//// LINEAS_ARTICULOS ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition totalesIva */
/////////////////////////////////////////////////////////////////
//// TOTALES CON IVA ////////////////////////////////////////////

function totalesIva_datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean
{
	if(!this.iface.__datosLineaFactura(curLineaAlbaran))
		return false;

	with (this.iface.curLineaFactura) {
		setValueBuffer("totalconiva", curLineaAlbaran.valueBuffer("totalconiva"));
	}
	return true;
}

//// TOTALES CON IVA ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition silixExtensiones */
/////////////////////////////////////////////////////////////////
//// SILIX EXTENSIONES //////////////////////////////////////////

function silixExtensiones_datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean
{
	if(!this.iface.__datosLineaFactura(curLineaAlbaran))
		return false;

	var util:FLUtil = new FLUtil;

	var cantidad:Number = parseFloat(curLineaAlbaran.valueBuffer("cantidad")) - parseFloat(curLineaAlbaran.valueBuffer("totalenfactura"));
	
	var pvpSinDto:Number = parseFloat(curLineaAlbaran.valueBuffer("pvpsindto")) * cantidad / parseFloat(curLineaAlbaran.valueBuffer("cantidad"));
	pvpSinDto = util.roundFieldValue(pvpSinDto, "lineasfacturascli", "pvpsindto");

	with (this.iface.curLineaFactura) {
		setValueBuffer("cantidad", cantidad);
		setValueBuffer("pvpsindto", pvpSinDto);
		setValueBuffer("pvptotal", formRecordlineaspedidoscli.iface.pub_commonCalculateField("pvptotal", this));
	}

	return true;
}

/** \D
Copia las líneas de un remito como líneas de su factura asociada. Chequea la cantidad servida
@param idAlbaran: Identificador del remito
@param idFactura: Identificador de la factura
@return	Verdadero si no hay error, falso en caso contrario
\end */
function silixExtensiones_copiaLineasAlbaran(idAlbaran:Number, idFactura:Number):Boolean
{
	var util:FLUtil = new FLUtil;
	var cantidad:Number;
	var totalEnFactura:Number;
	var curLineaAlbaran:FLSqlCursor = new FLSqlCursor("lineasalbaranescli");
	curLineaAlbaran.select("idalbaran = " + idAlbaran + " AND (cerrada = false or cerrada IS NULL)");
	
	while (curLineaAlbaran.next()) {
		curLineaAlbaran.setModeAccess(curLineaAlbaran.Browse);
		curLineaAlbaran.refreshBuffer();
		cantidad = parseFloat(curLineaAlbaran.valueBuffer("cantidad"));
		totalEnFactura = parseFloat(curLineaAlbaran.valueBuffer("totalenfactura"));

		if (cantidad > totalEnFactura) {
			if (!this.iface.copiaLineaAlbaran(curLineaAlbaran, idFactura))
				return false;
		}
	}
	return true;
}

//// SILIX EXTENSIONES //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition impresiones */
/////////////////////////////////////////////////////////////////
//// IMPRESIONES ////////////////////////////////////////////////

function impresiones_init()
{
	this.iface.__init();

	this.iface.tbnImprimir = this.child("toolButtonPrint");
	this.iface.tbnImprimirQuick = this.child("tbnPrintQuick");

	connect(this.iface.tbnImprimir, "clicked()", this, "iface.imprimir");
	connect(this.iface.tbnImprimirQuick, "clicked()", this, "iface.imprimirQuick");
}

function impresiones_imprimir(codAlbaran:String)
{
	if (sys.isLoadedModule("flfactinfo")) {
		var util:FLUtil = new FLUtil;
		var codigo:String;
		var idAlbaran:Number;
		if (codAlbaran) {
			codigo = codAlbaran;
			idAlbaran = util.sqlSelect("albaranescli", "idalbaran", "codigo = '" + codAlbaran + "'");
		}
		else {
			if (!this.cursor().isValid())
				return;
			codigo = this.cursor().valueBuffer("codigo");
			idAlbaran = this.cursor().valueBuffer("idalbaran");
		}

		var idLinea:Number = util.sqlSelect("lineasalbaranescli", "idlinea", "idalbaran = " + idAlbaran + " AND idlineapedido <> 0");

		var dialog:Dialog = new Dialog(util.translate ( "scripts", "Imprimir Remito" ), 0, "imprimir");

		dialog.OKButtonText = util.translate ( "scripts", "Aceptar" );
		dialog.cancelButtonText = util.translate ( "scripts", "Cancelar" );

		var text:Object = new Label;
		text.text = util.translate("scripts","Remito: ") + codigo;
		dialog.add(text);

		var bgroup:GroupBox = new GroupBox;
		bgroup.title = util.translate("scripts", "Opciones");
		dialog.add( bgroup );

		if ( util.sqlSelect("servicioscli", "idservicio", "idalbaran = " + idAlbaran) ) {
			var impServicio:RadioButton = new RadioButton;
			impServicio.text = util.translate ( "scripts", "Imprimir Servicio" );
			impServicio.checked = false;
			bgroup.add( impServicio );
		}

		var impRemito:RadioButton = new RadioButton;
		impRemito.text = util.translate ( "scripts", "Imprimir Remito" );
		impRemito.checked = true;
		bgroup.add( impRemito );

		var impComponentes:CheckBox = new CheckBox;
		impComponentes.text = util.translate ( "scripts", "Imprimir artículos con sus componentes" );
		impComponentes.checked = flfactppal.iface.pub_valorDefectoEmpresa("imprimircomponentes");
		bgroup.add( impComponentes );

		var impNumSerie:CheckBox = new CheckBox;
		impNumSerie.text = util.translate ( "scripts", "Imprimir números de serie" );
		impNumSerie.checked = flfactppal.iface.pub_valorDefectoEmpresa("imprimirnumserie");
		bgroup.add( impNumSerie );

		if ( !dialog.exec() )
			return true;

		var nombreInforme:String;
		var numCopias:Number = flfactppal.iface.pub_valorDefectoEmpresa("copiasalbaran");
		if (!numCopias)
			numCopias = 1;

		if ( impRemito.checked == true) {

			if ( impComponentes.checked == true ) {
				if ( impNumSerie.checked == true ) {
					nombreInforme = "i_albaranesclicomp_ns";
					flfactinfo.iface.pub_crearTabla("AC", idAlbaran);
				} else {
					if (idLinea)
						nombreInforme = "i_albaranesclicomp_auto";
					else
						nombreInforme = "i_albaranesclicomp";
					flfactinfo.iface.pub_crearTabla("AC", idAlbaran);
				}
			} else {
				if ( impNumSerie.checked == true ) {
					nombreInforme = "i_albaranescli_ns";
				} else {
					if (idLinea)
						nombreInforme = "i_albaranescli_auto";
					else
						nombreInforme = "i_albaranescli";
				}
			}
		}
		else {
			nombreInforme = "i_albaranescli_serv";
		}

		var curImprimir:FLSqlCursor = new FLSqlCursor("i_albaranescli");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_albaranescli_codigo", codigo);
		curImprimir.setValueBuffer("h_albaranescli_codigo", codigo);

		flfactinfo.iface.pub_lanzarInforme(curImprimir, nombreInforme, "", "", false, false, "", nombreInforme, numCopias);
	} else
		flfactppal.iface.pub_msgNoDisponible("Informes");
}

function impresiones_imprimirQuick(codAlbaran:String, impresora:String)
{
	if (sys.isLoadedModule("flfactinfo")) {
		var util:FLUtil = new FLUtil;
		var codigo:String;
		var idAlbaran:Number;
		if (codAlbaran) {
			codigo = codAlbaran;
			idAlbaran = util.sqlSelect("albaranescli", "idalbaran", "codigo = '" + codAlbaran + "'");
		}
		else {
			if (!this.cursor().isValid())
				return;
			codigo = this.cursor().valueBuffer("codigo");
			idAlbaran = this.cursor().valueBuffer("idalbaran");
		}

		var idLinea:Number = util.sqlSelect("lineasalbaranescli", "idlinea", "idalbaran = " + idAlbaran + " AND idlineapedido <> 0");

		var impComponentes:Boolean = flfactppal.iface.pub_valorDefectoEmpresa("imprimircomponentes");
		var impNumSerie:Boolean = flfactppal.iface.pub_valorDefectoEmpresa("imprimirnumserie");
		var impDirecta:Boolean = true;

		var nombreInforme:String;
		var numCopias:Number = flfactppal.iface.pub_valorDefectoEmpresa("copiasalbaran");
		if (!numCopias)
			numCopias = 1;

		if ( impComponentes == true ) {
			if ( impNumSerie == true ) {
				nombreInforme = "i_albaranesclicomp_ns";
				flfactinfo.iface.pub_crearTabla("AC", idAlbaran);
			} else {
				if (idLinea)
					nombreInforme = "i_albaranesclicomp_auto";
				else
					nombreInforme = "i_albaranesclicomp";
				flfactinfo.iface.pub_crearTabla("AC", idAlbaran);
			}
		} else {
			if ( impNumSerie == true ) {
				nombreInforme = "i_albaranescli_ns";
			} else {
				if (idLinea)
					nombreInforme = "i_albaranescli_auto";
				else
					nombreInforme = "i_albaranescli";
			}
		}

		var curImprimir:FLSqlCursor = new FLSqlCursor("i_albaranescli");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_albaranescli_codigo", codigo);
		curImprimir.setValueBuffer("h_albaranescli_codigo", codigo);

		flfactinfo.iface.pub_lanzarInforme(curImprimir, nombreInforme, "", "", false, impDirecta, "", nombreInforme, numCopias, impresora);
	} else
		flfactppal.iface.pub_msgNoDisponible("Informes");
}

//// IMPRESIONES ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ordenCampos */
/////////////////////////////////////////////////////////////////
//// ORDEN_CAMPOS ///////////////////////////////////////////////

function ordenCampos_init()
{
	this.iface.__init();

	var orden:Array = [ "codigo", "tipoventa", "servido", "ptefactura", "nombrecliente", "neto", "totaliva", "totalpie", "total", "coddivisa", "tasaconv", "totaleuros", "fecha", "hora", "codserie", "numero", "codejercicio", "codalmacen", "codpago", "codtarifa", "codenvio", "codcliente", "cifnif", "direccion", "codpostal", "ciudad", "provincia", "codpais", "nombre", "apellidos", "empresa", "codagente", "comision", "tpv", "costototal", "ganancia", "utilidad", "idusuario", "observaciones" ];

	this.iface.tdbRecords.setOrderCols(orden);
	this.iface.tdbRecords.setFocus();
}

//// ORDEN_CAMPOS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition tipoVenta */
//////////////////////////////////////////////////////////////////
//// TIPO VENTA //////////////////////////////////////////////////

function tipoVenta_datosFactura(curAlbaran:FLSqlCursor, where:String, datosAgrupacion:Array):Boolean
{
	if (!this.iface.__datosFactura(curAlbaran, where, datosAgrupacion))
		return false;

	var util:FLUtil = new FLUtil();
	
	var tipoVenta:String, codSerie:String;
	var regimenIva:Boolean = util.sqlSelect("clientes", "regimeniva", "codcliente = '" + curAlbaran.valueBuffer("codcliente") + "'");
	switch ( regimenIva ) {
		case "Consumidor Final":
		case "Exento":
		case "No Responsable":
		case "Responsable Monotributo": {
			tipoVenta = "Factura B";
			codSerie = flfactppal.iface.pub_valorDefectoEmpresa("codserie_b");
			break;
		}
		case "Responsable Inscripto":
		case "Responsable No Inscripto": {
			tipoVenta = "Factura A";
			codSerie = flfactppal.iface.pub_valorDefectoEmpresa("codserie_a");
			break;
		}
	}

	with (this.iface.curFactura) {
		setValueBuffer("tipoventa", tipoVenta);
		setValueBuffer("codserie", codSerie);
	}
	return true;
}

//// TIPO VENTA //////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition pieDocumento */
//////////////////////////////////////////////////////////////////
//// PIE DE DOCUMENTO ////////////////////////////////////////////

function pieDocumento_commonCalculateField(fN:String, cursor:FLSqlCursor):String
{
	var util:FLUtil = new FLUtil();
	var valor:String;
	switch (fN) {
		case "totalpie": {
			var totalLineas:Number = parseFloat(util.sqlSelect("piealbaranescli", "SUM(totalinc)", "idalbaran = " + cursor.valueBuffer("idalbaran") + " AND incluidoneto = false"));
			if (!totalLineas || isNaN(totalLineas))
				totalLineas = 0;
			valor = totalLineas;
			break;
		}
		case "total": {
			var totalPie:Number = parseFloat(cursor.valueBuffer("totalpie"));
			valor = this.iface.__commonCalculateField(fN, cursor);
			valor += totalPie;
			valor = parseFloat(util.roundFieldValue(valor, "albaranescli", "total"));
			break;
		}
		case "neto": {
			var netoPie:Number = parseFloat(util.sqlSelect("piealbaranescli", "SUM(totalinc)", "idalbaran = " + cursor.valueBuffer("idalbaran") + " AND incluidoneto = true"));
			valor = this.iface.__commonCalculateField(fN, cursor);
			valor += netoPie;
			valor = parseFloat(util.roundFieldValue(valor, "albaranescli", "neto"));
			break;
		}
		case "totaliva": {
			if (formfacturascli.iface.pub_sinIVA(cursor))
				valor = 0;
			else {
				var ivaPie:Number = parseFloat(util.sqlSelect("piealbaranescli", "SUM(totaliva)", "idalbaran = " + cursor.valueBuffer("idalbaran") + " AND incluidoneto = true"));
				valor = this.iface.__commonCalculateField(fN, cursor);
				valor += ivaPie;
			}
			valor = parseFloat(util.roundFieldValue(valor, "albaranescli", "totaliva"));
			break;
		}
		default:{
			valor = this.iface.__commonCalculateField(fN, cursor);
			break;
		}
	}
	return valor;
}

function pieDocumento_copiaPiesAlbaran(idAlbaran:Number, idFactura:Number):Boolean
{
	var curPieAlbaran:FLSqlCursor = new FLSqlCursor("piealbaranescli");
	curPieAlbaran.select("idalbaran = " + idAlbaran);
	
	while (curPieAlbaran.next()) {
		curPieAlbaran.setModeAccess(curPieAlbaran.Browse);
		if (!this.iface.copiaPieAlbaran(curPieAlbaran, idFactura))
			return false;
	}
	return true;
}

function pieDocumento_copiaPieAlbaran(curPieAlbaran:FLSqlCursor, idFactura:Number):Number
{
	if (!this.iface.curPieFactura)
		this.iface.curPieFactura = new FLSqlCursor("piefacturascli");
	
	with (this.iface.curPieFactura) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idfactura", idFactura);
	}
	
	if (!this.iface.datosPieFactura(curPieAlbaran))
		return false;
		
	if (!this.iface.curPieFactura.commitBuffer())
		return false;
	
	return this.iface.curPieFactura.valueBuffer("idpie");
}

function pieDocumento_datosPieFactura(curPieAlbaran:FLSqlCursor):Boolean
{
	with (this.iface.curPieFactura) {
		setValueBuffer("codpie", curPieAlbaran.valueBuffer("codpie"));
		setValueBuffer("descripcion", curPieAlbaran.valueBuffer("descripcion"));
		setValueBuffer("baseimponible", curPieAlbaran.valueBuffer("baseimponible"));
		setValueBuffer("incporcentual", curPieAlbaran.valueBuffer("incporcentual"));
		setValueBuffer("inclineal", curPieAlbaran.valueBuffer("inclineal"));
		setValueBuffer("totalinc", curPieAlbaran.valueBuffer("totalinc"));
		setValueBuffer("incluidoneto", curPieAlbaran.valueBuffer("incluidoneto"));
		setValueBuffer("totaliva", curPieAlbaran.valueBuffer("totaliva"));
		setValueBuffer("totallinea", curPieAlbaran.valueBuffer("totallinea"));
	}
	return true;
}

function pieDocumento_datosFactura(curAlbaran:FLSqlCursor, where:String, datosAgrupacion:Array):Boolean
{
	if (!this.iface.__datosFactura(curAlbaran, where, datosAgrupacion))
		return false;

	with (this.iface.curFactura) {
		setValueBuffer("totalpie", curAlbaran.valueBuffer("totalpie"));
	}
	return true;
}

//// PIE DE DOCUMENTO ////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition periodosFiscales */
//////////////////////////////////////////////////////////////////
//// PERIODOS FISCALES ///////////////////////////////////////////

function periodosFiscales_datosFactura(curAlbaran:FLSqlCursor, where:String, datosAgrupacion:Array):Boolean
{
	if (!this.iface.__datosFactura(curAlbaran, where, datosAgrupacion))
		return false;

	var util:FLUtil = new FLUtil();
	var codPeriodo:String;

	if (datosAgrupacion) {
		codPeriodo = datosAgrupacion["codperiodo"];
		if (!codPeriodo) {
			MessageBox.warning(util.translate("scripts", "Debe indicar el período fiscal al que se imputa la factura"), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	} else {
		var fecha:String = this.iface.curFactura.valueBuffer("fecha");
		codPeriodo = util.sqlSelect("periodos", "codperiodo", "fechainicio <= '" + fecha + "' AND fechafin >= '" + fecha + "' AND codejercicio = '" + this.iface.curFactura.valueBuffer("codejercicio") + "'");
		if (!codPeriodo) {
			MessageBox.warning(util.translate("scripts", "No hay abierto un período fiscal para esta fecha.\nDebe crear un nuevo período fiscal para el ejercicio actual."), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	}

	var estado:String = util.sqlSelect("periodos", "estado", "codperiodo = '" + codPeriodo + "'");
	if (estado == "CERRADO") {
		MessageBox.warning(util.translate("scripts", "El período fiscal para esta fecha ya está cerrado.\nDebe crear un nuevo período fiscal para el ejercicio actual."), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	with (this.iface.curFactura) {
		setValueBuffer("codperiodo", codPeriodo);
	}
	return true;
}

//// PERIODOS FISCALES ///////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////