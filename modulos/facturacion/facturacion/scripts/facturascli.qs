/***************************************************************************
                 facturascli.qs  -  description
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
	function calculateField(fN:String):String { return this.ctx.interna_calculateField(fN); }
	function validateForm():Boolean { return this.ctx.interna_validateForm(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var bloqueoProvincia:Boolean;
	var lblDatosFacturaAbono:Object;
	var curLineaRectificacion_:FLSqlCursor;
	var pbnAplicarComision:Object;
    function oficial( context ) { interna( context ); } 
	function inicializarControles() {
		return this.ctx.oficial_inicializarControles();
	}
	function aplicarComision_clicked() {
		return this.ctx.oficial_aplicarComision_clicked();
	}
	function calcularTotales() {
		return this.ctx.oficial_calcularTotales();
	}
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function verificarHabilitaciones() {
		return this.ctx.oficial_verificarHabilitaciones();
	}
	function buscarFactura() {
		this.ctx.oficial_buscarFactura();
	}
	function mostrarDatosFactura(idFactura:String):Boolean {
		return this.ctx.oficial_mostrarDatosFactura(idFactura);
	}
	function mostrarTraza() {
		return this.ctx.oficial_mostrarTraza();
	}
	function actualizarLineasIva(curFactura:FLSqlCursor):Boolean {
		return this.ctx.oficial_actualizarLineasIva(curFactura);
	}
	function actualizarIvaClicked() {
		return this.ctx.oficial_actualizarIvaClicked();
	}
	function copiarLineasRec(idFacturaOriginal:String, factor:Number):Boolean {
		return this.ctx.oficial_copiarLineasRec(idFacturaOriginal, factor);
	}
	function copiarCampoLineaRec(nombreCampo:String, curLineaOriginal:FLSqlCursor, factor:Number):Boolean {
		return this.ctx.oficial_copiarCampoLineaRec(nombreCampo, curLineaOriginal, factor);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration numeroSecuencia */
//////////////////////////////////////////////////////////////////
//// NUMERO SECUENCIA ////////////////////////////////////////////
class numeroSecuencia extends oficial {
	function numeroSecuencia( context ) { oficial( context ); } 
	function init() {
		return this.ctx.numeroSecuencia_init();
	}
	function calculateField(fN:String):String {
		return this.ctx.numeroSecuencia_calculateField(fN);
	}
	function acceptedForm() {
		return this.ctx.numeroSecuencia_acceptedForm();
	}
	function bufferChanged(fN:String) {
		return this.ctx.numeroSecuencia_bufferChanged(fN);
	}
}
//// NUMERO SECUENCIA ////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration modoAccesso */
//////////////////////////////////////////////////////////////////
//// MODO ACCESO /////////////////////////////////////////////////
class modoAccesso extends numeroSecuencia {
	var modoAcceso:Number;
	function modoAccesso( context ) { numeroSecuencia( context ); } 
	function init() {
		return this.ctx.modoAccesso_init();
	}
	function getModoAcceso():Number {
		return this.ctx.modoAccesso_modoAcceso();
	}
}
//// MODO ACCESO /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration cantLineas */
//////////////////////////////////////////////////////////////////
//// CANT LINEAS /////////////////////////////////////////////////
class cantLineas extends modoAccesso {
	function cantLineas( context ) { modoAccesso( context ); } 
	function validateForm():Boolean {
		return this.ctx.cantLineas_validateForm();
	}
}
//// CANT LINEAS /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration habilitaciones */
//////////////////////////////////////////////////////////////////
//// HABILITACIONES //////////////////////////////////////////////
class habilitaciones extends cantLineas {
	function habilitaciones( context ) { cantLineas( context ); } 
	function verificarHabilitaciones() {
		return this.ctx.habilitaciones_verificarHabilitaciones();
	}
}
//// HABILITACIONES //////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration controlUsuario */
/////////////////////////////////////////////////////////////////
//// CONTROL_USUARIO ////////////////////////////////////////////
class controlUsuario extends habilitaciones {
    function controlUsuario( context ) { habilitaciones ( context ); }
	function init() {
		return this.ctx.controlUsuario_init();
	}
}
//// CONTROL_USUARIO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration silixExtensiones */
/////////////////////////////////////////////////////////////////
//// SILIX EXTENSIONES //////////////////////////////////////////
class silixExtensiones extends controlUsuario {
    function silixExtensiones( context ) { controlUsuario ( context ); }
	function init() {
		return this.ctx.silixExtensiones_init();
	}
	function validateForm():Boolean {
		return this.ctx.silixExtensiones_validateForm();
	}
	function inicializarControles() {
		return this.ctx.silixExtensiones_inicializarControles();
	}

}
//// SILIX EXTENSIONES //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ordenCampos */
/////////////////////////////////////////////////////////////////
//// ORDEN_CAMPOS ///////////////////////////////////////////////
class ordenCampos extends silixExtensiones {
    function ordenCampos( context ) { silixExtensiones ( context ); }
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
	function init() {
		this.ctx.tipoVenta_init();
	}
	function calculateField(fN:String):String {
		return this.ctx.tipoVenta_calculateField(fN);
	}
	function bufferChanged(fN:String) {
		return this.ctx.tipoVenta_bufferChanged(fN);
	}
}
//// TIPO DE VENTA  /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pieDocumento */
/////////////////////////////////////////////////////////////////
//// PIE DE DOCUMENTO ///////////////////////////////////////////
class pieDocumento extends tipoVenta {
	function pieDocumento( context ) { tipoVenta ( context ); }
	function init() {
		this.ctx.pieDocumento_init();
	}
	function calcularTotales() {
		this.ctx.pieDocumento_calcularTotales();
	}
	function actualizarPieDocumento(curFactura:FLSqlCursor):Boolean {
		return this.ctx.pieDocumento_actualizarPieDocumento(curFactura);
	}
	function actualizarLineasIva(curFactura:FLSqlCursor):Boolean {
		return this.ctx.pieDocumento_actualizarLineasIva(curFactura);
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
	function pub_actualizarLineasIva(curFactura:FLSqlCursor):Boolean {
		return this.actualizarLineasIva(curFactura);
	}
}
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubModoAccesso */
//////////////////////////////////////////////////////////////////
//// PUB MODO ACCESO /////////////////////////////////////////////
class pubModoAccesso extends ifaceCtx {
	function pubModoAccesso( context ) { ifaceCtx( context ); } 
	function pub_modoAcceso():Number {
		return this.getModoAcceso();
	}
}
//// PUB MODO ACCESO /////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

const iface = new pubModoAccesso( this );

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
/** \C
Este formulario realiza la gestión de los facturas a clientes.

Las facturas pueden ser generadas de forma manual o a partir de un remito o remitos (facturas automáticas).
\end */
function interna_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	this.iface.bloqueoProvincia = false;

