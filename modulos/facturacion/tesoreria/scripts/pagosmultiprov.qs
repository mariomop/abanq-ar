/***************************************************************************
                      pagosmultiprov.qs  -  description
                             -------------------
    begin                : lun abr 1 2009
    copyright            : (C) 2009 by Silix
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
    function interna( context ) { this.ctx = context; }
    function init() { this.ctx.interna_init(); }
	function validateForm():Boolean { return this.ctx.interna_validateForm(); }
	function calculateField(fN:String):String { return this.ctx.interna_calculateField(fN); }
	function calculateCounter():Number { return this.ctx.interna_calculateCounter(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
    function oficial( context ) { interna( context ); } 
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration pagosMultiples */
//////////////////////////////////////////////////////////////////
//// PAGOS MULTIPLES /////////////////////////////////////////////
class pagosMultiples extends oficial {
    function pagosMultiples( context ) { oficial ( context ); }
	var ejercicioActual:String;
	var bloqueoSubcuenta:Boolean;
	var contabActivada:Boolean;
	var longSubcuenta:Number;
	var posActualPuntoSubcuenta:Number;
	var tblResAsientos:QTable;
	var curPagosDev:FLSqlCursor;
	var pagoIndirecto_:Boolean;
	var bngTasaCambio:Object;
	var divisaEmpresa:String;

	function actualizarTotal() {
		return this.ctx.pagosMultiples_actualizarTotal();
	}
	function agregarRecibo():Boolean {
		return this.ctx.pagosMultiples_agregarRecibo();
	}
	function eliminarRecibo() {
		return this.ctx.pagosMultiples_eliminarRecibo();
	}
	function bufferChanged(fN:String) {
		return this.ctx.pagosMultiples_bufferChanged(fN);
	}
	function asientoAcumulado() {
		return this.ctx.pagosMultiples_asientoAcumulado();
	}
	function asociarReciboPagoMulti(idRecibo:String, curPagoMulti:FLSqlCursor):Boolean {
		return this.ctx.pagosMultiples_asociarReciboPagoMulti(idRecibo, curPagoMulti);
	}
	function excluirReciboPagoMulti(idRecibo:String, idPagoMulti:String):Boolean {
		return this.ctx.pagosMultiples_excluirReciboPagoMulti(idRecibo, idPagoMulti);
	}
	function datosPagosDev(idRecibo:String, curPagoMulti:FLSqlCursor):Boolean {
		return this.ctx.pagosMultiples_datosPagosDev(idRecibo, curPagoMulti);
	}
	function cambiarEstado() {
		return this.ctx.pagosMultiples_cambiarEstado();
	}
	function filtroRecibosProv():String {
		return this.ctx.pagosMultiples_filtroRecibosProv();
	}
	function habilitarPorRecibos() {
		return this.ctx.pagosMultiples_habilitarPorRecibos();
	}
	function bngTasaCambio_clicked(opcion:Number) {
		return this.ctx.pagosMultiples_bngTasaCambio_clicked(opcion);
	}
}
//// PAGOS MULTIPLES /////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration controlUsuario */
/////////////////////////////////////////////////////////////////
//// CONTROL_USUARIO ////////////////////////////////////////////
class controlUsuario extends pagosMultiples {
    function controlUsuario( context ) { pagosMultiples ( context ); }
	function init() {
		return this.ctx.controlUsuario_init();
	}
}
//// CONTROL_USUARIO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ordenCampos */
/////////////////////////////////////////////////////////////////
//// ORDEN_CAMPOS ///////////////////////////////////////////////
class ordenCampos extends controlUsuario {
    function ordenCampos( context ) { controlUsuario ( context ); }
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
	function pub_asociarReciboPagoMulti(idRecibo:String, curPagoMulti:FLSqlCursor):Boolean {
		return this.asociarReciboPagoMulti(idRecibo, curPagoMulti);
	}
	function pub_excluirReciboPagoMulti(idRecibo:String, idPagoMulti:String):Boolean {
		return this.excluirReciboPagoMulti(idRecibo, idPagoMulti);
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
/** \C Los campos de contabilidad sólo aparecen cuando se trabaja con contabilidad integrada
\end */
function interna_init()
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil;

	this.iface.bngTasaCambio = this.child("bngTasaCambio");
	this.iface.divisaEmpresa = util.sqlSelect("empresa", "coddivisa", "1 = 1");

	this.iface.contabActivada = sys.isLoadedModule("flcontppal") && util.sqlSelect("empresa", "contintegrada", "1 = 1");
	if (this.iface.contabActivada) {
		this.iface.tblResAsientos = this.child("tblResAsientos");
		this.iface.tblResAsientos.setNumCols(4);
		this.iface.tblResAsientos.setColumnWidth(0, 100);
		this.iface.tblResAsientos.setColumnWidth(1, 200);
		this.iface.tblResAsientos.setColumnWidth(2, 100);
		this.iface.tblResAsientos.setColumnWidth(3, 100);
		this.iface.tblResAsientos.setColumnLabels("/", util.translate("scripts", "Subcuenta") + "/" + util.translate("scripts", "Descripción") + "/" +  util.translate("scripts", "Debe") + "/" + util.translate("scripts", "Haber"));
		this.iface.tblResAsientos.readOnly = true;
	
		this.iface.ejercicioActual = flfactppal.iface.pub_ejercicioActual();
		this.iface.longSubcuenta = util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + this.iface.ejercicioActual + "'");
		this.child("fdbIdSubcuenta").setFilter("codejercicio = '" + this.iface.ejercicioActual + "'");
		this.iface.posActualPuntoSubcuenta = -1;
		this.child("lblResAsientos").text = util.translate("scripts", "Existe un asiento por pago de comprobante. A continuación se muestra un acumulado de las partidas de todos los asientos asociados a los comprobantes de la orden de pago.");

		this.iface.pagoIndirecto_ = util.sqlSelect("factteso_general", "pagoindirecto", "1 = 1");
		if (!this.iface.pagoIndirecto_) {
			this.child("tbwRecibos").setTabEnabled("pagos", false);
		}
	} else {
		this.child("tbwRecibos").setTabEnabled("contabilidad", false);
		this.child("tbwRecibos").setTabEnabled("pagos", false);
		this.iface.pagoIndirecto_ = false;
	}

