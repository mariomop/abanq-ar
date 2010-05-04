/***************************************************************************
                 flfact_tpv.qs  -  description
                             -------------------
    begin                : lun ago 19 2005
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
	function beforeCommit_tpv_comandas(curComanda:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_tpv_comandas(curComanda);
	}
	function afterCommit_tpv_comandas(curComanda:FLSqlCursor):Boolean  {
		return this.ctx.interna_afterCommit_tpv_comandas(curComanda);
	}
	function beforeCommit_tpv_pagoscomanda(curPago:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_tpv_pagoscomanda(curPago);
	}
	function afterCommit_tpv_lineasvale(curLinea:FLSqlCursor):Boolean  {
		return this.ctx.interna_afterCommit_tpv_lineasvale(curLinea);
	}
	function afterCommit_tpv_pagoscomanda(curPago:FLSqlCursor):Boolean  {
		return this.ctx.interna_afterCommit_tpv_pagoscomanda(curPago);
	}
	function afterCommit_tpv_lineascomanda(curLinea:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_tpv_lineascomanda(curLinea);
	}
	function beforeCommit_tpv_arqueos(curArqueo:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_tpv_arqueos(curArqueo);
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var printer:FLPosPrinter;
	var printerXPos:Number;
	var printerYPos:Number;
	var printerESC:String;
	var textoPrinter:String = "";

	var curFactura:FLSqlCursor;
	var curLineaFactura:FLSqlCursor;

	function oficial( context ) { interna( context ); } 
	function ejecutarQry(tabla, campos, where, listaTablas):Array {
		return this.ctx.oficial_ejecutarQry(tabla, campos, where, listaTablas);
	}
	function copiarLinea(idFactura:Number,curLineaComanda:FLSqlCursor):Boolean {
		return this.ctx.oficial_copiarLinea(idFactura,curLineaComanda);
	}
	function copiarLineas(idComanda:Number, idFactura:Number):Boolean {
		return this.ctx.oficial_copiarLineas(idComanda, idFactura);
	}
	function crearFactura(curComanda:FLSqlCursor):Number {
		return this.ctx.oficial_crearFactura(curComanda);
	}
	function borrarFactura(idFactura:String):Boolean {
		return this.ctx.oficial_borrarFactura(idFactura);
	}
	function valoresIniciales() {
		return this.ctx.oficial_valoresIniciales();
	}
	function datosLineaFactura(curLineaComanda:FLSqlCursor):Boolean {
		return this.ctx.oficial_datosLineaFactura(curLineaComanda);
	}
	function generarRecibos(curComanda:FLSqlCursor):Boolean {
		return this.ctx.oficial_generarRecibos(curComanda);
	}
	function emitirReciboComo(codPago:String):String {
		return this.ctx.oficial_emitirReciboComo(codPago);
	}
	function generarRecibo(qryFactura:FLSqlQuery, datosRecibo:Array):Number {
		return this.ctx.oficial_generarRecibo(qryFactura, datosRecibo);
	}
	function pagarRecibo(idRecibo:String, datosRecibo:Array):Boolean {
		return this.ctx.oficial_pagarRecibo(idRecibo, datosRecibo);
	}
	function totalesFactura():Boolean {
		return this.ctx.oficial_totalesFactura();
	}
	function datosFactura(curComanda:FLSqlCursor):Boolean {
		return this.ctx.oficial_datosFactura(curComanda);
	}
	function imprimirDatos(datos:String, maxLon:Number, alineacion:Number) {
		return this.ctx.oficial_imprimirDatos(datos, maxLon, alineacion);
	}
	function establecerImpresora(impresora:String) {
		return this.ctx.oficial_establecerImpresora(impresora);
	}
	function flushImpresora() {
		return this.ctx.oficial_flushImpresora();
	}
	function impNuevaLinea(numLineas:Number) {
		return this.ctx.oficial_impNuevaLinea(numLineas);
	}
	function impAlinearH(alineacion:Number) {
		return this.ctx.oficial_impAlinearH(alineacion);
	}
	function impResaltar(resaltar:Boolean) {
		return this.ctx.oficial_impResaltar(resaltar);
	}
	function impSubrayar(subrayar:Boolean) {
		return this.ctx.oficial_impSubrayar(subrayar);
	}
	function impCortar() {
		return this.ctx.oficial_impCortar();
	}
	function espaciosIzquierda(texto:String, totalLongitud:Number):String {
		return this.ctx.oficial_espaciosIzquierda(texto, totalLongitud);
	}
	function subcuentaDefecto(nombre:String, codEjercicio:String):Array {
		return this.ctx.oficial_subcuentaDefecto(nombre, codEjercicio);
	}
	function subcuentaCausa(codCausa:String, codEjercicio:String):Array {
		return this.ctx.oficial_subcuentaCausa(codCausa, codEjercicio);
	}
	function generarAsientoArqueo(curArqueo:FLSqlCursor):Boolean {
		return this.ctx.oficial_generarAsientoArqueo(curArqueo);
	}
	function comprobarRegularizacion(curArqueo:FLSqlCursor):Boolean {
		return this.ctx.oficial_comprobarRegularizacion(curArqueo);
	}
	function regenerarAsiento(curArqueo:FLSqlCursor, valoresDefecto:Array):Array {
		return this.ctx.oficial_regenerarAsiento(curArqueo, valoresDefecto);
	}
	function generarPartidasMovi(curArqueo:FLSqlCursor, idAsiento:Number, valoresDefecto:Array):Boolean {
		return this.ctx.oficial_generarPartidasMovi(curArqueo, idAsiento, valoresDefecto);
	}
	function generarPartidasMoviCierre(curArqueo:FLSqlCursor, idAsiento:Number, valoresDefecto:Array):Boolean {
		return this.ctx.oficial_generarPartidasMoviCierre(curArqueo, idAsiento, valoresDefecto);
	}
	function generarPartidasDif(curArqueo:FLSqlCursor, idAsiento:Number, valoresDefecto:Array):Boolean {
		return this.ctx.oficial_generarPartidasDif(curArqueo, idAsiento, valoresDefecto);
	}
	function conceptoPartida(curArqueo:FLSqlCursor, masConcepto:String):String {
		return this.ctx.oficial_conceptoPartida(curArqueo, masConcepto);
	}
	function subcuentaDefecto(nombre:String, codEjercicio:String):Array {
		return this.ctx.oficial_subcuentaDefecto(nombre, codEjercicio);
	}
	function borrarAsientoArqueo(curArqueo:FLSqlCursor, idAsiento:String):Boolean {
		return this.ctx.oficial_borrarAsientoArqueo(curArqueo, idAsiento);
	}
	function obtenerCodigoComanda(curComanda:FLSqlCursor):String {
		return this.ctx.oficial_obtenerCodigoComanda(curComanda);
	}
	function obtenerCodigoArqueo(curArqueo:FLSqlCursor):String {
		return this.ctx.oficial_obtenerCodigoArqueo(curArqueo);
	}
	function comprobarSincronizacion(curComanda:FLSqlCursor):Boolean {
		return this.ctx.oficial_comprobarSincronizacion(curComanda);
	}
	function generarPartidasArqueo(curArqueo:FLSqlCursor, datosAsiento:Array, valoresDefecto:Array):Boolean {
		return this.ctx.oficial_generarPartidasArqueo(curArqueo, datosAsiento, valoresDefecto);
	}
	function valorDefectoTPV(campo:String):String {
		return this.ctx.oficial_valorDefectoTPV(campo);
	}
}

//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration funNumSerie */
/////////////////////////////////////////////////////////////////
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////
class funNumSerie extends oficial {
	function funNumSerie( context ) { oficial ( context ); }
	function datosLineaFactura(curLineaComanda:FLSqlCursor):Boolean {
		return this.ctx.funNumSerie_datosLineaFactura(curLineaComanda);
	}
}
//// FUN_NUMEROS_SERIE //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration tpvNsAcomp */
//////////////////////////////////////////////////////////////////
//// TPV_NS_ACOMP /////////////////////////////////////////////////////

class tpvNsAcomp extends funNumSerie {
	function tpvNsAcomp( context ) { funNumSerie( context ); } 	
	function copiarLinea(idFactura:Number,curLineaComanda:FLSqlCursor):Boolean {
		return this.ctx.tpvNsAcomp_copiarLinea(idFactura,curLineaComanda);
	}
	function afterCommit_tpv_lineascomandans(curL:FLSqlCursor):Boolean {
		return this.ctx.tpvNsAcomp_afterCommit_tpv_lineascomandans(curL);
	}
}

//// TPV_NS_ACOMP /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration ivaIncluido */
//////////////////////////////////////////////////////////////////
//// IVA INCLUIDO ////////////////////////////////////////////////
class ivaIncluido extends tpvNsAcomp {
	function ivaIncluido( context ) { tpvNsAcomp( context ); }
	function datosLineaFactura(curLineaComanda:FLSqlCursor):Boolean {
		return this.ctx.ivaIncluido_datosLineaFactura(curLineaComanda);
	}
}
//// IVA INCLUIDO ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration numeroSecuencia */
//////////////////////////////////////////////////////////////////
//// NUMERO SECUENCIA ////////////////////////////////////////////
class numeroSecuencia extends ivaIncluido {
	function numeroSecuencia( context ) { ivaIncluido( context ); } 
	function datosFactura(curComanda:FLSqlCursor):Boolean {
		return this.ctx.numeroSecuencia_datosFactura(curComanda);
	}
}
//// NUMERO SECUENCIA ////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration ganancias */
/////////////////////////////////////////////////////////////////
//// GANANCIAS //////////////////////////////////////////////////
class ganancias extends numeroSecuencia {
	function ganancias( context ) { numeroSecuencia ( context ); }

	function beforeCommit_tpv_comandas(curComanda:FLSqlCursor):Boolean {
		return this.ctx.ganancias_beforeCommit_tpv_comandas(curComanda);
	}
	function beforeCommit_tpv_lineascomanda(curLinea:FLSqlCursor):Boolean {
		return this.ctx.ganancias_beforeCommit_tpv_lineascomanda(curLinea);
	}

	function datosLineaFactura(curLineaComanda:FLSqlCursor):Boolean {
		return this.ctx.ganancias_datosLineaFactura(curLineaComanda);
	}
	function datosFactura(curComanda:FLSqlCursor):Boolean {
		return this.ctx.ganancias_datosFactura(curComanda);
	}

}
//// GANANCIAS //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration controlUsuario */
/////////////////////////////////////////////////////////////////
//// CONTROL_USUARIO ////////////////////////////////////////////
class controlUsuario extends ganancias {
    function controlUsuario( context ) { ganancias ( context ); }

	function beforeCommit_tpv_arqueos(curArqueo:FLSqlCursor):Boolean {
		return this.ctx.controlUsuario_beforeCommit_tpv_arqueos(curArqueo);
	}
}
//// CONTROL_USUARIO ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration tipoVenta */
/////////////////////////////////////////////////////////////////
//// TIPO DE VENTA //////////////////////////////////////////////
class tipoVenta extends controlUsuario {
	var curRemito:FLSqlCursor;
	var curLineaRemito:FLSqlCursor;
	var curPedido:FLSqlCursor;
	var curLineaPedido:FLSqlCursor;
	var curPresupuesto:FLSqlCursor;
	var curLineaPresupuesto:FLSqlCursor;