	this.iface.lblDatosFacturaAbono = this.child("lblDatosFacturaAbono");
	this.iface.pbnAplicarComision = this.child("pbnAplicarComision");

    connect(this.iface.pbnAplicarComision, "clicked()", this, "iface.aplicarComision_clicked()");
	connect(this.child("tdbLineasFacturasCli").cursor(), "bufferCommited()", this, "iface.calcularTotales");
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.child("tbnBuscarFactura"), "clicked()", this, "iface.buscarFactura()");
	connect(this.child("tbnTraza"), "clicked()", this, "iface.mostrarTraza()");
	connect(this.child("tbnActualizarIva"), "clicked()", this, "iface.actualizarIvaClicked()");

	this.iface.pbnAplicarComision.setDisabled(true);

	if (cursor.modeAccess() == cursor.Insert) {
		this.child("fdbCodEjercicio").setValue(flfactppal.iface.pub_ejercicioActual());
		this.child("fdbCodDivisa").setValue(flfactppal.iface.pub_valorDefectoEmpresa("coddivisa"));
		this.child("fdbCodPago").setValue(flfactppal.iface.pub_valorDefectoEmpresa("codpago"));
		this.child("fdbCodAlmacen").setValue(flfactppal.iface.pub_valorDefectoEmpresa("codalmacen"));
		this.child("fdbTasaConv").setValue(util.sqlSelect("divisas", "tasaconv", "coddivisa = '" + this.child("fdbCodDivisa").value() + "'"));
		this.child("tbnBuscarFactura").setDisabled(true);
	}
	else {
		if (this.cursor().valueBuffer("decredito") == true || this.cursor().valueBuffer("dedebito") == true) {
			this.child("tbnBuscarFactura").setDisabled(false);
			this.iface.mostrarDatosFactura(util.sqlSelect("facturascli", "idfacturarect", "codigo = '" + this.child("fdbCodigo").value() + "'"));
		}
		else {
			this.child("tbnBuscarFactura").setDisabled(true);
		}
	}

	if (parseFloat(cursor.valueBuffer("idasiento")) != 0)
		this.child("ckbContabilizada").checked = true;

	if (cursor.valueBuffer("automatica") == true) {
//	Comentamos las siguientes líneas para permitir editar la cantidad de artículos que se facturan (servidos/parcial)
// 		this.child("toolButtomInsert").setDisabled(true);
// 		this.child("toolButtonDelete").setDisabled(true);
// 		this.child("toolButtonEdit").setDisabled(true);
// 		this.child("tdbLineasFacturasCli").setReadOnly(true);
		this.child("fdbCodCliente").setDisabled(true);
		this.child("fdbNombreCliente").setDisabled(true);
		this.child("fdbCifNif").setDisabled(true);
		this.child("fdbCodDivisa").setDisabled(true);
		this.child("fdbTasaConv").setDisabled(true);
	}
	this.iface.inicializarControles();
}

function interna_calculateField(fN:String):String
{
	return formfacturascli.iface.pub_commonCalculateField(fN, this.cursor());
}

function interna_validateForm()
{
	var cursor:FLSqlCursor = this.cursor();	

	var idFactura = cursor.valueBuffer("idfactura");
	if(!idFactura)
		return false;

	var codCliente = this.child("fdbCodCliente").value();
	
	if(!flfacturac.iface.pub_validarIvaCliente(codCliente,idFactura,"lineasfacturascli","idfactura"))
		return false;

	return true;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_inicializarControles()
{
	var util:FLUtil = new FLUtil();
	if (!sys.isLoadedModule("flcontppal") || !util.sqlSelect("empresa", "contintegrada", "1 = 1")) {
		this.child("tbwFactura").setTabEnabled("contabilidad", false);
	} else {
		this.child("tdbPartidas").setReadOnly(true);
	}

	this.child("tdbLineasIvaFactCli").setReadOnly(true);
	this.child("tbnActualizarIva").enabled = false;
	this.iface.verificarHabilitaciones();
}

function oficial_calcularTotales()
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();

	this.child("fdbNeto").setValue(this.iface.calculateField("neto"));
	this.child("fdbTotalIva").setValue(this.iface.calculateField("totaliva"));
	this.child("fdbTotal").setValue(this.iface.calculateField("total"));
	this.child("fdbComision").setValue(this.iface.calculateField("comision"));

	this.iface.actualizarLineasIva(this.cursor());
	this.child("tdbLineasIvaFactCli").refresh();
	this.child("tbnActualizarIva").enabled = false;

	this.iface.verificarHabilitaciones();
}

