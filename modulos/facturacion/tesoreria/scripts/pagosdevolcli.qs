/***************************************************************************
                 pagosdevolcli.qs  -  description
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

/** @ file */

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
	function validateForm() { return this.ctx.interna_validateForm(); }
	function calculateField(fN:String):String { return this.ctx.interna_calculateField(fN); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var ejercicioActual:String;
	var bloqueoSubcuenta:Boolean;
	var longSubcuenta:Number;
	var contabActivada:Boolean;
	var bngTasaCambio:Object;
	var divisaEmpresa:String;
	var posActualPuntoSubcuenta:Number;
	var noGenAsiento:Boolean;
	var curFacturaCli:FLSqlCursor;
	var curFacturaProv:FLSqlCursor;
	var curRelacionado:FLSqlCursor;
	
	function oficial( context ) { interna( context ); } 
	function desconexion() {
		return this.ctx.oficial_desconexion();
	}
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function bngTasaCambio_clicked(opcion:Number) {
		return this.ctx.oficial_bngTasaCambio_clicked(opcion);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration infoVencimtos */
//////////////////////////////////////////////////////////////////
//// INFO VENCIMIENTOS ///////////////////////////////////////////
class infoVencimtos extends oficial {
    function infoVencimtos( context ) { oficial( context ); } 
	function calculateField(fN:String):String { 
		return this.ctx.infoVencimtos_calculateField(fN); 
	}
}
//// INFO VENCIMIENTOS ///////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends infoVencimtos {
    function head( context ) { infoVencimtos ( context ); }
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
/** \C El marco 'Contabilidad' se habilitará en caso de que esté cargado el módulo principal de contabilidad.
\end */
function interna_init()
{
	var cursor:FLSqlCursor = this.cursor();
	
	if (!this.iface.curRelacionado)
		this.iface.curRelacionado = cursor.cursorRelation();
	
	var util:FLUtil = new FLUtil();
	this.iface.bngTasaCambio = this.child("bngTasaCambio");
	this.iface.divisaEmpresa = util.sqlSelect("empresa", "coddivisa", "1 = 1");
	this.iface.noGenAsiento = false;

	this.iface.contabActivada = sys.isLoadedModule("flcontppal") && util.sqlSelect("empresa", "contintegrada", "1 = 1");
			
	this.iface.ejercicioActual = flfactppal.iface.pub_ejercicioActual();
	if (this.iface.contabActivada) {
		this.iface.longSubcuenta = util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + this.iface.ejercicioActual + "'");
		this.child("fdbIdSubcuenta").setFilter("codejercicio = '" + this.iface.ejercicioActual + "'");
		this.iface.posActualPuntoSubcuenta = -1;
	} else {
		this.child("tbwPagDevCli").setTabEnabled("contabilidad", false);
	}

	this.child("fdbTipo").setDisabled(true);
	this.child("fdbTasaConv").setDisabled(true);
	this.child("tdbPartidas").setReadOnly(true);

	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(form, "closed()", this, "iface.desconexion");
	connect(this.iface.bngTasaCambio, "clicked(int)", this, "iface.bngTasaCambio_clicked()");
	
	var curPagosDevol:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
	curPagosDevol.select("idrecibo = " + this.iface.curRelacionado.valueBuffer("idrecibo") + " ORDER BY fecha, idpagodevol");
	var last:Boolean = false;
	if (curPagosDevol.last()) {
		last = true;
		curPagosDevol.setModeAccess(curPagosDevol.Browse);
		curPagosDevol.refreshBuffer();
		if(curPagosDevol.valueBuffer("nogenerarasiento") && curPagosDevol.valueBuffer("tipo") == "Pago"){
			this.iface.noGenAsiento = true;
			this.child("fdbNoGenerarAsiento").setValue(true);
		}
	}
	switch (cursor.modeAccess()) {
		case cursor.Insert:
			this.child("fdbTipo").setValue("Pago");
			this.child("fdbCodCuenta").setValue(this.iface.calculateField("codcuenta"));
			if (this.iface.contabActivada) {
				this.child("fdbIdSubcuenta").setValue(this.iface.calculateField("idsubcuentadefecto"));
			}
			if (this.iface.curRelacionado.valueBuffer("coddivisa") != this.iface.divisaEmpresa) {
				this.child("fdbTasaConv").setDisabled(false);
				this.child("rbnTasaActual").checked = true;
				this.iface.bngTasaCambio_clicked(0);
			}
			break;
		case cursor.Edit:
			if (cursor.valueBuffer("idsubcuenta") == "0")
				cursor.setValueBuffer("idsubcuenta", "");
	}
	this.iface.bufferChanged("tipo");
}

function interna_validateForm():Boolean
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();

	/** \C
	Si la contabilidad está integrada, se debe seleccionar una subcuenta válida a la que asignar el asiento de pago
	\end */
	if (this.iface.contabActivada && !this.child("fdbNoGenerarAsiento").value() && (this.child("fdbCodSubcuenta").value().isEmpty() || this.child("fdbIdSubcuenta").value() == 0)) {
		MessageBox.warning(util.translate("scripts", "Debe seleccionar una subcuenta válida a la que asignar el asiento de pago"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

	/** \C
	La fecha de un pago debe ser siempre posterior\na la fecha del pago anterior
	\end */
	var curPagosDevol:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
	curPagosDevol.select("idrecibo = " + this.iface.curRelacionado.valueBuffer("idrecibo") + " AND idpagodevol <> " + cursor.valueBuffer("idpagodevol") + " ORDER BY  fecha, idpagodevol");
	if (curPagosDevol.last()) {
		curPagosDevol.setModeAccess(curPagosDevol.Browse);
		curPagosDevol.refreshBuffer();
		if (util.daysTo(curPagosDevol.valueBuffer("fecha"), cursor.valueBuffer("fecha")) < 0) {
			MessageBox.warning(util.translate("scripts", "La fecha de un pago debe ser siempre igual o posterior\na la fecha del pago anterior."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
	}

	/** \C Si el ejercicio de la factura que originó el recibo no coincide con el ejercicio actual, se solicita al usuario que confirme el pago
	\end */
	var ejercicioFactura = util.sqlSelect("reciboscli r INNER JOIN facturascli f ON r.idfactura = f.idfactura", "f.codejercicio", "r.idrecibo = " + cursor.valueBuffer("idrecibo"), "reciboscli,facturascli");
	if (this.iface.ejercicioActual != ejercicioFactura) {
		var respuesta:Number = MessageBox.warning(util.translate("scripts", "El ejercicio de la factura que originó este recibo es distinto del ejercicio actual ¿Desea continuar?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
		if (respuesta != MessageBox.Yes)
			return false;
	}
	
	return true;
}

function interna_calculateField(fN:String):String
{
		var util:FLUtil = new FLUtil();
		var cursor:FLSqlCursor = this.cursor();
		var res:String;
		switch (fN) {
				/** \D
				La subcuenta contable por defecto será la asociada a la cuenta bancaria. Si ésta está vacía, será la subcuenta correspondienta a Caja
				\end */
		case "idsubcuentadefecto":
				if (this.iface.contabActivada) {
						var codSubcuenta:String = util.sqlSelect("cuentasbanco", "codsubcuenta",
																							"codcuenta = '" +
																							cursor.
																							valueBuffer("codcuenta") + "'");
						if (codSubcuenta)
								res = util.sqlSelect("co_subcuentas", "idsubcuenta",
																		 "codsubcuenta = '" + codSubcuenta +
																		 "' AND codejercicio = '" +
																		 this.iface.ejercicioActual + "'");
						else {
								var qrySubcuenta:FLSqlQuery = new FLSqlQuery();
								qrySubcuenta.setTablesList("co_cuentas,co_subcuentas");
								qrySubcuenta.setSelect("s.idsubcuenta");
								qrySubcuenta.setFrom("co_cuentas c INNER JOIN co_subcuentas s ON c.idcuenta = s.idcuenta");
								qrySubcuenta.setWhere("c.codejercicio = '" + this.iface.ejercicioActual + "'" +
										" AND c.idcuentaesp = 'CAJA'");
								
								if (!qrySubcuenta.exec())
										return false;
								if (!qrySubcuenta.first())
										return false;
								res = qrySubcuenta.value(0);
						}
				}
				break;
		case "idsubcuenta":
				var codSubcuenta:String = cursor.valueBuffer("codsubcuenta").toString();
				if (codSubcuenta.length == this.iface.longSubcuenta)
						res = util.sqlSelect("co_subcuentas", "idsubcuenta",
																 "codsubcuenta = '" + codSubcuenta +
																 "' AND codejercicio = '" + this.iface.ejercicioActual +
																 "'");
				break;
				/** \C
				La cuenta bancaria por defecto será la asociada al cliente (Cuenta 'Remesar en'). Si el cliente no está informado o no tiene especificada la cuenta, se tomará la cuenta asociada a la forma de pago asignada a la factura del recibo. 
				\end */
		case "codcuenta":
				res = false;
				var codCliente:String = this.iface.curRelacionado.valueBuffer("codcliente");
				if (codCliente)
					res = util.sqlSelect("clientes", "codcuentarem", "codcliente = '" + codCliente + "'");
				if (!res) {
					var codpago:String = util.sqlSelect("facturascli", "codpago", "idfactura = " + this.iface.curRelacionado.valueBuffer("idfactura"));
					res = util.sqlSelect("formaspago", "codcuenta", "codpago = '" + codpago + "'");
				}
				break;
		case "dc":
				var entidad:String = cursor.valueBuffer("ctaentidad");
				var agencia:String = cursor.valueBuffer("ctaagencia");
				var cuenta:String = cursor.valueBuffer("cuenta");
				if ( !entidad.isEmpty() && !agencia.isEmpty() && ! cuenta.isEmpty() 
						&& entidad.length == 3 && agencia.length == 3 && cuenta.length == 11 ) {
					var util:FLUtil = new FLUtil();
					var dc1:String = util.calcularDC(entidad + agencia);
					var dc2:String = util.calcularDC(cuenta);
					res = dc1 + dc2;
				}
				break;
		}
		return res;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_desconexion()
{
	disconnect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");
}

function oficial_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	switch (fN) {
	/** \C
	Si el usuario pulsa la tecla del punto '.', la subcuenta se informa automaticamente con el código de cuenta más tantos ceros como sea necesario para completar la longitud de subcuenta asociada al ejercicio actual.
	\end */
	case "codsubcuenta":
		if (!this.iface.bloqueoSubcuenta) {
			this.iface.bloqueoSubcuenta = true;
			this.iface.posActualPuntoSubcuenta = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuenta", this.iface.longSubcuenta, this.iface.posActualPuntoSubcuenta);
			this.iface.bloqueoSubcuenta = false;
		}
		if (!this.iface.bloqueoSubcuenta && this.child("fdbCodSubcuenta").value().length == this.iface.longSubcuenta) {
			this.child("fdbIdSubcuenta").setValue(this.iface.calculateField("idsubcuenta"));
		}
		break;
		/** \C
		Si el usuario selecciona una cuenta bancaria, se tomará su cuenta contable asociada como cuenta contable para el pago. La subcuenta contable por defecto será la asociada a la cuenta bancaria. Si ésta está vacía, será la subcuenta correspondienta a Caja
		\end */
	case "codcuenta":
	case "ctaentidad":
	case "ctaagencia":
	case "cuenta":
		this.child("fdbIdSubcuenta").
				setValue(this.iface.calculateField("idsubcuentadefecto"));
		this.child("fdbDc").setValue(this.iface.calculateField("dc"));
		break;
	}
}

/** \D
Establece el valor de --tasaconv-- obteniéndolo de la factura original o del cambio actual de la divisa del recibo
@param	opcion: Origen de la tasa: tasa actual o tasa de la factura original
\end */
function oficial_bngTasaCambio_clicked(opcion:Number)
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	switch (opcion) {
	case 0: // Tasa actual
		this.child("fdbTasaConv").setValue(util.sqlSelect("divisas", "tasaconv", "coddivisa = '" + this.iface.curRelacionado.valueBuffer("coddivisa") + "'"));
		break;
	case 1: // Tasa de la factura
		this.child("fdbTasaConv").setValue(util.sqlSelect("facturascli", "tasaconv", "idfactura = " + this.iface.curRelacionado.valueBuffer("idfactura")));
		break;
	}
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition infoVencimtos */
/////////////////////////////////////////////////////////////////
//// INFO VENCIMIENTOS //////////////////////////////////////////
/** \D La cuenta de pago por defecto es la del recibo
\end */
function infoVencimtos_calculateField(fN:String):String
{
	var cursor:FLSqlCursor = this.cursor();
	var res:String;
	switch (fN) {
		case "codcuenta": {
			res = cursor.cursorRelation().valueBuffer("codcuentapago");
			if (!res || res == "")
				res = this.iface.__calculateField(fN);
			break;
		}
		default: {
			res = this.iface.__calculateField(fN);
			break;
		}
	}
	return res;
}
//// INFO VENCIMIENTOS //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////