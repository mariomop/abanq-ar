/***************************************************************************
                 masterpresupuestoscli.qs  -  description
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
	var pbnGPedido:Object;
	var tdbRecords:FLTableDB;
	var tbnDuplicarPres:Object;
	var curPedido:FLSqlCursor;
	var curLineaPedido:FLSqlCursor;
	var curPresupuesto_:FLSqlCursor;
	var curLineaPres_:FLSqlCursor;

    function oficial( context ) { interna( context ); } 
	function procesarEstado() {
		return this.ctx.oficial_procesarEstado();
	}
	function pbnGenerarPedido_clicked() {
		return this.ctx.oficial_pbnGenerarPedido_clicked();
	}
	function generarPedido(cursor:FLSqlCursor):Number {
		return this.ctx.oficial_generarPedido(cursor);
	}
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.oficial_commonCalculateField(fN, cursor);
	}
	function copiaLineas(idPresupuesto:Number, idPedido:Number):Boolean {
		return this.ctx.oficial_copiaLineas(idPresupuesto, idPedido);
	}
	function copiaLineaPresupuesto(curLineaPresupuesto:FLSqlCursor, idPedido:Number):Number {
		return this.ctx.oficial_copiaLineaPresupuesto(curLineaPresupuesto, idPedido);
	}
	function totalesPedido():Boolean {
		return this.ctx.oficial_totalesPedido();
	}
	function datosPedido(curPresupuesto:FLSqlCursor):Boolean {
		return this.ctx.oficial_datosPedido(curPresupuesto);
	}
	function datosLineaPedido(curLineaPresupuesto:FLSqlCursor):Boolean {
		return this.ctx.oficial_datosLineaPedido(curLineaPresupuesto);
	}
	function duplicarPresupuesto_clicked() {
		return this.ctx.oficial_duplicarPresupuesto_clicked();
	}
	function duplicarPresupuesto(curOrigen:FLSqlCursor):String {
		return this.ctx.oficial_duplicarPresupuesto(curOrigen);
	}
	function copiarCampoPresupuesto(nombreCampo:String, cursor:FLSqlCursor, campoInformado:Array):Boolean {
		return this.ctx.oficial_copiarCampoPresupuesto(nombreCampo, cursor, campoInformado);
	}
	function duplicarHijosPresupuesto(idPresOrigen:String, idPresDestino:String):Boolean {
		return this.ctx.oficial_duplicarHijosPresupuesto(idPresOrigen, idPresDestino);
	}
	function duplicarLineasPresupuesto(idPresOrigen:String, idPresDestino:String):String {
		return this.ctx.oficial_duplicarLineasPresupuesto(idPresOrigen, idPresDestino);
	}
	function copiarCampoLineaPresupuesto(nombreCampo:String, cursor:FLSqlCursor, campoInformado:Array):Boolean {
		return this.ctx.oficial_copiarCampoLineaPresupuesto(nombreCampo, cursor, campoInformado);
	}
}

//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
class lotes extends oficial {
    function lotes( context ) { oficial ( context ); }
	function copiaLineaPresupuesto(curLineaPresupuesto:FLSqlCursor, idPedido:Number):Number {
		return this.ctx.lotes_copiaLineaPresupuesto(curLineaPresupuesto, idPedido);
	}
}
//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ivaIncluido */
//////////////////////////////////////////////////////////////////
//// IVAINCLUIDO /////////////////////////////////////////////////////
class ivaIncluido extends lotes {
    function ivaIncluido( context ) { lotes( context ); } 	
	function datosLineaPedido(curLineaPresupuesto:FLSqlCursor):Boolean {
		return this.ctx.ivaIncluido_datosLineaPedido(curLineaPresupuesto);
	}
}
//// IVAINCLUIDO /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration fechas */
/////////////////////////////////////////////////////////////////
//// FECHAS /////////////////////////////////////////////////
class fechas extends ivaIncluido {
	var fechaDesde:Object;
	var fechaHasta:Object;

    function fechas( context ) { ivaIncluido ( context ); }
	function init() {
		this.ctx.fechas_init();
	}
	function actualizarFiltro() {
		return this.ctx.fechas_actualizarFiltro();
	}
}
//// FECHAS /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_declaration totalesIva */
/////////////////////////////////////////////////////////////////
//// TOTALES CON IVA ////////////////////////////////////////////
class totalesIva extends fechas {
    function totalesIva( context ) { fechas ( context ); }
	function datosLineaPedido(curLineaPresupuesto:FLSqlCursor):Boolean {
		return this.ctx.totalesIva_datosLineaPedido(curLineaPresupuesto);
	}
}
//// TOTALES CON IVA ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_declaration impresiones */
/////////////////////////////////////////////////////////////////
//// IMPRESIONES ////////////////////////////////////////////////
class impresiones extends totalesIva {
	var tbnImprimir:Object;
	var tbnImprimirQuick:Object;

    function impresiones( context ) { totalesIva ( context ); }
	function init() { this.ctx.impresiones_init(); }
	function imprimir(codPresupuesto:String) {
		return this.ctx.impresiones_imprimir(codPresupuesto);
	}
	function imprimirQuick(codPresupuesto:String, impresora:String) {
		return this.ctx.impresiones_imprimirQuick(codPresupuesto, impresora);
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
	function datosPedido(curPresupuesto:FLSqlCursor):Boolean {
		return this.ctx.tipoVenta_datosPedido(curPresupuesto);
	}
}
//// TIPO DE VENTA  /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pieDocumento */
/////////////////////////////////////////////////////////////////
//// PIE DE DOCUMENTO ///////////////////////////////////////////
class pieDocumento extends tipoVenta {
	var curPiePedido:FLSqlCursor;