function oficial_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();
	switch (fN) {
		/** \C
		El --total-- es el --neto-- más el --totaliva--
		\end */
		case "neto":
		case "totaliva": {
			this.child("fdbTotal").setValue(this.iface.calculateField("total"));
			break;
		}
		/** \C
		El --totaleuros-- es el producto del --total-- por la --tasaconv--
		\end */
		case "total": {
			this.child("fdbTotalEuros").setValue(this.iface.calculateField("totaleuros"));
			this.child("fdbComision").setValue(this.iface.calculateField("comision"));
			break;
		}
		case "tasaconv": {
			this.child("fdbTotalEuros").setValue(this.iface.calculateField("totaleuros"));
			break;
		}
		/** \C
		El valor de --coddir-- por defecto corresponde a la dirección del cliente marcada como dirección de facturación
		\end */
		case "codcliente": {
			this.child("fdbCodDir").setValue("0");
			this.child("fdbCodDir").setValue(this.iface.calculateField("coddir"));
			this.child("fdbCodTarifa").setValue(this.iface.calculateField("codtarifa"));
			break;
		}
		case "decredito": {
			if (this.cursor().valueBuffer("decredito") == true) {
				this.cursor().setValueBuffer("dedebito", false);
				this.child("tbnBuscarFactura").setDisabled(false);
			}
			else {
				if (this.cursor().valueBuffer("dedebito") == false) {
					this.child("tbnBuscarFactura").setDisabled(true);
					this.iface.lblDatosFacturaAbono.text = "";
					if ( !this.cursor().isNull("idfacturarect") ) {
						this.cursor().setNull("idfacturarect");
						// restaurar la forma de pago predefinida para el cliente
						if ( this.cursor().isNull("codcliente")) {
							this.child("fdbCodPago").setValue(flfactppal.iface.pub_valorDefectoEmpresa("codpago"));
						}
						else {
							var codPago:String = util.sqlSelect("clientes", "codpago", "codcliente = '" + this.cursor().valueBuffer("codcliente") + "'");
							this.child("fdbCodPago").setValue(codPago);
						}
					}
					this.cursor().setValueBuffer("codigorect", "");
				}
			}
			break;
		}
		case "dedebito": {
			if (this.cursor().valueBuffer("dedebito") == true) {
				this.cursor().setValueBuffer("decredito", false);
				this.child("tbnBuscarFactura").setDisabled(false);
			}
			else {
				if (this.cursor().valueBuffer("decredito") == false) {
					this.child("tbnBuscarFactura").setDisabled(true);
					this.iface.lblDatosFacturaAbono.text = "";
					if ( !this.cursor().isNull("idfacturarect") ) {
						this.cursor().setNull("idfacturarect");
						// restaurar la forma de pago predefinida para el cliente
						if ( this.cursor().isNull("codcliente")) {
							this.child("fdbCodPago").setValue(flfactppal.iface.pub_valorDefectoEmpresa("codpago"));
						}
						else {
							var codPago:String = util.sqlSelect("clientes", "codpago", "codcliente = '" + this.cursor().valueBuffer("codcliente") + "'");
							this.child("fdbCodPago").setValue(codPago);
						}
					}
					this.cursor().setValueBuffer("codigorect", "");
				}
			}
			break;
		}
		case "provincia": {
			if (!this.iface.bloqueoProvincia) {
				this.iface.bloqueoProvincia = true;
				flfactppal.iface.pub_obtenerProvincia(this);
				this.iface.bloqueoProvincia = false;
			}
			break;
		}
		case "idprovincia": {
			if (cursor.valueBuffer("idprovincia") == 0)
				cursor.setNull("idprovincia");
			break;
		}
		case "coddir": {
			this.child("fdbProvincia").setValue(this.iface.calculateField("provincia"));
			this.child("fdbCodPais").setValue(this.iface.calculateField("codpais"));
			break;
		}
		case "codagente": {
			this.iface.pbnAplicarComision.setDisabled(false);
			break;
		}
	}
}

function oficial_verificarHabilitaciones()
{
		var util:FLUtil = new FLUtil();
		if (!util.sqlSelect("lineasfacturascli", "idfactura", "idfactura = " + this.cursor().valueBuffer("idfactura"))) {
				this.child("fdbCodAlmacen").setDisabled(false);
				this.child("fdbCodDivisa").setDisabled(false);
				this.child("fdbTasaConv").setDisabled(false);
				this.child("fdbCodTarifa").setDisabled(false);
		} else {
				this.child("fdbCodAlmacen").setDisabled(true);
				this.child("fdbCodDivisa").setDisabled(true);
				this.child("fdbTasaConv").setDisabled(true);
				this.child("fdbCodTarifa").setDisabled(true);
		}
}

