/***************************************************************************
                 flfacturac.qs  -  description
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
	function beforeCommit_presupuestoscli(curPresupuesto:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_presupuestoscli(curPresupuesto);
	}
	function beforeCommit_pedidoscli(curPedido:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_pedidoscli(curPedido);
	}
	function beforeCommit_pedidosprov(curPedido:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_pedidosprov(curPedido);
	}
	function beforeCommit_albaranescli(curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_albaranescli(curAlbaran);
	}
	function beforeCommit_albaranesprov(curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_albaranesprov(curAlbaran);
	}
	function beforeCommit_facturascli(curFactura:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_facturascli(curFactura);
	}
	function beforeCommit_facturasprov(curFactura:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_facturasprov(curFactura);
	}
	function afterCommit_pedidoscli(curPedido:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_pedidoscli(curPedido);
	}
	function afterCommit_albaranescli(curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_albaranescli(curAlbaran);
	}
	function afterCommit_albaranesprov(curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_albaranesprov(curAlbaran);
	}
	function afterCommit_facturascli(curFactura:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_facturascli(curFactura);
	}
	function afterCommit_facturasprov(curFactura:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_facturasprov(curFactura);
	}
	function afterCommit_lineasalbaranesprov(curLA:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_lineasalbaranesprov(curLA);
	}
	function afterCommit_lineasfacturasprov(curLF:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_lineasfacturasprov(curLF);
	}
	function afterCommit_lineaspedidoscli(curLA:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_lineaspedidoscli(curLA);
	}
	function afterCommit_lineaspedidosprov(curLA:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_lineaspedidosprov(curLA);
	}
	function afterCommit_lineasalbaranescli(curLA:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_lineasalbaranescli(curLA);
	}
	function afterCommit_lineasfacturascli(curLF:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_lineasfacturascli(curLF);
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	function oficial( context ) { interna( context ); }
	function obtenerHueco(codSerie:String, codEjercicio:String, tipo:String):Number {
		return this.ctx.oficial_obtenerHueco(codSerie, codEjercicio, tipo);
	}
	function establecerNumeroSecuencia(fN:String, value:Number):Number {
		return this.ctx.oficial_establecerNumeroSecuencia(fN, value);
	}
	function cerosIzquierda(numero:String, totalCifras:Number):String {
		return this.ctx.oficial_cerosIzquierda(numero, totalCifras);
	}
	function construirCodigo(codSerie:String, codEjercicio:String, numero:String):String {
		return this.ctx.oficial_construirCodigo(codSerie, codEjercicio, numero);
	}
	function siguienteNumero(codSerie:String, codEjercicio:String, fN:String):Number {
		return this.ctx.oficial_siguienteNumero(codSerie, codEjercicio, fN);
	}
	function agregarHueco(serie:String, ejercicio:String, numero:Number, fN:String):Boolean {
		return this.ctx.oficial_agregarHueco(serie, ejercicio, numero, fN);
	}
	function asientoBorrable(idAsiento:Number):Boolean {
		return this.ctx.oficial_asientoBorrable(idAsiento);
	}
	function generarAsientoFacturaCli(curFactura:FLSqlCursor):Boolean {
		return this.ctx.oficial_generarAsientoFacturaCli(curFactura);
	}
	function generarPartidasVenta(curFactura:FLSqlCursor, idAsiento:Number, valoresDefecto:Array):Boolean {
		return this.ctx.oficial_generarPartidasVenta(curFactura, idAsiento, valoresDefecto);
	}
	function generarPartidasIVACli(curFactura:FLSqlCursor, idAsiento:Number, valoresDefecto:Array, ctaCliente:Array):Boolean {
		return this.ctx.oficial_generarPartidasIVACli(curFactura, idAsiento, valoresDefecto, ctaCliente);
	}
	function generarPartidasCliente(curFactura:FLSqlCursor, idAsiento:Number, valoresDefecto:Array, ctaCliente:Array):Boolean {
		return this.ctx.oficial_generarPartidasCliente(curFactura, idAsiento, valoresDefecto, ctaCliente);
	}
	function regenerarAsiento(cur:FLSqlCursor, valoresDefecto:Array):Array {
		return this.ctx.oficial_regenerarAsiento(cur, valoresDefecto);
	}
	function generarAsientoFacturaProv(curFactura:FLSqlCursor):Boolean {
		return this.ctx.oficial_generarAsientoFacturaProv(curFactura);
	}
	function generarPartidasCompra(curFactura:FLSqlCursor, idAsiento:Number, valoresDefecto:Array, concepto:String):Boolean {
		return this.ctx.oficial_generarPartidasCompra(curFactura, idAsiento, valoresDefecto, concepto);
	}
	function generarPartidasIVAProv(curFactura:FLSqlCursor, idAsiento:Number, valoresDefecto:Array, ctaProveedor:Array, concepto:String):Boolean {
		return this.ctx.oficial_generarPartidasIVAProv(curFactura, idAsiento, valoresDefecto, ctaProveedor, concepto);
	}
	function generarPartidasProveedor(curFactura:FLSqlCursor, idAsiento:Number, valoresDefecto:Array, ctaProveedor:Array, concepto:String, sinIVA:Boolean):Boolean {
		return this.ctx.oficial_generarPartidasProveedor(curFactura, idAsiento, valoresDefecto, ctaProveedor, concepto, sinIVA);
	}
	function datosCtaEspecial(ctaEsp:String, codEjercicio:String):Array {
		return this.ctx.oficial_datosCtaEspecial(ctaEsp, codEjercicio);
	}
	function datosCtaIVA(tipo:String, codEjercicio:String, codImpuesto:String):Array {
		return this.ctx.oficial_datosCtaIVA(tipo, codEjercicio, codImpuesto);
	}
	function datosCtaVentas(codEjercicio:String, codSerie:String):Array {
		return this.ctx.oficial_datosCtaVentas(codEjercicio, codSerie);
	}
	function datosCtaCliente(curFactura:FLSqlCursor, valoresDefecto:Array):Array {
		return this.ctx.oficial_datosCtaCliente(curFactura, valoresDefecto);
	}
	function datosCtaProveedor(curFactura:FLSqlCursor, valoresDefecto:Array):Array {
		return this.ctx.oficial_datosCtaProveedor(curFactura, valoresDefecto);
	}
	function asientoNotaCreditoCli(curFactura:FLSqlCursor, valoresDefecto:Array){
		return this.ctx.oficial_asientoNotaCreditoCli(curFactura, valoresDefecto);
	}
	function asientoNotaDebitoCli(curFactura:FLSqlCursor, valoresDefecto:Array){
		return this.ctx.oficial_asientoNotaDebitoCli(curFactura, valoresDefecto);
	}
	function asientoNotaCreditoProv(curFactura:FLSqlCursor, valoresDefecto:Array){
		return this.ctx.oficial_asientoNotaCreditoProv(curFactura, valoresDefecto);
	}
	function asientoNotaDebitoProv(curFactura:FLSqlCursor, valoresDefecto:Array){
		return this.ctx.oficial_asientoNotaDebitoProv(curFactura, valoresDefecto);
	}
	function datosDocFacturacion(fecha:String, codEjercicio:String, tipoDoc:String):Array {
		return this.ctx.oficial_datosDocFacturacion(fecha, codEjercicio, tipoDoc);
	}
	function tieneIvaDocCliente(codSerie:String, codCliente:String, codEjercicio:String):Boolean {
		return this.ctx.oficial_tieneIvaDocCliente(codSerie, codCliente, codEjercicio);
	}
	function tieneIvaDocProveedor(codSerie:String, codProveedor:String, codEjercicio:String):Boolean {
		return this.ctx.oficial_tieneIvaDocProveedor(codSerie, codProveedor, codEjercicio);
	}
	function automataActivado():Boolean {
		return this.ctx.oficial_automataActivado();
	}
	function comprobarRegularizacion(curFactura:FLSqlCursor):Boolean {
		return this.ctx.oficial_comprobarRegularizacion(curFactura);
	}
	function recalcularHuecos(serie:String, ejercicio:String, fN:String):Boolean {
		return this.ctx.oficial_recalcularHuecos(serie, ejercicio, fN);
	}
	function mostrarTraza(codigo:String, tipo:String) {
		return this.ctx.oficial_mostrarTraza(codigo, tipo);
	}
	function datosPartidaFactura(curPartida:FLSqlCursor, curFactura:FLSqlCursor, tipo:String, concepto:String) {
		return this.ctx.oficial_datosPartidaFactura(curPartida, curFactura, tipo, concepto);
	}
	function eliminarAsiento(idAsiento:String):Boolean {
		return this.ctx.oficial_eliminarAsiento(idAsiento);
	}
	function siGenerarRecibosCli(curFactura:FLSqlCursor, masCampos:Array):Boolean {
		return this.ctx.oficial_siGenerarRecibosCli(curFactura, masCampos);
	}
	function validarIvaCliente(codCliente:String,id:Number,tabla:String,identificador:String):Boolean {
		return this.ctx.oficial_validarIvaCliente(codCliente,id,tabla,identificador);
	}
	function validarIvaProveedor(codProveedor:String,id:Number,tabla:String,identificador:String):Boolean {
		return this.ctx.oficial_validarIvaProveedor(codProveedor,id,tabla,identificador);
	}
	function comprobarNotaCreditoCli(curFactura:FLSqlCursor):Boolean {
		return this.ctx.oficial_comprobarNotaCreditoCli(curFactura);
	}
	function comprobarNotaDebitoCli(curFactura:FLSqlCursor):Boolean {
		return this.ctx.oficial_comprobarNotaDebitoCli(curFactura);
	}
	function comprobarNotaCreditoProv(curFactura:FLSqlCursor):Boolean {
		return this.ctx.oficial_comprobarNotaCreditoProv(curFactura);
	}
	function comprobarNotaDebitoProv(curFactura:FLSqlCursor):Boolean {
		return this.ctx.oficial_comprobarNotaDebitoProv(curFactura);
	}
	function controlFacturaRectificada(curFactura:FLSqlCursor, factura:String):Boolean {
		return this.ctx.oficial_controlFacturaRectificada(curFactura, factura);
	}
	function consultarCtaEspecial(ctaEsp:String, codEjercicio:String):Boolean {
		return this.ctx.oficial_consultarCtaEspecial(ctaEsp, codEjercicio);
	}
	function crearCtaEspecial(codCtaEspecial:String, tipo:String, codEjercicio:String, desCta:String):Boolean {
		return this.ctx.oficial_crearCtaEspecial(codCtaEspecial, tipo, codEjercicio, desCta);
	}
	function comprobarCambioSerie(cursor:FLSqlCursor):Boolean {
		return this.ctx.oficial_comprobarCambioSerie(cursor);
	}
	function netoVentasFacturaCli(curFactura:FLSqlCursor):Number {
		return this.ctx.oficial_netoVentasFacturaCli(curFactura);
	}
	function netoComprasFacturaProv(curFactura:FLSqlCursor):Number {
		return this.ctx.oficial_netoComprasFacturaProv(curFactura);
	}
	function datosConceptoAsiento(cur:FLSqlCursor):Array {
		return this.ctx.oficial_datosConceptoAsiento(cur);
	}
	function subcuentaVentas(referencia:String, codEjercicio:String):Array {
		return this.ctx.oficial_subcuentaVentas(referencia, codEjercicio);
	}
	function regimenIVACliente(curDocCliente:FLSqlCursor):String {
		return this.ctx.oficial_regimenIVACliente(curDocCliente);
	}
// 	function liberarPedidosCli(curAlbaran:FLSqlCursor):Boolean {
// 		return this.ctx.oficial_liberarPedidosCli(curAlbaran);
// 	}
// 	function liberarPedidosProv(curAlbaran:FLSqlCursor):Boolean {
// 		return this.ctx.oficial_liberarPedidosProv(curAlbaran);
// 	}
	function restarCantidadCli(idLineaPedido:Number, idLineaAlbaran:Number):Boolean {
		return this.ctx.oficial_restarCantidadCli(idLineaPedido, idLineaAlbaran);
	}
	function restarCantidadProv(idLineaPedido:Number, idLineaAlbaran:Number):Boolean {
		return this.ctx.oficial_restarCantidadProv(idLineaPedido, idLineaAlbaran);
	}
	function actualizarPedidosCli(curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.oficial_actualizarPedidosCli(curAlbaran);
	}
	function actualizarPedidosProv(curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.oficial_actualizarPedidosProv(curAlbaran);
	}
	function actualizarLineaPedidoProv(idLineaPedido:Number, idPedido:Number, referencia:String, idAlbaran:Number, cantidadLineaAlbaran:Number):Boolean {
		return this.ctx.oficial_actualizarLineaPedidoProv(idLineaPedido, idPedido, referencia, idAlbaran, cantidadLineaAlbaran);
	}
	function actualizarEstadoPedidoProv(idPedido:Number, curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.oficial_actualizarEstadoPedidoProv(idPedido, curAlbaran);
	}
	function obtenerEstadoPedidoProv(idPedido:Number):String {
		return this.ctx.oficial_obtenerEstadoPedidoProv(idPedido);
	}
	function actualizarLineaPedidoCli(idLineaPedido:Number, idPedido:Number, referencia:String, idAlbaran:Number, cantidadLineaAlbaran:Number):Boolean {
		return this.ctx.oficial_actualizarLineaPedidoCli(idLineaPedido, idPedido, referencia, idAlbaran, cantidadLineaAlbaran);
	}
	function actualizarEstadoPedidoCli(idPedido:Number, curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.oficial_actualizarEstadoPedidoCli(idPedido, curAlbaran);
	}
	function obtenerEstadoPedidoCli(idPedido:Number):String {
		return this.ctx.oficial_obtenerEstadoPedidoCli(idPedido);
	}
	function liberarAlbaranesCli(idFactura:Number):Boolean {
		return this.ctx.oficial_liberarAlbaranesCli(idFactura);
	}
	function liberarAlbaranCli(idAlbaran:Number):Boolean {
		return this.ctx.oficial_liberarAlbaranCli(idAlbaran);
	}
	function liberarAlbaranesProv(idFactura:Number):Boolean {
		return this.ctx.oficial_liberarAlbaranesProv(idFactura);
	}
	function liberarAlbaranProv(idAlbaran:Number):Boolean {
		return this.ctx.oficial_liberarAlbaranProv(idAlbaran);
	}
	function liberarPresupuestoCli(idPresupuesto:Number):Boolean {
		return this.ctx.oficial_liberarPresupuestoCli(idPresupuesto);
	}
	function actualizarPedidosLineaAlbaranCli(curLA:FLSqlCursor):Boolean {
		return this.ctx.oficial_actualizarPedidosLineaAlbaranCli(curLA);
	}
	function actualizarPedidosLineaAlbaranProv(curLA:FLSqlCursor):Boolean {
		return this.ctx.oficial_actualizarPedidosLineaAlbaranProv(curLA);
	}
	function aplicarComisionLineas(codAgente:String,tblHija:String,where:String):Boolean {
		return this.ctx.oficial_aplicarComisionLineas(codAgente,tblHija,where);
	}
	function calcularComisionLinea(codAgente:String,referencia:String):Number {
		return this.ctx.oficial_calcularComisionLinea(codAgente,referencia);
	}
}

//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration fluxEcommerce */
/////////////////////////////////////////////////////////////////
//// FLUX ECOMMERCE //////////////////////////////////////////////////////
class fluxEcommerce extends oficial {
    function fluxEcommerce( context ) { oficial ( context ); }
	
	function beforeCommit_pedidoscli(curPedido:FLSqlCursor):Boolean {
		return this.ctx.fluxEcommerce_beforeCommit_pedidoscli(curPedido);
	}

	function setModificado(cursor:FLSqlCursor)  {
		return this.ctx.fluxEcommerce_setModificado(cursor);
	}
}
//// FLUX ECOMMERCE //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pedidosauto */
/////////////////////////////////////////////////////////////////
//// PEDIDOS_AUTO ///////////////////////////////////////////////
class pedidosauto extends fluxEcommerce {
	function pedidosauto( context ) { fluxEcommerce ( context ); }
	function beforeCommit_pedidosprov(curPedido:FLSqlCursor):Boolean {
		return this.ctx.pedidosauto_beforeCommit_pedidosprov(curPedido);
	}
	function cambiarStockOrd(referencia:String, variacion:Number):Boolean {
		return this.ctx.pedidosauto_cambiarStockOrd(referencia, variacion);
	}
}
//// PEDIDOS_AUTO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
class lotes extends pedidosauto {
	function lotes( context ) { pedidosauto ( context ); }
	function beforeCommit_lineasfacturasprov(curLF:FLSqlCursor):Boolean {
		return this.ctx.lotes_beforeCommit_lineasfacturasprov(curLF);
	}
	function beforeCommit_lineasfacturascli(curLF:FLSqlCursor):Boolean {
		return this.ctx.lotes_beforeCommit_lineasfacturascli(curLF);
	}
}
//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration proveed */
/////////////////////////////////////////////////////////////////
//// PROVEED ////////////////////////////////////////////////////
class proveed extends lotes {
	function proveed( context ) { lotes ( context ); }
	function datosConceptoAsiento(cur:FLSqlCursor):Array {
		return this.ctx.proveed_datosConceptoAsiento(cur);
	}
}
//// PROVEED ////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration funServiciosCli */
/////////////////////////////////////////////////////////////////
//// SERVICIOS CLI //////////////////////////////////////////////
class funServiciosCli extends proveed {
	function funServiciosCli( context ) { proveed ( context ); }
	function afterCommit_albaranescli(curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.funServiciosCli_afterCommit_albaranescli(curAlbaran);
	}
}
//// SERVICIOS CLI //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration funNumSerie */
//////////////////////////////////////////////////////////////////
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////////
class funNumSerie extends funServiciosCli {
	function funNumSerie( context ) { funServiciosCli( context ); } 
	function afterCommit_lineasalbaranesprov(curLA:FLSqlCursor):Boolean {
		return this.ctx.funNumSerie_afterCommit_lineasalbaranesprov(curLA);
	}
	function afterCommit_lineasfacturasprov(curLF:FLSqlCursor):Boolean {
		return this.ctx.funNumSerie_afterCommit_lineasfacturasprov(curLF);
	}
	function afterCommit_lineasalbaranescli(curLA:FLSqlCursor):Boolean {
		return this.ctx.funNumSerie_afterCommit_lineasalbaranescli(curLA);
	}
	function afterCommit_lineasfacturascli(curLF:FLSqlCursor):Boolean {
		return this.ctx.funNumSerie_afterCommit_lineasfacturascli(curLF);
	}
	function beforeCommit_lineasfacturascli(curLF:FLSqlCursor):Boolean {
		return this.ctx.funNumSerie_beforeCommit_lineasfacturascli(curLF);
	}
	function beforeCommit_lineasfacturasprov(curLF:FLSqlCursor):Boolean {
		return this.ctx.funNumSerie_beforeCommit_lineasfacturasprov(curLF);
	}
	function actualizarLineaPedidoCli(idLineaPedido:Number, idPedido:Number, referencia:String, idAlbaran:Number, cantidadLineaAlbaran:Number):Boolean {
		return this.ctx.funNumSerie_actualizarLineaPedidoCli(idLineaPedido, idPedido, referencia, idAlbaran, cantidadLineaAlbaran);
	}
	function actualizarLineaPedidoProv(idLineaPedido:Number, idPedido:Number, referencia:String, idAlbaran:Number, cantidadLineaAlbaran:Number):Boolean {
		return this.ctx.funNumSerie_actualizarLineaPedidoProv(idLineaPedido, idPedido, referencia, idAlbaran, cantidadLineaAlbaran);
	}
}
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration nsServicios */
//////////////////////////////////////////////////////////////////
//// NS_SERVICIOS /////////////////////////////////////////////////////
class nsServicios extends funNumSerie {
	function nsServicios( context ) { funNumSerie( context ); } 	
	function afterCommit_lineasservicioscli(curLS:FLSqlCursor):Boolean {
		return this.ctx.nsServicios_afterCommit_lineasservicioscli(curLS);
	}
}
//// NS_SERVICIOS /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration funNumServAcomp */
//////////////////////////////////////////////////////////////////
//// FUN_NUM_SERV_ACOMP /////////////////////////////////////////////////////

class funNumServAcomp extends nsServicios {
	function funNumServAcomp( context ) { nsServicios( context ); } 	
	function afterCommit_lineasserviciosclins(curL:FLSqlCursor):Boolean {
		return this.ctx.funNumAcomp_afterCommit_lineasserviciosclins(curL);
	}
}

//// FUN_NUM_SERV_ACOMP /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration funNumAcomp */
//////////////////////////////////////////////////////////////////
//// FUN_NUM_ACOMP /////////////////////////////////////////////////////

class funNumAcomp extends funNumServAcomp {
	function funNumAcomp( context ) { funNumServAcomp( context ); } 	
	function afterCommit_lineasalbaranesclins(curL:FLSqlCursor):Boolean {
		return this.ctx.funNumAcomp_afterCommit_lineasalbaranesclins(curL);
	}
	function afterCommit_lineasfacturasclins(curL:FLSqlCursor):Boolean {
		return this.ctx.funNumAcomp_afterCommit_lineasfacturasclins(curL);
	}
}

//// FUN_NUM_ACOMP /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration factPeriodica */
//////////////////////////////////////////////////////////////////
//// FACTURACION_PERIODICA /////////////////////////////////////////////////////
class factPeriodica extends funNumAcomp {
	function factPeriodica( context ) { funNumAcomp( context ); } 
	function afterCommit_facturascli(curFactura:FLSqlCursor):Boolean {
		return this.ctx.factPeriodica_afterCommit_facturascli(curFactura);
	}
	function beforeCommit_periodoscontratos(curFactura:FLSqlCursor):Boolean {
		return this.ctx.factPeriodica_beforeCommit_periodoscontratos(curFactura);
	}
}
//// FACTURACION_PERIODICA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration numeroSecuencia */
//////////////////////////////////////////////////////////////////
//// NUMERO SECUENCIA ////////////////////////////////////////////
class numeroSecuencia extends factPeriodica {
	function numeroSecuencia( context ) { factPeriodica( context ); } 
	function recalcularHuecos(serie:String, ejercicio:String, fN:String):Boolean {
		return this.ctx.numeroSecuencia_recalcularHuecos(serie, ejercicio, fN);
	}
}
//// NUMERO SECUENCIA ////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration lineasArticulos */
/////////////////////////////////////////////////////////////////
//// LINEAS_ARTICULOS ///////////////////////////////////////////
class lineasArticulos extends numeroSecuencia {
	function lineasArticulos( context ) { numeroSecuencia ( context ); }

	function afterCommit_lineaspedidoscli(curLP:FLSqlCursor):Boolean {
		return this.ctx.lineasArticulos_afterCommit_lineaspedidoscli(curLP);
	}
	function afterCommit_lineaspedidosprov(curLP:FLSqlCursor):Boolean {
		return this.ctx.lineasArticulos_afterCommit_lineaspedidosprov(curLP);
	}
	function afterCommit_lineasalbaranescli(curLA:FLSqlCursor):Boolean {
		return this.ctx.lineasArticulos_afterCommit_lineasalbaranescli(curLA);
	}
	function afterCommit_lineasalbaranesprov(curLA:FLSqlCursor):Boolean {
		return this.ctx.lineasArticulos_afterCommit_lineasalbaranesprov(curLA);
	}
	function afterCommit_lineasfacturascli(curLF:FLSqlCursor):Boolean {
		return this.ctx.lineasArticulos_afterCommit_lineasfacturascli(curLF);
	}
	function afterCommit_lineasfacturasprov(curLF:FLSqlCursor):Boolean {
		return this.ctx.lineasArticulos_afterCommit_lineasfacturasprov(curLF);
	}

	function generarLineaSalida(documento:String, curLS:FLSqlCursor):Boolean {
		return this.ctx.lineasArticulos_generarLineaSalida(documento, curLS);
	}
	function borrarLineaSalida(curLS:FLSqlCursor, nombreIdLinea:String, nombreIdTabla:String) {
		return this.ctx.lineasArticulos_borrarLineaSalida(curLS, nombreIdLinea, nombreIdTabla);
	}
	function controlLineaSalidaAutomatica(documento:String, curLS:FLSqlCursor) {
		return this.ctx.lineasArticulos_controlLineaSalidaAutomatica(documento, curLS);
	}

	function generarLineaEntrada(documento:String, curLE:FLSqlCursor):Boolean {
		return this.ctx.lineasArticulos_generarLineaEntrada(documento, curLE);
	}
	function borrarLineaEntrada(curLE:FLSqlCursor, nombreIdLinea:String, nombreIdTabla:String) {
		return this.ctx.lineasArticulos_borrarLineaEntrada(curLE, nombreIdLinea, nombreIdTabla);
	}
	function controlLineaEntradaAutomatica(documento:String, curLE:FLSqlCursor) {
		return this.ctx.lineasArticulos_controlLineaEntradaAutomatica(documento, curLE);
	}
}
//// LINEAS_ARTICULOS ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ganancias */
/////////////////////////////////////////////////////////////////
//// GANANCIAS //////////////////////////////////////////////////
class ganancias extends lineasArticulos {
	function ganancias( context ) { lineasArticulos ( context ); }

	function beforeCommit_lineaspresupuestoscli(curLP:FLSqlCursor):Boolean {
		return this.ctx.ganancias_beforeCommit_lineaspresupuestoscli(curLP);
	}
	function beforeCommit_lineaspedidoscli(curLP:FLSqlCursor):Boolean {
		return this.ctx.ganancias_beforeCommit_lineaspedidoscli(curLP);
	}
	function beforeCommit_lineasalbaranescli(curLA:FLSqlCursor):Boolean {
		return this.ctx.ganancias_beforeCommit_lineasalbaranescli(curLA);
	}
	function beforeCommit_lineasfacturascli(curLF:FLSqlCursor):Boolean {
		return this.ctx.ganancias_beforeCommit_lineasfacturascli(curLF);
	}
	function beforeCommit_presupuestoscli(curPresupuesto:FLSqlCursor):Boolean {
		return this.ctx.ganancias_beforeCommit_presupuestoscli(curPresupuesto);
	}
	function beforeCommit_pedidoscli(curPedido:FLSqlCursor):Boolean {
		return this.ctx.ganancias_beforeCommit_pedidoscli(curPedido);
	}
	function beforeCommit_albaranescli(curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.ganancias_beforeCommit_albaranescli(curAlbaran);
	}
	function beforeCommit_facturascli(curFactura:FLSqlCursor):Boolean {
		return this.ctx.ganancias_beforeCommit_facturascli(curFactura);
	}

	function obtenerGananciaLinea(lineaDoc:FLSqlCursor, doc:String):Boolean {
		return this.ctx.ganancias_obtenerGananciaLinea(lineaDoc, doc);
	}
	function obtenerGanancia(doc:FLSqlCursor, linea:String):Boolean {
		return this.ctx.ganancias_obtenerGanancia(doc, linea);
	}
}
//// GANANCIAS //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration costos */
/////////////////////////////////////////////////////////////////
//// COSTOS /////////////////////////////////////////////////
class costos extends ganancias {
	function costos( context ) { ganancias ( context ); }
	function afterCommit_lineasfacturasprov(curLF:FLSqlCursor):Boolean {
		return this.ctx.costos_afterCommit_lineasfacturasprov(curLF);
	}
}
//// COSTOS /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration controlUsuario */
/////////////////////////////////////////////////////////////////
//// CONTROL_USUARIO ////////////////////////////////////////////
class controlUsuario extends costos {
    function controlUsuario( context ) { costos ( context ); }