	function pieDocumento( context ) { tipoVenta ( context ); }
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.pieDocumento_commonCalculateField(fN, cursor);
	}
	function copiaPiesPresupuesto(idPresupuesto:Number, idPedido:Number):Boolean {
		return this.ctx.pieDocumento_copiaPiesPresupuesto(idPresupuesto, idPedido);
	}
	function copiaPiePresupuesto(curPiePresupuesto:FLSqlCursor, idPedido:Number):Number {
		return this.ctx.pieDocumento_copiaPiePresupuesto(curPiePresupuesto, idPedido);
	}
	function datosPiePedido(curPiePresupuesto:FLSqlCursor):Boolean {
		return this.ctx.pieDocumento_datosPiePedido(curPiePresupuesto);
	}
	function datosPedido(curPresupuesto:FLSqlCursor):Boolean {
		return this.ctx.pieDocumento_datosPedido(curPresupuesto);
	}
}
//// PIE DE DOCUMENTO  //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends pieDocumento {
    function head( context ) { pieDocumento ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
	function pub_commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.commonCalculateField(fN, cursor);
	}
	function pub_imprimir(codPresupuesto:String) {
		return this.imprimir(codPresupuesto);
	}
	function pub_imprimirQuick(codPresupuesto:String, impresora:String) {
		return this.imprimirQuick(codPresupuesto, impresora);
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
/** \C
Este es el formulario maestro de presupuestos a cliente.
\end */
function interna_init()
{
	this.iface.pbnGPedido = this.child("pbnGenerarPedido");
	this.iface.tdbRecords= this.child("tableDBRecords");
	this.iface.tbnDuplicarPres = this.child("tbnDuplicarPres");

	connect(this.iface.pbnGPedido, "clicked()", this, "iface.pbnGenerarPedido_clicked");
	connect(this.iface.tdbRecords, "currentChanged()", this, "iface.procesarEstado");
	connect(this.iface.tbnDuplicarPres, "clicked()", this, "iface.duplicarPresupuesto_clicked");

	this.iface.procesarEstado();
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_procesarEstado()
{
	if (this.cursor().isValid() && this.cursor().valueBuffer("editable") == true)
		this.iface.pbnGPedido.enabled = true;
	else
		this.iface.pbnGPedido.enabled = false;
}

/** \C
Al pulsar el botón de generar pedido se creará el remito correspondiente al presupuesto seleccionado.
\end */
function oficial_pbnGenerarPedido_clicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	if (!this.cursor().isValid()) {
		this.iface.procesarEstado();
		return;
	}
	if (cursor.valueBuffer("editable") == false) {
		MessageBox.warning(util.translate("scripts", "El presupuesto ya está aprobado"), MessageBox.Ok, MessageBox.NoButton);
		this.iface.procesarEstado();
		return;
	}
	var res:Number = MessageBox.warning(util.translate("scripts", "Se generará un pedido a partir del presupuesto seleccionado.\n¿Desea continuar?"), MessageBox.Yes, MessageBox.No);
	if (res != MessageBox.Yes)
		return;

	this.iface.pbnGPedido.setEnabled(false);

	cursor.transaction(false);
	try {
		if (this.iface.generarPedido(cursor))
			cursor.commit();
		else
			cursor.rollback();
	}
	catch (e) {
		cursor.rollback();
		MessageBox.critical(util.translate("scripts", "Hubo un error en la generación del pedido:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
	}

	this.iface.tdbRecords.refresh();
	this.iface.procesarEstado();
}

/** \D
Genera el pedido asociado a un presupuesto
@param cursor: Cursor con los datos principales que se copiarán del presupuesto al pedido
@return True: Copia realizada con éxito, False: Error
\end */
function oficial_generarPedido(curPresupuesto:FLSqlCursor):Number
{
	var util:FLUtil = new FLUtil();
	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Generando pedido..." ), 11 );

	if (!this.iface.curPedido)
		this.iface.curPedido = new FLSqlCursor("pedidoscli");
	
	util.setProgress( ++paso );
	
	var idPresupuesto:String = curPresupuesto.valueBuffer("idpresupuesto");
	
	this.iface.curPedido.setModeAccess(this.iface.curPedido.Insert);
	this.iface.curPedido.refreshBuffer();
	this.iface.curPedido.setValueBuffer("idpresupuesto", idPresupuesto);
	
	util.setProgress( ++paso );
	
	if (!this.iface.datosPedido(curPresupuesto)) {
		util.destroyProgressDialog();
		return false;
	}
	
	util.setProgress( ++paso );
	
	if (!this.iface.curPedido.commitBuffer()) {
		util.destroyProgressDialog();
		return false;
	}
	
	util.setProgress( ++paso );
	
	var idPedido:Number = this.iface.curPedido.valueBuffer("idpedido");
	var curPresupuestos:FLSqlCursor = new FLSqlCursor("presupuestoscli");
	curPresupuestos.select("idpresupuesto = " + idPresupuesto);
	if (!curPresupuestos.first()) {
		util.destroyProgressDialog();
		return false;
	}
	
	util.setProgress( ++paso );
	
	curPresupuestos.setModeAccess(curPresupuestos.Edit);
	curPresupuestos.refreshBuffer();
	if (!this.iface.copiaLineas(idPresupuesto, idPedido)) {
		util.destroyProgressDialog();
		return false;
	}
	
	util.setProgress( ++paso );
	
	// Copia los pies de presupuesto
	if (!this.iface.copiaPiesPresupuesto(idPresupuesto, idPedido)) {
		util.destroyProgressDialog();
		return false;
	}
	
	util.setProgress( ++paso );
	
	curPresupuestos.setValueBuffer("fechasalida", this.iface.curPedido.valueBuffer("fecha"));
	curPresupuestos.setValueBuffer("editable", false);
	if (!curPresupuestos.commitBuffer()) {
		util.destroyProgressDialog();
		return false;
	}
	
	util.setProgress( ++paso );
	
	this.iface.curPedido.select("idpedido = " + idPedido);
	if (this.iface.curPedido.first()) {
		this.iface.curPedido.setModeAccess(this.iface.curPedido.Edit);
		this.iface.curPedido.refreshBuffer();
		this.iface.curPedido.setValueBuffer("idpresupuesto", idPresupuesto);
		
		util.setProgress( ++paso );
		
		if (!this.iface.totalesPedido()) {
			util.destroyProgressDialog();
			return false;
		}
		
		util.setProgress( ++paso );
		
		if (this.iface.curPedido.commitBuffer() == false) {
			util.destroyProgressDialog();
			return false;
		}
		
		util.setProgress( ++paso );
	}

	util.destroyProgressDialog();

	return idPedido;
}

/** \D Informa los datos de un pedido a partir de los de un presupuesto
@param	curPresupuesto: Cursor que contiene los datos a incluir en el pedido
@return	True si el cálculo se realiza correctamente, false en caso contrario
\end */
function oficial_datosPedido(curPresupuesto:FLSqlCursor):Boolean
{
	var fecha:String;
	if (curPresupuesto.action() == "presupuestoscli") {
		var hoy:Date = new Date();
		fecha = hoy.toString();
	} else
		fecha = curPresupuesto.valueBuffer("fecha");
	
	var codEjercicio:String = curPresupuesto.valueBuffer("codejercicio");
	var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(fecha, codEjercicio, "pedidoscli");
	if (!datosDoc.ok)
		return false;
	if (datosDoc.modificaciones == true) {
		codEjercicio = datosDoc.codEjercicio;
		fecha = datosDoc.fecha;
	}
	
	var codDir:Number = curPresupuesto.valueBuffer("coddir");
	with (this.iface.curPedido) {
		setValueBuffer("codejercicio", codEjercicio);
		setValueBuffer("fecha", fecha);
		setValueBuffer("codagente", curPresupuesto.valueBuffer("codagente"));
		setValueBuffer("codalmacen", curPresupuesto.valueBuffer("codalmacen"));
		setValueBuffer("codpago", curPresupuesto.valueBuffer("codpago"));
		setValueBuffer("codtarifa", curPresupuesto.valueBuffer("codtarifa"));
		setValueBuffer("coddivisa", curPresupuesto.valueBuffer("coddivisa"));
		setValueBuffer("tasaconv", curPresupuesto.valueBuffer("tasaconv"));
		setValueBuffer("codcliente", curPresupuesto.valueBuffer("codcliente"));
		setValueBuffer("cifnif", curPresupuesto.valueBuffer("cifnif"));
		setValueBuffer("nombrecliente", curPresupuesto.valueBuffer("nombrecliente"));
		if (codDir == 0)
			setNull("coddir");
		else
			setValueBuffer("coddir", codDir);
		setValueBuffer("direccion", curPresupuesto.valueBuffer("direccion"));
		setValueBuffer("codpostal", curPresupuesto.valueBuffer("codpostal"));
		setValueBuffer("ciudad", curPresupuesto.valueBuffer("ciudad"));
		setValueBuffer("provincia", curPresupuesto.valueBuffer("provincia"));
		setValueBuffer("apartado", curPresupuesto.valueBuffer("apartado"));
		setValueBuffer("codpais", curPresupuesto.valueBuffer("codpais"));
		setValueBuffer("fechasalida", fecha);
		setValueBuffer("observaciones", curPresupuesto.valueBuffer("observaciones"));
	}
	
	return true;
}

/** \D Informa los datos de un pedido referentes a totales (I.V.A., neto, etc.)
@return	True si el cálculo se realiza correctamente, false en caso contrario
\end */
function oficial_totalesPedido():Boolean
{
	with (this.iface.curPedido) {
		setValueBuffer("neto", formpedidoscli.iface.pub_commonCalculateField("neto", this));
		setValueBuffer("totaliva", formpedidoscli.iface.pub_commonCalculateField("totaliva", this));
		setValueBuffer("total", formpedidoscli.iface.pub_commonCalculateField("total", this));
		setValueBuffer("totaleuros", formpedidoscli.iface.pub_commonCalculateField("totaleuros", this));
		setValueBuffer("comision", formpedidoscli.iface.pub_commonCalculateField("comision", this));
	}
	return true;
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
			valor = parseFloat(util.roundFieldValue(valor, "presupuestoscli", "total"));
			break;
		}
		case "comision": {
			valor = util.sqlSelect("lineaspresupuestoscli", "SUM((porcomision*pvptotal)/100)", "idpresupuesto = " + cursor.valueBuffer("idpresupuesto"));
			valor = parseFloat(util.roundFieldValue(valor, "presupuestoscli", "comision"));
			break;
		}
		/** \C
		El --totaleuros-- es el producto del --total-- por la --tasaconv--
		\end */
		case "totaleuros": {
			var total:Number = parseFloat(cursor.valueBuffer("total"));
			var tasaConv:Number = parseFloat(cursor.valueBuffer("tasaconv"));
			valor = total * tasaConv;
			valor = parseFloat(util.roundFieldValue(valor, "presupuestoscli", "totaleuros"));
			break;
		}
		/** \C
		El --neto-- es la suma del pvp total de las líneas de factura
		\end */
		case "neto": {
			valor = util.sqlSelect("lineaspresupuestoscli", "SUM(pvptotal)", "idpresupuesto = " + cursor.valueBuffer("idpresupuesto"));
			valor = parseFloat(util.roundFieldValue(valor, "presupuestoscli", "neto"));
			break;
		}
		/** \C
		El --totaliva-- es la suma del iva correspondiente a las líneas de factura
		\end */
		case "totaliva": {
			if (formfacturascli.iface.pub_sinIVA(cursor)) {
				valor = 0;
			} else {
				valor = util.sqlSelect("lineaspresupuestoscli", "SUM((pvptotal * iva) / 100)", "idpresupuesto = " + cursor.valueBuffer("idpresupuesto"));
			}
			valor = parseFloat(util.roundFieldValue(valor, "presupuestoscli", "totaliva"));
			break;
		}
		/** \C
		El --coddir-- corresponde a la dirección del cliente marcada como dirección de facturación
		\end */
		case "coddir": {
			valor = util.sqlSelect("dirclientes", "id", "codcliente = '" + cursor.valueBuffer("codcliente") + "' AND domfacturacion = 'true'");
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

/** \D
Copia las líneas de un pedido como líneas de su remito asociado
@param idPresupuesto: Identificador del pedido
@param idPedido: Identificador del pedido
\end */
function oficial_copiaLineas(idPresupuesto:Number, idPedido:Number):Boolean
{
	var curLineaPresupuesto:FLSqlCursor = new FLSqlCursor("lineaspresupuestoscli");
	curLineaPresupuesto.select("idpresupuesto = " + idPresupuesto);
	while (curLineaPresupuesto.next()) {
		curLineaPresupuesto.setModeAccess(curLineaPresupuesto.Browse);
		curLineaPresupuesto.refreshBuffer();
		if (!this.iface.copiaLineaPresupuesto(curLineaPresupuesto, idPedido))
			return false;
	}
	return true;
}

function oficial_copiaLineaPresupuesto(curLineaPresupuesto:FLSqlCursor, idPedido:Number):Number
{
	if (!this.iface.curLineaPedido)
		this.iface.curLineaPedido = new FLSqlCursor("lineaspedidoscli");
	
	with (this.iface.curLineaPedido) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idpedido", idPedido);
	}
	
	if (!this.iface.datosLineaPedido(curLineaPresupuesto))
		return false;
		
	if (!this.iface.curLineaPedido.commitBuffer())
		return false;
	
	return this.iface.curLineaPedido.valueBuffer("idlinea");
}

/** \D Copia los datos de una línea de presupuesto en una línea de pedido
@param	curLineaPresupuesto: Cursor que contiene los datos a incluir en la línea de pedido
@return	True si la copia se realiza correctamente, false en caso contrario
\end */
function oficial_datosLineaPedido(curLineaPresupuesto:FLSqlCursor):Boolean
{
	with (this.iface.curLineaPedido) {
		setValueBuffer("idlineapresupuesto", curLineaPresupuesto.valueBuffer("idlinea"));
		setValueBuffer("pvpunitario", curLineaPresupuesto.valueBuffer("pvpunitario"));
		setValueBuffer("pvpsindto", curLineaPresupuesto.valueBuffer("pvpsindto"));
		setValueBuffer("pvptotal", curLineaPresupuesto.valueBuffer("pvptotal"));
		setValueBuffer("cantidad", curLineaPresupuesto.valueBuffer("cantidad"));
		setValueBuffer("cantidadprevia", curLineaPresupuesto.valueBuffer("cantidad"));
		setValueBuffer("referencia", curLineaPresupuesto.valueBuffer("referencia"));
		setValueBuffer("descripcion", curLineaPresupuesto.valueBuffer("descripcion"));
		setValueBuffer("codimpuesto", curLineaPresupuesto.valueBuffer("codimpuesto"));
		setValueBuffer("iva", curLineaPresupuesto.valueBuffer("iva"));
		setValueBuffer("dtolineal", curLineaPresupuesto.valueBuffer("dtolineal"));
		setValueBuffer("dtopor", curLineaPresupuesto.valueBuffer("dtopor"));
		setValueBuffer("porcomision", curLineaPresupuesto.valueBuffer("porcomision"));
	}
	return true;
}

function oficial_duplicarPresupuesto_clicked() 
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var codPresupuesto:String;
	cursor.transaction(false);
	try {
		codPresupuesto = this.iface.duplicarPresupuesto(cursor);
		if (codPresupuesto) {
			cursor.commit();
			MessageBox.information(util.translate("scripts", "Se ha copiado el presupuesto %1 con código %2").arg(cursor.valueBuffer("codigo")).arg(codPresupuesto), MessageBox.Ok, MessageBox.NoButton);
			this.iface.tdbRecords.refresh();
		} else {
			cursor.rollback();
		}
	}
	catch (e) {
		cursor.rollback();
		MessageBox.critical(util.translate("scripts", "Hubo un error en la copia del presupuesto:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
	}
}


function oficial_duplicarPresupuesto(curOrigen:FLSqlCursor):String
{
	var util:FLUtil = new FLUtil();
	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Copiando presupuesto..." ), 7 );

	if (!this.iface.curPresupuesto_) {
		this.iface.curPresupuesto_ = new FLSqlCursor("presupuestoscli");
	}
	
	util.setProgress( ++paso );
	
	this.iface.curPresupuesto_.setModeAccess(this.iface.curPresupuesto_.Insert);
	this.iface.curPresupuesto_.refreshBuffer();

	var campos:Array = util.nombreCampos("presupuestoscli");
	var totalCampos:Number = campos[0];
	
	util.setProgress( ++paso );
	
	var campoInformado:Array = [];
	for (var i:Number = 1; i <= totalCampos; i++) {
		campoInformado[campos[i]] = false;
	}
	
	util.setProgress( ++paso );
	
	for (var i:Number = 1; i <= totalCampos; i++) {
		if (!this.iface.copiarCampoPresupuesto(campos[i], curOrigen, campoInformado)) {
			util.destroyProgressDialog();
			return false;
		}
	}
	
	util.setProgress( ++paso );
	
	if (!this.iface.curPresupuesto_.commitBuffer()) {
		util.destroyProgressDialog();
		return false;
	}
	
	util.setProgress( ++paso );
	
	var idPresDestino:String = this.iface.curPresupuesto_.valueBuffer("idpresupuesto");
	if (!this.iface.duplicarHijosPresupuesto(curOrigen.valueBuffer("idpresupuesto"), idPresDestino)) {
		util.destroyProgressDialog();
		return false;
	}
	
	util.setProgress( ++paso );
	
	var codPresupuesto:String = this.iface.curPresupuesto_.valueBuffer("codigo");
	
	util.setProgress( ++paso );
	util.destroyProgressDialog();
	
	return codPresupuesto;
}

function oficial_copiarCampoPresupuesto(nombreCampo:String, cursor:FLSqlCursor, campoInformado:Array):Boolean
{
	if (campoInformado[nombreCampo]) {
		return true;
	}
	var nulo:Boolean =false;

	var cursor:FLSqlCursor = this.cursor();
	switch (nombreCampo) {
		case "idpresupuesto": {
			return true;
			break;
		}
		case "numero": {
			return true;
			break;
		}
		case "editable": {
			valor = true;
			break;
		}
		default: {
			if (cursor.isNull(nombreCampo)) {
				nulo = true;
			} else {
				valor = cursor.valueBuffer(nombreCampo);
			}
		}
	}
	if (nulo) {
		this.iface.curPresupuesto_.setNull(nombreCampo);
	} else {
		this.iface.curPresupuesto_.setValueBuffer(nombreCampo, valor);
	}
	campoInformado[nombreCampo] = true;
	
	return true;
}

function oficial_duplicarHijosPresupuesto(idPresOrigen:String, idPresDestino:String):Boolean
{
	if (!this.iface.duplicarLineasPresupuesto(idPresOrigen, idPresDestino)) {
		return false;
	}
	return true;
}

function oficial_duplicarLineasPresupuesto(idPresOrigen:String, idPresDestino:String):String
{
	var util:FLUtil = new FLUtil;

	if (!this.iface.curLineaPres_) {
		this.iface.curLineaPres_ = new FLSqlCursor("lineaspresupuestoscli");
	}
	
	var campos:Array = util.nombreCampos("lineaspresupuestoscli");
	var totalCampos:Number = campos[0];

	var campoInformado:Array = [];
	
	var curLineaOrigen:FLSqlCursor = new FLSqlCursor("lineaspresupuestoscli");
	curLineaOrigen.select("idpresupuesto = " + idPresOrigen);
	while (curLineaOrigen.next()) {
		for (var i:Number = 1; i <= totalCampos; i++) {
			campoInformado[campos[i]] = false;
		}
		this.iface.curLineaPres_.setModeAccess(this.iface.curLineaPres_.Insert);
		this.iface.curLineaPres_.refreshBuffer();
		this.iface.curLineaPres_.setValueBuffer("idpresupuesto", idPresDestino);

		for (var i:Number = 1; i <= totalCampos; i++) {
			if (!this.iface.copiarCampoLineaPresupuesto(campos[i], curLineaOrigen, campoInformado)) {
				return false;
			}
		}
		if (!this.iface.curLineaPres_.commitBuffer()) {
			return false;
		}
	}
	return true;
}

function oficial_copiarCampoLineaPresupuesto(nombreCampo:String, curLineaOrigen:FLSqlCursor, campoInformado:Array):Boolean
{
	if (campoInformado[nombreCampo]) {
		return true;
	}
	var nulo:Boolean =false;

	switch (nombreCampo) {
		case "idlinea":
		case "idpresupuesto": {
			return true;
			break;
		}
		default: {
			if (curLineaOrigen.isNull(nombreCampo)) {
				nulo = true;
			} else {
				valor = curLineaOrigen.valueBuffer(nombreCampo);
			}
		}
	}
	if (nulo) {
		this.iface.curLineaPres_.setNull(nombreCampo);
	} else {
		this.iface.curLineaPres_.setValueBuffer(nombreCampo, valor);
	}
	campoInformado[nombreCampo] = true;
	
	return true;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////

function lotes_copiaLineaPresupuesto(curLineaPresupuesto:FLSqlCursor, idPedido:Number):Number
{
	var util:FLUtil = new FLUtil;
	var idLineaPedido:Number = this.iface.__copiaLineaPresupuesto(curLineaPresupuesto, idPedido);
	
	var referencia:String = curLineaPresupuesto.valueBuffer("referencia");
	if (!util.sqlSelect("articulos", "porlotes", "referencia = '" + referencia + "'"))
		return idLineaPedido;

	if (flfactppal.iface.pub_valorDefectoEmpresa("lotepedidos")) {

		var codAlmacen:String = util.sqlSelect("pedidoscli","codalmacen","idpedido = " + idPedido);
	
		var canLinea:Number = parseFloat(curLineaPresupuesto.valueBuffer("cantidad"));
		if(!canLinea || canLinea == 0)
			return idLineaPedido;
	
		var canLote:Number;
		var descArticulo:String = curLineaPresupuesto.valueBuffer("descripcion");
		var canTotal:Number = 0;
	
		while (canTotal < canLinea) {
			var f:Object = new FLFormSearchDB("seleclote");
			var curLote:FLSqlCursor = f.cursor();
			curLote.select();
			if (!curLote.first())
				curLote.setModeAccess(curLote.Insert);
			else
				curLote.setModeAccess(curLote.Edit);
		
			f.setMainWidget();
		
			canLote = canLinea - canTotal;
		
			curLote.refreshBuffer();
			curLote.setValueBuffer("referencia",referencia);
			curLote.setValueBuffer("descripcion",descArticulo);
			curLote.setValueBuffer("canlinea",canLinea);
			curLote.setValueBuffer("canlote",canLote);
			curLote.setValueBuffer("resto",canLote);
	
			var acpt:String = f.exec("id");
			if (acpt) {
				var nuevaCantidad:Number = parseFloat(curLote.valueBuffer("canlote"));
				var codLote:String = curLote.valueBuffer("codlote");
	
				var curMoviLote:FLSqlCursor = new FLSqlCursor("movilote");
				var fecha:Date = util.sqlSelect("pedidoscli","fecha","idpedido = " + idPedido);
				var idStock:Number = util.sqlSelect("stocks", "idstock", "codalmacen = '" + codAlmacen + "' AND referencia = '" + referencia + "'");
	
				curMoviLote.setModeAccess(curMoviLote.Insert);
				curMoviLote.refreshBuffer();
				curMoviLote.setValueBuffer("codlote", codLote);
				curMoviLote.setValueBuffer("fecha", fecha);
				curMoviLote.setValueBuffer("tipo", "Salida");
				curMoviLote.setValueBuffer("docorigen", "PC");
				curMoviLote.setValueBuffer("idlineapc", idLineaPedido);
				curMoviLote.setValueBuffer("idstock", idStock);
				curMoviLote.setValueBuffer("cantidad", (nuevaCantidad * -1));

				if (!flfactppal.iface.pub_valorDefectoEmpresa("stockpedidos"))
					curMoviLote.setValueBuffer("reserva", true);

				if(!curMoviLote.commitBuffer())
					return false;
				canTotal += nuevaCantidad;
			}
			else
				return false;
		}

	}

	return idLineaPedido;
}

//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ivaIncluido */
//////////////////////////////////////////////////////////////////
//// IVAINCLUIDO /////////////////////////////////////////////////////
/** \D Copia los datos de una línea de presupuesto en una línea de pedido
@param	curLineaPresupuesto: Cursor que contiene los datos a incluir en la línea de pedido
@return	True si la copia se realiza correctamente, false en caso contrario
\end */
function ivaIncluido_datosLineaPedido(curLineaPresupuesto:FLSqlCursor):Boolean
{
	if(!this.iface.__datosLineaPedido(curLineaPresupuesto))
		return false;
	
	with (this.iface.curLineaPedido) {
		setValueBuffer("ivaincluido", curLineaPresupuesto.valueBuffer("ivaincluido"));
		setValueBuffer("pvpunitarioiva", curLineaPresupuesto.valueBuffer("pvpunitarioiva"));
	}
	
	return true;
}
//// IVAINCLUIDO /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


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

	this.iface.actualizarFiltro();

	this.iface.procesarEstado();
}

function fechas_actualizarFiltro()
{
	var desde:String = this.iface.fechaDesde.date.toString().left(10);
	var hasta:String = this.iface.fechaHasta.date.toString().left(10);

	if (desde == "" || hasta == "")
		return;

	this.cursor().setMainFilter("fecha >= '" + desde + "' AND fecha <= '" + hasta + "'");

	this.iface.tdbRecords.refresh();
	this.cursor().last();
	this.iface.tdbRecords.setCurrentRow(this.cursor().at());
}

//// FECHAS /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition totalesIva */
/////////////////////////////////////////////////////////////////
//// TOTALES CON IVA ////////////////////////////////////////////

function totalesIva_datosLineaPedido(curLineaPresupuesto:FLSqlCursor):Boolean
{
	if(!this.iface.__datosLineaPedido(curLineaPresupuesto))
		return false;

	with (this.iface.curLineaPedido) {
		setValueBuffer("totalconiva", curLineaPresupuesto.valueBuffer("totalconiva"));
	}
	return true;
}

//// TOTALES CON IVA ////////////////////////////////////////////
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

function impresiones_imprimir(codPresupuesto:String)
{
	if (sys.isLoadedModule("flfactinfo")) {

		var util:FLUtil = new FLUtil;
		var codigo:String;
		var idPresupuesto:Number;
		if (codPresupuesto) {
			codigo = codPresupuesto;
			idPresupuesto = util.sqlSelect("presupuestoscli", "idpresupuesto", "codigo = '" + codPresupuesto + "'");
		}
		else {
			if (!this.cursor().isValid())
				return;
			codigo = this.cursor().valueBuffer("codigo");
			idPresupuesto = this.cursor().valueBuffer("idpresupuesto");
		}

		var dialog:Dialog = new Dialog(util.translate ( "scripts", "Imprimir Presupuesto" ), 0, "imprimir");

		dialog.OKButtonText = util.translate ( "scripts", "Aceptar" );
		dialog.cancelButtonText = util.translate ( "scripts", "Cancelar" );

		var text:Object = new Label;
		text.text = util.translate("scripts","Presupuesto: ") + codigo;
		dialog.add(text);

		var bgroup:GroupBox = new GroupBox;
		bgroup.title = util.translate("scripts", "Opciones");
		dialog.add( bgroup );

		var impPresupuesto:RadioButton = new RadioButton;
		impPresupuesto.text = util.translate ( "scripts", "Imprimir Presupuesto" );
		impPresupuesto.checked = true;
		bgroup.add( impPresupuesto );

		var impComponentes:CheckBox = new CheckBox;
		impComponentes.text = util.translate ( "scripts", "Imprimir artículos con sus componentes" );
		impComponentes.checked = flfactppal.iface.pub_valorDefectoEmpresa("imprimircomponentes");
		bgroup.add( impComponentes );
		
		if ( !dialog.exec() )
			return true;

		var nombreInforme:String;
		var numCopias:Number = flfactppal.iface.pub_valorDefectoEmpresa("copiaspresupuesto");
		if (!numCopias)
			numCopias = 1;

		if ( impPresupuesto.checked == true) {

			if ( impComponentes.checked == true ){
				nombreInforme = "i_presupuestosclicomp";
				flfactinfo.iface.pub_crearTabla("PR", idPresupuesto);
			}
			else
				nombreInforme = "i_presupuestoscli";
		}

		var curImprimir:FLSqlCursor = new FLSqlCursor("i_presupuestoscli");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_presupuestoscli_codigo", codigo);
		curImprimir.setValueBuffer("h_presupuestoscli_codigo", codigo);

		flfactinfo.iface.pub_lanzarInforme(curImprimir, nombreInforme, "", "", false, false, "", nombreInforme, numCopias);

	} else
		flfactppal.iface.pub_msgNoDisponible("Informes");
}

function impresiones_imprimirQuick(codPresupuesto:String, impresora:String)
{
	if (sys.isLoadedModule("flfactinfo")) {

		var util:FLUtil = new FLUtil;
		var codigo:String;
		var idPresupuesto:Number;
		if (codPresupuesto) {
			codigo = codPresupuesto;
			idPresupuesto = util.sqlSelect("presupuestoscli", "idpresupuesto", "codigo = '" + codPresupuesto + "'");
		}
		else {
			if (!this.cursor().isValid())
				return;
			codigo = this.cursor().valueBuffer("codigo");
			idPresupuesto = this.cursor().valueBuffer("idpresupuesto");
		}

		var impComponentes:Boolean = flfactppal.iface.pub_valorDefectoEmpresa("imprimircomponentes");
		var impDirecta:Boolean = true;

		var nombreInforme:String;
		var numCopias:Number = flfactppal.iface.pub_valorDefectoEmpresa("copiaspresupuesto");
		if (!numCopias)
			numCopias = 1;

		if ( impComponentes == true ){
			nombreInforme = "i_presupuestosclicomp";
			flfactinfo.iface.pub_crearTabla("PR", idPresupuesto);
		}
		else
			nombreInforme = "i_presupuestoscli";

		var curImprimir:FLSqlCursor = new FLSqlCursor("i_presupuestoscli");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_presupuestoscli_codigo", codigo);
		curImprimir.setValueBuffer("h_presupuestoscli_codigo", codigo);

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

	var orden:Array = [ "codigo", "tipoventa", "editable", "nombrecliente", "neto", "totaliva", "totalpie", "total", "coddivisa", "tasaconv", "totaleuros", "fecha", "fechasalida", "codserie", "numero", "codejercicio", "codalmacen", "codpago", "codtarifa", "codcliente", "cifnif", "direccion", "codpostal", "ciudad", "provincia", "codpais", "codagente", "comision", "tpv", "costototal", "ganancia", "utilidad", "idusuario", "observaciones" ];

	this.iface.tdbRecords.setOrderCols(orden);
	this.iface.tdbRecords.setFocus();
}

//// ORDEN_CAMPOS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition tipoVenta */
//////////////////////////////////////////////////////////////////
//// TIPO VENTA //////////////////////////////////////////////////

function tipoVenta_datosPedido(curPresupuesto:FLSqlCursor):Boolean
{
	if (!this.iface.__datosPedido(curPresupuesto))
		return false;
		
	with (this.iface.curPedido) {
		setValueBuffer("tipoventa", "Pedido");
		setValueBuffer("codserie", flfactppal.iface.pub_valorDefectoEmpresa("codserie_pedido"));
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
			var totalLineas:Number = parseFloat(util.sqlSelect("piepresupuestoscli", "SUM(totalinc)", "idpresupuesto = " + cursor.valueBuffer("idpresupuesto") + " AND incluidoneto = false"));
			if (!totalLineas || isNaN(totalLineas))
				totalLineas = 0;
			valor = totalLineas;
			break;
		}
		case "total": {
			var totalPie:Number = parseFloat(cursor.valueBuffer("totalpie"));
			valor = this.iface.__commonCalculateField(fN, cursor);
			valor += totalPie;
			valor = parseFloat(util.roundFieldValue(valor, "presupuestoscli", "total"));
			break;
		}
		case "neto": {
			var netoPie:Number = parseFloat(util.sqlSelect("piepresupuestoscli", "SUM(totalinc)", "idpresupuesto = " + cursor.valueBuffer("idpresupuesto") + " AND incluidoneto = true"));
			valor = this.iface.__commonCalculateField(fN, cursor);
			valor += netoPie;
			valor = parseFloat(util.roundFieldValue(valor, "presupuestoscli", "neto"));
			break;
		}
		case "totaliva": {
			if (formfacturascli.iface.pub_sinIVA(cursor)) {
				valor = 0;
			} else {
				var ivaPie:Number = parseFloat(util.sqlSelect("piepresupuestoscli", "SUM(totaliva)", "idpresupuesto = " + cursor.valueBuffer("idpresupuesto") + " AND incluidoneto = true"));
				valor = this.iface.__commonCalculateField(fN, cursor);
				valor += ivaPie;
			}
			valor = parseFloat(util.roundFieldValue(valor, "presupuestoscli", "totaliva"));
			break;
		}
		default:{
			valor = this.iface.__commonCalculateField(fN, cursor);
			break;
		}
	}
	return valor;
}

function pieDocumento_copiaPiesPresupuesto(idPresupuesto:Number, idPedido:Number):Boolean
{
	var curPiePresupuesto:FLSqlCursor = new FLSqlCursor("piepresupuestoscli");
	curPiePresupuesto.select("idpresupuesto = " + idPresupuesto);

	while (curPiePresupuesto.next()) {
		curPiePresupuesto.setModeAccess(curPiePresupuesto.Browse);
		if (!this.iface.copiaPiePresupuesto(curPiePresupuesto, idPedido))
			return false;
	}
	return true;
}

function pieDocumento_copiaPiePresupuesto(curPiePresupuesto:FLSqlCursor, idPedido:Number):Number
{
	if (!this.iface.curPiePedido)
		this.iface.curPiePedido = new FLSqlCursor("piepedidoscli");
	
	with (this.iface.curPiePedido) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idpedido", idPedido);
	}
	
	if (!this.iface.datosPiePedido(curPiePresupuesto))
		return false;
		
	if (!this.iface.curPiePedido.commitBuffer())
		return false;
	
	return this.iface.curPiePedido.valueBuffer("idpie");
}

function pieDocumento_datosPiePedido(curPiePresupuesto:FLSqlCursor):Boolean
{
	with (this.iface.curPiePedido) {
		setValueBuffer("codpie", curPiePresupuesto.valueBuffer("codpie"));
		setValueBuffer("descripcion", curPiePresupuesto.valueBuffer("descripcion"));
		setValueBuffer("baseimponible", curPiePresupuesto.valueBuffer("baseimponible"));
		setValueBuffer("incporcentual", curPiePresupuesto.valueBuffer("incporcentual"));
		setValueBuffer("inclineal", curPiePresupuesto.valueBuffer("inclineal"));
		setValueBuffer("totalinc", curPiePresupuesto.valueBuffer("totalinc"));
		setValueBuffer("incluidoneto", curPiePresupuesto.valueBuffer("incluidoneto"));
		setValueBuffer("totaliva", curPiePresupuesto.valueBuffer("totaliva"));
		setValueBuffer("totallinea", curPiePresupuesto.valueBuffer("totallinea"));
	}
	return true;
}

function pieDocumento_datosPedido(curPresupuesto:FLSqlCursor):Boolean
{
	if (!this.iface.__datosPedido(curPresupuesto))
		return false;
		
	with (this.iface.curPedido) {
		setValueBuffer("totalpie", curPresupuesto.valueBuffer("totalpie"));
	}
	
	return true;
}

//// PIE DE DOCUMENTO ////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////