/* \D Muestra el formulario de busqueda de facturas de cliente filtrando las facturas 
que no estan abonadas y que no son la factura que se esta editando.
\end */
function oficial_buscarFactura()
{
	var ruta:Object = new FLFormSearchDB("busfactcli");
	var curFacturas:FLSqlCursor = ruta.cursor();
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();
	
	var codCliente:String = cursor.valueBuffer("codcliente");
	var masFiltro:String = "";
	if (codCliente)
		masFiltro += " AND codcliente = '" + codCliente + "'";
	
	if (cursor.modeAccess() == cursor.Insert)
		curFacturas.setMainFilter("rectificada = false AND decredito = false AND dedebito = false" + masFiltro);
	else
		curFacturas.setMainFilter("rectificada = false AND decredito = false AND dedebito = false AND idfactura <> " + this.cursor().valueBuffer("idfactura") + masFiltro);

	ruta.setMainWidget();
	var idFactura:String = ruta.exec("idfactura");

	if (!idFactura) {
		return false;
	}

	var query:FLSqlQuery = new FLSqlQuery();
	query.setTablesList("facturascli");
	query.setSelect("codigo, codpago");
	query.setFrom("facturascli");
	query.setWhere("idfactura = '" + idFactura + "'");
	if (!query.exec() || !query.next())
		return;

	cursor.setValueBuffer("idfacturarect", idFactura);
	cursor.setValueBuffer("codigorect", query.value(0));
	cursor.setValueBuffer("codpago", query.value(1));
	this.iface.mostrarDatosFactura(idFactura);

	var opciones:Array = [util.translate("scripts", "Copiar líneas de la factura"), util.translate("scripts", "Copiar líneas de la factura con cantidad negativa"), util.translate("scripts", "No copiar líneas")];
	var opcion:Number = flfactppal.iface.pub_elegirOpcion(opciones);
	switch (opcion) {
		case 0: {
			if (!this.iface.copiarLineasRec(idFactura, 1)) {
				return false;
			}
			break;
		}
		case 1: {
			if (!this.iface.copiarLineasRec(idFactura, -1)) {
				return false;
			}
			break;
		}
	}
}

function oficial_copiarLineasRec(idFacturaOriginal:String, factor:Number):Boolean
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
debug(1);
	if (cursor.modeAccess() == cursor.Insert) {
		var curLineas:FLSqlCursor = this.child("tdbLineasFacturasCli").cursor();
		if (!curLineas.commitBufferCursorRelation()) {
			return false;
		}
	}

	var curLineaOriginal:FLSqlCursor = new FLSqlCursor("lineasfacturascli");
	this.iface.curLineaRectificacion_ = new FLSqlCursor("lineasfacturascli");

	var camposLinea:Array = util.nombreCampos("lineasfacturascli");
	var totalCampos:Number = camposLinea[0];
	curLineaOriginal.select("idfactura = " + idFacturaOriginal + " ORDER BY idlinea");
	while (curLineaOriginal.next()) {
debug(2);
		curLineaOriginal.setModeAccess(curLineaOriginal.Browse);
		curLineaOriginal.refresh();
		this.iface.curLineaRectificacion_.setModeAccess(this.iface.curLineaRectificacion_.Insert);
		this.iface.curLineaRectificacion_.refresh();

		for (var i:Number = 1; i <= totalCampos; i++) {
			if (!this.iface.copiarCampoLineaRec(camposLinea[i], curLineaOriginal, factor)) {
debug(3);
				return false;
			}
		}
		if (!this.iface.curLineaRectificacion_.commitBuffer()) {
debug(4);
			return false;
		}
	}
	this.iface.calcularTotales();
	this.child("tdbLineasFacturasCli").refresh();

	return true;
}

function oficial_copiarCampoLineaRec(nombreCampo:String, curLineaOriginal:FLSqlCursor, factor:Number):Boolean
{
	var cursor:FLSqlCursor = this.cursor();
	switch (nombreCampo) {
		case "idlinea":
		case "idalbaran": {
			return true;
			break;
		}
		case "idfactura": {
			this.iface.curLineaRectificacion_.setValueBuffer("idfactura", cursor.valueBuffer("idfactura"));
			break;
		}
		case "cantidad":
		case "dtolineal":
		case "pvpsindto":
		case "pvptotal":
		case "totalconiva": {
			this.iface.curLineaRectificacion_.setValueBuffer(nombreCampo, curLineaOriginal.valueBuffer(nombreCampo) * factor);
			break;
		}
		default: {
			if (curLineaOriginal.isNull(nombreCampo)) {
				this.iface.curLineaRectificacion_.setNull(nombreCampo);
			} else {
				this.iface.curLineaRectificacion_.setValueBuffer(nombreCampo, curLineaOriginal.valueBuffer(nombreCampo));
			}
		}
	}
	return true;
}


/* \D Compone los datos dela factura a abonar en un label
@param	idFactura: identificador de la factura
@return	VERDADERO si no hay error. FALSO en otro caso
\end */
function oficial_mostrarDatosFactura(idFactura:String):Boolean
{
	var util:FLUtil = new FLUtil();
	var q:FLSqlQuery = new FLSqlQuery();
	
	q.setTablesList("facturascli");
	q.setSelect("codigo,fecha");
	q.setFrom("facturascli");
	q.setWhere("idfactura = '" + idFactura + "'");
	if (!q.exec())
		return false;
	if (!q.first())
		return false;
	var codFactura:String = q.value(0);
	var fecha:String = util.dateAMDtoDMA(q.value(1));
	this.iface.lblDatosFacturaAbono.text = "Rectifica a la factura  " + codFactura + " con fecha " + fecha;
	
	return true;
}

function oficial_mostrarTraza()
{
	flfacturac.iface.pub_mostrarTraza(this.cursor().valueBuffer("codigo"), "facturascli");
}

