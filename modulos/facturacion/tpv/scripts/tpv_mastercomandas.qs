/***************************************************************************
                 tpv_mastercomandas.qs  -  description
                             -------------------
    begin                : mar nov 15 2005
    copyright            : Por ahora (C) 2005 by InfoSiAL S.L.
    email                : lveb@telefonica.net
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
	var tbnBlocDesbloc:Object;
	var tdbRecords:FLTableDB;

	function oficial( context ) { interna( context ); } 
	function abrirComanda_clicked() {
		return this.ctx.oficial_abrirComanda_clicked();
	}
	function abrirComanda(idComanda:String):Boolean {
		return this.ctx.oficial_abrirComanda(idComanda);
	}
	function eliminarFactura(idFactura:Number):Boolean {
		return this.ctx.oficial_eliminarFactura(idFactura);
	}
	function imprimir_clicked(){
		return this.ctx.oficial_imprimir_clicked();
	}
	function imprimirTiqueComanda(codComanda:String):Boolean{
		return this.ctx.oficial_imprimirTiqueComanda(codComanda);
	}
	function imprimirDocumento_clicked():Boolean{
		return this.ctx.oficial_imprimirDocumento_clicked();
	}
	function abrirCajon_clicked() {
		return this.ctx.oficial_abrirCajon_clicked();
	}
	function imprimirQuick_clicked(){
		return this.ctx.oficial_imprimirQuick_clicked();
	}
	function abrirCajon( impresora:String, escAbrir:String ) {
		return this.ctx.oficial_abrirCajon( impresora, escAbrir);
	}
	function imprimirQuick( codComanda:String, impresora:String ) {
		return this.ctx.oficial_imprimirQuick( codComanda, impresora );
	}
	function filtrarVentas() {
		return this.ctx.oficial_filtrarVentas();
	}
	function filtroVentas():String {
		return this.ctx.oficial_filtroVentas();
	}
	function imprimirTiquePOS(codComanda:String, impresora:String, qry:FLSqlQuery) {
		return this.ctx.oficial_imprimirTiquePOS(codComanda, impresora, qry);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration ivaIncluido */
/////////////////////////////////////////////////////////////////
//// IVA INCLUIDO ///////////////////////////////////////////////
class ivaIncluido extends oficial {
    function ivaIncluido( context ) { oficial ( context ); }
	function imprimirTiquePOS(codComanda:String, impresora:String, qry:FLSqlQuery) {
		return this.ctx.ivaIncluido_imprimirTiquePOS(codComanda, impresora, qry);
	}
}
//// IVA INCLUIDO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration fechas */
/////////////////////////////////////////////////////////////////
//// FECHAS /////////////////////////////////////////////////
class fechas extends ivaIncluido {
	var fechaDesde:Object;
	var fechaHasta:Object;
	var ckbSoloPV:Object;

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

/** @class_declaration tipoVenta */
/////////////////////////////////////////////////////////////////
//// TIPO DE VENTA //////////////////////////////////////////////
class tipoVenta extends fechas {
	var pbnAFactura:Object;
	var curFactura:FLSqlCursor;
	var curLineaFactura:FLSqlCursor;

    function tipoVenta( context ) { fechas ( context ); }
	function init() {
		this.ctx.tipoVenta_init();
	}
	function asociarAFactura() {
		this.ctx.tipoVenta_asociarAFactura();
	}
	function whereAgrupacion(curAgrupar:FLSqlCursor):String {
		return this.ctx.tipoVenta_whereAgrupacion(curAgrupar);
	}
	function dameDatosAgrupacionAlbaranes(curAgruparAlbaranes:FLSqlCursor):Array {
		return this.ctx.tipoVenta_dameDatosAgrupacionAlbaranes(curAgruparAlbaranes);
	}

