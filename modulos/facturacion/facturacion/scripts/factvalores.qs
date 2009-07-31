/***************************************************************************
                 factvalores.qs  -  description
                             -------------------
    begin                : lun may 25 2009
    copyright            : Silix
    email                : contacto@silix.com.ar
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

	function interna( context ) {
		this.ctx = context;
	}
	function init() {
		this.ctx.interna_init();
	}
	function validateForm():Boolean {
		return this.ctx.interna_validateForm();
	}
	function calculateField( fN:String ):String { return this.ctx.interna_calculateField( fN ); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var tabsTiposValores:Object;
	function oficial( context ) { interna( context ); } 
	function bufferChanged(fN:String) { return this.ctx.oficial_bufferChanged(fN); }
	function verificarHabilitaciones() { return this.ctx.oficial_verificarHabilitaciones(); }
	function seleccionEfectivo() { this.ctx.oficial_seleccionEfectivo(); }
	function seleccionCheque() { this.ctx.oficial_seleccionCheque(); }
	function seleccionChequePropio() { this.ctx.oficial_seleccionChequePropio(); }
	function seleccionTarjeta() { this.ctx.oficial_seleccionTarjeta(); }
	function seleccionRetencion() { this.ctx.oficial_seleccionRetencion(); }
	function actualizarTabs(tab:String) { this.ctx.oficial_actualizarTabs(tab); }
	function datosSucursal() { this.ctx.oficial_datosSucursal(); }
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial {
    function head( context ) { oficial ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
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
function interna_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	this.iface.tabsTiposValores = this.child("tabsTiposValores");

	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.child("btnEfectivo"), "clicked()", this, "iface.seleccionEfectivo");
	connect(this.child("btnCheque"), "clicked()", this, "iface.seleccionCheque");
	connect(this.child("btnChequePropio"), "clicked()", this, "iface.seleccionChequePropio");
	connect(this.child("btnTarjeta"), "clicked()", this, "iface.seleccionTarjeta");
	connect(this.child("btnRetencion"), "clicked()", this, "iface.seleccionRetencion");

	if (cursor.modeAccess() == cursor.Insert) {
		var hoy:Date = new Date();
		this.child("fdbFechaCheque").setValue(hoy);
		cursor.setValueBuffer("coddivisa", flfactppal.iface.pub_valorDefectoEmpresa("coddivisa"));
		this.child("btnEfectivo").setOn(true);
		this.iface.seleccionEfectivo();
	}
	else {
		this.iface.datosSucursal();
		this.child("btnEfectivo").setDisabled(true);
		this.child("btnCheque").setDisabled(true);
		this.child("btnChequePropio").setDisabled(true);
		this.child("btnTarjeta").setDisabled(true);
		this.child("btnRetencion").setDisabled(true);
		switch (cursor.valueBuffer("tipovalor")) {
			case "Efectivo": {
				this.child("btnEfectivo").setDisabled(false);
				this.child("btnEfectivo").setOn(true);
				this.child("fdbMonto").setFocus();
				break;
			}
			case "Cheque": {
				this.child("btnCheque").setDisabled(false);
				this.child("btnCheque").setOn(true);
				this.child("fdbMonto").setFocus();
				break;
			}
			case "Cheque propio": {
				this.child("btnChequePropio").setDisabled(false);
				this.child("btnChequePropio").setOn(true);
				this.child("fdbCuenta").setFocus();
				break;
			}
			case "Tarjeta": {
				this.child("btnTarjeta").setDisabled(false);
				this.child("btnTarjeta").setOn(true);
				this.child("fdbTarjeta").setFocus();
				break;
			}
			case "Retención": {
				this.child("btnRetencion").setDisabled(false);
				this.child("btnRetencion").setOn(true);
				this.child("fdbCodTipoRetencion").setFocus();
				break;
			}
		}
	}

	this.iface.verificarHabilitaciones();
	this.iface.actualizarTabs(cursor.valueBuffer("tipovalor"));
}

function interna_validateForm():Boolean
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	// si no se define la fecha (en valores como Efectivo), cargar la fecha del documento
	if (cursor.isNull("fecha"))
		cursor.setValueBuffer("fecha", cursor.cursorRelation().valueBuffer("fecha"));

	/** \C
	El pago debe producir un total inferior o igual al total de la factura
	*/
	var totalFactura:Number = parseFloat(cursor.cursorRelation().valueBuffer("total"));
	var totalPagos:Number = parseFloat(util.sqlSelect("factvalores", "SUM(monto)", "idfactura = " + cursor.valueBuffer("idfactura") + " AND codvalor <> " + cursor.valueBuffer("codvalor")));
	var diferencia:Number = util.roundFieldValue((totalFactura - totalPagos), "factvalores", "monto");
	if ( diferencia < util.roundFieldValue(parseFloat(cursor.valueBuffer("monto")), "factvalores", "monto") ) {
		MessageBox.warning(util.translate("scripts", "El monto del pago hace que la suma de pagos sea superior al monto de la venta"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	if (cursor.valueBuffer("tipovalor") == "Cheque" || cursor.valueBuffer("tipovalor") == "Cheque propio") {
		if (cursor.valueBuffer("pagodiferido") == true) {
			if (util.daysTo(cursor.valueBuffer("fecha"), cursor.valueBuffer("fechavencimiento")) < 1 ) {
				MessageBox.warning(util.translate("scripts", "La fecha de vencimiento del cheque debe ser posterior a la fecha de emisión"), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}
		}
	}

	return true;
}

function interna_calculateField( fN ):String
{
	var util:FLUtil = new FLUtil();
	var result:String;
	var cursor:FLSqlCursor = this.cursor();

	switch(fN) {
		case "ledCantCuotas": {
			var cantCuotas:Number = util.sqlSelect("ctas_planestarjeta", "cantidadcuotas", "codplan = '" + cursor.valueBuffer("codplan") + "'");
			if (isNaN(cantCuotas) || !cantCuotas)
				cantCuotas = 0;
			result = cantCuotas;
			break;
		}
		case "ledCoefRecargo": {
			var coefRecargo:Number = util.sqlSelect("ctas_planestarjeta", "coeficiente", "codplan = '" + cursor.valueBuffer("codplan") + "'");
			if (isNaN(coefRecargo) || !coefRecargo)
				coefRecargo = 0;
			result = coefRecargo;
			break;
		}
	}
	return result;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_bufferChanged(fN:String)
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	switch (fN) {
		case "tipovalor": {
			this.iface.actualizarTabs(cursor.valueBuffer("tipovalor"));
			break;
		}
		case "pagodiferido": {
			this.iface.verificarHabilitaciones();
			break;
		}
		case "codcuenta": {
			if (cursor.valueBuffer("tipovalor") == "Cheque propio") {
				var entidad:String = util.sqlSelect("cuentasbanco", "entidad", "codcuenta = '" + cursor.valueBuffer("codcuenta") + "'");
				var agencia:String = util.sqlSelect("cuentasbanco", "agencia", "codcuenta = '" + cursor.valueBuffer("codcuenta") + "'");
				var codigopostal:String = util.sqlSelect("sucursales", "codpostal", "agencia = '" + agencia + "'");
				var numerocuenta:String = util.sqlSelect("cuentasbanco", "cuenta", "codcuenta = '" + cursor.valueBuffer("codcuenta") + "'");

				cursor.setValueBuffer("entidad", entidad);
				cursor.setValueBuffer("agencia", agencia);
				cursor.setValueBuffer("codigopostal", codigopostal);
				cursor.setValueBuffer("numerocuenta", numerocuenta);
				// Filtrar las chequeras de la cuenta especificada
				this.child("fdbCodChequera").setFilter("codcuenta = '" + cursor.valueBuffer("codcuenta") + "' AND (debaja = false OR fechabaja > '" + cursor.valueBuffer("fecha") + "')");
			}
			break;
		}
		case "codchequera": {
			if (cursor.valueBuffer("tipovalor") == "Cheque propio") {
				var qryChequera:FLSqlQuery = new FLSqlQuery;
				qryChequera.setTablesList("ctas_chequeras");
				qryChequera.setSelect("siguientecheque, coddivisa, pagodiferido, hasta");
				qryChequera.setFrom("ctas_chequeras");
				qryChequera.setWhere("codchequera = '" + cursor.valueBuffer("codchequera") + "'");
				if (!qryChequera.exec())
					break;
				if (qryChequera.first()) {
					var hasta:Number = parseInt(qryChequera.value("hasta"), 10);
					var numero:Number = qryChequera.value("siguientecheque");
					if (numero > hasta) {
						MessageBox.warning(util.translate("scripts", "Según los registros, ya se emitió el último cheque de esta chequera.\nVerifique la chequera que está utilizando, y dela de baja si corresponde"), MessageBox.Ok, MessageBox.NoButton);
						cursor.setNull("codchequera");
						break;
					}
					var numerocheque:String = numero.toString();
					util.sqlUpdate("ctas_chequeras", "siguientecheque", numero + 1, "codchequera = '" + cursor.valueBuffer("codchequera") + "'");
					cursor.setValueBuffer("numerocheque", flfactppal.iface.pub_cerosIzquierda(numerocheque, 8));
					cursor.setValueBuffer("coddivisa", qryChequera.value("coddivisa"));
					cursor.setValueBuffer("pagodiferido", qryChequera.value("pagodiferido"));

					if ( numero == hasta) {
						MessageBox.information(util.translate("scripts", "Según los registros, este es el último cheque de esta chequera.\nRecuerde dar de baja la chequera si corresponde."), MessageBox.Ok, MessageBox.NoButton);
					}
				}
			}
			break;
		}
		case "codplan": {
			if (cursor.valueBuffer("tipovalor") == "Tarjeta") {
				this.child("ledCantCuotas").text = this.iface.calculateField("ledCantCuotas");
				this.child("ledCoefRecargo").text = this.iface.calculateField("ledCoefRecargo");
			}
			break;
		}
		case "agencia": {
			this.iface.datosSucursal();
			break;
		}
	}
}

function oficial_verificarHabilitaciones()
{
	if (!this.cursor().valueBuffer("pagodiferido")) {
		this.child("fdbVencimiento").setDisabled(true);
		this.child("fdbVencimientoPropio").setDisabled(true);
	}
	else {
		this.child("fdbVencimiento").setDisabled(false);
		this.child("fdbVencimientoPropio").setDisabled(false);
	}
}

function oficial_seleccionEfectivo() {
	this.cursor().setValueBuffer("tipovalor", "Efectivo");
}

function oficial_seleccionCheque() {
	this.cursor().setValueBuffer("tipovalor", "Cheque");
}

function oficial_seleccionChequePropio() {
	this.cursor().setValueBuffer("tipovalor", "Cheque propio");
}

function oficial_seleccionTarjeta() {
	this.cursor().setValueBuffer("tipovalor", "Tarjeta");
}

function oficial_seleccionRetencion() {
	this.cursor().setValueBuffer("tipovalor", "Retención");
}

function oficial_actualizarTabs(tab:String)
{
	this.iface.tabsTiposValores.setTabEnabled("tabEfectivo", false);
	this.iface.tabsTiposValores.setTabEnabled("tabCheque", false);
	this.iface.tabsTiposValores.setTabEnabled("tabChequePropio", false);
	this.iface.tabsTiposValores.setTabEnabled("tabTarjeta", false);
	this.iface.tabsTiposValores.setTabEnabled("tabRetencion", false);

	switch (tab) {
		case "Efectivo": {
			this.iface.tabsTiposValores.setTabEnabled("tabEfectivo", true);
			this.iface.tabsTiposValores.showPage("tabEfectivo");
			this.child("lblTipoValor").text = "EFECTIVO";
			break;
		}
		case "Cheque": {
			this.iface.tabsTiposValores.setTabEnabled("tabCheque", true);
			this.iface.tabsTiposValores.showPage("tabCheque");
			this.child("lblTipoValor").text = "CHEQUE";
			break;
		}
		case "Cheque propio": {
			this.iface.tabsTiposValores.setTabEnabled("tabChequePropio", true);
			this.iface.tabsTiposValores.showPage("tabChequePropio");
			this.child("lblTipoValor").text = "CHEQUE PROPIO";
			break;
		}
		case "Tarjeta": {
			this.iface.tabsTiposValores.setTabEnabled("tabTarjeta", true);
			this.iface.tabsTiposValores.showPage("tabTarjeta");
			this.child("lblTipoValor").text = "TARJETA";
			break;
		}
		case "Retención": {
			this.iface.tabsTiposValores.setTabEnabled("tabRetencion", true);
			this.iface.tabsTiposValores.showPage("tabRetencion");
			this.child("lblTipoValor").text = "RETENCIÓN";
			break;
		}
	}
}

function oficial_datosSucursal() {
	var cursor:FLSqlCursor = this.cursor();
	var qryAgencia:FLSqlQuery = new FLSqlQuery;
	qryAgencia.setTablesList("sucursales");
	qryAgencia.setSelect("nombre, direccion, codpostal");
	qryAgencia.setFrom("sucursales");
	qryAgencia.setWhere("entidad = '" + cursor.valueBuffer("entidad") + "' AND agencia = '" + cursor.valueBuffer("agencia") + "'");
	if (!qryAgencia.exec())
		return;
	if (qryAgencia.first()) {
		this.child("ledSucursal").text = qryAgencia.value("nombre");
	}
	else {
		this.child("ledSucursal").text = "";
	}
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
