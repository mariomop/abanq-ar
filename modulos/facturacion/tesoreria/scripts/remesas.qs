/***************************************************************************
                      remesas.qs  -  description
                             -------------------
    begin                : lun may 31 2004
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
	var ejercicioActual:String;
	var bloqueoSubcuenta:Boolean;
	var contabActivada:Boolean;
	var longSubcuenta:Number;
	var posActualPuntoSubcuenta:Number;
	var tblResAsientos:QTable;
	var curPagosDev:FLSqlCursor;
	var pagoIndirecto_:Boolean;
	
    function oficial( context ) { interna( context ); } 
	function actualizarTotal() {
		return this.ctx.oficial_actualizarTotal();
	}
	function agregarRecibo():Boolean {
		return this.ctx.oficial_agregarRecibo();
	}
	function eliminarRecibo() {
		return this.ctx.oficial_eliminarRecibo();
	}
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function asientoAcumulado() {
		return this.ctx.oficial_asientoAcumulado();
	}
	function asociarReciboRemesa(idRecibo:String, curRemesa:FLSqlCursor):Boolean {
		return this.ctx.oficial_asociarReciboRemesa(idRecibo, curRemesa);
	}
	function excluirReciboRemesa(idRecibo:String, idRemesa:String):Boolean {
		return this.ctx.oficial_excluirReciboRemesa(idRecibo, idRemesa);
	}
	function datosPagosDev(idRecibo:String, curRemesa:FLSqlCursor):Boolean {
		return this.ctx.oficial_datosPagosDev(idRecibo, curRemesa);
	}
	function cambiarEstado() {
		return this.ctx.oficial_cambiarEstado();
	}
	function filtroRecibosCli():String {
		return this.ctx.oficial_filtroRecibosCli();
	}
	function habilitarPorRecibos() {
		return this.ctx.oficial_habilitarPorRecibos();
	}
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
	function pub_asociarReciboRemesa(idRecibo:String, curRemesa:FLSqlCursor):Boolean {
		return this.asociarReciboRemesa(idRecibo, curRemesa);
	}
	function pub_excluirReciboRemesa(idRecibo:String, idRemesa:String):Boolean {
		return this.excluirReciboRemesa(idRecibo, idRemesa);
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
/** \C Los campos de contabilidad s�lo aparecen cuando se trabaja con contabilidad integrada
\end */
function interna_init()
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil;

	this.iface.contabActivada = sys.isLoadedModule("flcontppal") && util.sqlSelect("empresa", "contintegrada", "1 = 1");
	if (this.iface.contabActivada) {
		this.iface.tblResAsientos = this.child("tblResAsientos");
		this.iface.tblResAsientos.setNumCols(4);
		this.iface.tblResAsientos.setColumnWidth(0, 100);
		this.iface.tblResAsientos.setColumnWidth(1, 200);
		this.iface.tblResAsientos.setColumnWidth(2, 100);
		this.iface.tblResAsientos.setColumnWidth(3, 100);
		this.iface.tblResAsientos.setColumnLabels("/", util.translate("scripts", "Subcuenta") + "/" + util.translate("scripts", "Descripci�n") + "/" +  util.translate("scripts", "Debe") + "/" + util.translate("scripts", "Haber"));
		this.iface.tblResAsientos.readOnly = true;
	
		this.iface.ejercicioActual = flfactppal.iface.pub_ejercicioActual();
		this.iface.longSubcuenta = util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + this.iface.ejercicioActual + "'");
		this.child("fdbIdSubcuenta").setFilter("codejercicio = '" + this.iface.ejercicioActual + "'");
		this.iface.posActualPuntoSubcuenta = -1;
		this.child("lblResAsientos").text = util.translate("scripts", "Existe un asiento por pago de factura. A continuaci�n se muestra un acumulado de las partidas de todos los asientos asociados a las facturas de la remesa.");

		this.iface.pagoIndirecto_ = util.sqlSelect("factteso_general", "pagoindirecto", "1 = 1");
		if (!this.iface.pagoIndirecto_) {
			this.child("tbwRecibos").setTabEnabled("pagos", false);
		}
	} else {
		this.child("tbwRemesa").setTabEnabled("contabilidad", false);
		this.child("tbwRecibos").setTabEnabled("pagos", false);
		this.iface.pagoIndirecto_ = false;
	}

	connect(this.child("tbInsert"), "clicked()", this, "iface.agregarRecibo");
	connect(this.child("tbDelete"), "clicked()", this, "iface.eliminarRecibo");
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.child("tdbPagosDevolRem").cursor(), "bufferCommited()", this, "iface.cambiarEstado");
	this.iface.bufferChanged("estado");
		
