/***************************************************************************
                 masteralbaranesprov.qs  -  description
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
	function copiaLineaAlbaran(curLineaAlbaran:FLSqlCursor, idFactura:Number):Number {
		return this.ctx.oficial_copiaLineaAlbaran(curLineaAlbaran, idFactura);
	}
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.oficial_commonCalculateField(fN, cursor);
	}
	function asociarAAlbaran() {
		return this.ctx.oficial_asociarAAlbaran();
	}
	function whereAgrupacion(curAgrupar:FLSqlCursor):String {
		return this.ctx.oficial_whereAgrupacion(curAgrupar);
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

/** @class_declaration funNumSerie */
/////////////////////////////////////////////////////////////////
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////
class funNumSerie extends lotes {
	function funNumSerie( context ) { lotes ( context ); }
	function datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean {
		return this.ctx.funNumSerie_datosLineaFactura(curLineaAlbaran);
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


/** @class_declaration impresiones */
/////////////////////////////////////////////////////////////////
//// IMPRESIONES ////////////////////////////////////////////////
class impresiones extends totalesIva {
	var tbnImprimir:Object;

    function impresiones( context ) { totalesIva ( context ); }
	function init() { this.ctx.impresiones_init(); }
	function imprimir(codAlbaran:String) {
		return this.ctx.impresiones_imprimir(codAlbaran);
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
	function pub_commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.commonCalculateField(fN, cursor);
	}
	function pub_generarFactura(where:String, curAlbaran:FLSqlCursor, datosAgrupacion:Array):Number {
		return this.generarFactura(where, curAlbaran, datosAgrupacion);
	}
	function pub_whereAgrupacion(curAgrupar:FLSqlCursor):String {
		return this.whereAgrupacion(curAgrupar);
	}
	function pub_imprimir(codAlbaran:String) {
		return this.imprimir(codAlbaran);
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
Este es el formulario maestro de albaranes a proveedor.
\end */
function interna_init()
{
	this.iface.pbnGFactura = this.child("pbnGenerarFactura");
	this.iface.pbnAAlbaran = this.child("pbnAsociarAAlbaran");
	this.iface.tdbRecords = this.child("tableDBRecords");

	connect(this.iface.pbnAAlbaran, "clicked()", this, "iface.asociarAAlbaran");
	connect(this.iface.pbnGFactura, "clicked()", this, "iface.pbnGenerarFactura_clicked");
	connect(this.iface.tdbRecords, "currentChanged()", this, "iface.procesarEstado");

	var codEjercicio = flfactppal.iface.pub_ejercicioActual();;
	if (codEjercicio)
		this.cursor().setMainFilter("codejercicio='" + codEjercicio + "'");

	this.iface.procesarEstado();
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \C
Al pulsar el botón imprimir se lanzará el informe correspondiente al remito seleccionado (en caso de que el módulo de informes esté cargado)
\end */

function oficial_procesarEstado()
{
	if (this.cursor().isValid() && this.cursor().valueBuffer("ptefactura") == true) {
		this.iface.pbnGFactura.enabled = true;
	} else {
		this.iface.pbnGFactura.enabled = false;
	}
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

	var idFactura:Number;
	var where:String = "idalbaran = " + cursor.valueBuffer("idalbaran");

	cursor.transaction(false);
	try {
		idFactura = this.iface.generarFactura(where, cursor);
		if (idFactura)
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
		this.iface.curFactura = new FLSqlCursor("facturasprov");
	
	this.iface.curFactura.setModeAccess(this.iface.curFactura.Insert);
	this.iface.curFactura.refreshBuffer();
	
	if (!this.iface.datosFactura(curAlbaran, where, datosAgrupacion)) {
		return false;
	}

	if (!this.iface.curFactura.commitBuffer()) {
		return false;
	}
	var idFactura:Number = this.iface.curFactura.valueBuffer("idfactura");
	
	var curAlbaranes:FLSqlCursor = new FLSqlCursor("albaranesprov");
	curAlbaranes.select(where);
	var idAlbaran:Number;
	while (curAlbaranes.next()) {
		curAlbaranes.setModeAccess(curAlbaranes.Edit);
		curAlbaranes.refreshBuffer();
		idAlbaran = curAlbaranes.valueBuffer("idalbaran");
		if (!this.iface.copiaLineasAlbaran(idAlbaran, idFactura))
			return false;

		curAlbaranes.setValueBuffer("idfactura", idFactura);
		curAlbaranes.setValueBuffer("ptefactura", false);
		if (!curAlbaranes.commitBuffer())
			return false;

		// Crea los pies de factura a partir de los pies de remito
		if (!this.iface.copiaPiesAlbaran(idAlbaran, idFactura)) {
			return false;
		}
	}

	this.iface.curFactura.select("idfactura = " + idFactura);
	if (this.iface.curFactura.first()) {
/* 
		if (!formRecordfacturasprov.iface.pub_actualizarLineasIva(idFactura))
			return false;
*/
		
		this.iface.curFactura.setModeAccess(this.iface.curFactura.Edit);
		this.iface.curFactura.refreshBuffer();
		
		if (!this.iface.totalesFactura())
			return false;
		
		if (this.iface.curFactura.commitBuffer() == false)
			return false;
	}
	return idFactura;
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
	var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(fecha, codEjercicio, "facturasprov");
	if (!datosDoc.ok)
		return false;
	if (datosDoc.modificaciones == true) {
		codEjercicio = datosDoc.codEjercicio;
		fecha = datosDoc.fecha;
	}
	
	with(this.iface.curFactura) {
		setValueBuffer("codproveedor", curAlbaran.valueBuffer("codproveedor"));
		setValueBuffer("nombre", curAlbaran.valueBuffer("nombre"));
		setValueBuffer("cifnif", curAlbaran.valueBuffer("cifnif"));
		setValueBuffer("coddivisa", curAlbaran.valueBuffer("coddivisa"));
		setValueBuffer("tasaconv", curAlbaran.valueBuffer("tasaconv"));
		setValueBuffer("codpago", curAlbaran.valueBuffer("codpago"));
		setValueBuffer("codalmacen", curAlbaran.valueBuffer("codalmacen"));
		setValueBuffer("fecha", fecha);
		setValueBuffer("hora", hora);
		setValueBuffer("codejercicio", codEjercicio);
		setValueBuffer("tasaconv", curAlbaran.valueBuffer("tasaconv"));
		setValueBuffer("automatica", true);
		setValueBuffer("observaciones", curAlbaran.valueBuffer("observaciones"));
	}
	return true;
}

/** \D Copia los datos de una línea de remito en una línea de factura
@param	curLineaAlbaran: Cursor que contiene los datos a incluir en la línea de factura
@return	True si el cálculo se realiza correctamente, false en caso contrario
\end */
function oficial_datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var referencia:String = curLineaAlbaran.valueBuffer("referencia");
	
	with (this.iface.curLineaFactura) {
		setValueBuffer("referencia", referencia);
		setValueBuffer("descripcion", curLineaAlbaran.valueBuffer("descripcion"));
		setValueBuffer("pvpunitario", curLineaAlbaran.valueBuffer("pvpunitario"));
		setValueBuffer("pvpsindto", curLineaAlbaran.valueBuffer("pvpsindto"));
		setValueBuffer("cantidad", curLineaAlbaran.valueBuffer("cantidad"));
		setValueBuffer("pvptotal", curLineaAlbaran.valueBuffer("pvptotal"));
		setValueBuffer("codimpuesto", curLineaAlbaran.valueBuffer("codimpuesto"));
		setValueBuffer("iva", curLineaAlbaran.valueBuffer("iva"));
		setValueBuffer("dtopor", curLineaAlbaran.valueBuffer("dtopor"));
		setValueBuffer("dtolineal", curLineaAlbaran.valueBuffer("dtolineal"));
		setValueBuffer("idalbaran", curLineaAlbaran.valueBuffer("idalbaran"));
	}
	
	/** \C La subcuenta de compras asociada a cada línea será la establecida en la tabla de artículos
	\end */
	if (sys.isLoadedModule("flcontppal") && referencia != "") {
		var codSubcuenta = util.sqlSelect("articulos", "codsubcuentacom", "referencia = '" + referencia + "'");
		if (codSubcuenta) {
			var ejercicioActual:String = flfactppal.iface.pub_ejercicioActual();
			var idSubcuenta:Number = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + ejercicioActual + "'");
			if (!idSubcuenta) {
				MessageBox.warning(util.translate("scripts", "No existe la subcuenta de compras con código ") + codSubcuenta +  util.translate("scripts", " y ejercicio ") + ejercicioActual + ".\n" + util.translate("scripts", "Debe crear la subcuenta en el área Financiera."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
			}
			this.iface.curLineaFactura.setValueBuffer("codsubcuenta", codSubcuenta);
			this.iface.curLineaFactura.setValueBuffer("idsubcuenta", idSubcuenta);
		}
	}
	return true;
}

/** \D Informa los datos de una factura referentes a totales (I.V.A., neto, etc.)
@return	True si el cálculo se realiza correctamente, false en caso contrario
\end */
function oficial_totalesFactura():Boolean
{
	with (this.iface.curFactura) {
		setValueBuffer("neto", formfacturasprov.iface.pub_commonCalculateField("neto", this));
		setValueBuffer("totaliva", formfacturasprov.iface.pub_commonCalculateField("totaliva", this));
		setValueBuffer("total", formfacturasprov.iface.pub_commonCalculateField("total", this));
		setValueBuffer("totaleuros", formfacturasprov.iface.pub_commonCalculateField("totaleuros", this));
	}
	return true;
}

/** \D
Copia las líneas de un remito como líneas de su factura asociada
@param idAlbaran: Identificador del remito
@param idFactura: Identificador de la factuta
@return	Verdadero si no hay error, falso en caso contrario
\end */
function oficial_copiaLineasAlbaran(idAlbaran:Number, idFactura:Number):Boolean
{
	var curLineaAlbaran:FLSqlCursor = new FLSqlCursor("lineasalbaranesprov");
	curLineaAlbaran.select("idalbaran = " + idAlbaran);
	
	while (curLineaAlbaran.next()) {
		curLineaAlbaran.setModeAccess(curLineaAlbaran.Browse);
		if (!this.iface.copiaLineaAlbaran(curLineaAlbaran, idFactura))
			return false;
	}
	return true;
}

/** \D
Copia una líneas de remito en su factura asociada
@param curLineaAlbaran: Cursor posicionado en la línea de remito
@param idFactura: Identificador de la factuta
@return	identificador de la línea creada si no hay error falso en caso contrario
\end */
function oficial_copiaLineaAlbaran(curLineaAlbaran:FLSqlCursor, idFactura:Number):Number
{
	if (!this.iface.curLineaFactura)
		this.iface.curLineaFactura = new FLSqlCursor("lineasfacturasprov");
	
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
			valor = parseFloat(util.roundFieldValue(valor, "albaranesprov", "total"));
			break;
		}
		/** \C
		El --totaleuros-- es el producto del --total-- por la --tasaconv--
		\end */
		case "totaleuros": {
			var total:Number = parseFloat(cursor.valueBuffer("total"));
			var tasaConv:Number = parseFloat(cursor.valueBuffer("tasaconv"));
			valor = total * tasaConv;
			valor = parseFloat(util.roundFieldValue(valor, "albaranesprov", "totaleuros"));
			break;
		}
		/** \C
		El --neto-- es la suma del pvp total de las líneas de remito
		\end */
		case "neto": {
			valor = util.sqlSelect("lineasalbaranesprov", "SUM(pvptotal)", "idalbaran = " + cursor.valueBuffer("idalbaran"));
			valor = parseFloat(util.roundFieldValue(valor, "albaranesprov", "neto"));
			break;
		}
		/** \C
		El --totaliva-- es la suma del iva correspondiente a las líneas de remito
		\end */
		case "totaliva": {
			if (formfacturasprov.iface.pub_sinIVA(cursor)) {
				valor = 0;
			} else {
				valor = util.sqlSelect("lineasalbaranesprov", "SUM((pvptotal * iva) / 100)", "idalbaran = " + cursor.valueBuffer("idalbaran"));
			}
			valor = parseFloat(util.roundFieldValue(valor, "albaranesprov", "totaliva"));
			break;
		}
	}
	return valor;
}

/** \C
Al pulsar el botón de asociar a remito se abre la ventana de agrupar pedidos de proveedor
\end */
function oficial_asociarAAlbaran()
{
		var util:FLUtil = new FLUtil;
		var f:Object = new FLFormSearchDB("agruparpedidosprov");
		var cursor:FLSqlCursor = f.cursor();
		var where:String;
		var codProveedor:String;
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
				var curAgruparPedidos:FLSqlCursor = new FLSqlCursor("agruparpedidosprov");
				curAgruparPedidos.select();
				if (curAgruparPedidos.first()) {
						where = this.iface.whereAgrupacion(curAgruparPedidos);
						var excepciones:String = curAgruparPedidos.valueBuffer("excepciones");
						if (!excepciones.isEmpty())
								where += " AND idpedido NOT IN (" + excepciones + ")";

						var qryAgruparPedidos:FLSqlQuery = new FLSqlQuery;
						qryAgruparPedidos.setTablesList("pedidosprov");
						qryAgruparPedidos.setSelect("codproveedor,codalmacen");
						qryAgruparPedidos.setFrom("pedidosprov");
						qryAgruparPedidos.setWhere(where + " GROUP BY codproveedor,codalmacen");

						if (!qryAgruparPedidos.exec())
								return;

						var totalProv:Number = qryAgruparPedidos.size();
						util.createProgressDialog(util.translate("scripts", "Generando remitos"), totalProv);
						util.setProgress(1);
						var j:Number = 0;

						var curPedido:FLSqlCursor = new FLSqlCursor("pedidosprov");
						var whereAlbaran:String;
						var datosAgrupacion:Array = [];
						while (qryAgruparPedidos.next()) {
							codProveedor = qryAgruparPedidos.value(0);
							codAlmacen = qryAgruparPedidos.value(1);
							whereAlbaran = where;
							if(codProveedor && codProveedor != "")
								whereAlbaran += " AND codproveedor = '" + codProveedor + "'";
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
								if (formpedidosprov.iface.pub_generarAlbaran(whereAlbaran, curPedido, datosAgrupacion)) {
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
						util.setProgress(totalProv);
						util.destroyProgressDialog();
				}

				f.close();
				this.iface.tdbRecords.refresh();
		}
}

/** \D
Construye un array con los datos del remito a generar especificados en el formulario de agrupación de pedidos
@param curAgruparPedidos: Cursor de la tabla agruparpedidosprov que contiene los valores
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
@param curAgrupar: Cursor de la tabla agruparpedidosprov que contiene los valores de los criterios de búsqueda
@return Sentencia where
\end */
function oficial_whereAgrupacion(curAgrupar:FLSqlCursor):String
{
		var codProveedor:String = curAgrupar.valueBuffer("codproveedor");
		var nombre:String = curAgrupar.valueBuffer("nombre");
		var cifNif:String = curAgrupar.valueBuffer("cifnif");
		var codAlmacen:String = curAgrupar.valueBuffer("codalmacen");
		var codPago:String = curAgrupar.valueBuffer("codpago");
		var codDivisa:String = curAgrupar.valueBuffer("coddivisa");
		var fechaDesde:String = curAgrupar.valueBuffer("fechadesde");
		var fechaHasta:String = curAgrupar.valueBuffer("fechahasta");
		var where:String = "servido <> 'Sí'";
		if (codProveedor && !codProveedor.isEmpty())
				where += " AND codproveedor = '" + codProveedor + "'";
		if (cifNif && !cifNif.isEmpty())
				where += " AND cifnif = '" + cifNif + "'";
		if (codAlmacen && !codAlmacen.isEmpty())
				where = where + " AND codalmacen = '" + codAlmacen + "'";
		where = where + " AND fecha >= '" + fechaDesde + "'";
		where = where + " AND fecha <= '" + fechaHasta + "'";
		if (codPago && !codPago.isEmpty() != "")
				where = where + " AND codpago = '" + codPago + "'";
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
	var util:FLUtil;

	var idLineaFactura:Number = this.iface.__copiaLineaAlbaran(curLineaAlbaran, idFactura);

	if(!idLineaFactura)
		return false

	var idLineaAlbaran:Number = curLineaAlbaran.valueBuffer("idlinea");

	if(!idLineaAlbaran)
		return false;

	if(!util.sqlUpdate("movilote","idlineafp",idLineaFactura,"idlineaap = " + idLineaAlbaran))
		return false;
	
	return this.iface.curLineaFactura.valueBuffer("idlinea");
}
//// LOTES /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition funNumSerie */
/////////////////////////////////////////////////////////////////
//// FUN_NUMEROS_SERIE //////////////////////////////////////////

/** \D Copia los datos de una línea de remito en una línea de factura
@param	curLineaAlbaran: Cursor que contiene los datos a incluir en la línea de factura
@return	True si el cálculo se realiza correctamente, false en caso contrario
\end */
function funNumSerie_datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean
{

	with (this.iface.curLineaFactura) {
 		setValueBuffer("numserie", curLineaAlbaran.valueBuffer("numserie"));
	}
	
	if(!this.iface.__datosLineaFactura(curLineaAlbaran))
		return false;

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

/** @class_definition impresiones */
/////////////////////////////////////////////////////////////////
//// IMPRESIONES ////////////////////////////////////////////////

function impresiones_init()
{
	this.iface.__init();

	this.iface.tbnImprimir = this.child("toolButtonPrint");

	connect(this.iface.tbnImprimir, "clicked()", this, "iface.imprimir");
}

function impresiones_imprimir(codAlbaran:String)
{
	if (sys.isLoadedModule("flfactinfo")) {
		var util:FLUtil = new FLUtil;
		var codigo:String;
		var idAlbaran:Number;
		if (codAlbaran) {
			codigo = codAlbaran;
			idAlbaran = util.sqlSelect("albaranesprov", "idalbaran", "codigo = '" + codAlbaran + "'");
		}
		else {
			if (!this.cursor().isValid())
				return;
			codigo = this.cursor().valueBuffer("codigo");
			idAlbaran = this.cursor().valueBuffer("idalbaran");
		}

		var dialog:Dialog = new Dialog(util.translate ( "scripts", "Imprimir Remito" ), 0, "imprimir");

		dialog.OKButtonText = util.translate ( "scripts", "Aceptar" );
		dialog.cancelButtonText = util.translate ( "scripts", "Cancelar" );

		var text:Object = new Label;
		text.text = util.translate("scripts","Remito: ") + codigo;
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

		var impNumSerie:RadioButton = new RadioButton;
		impNumSerie.text = util.translate ( "scripts", "Imprimir números de serie" );
		impNumSerie.checked = false;
		bgroup.add( impNumSerie );

		if ( !dialog.exec() )
			return true;

		var nombreInforme:String;

		if ( impNormal.checked == true ) {
			nombreInforme = "i_albaranesprov";
		}
		else if ( impComponentes.checked == true ) {
			nombreInforme = "i_albaranesprovcomp";
			flfactinfo.iface.pub_crearTabla("AP", idAlbaran);
		}
		else if ( impNumSerie.checked == true ) {
			nombreInforme = "i_albaranesprov_ns";
		}

		var curImprimir:FLSqlCursor = new FLSqlCursor("i_albaranesprov");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_albaranesprov_codigo", codigo);
		curImprimir.setValueBuffer("h_albaranesprov_codigo", codigo);

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

	var orden:Array = [ "codigo", "tipoventa", "ptefactura", "numproveedor", "nombre", "neto", "totaliva", "totalpie", "total", "coddivisa", "tasaconv", "totaleuros", "fecha", "hora", "codserie", "numero", "codejercicio", "codalmacen", "codpago", "codproveedor", "cifnif", "idusuario", "observaciones" ];

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
	var regimenIva:Boolean = util.sqlSelect("proveedores", "regimeniva", "codproveedor = '" + curAlbaran.valueBuffer("codproveedor") + "'");
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
			var totalLineas:Number = parseFloat(util.sqlSelect("piealbaranesprov", "SUM(totalinc)", "idalbaran = " + cursor.valueBuffer("idalbaran") + " AND incluidoneto = false"));
			if (!totalLineas || isNaN(totalLineas))
				totalLineas = 0;
			valor = totalLineas;
			break;
		}
		case "total": {
			var totalPie:Number = parseFloat(cursor.valueBuffer("totalpie"));
			valor = this.iface.__commonCalculateField(fN, cursor);
			valor += totalPie;
			valor = parseFloat(util.roundFieldValue(valor, "albaranesprov", "total"));
			break;
		}
		case "neto": {
			var netoPie:Number = parseFloat(util.sqlSelect("piealbaranesprov", "SUM(totalinc)", "idalbaran = " + cursor.valueBuffer("idalbaran") + " AND incluidoneto = true"));
			valor = this.iface.__commonCalculateField(fN, cursor);
			valor += netoPie;
			valor = parseFloat(util.roundFieldValue(valor, "albaranesprov", "neto"));
			break;
		}
		case "totaliva": {
			if (formfacturasprov.iface.pub_sinIVA(cursor))
				valor = 0;
			else {
				var ivaPie:Number = parseFloat(util.sqlSelect("piealbaranesprov", "SUM(totaliva)", "idalbaran = " + cursor.valueBuffer("idalbaran") + " AND incluidoneto = true"));
				valor = this.iface.__commonCalculateField(fN, cursor);
				valor += ivaPie;
			}
			valor = parseFloat(util.roundFieldValue(valor, "albaranesprov", "totaliva"));
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
	var curPieAlbaran:FLSqlCursor = new FLSqlCursor("piealbaranesprov");
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
		this.iface.curPieFactura = new FLSqlCursor("piefacturasprov");
	
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