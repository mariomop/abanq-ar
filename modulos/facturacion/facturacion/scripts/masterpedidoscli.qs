/***************************************************************************
                 masterpedidoscli.qs  -  description
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

/** @class_declaration  oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var pbnGAlbaran:Object;
	var pbnGFactura:Object;
	var tdbRecords:FLTableDB;
	var tbnAbrirCerrar:Object;
	var curAlbaran:FLSqlCursor;
	var curLineaAlbaran:FLSqlCursor;

    function oficial( context ) { interna( context ); } 
	function procesarEstado() {
		return this.ctx.oficial_procesarEstado();
	}
	function pbnGenerarAlbaran_clicked() {
		return this.ctx.oficial_pbnGenerarAlbaran_clicked();
	}
	function pbnGenerarFactura_clicked() {
		return this.ctx.oficial_pbnGenerarFactura_clicked();
	}
	function generarAlbaran(where:String, cursor:FLSqlCursor, datosAgrupacion:Array):Number {
		return this.ctx.oficial_generarAlbaran(where, cursor, datosAgrupacion);
	}
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.oficial_commonCalculateField(fN, cursor);
	}
	function copiaLineas(idPedido:Number, idAlbaran:Number):Boolean {
		return this.ctx.oficial_copiaLineas(idPedido, idAlbaran);
	}
	function copiaLineaPedido(curLineaPedido:FLSqlCursor, idAlbaran:Number):Number {
		return this.ctx.oficial_copiaLineaPedido(curLineaPedido, idAlbaran);
	}
	function actualizarDatosPedido(where:String, idAlbaran:String):Boolean {
		return this.ctx.oficial_actualizarDatosPedido(where, idAlbaran);
	}
	function totalesAlbaran():Boolean {
		return this.ctx.oficial_totalesAlbaran();
	}
	function datosAlbaran(curPedido:FLSqlCursor, where:String, datosAgrupacion:Array):Boolean {
		return this.ctx.oficial_datosAlbaran(curPedido, where, datosAgrupacion);
	}
	function datosLineaAlbaran(curLineaPedido:FLSqlCursor):Boolean {
		return this.ctx.oficial_datosLineaAlbaran(curLineaPedido);
	}
	function comprobarStockEnAlbaranado(curLineaPedido:FLSqlCursor, cantidad:Number):Array {
		return this.ctx.oficial_comprobarStockEnAlbaranado(curLineaPedido, cantidad);
	}
	function abrirCerrarPedido() {
		return this.ctx.oficial_abrirCerrarPedido();
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration pedidosauto */
/////////////////////////////////////////////////////////////////
//// PEDIDOS_AUTO ///////////////////////////////////////////////
class pedidosauto extends oficial {
	function pedidosauto( context ) { oficial ( context ); }
}
//// PEDIDOS_AUTO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
class lotes extends pedidosauto {
    function lotes( context ) { pedidosauto ( context ); }
	function copiaLineaPedido(curLineaPedido:FLSqlCursor, idAlbaran:Number):Number {
		return this.ctx.lotes_copiaLineaPedido(curLineaPedido, idAlbaran);
	}
}
//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ivaIncluido */
//////////////////////////////////////////////////////////////////
//// IVAINCLUIDO /////////////////////////////////////////////////////
class ivaIncluido extends lotes {
    function ivaIncluido( context ) { lotes( context ); } 	
	function datosLineaAlbaran(curLineaPedido:FLSqlCursor):Boolean {
		return this.ctx.ivaIncluido_datosLineaAlbaran(curLineaPedido);
	}
}
//// IVAINCLUIDO /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration fluxEcommerce */
/////////////////////////////////////////////////////////////////
//// FLUX ECOMMERCE //////////////////////////////////////////////////////
class fluxEcommerce extends ivaIncluido {
    function fluxEcommerce( context ) { ivaIncluido ( context ); }
	function datosAlbaran(curPedido:FLSqlCursor, where:String, datosAgrupacion:Array):Boolean {
		return this.ctx.fluxEcommerce_datosAlbaran(curPedido, where, datosAgrupacion);
	}
}
//// FLUX ECOMMERCE //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_declaration funNumSerie */
/////////////////////////////////////////////////////////////////
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////
class funNumSerie extends fluxEcommerce {
	function funNumSerie( context ) { fluxEcommerce ( context ); }
	function copiaLineaPedido(curLineaPedido:FLSqlCursor, idAlbaran:Number):Number {
		return this.ctx.funNumSerie_copiaLineaPedido(curLineaPedido, idAlbaran);
	}
	function datosLineaAlbaran(curLineaPedido:FLSqlCursor):Boolean {
		return this.ctx.funNumSerie_datosLineaAlbaran(curLineaPedido);
	}
}
//// FUN_NUMEROS_SERIE //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_declaration fechas */
/////////////////////////////////////////////////////////////////
//// FECHAS /////////////////////////////////////////////////
class fechas extends funNumSerie {
	var fechaDesde:Object;
	var fechaHasta:Object;
	var ejercicio:String;