/** \D Se muestran s�lo los recibos de la remesa
\end */
	var tdbRecibos:FLTableDB = this.child("tdbRecibos");
	tdbRecibos.cursor().setMainFilter("idremesa = " + cursor.valueBuffer("idremesa"));
/** \C La tabla de recibos se muestra en modo de s�lo lectura
\end */
	tdbRecibos.setReadOnly(true);
	var mA = cursor.modeAccess();
	if (mA == cursor.Insert)
			this.child("fdbCodDivisa").setValue(flfactppal.iface.pub_valorDefectoEmpresa("coddivisa"));

	tdbRecibos.cursor().setMainFilter("idrecibo IN (SELECT idrecibo FROM pagosdevolcli WHERE idremesa = " + cursor.valueBuffer("idremesa") + ")");
	tdbRecibos.refresh();
	
	this.iface.habilitarPorRecibos();
}

function interna_validateForm():Boolean
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	/** \C La remesa debe tener al menos un recibo
	\end */
	if (!util.sqlSelect("pagosdevolcli", "idpagodevol", "idremesa = " + cursor.valueBuffer("idremesa"))) {
		MessageBox.warning(util.translate("scripts", "La remesa debe tener al menos una factura."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	
	/** \C La cuenta bancaria de los recibos incluidos en la remesa debe ser una cuenta del cliente v�lida
	\end 
	var qryRecibos:FLSqlQuery = new qryRecibos();
	qryRecibos.setTablesList("pagosdevolcli,reciboscli,cuentasbcocli");
	qryRecibos.setSelect("r.codigo");
	qryRecibos.setFrom("pagosdevolcli pd INNER JOIN reciboscli r ON pd.idrecibo = r.idrecibo LEFT OUTER JOIN cuentasbcocli cc ON (r.codcliente = cc.codcliente AND r.codcuenta = cc.codcuenta)");
	qryRecibos.where("pd.idremesa = " + cursorvalueBuffer("remesa") + " AND cc.codcuenta IS NULL");
	qryRecibos.setForwardOnly(true);
	if (!qryRecibos.exec())
		return false;
		
	if (qryRecibos.first()) {
		MessageBox.warning(util.translate("scripts", "La factura %1 est� asociada a una cuenta bancaria que ha sido eliminada del cliente.\nDebe asociar la factura a una cuenta v�lida antes de a�adirlo a la remesa.").arg(qryRecibos.value("r.codigo")), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	*/
	return true;
}

function interna_calculateField(fN:String):String
{
	var util:FLUtil = new FLUtil();
	var cursor = this.cursor();

	var res:String;
	switch (fN) {
		/** \D La subcuenta contable por defecto depender� de si se ha establecido o no la opci�n Cobro directo en el formulario de datos generales. Si la opci�n est� establecida ser� la asociada a la cuenta bancaria. Si no lo est� ser� la subcuenta de efectos comerciales de gesti�n de cobro asociada a la cuenta bancaria. Si �sta est� vac�a, ser� la subcuenta correspondienta a Caja
		\end */
		case "idsubcuentadefecto": {
			if (this.iface.contabActivada) {
				var codSubcuenta:String;
				if (this.iface.pagoIndirecto_) {
					codSubcuenta = util.sqlSelect("cuentasbanco", "codsubcuentaecgc", "codcuenta = '" + cursor. valueBuffer("codcuenta") + "'");
				} else {
					codSubcuenta = util.sqlSelect("cuentasbanco", "codsubcuenta", "codcuenta = '" + cursor. valueBuffer("codcuenta") + "'");
				}
				if (codSubcuenta != false) {
					res = util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + codSubcuenta + "' AND codejercicio = '" + this.iface.ejercicioActual + "'");
				} else  {
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
		case "total": {
			res = util.sqlSelect("reciboscli", "SUM(importe)", "idrecibo IN (SELECT idrecibo FROM pagosdevolcli WHERE idremesa = " + cursor.valueBuffer("idremesa") + ")");
			break;
		}
		case "estado": {
			if (this.iface.pagoIndirecto_) {
				var tipo:String = util.sqlSelect("pagosdevolrem", "tipo", "idremesa = " + cursor.valueBuffer("idremesa"));
				if (!tipo || tipo == "")
					res = "Emitida";
				else
					res = "Pagada";
			} else {
				res = "Emitida";
			}
			break;
		}
	}
	return res;
}

/** \D Calcula un nuevo c�digo de remesa
\end */
function interna_calculateCounter():Number
{
	var util:FLUtil = new FLUtil();
	var cadena:String = util.sqlSelect("remesas", "idremesa", "1 = 1 ORDER BY idremesa DESC");
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
function oficial_actualizarTotal()
{
	this.child("total").setValue(this.iface.calculateField("total"));
	this.iface.habilitarPorRecibos();
}

function oficial_habilitarPorRecibos()
{
	if (this.child("tdbRecibos").cursor().size() > 0) {
		this.child("fdbCodCuenta").setDisabled(true);
		this.child("fdbCodDivisa").setDisabled(true);
		this.child("fdbFecha").setDisabled(true);
		this.child("gbxContabilidad").setEnabled(false);
		
	} else {
		this.child("fdbCodCuenta").setDisabled(false);
		this.child("fdbCodDivisa").setDisabled(false);
		this.child("fdbFecha").setDisabled(false);
		this.child("gbxContabilidad").setEnabled(true);
	}
	if (this.iface.contabActivada)
		this.iface.asientoAcumulado();
}

/** \D Se agrega un recibo a la remesa. Si la contabilidad est� integrada se comprueba que se ha seleccionado una subcuenta
\end */
function oficial_agregarRecibo():Boolean
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	
	if (!cursor.valueBuffer("codcuenta")) {
		MessageBox.warning(util.translate("scripts", "Debe indicar una cuenta bancaria"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return;
	}
	
	if (sys.isLoadedModule("flcontppal") && !cursor.valueBuffer("nogenerarasiento") && !cursor.valueBuffer("codsubcuenta")) {
		if (this.iface.pagoIndirecto_) {
			if (!util.sqlSelect("cuentasbanco", "codsubcuentaecgc", "codcuenta = '" + cursor.valueBuffer("codcuenta") + "'")) {
				MessageBox.warning(util.translate("scripts", "La cuenta bancaria seleccionada no tiene asociada una subcuenta de Efectos comerciales de gesti�n de cobro.\nDebe asignar esta subcuenta o desactivar la opci�n de pago indirecto de remesas en Datos generales."), MessageBox.Ok, MessageBox.NoButton);
			} else {
				MessageBox.warning(util.translate("scripts", "Debe indicar una subcuenta contable"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			}
		} else {
			if (!util.sqlSelect("cuentasbanco", "codsubcuenta", "codcuenta = '" + cursor.valueBuffer("codcuenta") + "'")) {
				MessageBox.warning(util.translate("scripts", "La cuenta bancaria seleccionada no tiene asociada una subcuenta contable.\nDebe asignar esta subcuenta en el m�dulo principal de facturaci�n (Cuentas bancarias)."), MessageBox.Ok, MessageBox.NoButton);
			} else {
				MessageBox.warning(util.translate("scripts", "Debe indicar una subcuenta contable"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			}
		}
		return;
	}
	
	var f:Object = new FLFormSearchDB("seleccionreciboscli");
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
	curRecibos.setValueBuffer("filtro", this.iface.filtroRecibosCli());

	var ret = f.exec( "datos" );

	if ( !f.accepted() )
		return false;

	var datos:String = new String( ret );

	if ( datos.isEmpty() ) 
		return false;

	var recibos:Array = datos.split(",");

	for (var i:Number = 0; i < recibos.length; i++) {
		if (!this.iface.asociarReciboRemesa(recibos[i], cursor))
			return false;
	}

	this.child("tdbRecibos").refresh();
	this.iface.actualizarTotal();
}

function oficial_filtroRecibosCli():String
{
	var cursor:FLSqlCursor = this.cursor();
	
	return "estado = 'Pendiente'";
}

/** \D Se elimina el recibo activo de la remesa. El pago asociado a la remesa debe ser el �ltimo asignado al recibo
\end */
function oficial_eliminarRecibo()
{
	if (!this.child("tdbRecibos").cursor().isValid())
		return;
	
	var recibo:String = this.child("tdbRecibos").cursor().valueBuffer("idrecibo");
	if (!this.iface.excluirReciboRemesa(recibo, this.cursor().valueBuffer("idremesa")))
		return 

	this.child("tdbRecibos").refresh();
	this.iface.actualizarTotal();
}

function oficial_excluirReciboRemesa(idRecibo:String, idRemesa:String):Boolean
{
	var util:FLUtil = new FLUtil;

	var cuentaValida:String = util.sqlSelect("reciboscli r LEFT OUTER JOIN cuentasbcocli c ON r.codcliente = c.codcliente", "r.idrecibo", "idrecibo = " + idRecibo + " AND (r.codcuenta = c.codcuenta OR r.codcuenta = '' OR r.codcuenta IS NULL)", "reciboscli,cuentasbcocli");
	if (!cuentaValida) {
		var codRecibo:String = util.sqlSelect("reciboscli", "codigo", "idrecibo = " + idRecibo);
		MessageBox.warning(util.translate("scripts", "La cuenta bancaria de la factura %1 no es una cuenta v�lida del cliente.\nCambie o borre la cuenta antes de excluir la factura de la remesa.").arg(codRecibo), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	
	var curRecibos:FLSqlCursor = new FLSqlCursor("reciboscli");
	var curPagosDev:FLSqlCursor = new FLSqlCursor("pagosdevolcli");
	var curFactura:FLSqlCursor = new FLSqlCursor("facturascli");
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
	curRecibos.setNull("idremesa");
	
	if (!curRecibos.commitBuffer())
		return false;

	return true;
}

function oficial_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();
	switch (fN) {
		/** \C En contabilidad integrada, si el usuario pulsa la tecla del punto '.', --codsubcuenta-- se informa automaticamente con el c�digo de cuenta m�s tantos ceros como sea necesario para completar la longitud de subcuenta asociada al ejercicio actual.
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
			/** \D Si el usuario selecciona una cuenta bancaria, se tomar� su cuenta contable asociada como --codcuenta-- contable para el pago.
				\end */
		case "codcuenta": {
			this.child("fdbIdSubcuenta").setValue(this.iface.calculateField("idsubcuentadefecto"));
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
	}
}

/** \D Rellena la tabla de asiento acumulado de la pesta�a de Contabilidad con los datos de contabilidad asociados a los recibos de la remesa
\end */
function oficial_asientoAcumulado()
{
	var util:FLUtil = new FLUtil;
	var totalFilas:Number = this.iface.tblResAsientos.numRows() - 1;
	var fila:Number;
	for (fila = totalFilas; fila >= 0; fila--)
		this.iface.tblResAsientos.removeRow(fila);
	
	var idRemesa = this.cursor().valueBuffer("idremesa");
	if (!idRemesa)
		return;
	var qryAsientos:FLSqlQuery = new FLSqlQuery();
	qryAsientos.setTablesList("reciboscli,pagosdevolcli,co_partidas");
	qryAsientos.setSelect("p.codsubcuenta, SUM(p.debe), SUM(p.haber)");
	qryAsientos.setFrom("reciboscli r INNER JOIN pagosdevolcli pd ON r.idrecibo = pd.idrecibo INNER JOIN co_partidas p ON pd.idasiento = p.idasiento");
	qryAsientos.setWhere("pd.idremesa = " + idRemesa + " GROUP BY p.codsubcuenta");
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

/** \D Asocia un recibo a una remesa, marc�ndolo como Pagado
@param	idRecibo: Identificador del recibo
@param	curRemesa: Cursor posicionado en la remesa
@return	true si la asociaci�n se realiza de forma correcta, false en caso contrario
\end */
function oficial_asociarReciboRemesa(idRecibo:String, curRemesa:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var idRemesa:String = curRemesa.valueBuffer("idremesa");
	
	if (util.sqlSelect("reciboscli", "coddivisa", "idrecibo = " + idRecibo) != curRemesa.valueBuffer("coddivisa")) {
		MessageBox.warning(util.translate("scripts", "No es posible incluir la factura.\nLa divisa de la factura y de la remesa deben ser la misma."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return;
	}

	var datosCuenta:Array = flfactppal.iface.pub_ejecutarQry("cuentasbanco", "ctaentidad,ctaagencia,cuenta", "codcuenta = '" + curRemesa.valueBuffer("codcuenta") + "'");
	if (datosCuenta.result != 1)
		return false;
	var dc:String = util.calcularDC(datosCuenta.ctaentidad + datosCuenta.ctaagencia) + util.calcularDC(datosCuenta.cuenta);

	var curRecibos:FLSqlCursor = new FLSqlCursor("reciboscli");
	var idFactura:Number;

	var fecha:String = curRemesa.valueBuffer("fecha");
	if (!this.iface.curPagosDev)
		this.iface.curPagosDev = new FLSqlCursor("pagosdevolcli");
	this.iface.curPagosDev.select("idrecibo = " + idRecibo + " ORDER BY fecha,idpagodevol");
	if (this.iface.curPagosDev.last()) {
		if (util.daysTo(this.iface.curPagosDev.valueBuffer("fecha"), fecha) < 0) {
			var codRecibo:String = util.sqlSelect("reciboscli", "codigo", "idrecibo = " + idRecibo);
			MessageBox.warning(util.translate("scripts", "Existen pagos con fecha igual o porterior a la de la remesa para la factura %1").arg(codRecibo), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	}

	curRecibos.select("idrecibo = " + idRecibo);
	if (curRecibos.next()) {
		curRecibos.setActivatedCheckIntegrity(false);
		curRecibos.setModeAccess(curRecibos.Edit);
		curRecibos.refreshBuffer();
		curRecibos.setValueBuffer("idremesa", idRemesa);
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
	this.iface.curPagosDev.setValueBuffer("codcuenta", curRemesa.valueBuffer("codcuenta"));
	this.iface.curPagosDev.setValueBuffer("ctaentidad", datosCuenta.ctaentidad);
	this.iface.curPagosDev.setValueBuffer("ctaagencia", datosCuenta.ctaagencia);
	this.iface.curPagosDev.setValueBuffer("dc", dc);
	this.iface.curPagosDev.setValueBuffer("cuenta", datosCuenta.cuenta);
	this.iface.curPagosDev.setValueBuffer("idremesa", idRemesa);
	this.iface.curPagosDev.setValueBuffer("nogenerarasiento", curRemesa.valueBuffer("nogenerarasiento"));
	if (parseFloat(curRemesa.valueBuffer("idsubcuenta")) == 0) {
		this.iface.curPagosDev.setNull("idsubcuenta");
		this.iface.curPagosDev.setNull("codsubcuenta");
	} else {
		this.iface.curPagosDev.setValueBuffer("idsubcuenta", curRemesa.valueBuffer("idsubcuenta"));
		this.iface.curPagosDev.setValueBuffer("codsubcuenta", curRemesa.valueBuffer("codsubcuenta"));
	}
	if (!this.iface.datosPagosDev(idRecibo, curRemesa))
		return false;

	if (!this.iface.curPagosDev.commitBuffer())
		return false;

	return true;
}

function oficial_datosPagosDev(idRecibo:String, curRemesa:FLSqlCursor):Boolean
{
	return true;
}

function oficial_cambiarEstado()
{
	this.child("fdbEstado").setValue(this.iface.calculateField("estado"));
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