	function generarFactura(where:String, curAlbaran:FLSqlCursor, datosAgrupacion):Number {
		return this.ctx.tipoVenta_generarFactura(where, curAlbaran, datosAgrupacion);
	}
	function datosFactura(curAlbaran:FLSqlCursor, where:String, datosAgrupacion:Array):Boolean {
		return this.ctx.tipoVenta_datosFactura(curAlbaran, where, datosAgrupacion);
	}
	function copiaLineasAlbaran(idAlbaran:Number, idFactura:Number):Boolean {
		return this.ctx.tipoVenta_copiaLineasAlbaran(idAlbaran, idFactura);
	}
	function copiaLineaAlbaran(curLineaAlbaran:FLSqlCursor, idFactura:Number):Number {
		return this.ctx.tipoVenta_copiaLineaAlbaran(curLineaAlbaran, idFactura);
	}
	function datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean {
		return this.ctx.tipoVenta_datosLineaFactura(curLineaAlbaran);
	}
	function totalesFactura(curFactura:FLSqlCursor):Boolean {
		return this.ctx.tipoVenta_totalesFactura(curFactura);
	}
	function aplicarPago(curFactura:FLSqlCursor):Boolean {
		return this.ctx.tipoVenta_aplicarPago(curFactura);
	}
}
//// TIPO DE VENTA  /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ordenCampos */
/////////////////////////////////////////////////////////////////
//// ORDEN_CAMPOS ///////////////////////////////////////////////
class ordenCampos extends tipoVenta {
    function ordenCampos( context ) { tipoVenta ( context ); }
	function init() {
		this.ctx.ordenCampos_init();
	}
}
//// ORDEN_CAMPOS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends ordenCampos {
    function head( context ) { ordenCampos ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
	function ifaceCtx( context ) { head( context ); }
	function pub_imprimirTiqueComanda(codComanda:Stirng):Boolean{
		return this.imprimirTiqueComanda(codComanda);
	}
	function pub_abrirCajon( impresora:String, escAbrir:String ) {
		return this.abrirCajon( impresora, escAbrir );
	}
	function pub_imprimirQuick( codComanda:String, impresora:String ) {
		return this.imprimirQuick( codComanda, impresora );
	}
}
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubTipoVenta */
/////////////////////////////////////////////////////////////////
//// PUB_TIPOVENTA  /////////////////////////////////////////////
class pubTipoVenta extends ifaceCtx {
	function pubTipoVenta( context ) { ifaceCtx( context ); }
	function pub_whereAgrupacion(curAgrupar:FLSqlCursor):String {
		return this.whereAgrupacion(curAgrupar);
	}
}
//// PUB_TIPOVENTA //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

const iface = new pubTipoVenta( this );

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
function interna_init()
{
	this.iface.tbnBlocDesbloc = this.child("tbnBlocDesbloc");
	this.iface.tdbRecords = this.child("tableDBRecords");

	connect(this.iface.tbnBlocDesbloc, "clicked()", this, "iface.abrirComanda_clicked()");
	connect(this.child("toolButtonPrint"),"clicked()", this, "iface.imprimir_clicked()");
	connect( this.child( "tbnPrintQuick" ), "clicked()", this, "iface.imprimirQuick_clicked()" );
	connect( this.child( "tbnOpenCash" ), "clicked()",  this, "iface.abrirCajon_clicked()" );
	connect( this.child( "tbnImprimirDocumento" ), "clicked()",  this, "iface.imprimirDocumento_clicked()" );
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D
Abre una comanda
No se podrá abir una comanda si su arqueo está cerrado
@return Boolean, devuelve true si todo se ha ejecutado correctamente y false si hay algún error
*/
function oficial_abrirComanda_clicked():Boolean
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	var idFactura:Number = cursor.valueBuffer("iddocumento");
	var idComanda:Number = cursor.valueBuffer("idtpv_comanda");
	if (!idComanda)
		return false;
	
	if (cursor.valueBuffer("editable") == true) {
		MessageBox.warning(util.translate("scripts", "La venta ya está abierta"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return true;
	}
	
	/*
	if (!util.sqlSelect("tpv_arqueos", "abierta", "idtpv_arqueo = '" + cursor.valueBuffer("idtpv_arqueo") + "'")) {
		MessageBox.warning(util.translate("scripts", "No pueden abrirse ventas asociadas a un arqueo cerrado"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return true;
	}
	*/
	
	var res:Number = MessageBox.warning(util.translate("scripts", "Va a abrir la venta seleccionada"), MessageBox.Ok, MessageBox.Cancel);
	if (res != MessageBox.Ok)
		return true;
	
	cursor.transaction(false);
	try {
		if (this.iface.abrirComanda(idComanda))
			cursor.commit();
		else {
			cursor.rollback();
			return false;
		}
	}
	catch (e) {
		cursor.rollback();
		MessageBox.critical(util.translate("scripts", "Hubo un error en la apertura de la venta:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
	}
	
	this.iface.tdbRecords.refresh();
	
	return true;
}

/** \D Abre la comanda
@param	idComanda: identificador de la comanda
@return	true si la comanda se abre correctamente, false en caso contrario
\end */
function oficial_abrirComanda(idComanda:String):Boolean
{
	var util:FLUtil = new FLUtil();
	var curComanda:FLSqlCursor = new FLSqlCursor("tpv_comandas");
	curComanda.select("idtpv_comanda = " + idComanda);
	if (!curComanda.first())
		return false;
	curComanda.setUnLock("editable", true)
	
	curComanda.select("idtpv_comanda = " + idComanda);
	if (!curComanda.first())
		return false;
		
	curComanda.setModeAccess(curComanda.Edit);
	curComanda.refreshBuffer();
	curComanda.setValueBuffer("estado","Abierta");
	if (!curComanda.commitBuffer())
		return false;
		
	return true;
}
/** \D
Elimina los el pago, recibo y factura que corresponden a la comanda
@param idFactura identificador de la factura a borrar
@return Boolean, devuelve true si todo se ha ejecutado correctamente y fasle si hay algún error
*/
function oficial_eliminarFactura(idFactura:Number):Boolean 
{
	var util:FLUtil = new FLUtil();
	var curFactura:FLSqlCursor = new FLSqlCursor("facturascli");
	curFactura.select("idfactura = " + idFactura);
	if(!curFactura.first())
		return false;
	var codRecibo = curFactura.valueBuffer("codigo") + "-01";
	if(util.sqlSelect("reciboscli","estado","codigo = '" + codRecibo + "'") == "Pagado"){
		var idrecibo:Number = util.sqlSelect("reciboscli","idrecibo","codigo = '" + codRecibo + "'");
		var curPagos:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
		curPagos.select("idrecibo = " + idrecibo);
		if(!curPagos.first())
			return false; 
		curPagos.setModeAccess(curPagos.Del);
		curPagos.refreshBuffer();
		if(!curPagos.commitBuffer())
			return false;
		var curRecibos:FLSqlCursor = new FLSqlCursor("reciboscli");
		curRecibos.select("idrecibo = " + idrecibo);
		if(!curRecibos.first())
			return false; 
		curRecibos.setModeAccess(curRecibos.Edit);
		curRecibos.refreshBuffer();
		curRecibos.setValueBuffer("estado","Emitido");
		if(!curRecibos.commitBuffer())
			return false;
		curFactura.setUnLock("editable",true);
	}	
	curFactura.setModeAccess(curFactura.Del);
	curFactura.refreshBuffer();
	if(!curFactura.commitBuffer())
		return false;
	return true;
}

/** \D
Abre una transacción y llama a la función ImprimirTiqueComanda
*/
function oficial_imprimir_clicked()
{
	var cursor:FLSqlCursor = this.cursor();
	var codComanda:String = cursor.valueBuffer("codigo");
	if (!codComanda)
		return false;
	
	if (!this.iface.imprimirTiqueComanda(codComanda)){
		return false;
	}

	this.iface.tdbRecords.cursor().refresh();
}

/** \D
Si el módulo de informes no está cargado muestra un mensaje de aviso y si lo está lanza el informe correspondiente
@param codComanda codigo de la comanda a imprimir
@return true si se imprime correctamente y false si ha algún error
*/
function oficial_imprimirTiqueComanda(codComanda:String):Boolean
{
	if (sys.isLoadedModule("flfactinfo")) {
		if (!this.cursor().isValid())
			return;
		var curImprimir:FLSqlCursor = new FLSqlCursor("tpv_i_comandas");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_tpv__comandas_codigo", codComanda);
		curImprimir.setValueBuffer("h_tpv__comandas_codigo", codComanda);
		flfactinfo.iface.pub_lanzarInforme(curImprimir, "tpv_i_comandas");
	} else
		flfactppal.iface.pub_msgNoDisponible("Informes");
	
}

/** \D
Manda a imprimir directamente a la impresora la comanda actualmente seleccionada
*/
function oficial_imprimirQuick_clicked()
{
	if (!this.cursor().isValid())
		return;
	
	var util:FLUtil = new FLUtil();
	var pv:String = util.readSettingEntry( "scripts/fltpv_ppal/codTerminal" );

	if ( !pv )
		pv = util.sqlSelect( "tpv_puntosventa", "codtpv_puntoventa", "1=1") ;
	
	var impresora:String = util.sqlSelect( "tpv_puntosventa", "impresora","codtpv_puntoventa = '" + pv + "'") ;	
	
	this.iface.imprimirQuick( this.cursor().valueBuffer( "codigo" ) , impresora );

}

function oficial_imprimirQuick( codComanda:String, impresora:String )
{
	var util:FLUtil = new FLUtil();		
	var q:FLSqlQuery = new FLSqlQuery( "tpv_i_comandas" );
	var codPuntoVenta:String = util.readSettingEntry("scripts/fltpv_ppal/codTerminal");
	
	q.setWhere( "codigo = '" + codComanda + "'" );
	if (q.exec() == false) {
		MessageBox.critical(util.translate("scripts", "Falló la consulta"), MessageBox.Ok, MessageBox.NoButton);
		return;
	} else {
		if (q.first() == false) {
			MessageBox.warning(util.translate("scripts", "No hay registros que cumplan los criterios de búsqueda establecidos"), MessageBox.Ok, MessageBox.NoButton);
			return;
		}
	}

	var tipoImpresora:String = util.sqlSelect("tpv_puntosventa", "tipoimpresora", "codtpv_puntoventa = '" + codPuntoVenta + "'");
	if (tipoImpresora == "ESC-POS") {
		this.iface.imprimirTiquePOS(codComanda, impresora, q);
	} else {
		var pixel:Number = util.sqlSelect("tpv_puntosventa", "pixel", "codtpv_puntoventa = '" + codPuntoVenta + "'");
		if (!pixel || isNaN(pixel)) {
			pixel = 780;
		}
		var resolucion:Number = util.sqlSelect("tpv_puntosventa", "resolucion", "codtpv_puntoventa = '" + codPuntoVenta + "'");
		if (!resolucion || isNaN(resolucion)) {
			resolucion = 300;
		}
		var rptViewer:FLReportViewer = new FLReportViewer();
		rptViewer.setPixel(pixel);
		rptViewer.setResolution(resolucion);
		rptViewer.setReportTemplate( "tpv_i_comandas" );
		rptViewer.setReportData( q );
		rptViewer.renderReport();
		rptViewer.setPrinterName( impresora );
		rptViewer.printReport();
	}
}

function oficial_imprimirTiquePOS(codComanda:String, impresora:String, qryTicket:FLSqlQuery)
{
	var util:FLUtil = new FLUtil;
	flfact_tpv.iface.establecerImpresora(impresora);

	var primerRegistro:Boolean = true;
	var total:String;
	var neto:String;
	var totalIva:String;
	var agente:String;
	var totalLinea:Number;
	var pvpUnitarioIva:Number;
	var descripcion:String;
	var codColor:String;
	var formaPago:String;

	if (!qryTicket.exec()) {
		return false;
	}
	while (qryTicket.next()) {
		if (primerRegistro) {
			flfact_tpv.iface.impResaltar(true);
			flfact_tpv.iface.impSubrayar(true);
			flfact_tpv.iface.imprimirDatos(qryTicket.value("empresa.nombre"));
			flfact_tpv.iface.impResaltar(false);
			flfact_tpv.iface.impSubrayar(false);
			flfact_tpv.iface.impNuevaLinea();
			flfact_tpv.iface.imprimirDatos(qryTicket.value("empresa.direccion"));
			flfact_tpv.iface.impNuevaLinea();
			flfact_tpv.iface.imprimirDatos(qryTicket.value("empresa.ciudad"));
			flfact_tpv.iface.impNuevaLinea();
			flfact_tpv.iface.imprimirDatos("Telef.  ");
			flfact_tpv.iface.imprimirDatos(qryTicket.value("empresa.telefono"));
			flfact_tpv.iface.impNuevaLinea();
			flfact_tpv.iface.imprimirDatos("CUIT  ");
			flfact_tpv.iface.imprimirDatos(qryTicket.value("empresa.cifnif"));
			flfact_tpv.iface.impNuevaLinea(2);
			flfact_tpv.iface.imprimirDatos("Nº Tiquet: " + qryTicket.value("tpv_comandas.codigo"));
			flfact_tpv.iface.impNuevaLinea();
			flfact_tpv.iface.imprimirDatos("Fecha: " + util.dateAMDtoDMA(qryTicket.value("tpv_comandas.fecha")));

			var hora:String = qryTicket.value("tpv_comandas.hora").toString();
			hora = hora.right(8);
			hora = hora.left(5);
			flfact_tpv.iface.imprimirDatos("   Hora: " + hora);
			flfact_tpv.iface.impNuevaLinea(2);
			flfact_tpv.iface.imprimirDatos("ARTICULO", 20);
			flfact_tpv.iface.imprimirDatos("CANTIDAD", 10, 2);
			flfact_tpv.iface.imprimirDatos("IMPORTE", 10, 2);
			flfact_tpv.iface.impNuevaLinea();

			totaliva = util.roundFieldValue(qryTicket.value("tpv_comandas.totaliva"), "tpv_comandas", "totaliva");
			neto = util.roundFieldValue(qryTicket.value("tpv_comandas.neto"), "tpv_comandas", "neto");
			total = util.roundFieldValue(qryTicket.value("tpv_comandas.total"), "tpv_comandas", "total");
			agente = qryTicket.value("tpv_agentes.descripcion");
		}
		
		primerRegistro = false;
		
		cantidad = qryTicket.value("tpv_lineascomanda.cantidad");
		pvpUnitarioIva = qryTicket.value("tpv_lineascomanda.pvptotal");
		totalLinea = util.roundFieldValue(pvpUnitarioIva * cantidad, "tpv_comandas", "total");
		
		descripcion = qryTicket.value("tpv_lineascomanda.descripcion");
		
		flfact_tpv.iface.imprimirDatos(descripcion, 20);
		flfact_tpv.iface.imprimirDatos(cantidad, 10, 2);
		flfact_tpv.iface.imprimirDatos(totalLinea, 10, 2);
		flfact_tpv.iface.impNuevaLinea();
	}
	
	flfact_tpv.iface.impNuevaLinea();
	flfact_tpv.iface.imprimirDatos("Total Neto.", 30);
	flfact_tpv.iface.imprimirDatos(neto, 10,2);
	flfact_tpv.iface.impNuevaLinea();
	flfact_tpv.iface.imprimirDatos("Total I.V.A.", 30);
	flfact_tpv.iface.imprimirDatos(totaliva, 10,2);
	flfact_tpv.iface.impNuevaLinea();
	flfact_tpv.iface.imprimirDatos("Total Ticket.", 30);
	flfact_tpv.iface.imprimirDatos(total, 10,2);

	flfact_tpv.iface.impAlinearH(1);
	
	flfact_tpv.iface.impNuevaLinea();
	flfact_tpv.iface.imprimirDatos("GRACIAS POR SU VISITA");
	flfact_tpv.iface.impAlinearH(0);
	flfact_tpv.iface.impNuevaLinea(2);
	flfact_tpv.iface.impSubrayar(true);
	flfact_tpv.iface.imprimirDatos("Lo atendió:");
	flfact_tpv.iface.impSubrayar(false);
	flfact_tpv.iface.imprimirDatos("   " + agente);
	flfact_tpv.iface.impNuevaLinea();
	
	flfact_tpv.iface.impNuevaLinea(9);
	flfact_tpv.iface.impCortar();
	flfact_tpv.iface.flushImpresora();

	var printer:FLPosPrinter = new FLPosPrinter();
	printer.setPrinterName( impresora );
	printer.send( "ESC:1B,64,05,1B,69" );
	printer.flush();
}

/** \D
Abre el cajón del punto de venta actual
*/
function oficial_abrirCajon_clicked()
{
	var util:FLUtil = new FLUtil();
	var pv:String = util.readSettingEntry( "scripts/fltpv_ppal/codTerminal" );
	
	if ( !pv )
			pv = util.sqlSelect( "tpv_puntosventa", "codtpv_puntoventa", "1=1") ;
	
	var impresora:String = util.sqlSelect( "tpv_puntosventa", "impresora", "codtpv_puntoventa = '" + pv + "'") ;
	var escAbrir:String = util.sqlSelect( "tpv_puntosventa", "abrircajon", "codtpv_puntoventa = '" + pv + "'") ;
	
	this.iface.abrirCajon( impresora, escAbrir);
}

/** \D
Abre el cajón portamonedas conectado a una impresora
@impresora Nombre de la impresora LPR donde está conectado el cajón
*/
function oficial_abrirCajon( impresora:String, escAbrir:String )
{
	var printer:FLPosPrinter = new FLPosPrinter();
	printer.setPrinterName( impresora );
	
	if (!escAbrir) {
		escAbrir = "27,7,20,20,7";
	}
	printer.send( "ESC:" + escAbrir);
	printer.flush();
}

/** \D
Imprime el documento correspondiente a la venta seleccionada
*/
function oficial_imprimirDocumento_clicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	
	var codComanda:String = cursor.valueBuffer("codigo");
	if (!codComanda) {
		return;
	}

	var idDocumento:String = cursor.valueBuffer("iddocumento");
	switch (cursor.valueBuffer("tipoventa")) {
		case "Presupuesto": {
			var codPresupuesto:String = util.sqlSelect("presupuestoscli", "codigo", "idpresupuesto = " + idDocumento);
			if (codPresupuesto) {
				formpresupuestoscli.iface.pub_imprimir(codPresupuesto);
			}
			break;
		}
		case "Pedido": {
			var codPedido:String = util.sqlSelect("pedidoscli", "codigo", "idpedido = " + idDocumento);
			if (codPedido) {
				formpedidoscli.iface.pub_imprimir(codPedido);
			}
			break;
		}
		case "Remito": {
			var codRemito:String = util.sqlSelect("albaranescli", "codigo", "idalbaran = " + idDocumento);
			if (codRemito) {
				formalbaranescli.iface.pub_imprimir(codRemito);
			}
			break;
		}
		default: {
			if (!idDocumento) {
				var res:Number = MessageBox.warning(util.translate("scripts", "La venta seleccionada todavía no tiene una factura asociada. ¿Desea crearla ahora?"), MessageBox.Yes, MessageBox.No);
				if (res != MessageBox.Yes) {
					return;
				}
				
				var curComanda:FLSqlCursor = new FLSqlCursor("tpv_comandas");
				curComanda.transaction(false);
				try {
					idDocumento = flfact_tpv.iface.pub_crearFactura(cursor);
					if (!idDocumento) {
						throw util.translate("scripts", "La función crearFactura ha fallado");
					}
		
					/// Evita que se llame a sincronizarConFacturación otra vez
					curComanda.setActivatedCommitActions(false);
		
					curComanda.select("codigo = '" + codComanda + "'");
					if (!curComanda.first()) {
						throw util.translate("scripts", "Error al buscar la venta seleccionada");
					}
					curComanda.setModeAccess(curComanda.Edit);
					curComanda.refreshBuffer();
					curComanda.setValueBuffer("iddocumento", idDocumento);
					if (!curComanda.commitBuffer()) {
						throw util.translate("scripts", "Error al actualizar la venta con el Id de la factura generada");
					}
					curComanda.commit();
				}
				catch (e) {
					curComanda.rollback();
					MessageBox.critical(util.translate("scripts", "Hubo un error al generar la factura:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
				}
			}
			var codFactura:String = util.sqlSelect("facturascli", "codigo", "idfactura = " + idDocumento);
			if (codFactura) {
				formfacturascli.iface.pub_imprimir(codFactura);
			}
			break;
		}
	}
}

/** \D Activa o desactiva el filtro que muestra únicamente las últimas ventas o las del puesto por defecto. El filtro mejora el rendimiento
\end */
function oficial_filtrarVentas()
{
	var cursor:FLSqlCursor = this.cursor();
	var filtro:String = this.iface.filtroVentas();
	if (!filtro && filtro != "")
		return;

	cursor.setMainFilter(filtro);
	this.iface.tdbRecords.refresh();
}

function oficial_filtroVentas():String
{
	var filtro:String = "";
	var util:FLUtil = new FLUtil;
	if (this.iface.ckbSoloHoy.checked) {
		var hoy:Date = new Date;
		filtro = "fecha = '" + hoy.toString().left(10) + "'";
	}

	if (this.iface.ckbSoloPV.checked) {
		var codTerminal:String = util.readSettingEntry("scripts/fltpv_ppal/codTerminal");
		if (codTerminal) {
			if (filtro != "")
				filtro += " AND ";
			filtro += "codtpv_puntoventa = '" + codTerminal + "'";
		}
	}

	return filtro;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ivaIncluido */
/////////////////////////////////////////////////////////////////
//// IVA INCLUIDO ///////////////////////////////////////////////
function ivaIncluido_imprimirTiquePOS(codComanda:String, impresora:String, qryTicket:FLSqlQuery)
{
	var util:FLUtil = new FLUtil;
	flfact_tpv.iface.establecerImpresora(impresora);

	var primerRegistro:Boolean = true;
	var total:String;
	var agente:String;
	var totalLinea:Number;
	var pvpUnitarioIva:Number;
	var descripcion:String;
	var codColor:String;
	var formaPago:String;

	if (!qryTicket.exec()) {
		return false;
	}
	while (qryTicket.next()) {
		if (primerRegistro) {
			flfact_tpv.iface.impResaltar(true);
			flfact_tpv.iface.impSubrayar(true);
			flfact_tpv.iface.imprimirDatos(qryTicket.value("empresa.nombre"));
			flfact_tpv.iface.impResaltar(false);
			flfact_tpv.iface.impSubrayar(false);
			flfact_tpv.iface.impNuevaLinea();
			flfact_tpv.iface.imprimirDatos(qryTicket.value("empresa.direccion"));
			flfact_tpv.iface.impNuevaLinea();
			flfact_tpv.iface.imprimirDatos(qryTicket.value("empresa.ciudad"));
			flfact_tpv.iface.impNuevaLinea();
			flfact_tpv.iface.imprimirDatos("Telef.  ");
			flfact_tpv.iface.imprimirDatos(qryTicket.value("empresa.telefono"));
			flfact_tpv.iface.impNuevaLinea();
			flfact_tpv.iface.imprimirDatos("CUIT  ");
			flfact_tpv.iface.imprimirDatos(qryTicket.value("empresa.cifnif"));
			flfact_tpv.iface.impNuevaLinea(2);
			flfact_tpv.iface.imprimirDatos("Nº Tiquet: " + qryTicket.value("tpv_comandas.codigo"));
			flfact_tpv.iface.impNuevaLinea();
			flfact_tpv.iface.imprimirDatos("Fecha: " + util.dateAMDtoDMA(qryTicket.value("tpv_comandas.fecha")));
			var hora:String = qryTicket.value("tpv_comandas.hora").toString();
			hora = hora.right(8);
			hora = hora.left(5);
			flfact_tpv.iface.imprimirDatos("   Hora: " + hora);
			flfact_tpv.iface.impNuevaLinea(2);
			flfact_tpv.iface.imprimirDatos("DESCRIPCION", 20);
			flfact_tpv.iface.imprimirDatos("CANTIDAD", 10, 2);
			flfact_tpv.iface.imprimirDatos("IMPORTE", 10, 2);
			flfact_tpv.iface.impNuevaLinea();

			total = util.roundFieldValue(qryTicket.value("tpv_comandas.total"), "tpv_comandas", "total");
			agente = qryTicket.value("tpv_agentes.descripcion");
		}
		
		primerRegistro = false;
		
		cantidad = qryTicket.value("tpv_lineascomanda.cantidad");
		pvpUnitarioIva = qryTicket.value("tpv_lineascomanda.pvpunitarioiva");
		totalLinea = util.roundFieldValue(pvpUnitarioIva * cantidad, "tpv_comandas", "total");
		
		descripcion = qryTicket.value("tpv_lineascomanda.descripcion");
		
		flfact_tpv.iface.imprimirDatos(descripcion, 20);
		flfact_tpv.iface.imprimirDatos(cantidad, 10, 2);
		flfact_tpv.iface.imprimirDatos(totalLinea, 10, 2);
		flfact_tpv.iface.impNuevaLinea();
	}
	
	flfact_tpv.iface.impNuevaLinea();
	flfact_tpv.iface.imprimirDatos("Total Ticket.", 30);
	flfact_tpv.iface.imprimirDatos(total, 10,2);

	flfact_tpv.iface.impAlinearH(1);
	
	flfact_tpv.iface.impNuevaLinea(2);
	flfact_tpv.iface.imprimirDatos("*** I.V.A. INCLUIDO ***");
	flfact_tpv.iface.impNuevaLinea();
	flfact_tpv.iface.imprimirDatos("GRACIAS POR SU VISITA");
	flfact_tpv.iface.impAlinearH(0);
	flfact_tpv.iface.impNuevaLinea(2);
	flfact_tpv.iface.impSubrayar(true);
	flfact_tpv.iface.imprimirDatos("Lo atendió:");
	flfact_tpv.iface.impSubrayar(false);
	flfact_tpv.iface.imprimirDatos("   " + agente);
	flfact_tpv.iface.impNuevaLinea();
	flfact_tpv.iface.impNuevaLinea(9);
	flfact_tpv.iface.impCortar();
	flfact_tpv.iface.flushImpresora();

	var printer:FLPosPrinter = new FLPosPrinter();
	printer.setPrinterName( impresora );
	printer.send( "ESC:1B,64,05,1B,69" );
	printer.flush();
}
//// IVA INCLUIDO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition fechas */
/////////////////////////////////////////////////////////////////
//// FECHAS /////////////////////////////////////////////////////

function fechas_init()
{
	this.iface.__init();

	this.iface.fechaDesde = this.child("dateFrom");
	this.iface.fechaHasta = this.child("dateTo");
	this.iface.ckbSoloPV = this.child("ckbSoloPV");

	this.iface.fechaDesde.date = new Date();
	this.iface.fechaHasta.date = new Date();

	connect(this.iface.fechaDesde, "valueChanged(const QDate&)", this, "iface.actualizarFiltro");
	connect(this.iface.fechaHasta, "valueChanged(const QDate&)", this, "iface.actualizarFiltro");
	connect( this.child( "ckbSoloPV" ), "clicked()",  this, "iface.actualizarFiltro()" );

	this.iface.actualizarFiltro();
}

function fechas_actualizarFiltro()
{
	var desde:String = this.iface.fechaDesde.date.toString().left(10);
	var hasta:String = this.iface.fechaHasta.date.toString().left(10);

	if (desde == "" || hasta == "")
		return;

	var util:FLUtil = new FLUtil;
	var filtro:String = "fecha >= '" + desde + "' AND fecha <= '" + hasta + "'";

	if (this.iface.ckbSoloPV.checked) {
		var codTerminal:String = util.readSettingEntry("scripts/fltpv_ppal/codTerminal");
		if (codTerminal) {
			filtro += " AND codtpv_puntoventa = '" + codTerminal + "'";
		}
	}

	this.cursor().setMainFilter(filtro);

	this.iface.tdbRecords.refresh();
	this.cursor().last();
	this.iface.tdbRecords.setCurrentRow(this.cursor().at());
}


//// FECHAS /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition tipoVenta */
//////////////////////////////////////////////////////////////////
//// TIPO VENTA //////////////////////////////////////////////////

function tipoVenta_init()
{
	this.iface.__init();

	this.iface.pbnAFactura = this.child("pbnAsociarAFactura");

	connect(this.iface.pbnAFactura, "clicked()", this, "iface.asociarAFactura()");
}

/** \C
Al pulsar el botón de asociar a factura se abre la ventana de agrupar remitos de cliente
\end */
function tipoVenta_asociarAFactura()
{
	var util:FLUtil = new FLUtil;
	var f:Object = new FLFormSearchDB("tpv_agruparalbaranescli");
	var cursor:FLSqlCursor = f.cursor();
	var where:String;
	var codCliente:String;
	var codTPV:String;

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
		var curAgruparAlbaranes:FLSqlCursor = new FLSqlCursor("tpv_agruparalbaranescli");
		curAgruparAlbaranes.select();
		if (curAgruparAlbaranes.first()) {
			where = this.iface.whereAgrupacion(curAgruparAlbaranes);
			var excepciones:String = curAgruparAlbaranes.valueBuffer("excepciones");
			if (!excepciones.isEmpty())
				where += " AND idtpv_comanda NOT IN (" + excepciones + ")";

			var qryAgruparAlbaranes:FLSqlCursor = new FLSqlQuery;
			qryAgruparAlbaranes.setTablesList("tpv_comandas");
			qryAgruparAlbaranes.setSelect("codcliente,codtpv_puntoventa");
			qryAgruparAlbaranes.setFrom("tpv_comandas");
			qryAgruparAlbaranes.setWhere(where + " GROUP BY codcliente,codtpv_puntoventa");

			if (!qryAgruparAlbaranes.exec())
				return;

			var totalClientes:Number = qryAgruparAlbaranes.size();
			util.createProgressDialog(util.translate("scripts", "Generando facturas"), totalClientes);
			util.setProgress(1);
			var j:Number = 0;
			
			var curAlbaran:FLSqlCursor = new FLSqlCursor("tpv_comandas");
			var whereFactura:String;
			var datosAgrupacion:Array = [];
			while (qryAgruparAlbaranes.next()) {
				codCliente = qryAgruparAlbaranes.value(0);
				codTPV = qryAgruparAlbaranes.value(1);
				whereFactura = where;
				if (codCliente && codCliente != "")
					 whereFactura += " AND codcliente = '" + codCliente + "'";
				if(codTPV && codTPV != "")
					whereFactura += " AND codtpv_puntoventa = '" + codTPV + "'";
				curAlbaran.transaction(false);
				try {
					curAlbaran.select(whereFactura);
					if (!curAlbaran.first()) {
						curAlbaran.rollback();
						util.destroyProgressDialog();
						return;
					}
					
					datosAgrupacion = this.iface.dameDatosAgrupacionAlbaranes(curAgruparAlbaranes);
					if (this.iface.generarFactura(whereFactura, curAlbaran, datosAgrupacion)) {
						curAlbaran.commit();
					} else {
						MessageBox.warning(util.translate("scripts", "Falló la inserción de la factura correspondiente al cliente: ") + codCliente, MessageBox.Ok, MessageBox.NoButton);
						curAlbaran.rollback();
						util.destroyProgressDialog();
						return;
					}
				} catch (e) {
					curAlbaran.rollback();
					MessageBox.critical(util.translate("scripts", "Error al generar la factura:") + e, MessageBox.Ok, MessageBox.NoButton);
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
Construye un array con los datos de la factura a generar especificados en el formulario de agrupación de remitos
@param curAgruparAlbaranes: Cursor de la tabla agruparalbaranescli que contiene los valores
@return Array
\end */
function tipoVenta_dameDatosAgrupacionAlbaranes(curAgruparAlbaranes:FLSqlCursor):Array
{
	var res:Array = [];
	res["fecha"] = curAgruparAlbaranes.valueBuffer("fecha");
	res["hora"] = curAgruparAlbaranes.valueBuffer("hora");
	return res;
}

/** \D
Construye la sentencia WHERE de la consulta que buscará los remitos a agrupar
@param curAgrupar: Cursor de la tabla agruparalbaranescli que contiene los valores de los criterios de búsqueda
@return Sentencia where
\end */
function tipoVenta_whereAgrupacion(curAgrupar:FLSqlCursor):String
{
	var codCliente:String = curAgrupar.valueBuffer("codcliente");
	var nombreCliente:String = curAgrupar.valueBuffer("nombrecliente");
	var cifNif:String = curAgrupar.valueBuffer("cifnif");
	var fechaDesde:String = curAgrupar.valueBuffer("fechadesde");
	var fechaHasta:String = curAgrupar.valueBuffer("fechahasta");
	var where:String = "tpv_comandas.tipoventa = 'Remito' AND tpv_comandas.editable = true";
	if (codCliente && !codCliente.isEmpty())
		where += " AND tpv_comandas.codcliente = '" + codCliente + "'";
	if (cifNif && !cifNif.isEmpty())
		where += " AND tpv_comandas.cifnif = '" + cifNif + "'";
	where += " AND tpv_comandas.fecha >= '" + fechaDesde + "'";
	where += " AND tpv_comandas.fecha <= '" + fechaHasta + "'";

	return where;
}


/** \D
Genera la factura asociada a uno o más albaranes
@param where: Sentencia where para la consulta de búsqueda de los albaranes a agrupar
@param curAlbaran: Cursor con los datos principales que se copiarán del remito a la factura
@param datosAgrupacion: Array con los datos indicados en el formulario de agrupación de albaranes
@return True: Copia realizada con éxito, False: Error
\end */
function tipoVenta_generarFactura(where:String, curAlbaran:FLSqlCursor, datosAgrupacion:Array):Number
{
	if (!this.iface.curFactura)
		this.iface.curFactura = new FLSqlCursor("tpv_comandas");

	this.iface.curFactura.setModeAccess(this.iface.curFactura.Insert);
	this.iface.curFactura.refreshBuffer();

	if (!this.iface.datosFactura(curAlbaran, where, datosAgrupacion)) {
		return false;
	}

	if (!this.iface.curFactura.commitBuffer()) {
		return false;
	}

	var util:FLUtil = new FLUtil;
	var idFactura:Number = this.iface.curFactura.valueBuffer("idtpv_comanda");

	var curRemito:FLSqlCursor = new FLSqlCursor("albaranescli");
	var curAlbaranes:FLSqlCursor = new FLSqlCursor("tpv_comandas");
	curAlbaranes.select(where);
	var idAlbaran:Number;
	while (curAlbaranes.next()) {
		curAlbaranes.setModeAccess(curAlbaranes.Edit);
		curAlbaranes.refreshBuffer();
		idAlbaran = curAlbaranes.valueBuffer("idtpv_comanda");
		if (!this.iface.copiaLineasAlbaran(idAlbaran, idFactura)) {
			return false;
		}
		curAlbaranes.setValueBuffer("idtpv_comanda_factura", idFactura);
		curAlbaranes.setValueBuffer("editable", false);
		curAlbaranes.setValueBuffer("estado", "Cerrada");
		if (!curAlbaranes.commitBuffer()) {
			return false;
		}
		curRemito.select("idtpv_comanda = " + curAlbaranes.valueBuffer("idtpv_comanda"));
		curRemito.first();
		curRemito.setModeAccess(curRemito.Edit);
		curRemito.refreshBuffer();
		curRemito.setValueBuffer("ptefactura", false);
		curRemito.setValueBuffer("servido", "Sí");
		if (!curRemito.commitBuffer()) {
			return false;
		}
	}

	this.iface.curFactura.select("idtpv_comanda = " + idFactura);
	if (this.iface.curFactura.first()) {

		this.iface.curFactura.setModeAccess(this.iface.curFactura.Edit);
		this.iface.curFactura.refreshBuffer();

		if (!this.iface.totalesFactura(this.iface.curFactura)) {
			return false;
		}

		if (util.sqlSelect("tpv_datosgenerales", "araplicarpago", "1 = 1"))
			if (!this.iface.aplicarPago(this.iface.curFactura))
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
function tipoVenta_datosFactura(curAlbaran:FLSqlCursor, where:String, datosAgrupacion:Array):Boolean
{
	var util:FLUtil = new FLUtil();
	var fecha:String, hora:String;

	if (datosAgrupacion) {
		fecha = datosAgrupacion["fecha"];
		hora = datosAgrupacion["hora"];
	} else {
		var hoy:Date = new Date();
		fecha = hoy.toString();
		hora = hoy.toString().right(8);
	}

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

	var idSec:Number = util.sqlSelect("secuenciasejercicios", "id", "codejercicio = '" + flfactppal.iface.pub_ejercicioActual() + "' AND codserie = '" + codSerie + "'");
	var numero:Number = util.sqlSelect("secuencias", "valorout", "id = " + idSec + " AND nombre = 'nfacturacli'");
	if ( !numero || isNaN(numero) || numero == 0 )
		numero = 1;
	var codTerminal:String = util.readSettingEntry("scripts/fltpv_ppal/codTerminal");
	var agente:String = util.sqlSelect("tpv_puntosventa","codtpv_agente","codtpv_puntoventa ='" + codTerminal + "'");

	var codDir:Number = util.sqlSelect("dirclientes", "id", "codcliente = '" + curAlbaran.valueBuffer("codcliente") + "' AND domfacturacion = 'true'");
	with (this.iface.curFactura) {
		setValueBuffer("tipoventa", tipoVenta);
		setValueBuffer("codserie", codSerie);
		setValueBuffer("numerosecuencia", numero);
		setValueBuffer("fecha", fecha);
		setValueBuffer("hora", hora);
		setValueBuffer("codtpv_puntoventa", codTerminal);
		setValueBuffer("codtpv_agente", agente);
		setValueBuffer("tipopago", curAlbaran.valueBuffer("tipopago"));
		setValueBuffer("codpago", curAlbaran.valueBuffer("codpago"));
		setValueBuffer("nombrecliente", curAlbaran.valueBuffer("nombrecliente"));
		setValueBuffer("cifnif", curAlbaran.valueBuffer("cifnif"));
		setValueBuffer("codcliente", curAlbaran.valueBuffer("codcliente"));
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
			setValueBuffer("codpais", curAlbaran.valueBuffer("codpais"));
		} else {
			setValueBuffer("coddir", codDir);
			setValueBuffer("direccion", util.sqlSelect("dirclientes","direccion","id = " + codDir));
			setValueBuffer("codpostal", util.sqlSelect("dirclientes","codpostal","id = " + codDir));
			setValueBuffer("ciudad", util.sqlSelect("dirclientes","ciudad","id = " + codDir));
			setValueBuffer("provincia", util.sqlSelect("dirclientes","provincia","id = " + codDir));
			setValueBuffer("codpais", util.sqlSelect("dirclientes","codpais","id = " + codDir));
		}
		setValueBuffer("costototal", curAlbaran.valueBuffer("costototal"));
		setValueBuffer("ganancia", curAlbaran.valueBuffer("ganancia"));
		setValueBuffer("utilidad", curAlbaran.valueBuffer("utilidad"));
		setValueBuffer("estado", "Abierta");
		setValueBuffer("editable", true);
		setValueBuffer("automatica", true);
	}
	return true;
}

/** \D Informa los datos de una factura referentes a totales (I.V.A., neto, etc.)
@return	True si el cálculo se realiza correctamente, false en caso contrario
\end */
function tipoVenta_totalesFactura(curFactura:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	var neto:Number, totalIva:Number, total:Number;

	neto = util.sqlSelect("tpv_lineascomanda", "SUM(pvptotal)", "idtpv_comanda = " + curFactura.valueBuffer("idtpv_comanda"));

	totalIva = util.sqlSelect("tpv_lineascomanda", "SUM((pvptotal * iva) / 100)", "idtpv_comanda = " + curFactura.valueBuffer("idtpv_comanda"));

	total = neto + totalIva;

	neto = util.roundFieldValue(neto, "tpv_comandas", "neto");
	totalIva = util.roundFieldValue(totalIva, "tpv_comandas", "totaliva");
	total = util.roundFieldValue(total, "tpv_comandas", "total");

	with (curFactura) {
		setValueBuffer("neto", neto);
		setValueBuffer("totaliva", totalIva);
		setValueBuffer("total", total);
		setValueBuffer("pendiente", total);
	}
	return true;
}

/** \D
Copia las líneas de un remito como líneas de su factura asociada
@param idAlbaran: Identificador del remito
@param idFactura: Identificador de la factura
@return	Verdadero si no hay error, falso en caso contrario
\end */
function tipoVenta_copiaLineasAlbaran(idAlbaran:Number, idFactura:Number):Boolean
{
	var util:FLUtil = new FLUtil;
	var cantidad:Number, totalEnFactura:Number;
	var curLineaAlbaran:FLSqlCursor = new FLSqlCursor("tpv_lineascomanda");
	curLineaAlbaran.select("idtpv_comanda = " + idAlbaran);
	
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

/** \D
Copia una línea de remito en su factura asociada
@param curLineaAlbaran: Cursor posicionado en la línea de remito a copiar
@param idFactura: Identificador de la factura
@return	Identificador de la línea de factura si no hay error, falso en caso contrario
\end */
function tipoVenta_copiaLineaAlbaran(curLineaAlbaran:FLSqlCursor, idFactura:Number):Number
{
	if (!this.iface.curLineaFactura)
		this.iface.curLineaFactura = new FLSqlCursor("tpv_lineascomanda");
	
	with (this.iface.curLineaFactura) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idtpv_comanda", idFactura);
	}
	
	if (!this.iface.datosLineaFactura(curLineaAlbaran))
		return false;
		
	if (!this.iface.curLineaFactura.commitBuffer())
		return false;
	
	return this.iface.curLineaFactura.valueBuffer("idtpv_linea");
}

/** \D Copia los datos de una línea de remito en una línea de factura
@param	curLineaAlbaran: Cursor que contiene los datos a incluir en la línea de factura
@return	True si la copia se realiza correctamente, false en caso contrario
\end */
function tipoVenta_datosLineaFactura(curLineaAlbaran:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	var cantidad:Number = parseFloat(curLineaAlbaran.valueBuffer("cantidad")) - parseFloat(curLineaAlbaran.valueBuffer("totalenfactura"));
	var pvpSinDto:Number = parseFloat(curLineaAlbaran.valueBuffer("pvpsindto")) * cantidad / parseFloat(curLineaAlbaran.valueBuffer("cantidad"));
	pvpSinDto = util.roundFieldValue(pvpSinDto, "lineasfacturascli", "pvpsindto");

	with (this.iface.curLineaFactura) {
		setValueBuffer("referencia", curLineaAlbaran.valueBuffer("referencia"));
		setValueBuffer("descripcion", curLineaAlbaran.valueBuffer("descripcion"));
		setValueBuffer("pvpunitario", curLineaAlbaran.valueBuffer("pvpunitario"));
		setValueBuffer("cantidad", cantidad);
		setValueBuffer("cantidadprevia", cantidad);
		setValueBuffer("pvpsindto", pvpSinDto);
		setValueBuffer("pvptotal", formRecordtpv_lineascomanda.iface.pub_commonCalculateField("pvptotal", this));
		setValueBuffer("codimpuesto", curLineaAlbaran.valueBuffer("codimpuesto"));
		setValueBuffer("iva", curLineaAlbaran.valueBuffer("iva"));
		setValueBuffer("dtopor", curLineaAlbaran.valueBuffer("dtopor"));
		setValueBuffer("dtolineal", curLineaAlbaran.valueBuffer("dtolineal"));

		setValueBuffer("totalconiva", curLineaAlbaran.valueBuffer("totalconiva"));
		setValueBuffer("costounitario", curLineaAlbaran.valueBuffer("costounitario"));
		setValueBuffer("costototal", curLineaAlbaran.valueBuffer("costototal"));
		setValueBuffer("ganancia", curLineaAlbaran.valueBuffer("ganancia"));
		setValueBuffer("utilidad", curLineaAlbaran.valueBuffer("utilidad"));

		setValueBuffer("ivaincluido", curLineaAlbaran.valueBuffer("ivaincluido"));
		setValueBuffer("pvpunitarioiva", curLineaAlbaran.valueBuffer("pvpunitarioiva"));

		setValueBuffer("numserie", curLineaAlbaran.valueBuffer("numserie"));

		setValueBuffer("idtpv_comanda_albaran", curLineaAlbaran.valueBuffer("idtpv_comanda"));
		setValueBuffer("idtpv_lineacomanda_albaran", curLineaAlbaran.valueBuffer("idtpv_linea"));
	}

	return true;
}

function tipoVenta_aplicarPago(curFactura:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	var fecha:Date = new Date();
	var idComanda:String = curFactura.valueBuffer("idtpv_comanda");
	var importe:Number = curFactura.valueBuffer("pendiente");

	var curPago:FLSqlCursor = new FLSqlCursor("tpv_pagoscomanda");
	var codTerminal:String = util.readSettingEntry("scripts/fltpv_ppal/codTerminal");
	with (curPago) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idtpv_comanda", idComanda);
		setValueBuffer("importe", importe);
		setValueBuffer("fecha", fecha);
		setValueBuffer("estado", util.translate("scripts", "Pagado"));
		if (codTerminal) {
			setValueBuffer("codtpv_puntoventa", codTerminal);
			setValueBuffer("codtpv_agente", curFactura.valueBuffer("codtpv_agente"));
		}
	}
	curPago.setValueBuffer("codpago", curFactura.valueBuffer("codpago"));
	
	if (!curPago.commitBuffer())
		return false;

	with (curFactura) {
		setValueBuffer("pagado", curFactura.valueBuffer("pagado") + importe);
		setValueBuffer("pendiente", 0);
		setValueBuffer("estado", "Cerrada");
		setValueBuffer("editable", false);
	}

	return true;
}

//// TIPO VENTA //////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition ordenCampos */
/////////////////////////////////////////////////////////////////
//// ORDEN_CAMPOS ///////////////////////////////////////////////

function ordenCampos_init()
{
	this.iface.__init();

	var orden:Array = [ "codigo", "tipoventa", "nombrecliente", "neto", "totaliva", "total", "fecha", "hora", "estado", "editable", "codserie", "numerosecuencia", "codtpv_puntoventa", "codtpv_agente", "pagado", "pendiente", "tipopago", "codpago", "codtarifa", "codcliente", "cifnif", "direccion", "codpostal", "ciudad", "provincia", "codpais", "automatica" ];

	this.iface.tdbRecords.setOrderCols(orden);
	this.iface.tdbRecords.setFocus();
}

//// ORDEN_CAMPOS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////