/** \D
Actualiza (borra y reconstruye) los datos referentes a la factura en la tabla de agrupaciones por IVA (lineasivafactcli)
@param idFactura: Identificador de la factura
\end */
function oficial_actualizarLineasIva(curFactura:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var idFactura:String;
	try {
		idFactura = curFactura.valueBuffer("idfactura");
	} catch (e) {
		// Antes se recibía sólo idFactura
		MessageBox.critical(util.translate("scripts", "Hay un problema con la actualización de su personalización.\nPor favor, póngase en contacto con InfoSiAL para solucionarlo"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	var netoExacto:Number = curFactura.valueBuffer("neto");
	var ivaExacto:Number = curFactura.valueBuffer("totaliva");
	
	if (!util.sqlDelete("lineasivafactcli", "idfactura = " + idFactura))
		return false;

	var codImpuestoAnt:Number = 0;
	var codImpuesto:Number = 0;
	var iva:Number;
	var totalNeto:Number = 0;
	var totalIva:Number = 0;
	var totalLinea:Number = 0;
	var acumNeto:Number = 0;
	var acumIva:Number = 0;
	
	var curLineaIva:FLSqlCursor = new FLSqlCursor("lineasivafactcli");
	var qryLineasFactura:FLSqlQuery = new FLSqlQuery;
	with (qryLineasFactura) {
		setTablesList("lineasfacturascli");
		setSelect("codimpuesto, iva, pvptotal");
		setFrom("lineasfacturascli");
		setWhere("idfactura = " + idFactura + " AND pvptotal <> 0 ORDER BY codimpuesto");
		setForwardOnly(true);
	}
	if (!qryLineasFactura.exec()) {
		return false;
	}

	var regIva:String = flfacturac.iface.pub_regimenIVACliente(curFactura);
	
	
	while (qryLineasFactura.next()) {
		codImpuesto = qryLineasFactura.value("codimpuesto");
		if (codImpuestoAnt != 0 && codImpuestoAnt != codImpuesto) {
			totalNeto = util.roundFieldValue(totalNeto, "lineasivafactcli", "neto");
			totalIva = util.roundFieldValue((iva * totalNeto) / 100, "lineasivafactcli", "totaliva");
			totalLinea = parseFloat(totalNeto) + parseFloat(totalIva);
			totalLinea = util.roundFieldValue(totalLinea, "lineasivafactcli", "totallinea");
			
			acumNeto += parseFloat(totalNeto);
			acumIva += parseFloat(totalIva);

			with(curLineaIva) {
				setModeAccess(Insert);
				refreshBuffer();
				setValueBuffer("idfactura", idFactura);
				setValueBuffer("codimpuesto", codImpuestoAnt);
				setValueBuffer("iva", iva);
				setValueBuffer("neto", totalNeto);
				setValueBuffer("totaliva", totalIva);
				setValueBuffer("totallinea", totalLinea);
			}
			if (!curLineaIva.commitBuffer())
					return false;
			totalNeto = 0;
		}
		codImpuestoAnt = codImpuesto;
		if (regIva == "Exento") {
			iva = 0;
		} else {
			iva = parseFloat(qryLineasFactura.value("iva"));
		}
		totalNeto += parseFloat(qryLineasFactura.value("pvptotal"));
	}

	if (totalNeto != 0) {
		totalNeto = util.roundFieldValue(netoExacto - acumNeto, "lineasivafactcli", "neto");
		totalIva = util.roundFieldValue(ivaExacto - acumIva, "lineasivafactcli", "totaliva");
		totalLinea = parseFloat(totalNeto) + parseFloat(totalIva);
		totalLinea = util.roundFieldValue(totalLinea, "lineasivafactcli", "totallinea");

		with(curLineaIva) {
			setModeAccess(Insert);
			refreshBuffer();
			setValueBuffer("idfactura", idFactura);
			setValueBuffer("codimpuesto", codImpuestoAnt);
			setValueBuffer("iva", iva);
			setValueBuffer("neto", totalNeto);
			setValueBuffer("totaliva", totalIva);
			setValueBuffer("totallinea", totalLinea);
		}
		if (!curLineaIva.commitBuffer())
			return false;
	}
	return true;
}

/** \D Llama a la función de actualizar líneas de IVA cuando se pulsa el botón
\end */
function oficial_actualizarIvaClicked()
{
	this.iface.actualizarLineasIva(this.cursor());
	this.child("tdbLineasIvaFactCli").refresh();
	this.child("tbnActualizarIva").enabled = false;
}

function oficial_aplicarComision_clicked()
{
	var util:FLUtil;
	
	var idFactura:Number = this.cursor().valueBuffer("idfactura");
	if(!idFactura)
		return;
	var codAgente:String = this.cursor().valueBuffer("codagente");
	if(!codAgente || codAgente == "")
		return;

	var res:Number = MessageBox.information(util.translate("scripts", "¿Seguro que desea actualizar la comisión en todas las líneas?"), MessageBox.Yes, MessageBox.No);
	if(res != MessageBox.Yes)
		return;

	var cursor:FLSqlCursor = new FLSqlCursor("empresa");
	cursor.transaction(false);

	try {
		if(!flfacturac.iface.pub_aplicarComisionLineas(codAgente,"lineasfacturascli","idfactura = " + idFactura)) {
			cursor.rollback();
			return;
		}
		else {
			cursor.commit();
		}
	} catch (e) {
		MessageBox.critical(util.translate("scripts", "Hubo un error al aplicarse la comisión en las líneas.\n%1").arg(e), MessageBox.Ok, MessageBox.NoButton);
		cursor.rollback();
		return false;
	}

	MessageBox.information(util.translate("scripts", "La comisión se actualizó correctamente."), MessageBox.Ok, MessageBox.NoButton);
	this.iface.pbnAplicarComision.setDisabled(true);
	this.child("tdbLineasFacturasCli").refresh();
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition numeroSecuencia */
/////////////////////////////////////////////////////////////////
//// NUMERO SECUENCIA ///////////////////////////////////////////

function numeroSecuencia_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	if (cursor.modeAccess() == cursor.Insert) {
		var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
		var codSerie:String = this.iface.calculateField("codserie");
		// Inicialización del número de secuencia de la factura
		var idSec:Number = util.sqlSelect("secuenciasejercicios", "id", "codejercicio = '" + codEjercicio + "' AND codserie = '" + codSerie + "'");
		var numero:Number = util.sqlSelect("secuencias", "valorout", "id = " + idSec + " AND nombre = 'nfacturacli'");
		if ( !numero || isNaN(numero) )
			numero = 0;
		this.child("fdbNumero").setValue(numero.toString());
	}

	this.iface.__init();
}

function numeroSecuencia_calculateField(fN:String):String
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	var valor:String;
	switch (fN) {
		case "numero": {
			var idSec:Number = util.sqlSelect("secuenciasejercicios", "id", "codejercicio = '" + this.child("fdbCodEjercicio").value() + "' AND codserie = '" + this.child("fdbCodSerie").value() + "'");
			if (!idSec) {
				valor = 0;
				break;
			}
			var numero:Number = util.sqlSelect("secuencias", "valorout", "id = " + idSec + " AND nombre = 'nfacturacli'");
			if ( !numero || isNaN(numero) )
				numero = 0;
			valor = numero.toString();
			break;
		}
		default:
			valor = formfacturascli.iface.pub_commonCalculateField(fN, this.cursor());
			break;
	}
	return valor;
}

function numeroSecuencia_acceptedForm()
{
	// al aceptar la factura se incrementa el número de secuencia
	var cursorFactura:FLSqlCursor = this.cursor();
	if ( this.iface.modoAcceso == this.cursor().Insert ) {
		var cursorSecuencias:FLSqlCursor = new FLSqlCursor("secuenciasejercicios");
		cursorSecuencias.setActivatedCheckIntegrity(false);
		cursorSecuencias.select("upper(codserie) = '" + cursorFactura.valueBuffer("codserie") + "' AND upper(codejercicio) = '" + cursorFactura.valueBuffer("codejercicio") + "'");
		if (cursorSecuencias.next()) {
			var cursorSecs:FLSqlCursor = new FLSqlCursor( "secuencias" );
			cursorSecs.setActivatedCheckIntegrity( false );
			var idSec:Number = cursorSecuencias.valueBuffer( "id" );
			cursorSecs.select( "id = " + idSec + " AND nombre = 'nfacturacli'" );
			if (cursorSecs.next()) {
				cursorSecs.setModeAccess( cursorSecs.Edit );
				cursorSecs.refreshBuffer();
				var numerosiguiente:Number = parseInt(cursorFactura.valueBuffer("numero"), 10) + 1;
				cursorSecs.setValueBuffer( "valorout", numerosiguiente );
				cursorSecs.commitBuffer();
			}
			else {
				cursorSecs.setModeAccess( cursorSecs.Insert );
				cursorSecs.refreshBuffer();
				cursorSecs.setValueBuffer( "id", idSec );
				cursorSecs.setValueBuffer( "nombre", "nfacturacli" );
				cursorSecs.setValueBuffer( "valor", 1 );
				var numerosiguiente:Number = parseInt(cursor.valueBuffer("numerosecuencia"), 10) + 1;
				cursorSecs.setValueBuffer( "valorout", numerosiguiente );
				cursorSecs.commitBuffer();
			}
			cursorSecs.setActivatedCheckIntegrity( true );
		}
		cursorSecuencias.setActivatedCheckIntegrity(true);
	}
}

function numeroSecuencia_bufferChanged(fN:String)
{
	this.iface.__bufferChanged(fN);

	if (fN == "codserie")
		this.child("fdbNumero").setValue(this.iface.calculateField("numero"));

}

//// NUMERO SECUENCIA /////////////////////////////////////////
///////////////////////////////////////////////////////////////

/** @class_definition modoAccesso */
/////////////////////////////////////////////////////////////////
//// MODO ACCESO ////////////////////////////////////////////////

function modoAccesso_init()
{
	// se toma nota del modo de acceso
	this.iface.modoAcceso = this.cursor().modeAccess();

	this.iface.__init();
}

function modoAccesso_modoAcceso():Number
{
	return this.iface.modoAcceso;
}

//// MODO ACCESO //////////////////////////////////////////////
///////////////////////////////////////////////////////////////

/** @class_definition cantLineas */
/////////////////////////////////////////////////////////////////
//// CANT LINEAS ////////////////////////////////////////////////

function cantLineas_validateForm()
{
	if ( !this.iface.__validateForm() )
		return false;

	// Chequear que haya alguna línea cargada, y que no superen el número de 34
	var hayLineas:FLSqlCursor = this.child("tdbLineasFacturasCli").cursor();
	hayLineas.select("idfactura = " + this.cursor().valueBuffer("idfactura"));
	if (hayLineas.size() < 1) {
		return false;
	}
	else if (hayLineas.size() > 34) {
		MessageBox.warning("Hay demasiadas líneas de artículos:\nel límite máximo por documento es 34.", MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	return true;
}

//// CANT LINEAS //////////////////////////////////////////////
///////////////////////////////////////////////////////////////

/** @class_definition habilitaciones */
//////////////////////////////////////////////////////////////////
//// HABILITACIONES //////////////////////////////////////////////

function habilitaciones_verificarHabilitaciones()
{
	this.iface.__verificarHabilitaciones();

	// si ya se creó, no permitir cambiar el tipo de venta, codserie ni número
	if ( this.cursor().modeAccess() == this.cursor().Insert ) {
		this.child("fdbTipoVenta").setDisabled(false);
	} else {
		this.child("fdbTipoVenta").setDisabled(true);
	}
	if ( this.iface.modoAcceso == this.cursor().Insert ) {
		this.child("fdbNumero").setDisabled(false);
	} else {
		this.child("fdbNumero").setDisabled(true);
	}
}

//// HABILITACIONES //////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition controlUsuario */
/////////////////////////////////////////////////////////////////
//// CONTROL_USUARIO ////////////////////////////////////////////

function controlUsuario_init()
{
	if (this.cursor().modeAccess() == this.cursor().Insert) {
		if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
			flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Facturas");
		}
	}

	this.iface.__init();
}

//// CONTROL_USUARIO //////////////////////////////////////////
///////////////////////////////////////////////////////////////

/** @class_definition silixExtensiones */
/////////////////////////////////////////////////////////////////
//// SILIX EXTENSIONES //////////////////////////////////////////

function silixExtensiones_init()
{
	var util:FLUtil = new FLUtil();
	if (sys.isLoadedModule("flfactcuentas") && flfactppal.iface.pub_valorDefectoEmpresa("cuentascajaintegrada")) {
		this.cursor().setValueBuffer("codcaja", util.sqlSelect("ctas_datosgenerales","cajafacturascli","1 = 1"));
	}
	this.child("tdbValores").cursor().setAction("factclivalores");

	this.iface.__init();
}

function silixExtensiones_validateForm()
{
	var util:FLUtil = new FLUtil();
	if ( !this.iface.__validateForm() )
		return false;

	if (sys.isLoadedModule("flfactcuentas") && flfactppal.iface.pub_valorDefectoEmpresa("cuentascajaintegrada")) {
		var comprobante = util.sqlSelect("ctas_datosgenerales","comprobantefacturascli","1 = 1");
		if (!comprobante) {
			MessageBox.warning(util.translate("scripts",
			"No se ha asociado un tipo de comprobante para las Facturas de Cliente en el módulo de Cuentas.\nEn 'Datos generales' debe seleccionar un comprobante para esta operación\n"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
		if (this.cursor().valueBuffer("codcaja") == "") {
			MessageBox.warning(util.translate("scripts",
			"No ha indicado la cuenta caja donde se registrará el ingreso de los valores de pago.\nIngrésela en la pestaña \"Datos de Pago\"\n"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
	}

	// Los pagos, si se introducen, deben producir un total igual al total de la factura
	var curValores:FLSqlCursor = new FLSqlCursor("factvalores");
	curValores.select("idfactura = " + this.cursor().valueBuffer("idfactura"));
	if (curValores.size() > 0) {
		var totalFactura:Number = parseFloat(this.cursor().valueBuffer("total"));
		var totalPagos = parseFloat(util.sqlSelect("factvalores", "SUM(monto)", "idfactura = " + this.cursor().valueBuffer("idfactura")));
		var diferencia:Number = util.roundFieldValue((totalFactura - totalPagos), "facturascli", "total");
		if (diferencia > 0) {
			if (this.cursor().valueBuffer("codpago") == "CTACTE") {
				var ans = MessageBox.warning(util.translate("scripts", "El monto de los pagos es menor que el total de la factura.\n\nEl saldo se cargará a la Cuenta Corriente. ¿Continuar?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
				if (ans == MessageBox.No)
					return false;
			}
			else {
				MessageBox.warning(util.translate("scripts", "El monto de los pagos es menor que el total de la factura"), MessageBox.Ok, MessageBox.NoButton);
				return false;
			}
		}
	}

	return true;
}

function silixExtensiones_inicializarControles()
{
	this.iface.__inicializarControles();

	var util:FLUtil = new FLUtil();
	if (!sys.isLoadedModule("flfactcuentas") || !flfactppal.iface.pub_valorDefectoEmpresa("cuentascajaintegrada")) {
		this.child("tbwFactura").setTabEnabled("datosPago", false);
	}
}
//// SILIX EXTENSIONES //////////////////////////////////////////
///////////////////////////////////////////////////////////////

/** @class_definition ordenCampos */
/////////////////////////////////////////////////////////////////
//// ORDEN_CAMPOS ///////////////////////////////////////////////

function ordenCampos_init()
{
	this.iface.__init();

	var orden:Array = [ "referencia", "descripcion", "cantidad", "pvpunitario", "pvpsindto", "pvptotal", "totalconiva", "codimpuesto", "iva", "dtolineal", "dtopor", "porcomision", "costounitario", "costototal", "ganancia", "utilidad", "numserie" ];

	this.child("tdbLineasFacturasCli").setOrderCols(orden);
}

//// ORDEN_CAMPOS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition tipoVenta */
//////////////////////////////////////////////////////////////////
//// TIPO VENTA //////////////////////////////////////////////////

function tipoVenta_init()
{
	this.iface.__init();

	if ( this.iface.modoAcceso == this.cursor().Insert )
		this.iface.bufferChanged("tipoventa");
}

function tipoVenta_calculateField(fN:String):String
{
	var valor:String;
	
	switch (fN) {
		case "codserie": {
			switch (this.cursor().valueBuffer("tipoventa")) {
				case "Factura A": {
					valor = flfactppal.iface.pub_valorDefectoEmpresa("codserie_a");
					break;
				}
				case "Factura B": {
					valor = flfactppal.iface.pub_valorDefectoEmpresa("codserie_b");
					break;
				}
				case "Factura C": {
					valor = flfactppal.iface.pub_valorDefectoEmpresa("codserie_c");
					break;
				}
			}
			break;
		}
		default: {
			valor = this.iface.__calculateField(fN);
		}
	}
	return valor;
}

function tipoVenta_bufferChanged(fN:String)
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	switch (fN) {
		case "tipoventa": {
			this.child("fdbCodSerie").setValue(this.iface.calculateField("codserie"));
			break;
		}
		case "codcliente": {
			if (cursor.valueBuffer("codcliente") && cursor.valueBuffer("codcliente") != "") {
				var regimenIva:Boolean = util.sqlSelect("clientes", "regimeniva", "codcliente = '" + cursor.valueBuffer("codcliente") + "'");
				switch ( regimenIva ) {
					case "Consumidor Final":
					case "Exento":
					case "No Responsable":
					case "Responsable Monotributo": {
						cursor.setValueBuffer("tipoventa", "Factura B");
						break;
					}
					case "Responsable Inscripto":
					case "Responsable No Inscripto": {
						cursor.setValueBuffer("tipoventa", "Factura A");
						break;
					}
				}
			}
			this.iface.__bufferChanged(fN);
			break;
		}
		default:
			this.iface.__bufferChanged(fN);
	}
}
//// TIPO VENTA //////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition pieDocumento */
//////////////////////////////////////////////////////////////////
//// PIE DE DOCUMENTO ////////////////////////////////////////////

function pieDocumento_init()
{
	this.iface.__init();

	connect(this.child("tdbPieDocumento").cursor(), "bufferCommited()", this, "iface.calcularTotales");

	this.child("tdbLineasIvaFactCli").setFindHidden(true);
	this.child("tdbLineasIvaFactCli").setFilterHidden(true);

	this.child("tdbPieDocumento").setFindHidden(true);
	this.child("tdbPieDocumento").setFilterHidden(true);
}

function pieDocumento_bufferChanged(fN:String)
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	switch (fN) {
		case "totalpie": {
			this.child("fdbTotal").setValue(this.iface.calculateField("total"));
			break;
		}
		default:
			this.iface.__bufferChanged(fN);
	}
}

function pieDocumento_calcularTotales()
{
	this.child("fdbTotalPie").setValue(this.iface.calculateField("totalpie"));

	this.iface.__calcularTotales();

	this.iface.actualizarPieDocumento(this.cursor());

}

function pieDocumento_actualizarPieDocumento(curFactura:FLSqlCursor):Boolean
{
	// Acá se deberían actualizar los pie de factura que dependan del neto

	return true;
}

function pieDocumento_actualizarLineasIva(curFactura:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var idFactura:String = curFactura.valueBuffer("idfactura");

	var netoExacto:Number = curFactura.valueBuffer("neto");
	var ivaExacto:Number = curFactura.valueBuffer("totaliva");
	
	if (!util.sqlDelete("lineasivafactcli", "idfactura = " + idFactura))
		return false;

	var codImpuestoAnt:Number = 0;
	var codImpuesto:Number = 0;
	var iva:Number;
	var totalNeto:Number = 0;
	var totalIva:Number = 0;
	var totalLinea:Number = 0;
	var acumNeto:Number = 0;
	var acumIva:Number = 0;
	
	var curLineaIva:FLSqlCursor = new FLSqlCursor("lineasivafactcli");
	var qryLineasFactura:FLSqlQuery = new FLSqlQuery;
	with (qryLineasFactura) {
		setTablesList("lineasfacturascli,piefacturascli,piedocumentos");
		setSelect("li.codimpuesto, li.iva, li.pvptotal");
		setFrom("( SELECT lf.codimpuesto, lf.iva, lf.pvptotal FROM lineasfacturascli AS lf WHERE lf.idfactura = " + idFactura + " AND lf.pvptotal <> 0 UNION SELECT pd.codimpuesto, pf.totaliva, pf.totalinc FROM piefacturascli AS pf INNER JOIN piedocumentos AS pd ON pf.codpie = pd.codpie WHERE pf.idfactura = " + idFactura + " AND pf.incluidoneto = true AND pf.totalinc <> 0) AS li");
		setWhere("1=1");
		setOrderBy("li.codimpuesto");
		setForwardOnly(true);
	}
	if (!qryLineasFactura.exec()) {
		return false;
	}

	var regIva:String = flfacturac.iface.pub_regimenIVACliente(curFactura);
	
	while (qryLineasFactura.next()) {
		codImpuesto = qryLineasFactura.value("li.codimpuesto");
		if (codImpuestoAnt != 0 && codImpuestoAnt != codImpuesto) {

			totalNeto = util.roundFieldValue(totalNeto, "lineasivafactcli", "neto");
			totalIva = util.roundFieldValue((iva * totalNeto) / 100, "lineasivafactcli", "totaliva");
			totalLinea = parseFloat(totalNeto) + parseFloat(totalIva);
			totalLinea = util.roundFieldValue(totalLinea, "lineasivafactcli", "totallinea");
			
			acumNeto += parseFloat(totalNeto);
			acumIva += parseFloat(totalIva);

			with(curLineaIva) {
				setModeAccess(Insert);
				refreshBuffer();
				setValueBuffer("idfactura", idFactura);
				setValueBuffer("codimpuesto", codImpuestoAnt);
				setValueBuffer("iva", iva);
				setValueBuffer("neto", totalNeto);
				setValueBuffer("totaliva", totalIva);
				setValueBuffer("totallinea", totalLinea);
			}
			if (!curLineaIva.commitBuffer())
					return false;
			totalNeto = 0;
		}
		codImpuestoAnt = codImpuesto;
		if (regIva == "Exento") {
			iva = 0;
		} else {
			iva = parseFloat(qryLineasFactura.value("li.iva"));
		}
		totalNeto += parseFloat(qryLineasFactura.value("li.pvptotal"));
	}

	if (totalNeto != 0) {
		totalNeto = util.roundFieldValue(netoExacto - acumNeto, "lineasivafactcli", "neto");
		totalIva = util.roundFieldValue(ivaExacto - acumIva, "lineasivafactcli", "totaliva");
		totalLinea = parseFloat(totalNeto) + parseFloat(totalIva);
		totalLinea = util.roundFieldValue(totalLinea, "lineasivafactcli", "totallinea");

		with(curLineaIva) {
			setModeAccess(Insert);
			refreshBuffer();
			setValueBuffer("idfactura", idFactura);
			setValueBuffer("codimpuesto", codImpuestoAnt);
			setValueBuffer("iva", iva);
			setValueBuffer("neto", totalNeto);
			setValueBuffer("totaliva", totalIva);
			setValueBuffer("totallinea", totalLinea);
		}
		if (!curLineaIva.commitBuffer())
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