	this.child("tbwRecibos").setTabEnabled("pagos", true);
	this.child("fdbTasaConv").setDisabled(true);

	connect(this.child("tbInsert"), "clicked()", this, "iface.agregarRecibo");
	connect(this.child("tbDelete"), "clicked()", this, "iface.eliminarRecibo");
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.child("tdbPagosDevolPagosMulti").cursor(), "bufferCommited()", this, "iface.cambiarEstado");
	connect(this.iface.bngTasaCambio, "clicked(int)", this, "iface.bngTasaCambio_clicked()");
	this.iface.bufferChanged("estado");
		
/** \D Se muestran sólo los recibos del pago múltiple
\end */
	var tdbRecibos:FLTableDB = this.child("tdbRecibos");
	tdbRecibos.cursor().setMainFilter("idpagomulti = " + cursor.valueBuffer("idpagomulti"));
/** \C La tabla de recibos se muestra en modo de sólo lectura
\end */
	tdbRecibos.setReadOnly(true);
	var mA = cursor.modeAccess();
	if (mA == cursor.Insert) {
		this.child("fdbCodDivisa").setValue(flfactppal.iface.pub_valorDefectoEmpresa("coddivisa"));
		if (this.iface.contabActivada) {
			this.child("fdbIdSubcuenta").setValue(this.iface.calculateField("idsubcuentadefecto"));
		}
	}

	tdbRecibos.cursor().setMainFilter("idrecibo IN (SELECT idrecibo FROM pagosdevolprov WHERE idpagomulti = " + cursor.valueBuffer("idpagomulti") + ")");
	tdbRecibos.refresh();
	
	this.iface.habilitarPorRecibos();
	form.child("fdbCodProveedor").setFocus();
}