	function beforeCommit_presupuestoscli(curPresupuesto:FLSqlCursor):Boolean {
		return this.ctx.controlUsuario_beforeCommit_presupuestoscli(curPresupuesto);
	}
	function beforeCommit_pedidoscli(curPedido:FLSqlCursor):Boolean {
		return this.ctx.controlUsuario_beforeCommit_pedidoscli(curPedido);
	}
	function beforeCommit_albaranescli(curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.controlUsuario_beforeCommit_albaranescli(curAlbaran);
	}
	function beforeCommit_facturascli(curFactura:FLSqlCursor):Boolean {
		return this.ctx.controlUsuario_beforeCommit_facturascli(curFactura);
	}
	function beforeCommit_servicioscli(curServicio:FLSqlCursor):Boolean {
		return this.ctx.controlUsuario_beforeCommit_servicioscli(curServicio);
	}
	function beforeCommit_contratos(curContrato:FLSqlCursor):Boolean {
		return this.ctx.controlUsuario_beforeCommit_contratos(curContrato);
	}
	function beforeCommit_pedidosprov(curPedido:FLSqlCursor):Boolean {
		return this.ctx.controlUsuario_beforeCommit_pedidosprov(curPedido);
	}
	function beforeCommit_albaranesprov(curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.controlUsuario_beforeCommit_albaranesprov(curAlbaran);
	}
	function beforeCommit_facturasprov(curFactura:FLSqlCursor):Boolean {
		return this.ctx.controlUsuario_beforeCommit_facturasprov(curFactura);
	}
	function beforeCommit_pedidosaut(curPedido:FLSqlCursor):Boolean {
		return this.ctx.controlUsuario_beforeCommit_pedidosaut(curPedido);
	}
}
//// CONTROL_USUARIO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration silixExtensiones */
/////////////////////////////////////////////////////////////////
//// SILIX EXTENSIONES //////////////////////////////////////////
class silixExtensiones extends controlUsuario {
    function silixExtensiones( context ) { controlUsuario ( context ); }
	function afterCommit_facturascli(curFactura:FLSqlCursor):Boolean {
		return this.ctx.silixExtensiones_afterCommit_facturascli(curFactura);
	}
	function beforeCommit_albaranescli(curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.silixExtensiones_beforeCommit_albaranescli(curAlbaran);
	}
	function afterCommit_lineasfacturascli(curLF:FLSqlCursor):Boolean {
		return this.ctx.silixExtensiones_afterCommit_lineasfacturascli(curLF);
	}
	function actualizarLineaAlbaranCli(idLineaAlbaran:Number, idAlbaran:Number, referencia:String, idFactura:Number, cantidadLineaFactura:Number):Boolean {
		return this.ctx.silixExtensiones_actualizarLineaAlbaranCli(idLineaAlbaran, idAlbaran, referencia, idFactura, cantidadLineaFactura);
	}
	function actualizarEstadoAlbaranCli(idAlbaran:Number, curFactura:FLSqlCursor):Boolean {
		return this.ctx.silixExtensiones_actualizarEstadoAlbaranCli(idAlbaran, curFactura);
	}
	function obtenerEstadoAlbaranCli(idAlbaran:Number):String {
		return this.ctx.silixExtensiones_obtenerEstadoAlbaranCli(idAlbaran);
	}
	function actualizarAlbaranesLineaFacturaCli(curLF:FLSqlCursor):Boolean {
		return this.ctx.silixExtensiones_actualizarAlbaranesLineaFacturaCli(curLF);
	}
	function restarCantidadAlbaranCli(idLineaAlbaran:Number, idLineaFactura:Number):Boolean {
		return this.ctx.silixExtensiones_restarCantidadAlbaranCli(idLineaAlbaran, idLineaFactura);
	}
	function generarRecibos(curFactura:FLSqlCursor):Boolean {
		return this.ctx.silixExtensiones_generarRecibos(curFactura);
	}
	function emitirReciboComo(codPago:String):String {
		return this.ctx.silixExtensiones_emitirReciboComo(codPago);
	}
	function generarRecibo(curFactura:FLSqlCursor, datosRecibo:Array):Number {
		return this.ctx.silixExtensiones_generarRecibo(curFactura, datosRecibo);
	}
	function pagarRecibo(idRecibo:String, datosRecibo:Array, tabla:String):Boolean {
		return this.ctx.silixExtensiones_pagarRecibo(idRecibo, datosRecibo, tabla);
	}
}
//// SILIX EXTENSIONES //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pieDocumento */
/////////////////////////////////////////////////////////////////
//// PIE DE DOCUMENTO ///////////////////////////////////////////
class pieDocumento extends silixExtensiones {
	function pieDocumento( context ) { silixExtensiones ( context ); }
	function generarAsientoFacturaCli(curFactura:FLSqlCursor):Boolean {
		return this.ctx.pieDocumento_generarAsientoFacturaCli(curFactura);
	}
	function generarAsientoFacturaProv(curFactura:FLSqlCursor):Boolean {
		return this.ctx.pieDocumento_generarAsientoFacturaProv(curFactura);
	}
	function generarPartidasCompra(curFactura:FLSqlCursor, idAsiento:Number, valoresDefecto:Array, concepto:String):Boolean {
		return this.ctx.pieDocumento_generarPartidasCompra(curFactura, idAsiento, valoresDefecto, concepto);
	}
	function generarPartidasPieFacturascli(curFactura:FLSqlCursor, idAsiento:Number, valoresDefecto:Array):Boolean {
		return this.ctx.pieDocumento_generarPartidasPieFacturascli(curFactura, idAsiento, valoresDefecto);
	}
	function generarPartidasPieFacturasprov(curFactura:FLSqlCursor, idAsiento:Number, valoresDefecto:Array, concepto:String):Boolean {
		return this.ctx.pieDocumento_generarPartidasPieFacturasprov(curFactura, idAsiento, valoresDefecto, concepto);
	}
}
//// PIE DE DOCUMENTO  //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends pieDocumento {
    function head( context ) { pieDocumento( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
	function ifaceCtx( context ) { head( context ); }
	function pub_cerosIzquierda(numero:String, totalCifras:Number):String {
		return this.cerosIzquierda(numero, totalCifras);
	}
	function pub_asientoBorrable(idAsiento:Number):Boolean {
		return this.asientoBorrable(idAsiento);
	}
	function pub_regenerarAsiento(cur:FLSqlCursor, valoresDefecto:Array):Array {
		return this.regenerarAsiento(cur, valoresDefecto);
	}
	function pub_datosCtaEspecial(ctaEsp:String, codEjercicio:String):Array {
		return this.datosCtaEspecial(ctaEsp, codEjercicio);
	}
	function pub_siguienteNumero(codSerie:String, codEjercicio:String, fN:String):Number {
		return this.siguienteNumero(codSerie, codEjercicio, fN);
	}
	function pub_construirCodigo(codSerie:String, codEjercicio:String, numero:String):String {
		return this.construirCodigo(codSerie, codEjercicio, numero);
	}
	function pub_agregarHueco(serie:String, ejercicio:String, numero:Number, fN:String):Boolean {
		return this.agregarHueco(serie, ejercicio, numero, fN);
	}
	function pub_datosDocFacturacion(fecha:String, codEjercicio:String, tipoDoc:String):Array {
		return this.datosDocFacturacion(fecha, codEjercicio, tipoDoc);
	}
	function pub_tieneIvaDocCliente(codSerie:String, codCliente:String, codEjercicio:String):Boolean {
		return this.tieneIvaDocCliente(codSerie, codCliente, codEjercicio);
	}
	function pub_tieneIvaDocProveedor(codSerie:String, codProveedor:String, codEjercicio:String):Boolean {
		return this.tieneIvaDocProveedor(codSerie, codProveedor, codEjercicio);
	}
	function pub_automataActivado():Boolean {
		return this.automataActivado();
	}
	function pub_generarAsientoFacturaCli(curFactura:FLSqlCursor):Boolean {
		return this.generarAsientoFacturaCli(curFactura);
	}
	function pub_generarAsientoFacturaProv(curFactura:FLSqlCursor):Boolean {
		return this.generarAsientoFacturaProv(curFactura);
	}
	function pub_mostrarTraza(codigo:String, tipo:String) {
		return this.mostrarTraza(codigo, tipo);
	}
	function pub_eliminarAsiento(idAsiento:String):Boolean {
		return this.eliminarAsiento(idAsiento);
	}
	function pub_validarIvaCliente(codCliente:String,id:Number,tabla:String,identificador:String):Boolean {
		return this.validarIvaCliente(codCliente,id,tabla,identificador);
	}
	function pub_validarIvaProveedor(codProveedor:String,id:Number,tabla:String,identificador:String):Boolean {
		return this.validarIvaProveedor(codProveedor,id,tabla,identificador);
	}
	function pub_subcuentaVentas(referencia:String, codEjercicio:String):Array {
		return this.subcuentaVentas(referencia, codEjercicio);
	}
	function pub_regimenIVACliente(curDocCliente:FLSqlCursor):String {
		return this.regimenIVACliente(curDocCliente);
	}
	function pub_actualizarEstadoPedidoCli(idPedido:Number, curAlbaran:FLSqlCursor):Boolean {
		return this.actualizarEstadoPedidoCli(idPedido, curAlbaran);
	}
	function pub_actualizarEstadoPedidoProv(idPedido:Number, curAlbaran:FLSqlCursor):Boolean {
		return this.actualizarEstadoPedidoProv(idPedido, curAlbaran);
	}
	function pub_actualizarEstadoAlbaranCli(idAlbaran:Number, curFactura:FLSqlCursor):Boolean {
		return this.actualizarEstadoAlbaranCli(idAlbaran, curFactura);
	}
	function pub_aplicarComisionLineas(codAgente:String,tblHija:String,where:String):Boolean {
		return this.aplicarComisionLineas(codAgente,tblHija,where);
	}
	function pub_calcularComisionLinea(codAgente:String,referencia:String):Number {
		return this.calcularComisionLinea(codAgente,referencia);
	}
}
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubPedAuto */
/////////////////////////////////////////////////////////////////
//// PUB_PEDIDOSAUTO ///////////////////////////////////////////////
class pubPedAuto extends ifaceCtx {
	function pubPedAuto( context ) { ifaceCtx ( context ); }
	function pub_cambiarStockOrd(referencia:String, variacion:Number):Boolean {
		return this.cambiarStockOrd(referencia, variacion);
	}
}
//// PUB_PEDIDOSAUTO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubGanancias */
/////////////////////////////////////////////////////////////////
//// PUB_GANANCIAS //////////////////////////////////////////////
class pubGanancias extends pubPedAuto {
	function pubGanancias( context ) { pubPedAuto ( context ); }
	function pub_obtenerGananciaLinea(lineaDoc:FLSqlCursor, doc:String):Boolean {
		return this.obtenerGananciaLinea(lineaDoc, doc);
	}
	function pub_obtenerGanancia(doc:FLSqlCursor, linea:String):Boolean {
		return this.obtenerGanancia(doc, linea);
	}
}
//// PUB_GANANCIAS //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

const iface = new pubGanancias( this );

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
/** \C 
Se calcula el número del pedido como el siguiente de la secuencia asociada a su ejercicio y serie. 

Se actualiza el estado del pedido.

Si el pedido está servido parcialmente y se quiere borrar, no se permite borrarlo o se dá la opción de cancelar lo pendiente de servir.
\end */
function interna_beforeCommit_pedidoscli(curPedido:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	var numero:String;
	
	switch (curPedido.modeAccess()) {
		case curPedido.Insert: {
			if (!flfactppal.iface.pub_clienteActivo(curPedido.valueBuffer("codcliente"), curPedido.valueBuffer("fecha")))
				return false;
			if (curPedido.valueBuffer("numero") == 0) {
				numero = this.iface.siguienteNumero(curPedido.valueBuffer("codserie"), curPedido.valueBuffer("codejercicio"), "npedidocli");
				if (!numero)
					return false;
				curPedido.setValueBuffer("numero", numero);
				curPedido.setValueBuffer("codigo", formpedidoscli.iface.pub_commonCalculateField("codigo", curPedido));
			}
			break;
		}
		case curPedido.Edit: {
			if(!this.iface.comprobarCambioSerie(curPedido))
				return false;
			if (!flfactppal.iface.pub_clienteActivo(curPedido.valueBuffer("codcliente"), curPedido.valueBuffer("fecha")))
				return false;
			if (curPedido.valueBuffer("servido") == "Parcial") {
				var estado:String = this.iface.obtenerEstadoPedidoCli(curPedido.valueBuffer("idpedido"));
				if (estado == "Sí") {
					curPedido.setValueBuffer("servido", estado);
					curPedido.setValueBuffer("editable", false);
				}
			}
			break;
		}
		case curPedido.Del: {
			if (curPedido.valueBuffer("servido") == "Parcial") {
				MessageBox.warning(util.translate("scripts", "No se puede eliminar un pedido servido parcialmente.\nDebe borrar antes el remito relacionado."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
			}
			break;
		}
	}

	if (curPedido.modeAccess() == curPedido.Insert || curPedido.modeAccess() == curPedido.Edit) {
		while (util.sqlSelect("pedidoscli", "idpedido", "codejercicio = '" + curPedido.valueBuffer("codejercicio") + "' AND codserie = '" + curPedido.valueBuffer("codserie") + "' AND numero = '" + curPedido.valueBuffer("numero") + "' AND idpedido <> " + curPedido.valueBuffer("idpedido"))) {
			numero = this.iface.siguienteNumero(curPedido.valueBuffer("codserie"), curPedido.valueBuffer("codejercicio"), "npedidocli");
			if (!numero)
				return false;
			curPedido.setValueBuffer("numero", numero);
			curPedido.setValueBuffer("codigo", formpedidoscli.iface.pub_commonCalculateField("codigo", curPedido));
		}
	}

	return true;
}

/** \C 
Si se borra la linea de remito se actualiza la línea y el estado del pedido asociado a la misma.
\end */
function interna_beforeCommit_lineasalbaranescli(curLinea:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	
	switch (curLinea.modeAccess()) {
		case curLinea.Del: {
			break;
		}
	}
	return true;
}


/** \C 
Se calcula el número del pedido como el siguiente de la secuencia asociada a su ejercicio y serie. 

Se actualiza el estado del pedido.

Si el pedido está servido parcialmente y se quiere borrar, no se permite borrarlo o se dá la opción de cancelar lo pendiente de servir.
\end */
function interna_beforeCommit_pedidosprov(curPedido:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	var numero:String;
	
	switch (curPedido.modeAccess()) {
		case curPedido.Insert: {
			if (curPedido.valueBuffer("numero") == 0) {
				numero = this.iface.siguienteNumero(curPedido.valueBuffer("codserie"), curPedido.valueBuffer("codejercicio"), "npedidoprov");
				if (!numero)
					return false;
				curPedido.setValueBuffer("numero", numero);
				curPedido.setValueBuffer("codigo", formpedidosprov.iface.pub_commonCalculateField("codigo", curPedido));
			}
			break;
		}
		case curPedido.Edit: {
			if(!this.iface.comprobarCambioSerie(curPedido))
				return false;
			if (curPedido.valueBuffer("servido") == "Parcial") {
				var estado:String = this.iface.obtenerEstadoPedidoProv(curPedido.valueBuffer("idpedido"));
				if (estado == "Sí") {
					curPedido.setValueBuffer("servido", estado);
					curPedido.setValueBuffer("editable", false);
					if (sys.isLoadedModule("flcolaproc")) {
						if (!flfactppal.iface.pub_lanzarEvento(curPedido, "pedidoProvAlbaranado"))
							return false;
					}
				}
			}
			break;
		}
		case curPedido.Del: {
			if (curPedido.valueBuffer("servido") == "Parcial") {
				MessageBox.warning(util.translate("scripts", "No se puede eliminar un pedido servido parcialmente.\nDebe borrar antes el remito relacionado."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
			}
			break;
		}
	}
	return true;
}

/* \C En el caso de que el módulo de contabilidad esté cargado y activado, genera o modifica el asiento contable correspondiente a la factura a cliente.
\end */
function interna_beforeCommit_facturascli(curFactura:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	var numero:String;
	
	if (curFactura.modeAccess() == curFactura.Insert || curFactura.modeAccess() == curFactura.Edit) {
		if (!this.iface.comprobarNotaCreditoCli(curFactura)) {
			return false;
		}
		if (!this.iface.comprobarNotaDebitoCli(curFactura)) {
			return false;
		}
	}

	switch (curFactura.modeAccess()) {
		case curFactura.Insert: {
			if (!flfactppal.iface.pub_clienteActivo(curFactura.valueBuffer("codcliente"), curFactura.valueBuffer("fecha")))
				return false;
			if (!flfactteso.iface.pub_cuentaActiva(curFactura))
				return false;
			if (curFactura.valueBuffer("numero") == 0) {
				this.iface.recalcularHuecos( curFactura.valueBuffer("codserie"), curFactura.valueBuffer("codejercicio"), "nfacturacli" );
				numero = this.iface.siguienteNumero(curFactura.valueBuffer("codserie"), curFactura.valueBuffer("codejercicio"), "nfacturacli");
				if (!numero)
					return false;
				curFactura.setValueBuffer("numero", numero);
				curFactura.setValueBuffer("codigo", formfacturascli.iface.pub_commonCalculateField("codigo", curFactura));
			}
			break;
		}
		case curFactura.Edit: {
			if(!this.iface.comprobarCambioSerie(curFactura))
				return false;
			if (!flfactppal.iface.pub_clienteActivo(curFactura.valueBuffer("codcliente"), curFactura.valueBuffer("fecha")))
				return false;
			if (formRecordfacturascli.iface.pub_modoAcceso() == 0) {
				if (!flfactteso.iface.pub_cuentaActiva(curFactura))
					return false;
			}
			break;
		}
	}

	if (curFactura.modeAccess() == curFactura.Insert || curFactura.modeAccess() == curFactura.Edit) {
		while (util.sqlSelect("facturascli", "idfactura", "codejercicio = '" + curFactura.valueBuffer("codejercicio") + "' AND codserie = '" + curFactura.valueBuffer("codserie") + "' AND numero = '" + curFactura.valueBuffer("numero") + "' AND idfactura <> " + curFactura.valueBuffer("idfactura"))) {
			numero = this.iface.siguienteNumero(curFactura.valueBuffer("codserie"), curFactura.valueBuffer("codejercicio"), "nfacturacli");
			if (!numero)
				return false;
			curFactura.setValueBuffer("numero", numero);
			curFactura.setValueBuffer("codigo", formfacturascli.iface.pub_commonCalculateField("codigo", curFactura));
		}
	}

	if (curFactura.modeAccess() == curFactura.Edit) {
		if (!formRecordfacturascli.iface.pub_actualizarLineasIva(curFactura)) {
			return false;
		}
	}

	if (curFactura.modeAccess() == curFactura.Insert || curFactura.modeAccess() == curFactura.Edit) {
		if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada")) {
			if (this.iface.generarAsientoFacturaCli(curFactura) == false) {
				return false;
			}
		}
	}
	return true;
}

/* \C En el caso de que el módulo de contabilidad esté cargado y activado, genera o modifica el asiento contable correspondiente a la factura a proveedor.
\end */
function interna_beforeCommit_facturasprov(curFactura:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	var numero:String;

	if (curFactura.modeAccess() == curFactura.Insert || curFactura.modeAccess() == curFactura.Edit) {
		if (!this.iface.comprobarNotaCreditoProv(curFactura)) {
			return false;
		}
		if (!this.iface.comprobarNotaDebitoProv(curFactura)) {
			return false;
		}
	}

	if (curFactura.modeAccess() == curFactura.Edit) {
		if (!this.iface.comprobarCambioSerie(curFactura)) {
			return false;
		}
	}
	if (curFactura.modeAccess() == curFactura.Insert) {
		if (curFactura.valueBuffer("numero") == 0) {
			this.iface.recalcularHuecos( curFactura.valueBuffer("codserie"), curFactura.valueBuffer("codejercicio"), "nfacturaprov" );
			numero = this.iface.siguienteNumero(curFactura.valueBuffer("codserie"), curFactura.valueBuffer("codejercicio"), "nfacturaprov");
			if (!numero)
				return false;
			curFactura.setValueBuffer("numero", numero);
			curFactura.setValueBuffer("codigo", formfacturasprov.iface.pub_commonCalculateField("codigo", curFactura));
		}
	}

	if (curFactura.modeAccess() == curFactura.Insert || curFactura.modeAccess() == curFactura.Edit) {
		if (util.sqlSelect("facturasprov", "idfactura", "codejercicio = '" + curFactura.valueBuffer("codejercicio") + "' AND codserie = '" + curFactura.valueBuffer("codserie") + "' AND numero = '" + curFactura.valueBuffer("numero") + "' AND idfactura <> " + curFactura.valueBuffer("idfactura"))) {
			numero = this.iface.siguienteNumero(curFactura.valueBuffer("codserie"), curFactura.valueBuffer("codejercicio"), "nfacturaprov");
			if (!numero)
				return false;
			curFactura.setValueBuffer("numero", numero);
			curFactura.setValueBuffer("codigo", formfacturasprov.iface.pub_commonCalculateField("codigo", curFactura));
		}
	}

	if (curFactura.modeAccess() == curFactura.Edit) {
		if (!formRecordfacturasprov.iface.pub_actualizarLineasIva(curFactura)) {
			return false;
		}
	}

	if (curFactura.modeAccess() == curFactura.Insert || curFactura.modeAccess() == curFactura.Edit) {
		if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada")) {
			if (this.iface.generarAsientoFacturaProv(curFactura) == false) {
				return false;
			}
		}
	}
	return true;
}


/* \C Se calcula el número del remito como el siguiente de la secuencia asociada a su ejercicio y serie. 
Se recalcula el estado de los pedidos asociados al remito
\end */
function interna_beforeCommit_albaranescli(curAlbaran:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	var numero:String;
	
	switch (curAlbaran.modeAccess()) {
		case curAlbaran.Insert: {
			if (!flfactppal.iface.pub_clienteActivo(curAlbaran.valueBuffer("codcliente"), curAlbaran.valueBuffer("fecha")))
				return false;
			if (curAlbaran.valueBuffer("numero") == 0) {
				numero = this.iface.siguienteNumero(curAlbaran.valueBuffer("codserie"), curAlbaran.valueBuffer("codejercicio"), "nalbarancli");
				if (!numero)
					return false;
				curAlbaran.setValueBuffer("numero", numero);
				curAlbaran.setValueBuffer("codigo", formalbaranescli.iface.pub_commonCalculateField("codigo", curAlbaran));
			}
			break;
		}
		case curAlbaran.Edit: {
			if(!this.iface.comprobarCambioSerie(curAlbaran)) {
				return false;
			}
			if (!flfactppal.iface.pub_clienteActivo(curAlbaran.valueBuffer("codcliente"), curAlbaran.valueBuffer("fecha"))) {
				return false;
			}
// 			if(!this.iface.actualizarPedidosCli(curAlbaran)) {
// 				return false;
// 			}
			break;
		}
		case curAlbaran.Del: {
			break;
		}
	}

	if (curAlbaran.modeAccess() == curAlbaran.Insert || curAlbaran.modeAccess() == curAlbaran.Edit) {
		while (util.sqlSelect("albaranescli", "idalbaran", "codejercicio = '" + curAlbaran.valueBuffer("codejercicio") + "' AND codserie = '" + curAlbaran.valueBuffer("codserie") + "' AND numero = '" + curAlbaran.valueBuffer("numero") + "' AND idalbaran <> " + curAlbaran.valueBuffer("idalbaran"))) {
			numero = this.iface.siguienteNumero(curAlbaran.valueBuffer("codserie"), curAlbaran.valueBuffer("codejercicio"), "nalbarancli");
			if (!numero)
				return false;
			curAlbaran.setValueBuffer("numero", numero);
			curAlbaran.setValueBuffer("codigo", formalbaranescli.iface.pub_commonCalculateField("codigo", curAlbaran));
		}
	}

	return true;
}

/** \C Si el remito se borra se actualizan los pedidos asociados
\end */
function interna_afterCommit_albaranescli(curAlbaran:FLSqlCursor):Boolean
{
	switch (curAlbaran.modeAccess()) {
		case curAlbaran.Del: {
// 			if (!this.iface.liberarPedidosCli(curAlbaran)) {
// 				return false;
// 			}
			break;
		}
	}
	return true;
}

/** \C Si el remito se borra se actualizan los pedidos asociados
\end */
function interna_afterCommit_albaranesprov(curAlbaran:FLSqlCursor):Boolean
{
	switch (curAlbaran.modeAccess()) {
		case curAlbaran.Del: {
// 			if (!this.iface.liberarPedidosProv(curAlbaran)) {
// 				return false;
// 			}
			break;
		}
	}
	return true;
}


/* \C Se calcula el número del remito como el siguiente de la secuencia asociada a su ejercicio y serie. 

Se recalcula el estado de los pedidos asociados al remito
\end */
function interna_beforeCommit_albaranesprov(curAlbaran:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	var numero:String;
	
	switch (curAlbaran.modeAccess()) {
		case curAlbaran.Insert: {
			if (curAlbaran.valueBuffer("numero") == 0) {
				numero = this.iface.siguienteNumero(curAlbaran.valueBuffer("codserie"), curAlbaran.valueBuffer("codejercicio"), "nalbaranprov");
				if (!numero)
					return false;
				curAlbaran.setValueBuffer("numero", numero);
				curAlbaran.setValueBuffer("codigo", formalbaranesprov.iface.pub_commonCalculateField("codigo", curAlbaran));
			}
			break;
		}
		case curAlbaran.Edit: {
			if (!this.iface.comprobarCambioSerie(curAlbaran)) {
				return false;
			}
// 			if (!this.iface.actualizarPedidosProv(curAlbaran)) {
// 				return false;
// 			}
			break;
		}
	}

	return true;
}

/* \C Se calcula el número del presupuesto como el siguiente de la secuencia asociada a su ejercicio y serie. 
\end */
function interna_beforeCommit_presupuestoscli(curPresupuesto:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	var numero:String;
	
	switch (curPresupuesto.modeAccess()) {
		case curPresupuesto.Insert: {
			if (!flfactppal.iface.pub_clienteActivo(curPresupuesto.valueBuffer("codcliente"), curPresupuesto.valueBuffer("fecha")))
				return false;
			if (curPresupuesto.valueBuffer("numero") == 0) {
				numero = this.iface.siguienteNumero(curPresupuesto.valueBuffer("codserie"), curPresupuesto.valueBuffer("codejercicio"), "npresupuestocli");
				if (!numero)
					return false;
				curPresupuesto.setValueBuffer("numero", numero);
				curPresupuesto.setValueBuffer("codigo", formpresupuestoscli.iface.pub_commonCalculateField("codigo", curPresupuesto));
			}
			break;
		}
		case curPresupuesto.Edit: {
			if(!this.iface.comprobarCambioSerie(curPresupuesto))
				return false;
			if (!flfactppal.iface.pub_clienteActivo(curPresupuesto.valueBuffer("codcliente"), curPresupuesto.valueBuffer("fecha")))
				return false;
			break;
		}
	}

	if (curPresupuesto.modeAccess() == curPresupuesto.Insert || curPresupuesto.modeAccess() == curPresupuesto.Edit) {
		while (util.sqlSelect("presupuestoscli", "idpresupuesto", "codejercicio = '" + curPresupuesto.valueBuffer("codejercicio") + "' AND codserie = '" + curPresupuesto.valueBuffer("codserie") + "' AND numero = '" + curPresupuesto.valueBuffer("numero") + "' AND idpresupuesto <> " + curPresupuesto.valueBuffer("idpresupuesto"))) {
			numero = this.iface.siguienteNumero(curPresupuesto.valueBuffer("codserie"), curPresupuesto.valueBuffer("codejercicio"), "npresupuestocli");
			if (!numero)
				return false;
			curPresupuesto.setValueBuffer("numero", numero);
			curPresupuesto.setValueBuffer("codigo", formpresupuestoscli.iface.pub_commonCalculateField("codigo", curPresupuesto));
		}
	}

	return true;
}

/** \C Si el pedido se borra se actualiza el presupuesto asociado
\end */
function interna_afterCommit_pedidoscli(curPedido:FLSqlCursor):Boolean
{
	switch (curPedido.modeAccess()) {
		case curPedido.Del: {
			if (!this.iface.liberarPresupuestoCli(curPedido.valueBuffer("idpresupuesto"))) {
				return false;
			}
			break;
		}
	}
	return true;
}

/* \C En el caso de que el módulo de tesorería esté cargado, genera o modifica los recibos correspondientes a la factura.

En el caso de que el módulo pincipal de contabilidad esté cargado y activado, y que la acción a realizar sea la de borrado de la factura, borra el asiento contable correspondiente.
\end */
function interna_afterCommit_facturascli(curFactura:FLSqlCursor):Boolean
{
	switch (curFactura.modeAccess()) {
		case curFactura.Del: {
			if (!this.iface.agregarHueco(curFactura.valueBuffer("codserie"), curFactura.valueBuffer("codejercicio"), curFactura.valueBuffer("numero"), "nfacturacli")) {
				return false;
			}
			if (!this.iface.liberarAlbaranesCli(curFactura.valueBuffer("idfactura"))) {
				return false;
			}
			break;
		}
	}
	
	var util:FLUtil = new FLUtil();
	if (sys.isLoadedModule("flfactteso") && curFactura.valueBuffer("tpv") == false) {
		if (curFactura.modeAccess() == curFactura.Insert || curFactura.modeAccess() == curFactura.Edit) {
			if (this.iface.siGenerarRecibosCli(curFactura))
				if (flfactteso.iface.pub_regenerarRecibosCli(curFactura) == false)
					return false;
		}
		if (curFactura.modeAccess() == curFactura.Del) {
			flfactteso.iface.pub_actualizarRiesgoCliente(curFactura.valueBuffer("codcliente"));
		}
	}

	this.iface.controlFacturaRectificada(curFactura, "facturascli");

	if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada")) {
		switch (curFactura.modeAccess()) {
			case curFactura.Edit: {
				if (curFactura.valueBuffer("nogenerarasiento")) {
					var idAsientoAnterior:String = curFactura.valueBufferCopy("idasiento");
					if (idAsientoAnterior && idAsientoAnterior != "") {
						if (!this.iface.eliminarAsiento(idAsientoAnterior)) {
							return false;
						}
					}
				}
				break;
			}
			case curFactura.Del: {
				if (!this.iface.eliminarAsiento(curFactura.valueBuffer("idasiento"))) {
					return false;
				}
				break;
			}
		}
	}

	return true;
}

/* \C En el caso de que el módulo pincipal de contabilidad esté cargado y activado, y que la acción a realizar sea la de borrado de la factura, borra el asiento contable correspondiente.
\end */
function interna_afterCommit_facturasprov(curFactura:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (sys.isLoadedModule("flfactteso")) {
		if (curFactura.modeAccess() == curFactura.Insert || curFactura.modeAccess() == curFactura.Edit) {
			if (curFactura.valueBuffer("total") != curFactura.valueBufferCopy("total")
				|| curFactura.valueBuffer("codproveedor") != curFactura.valueBufferCopy("codproveedor")
				|| curFactura.valueBuffer("codpago") != curFactura.valueBufferCopy("codpago")
				|| curFactura.valueBuffer("fecha") != curFactura.valueBufferCopy("fecha")) {
				if (flfactteso.iface.pub_regenerarRecibosProv(curFactura) == false)
					return false;
			}
		}
	}

	switch (curFactura.modeAccess()) {
		case curFactura.Del: {
			if (!this.iface.liberarAlbaranesProv(curFactura.valueBuffer("idfactura"))) {
				return false;
			}
			break;
		}
	}

	this.iface.controlFacturaRectificada(curFactura, "facturasprov");

	if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada")) {
		switch (curFactura.modeAccess()) {
			case curFactura.Edit: {
				if (curFactura.valueBuffer("nogenerarasiento")) {
					var idAsientoAnterior:String = curFactura.valueBufferCopy("idasiento");
					if (idAsientoAnterior && idAsientoAnterior != "") {
						if (!this.iface.eliminarAsiento(idAsientoAnterior))
							return false;
					}
				}
				break;
			}
			case curFactura.Del: {
				if (!this.iface.eliminarAsiento(curFactura.valueBuffer("idasiento"))) {
					return false;
				}
				break;
			}
		}
	}
	return true;
}

/** \C
Actualización del stock correspondiente al artículo seleccionado en la línea
\end */
function interna_afterCommit_lineasalbaranesprov(curLA:FLSqlCursor):Boolean
{
	if (!this.iface.actualizarPedidosLineaAlbaranProv(curLA)) {
		return false;
	}

	if (sys.isLoadedModule("flfactalma")) {
		if (!flfactalma.iface.pub_controlStockAlbaranesProv(curLA)) {
			return false;
		}
	}
	return true;
}

/** \C
En el caso de que la factura no sea automática (no provenga de un remito), realiza la actualización del stock correspondiente al artículo seleccionado en la línea.

Actualiza también el coste medio de los artículos afectados por el cambio.
\end */
function interna_afterCommit_lineasfacturasprov(curLF:FLSqlCursor):Boolean
{
	if (sys.isLoadedModule("flfactalma")) {
		var util:FLUtil = new FLUtil();
		switch(curLF.modeAccess()) {
			case curLF.Edit:
				if (curLF.valueBuffer("referencia") != curLF.valueBufferCopy("referencia"))
					flfactalma.iface.pub_cambiarCosteMedio(curLF.valueBufferCopy("referencia"));
			case curLF.Insert:
			case curLF.Del:
					flfactalma.iface.pub_cambiarCosteMedio(curLF.valueBuffer("referencia"));
			break;
		}
		
		if (!flfactalma.iface.pub_controlStockFacturasProv(curLF))
			return false;
	}
	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea si el sistema
está configurado para ello
\end */
function interna_afterCommit_lineaspedidoscli(curLP:FLSqlCursor):Boolean
{
 	if (sys.isLoadedModule("flfactalma"))
		if (!flfactalma.iface.pub_controlStockPedidosCli(curLP))
			return false;
	
	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea si el sistema
está configurado para ello
\end */
function interna_afterCommit_lineaspedidosprov(curLP:FLSqlCursor):Boolean
{
 	if (sys.isLoadedModule("flfactalma")) {
		if (!flfactalma.iface.pub_controlStockPedidosProv(curLP)) {
			return false;
		}
	}
	return true;
}

/** \C
Si la línea de remito no proviene de una línea de pedido, realiza la actualización del stock correspondiente al artículo seleccionado en la línea
\end */
function interna_afterCommit_lineasalbaranescli(curLA:FLSqlCursor):Boolean
{
	if (!this.iface.actualizarPedidosLineaAlbaranCli(curLA)) {
		return false;
	}
		
	if (sys.isLoadedModule("flfactalma")) {
		if (!flfactalma.iface.pub_controlStockAlbaranesCli(curLA)) {
			return false;
		}
	}
	
	return true;
}

/** \C
En el caso de que la factura no sea automática (no provenga de un remito), realiza la actualización del stock correspondiente al artículo seleccionado en la línea
\end */
function interna_afterCommit_lineasfacturascli(curLF:FLSqlCursor):Boolean
{
	if (sys.isLoadedModule("flfactalma")) 
		if (!flfactalma.iface.pub_controlStockFacturasCli(curLF))
			return false;
	
	return true;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_actualizarPedidosLineaAlbaranCli(curLA:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var idLineaPedido:Number = parseFloat(curLA.valueBuffer("idlineapedido"));
	if (idLineaPedido == 0) {
		return true;
	}
	
	switch (curLA.modeAccess()) {
		case curLA.Insert: {
			if (!this.iface.actualizarLineaPedidoCli(curLA.valueBuffer("idlineapedido"), curLA.valueBuffer("idpedido") , curLA.valueBuffer("referencia"), curLA.valueBuffer("idalbaran"), curLA.valueBuffer("cantidad"))) {
				return false;
			}
			if (!this.iface.actualizarEstadoPedidoCli(curLA.valueBuffer("idpedido"), curLA)) {
				return false;
			}
			break;
		}
		case curLA.Edit: {
			if (curLA.valueBuffer("cantidad") != curLA.valueBufferCopy("cantidad")) {
				if (!this.iface.actualizarLineaPedidoCli(curLA.valueBuffer("idlineapedido"), curLA.valueBuffer("idpedido") , curLA.valueBuffer("referencia"), curLA.valueBuffer("idalbaran"), curLA.valueBuffer("cantidad"))) {
					return false;
				}
				if (!this.iface.actualizarEstadoPedidoCli(curLA.valueBuffer("idpedido"), curLA)) {
					return false;
				}
			}
			break;
		}
		case curLA.Del: {
			var idPedido:Number = curLA.valueBuffer("idpedido");
			var idLineaAlbaran:Number = curLA.valueBuffer("idlinea");
			if (!this.iface.restarCantidadCli(idLineaPedido, idLineaAlbaran)) {
				return false;
			}
			this.iface.actualizarEstadoPedidoCli(idPedido);
			break;
		}
	}
	return true;
}

function oficial_actualizarPedidosLineaAlbaranProv(curLA:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	var idLineaPedido:Number = parseFloat(curLA.valueBuffer("idlineapedido"));
	if (idLineaPedido == 0) {
		return true;
	}

	switch (curLA.modeAccess()) {
		case curLA.Insert: {
			if (!this.iface.actualizarLineaPedidoProv(curLA.valueBuffer("idlineapedido"), curLA.valueBuffer("idpedido") , curLA.valueBuffer("referencia"), curLA.valueBuffer("idalbaran"), curLA.valueBuffer("cantidad"))) {
				return false;
			}
			if (!this.iface.actualizarEstadoPedidoProv(curLA.valueBuffer("idpedido"), curLA)) {
				return false;
			}
			break;
		}
		case curLA.Edit: {
			if (curLA.valueBuffer("cantidad") != curLA.valueBufferCopy("cantidad")) {
				if (!this.iface.actualizarLineaPedidoProv(curLA.valueBuffer("idlineapedido"), curLA.valueBuffer("idpedido") , curLA.valueBuffer("referencia"), curLA.valueBuffer("idalbaran"), curLA.valueBuffer("cantidad"))) {
					return false;
				}
				if (!this.iface.actualizarEstadoPedidoProv(curLA.valueBuffer("idpedido"), curLA)) {
					return false;
				}
			}
			break;
		}
		case curLA.Del: {
			var idPedido:Number = curLA.valueBuffer("idpedido");
			var idLineaAlbaran:Number = curLA.valueBuffer("idlinea");
			if (!this.iface.restarCantidadProv(idLineaPedido, idLineaAlbaran)) {
				return false;
			}
			this.iface.actualizarEstadoPedidoProv(idPedido);
			break;
		}
	}
	return true;
}

/** \D
Obtiene el primer hueco de la tabla de huecos (documentos de facturación que han sido borrados y han dejado su código disponible para volver a ser usado)
@param codSerie: Código de serie del documento
@param codEjercicio: Código de ejercicio del documento
@param tipo: Tipo de documento (factura a cliente, a proveedor)
@return Número correspondiente al primer hueco encontrado (0 si no se encuentra ninguno)
\end */
function oficial_obtenerHueco(codSerie:String, codEjercicio:String, tipo:String):Number
{
	var cursorHuecos:FLSqlCursor = new FLSqlCursor("huecos");
	var numHueco:Number = 0;
	cursorHuecos.select("upper(codserie)='" + codSerie + "' AND upper(codejercicio)='" + codEjercicio + "' AND upper(tipo)='" + tipo + "' ORDER BY numero;");
	if (cursorHuecos.next()) {
		numHueco = cursorHuecos.valueBuffer("numero");
		cursorHuecos.setActivatedCheckIntegrity(false);
		cursorHuecos.setModeAccess(cursorHuecos.Del);
		cursorHuecos.refreshBuffer();
		cursorHuecos.commitBuffer();
	}
	return numHueco;
}

function oficial_establecerNumeroSecuencia(fN:String, value:Number):Number
{
	return (parseFloat(value) + 1);
}

/** \D
Rellena un string con ceros a la izquierda hasta completar la logitud especificada
@param numero: String que contiene el número
@param totalCifras: Longitud a completar
\end */
function oficial_cerosIzquierda(numero:String, totalCifras:Number):String
{
	var ret:String = numero.toString();
	var numCeros:Number = totalCifras - ret.length;
	for ( ; numCeros > 0 ; --numCeros)
		ret = "0" + ret;
	return ret;
}

function oficial_construirCodigo(codSerie:String, codEjercicio:String, numero:String):String
{
	return this.iface.cerosIzquierda(codEjercicio, 4) + "-" +
		this.iface.cerosIzquierda(codSerie, 4) + "-" +
		this.iface.cerosIzquierda(numero, 8);
}

/** \D
Obtiene el siguiente número de la secuencia de documentos
@param codSerie: Código de serie del documento
@param codEjercicio: Código de ejercicio del documento
@param fN: Tipo de documento (factura a cliente, a proveedor, remito, etc.)
@return Número correspondiente al siguiente documento en la serie o false si hay error
\end */
function oficial_siguienteNumero(codSerie:String, codEjercicio:String, fN:String):Number
{
	var numero:Number;
	var util:FLUtil = new FLUtil;
	var cursorSecuencias:FLSqlCursor = new FLSqlCursor("secuenciasejercicios");

	cursorSecuencias.setContext(this);
	cursorSecuencias.setActivatedCheckIntegrity(false);
	cursorSecuencias.select("upper(codserie)='" + codSerie + "' AND upper(codejercicio)='" + codEjercicio + "';");
	if (cursorSecuencias.next()) {
		if (fN == "nfacturaprov") {
			var numeroHueco:Number = this.iface.obtenerHueco(codSerie, codEjercicio, "FP");
			if (numeroHueco != 0) {
				cursorSecuencias.setActivatedCheckIntegrity(true);
				return numeroHueco;
			}
		}
		if (fN == "nfacturacli") {
			var numeroHueco:Number = this.iface.obtenerHueco(codSerie, codEjercicio, "FC");
			if (numeroHueco != 0) {
				cursorSecuencias.setActivatedCheckIntegrity(true);
				return numeroHueco;
			}
		}

		/** \C
		Para minimizar bloqueos las secuencias se han separado en distintos registros de otra tabla
		llamada secuencias
		\end */
		var cursorSecs:FLSqlCursor = new FLSqlCursor( "secuencias" );
		cursorSecs.setContext( this );
		cursorSecs.setActivatedCheckIntegrity( false );
		/** \C
		Si el registro no existe lo crea inicializandolo con su antiguo valor del campo correspondiente
		en la tabla secuenciasejercicios.
		\end */
		var idSec:Number = cursorSecuencias.valueBuffer( "id" );
		cursorSecs.select( "id=" + idSec + " AND nombre='" + fN + "'" );
		if ( !cursorSecs.next() ) {
			numero = cursorSecuencias.valueBuffer(fN);
			if (!numero || isNaN(numero)) {
				numero = 1;
			}
			cursorSecs.setModeAccess( cursorSecs.Insert );
			cursorSecs.refreshBuffer();
			cursorSecs.setValueBuffer( "id", idSec );
			cursorSecs.setValueBuffer( "nombre", fN );
			cursorSecs.setValueBuffer( "valor", this.iface.establecerNumeroSecuencia( fN, numero ) );
			cursorSecs.commitBuffer();
		} else {
			cursorSecs.setModeAccess( cursorSecs.Edit );
			cursorSecs.refreshBuffer();
			if ( !cursorSecs.isNull( "valorout" ) )
				numero = cursorSecs.valueBuffer( "valorout" );
			else
				numero = cursorSecs.valueBuffer( "valor" );
			cursorSecs.setValueBuffer( "valorout", this.iface.establecerNumeroSecuencia( fN, numero ) );		
			cursorSecs.commitBuffer();
		}
		cursorSecs.setActivatedCheckIntegrity( true );
	} else {
		/** \C
		Si la serie no existe para el ejercicio actual se consultará al usuario si la quiere crear
		\end */
		var res:Number = MessageBox.warning(util.translate("scripts", "La serie ") + codSerie + util.translate("scripts"," no existe para el ejercicio ") + codEjercicio + util.translate("scripts",".\n¿Desea crearla?"), MessageBox.Yes,MessageBox.No);
		if (res != MessageBox.Yes) {
			cursorSecuencias.setActivatedCheckIntegrity(true);
			return false;
		}
		cursorSecuencias.setModeAccess(cursorSecuencias.Insert);
		cursorSecuencias.refreshBuffer();
		cursorSecuencias.setValueBuffer("codserie", codSerie);
		cursorSecuencias.setValueBuffer("codejercicio", codEjercicio);
		numero = "1";
		cursorSecuencias.setValueBuffer(fN, "2");
		if (!cursorSecuencias.commitBuffer()) {
			cursorSecuencias.setActivatedCheckIntegrity(true);
			return false;
		}
	}
	cursorSecuencias.setActivatedCheckIntegrity(true);
	return numero;
}

/** \D
Agrega un hueco a la tabla de huecos
@param serie: Código de serie del documento
@param ejercicio: Código de ejercicio del documento
@param numero: Número del documento
@param fN: Tipo de documento (factura a cliente, a proveedor, remito, etc.)
@return true si el hueco se inserta correctamente o false si hay error
\end */
function oficial_agregarHueco(serie:String, ejercicio:String, numero:Number, fN:String):Boolean
{
	return this.iface.recalcularHuecos( serie, ejercicio, fN );
}

/* \D Indica si el asiento asociado a la factura puede o no regenerarse, según pertenezca a un ejercicio abierto o cerrado
@param idAsiento: Identificador del asiento
@return True: Asiento borrable, False: Asiento no borrable
\end */
function oficial_asientoBorrable(idAsiento:Number):Boolean
{
	var util:FLUtil = new FLUtil();
	var qryEjerAsiento:FLSqlQuery = new FLSqlQuery();
	qryEjerAsiento.setTablesList("ejercicios,co_asientos");
	qryEjerAsiento.setSelect("e.estado");
	qryEjerAsiento.setFrom("co_asientos a INNER JOIN ejercicios e" +
			" ON a.codejercicio = e.codejercicio");
	qryEjerAsiento.setWhere("a.idasiento = " + idAsiento);
	try { qryEjerAsiento.setForwardOnly( true ); } catch (e) {}

	if (!qryEjerAsiento.exec())
		return false;

	if (!qryEjerAsiento.next())
		return false;

	if (qryEjerAsiento.value(0) != "ABIERTO") {
		MessageBox.critical(util.translate("scripts",
		"No puede realizarse la modificación porque el asiento contable correspondiente pertenece a un ejercicio cerrado"),
				MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

	return true;
}

/** \U Genera o regenera el asiento correspondiente a una factura de cliente
@param	curFactura: Cursor con los datos de la factura
@return	VERDADERO si no hay error. FALSO en otro caso
\end */
function oficial_generarAsientoFacturaCli(curFactura:FLSqlCursor):Boolean
{
	if (curFactura.modeAccess() != curFactura.Insert && curFactura.modeAccess() != curFactura.Edit)
		return true;

	var util:FLUtil = new FLUtil;
	if (curFactura.valueBuffer("nogenerarasiento")) {
		curFactura.setNull("idasiento");
		return true;
	}

	if (!this.iface.comprobarRegularizacion(curFactura))
		return false;

	var datosAsiento:Array = [];
	var valoresDefecto:Array;
	valoresDefecto["codejercicio"] = curFactura.valueBuffer("codejercicio");
	valoresDefecto["coddivisa"] = flfactppal.iface.pub_valorDefectoEmpresa("coddivisa");

	var curTransaccion:FLSqlCursor = new FLSqlCursor("facturascli");
	curTransaccion.transaction(false);
	try {
		datosAsiento = this.iface.regenerarAsiento(curFactura, valoresDefecto);
		if (datosAsiento.error == true)
			throw util.translate("scripts", "Error al regenerar el asiento");
	
		var ctaCliente = this.iface.datosCtaCliente(curFactura, valoresDefecto);
		if (ctaCliente.error != 0)
			throw util.translate("scripts", "Error al leer los datos de subcuenta de cliente");
	
		if (!this.iface.generarPartidasCliente(curFactura, datosAsiento.idasiento, valoresDefecto, ctaCliente))
			throw util.translate("scripts", "Error al generar las partidas de cliente");
	
		if (!this.iface.generarPartidasIVACli(curFactura, datosAsiento.idasiento, valoresDefecto, ctaCliente))
			throw util.translate("scripts", "Error al generar las partidas de IVA");
	
		if (!this.iface.generarPartidasVenta(curFactura, datosAsiento.idasiento, valoresDefecto))
			throw util.translate("scripts", "Error al generar las partidas de venta");
		
		curFactura.setValueBuffer("idasiento", datosAsiento.idasiento);
		
		if (curFactura.valueBuffer("decredito") == true)
			if (!this.iface.asientoNotaCreditoCli(curFactura, valoresDefecto))
				throw util.translate("scripts", "Error al generar el asiento correspondiente a la nota de crédito");
	
		if (curFactura.valueBuffer("dedebito") == true)
			if (!this.iface.asientoNotaDebitoCli(curFactura, valoresDefecto))
				throw util.translate("scripts", "Error al generar el asiento correspondiente a la nota de débito");
	
		if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento))
			throw util.translate("scripts", "Error al comprobar el asiento");
	} catch (e) {
		curTransaccion.rollback();
		MessageBox.warning(util.translate("scripts", "Error al generar el asiento correspondiente a la factura %1:").arg(curFactura.valueBuffer("codigo")) + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	curTransaccion.commit();

	return true;
}

/** \D Genera la parte del asiento de factura correspondiente a la subcuenta de ventas
@param	curFactura: Cursor de la factura
@param	idAsiento: Id del asiento asociado
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return	VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasVenta(curFactura:FLSqlCursor, idAsiento:Number, valoresDefecto:Array):Boolean
{
	var util:FLUtil = new FLUtil();
	var ctaVentas:Array = this.iface.datosCtaVentas(valoresDefecto.codejercicio, curFactura.valueBuffer("codserie"));
	if (ctaVentas.error != 0) {
		MessageBox.warning(util.translate("scripts", "No se ha encontrado una subcuenta de ventas para esta factura."), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	var haber:Number = 0;
	var haberME:Number = 0;
	var monedaSistema:Boolean = (valoresDefecto.coddivisa == curFactura.valueBuffer("coddivisa"));
	if (monedaSistema) {
		haber = this.iface.netoVentasFacturaCli(curFactura);
		haberME = 0;
	} else {
		haber = parseFloat(util.sqlSelect("co_partidas", "SUM(debe - haber)", "idasiento = " + idAsiento));
		haberME = this.iface.netoVentasFacturaCli(curFactura);
	}
	haber = util.roundFieldValue(haber, "co_partidas", "haber");
	haberME = util.roundFieldValue(haberME, "co_partidas", "haberme");

	var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
	with (curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("idsubcuenta", ctaVentas.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaVentas.codsubcuenta);
		setValueBuffer("idasiento", idAsiento);
		setValueBuffer("debe", 0);
		setValueBuffer("haber", haber);
		setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
		setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", haberME);
	}
	
	this.iface.datosPartidaFactura(curPartida, curFactura, "cliente")
	
	if (!curPartida.commitBuffer())
		return false;
	return true;
}

function oficial_netoVentasFacturaCli(curFactura:FLSqlCursor):Number
{
	return parseFloat(curFactura.valueBuffer("neto"));
}
function oficial_netoComprasFacturaProv(curFactura:FLSqlCursor):Number
{
	return parseFloat(curFactura.valueBuffer("neto"));
}

/** \D Genera la parte del asiento de factura correspondiente a la subcuenta de IVA, si la factura lo tiene
@param	curFactura: Cursor de la factura
@param	idAsiento: Id del asiento asociado
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@param	ctaCliente: Array con los datos de la contrapartida
@return	VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasIVACli(curFactura:FLSqlCursor, idAsiento:Number, valoresDefecto:Array, ctaCliente:Array):Boolean
{
	var util:FLUtil = new FLUtil();
	var haber:Number = 0;
	var haberME:Number = 0;
	var baseImponible:Number = 0;
	var iva:Number;
	
	var regimenIVA:String = this.iface.regimenIVACliente(curFactura);
	if (!regimenIVA) {
		MessageBox.warning(util.translate("scripts", "Error al obtener el régimen de IVA asociado a la factura %1.\nCompruebe que el cliente tiene un régimen de IVA establecido").arg(curFactura.valueBuffer("codigo")), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	
	var monedaSistema:Boolean = (valoresDefecto.coddivisa == curFactura.valueBuffer("coddivisa"));
	var qryIva:FLSqlQuery = new FLSqlQuery();
	qryIva.setTablesList("lineasivafactcli");
	qryIva.setSelect("neto, iva, totaliva, codimpuesto");
	qryIva.setFrom("lineasivafactcli");
	qryIva.setWhere("idfactura = " + curFactura.valueBuffer("idfactura"));
	try { qryIva.setForwardOnly( true ); } catch (e) {}
	if (!qryIva.exec())
		return false;

	while (qryIva.next()) {
		iva = parseFloat(qryIva.value("iva"));
		if (isNaN(iva)) {
			iva = 0;
		}
		if (monedaSistema) {
			haber = parseFloat(qryIva.value(2));
			haberME = 0;
			baseImponible = parseFloat(qryIva.value(0));
		} else {
			haber = parseFloat(qryIva.value(2)) * parseFloat(curFactura.valueBuffer("tasaconv"));
			haberME = parseFloat(qryIva.value(2));
			baseImponible = parseFloat(qryIva.value(0))  * parseFloat(curFactura.valueBuffer("tasaconv"));
		}
		haber = util.roundFieldValue(haber, "co_partidas", "haber");
		haberME = util.roundFieldValue(haberME, "co_partidas", "haberme");
		baseImponible = util.roundFieldValue(baseImponible, "co_partidas", "baseimponible");

		var ctaIvaRep:Array;
		var textoError:String;
		switch (regimenIVA) {
			case "U.E.": {
				ctaIvaRep = this.iface.datosCtaIVA("IVAEUE", valoresDefecto.codejercicio,qryIva.value(3));
				textoError = util.translate("scripts", "I.V.A. entregas intracomunitarias (IVAEUE)");
				break;
			}
			case "Exento": {
				ctaIvaRep = this.iface.datosCtaIVA("IVAREX", valoresDefecto.codejercicio, qryIva.value(3));
				textoError = util.translate("scripts", "I.V.A. repercutido exento (IVAREX)");
				break;
			}
			case "Exportaciones": {
				ctaIvaRep = this.iface.datosCtaIVA("IVARXP", valoresDefecto.codejercicio, qryIva.value(3));
				textoError = util.translate("scripts", "I.V.A. repercutido exportaciones (IVARXP)");
				break;
			}
			default: {
				ctaIvaRep = this.iface.datosCtaIVA("IVAREP", valoresDefecto.codejercicio, qryIva.value(3));
				textoError = util.translate("scripts", "I.V.A. repercutido R. General(IVAREP)");
			}
		}
		if (ctaIvaRep.error != 0) {
			MessageBox.information(util.translate("scripts", "La cuenta especial de %1 no tiene asignada subcuenta.\nDebe asociarla en el módulo Principal del área Financiera").arg(textoError), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
		
		var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
		with (curPartida) {
			setModeAccess(curPartida.Insert);
			refreshBuffer();
			setValueBuffer("idsubcuenta", ctaIvaRep.idsubcuenta);
			setValueBuffer("codsubcuenta", ctaIvaRep.codsubcuenta);
			setValueBuffer("idasiento", idAsiento);
			setValueBuffer("debe", 0);
			setValueBuffer("haber", haber);
			setValueBuffer("baseimponible", baseImponible);
			setValueBuffer("iva", iva);
			setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
			setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
			setValueBuffer("idcontrapartida", ctaCliente.idsubcuenta);
			setValueBuffer("codcontrapartida", ctaCliente.codsubcuenta);
			setValueBuffer("debeME", 0);
			setValueBuffer("haberME", haberME);
			setValueBuffer("codserie", curFactura.valueBuffer("codserie"));
			setValueBuffer("cifnif", curFactura.valueBuffer("cifnif"));
		}
		
		this.iface.datosPartidaFactura(curPartida, curFactura, "cliente")
		
		if (!curPartida.commitBuffer())
			return false;
	}
	return true;
}

/** \D Obtiene el régimen de IVA asociado a una factura de cliente
@param	curFactura: Factura
@return	Régimen de IVA
\end */
function oficial_regimenIVACliente(curDocCliente:FLSqlCursor):String
{
	var util:FLUtil = new FLUtil();

	var regimen:String;
	var codCliente:String = curDocCliente.valueBuffer("codcliente");
	if (codCliente && codCliente != "") {
		regimen = util.sqlSelect("clientes", "regimeniva", "codcliente = '" + codCliente + "'");
	} else {
		regimen = "Consumidor Final";
	}
	return regimen;
}

/** \D Genera la parte del asiento de factura correspondiente a la subcuenta de clientes
@param	curFactura: Cursor de la factura
@param	idAsiento: Id del asiento asociado
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@param	ctaCliente: Datos de la subcuenta del cliente asociado a la factura
@return	VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasCliente(curFactura:FLSqlCursor, idAsiento:Number, valoresDefecto:Array, ctaCliente:Array):Boolean
{
		var util:FLUtil = new FLUtil();
		var debe:Number = 0;
		var debeME:Number = 0;
		var monedaSistema:Boolean = (valoresDefecto.coddivisa == curFactura.valueBuffer("coddivisa"));
		if (monedaSistema) {
				debe = parseFloat(curFactura.valueBuffer("total"));
				debeME = 0;
		} else {
				debe = parseFloat(curFactura.valueBuffer("total")) * parseFloat(curFactura.valueBuffer("tasaconv"));
				debeME = parseFloat(curFactura.valueBuffer("total"));
		}
		debe = util.roundFieldValue(debe, "co_partidas", "debe");
		debeME = util.roundFieldValue(debeME, "co_partidas", "debeme");
		
		var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
		with (curPartida) {
				setModeAccess(curPartida.Insert);
				refreshBuffer();
				setValueBuffer("idsubcuenta", ctaCliente.idsubcuenta);
				setValueBuffer("codsubcuenta", ctaCliente.codsubcuenta);
				setValueBuffer("idasiento", idAsiento);
				setValueBuffer("debe", debe);
				setValueBuffer("haber", 0);
				setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
				setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
				setValueBuffer("debeME", debeME);
				setValueBuffer("haberME", 0);
		}
		
		this.iface.datosPartidaFactura(curPartida, curFactura, "cliente")
		
		if (!curPartida.commitBuffer())
				return false;

		return true;
}

/** \D Genera o regenera el registro en la tabla de asientos correspondiente a la factura. Si el asiento ya estaba creado borra sus partidas asociadas.
@param	curFactura: Cursor posicionado en el registro de factura
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return	array con los siguientes datos:
asiento.idasiento: Id del asiento
asiento.numero: numero del asiento
asiento.fecha: fecha del asiento
asiento.error: indicador booleano de que ha habido un error en la función
\end */
function oficial_regenerarAsiento(cur:FLSqlCursor, valoresDefecto:Array):Array
{
	var util:FLUtil = new FLUtil;
	var asiento:Array = [];
	var idAsiento:Number = cur.valueBuffer("idasiento");
	if (cur.isNull("idasiento")) {

		var datosAsiento:Array = this.iface.datosConceptoAsiento(cur);

		var curAsiento:FLSqlCursor = new FLSqlCursor("co_asientos");
		//var numAsiento:Number = util.sqlSelect("co_asientos", "MAX(numero)",  "codejercicio = '" + valoresDefecto.codejercicio + "'");
		//numAsiento++;
		with (curAsiento) {
			setModeAccess(curAsiento.Insert);
			refreshBuffer();
			setValueBuffer("numero", 0);
			setValueBuffer("fecha", cur.valueBuffer("fecha"));
			setValueBuffer("codejercicio", valoresDefecto.codejercicio);
			setValueBuffer("concepto", datosAsiento.concepto);
			setValueBuffer("tipodocumento", datosAsiento.tipoDocumento);
			setValueBuffer("documento", datosAsiento.documento);
		}

		if (!curAsiento.commitBuffer()) {
			asiento.error = true;
			return asiento;
		}
		asiento.idasiento = curAsiento.valueBuffer("idasiento");
		asiento.numero = curAsiento.valueBuffer("numero");
		asiento.fecha = curAsiento.valueBuffer("fecha");
		asiento.concepto = curAsiento.valueBuffer("concepto");
		asiento.tipodocumento = curAsiento.valueBuffer("tipodocumento");
		asiento.documento = curAsiento.valueBuffer("documento");

		curAsiento.select("idasiento = " + asiento.idasiento);
		curAsiento.first();
		curAsiento.setUnLock("editable", false);
	} else {
		var datosAsiento:Array = this.iface.datosConceptoAsiento(cur);

		if (!this.iface.asientoBorrable(idAsiento)) {
			asiento.error = true;
			return asiento;
		}

// 		if (cur.valueBuffer("fecha") != cur.valueBufferCopy("fecha")) {
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
			curAsiento.setValueBuffer("fecha", cur.valueBuffer("fecha"));
			curAsiento.setValueBuffer("concepto", datosAsiento.concepto);
			curAsiento.setValueBuffer("tipodocumento", datosAsiento.tipoDocumento);
			curAsiento.setValueBuffer("documento", datosAsiento.documento);

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
// 		}

		asiento = flfactppal.iface.pub_ejecutarQry("co_asientos", "idasiento,numero,fecha,codejercicio,concepto,tipodocumento,documento", "idasiento = '" + idAsiento + "'");
		if (asiento.codejercicio != valoresDefecto.codejercicio) {
			MessageBox.warning(util.translate("scripts", "Está intentando regenerar un asiento del ejercicio %1 en el ejercicio %2.\nVerifique que su ejercicio actual es correcto. Si lo es y está actualizando un pago, bórrelo y vuélvalo a crear.").arg(asiento.codejercicio).arg(valoresDefecto.codejercicio), MessageBox.Ok, MessageBox.NoButton);
			asiento.error = true;
			return asiento;
		}
		var curPartidas = new FLSqlCursor("co_partidas");
		curPartidas.select("idasiento = " + idAsiento);
		var idP:Number = 0;
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

function oficial_datosConceptoAsiento(cur:FLSqlCursor):Array
{
	var util:FLUtil = new FLUtil;
	var datosAsiento:Array = [];

	switch (cur.table()) {
		case "facturascli": {
			datosAsiento.concepto = "Nuestra factura " + cur.valueBuffer("codigo") + " - " + cur.valueBuffer("nombrecliente");
			datosAsiento.documento = cur.valueBuffer("codigo");
			datosAsiento.tipoDocumento = "Factura de cliente";
			break;
		}
		case "facturasprov": {
			var numProveedor:String = cur.valueBuffer("numproveedor");
			if (numProveedor && numProveedor != "") {
				numProveedor = numProveedor + " / ";
			}
			datosAsiento.concepto = "Su factura " + numProveedor + cur.valueBuffer("codigo") + " - " + cur.valueBuffer("nombre");
			datosAsiento.documento = cur.valueBuffer("codigo");
			datosAsiento.tipoDocumento = "Factura de proveedor";
			break;
		}
		case "pagosdevolcli": {
			var codRecibo:String = util.sqlSelect("reciboscli", "codigo", "idrecibo = " + cur.valueBuffer("idrecibo"));
			var nombreCli:String = util.sqlSelect("reciboscli", "nombrecliente", "idrecibo = " + cur.valueBuffer("idrecibo"));
			
			if (cur.valueBuffer("tipo") == "Pago") {
				datosAsiento.concepto = "Pago recibo " + codRecibo + " - " + nombreCli;
			} else {
				datosAsiento.concepto = "Devolución recibo " + codRecibo;
			}

			datosAsiento.tipoDocumento = "Recibo";
			datosAsiento.documento = "";
			break;
		}
		case "pagosdevolrem": {
			if (cur.valueBuffer("tipo") == "Pago")
				datosAsiento.concepto = cur.valueBuffer("tipo") + " " + "remesa" + " " + cur.valueBuffer("idremesa");
				datosAsiento.tipoDocumento = "";
				datosAsiento.documento = "";
			break;
		}
		case "co_dotaciones": {
			datosAsiento.concepto = "Dotación de " + util.sqlSelect("co_amortizaciones","elemento","codamortizacion = '" + cur.valueBuffer("codamortizacion") + "'") + " - " + util.dateAMDtoDMA(cur.valueBuffer("fecha"));
			datosAsiento.documento = "";
			datosAsiento.tipoDocumento = "";
			break;
		}
		default: 
			datosAsiento.concepto = "";
			datosAsiento.documento = "";
			datosAsiento.tipoDocumento = "";
	}
	return datosAsiento;
}

function oficial_eliminarAsiento(idAsiento:String):Boolean
{
	var util:FLUtil = new FLUtil;
	if (!idAsiento || idAsiento == "")
		return true;

	if (!this.iface.asientoBorrable(idAsiento))
		return false;

	var curAsiento:FLSqlCursor = new FLSqlCursor("co_asientos");
	curAsiento.select("idasiento = " + idAsiento);
	if (!curAsiento.first())
		return false;

	curAsiento.setUnLock("editable", true);
	if (!util.sqlDelete("co_asientos", "idasiento = " + idAsiento)) {
		curAsiento.setValueBuffer("idasiento", idAsiento);
		return false;
	}
	return true;
}

/** \U Genera o regenera el asiento correspondiente a una factura de proveedor
@param	curFactura: Cursor con los datos de la factura
@return	VERDADERO si no hay error. FALSO en otro caso
\end */
/** \C El concepto de los asientos de factura de proveedor será 'Su factura ' + número de proveedor asociado a la factura. Si el número de proveedor no se especifica, el concepto será 'Su factura ' + código de factura.
\end */
function oficial_generarAsientoFacturaProv(curFactura:FLSqlCursor):Boolean
{
	if (curFactura.modeAccess() != curFactura.Insert && curFactura.modeAccess() != curFactura.Edit)
		return true;

	var util:FLUtil = new FLUtil;
	if (curFactura.valueBuffer("nogenerarasiento")) {
		curFactura.setNull("idasiento");
		return true;
	}

	if (!this.iface.comprobarRegularizacion(curFactura))
		return false;

	var util:FLUtil = new FLUtil();
	var datosAsiento:Array = [];
	var valoresDefecto:Array;
	valoresDefecto["codejercicio"] = curFactura.valueBuffer("codejercicio");
	valoresDefecto["coddivisa"] = flfactppal.iface.pub_valorDefectoEmpresa("coddivisa");

	datosAsiento = this.iface.regenerarAsiento(curFactura, valoresDefecto);
	if (datosAsiento.error == true)
		return false;

	var numProveedor:String = curFactura.valueBuffer("numproveedor");
	var concepto:String = "";
	if (!numProveedor || numProveedor == "")
		concepto = util.translate("scripts", "Su factura ") + curFactura.valueBuffer("codigo");
	else
		concepto = util.translate("scripts", "Su factura ") + numProveedor;
	concepto += " - " + curFactura.valueBuffer("nombre");

	var ctaProveedor:Array = this.iface.datosCtaProveedor(curFactura, valoresDefecto);
	if (ctaProveedor.error != 0)
		return false;

	// Las partidas generadas dependen del régimen de IVA del proveedor
	var regimenIVA:String = util.sqlSelect("proveedores", "regimeniva", "codproveedor = '" + curFactura.valueBuffer("codproveedor") + "'");
	
	switch(regimenIVA) {
		case "UE":
			if (!this.iface.generarPartidasProveedor(curFactura, datosAsiento.idasiento, valoresDefecto, ctaProveedor, concepto, true))
				return false;
				
			if (!this.iface.generarPartidasIVAProv(curFactura, datosAsiento.idasiento, valoresDefecto, ctaProveedor, concepto))
				return false;
		
			if (!this.iface.generarPartidasCompra(curFactura, datosAsiento.idasiento, valoresDefecto, concepto))
				return false;
		break;
		
		case "Exento":
			if (!this.iface.generarPartidasProveedor(curFactura, datosAsiento.idasiento, valoresDefecto, ctaProveedor, concepto, true))
				return false;
				
			if (!this.iface.generarPartidasIVAProv(curFactura, datosAsiento.idasiento, valoresDefecto, ctaProveedor, concepto))
				return false;
		
			if (!this.iface.generarPartidasCompra(curFactura, datosAsiento.idasiento, valoresDefecto, concepto))
				return false;
		break;
		
		default:
			if (!this.iface.generarPartidasProveedor(curFactura, datosAsiento.idasiento, valoresDefecto, ctaProveedor, concepto))
				return false;
				
			if (!this.iface.generarPartidasIVAProv(curFactura, datosAsiento.idasiento, valoresDefecto, ctaProveedor, concepto))
				return false;
		
			if (!this.iface.generarPartidasCompra(curFactura, datosAsiento.idasiento, valoresDefecto, concepto))
				return false;
	}
		
	curFactura.setValueBuffer("idasiento", datosAsiento.idasiento);
	if (curFactura.valueBuffer("decredito") == true) {
		if (!this.iface.asientoNotaCreditoProv(curFactura, valoresDefecto))
			return false;
	}
	if (curFactura.valueBuffer("dedebito") == true) {
		if (!this.iface.asientoNotaDebitoProv(curFactura, valoresDefecto))
			return false;
	}

	if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento))
		return false;

	return true;
}

/** \D Genera la parte del asiento de factura de proveedor correspondiente a la subcuenta de compras
@param	curFactura: Cursor de la factura
@param	idAsiento: Id del asiento asociado
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@param	concepto: Concepto de la partida
@return	VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasCompra(curFactura:FLSqlCursor, idAsiento:Number, valoresDefecto:Array, concepto:String):Boolean
{
		var ctaCompras:Array = [];
	var util:FLUtil = new FLUtil();
	var monedaSistema:Boolean = (valoresDefecto.coddivisa == curFactura.valueBuffer("coddivisa"));
	var debe:Number = 0;
	var debeME:Number = 0;
	var idUltimaPartida:Number = 0;

	/** \C En el asiento correspondiente a las facturas de proveedor, se generarán tantas partidas de compra como subcuentas distintas existan en las líneas de factura
	\end */
	var qrySubcuentas:FLSqlQuery = new FLSqlQuery();
	with (qrySubcuentas) {
		setTablesList("lineasfacturasprov");
		setSelect("codsubcuenta, SUM(pvptotal)");
		setFrom("lineasfacturasprov");
		setWhere("idfactura = " + curFactura.valueBuffer("idfactura") + " GROUP BY codsubcuenta");
	}
	try { qrySubcuentas.setForwardOnly( true ); } catch (e) {}
	
	if (!qrySubcuentas.exec())
			return false;

	if (qrySubcuentas.size() == 0 || curFactura.valueBuffer("decredito") || curFactura.valueBuffer("dedebito")) {
	/// \D Si la factura es rectificativa se genera una sola partida de compras que luego se convertirá a partida de nota de crédito o de nota de débito
		ctaCompras = this.iface.datosCtaEspecial("COMPRA", valoresDefecto.codejercicio);
		if (ctaCompras.error != 0) {
			MessageBox.warning(util.translate("scripts", "No existe ninguna subcuenta marcada como cuenta especial de COMPRA para %1").arg(valoresDefecto.codejercicio), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
		if (monedaSistema) {
			debe = this.iface.netoComprasFacturaProv(curFactura);
			debeME = 0;
		} else {
			debe = parseFloat(curFactura.valueBuffer("neto")) * parseFloat(curFactura.valueBuffer("tasaconv"));
			debeME = this.iface.netoComprasFacturaProv(curFactura);
		}
		debe = util.roundFieldValue(debe, "co_partidas", "debe");
		debeME = util.roundFieldValue(debeME, "co_partidas", "debeme");
		
		var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
		with (curPartida) {
			setModeAccess(curPartida.Insert);
			refreshBuffer();
			setValueBuffer("idsubcuenta", ctaCompras.idsubcuenta);
			setValueBuffer("codsubcuenta", ctaCompras.codsubcuenta);
			setValueBuffer("idasiento", idAsiento);
			setValueBuffer("debe", debe);
			setValueBuffer("haber", 0);
			setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
			setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
			setValueBuffer("debeME", debeME);
			setValueBuffer("haberME", 0);
		}
			
		this.iface.datosPartidaFactura(curPartida, curFactura, "proveedor", concepto);
		
		if (!curPartida.commitBuffer())
			return false;
		idUltimaPartida = curPartida.valueBuffer("idpartida");
	} else {
		while (qrySubcuentas.next()) {
			if (qrySubcuentas.value(0) == "" || !qrySubcuentas.value(0)) {
				ctaCompras = this.iface.datosCtaEspecial("COMPRA", valoresDefecto.codejercicio);
				if (ctaCompras.error != 0)
					return false;
			} else {
				ctaCompras.codsubcuenta = qrySubcuentas.value(0);
				ctaCompras.idsubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + qrySubcuentas.value(0) + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
				if (!ctaCompras.idsubcuenta) {
					MessageBox.warning(util.translate("scripts", "No existe la subcuenta ")  + ctaCompras.codsubcuenta + util.translate("scripts", " correspondiente al ejercicio ") + valoresDefecto.codejercicio + util.translate("scripts", ".\nPara poder crear la factura debe crear antes esta subcuenta"), MessageBox.Ok, MessageBox.NoButton);
					return false;
				}
			}

			if (monedaSistema) {
				debe = parseFloat(qrySubcuentas.value(1));
				debeME = 0;
			} else {
				debe = parseFloat(qrySubcuentas.value(1)) * parseFloat(curFactura.valueBuffer("tasaconv"));
				debeME = parseFloat(qrySubcuentas.value(1));
			}
			debe = util.roundFieldValue(debe, "co_partidas", "debe");
			debeME = util.roundFieldValue(debeME, "co_partidas", "debeme");
			
			var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
			with (curPartida) {
				setModeAccess(curPartida.Insert);
				refreshBuffer();
				setValueBuffer("idsubcuenta", ctaCompras.idsubcuenta);
				setValueBuffer("codsubcuenta", ctaCompras.codsubcuenta);
				setValueBuffer("idasiento", idAsiento);
				setValueBuffer("debe", debe);
				setValueBuffer("haber", 0);
				setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
				setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
				setValueBuffer("debeME", debeME);
				setValueBuffer("haberME", 0);
			}
			
			this.iface.datosPartidaFactura(curPartida, curFactura, "proveedor", concepto);
			
			if (!curPartida.commitBuffer())
				return false;
			idUltimaPartida = curPartida.valueBuffer("idpartida");
		}
	}

	/** \C En los asientos de factura de proveedor, y en el caso de que se use moneda extranjera, la última partida de compras tiene un saldo tal que haga que el asiento cuadre perfectamente. Esto evita errores de redondeo de conversión de moneda entre las partidas del asiento.
	\end */
	if (!monedaSistema) {
		debe = parseFloat(util.sqlSelect("co_partidas", "SUM(haber - debe)", "idasiento = " + idAsiento + " AND idpartida <> " + idUltimaPartida));
		if (debe && !isNaN(debe) && debe != 0) {
			debe = parseFloat(util.roundFieldValue(debe, "co_partidas", "debe"));
			if (!util.sqlUpdate("co_partidas", "debe", debe, "idpartida = " + idUltimaPartida))
				return false;
		}
	}

	return true;
}

/** \D Genera la parte del asiento de factura de proveedor correspondiente a la subcuenta de IVA, si la factura lo tiene
@param	curFactura: Cursor de la factura
@param	idAsiento: Id del asiento asociado
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@param	ctaProveedor: Array con los datos de la contrapartida
@param	concepto: Concepto de la partida
@return	VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasIVAProv(curFactura:FLSqlCursor, idAsiento:Number, valoresDefecto:Array, ctaProveedor:Array, concepto:String):Boolean
{
	var util:FLUtil = new FLUtil();
	var haber:Number = 0;
	var haberME:Number = 0;
	var baseImponible:Number = 0;
	var monedaSistema:Boolean = (valoresDefecto.coddivisa == curFactura.valueBuffer("coddivisa"));
	var iva:Number;
	
	var regimenIVA:String = util.sqlSelect("proveedores","regimeniva","codproveedor = '" + curFactura.valueBuffer("codproveedor") + "'");
	var codCuentaEspIVA:String;
	
	var qryIva:FLSqlQuery = new FLSqlQuery();
	qryIva.setTablesList("lineasivafactprov");
	
	if (regimenIVA == "UE")
		qryIva.setSelect("neto, iva, neto*iva/100, codimpuesto");
	else
		qryIva.setSelect("neto, iva, totaliva, codimpuesto");
	
	qryIva.setFrom("lineasivafactprov");
	qryIva.setWhere("idfactura = " + curFactura.valueBuffer("idfactura"));
	try { qryIva.setForwardOnly( true ); } catch (e) {}
	if (!qryIva.exec())
		return false;

		
	while (qryIva.next()) {
		iva = parseFloat(qryIva.value("iva"));
		if (isNaN(iva)) {
			iva = 0;
		}
		if (monedaSistema) {
			debe = parseFloat(qryIva.value(2));
			debeME = 0;
			baseImponible = parseFloat(qryIva.value(0));
		} else {
			debe = parseFloat(qryIva.value(2)) * parseFloat(curFactura.valueBuffer("tasaconv"));
			debeME = parseFloat(qryIva.value(2));
			baseImponible = parseFloat(qryIva.value(0)) * parseFloat(curFactura.valueBuffer("tasaconv"));
		}
		debe = util.roundFieldValue(debe, "co_partidas", "debe");
		debeME = util.roundFieldValue(debeME, "co_partidas", "debeme");
		baseImponible = util.roundFieldValue(baseImponible, "co_partidas", "baseimponible");
		
		switch(regimenIVA) {
			case "UE": {
				codCuentaEspIVA = "IVASUE";
				break;
			}
			case "General": {
				codCuentaEspIVA = "IVASOP";
				break;
			}
			case "Exento": {
				codCuentaEspIVA = "IVASEX";
				break;
			}
			case "Importaciones": {
				codCuentaEspIVA = "IVASIM";
				break;
			}
			default: {
				codCuentaEspIVA = "IVASOP";
			}
		}
		
		var ctaIvaSop:Array = this.iface.datosCtaIVA(codCuentaEspIVA, valoresDefecto.codejercicio, qryIva.value(3));
		if (ctaIvaSop.error != 0) {
			MessageBox.warning(util.translate("scripts", "Esta factura pertenece al régimen IVA tipo %1.\nNo existe ninguna cuenta contable marcada como tipo especial %2\n\nDebe asociar una cuenta contable a dicho tipo especial en el módulo Principal del área Financiera").arg(regimenIVA).arg(codCuentaEspIVA), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
		var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
		with (curPartida) {
			setModeAccess(curPartida.Insert);
			refreshBuffer();
			setValueBuffer("idsubcuenta", ctaIvaSop.idsubcuenta);
			setValueBuffer("codsubcuenta", ctaIvaSop.codsubcuenta);
			setValueBuffer("idasiento", idAsiento);
			setValueBuffer("debe", debe);
			setValueBuffer("haber", 0);
			setValueBuffer("baseimponible", baseImponible);
			setValueBuffer("iva", iva);
			setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
			setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
			setValueBuffer("idcontrapartida", ctaProveedor.idsubcuenta);
			setValueBuffer("codcontrapartida", ctaProveedor.codsubcuenta);
			setValueBuffer("debeME", debeME);
			setValueBuffer("haberME", 0);
			setValueBuffer("codserie", curFactura.valueBuffer("codserie"));
			setValueBuffer("cifnif", curFactura.valueBuffer("cifnif"));
		}
		
		this.iface.datosPartidaFactura(curPartida, curFactura, "proveedor")
		
		if (!curPartida.commitBuffer())
			return false;

		
		// Otra partida de haber de IVA sobre una cuenta 477 para compensar en UE
		if (regimenIVA == "UE") {
			
			haber = debe;
			haberME = debeME;
			codCuentaEspIVA = "IVARUE";
			var ctaIvaSop = this.iface.datosCtaIVA("IVARUE", valoresDefecto.codejercicio,qryIva.value(3));
// 			var ctaIvaSop:Array = this.iface.datosCtaEspecial("IVARUE", valoresDefecto.codejercicio);
			if (ctaIvaSop.error != 0) {
				return false;
			}
			var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
			with (curPartida) {
				setModeAccess(curPartida.Insert);
				refreshBuffer();
				setValueBuffer("idsubcuenta", ctaIvaSop.idsubcuenta);
				setValueBuffer("codsubcuenta", ctaIvaSop.codsubcuenta);
				setValueBuffer("idasiento", idAsiento);
				setValueBuffer("debe", 0);
				setValueBuffer("haber", haber);
				setValueBuffer("baseimponible", baseImponible);
				setValueBuffer("iva", iva);
				setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
				setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
				setValueBuffer("idcontrapartida", ctaProveedor.idsubcuenta);
				setValueBuffer("codcontrapartida", ctaProveedor.codsubcuenta);
				setValueBuffer("debeME", 0);
				setValueBuffer("haberME", haberME);
				setValueBuffer("codserie", curFactura.valueBuffer("codserie"));
				setValueBuffer("cifnif", curFactura.valueBuffer("cifnif"));
			}
		
			this.iface.datosPartidaFactura(curPartida, curFactura, "proveedor", concepto)
			
			if (!curPartida.commitBuffer())
				return false;
		}
	}
	return true;
}

/** \D Genera la parte del asiento de factura correspondiente a la subcuenta de proveedor
@param	curFactura: Cursor de la factura
@param	idAsiento: Id del asiento asociado
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@param	ctaCliente: Datos de la subcuenta del proveedor asociado a la factura
@param	concepto: Concepto a asociar a la factura
@return	VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasProveedor(curFactura:FLSqlCursor, idAsiento:Number, valoresDefecto:Array, ctaProveedor:Array, concepto:String, sinIVA:Boolean):Boolean
{
		var util:FLUtil = new FLUtil;
		var haber:Number = 0;
		var haberME:Number = 0;
		var totalIVA:Number = 0;
		
		if (sinIVA)
			totalIVA = parseFloat(curFactura.valueBuffer("totaliva"));
		
		var monedaSistema:Boolean = (valoresDefecto.coddivisa == curFactura.valueBuffer("coddivisa"));
		if (monedaSistema) {
				haber = parseFloat(curFactura.valueBuffer("total"));
				haber -= totalIVA;
				haberME = 0;
		} else {
				haber = (parseFloat(curFactura.valueBuffer("total")) - totalIVA) * parseFloat(curFactura.valueBuffer("tasaconv"));
				haberME = parseFloat(curFactura.valueBuffer("total"));
		}
		haber = util.roundFieldValue(haber, "co_partidas", "haber");
		haberME = util.roundFieldValue(haberME, "co_partidas", "haberme");

		var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
		with (curPartida) {
				setModeAccess(curPartida.Insert);
				refreshBuffer();
				setValueBuffer("idsubcuenta", ctaProveedor.idsubcuenta);
				setValueBuffer("codsubcuenta", ctaProveedor.codsubcuenta);
				setValueBuffer("idasiento", idAsiento);
				setValueBuffer("debe", 0);
				setValueBuffer("haber", haber);
				setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
				setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
				setValueBuffer("debeME", 0);
				setValueBuffer("haberME", haberME);
		}
		
		this.iface.datosPartidaFactura(curPartida, curFactura, "proveedor", concepto);
		
		if (!curPartida.commitBuffer())
				return false;
		return true;
}

/* \D Devuelve el código e id de la subcuenta especial correspondiente a un determinado ejercicio. Primero trata de obtener los datos a partir del campo cuenta de co_cuentasesp. Si este no existe o no produce resultados, busca los datos de la cuenta (co_cuentas) marcada con el tipo especial buscado.
@param ctaEsp: Tipo de cuenta especial
@codEjercicio: Código de ejercicio
@return Los datos componen un vector de tres valores:
error: 0.Sin error 1.Datos no encontrados 2.Error al ejecutar la query
idsubcuenta: Identificador de la subcuenta
codsubcuenta: Código de la subcuenta
\end */
function oficial_datosCtaEspecial(ctaEsp:String, codEjercicio:String):Array
{
	var datos:Array = [];
	var q:FLSqlQuery = new FLSqlQuery();
	
	with(q) {
		setTablesList("co_subcuentas,co_cuentasesp");
		setSelect("s.idsubcuenta, s.codsubcuenta");
		setFrom("co_cuentasesp ce INNER JOIN co_subcuentas s ON ce.codsubcuenta = s.codsubcuenta");
		setWhere("ce.idcuentaesp = '" + ctaEsp + "' AND s.codejercicio = '" + codEjercicio + "'  ORDER BY s.codsubcuenta");
	}
	try { q.setForwardOnly( true ); } catch (e) {}
	if (!q.exec()) {
		datos["error"] = 2;
		return datos;
	}
	if (q.next()) {
		datos["error"] = 0;
		datos["idsubcuenta"] = q.value(0);
		datos["codsubcuenta"] = q.value(1);
		return datos;
	}
	
	with(q) {
		setTablesList("co_cuentas,co_subcuentas,co_cuentasesp");
		setSelect("s.idsubcuenta, s.codsubcuenta");
		setFrom("co_cuentasesp ce INNER JOIN co_cuentas c ON ce.codcuenta = c.codcuenta INNER JOIN co_subcuentas s ON c.idcuenta = s.idcuenta");
		setWhere("ce.idcuentaesp = '" + ctaEsp + "' AND c.codejercicio = '" + codEjercicio + "' ORDER BY s.codsubcuenta");
	}
	try { q.setForwardOnly( true ); } catch (e) {}
	if (!q.exec()) {
		datos["error"] = 2;
		return datos;
	}
	if (q.next()) {
		datos["error"] = 0;
		datos["idsubcuenta"] = q.value(0);
		datos["codsubcuenta"] = q.value(1);
		return datos;
	}

	with(q) {
		setTablesList("co_cuentas,co_subcuentas");
		setSelect("s.idsubcuenta, s.codsubcuenta");
		setFrom("co_cuentas c INNER JOIN co_subcuentas s ON c.idcuenta = s.idcuenta");
		setWhere("c.idcuentaesp = '" + ctaEsp + "' AND c.codejercicio = '" + codEjercicio + "' ORDER BY s.codsubcuenta");
	}
	try { q.setForwardOnly( true ); } catch (e) {}
	if (!q.exec()) {
		datos["error"] = 2;
		return datos;
	}
	if (!q.next()) {
		if (this.iface.consultarCtaEspecial(ctaEsp, codEjercicio)) {
			return this.iface.datosCtaEspecial(ctaEsp, codEjercicio);
		} else {
			datos["error"] = 1;
			return datos;
		}
	}

	datos["error"] = 0;
	datos["idsubcuenta"] = q.value(0);
	datos["codsubcuenta"] = q.value(1);
	return datos;
}

function oficial_consultarCtaEspecial(ctaEsp:String, codEjercicio:String):Boolean
{
	var util:FLUtil = new FLUtil;
	switch (ctaEsp) {
		case "IVASUE": {
			var res:Number = MessageBox.warning(util.translate("scripts", "No tiene establecida la subcuenta de IVA soportado para adquisiciones intracomunitaras (IVASUE).\nEsta subcuenta es necesaria para almacenar información útil para informes como el de facturas emitidas.\n¿Desea indicar cuál es esta subcuenta ahora?"), MessageBox.Yes, MessageBox.No);
			if (res != MessageBox.Yes)
				return false;
			return this.iface.crearCtaEspecial("IVASUE", "subcuenta", codEjercicio, util.translate("scripts", "IVA soportado en adquisiciones intracomunitarias U.E."));
			break;
		}
		case "IVARUE": {
			var res:Number = MessageBox.warning(util.translate("scripts", "No tiene establecida la subcuenta de IVA repercutido para adquisiciones intracomunitaras (IVARUE).\nEsta subcuenta es necesaria para almacenar información útil para informes como el de facturas emitidas.\n¿Desea indicar cuál es esta subcuenta ahora?"), MessageBox.Yes, MessageBox.No);
			if (res != MessageBox.Yes)
				return false;
			return this.iface.crearCtaEspecial("IVARUE", "subcuenta", codEjercicio, util.translate("scripts", "IVA repercutido en adquisiciones intracomunitarias U.E."));
			break;
		}
		case "IVAEUE": {
			var res:Number = MessageBox.warning(util.translate("scripts", "No tiene establecida la subcuenta de IVA para entregas intracomunitaras (IVAEUE).\nEsta subcuenta es necesaria para almacenar información útil para informes como el de facturas emitidas.\n¿Desea indicar cuál es esta subcuenta ahora?"), MessageBox.Yes, MessageBox.No);
			if (res != MessageBox.Yes)
				return false;
			return this.iface.crearCtaEspecial("IVAEUE", "subcuenta", codEjercicio, util.translate("scripts", "IVA en entregas intracomunitarias U.E."));
			break;
		}
		default: {
			return false;
		}
	}
	return false;
}

/* \D Devuelve el código e id de la subcuenta correspondiente a un impuesto y ejercicio determinados
@param	ctaEsp: Tipo de cuenta (IVA soportado, repercutido)

@param	codEjercicio: Código de ejercicio
@param	codImpuesto: Código de impuesto
@return Los datos componen un vector de tres valores:
error: 0.Sin error 1.Datos no encontrados 2.Error al ejecutar la query
idsubcuenta: Identificador de la subcuenta
codsubcuenta: Código de la subcuenta
\end */
function oficial_datosCtaIVA(tipo:String, codEjercicio:String, codImpuesto:String):Array
{
		if (!codImpuesto || codImpuesto == "")
				return this.iface.datosCtaEspecial(tipo, codEjercicio);

		var util:FLUtil = new FLUtil();
		var datos:Array = [];
		var codSubcuenta:String;
		if (tipo == "IVAREP")
				codSubcuenta = util.sqlSelect("impuestos", "codsubcuentarep", "codimpuesto = '" + codImpuesto + "'");
		if (tipo == "IVASOP")
				codSubcuenta = util.sqlSelect("impuestos", "codsubcuentasop", "codimpuesto = '" + codImpuesto + "'");
		if (tipo == "IVAACR")
				codSubcuenta = util.sqlSelect("impuestos", "codsubcuentaacr", "codimpuesto = '" + codImpuesto + "'");
		if (tipo == "IVADEU")
				codSubcuenta = util.sqlSelect("impuestos", "codsubcuentadeu", "codimpuesto = '" + codImpuesto + "'");
		if (tipo == "IVARUE")
				codSubcuenta = util.sqlSelect("impuestos", "codsubcuentaivadevadue", "codimpuesto = '" + codImpuesto + "'");
		if (tipo == "IVASUE")
				codSubcuenta = util.sqlSelect("impuestos", "codsubcuentaivadedadue", "codimpuesto = '" + codImpuesto + "'");
		if (tipo == "IVAEUE")
				codSubcuenta = util.sqlSelect("impuestos", "codsubcuentaivadeventue", "codimpuesto = '" + codImpuesto + "'");
		if (tipo == "IVASIM") {
			var curPrueba:FLSqlCursor = new FLSqlCursor("impuestos");
			if (curPrueba.fieldType("codsubcuentaivasopimp") != 0) {
				codSubcuenta = util.sqlSelect("impuestos", "codsubcuentaivasopimp", "codimpuesto = '" + codImpuesto + "'");
			} else {
				tipo = "IVASOP";
			}
		}
		if (tipo == "IVARXP") {
			var curPrueba:FLSqlCursor = new FLSqlCursor("impuestos");
			if (curPrueba.fieldType("codsubcuentaivarepexp") != 0) {
				codSubcuenta = util.sqlSelect("impuestos", "codsubcuentaivarepexp", "codimpuesto = '" + codImpuesto + "'");
			} else {
				tipo = "IVARXP";
			}
		}
		if (tipo == "IVAREX") {
			var curPrueba:FLSqlCursor = new FLSqlCursor("impuestos");
			if (curPrueba.fieldType("codsubcuentaivarepexe") != 0) {
				codSubcuenta = util.sqlSelect("impuestos", "codsubcuentaivarepexe", "codimpuesto = '" + codImpuesto + "'");
			} else {
				tipo = "IVAREX";
			}
		}
		if (tipo == "IVASEX") {
			var curPrueba:FLSqlCursor = new FLSqlCursor("impuestos");
			if (curPrueba.fieldType("codsubcuentaivasopexe") != 0) {
				codSubcuenta = util.sqlSelect("impuestos", "codsubcuentaivasopexe", "codimpuesto = '" + codImpuesto + "'");
			} else {
				tipo = "IVASEX";
			}
		}

		if (!codSubcuenta || codSubcuenta == "") {
			return this.iface.datosCtaEspecial(tipo, codEjercicio);
		}

		var q:FLSqlQuery = new FLSqlQuery();
		with(q) {
				setTablesList("co_subcuentas");
				setSelect("idsubcuenta, codsubcuenta");
				setFrom("co_subcuentas");
				setWhere("codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + codEjercicio + "'");
		}
		try { q.setForwardOnly( true ); } catch (e) {}
		if (!q.exec()) {
				datos["error"] = 2;
				return datos;
		}
		if (!q.next()) {
				return this.iface.datosCtaEspecial(tipo, codEjercicio);
		}

		datos["error"] = 0;
		datos["idsubcuenta"] = q.value(0);
		datos["codsubcuenta"] = q.value(1);
		return datos;
}

/* \D Devuelve el código e id de la subcuenta de ventas correspondiente a un determinado ejercicio. La cuenta de ventas es la asignada a la serie de facturación. En caso de no estar establecida es la correspondiente a la subcuenta especial marcada como ventas
@param ctaEsp: Tipo de cuenta especial
@param codEjercicio: Código de ejercicio
@param codSerie: Código de serie de la factura
@return Los datos componen un vector de tres valores:
error: 0.Sin error 1.Datos no encontrados 2.Error al ejecutar la query
idsubcuenta: Identificador de la subcuenta
codsubcuenta: Código de la subcuenta
\end */
function oficial_datosCtaVentas(codEjercicio:String, codSerie:String):Array
{
		var util:FLUtil = new FLUtil();
		var datos:Array = [];

		var codCuenta:String = util.sqlSelect("series", "codcuenta", "codserie = '" + codSerie + "'");
		if (codCuenta.toString().isEmpty())
				return this.iface.datosCtaEspecial("VENTAS", codEjercicio);

		var q:FLSqlQuery = new FLSqlQuery();
		with(q) {
				setTablesList("co_cuentas,co_subcuentas");
				setSelect("idsubcuenta, codsubcuenta");
				setFrom("co_cuentas c INNER JOIN co_subcuentas s ON c.idcuenta = s.idcuenta");
				setWhere("c.codcuenta = '" + codCuenta + "' AND c.codejercicio = '" + codEjercicio + "' ORDER BY codsubcuenta");
		}
		try { q.setForwardOnly( true ); } catch (e) {}
		if (!q.exec()) {
				datos["error"] = 2;
				return datos;
		}
		if (!q.next()) {
				datos["error"] = 1;
				return datos;
		}

		datos["error"] = 0;
		datos["idsubcuenta"] = q.value(0);
		datos["codsubcuenta"] = q.value(1);
		return datos;
}

/* \D Devuelve el código e id de la subcuenta de cliente correspondiente a una  determinada factura
@param curFactura: Cursor posicionado en la factura
@param valoresDefecto: Array con los datos de ejercicio y divisa actuales
@return Los datos componen un vector de tres valores:
error: 0.Sin error 1.Datos no encontrados 2.Error al ejecutar la query
idsubcuenta: Identificador de la subcuenta
codsubcuenta: Código de la subcuenta
\end */
function oficial_datosCtaCliente(curFactura:FLSqlCursor, valoresDefecto:Array):Array
{
	return flfactppal.iface.pub_datosCtaCliente( curFactura.valueBuffer("codcliente"), valoresDefecto );
}

/* \D Devuelve el código e id de la subcuenta de proveedor correspondiente a una  determinada factura
@param curFactura: Cursor posicionado en la factura
@param valoresDefecto: Array con los datos de ejercicio y divisa actuales
@return Los datos componen un vector de tres valores:
error: 0.Sin error 1.Datos no encontrados 2.Error al ejecutar la query
idsubcuenta: Identificador de la subcuenta
codsubcuenta: Código de la subcuenta
\end */
function oficial_datosCtaProveedor(curFactura:FLSqlCursor, valoresDefecto:Array):Array
{
	return flfactppal.iface.pub_datosCtaProveedor( curFactura.valueBuffer("codproveedor"), valoresDefecto );
}

/* \D Regenera el asiento correspondiente a una factura de abono de cliente
@param	curFactura: Cursor con los datos de la factura
@param valoresDefecto: Array con los datos de ejercicio y divisa actuales
@return	VERDADERO si no hay error. FALSO en otro caso
\end */
function oficial_asientoNotaCreditoCli(curFactura:FLSqlCursor, valoresDefecto:Array)
{
	var idAsiento:String  = curFactura.valueBuffer("idasiento").toString();
    var idFactura:String = curFactura.valueBuffer("idfactura");
	var curPartidas:FLSqlCursor = new FLSqlCursor("co_partidas");
	var debe:Number = 0;
	var haber:Number = 0;
	var debeME:Number = 0;
	var haberME:Number = 0;
	var aux:Number;
	var util:FLUtil = new FLUtil;
	
	curPartidas.select("idasiento = '" + idAsiento + "'");
	while (curPartidas.next()) {
		curPartidas.setModeAccess(curPartidas.Edit);
		curPartidas.refreshBuffer();
		debe = parseFloat(curPartidas.valueBuffer("debe"));
		haber = parseFloat(curPartidas.valueBuffer("haber"));
		debeME = parseFloat(curPartidas.valueBuffer("debeme"));
		haberME = parseFloat(curPartidas.valueBuffer("haberme"));
		aux = debe;
		debe = haber * -1;
		haber = aux * -1;
		aux = debeME;
		debeME = haberME * -1;
		haberME = aux * -1;
		debe = util.roundFieldValue(debe, "co_partidas", "debe");
		haber = util.roundFieldValue(haber, "co_partidas", "haber");
		debeME = util.roundFieldValue(debeME, "co_partidas", "debeme");
		haberME = util.roundFieldValue(haberME, "co_partidas", "haberme");

		curPartidas.setValueBuffer("debe",  debe);
		curPartidas.setValueBuffer("haber", haber);
		curPartidas.setValueBuffer("debeme",  debeME);
		curPartidas.setValueBuffer("haberme", haberME);

		if (!curPartidas.commitBuffer())
			return false;
	}
	
	var qryPartidasVenta:FLSqlQuery = new FLSqlQuery();
	qryPartidasVenta.setTablesList("co_partidas,co_subcuentas,co_cuentas");
	qryPartidasVenta.setSelect("p.idsubcuenta");
	qryPartidasVenta.setFrom("co_partidas p INNER JOIN co_subcuentas s ON s.idsubcuenta = p.idsubcuenta INNER JOIN co_cuentas c ON c.idcuenta = s.idcuenta ");
	qryPartidasVenta.setWhere("c.idcuentaesp = 'VENTAS' AND idasiento = " + idAsiento);
	try { qryPartidasVenta.setForwardOnly( true ); } catch (e) {}

	if (!qryPartidasVenta.exec())
		return false;

	if (qryPartidasVenta.size == 0)
		return true;

	var ctaDevolVentas = this.iface.datosCtaEspecial("DEVVEN", valoresDefecto.codejercicio);
	if (ctaDevolVentas.error == 1) {
		MessageBox.warning(util.translate("scripts", "No tiene definida una subcuenta especial de devoluciones de ventas.\nEl asiento asociado a la factura no puede ser creado"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	if (ctaDevolVentas.error == 2)
		return false;

	var curPartidasVenta:FLSqlCursor = new FLSqlCursor("co_partidas");

	while (qryPartidasVenta.next()) {
		curPartidasVenta.select("idasiento = " + idAsiento + " AND idsubcuenta = " + qryPartidasVenta.value(0));
		curPartidasVenta.first();
		curPartidasVenta.setModeAccess(curPartidasVenta.Edit);
		curPartidasVenta.refreshBuffer();
		curPartidasVenta.setValueBuffer("idsubcuenta",  ctaDevolVentas.idsubcuenta);
		curPartidasVenta.setValueBuffer("codsubcuenta",  ctaDevolVentas.codsubcuenta);
		if (!curPartidasVenta.commitBuffer())
				return false;
	}

	return true;
}

/* \D Regenera el asiento correspondiente a una nota de débito de cliente
@param	curFactura: Cursor con los datos de la factura
@param valoresDefecto: Array con los datos de ejercicio y divisa actuales
@return	VERDADERO si no hay error. FALSO en otro caso
\end */
function oficial_asientoNotaDebitoCli(curFactura:FLSqlCursor, valoresDefecto:Array)
{
	var idAsiento:String  = curFactura.valueBuffer("idasiento").toString();
    var idFactura:String = curFactura.valueBuffer("idfactura");
	var curPartidas:FLSqlCursor = new FLSqlCursor("co_partidas");
	var debe:Number = 0;
	var haber:Number = 0;
	var debeME:Number = 0;
	var haberME:Number = 0;
	var aux:Number;
	var util:FLUtil = new FLUtil;
	
	curPartidas.select("idasiento = '" + idAsiento + "'");
	while (curPartidas.next()) {
		curPartidas.setModeAccess(curPartidas.Edit);
		curPartidas.refreshBuffer();
		debe = parseFloat(curPartidas.valueBuffer("debe"));
		haber = parseFloat(curPartidas.valueBuffer("haber"));
		debeME = parseFloat(curPartidas.valueBuffer("debeme"));
		haberME = parseFloat(curPartidas.valueBuffer("haberme"));
		debe = util.roundFieldValue(debe, "co_partidas", "debe");
		haber = util.roundFieldValue(haber, "co_partidas", "haber");
		debeME = util.roundFieldValue(debeME, "co_partidas", "debeme");
		haberME = util.roundFieldValue(haberME, "co_partidas", "haberme");

		curPartidas.setValueBuffer("debe",  debe);
		curPartidas.setValueBuffer("haber", haber);
		curPartidas.setValueBuffer("debeme",  debeME);
		curPartidas.setValueBuffer("haberme", haberME);

		if (!curPartidas.commitBuffer())
			return false;
	}
	
	var qryPartidasVenta:FLSqlQuery = new FLSqlQuery();
	qryPartidasVenta.setTablesList("co_partidas,co_subcuentas,co_cuentas");
	qryPartidasVenta.setSelect("p.idsubcuenta");
	qryPartidasVenta.setFrom("co_partidas p INNER JOIN co_subcuentas s ON s.idsubcuenta = p.idsubcuenta INNER JOIN co_cuentas c ON c.idcuenta = s.idcuenta ");
	qryPartidasVenta.setWhere("c.idcuentaesp = 'VENTAS' AND idasiento = " + idAsiento);
	try { qryPartidasVenta.setForwardOnly( true ); } catch (e) {}

	if (!qryPartidasVenta.exec())
		return false;

	if (qryPartidasVenta.size == 0)
		return true;

	var ctaDevolVentas = this.iface.datosCtaEspecial("DEBVEN", valoresDefecto.codejercicio);
	if (ctaDevolVentas.error == 1) {
		MessageBox.warning(util.translate("scripts", "No tiene definida una subcuenta especial de notas de débitos de ventas.\nEl asiento asociado a la factura no puede ser creado"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	if (ctaDevolVentas.error == 2)
		return false;

	var curPartidasVenta:FLSqlCursor = new FLSqlCursor("co_partidas");

	while (qryPartidasVenta.next()) {
		curPartidasVenta.select("idasiento = " + idAsiento + " AND idsubcuenta = " + qryPartidasVenta.value(0));
		curPartidasVenta.first();
		curPartidasVenta.setModeAccess(curPartidasVenta.Edit);
		curPartidasVenta.refreshBuffer();
		curPartidasVenta.setValueBuffer("idsubcuenta",  ctaDevolVentas.idsubcuenta);
		curPartidasVenta.setValueBuffer("codsubcuenta",  ctaDevolVentas.codsubcuenta);
		if (!curPartidasVenta.commitBuffer())
				return false;
	}

	return true;
}

/* \D Regenera el asiento correspondiente a una factura de abono de proveedor
@param	curFactura: Cursor con los datos de la factura
@param valoresDefecto: Array con los datos de ejercicio y divisa actuales
@return	VERDADERO si no hay error. FALSO en otro caso
\end */
function oficial_asientoNotaCreditoProv(curFactura:FLSqlCursor, valoresDefecto:Array)
{
	var idAsiento:String  = curFactura.valueBuffer("idasiento").toString();
    var idFactura:String = curFactura.valueBuffer("idfactura");
	var curPartidas:FLSqlCursor = new FLSqlCursor("co_partidas");
	var debe:Number = 0;
	var haber:Number = 0;
	var debeME:Number = 0;
	var haberME:Number = 0;
	var aux:Number;
	
	var util:FLUtil = new FLUtil;
	
	curPartidas.select("idasiento = '" + idAsiento + "'");
	while (curPartidas.next()) {
		curPartidas.setModeAccess(curPartidas.Edit);
		curPartidas.refreshBuffer();
		debe = parseFloat(curPartidas.valueBuffer("debe"));
		haber = parseFloat(curPartidas.valueBuffer("haber"));
		debeME = parseFloat(curPartidas.valueBuffer("debeme"));
		haberME = parseFloat(curPartidas.valueBuffer("haberme"));
		aux = debe;
		debe = haber * -1;
		haber = aux * -1;
		aux = debeME;
		debeME = haberME * -1;
		haberME = aux * -1;
		debe = util.roundFieldValue(debe, "co_partidas", "debe");
		haber = util.roundFieldValue(haber, "co_partidas", "haber");
		debeME = util.roundFieldValue(debeME, "co_partidas", "debeme");
		haberME = util.roundFieldValue(haberME, "co_partidas", "haberme");

		curPartidas.setValueBuffer("debe",  debe);
		curPartidas.setValueBuffer("haber", haber);
		curPartidas.setValueBuffer("debeme",  debeME);
		curPartidas.setValueBuffer("haberme", haberME);

		if (!curPartidas.commitBuffer())
			return false;
	}
	
	var qryPartidasCompra:FLSqlQuery = new FLSqlQuery();
	qryPartidasCompra.setTablesList("co_partidas,co_subcuentas,co_cuentas");
	qryPartidasCompra.setSelect("p.idsubcuenta");
	qryPartidasCompra.setFrom("co_partidas p INNER JOIN co_subcuentas s ON s.idsubcuenta = p.idsubcuenta INNER JOIN co_cuentas c ON c.idcuenta = s.idcuenta ");
	qryPartidasCompra.setWhere("c.idcuentaesp = 'COMPRA' AND idasiento = " + idAsiento);
	try { qryPartidasCompra.setForwardOnly( true ); } catch (e) {}

	if (!qryPartidasCompra.exec())
		return false;

	if (qryPartidasCompra.size() == 0)
		return true;
	
	var ctaDevolCompra:Array = this.iface.datosCtaEspecial("DEVCOM", valoresDefecto.codejercicio);
	if (ctaDevolCompra.error == 1) {
		MessageBox.warning(util.translate("scripts", "No tiene definida una subcuenta especial de devoluciones de compras.\nEl asiento asociado a la factura no puede ser creado"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	if (ctaDevolCompra.error == 2)
		return false;

	var curPartidasCompra:FLSqlCursor = new FLSqlCursor("co_partidas");
	while (qryPartidasCompra.next()) {
		curPartidasCompra.select("idasiento = " + idAsiento + " AND idsubcuenta = " + qryPartidasCompra.value(0));
		curPartidasCompra.first();
		curPartidasCompra.setModeAccess(curPartidasCompra.Edit);
		curPartidasCompra.refreshBuffer();
		curPartidasCompra.setValueBuffer("idsubcuenta",  ctaDevolCompra.idsubcuenta);
		curPartidasCompra.setValueBuffer("codsubcuenta",  ctaDevolCompra.codsubcuenta);
		if (!curPartidasCompra.commitBuffer())
				return false;
	}
	return true;
}

/* \D Regenera el asiento correspondiente a una nota de débito de proveedor
@param	curFactura: Cursor con los datos de la factura
@param valoresDefecto: Array con los datos de ejercicio y divisa actuales
@return	VERDADERO si no hay error. FALSO en otro caso
\end */
function oficial_asientoNotaDebitoProv(curFactura:FLSqlCursor, valoresDefecto:Array)
{
	var idAsiento:String  = curFactura.valueBuffer("idasiento").toString();
    var idFactura:String = curFactura.valueBuffer("idfactura");
	var curPartidas:FLSqlCursor = new FLSqlCursor("co_partidas");
	var debe:Number = 0;
	var haber:Number = 0;
	var debeME:Number = 0;
	var haberME:Number = 0;
	var aux:Number;
	
	var util:FLUtil = new FLUtil;
	
	curPartidas.select("idasiento = '" + idAsiento + "'");
	while (curPartidas.next()) {
		curPartidas.setModeAccess(curPartidas.Edit);
		curPartidas.refreshBuffer();
		debe = parseFloat(curPartidas.valueBuffer("debe"));
		haber = parseFloat(curPartidas.valueBuffer("haber"));
		debeME = parseFloat(curPartidas.valueBuffer("debeme"));
		haberME = parseFloat(curPartidas.valueBuffer("haberme"));
		debe = util.roundFieldValue(debe, "co_partidas", "debe");
		haber = util.roundFieldValue(haber, "co_partidas", "haber");
		debeME = util.roundFieldValue(debeME, "co_partidas", "debeme");
		haberME = util.roundFieldValue(haberME, "co_partidas", "haberme");

		curPartidas.setValueBuffer("debe",  debe);
		curPartidas.setValueBuffer("haber", haber);
		curPartidas.setValueBuffer("debeme",  debeME);
		curPartidas.setValueBuffer("haberme", haberME);

		if (!curPartidas.commitBuffer())
			return false;
	}
	
	var qryPartidasCompra:FLSqlQuery = new FLSqlQuery();
	qryPartidasCompra.setTablesList("co_partidas,co_subcuentas,co_cuentas");
	qryPartidasCompra.setSelect("p.idsubcuenta");
	qryPartidasCompra.setFrom("co_partidas p INNER JOIN co_subcuentas s ON s.idsubcuenta = p.idsubcuenta INNER JOIN co_cuentas c ON c.idcuenta = s.idcuenta ");
	qryPartidasCompra.setWhere("c.idcuentaesp = 'COMPRA' AND idasiento = " + idAsiento);
	try { qryPartidasCompra.setForwardOnly( true ); } catch (e) {}

	if (!qryPartidasCompra.exec())
		return false;

	if (qryPartidasCompra.size() == 0)
		return true;
	
	var ctaDevolCompra:Array = this.iface.datosCtaEspecial("DEBCOM", valoresDefecto.codejercicio);
	if (ctaDevolCompra.error == 1) {
		MessageBox.warning(util.translate("scripts", "No tiene definida una subcuenta especial de notas de débitos de compras.\nEl asiento asociado a la factura no puede ser creado"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	if (ctaDevolCompra.error == 2)
		return false;

	var curPartidasCompra:FLSqlCursor = new FLSqlCursor("co_partidas");
	while (qryPartidasCompra.next()) {
		curPartidasCompra.select("idasiento = " + idAsiento + " AND idsubcuenta = " + qryPartidasCompra.value(0));
		curPartidasCompra.first();
		curPartidasCompra.setModeAccess(curPartidasCompra.Edit);
		curPartidasCompra.refreshBuffer();
		curPartidasCompra.setValueBuffer("idsubcuenta",  ctaDevolCompra.idsubcuenta);
		curPartidasCompra.setValueBuffer("codsubcuenta",  ctaDevolCompra.codsubcuenta);
		if (!curPartidasCompra.commitBuffer())
				return false;
	}
	return true;
}

/** \D Si la fecha no está dentro del ejercicio, propone al usuario la selección de uno nuevo
@param	fecha: Fecha del documento
@param	codEjercicio: Ejercicio del documento
@param	tipoDoc: Tipo de documento a generar
@return	Devuelve un array con los siguientes datos:
ok:	Indica si la función terminó correctamente (true) o con error (false)
modificaciones: Indica si se ha modificado algún valor (fecha o ejercicio)
fecha: Nuevo valor para la fecha modificada
codEjercicio: Nuevo valor para el ejercicio modificado
\end */
function oficial_datosDocFacturacion(fecha:String, codEjercicio:String, tipoDoc:String):Array
{
	
	var res:Array = [];
	res["ok"] = true;
	res["modificaciones"] = false;
	
	var util:FLUtil = new FLUtil;
	if (util.sqlSelect("ejercicios", "codejercicio", "codejercicio = '" + codEjercicio + "' AND '" + fecha + "' BETWEEN fechainicio AND fechafin"))
		return res;
		
	var f:Object = new FLFormSearchDB("fechaejercicio");
	var cursor:FLSqlCursor = f.cursor();
	
	cursor.select();
	if (!cursor.first())
		cursor.setModeAccess(cursor.Insert);
	else
		cursor.setModeAccess(cursor.Edit);
	cursor.refreshBuffer();

	cursor.refreshBuffer();
	cursor.setValueBuffer("fecha", fecha);
	cursor.setValueBuffer("codejercicio", codEjercicio);
	cursor.setValueBuffer("label", tipoDoc);
	cursor.commitBuffer();
	cursor.select();

	if (!cursor.first()) {
		res["ok"] = false;
		return res;
	}

	cursor.setModeAccess(cursor.Edit);
	cursor.refreshBuffer();

	f.setMainWidget();
	
	var acpt:String = f.exec("codejercicio");
	if (!acpt) {
		res["ok"] = false;
		return res;
	}
	res["modificaciones"] = true;
	res["fecha"] = cursor.valueBuffer("fecha");
	res["codEjercicio"] = cursor.valueBuffer("codejercicio");
	
	if (res.codEjercicio != flfactppal.iface.pub_ejercicioActual()) {
		if (tipoDoc != "pagosdevolcli" && tipoDoc != "pagosdevolprov") {
			MessageBox.information(util.translate("scripts", "Ha seleccionado un ejercicio distinto del actual.\nPara visualizar los documentos generados debe cambiar el ejercicio actual en la ventana\nde empresa y volver a abrir el formulario maestro correspondiente a los documentos generados"), MessageBox.Ok, MessageBox.NoButton);
		}
	}
	
	return res;
}

/** \C Establece si un documento de cliente debe tener IVA. No lo tendrá si el cliente seleccionado está exento, o la serie seleccionada sea sin IVA
@param	codSerie: Serie del documento
@param	codCliente: Código del cliente
@return	Devuelve verdadero si lleva iva o falso si no lleva
\end */
function oficial_tieneIvaDocCliente(codSerie:String, codCliente:String, codEjercicio:String):Boolean
{
	var util:FLUtil = new FLUtil;
	var conIva:Boolean = true;
	
	if (util.sqlSelect("series", "siniva", "codserie = '" + codSerie + "'"))
		return false;
	else {
		var regIva:String = util.sqlSelect("clientes", "regimeniva", "codcliente = '" + codCliente + "'");
		if (regIva == "Exento")
			return false;
		else
			return true;
	}
}

/** \C Establece si un documento de proveedor debe tener IVA. No lo tendrá si el proveedor seleccionado está exento, o la serie seleccionada sea sin IVA
@param	codSerie: Serie del documento
@param	codProveedor: Código del proveedor
@return	Devuelve verdadero si lleva iva o falso si no lleva
\end */
function oficial_tieneIvaDocProveedor(codSerie:String, codProveedor:String, codEjercicio:String):Boolean
{
	var util:FLUtil = new FLUtil;
	var conIva:Boolean = true;
	
	if (util.sqlSelect("series", "siniva", "codserie = '" + codSerie + "'"))
		return false;
	else {
		var regIva:String = util.sqlSelect("proveedores", "regimeniva", "codproveedor = '" + codProveedor + "'");
		if (regIva == "Exento")
			return false;
		else
			return true;
	}
}

/** \D Indica si el módulo de autómata está instalado y activado
@return	true si está activado, false en caso contrario
\end */
function oficial_automataActivado():Boolean
{
	if (!sys.isLoadedModule("flautomata"))
		return false;
	
	if (formau_automata.iface.pub_activado())
		return true;
	
	return false;
}

/** \D Comprueba que si la factura tiene IVA, no esté incluida en un período de regularización ya cerrado
@param	curFactura: Cursor de la factura de cliente o proveedor
@return TRUE si la factura no tiene IVA o teniéndolo su fecha no está incluida en ningún período ya cerrado. FALSE en caso contrario
\end */
function oficial_comprobarRegularizacion(curFactura:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	var fecha:String = curFactura.valueBuffer("fecha");
	if (util.sqlSelect("co_regiva", "idregiva", "fechainicio <= '" + fecha + "' AND fechafin >= '" + fecha + "' AND codejercicio = '" + curFactura.valueBuffer("codejercicio") + "'")) {
		MessageBox.warning(util.translate("scripts", "No puede incluirse el asiento de la factura en un período de I.V.A. ya regularizado"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	return true;
}

/** \D
Recalcula la tabla huecos y el último valor de la secuencia de numeración.
@param serie: Código de serie del documento
@param ejercicio: Código de ejercicio del documento
@param fN: Tipo de documento (factura a cliente, a proveedor, remito, etc.)
@return true si el calculo se ralizó correctamente
\end */
function oficial_recalcularHuecos( serie:String, ejercicio:String, fN:String ):Boolean {
	var util:FLUtil = new FLUtil;
	var tipo:String;
	var tabla:String;

	if ( fN == "nfacturaprov" ) {
		tipo = "FP";
		tabla = "facturasprov"
	} else if (fN == "nfacturacli") {
		tipo = "FC";
		tabla = "facturascli";
	}

	var idSec = util.sqlSelect( "secuenciasejercicios", "id", "codserie = '" + serie + "' AND codejercicio = '" + ejercicio + "'" );

	if ( idSec ) {
		var nHuecos:Number = parseInt( util.sqlSelect( "huecos", "count(*)", "codserie = '" + serie + "' AND codejercicio = '" + ejercicio + "' AND tipo = '" + tipo + "'" ) );
		var nFacturas:Number = parseInt( util.sqlSelect( tabla, "count(*)", "codserie = '" + serie + "' AND codejercicio = '" + ejercicio + "'" ) );
		var maxFactura:Number = parseInt( util.sqlSelect( "secuencias", "valorout", "id = " + idSec + " AND nombre='" + fN + "'" ) ) - 1;
		if (isNaN(maxFactura))
			maxFactura = 0;

		if ( maxFactura - nFacturas != nHuecos ) {
			var nSec:Number = 0;
			var nFac:Number = 0;
			var ultFac:Number = -1;
			var cursorHuecos:FLSqlCursor = new FLSqlCursor("huecos");
			var qryFac:FLSqlQuery = new FLSqlQuery();

			util.createProgressDialog( util.translate( "scripts", "Calculando huecos en la numeración..." ), maxFactura );

			qryFac.setTablesList( tabla );
			qryFac.setSelect( "numero" );
			qryFac.setFrom( tabla );
			qryFac.setWhere( "codserie = '" + serie + "' AND codejercicio = '" + ejercicio + "'" );
			qryFac.setOrderBy( "codigo asc" );
			qryFac.setForwardOnly( true );

			if ( !qryFac.exec() )
				return true;

			util.sqlDelete( "huecos", "codserie = '" + serie + "' AND codejercicio = '" + ejercicio + "' AND ( tipo = 'XX' OR tipo = '" + tipo + "')" );

			while ( qryFac.next() ) {
				nFac = qryFac.value( 0 );
				
				// Por si hay duplicados, que no debería haberlos...
				if (ultFac == nFac)
					continue;
				ultFac = nFac;
				
				util.setProgress( ++nSec );
				while ( nSec < nFac ) {
					cursorHuecos.setModeAccess( cursorHuecos.Insert );
					cursorHuecos.refreshBuffer();
					cursorHuecos.setValueBuffer( "tipo", tipo );
					cursorHuecos.setValueBuffer( "codserie", serie );
					cursorHuecos.setValueBuffer( "codejercicio", ejercicio );
					cursorHuecos.setValueBuffer( "numero", nSec );
					cursorHuecos.commitBuffer();
					util.setProgress( ++nSec );
				}
			}
			
			util.setProgress( ++nSec );
			util.sqlUpdate( "secuencias", "valorout", nSec, "id = " + idSec + " AND nombre='" + fN + "'" );

			util.setProgress( maxFactura );
			util.destroyProgressDialog();
		}
	}

	return true;
}

/** \D Lanza el formulario que muestra los documentos relacionados con un determinado documento de facturación
@param	codigo: Código del documento
@param	tipo: Tipo del documento
\end */
function oficial_mostrarTraza(codigo:String, tipo:String)
{
	var util:FLUtil = new FLUtil();
	util.sqlDelete("trazadoc", "usuario = '" + sys.nameUser() + "'");

	var f:Object = new FLFormSearchDB("trazadoc");
	var curTraza:FLSqlCursor = f.cursor();
	curTraza.setModeAccess(curTraza.Insert);
	curTraza.refreshBuffer();
	curTraza.setValueBuffer("usuario", sys.nameUser());
	curTraza.setValueBuffer("codigo", codigo);
	curTraza.setValueBuffer("tipo", tipo);
	if (!curTraza.commitBuffer())
		return false;;

	curTraza.select("usuario = '" + sys.nameUser() + "'");
	if (!curTraza.first())
		return false;

	curTraza.setModeAccess(curTraza.Browse);
	f.setMainWidget();
	curTraza.refreshBuffer();
	var acpt:String = f.exec("usuario");
}

/** \D Establece los datos opcionales de una partida de IVA decompras/ventas.
Para facilitar personalizaciones en las partidas.
Se ponen datos de concepto, tipo de documento, documento y factura
@param	curPartida: Cursor sobre la partida
@param	curFactura: Cursor sobre la factura
@param	tipo: cliente / proveedor
@param	concepto: Concepto, opcional
*/
function oficial_datosPartidaFactura(curPartida:FLSqlCursor, curFactura:FLSqlCursor, tipo:String, concepto:String) 
{
	var util:FLUtil = new FLUtil();
	
	if (tipo == "cliente") {
		if (concepto)
			curPartida.setValueBuffer("concepto", concepto);
		else
			curPartida.setValueBuffer("concepto", util.translate("scripts", "Nuestra factura ") + curFactura.valueBuffer("codigo") + " - " + curFactura.valueBuffer("nombrecliente"));
		
		// Si es de IVA
		if (curPartida.valueBuffer("cifnif"))
			curPartida.setValueBuffer("tipodocumento", "Factura de cliente");
	}
	else {
		if (concepto)
			curPartida.setValueBuffer("concepto", concepto);
		else
			curPartida.setValueBuffer("concepto", util.translate("scripts", "Su factura ") + curFactura.valueBuffer("codigo") + " - " + curFactura.valueBuffer("nombre"));
		
		// Si es de IVA
		if (curPartida.valueBuffer("cifnif"))
		curPartida.setValueBuffer("tipodocumento", "Factura de proveedor");
	}
	
	// Si es de IVA
	if (curPartida.valueBuffer("cifnif")) {
		curPartida.setValueBuffer("documento", curFactura.valueBuffer("codigo"));
		curPartida.setValueBuffer("factura", curFactura.valueBuffer("numero"));
	}
}

/** \D Comprueba si hay condiciones para regenerar los recibos de una factura
cuando se edita la misma. Para sobrecargar en extensiones
@param	curFactura: Cursor de la factura
@param	masCampos: Array con los nombres de campos adicionales. Opcional
@return	VERDADERO si hay que regenerar, FALSO en otro caso
\end */
function oficial_siGenerarRecibosCli(curFactura:FLSqlCursor, masCampos:Array):Boolean 
{
	var camposAcomprobar = new Array("codcliente","total","codpago","fecha");
	
	for (var i:Number = 0; i < camposAcomprobar.length; i++)
		if (curFactura.valueBuffer(camposAcomprobar[i]) != curFactura.valueBufferCopy(camposAcomprobar[i]))
			return true;
	
	if (masCampos) {
		for (i = 0; i < masCampos.length; i++)
			if (curFactura.valueBuffer(masCampos[i]) != curFactura.valueBufferCopy(masCampos[i]))
				return true;
	}
	
	return false;
}

function oficial_validarIvaCliente(codCliente:String,id:Number,tabla:String,identificador:String):Boolean
{
	return true; // No valida por ahora

	var util:FLUtil;

	if(!codCliente)
		return true;

	var regimenIva = util.sqlSelect("clientes","regimeniva","codcliente = '" + codCliente + "'");
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList(tabla);
	q.setSelect("iva");
	q.setFrom(tabla);
	q.setWhere(identificador + " = " + id);
	
	if (!q.exec())
		return false;

	var preguntadoIva:Boolean = false;
	while (q.next() && (!preguntadoIva)) {
				var iva:Number = parseFloat(q.value("iva"));
		if(!iva)
			iva = 0;

		if(!preguntadoIva) {
			switch (regimenIva) {
				case "Consumidor Final":
				case "No Responsable":
				case "Responsable Monotributo":
				case "Responsable Inscripto":
				case "Responsable No Inscripto": {
					if (iva == 0) {
						var res:Number = MessageBox.warning(util.translate("scripts", "El cliente %1 tiene establecido un régimen de I.V.A. %2\ny en alguna o varias de las lineas no hay establecido un % de I.V.A.\n¿Desea continuar de todas formas?").arg(codCliente).arg(regimenIva), MessageBox.Yes,MessageBox.No);
						preguntadoIva = true;
						if (res != MessageBox.Yes)
							return false;
					}
				}
				break;
				case "Exento": {
					if (iva != 0) {
						var res:Number = MessageBox.warning(util.translate("scripts", "El cliente %1 tiene establecido un régimen de I.V.A. %2\ny en alguna o varias de las lineas hay establecido un % de I.V.A.\n¿Desea continuar de todas formas?").arg(codCliente).arg(regimenIva), MessageBox.Yes,MessageBox.No);
						preguntadoIva = true;
						if (res != MessageBox.Yes)
							return false;
					}
				}
				break;
			}
		}
	}

	return true;
}

function oficial_validarIvaProveedor(codProveedor:String,id:Number,tabla:String,identificador:String):Boolean
{
	return true; // No valida por ahora

	var util:FLUtil;

	if(!codProveedor)
		return true;	

	var regimenIva = util.sqlSelect("proveedores","regimeniva","codproveedor = '" + codProveedor + "'");
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList(tabla);
	q.setSelect("iva");
	q.setFrom(tabla);
	q.setWhere(identificador + " = " + id);
	
	if (!q.exec())
		return false;

	var preguntadoIva:Boolean = false;
	while (q.next()  && (!preguntadoIva)) {
		var iva:Number = parseFloat(q.value("iva"));
		if(!iva)
			iva = 0;

		if(!preguntadoIva) {
			switch (regimenIva) {
				case "Consumidor Final":
				case "No Responsable":
				case "Responsable Monotributo":
				case "Responsable Inscripto":
				case "Responsable No Inscripto": {
					if (iva == 0) {
						var res:Number = MessageBox.warning(util.translate("scripts", "El proveedor %1 tiene establecido un régimen de I.V.A. %2\ny en alguna o varias de las lineas no hay establecido un % de I.V.A.\n¿Desea continuar de todas formas?").arg(codProveedor).arg(regimenIva), MessageBox.Yes,MessageBox.No);
						preguntadoIva = true;
						if (res != MessageBox.Yes)
							return false;
					}
				}
				break;
				case "Exento": {
					if (iva != 0) {
						var res:Number = MessageBox.warning(util.translate("scripts", "El proveedor %1 tiene establecido un régimen de I.V.A. %2\ny en alguna o varias de las lineas hay establecido un % de I.V.A.\n¿Desea continuar de todas formas?").arg(codProveedor).arg(regimenIva), MessageBox.Yes,MessageBox.No);
						preguntadoIva = true;
						if (res != MessageBox.Yes)
							return false;
					}
				}
				break;
			}
		}
	}

	return true;
}

function oficial_comprobarNotaCreditoCli(curFactura:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (curFactura.valueBuffer("decredito") == true) {
		if (!curFactura.valueBuffer("idfacturarect")){
			var res:Number = MessageBox.warning(util.translate("scripts", "No ha indicado la factura que desea rectificar.\n¿Desea continuar?"), MessageBox.No, MessageBox.Yes);
			if (res != MessageBox.Yes) {
				return false;
			}
		} else {
			if (util.sqlSelect("facturascli", "idfacturarect", "idfacturarect = " + curFactura.valueBuffer("idfacturarect") + " AND idfactura <> " + curFactura.valueBuffer("idfactura"))) {
				MessageBox.warning(util.translate("scripts", "La factura ") +  util.sqlSelect("facturascli", "codigo", "idfactura = " + curFactura.valueBuffer("idfacturarect"))  + util.translate("scripts", " ya está rectificada"),MessageBox.Ok, MessageBox.NoButton,MessageBox.NoButton);
				return false;
			}
		}
	}
	return true;
}

function oficial_comprobarNotaDebitoCli(curFactura:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (curFactura.valueBuffer("dedebito") == true) {
		if (!curFactura.valueBuffer("idfacturarect")){
			var res:Number = MessageBox.warning(util.translate("scripts", "No ha indicado la factura que desea rectificar.\n¿Desea continuar?"), MessageBox.No, MessageBox.Yes);
			if (res != MessageBox.Yes) {
				return false;
			}
		} else {
			if (util.sqlSelect("facturascli", "idfacturarect", "idfacturarect = " + curFactura.valueBuffer("idfacturarect") + " AND idfactura <> " + curFactura.valueBuffer("idfactura"))) {
				MessageBox.warning(util.translate("scripts", "La factura ") +  util.sqlSelect("facturascli", "codigo", "idfactura = " + curFactura.valueBuffer("idfacturarect"))  + util.translate("scripts", " ya está rectificada"),MessageBox.Ok, MessageBox.NoButton,MessageBox.NoButton);
				return false;
			}
		}
	}
	return true;
}

function oficial_comprobarNotaCreditoProv(curFactura:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (curFactura.valueBuffer("decredito") == true) {
		if (!curFactura.valueBuffer("idfacturarect")){
			var res:Number = MessageBox.warning(util.translate("scripts", "No ha indicado la factura que desea rectificar.\n¿Desea continuar?"), MessageBox.No, MessageBox.Yes);
			if (res != MessageBox.Yes) {
				return false;
			}
		}
		if (util.sqlSelect("facturasprov", "idfacturarect", "idfacturarect = " + curFactura.valueBuffer("idfacturarect") + " AND idfactura <> " + curFactura.valueBuffer("idfactura") + " AND decredito = true")) {
			MessageBox.warning(util.translate("scripts", "De la factura ") +  util.sqlSelect("facturasprov", "codigo", "idfactura = " + curFactura.valueBuffer("idFacturarect"))  + util.translate("scripts", " ya se ha generado una nota de crédito"),MessageBox.Ok, MessageBox.NoButton,MessageBox.NoButton);
			return false;
		}
	}
	return true;
}

function oficial_comprobarNotaDebitoProv(curFactura:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (curFactura.valueBuffer("dedebito") == true) {
		if (!curFactura.valueBuffer("idfacturarect")){
			var res:Number = MessageBox.warning(util.translate("scripts", "No ha indicado la factura que desea rectificar.\n¿Desea continuar?"), MessageBox.No, MessageBox.Yes);
			if (res != MessageBox.Yes) {
				return false;
			}
		}
		if (util.sqlSelect("facturasprov", "idfacturarect", "idfacturarect = " + curFactura.valueBuffer("idfacturarect") + " AND idfactura <> " + curFactura.valueBuffer("idfactura") + " AND dedebito = true")) {
			MessageBox.warning(util.translate("scripts", "De la factura ") +  util.sqlSelect("facturasprov", "codigo", "idfactura = " + curFactura.valueBuffer("idFacturarect"))  + util.translate("scripts", " ya se ha generado una nota de débito"),MessageBox.Ok, MessageBox.NoButton,MessageBox.NoButton);
			return false;
		}
	}
	return true;
}

function oficial_controlFacturaRectificada(curFactura:FLSqlCursor, factura:String):Boolean
{
	var util:FLUtil = new FLUtil();
	if ( curFactura.valueBuffer("idfacturarect") ) {

		var rectificada:Boolean;
		var idFactura:Number = curFactura.valueBuffer("idfacturarect");
		var idFacturaAnterior:Number;
		switch (curFactura.modeAccess()) {
			case curFactura.Insert: {
				rectificada = true;
				break;
			}
			case curFactura.Del: {
				rectificada = false;
				break;
			}
			case curFactura.Edit: {
				rectificada = true;
				if (curFactura.valueBuffer("idfacturarect") != curFactura.valueBufferCopy("idfacturarect"))
					idFacturaAnterior = curFactura.valueBufferCopy("idfacturarect");
				break;
			}
			break;
		}

		var editable:Boolean = util.sqlSelect(factura, "editable", "idfactura = " + idFactura);
		if ( !editable)
			flfactppal.iface.pub_setUnLock(factura, idFactura, true);

		var curFactura:FLSqlCursor = new FLSqlCursor(factura);
		curFactura.select("idfactura =" + idFactura);
		if (curFactura.next()) {
			curFactura.setActivatedCommitActions(false);
			curFactura.setModeAccess(curFactura.Edit);
			curFactura.refreshBuffer();
			curFactura.setValueBuffer("rectificada", rectificada);
			curFactura.commitBuffer();
		}

		if ( !editable)
			flfactppal.iface.pub_setUnLock(factura, idFactura, false);


		if (idFacturaAnterior) {

			editable = util.sqlSelect(factura, "editable", "idfactura = " + idFacturaAnterior);
			if ( !editable)
				flfactppal.iface.pub_setUnLock(factura, idFacturaAnterior, true);

			delete curFactura;
			curFactura = new FLSqlCursor(factura);
			rectificada = !rectificada;
			curFactura.select("idfactura =" + idFacturaAnterior);
			if (curFactura.next()) {
				curFactura.setActivatedCommitActions(false);
				curFactura.setModeAccess(curFactura.Edit);
				curFactura.refreshBuffer();
				curFactura.setValueBuffer("rectificada", rectificada);
				curFactura.commitBuffer();
			}

			if ( !editable)
				flfactppal.iface.pub_setUnLock(factura, idFacturaAnterior, false);

		}

	}

	return true;
}

function oficial_crearCtaEspecial(codCtaEspecial:String, tipo:String, codEjercicio:String, desCta:String):Boolean
{
	var util:FLUtil = new FLUtil();
	
	var codSubcuenta:String;
	if (tipo == "subcuenta") {
		var f:Object = new FLFormSearchDB("co_subcuentas");
		var curSubcuenta:FLSqlCursor = f.cursor();
		curSubcuenta.setMainFilter("codejercicio = '" + codEjercicio + "'");
		
		f.setMainWidget();
		codSubcuenta = f.exec("codsubcuenta");
		if (!codSubcuenta)
			return false;
	}
	var curCtaEspecial:FLSqlCursor = new FLSqlCursor("co_cuentasesp");
	curCtaEspecial.select("idcuentaesp = '" + codCtaEspecial + "'");
	if (curCtaEspecial.first()) {
		curCtaEspecial.setModeAccess(curCtaEspecial.Edit);
		curCtaEspecial.refreshBuffer();
	} else {
		curCtaEspecial.setModeAccess(curCtaEspecial.Insert);
		curCtaEspecial.refreshBuffer();
		curCtaEspecial.setValueBuffer("idcuentaesp", codCtaEspecial);
		curCtaEspecial.setValueBuffer("descripcion", desCta);
	}
	if (codSubcuenta && codSubcuenta != "") {
		curCtaEspecial.setValueBuffer("codsubcuenta", codSubcuenta);
	}
	if (!curCtaEspecial.commitBuffer())
		return false;

	return true;
}

function oficial_comprobarCambioSerie(cursor:FLSqlCursor):Boolean
{
	var util:FLUtil;
	if(!cursor.valueBuffer("codserie") || cursor.valueBuffer("codserie") == "" || !cursor.valueBufferCopy("codserie") || cursor.valueBufferCopy("codserie") == "")
		return true;
	if(cursor.valueBuffer("codserie") != cursor.valueBufferCopy("codserie")) {
		var util:FLUtil = new FLUtil();
		MessageBox.warning(util.translate("scripts", "No se puede modificar la serie.\nSerie anterior: %1 - Serie actual: %2").arg(cursor.valueBufferCopy("codserie")).arg(cursor.valueBuffer("codserie")), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	return true;
}

/** Función a sobrecargar por la extensión de subcuenta de ventas por artículo
\end */
function oficial_subcuentaVentas(referencia:String, codEjercicio:String):Array
{
	return false;
}

// function oficial_liberarPedidosCli(curAlbaran:FLSqlCursor):Boolean
// {
// 	var idLineaAlbaran:Number;
// 	var idLineaPedido:Number;
// 	var numeroPedido:Number;
// 
// 	var query:FLSqlQuery = new FLSqlQuery();
// 	query.setTablesList("lineasalbaranescli");
// 	query.setSelect("idlineapedido, idlinea");
// 	query.setFrom("lineasalbaranescli");
// 	query.setWhere("idalbaran = " + curAlbaran.valueBuffer("idalbaran") + " AND idlineapedido <> 0;");
// 	query.exec();
// 
// 	while (query.next()) {
// 		idLineaPedido = query.value("idlineapedido");
// 		idLineaAlbaran = query.value("idlinea");
// 		if (!this.iface.restarCantidadCli(idLineaPedido, idLineaAlbaran)) {
// 			return false;
// 		}
// 	}
// 
// 	var qryPedido:FLSqlQuery = new FLSqlQuery();
// 	qryPedido.setTablesList("lineasalbaranescli");
// 	qryPedido.setSelect("idpedido");
// 	qryPedido.setFrom("lineasalbaranescli");
// 	qryPedido.setWhere("idalbaran = " + curAlbaran.valueBuffer("idalbaran") + " AND idpedido <> 0 GROUP BY idpedido;");
// 	qryPedido.exec();
// 	while (qryPedido.next()) {
// 		idPedido = qryPedido.value("idpedido");
// 		formRecordlineasalbaranescli.iface.pub_actualizarEstadoPedido(idPedido, curAlbaran);
// 	}
// 	return true;
// }

// function oficial_liberarPedidosProv(curAlbaran:FLSqlCursor):Boolean
// {
// 	var idLineaAlbaran:Number;
// 	var idLineaPedido:Number;
// 	var numeroPedido:Number;
// 
// 	var query:FLSqlQuery = new FLSqlQuery();
// 	query.setTablesList("lineasalbaranesprov");
// 	query.setSelect("idlineapedido, idlinea");
// 	query.setFrom("lineasalbaranesprov");
// 	query.setWhere("idalbaran = " + curAlbaran.valueBuffer("idalbaran") + " AND idlineapedido <> 0;");
// 	query.exec();
// 
// 	while (query.next()) {
// 		idLineaPedido = query.value("idlineapedido");
// 		idLineaAlbaran = query.value("idlinea");
// 		if (!this.iface.restarCantidadProv(idLineaPedido, idLineaAlbaran)) {
// 			return false;
// 		}
// 	}
// 
// 	var qryPedido = new FLSqlQuery();
// 	qryPedido.setTablesList("lineasalbaranesprov");
// 	qryPedido.setSelect("idpedido");
// 	qryPedido.setFrom("lineasalbaranesprov");
// 	qryPedido.setWhere("idalbaran = " + curAlbaran.valueBuffer("idalbaran") + " AND idpedido <> 0 GROUP BY idpedido;");
// 	qryPedido.exec();
// 	while (qryPedido.next()) {
// 		idPedido = qryPedido.value("idpedido");
// 		formRecordlineasalbaranesprov.iface.pub_actualizarEstadoPedido(idPedido);
// 	}
// 	return true;
// }

/** \D
Cambia el valor del campo totalenalbaran de una determinada línea de pedido, calculándolo como la suma de cantidades en otras líneas distintas de la línea de remito indicada
@param idLineaPedido: Identificador de la línea de pedido
@param idLineaAlbaran: Identificador de la línea de remito
\end */
function oficial_restarCantidadCli(idLineaPedido:Number, idLineaAlbaran:Number):Boolean
{
	var util:FLUtil = new FLUtil;
	var cantidad:Number = parseFloat(util.sqlSelect("lineasalbaranescli", "SUM(cantidad)", "idlineapedido = " + idLineaPedido + " AND idlinea <> " + idLineaAlbaran));
	if (isNaN(cantidad))
		cantidad = 0;

	var curLineaPedido:FLSqlCursor = new FLSqlCursor("lineaspedidoscli");
	curLineaPedido.select("idlinea = " + idLineaPedido);
	if (curLineaPedido.first()) {
		curLineaPedido.setModeAccess(curLineaPedido.Edit);
		curLineaPedido.refreshBuffer();
		curLineaPedido.setValueBuffer("totalenalbaran", cantidad);
		if (!curLineaPedido.commitBuffer()) {
			return false;
		}
	}
	return true;
}

/** \D
Cambia el valor del campo totalenalbaran de una determinada línea de pedido, calculándolo como la suma de cantidades en otras líneas distintas de la línea de remito indicada
@param idLineaPedido: Identificador de la línea de pedido
@param idLineaAlbaran: Identificador de la línea de remito
\end */
function oficial_restarCantidadProv(idLineaPedido:Number, idLineaAlbaran:Number):Boolean
{
	var util:FLUtil = new FLUtil;
	var cantidad:Number = parseFloat(util.sqlSelect("lineasalbaranesprov", "SUM(cantidad)", "idlineapedido = " + idLineaPedido + " AND idlinea <> " + idLineaAlbaran));
	if (isNaN(cantidad))
		cantidad = 0;

	var curLineaPedido:FLSqlCursor = new FLSqlCursor("lineaspedidosprov");
	curLineaPedido.select("idlinea = " + idLineaPedido);
	if (curLineaPedido.first()) {
		curLineaPedido.setModeAccess(curLineaPedido.Edit);
		curLineaPedido.refreshBuffer();
		curLineaPedido.setValueBuffer("totalenalbaran", cantidad);
		if (!curLineaPedido.commitBuffer()) {
			return false;
		}
	}
	return true;
}

function oficial_actualizarPedidosCli(curAlbaran:FLSqlCursor):Boolean
{
	return true;
/*
	var util:FLUtil = new FLUtil();

	var query:FLSqlQuery = new FLSqlQuery();
	query.setTablesList("lineasalbaranescli");
	query.setSelect("idlineapedido, idpedido, referencia, idalbaran, cantidad");
	query.setFrom("lineasalbaranescli");
	query.setWhere("idalbaran = " + curAlbaran.valueBuffer("idalbaran") + " AND idlineapedido <> 0 ORDER BY idpedido");
	try { query.setForwardOnly( true ); } catch (e) {}
	query.exec();
	var idPedido:String = 0;
	while (query.next()) {
		if (!this.iface.actualizarLineaPedidoCli(query.value(0), query.value(1), query.value(2), query.value(3), query.value(4))) {
			return false;
		}
			
		if (idPedido != query.value(1)) {
			if (!this.iface.actualizarEstadoPedidoCli(query.value(1), curAlbaran))
				return false;
		}
		idPedido = query.value(1)
	}
	return true;*/
}

function oficial_actualizarPedidosProv(curAlbaran:FLSqlCursor):Boolean
{
return true;
// 	var util:FLUtil = new FLUtil();
// 
// 	var query:FLSqlQuery = new FLSqlQuery();
// 	query.setTablesList("lineasalbaranesprov");
// 	query.setSelect("idlineapedido, idpedido, referencia, idalbaran, cantidad");
// 	query.setFrom("lineasalbaranesprov");
// 	query.setWhere("idalbaran = " + curAlbaran.valueBuffer("idalbaran") + " AND idlineapedido <> 0 ORDER BY idpedido");
// 	query.setForwardOnly(true);
// 	query.exec();
// 	var idPedido:String = 0;
// 	while (query.next()) {
// 		if (!this.iface.actualizarLineaPedidoProv(query.value(0), query.value(1), query.value(2), query.value(3), query.value(4))) {
// 			return false;
// 		}
// 		if (idPedido != query.value(1)) {
// 			if (!this.iface.actualizarEstadoPedidoProv(query.value(1), curAlbaran))
// 				return false;
// 		}
// 		idPedido = query.value(1);
// 	}
// 	return true;
}

/** \C
Actualiza el campo total en remito de la línea de pedido correspondiente (si existe).
@param	idLineaPedido: Id de la línea a actualizar
@param	idPedido: Id del pedido a actualizar
@param	referencia del artículo contenido en la línea
@param	idAlbaran: Id del remito en el que se sirve el pedido
@param	cantidadLineaAlbaran: Cantidad total de artículos de la referencia actual en el remito
@return	True si la actualización se realiza correctamente, false en caso contrario
\end */
function oficial_actualizarLineaPedidoProv(idLineaPedido:Number, idPedido:Number, referencia:String, idAlbaran:Number, cantidadLineaAlbaran:Number):Boolean
{
	if (idLineaPedido == 0) {
		return true;
	}
	
	var cantidadServida:Number;
	var curLineaPedido:FLSqlCursor = new FLSqlCursor("lineaspedidosprov");
	curLineaPedido.select("idlinea = " + idLineaPedido);
	curLineaPedido.setModeAccess(curLineaPedido.Edit);
	if (!curLineaPedido.first()) {
		return true;
	}
	var cantidadPedido:Number = parseFloat(curLineaPedido.valueBuffer("cantidad"));
	var query:FLSqlQuery = new FLSqlQuery();
	query.setTablesList("lineasalbaranesprov");
	query.setSelect("SUM(cantidad)");
	query.setFrom("lineasalbaranesprov");
	query.setWhere("idlineapedido = " + idLineaPedido + " AND idalbaran <> " + idAlbaran);
	if (!query.exec()) {
		return false;
	}
	if (query.next()) {
		var canOtros:Number = parseFloat(query.value("SUM(cantidad)"));
		if (isNaN(canOtros)) {
			canOtros = 0;
		}
		cantidadServida = canOtros + parseFloat(cantidadLineaAlbaran);
	}
	if (cantidadServida > cantidadPedido)
		cantidadServida = cantidadPedido;
	
	curLineaPedido.setValueBuffer("totalenalbaran", cantidadServida);
	if (!curLineaPedido.commitBuffer()) {
		return false;
	}
		
	return true;
}

/** \C
Marca el pedido como servido o parcialmente servido según corresponda.
@param	idPedido: Id del pedido a actualizar
@param	curAlbaran: Cursor posicionado en el remito que modifica el estado del pedido
@return	True si la actualización se realiza correctamente, false en caso contrario
\end */
function oficial_actualizarEstadoPedidoProv(idPedido:Number, curAlbaran:FLSqlCursor):Boolean
{
	var estado:String = this.iface.obtenerEstadoPedidoProv(idPedido);
	if (!estado) {
		return false;
	}
	var curPedido:FLSqlCursor = new FLSqlCursor("pedidosprov");
	curPedido.select("idpedido = " + idPedido);
	if (curPedido.first()) {
		if (estado == curPedido.valueBuffer("servido")) {
			return true;
		}
		curPedido.setUnLock("editable", true);
	}
	
	curPedido.select("idpedido = " + idPedido);
	curPedido.setModeAccess(curPedido.Edit);
	if (curPedido.first()) {
		curPedido.setValueBuffer("servido", estado);
		if (estado == "Sí") {
			curPedido.setValueBuffer("editable", false);
			if (sys.isLoadedModule("flcolaproc")) {
				if (!flfactppal.iface.pub_lanzarEvento(curPedido, "pedidoProvAlbaranado")) {
					return false;
				}
			}
		}
		if (!curPedido.commitBuffer()) {
			return false;
		}
	}
	return true;
}

/** \C
Obtiene el estado de un pedido
@param	idPedido: Id del pedido a actualizar
@return	True si la actualización se realiza correctamente, false en caso contrario
\end */
function oficial_obtenerEstadoPedidoProv(idPedido:Number):String
{
	var query:FLSqlQuery = new FLSqlQuery();

	query.setTablesList("lineaspedidosprov");
	query.setSelect("cantidad, totalenalbaran,cerrada");
	query.setFrom("lineaspedidosprov");
	query.setWhere("idpedido = " + idPedido);
	if (!query.exec()) {
		return false;
	}

	var estado:String = "";
	var totalServida:Number = 0;
	var parcial:Boolean = false;
	var totalLineas:Number = query.size();

	if(totalLineas == 0)
		return "No";

	while (query.next()) {
		var cantidad:Number = parseFloat(query.value("cantidad"));
		var cantidadServida:Number = parseFloat(query.value("totalenalbaran"));
		var cerrada:Boolean = query.value("cerrada");
		if (cantidad == cantidadServida || cerrada)
			totalServida += 1;
		else
			if(cantidad > cantidadServida && cantidadServida != 0)
				parcial = true;
	}
	
	if(parcial) {
		estado = "Parcial";
	}
	else {
		if (totalServida == 0)
			estado = "No";
		else {
			if(totalServida == totalLineas)
				estado = "Sí";
			else
				if(totalServida < totalLineas)
					estado = "Parcial";
		}
	}

	return estado;
}

/** \C
Actualiza el campo total en remito de la línea de pedido correspondiente (si existe).
@param	idLineaPedido: Id de la línea a actualizar
@param	idPedido: Id del pedido a actualizar
@param	referencia del artículo contenido en la línea
@param	idAlbaran: Id del remito en el que se sirve el pedido
@param	cantidadLineaAlbaran: Cantidad total de artículos de la referencia actual en el remito
@return	True si la actualización se realiza correctamente, false en caso contrario
\end */
function oficial_actualizarLineaPedidoCli(idLineaPedido:Number, idPedido:Number, referencia:String, idAlbaran:Number, cantidadLineaAlbaran:Number):Boolean
{
	if (idLineaPedido == 0) {
		return true;
	}
		
	var cantidadServida:Number;
	var curLineaPedido:FLSqlCursor = new FLSqlCursor("lineaspedidoscli");
	curLineaPedido.select("idlinea = " + idLineaPedido);
	curLineaPedido.setModeAccess(curLineaPedido.Edit);
	if (!curLineaPedido.first()) {
		return true;
	}

	var cantidadPedido:Number = parseFloat(curLineaPedido.valueBuffer("cantidad"));
	var query:FLSqlQuery = new FLSqlQuery();
	query.setTablesList("lineasalbaranescli");
	query.setSelect("SUM(cantidad)");
	query.setFrom("lineasalbaranescli");
	query.setWhere("idlineapedido = " + idLineaPedido + " AND idalbaran <> " + idAlbaran);
	if (!query.exec()) {
		return false;
	}
	if (query.next()) {
		var canOtros:Number = parseFloat(query.value("SUM(cantidad)"));
		if (isNaN(canOtros)) {
			canOtros = 0;
		}
		cantidadServida = canOtros + parseFloat(cantidadLineaAlbaran);
	}
	if (cantidadServida > cantidadPedido) {
		cantidadServida = cantidadPedido;
	}
		
	curLineaPedido.setValueBuffer("totalenalbaran", cantidadServida);
	if (!curLineaPedido.commitBuffer()) {
		return false;
	}
	
	return true;
}

/** \C
Marca el pedido como servido o parcialmente servido según corresponda.
@param	idPedido: Id del pedido a actualizar
@param	curAlbaran: Cursor posicionado en el remito que modifica el estado del pedido
@return	True si la actualización se realiza correctamente, false en caso contrario
\end */
function oficial_actualizarEstadoPedidoCli(idPedido:Number, curAlbaran:FLSqlCursor):Boolean
{
	var estado:String = this.iface.obtenerEstadoPedidoCli(idPedido);
	if (!estado) {
		return false;
	}
		
	var curPedido:FLSqlCursor = new FLSqlCursor("pedidoscli");
	curPedido.select("idpedido = " + idPedido);
	if (curPedido.first()) {
		if (estado == curPedido.valueBuffer("servido")) {
			return true;
		}
		curPedido.setUnLock("editable", true);
	}
	
	curPedido.select("idpedido = " + idPedido);
	curPedido.setModeAccess(curPedido.Edit);
	if (curPedido.first()) {
		curPedido.setValueBuffer("servido", estado);
		if (estado == "Sí") {
			curPedido.setValueBuffer("editable", false);
		}
		if (!curPedido.commitBuffer()) {
			return false;
		}
	}
	return true;
}

/** \C
Obtiene el estado de un pedido
@param	idPedido: Id del pedido a actualizar
@return	Estado del pedido
\end */
function oficial_obtenerEstadoPedidoCli(idPedido:Number):String
{
	var query:FLSqlQuery = new FLSqlQuery();

	query.setTablesList("lineaspedidoscli");
	query.setSelect("cantidad, totalenalbaran,cerrada");
	query.setFrom("lineaspedidoscli");
	query.setWhere("idpedido = " + idPedido);
	if (!query.exec()) {
		return false;
	}

	var estado:String = "";
	var totalServida:Number = 0;
	var parcial:Boolean = false;
	var totalLineas:Number = query.size();

	if(totalLineas == 0)
		return "No";

	while (query.next()) {
		var cantidad:Number = parseFloat(query.value("cantidad"));
		var cantidadServida:Number = parseFloat(query.value("totalenalbaran"));
		var cerrada:Boolean = query.value("cerrada");
		if (cantidad == cantidadServida || cerrada)
			totalServida += 1;
		else
			if(cantidad > cantidadServida && cantidadServida != 0)
				parcial = true;
	}
	
	if(parcial) {
		estado = "Parcial";
	}
	else {
		if (totalServida == 0)
			estado = "No";
		else {
			if(totalServida == totalLineas)
				estado = "Sí";
			else
				if(totalServida < totalLineas)
					estado = "Parcial";
		}
	}
	return estado;
}

/** \D
Llama a la función liberarAlbaran para todos los remitos agrupados en una factura
@param idFactura: Identificador de la factura
\end */
function oficial_liberarAlbaranesCli(idFactura:Number):Boolean
{
	var curAlbaranes:FLSqlCursor = new FLSqlCursor("albaranescli");
	curAlbaranes.select("idfactura = " + idFactura);
	while (curAlbaranes.next()) {
		if (!this.iface.liberarAlbaranCli(curAlbaranes.valueBuffer("idalbaran"))) {
			return false;
		}
	}
	return true;
}

/** \D
Desbloquea un remito que estaba asociado a una factura
@param idAlbaran: Identificador del remito
\end */
function oficial_liberarAlbaranCli(idAlbaran:Number):Boolean
{
	var curAlbaran:FLSqlCursor = new FLSqlCursor("albaranescli");
	with(curAlbaran) {
		select("idalbaran = " + idAlbaran);
		first();
		setUnLock("ptefactura", true);
		setModeAccess(Edit);
		refreshBuffer();
		setValueBuffer("idfactura", "0");
	}
	if (!curAlbaran.commitBuffer()) {
		return false;
	}
	return true;
}

/** \D
Llama a la función liberarAlbaran para todos los remitos agrupados en una factura
@param idFactura: Identificador de la factura
\end */
function oficial_liberarAlbaranesProv(idFactura:Number):Boolean
{
	var curAlbaranes:FLSqlCursor = new FLSqlCursor("albaranesprov");
	curAlbaranes.select("idfactura = " + idFactura);
	while (curAlbaranes.next()) {
		if (!this.iface.liberarAlbaranProv(curAlbaranes.valueBuffer("idalbaran"))) {
			return false;
		}
	}
	return true;
}

/** \D
Desbloquea un remito que estaba asociado a una factura
@param idAlbaran: Identificador del remito
\end */
function oficial_liberarAlbaranProv(idAlbaran:Number):Boolean
{
	var curAlbaran:FLSqlCursor = new FLSqlCursor("albaranesprov");
	with(curAlbaran) {
		select("idalbaran = " + idAlbaran);
		first();
		setUnLock("ptefactura", true);
		setModeAccess(Edit);
		refreshBuffer();
		setValueBuffer("idfactura", "0");
	}
	if (!curAlbaran.commitBuffer()) {
		return false;
	}
	return true;
}

function oficial_liberarPresupuestoCli(idPresupuesto:Number):Boolean
{
	if (idPresupuesto) {
		var curPresupuesto = new FLSqlCursor("presupuestoscli");
		curPresupuesto.select("idpresupuesto = " + idPresupuesto);
		if (!curPresupuesto.first()) {
			return false;
		}
		with(curPresupuesto) {
			setUnLock("editable", true);
		}
	}
	return true;
}

function oficial_aplicarComisionLineas(codAgente:String,tblHija:String,where:String):Boolean
{
	var util:FLUtil;

	var numLineas:Number = util.sqlSelect(tblHija,"count(idlinea)",where);
	if(!numLineas)
		return true;

	var referencia:String = "";
	var comision:Number = 0;
	
	if(!codAgente || codAgente == "")
		return false;

	var curLineas:FLSqlCursor = new FLSqlCursor(tblHija);
	curLineas.select(where);
	
	util.createProgressDialog(util.translate( "scripts", "Actualizando comisión ..." ), numLineas);

	var i:Number = 0;
	while (curLineas.next()) {
		util.setProgress(i++);
		curLineas.setActivatedCommitActions(false);
		curLineas.setModeAccess(curLineas.Edit);
		curLineas.refreshBuffer();
// 		comision = formRecordlineaspedidoscli.iface.pub_commonCalculateField("porcomision",curLineas);
		referencia = curLineas.valueBuffer("referencia");
		comision = this.iface.calcularComisionLinea(codAgente,referencia);
		comision = util.roundFieldValue(comision, tblHija, "porcomision");
		curLineas.setValueBuffer("porcomision",comision);
		if(!curLineas.commitBuffer()) {
			util.destroyProgressDialog();
			return false;
		}
	}
	util.setProgress(numLineas);
	util.destroyProgressDialog();	
	return true;
}

function oficial_calcularComisionLinea(codAgente:String,referencia:String):Number
{
	var util:FLUtil;
	var valor:Number = -1;

	if(referencia && referencia != "") {
		var id:Number = util.sqlSelect("articulosagen", "id", "referencia = '" + referencia + "' AND codagente = '" + codAgente + "'");
		if(id)
			valor = parseFloat(util.sqlSelect("articulosagen", "comision", "id = " + id));
	}
		
	if(valor == -1)
		valor = parseFloat(util.sqlSelect("agentes", "porcomision", "codagente = '" + codAgente + "'"));

	valor = util.roundFieldValue(valor, "agentes", "porcomision");

	return valor;
}
//// OFICIAL ////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition fluxEcommerce */
/////////////////////////////////////////////////////////////////
//// FLUX ECOMMERCE //////////////////////////////////////////////////////

function fluxEcommerce_beforeCommit_pedidoscli(cursor:FLSqlCursor):Boolean 
{
	if (!this.iface.__beforeCommit_pedidoscli(cursor))
		return false;
	
	/** \C Los pedidos web modificados en local se registran
	*/
	if (cursor.valueBuffer("pedidoweb") && cursor.modeAccess() == cursor.Edit) {
		var curTab:FLSqlCursor = new FLSqlCursor("pedidoscli_mod");
		var codigo = cursor.valueBuffer("codigo");
		curTab.select("codigo = '" + codigo + "'");
		if (!curTab.first()) {
			curTab.setModeAccess(curTab.Insert);
			curTab.refreshBuffer();
			curTab.setValueBuffer("codigo", codigo);
			if (!curTab.commitBuffer())
				return false;
		}
	}
	return true;
}

function fluxEcommerce_setModificado(cursor:FLSqlCursor) 
{
	if (cursor.isModifiedBuffer() && !cursor.valueBufferCopy("modificado"))
		cursor.setValueBuffer("modificado", true);
}

//// FLUX ECOMMERCE //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition pedidosauto */
/////////////////////////////////////////////////////////////////
//// PEDIDOS_AUTO //////////////////////////////////////////////
function pedidosauto_beforeCommit_pedidosprov(curPedido:FLSqlCursor)
{
	var util:FLUtil = new FLUtil();
	
	if (!this.iface.__beforeCommit_pedidosprov(curPedido))
		return false;

	var idPedido:Number = curPedido.valueBuffer("idpedido");
		
	var qryLineasPedProv:FLSqlQuery = new FLSqlQuery();
	with (qryLineasPedProv) {
		setTablesList("lineaspedidosprov");
		setSelect("referencia,cantidad");
		setFrom("lineaspedidosprov");
		setWhere("idpedido = " + idPedido);
		setForwardOnly(true);
	}
	if (!qryLineasPedProv.exec())
		return false;

	while (qryLineasPedProv.next())
		if (!this.iface.cambiarStockOrd(qryLineasPedProv.value("referencia"), qryLineasPedProv.value("cantidad")))
			return false;
	
	return true;
}

/** \D Cambia el valor del stock pedido de un articulo. 

@param referencia Referencia del artículo
@param variación Variación en el número de existencias del artículo
@return True si la modificación tuvo éxito, false en caso contrario
\end */
function pedidosauto_cambiarStockOrd(referencia:String, variacion:Number):Boolean
{
	debug(referencia);

	var util:FLUtil = new FLUtil();
	if (!referencia)
		return true;

	var stockOrd:Number = util.sqlSelect("lineaspedidosprov", "sum(cantidad-totalenalbaran)", "referencia = '" + referencia + "'");
	debug(stockOrd);
	if (!stockOrd)
		stockOrd = 0;

	stockOrd = parseFloat(stockOrd);

	var curArticulos:FLSqlCursor = new FLSqlCursor("articulos");
	curArticulos.select("referencia = '" + referencia + "'");
	if (!curArticulos.first())
		return true;
	curArticulos.setModeAccess(curArticulos.Edit);
	curArticulos.refreshBuffer();
	curArticulos.setValueBuffer("stockord", stockOrd);
	if (!curArticulos.commitBuffer())
		return false;

	return true;
}
//// PEDIDOS_AUTO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
function lotes_beforeCommit_lineasfacturasprov(curLF:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	switch (curLF.modeAccess()) {
		case curLF.Del: {
			if (util.sqlSelect("articulos", "porlotes", "referencia = '" + curLF.valueBuffer("referencia") + "'")) {
				if (util.sqlSelect("movilote", "idlineaap","idlineafp = " + curLF.valueBuffer("idlinea"))) {
					if (!util.sqlUpdate("movilote", "idlineafp","NULL","idlineafp = " + curLF.valueBuffer("idlinea"))) {
						return false;
					}
				}
				if (!util.sqlDelete("movilote", "idlineafp = " + curLF.valueBuffer("idlinea"))) {
					return false;
				}
			}
			break;
		}
		
	}
	return true;
}

function lotes_beforeCommit_lineasfacturascli(curLF:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	switch (curLF.modeAccess()) {
		case curLF.Del: {
			if (util.sqlSelect("articulos", "porlotes", "referencia = '" + curLF.valueBuffer("referencia") + "'")) {
				if (util.sqlSelect("movilote", "idlineaac","idlineafc = " + curLF.valueBuffer("idlinea"))) {
					if (!util.sqlUpdate("movilote", "idlineafc","NULL","idlineafc = " + curLF.valueBuffer("idlinea"))) {
						return false;
					}
				}
				if (!util.sqlDelete("movilote", "idlineafc = " + curLF.valueBuffer("idlinea"))) {
					return false;
				}
			}
			break;
		}
		
	}
	
	return true;
}

//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition proveed */
/////////////////////////////////////////////////////////////////
//// PROVEED ////////////////////////////////////////////////////
function proveed_datosConceptoAsiento(cur:FLSqlCursor):Array
{
	var util:FLUtil = new FLUtil;
	var datosAsiento:Array = [];

	switch (cur.table()) {
		case "pagosdevolprov": {
			var numFactura:String = util.sqlSelect("recibosprov r INNER JOIN facturasprov f ON r.idfactura = f.idfactura", "f.numproveedor", "r.idrecibo = " + cur.valueBuffer("idrecibo"), "recibosprov,facturasprov");
			if (numFactura && numFactura != "") {
				numFactura = " (Fra. " + numFactura + ")";
			} else {
				numFactura = "";
			}
			var codRecibo:String = util.sqlSelect("recibosprov", "codigo", "idrecibo = " + cur.valueBuffer("idrecibo"));
			var nombreProv:String = util.sqlSelect("recibosprov", "nombreproveedor", "idrecibo = " + cur.valueBuffer("idrecibo"));

			if (cur.valueBuffer("tipo") == "Pago") {
				datosAsiento.concepto = "Pago " + " recibo prov. " + codRecibo + numFactura + " - " + nombreProv;
			}
			if (cur.valueBuffer("tipo") == "Devolución") {
				datosAsiento.concepto = "Devolución recibo " + codRecibo + numFactura + " - " + nombreProv;;
			}
			datosAsiento.documento = "";
			datosAsiento.tipoDocumento = "";
			break;
		}
		default: {
			datosAsiento = this.iface.__datosConceptoAsiento(cur);
			break;
		}
	}
	return datosAsiento;
}



//// PROVEED ////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition funServiciosCli */
/////////////////////////////////////////////////////////////////
//// SERVICIOS CLI //////////////////////////////////////////////
/** \C Si el remito se borra se actualizan los pedidos asociados
\end */
function funServiciosCli_afterCommit_albaranescli(curAlbaran:FLSqlCursor):Boolean
{
	if (!this.iface.__afterCommit_albaranescli(curAlbaran)) {
		return false;
	}
	switch (curAlbaran.modeAccess()) {
		case curAlbaran.Del: {
			var idAlbaran:Number = curAlbaran.valueBuffer("idalbaran");
			if (idAlbaran) {
				var curServicio:FLSqlCursor = new FLSqlCursor("servicioscli");
				curServicio.select("idalbaran = " + idAlbaran);
				if (curServicio.first()) {
					curServicio.setUnLock("editable", true);
				}
			}
			break;
		}
	}
	return true;
}
//// SERVICIOS CLI //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition funNumSerie */
/////////////////////////////////////////////////////////////////
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////

/** \D El número de serie no puede ser nulo cuando el artículo lo requiere
*/
function funNumSerie_beforeCommit_lineasfacturascli(curLF:FLSqlCursor):Boolean
{
	if ( !this.iface.__beforeCommit_lineasfacturascli(curLF) )
		return false;

	if (curLF.modeAccess() != curLF.Insert) 
		return true;	
	
	var util:FLUtil = new FLUtil;
	if (util.sqlSelect("articulos", "controlnumserie", "referencia = '" + curLF.valueBuffer("referencia") + "'")) {
		
		if (!curLF.valueBuffer("numserie")) {
			MessageBox.warning(util.translate("scripts", "El número de serie en las líneas de factura no puede ser nulo para el artículo ") + curLF.valueBuffer("referencia"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
	}

	return true;
}

/** \D El número de serie no puede ser nulo cuando el artículo lo requiere
*/
function funNumSerie_beforeCommit_lineasfacturasprov(curLF:FLSqlCursor):Boolean
{
	if ( !this.iface.__beforeCommit_lineasfacturasprov(curLF) )
		return false;

	if (curLF.modeAccess() != curLF.Insert) 
		return true;	
	
	var util:FLUtil = new FLUtil;
	if (util.sqlSelect("articulos", "controlnumserie", "referencia = '" + curLF.valueBuffer("referencia") + "'")) {
		
		if (!curLF.valueBuffer("numserie")) {
			MessageBox.warning(util.translate("scripts", "El número de serie en las líneas de factura no puede ser nulo para el artículo ") + curLF.valueBuffer("referencia"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
		
	}
	
	return true;
}

/** \D Controla los números de serie en función de la eliminación o creación de líneas de remito
*/
function funNumSerie_afterCommit_lineasalbaranesprov(curLA:FLSqlCursor):Boolean
{
	if (!this.iface.__afterCommit_lineasalbaranesprov(curLA))
		return false;
		
	if (!curLA.valueBuffer("numserie")) return true;
	
	switch(curLA.modeAccess()) {
		
		case curLA.Insert:
		case curLA.Edit:
			if (!flfactalma.iface.insertarNumSerie(curLA.valueBuffer("referencia"), curLA.valueBuffer("numserie"), curLA.valueBuffer("idalbaran"), -1))
				return false;
			break;
		
		case curLA.Del: 
			if (!flfactalma.iface.borrarNumSerie(curLA.valueBuffer("referencia"), curLA.valueBuffer("numserie")))
				return false;
			break;
	}
	return true;
}

/** \D Controla los números de serie en función de la eliminación o creación
de líneas de factura en caso de que no se trate de una factura automática
*/
function funNumSerie_afterCommit_lineasfacturasprov(curLF:FLSqlCursor):Boolean
{
	if (!interna_afterCommit_lineasfacturasprov(curLF))
		return false;
	
	var util:FLUtil = new FLUtil;
	
	if (!curLF.valueBuffer("numserie")) return true;
	
	var automatica:Boolean = util.sqlSelect("facturasprov", "automatica", "idfactura = " + curLF.valueBuffer("idfactura"));
	
 	// Factura normal
	if (!automatica) {
	
		switch(curLF.modeAccess()) {
			
			case curLF.Insert:
				if (!flfactalma.iface.insertarNumSerie(curLF.valueBuffer("referencia"), curLF.valueBuffer("numserie"), -1, curLF.valueBuffer("idfactura")))
					return false;
				break;
			
			case curLF.Del:
				if (!flfactalma.iface.borrarNumSerie(curLF.valueBuffer("referencia"), curLF.valueBuffer("numserie")))
					return false;
				break;
		}
	}
	
 	// Factura automática. El número de serie ya está registrado
	else {
	
		switch(curLF.modeAccess()) {
			
			case curLF.Insert:
			case curLF.Edit:
				if (!flfactalma.iface.modificarNumSerie(curLF.valueBuffer("referencia"), curLF.valueBuffer("numserie"), "idfacturacompra", curLF.valueBuffer("idfactura")))
					return false;
				break;
		
			case curLF.Del:
				if (!flfactalma.iface.modificarNumSerie(curLF.valueBuffer("referencia"), curLF.valueBuffer("numserie"), "idfacturacompra", 0))
					return false;
				break;
		}
	}
	return true;
}

/** \D Actualiza el id de remito de compra para un número de serie.
*/
function funNumSerie_afterCommit_lineasalbaranescli(curLA:FLSqlCursor):Boolean
{
	if (!this.iface.__afterCommit_lineasalbaranescli(curLA))
		return false;
		
	if (!curLA.valueBuffer("numserie")) return true;
	
	var curNS:FLSqlCursor = new FLSqlCursor("numerosserie");
	
	switch(curLA.modeAccess()) {
		
		case curLA.Edit: 
			// Control cuando cambia un número por otro, se libera el primero
			if (curLA.valueBuffer("numserie") != curLA.valueBufferCopy("numserie")) {
				curNS.select("referencia = '" + curLA.valueBuffer("referencia") + "' AND numserie = '" + curLA.valueBufferCopy("numserie") + "'");
				if (curNS.first()) {
					curNS.setModeAccess(curNS.Edit);
					curNS.refreshBuffer();
					curNS.setValueBuffer("idalbaranventa", -1)
					curNS.setValueBuffer("vendido", "false")
					if (!curNS.commitBuffer()) return false;
				}
			}
		
		case curLA.Insert:
			curNS.select("referencia = '" + curLA.valueBuffer("referencia") + "' AND numserie = '" + curLA.valueBuffer("numserie") + "'");
			if (curNS.first()) {
				curNS.setModeAccess(curNS.Edit);
				curNS.refreshBuffer();
				curNS.setValueBuffer("idalbaranventa", curLA.valueBuffer("idalbaran"))
				curNS.setValueBuffer("vendido", "true")
				if (!curNS.commitBuffer()) return false;
			}
			
			
		break;
		
		case curLA.Del:
			curNS.select("referencia = '" + curLA.valueBuffer("referencia") + "' AND numserie = '" + curLA.valueBuffer("numserie") + "'");
			if (curNS.first()) {
				curNS.setModeAccess(curNS.Edit);
				curNS.refreshBuffer();
				curNS.setValueBuffer("idalbaranventa", -1)
				curNS.setValueBuffer("vendido", "false")
				if (!curNS.commitBuffer()) return false;
			}
			break;
	}
	return true;
}

/** \D Actualiza el id de la factura de compra para un número de serie.
*/
function funNumSerie_afterCommit_lineasfacturascli(curLF:FLSqlCursor):Boolean
{
	if (!interna_afterCommit_lineasfacturascli(curLF))
		return false;
		
	if (!curLF.valueBuffer("numserie")) return true;
	
	var util:FLUtil = new FLUtil();
	var curNS:FLSqlCursor = new FLSqlCursor("numerosserie");
	
	switch(curLF.modeAccess()) {
		case curLF.Edit:
			// Control cuando cambia un número por otro, se libera el primero
			if (curLF.valueBuffer("numserie") != curLF.valueBufferCopy("numserie")) {
				curNS.select("referencia = '" + curLF.valueBuffer("referencia") + "' AND numserie = '" + curLF.valueBufferCopy("numserie") + "'");
				if (curNS.first()) {
					curNS.setModeAccess(curNS.Edit);
					curNS.refreshBuffer();
					
					if (util.sqlSelect("facturascli", "decredito", "idfactura = " + curLF.valueBuffer("idfactura"))) {
						curNS.setValueBuffer("idfacturadevol", -1)
						curNS.setValueBuffer("vendido", "true")
					}
					else {
						curNS.setValueBuffer("idfacturaventa", -1)
						curNS.setValueBuffer("vendido", "false")
					}
					
					if (!curNS.commitBuffer()) return false;
				}
			}
			
		case curLF.Insert:
		
			curNS.select("referencia = '" + curLF.valueBuffer("referencia") + "' AND numserie = '" + curLF.valueBuffer("numserie") + "'");
			if (!curNS.first())
				break;
			
			curNS.setModeAccess(curNS.Edit);
			curNS.refreshBuffer();
			
			if (util.sqlSelect("facturascli", "decredito", "idfactura = " + curLF.valueBuffer("idfactura"))) {
				curNS.setValueBuffer("idfacturadevol", curLF.valueBuffer("idfactura"))
				curNS.setValueBuffer("vendido", "false")
			}
			else {
				curNS.setValueBuffer("idfacturaventa", curLF.valueBuffer("idfactura"))
				curNS.setValueBuffer("vendido", "true")
			}
			
			if (!curNS.commitBuffer()) return false;
			
			break;
		
		case curLF.Del:
			curNS.select("referencia = '" + curLF.valueBuffer("referencia") + "' AND numserie = '" + curLF.valueBuffer("numserie") + "' AND idalbaranventa IS NULL");
			if (curNS.first()) {
				curNS.setModeAccess(curNS.Edit);
				curNS.refreshBuffer();
				var util:FLUtil = new FLUtil();
				if (util.sqlSelect("facturascli", "decredito", "idfactura = " + curLF.valueBuffer("idfactura"))) {
					curNS.setValueBuffer("idfacturadevol", -1)
					curNS.setValueBuffer("vendido", "true")
				}
				else {
					curNS.setValueBuffer("idfacturaventa", -1)
					curNS.setValueBuffer("vendido", "false")
				}
				
				if (!curNS.commitBuffer()) return false;
			}
			break;
	}
	return true;
}

/** Verifica si la referencia es de número de serie, en cuyo caso la 
catidad servida sólo puede ser 1 en el remito
\end */
function funNumSerie_actualizarLineaPedidoCli(idLineaPedido:Number, idPedido:Number, referencia:String, idAlbaran:Number, cantidadLineaAlbaran:Number):Boolean
{
	if (idLineaPedido == 0)
		return true;

	var util:FLUtil = new FLUtil();
	if (!util.sqlSelect("articulos", "controlnumserie", "referencia = '" + referencia + "'"))
		return this.iface.__actualizarLineaPedidoCli(idLineaPedido, idPedido, referencia, idAlbaran, cantidadLineaAlbaran);

	
	var curLineaPedido:FLSqlCursor = new FLSqlCursor("lineaspedidoscli");
	curLineaPedido.select("idlinea = " + idLineaPedido);
	curLineaPedido.setModeAccess(curLineaPedido.Edit);
	if (!curLineaPedido.first())
		return false;
			
	var query:FLSqlQuery = new FLSqlQuery();
	query.setTablesList("lineasalbaranescli");
	query.setSelect("SUM(cantidad)");
	query.setFrom("lineasalbaranescli");
	query.setWhere("idlineapedido = " + idLineaPedido + " AND referencia = '" + referencia + "'");
	
	if (!query.exec())
		return false;
	if (query.next())
		cantidadServida = parseFloat(query.value(0));
		
	curLineaPedido.setValueBuffer("totalenalbaran", cantidadServida);
	if (!curLineaPedido.commitBuffer())
		return false;
	
	return true;
}

/** Verifica si la referencia es de número de serie, en cuyo caso la 
catidad servida sólo puede ser 1 en el remito
\end */
function funNumSerie_actualizarLineaPedidoProv(idLineaPedido:Number, idPedido:Number, referencia:String, idAlbaran:Number, cantidadLineaAlbaran:Number):Boolean
{
	if (idLineaPedido == 0)
		return true;

	var util:FLUtil = new FLUtil();
	if (!util.sqlSelect("articulos", "controlnumserie", "referencia = '" + referencia + "'"))
		return this.iface.__actualizarLineaPedidoProv(idLineaPedido, idPedido, referencia, idAlbaran, cantidadLineaAlbaran);

	
	var curLineaPedido:FLSqlCursor = new FLSqlCursor("lineaspedidosprov");
	curLineaPedido.select("idlinea = " + idLineaPedido);
	curLineaPedido.setModeAccess(curLineaPedido.Edit);
	if (!curLineaPedido.first())
		return false;
			
	var query:FLSqlQuery = new FLSqlQuery();
	query.setTablesList("lineasalbaranesprov");
	query.setSelect("SUM(cantidad)");
	query.setFrom("lineasalbaranesprov");
	query.setWhere("idlineapedido = " + idLineaPedido + " AND referencia = '" + referencia + "'");
	
	debug(query.sql());
	
	if (!query.exec())
		return false;
	if (query.next())
		cantidadServida = parseFloat(query.value(0));
		
	curLineaPedido.setValueBuffer("totalenalbaran", cantidadServida);
	if (!curLineaPedido.commitBuffer())
		return false;
	
	return true;
}

//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition nsServicios */
/////////////////////////////////////////////////////////////////
//// NS_SERVICIOS /////////////////////////////////////////////////

/** \D Actualiza el id de remito de compra para un número de serie.
*/
function nsServicios_afterCommit_lineasservicioscli(curLS:FLSqlCursor):Boolean
{
	if (!curLS.valueBuffer("numserie")) return true;
	
	var curNS:FLSqlCursor = new FLSqlCursor("numerosserie");
	
	switch(curLS.modeAccess()) {
		
		case curLS.Edit: 
			// Control cuando cambia un número por otro, se libera el primero
			if (curLS.valueBuffer("numserie") != curLS.valueBufferCopy("numserie")) {
				curNS.select("referencia = '" + curLS.valueBuffer("referencia") + "' AND numserie = '" + curLS.valueBufferCopy("numserie") + "'");
				if (curNS.first()) {
					curNS.setModeAccess(curNS.Edit);
					curNS.refreshBuffer();
					curNS.setValueBuffer("idservicioventa", -1)
					curNS.setValueBuffer("vendido", "false")
					if (!curNS.commitBuffer()) return false;
				}
			}
		break;
		
		case curLS.Insert:
			curNS.select("referencia = '" + curLS.valueBuffer("referencia") + "' AND numserie = '" + curLS.valueBuffer("numserie") + "'");
			if (curNS.first()) {
				curNS.setModeAccess(curNS.Edit);
				curNS.refreshBuffer();
				curNS.setValueBuffer("idservicioventa", curLS.valueBuffer("idservicio"))
				curNS.setValueBuffer("vendido", "true")
				if (!curNS.commitBuffer()) return false;
			}
			
			
		break;
		
		case curLS.Del:
			curNS.select("referencia = '" + curLS.valueBuffer("referencia") + "' AND numserie = '" + curLS.valueBuffer("numserie") + "'");
			if (curNS.first()) {
				curNS.setModeAccess(curNS.Edit);
				curNS.refreshBuffer();
				curNS.setValueBuffer("idservicioventa", -1)
				curNS.setValueBuffer("vendido", "false")
				if (!curNS.commitBuffer()) return false;
			}
			break;
	}
	return true;
}

//// NS_SERVICIOS /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////



/** @class_definition funNumServAcomp */
/////////////////////////////////////////////////////////////////
//// FUN_NUM_SERV_ACOMP /////////////////////////////////////////////////

/** \D Actualiza el id de servicio de venta para un número de serie.
*/
function funNumAcomp_afterCommit_lineasserviciosclins(curL:FLSqlCursor):Boolean
{
	debug(curL.valueBuffer("numserie"));
	if (!curL.valueBuffer("numserie")) return true;
	
	var util:FLUtil = new FLUtil();
	
	var curNS:FLSqlCursor = new FLSqlCursor("numerosserie");
	var idServicio = util.sqlSelect("lineasservicioscli", "idservicio", "idlinea = " + curL.valueBuffer("idlineaservicio"));
	
	switch(curL.modeAccess()) {
		
		case curL.Edit: 
			// Control cuando cambia un número por otro, se libera el primero
			if (curL.valueBuffer("numserie") != curL.valueBufferCopy("numserie")) {
				debug("referencia = '" + curL.valueBuffer("referencia") + "' AND numserie = '" + curL.valueBufferCopy("numserie") + "'");
				curNS.select("referencia = '" + curL.valueBuffer("referencia") + "' AND numserie = '" + curL.valueBufferCopy("numserie") + "'");
				if (curNS.first()) {
					curNS.setModeAccess(curNS.Edit);
					curNS.refreshBuffer();
					curNS.setValueBuffer("idservicioventa", -1)
					curNS.setValueBuffer("vendido", "false")
					if (!curNS.commitBuffer()) return false;
				}
			}
		
		case curL.Insert:
			debug("referencia = '" + curL.valueBuffer("referencia") + "' AND numserie = '" + curL.valueBuffer("numserie") + "'");
			curNS.select("referencia = '" + curL.valueBuffer("referencia") + "' AND numserie = '" + curL.valueBuffer("numserie") + "'");
			if (curNS.first()) {
				curNS.setModeAccess(curNS.Edit);
				curNS.refreshBuffer();
				curNS.setValueBuffer("idservicioventa", idServicio)
				curNS.setValueBuffer("vendido", "true")
				if (!curNS.commitBuffer()) return false;
			}
			
			
		break;
		
		case curL.Del:
			curNS.select("referencia = '" + curL.valueBuffer("referencia") + "' AND numserie = '" + curL.valueBuffer("numserie") + "'");
			if (curNS.first()) {
				curNS.setModeAccess(curNS.Edit);
				curNS.refreshBuffer();
				curNS.setValueBuffer("idservicioventa", -1)
				curNS.setValueBuffer("vendido", "false")
				if (!curNS.commitBuffer()) return false;
			}
			break;
	}
	return true;
}

//// FUN_NUM_SERV_ACOMP /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition funNumAcomp */
/////////////////////////////////////////////////////////////////
//// FUN_NUM_ACOMP /////////////////////////////////////////////////

/** \D Actualiza el id de remito de compra para un número de serie.
*/
function funNumAcomp_afterCommit_lineasalbaranesclins(curL:FLSqlCursor):Boolean
{
	if (!curL.valueBuffer("numserie")) return true;
	
	var util:FLUtil = new FLUtil();
	
	var curNS:FLSqlCursor = new FLSqlCursor("numerosserie");
	var idAlbaran = util.sqlSelect("lineasalbaranescli", "idalbaran", "idlinea = " + curL.valueBuffer("idlineaalbaran"));
	
	switch(curL.modeAccess()) {
		
		case curL.Edit: 
			// Control cuando cambia un número por otro, se libera el primero
			if (curL.valueBuffer("numserie") != curL.valueBufferCopy("numserie")) {
				curNS.select("referencia = '" + curL.valueBuffer("referencia") + "' AND numserie = '" + curL.valueBufferCopy("numserie") + "'");
				if (curNS.first()) {
					curNS.setModeAccess(curNS.Edit);
					curNS.refreshBuffer();
					curNS.setValueBuffer("idalbaranventa", -1)
					curNS.setValueBuffer("vendido", "false")
					if (!curNS.commitBuffer()) return false;
				}
			}
		
		case curL.Insert:
			curNS.select("referencia = '" + curL.valueBuffer("referencia") + "' AND numserie = '" + curL.valueBuffer("numserie") + "'");
			if (curNS.first()) {
				curNS.setModeAccess(curNS.Edit);
				curNS.refreshBuffer();
				curNS.setValueBuffer("idalbaranventa", idAlbaran)
				curNS.setValueBuffer("vendido", "true")
				if (!curNS.commitBuffer()) return false;
			}
			
			
		break;
		
		case curL.Del:
			curNS.select("referencia = '" + curL.valueBuffer("referencia") + "' AND numserie = '" + curL.valueBuffer("numserie") + "'");
			if (curNS.first()) {
				curNS.setModeAccess(curNS.Edit);
				curNS.refreshBuffer();
				curNS.setValueBuffer("idalbaranventa", -1)
				curNS.setValueBuffer("vendido", "false")
				if (!curNS.commitBuffer()) return false;
			}
			break;
	}
	return true;
}

/** \D Actualiza el id de factura de compra para un número de serie.
*/
function funNumAcomp_afterCommit_lineasfacturasclins(curL:FLSqlCursor):Boolean
{
	if (!curL.valueBuffer("numserie")) return true;
	
	var util:FLUtil = new FLUtil();
	
	var curNS:FLSqlCursor = new FLSqlCursor("numerosserie");
	var idAlbaran = util.sqlSelect("lineasfacturascli", "idfactura", "idlinea = " + curL.valueBuffer("idlineafactura"));
	
	switch(curL.modeAccess()) {
		
		case curL.Edit: 
			// Control cuando cambia un número por otro, se libera el primero
			if (curL.valueBuffer("numserie") != curL.valueBufferCopy("numserie")) {
				curNS.select("referencia = '" + curL.valueBuffer("referencia") + "' AND numserie = '" + curL.valueBufferCopy("numserie") + "'");
				if (curNS.first()) {
					curNS.setModeAccess(curNS.Edit);
					curNS.refreshBuffer();
					curNS.setValueBuffer("idfacturaventa", -1)
					curNS.setValueBuffer("vendido", "false")
					if (!curNS.commitBuffer()) return false;
				}
			}
			
		break;
		
		case curL.Insert:
			curNS.select("referencia = '" + curL.valueBuffer("referencia") + "' AND numserie = '" + curL.valueBuffer("numserie") + "'");
			if (curNS.first()) {
				curNS.setModeAccess(curNS.Edit);
				curNS.refreshBuffer();
				curNS.setValueBuffer("idfacturaventa", idAlbaran)
				curNS.setValueBuffer("vendido", "true")
				if (!curNS.commitBuffer()) return false;
			}
			
		break;
		
		case curL.Del:
			curNS.select("referencia = '" + curL.valueBuffer("referencia") + "' AND numserie = '" + curL.valueBuffer("numserie") + "'");
			if (curNS.first()) {
				curNS.setModeAccess(curNS.Edit);
				curNS.refreshBuffer();
				curNS.setValueBuffer("idfacturaventa", -1)
				if (!idAlbaran)
					curNS.setValueBuffer("vendido", "false")
				if (!curNS.commitBuffer()) return false;
			}
			break;
	}
	return true;
}

//// FUN_NUM_ACOMP /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition factPeriodica */
/////////////////////////////////////////////////////////////////
//// FACTURACION_PERIODICA /////////////////////////////////////////////////

/** \D Si la factura está asociada a un periodo o periodos y se elimina,
se desvincula el periodo
*/
function factPeriodica_afterCommit_facturascli(curFactura:FLSqlCursor):Boolean
{
	if (curFactura.modeAccess() == curFactura.Del) {
		var curTab:FLSqlCursor = new FLSqlCursor("periodoscontratos");
		curTab.select("idfactura = " + curFactura.valueBuffer("idfactura"));
		while(curTab.next()) {
			curTab.setModeAccess(curTab.Edit);
			curTab.refreshBuffer();
			curTab.setNull("idfactura");
			curTab.setValueBuffer("facturado", false);
			curTab.commitBuffer();
		}
	}
	
	return this.iface.__afterCommit_facturascli(curFactura);
}

/** \D Si la el periodo está facturado no se puede eliminar
*/
function factPeriodica_beforeCommit_periodoscontratos(curP:FLSqlCursor):Boolean
{
	if (curP.modeAccess() == curP.Del) {
		var util:FLUtil = new FLUtil();
		if (util.sqlSelect("facturascli", "idfactura", "idfactura = " + curP.valueBuffer("idfactura"))) {
			MessageBox.warning(util.translate("scripts", "Para eliminar el período debe eliminar antes la factura asociada"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
	}
	
	return true;
}

//// FACTURACION_PERIODICA /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition numeroSecuencia */
/////////////////////////////////////////////////////////////////
//// NUMERO SECUENCIA ///////////////////////////////////////////

function numeroSecuencia_recalcularHuecos( serie:String, ejercicio:String, fN:String ):Boolean
{
	// desactivamos el recalculo y uso de huecos
	return true;
}

//// NUMERO SECUENCIA /////////////////////////////////////////
///////////////////////////////////////////////////////////////


/** @class_definition lineasArticulos */
/////////////////////////////////////////////////////////////////
//// LINEAS_ARTICULOS ///////////////////////////////////////////

function lineasArticulos_afterCommit_lineaspedidoscli(curLP:FLSqlCursor):Boolean
{
	if ( !this.iface.__afterCommit_lineaspedidoscli(curLP) )
		return false;

	if (curLP.modeAccess() == curLP.Insert || curLP.modeAccess() == curLP.Edit) {
		if (flfactppal.iface.pub_valorDefectoEmpresa("stockpedidos"))
			this.iface.generarLineaSalida("Pedido", curLP);
	}

	return true;
}

function lineasArticulos_afterCommit_lineaspedidosprov(curLP:FLSqlCursor):Boolean
{
	if ( !this.iface.__afterCommit_lineaspedidosprov(curLP) )
		return false;

	if (curLP.modeAccess() == curLP.Insert || curLP.modeAccess() == curLP.Edit) {
		if (flfactppal.iface.pub_valorDefectoEmpresa("stockpedidos"))
			this.iface.generarLineaEntrada("Pedido", curLP);
	}

	return true;
}

function lineasArticulos_afterCommit_lineasalbaranescli(curLA:FLSqlCursor):Boolean
{
	if ( !this.iface.__afterCommit_lineasalbaranescli(curLA) )
		return false;

	if (curLA.modeAccess() == curLA.Insert || curLA.modeAccess() == curLA.Edit)
		this.iface.generarLineaSalida("Remito", curLA);

	return true;
}

function lineasArticulos_afterCommit_lineasalbaranesprov(curLA:FLSqlCursor):Boolean
{
	if ( !this.iface.__afterCommit_lineasalbaranesprov(curLA) )
		return false;

	if (curLA.modeAccess() == curLA.Insert || curLA.modeAccess() == curLA.Edit)
		this.iface.generarLineaEntrada("Remito", curLA);

	return true;
}

function lineasArticulos_afterCommit_lineasfacturascli(curLF:FLSqlCursor):Boolean
{
	if ( !this.iface.__afterCommit_lineasfacturascli(curLF) )
		return false;

	if (curLF.modeAccess() == curLF.Insert || curLF.modeAccess() == curLF.Edit)
		this.iface.generarLineaSalida("Factura", curLF);

	return true;
}

function lineasArticulos_afterCommit_lineasfacturasprov(curLF:FLSqlCursor):Boolean
{
	if ( !this.iface.__afterCommit_lineasfacturasprov(curLF) )
		return false;

	if (curLF.modeAccess() == curLF.Insert || curLF.modeAccess() == curLF.Edit)
		this.iface.generarLineaEntrada("Factura", curLF);

	return true;
}


function lineasArticulos_generarLineaSalida(documento:String, curLS:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	var tabla:String;
	var nombreIdTabla:String;
	var nombreIdLinea:String;

	var idDocumento:Number;

	switch (documento) {
		case "Factura": {
			tabla = "facturascli";
			nombreIdTabla = "idfactura";
			nombreIdLinea = "idlineafactura";
			idDocumento = curLS.valueBuffer("idfactura");
			break;
		}
		case "Remito": {
			tabla = "albaranescli";
			nombreIdTabla = "idalbaran";
			nombreIdLinea = "idlineaalbaran";
			idDocumento = curLS.valueBuffer("idalbaran");
			break;
		}
		case "Pedido": {
			tabla = "pedidoscli";
			nombreIdTabla = "idpedido";
			nombreIdLinea = "idlineapedido";
			idDocumento = curLS.valueBuffer("idpedido");
			break;
		}
	}

	// Si está editando entonces existe una linea de salida; la busco y la borro
	if (curLS.modeAccess() == curLS.Edit) {
		this.iface.borrarLineaSalida(curLS, nombreIdLinea, nombreIdTabla);
	}

	// Si la linea es de un documento automático borra la línea origen
	this.iface.controlLineaSalidaAutomatica(documento, curLS);

	var query:FLSqlQuery = new FLSqlQuery();
	query.setTablesList(tabla);
	query.setSelect("fecha,codigo,codcliente,nombrecliente");
	query.setFrom(tabla);
	query.setWhere(nombreIdTabla + " = " + idDocumento);
	if (!query.exec() || !query.next())
		return false;

	var curLineaSalida:FLSqlCursor = new FLSqlCursor("lineassalidasarticulos");
	with (curLineaSalida) {
		setModeAccess(curLineaSalida.Insert);
		refreshBuffer();
		setValueBuffer(nombreIdLinea, curLS.valueBuffer("idlinea"));
		setValueBuffer(nombreIdTabla, curLS.valueBuffer(nombreIdTabla));
		setValueBuffer("referencia", curLS.valueBuffer("referencia"));
		setValueBuffer("descripcion", curLS.valueBuffer("descripcion"));
		setValueBuffer("fecha", query.value("fecha"));
		setValueBuffer("documento", documento );
		setValueBuffer("codigo", query.value("codigo") );
		setValueBuffer("codcliente", query.value("codcliente"));
		setValueBuffer("nombrecliente", query.value("nombrecliente"));
		setValueBuffer("cantidad", curLS.valueBuffer("cantidad"));
		setValueBuffer("pvpunitario", curLS.valueBuffer("pvpunitario"));
		setValueBuffer("pvpsindto", curLS.valueBuffer("pvpsindto"));
		setValueBuffer("pvptotal", curLS.valueBuffer("pvptotal"));
		setValueBuffer("totalconiva", curLS.valueBuffer("totalconiva"));
		setValueBuffer("dtolineal", curLS.valueBuffer("dtolineal"));
		setValueBuffer("dtopor", curLS.valueBuffer("dtopor"));
		setValueBuffer("costounitario", curLS.valueBuffer("costounitario"));
		setValueBuffer("costototal", curLS.valueBuffer("costototal"));
		setValueBuffer("ganancia", curLS.valueBuffer("ganancia"));
		setValueBuffer("utilidad", curLS.valueBuffer("utilidad"));
	}
	if (!curLineaSalida.commitBuffer())
		return false;

	return true;
}

function lineasArticulos_borrarLineaSalida(curLS:FLSqlCursor, nombreIdLinea:String, nombreIdTabla:String)
{
	var lineaSalida:FLSqlCursor = new FLSqlCursor("lineassalidasarticulos");
	lineaSalida.select(nombreIdLinea + " = " + curLS.valueBuffer("idlinea") + " AND " + nombreIdTabla + " = " + curLS.valueBuffer(nombreIdTabla));
	if (lineaSalida.next()) {
		lineaSalida.setActivatedCheckIntegrity(false);
		lineaSalida.setModeAccess(lineaSalida.Del);
		lineaSalida.refreshBuffer();
		lineaSalida.commitBuffer();
	}
}

function lineasArticulos_controlLineaSalidaAutomatica(documento:String, curLS:FLSqlCursor)
{
	if (curLS.modeAccess() == curLS.Insert) {
		if (documento == "Factura") {
			if (curLS.valueBuffer("idlineaalbaran")) {
				var lineaRemito:FLSqlCursor = new FLSqlCursor("lineasalbaranescli");
				lineaRemito.select("idlinea = " + curLS.valueBuffer("idlineaalbaran") + " AND idalbaran = " + curLS.valueBuffer("idalbaran"));
				if (lineaRemito.first())
					this.iface.borrarLineaSalida(lineaRemito, "idlineaalbaran", "idalbaran");
			}
		}
		else if (documento == "Remito") {
			if (curLS.valueBuffer("idlineapedido")) {
				var lineaPedido:FLSqlCursor = new FLSqlCursor("lineaspedidoscli");
				lineaPedido.select("idlinea = " + curLS.valueBuffer("idlineapedido") + " AND idpedido = " + curLS.valueBuffer("idpedido"));
				if (lineaPedido.first())
					this.iface.borrarLineaSalida(lineaPedido, "idlineapedido", "idpedido");
			}
		}
	}
}

function lineasArticulos_generarLineaEntrada(documento:String, curLE:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	var tabla:String;
	var nombreIdTabla:String;
	var nombreIdLinea:String;

	var idDocumento:Number;

	switch (documento) {
		case "Factura": {
			tabla = "facturasprov";
			nombreIdTabla = "idfactura";
			nombreIdLinea = "idlineafactura";
			idDocumento = curLE.valueBuffer("idfactura");
			break;
		}
		case "Remito": {
			tabla = "albaranesprov";
			nombreIdTabla = "idalbaran";
			nombreIdLinea = "idlineaalbaran";
			idDocumento = curLE.valueBuffer("idalbaran");
			break;
		}
		case "Pedido": {
			tabla = "pedidosprov";
			nombreIdTabla = "idpedido";
			nombreIdLinea = "idlineapedido";
			idDocumento = curLE.valueBuffer("idpedido");
			break;
		}
	}

	// Si está editando entonces existe una linea de entrada; la busco y la borro
	if (curLE.modeAccess() == curLE.Edit) {
		this.iface.borrarLineaEntrada(curLE, nombreIdLinea, nombreIdTabla);
	}

	// Si la linea es de un documento automático borra la línea origen
	this.iface.controlLineaEntradaAutomatica(documento, curLE);

	var query:FLSqlQuery = new FLSqlQuery();
	query.setTablesList(tabla);
	query.setSelect("fecha,codigo,codproveedor,nombre");
	query.setFrom(tabla);
	query.setWhere(nombreIdTabla + " = " + idDocumento);
	if (!query.exec() || !query.next())
		return false;

	var curLineaEntrada:FLSqlCursor = new FLSqlCursor("lineasentradasarticulos");
	with (curLineaEntrada) {
		setModeAccess(curLineaEntrada.Insert);
		refreshBuffer();
		setValueBuffer(nombreIdLinea, curLE.valueBuffer("idlinea"));
		setValueBuffer(nombreIdTabla, curLE.valueBuffer(nombreIdTabla));
		setValueBuffer("referencia", curLE.valueBuffer("referencia"));
		setValueBuffer("descripcion", curLE.valueBuffer("descripcion"));
		setValueBuffer("fecha", query.value("fecha") );
		setValueBuffer("documento", documento );
		setValueBuffer("codigo", query.value("codigo") );
		setValueBuffer("codproveedor", query.value("codproveedor") );
		setValueBuffer("nombreproveedor", query.value("nombre") );
		setValueBuffer("cantidad", curLE.valueBuffer("cantidad"));
		setValueBuffer("pvpunitario", curLE.valueBuffer("pvpunitario"));
		setValueBuffer("pvpsindto", curLE.valueBuffer("pvpsindto"));
		setValueBuffer("pvptotal", curLE.valueBuffer("pvptotal"));
		setValueBuffer("totalconiva", curLE.valueBuffer("totalconiva"));
		setValueBuffer("dtolineal", curLE.valueBuffer("dtolineal"));
		setValueBuffer("dtopor", curLE.valueBuffer("dtopor"));
	}
	if (!curLineaEntrada.commitBuffer())
		return false;

	return true;
}

function lineasArticulos_borrarLineaEntrada(curLE:FLSqlCursor, nombreIdLinea:String, nombreIdTabla:String)
{
	var lineaEntrada:FLSqlCursor = new FLSqlCursor("lineasentradasarticulos");
	lineaEntrada.select(nombreIdLinea + " = " + curLE.valueBuffer("idlinea") + " AND " + nombreIdTabla + " = " + curLE.valueBuffer(nombreIdTabla));
	if (lineaEntrada.next()) {
		lineaEntrada.setActivatedCheckIntegrity(false);
		lineaEntrada.setModeAccess(lineaEntrada.Del);
		lineaEntrada.refreshBuffer();
		lineaEntrada.commitBuffer();
	}
}

function lineasArticulos_controlLineaEntradaAutomatica(documento:String, curLE:FLSqlCursor)
{
	if (curLE.modeAccess() == curLE.Insert) {
		if (documento == "Factura") {
			if (curLE.valueBuffer("idlineaalbaran")) {
				var lineaRemito:FLSqlCursor = new FLSqlCursor("lineasalbaranesprov");
				lineaRemito.select("idlinea = " + curLE.valueBuffer("idlineaalbaran") + " AND idalbaran = " + curLE.valueBuffer("idalbaran"));
				if (lineaRemito.first())
					this.iface.borrarLineaEntrada(lineaRemito, "idlineaalbaran", "idalbaran");
			}
		}
		else if (documento == "Remito") {
			if (curLE.valueBuffer("idlineapedido")) {
				var lineaPedido:FLSqlCursor = new FLSqlCursor("lineaspedidosprov");
				lineaPedido.select("idlinea = " + curLE.valueBuffer("idlineapedido") + " AND idpedido = " + curLE.valueBuffer("idpedido"));
				if (lineaPedido.first())
					this.iface.borrarLineaSalida(lineaPedido, "idlineapedido", "idpedido");
			}
		}
	}
}

//// LINEAS_ARTICULOS ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition ganancias */
/////////////////////////////////////////////////////////////////
//// GANANCIAS //////////////////////////////////////////////////

function ganancias_beforeCommit_lineaspresupuestoscli(curLP:FLSqlCursor):Boolean
{
	return this.iface.obtenerGananciaLinea(curLP, "presupuestoscli");
}

function ganancias_beforeCommit_lineaspedidoscli(curLP:FLSqlCursor):Boolean
{
	return this.iface.obtenerGananciaLinea(curLP, "pedidoscli");
}

function ganancias_beforeCommit_lineasalbaranescli(curLA:FLSqlCursor):Boolean
{
	return this.iface.obtenerGananciaLinea(curLA, "albaranescli");
}

function ganancias_beforeCommit_lineasfacturascli(curLF:FLSqlCursor):Boolean
{
	if ( !this.iface.__beforeCommit_lineasfacturascli(curLF) )
		return false;

	var util:FLUtil = new FLUtil();
	if ( !util.sqlSelect("facturascli","tpv","idfactura = "+ curLF.valueBuffer("idfactura")) )
		return this.iface.obtenerGananciaLinea(curLF, "facturascli");
	else
		return true;
}

function ganancias_beforeCommit_presupuestoscli(curPresupuesto:FLSqlCursor):Boolean
{
	if ( !this.iface.__beforeCommit_presupuestoscli(curPresupuesto) )
		return false;
	
	return this.iface.obtenerGanancia(curPresupuesto, "presupuesto");
}

function ganancias_beforeCommit_pedidoscli(curPedido:FLSqlCursor):Boolean
{
	if ( !this.iface.__beforeCommit_pedidoscli(curPedido) )
		return false;
	
	return this.iface.obtenerGanancia(curPedido, "pedido");
}

function ganancias_beforeCommit_albaranescli(curAlbaran:FLSqlCursor):Boolean
{
	if ( !this.iface.__beforeCommit_albaranescli(curAlbaran) )
		return false;

	return this.iface.obtenerGanancia(curAlbaran, "albaran");
}

function ganancias_beforeCommit_facturascli(curFactura:FLSqlCursor):Boolean
{
	if ( !this.iface.__beforeCommit_facturascli(curFactura) )
		return false;

	if ( !curFactura.valueBuffer("tpv") )
		return this.iface.obtenerGanancia(curFactura, "factura");
	else
		return true;
}

/* Calcula los costos, ganancia y utilidad porcentual de una línea de documento de cliente*/
function ganancias_obtenerGananciaLinea(lineaDoc:FLSqlCursor, doc:String):Boolean
{
	if (lineaDoc.modeAccess() == lineaDoc.Insert || lineaDoc.modeAccess() == lineaDoc.Edit) {

		var util:FLUtil = new FLUtil();

		var idDoc:String;
		switch (doc) {
			case "facturascli":
				idDoc = "idfactura";
				break;
			case "albaranescli":
				idDoc = "idalbaran";
				break;
			case "pedidoscli":
				idDoc = "idpedido";
				break;
			case "presupuestoscli":
				idDoc = "idpresupuesto";
				break;
			case "tpv_comandas":
				idDoc = "idtpv_comanda";
				break;
		}

		var costounitario:Number;
		var costototal:Number;
		var ganancia:Number;
		var utilidad:Number;

		// CONTEMPLAR MANEJO DE VARIAS DIVISAS

		costounitario = parseFloat(util.sqlSelect("articulos", "costeultimo",  "referencia = '" + lineaDoc.valueBuffer("referencia") + "'"));
		if (!costounitario || isNaN(costounitario)) {
			costounitario = parseFloat(util.sqlSelect("articulos", "costemaximo",  "referencia = '" + lineaDoc.valueBuffer("referencia") + "'"));
		}
		if (!costounitario || isNaN(costounitario)) {
			costounitario = 0;
		}
		costounitario = util.roundFieldValue(costounitario, lineaDoc.table(), "costounitario");

		costototal = costounitario * parseFloat(lineaDoc.valueBuffer("cantidad"));
		costototal = util.roundFieldValue(costototal, lineaDoc.table(), "costototal");

		ganancia = parseFloat(lineaDoc.valueBuffer("pvptotal")) - costototal;
		ganancia = util.roundFieldValue(ganancia, lineaDoc.table(), "ganancia");

		utilidad = (ganancia / parseFloat(lineaDoc.valueBuffer("pvptotal")))*100 ;
		utilidad = util.roundFieldValue(utilidad, lineaDoc.table(), "utilidad");
	
		lineaDoc.setValueBuffer("costounitario", costounitario);
		lineaDoc.setValueBuffer("costototal", costototal);
		lineaDoc.setValueBuffer("ganancia", ganancia);
		lineaDoc.setValueBuffer("utilidad", utilidad);
	}
	return true;
}

/* Calcula los costos, ganancia y utilidad porcentual de un documento de cliente*/
function ganancias_obtenerGanancia(doc:FLSqlCursor, linea:String):Boolean
{

	if (doc.modeAccess() == doc.Insert || doc.modeAccess() == doc.Edit) {

		var lineaDoc:String;
		var idLineaDoc:String;

		switch (linea) {
			case "presupuesto": {
				lineaDoc = "lineaspresupuestoscli";
				idLineaDoc = "idpresupuesto";
				break;
			}
			case "pedido": {
				lineaDoc = "lineaspedidoscli";
				idLineaDoc = "idpedido";
				break;
			}
			case "albaran": {
				lineaDoc = "lineasalbaranescli";
				idLineaDoc = "idalbaran";
				break;
			}
			case "factura": {
				lineaDoc = "lineasfacturascli";
				idLineaDoc = "idfactura";
				break;
			}
			case "tpv_comanda": {
				lineaDoc = "tpv_lineascomanda";
				idLineaDoc = "idtpv_comanda";
				break;
			}
			break;
		}
		var util:FLUtil = new FLUtil();

		var costototal:Number;
		var ganancia:Number;
		var utilidad:Number;

		costototal = parseFloat(util.sqlSelect(lineaDoc, "SUM(costototal)", idLineaDoc + " = " + doc.valueBuffer(idLineaDoc)));

		ganancia = parseFloat(doc.valueBuffer("neto")) - costototal;
		ganancia = util.roundFieldValue(ganancia, doc.table(), "ganancia");

		utilidad = (ganancia / parseFloat(doc.valueBuffer("neto")))*100 ;
		utilidad = util.roundFieldValue(utilidad, doc.table(), "utilidad");

		doc.setValueBuffer("costototal", costototal);
		doc.setValueBuffer("ganancia", ganancia);
		doc.setValueBuffer("utilidad", utilidad);
	}
	return true;
}

//// GANANCIAS //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition costos */
/////////////////////////////////////////////////////////////////
//// COSTOS /////////////////////////////////////////////////////

function costos_afterCommit_lineasfacturasprov(curLF:FLSqlCursor):Boolean
{
	if (!this.iface.__afterCommit_lineasfacturasprov(curLF))
		return false;

	if (sys.isLoadedModule("flfactalma")) {
		switch(curLF.modeAccess()) {
			case curLF.Edit: {
				if (curLF.valueBuffer("referencia") != curLF.valueBufferCopy("referencia")) {
					flfactalma.iface.pub_cambiarCosteUltimo(curLF.valueBufferCopy("referencia"));
					flfactalma.iface.pub_cambiarCosteMaximo(curLF.valueBufferCopy("referencia"));
				} else {
					flfactalma.iface.pub_cambiarCosteUltimo(curLF.valueBuffer("referencia"));
					flfactalma.iface.pub_cambiarCosteMaximo(curLF.valueBuffer("referencia"));
				}
				break;
			}
			case curLF.Insert: {
				flfactalma.iface.pub_cambiarCosteUltimo(curLF.valueBuffer("referencia"));
				flfactalma.iface.pub_cambiarCosteMaximo(curLF.valueBuffer("referencia"));
				break;
			}
			case curLF.Del: {
				flfactalma.iface.pub_cambiarCosteUltimo(curLF.valueBuffer("referencia"));
				flfactalma.iface.pub_cambiarCosteMaximo(curLF.valueBuffer("referencia"));
				break;
			}
			break;
		}

		flfactalma.iface.pub_cambiarCosteProveedor(curLF);

	}

	return true;
}

//// COSTOS /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition controlUsuario */
/////////////////////////////////////////////////////////////////
//// CONTROL_USUARIO ////////////////////////////////////////////

function controlUsuario_beforeCommit_presupuestoscli(curPresupuesto:FLSqlCursor):Boolean
{
	switch (curPresupuesto.modeAccess()) {
		case curPresupuesto.Insert: {
			if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
				flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Presupuestos");
				return false;
			} else {
				curPresupuesto.setValueBuffer( "idusuario", sys.nameUser() );
			}
			break;
		}
		break;
	}

	return this.iface.__beforeCommit_presupuestoscli(curPresupuesto);
}

function controlUsuario_beforeCommit_pedidoscli(curPedido:FLSqlCursor):Boolean
{
	switch (curPedido.modeAccess()) {
		case curPedido.Insert: {
			if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
				flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Pedidos");
				return false;
			} else {
				curPedido.setValueBuffer( "idusuario", sys.nameUser() );
			}
			break;
		}
		break;
	}

	return this.iface.__beforeCommit_pedidoscli(curPedido);
}

function controlUsuario_beforeCommit_albaranescli(curAlbaran:FLSqlCursor):Boolean
{
	switch (curAlbaran.modeAccess()) {
		case curAlbaran.Insert: {
			if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
				flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Remitos");
				return false;
			} else {
				curAlbaran.setValueBuffer( "idusuario", sys.nameUser() );
			}
			break;
		}
		break;
	}

	return this.iface.__beforeCommit_albaranescli(curAlbaran);
}

function controlUsuario_beforeCommit_facturascli(curFactura:FLSqlCursor):Boolean
{
	switch (curFactura.modeAccess()) {
		case curFactura.Insert: {
			if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
				flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Facturas");
				return false;
			} else {
				curFactura.setValueBuffer( "idusuario", sys.nameUser() );
			}
			break;
		}
		break;
	}

	return this.iface.__beforeCommit_facturascli(curFactura);
}

function controlUsuario_beforeCommit_servicioscli(curServicio:FLSqlCursor):Boolean
{
	switch (curServicio.modeAccess()) {
		case curServicio.Insert: {
			if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
				flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Servicios");
				return false;
			} else {
				curServicio.setValueBuffer( "idusuario", sys.nameUser() );
			}
			break;
		}
		break;
	}

	return true;
}

function controlUsuario_beforeCommit_contratos(curContrato:FLSqlCursor):Boolean
{
	switch (curContrato.modeAccess()) {
		case curContrato.Insert: {
			if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
				flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Contratos");
				return false;
			} else {
				curContrato.setValueBuffer( "idusuario", sys.nameUser() );
			}
			break;
		}
		break;
	}

	return true;
}

function controlUsuario_beforeCommit_pedidosprov(curPedido:FLSqlCursor):Boolean
{
	switch (curPedido.modeAccess()) {
		case curPedido.Insert: {
			if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
				flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Pedidos");
				return false;
			} else {
				curPedido.setValueBuffer( "idusuario", sys.nameUser() );
			}
			break;
		}
		break;
	}

	return this.iface.__beforeCommit_pedidosprov(curPedido);
}

function controlUsuario_beforeCommit_albaranesprov(curAlbaran:FLSqlCursor):Boolean
{
	switch (curAlbaran.modeAccess()) {
		case curAlbaran.Insert: {
			if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
				flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Remitos");
				return false;
			} else {
				curAlbaran.setValueBuffer( "idusuario", sys.nameUser() );
			}
			break;
		}
		break;
	}

	return this.iface.__beforeCommit_albaranesprov(curAlbaran);
}

function controlUsuario_beforeCommit_facturasprov(curFactura:FLSqlCursor):Boolean
{
	switch (curFactura.modeAccess()) {
		case curFactura.Insert: {
			if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
				flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Facturas");
				return false;
			} else {
				curFactura.setValueBuffer( "idusuario", sys.nameUser() );
			}
			break;
		}
		break;
	}

	return this.iface.__beforeCommit_facturasprov(curFactura);
}

function controlUsuario_beforeCommit_pedidosaut(curPedido:FLSqlCursor):Boolean
{
	switch (curPedido.modeAccess()) {
		case curPedido.Insert: {
			if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
				flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Pedidos automáticos");
				return false;
			} else {
				curPedido.setValueBuffer( "idusuario", sys.nameUser() );
			}
			break;
		}
		break;
	}

	return true;
}

//// CONTROL_USUARIO //////////////////////////////////////////
///////////////////////////////////////////////////////////////

/** @class_definition silixExtensiones */
/////////////////////////////////////////////////////////////////
//// SILIX EXTENSIONES //////////////////////////////////////////

function silixExtensiones_afterCommit_facturascli(curFactura:FLSqlCursor):Boolean
{
	if (!this.iface.__afterCommit_facturascli(curFactura))
		return false;

	var util:FLUtil = new FLUtil;
	if (sys.isLoadedModule("flfactcuentas") && flfactppal.iface.pub_valorDefectoEmpresa("cuentascajaintegrada")) {
		switch (curFactura.modeAccess()) {
			case curFactura.Edit: {
				// Chequear si se cargaron valores como pago, y qué forma de pago
				var curValores:FLSqlCursor = new FLSqlCursor("factvalores");
				curValores.select("idfactura = " + curFactura.valueBuffer("idfactura"));
				if (curValores.size() < 1 && curFactura.valueBuffer("codpago") == "CONTADO") {
					curValores.setModeAccess(curValores.Insert);
					curValores.refreshBuffer();
					curValores.setValueBuffer("tipodoc", "facturascli");
					curValores.setValueBuffer("tipovalor", "Efectivo");
					curValores.setValueBuffer("fecha", curFactura.valueBuffer("fecha"));
					curValores.setValueBuffer("pteaprobacion", false);
					curValores.setValueBuffer("monto", curFactura.valueBuffer("total"));
					curValores.setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
					curValores.setValueBuffer("idfactura", curFactura.valueBuffer("idfactura"));
					if (!curValores.commitBuffer())
						return false;
				}

				var query:FLSqlCursor = new FLSqlQuery;
				query.setTablesList("factvalores");
				query.setSelect("tipovalor, monto, coddivisa, valor, pteaprobacion, codcuenta, codchequera, codcheque, tipocheque, entidad, agencia, codigopostal, numerocheque, numerocuenta, numerocupon, codtarjeta, codplan, codtiporetencion, numeroretencion, pagodiferido, fecha, fechavencimiento, cifnif");
				query.setFrom("factvalores");
				query.setWhere("idfactura = " + curFactura.valueBuffer("idfactura"));
				if (!query.exec())
					return;

				if (query.size() > 0) {
					var curMovimiento:FLSqlCursor = new FLSqlCursor("ctas_movimientos");
					curMovimiento.setModeAccess(curMovimiento.Insert);
					curMovimiento.refreshBuffer();
					curMovimiento.setValueBuffer("codcomprobante", util.sqlSelect("ctas_datosgenerales","comprobantefacturascli","1 = 1"));
					curMovimiento.setValueBuffer("pteaprobacion", false);
					curMovimiento.setValueBuffer("numerocomprobante", curFactura.valueBuffer("codigo"));
					curMovimiento.setValueBuffer("tipocuenta", "Caja");
					curMovimiento.setValueBuffer("codcaja", curFactura.valueBuffer("codcaja"));
					curMovimiento.setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
					curMovimiento.setValueBuffer("fecha", curFactura.valueBuffer("fecha"));
					if (!curMovimiento.commitBuffer())
						return false;
					var saldo:Number = 0;
					while (query.next()) {
						var curValor:FLSqlCursor = new FLSqlCursor("ctas_valores");;
						with (curValor) {
							setModeAccess(curValor.Insert);
							refreshBuffer();
							setValueBuffer("codmovimiento", curMovimiento.valueBuffer("codmovimiento"));
							setValueBuffer("valor", query.value("valor"));
							setValueBuffer("monto", query.value("monto"));
							setValueBuffer("coddivisa", query.value("coddivisa"));
							setValueBuffer("pagodiferido", query.value("pagodiferido"));
							setValueBuffer("fecha", query.value("fecha"));
							setValueBuffer("fechavencimiento", query.value("fechavencimiento"));
							setValueBuffer("entidad", query.value("entidad"));
							setValueBuffer("agencia", query.value("agencia"));
							setValueBuffer("codigopostal", query.value("codigopostal"));
							setValueBuffer("numerocheque", query.value("numerocheque"));
							setValueBuffer("numerocuenta", query.value("numerocuenta"));
							setValueBuffer("cifnif", query.value("cifnif"));
							setValueBuffer("pteaprobacion", false);
							setValueBuffer("tipocheque", query.value("tipocheque"));
							setValueBuffer("tipocuentadestino", "Caja");
							setValueBuffer("codcajadestino", curFactura.valueBuffer("codcaja"));
							setValueBuffer("tipovalor", query.value("tipovalor"));
						}
						if (!curValor.commitBuffer())
							return false;
						saldo = saldo + query.value("monto");
					}

					curMovimiento.setModeAccess(curMovimiento.Edit);
					curMovimiento.refreshBuffer();
					curMovimiento.setValueBuffer("saldo", saldo);
					if (!curMovimiento.commitBuffer())
						return false;
				}
				break;
			}
			case curFactura.Del: {

				break;
			}
		}
	}

	if (sys.isLoadedModule("flfactteso") && curFactura.valueBuffer("tpv") == false) {
		switch (curFactura.modeAccess()) {
			case curFactura.Edit: {
				// Chequear si se cargaron valores como pago, y qué forma de pago
				var curValores:FLSqlCursor = new FLSqlCursor("factvalores");
				curValores.select("idfactura = " + curFactura.valueBuffer("idfactura"));
				if (curValores.size() > 0 && curFactura.valueBuffer("codpago") == "CTACTE") {
					/* si es CTACTE pero se hizo algún pago parcial, eliminar todos los recibos
					y regenerarlos. Esto se hace así pues INTERNA_afterCommit_facturascli
					genera un recibo por CtaCte y ese recibo chocaría con los generados aquí */
					var curRecibos:FLSqlCursor = new FLSqlCursor("reciboscli");
					curRecibos.select("idfactura = " + curFactura.valueBuffer("idfactura"));
					while (curRecibos.next()) {
						curRecibos.setModeAccess(curRecibos.Del);
						curRecibos.refreshBuffer();
						curRecibos.commitBuffer();
					}

					if (curFactura.modeAccess() == curFactura.Insert || curFactura.modeAccess() == curFactura.Edit) {
						if (!this.iface.generarRecibos(curFactura))
							return false;
					}
				}
				break;
			}
		}
	}
}

function silixExtensiones_beforeCommit_albaranescli(curAlbaran:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	switch (curAlbaran.modeAccess()) {
		case curAlbaran.Del: {
			if (curAlbaran.valueBuffer("servido") == "Parcial") {
				MessageBox.warning(util.translate("scripts", "No se puede eliminar un remito servido parcialmente.\nDebe borrar antes la factura relacionada."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
			}
			break;
		}
	}

	return this.iface.__beforeCommit_albaranescli(curAlbaran);
}

function silixExtensiones_afterCommit_lineasfacturascli(curLF:FLSqlCursor):Boolean
{
	if (!this.iface.actualizarAlbaranesLineaFacturaCli(curLF)) {
		return false;
	}

	if ( !this.iface.__afterCommit_lineasfacturascli(curLF) )
		return false;

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
function silixExtensiones_actualizarLineaAlbaranCli(idLineaAlbaran:Number, idAlbaran:Number, referencia:String, idFactura:Number, cantidadLineaFactura:Number):Boolean
{
	if (idLineaAlbaran == 0) {
		return true;
	}

	var cantidadServida:Number;
	var curLineaAlbaran:FLSqlCursor = new FLSqlCursor("lineasalbaranescli");
	curLineaAlbaran.select("idlinea = " + idLineaAlbaran);
	curLineaAlbaran.setModeAccess(curLineaAlbaran.Edit);
	if (!curLineaAlbaran.first()) {
		return true;
	}

	var cantidadAlbaran:Number = parseFloat(curLineaAlbaran.valueBuffer("cantidad"));
	var query:FLSqlQuery = new FLSqlQuery();
	query.setTablesList("lineasfacturascli");
	query.setSelect("SUM(cantidad)");
	query.setFrom("lineasfacturascli");
	query.setWhere("idlineaalbaran = " + idLineaAlbaran + " AND idfactura <> " + idFactura);
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

/** \C
Marca el remito como servido o parcialmente servido según corresponda.
@param	idAlbaran: Id del remito a actualizar
@param	curFactura: Cursor posicionado en la factura que modifica el estado del remito
@return	True si la actualización se realiza correctamente, false en caso contrario
\end */
function silixExtensiones_actualizarEstadoAlbaranCli(idAlbaran:Number, curFactura:FLSqlCursor):Boolean
{
	var estado:String = this.iface.obtenerEstadoAlbaranCli(idAlbaran);
	if (!estado) {
		return false;
	}
		
	var curAlbaran:FLSqlCursor = new FLSqlCursor("albaranescli");
	curAlbaran.select("idalbaran = " + idAlbaran);
	if (curAlbaran.first()) {
		if (estado == curAlbaran.valueBuffer("servido")) {
			return true;
		}
		curAlbaran.setUnLock("ptefactura", true);
	}
	
	curAlbaran.select("idalbaran = " + idAlbaran);
	curAlbaran.setModeAccess(curAlbaran.Edit);
	if (curAlbaran.first()) {
		curAlbaran.setValueBuffer("servido", estado);
		if (estado == "Sí") {
			curAlbaran.setValueBuffer("ptefactura", false);
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
function silixExtensiones_obtenerEstadoAlbaranCli(idAlbaran:Number):String
{
	var query:FLSqlQuery = new FLSqlQuery();

	query.setTablesList("lineasalbaranescli");
	query.setSelect("cantidad, totalenfactura, cerrada");
	query.setFrom("lineasalbaranescli");
	query.setWhere("idalbaran = " + idAlbaran);
	if (!query.exec()) {
		return false;
	}

	var estado:String = "";
	var totalServida:Number = 0;
	var parcial:Boolean = false;
	var totalLineas:Number = query.size();

	if(totalLineas == 0)
		return "No";

	while (query.next()) {
		var cantidad:Number = parseFloat(query.value("cantidad"));
		var cantidadServida:Number = parseFloat(query.value("totalenfactura"));
		var cerrada:Boolean = query.value("cerrada");
		if (cantidad == cantidadServida || cerrada)
			totalServida += 1;
		else
			if(cantidad > cantidadServida && cantidadServida != 0)
				parcial = true;
	}
	
	if(parcial) {
		estado = "Parcial";
	}
	else {
		if (totalServida == 0)
			estado = "No";
		else {
			if(totalServida == totalLineas)
				estado = "Sí";
			else
				if(totalServida < totalLineas)
					estado = "Parcial";
		}
	}
	return estado;
}

function silixExtensiones_actualizarAlbaranesLineaFacturaCli(curLF:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var idLineaAlbaran:Number = parseFloat(curLF.valueBuffer("idlineaalbaran"));
	if (idLineaAlbaran == 0) {
		return true;
	}
	
	switch (curLF.modeAccess()) {
		case curLF.Insert: {
			if (!this.iface.actualizarLineaAlbaranCli(curLF.valueBuffer("idlineaalbaran"), curLF.valueBuffer("idalbaran") , curLF.valueBuffer("referencia"), curLF.valueBuffer("idfactura"), curLF.valueBuffer("cantidad"))) {
				return false;
			}
			if (!this.iface.actualizarEstadoAlbaranCli(curLF.valueBuffer("idalbaran"), curLF)) {
				return false;
			}
			break;
		}
		case curLF.Edit: {
			if (curLF.valueBuffer("cantidad") != curLF.valueBufferCopy("cantidad")) {
				if (!this.iface.actualizarLineaAlbaranCli(curLF.valueBuffer("idlineaalbaran"), curLF.valueBuffer("idalbaran") , curLF.valueBuffer("referencia"), curLF.valueBuffer("idfactura"), curLF.valueBuffer("cantidad"))) {
					return false;
				}
				if (!this.iface.actualizarEstadoAlbaranCli(curLF.valueBuffer("idalbaran"), curLF)) {
					return false;
				}
			}
			break;
		}
		case curLF.Del: {
			var idAlbaran:Number = curLF.valueBuffer("idalbaran");
			var idLineaFactura:Number = curLF.valueBuffer("idlinea");
			if (!this.iface.restarCantidadAlbaranCli(idLineaAlbaran, idLineaFactura)) {
				return false;
			}
			this.iface.actualizarEstadoAlbaranCli(idAlbaran);
			break;
		}
	}
	return true;
}

/** \D
Cambia el valor del campo totalenfactura de una determinada línea de remito, calculándolo como la suma de cantidades en otras líneas distintas de la línea de factura indicada
@param idLineaAlbaran: Identificador de la línea de remito
@param idLineaFactura: Identificador de la línea de factura
\end */
function silixExtensiones_restarCantidadAlbaranCli(idLineaAlbaran:Number, idLineaFactura:Number):Boolean
{
	var util:FLUtil = new FLUtil;
	var cantidad:Number = parseFloat(util.sqlSelect("lineasfacturascli", "SUM(cantidad)", "idlineaalbaran = " + idLineaAlbaran + " AND idlinea <> " + idLineaFactura));
	if (isNaN(cantidad))
		cantidad = 0;

	var curLineaAlbaran:FLSqlCursor = new FLSqlCursor("lineasalbaranescli");
	curLineaAlbaran.select("idlinea = " + idLineaAlbaran);
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

/** \C Genera un recibo pagado por cada pago asociada a una factura de clientes o proveedores
@param	curFactura: cursor posiciondado en la factura
@return	true si la generación se realiza correctamente, false en caso contrario
\end */
function silixExtensiones_generarRecibos(curFactura:FLSqlCursor):Boolean
{
	if (!sys.isLoadedModule("flfactteso"))
		return true;
	
	var util:FLUtil = new FLUtil;

	var curPagos:FLSqlCursor = new FLSqlCursor("factvalores");
	curPagos.select("idfactura = " + curFactura.valueBuffer("idfactura"));

	var datosRecibo:Array = [];
	datosRecibo.numRecibo = 1;
	datosRecibo.moneda = util.sqlSelect("facturascli f INNER JOIN divisas d ON f.coddivisa = d.coddivisa", "d.descripcion", "f.idfactura = " + curFactura.valueBuffer("idfactura"), "facturascli,divisas");
	
	var idRecibo:String;
	var importe:Number;
	var totalPagado:Number;
	while (curPagos.next()) {
		datosRecibo.importe = parseFloat(curPagos.valueBuffer("monto"));
		datosRecibo.fecha = curPagos.valueBuffer("fecha");
		var tipoValor:String;
		switch (curPagos.valueBuffer("tipovalor")) {
			case "Cheque": {
				tipoValor = "CHEQUE";
				break;
			}
			default: {
				tipoValor = "CONTADO";
				break;
			}
		}
		datosRecibo.codPago = tipoValor;
		datosRecibo.estado = this.iface.emitirReciboComo(tipoValor);

		idRecibo = this.iface.generarRecibo(curFactura, datosRecibo);
		if (!idRecibo)
			return false;
		datosRecibo.numRecibo++;
		totalPagado += datosRecibo.importe;
	}

	datosRecibo.importe = parseFloat(curFactura.valueBuffer("total")) - totalPagado;
	if (datosRecibo.importe > 0) {
		datosRecibo.estado = "Emitido";
		datosRecibo.fecha = curFactura.valueBuffer("fecha");
		
		idRecibo = this.iface.generarRecibo(curFactura, datosRecibo);
		if (!idRecibo)
			return false;
	}
		
	return true;
}

function silixExtensiones_emitirReciboComo(codPago:String):String
{
	var util:FLUtil = new FLUtil;
	var emitirComo:String = util.sqlSelect("formaspago", "genrecibos", "codpago = '" + codPago + "'");

	if (emitirComo == "Pagados") {
		emitirComo = "Pagado";
	} else
		emitirComo = "Emitido";

	return emitirComo;
}

/** \C Genera un recibo más un pago asociado al pago de la factura
@param	curFactura: consulta que contiene los datos de la factura
@param	datosRecibo: Array con los siguientes datos relativos al recibo:
	importe
	número
	fecha
	moneda
	estado
@return	identificador del recibo, o false si hay error
\end */
function silixExtensiones_generarRecibo(curFactura:FLSqlCursor, datosRecibo:Array):Number
{
	var util:FLUtil = new FLUtil;
	
	var tabla:String = curFactura.table();
	if (tabla == "facturascli")
		tabla = "cli";
	else if (tabla == "facturasprov")
		tabla = "prov";

	var curRecibo:FLSqlCursor = new FLSqlCursor("recibos" + tabla);
	with (curRecibo) {
		setModeAccess(Insert);
		refreshBuffer()
		setValueBuffer("numero", datosRecibo.numRecibo);
		setValueBuffer("idfactura", curFactura.valueBuffer("idfactura"));
		setValueBuffer("importe", datosRecibo.importe);
		setValueBuffer("importeeuros", datosRecibo.importe * parseFloat(curFactura.valueBuffer("tasaconv")));
		setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
		setValueBuffer("codigo", curFactura.valueBuffer("codigo") + "-" + flfacturac.iface.pub_cerosIzquierda(datosRecibo.numRecibo, 2));
		setValueBuffer("codcliente", curFactura.valueBuffer("codcliente"));
		setValueBuffer("nombrecliente", curFactura.valueBuffer("nombrecliente"));
		setValueBuffer("cifnif", curFactura.valueBuffer("cifnif"));
		if (curFactura.valueBuffer("coddir"))
			setValueBuffer("coddir", curFactura.valueBuffer("coddir"));
		else
			setNull("coddir");
		setValueBuffer("direccion", curFactura.valueBuffer("direccion"));
		setValueBuffer("codpostal", curFactura.valueBuffer("codpostal"));
		setValueBuffer("ciudad", curFactura.valueBuffer("ciudad"));
		setValueBuffer("provincia", curFactura.valueBuffer("provincia"));
		setValueBuffer("codpais", curFactura.valueBuffer("codpais"));
		setValueBuffer("fecha", datosRecibo.fecha);
		setValueBuffer("fechav", datosRecibo.fecha);
		setValueBuffer("estado", datosRecibo.estado);
		setValueBuffer("texto", util.enLetraMoneda(datosRecibo.importe, datosRecibo.moneda));
	}
	if (!curRecibo.commitBuffer())
		return false;
	
	var idRecibo = curRecibo.valueBuffer("idrecibo");
	if (datosRecibo.estado == util.translate("scripts", "Pagado")) {
		if (!this.iface.pagarRecibo(idRecibo, datosRecibo, tabla))
			return false;
	}
		
	return idRecibo;
}

/** \C
Crea un registro de pago en tesorería asociado al recibo especificado
@param	idRecibo: Identificador del recibo a pagar
@param	datosRecibo: Array con los datos del recibo
@param tabla: "cli" o "prov", dependiendo de si es factura de cliente o de proveedor
@return true si el pago se crea correctamente, false en caso contrario
\end */
function silixExtensiones_pagarRecibo(idRecibo:String, datosRecibo:Array, tabla:String):Boolean
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
	
	var curPagoDevol:FLSqlCursor = new FLSqlCursor("pagosdevol" + tabla);
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

//// SILIX EXTENSIONES //////////////////////////////////////////
///////////////////////////////////////////////////////////////

/** @class_definition pieDocumento */
//////////////////////////////////////////////////////////////////
//// PIE DE DOCUMENTO ////////////////////////////////////////////

function pieDocumento_generarAsientoFacturaCli(curFactura:FLSqlCursor):Boolean
{
	if (curFactura.modeAccess() != curFactura.Insert && curFactura.modeAccess() != curFactura.Edit)
		return true;

	if (curFactura.valueBuffer("nogenerarasiento")) {
		curFactura.setNull("idasiento");
		return true;
	}

	if (!this.iface.comprobarRegularizacion(curFactura))
		return false;

	var util:FLUtil = new FLUtil();
	var datosAsiento:Array = [];
	var valoresDefecto:Array;
	valoresDefecto["codejercicio"] = curFactura.valueBuffer("codejercicio");
	valoresDefecto["coddivisa"] = flfactppal.iface.pub_valorDefectoEmpresa("coddivisa");

	var curTransaccion:FLSqlCursor = new FLSqlCursor("facturascli");
	curTransaccion.transaction(false);
	try {
		datosAsiento = this.iface.regenerarAsiento(curFactura, valoresDefecto);
		if (datosAsiento.error == true)
			throw util.translate("scripts", "Error al regenerar el asiento");
	
		var ctaCliente = this.iface.datosCtaCliente(curFactura, valoresDefecto);
		if (ctaCliente.error != 0)
			throw util.translate("scripts", "Error al leer los datos de subcuenta de cliente");
	
		if (!this.iface.generarPartidasCliente(curFactura, datosAsiento.idasiento, valoresDefecto, ctaCliente))
			throw util.translate("scripts", "Error al generar las partidas de cliente");
	
		if (!this.iface.generarPartidasIVACli(curFactura, datosAsiento.idasiento, valoresDefecto, ctaCliente))
			throw util.translate("scripts", "Error al generar las partidas de IVA");
	
		if (!this.iface.generarPartidasPieFacturascli(curFactura, datosAsiento.idasiento, valoresDefecto))
			throw util.translate("scripts", "Error al generar las partidas de pies de factura");

		if (!this.iface.generarPartidasVenta(curFactura, datosAsiento.idasiento, valoresDefecto))
			throw util.translate("scripts", "Error al generar las partidas de venta");

		curFactura.setValueBuffer("idasiento", datosAsiento.idasiento);

		if (curFactura.valueBuffer("decredito") == true)
			if (!this.iface.asientoNotaCreditoCli(curFactura, valoresDefecto))
				throw util.translate("scripts", "Error al generar el asiento correspondiente a la nota de crédito");
	
		if (curFactura.valueBuffer("dedebito") == true)
			if (!this.iface.asientoNotaDebitoCli(curFactura, valoresDefecto))
				throw util.translate("scripts", "Error al generar el asiento correspondiente a la nota de débito");

		if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento))
			throw util.translate("scripts", "Error al comprobar el asiento");
	} catch (e) {
		curTransaccion.rollback();
		MessageBox.warning(util.translate("scripts", "Error al generar el asiento correspondiente a la factura %1:").arg(curFactura.valueBuffer("codigo")) + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	curTransaccion.commit();

	return true;
}

function pieDocumento_generarAsientoFacturaProv(curFactura:FLSqlCursor):Boolean
{
	if (curFactura.modeAccess() != curFactura.Insert && curFactura.modeAccess() != curFactura.Edit)
		return true;

	if (curFactura.valueBuffer("nogenerarasiento")) {
		curFactura.setNull("idasiento");
		return true;
	}

	if (!this.iface.comprobarRegularizacion(curFactura))
		return false;

	var util:FLUtil = new FLUtil();
	var datosAsiento:Array = [];
	var valoresDefecto:Array;
	valoresDefecto["codejercicio"] = curFactura.valueBuffer("codejercicio");
	valoresDefecto["coddivisa"] = flfactppal.iface.pub_valorDefectoEmpresa("coddivisa");

	datosAsiento = this.iface.regenerarAsiento(curFactura, valoresDefecto);
	if (datosAsiento.error == true)
		return false;

	var numProveedor:String = curFactura.valueBuffer("numproveedor");
	var concepto:String = "";
	if (!numProveedor || numProveedor == "")
		concepto = util.translate("scripts", "Su factura ") + curFactura.valueBuffer("codigo");
	else
		concepto = util.translate("scripts", "Su factura ") + numProveedor;
	concepto += " - " + curFactura.valueBuffer("nombre");

	// Las partidas generadas dependen del régimen de IVA del proveedor
	var sinIva:Boolean = false;
	var regimenIVA:String = util.sqlSelect("proveedores", "regimeniva", "codproveedor = '" + curFactura.valueBuffer("codproveedor") + "'");
	if (regimenIVA == "Exento") sinIva = true;

	var ctaProveedor:Array = this.iface.datosCtaProveedor(curFactura, valoresDefecto);
	if (ctaProveedor.error != 0)
		return false;

	if (!this.iface.generarPartidasProveedor(curFactura, datosAsiento.idasiento, valoresDefecto, ctaProveedor, concepto, sinIva))
		return false;

	if (!this.iface.generarPartidasIVAProv(curFactura, datosAsiento.idasiento, valoresDefecto, ctaProveedor, concepto))
		return false;

	if (!this.iface.generarPartidasPieFacturasprov(curFactura, datosAsiento.idasiento, valoresDefecto, concepto))
		return false;

	if (!this.iface.generarPartidasCompra(curFactura, datosAsiento.idasiento, valoresDefecto, concepto))
		return false;

	curFactura.setValueBuffer("idasiento", datosAsiento.idasiento);

	if (curFactura.valueBuffer("decredito") == true) {
		if (!this.iface.asientoNotaCreditoProv(curFactura, valoresDefecto))
			return false;
	}
	if (curFactura.valueBuffer("dedebito") == true) {
		if (!this.iface.asientoNotaDebitoProv(curFactura, valoresDefecto))
			return false;
	}

	if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento))
		return false;

	return true;
}

function pieDocumento_generarPartidasCompra(curFactura:FLSqlCursor, idAsiento:Number, valoresDefecto:Array, concepto:String):Boolean
{
	var ctaCompras:Array = [];
	var util:FLUtil = new FLUtil();
	var monedaSistema:Boolean = (valoresDefecto.coddivisa == curFactura.valueBuffer("coddivisa"));
	var debe:Number = 0;
	var debeME:Number = 0;
	var idUltimaPartida:Number = 0;
	var debePie:Number = 0;

	/** \C En el asiento correspondiente a las facturas de proveedor, se generarán tantas partidas de compra como subcuentas distintas existan en las líneas de factura
	\end */
	var qrySubcuentas:FLSqlQuery = new FLSqlQuery();
	with (qrySubcuentas) {
		setTablesList("lineasfacturasprov");
		setSelect("codsubcuenta, SUM(pvptotal)");
		setFrom("lineasfacturasprov");
		setWhere("idfactura = " + curFactura.valueBuffer("idfactura") + " GROUP BY codsubcuenta");
	}
	try { qrySubcuentas.setForwardOnly( true ); } catch (e) {}
	
	if (!qrySubcuentas.exec())
		return false;

	if (qrySubcuentas.size() == 0 || curFactura.valueBuffer("decredito") || curFactura.valueBuffer("dedebito")) {
	/// \D Si la factura es rectificativa se genera una sola partida de compras que luego se convertirá a partida de nota de crédito o de nota de débito
		ctaCompras = this.iface.datosCtaEspecial("COMPRA", valoresDefecto.codejercicio);
		if (ctaCompras.error != 0) {
			MessageBox.warning(util.translate("scripts", "No existe ninguna subcuenta marcada como cuenta especial de COMPRA para %1").arg(valoresDefecto.codejercicio), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
		if (monedaSistema) {
			debe = this.iface.netoComprasFacturaProv(curFactura);
			debeME = 0;
		} else {
			debe = parseFloat(curFactura.valueBuffer("neto")) * parseFloat(curFactura.valueBuffer("tasaconv"));
			debeME = this.iface.netoComprasFacturaProv(curFactura);
		}
		debe = util.roundFieldValue(debe, "co_partidas", "debe");
		debeME = util.roundFieldValue(debeME, "co_partidas", "debeme");
		
		var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
		with (curPartida) {
			setModeAccess(curPartida.Insert);
			refreshBuffer();
			setValueBuffer("idsubcuenta", ctaCompras.idsubcuenta);
			setValueBuffer("codsubcuenta", ctaCompras.codsubcuenta);
			setValueBuffer("idasiento", idAsiento);
			setValueBuffer("debe", debe);
			setValueBuffer("haber", 0);
			setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
			setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
			setValueBuffer("debeME", debeME);
			setValueBuffer("haberME", 0);
		}
			
		this.iface.datosPartidaFactura(curPartida, curFactura, "proveedor", concepto);
		
		if (!curPartida.commitBuffer())
			return false;
		idUltimaPartida = curPartida.valueBuffer("idpartida");
	} else {
		while (qrySubcuentas.next()) {
			if (qrySubcuentas.value(0) == "" || !qrySubcuentas.value(0)) {
				ctaCompras = this.iface.datosCtaEspecial("COMPRA", valoresDefecto.codejercicio);
				if (ctaCompras.error != 0)
					return false;
				debePie = parseFloat(util.sqlSelect("piefacturasprov pf INNER JOIN piedocumentos pd ON pf.codpie = pd.codpie", "SUM(pf.totalinc)", "pf.idfactura = " + curFactura.valueBuffer("idfactura") + " AND pf.incluidoneto = true AND pd.codsubcuenta IS NULL ", "piefacturasprov,piedocumentos"));
				if (isNaN(debePie)) debePie = 0;
			} else {
				ctaCompras.codsubcuenta = qrySubcuentas.value(0);
				ctaCompras.idsubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + qrySubcuentas.value(0) + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
				if (!ctaCompras.idsubcuenta) {
					MessageBox.warning(util.translate("scripts", "No existe la subcuenta ")  + ctaCompras.codsubcuenta + util.translate("scripts", " correspondiente al ejercicio ") + valoresDefecto.codejercicio + util.translate("scripts", ".\nPara poder crear la factura debe crear antes esta subcuenta"), MessageBox.Ok, MessageBox.NoButton);
					return false;
				}
				debePie = 0;
			}

			if (monedaSistema) {
				debe = parseFloat(qrySubcuentas.value(1)) + debePie;
				debeME = 0;
			} else {
				debe = (parseFloat(qrySubcuentas.value(1)) + debePie) * parseFloat(curFactura.valueBuffer("tasaconv"));
				debeME = parseFloat(qrySubcuentas.value(1)) + debePie;
			}
			debe = util.roundFieldValue(debe, "co_partidas", "debe");
			debeME = util.roundFieldValue(debeME, "co_partidas", "debeme");
			
			var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
			with (curPartida) {
				setModeAccess(curPartida.Insert);
				refreshBuffer();
				setValueBuffer("idsubcuenta", ctaCompras.idsubcuenta);
				setValueBuffer("codsubcuenta", ctaCompras.codsubcuenta);
				setValueBuffer("idasiento", idAsiento);
				setValueBuffer("debe", debe);
				setValueBuffer("haber", 0);
				setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
				setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
				setValueBuffer("debeME", debeME);
				setValueBuffer("haberME", 0);
			}
			
			this.iface.datosPartidaFactura(curPartida, curFactura, "proveedor", concepto);
			
			if (!curPartida.commitBuffer())
				return false;
			idUltimaPartida = curPartida.valueBuffer("idpartida");
		}
	}

	/** \C En los asientos de factura de proveedor, y en el caso de que se use moneda extranjera, la última partida de compras tiene un saldo tal que haga que el asiento cuadre perfectamente. Esto evita errores de redondeo de conversión de moneda entre las partidas del asiento.
	\end */
	if (!monedaSistema) {
		debe = parseFloat(util.sqlSelect("co_partidas", "SUM(haber - debe)", "idasiento = " + idAsiento + " AND idpartida <> " + idUltimaPartida));
		if (debe && !isNaN(debe) && debe != 0) {
			debe = parseFloat(util.roundFieldValue(debe, "co_partidas", "debe"));
			if (!util.sqlUpdate("co_partidas", "debe", debe, "idpartida = " + idUltimaPartida))
				return false;
		}
	}

	return true;
}

function pieDocumento_generarPartidasPieFacturascli(curFactura:FLSqlCursor, idAsiento:Number, valoresDefecto:Array):Boolean
{
	var util:FLUtil = new FLUtil();

	var qryPieFacturascli:FLSqlQuery = new FLSqlQuery();
	with (qryPieFacturascli) {
		setTablesList("piefacturascli,piedocumentos");
		setSelect("pd.codsubcuenta, SUM(pf.totalinc)");
		setFrom("piefacturascli pf INNER JOIN piedocumentos pd ON pf.codpie = pd.codpie");
		setWhere("pf.idfactura = " + curFactura.valueBuffer("idfactura") + " AND pd.codsubcuenta IS NOT NULL GROUP BY pd.codsubcuenta");
	}
	try { qryPieFacturascli.setForwardOnly( true ); } catch (e) {}
	
	if (!qryPieFacturascli.exec())
		return false;

	if (qryPieFacturascli.size() == 0)
		return true;

	var monedaSistema:Boolean = (valoresDefecto.coddivisa == curFactura.valueBuffer("coddivisa"));
	var debe:Number = 0, debeME:Number = 0;
	var haber:Number = 0, haberME:Number = 0;

	var ctaPie:Array = [];
	var importePie:Number;
	var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
	while (qryPieFacturascli.next()) {
		importePie = parseFloat(qryPieFacturascli.value(1));
		if (!importePie || isNaN(importePie) || importePie == 0)
			continue;

		ctaPie.codsubcuenta = qryPieFacturascli.value(0);
		ctaPie.idsubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + qryPieFacturascli.value(0) + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
		if (!ctaPie.idsubcuenta) {
			MessageBox.warning(util.translate("scripts", "No existe la subcuenta ")  + ctaPie.codsubcuenta + util.translate("scripts", " correspondiente al ejercicio ") + valoresDefecto.codejercicio + util.translate("scripts", ".\nPara poder crear la factura debe crear antes esta subcuenta"), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}

		if (importePie > 0) {
			if (monedaSistema) {
				debe = 0;
				debeME = 0;
				haber = importePie;
				haberME = 0;
			} else {
				debe = 0;
				debeME = 0;
				haber = importePie * parseFloat(curFactura.valueBuffer("tasaconv"));
				haberME = importePie;
			}
		} else {
			importePie = importePie * -1;
			if (monedaSistema) {
				debe = importePie;
				debeME = 0;
				haber = 0;
				haberME = 0;
			} else {
				debe = importePie * parseFloat(curFactura.valueBuffer("tasaconv"));
				debeME = importePie;
				haber = 0;
				haberME = 0;
			}
		}

		debe = util.roundFieldValue(debe, "co_partidas", "debe");
		debeME = util.roundFieldValue(debeME, "co_partidas", "debeme");
		haber = util.roundFieldValue(haber, "co_partidas", "haber");
		haberME = util.roundFieldValue(haberME, "co_partidas", "haberme");
		
		with (curPartida) {
			setModeAccess(curPartida.Insert);
			refreshBuffer();
			setValueBuffer("idsubcuenta", ctaPie.idsubcuenta);
			setValueBuffer("codsubcuenta", ctaPie.codsubcuenta);
			setValueBuffer("idasiento", idAsiento);
			setValueBuffer("debe", debe);
			setValueBuffer("haber", haber);
			setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
			setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
			setValueBuffer("debeME", debeME);
			setValueBuffer("haberME", haberME);
		}
		
		this.iface.datosPartidaFactura(curPartida, curFactura, "cliente")
		
		if (!curPartida.commitBuffer())
			return false;
	}

	return true;
}

function pieDocumento_generarPartidasPieFacturasprov(curFactura:FLSqlCursor, idAsiento:Number, valoresDefecto:Array, concepto:String):Boolean
{
	var util:FLUtil = new FLUtil();

	var qryPieFacturasprov:FLSqlQuery = new FLSqlQuery();
	with (qryPieFacturasprov) {
		setTablesList("piefacturasprov,piedocumentos");
		setSelect("pd.codsubcuenta, SUM(pf.totalinc)");
		setFrom("piefacturasprov pf INNER JOIN piedocumentos pd ON pf.codpie = pd.codpie");
		setWhere("pf.idfactura = " + curFactura.valueBuffer("idfactura") + " AND pd.codsubcuenta IS NOT NULL GROUP BY pd.codsubcuenta");
	}
	try { qryPieFacturasprov.setForwardOnly( true ); } catch (e) {}
	
	if (!qryPieFacturasprov.exec())
		return false;

	if (qryPieFacturasprov.size() == 0)
		return true;

	var monedaSistema:Boolean = (valoresDefecto.coddivisa == curFactura.valueBuffer("coddivisa"));
	var debe:Number = 0, debeME:Number = 0;
	var haber:Number = 0, haberME:Number = 0;

	var ctaPie:Array = [];
	var importePie:Number;
	var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
	while (qryPieFacturasprov.next()) {
		importePie = parseFloat(qryPieFacturasprov.value(1));
		if (!importePie || isNaN(importePie) || importePie == 0)
			continue;

		ctaPie.codsubcuenta = qryPieFacturasprov.value(0);
		ctaPie.idsubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + qryPieFacturasprov.value(0) + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
		if (!ctaPie.idsubcuenta) {
			MessageBox.warning(util.translate("scripts", "No existe la subcuenta ")  + ctaPie.codsubcuenta + util.translate("scripts", " correspondiente al ejercicio ") + valoresDefecto.codejercicio + util.translate("scripts", ".\nPara poder crear la factura debe crear antes esta subcuenta"), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}

		if (importePie < 0) {
			importePie = importePie * -1;
			if (monedaSistema) {
				debe = 0;
				debeME = 0;
				haber = importePie;
				haberME = 0;
			} else {
				debe = 0;
				debeME = 0;
				haber = importePie * parseFloat(curFactura.valueBuffer("tasaconv"));
				haberME = importePie;
			}
		} else {
			if (monedaSistema) {
				debe = importePie;
				debeME = 0;
				haber = 0;
				haberME = 0;
			} else {
				debe = importePie * parseFloat(curFactura.valueBuffer("tasaconv"));
				debeME = importePie;
				haber = 0;
				haberME = 0;
			}
		}

		debe = util.roundFieldValue(debe, "co_partidas", "debe");
		debeME = util.roundFieldValue(debeME, "co_partidas", "debeme");
		haber = util.roundFieldValue(haber, "co_partidas", "haber");
		haberME = util.roundFieldValue(haberME, "co_partidas", "haberme");
		
		with (curPartida) {
			setModeAccess(curPartida.Insert);
			refreshBuffer();
			setValueBuffer("idsubcuenta", ctaPie.idsubcuenta);
			setValueBuffer("codsubcuenta", ctaPie.codsubcuenta);
			setValueBuffer("idasiento", idAsiento);
			setValueBuffer("debe", debe);
			setValueBuffer("haber", haber);
			setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
			setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
			setValueBuffer("debeME", debeME);
			setValueBuffer("haberME", haberME);
		}
		
		this.iface.datosPartidaFactura(curPartida, curFactura, "proveedor", concepto);
		
		if (!curPartida.commitBuffer())
			return false;
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