/***************************************************************************
                 flfactteso.qs  -  description
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
    function afterCommit_pagosdevolcli(curPD:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_pagosdevolcli(curPD);
	}
	function beforeCommit_pagosdevolcli(curPD:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_pagosdevolcli(curPD);
	}
	function afterCommit_reciboscli(curR:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_reciboscli(curR);
	}
	function afterCommit_pagosdevolprov(curPD:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_pagosdevolprov(curPD);
	}
	function beforeCommit_pagosdevolprov(curPD:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_pagosdevolprov(curPD);
	}
	function beforeCommit_remesas(curRemesa:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_remesas(curRemesa);
	}
	function beforeCommit_pagosdevolrem(curPR:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_pagosdevolrem(curPR);
	}
	function afterCommit_pagosdevolrem(curPD:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_pagosdevolrem(curPD);
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var curReciboCli:FLSqlCursor;
	
    function oficial( context ) { interna( context ); }
	function generarAsientoInverso(idAsientoDestino:Number, idAsientoOrigen:Number, concepto:String, codEjercicio:String):Boolean {
		return this.ctx.oficial_generarAsientoInverso(idAsientoDestino, idAsientoOrigen, concepto, codEjercicio);
	}
	function tienePagosDevCli(idRecibo:Number):Boolean {
		return this.ctx.oficial_tienePagosDevCli(idRecibo);
	}
	function regenerarRecibosCli(cursor:FLSqlCursor, emitirComo:String):Boolean {
		return this.ctx.oficial_regenerarRecibosCli(cursor, emitirComo);
	}
	function generarReciboCli(curFactura:FLSqlCursor, numRecibo:String, importe:Number, fechaVto:String, emitirComo:String, datosCuentaDom:Array, datosCuentaEmp:Array, datosSubcuentaEmp:Array):Boolean {
		return this.ctx.oficial_generarReciboCli(curFactura, numRecibo, importe, fechaVto, emitirComo, datosCuentaDom, datosCuentaEmp, datosSubcuentaEmp);
	}
	function obtenerDatosCuentaDom(codCliente:String):Array {
		return this.ctx.oficial_obtenerDatosCuentaDom(codCliente);
	}
	function obtenerDatosCuentaEmp(codCliente:String, codPago:String):Array {
		return this.ctx.oficial_obtenerDatosCuentaEmp(codCliente, codPago);
	}
	function obtenerDatosSubcuentaEmp(datosCuentaEmp:Array):Array {
		return this.ctx.oficial_obtenerDatosSubcuentaEmp(datosCuentaEmp);
	}
	function borrarRecibosCli(idFactura:Number):Boolean {
		return this.ctx.oficial_borrarRecibosCli(idFactura);
	}
	function calcFechaVencimientoCli(curFactura:FLSqlCursor, numPlazo:Number, diasAplazado:Number):String {
		return this.ctx.oficial_calcFechaVencimientoCli(curFactura, numPlazo, diasAplazado);
	}
	function regenerarRecibosProv(cursor:FLSqlCursor, emitirComo:String):Boolean {
		return this.ctx.oficial_regenerarRecibosProv(cursor, emitirComo);
	}
	function datosReciboCli(curFactura:FLSqlCursor):Boolean {
		return this.ctx.oficial_datosReciboCli(curFactura);
	}
	function calcularEstadoFacturaCli(idRecibo:String, idFactura:String):Boolean {
		return this.ctx.oficial_calcularEstadoFacturaCli(idRecibo, idFactura);
	}
	function cambiaUltimoPagoCli(idRecibo:String, idPagoDevol:String, unlock:Boolean):Boolean {
		return this.ctx.oficial_cambiaUltimoPagoCli(idRecibo, idPagoDevol, unlock);
	}
	function generarAsientoPagoDevolCli(curPD:FLSqlCursor) {
		return this.ctx.oficial_generarAsientoPagoDevolCli(curPD);
	}
	function generarPartidasCli(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean {
		return this.ctx.oficial_generarPartidasCli(curPD, valoresDefecto, datosAsiento, recibo);
	}
	function generarPartidasBanco(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean {
		return this.ctx.oficial_generarPartidasBanco(curPD, valoresDefecto, datosAsiento, recibo);
	}
	function generarPartidasCambio(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean {
		return this.ctx.oficial_generarPartidasCambio(curPD, valoresDefecto, datosAsiento, recibo);
	}
	function comprobarCuentasDom(idRemesa:String):Boolean {
		return this.ctx.oficial_comprobarCuentasDom(idRemesa);
	}
	function automataActivado():Boolean {
		return this.ctx.oficial_automataActivado();
	}
	function generarAsientoPagoRemesa(curPR:FLSqlCursor):Boolean {
		return this.ctx.oficial_generarAsientoPagoRemesa(curPR);
	}
	function generarPartidasEFCOGC(curPR:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, remesa:Array):Boolean {
		return this.ctx.oficial_generarPartidasEFCOGC(curPR, valoresDefecto, datosAsiento, remesa);
	}
	function generarPartidasBancoRem(curPR:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, remesa:Array):Boolean {
		return this.ctx.oficial_generarPartidasBancoRem(curPR, valoresDefecto, datosAsiento, remesa);
	}
	function esPagoEstePagoDevol(curPD:FLSqlCursor):Boolean {
		return this.ctx.oficial_esPagoEstePagoDevol(curPD);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration anticipos */
//////////////////////////////////////////////////////////////////
//// ANTICIPOS ///////////////////////////////////////////////////
class anticipos extends oficial {
	function anticipos( context ) { oficial( context ); }
	function afterCommit_anticiposcli(curA:FLSqlCursor):Boolean {
		return this.ctx.anticipos_afterCommit_anticiposcli(curA);
	}
	function beforeCommit_anticiposcli(curA:FLSqlCursor):Boolean {
		return this.ctx.anticipos_beforeCommit_anticiposcli(curA);
	}
	function generarReciboAnticipo(curFactura:FLSqlCursor, numRecibo:String, idAnticipo:Number, datosCuentaDom:Array):Boolean {
		return this.ctx.anticipos_generarReciboAnticipo(curFactura, numRecibo, idAnticipo, datosCuentaDom);
	}
	function regenerarRecibosCli(cursor:FLSqlCursor):Boolean {
		return this.ctx.anticipos_regenerarRecibosCli(cursor);
	}
}
//// ANTICIPOS ///////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration proveed */
//////////////////////////////////////////////////////////////////
//// PROVEED /////////////////////////////////////////////////////
class proveed extends anticipos {
    var curReciboProv:FLSqlCursor;
	