function interna_validateForm():Boolean
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	/** \C El pago múltiple debe tener al menos un recibo
	\end */
	if (!util.sqlSelect("pagosdevolprov", "idpagodevol", "idpagomulti = " + cursor.valueBuffer("idpagomulti"))) {
		MessageBox.warning(util.translate("scripts", "La orden de pago debe tener al menos un comprobante."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

	/** \C El pago múltiple debe tener al menos un pago
	\end */
	if (!util.sqlSelect("pagosdevolpagosmultiprov", "idpagopagomulti", "idpagomulti = " + cursor.valueBuffer("idpagomulti"))) {
		MessageBox.warning(util.translate("scripts", "La orden de pago debe tener al menos un pago."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

	return true;
}

function interna_calculateField(fN:String):String
{
	var util:FLUtil = new FLUtil();
	var cursor = this.cursor();

	var res:String;
	switch (fN) {
		/** \D La subcuenta contable por defecto será la asociada a la cuenta bancaria. Si ésta está vacía, será la subcuenta correspondienta a Caja.
		\end */
		case "idsubcuentadefecto": {
			if (this.iface.contabActivada) {
				var codSubcuenta:String;
				codSubcuenta = util.sqlSelect("cuentasbanco", "codsubcuenta", "codcuenta = '" + cursor. valueBuffer("codcuenta") + "'");
				if (codSubcuenta != false) {
					res = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + this.iface.ejercicioActual + "'");
				} else  {
					var qrySubcuenta:FLSqlQuery = new FLSqlQuery();
					qrySubcuenta.setTablesList("co_cuentas,co_subcuentas");
					qrySubcuenta.setSelect("s.idsubcuenta");
					qrySubcuenta.setFrom("co_cuentas c INNER JOIN co_subcuentas s ON c.idcuenta = s.idcuenta");
					qrySubcuenta.setWhere("c.codejercicio = '" + this.iface.ejercicioActual + "'" + " AND c.idcuentaesp = 'CAJA'");
					
					if ( qrySubcuenta.exec() && qrySubcuenta.first() )
						res = qrySubcuenta.value(0);
					else
						res = "";
				}
			}
			break;
		}
		case "idsubcuenta":
			var codSubcuenta:String = cursor.valueBuffer("codsubcuenta").toString();
			if (codSubcuenta.length == this.iface.longSubcuenta)
				res = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + this.iface.ejercicioActual + "'");
			break;
		case "codsubcuenta":
			res = "";
			if (cursor.valueBuffer("idsubcuenta"))
				res = util.sqlSelect("co_subcuentas", "codsubcuenta", "idsubcuenta = '" + cursor.valueBuffer("idsubcuenta") + "' AND codejercicio = '" + this.iface.ejercicioActual + "'");
			break;
		case "dc": {
			var entidad:String = cursor.valueBuffer("ctaentidad");
			var agencia:String = cursor.valueBuffer("ctaagencia");
			var cuenta:String = cursor.valueBuffer("cuenta");
			if ( !entidad.isEmpty() && !agencia.isEmpty() && ! cuenta.isEmpty() 
					&& entidad.length == 3 && agencia.length == 3 && cuenta.length == 11 ) {
				var dc1:String = util.calcularDC(entidad + agencia);
				var dc2:String = util.calcularDC(cuenta);
				res = dc1 + dc2;
			}
			break;
		}
		case "total": {
			res = util.sqlSelect("recibosprov", "SUM(importe)", "idrecibo IN (SELECT idrecibo FROM pagosdevolprov WHERE idpagomulti = " + cursor.valueBuffer("idpagomulti") + ")");
			break;
		}
		case "importeeuros": {
			var tasaConv:Number = parseFloat(cursor.valueBuffer("tasaconv"));
			res = cursor.valueBuffer("total") * tasaConv;
			break;
		}
		case "estado": {
// 			if (this.iface.pagoIndirecto_) {
				var tipo:String = util.sqlSelect("pagosdevolpagosmultiprov", "tipo", "idpagomulti = " + cursor.valueBuffer("idpagomulti"));
				if (!tipo || tipo == "")
					res = "Emitida";
				else
					res = "Pagada";
// 			} else {
// 				res = "Emitida";
// 			}
			break;
		}
	}
	return res;
}

/** \D Calcula un nuevo código de pago múltiple
\end */
function interna_calculateCounter():Number
{
	var util:FLUtil = new FLUtil();
	var cadena:String = util.sqlSelect("pagosmultiprov", "idpagomulti", "1 = 1 ORDER BY idpagomulti DESC");
	var valor:Number;
	if (!cadena)
		valor = 1;
	else
		valor = parseFloat(cadena) + 1;

	return valor;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition pagosMultiples */
//////////////////////////////////////////////////////////////////
//// PAGOS MULTIPLES /////////////////////////////////////////////

function pagosMultiples_actualizarTotal()
{
	this.child("total").setValue(this.iface.calculateField("total"));
	this.iface.habilitarPorRecibos();
}

function pagosMultiples_habilitarPorRecibos()
{
	if (this.child("tdbRecibos").cursor().size() > 0) {
		this.child("fdbCodProveedor").setDisabled(true);
		this.child("fdbCodCuenta").setDisabled(true);
		this.child("fdbCodDivisa").setDisabled(true);
		this.child("fdbFecha").setDisabled(true);
		this.child("gbxContabilidad").setEnabled(false);
		this.child("fdbTasaConv").setDisabled(true);
	} else {
		this.child("fdbCodProveedor").setDisabled(false);
		this.child("fdbCodCuenta").setDisabled(false);
		this.child("fdbCodDivisa").setDisabled(false);
		this.child("fdbFecha").setDisabled(false);
		this.child("gbxContabilidad").setEnabled(true);
	}
	if (this.iface.contabActivada)
		this.iface.asientoAcumulado();
}

function pagosMultiples_agregarRecibo():Boolean
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	
	if (!cursor.valueBuffer("codproveedor")) {
		MessageBox.warning(util.translate("scripts", "Debe indicar un proveedor"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return;
	}

	if ( sys.isLoadedModule("flcontppal") && // Si está cargado el módulo de contabilidad
		 !cursor.valueBuffer("nogenerarasiento") && // y debe generarse el asiento contable
		 !cursor.valueBuffer("codsubcuenta") ) { // y NO HAY una subcuenta para el asiento contable

		if ( cursor.valueBuffer("codcuenta") ) { // El pago se registra en una cuenta bancaria
			if (!util.sqlSelect("cuentasbanco", "codsubcuenta", "codcuenta = '" + cursor.valueBuffer("codcuenta") + "'")) {
				MessageBox.warning(util.translate("scripts", "La cuenta bancaria seleccionada no tiene asociada una subcuenta contable.\nDebe asignar esta subcuenta en el módulo principal de facturación (Cuentas bancarias)."), MessageBox.Ok, MessageBox.NoButton);
			} else {
				MessageBox.warning(util.translate("scripts", "Debe indicar una subcuenta contable"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			}
		} else { // El pago se registra en la caja
			// No tiene establecida una subcuenta para la CAJA
			MessageBox.warning(util.translate("scripts", "Debe indicar una subcuenta contable"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		}
		return;
	}
	
	var f:Object = new FLFormSearchDB("seleccionrecibosprov");
	var curRecibos:FLSqlCursor = f.cursor();
	var fecha:String = cursor.valueBuffer("fecha");
		
	var noGenerarAsiento:Boolean = cursor.valueBuffer("nogenerarasiento");

	if (cursor.modeAccess() != cursor.Browse)
		if (!cursor.checkIntegrity())
			return;

	if (this.iface.contabActivada && this.child("fdbCodSubcuenta").value().isEmpty()) {
		if (cursor.valueBuffer("nogenerarasiento") == false) {
			MessageBox.warning(util.translate("scripts", "Debe seleccionar una subcuenta a la que asignar el asiento de pago"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
	}

	curRecibos.select();
	if (!curRecibos.first())
		curRecibos.setModeAccess(curRecibos.Insert);
	else
		curRecibos.setModeAccess(curRecibos.Edit);
		
	f.setMainWidget();
	curRecibos.refreshBuffer();
	curRecibos.setValueBuffer("datos", "");
	curRecibos.setValueBuffer("filtro", this.iface.filtroRecibosProv());

	var ret = f.exec( "datos" );

	if ( !f.accepted() )
		return false;

	var datos:String = new String( ret );

	if ( datos.isEmpty() ) 
		return false;

	var recibos:Array = datos.split(",");

	for (var i:Number = 0; i < recibos.length; i++) {
		if (!this.iface.asociarReciboPagoMulti(recibos[i], cursor))
			return false;
	}

	this.child("tdbRecibos").refresh();
	this.iface.actualizarTotal();
}

function pagosMultiples_filtroRecibosProv():String
{
	var cursor:FLSqlCursor = this.cursor();
	return "estado = 'Pendiente' AND fecha <= '" + cursor.valueBuffer("fecha") + "' AND codproveedor = '" + cursor.valueBuffer("codproveedor") + "'";
}

/** \D Se elimina el recibo activo del pago múltiple. El pago asociado al pago múltiple debe ser el último asignado al recibo
\end */
function pagosMultiples_eliminarRecibo()
{
	if (!this.child("tdbRecibos").cursor().isValid())
		return;
	
	var recibo:String = this.child("tdbRecibos").cursor().valueBuffer("idrecibo");
	if (!this.iface.excluirReciboPagoMulti(recibo, this.cursor().valueBuffer("idpagomulti")))
		return;

	this.child("tdbRecibos").refresh();
	this.iface.actualizarTotal();
}

function pagosMultiples_excluirReciboPagoMulti(idRecibo:String, idPagoMulti:String):Boolean
{
	var util:FLUtil = new FLUtil;

	if (util.sqlSelect("pagosmulticli", "codcuenta", "idpagomulti = " + idPagoMulti)) {
		var cuentaValida:String = util.sqlSelect("recibosprov r LEFT OUTER JOIN cuentasbcoprov c ON r.codproveedor = c.codproveedor", "r.idrecibo", "idrecibo = " + idRecibo + " AND (r.codcuenta = c.codcuenta OR r.codcuenta = '' OR r.codcuenta IS NULL)", "recibosprov,cuentasbcoprov");
		if (!cuentaValida) {
			var codRecibo:String = util.sqlSelect("recibosprov", "codigo", "idrecibo = " + idRecibo);
			MessageBox.warning(util.translate("scripts", "La cuenta bancaria del comprobante %1 no es una cuenta válida del proveedor.\nCambie o borre la cuenta antes de excluir el comprobante de la orden de pago.").arg(codRecibo), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	}

	var curRecibos:FLSqlCursor = new FLSqlCursor("recibosprov");
	var curPagosDev:FLSqlCursor = new FLSqlCursor("pagosdevolprov");
	var curFactura:FLSqlCursor = new FLSqlCursor("facturasprov");
	var idfactura:Number;
	
	curRecibos.select("idrecibo = " + idRecibo);

	if (!curRecibos.first())
		return false;
	
	curRecibos.setModeAccess(curRecibos.Edit);
	curRecibos.refreshBuffer();
	
	idfactura = curRecibos.valueBuffer("idfactura");

	curFactura.select("idfactura = " + idfactura);
	if (curFactura.first())
		curFactura.setUnLock("editable", true);
	
	curPagosDev.select("idrecibo = " + idRecibo + " ORDER BY fecha,idpagodevol");
	if (curPagosDev.last()) {
		curPagosDev.setModeAccess(curPagosDev.Del);
		curPagosDev.refreshBuffer();
		if (!curPagosDev.commitBuffer())
			return false;
	}
	curPagosDev.select("idrecibo = " + idRecibo + " ORDER BY fecha,idpagodevol");
	if (curPagosDev.last())
		curPagosDev.setUnLock("editable", true);
	if (curPagosDev.size() == 0)
		curRecibos.setValueBuffer("estado", "Pendiente");
	curRecibos.setNull("idpagomulti");
	
	if (!curRecibos.commitBuffer())
		return false;

	return true;
}

function pagosMultiples_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();
	switch (fN) {
		/** \C En contabilidad integrada, si el usuario pulsa la tecla del punto '.', --codsubcuenta-- se informa automaticamente con el código de cuenta más tantos ceros como sea necesario para completar la longitud de subcuenta asociada al ejercicio actual.
			\end */
		case "codsubcuenta": {
			if (!this.iface.bloqueoSubcuenta) {
				this.iface.bloqueoSubcuenta = true;
				this.iface.posActualPuntoSubcuenta = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuenta", this.iface.longSubcuenta, this.iface.posActualPuntoSubcuenta);
				this.iface.bloqueoSubcuenta = false;
			}
			if (!this.iface.bloqueoSubcuenta && this.child("fdbCodSubcuenta").value().length == this.iface.longSubcuenta) {
				this.child("fdbIdSubcuenta").setValue(this.iface.calculateField("idsubcuenta"));
			}
			break;
		}
		/** \D Si el usuario selecciona una cuenta bancaria, se tomará su cuenta contable asociada como --codcuenta-- contable para el pago.
			\end */
		case "codcuenta":
		case "ctaentidad":
		case "ctaagencia":
		case "cuenta": {
			this.child("fdbIdSubcuenta").setValue(this.iface.calculateField("idsubcuentadefecto"));
			this.child("fdbDc").setValue(this.iface.calculateField("dc"));
			break;
		}
		case "idsubcuenta": {
			this.child("fdbCodSubcuenta").setValue(this.iface.calculateField("codsubcuenta"));
			break;
		}
		case "nogenerarasiento": {
			if (cursor.valueBuffer("nogenerarasiento") == true) {
				this.child("fdbIdSubcuenta").setValue("");
				this.child("fdbCodSubcuenta").setValue("");
				this.child("fdbDesSubcuenta").setValue("");
				cursor.setNull("idsubcuenta");
				cursor.setNull("codsubcuenta");
				this.child("fdbIdSubcuenta").setDisabled(true);
				this.child("fdbCodSubcuenta").setDisabled(true);
			} else {
				this.child("fdbIdSubcuenta").setDisabled(false);
				this.child("fdbCodSubcuenta").setDisabled(false);
			}
			break;
		}
		case "estado": {
			if (cursor.valueBuffer("estado") == "Pagada") {
				this.child("tbInsert").setDisabled(true);
				this.child("tbDelete").setDisabled(true);
			} else {
				this.child("tbInsert").setDisabled(false);
				this.child("tbDelete").setDisabled(false);
			}
			break;
		}
		case "tasaconv":
		case "total": {
			this.child("fdbImporteEuros").setValue(this.iface.calculateField("importeeuros"));
			break;
		}
		case "coddivisa": {
			if (cursor.valueBuffer("coddivisa") != this.iface.divisaEmpresa) {
				this.child("fdbTasaConv").setDisabled(false);
				this.child("rbnTasaActual").checked = true;
				this.iface.bngTasaCambio_clicked(0);
			}
			break;
		}
	}
}

/** \D
Establece el valor de --tasaconv-- obteniéndolo de la factura original o del cambio actual de la divisa del recibo
@param	opcion: Origen de la tasa: tasa actual o tasa de la factura original
\end */
function pagosMultiples_bngTasaCambio_clicked(opcion:Number)
{
	if (this.child("tdbRecibos").cursor().size() > 0)
		return;

	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	switch (opcion) {
		case 0: // Tasa actual
			this.child("fdbTasaConv").setValue(util.sqlSelect("divisas", "tasaconv", "coddivisa = '" + cursor.valueBuffer("coddivisa") + "'"));
			break;
		case 1: // Tasa de la factura
			this.child("fdbTasaConv").setValue(util.sqlSelect("divisas", "tasaconv", "coddivisa = '" + cursor.valueBuffer("coddivisa") + "'"));
//			this.child("fdbTasaConv").setValue(util.sqlSelect("facturascli", "tasaconv", "idfactura = " + this.iface.curRelacionado.valueBuffer("idfactura")));
			break;
	}
}

/** \D Rellena la tabla de asiento acumulado de la pestaña de Contabilidad con los datos de contabilidad asociados a los recibos del pago múltiple
\end */
function pagosMultiples_asientoAcumulado()
{
	var util:FLUtil = new FLUtil;
	var totalFilas:Number = this.iface.tblResAsientos.numRows() - 1;
	var fila:Number;
	for (fila = totalFilas; fila >= 0; fila--)
		this.iface.tblResAsientos.removeRow(fila);
	
	var idPagoMulti:Number = this.cursor().valueBuffer("idpagomulti");
	if (!idPagoMulti)
		return;
	var qryAsientos:FLSqlQuery = new FLSqlQuery();
	qryAsientos.setTablesList("recibosprov,pagosdevolprov,co_partidas");
	qryAsientos.setSelect("p.codsubcuenta, SUM(p.debe), SUM(p.haber)");
	qryAsientos.setFrom("recibosprov r INNER JOIN pagosdevolprov pd ON r.idrecibo = pd.idrecibo INNER JOIN co_partidas p ON pd.idasiento = p.idasiento");
	qryAsientos.setWhere("pd.idpagomulti = " + idPagoMulti + " GROUP BY p.codsubcuenta");
	qryAsientos.setOrderBy("p.codsubcuenta");
	if (!qryAsientos.exec())
		return;
	
	fila = 0;
	while (qryAsientos.next()) {
		this.iface.tblResAsientos.insertRows(fila, 1);
		this.iface.tblResAsientos.setText(fila, 0, qryAsientos.value("p.codsubcuenta"));
		this.iface.tblResAsientos.setText(fila, 1, util.sqlSelect("co_subcuentas", "descripcion", "codsubcuenta = '" + qryAsientos.value("p.codsubcuenta") + "' AND codejercicio = '" + this.iface.ejercicioActual + "'"));
		this.iface.tblResAsientos.setText(fila, 2, util.roundFieldValue(qryAsientos.value("SUM(p.debe)"), "co_partidas", "debe"));
		this.iface.tblResAsientos.setText(fila, 3, util.roundFieldValue(qryAsientos.value("SUM(p.haber)"), "co_partidas", "haber"));
		fila++;
	}
}

/** \D Asocia un recibo a un pago múltiple, marcándolo como Pagado
@param	idRecibo: Identificador del recibo
@param	curPagoMulti: Cursor posicionado en el pago múltiple
@return	true si la asociación se realiza de forma correcta, false en caso contrario
\end */
function pagosMultiples_asociarReciboPagoMulti(idRecibo:String, curPagoMulti:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var idPagoMulti:Number = curPagoMulti.valueBuffer("idpagomulti");
	
	if (util.sqlSelect("recibosprov", "coddivisa", "idrecibo = " + idRecibo) != curPagoMulti.valueBuffer("coddivisa")) {
		MessageBox.warning(util.translate("scripts", "No es posible incluir el comprobante.\nLa divisa del comprobante y de la orden de pago deben ser la misma."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return;
	}

	var datosCuenta:Array;
	var dc:String = "";
	if (curPagoMulti.valueBuffer("codcuenta")) {
		datosCuenta = flfactppal.iface.pub_ejecutarQry("cuentasbanco", "ctaentidad,ctaagencia,cuenta", "codcuenta = '" + curPagoMulti.valueBuffer("codcuenta") + "'");
		if ( datosCuenta.result != 1 )
			return false;
		dc = util.calcularDC(datosCuenta.ctaentidad + datosCuenta.ctaagencia) + util.calcularDC(datosCuenta.cuenta);
	}

	var curRecibos:FLSqlCursor = new FLSqlCursor("recibosprov");
	var idFactura:Number;

	var fecha:String = curPagoMulti.valueBuffer("fecha");
	if (!this.iface.curPagosDev)
		this.iface.curPagosDev = new FLSqlCursor("pagosdevolprov");
	this.iface.curPagosDev.select("idrecibo = " + idRecibo + " ORDER BY fecha,idpagodevol");
	if (this.iface.curPagosDev.last()) {
		if (util.daysTo(this.iface.curPagosDev.valueBuffer("fecha"), fecha) < 0) {
			var codRecibo:String = util.sqlSelect("recibosprov", "codigo", "idrecibo = " + idRecibo);
			MessageBox.warning(util.translate("scripts", "Existen pagos con fecha igual o porterior a la de la orden de pago para el comprobante %1").arg(codRecibo), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	}

	curRecibos.select("idrecibo = " + idRecibo);
	if (curRecibos.next()) {
		curRecibos.setActivatedCheckIntegrity(false);
		curRecibos.setModeAccess(curRecibos.Edit);
		curRecibos.refreshBuffer();
		curRecibos.setValueBuffer("idpagomulti", idPagoMulti);
		curRecibos.setValueBuffer("estado", "Pagado");
		idFactura = curRecibos.valueBuffer("idfactura");
		curRecibos.commitBuffer();
	}

	if (this.iface.curPagosDev.last()) {
		this.iface.curPagosDev.setUnLock("editable", false);
	}
	this.iface.curPagosDev.setModeAccess(this.iface.curPagosDev.Insert);
	this.iface.curPagosDev.refreshBuffer();
	this.iface.curPagosDev.setValueBuffer("idrecibo", idRecibo);
	this.iface.curPagosDev.setValueBuffer("fecha", fecha);
	this.iface.curPagosDev.setValueBuffer("tipo", "Pago");
	if (curPagoMulti.valueBuffer("codcuenta")) {
		this.iface.curPagosDev.setValueBuffer("codcuenta", curPagoMulti.valueBuffer("codcuenta"));
		this.iface.curPagosDev.setValueBuffer("ctaentidad", datosCuenta.ctaentidad);
		this.iface.curPagosDev.setValueBuffer("ctaagencia", datosCuenta.ctaagencia);
		this.iface.curPagosDev.setValueBuffer("dc", dc);
		this.iface.curPagosDev.setValueBuffer("cuenta", datosCuenta.cuenta);
	} else {
		this.iface.curPagosDev.setNull("codcuenta");
		this.iface.curPagosDev.setNull("ctaentidad");
		this.iface.curPagosDev.setNull("ctaagencia");
		this.iface.curPagosDev.setNull("dc");
		this.iface.curPagosDev.setNull("cuenta");
	}
	this.iface.curPagosDev.setValueBuffer("idpagomulti", idPagoMulti);
	this.iface.curPagosDev.setValueBuffer("tasaconv", curPagoMulti.valueBuffer("tasaconv"));
	this.iface.curPagosDev.setValueBuffer("nogenerarasiento", curPagoMulti.valueBuffer("nogenerarasiento"));
	if (parseFloat(curPagoMulti.valueBuffer("idsubcuenta")) == 0) {
		this.iface.curPagosDev.setNull("idsubcuenta");
		this.iface.curPagosDev.setNull("codsubcuenta");
	} else {
		this.iface.curPagosDev.setValueBuffer("idsubcuenta", curPagoMulti.valueBuffer("idsubcuenta"));
		this.iface.curPagosDev.setValueBuffer("codsubcuenta", curPagoMulti.valueBuffer("codsubcuenta"));
	}
	if (!this.iface.datosPagosDev(idRecibo, curPagoMulti))
		return false;

	if (!this.iface.curPagosDev.commitBuffer())
		return false;

	return true;
}

function pagosMultiples_datosPagosDev(idRecibo:String, curPagoMulti:FLSqlCursor):Boolean
{
	return true;
}

function pagosMultiples_cambiarEstado()
{
	this.child("fdbEstado").setValue(this.iface.calculateField("estado"));
}

//// PAGOS MULTIPLES /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition controlUsuario */
/////////////////////////////////////////////////////////////////
//// CONTROL_USUARIO ////////////////////////////////////////////

function controlUsuario_init()
{
	if (this.cursor().modeAccess() == this.cursor().Insert) {
		if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
			flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Órdenes de pago");
		}
	}

	this.iface.__init();
}

//// CONTROL_USUARIO //////////////////////////////////////////
///////////////////////////////////////////////////////////////

/** @class_definition ordenCampos */
/////////////////////////////////////////////////////////////////
//// ORDEN_CAMPOS ///////////////////////////////////////////////

function ordenCampos_init()
{
	this.iface.__init();

	var orden:Array = [ "codigo", "estado", "nombreproveedor", "importe", "coddivisa", "importeeuros", "fecha", "fechav", "idremesa", "idpagomulti", "codproveedor", "cifnif", "direccion", "codpostal", "ciudad", "provincia", "codpais", "texto" ];

	this.child("tdbRecibos").setOrderCols(orden);
}

//// ORDEN_CAMPOS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