    function fechas( context ) { funNumSerie ( context ); }
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
	function datosLineaAlbaran(curLineaPedido:FLSqlCursor):Boolean {
		return this.ctx.totalesIva_datosLineaAlbaran(curLineaPedido);
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
	function imprimir(codPedido:String) {
		return this.ctx.impresiones_imprimir(codPedido);
	}
	function imprimirQuick(codPedido:String, impresora:String) {
		return this.ctx.impresiones_imprimirQuick(codPedido, impresora);
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
	function datosAlbaran(curPedido:FLSqlCursor, where:String, datosAgrupacion:Array):Boolean {
		return this.ctx.tipoVenta_datosAlbaran(curPedido, where, datosAgrupacion);
	}
}
//// TIPO DE VENTA  /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pieDocumento */
/////////////////////////////////////////////////////////////////
//// PIE DE DOCUMENTO ///////////////////////////////////////////
class pieDocumento extends tipoVenta {
	var curPieAlbaran:FLSqlCursor;

	function pieDocumento( context ) { tipoVenta ( context ); }
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.pieDocumento_commonCalculateField(fN, cursor);
	}
	function copiaPiesPedido(idPedido:Number, idAlbaran:Number):Boolean {
		return this.ctx.pieDocumento_copiaPiesPedido(idPedido, idAlbaran);
	}
	function copiaPiePedido(curPiePedido:FLSqlCursor, idAlbaran:Number):Number {
		return this.ctx.pieDocumento_copiaPiePedido(curPiePedido, idAlbaran);
	}
	function datosPieAlbaran(curPiePedido:FLSqlCursor):Boolean {
		return this.ctx.pieDocumento_datosPieAlbaran(curPiePedido);
	}
	function datosAlbaran(curPedido:FLSqlCursor, where:String, datosAgrupacion:Array):Boolean {
		return this.ctx.pieDocumento_datosAlbaran(curPedido, where, datosAgrupacion);
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
	function pub_generarAlbaran(where:String, cursor:FLSqlCursor, datosAgrupacion:Array):Number {
		return this.generarAlbaran(where, cursor, datosAgrupacion);
	}
	function pub_imprimir(codPedido:String) {
		return this.imprimir(codPedido);
	}
	function pub_imprimirQuick(codPedido:String, impresora:String) {
		return this.imprimirQuick(codPedido, impresora);
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
Este es el formulario maestro de pedidos a cliente.
\end */
function interna_init()
{
	this.iface.pbnGAlbaran = this.child("pbnGenerarAlbaran");
	this.iface.pbnGFactura = this.child("pbnGenerarFactura");
	this.iface.tdbRecords = this.child("tableDBRecords");
	this.iface.tbnAbrirCerrar = this.child("tbnAbrirCerrar");

	connect(this.iface.pbnGAlbaran, "clicked()", this, "iface.pbnGenerarAlbaran_clicked()");
	connect(this.iface.pbnGFactura, "clicked()", this, "iface.pbnGenerarFactura_clicked()");
	connect(this.iface.tdbRecords, "currentChanged()", this, "iface.procesarEstado");
	connect(this.iface.tbnAbrirCerrar, "clicked()", this, "iface.abrirCerrarPedido()");

	var codEjercicio = flfactppal.iface.pub_ejercicioActual();
	if (codEjercicio)
		this.cursor().setMainFilter("codejercicio = '" + codEjercicio + "'");

	this.iface.procesarEstado();
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_procesarEstado()
{
	if (this.cursor().isValid() && this.cursor().valueBuffer("editable") == true) {
		this.iface.pbnGAlbaran.enabled = true;
		this.iface.pbnGFactura.enabled = true;
	} else {
		this.iface.pbnGAlbaran.enabled = false;
		this.iface.pbnGFactura.enabled = false;
	}
}

/** \C
Al pulsar el botón de generar remito se creará el remito correspondiente al pedido seleccionado.
\end */
function oficial_pbnGenerarAlbaran_clicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	if (!this.cursor().isValid()) {
		this.iface.procesarEstado();
		return;
	}
	if (cursor.valueBuffer("editable") == false) {
		MessageBox.warning(util.translate("scripts", "El pedido ya está servido"), MessageBox.Ok, MessageBox.NoButton);
		this.iface.procesarEstado();
		return;
	}
	var res:Number = MessageBox.warning(util.translate("scripts", "Se generará un remito a partir del pedido seleccionado.\n¿Desea continuar?"), MessageBox.Yes, MessageBox.No);
	if (res != MessageBox.Yes)
		return;

	this.iface.pbnGAlbaran.setEnabled(false);
	this.iface.pbnGFactura.setEnabled(false); 

	var where:String = "idpedido = " + cursor.valueBuffer("idpedido");
	var ok:Boolean;

	cursor.transaction(false);
	try {
		if (this.iface.generarAlbaran(where, cursor))
			cursor.commit();
		else
			cursor.rollback();
	}
	catch (e) {
		cursor.rollback();
		MessageBox.critical(util.translate("scripts", "Hubo un error en la generación del remito:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
	}

	this.iface.tdbRecords.refresh();
	this.iface.procesarEstado();
}

/** \C
Al pulsar el botón de generar factura se crearán tanto el remito como la factura correspondientes al pedido seleccionado.
\end */
function oficial_pbnGenerarFactura_clicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	if (!this.cursor().isValid()) {
		this.iface.procesarEstado();
		return;
	}
	if (cursor.valueBuffer("editable") == false) {
		MessageBox.warning(util.translate("scripts", "El pedido ya está servido. Genere la factura desde la ventana de remitos"), MessageBox.Ok, MessageBox.NoButton);
		this.iface.procesarEstado();
		return;
	}
	var res:Number = MessageBox.warning(util.translate("scripts", "Se generará una factura a partir del pedido seleccionado.\n¿Desea continuar?"), MessageBox.Yes, MessageBox.No);
	if (res != MessageBox.Yes)
		return;

	this.iface.pbnGAlbaran.setEnabled(false);
	this.iface.pbnGFactura.setEnabled(false);

	var idAlbaran:Number;
	var curAlbaran:FLSqlCursor = new FLSqlCursor("albaranescli");
	var where:String = "idpedido = " + cursor.valueBuffer("idpedido");

	cursor.transaction(false);
	try {
		idAlbaran = this.iface.generarAlbaran(where, cursor);
		if (idAlbaran) {
			cursor.commit();
			cursor.transaction(false);
			where = "idalbaran = " + idAlbaran;
			curAlbaran.select(where);
			if (curAlbaran.first()) {
				if (formalbaranescli.iface.pub_generarFactura(where, curAlbaran))
					cursor.commit();
				else
					cursor.rollback();
			} else
				cursor.rollback();
		} else
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
Genera el remito asociado a uno o más pedidos
@param where: Sentencia where para la consulta de búsqueda de los pedidos a agrupar
@param cursor: Cursor con los datos principales que se copiarán del pedido al remito
@param datosAgrupacion: Array con los datos indicados en el formulario de agrupación de pedidos
@return Identificador del remito generado. FALSE si hay error
\end */
function oficial_generarAlbaran(where:String, curPedido:FLSqlCursor, datosAgrupacion:Array):Number
{
	if (!this.iface.curAlbaran)
		this.iface.curAlbaran = new FLSqlCursor("albaranescli");
	
	this.iface.curAlbaran.setModeAccess(this.iface.curAlbaran.Insert);
	this.iface.curAlbaran.refreshBuffer();
	
	if (!this.iface.datosAlbaran(curPedido, where, datosAgrupacion))
		return false;
	
	if (!this.iface.curAlbaran.commitBuffer()) {
		return false;
	}
	
	var idAlbaran:Number = this.iface.curAlbaran.valueBuffer("idalbaran");
	
	var qryPedidos:FLSqlQuery = new FLSqlQuery();
	qryPedidos.setTablesList("pedidoscli");
	qryPedidos.setSelect("idpedido");
	qryPedidos.setFrom("pedidoscli");
	qryPedidos.setWhere(where);

	if (!qryPedidos.exec())
		return false;

	var idPedido:String;
	while (qryPedidos.next()) {
		idPedido = qryPedidos.value(0);
		if (!this.iface.copiaLineas(idPedido, idAlbaran))
			return false;
		// Crea los pies de remito a partir de los pies de pedido
		if (!this.iface.copiaPiesPedido(idPedido, idAlbaran))
			return false;
	}

	this.iface.curAlbaran.select("idalbaran = " + idAlbaran);
	if (this.iface.curAlbaran.first()) {
		this.iface.curAlbaran.setModeAccess(this.iface.curAlbaran.Edit);
		this.iface.curAlbaran.refreshBuffer();
		
		if (!this.iface.totalesAlbaran())
			return false;
		
		if (this.iface.curAlbaran.commitBuffer() == false)
			return false;
	}
	return idAlbaran;
}

/** \D Informa los datos de un remito a partir de los de uno o varios pedidos
@param	curPedido: Cursor que contiene los datos a incluir en el remito
@param where: Sentencia where para la consulta de búsqueda de los pedidos a agrupar
@param datosAgrupacion: Array con los datos indicados en el formulario de agrupación de pedidos
@return	True si el cálculo se realiza correctamente, false en caso contrario
\end */
function oficial_datosAlbaran(curPedido:FLSqlCursor, where:String, datosAgrupacion:Array):Boolean
{
	var util:FLUtil = new FLUtil();
	var fecha:String;
	var hora:String;
	var recFinanciero:Number;
	if (datosAgrupacion) {
		fecha = datosAgrupacion["fecha"];
		hora = datosAgrupacion["hora"];
		recFinanciero = datosAgrupacion["recfinanciero"];
	} else {
		var hoy:Date = new Date();
		fecha = hoy.toString();
		hora = hoy.toString().right(8);
		recFinanciero = curPedido.valueBuffer("recfinanciero");
	}
	
	var codEjercicio:String = curPedido.valueBuffer("codejercicio");
	var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(fecha, codEjercicio, "albaranescli");
	if (!datosDoc.ok)
		return false;
	if (datosDoc.modificaciones == true) {
		codEjercicio = datosDoc.codEjercicio;
		fecha = datosDoc.fecha;
	}
	
	var codDir:Number = util.sqlSelect("dirclientes", "id", "codcliente = '" + curPedido.valueBuffer("codcliente") + "' AND domenvio = 'true'");
		
	with (this.iface.curAlbaran) {
		setValueBuffer("codejercicio", codEjercicio);
		setValueBuffer("fecha", fecha);
		setValueBuffer("hora", hora);
		setValueBuffer("codagente", curPedido.valueBuffer("codagente"));
		setValueBuffer("porcomision", curPedido.valueBuffer("porcomision"));
		setValueBuffer("codalmacen", curPedido.valueBuffer("codalmacen"));
		setValueBuffer("codpago", curPedido.valueBuffer("codpago"));
		setValueBuffer("coddivisa", curPedido.valueBuffer("coddivisa"));
		setValueBuffer("tasaconv", curPedido.valueBuffer("tasaconv"));
		setValueBuffer("codcliente", curPedido.valueBuffer("codcliente"));
		setValueBuffer("cifnif", curPedido.valueBuffer("cifnif"));
		setValueBuffer("nombrecliente", curPedido.valueBuffer("nombrecliente"));
		if (!codDir) {
			codDir = curPedido.valueBuffer("coddir")
			if (codDir == 0)
				setNull("coddir");
			else 
				setValueBuffer("coddir", curPedido.valueBuffer("coddir"));
			setValueBuffer("direccion", curPedido.valueBuffer("direccion"));
			setValueBuffer("codpostal", curPedido.valueBuffer("codpostal"));
			setValueBuffer("ciudad", curPedido.valueBuffer("ciudad"));
			setValueBuffer("provincia", curPedido.valueBuffer("provincia"));
			setValueBuffer("apartado", curPedido.valueBuffer("apartado"));
			setValueBuffer("codpais", curPedido.valueBuffer("codpais"));
		} else {
			setValueBuffer("coddir", codDir);
			setValueBuffer("direccion", util.sqlSelect("dirclientes","direccion","id = " + codDir));
			setValueBuffer("codpostal", util.sqlSelect("dirclientes","codpostal","id = " + codDir));
			setValueBuffer("ciudad", util.sqlSelect("dirclientes","ciudad","id = " + codDir));
			setValueBuffer("provincia", util.sqlSelect("dirclientes","provincia","id = " + codDir));
			setValueBuffer("apartado", util.sqlSelect("dirclientes","apartado","id = " + codDir));
			setValueBuffer("codpais", util.sqlSelect("dirclientes","codpais","id = " + codDir));
		}
		setValueBuffer("recfinanciero", recFinanciero);
		setValueBuffer("observaciones", curPedido.valueBuffer("observaciones"));
	}
	
	return true;
}

/** \D Informa los datos de un remito referentes a totales (I.V.A., neto, etc.)
@return	True si el cálculo se realiza correctamente, false en caso contrario
\end */
function oficial_totalesAlbaran():Boolean
{
	with (this.iface.curAlbaran) {
		setValueBuffer("neto", formalbaranescli.iface.pub_commonCalculateField("neto", this));
		setValueBuffer("totaliva", formalbaranescli.iface.pub_commonCalculateField("totaliva", this));
		setValueBuffer("total", formalbaranescli.iface.pub_commonCalculateField("total", this));
		setValueBuffer("totaleuros", formalbaranescli.iface.pub_commonCalculateField("totaleuros", this));
	}
	return true;
}

function oficial_actualizarDatosPedido(where:String, idAlbaran:String):Boolean
{
	var curPedidos:FLSqlCursor = new FLSqlCursor("pedidoscli");
	curPedidos.select(where);
	while (curPedidos.next()) {
		curPedidos.setModeAccess(curPedidos.Edit);
		curPedidos.refreshBuffer();
		curPedidos.setValueBuffer("servido", "Sí");
		curPedidos.setValueBuffer("editable", false);
		if(!curPedidos.commitBuffer()) 
			return false;
	}
	return true;
}

function oficial_commonCalculateField(fN:String, cursor:FLSqlCursor):String
{
		var util = new FLUtil();
		var valor;
		/** \C
		El --código-- se construye como la concatenación de --codserie--, --codejercicio-- y --numero--
		\end */
		if (fN == "codigo")
				valor = flfacturac.iface.pub_construirCodigo(cursor.valueBuffer("codserie"), cursor.valueBuffer("codejercicio"), cursor.valueBuffer("numero"));

		switch (fN) {
			/** \C
			El --total-- es el --neto-- más el --totaliva-- más el --recfinanciero--
			\end */
			case "total": {
				var neto = parseFloat(cursor.valueBuffer("neto"));
				var totalIva = parseFloat(cursor.valueBuffer("totaliva"));
				var recFinanciero = (parseFloat(cursor.valueBuffer("recfinanciero")) * neto) / 100;
				recFinanciero = parseFloat(util.roundFieldValue(recFinanciero, "pedidoscli", "total"));
				valor = neto + totalIva + recFinanciero;
				valor = parseFloat(util.roundFieldValue(valor, "pedidoscli", "total"));
				break;
			}
			case "lblComision": {
				valor = (parseFloat(cursor.valueBuffer("porcomision")) * (parseFloat(cursor.valueBuffer("neto")))) / 100;
				valor = parseFloat(util.roundFieldValue(valor, "pedidoscli", "total"));
				break;
			}
			case "lblRecFinanciero": {
				valor = (parseFloat(cursor.valueBuffer("recfinanciero")) * (parseFloat(cursor.valueBuffer("neto")))) / 100;
				valor = parseFloat(util.roundFieldValue(valor, "pedidoscli", "total"));
				break;
			}
			/** \C
			El --totaleuros-- es el producto del --total-- por la --tasaconv--
			\end */
			case "totaleuros": {
				var total = parseFloat(cursor.valueBuffer("total"));
				var tasaConv = parseFloat(cursor.valueBuffer("tasaconv"));
				valor = total * tasaConv;
				valor = parseFloat(util.roundFieldValue(valor, "pedidoscli", "totaleuros"));
				break;
			}
			/** \C
			El --neto-- es la suma del pvp total de las líneas de factura
			\end */
			case "neto": {
				valor = util.sqlSelect("lineaspedidoscli", "SUM(pvptotal)", "idpedido = " + cursor.valueBuffer("idpedido"));
				valor = parseFloat(util.roundFieldValue(valor, "pedidoscli", "neto"));
				break;
			}
			/** \C
			El --totaliva-- es la suma del iva correspondiente a las líneas de factura
			\end */
			case "totaliva": {
				if (formfacturascli.iface.pub_sinIVA(cursor)) {
					valor = 0;
				} else {
					valor = util.sqlSelect("lineaspedidoscli", "SUM((pvptotal * iva) / 100)", "idpedido = " + cursor.valueBuffer("idpedido"));
				}
				valor = parseFloat(util.roundFieldValue(valor, "pedidoscli", "totaliva"));
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
		}
		return valor;
}

/** \D
Copia las líneas de un pedido como líneas de su remito asociado
@param idPedido: Identificador del pedido
@param idAlbaran: Identificador del remito
@return VERDADERO si no hay error. FALSE en otro caso.
\end */
function oficial_copiaLineas(idPedido:Number, idAlbaran:Number):Boolean
{
	var util:FLUtil = new FLUtil;
	var cantidad:Number;
	var totalEnAlbaran:Number;
	var curLineaPedido:FLSqlCursor = new FLSqlCursor("lineaspedidoscli");
	curLineaPedido.select("idpedido = " + idPedido + " AND (cerrada = false or cerrada IS NULL)");
	while (curLineaPedido.next()) {
		curLineaPedido.setModeAccess(curLineaPedido.Browse);
		curLineaPedido.refreshBuffer();
		cantidad = parseFloat(curLineaPedido.valueBuffer("cantidad"));
		totalEnAlbaran = parseFloat(curLineaPedido.valueBuffer("totalenalbaran"));
		if (cantidad > totalEnAlbaran) {
			if (!this.iface.copiaLineaPedido(curLineaPedido, idAlbaran)) {
				return false;
			}
// 			cantidad = util.sqlSelect("lineasalbaranescli", "SUM(cantidad)", "idlineapedido = " + curLineaPedido.valueBuffer("idlinea"));
// 			curLineaPedido.setValueBuffer("totalenalbaran", cantidad);
// 			if (!curLineaPedido.commitBuffer())
// 				return false;
		}
	}
	return true;
}

/** \D
Copia una líneas de un pedido en su remito asociado
@param curdPedido: Cursor posicionado en la línea de pedido a copiar
@param idAlbaran: Identificador del remito
@return identificador de la línea de remito creada si no hay error. FALSE en otro caso.
\end */
function oficial_copiaLineaPedido(curLineaPedido:FLSqlCursor, idAlbaran:Number):Number
{
	if (!this.iface.curLineaAlbaran)
		this.iface.curLineaAlbaran = new FLSqlCursor("lineasalbaranescli");
	
	with (this.iface.curLineaAlbaran) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idalbaran", idAlbaran);
	}
	
	if (!this.iface.datosLineaAlbaran(curLineaPedido))
		return false;

 	//if (!(this.iface.curLineaAlbaran.valueBuffer("cantidad") == 0 && curLineaPedido.valueBuffer("cantidad") != 0)) {
		if (!this.iface.curLineaAlbaran.commitBuffer())
			return false;
 	//}
	
	return this.iface.curLineaAlbaran.valueBuffer("idlinea");
}

/** \D Copia los datos de una línea de pedido en una línea de remito
@param	curLineaPedido: Cursor que contiene los datos a incluir en la línea de remito
@return	True si la copia se realiza correctamente, false en caso contrario
\end */
function oficial_datosLineaAlbaran(curLineaPedido:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	var cantidad:Number = parseFloat(curLineaPedido.valueBuffer("cantidad")) - parseFloat(curLineaPedido.valueBuffer("totalenalbaran"));
	var comprobarStock:Array = this.iface.comprobarStockEnAlbaranado(curLineaPedido, cantidad);
	if (!comprobarStock["ok"])
		return false;
	
	if (!comprobarStock["haystock"])
		cantidad = comprobarStock["cantidad"];

	var pvpSinDto:Number = parseFloat(curLineaPedido.valueBuffer("pvpsindto")) * cantidad / parseFloat(curLineaPedido.valueBuffer("cantidad"));
	pvpSinDto = util.roundFieldValue(pvpSinDto, "lineasalbaranescli", "pvpsindto");
	
	with (this.iface.curLineaAlbaran) {
		setValueBuffer("idlineapedido", curLineaPedido.valueBuffer("idlinea"));
		setValueBuffer("idpedido", curLineaPedido.valueBuffer("idpedido"));
		setValueBuffer("referencia", curLineaPedido.valueBuffer("referencia"));
		setValueBuffer("descripcion", curLineaPedido.valueBuffer("descripcion"));
		setValueBuffer("pvpunitario", curLineaPedido.valueBuffer("pvpunitario"));
		setValueBuffer("cantidad", cantidad);
		setValueBuffer("codimpuesto", curLineaPedido.valueBuffer("codimpuesto"));
		setValueBuffer("iva", curLineaPedido.valueBuffer("iva"));
		setValueBuffer("dtolineal", curLineaPedido.valueBuffer("dtolineal"));
		setValueBuffer("dtopor", curLineaPedido.valueBuffer("dtopor"));
		setValueBuffer("porcomision", curLineaPedido.valueBuffer("porcomision"));
		setValueBuffer("pvpsindto", pvpSinDto);
		setValueBuffer("pvptotal", formRecordlineaspedidoscli.iface.pub_commonCalculateField("pvptotal", this));
	}
	return true;
}

function oficial_comprobarStockEnAlbaranado(curLineaPedido:FLSqlCursor, cantidad:Number):Array
{
	var util:FLUtil = new FLUtil;
	var res:Array = [];

	res["haystock"] = true;
	res["cantidad"] = 0;
	res["ok"] = true;
	var referencia:String = curLineaPedido.valueBuffer("referencia");
	if (referencia && referencia != "") {
		var controlStock:Boolean = util.sqlSelect("articulos", "controlstock", "referencia = '" + referencia + "'");
		if (!controlStock) {
			var codAlmacen:String;
			if (curLineaPedido.cursorRelation())
				codAlmacen = curLineaPedido.cursorRelation().valueBuffer("codalmacen");
			else
				codAlmacen = util.sqlSelect("pedidoscli", "codalmacen", "idpedido = " + curLineaPedido.valueBuffer("idpedido"));

			var cantidadStock:Number = parseFloat(util.sqlSelect("stocks", "cantidad", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "'"));
			if (!cantidadStock || isNaN(cantidadStock))
				cantidadStock = 0;

			if (cantidadStock < cantidad) {
				res["haystock"] = false;
				var resCuestion:Number = MessageBox.warning(util.translate("scripts", "El artículo %1 no permite ventas sin stocks.\nEstá albaranando más cantidad (%2) que la disponible (%3) ahora mismo en el almacén %4.\n¿Desea continuar dejando el pedido parcialmente albaranado?").arg(referencia).arg(cantidad).arg(cantidadStock).arg(codAlmacen), MessageBox.No, MessageBox.Yes);
				if (resCuestion != MessageBox.Yes) {
					res["ok"] = false;
					return res;
				}
				if (cantidadStock < 0)
					cantidadStock = 0;
				res["cantidad"] = cantidadStock;
			}
		}
	}
	return res;
}

function oficial_abrirCerrarPedido()
{
	var util:FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var idPedido:Number = cursor.valueBuffer("idpedido");
	if(!idPedido) {
		MessageBox.warning(util.translate("scripts", "No hay ningún registro seleccionado"), MessageBox.Ok, MessageBox.NoButton);
	}

	var cerrar:Boolean = true;
	var res:Number;
	if(util.sqlSelect("lineaspedidoscli","cerrada","idpedido = " + idPedido + " AND cerrada")) {
		cerrar = false;
		res = MessageBox.information(util.translate("scripts", "El pedido seleccionado tiene líneas cerradas.\n¿Seguro que desea abrirlas?"), MessageBox.Yes, MessageBox.No);
	}
	else {
		if(!cursor.valueBuffer("editable")) {
			MessageBox.warning(util.translate("scripts", "El pedido ya ha sido servido completamente."), MessageBox.Ok, MessageBox.NoButton);
			return;
		}
		res = MessageBox.information(util.translate("scripts", "Se va a cerrar el pedido y no podrá terminar de servirse.\n¿Desea continuar?"), MessageBox.Yes, MessageBox.No);
	}
	if(res != MessageBox.Yes)
		return;

	if(!util.sqlUpdate("lineaspedidoscli","cerrada",cerrar,"idpedido = " + idPedido))
		return;

	if (!flfacturac.iface.pub_actualizarEstadoPedidoCli(idPedido))
		return;

	this.iface.tdbRecords.refresh();
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition pedidosauto */
/////////////////////////////////////////////////////////////////
//// PEDIDOS_AUTO //////////////////////////////////////////////

//// PEDIDOS_AUTO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
/** \C Generación de facturas y remitos a partir de pedidos: La selección de los lotes a los que se asociarán las líneas de factura o remito se llevará a cabo de la siguiente forma: Se buscarán los lotes ordenados por fecha de caducidad, y deberán pertenecer todos al almacén consignado en pedido. Los lotes se irán añadiendo (creando movimientos de salida de lote) hasta alcanzar la cantidad especificada en la línea de pedido. Si no hay lotes suficientes en el almacén consignado en el documento origen el sistema dará un aviso y permitirá stocks negativos en el último lote hasta completar el pedido.
\end */
function lotes_init() {
}

function lotes_copiaLineaPedido(curLineaPedido:FLSqlCursor, idAlbaran:Number):Number {

	var util:FLUtil = new FLUtil;
	var idLineaAlbaran:Number = this.iface.__copiaLineaPedido(curLineaPedido, idAlbaran);
	
	var referencia:String = curLineaPedido.valueBuffer("referencia");
	if (!util.sqlSelect("articulos", "porlotes", "referencia = '" + referencia + "'"))
		return idLineaAlbaran;
	var codAlmacen:String = util.sqlSelect("albaranescli","codalmacen","idalbaran = " + idAlbaran);

	var canLinea:Number = parseFloat(curLineaPedido.valueBuffer("cantidad"));
	if(!canLinea || canLinea == 0)
		return idLineaAlbaran;

	var canLote:Number;
	var descArticulo:String = curLineaPedido.valueBuffer("descripcion");


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
			var fecha:Date = util.sqlSelect("albaranescli","fecha","idalbaran = " + idAlbaran);
			 var idStock:Number = util.sqlSelect("stocks", "idstock", "codalmacen = '" + codAlmacen + "' AND referencia = '" + referencia + "'");

			curMoviLote.setModeAccess(curMoviLote.Insert);
			curMoviLote.refreshBuffer();
			curMoviLote.setValueBuffer("codlote", codLote);
			curMoviLote.setValueBuffer("fecha", fecha);
			curMoviLote.setValueBuffer("tipo", "Salida");
			curMoviLote.setValueBuffer("docorigen", "AC");
			curMoviLote.setValueBuffer("idlineaac", idLineaAlbaran);
			curMoviLote.setValueBuffer("idstock", idStock);
			curMoviLote.setValueBuffer("cantidad", (nuevaCantidad * -1));
			if(!curMoviLote.commitBuffer())
				return false;
			canTotal += nuevaCantidad;
		}
		else
			return false;
	}
// 	var qryLotes:FLSqlQuery = new FLSqlQuery();
// 	qryLotes.setTablesList("lotes");
// 	qryLotes.setSelect("codlote");
// 	qryLotes.setFrom("lotes");
// 	qryLotes.setWhere("referencia = '" + referencia + "' AND caducidad > CURRENT_DATE ORDER BY caducidad");
// 	if (!qryLotes.exec())
// 		return false;
// 	
// 	var canStock:Number;
// 	var codAlmacen = util.sqlSelect("albaranescli", "codalmacen", "idalbaran = " + idAlbaran);
// 	var fecha = util.sqlSelect("albaranescli", "fecha", "idalbaran = " + idAlbaran);
// 	var idStock = util.sqlSelect("stocks", "idstock", "codalmacen = '" + codAlmacen + "' AND referencia = '" + referencia + "'");
// 	var cantidad:Number = parseFloat(curLineaPedido.valueBuffer("cantidad"));
// 	var hayMasLotes:Boolean = true;
// 	var hayLotes:Boolean = false;
// 	var codLote:String;
// 	var curMoviLote:FLSqlCursor = new FLSqlCursor("movilote");
// 	while (qryLotes.next() && cantidad > 0) {
// 		hayLotes = true;
// 		codLote = qryLotes.value("codlote");
// 		if (!qryLotes.next())
// 			hayMasLotes = false;
// 			
// 		qryLotes.prev();
// 		if(!idStock)
// 			canStock = 0;
// 		else
// 			canStock = util.sqlSelect("movilote", "SUM(cantidad)", "idstock = " + idStock + " AND codlote = '" + codLote + "'");
// 		
// 		curMoviLote.setModeAccess(curMoviLote.Insert);
// 		curMoviLote.refreshBuffer();
// 		curMoviLote.setValueBuffer("codlote", codLote);
// 		curMoviLote.setValueBuffer("fecha", fecha);
// 		curMoviLote.setValueBuffer("tipo", "Salida");
// 		curMoviLote.setValueBuffer("docorigen", "AC");
// 		curMoviLote.setValueBuffer("idorigen", idLineaAlbaran);
// 		curMoviLote.setValueBuffer("idstock", idStock);
// 		if (hayMasLotes) {
// 			if (!canStock || canStock <= 0)
// 				continue;
// 			if (cantidad > canStock) {
// 				curMoviLote.setValueBuffer("cantidad", -1 * canStock);
// 				cantidad -= canStock;
// 			} else {
// 				curMoviLote.setValueBuffer("cantidad", -1 * cantidad);
// 				cantidad = 0;
// 			}
// 		} else {
// 			if (cantidad > canStock) {
// 				var respuesta:Number = MessageBox.warning(util.translate("scripts", "No hay suficientes artículos ") + referencia + util.translate("scripts", " en el almacén ") + codAlmacen + ".\n" + util.translate("scripts", "¿Desea crear un stock negativo para el lote ") + codLote + util.translate("scripts", "?"), MessageBox.Yes, MessageBox.No);
// 				if (respuesta !=  MessageBox.Yes)
// 					return false;
// 			}
// 			if (!idStock) {
// 				idStock = flfactalma.iface.pub_crearStock(codAlmacen, referencia);
// 				curMoviLote.setValueBuffer("idstock", idStock);
// 			}
// 			curMoviLote.setValueBuffer("cantidad", -1 * cantidad);
// 			cantidad = 0;
// 		}
// 		if (!curMoviLote.commitBuffer())
// 			return false;
// 	}
// 	if (!hayLotes) {
// 		MessageBox.warning(util.translate("scripts", "No hay lotes disponibles para el artículo  ") + referencia, MessageBox.Ok, MessageBox.NoButton);
// 		return false;
// 	}

	return idLineaAlbaran;
}

//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ivaIncluido */
//////////////////////////////////////////////////////////////////
//// IVAINCLUIDO /////////////////////////////////////////////////////
/** \D Copia los datos de una línea de pedido en una línea de remito
@param	curLineaPedido: Cursor que contiene los datos a incluir en la línea de remito
@return	True si la copia se realiza correctamente, false en caso contrario
\end */
function ivaIncluido_datosLineaAlbaran(curLineaPedido:FLSqlCursor):Boolean
{
	var cantidad:Number;
 	var pvpSinDto:Number;

	if (!this.iface.__datosLineaAlbaran(curLineaPedido))
		return false;
		
	with (this.iface.curLineaAlbaran) {
		setValueBuffer("ivaincluido", curLineaPedido.valueBuffer("ivaincluido"));
		setValueBuffer("pvpunitarioiva", curLineaPedido.valueBuffer("pvpunitarioiva"));
	}
	
	return true;
}

//// IVAINCLUIDO /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_definition fluxEcommerce */
/////////////////////////////////////////////////////////////////
//// FLUX ECOMMERCE //////////////////////////////////////////////////////

function fluxEcommerce_datosAlbaran(curPedido:FLSqlCursor,where:String, datosAgrupacion:Array):Boolean
{
	if (!this.iface.__datosAlbaran(curPedido, where, datosAgrupacion))
		return false;
		
	var codDirEnv:Number;
	with (this.iface.curAlbaran) {
		setValueBuffer("nombre", curPedido.valueBuffer("nombre"));
		setValueBuffer("apellidos", curPedido.valueBuffer("apellidos"));
		setValueBuffer("empresa", curPedido.valueBuffer("empresa"));
		if (codDirEnv == 0) {
			setNull("coddirenv");
		} else {
			setValueBuffer("coddirenv", curPedido.valueBuffer("coddirenv"));
		}
		setValueBuffer("nombreenv", curPedido.valueBuffer("nombreenv"));
		setValueBuffer("apellidosenv", curPedido.valueBuffer("apellidosenv"));
		setValueBuffer("empresaenv", curPedido.valueBuffer("empresaenv"));
		setValueBuffer("direccionenv", curPedido.valueBuffer("direccionenv"));
		setValueBuffer("codpostalenv", curPedido.valueBuffer("codpostalenv"));
		setValueBuffer("ciudadenv", curPedido.valueBuffer("ciudadenv"));
		setValueBuffer("provinciaenv", curPedido.valueBuffer("provinciaenv"));
		setValueBuffer("apartadoenv", curPedido.valueBuffer("apartadoenv"));
		setValueBuffer("codpaisenv", curPedido.valueBuffer("codpaisenv"));
		setValueBuffer("codenvio", curPedido.valueBuffer("codenvio"));
	}
	
	return true;
}

//// FLUX ECOMMERCE //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition funNumSerie */
/////////////////////////////////////////////////////////////////
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////
/** \D
Copia una líneas de un pedido en su remito asociado. Si se trata de una línea de
número de serie genera tantas líneas de cantidad 1 como cantidad hay en la línea.
@param curdPedido: Cursor posicionado en la línea de pedido a copiar
@param idAlbaran: Identificador del remito
@return identificador de la línea de remito creada si no hay error. FALSE en otro caso.
\end */
function funNumSerie_copiaLineaPedido(curLineaPedido:FLSqlCursor, idAlbaran:Number):Number
{
	var util:FLUtil = new FLUtil();
	
	if (!util.sqlSelect("articulos", "controlnumserie", "referencia = '" + curLineaPedido.valueBuffer("referencia") + "'"))
		return this.iface.__copiaLineaPedido(curLineaPedido, idAlbaran);

	if (!this.iface.curLineaAlbaran)
		this.iface.curLineaAlbaran = new FLSqlCursor("lineasalbaranescli");
	
	var cantidad:Number = parseFloat(curLineaPedido.valueBuffer("cantidad"));
	var cantidadServida:Number = parseFloat(curLineaPedido.valueBuffer("totalenalbaran"));
	
	for (var i:Number = cantidadServida; i < cantidad; i++) {
	
		with (this.iface.curLineaAlbaran) {
			setModeAccess(Insert);
			refreshBuffer();
			setValueBuffer("idalbaran", idAlbaran);
		}
		
		if (!this.iface.datosLineaAlbaran(curLineaPedido))
			return false;
			
		if (!this.iface.curLineaAlbaran.commitBuffer())
			return false;
	}
	
	curLineaPedido.setValueBuffer("cantidad", cantidad);
	
	return this.iface.curLineaAlbaran.valueBuffer("idlinea");
}

function funNumSerie_datosLineaAlbaran(curLineaPedido:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	if(!this.iface.__datosLineaAlbaran(curLineaPedido))
		return false;

	var pvpSinDto:Number = parseFloat(curLineaPedido.valueBuffer("pvpunitario"));

	if (util.sqlSelect("articulos", "controlnumserie", "referencia = '" + curLineaPedido.valueBuffer("referencia") + "'"))
		with (this.iface.curLineaAlbaran) {
			setValueBuffer("cantidad", 1);
			setValueBuffer("pvpsindto", pvpSinDto);
			setValueBuffer("pvptotal", parseFloat(formRecordlineaspedidoscli.iface.pub_commonCalculateField("pvptotal", this)));
		}

	return true;
}


//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////
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


/** @class_definition totalesIva */
/////////////////////////////////////////////////////////////////
//// TOTALES CON IVA ////////////////////////////////////////////

function totalesIva_datosLineaAlbaran(curLineaPedido:FLSqlCursor):Boolean
{
	if(!this.iface.__datosLineaAlbaran(curLineaPedido))
		return false;

	with (this.iface.curLineaAlbaran) {
//		setValueBuffer("totalconiva", curLineaPedido.valueBuffer("totalconiva"));
		setValueBuffer("totalconiva", parseFloat(formRecordlineaspedidoscli.iface.pub_commonCalculateField("totalconiva", this)));
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

function impresiones_imprimir(codPedido:String)
{
	if (sys.isLoadedModule("flfactinfo")) {
		var util:FLUtil = new FLUtil;
		var codigo:String;
		var idPedido:Number;
		if (codPedido) {
			codigo = codPedido;
			idPedido = util.sqlSelect("pedidoscli", "idpedido", "codigo = '" + codPedido + "'");
		}
		else {
			if (!this.cursor().isValid())
				return;
			codigo = this.cursor().valueBuffer("codigo");
			idPedido = this.cursor().valueBuffer("idpedido");
		}

		var dialog:Dialog = new Dialog(util.translate ( "scripts", "Imprimir Pedido" ), 0, "imprimir");

		dialog.OKButtonText = util.translate ( "scripts", "Aceptar" );
		dialog.cancelButtonText = util.translate ( "scripts", "Cancelar" );

		var text:Object = new Label;
		text.text = util.translate("scripts","Pedido: ") + codigo;
		dialog.add(text);

		var bgroup:GroupBox = new GroupBox;
		bgroup.title = util.translate("scripts", "Opciones");
		dialog.add( bgroup );

		var impPedido:RadioButton = new RadioButton;
		impPedido.text = util.translate ( "scripts", "Imprimir Pedido" );
		impPedido.checked = true;
		bgroup.add( impPedido );

		var impComponentes:CheckBox = new CheckBox;
		impComponentes.text = util.translate ( "scripts", "Imprimir artículos con sus componentes" );
		impComponentes.checked = flfactppal.iface.pub_valorDefectoEmpresa("imprimircomponentes");
		bgroup.add( impComponentes );

		if ( !dialog.exec() )
			return true;

		var nombreInforme:String;
		var numCopias:Number = flfactppal.iface.pub_valorDefectoEmpresa("copiaspedido");
		if (!numCopias)
			numCopias = 1;

		if ( impPedido.checked == true) {

			if ( impComponentes.checked == true ){
				nombreInforme = "i_pedidosclicomp";
				flfactinfo.iface.pub_crearTabla("PC", idPedido);
			}
			else
				nombreInforme = "i_pedidoscli";
		}

		var curImprimir:FLSqlCursor = new FLSqlCursor("i_pedidoscli");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_pedidoscli_codigo", codigo);
		curImprimir.setValueBuffer("h_pedidoscli_codigo", codigo);

		flfactinfo.iface.pub_lanzarInforme(curImprimir, nombreInforme, "", "", false, false, "", nombreInforme, numCopias);
	} else
		flfactppal.iface.pub_msgNoDisponible("Informes");
}

function impresiones_imprimirQuick(codPedido:String, impresora:String)
{
	if (sys.isLoadedModule("flfactinfo")) {
		var util:FLUtil = new FLUtil;
		var codigo:String;
		var idPedido:Number;
		if (codPedido) {
			codigo = codPedido;
			idPedido = util.sqlSelect("pedidoscli", "idpedido", "codigo = '" + codPedido + "'");
		}
		else {
			if (!this.cursor().isValid())
				return;
			codigo = this.cursor().valueBuffer("codigo");
			idPedido = this.cursor().valueBuffer("idpedido");
		}

		var impComponentes:Boolean = flfactppal.iface.pub_valorDefectoEmpresa("imprimircomponentes");
		var impDirecta:Boolean = true;

		var nombreInforme:String;
		var numCopias:Number = flfactppal.iface.pub_valorDefectoEmpresa("copiaspedido");
		if (!numCopias)
			numCopias = 1;

		if ( impComponentes == true ){
			nombreInforme = "i_pedidosclicomp";
			flfactinfo.iface.pub_crearTabla("PC", idPedido);
		}
		else
			nombreInforme = "i_pedidoscli";

		var curImprimir:FLSqlCursor = new FLSqlCursor("i_pedidoscli");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_pedidoscli_codigo", codigo);
		curImprimir.setValueBuffer("h_pedidoscli_codigo", codigo);

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

	var orden:Array = [ "codigo", "tipoventa", "servido", "editable", "nombrecliente", "neto", "totaliva", "recfinanciero", "totalpie", "total", "coddivisa", "tasaconv", "totaleuros", "fecha", "fechasalida", "codserie", "numero", "codejercicio", "codalmacen", "codpago", "codenvio", "codcliente", "cifnif", "direccion", "codpostal", "ciudad", "provincia", "codpais", "nombre", "apellidos", "empresa", "codagente", "porcomision", "tpv", "pedidoweb", "pagado", "transactionid", "costototal", "ganancia", "utilidad", "idusuario", "observaciones" ];

	this.iface.tdbRecords.setOrderCols(orden);
}

//// ORDEN_CAMPOS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition tipoVenta */
//////////////////////////////////////////////////////////////////
//// TIPO VENTA //////////////////////////////////////////////////

function tipoVenta_datosAlbaran(curPedido:FLSqlCursor,where:String, datosAgrupacion:Array):Boolean
{
	if (!this.iface.__datosAlbaran(curPedido, where, datosAgrupacion))
		return false;
		
	with (this.iface.curAlbaran) {
		setValueBuffer("tipoventa", "Remito");
		setValueBuffer("codserie", flfactppal.iface.pub_valorDefectoEmpresa("codserie_remito"));
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
			var totalLineas:Number = parseFloat(util.sqlSelect("piepedidoscli", "SUM(totalinc)", "idpedido = " + cursor.valueBuffer("idpedido") + " AND coniva = false"));
			if (!totalLineas || isNaN(totalLineas))
				totalLineas = 0;
			valor = totalLineas;
			break;
		}
		case "total": {
			var totalPie:Number = parseFloat(cursor.valueBuffer("totalpie"));
			valor = this.iface.__commonCalculateField(fN, cursor);
			valor += totalPie;
			valor = parseFloat(util.roundFieldValue(valor, "pedidoscli", "total"));
			break;
		}
		case "neto": {
			var netoPie:Number = parseFloat(util.sqlSelect("piepedidoscli", "SUM(totalinc)", "idpedido = " + cursor.valueBuffer("idpedido") + " AND coniva = true"));
			valor = this.iface.__commonCalculateField(fN, cursor);
			valor += netoPie;
			valor = parseFloat(util.roundFieldValue(valor, "pedidoscli", "neto"));
			break;
		}
		case "totaliva": {
			if (formfacturascli.iface.pub_sinIVA(cursor))
				valor = 0;
			else {
				var ivaPie:Number = parseFloat(util.sqlSelect("piepedidoscli", "SUM(totaliva)", "idpedido = " + cursor.valueBuffer("idpedido") + " AND coniva = true"));
				valor = this.iface.__commonCalculateField(fN, cursor);
				valor += ivaPie;
			}
			valor = parseFloat(util.roundFieldValue(valor, "pedidoscli", "totaliva"));
			break;
		}
		default:{
			valor = this.iface.__commonCalculateField(fN, cursor);
			break;
		}
	}
	return valor;
}

function pieDocumento_copiaPiesPedido(idPedido:Number, idAlbaran:Number):Boolean
{
	var curPiePedido:FLSqlCursor = new FLSqlCursor("piepedidoscli");
	curPiePedido.select("idpedido = " + idPedido);

	while (curPiePedido.next()) {
		curPiePedido.setModeAccess(curPiePedido.Browse);
		if (!this.iface.copiaPiePedido(curPiePedido, idAlbaran))
			return false;
	}
	return true;
}

function pieDocumento_copiaPiePedido(curPiePedido:FLSqlCursor, idAlbaran:Number):Number
{
	if (!this.iface.curPieAlbaran)
		this.iface.curPieAlbaran = new FLSqlCursor("piealbaranescli");
	
	with (this.iface.curPieAlbaran) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idalbaran", idAlbaran);
	}
	
	if (!this.iface.datosPieAlbaran(curPiePedido))
		return false;
		
	if (!this.iface.curPieAlbaran.commitBuffer())
		return false;
	
	return this.iface.curPieAlbaran.valueBuffer("idpie");
}

function pieDocumento_datosPieAlbaran(curPiePedido:FLSqlCursor):Boolean
{
	with (this.iface.curPieAlbaran) {
		setValueBuffer("codpie", curPiePedido.valueBuffer("codpie"));
		setValueBuffer("descripcion", curPiePedido.valueBuffer("descripcion"));
		setValueBuffer("baseimponible", curPiePedido.valueBuffer("baseimponible"));
		setValueBuffer("incporcentual", curPiePedido.valueBuffer("incporcentual"));
		setValueBuffer("inclineal", curPiePedido.valueBuffer("inclineal"));
		setValueBuffer("totalinc", curPiePedido.valueBuffer("totalinc"));
		setValueBuffer("coniva", curPiePedido.valueBuffer("coniva"));
		setValueBuffer("totaliva", curPiePedido.valueBuffer("totaliva"));
		setValueBuffer("totallinea", curPiePedido.valueBuffer("totallinea"));
	}
	return true;
}

function pieDocumento_datosAlbaran(curPedido:FLSqlCursor,where:String, datosAgrupacion:Array):Boolean
{
	if (!this.iface.__datosAlbaran(curPedido, where, datosAgrupacion))
		return false;
		
	with (this.iface.curAlbaran) {
		setValueBuffer("totalpie", curPedido.valueBuffer("totalpie"));
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