    function tipoVenta( context ) { controlUsuario ( context ); }
	function sincronizarConFacturacion(curComanda:FLSqlCursor):Boolean {
		return this.ctx.tipoVenta_sincronizarConFacturacion(curComanda);
	}
	function datosLineaFactura(curLineaComanda:FLSqlCursor):Boolean {
		return this.ctx.tipoVenta_datosLineaFactura(curLineaComanda);
	}
	function datosFactura(curComanda:FLSqlCursor):Boolean {
		return this.ctx.tipoVenta_datosFactura(curComanda);
	}
	// Remitos
	function crearRemito(curComanda:FLSqlCursor):Number {
		return this.ctx.tipoVenta_crearRemito(curComanda);
	}
	function borrarRemito(idAlbaran:String):Boolean {
		return this.ctx.tipoVenta_borrarRemito(idAlbaran);
	}
	function copiarLineasRemito(idComanda:Number, idAlbaran:Number):Boolean {
		return this.ctx.tipoVenta_copiarLineasRemito(idComanda, idAlbaran);
	}
	function copiarLineaRemito(idAlbaran:Number,curLineaComanda:FLSqlCursor):Boolean {
		return this.ctx.tipoVenta_copiarLineaRemito(idAlbaran,curLineaComanda);
	}
	function datosLineaRemito(curLineaComanda:FLSqlCursor):Boolean {
		return this.ctx.tipoVenta_datosLineaRemito(curLineaComanda);
	}
	function totalesRemito():Boolean {
		return this.ctx.tipoVenta_totalesRemito();
	}
	function datosRemito(curComanda:FLSqlCursor):Boolean {
		return this.ctx.tipoVenta_datosRemito(curComanda);
	}
	// Pedidos
	function crearPedido(curComanda:FLSqlCursor):Number {
		return this.ctx.tipoVenta_crearPedido(curComanda);
	}
	function borrarPedido(idPedido:String):Boolean {
		return this.ctx.tipoVenta_borrarPedido(idPedido);
	}
	function copiarLineasPedido(idComanda:Number, idPedido:Number):Boolean {
		return this.ctx.tipoVenta_copiarLineasPedido(idComanda, idPedido);
	}
	function copiarLineaPedido(idPedido:Number,curLineaComanda:FLSqlCursor):Boolean {
		return this.ctx.tipoVenta_copiarLineaPedido(idPedido,curLineaComanda);
	}
	function datosLineaPedido(curLineaComanda:FLSqlCursor):Boolean {
		return this.ctx.tipoVenta_datosLineaPedido(curLineaComanda);
	}
	function totalesPedido():Boolean {
		return this.ctx.tipoVenta_totalesPedido();
	}
	function datosPedido(curComanda:FLSqlCursor):Boolean {
		return this.ctx.tipoVenta_datosPedido(curComanda);
	}
	// Presupuestos
	function crearPresupuesto(curComanda:FLSqlCursor):Number {
		return this.ctx.tipoVenta_crearPresupuesto(curComanda);
	}
	function borrarPresupuesto(idPresupuesto:String):Boolean {
		return this.ctx.tipoVenta_borrarPresupuesto(idPresupuesto);
	}
	function copiarLineasPresupuesto(idComanda:Number, idPresupuesto:Number):Boolean {
		return this.ctx.tipoVenta_copiarLineasPresupuesto(idComanda, idPresupuesto);
	}
	function copiarLineaPresupuesto(idPresupuesto:Number,curLineaComanda:FLSqlCursor):Boolean {
		return this.ctx.tipoVenta_copiarLineaPresupuesto(idPresupuesto,curLineaComanda);
	}
	function datosLineaPresupuesto(curLineaComanda:FLSqlCursor):Boolean {
		return this.ctx.tipoVenta_datosLineaPresupuesto(curLineaComanda);
	}
	function totalesPresupuesto():Boolean {
		return this.ctx.tipoVenta_totalesPresupuesto();
	}
	function datosPresupuesto(curComanda:FLSqlCursor):Boolean {
		return this.ctx.tipoVenta_datosPresupuesto(curComanda);
	}
	// Asociar remitos
	function afterCommit_tpv_comandas(curComanda:FLSqlCursor):Boolean  {
		return this.ctx.tipoVenta_afterCommit_tpv_comandas(curComanda);
	}
	function liberarAlbaranesCli(idFactura:Number):Boolean {
		return this.ctx.tipoVenta_liberarAlbaranesCli(idFactura);
	}
	function liberarAlbaranCli(idAlbaran:Number):Boolean {
		return this.ctx.tipoVenta_liberarAlbaranCli(idAlbaran);
	}
	function afterCommit_tpv_lineascomanda(curLinea:FLSqlCursor):Boolean {
		return this.ctx.tipoVenta_afterCommit_tpv_lineascomanda(curLinea);
	}
	function actualizarAlbaranesLineaFacturaCli(curLF:FLSqlCursor):Boolean {
		return this.ctx.tipoVenta_actualizarAlbaranesLineaFacturaCli(curLF);
	}
	function actualizarLineaAlbaranCli(idLineaAlbaran:Number, idAlbaran:Number, referencia:String, idFactura:Number, cantidadLineaFactura:Number):Boolean {
		return this.ctx.tipoVenta_actualizarLineaAlbaranCli(idLineaAlbaran, idAlbaran, referencia, idFactura, cantidadLineaFactura);
	}
	function restarCantidadAlbaranCli(idLineaAlbaran:Number, idLineaFactura:Number):Boolean {
		return this.ctx.tipoVenta_restarCantidadAlbaranCli(idLineaAlbaran, idLineaFactura);
	}
	function actualizarEstadoAlbaranCli(idAlbaran:Number, curFactura:FLSqlCursor):Boolean {
		return this.ctx.tipoVenta_actualizarEstadoAlbaranCli(idAlbaran, curFactura);
	}
	function obtenerEstadoAlbaranCli(idAlbaran:Number):String {
		return this.ctx.tipoVenta_obtenerEstadoAlbaranCli(idAlbaran);
	}
	function actualizarIdFacturaEnRemitos():Boolean {
		return this.ctx.tipoVenta_actualizarIdFacturaEnRemitos();
	}
	function actualizarIdFacturaEnRemito(idRemitoComanda:Number, idFactura:Number):Boolean {
		return this.ctx.tipoVenta_actualizarIdFacturaEnRemito(idRemitoComanda, idFactura);
	}
}
//// TIPO DE VENTA //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration periodosFiscales */
/////////////////////////////////////////////////////////////////
//// PERIODOS FISCALES //////////////////////////////////////////
class periodosFiscales extends tipoVenta {
	function periodosFiscales( context ) { tipoVenta ( context ); }
	function datosFactura(curComanda:FLSqlCursor):Boolean {
		return this.ctx.periodosFiscales_datosFactura(curComanda);
	}
}
//// PERIODOS FISCALES //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration desbloqueoStock */
/////////////////////////////////////////////////////////////////
//// DESBLOQUEO AL MODIFICAR STOCK //////////////////////////////
class desbloqueoStock extends periodosFiscales {
    function desbloqueoStock( context ) { periodosFiscales ( context ); }
	function beforeCommit_tpv_comandas(curComanda:FLSqlCursor):Boolean {
		return this.ctx.desbloqueoStock_beforeCommit_tpv_comandas(curComanda);
	}
	function afterCommit_tpv_comandas(curComanda:FLSqlCursor):Boolean {
		return this.ctx.desbloqueoStock_afterCommit_tpv_comandas(curComanda);
	}
}
//// DESBLOQUEO AL MODIFICAR STOCK //////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends desbloqueoStock {
    function head( context ) { desbloqueoStock ( context ); }
	function pub_crearFactura(curComanda:FLSqlCursor):Number {
		return this.crearFactura(curComanda);
	}
	function pub_generarRecibos(curComanda:FLSqlCursor):Boolean {
		return this.generarRecibos(curComanda);
	}
}

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
	function ifaceCtx( context ) { head( context ); }
	function pub_ejecutarQry(tabla, campos, where, listaTablas):Array {
		return this.ejecutarQry(tabla, campos, where, listaTablas);
	}
	function pub_borrarAsientoArqueo(curArqueo:FLSqlCursor, idAsiento:String):Boolean {
		return this.borrarAsientoArqueo(curArqueo, idAsiento);
	}
	function pub_valorDefectoTPV(campo:String):String {
		return this.valorDefectoTPV(campo);
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
/** \D
Si es la primera vez que se ejecuta establece los valores iniciales de Datos Generales
*/
function interna_init() 
{
	var cursor:FLSqlCursor = new FLSqlCursor("tpv_datosgenerales");
	var util:FLUtil = new FLUtil();
	cursor.select();
	if (!cursor.first()) {
		MessageBox.information(util.translate("scripts","Se establecerán algunos valores iniciales para empezar a trabajar."),MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		this.iface.valoresIniciales();
		this.execMainScript("tpv_datosgenerales");
	}
}

/** \C Si se ha seleccionado la opción de facturación integrada, se creará una factura por venta. Si no se ha seleccionado, se generará cuando la venta sea a cuenta y el usuario lo permita
\end */
function interna_beforeCommit_tpv_comandas(curComanda:FLSqlCursor):Boolean 
{
/*  El contenido de esta función se borró para liberar espacio,
    es redefinida en ganancias_beforeCommit_tpv_comandas
*/
	return true;
}

function interna_afterCommit_tpv_comandas(curComanda:FLSqlCursor):Boolean
{
	return true;
}

function interna_beforeCommit_tpv_pagoscomanda(curPago:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	if (!curPago.valueBuffer("idtpv_arqueo")) {
		var qryarqueos:FLSqlQuery = new FLSqlQuery();
		qryarqueos.setTablesList("tpv_arqueos");
		qryarqueos.setSelect("idtpv_arqueo");
		qryarqueos.setFrom("tpv_arqueos");
		qryarqueos.setWhere("ptoventa = '" + curPago.valueBuffer("codtpv_puntoventa") + "' AND abierta = true AND diadesde <= '" + curPago.valueBuffer("fecha") + "'");
		if (!qryarqueos.exec())
			return;
		/** \C
		Comprueba que existe un arqueo abierto que corresponda con los datos de la venta antes de crear una nueva.
		*/
		if (!qryarqueos.first()){
			MessageBox.warning(util.translate("scripts", "No existe ningún arqueo abierto para este punto de venta y esta fecha.\nAntes de crear una venta debe crear el aqueo."),MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
		if (qryarqueos.size() > 1){
		/** \C
		No se puede crear una venta si existen más de un arqueo a los que pueda pertenecer
		*/
			MessageBox.warning(util.translate("scripts", "Existe mas de un arqueo abierto para este punto de venta y esta fecha."),MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
		curPago.setValueBuffer("idtpv_arqueo", qryarqueos.value(0));
	}
	
	return true;
}

function interna_afterCommit_tpv_pagoscomanda(curPago:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	switch(curPago.modeAccess()) {
		case curPago.Insert:
		case curPago.Edit: {
			/** \C Si se ha pagado con un vale, se actualiza su saldo
			\end */
			var refVale:String = curPago.valueBuffer("refvale");
			if (refVale && refVale != "") {
				var importeVale:String = util.sqlSelect("tpv_vales", "importe", "referencia = '" + refVale + "'");
				var gastado:String = util.sqlSelect("tpv_pagoscomanda", "SUM(importe)", "refvale = '" + refVale + "'");
				if (!gastado)
					gastado = 0;
				var saldoVale:Number = parseFloat(importeVale) - parseFloat(gastado);
				if (saldoVale < 0) {
					MessageBox.warning(util.translate("scripts", "El importe del pago es superior al saldo del vale"), MessageBox.Ok, MessageBox.NoButton);
					return false;
				}
				if (!util.sqlUpdate("tpv_vales", "saldo", saldoVale, "referencia = '" + refVale + "'"))
					return false;
			}
			break;
		}
	}
	return true;
}

/** \C  Al modificar las líneas de vale (artículos devueltos), el stock de los artículos correspondientes se modifica en consonancia
\end */ 
function interna_afterCommit_tpv_lineasvale(curLinea:FLSqlCursor):Boolean
{
	if (!flfactalma.iface.pub_controlStockValesTPV(curLinea))
		return false;

	return true;
}

/** \C  Al modificar las líneas de venta (artículos vendidos), el stock de los artículos correspondientes se modifica en consonancia
\end */ 
function interna_afterCommit_tpv_lineascomanda(curLinea:FLSqlCursor):Boolean
{
	if (!flfactalma.iface.pub_controlStockComandasCli(curLinea))
		return false;

	return true;
}

/** \C  Al Cerrar o abrir el arqueo se genera o borra el correspondiente asiento contable
\end */ 
function interna_beforeCommit_tpv_arqueos(curArqueo:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	switch (curArqueo.modeAccess()) {
		case curArqueo.Insert: {
			if (curArqueo.valueBuffer("idtpv_arqueo") == "0") {
				curArqueo.setValueBuffer("idtpv_arqueo", this.iface.obtenerCodigoArqueo(curArqueo));
			}
			if (curArqueo.valueBuffer("idtpv_arqueo") == "" || curArqueo.valueBuffer("idtpv_arqueo") == "0") {
				MessageBox.warning(util.translate("scripts", "El código del arqueo no puede estar vacío"), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}
			break;
		}
	}

	if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada")) {
		switch (curArqueo.modeAccess()) {
			case curArqueo.Edit: {
				var estadoActual:Boolean = curArqueo.valueBuffer("abierta");
				var estadoPrevio:Boolean = curArqueo.valueBufferCopy("abierta");
				if (estadoActual != estadoPrevio) {
					if (!estadoActual) {
						if (!this.iface.generarAsientoArqueo(curArqueo)) {
							return false;
						}
					}
				}
				break;
			}
		}
	}
	return true;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
  
/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_comprobarSincronizacion(curComanda:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	var integracionFac:String = util.sqlSelect("tpv_datosgenerales", "integracionfac", "1 = 1");
	var pendiente:Number = parseFloat(curComanda.valueBuffer("pendiente"));
	if (pendiente != 0 || integracionFac || !curComanda.isNull("iddocumento")) {
		if (!this.iface.sincronizarConFacturacion(curComanda)) {
			return false;
		}
	}
	return true;
}

/** \D Ejecuta una query especificada
  
@param tabla Argumento de setTablesList 
@param campo Argumento de setSelect
@param tabla Argumento de setWhere
@param tabla Argumento de setFrom
  
@return Un array con los datos de los campos seleccionados. Un campo extra
'result' que es 1 = Ok, 0 = Error, -1 No encontrado
*/
function oficial_ejecutarQry(tabla, campos, where, listaTablas):Array
{ 
  var util:FLUtil = new FLUtil;
  var campo:Array = campos.split(",");
  var valor = [];
  valor["result"] = 1;
  var query:FLSqlQuery = new FLSqlQuery();
  if (listaTablas)
    query.setTablesList(listaTablas);
  else
    query.setTablesList(tabla);
  query.setSelect(campo);
  query.setFrom(tabla);
  query.setWhere(where + ";");
  if (query.exec()) {
    if (query.next()) {
      for (var i = 0; i < campo.length; i++) {
        valor[campo[i]] = query.value(i);
      }
    } else {
      valor.result = -1;
    }
  } else {
    MessageBox.critical
      (util.translate("scripts", "Falló la consulta") + query.sql(),
      MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
    valor.result = 0;
  }
  
  return valor;
} 
 
/** \D Copia una linea de la venta  a la factura
  
@param idFactura identificador de la factura
@param curLineaComanda cursor de las lineas de la venta
@return Boolean, true si la linea se ha copiado correctamente y false si ha habido algún errror
*/
function oficial_copiarLinea(idFactura:Number,curLineaComanda:FLSqlCursor):Boolean 
{
	if (!this.iface.curLineaFactura)
		this.iface.curLineaFactura = new FLSqlCursor("lineasfacturascli");
	
	with (this.iface.curLineaFactura) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idfactura", idFactura);
	}
	
	if (!this.iface.datosLineaFactura(curLineaComanda))
		return false;
		
	if (!this.iface.curLineaFactura.commitBuffer())
			return false;
	
	return this.iface.curLineaFactura.valueBuffer("idlinea");
}

/** \D Copia campo a campo una linea de la venta en una línea de la factura
@param curLineaComanda cursor de las lineas de la venta
@return Boolean, true si la linea se ha copiado correctamente y false si ha habido algún errror
*/
function oficial_datosLineaFactura(curLineaComanda:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	with (this.iface.curLineaFactura) {
		setValueBuffer("referencia", curLineaComanda.valueBuffer("referencia"));
		setValueBuffer("descripcion", curLineaComanda.valueBuffer("descripcion"));
		setValueBuffer("pvpunitario", curLineaComanda.valueBuffer("pvpunitario"));
		setValueBuffer("cantidad", curLineaComanda.valueBuffer("cantidad"));
		setValueBuffer("pvpsindto", curLineaComanda.valueBuffer("pvpsindto"));
		setValueBuffer("pvptotal", curLineaComanda.valueBuffer("pvptotal"));
		setValueBuffer("codimpuesto", curLineaComanda.valueBuffer("codimpuesto"));
		setValueBuffer("iva", curLineaComanda.valueBuffer("iva"));
		setValueBuffer("dtolineal", curLineaComanda.valueBuffer("dtolineal"));
		setValueBuffer("dtopor", curLineaComanda.valueBuffer("dtopor"));
	}
	/// Para la extensión de subcuenta de ventas por artículos
	var subctaVentas:Array = flfacturac.iface.pub_subcuentaVentas(curLineaComanda.valueBuffer("referencia"));
	if (subctaVentas) {
		this.iface.curLineaFactura.setValueBuffer("codsubcuenta", subctaVentas.codsubcuenta);
		this.iface.curLineaFactura.setValueBuffer("idsubcuenta", subctaVentas.idsubcuenta);
	}
	return true;
}
/** \D Copia todas las lineas de la acomanda a la factura
  
@param idComanda identificador de la venta
@param idFactura idfentificador de la factura
@return Boolean true si se han copiado todas las líneas correctamente y fasle si ha habido algún error
*/
function oficial_copiarLineas(idComanda:Number, idFactura:Number):Boolean 
{
	var curLineaComanda:FLSqlCursor = new FLSqlCursor("tpv_lineascomanda");
	curLineaComanda.select("idtpv_comanda = " + idComanda);
	while (curLineaComanda.next()) {
		if(!this.iface.copiarLinea(idFactura,curLineaComanda))
			return false;
	}
	return true;
}

/** \D Crea la factura a partir de una venta
  
@param curComanda cursor de la venta 

@return False si ha habido algún error y el idFactura se se ha creado correctamente
*/
function oficial_crearFactura(curComanda:FLSqlCursor):Number
{
	var util:FLUtil = new FLUtil();
	var idFactura:Number;
	
	if (!this.iface.curFactura)
		this.iface.curFactura = new FLSqlCursor("facturascli");

	this.iface.curFactura.setModeAccess(this.iface.curFactura.Insert);
	this.iface.curFactura.refreshBuffer();

	if (!this.iface.datosFactura(curComanda))
		return false;

	if (!this.iface.curFactura.commitBuffer())
		return false;
		
	idFactura = this.iface.curFactura.valueBuffer("idfactura"); 
	if (!this.iface.copiarLineas(curComanda.valueBuffer("idtpv_comanda"), idFactura))
		return false;

	this.iface.curFactura.select("idfactura = " + idFactura);
	if (!this.iface.curFactura.first())
		return false;
		
	if (!formRecordfacturascli.iface.pub_actualizarLineasIva(this.iface.curFactura))
		return false;

	this.iface.curFactura.setModeAccess(this.iface.curFactura.Edit);
	this.iface.curFactura.refreshBuffer();

	if (!this.iface.actualizarIdFacturaEnRemitos())
		return false;

	if (!this.iface.totalesFactura())
		return false;

	if (!this.iface.curFactura.commitBuffer())
		return false;
		
	return idFactura;
}

/** \D Calcula los datos de totale de la factura
@return	true el cálculo se realiza correcamente, false en caso contrario
\end */
function oficial_totalesFactura():Boolean
{
	with (this.iface.curFactura) {
		setValueBuffer("neto", formfacturascli.iface.pub_commonCalculateField("neto", this));
		setValueBuffer("totaliva", formfacturascli.iface.pub_commonCalculateField("totaliva", this));
		setValueBuffer("total", formfacturascli.iface.pub_commonCalculateField("total", this));
		setValueBuffer("totaleuros", formfacturascli.iface.pub_commonCalculateField("totaleuros", this));
	}
	return true;
}

/** \D Establece los datos de la factura a partir del registro de ventas
@param	curComanda: Cursor posicionado en el registro de ventas
@return	true si la copia de datos es correcta, false en caso contrario
\end */
function oficial_datosFactura(curComanda:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	var codAlmacen:String = util.sqlSelect("tpv_puntosventa", "codalmacen", "codtpv_puntoventa = '" + curComanda.valueBuffer("codtpv_puntoventa") + "'");
	if (!codAlmacen || codAlmacen == "")
		codAlmacen = flfactppal.iface.pub_valorDefectoEmpresa("codalmacen");
		
	var codCliente:String = curComanda.valueBuffer("codcliente");
	var nomCliente:String = curComanda.valueBuffer("nombrecliente");
	var cifCliente:String = curComanda.valueBuffer("cifnif");
	var direccion:String = curComanda.valueBuffer("direccion");

	if (!nomCliente || nomCliente == "")
		nomCliente = "-";
	if (!cifCliente || cifCliente == "")
		cifCliente = "-";
	if (!direccion || direccion == "")
		direccion = "-";
	
	with (this.iface.curFactura) {
		if (codCliente && codCliente != "")
			setValueBuffer("codcliente", codCliente);
		setValueBuffer("nombrecliente", nomCliente);
		setValueBuffer("cifnif", cifCliente);
		setValueBuffer("direccion", direccion);
		if (curComanda.valueBuffer("coddir") != 0)
			setValueBuffer("coddir", curComanda.valueBuffer("coddir"));
		setValueBuffer("codpostal", curComanda.valueBuffer("codpostal"));
		setValueBuffer("ciudad", curComanda.valueBuffer("ciudad"));
		setValueBuffer("provincia", curComanda.valueBuffer("provincia"));
		setValueBuffer("codpais", curComanda.valueBuffer("codpais"));
		setValueBuffer("fecha", curComanda.valueBuffer("fecha"));
		setValueBuffer("hora", curComanda.valueBuffer("hora"));
		setValueBuffer("codejercicio",flfactppal.iface.pub_ejercicioActual());
		setValueBuffer("coddivisa", curComanda.valueBuffer("coddivisa"));
		setValueBuffer("codpago", curComanda.valueBuffer("codpago"));
		setValueBuffer("codalmacen", codAlmacen);
		setValueBuffer("tasaconv", curComanda.valueBuffer("tasaconv"));
		//setValueBuffer("automatica", true);
		setValueBuffer("tpv", true);
	}
	return true;
}

/** \D
Crea una nueva forma de pago y establece los valores del formulario Datos Genenrales
*/
function oficial_valoresIniciales()
{
	var cursor:FLSqlCursor = new FLSqlCursor("tpv_datosgenerales");
	with(cursor) {
		setModeAccess(cursor.Insert);
		refreshBuffer();
		setValueBuffer("tarifa", "");
		setValueBuffer("pagoefectivo", "CONTADO");
		setValueBuffer("pagoctacte", "CTACTE");
		setValueBuffer("pagotarjeta", "TARJETA");
		setValueBuffer("pagocheque", "CHEQUE");
		setValueBuffer("pagovale", "VALE");
		commitBuffer();
	}
}

/** \D Borra la factura especificada, eliminando sus pagos si existen
@param	idFactura: Identificador de la factura a borrar
@return	true si la factura se borra correctamente, false en caso contrario
\end */
function oficial_borrarFactura(idFactura:String):Boolean
{
	var util:FLUtil = new FLUtil;
	
	if (sys.isLoadedModule("flfactteso")) {
		var qryRecibos:FLSqlQuery = new FLSqlQuery();
		qryRecibos.setTablesList("reciboscli,pagosdevolcli");
		qryRecibos.setSelect("idpagodevol");
		qryRecibos.setFrom("reciboscli r INNER JOIN pagosdevolcli p ON r.idrecibo = p.idrecibo");
		qryRecibos.setWhere("r.idfactura = " + idFactura + " ORDER BY p.idrecibo, p.fecha DESC, p.idpagodevol DESC");
		try { qryRecibos.setForwardOnly( true ); } catch (e) {}
		if (!qryRecibos.exec())
			return false;
		
		var curPagos:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
		while (qryRecibos.next()) {
			curPagos.select("idpagodevol = " + qryRecibos.value(0));
			if (!curPagos.first())
				return false;

			curPagos.setModeAccess(curPagos.Del);
			if (!curPagos.refreshBuffer())
				return false;;

			if (!curPagos.commitBuffer())
				return false;
		}
	}
	if (!util.sqlDelete("facturascli", "idfactura = " + idFactura))
		return false;

	return true;
}

/** \C Genera un recibo pagado por cada pago asociada a la venta
@param	curComanda: cursor posiciondado en la venta
@return	true si la generación se realiza correctamente, false en caso contrario
\end */
function oficial_generarRecibos(curComanda:FLSqlCursor):Boolean
{
	if (!sys.isLoadedModule("flfactteso"))
		return true;
	
	var util:FLUtil = new FLUtil;
	
	var idFactura:String = curComanda.valueBuffer("iddocumento");
	var qryFactura = new FLSqlQuery();
	qryFactura.setTablesList("facturascli");
	qryFactura.setSelect("idfactura, coddivisa, codigo, codcliente, nombrecliente, cifnif, coddir, direccion, codpostal, ciudad, provincia, codpais, tasaconv");
	qryFactura.setFrom("facturascli");
	qryFactura.setWhere("idfactura = " + idFactura);
	try { qryFactura.setForwardOnly( true ); } catch (e) {}
	
	if (!qryFactura.exec())
		return false;;
	if (!qryFactura.first())
		return false;
	
	var curPagos:FLSqlCursor = new FLSqlCursor("tpv_pagoscomanda");
	curPagos.select("idtpv_comanda = " + curComanda.valueBuffer("idtpv_comanda") + " AND estado = '" + util.translate("scripts", "Pagado") + "'");
	
	var datosRecibo:Array = [];
	datosRecibo.numRecibo = 1;
	datosRecibo.moneda = util.sqlSelect("facturascli f INNER JOIN divisas d ON f.coddivisa = d.coddivisa", "d.descripcion", "f.idfactura = " + idFactura, "facturascli,divisas");
	
	var idRecibo:String;
	var importe:Number;
	var totalPagado:Number;
	while (curPagos.next()) {
		datosRecibo.importe = parseFloat(curPagos.valueBuffer("importe"));
		datosRecibo.fecha = curPagos.valueBuffer("fecha");
		datosRecibo.codPago = curPagos.valueBuffer("codpago");

		datosRecibo.estado = this.iface.emitirReciboComo(curPagos.valueBuffer("codpago"));

		idRecibo = this.iface.generarRecibo(qryFactura, datosRecibo);
		if (!idRecibo)
			return false;
		datosRecibo.numRecibo++;
		totalPagado += datosRecibo.importe;
		
		curPagos.setModeAccess(curPagos.Edit);
		curPagos.refreshBuffer();
		curPagos.setValueBuffer("idrecibo", idRecibo);
		if (!curPagos.commitBuffer())
			return false;
	}
	
	datosRecibo.importe = parseFloat(curComanda.valueBuffer("total")) - totalPagado;
	if (datosRecibo.importe > 0) {
		datosRecibo.estado = "Pendiente";
		datosRecibo.fecha = curComanda.valueBuffer("fecha");
		
		idRecibo = this.iface.generarRecibo(qryFactura, datosRecibo);
		if (!idRecibo)
			return false;
	}
		
	return true;
}

function oficial_emitirReciboComo(codPago:String):String
{
	var util:FLUtil = new FLUtil;
	var emitirComo:String = util.sqlSelect("formaspago", "genrecibos", "codpago = '" + codPago + "'");

	if (emitirComo == "Contado") {
		emitirComo = "Pagado";
	} else
		emitirComo = "Pendiente";

	return emitirComo;
}

/** \C Genera un recibo más un pago asociado al pago de la venta
@param	qryFactura: consulta que contiene los datos de la factura
@param	datosRecibo: Array con los siguientes datos relativos al recibo:
	importe
	número
	fecha
	moneda
	estado
@return	identificador del recibo, o false si hay error
\end */
function oficial_generarRecibo(qryFactura:FLSqlQuery, datosRecibo:Array):Number
{
	var util:FLUtil = new FLUtil;
	
	var curRecibo:FLSqlCursor = new FLSqlCursor("reciboscli");
	with (curRecibo) {
		setModeAccess(Insert);
		refreshBuffer()
		setValueBuffer("numero", datosRecibo.numRecibo);
		setValueBuffer("idfactura", qryFactura.value("idfactura"));
		setValueBuffer("importe", datosRecibo.importe);
		setValueBuffer("importeeuros", datosRecibo.importe * parseFloat(qryFactura.value("tasaconv")));
		setValueBuffer("coddivisa", qryFactura.value("coddivisa"));
		setValueBuffer("codigo", qryFactura.value("codigo") + "-" + flfacturac.iface.pub_cerosIzquierda(datosRecibo.numRecibo, 2));
		setValueBuffer("codcliente", qryFactura.value("codcliente"));
		setValueBuffer("nombrecliente", qryFactura.value("nombrecliente"));
		setValueBuffer("cifnif", qryFactura.value("cifnif"));
		if (qryFactura.value("coddir"))
			setValueBuffer("coddir", qryFactura.value("coddir"));
		else
			setNull("coddir");
		setValueBuffer("direccion", qryFactura.value("direccion"));
		setValueBuffer("codpostal", qryFactura.value("codpostal"));
		setValueBuffer("ciudad", qryFactura.value("ciudad"));
		setValueBuffer("provincia", qryFactura.value("provincia"));
		setValueBuffer("codpais", qryFactura.value("codpais"));
		setValueBuffer("fecha", datosRecibo.fecha);
		setValueBuffer("fechav", datosRecibo.fecha);
		setValueBuffer("estado", datosRecibo.estado);
		setValueBuffer("texto", util.enLetraMoneda(datosRecibo.importe, datosRecibo.moneda));
	}
	if (!curRecibo.commitBuffer())
		return false;
	
	var idRecibo = curRecibo.valueBuffer("idrecibo");
	if (datosRecibo.estado == util.translate("scripts", "Pagado")) {
		if (!this.iface.pagarRecibo(idRecibo, datosRecibo))
			return false;
	}
		
	return idRecibo;
}

/** \C
Crea un registro de pago en tesorería asociado al recibo especificado
@param	idRecibo: Identificador del recibo a pagar
@param	datpsRecibo: Array con los datos del recibo
@return true si el pago se crea correctamente, false en caso contrario
\end */
function oficial_pagarRecibo(idRecibo:String, datosRecibo:Array):Boolean
{
	var util:FLUtil = new FLUtil;
	
	var hayContabilidad:Boolean = sys.isLoadedModule("flcontppal");
	var ejercicioActual:String = flfactppal.iface.pub_ejercicioActual();
	
	var idSubcuenta:String = "";
	var codSubcuenta:String = "";
	
	var qryCuenta:FLSqlQuery = new FLSqlQuery;
	qryCuenta.setTablesList("formaspago,cuentasbanco");
	qryCuenta.setSelect("cuenta,ctaentidad,ctaagencia,codsubcuenta");
	qryCuenta.setFrom("formaspago f INNER JOIN cuentasbanco c ON f.codcuenta = c.codcuenta")
	qryCuenta.setWhere("f.codpago = '" + datosRecibo.codPago + "'")
	try { qryCuenta.setForwardOnly( true ); } catch (e) {}
	if (!qryCuenta.exec())
		return false;
		
	var cuenta:String = "";
	var entidad:String = "";
	var agencia:String = "";
	if (qryCuenta.first()) {
		cuenta = qryCuenta.value("cuenta");
		entidad = qryCuenta.value("ctaentidad");
		agencia = qryCuenta.value("ctaagencia");
		codSubcuenta = qryCuenta.value("codsubcuenta");
	}
	
	if (hayContabilidad) {
		if (codSubcuenta && codSubcuenta != "") {
			idSubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + ejercicioActual + "'");
		}
		if (!idSubcuenta || idSubcuenta == "") {
			var datosSubcuenta:Array = flfacturac.iface.pub_datosCtaEspecial("CAJA", ejercicioActual);
			if (datosSubcuenta.error != 0) {
				MessageBox.warning(util.translate("scripts", "No tiene ninguna cuenta contable marcada como cuenta especial de caja\nDebe asociar la cuenta a la cuenta especial en el módulo Principal del área Financiera"), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}
			codSubcuenta = datosSubcuenta.codsubcuenta;
			idSubcuenta = datosSubcuenta.idsubcuenta;
		}
	}
	
	var curPagoDevol:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
	with (curPagoDevol) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idrecibo", idRecibo);
		setValueBuffer("fecha", datosRecibo.fecha);
		setValueBuffer("tipo", "Pago");
		setValueBuffer("cuenta", cuenta);
		setValueBuffer("ctaagencia", agencia);
		setValueBuffer("ctaentidad", entidad);
		if (hayContabilidad) {
			setValueBuffer("idsubcuenta", idSubcuenta);
			setValueBuffer("codsubcuenta", codSubcuenta);
		} else {
			setNull("idsubcuenta");
			setNull("codsubcuenta");
		}
	}
	if (!curPagoDevol.commitBuffer())
		return false;
	
	return true;
}

/** \D Envia una cadena de caracteres a la impresora
@param	datos: Cadena de caracteres
@param	maxLon: Número de caracteres máximo a enviar. Si este valor no está informado se envia toda la cadena.
\end */
function oficial_imprimirDatos(datos:String, maxLon:Number, alineacion:Number)
{
	// Si hay códigos de escape por imprimir, se imprimen antes de enviar los datos
	if (this.iface.printerESC != "ESC:") {
		this.iface.printer.send(this.iface.printerESC, this.iface.printerXPos, this.iface.printerYPos);
		this.iface.printerESC = "ESC:";
	}
	if (!datos)
		datos = "";
	else
		datos = datos.toString();
	
	if (maxLon && maxLon != 0) {
		datos = datos.left(maxLon);
		if (datos.length < maxLon) {
			if (alineacion == 2)
				datos = this.iface.espaciosIzquierda(datos, maxLon);
			else
				datos = flfactppal.iface.pub_espaciosDerecha(datos, maxLon);
		}
	}

	this.iface.printer.send(datos, this.iface.printerXPos, this.iface.printerYPos);
	this.iface.printerXPos += datos.length;
	
	this.iface.textoPrinter += datos;
}

function oficial_espaciosIzquierda(texto:String, totalLongitud:Number):String
{
	var ret:String = ""
	var numEspacios:Number = totalLongitud - texto.toString().length;
	for ( ; numEspacios > 0 ; --numEspacios)
		ret += " ";
	ret += texto.toString();
	return ret;
}


function oficial_impNuevaLinea(numLineas:Number)
{
	if (!numLineas)
		numLineas = 1;

	if (numLineas == 1) {
		this.iface.printerESC += "0A";
		this.iface.printer.send(this.iface.printerESC);
	} else {
		this.iface.printerESC += "1B,64," + flfactppal.iface.pub_cerosIzquierda(numLineas, 2);
		this.iface.printer.send(this.iface.printerESC);
	}
	this.iface.printerESC = "ESC:";
	this.iface.printerXPos = 1;
	this.iface.printerYPos += numLineas;

	for(var i:Number = 0; i < numLineas; i++)
		this.iface.textoPrinter += "\n";
}

/** \D Activa o desactiva el resaltado de letra
@param	alineación: Posibles valores:
	0. Alinear a la izquieda
	1. Centrar
	2. Alinear a la derecha
\end */
function oficial_impAlinearH(alineacion:Number)
{
	var tipo:String = "00";
	switch (alineacion) {
		case 0: {
			tipo = "00";
			break;
		}
		case 1: {
			tipo = "01";
			break;
		}
		case 2: {
			tipo = "02";
			break;
		}
	}
	this.iface.printerESC += "0D,1B,61," + tipo + ",";
}

/** \D Activa o desactiva el resaltado de letra
@param	resaltar: Indica si hay que activar o desactivar el resaltado
\end */
function oficial_impResaltar(resaltar:Boolean)
{
	if (resaltar)
		this.iface.printerESC += "1B,45,01,";
	else
		this.iface.printerESC += "1B,45,00,";
}

/** \D Activa o desactiva el subrayado de letra
@param	resaltar: Indica si hay que activar o desactivar el subrayado
\end */
function oficial_impSubrayar(subrayar:Boolean)
{
	if (subrayar)
		this.iface.printerESC += "1B,2D,01,";
	else
		this.iface.printerESC += "1B,2D,00,";
}

function oficial_flushImpresora()
{
	//debug(this.iface.textoPrinter);
	this.iface.textoPrinter = "";
	
	if (this.iface.printerESC != "ESC:") {
		this.iface.printer.send(this.iface.printerESC, this.iface.printerXPos, this.iface.printerYPos);
		this.iface.printerESC = "ESC:";
	}
	this.iface.printer.flush();
}

function oficial_impCortar()
{
	this.iface.printerESC += "1B,6D,";
}

function oficial_establecerImpresora(impresora:String)
{
	if (this.iface.printer)
		delete this.iface.printer;
	this.iface.printer = new FLPosPrinter();
	this.iface.printer.setPrinterName( impresora );
	this.iface.printerXPos = 1;
	this.iface.printerYPos = 1;
	this.iface.printerESC = "ESC:1B,74,19,";
	this.iface.impAlinearH(0);
	this.iface.impResaltar(false);
}

/** \U Genera o regenera el asiento correspondiente a un arqueo de TPV
@param	curArqueo: Cursor con los datos del arqueo
@return	VERDADERO si no hay error. FALSO en otro caso
\end */
function oficial_generarAsientoArqueo(curArqueo:FLSqlCursor):Boolean
{
	if (curArqueo.modeAccess() != curArqueo.Edit) {
		return true;
	}

	var util:FLUtil = new FLUtil;
	if (curArqueo.valueBuffer("nogenerarasiento")) {
		curArqueo.setNull("idasiento");
		return true;
	}

	if (!this.iface.comprobarRegularizacion(curArqueo)) {
		return false;
	}

	var datosAsiento:Array = [];
	var valoresDefecto:Array;
	valoresDefecto["codejercicio"] = flfactppal.iface.pub_ejercicioActual();
	valoresDefecto["coddivisa"] = flfactppal.iface.pub_valorDefectoEmpresa("coddivisa");

	datosAsiento = this.iface.regenerarAsiento(curArqueo, valoresDefecto);
	if (datosAsiento.error == true) {
		return false;
	}

	if (!this.iface.generarPartidasArqueo(curArqueo, datosAsiento, valoresDefecto)) {
		return false;
	}

	if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento)) {
		return false;
	}

	if (!util.sqlSelect("co_partidas", "idpartida", "idasiento = " + datosAsiento.idasiento)) {
		if (!this.iface.pub_borrarAsientoArqueo(curArqueo, datosAsiento.idasiento)) {
			return false;
		}
	} else {
		curArqueo.setValueBuffer("idasiento", datosAsiento.idasiento);
	}
	return true;
}

function oficial_generarPartidasArqueo(curArqueo:FLSqlCursor, datosAsiento:Array, valoresDefecto:Array):Boolean
{
	if (!this.iface.generarPartidasMovi(curArqueo, datosAsiento.idasiento, valoresDefecto)) {
		return false;
	}

	if (!this.iface.generarPartidasMoviCierre(curArqueo, datosAsiento.idasiento, valoresDefecto)) {
		return false;
	}

	if (!this.iface.generarPartidasDif(curArqueo, datosAsiento.idasiento, valoresDefecto)) {
		return false;
	}
	return true;
}

/** \D Comprueba que si la factura tiene IVA, no esté incluida en un período de regularización ya cerrado
@param	curFactura: Cursor de la factura de cliente o proveedor
@return TRUE si la factura no tiene IVA o teniéndolo su fecha no está incluida en ningún período ya cerrado. FALSE en caso contrario
\end */
function oficial_comprobarRegularizacion(curArqueo:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	var fecha:String = curArqueo.valueBuffer("diahasta");
	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	if (util.sqlSelect("co_regiva", "idregiva", "fechainicio <= '" + fecha + "' AND fechafin >= '" + fecha + "' AND codejercicio = '" + codEjercicio + "'")) {
		MessageBox.warning(util.translate("scripts", "No puede incluirse el asiento de la factura en un período de I.V.A. ya regularizado"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	return true;
}

/** \D Genera o regenera el registro en la tabla de asientos correspondiente a la factura. Si el asiento ya estaba creado borra sus partidas asociadas.
@param	curArqueo: Cursor posicionado en el registro de arqueo
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return	array con los siguientes datos:
asiento.idasiento: Id del asiento
asiento.numero: numero del asiento
asiento.fecha: fecha del asiento
asiento.error: indicador booleano de que ha habido un error en la función
\end */
function oficial_regenerarAsiento(curArqueo:FLSqlCursor, valoresDefecto:Array):Array
{
	var util:FLUtil = new FLUtil;
	var asiento:Array = [];
	var idAsiento:Number = curArqueo.valueBuffer("idasiento");
	if (curArqueo.isNull("idasiento") || curArqueo.valueBuffer("idasiento") == 0) {
		var curAsiento:FLSqlCursor = new FLSqlCursor("co_asientos");
		with (curAsiento) {
			setModeAccess(curAsiento.Insert);
			refreshBuffer();
			setValueBuffer("numero", 0);
			setValueBuffer("fecha", curArqueo.valueBuffer("diahasta"));
			setValueBuffer("codejercicio", valoresDefecto.codejercicio);
		}
		if (!curAsiento.commitBuffer()) {
			asiento.error = true;
			return asiento;
		}
		asiento.idasiento = curAsiento.valueBuffer("idasiento");
		asiento.numero = curAsiento.valueBuffer("numero");
		asiento.fecha = curAsiento.valueBuffer("fecha");
		curAsiento.select("idasiento = " + asiento.idasiento);
		curAsiento.first();
		curAsiento.setUnLock("editable", false);
	} else {
		if (!flfacturac.iface.pub_asientoBorrable(idAsiento)) {
			asiento.error = true;
			return asiento;
		}

		var curAsiento:FLSqlCursor = new FLSqlCursor("co_asientos");
		curAsiento.select("idasiento = " + idAsiento);
		if (!curAsiento.first()) {
			asiento.error = true;
			return asiento;
		}
		curAsiento.setUnLock("editable", true);

		curAsiento.select("idasiento = " + idAsiento);
		if (!curAsiento.first()) {
			asiento.error = true;
			return asiento;
		}
		curAsiento.setModeAccess(curAsiento.Edit);
		curAsiento.refreshBuffer();
		curAsiento.setValueBuffer("fecha", curArqueo.valueBuffer("diahasta"));

		if (!curAsiento.commitBuffer()) {
			asiento.error = true;
			return asiento;
		}
		curAsiento.select("idasiento = " + idAsiento);
		if (!curAsiento.first()) {
			asiento.error = true;
			return asiento;
		}
		curAsiento.setUnLock("editable", false);

		asiento = flfactppal.iface.pub_ejecutarQry("co_asientos", "idasiento,numero,fecha,codejercicio", "idasiento = '" + idAsiento + "'");
		if (asiento.codejercicio != valoresDefecto.codejercicio) {
			MessageBox.warning(util.translate("scripts", "Está intentando regenerar un asiento del ejercicio %1 en el ejercicio %2.\nVerifique que su ejercicio actual es correcto. Si lo es y está actualizando un pago, bórrelo y vuélvalo a crear.").arg(asiento.codejercicio).arg(valoresDefecto.codejercicio), MessageBox.Ok, MessageBox.NoButton);
			asiento.error = true;
			return asiento;
		}
		var curPartidas = new FLSqlCursor("co_partidas");
		curPartidas.select("idasiento = " + idAsiento);
		while (curPartidas.next()) {
			curPartidas.setModeAccess(curPartidas.Del);
			curPartidas.refreshBuffer();
			if (!curPartidas.commitBuffer()) {
				asiento.error = true;
				return asiento;
			}
		}
	}

	asiento.error = false;
	return asiento;
}

/** \D Borra el registro en la tabla de asientos correspondiente a un arqueo de ventas.
@param	curArqueo: Cursor posicionado en el registro de arqueo
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return	True si el asiento se borra correctamente o no existe, false en caso contrario
\end */
function oficial_borrarAsientoArqueo(curArqueo:FLSqlCursor, idAsiento:String):Boolean
{
	var util:FLUtil = new FLUtil;
	
	if (!flfacturac.iface.pub_asientoBorrable(idAsiento)) {
		return false;
	}

	var curAsiento:FLSqlCursor = new FLSqlCursor("co_asientos");
	curAsiento.select("idasiento = " + idAsiento);
	if (!curAsiento.first()) {
		return false;
	}
	curAsiento.setUnLock("editable", true);

// 	curAsiento.select("idasiento = " + idAsiento);
// 	if (!curArqueo.first()) {
// 		return false;
// 	}
// 	curArqueo.setModeAccess(curArqueo.Edit);
// 	curArqueo.refreshBuffer();
// 	curArqueo.setNull("idasiento");
// 	if (!curArqueo.commitBuffer()) {
// 		return false;
// 	}

	if (!util.sqlDelete("co_asientos", "idasiento = " + idAsiento)) {
		return false;
	}

	return true;
}

/** \D Genera la parte del asiento de arqueo correspondiente a los movimientos de caja extraordinarios
@param	curArqueo: Cursor del arqueo
@param	idAsiento: Id del asiento asociado
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return	VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasMovi(curArqueo:FLSqlCursor, idAsiento:Number, valoresDefecto:Array):Boolean
{
	var util:FLUtil = new FLUtil();

	var qryMovimientos:FLSqlQuery = new FLSqlQuery;
	with (qryMovimientos) {
		setTablesList("tpv_movimientos");
		setSelect("SUM(cantidad), codcausa");
		setFrom("tpv_movimientos");
		setWhere("idtpv_arqueo = '" + curArqueo.valueBuffer("idtpv_arqueo") + "' GROUP BY codcausa");
		setForwardOnly(true);
	}
	if (!qryMovimientos.exec())
		return false;

	var debe:Number = 0;
	var debeCaja:Number = 0;
	var haber:Number = 0;
	var haberCaja:Number = 0;
	var totalMovi:Number = parseFloat(curArqueo.valueBuffer("totalmov"));
	if (totalMovi == 0)
		return true;

	if (totalMovi > 0 ) {
		debeCaja = totalMovi;
		haberCaja = 0;
	} else {
		totalMovi = totalMovi * -1;
		debeCaja = 0;
		haberCaja = totalMovi;
	}
	debeCaja = util.roundFieldValue(debeCaja, "co_partidas", "debe");
	haberCaja = util.roundFieldValue(haberCaja, "co_partidas", "haber");
		
	var codPagoEfectivo:String = util.sqlSelect("tpv_datosgenerales", "pagoefectivo", "1 = 1");
	
	var ctaCaja:Array = this.iface.subcuentaDefecto("CAJA", valoresDefecto.codejercicio);
	if (ctaCaja.error != 0)
		return false;

	var ctaMovi:Array;
	var importeMovi:Number;
	var codCausa:String;
	var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
	while (qryMovimientos.next()) {
		importeMovi = parseFloat(qryMovimientos.value("SUM(cantidad)"));
		if (!importeMovi || isNaN(importeMovi) || importeMovi == 0)
			continue;
	
		codCausa = qryMovimientos.value("codcausa");
		if (!codCausa || codCausa == "") {
			MessageBox.warning(util.translate("scripts", "No es posible generar el asiento contable asociado al arqueo por la siguiente razón:\nHay al menos un movimiento de caja que no tiene establecida una causa.\nVerifique que todos los movimientos tienen asociada una causa y que ésta tiene asociada una cuenta contable"), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
		ctaMovi = this.iface.subcuentaCausa(codCausa, valoresDefecto.codejercicio);
		if (ctaMovi.error != 0)
			return false;

		if (importeMovi > 0) {
			debe = 0;
			haber = importeMovi;
		} else {
			importeMovi = importeMovi * -1;
			debe = importeMovi;
			haber = 0;
		}
		debe = util.roundFieldValue(debe, "co_partidas", "debe");
		haber = util.roundFieldValue(haber, "co_partidas", "haber");
		
		with (curPartida) {
			setModeAccess(curPartida.Insert);
			refreshBuffer();
			setValueBuffer("idsubcuenta", ctaMovi.idsubcuenta);
			setValueBuffer("codsubcuenta", ctaMovi.codsubcuenta);
			setValueBuffer("idasiento", idAsiento);
			setValueBuffer("debe", debe);
			setValueBuffer("haber", haber);
			setValueBuffer("coddivisa", valoresDefecto.coddivisa);
			setValueBuffer("tasaconv", 1);
			setValueBuffer("debeME", 0);
			setValueBuffer("haberME", 0);
		}

		curPartida.setValueBuffer("concepto", this.iface.conceptoPartida(curArqueo, util.translate("scripts", "Movimientos efectivo")));

		if (!curPartida.commitBuffer())
			return false;
	}
	
	with (curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("idsubcuenta", ctaCaja.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaCaja.codsubcuenta);
		setValueBuffer("idasiento", idAsiento);
		setValueBuffer("debe", debeCaja);
		setValueBuffer("haber", haberCaja);
		setValueBuffer("coddivisa", valoresDefecto.coddivisa);
		setValueBuffer("tasaconv", 1);
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", 0);
	}

	curPartida.setValueBuffer("concepto", this.iface.conceptoPartida(curArqueo, util.translate("scripts", "Movimientos efectivo")));

	if (!curPartida.commitBuffer())
		return false;

	return true;
}

/** \D Genera la parte del asiento de arqueo correspondiente al movimiento de ciere de caja
@param	curArqueo: Cursor del arqueo
@param	idAsiento: Id del asiento asociado
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return	VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasMoviCierre(curArqueo:FLSqlCursor, idAsiento:Number, valoresDefecto:Array):Boolean
{
	var util:FLUtil = new FLUtil();

	var debe:Number = 0;
	var debeCaja:Number = 0;
	var haber:Number = 0;
	var haberCaja:Number = 0;
	var totalMovi:Number = parseFloat(curArqueo.valueBuffer("sacadodecaja"));
	if (totalMovi == 0) {
		return true;
	}

	if (totalMovi > 0 ) {
		debe = totalMovi;
		haber = 0;
		debeCaja = 0;
		haberCaja = totalMovi;
	} else {
		totalMovi = totalMovi * -1;
		debe = 0;
		haber = totalMovi;
		debeCaja = totalMovi;
		haberCaja = 0;
	}
	debe = util.roundFieldValue(debe, "co_partidas", "debe");
	haber = util.roundFieldValue(haber, "co_partidas", "haber");
	debeCaja = util.roundFieldValue(debeCaja, "co_partidas", "debe");
	haberCaja = util.roundFieldValue(haberCaja, "co_partidas", "haber");
		
	var codPagoEfectivo:String = util.sqlSelect("tpv_datosgenerales", "pagoefectivo", "1 = 1");
	
	var ctaCaja:Array = this.iface.subcuentaDefecto("CAJA", valoresDefecto.codejercicio);
	if (ctaCaja.error != 0)
		return false;

	var codCausa:String = util.sqlSelect("tpv_datosgenerales", "codcausacierre", "1 = 1");
	if (!codCausa || codCausa == "") {
		MessageBox.warning(util.translate("scripts", "No es posible generar el asiento contable asociado al arqueo por la siguiente razón:\nNo tiene establecida la causa asociada al movimiento de cierre.\nAsocie la causa en el formulario de datos genrales y verifique que ésta tiene asociada una cuenta contable"), MessageBox.Ok, MessageBox.NoButton);
			return false;
	}
	var ctaMovi:Array = this.iface.subcuentaCausa(codCausa, valoresDefecto.codejercicio);
	if (ctaMovi.error != 0)
		return false;

	var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
	
	with (curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("idsubcuenta", ctaMovi.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaMovi.codsubcuenta);
		setValueBuffer("idasiento", idAsiento);
		setValueBuffer("debe", debe);
		setValueBuffer("haber", haber);
		setValueBuffer("coddivisa", valoresDefecto.coddivisa);
		setValueBuffer("tasaconv", 1);
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", 0);
	}

	curPartida.setValueBuffer("concepto", this.iface.conceptoPartida(curArqueo, util.translate("scripts", "Movimiento de cierre")));

	if (!curPartida.commitBuffer())
		return false;
	
	with (curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("idsubcuenta", ctaCaja.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaCaja.codsubcuenta);
		setValueBuffer("idasiento", idAsiento);
		setValueBuffer("debe", debeCaja);
		setValueBuffer("haber", haberCaja);
		setValueBuffer("coddivisa", valoresDefecto.coddivisa);
		setValueBuffer("tasaconv", 1);
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", 0);
	}

	curPartida.setValueBuffer("concepto", this.iface.conceptoPartida(curArqueo, util.translate("scripts", "Movimiento de cierre")));

	if (!curPartida.commitBuffer())
		return false;

	return true;
}

/** \D Genera la parte del asiento de arqueo correspondiente a las diferencias de efectivo detectadas al hacer el arqueo
@param	curArqueo: Cursor del arqueo
@param	idAsiento: Id del asiento asociado
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return	VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasDif(curArqueo:FLSqlCursor, idAsiento:Number, valoresDefecto:Array):Boolean
{
	var util:FLUtil = new FLUtil();

	var debe:Number = 0;
	var debeCaja:Number = 0;
	var haber:Number = 0;
	var haberCaja:Number = 0;
	var difEfectivo:Number = formRecordtpv_arqueos.iface.pub_commonCalculateField("diferenciaEfectivo", curArqueo);
	difEfectivo = parseFloat(difEfectivo);
	if (difEfectivo == 0)
		return true;

	var codPagoEfectivo:String = util.sqlSelect("tpv_datosgenerales", "pagoefectivo", "1 = 1");
	
	var ctaCaja:Array = this.iface.subcuentaDefecto("CAJA", valoresDefecto.codejercicio);
	if (ctaCaja.error != 0)
		return false;

	var ctaDif:Array;
	if (difEfectivo > 0) {
		haber = difEfectivo;
		debeCaja = difEfectivo;
		ctaDif = this.iface.subcuentaDefecto("DIFPOS", valoresDefecto.codejercicio);
		if (ctaDif.error != 0)
			return false;
	} else {
		difEfectivo = difEfectivo * -1;
		debe = difEfectivo;
		haberCaja = difEfectivo;
		ctaDif = this.iface.subcuentaDefecto("DIFNEG", valoresDefecto.codejercicio);
		if (ctaDif.error != 0)
			return false;
	}
	debe = util.roundFieldValue(debe, "co_partidas", "debe");
	haber = util.roundFieldValue(haber, "co_partidas", "haber");
	debeCaja = util.roundFieldValue(debeCaja, "co_partidas", "debe");
	haberCaja = util.roundFieldValue(haberCaja, "co_partidas", "haber");
		
	var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
	with (curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("idsubcuenta", ctaDif.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaDif.codsubcuenta);
		setValueBuffer("idasiento", idAsiento);
		setValueBuffer("debe", debe);
		setValueBuffer("haber", haber);
		setValueBuffer("coddivisa", valoresDefecto.coddivisa);
		setValueBuffer("tasaconv", 1);
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", 0);
	}

	curPartida.setValueBuffer("concepto", this.iface.conceptoPartida(curArqueo, util.translate("scripts", "Diferencias efectivo")));

	if (!curPartida.commitBuffer())
		return false;

	with (curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("idsubcuenta", ctaCaja.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaCaja.codsubcuenta);
		setValueBuffer("idasiento", idAsiento);
		setValueBuffer("debe", debeCaja);
		setValueBuffer("haber", haberCaja);
		setValueBuffer("coddivisa", valoresDefecto.coddivisa);
		setValueBuffer("tasaconv", 1);
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", 0);
	}

	curPartida.setValueBuffer("concepto", this.iface.conceptoPartida(curArqueo, util.translate("scripts", "Diferencias efectivo")));

	if (!curPartida.commitBuffer())
		return false;

	return true;
}

/** \D Establece los datos opcionales de una partida de asientos de arqueo
Para facilitar personalizaciones en las partidas.
Se ponen datos de concepto, tipo de documento, documento y factura
@param	curPartida: Cursor sobre la partida
@param	curArqueo: Cursor sobre el arqueo
@param	masConcepto: Concepto, opcional
*/
function oficial_conceptoPartida(curArqueo:FLSqlCursor, masConcepto:String):String
{
	var util:FLUtil = new FLUtil();
	var concepto:String = util.translate("scripts", "Arqueo de caja ") + curArqueo.valueBuffer("idtpv_arqueo");
	if (masConcepto)
		concepto += " " + masConcepto;
	
	return concepto;
}

function oficial_subcuentaCausa(codCausa:String, codEjercicio:String):Array
{
	var util:FLUtil = new FLUtil();
	var datos:Array = [];
	datos["error"] = 1;
	
	var q:FLSqlQuery = new FLSqlQuery();
	
	var codSubcuenta:String = util.sqlSelect("tpv_causasmovimiento", "codsubcuenta", "codcausa = '" + codCausa + "'");
	if (!codSubcuenta) {
		MessageBox.warning(util.translate("scripts", "No tiene especificada la subcuenta asociada a la causa de movimiento de caja %1.\nDebe editar la causa y asociar la correspondiente subcuenta contable").arg(codCausa), MessageBox.Ok, MessageBox.NoButton);
		return datos;
	}

	with(q) {
		setTablesList("co_subcuentas");
		setSelect("s.idsubcuenta, s.codsubcuenta");
		setFrom("co_subcuentas s");
		setWhere("s.codsubcuenta = '" + codSubcuenta + "' AND s.codejercicio = '" + codEjercicio + "'");
		setForwardOnly( true );
	}
	if (!q.exec()) {
		datos["error"] = 2;
		return datos;
	}
	if (q.first()) {
		datos["error"] = 0;
		datos["idsubcuenta"] = q.value(0);
		datos["codsubcuenta"] = q.value(1);
		return datos;
	}
	
	return datos;
}

function oficial_subcuentaDefecto(nombre:String, codEjercicio:String):Array
{
	var util:FLUtil = new FLUtil();
	var datos:Array = [];
	datos["error"] = 1;
	
	var q:FLSqlQuery = new FLSqlQuery();
	
	var codSubcuenta:String;
	switch (nombre) {
		case "VENTAS": {
			codSubcuenta = util.sqlSelect("tpv_datosgenerales", "codsubcuentaven", "1 = 1");
			if (!codSubcuenta) {
				MessageBox.warning(util.translate("scripts", "No tiene especificada la subcuenta de ventas a utilizar en el asiento de arqueo.\nDebe especificar dicha subcuenta en el formulario de datos generales del módulo de TPV"), MessageBox.Ok, MessageBox.NoButton);
				return datos;
			}
			break;
		}
		case "CAJA": {
			codSubcuenta = util.sqlSelect("tpv_datosgenerales", "codsubcuentacaja", "1 = 1");
			if (!codSubcuenta) {
				MessageBox.warning(util.translate("scripts", "No tiene especificada la subcuenta de caja a utilizar en el asiento de arqueo.\nDebe especificar dicha subcuenta en el formulario de datos generales del módulo de TPV"), MessageBox.Ok, MessageBox.NoButton);
				return datos;
			}
			break;
		}
		case "TARJETA": {
			codSubcuenta = util.sqlSelect("tpv_datosgenerales", "codsubcuentatar", "1 = 1");
			if (!codSubcuenta) {
				MessageBox.warning(util.translate("scripts", "No tiene especificada la subcuenta de pago con tarjeta ventas a utilizar en el asiento de arqueo.\nDebe especificar dicha subcuenta en el formulario de datos generales del módulo de TPV"), MessageBox.Ok, MessageBox.NoButton);
				return datos;
			}
			break;
		}
		case "VALE": {
			codSubcuenta = util.sqlSelect("tpv_datosgenerales", "codsubcuentavale", "1 = 1");
			if (!codSubcuenta) {
				MessageBox.warning(util.translate("scripts", "No tiene especificada la subcuenta de pago con vale ventas a utilizar en el asiento de arqueo.\nDebe especificar dicha subcuenta en el formulario de datos generales del módulo de TPV"), MessageBox.Ok, MessageBox.NoButton);
				return datos;
			}
			break;
		}
		case "DIFPOS": {
			codSubcuenta = util.sqlSelect("tpv_datosgenerales", "codsubcuentadifpos", "1 = 1");
			if (!codSubcuenta) {
				MessageBox.warning(util.translate("scripts", "No tiene especificada la subcuenta de diferencias positivas de cambio a utilizar en el asiento de arqueo.\nDebe especificar dicha subcuenta en el formulario de datos generales del módulo de TPV"), MessageBox.Ok, MessageBox.NoButton);
				return datos;
			}
			break;
		}
		case "DIFNEG": {
			codSubcuenta = util.sqlSelect("tpv_datosgenerales", "codsubcuentadifneg", "1 = 1");
			if (!codSubcuenta) {
				MessageBox.warning(util.translate("scripts", "No tiene especificada la subcuenta de diferencias negativas de cambio a utilizar en el asiento de arqueo.\nDebe especificar dicha subcuenta en el formulario de datos generales del módulo de TPV"), MessageBox.Ok, MessageBox.NoButton);
				return datos;
			}
			break;
		}
	}

	with(q) {
		setTablesList("co_subcuentas");
		setSelect("s.idsubcuenta, s.codsubcuenta");
		setFrom("co_subcuentas s");
		setWhere("s.codsubcuenta = '" + codSubcuenta + "' AND s.codejercicio = '" + codEjercicio + "'");
		setForwardOnly( true );
	}
	if (!q.exec()) {
		datos["error"] = 2;
		return datos;
	}
	if (!q.first()) {
		MessageBox.warning(util.translate("scripts", "No se ha encontrado la subcuenta %1 configurada como subcuenta %2 en los parámetros generales del TPV\npara el ejercicio %3").arg(codSubcuenta).arg(nombre).arg(codEjercicio), MessageBox.Ok, MessageBox.NoButton);
		return datos;
	}
	
	datos["error"] = 0;
	datos["idsubcuenta"] = q.value(0);
	datos["codsubcuenta"] = q.value(1);
	
	return datos;
}

function oficial_obtenerCodigoComanda(curComanda:FLSqlCursor):String
{
	var util:FLUtil = new FLUtil();

	var prefijo:String = util.sqlSelect("tpv_puntosventa", "prefijo", "codtpv_puntoventa = '" + curComanda.valueBuffer("codtpv_puntoventa") + "'");
	if (!prefijo)
		prefijo = curComanda.valueBuffer("codtpv_puntoventa");

	var ultimoTiquet:Number = util.sqlSelect("tpv_secuenciascomanda", "valor", "prefijo = '" + prefijo + "'");

	if (!ultimoTiquet) {
		var idUltimo:String = util.sqlSelect("tpv_comandas", "codigo", "codigo LIKE '" + prefijo + "%' ORDER BY codigo DESC");

		if (!idUltimo) {
			ultimoTiquet = 0;
		} else {
			ultimoTiquet = parseFloat(idUltimo);
		}

		var pass:String = util.readSettingEntry( "DBA/password");
		var port:String = util.readSettingEntry( "DBA/port");
		if (!sys.addDatabase(sys.nameDriver(), sys.nameBD(), sys.nameUser(), pass, sys.nameHost(), port, "conAux")) {
			MessageBox.warning(util.translate("scripts", "Ha habido un error al establecer una conexión auxiliar con la base de datos %1").arg(sys.nameBD()), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
		ultimoTiquet += 1;
		var curSecuencia:FLSqlCursor = new FLSqlCursor("tpv_secuenciascomanda", "conAux");
		curSecuencia.setModeAccess(curSecuencia.Insert);
		curSecuencia.refreshBuffer();
		curSecuencia.setValueBuffer("prefijo", prefijo);
		curSecuencia.setValueBuffer("valor", ultimoTiquet);
		if (!curSecuencia.commitBuffer()) {
			return false;
		}
	}
	else {
		ultimoTiquet += 1;
		util.sqlUpdate("tpv_secuenciascomanda", "valor", ultimoTiquet, "prefijo = '" + prefijo + "'");
	}

	var codigo:String = prefijo + flfacturac.iface.pub_cerosIzquierda(ultimoTiquet, 16 - prefijo.length);

	return codigo;
}

function oficial_obtenerCodigoArqueo(curArqueo:FLSqlCursor):String
{
	var util:FLUtil = new FLUtil();

	var prefijo:String = util.sqlSelect("tpv_puntosventa", "prefijo", "codtpv_puntoventa = '" + curArqueo.valueBuffer("ptoventa") + "'");
	if (!prefijo)
		prefijo = curArqueo.valueBuffer("ptoventa");

	var ultimoNumero:Number;
	var idUltimo:String = util.sqlSelect("tpv_arqueos", "idtpv_arqueo", "idtpv_arqueo LIKE '" + prefijo + "%' ORDER BY idtpv_arqueo DESC");

	if (!idUltimo) {
		ultimoNumero = 0;
	} else {
		ultimoNumero = parseFloat(idUltimo.right(6));
	}

	ultimoNumero += 1;

	var codigo:String = prefijo + flfacturac.iface.pub_cerosIzquierda(ultimoNumero, 16 - prefijo.length);

	return codigo;
}

function oficial_valorDefectoTPV(campo:String):String
{
	var util:FLUtil = new FLUtil;
	var valor:String = util.sqlSelect("tpv_datosgenerales", campo, "1 = 1");
	return valor;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
  
/** @class_definition funNumSerie */
/////////////////////////////////////////////////////////////////
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////
/** \D Copia los datos de una línea de venta en una línea de factura
@param	curLineaComanda: Cursor que contiene los datos a incluir en la línea de factura
@return	True si la copia se realiza correctamente, false en caso contrario
\end */
function funNumSerie_datosLineaFactura(curLineaComanda:FLSqlCursor):Boolean
{
	if(!this.iface.__datosLineaFactura(curLineaComanda))
		return false;

	with (this.iface.curLineaFactura) {
		setValueBuffer("numserie", curLineaComanda.valueBuffer("numserie"));
	}
	return true;
}
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition tpvNsAcomp */
/////////////////////////////////////////////////////////////////
//// TPV_NS_ACOMP /////////////////////////////////////////////////

/** \D Actualiza el id de venta de venta para un número de serie.
*/
function tpvNsAcomp_afterCommit_tpv_lineascomandans(curL:FLSqlCursor):Boolean
{
	if (!curL.valueBuffer("numserie")) return true;
	
	var util:FLUtil = new FLUtil();
	
	var curNS:FLSqlCursor = new FLSqlCursor("numerosserie");
	var idComanda = util.sqlSelect("tpv_lineascomanda", "idtpv_comanda", "idtpv_linea = " + curL.valueBuffer("idlineacomanda"));
	
	switch(curL.modeAccess()) {
		
		case curL.Edit: 
			// Control cuando cambia un número por otro, se libera el primero
			if (curL.valueBuffer("numserie") != curL.valueBufferCopy("numserie")) {
				curNS.select("referencia = '" + curL.valueBuffer("referencia") + "' AND numserie = '" + curL.valueBufferCopy("numserie") + "'");
				if (curNS.first()) {
					curNS.setModeAccess(curNS.Edit);
					curNS.refreshBuffer();
					curNS.setValueBuffer("idcomandaventa", -1)
					curNS.setValueBuffer("vendido", "false")
					if (!curNS.commitBuffer()) return false;
				}
			}
		
		case curL.Insert:
			curNS.select("referencia = '" + curL.valueBuffer("referencia") + "' AND numserie = '" + curL.valueBuffer("numserie") + "'");
			if (curNS.first()) {
				curNS.setModeAccess(curNS.Edit);
				curNS.refreshBuffer();
				curNS.setValueBuffer("idcomandaventa", idComanda)
				curNS.setValueBuffer("vendido", "true")
				if (!curNS.commitBuffer()) return false;
			}
			
			
		break;
		
		case curL.Del:
			curNS.select("referencia = '" + curL.valueBuffer("referencia") + "' AND numserie = '" + curL.valueBuffer("numserie") + "'");
			if (curNS.first()) {
				curNS.setModeAccess(curNS.Edit);
				curNS.refreshBuffer();
				curNS.setValueBuffer("idcomandaventa", -1)
				curNS.setValueBuffer("vendido", "false")
				if (!curNS.commitBuffer()) return false;
			}
			break;
	}
	return true;
}


function tpvNsAcomp_copiarLinea(idFactura:Number,curLineaComanda:FLSqlCursor):Boolean 
{
	var idLinea = this.iface.__copiarLinea(idFactura, curLineaComanda);
	if(!idLinea)
		return false;
	
	var util:FLUtil = new FLUtil;
	
	var curLNA:FLSqlCursor = new FLSqlCursor("tpv_lineascomandans");
	var curLNF:FLSqlCursor = new FLSqlCursor("lineasfacturasclins");
	
	curLNA.select("idlineacomanda = " + curLineaComanda.valueBuffer("idtpv_linea"));
	while(curLNA.next()) {
		
		if (!curLNA.valueBuffer("numserie")) {
			MessageBox.warning(util.translate("scripts", "No es posible generar la factura.\n\nLa venta tiene componentes de artículos compuestos\ncuyo número de serie no se ha establecido"), MessageBox.Ok, MessageBox.NoButton);
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


//// TPV_NS_ACOMP /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ivaIncluido */
//////////////////////////////////////////////////////////////////
//// IVA INCLUIDO ////////////////////////////////////////////////
/** \D Copia campo a campo los datos de IVA incluido de una linea de la venta en una línea de la factura
@param curLineaComanda cursor de las lineas de la venta
@return Boolean, true si la linea se ha copiado correctamente y false si ha habido algún errror
*/
function ivaIncluido_datosLineaFactura(curLineaComanda:FLSqlCursor):Boolean
{
	if (!this.iface.__datosLineaFactura(curLineaComanda))
		return false;

	with (this.iface.curLineaFactura) {
		setValueBuffer("ivaincluido", curLineaComanda.valueBuffer("ivaincluido"));
		setValueBuffer("pvpunitarioiva", curLineaComanda.valueBuffer("pvpunitarioiva"));
	}
	return true;
}
//// IVA INCLUIDO ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition numeroSecuencia */
//////////////////////////////////////////////////////////////////
//// NUMERO SECUENCIA ////////////////////////////////////////////

function numeroSecuencia_datosFactura(curComanda:FLSqlCursor):Boolean
{
	if (!this.iface.__datosFactura(curComanda))
		return false;

	with (this.iface.curFactura) {
		setValueBuffer("tipoventa", curComanda.valueBuffer("tipoventa"));
		setValueBuffer("claseventa", curComanda.valueBuffer("claseventa"));
		setValueBuffer("codserie", curComanda.valueBuffer("codserie"));
		setValueBuffer("numero", curComanda.valueBuffer("numerosecuencia"));
		setValueBuffer("codigo", formfacturascli.iface.pub_commonCalculateField("codigo", this));
	}
	return true;
}

//// NUMERO SECUENCIA ////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition ganancias */
/////////////////////////////////////////////////////////////////
//// GANANCIAS //////////////////////////////////////////////////

function ganancias_beforeCommit_tpv_comandas(curComanda:FLSqlCursor):Boolean
{

/*	Esto es copia de interna_beforeCommit_tpv_comandas
	porque el cálculo de ganancias va después de ese control
	pero antes de la sincronización.
	No se hace referencia a la función anterior
 */

	var util:FLUtil = new FLUtil();
	var codComanda:String = curComanda.valueBuffer("codigo");	
	var idTpvComanda:String = curComanda.valueBuffer("idtpv_comanda");	


	switch (curComanda.modeAccess()) {
		case curComanda.Insert: {
			if (curComanda.valueBuffer("codigo") == "0") {
				curComanda.setValueBuffer("codigo", this.iface.obtenerCodigoComanda(curComanda));
			}
			if (curComanda.valueBuffer("codigo") == "" || curComanda.valueBuffer("codigo") == "0") {
				MessageBox.warning(util.translate("scripts", "El código de la venta no puede estar vacío"), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}

			if (curComanda.modeAccess() == curComanda.Insert) {
				if (util.sqlSelect("tpv_comandas", "idtpv_comanda", "codigo = '" + codComanda + "' AND idtpv_comanda != " + idTpvComanda)) {
					var res:Number = MessageBox.information(util.translate("scripts", "Ya existe una venta con este código.\n¿Desea continuar?"), MessageBox.Yes, MessageBox.No);
					if (res != MessageBox.Yes) {
						return false;
					}
				}
			}
			break;
		}
	}

	if (!curComanda.valueBuffer("idtpv_arqueo")) {
		var qryarqueos:FLSqlQuery = new FLSqlQuery();
		qryarqueos.setTablesList("tpv_arqueos");
		qryarqueos.setSelect("idtpv_arqueo");
		qryarqueos.setFrom("tpv_arqueos");
		qryarqueos.setWhere("ptoventa = '" + curComanda.valueBuffer("codtpv_puntoventa") + "' AND abierta = true AND diadesde <= '" + curComanda.valueBuffer("fecha") + "'");
		if (!qryarqueos.exec())
			return;
		/** \C
		Comprueba que existe un arqueo abierto que corresponda con los datos de la comanda antes de crear una nueva.
		*/
		if (!qryarqueos.first()){
			MessageBox.warning(util.translate("scripts", "No existe ningún arqueo abierto para este punto de venta y esta fecha.\nAntes de crear una venta debe crear el aqueo."),MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
		if (qryarqueos.size() > 1){
		/** \C
		No se puede crear una comanda si existen más de un arqueo a los que pueda pertenecer
		*/
			MessageBox.warning(util.translate("scripts", "Existe mas de un arqueo abierto para este punto de venta y esta fecha."),MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
		curComanda.setValueBuffer("idtpv_arqueo", qryarqueos.value(0));
	}

	flfacturac.iface.pub_obtenerGanancia(curComanda, "tpv_comanda");

	if (!this.iface.comprobarSincronizacion(curComanda)) {
		return false;
	}

	return true;
}

function ganancias_beforeCommit_tpv_lineascomanda(curLinea:FLSqlCursor):Boolean
{
	if ( curLinea.modeAccess() == curLinea.Insert || curLinea.modeAccess() == curLinea.Edit )
		return flfacturac.iface.pub_obtenerGananciaLinea(curLinea, "tpv_comandas");
	else
		return true;
}

function ganancias_datosLineaFactura(curLineaComanda:FLSqlCursor):Boolean
{
	if (!this.iface.__datosLineaFactura(curLineaComanda))
		return false;

	with (this.iface.curLineaFactura) {
		setValueBuffer("totalconiva", curLineaComanda.valueBuffer("totalconiva"));
		setValueBuffer("costounitario", curLineaComanda.valueBuffer("costounitario"));
		setValueBuffer("costototal", curLineaComanda.valueBuffer("costototal"));
		setValueBuffer("ganancia", curLineaComanda.valueBuffer("ganancia"));
		setValueBuffer("utilidad", curLineaComanda.valueBuffer("utilidad"));
	}
	return true;
}

function ganancias_datosFactura(curComanda:FLSqlCursor):Boolean
{
	if (!this.iface.__datosFactura(curComanda))
		return false;

	with (this.iface.curFactura) {
		setValueBuffer("costototal", curComanda.valueBuffer("costototal"));
		setValueBuffer("ganancia", curComanda.valueBuffer("ganancia"));
		setValueBuffer("utilidad", curComanda.valueBuffer("utilidad"));
	}
	return true;
}

//// GANANCIAS //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition controlUsuario */
/////////////////////////////////////////////////////////////////
//// CONTROL_USUARIO ////////////////////////////////////////////

function controlUsuario_beforeCommit_tpv_arqueos(curArqueo:FLSqlCursor):Boolean
{
	switch (curArqueo.modeAccess()) {
		case curArqueo.Insert: {
			if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
				flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Arqueos");
				return false;
			} else {
				curArqueo.setValueBuffer( "idusuario", sys.nameUser() );
			}
			break;
		}
		break;
	}

	return this.iface.__beforeCommit_tpv_arqueos(curArqueo);
}
//// CONTROL_USUARIO //////////////////////////////////////////
///////////////////////////////////////////////////////////////

/** @class_definition tipoVenta */
/////////////////////////////////////////////////////////////////
//// TIPO DE VENTA //////////////////////////////////////////////

function tipoVenta_sincronizarConFacturacion(curComanda:FLSqlCursor):Boolean
{
	var util:FLUtil;

	switch (curComanda.modeAccess()) {
		case curComanda.Insert: {
			var idDocumento:String;
			switch (curComanda.valueBuffer("tipoventa")) {
				case "Presupuesto": {
					idDocumento = this.iface.crearPresupuesto(curComanda);
					break;
				}
				case "Pedido": {
					idDocumento = this.iface.crearPedido(curComanda);
					break;
				}
				case "Remito": {
					idDocumento = this.iface.crearRemito(curComanda);
					break;
				}
				default: {
					idDocumento = this.iface.crearFactura(curComanda);
					break;
				}
			}
			if (!idDocumento)
				return false;
			curComanda.setValueBuffer("iddocumento", idDocumento);

			// para que actualice el número del documento
			switch (curComanda.valueBuffer("tipoventa")) {
				case "Presupuesto": {
					var curPresupuesto:FLSqlCursor = new FLSqlCursor("presupuestoscli");
					curPresupuesto.select("idpresupuesto = " + idDocumento);
					if (!curPresupuesto.first())
						return false;
					curComanda.setValueBuffer("numerosecuencia", curPresupuesto.valueBuffer("numero"));
					break;
				}
				case "Pedido": {
					var curPedido:FLSqlCursor = new FLSqlCursor("pedidoscli");
					curPedido.select("idpedido = " + idDocumento);
					if (!curPedido.first())
						return false;
					curComanda.setValueBuffer("numerosecuencia", curPedido.valueBuffer("numero"));
					break;
				}
				case "Remito": {
					var curAlbaran:FLSqlCursor = new FLSqlCursor("albaranescli");
					curAlbaran.select("idalbaran = " + idDocumento);
					if (!curAlbaran.first())
						return false;
					curComanda.setValueBuffer("numerosecuencia", curAlbaran.valueBuffer("numero"));
					break;
				}
				default: {
					var curFactura:FLSqlCursor = new FLSqlCursor("facturascli");
					curFactura.select("idfactura = " + idDocumento);
					if (!curFactura.first())
						return false;
					curComanda.setValueBuffer("numerosecuencia", curFactura.valueBuffer("numero"));
					break;
				}
			}
			break;
		}
		case curComanda.Edit: {
			if (curComanda.valueBuffer("idtpv_comanda_factura") != 0)
				return true;

			var idDocumento:String = curComanda.valueBuffer("iddocumento");
			switch (curComanda.valueBuffer("tipoventa")) {
				case "Presupuesto": {
					if (!this.iface.borrarPresupuesto(idDocumento))
						return false;
					idDocumento = this.iface.crearPresupuesto(curComanda);
					if (!idDocumento)
						return false;
					break;
				}
				case "Pedido": {
					if (!this.iface.borrarPedido(idDocumento))
						return false;
					idDocumento = this.iface.crearPedido(curComanda);
					if (!idDocumento)
						return false;
					break;
				}
				case "Remito": {
					if (!this.iface.borrarRemito(idDocumento))
						return false;
					idDocumento = this.iface.crearRemito(curComanda);
					if (!idDocumento)
						return false;
					break;
				}
				default: {
					if (!this.iface.borrarFactura(idDocumento))
						return false;
					idDocumento = this.iface.crearFactura(curComanda);
					if (!idDocumento)
						return false;
					break;
				}
			}
			curComanda.setValueBuffer("iddocumento", idDocumento);

			// para que actualice el número del documento
			switch (curComanda.valueBuffer("tipoventa")) {
				case "Presupuesto": {
					var curPresupuesto:FLSqlCursor = new FLSqlCursor("presupuestoscli");
					curPresupuesto.select("idpresupuesto = " + idDocumento);
					if (!curPresupuesto.first())
						return false;
					curComanda.setValueBuffer("numerosecuencia", curPresupuesto.valueBuffer("numero"));
					break;
				}
				case "Pedido": {
					var curPedido:FLSqlCursor = new FLSqlCursor("pedidoscli");
					curPedido.select("idpedido = " + idDocumento);
					if (!curPedido.first())
						return false;
					curComanda.setValueBuffer("numerosecuencia", curPedido.valueBuffer("numero"));
					break;
				}
				case "Remito": {
					var curAlbaran:FLSqlCursor = new FLSqlCursor("albaranescli");
					curAlbaran.select("idalbaran = " + idDocumento);
					if (!curAlbaran.first())
						return false;
					curComanda.setValueBuffer("numerosecuencia", curAlbaran.valueBuffer("numero"));
					break;
				}
				default: {
					var curFactura:FLSqlCursor = new FLSqlCursor("facturascli");
					curFactura.select("idfactura = " + idDocumento);
					if (!curFactura.first())
						return false;
					curComanda.setValueBuffer("numerosecuencia", curFactura.valueBuffer("numero"));

					if (!this.iface.generarRecibos(curComanda))
						return false;

					break;
				}
			}
			break;
		}
		case curComanda.Del: {
			var idDocumento:String = curComanda.valueBuffer("iddocumento");
			switch (curComanda.valueBuffer("tipoventa")) {
				case "Presupuesto": {
					if (!this.iface.borrarPresupuesto(idDocumento))
						return false;
					break;
				}
				case "Pedido": {
					if (!this.iface.borrarPedido(idDocumento))
						return false;
					break;
				}
				case "Remito": {
					if (!this.iface.borrarRemito(idDocumento))
						return false;
					break;
				}
				default: {
					if (!util.sqlDelete("tpv_pagoscomanda", "idtpv_comanda = " + curComanda.valueBuffer("idtpv_comanda")))
						return false;
					if (!util.sqlDelete("tpv_pagoscomanda", "idtpv_comanda = " + curComanda.valueBuffer("idtpv_comanda")))
						return false;
					if (!this.iface.borrarFactura(idDocumento))
						return false;
					break;
				}
			}
			break;
		}
	}
	return true;
}

function tipoVenta_datosLineaFactura(curLineaComanda:FLSqlCursor):Boolean
{
	if (!this.iface.__datosLineaFactura(curLineaComanda))
		return false;

	var util:FLUtil;
	var idAlbaran:Number = util.sqlSelect("albaranescli", "idalbaran", "idtpv_comanda = " + curLineaComanda.valueBuffer("idtpv_comanda_albaran"));
	if (!idAlbaran)
		idAlbaran = 0;
	var idLineaAlbaran:Number = util.sqlSelect("lineasalbaranescli", "idlinea", "idalbaran = " + idAlbaran + " AND referencia = '" + curLineaComanda.valueBuffer("referencia") + "'");
	if (!idLineaAlbaran)
		idLineaAlbaran = 0;
	with (this.iface.curLineaFactura) {
		setValueBuffer("idalbaran", idAlbaran);
		setValueBuffer("idlineaalbaran", idLineaAlbaran);
	}

	return true;
}

function tipoVenta_datosFactura(curComanda:FLSqlCursor):Boolean
{
	if (!this.iface.__datosFactura(curComanda))
		return false;

	with (this.iface.curFactura) {
		setValueBuffer("automatica", curComanda.valueBuffer("automatica"));
		setValueBuffer("idtpv_comanda", curComanda.valueBuffer("idtpv_comanda"));
		setValueBuffer("impresofiscal", curComanda.valueBuffer("impresofiscal"));
	}
	return true;
}

//// Remitos ////

function tipoVenta_crearRemito(curComanda:FLSqlCursor):Number
{
	var util:FLUtil = new FLUtil();
	var idAlbaran:Number;

	if (!this.iface.curRemito)
		this.iface.curRemito = new FLSqlCursor("albaranescli");

	this.iface.curRemito.setModeAccess(this.iface.curRemito.Insert);
	this.iface.curRemito.refreshBuffer();

	if (!this.iface.datosRemito(curComanda))
		return false;

	if (!this.iface.curRemito.commitBuffer())
		return false;

	idAlbaran = this.iface.curRemito.valueBuffer("idalbaran");
	if (!this.iface.copiarLineasRemito(curComanda.valueBuffer("idtpv_comanda"), idAlbaran))
		return false;

	this.iface.curRemito.select("idalbaran = " + idAlbaran);
	if (!this.iface.curRemito.first())
		return false;

	this.iface.curRemito.setModeAccess(this.iface.curRemito.Edit);
	this.iface.curRemito.refreshBuffer();

	if (!this.iface.totalesRemito())
		return false;

	if (!this.iface.curRemito.commitBuffer())
		return false;

	return idAlbaran;
}

function tipoVenta_borrarRemito(idAlbaran:String):Boolean
{
	var util:FLUtil = new FLUtil;

	if (!util.sqlDelete("albaranescli", "idalbaran = " + idAlbaran))
		return false;

	return true;
}

function tipoVenta_copiarLineasRemito(idComanda:Number, idAlbaran:Number):Boolean 
{
	var curLineaComanda:FLSqlCursor = new FLSqlCursor("tpv_lineascomanda");
	curLineaComanda.select("idtpv_comanda = " + idComanda);
	while (curLineaComanda.next()) {
		if(!this.iface.copiarLineaRemito(idAlbaran,curLineaComanda))
			return false;
	}
	return true;
}

function tipoVenta_copiarLineaRemito(idAlbaran:Number,curLineaComanda:FLSqlCursor):Boolean
{
	if (!this.iface.curLineaRemito)
		this.iface.curLineaRemito = new FLSqlCursor("lineasalbaranescli");
	
	with (this.iface.curLineaRemito) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idalbaran", idAlbaran);
	}
	
	if (!this.iface.datosLineaRemito(curLineaComanda))
		return false;
		
	if (!this.iface.curLineaRemito.commitBuffer())
		return false;
	
	return this.iface.curLineaRemito.valueBuffer("idlinea");
}

function tipoVenta_datosLineaRemito(curLineaComanda:FLSqlCursor):Boolean
{
	with (this.iface.curLineaRemito) {
		setValueBuffer("referencia", curLineaComanda.valueBuffer("referencia"));
		setValueBuffer("descripcion", curLineaComanda.valueBuffer("descripcion"));
		setValueBuffer("pvpunitario", curLineaComanda.valueBuffer("pvpunitario"));
		setValueBuffer("cantidad", curLineaComanda.valueBuffer("cantidad"));
		setValueBuffer("pvpsindto", curLineaComanda.valueBuffer("pvpsindto"));
		setValueBuffer("pvptotal", curLineaComanda.valueBuffer("pvptotal"));
		setValueBuffer("totalconiva", curLineaComanda.valueBuffer("totalconiva"));
		setValueBuffer("codimpuesto", curLineaComanda.valueBuffer("codimpuesto"));
		setValueBuffer("iva", curLineaComanda.valueBuffer("iva"));
		setValueBuffer("dtolineal", curLineaComanda.valueBuffer("dtolineal"));
		setValueBuffer("dtopor", curLineaComanda.valueBuffer("dtopor"));
		setValueBuffer("numserie", curLineaComanda.valueBuffer("numserie"));
		setValueBuffer("ivaincluido", curLineaComanda.valueBuffer("ivaincluido"));
		setValueBuffer("pvpunitarioiva", curLineaComanda.valueBuffer("pvpunitarioiva"));
		setValueBuffer("costounitario", curLineaComanda.valueBuffer("costounitario"));
		setValueBuffer("costototal", curLineaComanda.valueBuffer("costototal"));
		setValueBuffer("ganancia", curLineaComanda.valueBuffer("ganancia"));
		setValueBuffer("utilidad", curLineaComanda.valueBuffer("utilidad"));
	}
	return true;
}

function tipoVenta_totalesRemito():Boolean
{
	with (this.iface.curRemito) {
		setValueBuffer("neto", formalbaranescli.iface.pub_commonCalculateField("neto", this));
		setValueBuffer("totaliva", formalbaranescli.iface.pub_commonCalculateField("totaliva", this));
		setValueBuffer("total", formalbaranescli.iface.pub_commonCalculateField("total", this));
		setValueBuffer("totaleuros", formalbaranescli.iface.pub_commonCalculateField("totaleuros", this));
	}

	return true;
}

function tipoVenta_datosRemito(curComanda:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	var codAlmacen:String = util.sqlSelect("tpv_puntosventa", "codalmacen", "codtpv_puntoventa = '" + curComanda.valueBuffer("codtpv_puntoventa") + "'");
	if (!codAlmacen || codAlmacen == "")
		codAlmacen = flfactppal.iface.pub_valorDefectoEmpresa("codalmacen");

	var codCliente:String = curComanda.valueBuffer("codcliente");
	var nomCliente:String = curComanda.valueBuffer("nombrecliente");
	var cifCliente:String = curComanda.valueBuffer("cifnif");
	var direccion:String = curComanda.valueBuffer("direccion");
	var numeroSecuencia:String = curComanda.valueBuffer("numerosecuencia");

	if (!nomCliente || nomCliente == "")
		nomCliente = "-";
	if (!cifCliente || cifCliente == "")
		cifCliente = "-";
	if (!direccion || direccion == "")
		direccion = "-";
	
	with (this.iface.curRemito) {
		if (codCliente && codCliente != "")
			setValueBuffer("codcliente", codCliente);
		setValueBuffer("nombrecliente", nomCliente);
		setValueBuffer("cifnif", cifCliente);
		setValueBuffer("direccion", direccion);
		if (curComanda.valueBuffer("coddir") != 0)
			setValueBuffer("coddir", curComanda.valueBuffer("coddir"));
		setValueBuffer("codpostal", curComanda.valueBuffer("codpostal"));
		setValueBuffer("ciudad", curComanda.valueBuffer("ciudad"));
		setValueBuffer("provincia", curComanda.valueBuffer("provincia"));
		setValueBuffer("codpais", curComanda.valueBuffer("codpais"));
		setValueBuffer("fecha", curComanda.valueBuffer("fecha"));
		setValueBuffer("hora", curComanda.valueBuffer("hora"));
		setValueBuffer("codejercicio",flfactppal.iface.pub_ejercicioActual());
		setValueBuffer("coddivisa", curComanda.valueBuffer("coddivisa"));
		setValueBuffer("codpago", curComanda.valueBuffer("codpago"));
		setValueBuffer("codalmacen", codAlmacen);
		setValueBuffer("codserie", curComanda.valueBuffer("codserie"));
		setValueBuffer("numero", numeroSecuencia);
		setValueBuffer("codigo", formalbaranescli.iface.pub_commonCalculateField("codigo", this));
		setValueBuffer("tasaconv", curComanda.valueBuffer("tasaconv"));
		setValueBuffer("tpv", true);
		setValueBuffer("idtpv_comanda", curComanda.valueBuffer("idtpv_comanda"));
		setValueBuffer("costototal", curComanda.valueBuffer("costototal"));
		setValueBuffer("ganancia", curComanda.valueBuffer("ganancia"));
		setValueBuffer("utilidad", curComanda.valueBuffer("utilidad"));
		setValueBuffer("impresofiscal", curComanda.valueBuffer("impresofiscal"));
	}
	return true;
}

//// Pedidos ////

function tipoVenta_crearPedido(curComanda:FLSqlCursor):Number
{
	var util:FLUtil = new FLUtil();
	var idPedido:Number;

	if (!this.iface.curPedido)
		this.iface.curPedido = new FLSqlCursor("pedidoscli");

	this.iface.curPedido.setModeAccess(this.iface.curPedido.Insert);
	this.iface.curPedido.refreshBuffer();

	if (!this.iface.datosPedido(curComanda))
		return false;

	if (!this.iface.curPedido.commitBuffer())
		return false;

	idPedido = this.iface.curPedido.valueBuffer("idpedido");
	if (!this.iface.copiarLineasPedido(curComanda.valueBuffer("idtpv_comanda"), idPedido))
		return false;

	this.iface.curPedido.select("idpedido = " + idPedido);
	if (!this.iface.curPedido.first())
		return false;

	this.iface.curPedido.setModeAccess(this.iface.curPedido.Edit);
	this.iface.curPedido.refreshBuffer();

	if (!this.iface.totalesPedido())
		return false;

	if (!this.iface.curPedido.commitBuffer())
		return false;

	return idPedido;
}

function tipoVenta_borrarPedido(idPedido:String):Boolean
{
	var util:FLUtil = new FLUtil;

	if (!util.sqlDelete("pedidoscli", "idpedido = " + idPedido))
		return false;

	return true;
}

function tipoVenta_copiarLineasPedido(idComanda:Number, idPedido:Number):Boolean 
{
	var curLineaComanda:FLSqlCursor = new FLSqlCursor("tpv_lineascomanda");
	curLineaComanda.select("idtpv_comanda = " + idComanda);
	while (curLineaComanda.next()) {
		if(!this.iface.copiarLineaPedido(idPedido,curLineaComanda))
			return false;
	}
	return true;
}

function tipoVenta_copiarLineaPedido(idPedido:Number,curLineaComanda:FLSqlCursor):Boolean
{
	if (!this.iface.curLineaPedido)
		this.iface.curLineaPedido = new FLSqlCursor("lineaspedidoscli");
	
	with (this.iface.curLineaPedido) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idpedido", idPedido);
	}
	
	if (!this.iface.datosLineaPedido(curLineaComanda))
		return false;
		
	if (!this.iface.curLineaPedido.commitBuffer())
		return false;
	
	return this.iface.curLineaPedido.valueBuffer("idlinea");
}

function tipoVenta_datosLineaPedido(curLineaComanda:FLSqlCursor):Boolean
{
	with (this.iface.curLineaPedido) {
		setValueBuffer("referencia", curLineaComanda.valueBuffer("referencia"));
		setValueBuffer("descripcion", curLineaComanda.valueBuffer("descripcion"));
		setValueBuffer("pvpunitario", curLineaComanda.valueBuffer("pvpunitario"));
		setValueBuffer("cantidad", curLineaComanda.valueBuffer("cantidad"));
		setValueBuffer("pvpsindto", curLineaComanda.valueBuffer("pvpsindto"));
		setValueBuffer("pvptotal", curLineaComanda.valueBuffer("pvptotal"));
		setValueBuffer("totalconiva", curLineaComanda.valueBuffer("totalconiva"));
		setValueBuffer("codimpuesto", curLineaComanda.valueBuffer("codimpuesto"));
		setValueBuffer("iva", curLineaComanda.valueBuffer("iva"));
		setValueBuffer("dtolineal", curLineaComanda.valueBuffer("dtolineal"));
		setValueBuffer("dtopor", curLineaComanda.valueBuffer("dtopor"));
		setValueBuffer("ivaincluido", curLineaComanda.valueBuffer("ivaincluido"));
		setValueBuffer("pvpunitarioiva", curLineaComanda.valueBuffer("pvpunitarioiva"));
		setValueBuffer("costounitario", curLineaComanda.valueBuffer("costounitario"));
		setValueBuffer("costototal", curLineaComanda.valueBuffer("costototal"));
		setValueBuffer("ganancia", curLineaComanda.valueBuffer("ganancia"));
		setValueBuffer("utilidad", curLineaComanda.valueBuffer("utilidad"));
	}
	return true;
}

function tipoVenta_totalesPedido():Boolean
{
	with (this.iface.curPedido) {
		setValueBuffer("neto", formpedidoscli.iface.pub_commonCalculateField("neto", this));
		setValueBuffer("totaliva", formpedidoscli.iface.pub_commonCalculateField("totaliva", this));
		setValueBuffer("total", formpedidoscli.iface.pub_commonCalculateField("total", this));
		setValueBuffer("totaleuros", formpedidoscli.iface.pub_commonCalculateField("totaleuros", this));
	}
	return true;
}

function tipoVenta_datosPedido(curComanda:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	var codAlmacen:String = util.sqlSelect("tpv_puntosventa", "codalmacen", "codtpv_puntoventa = '" + curComanda.valueBuffer("codtpv_puntoventa") + "'");
	if (!codAlmacen || codAlmacen == "")
		codAlmacen = flfactppal.iface.pub_valorDefectoEmpresa("codalmacen");

	var codCliente:String = curComanda.valueBuffer("codcliente");
	var nomCliente:String = curComanda.valueBuffer("nombrecliente");
	var cifCliente:String = curComanda.valueBuffer("cifnif");
	var direccion:String = curComanda.valueBuffer("direccion");
	var numeroSecuencia:String = curComanda.valueBuffer("numerosecuencia");

	if (!nomCliente || nomCliente == "")
		nomCliente = "-";
	if (!cifCliente || cifCliente == "")
		cifCliente = "-";
	if (!direccion || direccion == "")
		direccion = "-";
	
	with (this.iface.curPedido) {
		if (codCliente && codCliente != "")
			setValueBuffer("codcliente", codCliente);
		setValueBuffer("nombrecliente", nomCliente);
		setValueBuffer("cifnif", cifCliente);
		setValueBuffer("direccion", direccion);
		if (curComanda.valueBuffer("coddir") != 0)
			setValueBuffer("coddir", curComanda.valueBuffer("coddir"));
		setValueBuffer("codpostal", curComanda.valueBuffer("codpostal"));
		setValueBuffer("ciudad", curComanda.valueBuffer("ciudad"));
		setValueBuffer("provincia", curComanda.valueBuffer("provincia"));
		setValueBuffer("codpais", curComanda.valueBuffer("codpais"));
		setValueBuffer("fecha", curComanda.valueBuffer("fecha"));
		setValueBuffer("codejercicio",flfactppal.iface.pub_ejercicioActual());
		setValueBuffer("coddivisa", curComanda.valueBuffer("coddivisa"));
		setValueBuffer("codpago", curComanda.valueBuffer("codpago"));
		setValueBuffer("codalmacen", codAlmacen);
		setValueBuffer("codserie", curComanda.valueBuffer("codserie"));
		setValueBuffer("numero", numeroSecuencia);
		setValueBuffer("codigo", formpedidoscli.iface.pub_commonCalculateField("codigo", this));
		setValueBuffer("tasaconv", curComanda.valueBuffer("tasaconv"));
		setValueBuffer("tpv", true);
		setValueBuffer("idtpv_comanda", curComanda.valueBuffer("idtpv_comanda"));
		setValueBuffer("costototal", curComanda.valueBuffer("costototal"));
		setValueBuffer("ganancia", curComanda.valueBuffer("ganancia"));
		setValueBuffer("utilidad", curComanda.valueBuffer("utilidad"));
	}
	return true;
}

//// Presupuestos ////

function tipoVenta_crearPresupuesto(curComanda:FLSqlCursor):Number
{
	var util:FLUtil = new FLUtil();
	var idPresupuesto:Number;

	if (!this.iface.curPresupuesto)
		this.iface.curPresupuesto = new FLSqlCursor("presupuestoscli");

	this.iface.curPresupuesto.setModeAccess(this.iface.curPresupuesto.Insert);
	this.iface.curPresupuesto.refreshBuffer();

	if (!this.iface.datosPresupuesto(curComanda))
		return false;

	if (!this.iface.curPresupuesto.commitBuffer())
		return false;

	idPresupuesto = this.iface.curPresupuesto.valueBuffer("idpresupuesto");
	if (!this.iface.copiarLineasPresupuesto(curComanda.valueBuffer("idtpv_comanda"), idPresupuesto))
		return false;

	this.iface.curPresupuesto.select("idpresupuesto = " + idPresupuesto);
	if (!this.iface.curPresupuesto.first())
		return false;

	this.iface.curPresupuesto.setModeAccess(this.iface.curPresupuesto.Edit);
	this.iface.curPresupuesto.refreshBuffer();

	if (!this.iface.totalesPresupuesto())
		return false;

	if (!this.iface.curPresupuesto.commitBuffer())
		return false;

	return idPresupuesto;
}

function tipoVenta_borrarPresupuesto(idPresupuesto:String):Boolean
{
	var util:FLUtil = new FLUtil;

	if (!util.sqlDelete("presupuestoscli", "idpresupuesto = " + idPresupuesto))
		return false;

	return true;
}

function tipoVenta_copiarLineasPresupuesto(idComanda:Number, idPresupuesto:Number):Boolean 
{
	var curLineaComanda:FLSqlCursor = new FLSqlCursor("tpv_lineascomanda");
	curLineaComanda.select("idtpv_comanda = " + idComanda);
	while (curLineaComanda.next()) {
		if(!this.iface.copiarLineaPresupuesto(idPresupuesto,curLineaComanda))
			return false;
	}
	return true;
}

function tipoVenta_copiarLineaPresupuesto(idPresupuesto:Number,curLineaComanda:FLSqlCursor):Boolean
{
	if (!this.iface.curLineaPresupuesto)
		this.iface.curLineaPresupuesto = new FLSqlCursor("lineaspresupuestoscli");
	
	with (this.iface.curLineaPresupuesto) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idpresupuesto", idPresupuesto);
	}
	
	if (!this.iface.datosLineaPresupuesto(curLineaComanda))
		return false;
		
	if (!this.iface.curLineaPresupuesto.commitBuffer())
		return false;
	
	return this.iface.curLineaPresupuesto.valueBuffer("idlinea");
}

function tipoVenta_datosLineaPresupuesto(curLineaComanda:FLSqlCursor):Boolean
{
	with (this.iface.curLineaPresupuesto) {
		setValueBuffer("referencia", curLineaComanda.valueBuffer("referencia"));
		setValueBuffer("descripcion", curLineaComanda.valueBuffer("descripcion"));
		setValueBuffer("pvpunitario", curLineaComanda.valueBuffer("pvpunitario"));
		setValueBuffer("cantidad", curLineaComanda.valueBuffer("cantidad"));
		setValueBuffer("pvpsindto", curLineaComanda.valueBuffer("pvpsindto"));
		setValueBuffer("pvptotal", curLineaComanda.valueBuffer("pvptotal"));
		setValueBuffer("totalconiva", curLineaComanda.valueBuffer("totalconiva"));
		setValueBuffer("codimpuesto", curLineaComanda.valueBuffer("codimpuesto"));
		setValueBuffer("iva", curLineaComanda.valueBuffer("iva"));
		setValueBuffer("dtolineal", curLineaComanda.valueBuffer("dtolineal"));
		setValueBuffer("dtopor", curLineaComanda.valueBuffer("dtopor"));
		setValueBuffer("ivaincluido", curLineaComanda.valueBuffer("ivaincluido"));
		setValueBuffer("pvpunitarioiva", curLineaComanda.valueBuffer("pvpunitarioiva"));
		setValueBuffer("costounitario", curLineaComanda.valueBuffer("costounitario"));
		setValueBuffer("costototal", curLineaComanda.valueBuffer("costototal"));
		setValueBuffer("ganancia", curLineaComanda.valueBuffer("ganancia"));
		setValueBuffer("utilidad", curLineaComanda.valueBuffer("utilidad"));
	}
	return true;
}

function tipoVenta_totalesPresupuesto():Boolean
{
	with (this.iface.curPresupuesto) {
		setValueBuffer("neto", formpresupuestoscli.iface.pub_commonCalculateField("neto", this));
		setValueBuffer("totaliva", formpresupuestoscli.iface.pub_commonCalculateField("totaliva", this));
		setValueBuffer("total", formpresupuestoscli.iface.pub_commonCalculateField("total", this));
		setValueBuffer("totaleuros", formpresupuestoscli.iface.pub_commonCalculateField("totaleuros", this));
	}
	return true;
}

function tipoVenta_datosPresupuesto(curComanda:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	var codAlmacen:String = util.sqlSelect("tpv_puntosventa", "codalmacen", "codtpv_puntoventa = '" + curComanda.valueBuffer("codtpv_puntoventa") + "'");
	if (!codAlmacen || codAlmacen == "")
		codAlmacen = flfactppal.iface.pub_valorDefectoEmpresa("codalmacen");

	var codCliente:String = curComanda.valueBuffer("codcliente");
	var nomCliente:String = curComanda.valueBuffer("nombrecliente");
	var cifCliente:String = curComanda.valueBuffer("cifnif");
	var direccion:String = curComanda.valueBuffer("direccion");
	var numeroSecuencia:String = curComanda.valueBuffer("numerosecuencia");

	if (!nomCliente || nomCliente == "")
		nomCliente = "-";
	if (!cifCliente || cifCliente == "")
		cifCliente = "-";
	if (!direccion || direccion == "")
		direccion = "-";
	
	with (this.iface.curPresupuesto) {
		if (codCliente && codCliente != "")
			setValueBuffer("codcliente", codCliente);
		setValueBuffer("nombrecliente", nomCliente);
		setValueBuffer("cifnif", cifCliente);
		setValueBuffer("direccion", direccion);
		if (curComanda.valueBuffer("coddir") != 0)
			setValueBuffer("coddir", curComanda.valueBuffer("coddir"));
		setValueBuffer("codpostal", curComanda.valueBuffer("codpostal"));
		setValueBuffer("ciudad", curComanda.valueBuffer("ciudad"));
		setValueBuffer("provincia", curComanda.valueBuffer("provincia"));
		setValueBuffer("codpais", curComanda.valueBuffer("codpais"));
		setValueBuffer("fecha", curComanda.valueBuffer("fecha"));
		setValueBuffer("codejercicio",flfactppal.iface.pub_ejercicioActual());
		setValueBuffer("coddivisa", curComanda.valueBuffer("coddivisa"));
		setValueBuffer("codpago", curComanda.valueBuffer("codpago"));
		setValueBuffer("codalmacen", codAlmacen);
		setValueBuffer("codserie", curComanda.valueBuffer("codserie"));
		setValueBuffer("numero", numeroSecuencia);
		setValueBuffer("codigo", formpresupuestoscli.iface.pub_commonCalculateField("codigo", this));
		setValueBuffer("tasaconv", curComanda.valueBuffer("tasaconv"));
		setValueBuffer("tpv", true);
		setValueBuffer("idtpv_comanda", curComanda.valueBuffer("idtpv_comanda"));
		setValueBuffer("costototal", curComanda.valueBuffer("costototal"));
		setValueBuffer("ganancia", curComanda.valueBuffer("ganancia"));
		setValueBuffer("utilidad", curComanda.valueBuffer("utilidad"));
	}
	return true;
}


//// Asociar remitos ////

function tipoVenta_afterCommit_tpv_comandas(curComanda:FLSqlCursor):Boolean
{
	if (!this.iface.__afterCommit_tpv_comandas(curComanda))
		return false;

	if (curComanda.modeAccess() == curComanda.Del) {
		if (!this.iface.liberarAlbaranesCli(curComanda.valueBuffer("idtpv_comanda"))) {
			return false;
		}
	}

	return true;
}

/** \D
Llama a la función liberarAlbaran para todos los remitos agrupados en una factura
@param idFactura: Identificador de la factura
\end */
function tipoVenta_liberarAlbaranesCli(idFactura:Number):Boolean
{
	var curAlbaranes:FLSqlCursor = new FLSqlCursor("tpv_comandas");
	curAlbaranes.select("idtpv_comanda_factura = " + idFactura);
	while (curAlbaranes.next()) {
		if (!this.iface.liberarAlbaranCli(curAlbaranes.valueBuffer("idtpv_comanda"))) {
			return false;
		}
	}
	return true;
}

/** \D
Desbloquea un remito que estaba asociado a una factura
@param idAlbaran: Identificador del remito
\end */
function tipoVenta_liberarAlbaranCli(idAlbaran:Number):Boolean
{
	var curRemito:FLSqlCursor = new FLSqlCursor("albaranescli");
	with(curRemito) {
		select("idtpv_comanda = " + idAlbaran);
		first();
		setUnLock("ptefactura", true);
	}
	with(curRemito) {
		select("idtpv_comanda = " + idAlbaran);
		first();
		setModeAccess(Edit);
		refreshBuffer();
		setValueBuffer("idfactura", "0");
		setValueBuffer("servido", "No");
	}
	if (!curRemito.commitBuffer()) {
		return false;
	}

	var curAlbaran:FLSqlCursor = new FLSqlCursor("tpv_comandas");
	with(curAlbaran) {
		select("idtpv_comanda = " + idAlbaran);
		first();
		setUnLock("editable", true);
	}
	with(curAlbaran) {
		select("idtpv_comanda = " + idAlbaran);
		first();
		setModeAccess(Edit);
		refreshBuffer();
		setValueBuffer("idtpv_comanda_factura", "0");
		setValueBuffer("estado", "Abierta");
	}
	if (!curAlbaran.commitBuffer()) {
		return false;
	}
	return true;
}

function tipoVenta_afterCommit_tpv_lineascomanda(curLinea:FLSqlCursor):Boolean
{
	if ( !this.iface.__afterCommit_tpv_lineascomanda(curLinea) )
		return false;

	if ( !this.iface.actualizarAlbaranesLineaFacturaCli(curLinea) ) {
		return false;
	}

	return true;
}

function tipoVenta_actualizarAlbaranesLineaFacturaCli(curLF:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var idLineaAlbaran:Number = parseFloat(curLF.valueBuffer("idtpv_lineacomanda_albaran"));
	if (idLineaAlbaran == 0) {
		return true;
	}
	
	switch (curLF.modeAccess()) {
		case curLF.Insert: {
			if (!this.iface.actualizarLineaAlbaranCli(curLF.valueBuffer("idtpv_lineacomanda_albaran"), curLF.valueBuffer("idtpv_comanda_albaran") , curLF.valueBuffer("referencia"), curLF.valueBuffer("idtpv_comanda"), curLF.valueBuffer("cantidad"))) {
				return false;
			}
			if (!this.iface.actualizarEstadoAlbaranCli(curLF.valueBuffer("idtpv_comanda_albaran"), curLF)) {
				return false;
			}
			break;
		}
		case curLF.Edit: {
			if (curLF.valueBuffer("cantidad") != curLF.valueBufferCopy("cantidad")) {
				if (!this.iface.actualizarLineaAlbaranCli(curLF.valueBuffer("idtpv_lineacomanda_albaran"), curLF.valueBuffer("idtpv_comanda_albaran") , curLF.valueBuffer("referencia"), curLF.valueBuffer("idtpv_comanda"), curLF.valueBuffer("cantidad"))) {
					return false;
				}
				if (!this.iface.actualizarEstadoAlbaranCli(curLF.valueBuffer("idtpv_comanda_albaran"), curLF)) {
					return false;
				}
			}
			break;
		}
		case curLF.Del: {
			var idAlbaran:Number = curLF.valueBuffer("idtpv_comanda_albaran");
			var idLineaFactura:Number = curLF.valueBuffer("idtpv_linea");
			if (!this.iface.restarCantidadAlbaranCli(idLineaAlbaran, idLineaFactura)) {
				return false;
			}
			this.iface.actualizarEstadoAlbaranCli(idAlbaran);
			break;
		}
	}
	return true;
}

/** \C
Actualiza el campo total en factura de la línea de remito correspondiente (si existe).
@param	idLineaAlbaran: Id de la línea a actualizar
@param	idAlbaran: Id del remito a actualizar
@param	referencia del artículo contenido en la línea
@param	idFactura: Id de la factura en la que se sirve el remito
@param	cantidadLineaFactura: Cantidad total de artículos de la referencia actual en la factura
@return	True si la actualización se realiza correctamente, false en caso contrario
\end */
function tipoVenta_actualizarLineaAlbaranCli(idLineaAlbaran:Number, idAlbaran:Number, referencia:String, idFactura:Number, cantidadLineaFactura:Number):Boolean
{
	if (idLineaAlbaran == 0) {
		return true;
	}

	var cantidadServida:Number;
	var curLineaAlbaran:FLSqlCursor = new FLSqlCursor("tpv_lineascomanda");
	curLineaAlbaran.select("idtpv_linea = " + idLineaAlbaran);
	curLineaAlbaran.setModeAccess(curLineaAlbaran.Edit);
	if (!curLineaAlbaran.first()) {
		return true;
	}

	var cantidadAlbaran:Number = parseFloat(curLineaAlbaran.valueBuffer("cantidad"));
	var query:FLSqlQuery = new FLSqlQuery();
	query.setTablesList("tpv_lineascomanda");
	query.setSelect("SUM(cantidad)");
	query.setFrom("tpv_lineascomanda");
	query.setWhere("idtpv_lineacomanda_albaran = " + idLineaAlbaran + " AND idtpv_linea <> " + idFactura);
	if (!query.exec()) {
		return false;
	}
	if (query.next()) {
		var canOtros:Number = parseFloat(query.value("SUM(cantidad)"));
		if (isNaN(canOtros)) {
			canOtros = 0;
		}
		cantidadServida = canOtros + parseFloat(cantidadLineaFactura);
	}
	if (cantidadServida > cantidadAlbaran) {
		cantidadServida = cantidadAlbaran;
	}
		
	curLineaAlbaran.setValueBuffer("totalenfactura", cantidadServida);
	if (!curLineaAlbaran.commitBuffer()) {
		return false;
	}
	
	return true;
}

/** \D
Cambia el valor del campo totalenfactura de una determinada línea de remito, calculándolo como la suma de cantidades en otras líneas distintas de la línea de factura indicada
@param idLineaAlbaran: Identificador de la línea de remito
@param idLineaFactura: Identificador de la línea de factura
\end */
function tipoVenta_restarCantidadAlbaranCli(idLineaAlbaran:Number, idLineaFactura:Number):Boolean
{
	var util:FLUtil = new FLUtil;
	var cantidad:Number = parseFloat(util.sqlSelect("tpv_lineascomanda", "SUM(cantidad)", "idtpv_lineacomanda_albaran = " + idLineaAlbaran + " AND idtpv_linea <> " + idLineaFactura));
	if (isNaN(cantidad))
		cantidad = 0;

	var curLineaAlbaran:FLSqlCursor = new FLSqlCursor("tpv_lineascomanda");
	curLineaAlbaran.select("idtpv_linea = " + idLineaAlbaran);
	if (curLineaAlbaran.first()) {
		curLineaAlbaran.setModeAccess(curLineaAlbaran.Edit);
		curLineaAlbaran.refreshBuffer();
		curLineaAlbaran.setValueBuffer("totalenfactura", cantidad);
		if (!curLineaAlbaran.commitBuffer()) {
			return false;
		}
	}

	return true;
}

/** \C
Marca el remito como servido o parcialmente servido según corresponda.
@param	idAlbaran: Id del remito a actualizar
@param	curFactura: Cursor posicionado en la factura que modifica el estado del remito
@return	True si la actualización se realiza correctamente, false en caso contrario
\end */
function tipoVenta_actualizarEstadoAlbaranCli(idAlbaran:Number, curFactura:FLSqlCursor):Boolean
{
	var estado:String = this.iface.obtenerEstadoAlbaranCli(idAlbaran);
	if (!estado) {
		return false;
	}

	var curAlbaran:FLSqlCursor = new FLSqlCursor("tpv_comandas");
	curAlbaran.select("idtpv_comanda = " + idAlbaran);
	if (curAlbaran.first()) {
		if (estado == curAlbaran.valueBuffer("estado")) {
			return true;
		}
		curAlbaran.setUnLock("editable", true);
	}

	curAlbaran.select("idtpv_comanda = " + idAlbaran);
	curAlbaran.setModeAccess(curAlbaran.Edit);
	if (curAlbaran.first()) {
		curAlbaran.setValueBuffer("estado", estado);
		if (estado == "Cerrada") {
			curAlbaran.setValueBuffer("editable", false);
		}
		if (!curAlbaran.commitBuffer()) {
			return false;
		}
	}

	return true;
}

/** \C
Obtiene el estado de un remito
@param	idAlbaran: Id del remito a actualizar
@return	Estado del remito
\end */
function tipoVenta_obtenerEstadoAlbaranCli(idAlbaran:Number):String
{
	var query:FLSqlQuery = new FLSqlQuery();

	query.setTablesList("tpv_lineascomanda");
	query.setSelect("cantidad,totalenfactura");
	query.setFrom("tpv_lineascomanda");
	query.setWhere("idtpv_comanda = " + idAlbaran);
	if (!query.exec()) {
		return false;
	}

	var estado:String = "";
	var totalServida:Number = 0;
	var parcial:Boolean = false;
	var totalLineas:Number = query.size();

	if (totalLineas == 0)
		return "Abierta";

	while (query.next()) {
		var cantidad:Number = parseFloat(query.value("cantidad"));
		var cantidadServida:Number = parseFloat(query.value("totalenfactura"));
		if (cantidad == cantidadServida)
			totalServida += 1;
		else
			if (cantidad > cantidadServida && cantidadServida != 0)
				parcial = true;
	}
	
	if (parcial) {
		estado = "Parcial";
	}
	else {
		if (totalServida == 0)
			estado = "Abierta";
		else {
			if (totalServida == totalLineas)
				estado = "Cerrada";
			else
				if (totalServida < totalLineas)
					estado = "Parcial";
		}
	}
	return estado;
}

function tipoVenta_actualizarIdFacturaEnRemitos():Boolean
{
	if (!this.iface.curFactura.valueBuffer("automatica"))
		return true;

	var util:FLUtil = new FLUtil;
	var idFacturaComanda:Number = this.iface.curFactura.valueBuffer("idtpv_comanda");
	var idFactura:Number = util.sqlSelect("facturascli", "idfactura", "idtpv_comanda = " + idFacturaComanda);
	if (!idFactura)
		idFactura = 0;

	var curAlbaranes:FLSqlCursor = new FLSqlCursor("tpv_comandas");
	curAlbaranes.select("idtpv_comanda_factura = " + idFacturaComanda);
	while (curAlbaranes.next()) {
		if (!this.iface.actualizarIdFacturaEnRemito(curAlbaranes.valueBuffer("idtpv_comanda"), idFactura)) {
			return false;
		}
	}

	return true;
}

function tipoVenta_actualizarIdFacturaEnRemito(idRemitoComanda:Number, idFactura:Number):Boolean
{
	var curAlbaran:FLSqlCursor = new FLSqlCursor("albaranescli");
	curAlbaran.select("idtpv_comanda = " + idRemitoComanda);
	if (curAlbaran.first()) {
		curAlbaran.setUnLock("ptefactura", true);
	}
	
	curAlbaran.select("idtpv_comanda = " + idRemitoComanda);
	curAlbaran.setModeAccess(curAlbaran.Edit);
	if (curAlbaran.first()) {
		curAlbaran.setValueBuffer("idfactura", idFactura);
		curAlbaran.setValueBuffer("ptefactura", false);
		if (!curAlbaran.commitBuffer()) {
			return false;
		}
	}

	return true;
}
//// TIPO DE VENTA //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition periodosFiscales */
//////////////////////////////////////////////////////////////////
//// PERIODOS FISCALES ///////////////////////////////////////////

function periodosFiscales_datosFactura(curComanda:FLSqlCursor):Boolean
{
	if (!this.iface.__datosFactura(curComanda))
		return false;

	var util:FLUtil = new FLUtil();

	var fecha:String = this.iface.curFactura.valueBuffer("fecha");
	var codPeriodo:String = util.sqlSelect("periodos", "codperiodo", "fechainicio <= '" + fecha + "' AND fechafin >= '" + fecha + "' AND codejercicio = '" + this.iface.curFactura.valueBuffer("codejercicio") + "'");
	if (!codPeriodo) {
		MessageBox.warning(util.translate("scripts", "No hay abierto un período fiscal para esta fecha.\nDebe crear un nuevo período fiscal para el ejercicio actual."), MessageBox.Ok, MessageBox.NoButton);
		return false;
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

/** @class_declaration desbloqueoStock */
/////////////////////////////////////////////////////////////////
//// DESBLOQUEO AL MODIFICAR STOCK //////////////////////////////

function desbloqueoStock_beforeCommit_tpv_comandas(curComanda:FLSqlCursor):Boolean
{
	if ( !this.iface.__beforeCommit_tpv_comandas(curComanda) )
		return false;

	var util:FLUtil = new FLUtil();
	if (sys.isLoadedModule("flfactalma")) {
		if (curComanda.modeAccess() == curComanda.Insert || curComanda.modeAccess() == curComanda.Edit) {
			/* Actualizar el campo cantidadprevia en las líneas: cantidadprevia = cantidad. */
			var curLineas:FLSqlCursor = new FLSqlCursor("tpv_lineascomanda");
			curLineas.select("idtpv_comanda = " + curComanda.valueBuffer("idtpv_comanda"));
			while (curLineas.next()) {
				curLineas.setModeAccess(curLineas.Edit);
				curLineas.refreshBuffer();
				curLineas.setValueBuffer("cantidadprevia", curLineas.valueBuffer("cantidad"));
				if (!curLineas.commitBuffer())
					return false;
			}
		}
	}

	return true;
}

function desbloqueoStock_afterCommit_tpv_comandas(curComanda:FLSqlCursor):Boolean
{
	if (!this.iface.__afterCommit_tpv_comandas(curComanda))
		return false;

	/* Al eliminarse el documento con sus líneas, también se borran los registros correspondientes en movistock */
	if (curComanda.modeAccess() == curComanda.Del) {
		var tipoDoc = "";
		var tipoVenta = curComanda.valueBuffer("tipoventa");
		switch (tipoVenta) {
			case "Factura":
			case "Ticket":
				tipoDoc = "FC";
				break;
			case "Remito":
				tipoDoc = "RC";
				break;
			case "Pedido":
				tipoDoc = "PC";
				break;
		}

		var curMoviStock:FLSqlCursor = new FLSqlCursor("movistock");
		curMoviStock.select("tipodoc = '" + tipoDoc + "' AND iddoc = " + curComanda.valueBuffer("iddocumento"));
		while (curMoviStock.next()) {
			curMoviStock.setModeAccess(curMoviStock.Del);
			curMoviStock.refreshBuffer();
			if (!curMoviStock.commitBuffer())
				return false;
		}
	}

	return true;
}

//// DESBLOQUEO AL MODIFICAR STOCK //////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////