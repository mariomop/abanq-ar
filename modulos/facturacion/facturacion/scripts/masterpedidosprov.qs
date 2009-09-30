/***************************************************************************
                 masterpedidosprov.qs  -  description
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
	var pbnGAlbaran:Object;
	var pbnGFactura:Object;
	var tdbRecords:FLTableDB;
	var tbnImprimir:Object;
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
	function commonCalculateField(fN:String, cursor:FLSqlCursor):FLSqlCursor {
		return this.ctx.oficial_commonCalculateField(fN, cursor);
	}
	function copiaLineas(idPedido:Number, idAlbaran:Number, codAlmacen:String):Boolean {
		return this.ctx.oficial_copiaLineas(idPedido, idAlbaran, codAlmacen);
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
	function recordDelBeforepedidosprov() { return this.ctx.pedidosauto_recordDelBeforepedidosprov() };
}
//// PEDIDOS_AUTO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
class lotes extends pedidosauto {
    function lotes( context ) { pedidosauto ( context ); }
// 	function generarAlbaran(where:String, cursor:FLSqlCursor):Number {
// 		return this.ctx.lotes_generarAlbaran(where, cursor);
// 	}
// 	function comprobarAlbaran(idAlbaran:Number,idPedido:Number):Boolean {
// 		return this.ctx.lotes_comprobarAlbaran(idAlbaran,idPedido);
// 	}
	function copiaLineaPedido(curLineaPedido:FLSqlCursor, idAlbaran:Number):Number {
		return this.ctx.lotes_copiaLineaPedido(curLineaPedido, idAlbaran);
	}
}
//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_declaration funNumSerie */
/////////////////////////////////////////////////////////////////
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////
class funNumSerie extends lotes {
	function funNumSerie( context ) { lotes ( context ); }
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