	function proveed( context ) { anticipos( context ); } 
	function tienePagosDevProv(idRecibo:Number):Boolean {
		return this.ctx.proveed_tienePagosDevProv(idRecibo);
	}
	function regenerarRecibosProv(cursor:FLSqlCursor, forzarEmitirComo:String):Boolean {
		return this.ctx.proveed_regenerarRecibosProv(cursor, forzarEmitirComo);
	}
	function afterCommit_pagosdevolprov(curPD:FLSqlCursor):Boolean {
		return this.ctx.proveed_afterCommit_pagosdevolprov(curPD);
	}
	function beforeCommit_pagosdevolprov(curPD:FLSqlCursor):Boolean {
		return this.ctx.proveed_beforeCommit_pagosdevolprov(curPD);
	}
	function calcFechaVencimientoProv(curFactura:FLSqlCursor, numPlazo:Number, diasAplazado:Number):String {
		return this.ctx.proveed_calcFechaVencimientoProv(curFactura, numPlazo, diasAplazado);
	}
	function datosReciboProv():Boolean {
		return this.ctx.proveed_datosReciboProv();
	}
	function cambiaUltimoPagoProv(idRecibo:String, idPagoDevol:String, unlock:Boolean):Boolean {
		return this.ctx.proveed_cambiaUltimoPagoProv(idRecibo, idPagoDevol, unlock);
	}
	function calcularEstadoFacturaProv(idRecibo:String, idFactura:String):Boolean {
		return this.ctx.proveed_calcularEstadoFacturaProv(idRecibo, idFactura);
	}
	function borrarRecibosProv(idFactura:Number):Boolean {
		return this.ctx.proveed_borrarRecibosProv(idFactura);
	}
	function generarPartidasProv(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean {
		return this.ctx.proveed_generarPartidasProv(curPD, valoresDefecto, datosAsiento, recibo);
	}
	function generarPartidasBancoProv(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean {
		return this.ctx.proveed_generarPartidasBancoProv(curPD, valoresDefecto, datosAsiento, recibo);
	}
	function generarPartidasCambioProv(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean {
		return this.ctx.proveed_generarPartidasCambioProv(curPD, valoresDefecto, datosAsiento, recibo);
	}
	function generarAsientoPagoDevolProv(curPD:FLSqlCursor):Boolean {
		return this.ctx.proveed_generarAsientoPagoDevolProv(curPD);
	}
	function codCuentaPagoProv(curFactura:FLSqlCursor):String {
		return this.ctx.proveed_codCuentaPagoProv(curFactura);
	}
	function siGenerarRecibosProv(curFactura:FLSqlCursor, masCampos:Array):Boolean {
		return this.ctx.provee_siGenerarRecibosProv(curFactura, masCampos);
	}
}
//// PROVEED /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration infoVencimtos */
//////////////////////////////////////////////////////////////////
//// INFO VENCIMIENTOS////////////////////////////////////////////
class infoVencimtos extends proveed {
    function infoVencimtos( context ) { proveed( context ); } 
	function datosReciboCli():Boolean {
		return this.ctx.infoVencimtos_datosReciboCli();
	}
	function datosReciboProv():Boolean {
		return this.ctx.infoVencimtos_datosReciboProv();
	}
}
//// INFO VENCIMIENTOS////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration pagosMultiples */
//////////////////////////////////////////////////////////////////
//// PAGOS MULTIPLES /////////////////////////////////////////////
class pagosMultiples extends infoVencimtos {
    function pagosMultiples( context ) { infoVencimtos ( context ); }

	function beforeCommit_pagosmulticli(curPagoMulti:FLSqlCursor):Boolean {
		return this.ctx.pagosMultiples_beforeCommit_pagosmulticli(curPagoMulti);
	}
	function beforeCommit_pagosmultiprov(curPagoMulti:FLSqlCursor):Boolean {
		return this.ctx.pagosMultiples_beforeCommit_pagosmultiprov(curPagoMulti);
	}
	function borrarRecibosCli(idFactura:Number):Boolean {
		return this.ctx.pagosMultiples_borrarRecibosCli(idFactura);
	}
	function borrarRecibosProv(idFactura:Number):Boolean {
		return this.ctx.pagosMultiples_borrarRecibosProv(idFactura);
	}
}
//// PAGOS MULTIPLES /////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration ctasCtes */
/////////////////////////////////////////////////////////////////
//// CTASCTES ///////////////////////////////////////////////////
class ctasCtes extends pagosMultiples {
    function ctasCtes( context ) { pagosMultiples ( context ); }
	function actualizarRiesgoCliente(codCliente:String) {
		return this.ctx.ctasCtes_actualizarRiesgoCliente(codCliente);
	}
	function actualizarRiesgoProveedor(codProveedor:String) {
		return this.ctx.ctasCtes_actualizarRiesgoProveedor(codProveedor);
	}
	function afterCommit_recibosprov(curR:FLSqlCursor):Boolean {
		return this.ctx.ctasCtes_afterCommit_recibosprov(curR);
	}
	function cuentaActiva(curDoc:FLSqlCursor):Boolean {
		return this.ctx.ctasCtes_cuentaActiva(curDoc);
	}
}
//// CTASCTES ///////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration controlUsuario */
/////////////////////////////////////////////////////////////////
//// CONTROL_USUARIO ////////////////////////////////////////////
class controlUsuario extends ctasCtes {
    function controlUsuario( context ) { ctasCtes ( context ); }

	function beforeCommit_pagosmulticli(curPagoMulti:FLSqlCursor):Boolean {
		return this.ctx.controlUsuario_beforeCommit_pagosmulticli(curPagoMulti);
	}
	function beforeCommit_pagosmultiprov(curPagoMulti:FLSqlCursor):Boolean {
		return this.ctx.controlUsuario_beforeCommit_pagosmultiprov(curPagoMulti);
	}
}
//// CONTROL_USUARIO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends controlUsuario {
	function head( context ) { controlUsuario ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
	function pub_regenerarRecibosCli(cursor:FLSqlCursor, emitirComo:String):Boolean {
		return this.regenerarRecibosCli(cursor, emitirComo);
	}
	function pub_regenerarRecibosProv(cursor:FLSqlCursor, emitirComo:String):Boolean {
		return this.regenerarRecibosProv(cursor, emitirComo);
	}
	function pub_calcularEstadoFacturaCli(idRecibo:String, idFactura:String):Boolean {
		return this.calcularEstadoFacturaCli(idRecibo, idFactura);
	}
	function pub_comprobarCuentasDom(idRemesa:String):Boolean {
		return this.comprobarCuentasDom(idRemesa);
	}
	function pub_automataActivado():Boolean {
		return this.automataActivado();
	}
}
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubProveed */
/////////////////////////////////////////////////////////////////
//// PUB PROVEEDORES ////////////////////////////////////////////
class pubProveed extends ifaceCtx {
	function pubProveed( context ) { ifaceCtx( context ); }
	function pub_calcularEstadoFacturaProv(idRecibo:String, idFactura:String):Boolean {
		return this.calcularEstadoFacturaProv(idRecibo, idFactura);
	}
}
//// PUB PROVEEDORES ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubCtasCtes */
/////////////////////////////////////////////////////////////////
//// PUB CTACTES ////////////////////////////////////////////////
class pubCtasCtes extends pubProveed {
    function pubCtasCtes( context ) { pubProveed( context ); }
	function pub_actualizarRiesgoCliente(codCliente:String) {
		return this.actualizarRiesgoCliente(codCliente);
	}
	function pub_actualizarRiesgoProveedor(codProveedor:String) {
		return this.actualizarRiesgoProveedor(codProveedor);
	}
	function pub_cuentaActiva(curDoc:FLSqlCursor):Boolean {
		return this.cuentaActiva(curDoc);
	}
}
//// PUB CTASCTES ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

const iface = new pubCtasCtes( this );

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
/** \D Se actualiza el campo idremesa de los pagos con el valor del campo idremesa del recibo
\end */
function interna_init()
{
	var util:FLUtil;
	if (!util.sqlSelect("remesas", "idremesa", "1 = 1"))
		return;
	if (util.sqlSelect("pagosdevolcli", "idremesa", "idremesa IS NOT NULL AND idremesa <> 0"))
		return;
	var qryRecibos:FLSqlQuery = new FLSqlQuery;
	qryRecibos.setTablesList("reciboscli,pagosdevolcli");
	qryRecibos.setSelect("pd.idpagodevol, r.idremesa, MAX(pd.fecha)")
	qryRecibos.setFrom("reciboscli r INNER JOIN pagosdevolcli pd ON r.idrecibo = pd.idrecibo")
	qryRecibos.setWhere("r.idremesa IS NOT NULL AND r.idremesa <> 0 AND pd.tipo = 'Pago' AND (pd.idremesa IS NULL OR pd.idremesa = 0) GROUP BY pd.idpagodevol, r.idremesa");
	qryRecibos.setForwardOnly(true);
	if (!qryRecibos.exec())
		return;
	var editable:Boolean;
	var paso:Number = 0;
	var curPD:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
	curPD.setActivatedCommitActions(false);
	curPD.transaction(false);
	try {
		util.createProgressDialog(util.translate("scripts", "Actualizando pagos de recibos remesados"), qryRecibos.size());
		while (qryRecibos.next()) {
			util.setProgress(paso)
			curPD.select("idpagodevol = " + qryRecibos.value("pd.idpagodevol"))
			if (!curPD.first()) {
				curPD.rollback();
				util.destroyProgressDialog();
				break;
			}
			editable = curPD.valueBuffer("editable");
			if (!editable) {
				curPD.setUnLock("editable", true);
				curPD.select("idpagodevol = " + qryRecibos.value("pd.idpagodevol"));
				curPD.first();
			}
			curPD.setModeAccess(curPD.Edit);
			curPD.refreshBuffer();
			curPD.setValueBuffer("idremesa", qryRecibos.value("r.idremesa"));
			if (!curPD.commitBuffer()) {
				curPD.rollback();
				util.destroyProgressDialog();
				break;
			}
			if (!editable) {
				curPD.select("idpagodevol = " + qryRecibos.value("pd.idpagodevol"));
				curPD.first();
				curPD.setUnLock("editable", false);
			}
			paso++;
		}
	} catch (e) {
		util.destroyProgressDialog();
		curPD.rollback();
	}
	curPD.setActivatedCommitActions(true);
	util.destroyProgressDialog();
	if (paso == qryRecibos.size()) {
		debug("Commit");
		curPD.commit();
	} else
		curPD.rollback();
}

/** \C Se elimina, si es posible, el asiento contable asociado al pago o devoluci�n
\end */
function interna_afterCommit_pagosdevolcli(curPD:FLSqlCursor):Boolean
{
	var idRecibo:String = curPD.valueBuffer("idrecibo");
	/** \C Se cambia el pago anterior al actual para que s�lo el �ltimo sea editable
	\end */
	switch (curPD.modeAccess()) {
		case curPD.Insert:
		case curPD.Edit: {
			if (!this.iface.cambiaUltimoPagoCli(idRecibo, curPD.valueBuffer("idpagodevol"), false))
				return false;
			break;
		}
		case curPD.Del: {
			if (!this.iface.cambiaUltimoPagoCli(idRecibo, curPD.valueBuffer("idpagodevol"), true))
				return false;
			break;
		}
	}
	
	if (!this.iface.calcularEstadoFacturaCli(idRecibo))
		return false;
	
	
	var util:FLUtil = new FLUtil();
	if (sys.isLoadedModule("flcontppal") == false || util.sqlSelect("empresa", "contintegrada", "1 = 1") == false)
		return true;

	switch (curPD.modeAccess()) {
		case curPD.Del: {
			if (curPD.isNull("idasiento"))
				return true;
	
			var idAsiento:Number = curPD.valueBuffer("idasiento");
			if (flfacturac.iface.pub_asientoBorrable(idAsiento) == false)
				return false;
	
			var curAsiento:FLSqlCursor = new FLSqlCursor("co_asientos");
			curAsiento.select("idasiento = " + idAsiento);
			if (curAsiento.first()) {
				curAsiento.setUnLock("editable", true);
				curAsiento.setModeAccess(curAsiento.Del);
				curAsiento.refreshBuffer();
				if (!curAsiento.commitBuffer())
					return false;
			}
			break;
		}
		case curPD.Edit: {
			if (curPD.valueBuffer("nogenerarasiento")) {
				var idAsientoAnterior:String = curPD.valueBufferCopy("idasiento");
				if (idAsientoAnterior && idAsientoAnterior != "") {
					if (!flfacturac.iface.pub_eliminarAsiento(idAsientoAnterior))
						return false;
				}
			}
			break;
		}
	}
	
	return true;
}

/** \C Se regenera, si es posible, el asiento contable asociado al pago o devoluci�n
\end */
function interna_beforeCommit_pagosdevolcli(curPD:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada") && !curPD.valueBuffer("nogenerarasiento")) {
		if (!this.iface.generarAsientoPagoDevolCli(curPD))
			return false;
	}
	
	return true;
}

/** \C Se recalcula el riesgo alcanzado
\end */
function interna_afterCommit_reciboscli(curR:FLSqlCursor):Boolean
{
	if (curR.valueBuffer("codcliente"))
		this.iface.actualizarRiesgoCliente(curR.valueBuffer("codcliente"));
	
	return true;
}


/** \C Funcionalidad no implementada para la versi�n oficial
\end */
function interna_afterCommit_pagosdevolprov(curPD:FLSqlCursor):Boolean
{
	return true;
}

/** \C Funcionalidad no implementada para la versi�n oficial
\end */
function interna_beforeCommit_pagosdevolprov(curPD:FLSqlCursor):Boolean
{
	return true;
}

function interna_beforeCommit_remesas(curRemesa:FLSqlCursor):Boolean
{

	switch (curRemesa.modeAccess()) {
		/** \C La remesa puede borrarse si todos los pagos asociados pueden ser excluidos
		\end */
		case curRemesa.Del: {
			var idRemesa:Number = curRemesa.valueBuffer("idremesa");
			var qryRecibos:FLSqlQuery = new FLSqlQuery;
			qryRecibos.setTablesList("pagosdevolcli");
			qryRecibos.setSelect("DISTINCT(idrecibo)");
			qryRecibos.setFrom("pagosdevolcli");
			qryRecibos.setWhere("idremesa = " + idRemesa);
			if (!qryRecibos.exec())
				return false;
			while (qryRecibos.next()) {
				if (!formRecordremesas.iface.pub_excluirReciboRemesa(qryRecibos.value(0), idRemesa))
					return false;
			}
		}
	}
	return true;
}

/** \C Se regenera, si es posible, el asiento contable asociado al pago de una remesa
\end */
function interna_beforeCommit_pagosdevolrem(curPR:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (sys.isLoadedModule("flcontppal") && flfactppal.iface.pub_valorDefectoEmpresa("contintegrada") && !curPR.valueBuffer("nogenerarasiento")) {
		if (!this.iface.generarAsientoPagoRemesa(curPR))
			return false;
	}
	
	return true;
}

/** \C Se elimina, si es posible, el asiento contable asociado al pago o devoluci�n
\end */
function interna_afterCommit_pagosdevolrem(curPD:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (sys.isLoadedModule("flcontppal") == false || util.sqlSelect("empresa", "contintegrada", "1 = 1") == false)
		return true;

	switch (curPD.modeAccess()) {
		case curPD.Del: {
			if (curPD.isNull("idasiento"))
				return true;
	
			var idAsiento:Number = curPD.valueBuffer("idasiento");
			if (flfacturac.iface.pub_asientoBorrable(idAsiento) == false)
				return false;
	
			var curAsiento:FLSqlCursor = new FLSqlCursor("co_asientos");
			curAsiento.select("idasiento = " + idAsiento);
			if (curAsiento.first()) {
				curAsiento.setUnLock("editable", true);
				curAsiento.setModeAccess(curAsiento.Del);
				curAsiento.refreshBuffer();
				if (!curAsiento.commitBuffer())
					return false;
			}
			break;
		}
		case curPD.Edit: {
			if (curPD.valueBuffer("nogenerarasiento")) {
				var idAsientoAnterior:String = curPD.valueBufferCopy("idasiento");
				if (idAsientoAnterior && idAsientoAnterior != "") {
					if (!flfacturac.iface.pub_eliminarAsiento(idAsientoAnterior))
						return false;
				}
			}
			break;
		}
	}
	
	return true;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Genera las partidas inversas correspondientes a un asiento, asoci�ndolas a otro.
@param idAsientoDestino Asiento de destino para la partida
@param idAsientoOrigen Asiento de origen para la partida
@param concepto Concepto de la partida inversa
\end */
function oficial_generarAsientoInverso(idAsientoDestino:Number, idAsientoOrigen:Number, concepto:String, codEjercicio:String):Boolean
{
	var util:FLUtil = new FLUtil;
	var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
	curPartida.select("idasiento = " + idAsientoDestino);
	qryPartidaOriginal = new FLSqlQuery();
	with(qryPartidaOriginal) {
		setTablesList("co_partidas");
		setSelect("codsubcuenta, debe, haber, coddivisa, tasaconv, debeME, haberME");
		setFrom("co_partidas");
		setWhere("idasiento = " + idAsientoOrigen);
	}
	try { qryPartidaOriginal.setForwardOnly( true ); } catch (e) {}
	if (!qryPartidaOriginal.exec())
		return false;

	while (qryPartidaOriginal.next()) {
		var idSubcuenta:Number = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + qryPartidaOriginal.value(0) + "' AND codejercicio = '" + codEjercicio + "'");
		if (!idSubcuenta) {
			MessageBox.warning(util.translate("scripts", "No existe la subcuenta ")  + qryPartidaOriginal.value(0) + util.translate("scripts", " correspondiente al ejercicio ") + codEjercicio + util.translate("scripts", ".\nPara poder realizar el asiento debe crear antes esta subcuenta"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
		with(curPartida) {
			setModeAccess(curPartida.Insert);
			refreshBuffer();
			setValueBuffer("concepto", concepto);
			setValueBuffer("idsubcuenta", idSubcuenta);
			setValueBuffer("codsubcuenta", qryPartidaOriginal.value(0));
			setValueBuffer("idasiento", idAsientoDestino);
			setValueBuffer("debe", qryPartidaOriginal.value(2));
			setValueBuffer("haber", qryPartidaOriginal.value(1));
			setValueBuffer("coddivisa", qryPartidaOriginal.value(3));
			setValueBuffer("tasaconv", qryPartidaOriginal.value(4));
			setValueBuffer("debeME", qryPartidaOriginal.value(6));
			setValueBuffer("haberME", qryPartidaOriginal.value(5));
		}
		if (!curPartida.commitBuffer())
			return false;
	}
	return true;
}

/* \D Indica si un determinado recibo tiene pagos y/o devoluciones asociadas.
@param idRecibo: Identificador del recibo
@return True: Tiene, False: No tiene
\end */
function oficial_tienePagosDevCli(idRecibo:Number):Boolean
{
	var curPagosDev:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
	curPagosDev.select("idrecibo = " + idRecibo);
	return curPagosDev.next();
}

/* \D Calcula la fecha de vencimiento de un recibo, como la fecha de facturaci�n m�s los d�as del plazo correspondiente
@param curFactura: Cursor posicionado en el registro de facturas correspondiente a la factura
@param numPlazo: N�mero del plazo actual
@param diasAplazado: D�as de aplazamiento del pago
@return Fecha de vencimiento
\end */
function oficial_calcFechaVencimientoCli(curFactura:FLSqlCursor, numPlazo:Number, diasAplazado:Number):String
{
	var util:FLUtil = new FLUtil;
	return util.addDays(curFactura.valueBuffer("fecha"), diasAplazado);
}

/* \D Regenera los recibos asociados a una factura a cliente.
Si la contabilidad est� activada, genera los correspondientes asientos de pago y devoluci�n.

@param cursor: Cursor posicionado en el registro de facturascli correspondiente a la factura
@return True: Regeneraci�n realizada con �xito, False: Error
\end */
function oficial_regenerarRecibosCli(cursor:FLSqlCursor, emitirComo:String):Boolean
{
	var util:FLUtil = new FLUtil();
	var contActiva:Boolean = sys.isLoadedModule("flcontppal") && util.sqlSelect("empresa", "contintegrada", "1 = 1");

	var idFactura:Number = cursor.valueBuffer("idfactura");
	var total:Number = parseFloat(cursor.valueBuffer("total"));

	if (!this.iface.borrarRecibosCli(idFactura))
		return false;
		
	if (total == 0)
		return true;

	var codPago:String = cursor.valueBuffer("codpago");
	var codCliente:String = cursor.valueBuffer("codcliente");

	var emitirComo:String = util.sqlSelect("formaspago", "genrecibos", "codpago = '" + codPago + "'");
	var datosCuentaDom = this.iface.obtenerDatosCuentaDom(codCliente);
	if (datosCuentaDom.error == 2)
		return false;
	var numRecibo:Number = 1;
	var numPlazo:Number = 1;
	var importe:Number;
	var diasAplazado:Number;
	var fechaVencimiento:String;
	var datosCuentaEmp:Array = false;
	var datosSubcuentaEmp:Array = false;

	if (emitirComo == "Pagados") {
		emitirComo = "Pagado";
		/* \D Si los recibos deben emitirse como pagados, se generar�n los registros de pago asociados a cada recibo. Si el m�dulo Principal de contabilidad est� cargado, se generar� el correspondienta asiento. La subcuenta contable del Debe del apunte corresponder� a la subcuenta contable asociada a la cuenta corriente correspondiente a la forma de pago de la factura. Si dicha cuenta corriente no est� especificada, la subcuenta contable del Debe del asiento ser� la correspondiente a la cuenta especial Caja.
		\end */
		datosCuentaEmp = this.iface.obtenerDatosCuentaEmp(codCliente, codPago);
		if (datosCuentaEmp.error == 2)
			return false;
		if (contActiva) {
			datosSubcuentaEmp = this.iface.obtenerDatosSubcuentaEmp(datosCuentaEmp);
			if (datosSubcuentaEmp.error == 2)
				return false;
		}
	} else
		emitirComo = "Emitido";

	var importeAcumulado:Number = 0;
	var curPlazos:FLSqlCursor = new FLSqlCursor("plazos");
	curPlazos.select("codpago = '" + codPago + "'  ORDER BY dias");
	if(curPlazos.size() == 0) {
		MessageBox.warning(util.translate("scripts", "No se pueden generar los recibos, la forma de pago ") + codPago + util.translate("scripts", "no tiene plazos de pago asociados"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	while (curPlazos.next()) {
		diasAplazado = curPlazos.valueBuffer("dias");
		
		if ( curPlazos.at() == ( curPlazos.size() - 1 ) )
			importe = parseFloat(total) - parseFloat(importeAcumulado);
		else
			importe = (parseFloat(total) * parseFloat(curPlazos.valueBuffer("aplazado"))) / 100;

		importe = util.roundFieldValue(importe, "reciboscli","importe");
		importeAcumulado = parseFloat(importeAcumulado) + parseFloat(importe);

		fechaVencimiento = this.iface.calcFechaVencimientoCli(cursor, numPlazo, diasAplazado);
		if (!this.iface.generarReciboCli(cursor, numRecibo, importe, fechaVencimiento, emitirComo, datosCuentaDom, datosCuentaEmp, datosSubcuentaEmp))
			return false;
		numRecibo++;
		numPlazo++;
	}

	if (emitirComo == "Pagado") {
		if (!this.iface.calcularEstadoFacturaCli(false, idFactura))
			return false;
	}

	if (cursor.valueBuffer("codcliente"))
		if (sys.isLoadedModule("flfactteso"))
			this.iface.actualizarRiesgoCliente(codCliente);

	return true;
}

/* \D Genera un recibo con los datos proporcionados. Si el recibo se emite como pagado y la contabilidad est� integrada, se generar� el asiento de pago correspondiente

@param curFactura: Cursor posicionado en la factura de la que proviene el recibo
@param numRecibo: Ordinal del recibo dentro del grupo de recibos asociados a la factura
@param importe: Importe del recibo
@param fechaVto: Fecha de vencimiento
@param emitirComo: Indica si el recibo se emitir� como 'Pagado' o como 'Emitido'.
@param datosCuentaDom: Datos de la cuenta de domiciaci�n, si existe
@param datosCuentaEmp: Datos de la cuenta de la empresa para realizar el pago
@param datosSubcuentaEmp: Datos contables de la subcuenta asociada a la cuenta bancaria de la empresa
@return True si no hay error, false en caso contrario
\end */
function oficial_generarReciboCli(curFactura:FLSqlCursor, numRecibo:String, importe:Number, fechaVto:String, emitirComo:String, datosCuentaDom:Array, datosCuentaEmp:Array, datosSubcuentaEmp:Array):Boolean
{
	if (!this.iface.curReciboCli)
		this.iface.curReciboCli = new FLSqlCursor("reciboscli");
		
	var util:FLUtil = new FLUtil();
	var importeEuros:Number  = importe * parseFloat(curFactura.valueBuffer("tasaconv"));
	var divisa:String = util.sqlSelect("divisas", "descripcion", "coddivisa = '" + curFactura.valueBuffer("coddivisa") + "'");
	var codDir:Number = curFactura.valueBuffer("coddir");
	with (this.iface.curReciboCli) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("numero", numRecibo);
		setValueBuffer("idfactura", curFactura.valueBuffer("idfactura"));
		setValueBuffer("importe", importe);
		setValueBuffer("texto", util.enLetraMoneda(importe, divisa));
		setValueBuffer("importeeuros", importeEuros);
		setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
		setValueBuffer("codigo", curFactura.valueBuffer("codigo") + "-" + flfacturac.iface.pub_cerosIzquierda(numRecibo, 2));
		setValueBuffer("codcliente", curFactura.valueBuffer("codcliente"));
		setValueBuffer("nombrecliente", curFactura.valueBuffer("nombrecliente"));
		setValueBuffer("cifnif", curFactura.valueBuffer("cifnif"));
		if (codDir == 0)
			setNull("coddir");
		else
			setValueBuffer("coddir", codDir);
		setValueBuffer("direccion", curFactura.valueBuffer("direccion"));
		setValueBuffer("codpostal", curFactura.valueBuffer("codpostal"));
		setValueBuffer("ciudad", curFactura.valueBuffer("ciudad"));
		setValueBuffer("provincia", curFactura.valueBuffer("provincia"));
		setValueBuffer("codpais", curFactura.valueBuffer("codpais"));
		setValueBuffer("fecha", curFactura.valueBuffer("fecha"));

		if (datosCuentaDom.error == 0) {
			setValueBuffer("codcuenta", datosCuentaDom.codcuenta);
			setValueBuffer("descripcion", datosCuentaDom.descripcion);
			setValueBuffer("ctaentidad", datosCuentaDom.ctaentidad);
			setValueBuffer("ctaagencia", datosCuentaDom.ctaagencia);
			setValueBuffer("cuenta", datosCuentaDom.cuenta);
			setValueBuffer("dc", datosCuentaDom.dc);
		}
		setValueBuffer("fechav", fechaVto);
		setValueBuffer("estado", emitirComo);
	}
	if (!this.iface.datosReciboCli(curFactura))
		return false;
		
	if (!this.iface.curReciboCli.commitBuffer())
		return false;

	if (emitirComo == "Pagado") {
		var idRecibo = this.iface.curReciboCli.valueBuffer("idrecibo");
		var curPago = new FLSqlCursor("pagosdevolcli");
		with(curPago) {
			setModeAccess(Insert);
			refreshBuffer();
			setValueBuffer("idrecibo", idRecibo);
			setValueBuffer("tipo", "Pago");
			setValueBuffer("fecha", curFactura.valueBuffer("fecha"));
			setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
			if (datosCuentaEmp.error == 0) {
				setValueBuffer("codcuenta", datosCuentaEmp.codcuenta);
				setValueBuffer("descripcion", datosCuentaEmp.descripcion);
				setValueBuffer("ctaentidad", datosCuentaEmp.ctaentidad);
				setValueBuffer("ctaagencia", datosCuentaEmp.ctaagencia);
				setValueBuffer("dc", datosCuentaEmp.dc);
				setValueBuffer("cuenta", datosCuentaEmp.cuenta);
			}
			if (datosSubcuentaEmp && datosSubcuentaEmp.error == 0) {
				setValueBuffer("codsubcuenta", datosSubcuentaEmp.codsubcuenta);
				setValueBuffer("idsubcuenta", datosSubcuentaEmp.idsubcuenta);
			}
		}
		if (!curPago.commitBuffer())
			return false;
	}
	return true;
}

/* \D Borra los recibos asociados a una factura. No es posible borrar recibos que pertenecen a una remesa o que tienen pagos o devoluciones asociados.

@param idFactura: Identificador de la factura de la que provienen los recibos
@return False si hay error o si el recibo no se puede borrar, true si los recibos se borran correctamente
\end */
function oficial_borrarRecibosCli(idFactura:Number):Boolean
{
	var curRecibos = new FLSqlCursor("reciboscli");
	curRecibos.select("idfactura = " + idFactura);
	while (curRecibos.next()) {
		curRecibos.setModeAccess(curRecibos.Browse);
		curRecibos.refreshBuffer();
		if (curRecibos.valueBuffer("idremesa") != 0) {
			return false;
		}
		if (this.iface.tienePagosDevCli(curRecibos.valueBuffer("idrecibo"))) {
			return false;
		}
	}
	curRecibos.select("idfactura = " + idFactura);
	while (curRecibos.next()) {
		curRecibos.setModeAccess(curRecibos.Del);
		curRecibos.refreshBuffer();
		if (!curRecibos.commitBuffer())
			return false;
	}
	return true;
}

/* \D Obtiene los datos de la cuenta de domiciliaci�n de un cliente

@param codCliente: Identificador del cliente
@return Array con los datos de la cuenta o false si no existe o hay un error. Los elementos de este array son:
	descripcion: Descripcion de la cuenta
	ctaentidad: C�digo de entidad bancaria
	ctaagencia: C�digo de oficina
	cuenta: N�mero de cuenta
	dc: D�gitos de control
	codcuenta: C�digo de la cuenta en la tabla de cuentas
	error: 0.Sin error 1.Datos no encontrados 2.Error
\end */
function oficial_obtenerDatosCuentaDom(codCliente:String):Array
{
	var datosCuentaDom:Array = [];
	var util:FLUtil = new FLUtil;
	var domiciliarEn:String = util.sqlSelect("clientes", "codcuentadom", "codcliente = '" + codCliente + "'");

	if (domiciliarEn != "") {
		datosCuentaDom = flfactppal.iface.pub_ejecutarQry("cuentasbcocli", "descripcion,ctaentidad,ctaagencia,cuenta,codcuenta", "codcuenta = '" + domiciliarEn + "'");
		switch (datosCuentaDom.result) {
		case -1:
			datosCuentaDom.error = 1;
			break;
		case 0:
			datosCuentaDom.error = 2;
			break;
		case 1:
			datosCuentaDom.dc = util.calcularDC(datosCuentaDom.ctaentidad + datosCuentaDom.ctaagencia) + util.calcularDC(datosCuentaDom.cuenta);
			datosCuentaDom.error = 0;
			break;
		}
	} else {
		datosCuentaDom.error = 1;
	}

	return datosCuentaDom;
}

/* \D Obtiene los datos de la cuenta de la empresa asociada a un determinado cliente o forma de pago. Si el cliente est� informado, toma su cuenta 'Remesar en'. Si no lo est�, se toma la cuenta bancaria asociada a la forma de pago

@param codPago: Identificador de la forma de pago
@return Array con los datos de la cuenta o false si no existe o hay un error. Los elementos de este array son:
	descripcion: Descripcion de la cuenta
	ctaentidad: C�digo de entidad bancaria
	ctaagencia: C�digo de oficina
	cuenta: N�mero de cuenta
	dc: D�gitos de control
	codsubcuenta: C�digo de la subcuenta contable asociada
	codcuenta: C�digo de la cuenta en la tabla de cuentas
	error: 0.Sin error 1.Datos no encontrados 2.Error
\end */
function oficial_obtenerDatosCuentaEmp(codCliente:String, codPago:String):Array
{
	var util:FLUtil = new FLUtil;
	var datosCuentaEmp:Array = [];
	var codCuentaEmp:String = util.sqlSelect("clientes", "codcuentarem", "codcliente = '" + codCliente + "'");
	if (!codCuentaEmp)
		codCuentaEmp = util.sqlSelect("formaspago", "codcuenta", "codpago = '" + codPago + "'");
		
	if (!codCuentaEmp.toString().isEmpty()) {
		datosCuentaEmp = flfactppal.iface.pub_ejecutarQry("cuentasbanco", "descripcion,ctaentidad,ctaagencia,cuenta,codsubcuenta,codcuenta", "codcuenta = '" + codCuentaEmp + "'");
		switch (datosCuentaEmp.result) {
		case -1:
			datosCuentaEmp.error = 1;
			break;
		case 0:
			datosCuentaEmp.error = 2;
			break;
		case 1:
			datosCuentaEmp.dc = util.calcularDC(datosCuentaEmp.ctaentidad + datosCuentaEmp.ctaagencia) + util.calcularDC(datosCuentaEmp.cuenta);
			datosCuentaEmp.error = 0;
			break;
		}
	} else {
		datosCuentaEmp.error = 1;
	}
	return datosCuentaEmp;
}

/* \D Obtiene los datos de la subcuenta contable asociada a una determinada cuenta bancaria. Si la cuenta bancaria no existe busca la subcuenta contable correspondiente a Caja.

@param datosCuentaEmp: Datos de la cuenta bancaria
@return Array con los datos de la subcuenta o false si no existe o hay un error. Los elementos de este array son:
	codsubcuenta: C�digo de subcuenta
	idsubcuenta: Identificador de la subcuenta en la tabla de subcuenta
	error: 0.Sin error 1.Datos no encontrados 2.Error
\end */
function oficial_obtenerDatosSubcuentaEmp(datosCuentaEmp:Array):Array
{
	var util:FLUtil = new FLUtil;
	var datosSubcuentaEmp:Array = [];
	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	if (datosCuentaEmp.error == 0) {
		datosSubcuentaEmp = flfactppal.iface.pub_ejecutarQry("co_subcuentas", "idsubcuenta,codsubcuenta", "codsubcuenta = '" + datosCuentaEmp.codsubcuenta + "' AND codejercicio = '" + codEjercicio + "'");
		switch (datosSubcuentaEmp.result) {
		case -1:
			MessageBox.warning(util.translate("scripts", "La cuenta bancaria asociada a la forma de pago seleccionada no tiene una cuenta contable v�lida asociada"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			datosSubcuentaEmp.error = 2;
			break;
		case 0:
			datosSubcuentaEmp.error = 2;
			break;
		case 1:
			datosSubcuentaEmp.error = 0;
		}
	} else {
		datosSubcuentaEmp = flfacturac.iface.pub_datosCtaEspecial("CAJA", codEjercicio);
	}
	return datosSubcuentaEmp;
}

/* \D Regenera los recibos asociados a una factura a proveedor. Funcionalidad no disponible en la versi�n oficial
\end */
function oficial_regenerarRecibosProv(cursor:FLSqlCursor, emitirComo:String):Boolean
{
	return true;
}

/* \D Funci�n para sobrecargar. Sirve para a�adir al cursor del recibo los datos que a�ada la extensi�n
\end */
function oficial_datosReciboCli(curFactura:FLSqlCursor):Boolean
{
	return true;
}

/** \D Cambia la factura relacionada con un recibo a editable o no editable en funci�n de si tiene pagos asociados o no
@param	idRecibo: Identificador de un recibo asociado a la factura
@param	idFactura: Identificador de la factura
@return	true si la verificaci�n del estado es correcta, false en caso contrario
\end */
function oficial_calcularEstadoFacturaCli(idRecibo:String, idFactura:String):Boolean
{
	var util:FLUtil = new FLUtil();
	if (!idFactura)
		idFactura = util.sqlSelect("reciboscli", "idfactura", "idrecibo = " + idRecibo);
	
	var qryPagos:FLSqlQuery = new FLSqlQuery();
	qryPagos.setTablesList("reciboscli,pagosdevolcli");
	qryPagos.setSelect("p.idpagodevol");
	qryPagos.setFrom("reciboscli r INNER JOIN pagosdevolcli p ON r.idrecibo = p.idrecibo");
	qryPagos.setWhere("r.idfactura = " + idFactura);
	try { qryPagos.setForwardOnly( true ); } catch (e) {}
	if (!qryPagos.exec())
		return false;
	
	var curFactura:FLSqlCursor = new FLSqlCursor("facturascli");
	curFactura.select("idfactura = " + idFactura);
	curFactura.first();
	if (qryPagos.size() == 0)
		curFactura.setUnLock("editable", true);
	else
		curFactura.setUnLock("editable", false);
	return true;
}

/** \D Cambia la el estado del �ltimo pago anterior al especificado, de forma que se mantenga como �nico pago editable el �ltimo de todos
@param	idRecibo: Identificador del recibo al que pertenecen los pagos tratados
@param	idPagoDevol: Identificador del pago que ha cambiado
@param	unlock: Indicador de si el �ltim pago debe ser editable o no
@return	true si la verificaci�n del estado es correcta, false en caso contrario
\end */
function oficial_cambiaUltimoPagoCli(idRecibo:String, idPagoDevol:String, unlock:Boolean):Boolean
{
	var curPagosDevol:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
	curPagosDevol.select("idrecibo = " + idRecibo + " AND idpagodevol <> " + idPagoDevol + " ORDER BY fecha, idpagodevol");
	if (curPagosDevol.last())
		curPagosDevol.setUnLock("editable", unlock);
		
	return true;
}

/** \Genera o regenera el asiento contable asociado a un pago o devoluci�n de recibo
@param	curPD: Cursor posicionado en el pago o devoluci�n cuyo asiento se va a regenerar
@return	true si la regeneraci�n se realiza correctamente, false en caso contrario
\end */
function oficial_generarAsientoPagoDevolCli(curPD:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (curPD.modeAccess() != curPD.Insert && curPD.modeAccess() != curPD.Edit)
		return true;

	if (curPD.valueBuffer("nogenerarasiento")) {
		curPD.setNull("idasiento");
		return true;
	}

	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(curPD.valueBuffer("fecha"), codEjercicio, "pagosdevolcli");
	if (!datosDoc.ok)
		return false;
	if (datosDoc.modificaciones == true) {
		codEjercicio = datosDoc.codEjercicio;
		curPD.setValueBuffer("fecha", datosDoc.fecha);
	}
	
	var datosAsiento:Array = [];
	var valoresDefecto:Array;
	valoresDefecto["codejercicio"] = codEjercicio;
	valoresDefecto["coddivisa"] = util.sqlSelect("empresa", "coddivisa", "1 = 1");
	
	datosAsiento = flfacturac.iface.pub_regenerarAsiento(curPD, valoresDefecto);
	if (datosAsiento.error == true)
		return false;

	if (curPD.valueBuffer("tipo") == "Pago") {
		var recibo:Array = flfactppal.iface.pub_ejecutarQry("reciboscli", "coddivisa,importe,importeeuros,idfactura,codigo,nombrecliente", "idrecibo = " + curPD.valueBuffer("idrecibo"));
		if (recibo.result != 1)
			return false;
	
		if (!this.iface.generarPartidasCli(curPD, valoresDefecto, datosAsiento, recibo))
			return false;
	
		if (!this.iface.generarPartidasBanco(curPD, valoresDefecto, datosAsiento, recibo))
			return false;

		if (!this.iface.generarPartidasCambio(curPD, valoresDefecto, datosAsiento, recibo))
			return false;
	} else {
		/** \D En el caso de dar una devoluci�n, las subcuentas del asiento contable ser�n las inversas al asiento contable correspondiente al �ltimo pago
		\end */
// 		var idAsientoPago:Number = util.sqlSelect("pagosdevolcli", "idasiento", "idrecibo = " + curPD.valueBuffer("idrecibo") + " AND  tipo = 'Pago' ORDER BY fecha DESC, idpagodevol DESC");
// 		var codRecibo:String = util.sqlSelect("reciboscli", "codigo", "idrecibo = " + curPD.valueBuffer("idrecibo"));
// 		if (this.iface.generarAsientoInverso(datosAsiento.idasiento, idAsientoPago, curPD.valueBuffer("tipo") + " recibo " + codRecibo, valoresDefecto.codejercicio) == false)
// 			return false;
			
		var recibo:Array = flfactppal.iface.pub_ejecutarQry("reciboscli", "coddivisa,importe,importeeuros,idfactura,codigo,nombrecliente", "idrecibo = " + curPD.valueBuffer("idrecibo"));
		if (recibo.result != 1)
			return false;
	
		if (!this.iface.generarPartidasCli(curPD, valoresDefecto, datosAsiento, recibo))
			return false;
	
		if (!this.iface.generarPartidasBanco(curPD, valoresDefecto, datosAsiento, recibo))
			return false;

		if (!this.iface.generarPartidasCambio(curPD, valoresDefecto, datosAsiento, recibo))
			return false;
	}

	curPD.setValueBuffer("idasiento", datosAsiento.idasiento);

	if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento))
		return false;

	return true;
}

/** \D Genera la partida correspondiente al cliente del asiento de pago
@param	curPD: Cursor del pago o devoluci�n
@param	valoresDefecto: Array de valores por defecto (ejercicio, divisa, etc.)
@param	datosAsiento: Array con los datos del asiento
@param	recibo: Array con los datos del recibo asociado al pago
@return	true si la generaci�n es correcta, false en caso contrario
\end */
function oficial_generarPartidasCli(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean
{
	var util:FLUtil = new FLUtil();
	var ctaHaber:Array = [];
	var codEjercicioFac:String;
	/** \C La cuenta del haber del asiento de pago ser� la misma cuenta de tipo CLIENT que se us� para realizar el asiento de la correspondiente factura
	\end */
	var idAsientoFactura:Number = util.sqlSelect("reciboscli r INNER JOIN facturascli f" +
		" ON r.idfactura = f.idfactura", "f.idasiento",
		"r.idrecibo = " + curPD.valueBuffer("idrecibo"),
		"facturascli,reciboscli");
	if (!idAsientoFactura) {
		codEjercicioFac = false;
	} else {
		codEjercicioFac = util.sqlSelect("co_asientos", "codejercicio", "idasiento = " + idAsientoFactura);
	}
	if (codEjercicioFac == valoresDefecto.codejercicio) {
		ctaHaber.codsubcuenta = util.sqlSelect("co_partidas p" +
			" INNER JOIN co_subcuentas s ON p.idsubcuenta = s.idsubcuenta" +
			" INNER JOIN co_cuentas c ON c.idcuenta = s.idcuenta",
			"s.codsubcuenta",
			"p.idasiento = " + idAsientoFactura + " AND c.idcuentaesp = 'CLIENT'",
			"co_partidas,co_subcuentas,co_cuentas");
	
		if (!ctaHaber.codsubcuenta) {
			MessageBox.warning(util.translate("scripts", "No se ha encontrado la subcuenta de cliente del asiento contable correspondiente a la factura a pagar"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
	} else {
		var codCliente:String = util.sqlSelect("reciboscli", "codcliente", "idrecibo = " + curPD.valueBuffer("idrecibo"));
		if (codCliente && codCliente != "") {
			ctaHaber.codsubcuenta = util.sqlSelect("co_subcuentascli", "codsubcuenta", "codcliente = '" + codCliente + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
			if (!ctaHaber.codsubcuenta) {
				MessageBox.warning(util.translate("scripts", "El cliente %1 no tiene definida ninguna subcuenta en el ejercicio %2.\nEspecifique la subcuenta en la pesta�a de contabilidad del formulario de clientes").arg(codCliente).arg(valoresDefecto.codejercicio), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}
		} else {
			ctaHaber = flfacturac.iface.pub_datosCtaEspecial("CLIENT", valoresDefecto.codejercicio);
			if (!ctaHaber.codsubcuenta) {
				MessageBox.warning(util.translate("scripts", "No tiene definida ninguna cuenta de tipo CLIENT.\nDebe crear este tipo especial y asociarlo a una cuenta\nen el m�dulo principal de contabilidad"), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}
		}
	}

	ctaHaber.idsubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + ctaHaber.codsubcuenta + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
	if (!ctaHaber.idsubcuenta) {
		MessageBox.warning(util.translate("scripts", "No existe la subcuenta ")  + ctaHaber.codsubcuenta + util.translate("scripts", " correspondiente al ejercicio ") + valoresDefecto.codejercicio + util.translate("scripts", ".\nPara poder realizar el pago debe crear antes esta subcuenta"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

	var haber:Number = 0;
	var haberME:Number = 0;
	var tasaconvHaber:Number = 1;

	if (valoresDefecto.coddivisa == recibo.coddivisa) {
		haber = recibo.importe;
		haberMe = 0;
	} else {
		tasaconvHaber = util.sqlSelect("reciboscli r INNER JOIN facturascli f ON r.idfactura = f.idfactura ", "tasaconv", "idrecibo = " + curPD.valueBuffer("idrecibo"), "reciboscli,facturascli");
		haber = parseFloat(recibo.importeeuros);
		haberME = parseFloat(recibo.importe);
	}
	haber = util.roundFieldValue(haber, "co_partidas", "haber");
	haberME = util.roundFieldValue(haberME, "co_partidas", "haberme");
	
	var esAbono:Boolean = flfacturac.iface.pub_esNotaCredito(util.sqlSelect("reciboscli r INNER JOIN facturascli f ON r.idfactura = f.idfactura", "tipoventa", "idrecibo = " + curPD.valueBuffer("idrecibo"), "reciboscli,facturascli"));
	var esPago:Boolean = this.iface.esPagoEstePagoDevol(curPD);
	
	var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
	with(curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		try {
			setValueBuffer("concepto", datosAsiento.concepto);
		} catch (e) {
			setValueBuffer("concepto", curPD.valueBuffer("tipo") + " recibo " + recibo.codigo + " - " + recibo.nombrecliente);
		}
		setValueBuffer("idsubcuenta", ctaHaber.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaHaber.codsubcuenta);
		setValueBuffer("idasiento", datosAsiento.idasiento);
		if (esPago) {
			if (esAbono) {
				setValueBuffer("debe", haber * -1);
				setValueBuffer("haber", 0);
			} else {
				setValueBuffer("debe", 0);
				setValueBuffer("haber", haber);
			}
		} else {
			if (esAbono) {
				setValueBuffer("haber", haber * -1);
				setValueBuffer("debe", 0);
			} else {
				setValueBuffer("haber", 0);
				setValueBuffer("debe", haber);
			}
		}
		setValueBuffer("coddivisa", recibo.coddivisa);
		setValueBuffer("tasaconv", tasaconvHaber);
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", haberME);
	}
	if (!curPartida.commitBuffer())
		return false;

	return true;
}

/** \D Genera la partida correspondiente al banco o a caja del asiento de pago
@param	curPD: Cursor del pago o devoluci�n
@param	valoresDefecto: Array de valores por defecto (ejercicio, divisa, etc.)
@param	datosAsiento: Array con los datos del asiento
@param	recibo: Array con los datos del recibo asociado al pago
@return	true si la generaci�n es correcta, false en caso contrario
\end */
function oficial_generarPartidasBanco(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean
{
	var util:FLUtil = new FLUtil();
	var ctaDebe:Array = [];
	ctaDebe.codsubcuenta = curPD.valueBuffer("codsubcuenta");
	ctaDebe.idsubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + ctaDebe.codsubcuenta + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
	if (!ctaDebe.idsubcuenta) {
		MessageBox.warning(util.translate("scripts", "No tiene definida la subcuenta %1 en el ejercicio %2.\nAntes de dar el pago debe crear la subcuenta o modificar el ejercicio").arg(ctaDebe.codsubcuenta).arg(valoresDefecto.codejercicio), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	var debe:Number = 0;
	var debeME:Number = 0;
	var tasaconvDebe:Number = 1;
	if (valoresDefecto.coddivisa == recibo.coddivisa) {
		debe = recibo.importe;
		debeME = 0;
	} else {
		tasaconvDebe = curPD.valueBuffer("tasaconv");
		debe = parseFloat(recibo.importe) * parseFloat(tasaconvDebe);
		debeME = parseFloat(recibo.importe);
	}
	debe = util.roundFieldValue(debe, "co_partidas", "debe");
	debeME = util.roundFieldValue(debeME, "co_partidas", "debeme");

	var esAbono:Boolean = flfacturac.iface.pub_esNotaCredito(util.sqlSelect("reciboscli r INNER JOIN facturascli f ON r.idfactura = f.idfactura", "tipoventa", "idrecibo = " + curPD.valueBuffer("idrecibo"), "reciboscli,facturascli"));
	var esPago:Boolean = this.iface.esPagoEstePagoDevol(curPD);
	
	var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
	with(curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		try {
			setValueBuffer("concepto", datosAsiento.concepto);
		} catch (e) {
			setValueBuffer("concepto", curPD.valueBuffer("tipo") + " recibo " + recibo.codigo + " - " + recibo.nombrecliente);
		}
		setValueBuffer("idsubcuenta", ctaDebe.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaDebe.codsubcuenta);
		setValueBuffer("idasiento", datosAsiento.idasiento);
		if (esPago) {
			if (esAbono) {
				setValueBuffer("debe", 0);
				setValueBuffer("haber", debe * -1);
			} else {
				setValueBuffer("debe", debe);
				setValueBuffer("haber", 0);
			}
		} else {
			if (esAbono) {
				setValueBuffer("haber", 0);
				setValueBuffer("debe", debe * -1);
			} else {
				setValueBuffer("haber", debe);
				setValueBuffer("debe", 0);
			}
		}
		
		setValueBuffer("coddivisa", recibo.coddivisa);
		setValueBuffer("tasaconv", tasaconvDebe);
		setValueBuffer("debeME", debeME);
		setValueBuffer("haberME", 0);
	}
	if (!curPartida.commitBuffer())
		return false;

	return true;
}
/** \D Genera, si es necesario, la partida de diferecias positivas o negativas de cambio
@param	curPD: Cursor del pago o devoluci�n
@param	valoresDefecto: Array de valores por defecto (ejercicio, divisa, etc.)
@param	datosAsiento: Array con los datos del asiento
@param	recibo: Array con los datos del recibo asociado al pago
@return	true si la generaci�n es correcta, false en caso contrario
\end */
function oficial_generarPartidasCambio(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean
{
	/** \C En el caso de que la divisa sea extranjera y la tasa de cambio haya variado desde el momento de la emisi�n de la factura, la diferencia se imputar� a la correspondiente cuenta de diferencias de cambio.
	\end */

	if (valoresDefecto.coddivisa == recibo.coddivisa)
		return true;

	var util:FLUtil = new FLUtil();
	var debe:Number = 0;
	var haber:Number = 0;
	var tasaconvDebe:Number = 1;
	var tasaconvHaber:Number = 1;
	var diferenciaCambio:Number = 0;
		
	tasaconvDebe = curPD.valueBuffer("tasaconv");
	tasaconvHaber = util.sqlSelect("reciboscli r INNER JOIN facturascli f ON r.idfactura = f.idfactura ", "tasaconv", "idrecibo = " + curPD.valueBuffer("idrecibo"), "reciboscli,facturascli");
	debe = parseFloat(recibo.importe) * parseFloat(tasaconvDebe);
	debe = util.roundFieldValue(debe, "co_partidas", "debe");

	haber = parseFloat(recibo.importeeuros);
	haber = util.roundFieldValue(haber, "co_partidas", "debe");

	diferenciaCambio = debe - haber;
	if (util.buildNumber(diferenciaCambio, "f", 2) == "0.00" || util.buildNumber(diferenciaCambio, "f", 2) == "-0.00") {
		diferenciaCambio = 0;
		return true;
	}
	
	diferenciaCambio = util.roundFieldValue(diferenciaCambio, "co_partidas", "debe");

	var ctaDifCambio:Array = [];
	var debeDifCambio:Number = 0;
	var haberDifCambio:Number = 0;
	if (diferenciaCambio > 0) {
		ctaDifCambio = flfacturac.iface.pub_datosCtaEspecial("CAMPOS", valoresDefecto.codejercicio);
		if (ctaDifCambio.error != 0)
			return false;
		debeDifCambio = 0;
		haberDifCambio = diferenciaCambio;
	} else {
		ctaDifCambio = flfacturac.iface.pub_datosCtaEspecial("CAMNEG", valoresDefecto.codejercicio);
		if (ctaDifCambio.error != 0)
			return false;
		diferenciaCambio = 0 - diferenciaCambio;
		debeDifCambio = diferenciaCambio;
		haberDifCambio = 0;
	}
	/// Esto lo usan algunas extensiones
// 	if (curPD.valueBuffer("tipo") == "Devoluci�n") {
// 		var aux:Number = debeDifCambio;
// 		debeDifCambio = haberDifCambio;
// 		haberDifCambio = aux;
// 	}
	var esPago:Boolean = this.iface.esPagoEstePagoDevol(curPD);
	
	var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
	with(curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		try {
			setValueBuffer("concepto", datosAsiento.concepto);
		} catch (e) {
			setValueBuffer("concepto", curPD.valueBuffer("tipo") + " recibo " + recibo.codigo + " - " + recibo.nombrecliente);
		}
		setValueBuffer("idsubcuenta", ctaDifCambio.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaDifCambio.codsubcuenta);
		setValueBuffer("idasiento", datosAsiento.idasiento);
		if (esPago) {
			setValueBuffer("debe", debeDifCambio);
			setValueBuffer("haber", haberDifCambio);
		} else {
			setValueBuffer("debe", haberDifCambio);
			setValueBuffer("haber", debeDifCambio);
		}
		setValueBuffer("coddivisa", valoresDefecto.coddivisa);
		setValueBuffer("tasaconv", 1);
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", 0);
	}
	if (!curPartida.commitBuffer())
		return false;

	return true;
}

function oficial_esPagoEstePagoDevol(curPD:FLSqlCursor):Boolean
{
	return (curPD.valueBuffer("tipo") == "Pago");
}

function oficial_comprobarCuentasDom(idRemesa:String):Boolean
{
	var util:FLUtil = new FLUtil();
	
	var qryRecibos:FLSqlQuery = new FLSqlQuery;
	qryRecibos.setTablesList("pagosdevolcli,reciboscli,cuentasbcocli");
	qryRecibos.setSelect("r.codigo, r.codcliente, r.nombrecliente");
	qryRecibos.setFrom("pagosdevolcli pd INNER JOIN reciboscli r ON pd.idrecibo = r.idrecibo LEFT OUTER JOIN cuentasbcocli cc ON (r.codcliente = cc.codcliente AND r.codcuenta = cc.codcuenta)");
	qryRecibos.setWhere("pd.idremesa = " + idRemesa + " AND cc.codcuenta IS NULL ORDER BY codcliente, codigo");
	qryRecibos.setForwardOnly( true );
	if (!qryRecibos.exec())
		return false;
debug(qryRecibos.sql());
	var msgError:String = "";
	var i:Number = 0;
	while (qryRecibos.next()) {
		msgError += "\n" + util.translate("scripts", "Cliente: %1 (%2), Recibo %3").arg(qryRecibos.value("r.nombrecliente")).arg(qryRecibos.value("r.codcliente")).arg(qryRecibos.value("r.codigo"));
	}
	if (msgError != "") {
		var res:Number = MessageBox.warning(util.translate("scripts", "Los siguientes recibos no tienen especificada una cuenta de domiciliaci�n v�lida:") + msgError + "\n" + util.translate("scripts", "�Desea continuar?"), MessageBox.Yes, MessageBox.No);
		if (res != MessageBox.Yes)
			return false;
	}
	return true;
}

/** \D Indica si el m�dulo de aut�mata est� instalado y activado
@return	true si est� activado, false en caso contrario
\end */
function oficial_automataActivado():Boolean
{
	if (!sys.isLoadedModule("flautomata"))
		return false;
	
	if (formau_automata.iface.pub_activado())
		return true;
	
	return false;
}

/** \Genera o regenera el asiento contable asociado a un pago de una remesa
@param	curPR: Cursor posicionado en el pago cuyo asiento se va a regenerar
@return	true si la regeneraci�n se realiza correctamente, false en caso contrario
\end */
function oficial_generarAsientoPagoRemesa(curPR:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (curPR.modeAccess() != curPR.Insert && curPR.modeAccess() != curPR.Edit)
		return true;

	if (curPR.valueBuffer("nogenerarasiento")) {
		curPR.setNull("idasiento");
		return true;
	}
	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(curPR.valueBuffer("fecha"), codEjercicio, "pagosdevolrem");
	if (!datosDoc.ok)
		return false;
	if (datosDoc.modificaciones == true) {
		codEjercicio = datosDoc.codEjercicio;
		curPR.setValueBuffer("fecha", datosDoc.fecha);
	}
	
	var datosAsiento:Array = [];
	var valoresDefecto:Array;
	valoresDefecto["codejercicio"] = codEjercicio;
	valoresDefecto["coddivisa"] = util.sqlSelect("empresa", "coddivisa", "1 = 1");
	
	datosAsiento = flfacturac.iface.pub_regenerarAsiento(curPR, valoresDefecto);
	if (datosAsiento.error == true)
		return false;

	var remesa:Array = flfactppal.iface.pub_ejecutarQry("remesas", "coddivisa,total,fecha,idremesa,codsubcuenta,codcuenta", "idremesa = " + curPR.valueBuffer("idremesa"));
		if (remesa.result != 1)
			return false;
	
	if (curPR.valueBuffer("tipo") == "Pago") {
		if (!this.iface.generarPartidasEFCOGC(curPR, valoresDefecto, datosAsiento, remesa))
			return false;
	
		if (!this.iface.generarPartidasBancoRem(curPR, valoresDefecto, datosAsiento, remesa))
			return false;
	}
	curPR.setValueBuffer("idasiento", datosAsiento.idasiento);
	if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento))
		return false;

	return true;
}

/** \D Genera la parte del asiento del pago correspondiente a la subcuenta especial EFCOGC
@param	curPR: Cursor del pago de la remesa
@param	idAsiento: Id del asiento asociado
@param	valoresDefecto: Array con los valores por defecto de ejercicio y divisa
@return	VERDADERO si no hay error, FALSO en otro caso
\end */
function oficial_generarPartidasEFCOGC(curPR:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, remesa:Array):Boolean
{
	var util:FLUtil = new FLUtil();

	var haber:Number = 0;
	var haberME:Number = 0;
	var ctaHaber:Array = [];
	ctaHaber.codsubcuenta = util.sqlSelect("cuentasbanco","codsubcuentaecgc","codcuenta = '" + remesa.codcuenta + "'");

	if (!ctaHaber.codsubcuenta || ctaHaber.codsubcuenta == "") {
		MessageBox.warning(util.translate("scripts", "No tiene definida de efectos comerciales de gesti�n de cobro para la cuenta %1").arg(remesa.codcuenta), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	ctaHaber.idsubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + ctaHaber.codsubcuenta + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
	if (!ctaHaber.idsubcuenta) {
		MessageBox.warning(util.translate("scripts", "No tiene definida la subcuenta %1 en el ejercicio %2.\nAntes de dar el pago debe crear la subcuenta o modificar el ejercicio").arg(ctaDebe.codsubcuenta).arg(valoresDefecto.codejercicio), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	haber = remesa.total;
	haberME = 0;
	haber = util.roundFieldValue(haber, "co_partidas", "haber");
	haberME = util.roundFieldValue(haberME, "co_partidas", "haberme");

	var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
	with (curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("concepto", curPR.valueBuffer("tipo") + " " + util.translate("scripts", "remesa") + " " + remesa.idremesa);
		setValueBuffer("idsubcuenta", ctaHaber.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaHaber.codsubcuenta);
		setValueBuffer("idasiento", datosAsiento.idasiento);
		setValueBuffer("debe", 0);
		setValueBuffer("haber", haber);
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", haberME);
	}
		
	if (!curPartida.commitBuffer())
		return false;

	return true;
}

/** \D Genera la partida correspondiente al banco o a caja del asiento de pago de la remesa
@param	curPR: Cursor del pago de la remesa
@param	valoresDefecto: Array de valores por defecto (ejercicio, divisa, etc.)
@param	datosAsiento: Array con los datos del asiento
@param	recibo: Array con los datos del recibo asociado al pago de la remesa
@return	true si la generaci�n es correcta, false en caso contrario
\end */
function oficial_generarPartidasBancoRem(curPR:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, remesa:Array):Boolean
{
	var util:FLUtil = new FLUtil();
	var ctaDebe:Array = [];
	ctaDebe.codsubcuenta = util.sqlSelect("cuentasbanco", "codsubcuenta", "codcuenta = '" + remesa.codcuenta + "'");
	ctaDebe.idsubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + ctaDebe.codsubcuenta + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
	if (!ctaDebe.idsubcuenta) {
		MessageBox.warning(util.translate("scripts", "No tiene definida la subcuenta %1 en el ejercicio %2.\nAntes de dar el pago debe crear la subcuenta o modificar el ejercicio").arg(ctaDebe.codsubcuenta).arg(valoresDefecto.codejercicio), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	var debe:Number = 0;
	var debeME:Number = 0;
	var tasaconvDebe:Number = 1;
	if (valoresDefecto.coddivisa == remesa.coddivisa) {
		debe = parseFloat(remesa.total);
		debeME = 0;
	} else {
		tasaconvDebe = curPR.valueBuffer("tasaconv");
		debe = parseFloat(remesa.total) * parseFloat(tasaconvDebe);
		debeME = parseFloat(remesa.total);
	}
	debe = util.roundFieldValue(debe, "co_partidas", "debe");
	debeME = util.roundFieldValue(debeME, "co_partidas", "debeme");

	var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
	with(curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("concepto", curPR.valueBuffer("tipo") + " " + util.translate("scripts", "remesa") + " " + remesa.idremesa);
		setValueBuffer("idsubcuenta", ctaDebe.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaDebe.codsubcuenta);
		setValueBuffer("idasiento", datosAsiento.idasiento);
		setValueBuffer("debe", debe);
		setValueBuffer("haber", 0);
		setValueBuffer("coddivisa", remesa.coddivisa);
		setValueBuffer("tasaconv", tasaconvDebe);
		setValueBuffer("debeME", debeME);
		setValueBuffer("haberME", 0);
	}
	if (!curPartida.commitBuffer())
		return false;

	return true;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition anticipos */
//////////////////////////////////////////////////////////////////
//// ANTICIPOS ///////////////////////////////////////////////////
/** \C Se elimina, si es posible, el asiento contable asociado al anticipo
\end */
function anticipos_afterCommit_anticiposcli(curA):Boolean
{
	var util:FLUtil = new FLUtil();
	if (sys.isLoadedModule("flcontppal") == false || util.sqlSelect("empresa", "contintegrada", "1 = 1") == false)
		return true;

	if (curA.modeAccess() == curA.Del) {
		if (curA.isNull("idasiento"))
			return true;

		var idAsiento:Number = curA.valueBuffer("idasiento");
		if (flfacturac.iface.pub_asientoBorrable(idAsiento) == false)
			return false;

		var curAsiento:FLSqlCursor = new FLSqlCursor("co_asientos");
		curAsiento.select("idasiento = " + idAsiento);
		if (curAsiento.first()) {
			curAsiento.setUnLock("editable", true);
			curAsiento.setModeAccess(curAsiento.Del);
			curAsiento.refreshBuffer();
			if (!curAsiento.commitBuffer())
				return false;
		}
	}

	return true;
}

/** \C Se crea o se regenera, si es posible, el asiento contable asociado al anticipo
\end */
function anticipos_beforeCommit_anticiposcli(curA):Boolean
{
	var util:FLUtil = new FLUtil();
	if (!sys.isLoadedModule("flcontppal") || curA.valueBuffer("nogenerarasiento") || !util.sqlSelect("empresa", "contintegrada", "1 = 1"))
		return true;

	if (curA.modeAccess() != curA.Insert && curA.modeAccess() != curA.Edit)
		return true;

	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(curA.valueBuffer("fecha"), codEjercicio, "pagosdevolcli");
	if (!datosDoc.ok)
		return false;
	if (datosDoc.modificaciones == true) {
		codEjercicio = datosDoc.codEjercicio;
		curA.setValueBuffer("fecha", datosDoc.fecha);
	}
	
	var datosAsiento:Array = [];
	var valoresDefecto:Array;
	valoresDefecto["codejercicio"] = codEjercicio;
	valoresDefecto["coddivisa"] = util.sqlSelect("empresa", "coddivisa", "1 = 1");
	datosAsiento = flfacturac.iface.pub_regenerarAsiento(curA, valoresDefecto);
	if (datosAsiento.error == true)
		return false;

	var ctaDebe:Array = [];
	var ctaHaber:Array = [];
	var codCliente = util.sqlSelect( "pedidoscli", "codcliente", "idpedido = " + curA.valueBuffer( "idpedido" ) );

	ctaHaber = flfactppal.iface.pub_datosCtaCliente( codCliente, valoresDefecto);
	if (ctaHaber.error != 0)
		return false;

	ctaDebe.idsubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + curA.valueBuffer("codsubcuenta") + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
	if (!ctaDebe.idsubcuenta) {
		MessageBox.warning(util.translate("scripts", "No existe la subcuenta para el ejercicio seleccionado:") + "\n" + curA.valueBuffer("codsubcuenta") + "\n" + valoresDefecto.codejercicio, MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	ctaDebe.codsubcuenta = curA.valueBuffer("codsubcuenta");

	var debe:Number = 0;
	var haber:Number = 0;
	var debeME:Number = 0;
	var haberME:Number = 0;
	var tasaconvDebe:Number = 1;
	var tasaconvHaber:Number = 1;
	var diferenciaCambio:Number = 0;
	var pedido:Array = flfactppal.iface.pub_ejecutarQry("pedidoscli", "coddivisa,codigo,tasaconv,nombrecliente", "idpedido = " + curA.valueBuffer("idpedido"));
	if (pedido.result != 1)
		return false;

	if (valoresDefecto.coddivisa == pedido.coddivisa) {
		debe = curA.valueBuffer("importe");
		debeME = 0;
		haber = debe;
		haberMe = 0;
	} else {
		tasaconvDebe = curA.valueBuffer("tasaconv");
		tasaconvHaber = pedido.tasaconv;
		debe = parseFloat(curA.valueBuffer("importe")) * parseFloat(tasaconvDebe);
		debeME = parseFloat(curA.valueBuffer("importe"));
		haber = parseFloat(curA.valueBuffer("importe")) * parseFloat(tasaconvHaber);
		haberME = parseFloat(curA.valueBuffer("importe"));
		diferenciaCambio = debe - haber;
		if (util.buildNumber(diferenciaCambio, "f", 2) == "0.00" || util.buildNumber(diferenciaCambio, "f", 2) == "-0.00") {
			diferenciaCambio = 0;
			debe = haber;
		}
	}

	var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
	with(curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("concepto", "Anticipo pedido " + curA.valueBuffer( "codigo" ) + " - " + pedido.nombrecliente);
		setValueBuffer("idsubcuenta", ctaDebe.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaDebe.codsubcuenta);
		setValueBuffer("idasiento", datosAsiento.idasiento);
		setValueBuffer("debe", debe);
		setValueBuffer("haber", 0);
		setValueBuffer("coddivisa", pedido.coddivisa);
		setValueBuffer("tasaconv", tasaconvDebe);
		setValueBuffer("debeME", debeME);
		setValueBuffer("haberME", 0);
	}
	if (!curPartida.commitBuffer())
		return false;

	with(curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		setValueBuffer("concepto", "Anticipo pedido " + curA.valueBuffer( "codigo" ) + " - " + pedido.nombrecliente);
		setValueBuffer("idsubcuenta", ctaHaber.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaHaber.codsubcuenta);
		setValueBuffer("idasiento", datosAsiento.idasiento);
		setValueBuffer("debe", 0);
		setValueBuffer("haber", haber);
		setValueBuffer("coddivisa", pedido.coddivisa);
		setValueBuffer("tasaconv", tasaconvHaber);
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", haberME);
	}
	if (!curPartida.commitBuffer())
			return false;

	/** \C En el caso de que la divisa sea extranjera y la tasa de cambio haya variado, la diferencia se imputar� a la correspondiente cuenta de diferencias de cambio.
		\end */
	if (diferenciaCambio != 0) {
		var ctaDifCambio:Array = [];
		var debeDifCambio:Number = 0;
		var haberDifCambio:Number = 0;
		if (diferenciaCambio > 0) {
			ctaDifCambio = flfacturac.iface.pub_datosCtaEspecial("CAMPOS", valoresDefecto.codejercicio);
			if (ctaDifCambio.error != 0)
				return false;
			debeDifCambio = 0;
			haberDifCambio = diferenciaCambio;
		} else {
			ctaDifCambio = flfacturac.iface.pub_datosCtaEspecial("CAMNEG", valoresDefecto.codejercicio);
			if (ctaDifCambio.error != 0)
				return false;
			diferenciaCambio = 0 - diferenciaCambio;
			debeDifCambio = diferenciaCambio;
			haberDifCambio = 0;
		}

		with(curPartida) {
			setModeAccess(curPartida.Insert);
			refreshBuffer();
			setValueBuffer("concepto", "Anticipo pedido " + curA.valueBuffer( "codigo" ) + " - " + pedido.nombrecliente);
			setValueBuffer("idsubcuenta", ctaDifCambio.idsubcuenta);
			setValueBuffer("codsubcuenta", ctaDifCambio.codsubcuenta);
			setValueBuffer("idasiento", datosAsiento.idasiento);
			setValueBuffer("debe", debeDifCambio);
			setValueBuffer("haber", haberDifCambio);
			setValueBuffer("coddivisa", valoresDefecto.coddivisa);
			setValueBuffer("tasaconv", 1);
			setValueBuffer("debeME", 0);
			setValueBuffer("haberME", 0);
		}
		if (!curPartida.commitBuffer())
			return false;
	}

	curA.setValueBuffer("idasiento", datosAsiento.idasiento);

	return true;
}

function anticipos_generarReciboAnticipo(curFactura:FLSqlCursor, numRecibo:String, idAnticipo:Number, datosCuentaDom:Array):Boolean
{
	var anticipo:Array = flfactppal.iface.pub_ejecutarQry("anticiposcli", "importe,fecha", "idanticipo = " + idAnticipo );
	if ( anticipo.result != 1 )
		return false;
	
	var util:FLUtil = new FLUtil();
	var importeEuros:Number  = anticipo.importe * parseFloat(curFactura.valueBuffer("tasaconv"));
	var divisa:String = util.sqlSelect("divisas", "descripcion", "coddivisa = '" + curFactura.valueBuffer("coddivisa") + "'");

	var curRecibo:FLSqlCursor = new FLSqlCursor("reciboscli");

	with(curRecibo) {
		setModeAccess(curRecibo.Insert);
		refreshBuffer();
		setValueBuffer("numero", numRecibo);
		setValueBuffer("idfactura", curFactura.valueBuffer("idfactura"));
		setValueBuffer("importe", anticipo.importe);
		setValueBuffer("texto", util.enLetraMoneda(anticipo.importe, divisa));
		setValueBuffer("importeeuros", importeEuros);
		setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
		setValueBuffer("codigo", curFactura.valueBuffer("codigo") + "-" + flfacturac.iface.pub_cerosIzquierda(numRecibo, 2));
		setValueBuffer("codcliente", curFactura.valueBuffer("codcliente"));
		setValueBuffer("nombrecliente", curFactura.valueBuffer("nombrecliente"));
		setValueBuffer("cifnif", curFactura.valueBuffer("cifnif"));
		setValueBuffer("coddir", curFactura.valueBuffer("coddir"));
		setValueBuffer("direccion", curFactura.valueBuffer("direccion"));
		setValueBuffer("codpostal", curFactura.valueBuffer("codpostal"));
		setValueBuffer("ciudad", curFactura.valueBuffer("ciudad"));
		setValueBuffer("provincia", curFactura.valueBuffer("provincia"));
		setValueBuffer("codpais", curFactura.valueBuffer("codpais"));
		setValueBuffer("fecha", curFactura.valueBuffer("fecha"));

		if (datosCuentaDom.error == 0) {
			setValueBuffer("codcuenta", datosCuentaDom.codcuenta);
			setValueBuffer("descripcion", datosCuentaDom.descripcion);
			setValueBuffer("ctaentidad", datosCuentaDom.ctaentidad);
			setValueBuffer("ctaagencia", datosCuentaDom.ctaagencia);
			setValueBuffer("cuenta", datosCuentaDom.cuenta);
			setValueBuffer("dc", datosCuentaDom.dc);
		}
		setValueBuffer("fechav", anticipo.fecha);
		setValueBuffer("estado", "Pagado");
		setValueBuffer("idanticipo", idAnticipo);
	}
	if (!curRecibo.commitBuffer())
			return false;

	return true;
}

function anticipos_regenerarRecibosCli(cursor:FLSqlCursor):Boolean 
{
	var util:FLUtil = new FLUtil();
	var contActiva:Boolean = sys.isLoadedModule("flcontppal") && util.sqlSelect("empresa", "contintegrada", "1 = 1");

	var idFactura:Number = cursor.valueBuffer("idfactura");
	var total:Number = parseFloat(cursor.valueBuffer("total"));

	if (!util.sqlSelect("anticiposcli a inner join pedidoscli p on a.idpedido=p.idpedido inner join lineasalbaranescli la on la.idpedido=p.idpedido inner join albaranescli ab on ab.idalbaran=la.idalbaran inner join facturascli f on f.idfactura=ab.idfactura", "idanticipo,importe", "f.idfactura = " + idFactura + " group by idanticipo,importe",  "anticiposcli,pedidoscli,lineasalbaranescli,albaranescli,facturascli"))
		return this.iface.__regenerarRecibosCli(cursor);

	if (!this.iface.borrarRecibosCli(idFactura))
		return false;
		
	if (total == 0)
		return true;

	var codPago:String = cursor.valueBuffer("codpago");
	var codCliente:String = cursor.valueBuffer("codcliente");

	var emitirComo:String = util.sqlSelect("formaspago", "genrecibos", "codpago = '" + codPago + "'");
	var datosCuentaDom = this.iface.obtenerDatosCuentaDom(codCliente);
	if (datosCuentaDom.error == 2)
		return false;

	var numRecibo:Number = 1;
	var numPlazo:Number = 1;
	var importe:Number;
	var diasAplazado:Number;
	var fechaVencimiento:String;
	var datosCuentaEmp:Array = false;
	var datosSubcuentaEmp:Array = false;
	var hayAnticipos:Boolean = false;

	if (emitirComo == "Pagados") {
		emitirComo = "Pagado";
		datosCuentaEmp = this.iface.obtenerDatosCuentaEmp(codCliente, codPago);
		if (datosCuentaEmp.error == 2)
			return false;
		if (contActiva) {
			datosSubcuentaEmp = this.iface.obtenerDatosSubcuentaEmp(datosCuentaEmp);
			if (datosSubcuentaEmp.error == 2)
				return false;
		}
	} else
		emitirComo = "Emitido";

	var importeAcumulado:Number = 0;
	var curPlazos:FLSqlCursor = new FLSqlCursor("plazos");
	curPlazos.select("codpago = '" + codPago + "'  ORDER BY dias");
	if(curPlazos.size() == 0){
		MessageBox.warning(util.translate("scripts", "No se pueden generar los recibos, la forma de pago ") + codPago + util.translate("scripts", "no tiene plazos de pago asociados"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

	/** \C En el caso de que existan anticipos crea un recibo como pagado para cada uno de ellos.
		\end */
	qryAnticipos = new FLSqlQuery();
	qryAnticipos.setTablesList("anticiposcli,pedidoscli,lineasalbaranescli,albaranescli,facturascli");
	qryAnticipos.setSelect("idanticipo,importe");
	qryAnticipos.setFrom("anticiposcli a inner join pedidoscli p on a.idpedido=p.idpedido inner join lineasalbaranescli la on la.idpedido=p.idpedido inner join albaranescli ab on ab.idalbaran=la.idalbaran inner join facturascli f on f.idfactura=ab.idfactura");
	qryAnticipos.setWhere("f.idfactura = " + idFactura + " group by idanticipo,importe");

	if (!qryAnticipos.exec())
		return false;

	while (qryAnticipos.next()) {
		if ( !this.iface.generarReciboAnticipo(cursor, numRecibo, qryAnticipos.value(0), datosCuentaDom) )
			return false;
		total -= parseFloat( qryAnticipos.value(1) );
		numRecibo++;
		hayAnticipos = true;
	}

	while (curPlazos.next()) {
		diasAplazado = curPlazos.valueBuffer("dias");
		importe = (total * parseFloat(curPlazos.valueBuffer("aplazado"))) / 100;
		if ( curPlazos.at() == ( curPlazos.size() - 1 ) )
			importe = total - importeAcumulado;
		else {
			importe = Math.round( importe );
			importeAcumulado += importe;
		}
		if ( importe < 0 )
			break;
		fechaVencimiento = this.iface.calcFechaVencimientoCli(cursor, numPlazo, diasAplazado);
		if (!this.iface.generarReciboCli(cursor, numRecibo, importe, fechaVencimiento, emitirComo, datosCuentaDom, datosCuentaEmp, datosSubcuentaEmp))
			return false;
		numRecibo++;
		numPlazo++;
	}

	if (emitirComo == "Pagado") {
		if (!this.iface.calcularEstadoFacturaCli(false, idFactura))
			return false;
	}

	if (cursor.valueBuffer("codcliente"))
		if (sys.isLoadedModule("flfactteso"))
			this.iface.actualizarRiesgoCliente(codCliente);

	return true;
}
//// ANTICIPOS ///////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition proveed */
/////////////////////////////////////////////////////////////////
//// PROVEED ////////////////////////////////////////////////////
/** \D
Indica si un determinado recibo tiene pagos y/o devoluciones asociadas.
@param idRecibo: Identificador del recibo
@return True: Tiene, False: No tiene
\end */
function proveed_tienePagosDevProv(idRecibo:Number):Boolean
{
	var curPagosDev:FLSqlCursor = new FLSqlCursor("pagosdevolprov");
	curPagosDev.select("idrecibo = " + idRecibo);
	return curPagosDev.next();
}

function proveed_regenerarRecibosProv(cursor:FLSqlCursor, forzarEmitirComo:String):Boolean
{
	if (!this.iface.siGenerarRecibosProv(cursor))
		return true;


	var util:FLUtil = new FLUtil();
	var contActiva:Boolean = sys.isLoadedModule("flcontppal") && util.sqlSelect("empresa", "contintegrada", "1 = 1");
	var idFactura:Number = cursor.valueBuffer("idfactura");
	
	if (!this.iface.curReciboProv)
		this.iface.curReciboProv = new FLSqlCursor("recibosprov");
	
	if (!this.iface.borrarRecibosProv(idFactura))
		return false;
		
	if (parseFloat(cursor.valueBuffer("total")) == 0)
		return true;

	var codPago:String = cursor.valueBuffer("codpago");
	
	var emitirComo:String;
	if (forzarEmitirComo)
		emitirComo = forzarEmitirComo;
	else	
		emitirComo = util.sqlSelect("formaspago", "genrecibos", "codpago = '" + codPago + "'");
	
	var total:Number = parseFloat(cursor.valueBuffer("total"));
	var idRecibo:Number;
	var numRecibo:Number = 1;
	var importeRecibo:Number, importeEuros:Number;
	var diasAplazado:Number, fechaVencimiento:String;
	var tasaConv:Number = parseFloat(cursor.valueBuffer("tasaconv"));
	var divisa:String = util.sqlSelect("divisas", "descripcion", "coddivisa = '" + cursor.valueBuffer("coddivisa") + "'");
	
	var codCuentaEmp:String = "";
	var desCuentaEmp:String = "";
	var ctaEntidadEmp:String = "";
	var ctaAgenciaEmp:String = "";
	var dCEmp:String = "";
	var cuentaEmp:String = "";
	var codSubcuentaEmp:String = "";
	var idSubcuentaEmp:String = "";
	var codProveedor:String = cursor.valueBuffer("codproveedor");
	if (emitirComo == "Pagados") {
		emitirComo = "Pagado";
		/*D Si los recibos deben emitirse como pagados, se generar�n los registros de pago asociados a cada recibo. Si el m�dulo Principal de contabilidad est� cargado, se generar� el correspondienta asiento. La subcuenta contable del Debe del apunte corresponder� a la subcuenta contable asociada a la cuenta corriente correspondiente a la cuenta de pago del proveedor, o en su defecto a la forma de pago de la factura. Si dicha cuenta corriente no est� especificada, la subcuenta contable del Debe del asiento ser� la correspondiente a la cuenta especial Caja.
		\end */
		codCuentaEmp = this.iface.codCuentaPagoProv(cursor);

		if (!codCuentaEmp)
			codCuentaEmp = util.sqlSelect("proveedores", "codcuentapago", "codproveedor = '" + codProveedor + "'");

		if (!codCuentaEmp)
			codCuentaEmp = util.sqlSelect("formaspago", "codcuenta", "codpago = '" + codPago + "'");
		
		var datosCuentaEmp:Array = [];
		if (codCuentaEmp.toString().isEmpty()) {
			if (contActiva) {
				var qrySubcuenta:FLSqlQuery = new FLSqlQuery();
				with (qrySubcuenta) {
					setTablesList("co_cuentas,co_subcuentas");
					setSelect("s.idsubcuenta, s.codsubcuenta");
					setFrom("co_cuentas c INNER JOIN co_subcuentas s ON c.idcuenta = s.idcuenta");
					setWhere("c.codejercicio = '" + cursor.valueBuffer("codejercicio") + "'" + " AND c.idcuentaesp = 'CAJA'");
				}
				if (!qrySubcuenta.exec()) {
					return false;
				}
				if (!qrySubcuenta.first())
					return false;
				idSubcuentaEmp = qrySubcuenta.value(0);
				codSubcuentaEmp = qrySubcuenta.value(1);
			}
		} else {
			datosCuentaEmp = flfactppal.iface.pub_ejecutarQry("cuentasbanco", "descripcion,ctaentidad,ctaagencia,cuenta,codsubcuenta", "codcuenta = '" + codCuentaEmp + "'");
			idSubcuentaEmp = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + datosCuentaEmp.codsubcuenta + "'" + " AND codejercicio = '" + cursor.valueBuffer("codEjercicio") + "'");
			desCuentaEmp = datosCuentaEmp.descripcion;
			ctaEntidadEmp = datosCuentaEmp.ctaentidad;
			ctaAgenciaEmp = datosCuentaEmp.ctaagencia;
			cuentaEmp = datosCuentaEmp.cuenta;
			var dc1:String = util.calcularDC(ctaEntidadEmp + ctaAgenciaEmp);
			var dc2:String = util.calcularDC(cuentaEmp);
			dCEmp = dc1 + dc2;
			codSubcuentaEmp =  datosCuentaEmp.codsubcuenta;
		}
	} else
		emitirComo = "Emitido";
	var numPlazo:Number = 1;
	var curPlazos:FLSqlCursor = new FLSqlCursor("plazos");
	var importeAcumulado:Number = 0;
	curPlazos.select("codpago = '" + codPago + "' ORDER BY dias");
	while (curPlazos.next()) {
		
		if ( curPlazos.at() == ( curPlazos.size() - 1 ) )
			importeRecibo = parseFloat(total) - parseFloat(importeAcumulado);
		else
			importeRecibo = (parseFloat(total) * parseFloat(curPlazos.valueBuffer("aplazado"))) / 100;
			
		importeRecibo = util.roundFieldValue(importeRecibo, "recibosprov","importe");
		importeAcumulado = parseFloat(importeAcumulado) + parseFloat(importeRecibo);

		importeEuros = importeRecibo * tasaConv;
		diasAplazado = curPlazos.valueBuffer("dias");
		
		with (this.iface.curReciboProv) {
			setModeAccess(Insert); 
			refreshBuffer();
			setValueBuffer("numero", numRecibo);
			setValueBuffer("idfactura", idFactura);
			setValueBuffer("importe", importeRecibo);
			setValueBuffer("texto", util.enLetraMoneda(importeRecibo, divisa));
			setValueBuffer("importeeuros", importeEuros);
			setValueBuffer("coddivisa", cursor.valueBuffer("coddivisa"));
			setValueBuffer("codigo", cursor.valueBuffer("codigo") + "-" + flfacturac.iface.pub_cerosIzquierda(numRecibo, 2));
			setValueBuffer("codproveedor", codProveedor);
			setValueBuffer("nombreproveedor", cursor.valueBuffer("nombre"));
			setValueBuffer("cifnif", cursor.valueBuffer("cifnif"));
			setValueBuffer("fecha", cursor.valueBuffer("fecha"));
			setValueBuffer("estado", emitirComo);
		}
		if (codProveedor && codProveedor != "") {
			var qryDir:FLSqlQuery = new FLSqlQuery;
			with (qryDir) {
				setTablesList("dirproveedores");
				setSelect("id, direccion, ciudad, codpostal, provincia, codpais");
				setFrom("dirproveedores");
				setWhere("codproveedor = '" + codProveedor + "' AND direccionppal = true");
				setForwardOnly(true);
			}
			if (!qryDir.exec())
				return false;
			if (qryDir.first()) {
				with (this.iface.curReciboProv) {
					setValueBuffer("coddir", qryDir.value("id"));
					setValueBuffer("direccion", qryDir.value("direccion"));
					setValueBuffer("ciudad", qryDir.value("ciudad"));
					setValueBuffer("codpostal", qryDir.value("codpostal"));
					setValueBuffer("provincia", qryDir.value("provincia"));
					setValueBuffer("codpais", qryDir.value("codpais"));
				}
			}
		}

		fechaVencimiento = this.iface.calcFechaVencimientoProv(cursor, numPlazo, diasAplazado);
		this.iface.curReciboProv.setValueBuffer("fechav", fechaVencimiento);
		
		if (!this.iface.datosReciboProv())
			return false;
		
		if (!this.iface.curReciboProv.commitBuffer())
			return false;

		if (emitirComo == "Pagado") {
			idRecibo = this.iface.curReciboProv.valueBuffer("idrecibo");
				
			var curPago:FLSqlCursor = new FLSqlCursor("pagosdevolprov");
			with(curPago) {
				setModeAccess(Insert);
				refreshBuffer();
				setValueBuffer("idrecibo", idRecibo);
				setValueBuffer("tipo", "Pago");
				setValueBuffer("fecha", cursor.valueBuffer("fecha"));
				setValueBuffer("codcuenta", codCuentaEmp);
				setValueBuffer("descripcion", desCuentaEmp);
				setValueBuffer("ctaentidad", ctaEntidadEmp);
				setValueBuffer("ctaagencia", ctaAgenciaEmp);
				setValueBuffer("dc", dCEmp);
				setValueBuffer("cuenta", cuentaEmp);
				setValueBuffer("codsubcuenta", codSubcuentaEmp);
				setValueBuffer("idSubcuenta", idSubcuentaEmp);
				setValueBuffer("tasaconv", cursor.valueBuffer("tasaconv"));
			}

			if (!curPago.commitBuffer())
				return false;
		}
		numRecibo++;
	}

	if (emitirComo == "Pagado") {
		if (!this.iface.calcularEstadoFacturaProv(false, idFactura))
			return false;
	}

	return true;
}

/** \C Se elimina, si es posible, el asiento contable asociado al pago o devoluci�n
\end */
function proveed_afterCommit_pagosdevolprov(curPD:FLSqlCursor):Boolean
{
	var idRecibo:String = curPD.valueBuffer("idrecibo");
	
	/** \C Se cambia el pago anterior al actual para que s�lo el �ltimo sea editable
	\end */
	switch (curPD.modeAccess()) {
		case curPD.Insert:
		case curPD.Edit: {
			if (!this.iface.cambiaUltimoPagoProv(idRecibo, curPD.valueBuffer("idpagodevol"), false))
			return false;
			break;
		}
		case curPD.Del: {
			if (!this.iface.cambiaUltimoPagoProv(idRecibo, curPD.valueBuffer("idpagodevol"), true))
			return false;
			break;
		}
	}
		
	if (!this.iface.calcularEstadoFacturaProv(idRecibo))
		return false;

	var util:FLUtil = new FLUtil();
	if (sys.isLoadedModule("flcontppal") == false || util.sqlSelect("empresa", "contintegrada", "1 = 1") == false)
		return true;
		
	switch (curPD.modeAccess()) {
		case curPD.Del: {
			if (curPD.isNull("idasiento"))
				return true;
	
			var idAsiento:Number = curPD.valueBuffer("idasiento");
			if (flfacturac.iface.pub_asientoBorrable(idAsiento) == false)
				return false;
	
			var curAsiento:FLSqlCursor = new FLSqlCursor("co_asientos");
			curAsiento.select("idasiento = " + idAsiento);
			if (curAsiento.first()) {
				curAsiento.setUnLock("editable", true);
				curAsiento.setModeAccess(curAsiento.Del);
				curAsiento.refreshBuffer();
				if (!curAsiento.commitBuffer())
					return false;
			}
			break;
		}
		case curPD.Edit: {
			if (curPD.valueBuffer("nogenerarasiento")) {
				var idAsientoAnterior:String = curPD.valueBufferCopy("idasiento");
				if (idAsientoAnterior && idAsientoAnterior != "") {
					if (!flfacturac.iface.pub_eliminarAsiento(idAsientoAnterior))
						return false;
				}
			}
			break;
		}
	}
	return true;
}

/** \C Se regenera, si es posible, el asiento contable asociado al pago o devoluci�n
\end */
function proveed_beforeCommit_pagosdevolprov(curPD:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (sys.isLoadedModule("flcontppal") && util.sqlSelect("empresa", "contintegrada", "1 = 1") && !curPD.valueBuffer("nogenerarasiento")) {
		if (!this.iface.generarAsientoPagoDevolProv(curPD))
			return false;
	}
	return true;
}

function proveed_generarAsientoPagoDevolProv(curPD:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	if (curPD.modeAccess() != curPD.Insert && curPD.modeAccess() != curPD.Edit)
		return true;

	if (curPD.valueBuffer("nogenerarasiento")) {
		curPD.setNull("idasiento");
		return true;
	}

	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(curPD.valueBuffer("fecha"), codEjercicio, "pagosdevolprov");
	if (!datosDoc.ok)
		return false;
	if (datosDoc.modificaciones == true) {
		codEjercicio = datosDoc.codEjercicio;
		curPD.setValueBuffer("fecha", datosDoc.fecha);
	}

	var datosAsiento:Array = [];
	var valoresDefecto:Array;
	valoresDefecto["codejercicio"] = codEjercicio;
	valoresDefecto["coddivisa"] = util.sqlSelect("empresa", "coddivisa", "1 = 1");
	
	datosAsiento = flfacturac.iface.pub_regenerarAsiento(curPD, valoresDefecto);
	if (datosAsiento.error == true)
		return false;

	if (curPD.valueBuffer("tipo") == "Pago") {
		var recibo:Array = flfactppal.iface.pub_ejecutarQry("recibosprov", "coddivisa,importe,importeeuros,idfactura,codigo,nombreproveedor", "idrecibo = " + curPD.valueBuffer("idrecibo"));
		if (recibo.result != 1)
			return false;
	
		if (!this.iface.generarPartidasProv(curPD, valoresDefecto, datosAsiento, recibo))
			return false;
	
		if (!this.iface.generarPartidasBancoProv(curPD, valoresDefecto, datosAsiento, recibo))
			return false;

		if (!this.iface.generarPartidasCambioProv(curPD, valoresDefecto, datosAsiento, recibo))
			return false;
	} else {
		/** \D En el caso de dar una devoluci�n, las subcuentas del asiento contable ser�n las inversas al asiento contable correspondiente al �ltimo pago
		\end */
		var idAsientoPago:Number = util.sqlSelect("pagosdevolprov", "idasiento", "idrecibo = " + curPD.valueBuffer("idrecibo") + " AND  tipo = 'Pago' ORDER BY fecha DESC");
		var codRecibo:String = util.sqlSelect("recibosprov", "codigo", "idrecibo = " + curPD.valueBuffer("idrecibo"));
		if (this.iface.generarAsientoInverso(datosAsiento.idasiento, idAsientoPago, curPD.valueBuffer("tipo") + " recibo " + codRecibo, valoresDefecto.codejercicio) == false)
			return false;
	}

	curPD.setValueBuffer("idasiento", datosAsiento.idasiento);

	if (!flcontppal.iface.pub_comprobarAsiento(datosAsiento.idasiento))
		return false;

	return true;
}

/** \D Genera la partida correspondiente al proveedor del asiento de pago
@param	curPD: Cursor del pago o devoluci�n
@param	valoresDefecto: Array de valores por defecto (ejercicio, divisa, etc.)
@param	datosAsiento: Array con los datos del asiento
@param	recibo: Array con los datos del recibo asociado al pago
@return	true si la generaci�n es correcta, false en caso contrario
\end */
function proveed_generarPartidasProv(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean
{
	var util:FLUtil = new FLUtil();
	var ctaDebe:Array = [];
	var codEjercicioFac:String;

	/** \C La cuenta del debe del asiento de pago ser� la misma cuenta de tipo PROVEE que se us� para realizar el asiento de la correspondiente factura
	\end */
	var idAsientoFactura:Number = util.sqlSelect("recibosprov r INNER JOIN facturasprov f" + " ON r.idfactura = f.idfactura", "f.idasiento", "r.idrecibo = " + curPD.valueBuffer("idrecibo"), "facturasprov,recibosprov");
	if (!idAsientoFactura) {
		codEjercicioFac = false;
	} else {
		codEjercicioFac = util.sqlSelect("co_asientos", "codejercicio", "idasiento = " + idAsientoFactura);
	}
	if (codEjercicioFac == valoresDefecto.codejercicio) {
		ctaDebe.codsubcuenta = util.sqlSelect("co_partidas p" + " INNER JOIN co_subcuentas s ON p.idsubcuenta = s.idsubcuenta" + " INNER JOIN co_cuentas c ON c.idcuenta = s.idcuenta", "s.codsubcuenta", "p.idasiento = " + idAsientoFactura + " AND c.idcuentaesp = 'PROVEE'", "co_partidas,co_subcuentas,co_cuentas");
	
		if (!ctaDebe.codsubcuenta) {
			MessageBox.warning(util.translate("scripts", "No se ha encontrado la subcuenta de proveedor del asiento contable correspondiente a la factura a pagar"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
	} else {
		var codProveedor:String = util.sqlSelect("recibosprov", "codproveedor", "idrecibo = " + curPD.valueBuffer("idrecibo"));
		if (codProveedor && codProveedor != "") {
			ctaDebe.codsubcuenta = util.sqlSelect("co_subcuentasprov", "codsubcuenta", "codproveedor = '" + codProveedor + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
			if (!ctaDebe.codsubcuenta) {
				MessageBox.warning(util.translate("scripts", "El proveedor %1 no tiene definida ninguna subcuenta en el ejercicio %2.\nEspecifique la subcuenta en la pesta�a de contabilidad del formulario de proveedores").arg(codProveedor).arg(valoresDefecto.codejercicio), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}
		} else {
			ctaDebe = flfacturac.iface.pub_datosCtaEspecial("PROVEE", valoresDefecto.codejercicio);
			if (!ctaDebe.codsubcuenta) {
				MessageBox.warning(util.translate("scripts", "No tiene definida ninguna cuenta de tipo PROVEE.\nDebe crear este tipo especial y asociarlo a una cuenta\nen el m�dulo principal de contabilidad"), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}
		}
	}

	ctaDebe.idsubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + ctaDebe.codsubcuenta +  "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
	if (!ctaDebe.idsubcuenta) {
		MessageBox.warning(util.translate("scripts", "No existe la subcuenta ")  + ctaDebe.codsubcuenta + util.translate("scripts", " correspondiente al ejercicio ") + valoresDefecto.codejercicio + util.translate("scripts", ".\nPara poder realizar el pago debe crear antes esta subcuenta"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

	var debe:Number = 0;
	var debeME:Number = 0;
	var tasaconvDebe:Number = 1;
	
	if (valoresDefecto.coddivisa == recibo.coddivisa) {
		debe = parseFloat(recibo.importe);
		debeME = 0;
	} else {
		tasaconvDebe = util.sqlSelect("recibosprov r INNER JOIN facturasprov f ON r.idfactura = f.idfactura ", "tasaconv", "idrecibo = " + curPD.valueBuffer("idrecibo"), "recibosprov,facturasprov");
		debe = parseFloat(recibo.importeeuros);
		debeME = parseFloat(recibo.importe);
	}

	debe = util.roundFieldValue(debe, "co_partidas", "debe");
	debeME = util.roundFieldValue(debeME, "co_partidas", "debeme");


	var esAbono:Boolean = flfacturac.iface.pub_esNotaCredito(util.sqlSelect("recibosprov r INNER JOIN facturasprov f ON r.idfactura = f.idfactura", "tipoventa", "idrecibo = " + curPD.valueBuffer("idrecibo"), "recibosprov,facturasprov"));

	var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
	with(curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		try {
			setValueBuffer("concepto", datosAsiento.concepto);
		} catch (e) {
			setValueBuffer("concepto", curPD.valueBuffer("tipo") + " recibo prov. " + recibo.codigo + " - " + recibo.nombreproveedor);
		}
		setValueBuffer("idsubcuenta", ctaDebe.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaDebe.codsubcuenta);
		setValueBuffer("idasiento", datosAsiento.idasiento);
		if (esAbono) {
			setValueBuffer("debe", 0);
			setValueBuffer("haber", debe * -1);
		} else {
			setValueBuffer("debe", debe);
			setValueBuffer("haber", 0);
		}
		setValueBuffer("coddivisa", recibo.coddivisa);
		setValueBuffer("tasaconv", tasaconvDebe);
		setValueBuffer("debeME", debeME);
		setValueBuffer("haberME", 0);
	}
	if (!curPartida.commitBuffer())
		return false;

	return true;
}

function proveed_generarPartidasBancoProv(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean
{
	var util:FLUtil = new FLUtil();
	var ctaHaber:Array = [];
	
	ctaHaber.codsubcuenta = curPD.valueBuffer("codsubcuenta");
	ctaHaber.idsubcuenta = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + ctaHaber.codsubcuenta + "' AND codejercicio = '" + valoresDefecto.codejercicio + "'");
	if (!ctaHaber.idsubcuenta) {
		MessageBox.warning(util.translate("scripts", "No tiene definida la subcuenta %1 en el ejercicio %2.\nAntes de dar el pago debe crear la subcuenta o modificar el ejercicio").arg(ctaHaber.codsubcuenta).arg(valoresDefecto.codejercicio), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
		
	var haber:Number = 0;
	var haberME:Number = 0;
	var tasaconvHaber:Number = 1;

	if (valoresDefecto.coddivisa == recibo.coddivisa) {
		haber = parseFloat(recibo.importe);
		haberMe = 0;
	} else {
		tasaconvHaber = curPD.valueBuffer("tasaconv");
		haber = parseFloat(recibo.importe) * parseFloat(tasaconvHaber);
		haberME = parseFloat(recibo.importe);
	}
	haber = util.roundFieldValue(haber, "co_partidas", "haber");
	haberME = util.roundFieldValue(haberME, "co_partidas", "haberme");

	var esAbono:Boolean = flfacturac.iface.pub_esNotaCredito(util.sqlSelect("recibosprov r INNER JOIN facturasprov f ON r.idfactura = f.idfactura", "tipoventa", "idrecibo = " + curPD.valueBuffer("idrecibo"), "recibosprov,facturasprov"));
	
	var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
	with(curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		try {
			setValueBuffer("concepto", datosAsiento.concepto);
		} catch (e) {
			setValueBuffer("concepto", curPD.valueBuffer("tipo") + " recibo prov. " + recibo.codigo + " - " + recibo.nombreproveedor);
		}
		setValueBuffer("idsubcuenta", ctaHaber.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaHaber.codsubcuenta);
		setValueBuffer("idasiento", datosAsiento.idasiento);
		if (esAbono) {
			setValueBuffer("debe", haber * -1);
			setValueBuffer("haber", 0);
		} else {
			setValueBuffer("debe", 0);
			setValueBuffer("haber", haber);
		}
		setValueBuffer("coddivisa", recibo.coddivisa);
		setValueBuffer("tasaconv", tasaconvHaber);
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", haberME);
	}
	if (!curPartida.commitBuffer())
		return false;

	return true;
}

/** \D Genera, si es necesario, la partida de diferecias positivas o negativas de cambio
@param	curPD: Cursor del pago o devoluci�n
@param	valoresDefecto: Array de valores por defecto (ejercicio, divisa, etc.)
@param	datosAsiento: Array con los datos del asiento
@param	recibo: Array con los datos del recibo asociado al pago
@return	true si la generaci�n es correcta, false en caso contrario
\end */
function proveed_generarPartidasCambioProv(curPD:FLSqlCursor, valoresDefecto:Array, datosAsiento:Array, recibo:Array):Boolean
{
	/** \C En el caso de que la divisa sea extranjera y la tasa de cambio haya variado desde el momento de la emisi�n de la factura, la diferencia se imputar� a la correspondiente cuenta de diferencias de cambio.
	\end */
	if (valoresDefecto.coddivisa == recibo.coddivisa)
		return true;

	var util:FLUtil = new FLUtil();
	var debe:Number = 0;
	var haber:Number = 0;
	var tasaconvDebe:Number = 1;
	var tasaconvHaber:Number = 1;
	var diferenciaCambio:Number = 0;
		
		
	tasaconvHaber = curPD.valueBuffer("tasaconv");
	tasaconvDebe = util.sqlSelect("recibosprov r INNER JOIN facturasprov f ON r.idfactura = f.idfactura ", "tasaconv", "idrecibo = " + curPD.valueBuffer("idrecibo"), "recibosprov,facturasprov");
	haber = parseFloat(recibo.importe) * parseFloat(tasaconvHaber);
	haber = util.roundFieldValue(haber, "co_partidas", "haber");

	debe = parseFloat(recibo.importeeuros);
	debe = util.roundFieldValue(debe, "co_partidas", "debe");
	diferenciaCambio = debe - haber;
	if (util.buildNumber(diferenciaCambio, "f", 2) == "0.00" || util.buildNumber(diferenciaCambio, "f", 2) == "-0.00") {
		diferenciaCambio = 0;
		return true;
	}
	diferenciaCambio = util.roundFieldValue(diferenciaCambio, "co_partidas", "haber");

	var ctaDifCambio:Array = [];
	var debeDifCambio:Number = 0;
	var haberDifCambio:Number = 0;
	if (diferenciaCambio > 0) {
		ctaDifCambio = flfacturac.iface.pub_datosCtaEspecial("CAMPOS", valoresDefecto.codejercicio);
		if (ctaDifCambio.error != 0)
			return false;
		debeDifCambio = 0;
		haberDifCambio = diferenciaCambio;
	} else {
		ctaDifCambio = flfacturac.iface.pub_datosCtaEspecial("CAMNEG", valoresDefecto.codejercicio);
		if (ctaDifCambio.error != 0)
			return false;
		diferenciaCambio = 0 - diferenciaCambio;
		debeDifCambio = diferenciaCambio;
		haberDifCambio = 0;
	}

	/// Esto lo usan algunas extensiones
	if (curPD.valueBuffer("tipo") == "Devoluci�n") {
		var aux:Number = debeDifCambio;
		debeDifCambio = haberDifCambio;
		haberDifCambio = aux;
	}

	var curPartida:FLSqlCursor = new FLSqlCursor("co_partidas");
	with(curPartida) {
		setModeAccess(curPartida.Insert);
		refreshBuffer();
		try {
			setValueBuffer("concepto", datosAsiento.concepto);
		} catch (e) {
			setValueBuffer("concepto", curPD.valueBuffer("tipo") + " recibo prov. " + recibo.codigo + " - " + recibo.nombreproveedor);
		}
		setValueBuffer("idsubcuenta", ctaDifCambio.idsubcuenta);
		setValueBuffer("codsubcuenta", ctaDifCambio.codsubcuenta);
		setValueBuffer("idasiento", datosAsiento.idasiento);
		setValueBuffer("debe", debeDifCambio);
		setValueBuffer("haber", haberDifCambio);
		setValueBuffer("coddivisa", valoresDefecto.coddivisa);
		setValueBuffer("tasaconv", 1);
		setValueBuffer("debeME", 0);
		setValueBuffer("haberME", 0);
	}
	if (!curPartida.commitBuffer())
		return false;

	return true;
}

/** \D Calcula la fecha de vencimiento de un recibo de proveedor, como la fecha de facturaci�n m�s los d�as del plazo correspondiente
@param curFactura: Cursor posicionado en el registro de facturas correspondiente a la factura
@param numPlazo: N�mero del plazo actual
@param diasAplazado: D�as de aplazamiento del pago
@return Fecha de vencimiento
\end */
function proveed_calcFechaVencimientoProv(curFactura:FLSqlCursor, numPlazo:Number, diasAplazado:Number):String
{
	var util:FLUtil = new FLUtil; 
	return util.addDays(curFactura.valueBuffer("fecha"), diasAplazado);
}

/* \D Funci�n para sobrecargar. Sirve para a�adir al cursor del recibo los datos que a�ada la extensi�n
\end */
function proveed_datosReciboProv():Boolean
{
	return true;
}

/** \D Cambia la el estado del �ltimo pago anterior al especificado, de forma que se mantenga como �nico pago editable el �ltimo de todos
@param	idRecibo: Identificador del recibo al que pertenecen los pagos tratados
@param	idPagoDevol: Identificador del pago que ha cambiado
@param	unlock: Indicador de si el �ltim pago debe ser editable o no
@return	true si la verificaci�n del estado es correcta, false en caso contrario
\end */
function proveed_cambiaUltimoPagoProv(idRecibo:String, idPagoDevol:String, unlock:Boolean):Boolean
{
	var curPagosDevol:FLSqlCursor = new FLSqlCursor("pagosdevolprov");
	curPagosDevol.select("idrecibo = " + idRecibo + " AND idpagodevol <> " + idPagoDevol + " ORDER BY fecha, idpagodevol");
	if (curPagosDevol.last())
		curPagosDevol.setUnLock("editable", unlock);
	
	return true;
}

/** \D Cambia la factura relacionada con un recibo a editable o no editable en funci�n de si tiene pagos asociados o no
@param	idRecibo: Identificador de un recibo asociado a la factura
@param	idFactura: Identificador de la factura
@return	true si la verificaci�n del estado es correcta, false en caso contrario
\end */
function proveed_calcularEstadoFacturaProv(idRecibo:String, idFactura:String):Boolean
{
	var util:FLUtil = new FLUtil();
	if (!idFactura)
		idFactura = util.sqlSelect("recibosprov", "idfactura", "idrecibo = " + idRecibo);

	var qryPagos:FLSqlQuery = new FLSqlQuery();
	qryPagos.setTablesList("recibosprov,pagosdevolprov");
	qryPagos.setSelect("p.idpagodevol");
	qryPagos.setFrom("recibosprov r INNER JOIN pagosdevolprov p ON r.idrecibo = p.idrecibo");
	qryPagos.setWhere("r.idfactura = " + idFactura);
	try { qryPagos.setForwardOnly( true ); } catch (e) {}
	if (!qryPagos.exec())
		return false;

	var curFactura:FLSqlCursor = new FLSqlCursor("facturasprov");
	curFactura.select("idfactura = " + idFactura);
	curFactura.first();
	if (qryPagos.size() == 0)
		curFactura.setUnLock("editable", true);
	else
		curFactura.setUnLock("editable", false);
	return true
}

/* \D Borra los recibos asociados a una factura.

@param idFactura: Identificador de la factura de la que provienen los recibos
@return False si hay error o si el recibo no se puede borrar, true si los recibos se borran correctamente
\end */
function proveed_borrarRecibosProv(idFactura:Number):Boolean
{
	var curRecibos = new FLSqlCursor("recibosprov");
	curRecibos.select("idfactura = " + idFactura);
	while (curRecibos.next()) {
		curRecibos.setModeAccess(curRecibos.Browse);
		curRecibos.refreshBuffer();
		if (this.iface.tienePagosDevProv(curRecibos.valueBuffer("idrecibo"))) {
			return false;
		}
	}
	curRecibos.select("idfactura = " + idFactura);
	while (curRecibos.next()) {
		curRecibos.setModeAccess(curRecibos.Del);
		curRecibos.refreshBuffer();
		if (!curRecibos.commitBuffer())
			return false;
	}
	return true;
}

/** Para sobrecargar en extensiones
*/
function proveed_codCuentaPagoProv(curFactura:FLSqlCursor):String 
{
	return "";
}

function provee_siGenerarRecibosProv(curFactura:FLSqlCursor, masCampos:Array):Boolean 
{
 	var camposAcomprobar = new Array("codproveedor","total","codpago","fecha");
	
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

//// PROVEED ////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
/** @class_definition infoVencimtos */
/////////////////////////////////////////////////////////////////
//// INFO VENCIMIENTOS //////////////////////////////////////////
/** \D Informa la cuenta de pago como la cuenta de remesas del cliente
\end */
function infoVencimtos_datosReciboCli():Boolean
{
	var util:FLUtil = new FLUtil;
	if (!this.iface.__datosReciboCli())
		return false;
	var codCliente:String = this.iface.curReciboCli.valueBuffer("codcliente");
	if (!codCliente)
		return true;
	this.iface.curReciboCli.setValueBuffer("codcuentapago", util.sqlSelect("clientes", "codcuentarem", "codcliente = '" + codCliente + "'"));
	
	return true;
}

/** \D Informa la cuenta de pago como la cuenta de pago del proveedor
\end */
function infoVencimtos_datosReciboProv():Boolean
{
	var util:FLUtil = new FLUtil;
	if (!this.iface.__datosReciboProv())
		return false;
	var codProveedor:String = this.iface.curReciboProv.valueBuffer("codproveedor");
	if (!codProveedor)
		return true;
	this.iface.curReciboProv.setValueBuffer("codcuentapago", util.sqlSelect("proveedores", "codcuentapago", "codproveedor = '" + codProveedor + "'"));
	
	return true;
}

//// INFO VENCIMIENTOS //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition pagosMultiples */
//////////////////////////////////////////////////////////////////
//// PAGOS MULTIPLES /////////////////////////////////////////////

function pagosMultiples_beforeCommit_pagosmulticli(curPagoMulti:FLSqlCursor):Boolean
{
	switch (curPagoMulti.modeAccess()) {
		/** \C El Pago m�ltiple puede borrarse si todos los pagos asociados pueden ser excluidos
		\end */
		case curPagoMulti.Del: {
			var idPagoMulti:Number = curPagoMulti.valueBuffer("idpagomulti");
			var qryRecibos:FLSqlQuery = new FLSqlQuery;
			qryRecibos.setTablesList("pagosdevolcli");
			qryRecibos.setSelect("DISTINCT(idrecibo)");
			qryRecibos.setFrom("pagosdevolcli");
			qryRecibos.setWhere("idpagomulti = " + idPagoMulti);
			if (!qryRecibos.exec())
				return false;
			while (qryRecibos.next()) {
				if (!formRecordpagosmulticli.iface.pub_excluirReciboPagoMulti(qryRecibos.value(0), idPagoMulti))
					return false;
			}
		}
	}
	return true;
}

function pagosMultiples_beforeCommit_pagosmultiprov(curPagoMulti:FLSqlCursor):Boolean
{
	switch (curPagoMulti.modeAccess()) {
		/** \C El Pago m�ltiple puede borrarse si todos los pagos asociados pueden ser excluidos
		\end */
		case curPagoMulti.Del: {
			var idPagoMulti:Number = curPagoMulti.valueBuffer("idpagomulti");
			var qryRecibos:FLSqlQuery = new FLSqlQuery;
			qryRecibos.setTablesList("pagosdevolprov");
			qryRecibos.setSelect("DISTINCT(idrecibo)");
			qryRecibos.setFrom("pagosdevolprov");
			qryRecibos.setWhere("idpagomulti = " + idPagoMulti);
			if (!qryRecibos.exec())
				return false;
			while (qryRecibos.next()) {
				if (!formRecordpagosmultiprov.iface.pub_excluirReciboPagoMulti(qryRecibos.value(0), idPagoMulti))
					return false;
			}
		}
	}
	return true;
}

function pagosMultiples_borrarRecibosCli(idFactura:Number):Boolean
{
	var curRecibos:FLSqlCursor = new FLSqlCursor("reciboscli");
	curRecibos.select("idfactura = " + idFactura);
	while (curRecibos.next()) {
		curRecibos.setModeAccess(curRecibos.Browse);
		curRecibos.refreshBuffer();
		if (curRecibos.valueBuffer("idpagomulti") != 0) {
			return false;
		}
	}
	return this.iface.__borrarRecibosCli(idFactura);
}

function pagosMultiples_borrarRecibosProv(idFactura:Number):Boolean
{
	var curRecibos:FLSqlCursor = new FLSqlCursor("recibosprov");
	curRecibos.select("idfactura = " + idFactura);
	while (curRecibos.next()) {
		curRecibos.setModeAccess(curRecibos.Browse);
		curRecibos.refreshBuffer();
		if (curRecibos.valueBuffer("idpagomulti") != 0) {
			return false;
		}
	}
	return this.iface.__borrarRecibosProv(idFactura);
}

//// PAGOS MULTIPLES /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ctasCtes */
//////////////////////////////////////////////////////////////////
//// CTASCTES ////////////////////////////////////////////////////

/** \D Actualiza el valor del riesgo alcanzado para un cliente.
@param codCliente: C�digo del cliente
\end */
function ctasCtes_actualizarRiesgoCliente(codCliente:String)
{
	var util:FLUtil = new FLUtil();
	var riesgo:Number = parseFloat( util.sqlSelect( "reciboscli", "SUM(importeeuros)", "estado <> 'Pagado' AND codcliente='" + codCliente + "'" ) );
	if (!riesgo || isNaN(riesgo))
		riesgo = 0;

	util.sqlUpdate( "clientes", "riesgoalcanzado", riesgo, "codcliente = '" + codCliente + "'" );

	if ( !flfactteso.iface.pub_automataActivado() ) {
		var riesgoMax:Number = parseFloat( util.sqlSelect( "clientes", "riesgomax", "codcliente = '" + codCliente + "'" ) );
		if ( riesgo >= riesgoMax && riesgoMax > 0 ) {
			if ( util.sqlSelect( "clientes", "cuentactiva", "codcliente = '" + codCliente + "'" ) ) {
				MessageBox.warning(util.translate("scripts", "El cliente %0 ha superado el riesgo m�ximo.\nSu Cuenta Corriente ser� deshabilitada.").arg(codCliente), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				util.sqlUpdate( "clientes", "cuentactiva", false, "codcliente = '" + codCliente + "'" );
			}
		}
	}
}

/** \D Actualiza el valor del riesgo alcanzado para un proveedor.
@param codProveedor: C�digo del proveedor
\end */
function ctasCtes_actualizarRiesgoProveedor(codProveedor:String)
{
	var util:FLUtil = new FLUtil();
	var riesgo:Number = parseFloat( util.sqlSelect( "recibosprov", "SUM(importeeuros)", "estado <> 'Pagado' AND codproveedor = '" + codProveedor + "'" ) );
	if (!riesgo || isNaN(riesgo))
		riesgo = 0;

	util.sqlUpdate( "proveedores", "riesgoalcanzado", riesgo, "codproveedor = '" + codProveedor + "'" );
}

/** \C Se recalcula el riesgo alcanzado
\end */
function ctasCtes_afterCommit_recibosprov(curR:FLSqlCursor):Boolean
{
	if (curR.valueBuffer("codproveedor"))
		this.iface.actualizarRiesgoProveedor(curR.valueBuffer("codproveedor"));
	
	return true;
}

function ctasCtes_cuentaActiva(curDoc:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	var emitirComo:String = util.sqlSelect("formaspago", "genrecibos", "codpago = '" + curDoc.valueBuffer("codpago") + "'");
	if (emitirComo != "Emitidos")
		return true;

	var codCliente:String = curDoc.valueBuffer("codcliente");
	if (!codCliente || codCliente == "")
		return true;

	var qryCliente:FLSqlQuery = new FLSqlQuery;
	qryCliente.setTablesList("clientes");
	qryCliente.setSelect("cuentactiva, riesgomax, margencuenta, riesgoalcanzado");
	qryCliente.setFrom("clientes");
	qryCliente.setWhere("codcliente = '" + codCliente + "'");
	if (!qryCliente.exec() || !qryCliente.first())
		return false;

	/* Comprueba que el cliente tenga la Cuenta Corriente Activa */
	var cuentaActiva:Boolean = qryCliente.value("cuentactiva");

	if (!cuentaActiva) {
		MessageBox.warning(util.translate("scripts", "El cliente no tiene permiso para utilizar su Cuenta Corriente"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	/* Comprueba que el riesgo a alcanzar no supere el m�ximo permitido m�s el margen */
	var riesgoMaximo:Number = parseFloat(qryCliente.value("riesgomax"));
	var margenCuentaCte:Number = parseFloat(qryCliente.value("margencuenta"));
	var montoMaximo:Number = riesgoMaximo * (1 + margenCuentaCte/100);

	var riesgoAlcanzado:Number = parseFloat(qryCliente.value("riesgoalcanzado"));
	var monto:Number = curDoc.valueBuffer("total");

	if ((riesgoAlcanzado + monto) > montoMaximo) {
		MessageBox.warning(util.translate("scripts", "La venta supera el margen permitido para la Cuenta Corriente del cliente.\nNo puede realizar esta venta."), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	return true;
}

//// CTASCTES ////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition controlUsuario */
/////////////////////////////////////////////////////////////////
//// CONTROL_USUARIO ////////////////////////////////////////////

function controlUsuario_beforeCommit_pagosmulticli(curPagoMulti:FLSqlCursor):Boolean
{
	switch (curPagoMulti.modeAccess()) {
		case curPagoMulti.Insert: {
			if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
				flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Pagos m�ltiples");
				return false;
			} else {
				curPagoMulti.setValueBuffer( "idusuario", sys.nameUser() );
			}
			break;
		}
		break;
	}

	return this.iface.__beforeCommit_pagosmulticli(curPagoMulti);
}

function controlUsuario_beforeCommit_pagosmultiprov(curPagoMulti:FLSqlCursor):Boolean
{
	switch (curPagoMulti.modeAccess()) {
		case curPagoMulti.Insert: {
			if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
				flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Pagos m�ltiples");
				return false;
			} else {
				curPagoMulti.setValueBuffer( "idusuario", sys.nameUser() );
			}
			break;
		}
		break;
	}

	return this.iface.__beforeCommit_pagosmultiprov(curPagoMulti);
}

//// CONTROL_USUARIO //////////////////////////////////////////
///////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////