    function impresiones( context ) { totalesIva ( context ); }
	function init() { this.ctx.impresiones_init(); }
	function imprimir(codPedido:String) {
		return this.ctx.impresiones_imprimir(codPedido);
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
	function pub_commonCalculateField(fN:String, cursor:FLSqlCursor):FLSqlCursor {
		return this.commonCalculateField(fN, cursor);
	}
	function pub_generarAlbaran(where:String, cursor:FLSqlCursor, datosAgrupacion:Array):Number {
		return this.generarAlbaran(where, cursor, datosAgrupacion);
	}
	function pub_imprimir(codPedido:String) {
		return this.imprimir(codPedido);
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
Este es el formulario maestro de pedidos a proveedor.
\end */
function interna_init()
{
	this.iface.pbnGAlbaran = this.child("pbnGenerarAlbaran");
	this.iface.pbnGFactura = this.child("pbnGenerarFactura");
	this.iface.tdbRecords = this.child("tableDBRecords");
	this.iface.tbnImprimir = this.child("toolButtonPrint");
	this.iface.tbnAbrirCerrar = this.child("tbnAbrirCerrar");

	connect(this.iface.pbnGAlbaran, "clicked()", this, "iface.pbnGenerarAlbaran_clicked()");
	connect(this.iface.pbnGFactura, "clicked()", this, "iface.pbnGenerarFactura_clicked()");
	connect(this.iface.tdbRecords, "currentChanged()", this, "iface.procesarEstado()");
	connect(this.iface.tbnImprimir, "clicked()", this, "iface.imprimir");
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
	var idFactura:Number;
	var curAlbaran:FLSqlCursor = new FLSqlCursor("albaranesprov");
	var where:String = "idpedido = " + cursor.valueBuffer("idpedido");

	cursor.transaction(false);
	try {
		idAlbaran = this.iface.generarAlbaran(where, cursor);
		if (idAlbaran) {
			where = "idalbaran = " + idAlbaran;
			curAlbaran.select(where);
			if (curAlbaran.first()) {
				cursor.commit();
				cursor.transaction(false);
				idFactura = formalbaranesprov.iface.pub_generarFactura(where, curAlbaran);
				if (idFactura) {
					cursor.commit();
				} else
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
		this.iface.curAlbaran = new FLSqlCursor("albaranesprov");
	
	this.iface.curAlbaran.setModeAccess(this.iface.curAlbaran.Insert);
	this.iface.curAlbaran.refreshBuffer();
	
	if (!this.iface.datosAlbaran(curPedido, where, datosAgrupacion))
		return false;
	
	if (!this.iface.curAlbaran.commitBuffer()) {
		return false;
	}
	
	var idAlbaran:Number = this.iface.curAlbaran.valueBuffer("idalbaran");
	
	var qryPedidos:FLSqlQuery = new FLSqlQuery();
	qryPedidos.setTablesList("pedidosprov");
	qryPedidos.setSelect("idpedido");
	qryPedidos.setFrom("pedidosprov");
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
	
	var codEjercicio:String = curPedido.valueBuffer("codejercicio");
	var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(fecha, codEjercicio, "albaranesprov");
	if (!datosDoc.ok)
		return false;
	if (datosDoc.modificaciones == true) {
		codEjercicio = datosDoc.codEjercicio;
		fecha = datosDoc.fecha;
	}

	with (this.iface.curAlbaran) {
		setValueBuffer("codproveedor", curPedido.valueBuffer("codproveedor"));
		setValueBuffer("nombre", curPedido.valueBuffer("nombre"));
		setValueBuffer("cifnif", curPedido.valueBuffer("cifnif"));
		setValueBuffer("coddivisa", curPedido.valueBuffer("coddivisa"));
		setValueBuffer("tasaconv", curPedido.valueBuffer("tasaconv"));
		setValueBuffer("codpago", curPedido.valueBuffer("codpago"));
		setValueBuffer("codalmacen", curPedido.valueBuffer("codalmacen"));
		setValueBuffer("fecha", fecha);
		setValueBuffer("hora", hora);
		setValueBuffer("codejercicio", codEjercicio);
		setValueBuffer("tasaconv", curPedido.valueBuffer("tasaconv"));
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
		setValueBuffer("neto", formalbaranesprov.iface.pub_commonCalculateField("neto", this));
		setValueBuffer("totaliva", formalbaranesprov.iface.pub_commonCalculateField("totaliva", this));
		setValueBuffer("total", formalbaranesprov.iface.pub_commonCalculateField("total", this));
		setValueBuffer("totaleuros", formalbaranesprov.iface.pub_commonCalculateField("totaleuros", this));
	}
	return true;
}


function oficial_actualizarDatosPedido(where:String, idAlbaran:String):Boolean
{
	var curPedidos:FLSqlCursor = new FLSqlCursor("pedidosprov");
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

function oficial_commonCalculateField(fN:String, cursor:FLSqlCursor):FLSqlCursor
{
	var util:FLUtil = new FLUtil();
	var valor:String;

	/** \C
	El --código-- se construye como la concatenación de --codserie--, --codejercicio-- y --numero--
	\end */
	if (fN == "codigo") {
		valor = flfacturac.iface.pub_construirCodigo(cursor.valueBuffer("codserie"), cursor.valueBuffer("codejercicio"), cursor.valueBuffer("numero"));
	}

	switch (fN) {
		/** \C
		El --total-- es el --neto-- más el --totaliva--
		\end */
		case "total": {
			var neto:Number = parseFloat(cursor.valueBuffer("neto"));
			var totalIva:Number = parseFloat(cursor.valueBuffer("totaliva"));
			valor = neto + totalIva;
			valor = parseFloat(util.roundFieldValue(valor, "pedidosprov", "total"));
			break;
		}
		/** \C
		El --totaleuros-- es el producto del --total-- por la --tasaconv--
		\end */
		case "totaleuros":{
			var total:Number = parseFloat(cursor.valueBuffer("total"));
			var tasaConv:Number = parseFloat(cursor.valueBuffer("tasaconv"));
			valor = total * tasaConv;
			valor = parseFloat(util.roundFieldValue(valor, "pedidosprov", "totaleuros"));
			break;
		}
		/** \C
		El --neto-- es la suma del pvp total de las líneas de remito
		\end */
		case "neto": {
			valor = util.sqlSelect("lineaspedidosprov", "SUM(pvptotal)", "idpedido = " + cursor.valueBuffer("idpedido"));
			valor = parseFloat(util.roundFieldValue(valor, "pedidosprov", "neto"));
			break;
		}
		/** \C
		El --totaliva-- es la suma del iva correspondiente a las líneas de remito
		\end */
		case "totaliva": {
			if (formfacturasprov.iface.pub_sinIVA(cursor)) {
				valor = 0;
			} else {
				valor = util.sqlSelect("lineaspedidosprov", "SUM((pvptotal * iva) / 100)", "idpedido = " + cursor.valueBuffer("idpedido"));
			}
			valor = parseFloat(util.roundFieldValue(valor, "pedidosprov", "totaliva"));
			break;
		}
	}
	return valor;
}

/** \D
Copia las líneas de un pedido como líneas de su remito asociado
@param idPedido: Identificador del pedido
@param idAlbaran: Identificador del remito
@return VERDADERO si la copia se realiza correctamente. FALSO en otro caso
\end */
function oficial_copiaLineas(idPedido:Number, idAlbaran:Number):Boolean
{
	var cantidad:Number;
	var totalEnAlbaran:Number;
	var curLineaPedido:FLSqlCursor = new FLSqlCursor("lineaspedidosprov");
	curLineaPedido.select("idpedido = " + idPedido + " AND (cerrada = false or cerrada IS NULL)");
	while (curLineaPedido.next()) {
		curLineaPedido.setModeAccess(curLineaPedido.Browse);
		curLineaPedido.refreshBuffer();
		cantidad = parseFloat(curLineaPedido.valueBuffer("cantidad"));
		totalEnAlbaran = parseFloat(curLineaPedido.valueBuffer("totalenalbaran"));
		if (cantidad > totalEnAlbaran) {
			if (!this.iface.copiaLineaPedido(curLineaPedido, idAlbaran))
				return false;
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
		this.iface.curLineaAlbaran = new FLSqlCursor("lineasalbaranesprov");
	
	with (this.iface.curLineaAlbaran) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idalbaran", idAlbaran);
	}
	
	if (!this.iface.datosLineaAlbaran(curLineaPedido))
		return false;
		
	if (!this.iface.curLineaAlbaran.commitBuffer())
		return false;
	
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
	var pvpSinDto:Number = parseFloat(curLineaPedido.valueBuffer("pvpsindto")) * cantidad / parseFloat(curLineaPedido.valueBuffer("cantidad"));
	pvpSinDto = util.roundFieldValue(pvpSinDto, "lineasalbaranesprov", "pvpsindto");
	
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
		setValueBuffer("pvpsindto", pvpSinDto);
		setValueBuffer("pvptotal", formRecordlineaspedidosprov.iface.pub_commonCalculateField("pvptotal", this));
	}
	return true;
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
	if(util.sqlSelect("lineaspedidosprov","cerrada","idpedido = " + idPedido + " AND cerrada")) {
		cerrar = false;
		res = MessageBox.information(util.translate("scripts", "El pedido seleccionado tiene líneas cerradas.\n¿Seguro que desa abrirlas?"), MessageBox.Yes, MessageBox.No);
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

	if(!util.sqlUpdate("lineaspedidosprov","cerrada",cerrar,"idpedido = " + idPedido))
		return;

	if (!flfacturac.iface.pub_actualizarEstadoPedidoProv(idPedido))
		return;

	this.iface.tdbRecords.refresh();
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition pedidosauto */
/////////////////////////////////////////////////////////////////
//// PEDIDOS_AUTO //////////////////////////////////////////////

function pedidosauto_recordDelBeforepedidosprov()
{
	var cursor:FLSqlCursor = this.cursor();
	if (!cursor.isValid())
		return false;
		
	if (cursor.modeAccess() != cursor.Del)
		return true;
	
	var curTab:FLSqlCursor = new FLSqlCursor("pedidosaut");
	curTab.select("idpedidoaut = " + cursor.valueBuffer("idpedidoaut"));
	if (!curTab.first())
		return true;
		
	with(curTab) {
		setUnLock("editable", true);
		setModeAccess(Edit);
		refreshBuffer();
		commitBuffer();
	}
	
	return true;
}
//// PEDIDOS_AUTO //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
/*
function lotes_generarAlbaran(where:String, cursor:FLSqlCursor):Number 
{
	var util:FLUtil = new FLUtil;
	var qryPedidos:FLSqlQuery = new FLSqlQuery();
	qryPedidos.setTablesList("pedidosprov");
	qryPedidos.setSelect("idpedido,codproveedor,codigo");
	qryPedidos.setFrom("pedidosprov");
	qryPedidos.setWhere(where);
	if (!qryPedidos.exec())
		return false;
		
	if (qryPedidos.size() == 1) {
		qryPedidos.first();
		if (util.sqlSelect("lineaspedidosprov INNER JOIN articulos ON lineaspedidosprov.referencia = articulos.referencia", "idlinea", "idpedido = " + qryPedidos.value(0) + " AND porlotes = true", "lineaspedidosprov,articulos")) {
			var res:Number = MessageBox.warning(util.translate("scripts", "Este pedido (%1) contiene artículos por lotes.\nPara asociar un remito a este pedido debe crearlo manualmente para luego seleccionarlo\n¿Desea continuar?").arg(qryPedidos.value("codigo")), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
			if(res != MessageBox.Yes)
				return false;
			var f:Object = new FLFormSearchDB("albaranesprov");
			var curForm:FLSqlCursor = f.cursor();
			curForm.select();
	
			var qryLAlbaran:FLSqlQuery = new FLSqlQuery();
			qryLAlbaran.setTablesList("lineasalbaranesprov");
			qryLAlbaran.setSelect("idalbaran");
			qryLAlbaran.setFrom("lineasalbaranesprov");
			qryLAlbaran.setWhere("idpedido <> 0 GROUP BY idalbaran");
			if (!qryLAlbaran.exec())
				return false;	
			
			var lista:String = "";
			while(qryLAlbaran.next()){
				lista += qryLAlbaran.value(0) + ",";
			}
			
			f.setMainWidget();
			if (lista == "")
				curForm.setMainFilter("codproveedor = '" + qryPedidos.value(1) + "' AND ptefactura = true");
			else {
				lista = lista.left(lista.length -1);
				curForm.setMainFilter("codproveedor = '" + qryPedidos.value(1) + "' AND ptefactura = true AND idalbaran NOT IN (" + lista + ")");
			}
				
			curForm.refreshBuffer();
			var acpt:String = f.exec("codejercicio");
			var idAlbaran:Number;
			if (!acpt) 
				return false;
			idAlbaran = curForm.valueBuffer("idalbaran");
			if (!this.iface.comprobarAlbaran(idAlbaran, qryPedidos.value(0))) {
				MessageBox.warning(util.translate("scripts", "No se puede asociar al albaran ") + util.sqlSelect("albaranesprov","codigo","idalbaran = " + idAlbaran) + ("scripts", " porque los datos no coinciden con los del pedido"), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}
			formRecordlineasalbaranesprov.iface.pub_actualizarEstadoPedido(qryPedidos.value(0));
			this.iface.procesarEstado();
			return true;
		}
	} else {
		while (qryPedidos.next()) {
			if (util.sqlSelect("lineaspedidosprov INNER JOIN articulos ON lineaspedidosprov.referencia = articulos.referencia", "idlinea", "idpedido = " + qryPedidos.value(0) + " AND porlotes = true", "lineaspedidosprov,articulos")) {
			MessageBox.warning(util.translate("scripts", "No puede generar el remito porque alguno de los pedidos que lo forman contiene artículos gestionados por lotes"), MessageBox.Ok, MessageBox.NoButton);
			return false;
			}
		}
	}
	return this.iface.__generarAlbaran(where, cursor);
}

function lotes_comprobarAlbaran(idAlbaran:Number,idPedido:Number):Boolean
{
	var qryLPedido:FLSqlQuery = new FLSqlQuery();
	qryLPedido.setTablesList("lineaspedidosprov");
	qryLPedido.setSelect("idlinea,referencia,cantidad");
	qryLPedido.setFrom("lineaspedidosprov");
	qryLPedido.setWhere("idpedido = " + idPedido);
	if (!qryLPedido.exec())
		return false;
		
	var qryLAlbaran:FLSqlQuery = new FLSqlQuery();
	qryLAlbaran.setTablesList("lineasalbaranesprov");
	qryLAlbaran.setSelect("idlinea,referencia,cantidad");
	qryLAlbaran.setFrom("lineasalbaranesprov");
	qryLAlbaran.setWhere("idalbaran = " + idAlbaran);
	if (!qryLAlbaran.exec())
		return false;
		
	if(qryLPedido.size() != qryLAlbaran.size())
		return false;
	
	var curLPedido:FLSqlCursor = new FLSqlCursor("lineaspedidosprov");
	var curLAlbaran:FLSqlCursor = new FLSqlCursor("lineasalbaranesprov");
		
	var encontrado:Boolean = false;
	while(qryLPedido.next()){
		encontrado = false;
		qryLAlbaran.first();
		do{
			if(qryLPedido.value(1) == qryLAlbaran.value(1)){
				encontrado = true;
				if(parseFloat(qryLPedido.value(2)) != parseFloat(qryLAlbaran.value(2)))
					encontrado = false;
			}
			if(encontrado){
				curLPedido.select("idlinea = " + qryLPedido.value(0));
				curLPedido.first();
				curLPedido.setModeAccess(curLPedido.Edit);
				curLPedido.refreshBuffer();
				curLPedido.setValueBuffer("totalenalbaran", qryLAlbaran.value(2));
				if (!curLPedido.commitBuffer())
					return false;
					
				curLAlbaran.select("idlinea = " + qryLAlbaran.value(0));
				curLAlbaran.first();
				curLAlbaran.setModeAccess(curLAlbaran.Edit);
				curLAlbaran.refreshBuffer();
				curLAlbaran.setValueBuffer("idpedido", idPedido);
				curLAlbaran.setValueBuffer("idlineapedido", qryLPedido.value(0));
				if (!curLAlbaran.commitBuffer())
					return false;
			}
		} while(qryLAlbaran.next() && !encontrado);
	}
	if(!encontrado)
		return false;
	return true;
}*/

function lotes_copiaLineaPedido(curLineaPedido:FLSqlCursor, idAlbaran:Number):Number
{
	var util:FLUtil = new FLUtil;
	var idLineaAlbaran:Number = this.iface.__copiaLineaPedido(curLineaPedido, idAlbaran);
	
	var referencia:String = curLineaPedido.valueBuffer("referencia");
	if (!util.sqlSelect("articulos", "porlotes", "referencia = '" + referencia + "'"))
		return idLineaAlbaran;
	var codAlmacen:String = util.sqlSelect("albaranesprov","codalmacen","idalbaran = " + idAlbaran);

	var canLinea:Number = parseFloat(curLineaPedido.valueBuffer("cantidad"))-parseFloat(curLineaPedido.valueBuffer("totalenalbaran"));
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
			var fecha:Date = util.sqlSelect("albaranesprov","fecha","idalbaran = " + idAlbaran);
			 var idStock:Number = util.sqlSelect("stocks", "idstock", "codalmacen = '" + codAlmacen + "' AND referencia = '" + referencia + "'");

			if(!idStock)
				idStock = flfactalma.iface.pub_crearStock(codAlmacen,referencia);
			if(!idStock)
				return false;

			curMoviLote.setModeAccess(curMoviLote.Insert);
			curMoviLote.refreshBuffer();
			curMoviLote.setValueBuffer("codlote", codLote);
			curMoviLote.setValueBuffer("fecha", fecha);
			curMoviLote.setValueBuffer("tipo", "Entrada");
			curMoviLote.setValueBuffer("docorigen", "RP");
			curMoviLote.setValueBuffer("idlineaap", idLineaAlbaran);
			curMoviLote.setValueBuffer("idstock", idStock);
			curMoviLote.setValueBuffer("cantidad", nuevaCantidad);
			if(!curMoviLote.commitBuffer())
				return false;
			canTotal += nuevaCantidad;
		}
		else
			return false;
	}
	
	return idLineaAlbaran;
}

//// LOTES //////////////////////////////////////////////////////
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
		this.iface.curLineaAlbaran = new FLSqlCursor("lineasalbaranesprov");
	
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
	if (!util.sqlSelect("articulos", "controlnumserie", "referencia = '" + curLineaPedido.valueBuffer("referencia") + "'"))
		return this.iface.__datosLineaAlbaran(curLineaPedido);
	
	var pvpSinDto:Number = parseFloat(curLineaPedido.valueBuffer("pvpsindto")) / parseFloat(curLineaPedido.valueBuffer("cantidad"));
	pvpSinDto = util.roundFieldValue(pvpSinDto, "lineasalbaranesprov", "pvpsindto");
	
	with (this.iface.curLineaAlbaran) {
		setValueBuffer("idlineapedido", curLineaPedido.valueBuffer("idlinea"));
		setValueBuffer("idpedido", curLineaPedido.valueBuffer("idpedido"));
		setValueBuffer("referencia", curLineaPedido.valueBuffer("referencia"));
		setValueBuffer("descripcion", curLineaPedido.valueBuffer("descripcion"));
		setValueBuffer("pvpunitario", curLineaPedido.valueBuffer("pvpunitario"));
		setValueBuffer("cantidad", 1);
		setValueBuffer("codimpuesto", curLineaPedido.valueBuffer("codimpuesto"));
		setValueBuffer("iva", curLineaPedido.valueBuffer("iva"));
		setValueBuffer("dtolineal", curLineaPedido.valueBuffer("dtolineal"));
		setValueBuffer("dtopor", curLineaPedido.valueBuffer("dtopor"));
		setValueBuffer("pvpsindto", pvpSinDto);
		setValueBuffer("pvptotal", formRecordlineaspedidosprov.iface.pub_commonCalculateField("pvptotal", this));
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
		setValueBuffer("totalconiva", curLineaPedido.valueBuffer("totalconiva"));
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

	connect(this.iface.tbnImprimir, "clicked()", this, "iface.imprimir");
}

function impresiones_imprimir(codPedido:String)
{
	if (sys.isLoadedModule("flfactinfo")) {
		var util:FLUtil = new FLUtil;
		var codigo:String;
		var idPedido:Number;
		if (codPedido) {
			codigo = codPedido;
			idPedido = util.sqlSelect("pedidosprov", "idpedido", "codigo = '" + codPedido + "'");
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

		var impNormal:RadioButton = new RadioButton;
		impNormal.text = util.translate ( "scripts", "Imprimir normalmente" );
		impNormal.checked = true;
		bgroup.add( impNormal );

		var impComponentes:RadioButton = new RadioButton;
		impComponentes.text = util.translate ( "scripts", "Imprimir artículos con sus componentes" );
		impComponentes.checked = false;
		bgroup.add( impComponentes );

		if ( !dialog.exec() )
			return true;

		var nombreInforme:String;

		if ( impNormal.checked == true ) {
			nombreInforme = "i_pedidosprov";
		}
		else if ( impComponentes.checked == true ) {
			nombreInforme = "i_pedidosprovcomp";
			flfactinfo.iface.pub_crearTabla("PP", idPedido);
		}

		var curImprimir:FLSqlCursor = new FLSqlCursor("i_pedidosprov");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_pedidosprov_codigo", codigo);
		curImprimir.setValueBuffer("h_pedidosprov_codigo", codigo);

		flfactinfo.iface.pub_lanzarInforme(curImprimir, nombreInforme, "", "", false, false, "", nombreInforme);
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

	var orden:Array = [ "codigo", "tipoventa", "servido", "editable", "numproveedor", "nombre", "neto", "totaliva", "totalpie", "total", "coddivisa", "tasaconv", "totaleuros", "fecha", "codserie", "numero", "codejercicio", "codalmacen", "codpago", "codproveedor", "cifnif", "idusuario", "observaciones" ];

	this.iface.tdbRecords.setOrderCols(orden);
	this.iface.tdbRecords.setFocus();
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
			var totalLineas:Number = parseFloat(util.sqlSelect("piepedidosprov", "SUM(totalinc)", "idpedido = " + cursor.valueBuffer("idpedido") + " AND incluidoneto = false"));
			if (!totalLineas || isNaN(totalLineas))
				totalLineas = 0;
			valor = totalLineas;
			break;
		}
		case "total": {
			var totalPie:Number = parseFloat(cursor.valueBuffer("totalpie"));
			valor = this.iface.__commonCalculateField(fN, cursor);
			valor += totalPie;
			valor = parseFloat(util.roundFieldValue(valor, "pedidosprov", "total"));
			break;
		}
		case "neto": {
			var netoPie:Number = parseFloat(util.sqlSelect("piepedidosprov", "SUM(totalinc)", "idpedido = " + cursor.valueBuffer("idpedido") + " AND incluidoneto = true"));
			valor = this.iface.__commonCalculateField(fN, cursor);
			valor += netoPie;
			valor = parseFloat(util.roundFieldValue(valor, "pedidosprov", "neto"));
			break;
		}
		case "totaliva": {
			if (formfacturasprov.iface.pub_sinIVA(cursor)) {
				valor = 0;
			} else {
				var ivaPie:Number = parseFloat(util.sqlSelect("piepedidosprov", "SUM(totaliva)", "idpedido = " + cursor.valueBuffer("idpedido") + " AND incluidoneto = true"));
				valor = this.iface.__commonCalculateField(fN, cursor);
				valor += ivaPie;
			}
			valor = parseFloat(util.roundFieldValue(valor, "pedidosprov", "totaliva"));
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
	var curPiePedido:FLSqlCursor = new FLSqlCursor("piepedidosprov");
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
		this.iface.curPieAlbaran = new FLSqlCursor("piealbaranesprov");
	
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
		setValueBuffer("incluidoneto", curPiePedido.valueBuffer("incluidoneto"));
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