/***************************************************************************
                 facturasprov.qs  -  description
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
	var lblDatosFacturaAbono:Object;
	var curLineaRectificacion_:FLSqlCursor;
    function oficial( context ) { interna( context ); } 
	function inicializarControles() {
		return this.ctx.oficial_inicializarControles();
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
	function actualizarLineasIva(curFactura:FLSqlCursor):Boolean {
		return this.ctx.oficial_actualizarLineasIva(curFactura);
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

/** @class_declaration controlUsuario */
/////////////////////////////////////////////////////////////////
//// CONTROL_USUARIO ////////////////////////////////////////////
class controlUsuario extends oficial {
    function controlUsuario( context ) { oficial ( context ); }
	function init() {
		return this.ctx.controlUsuario_init();
	}
}
//// CONTROL_USUARIO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration cantLineas */
//////////////////////////////////////////////////////////////////
//// CANT LINEAS /////////////////////////////////////////////////
class cantLineas extends controlUsuario {
	function cantLineas( context ) { controlUsuario( context ); } 
	function validateForm():Boolean {
		return this.ctx.cantLineas_validateForm();
	}
}
//// CANT LINEAS /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration ordenCampos */
/////////////////////////////////////////////////////////////////
//// ORDEN_CAMPOS ///////////////////////////////////////////////
class ordenCampos extends cantLineas {
    function ordenCampos( context ) { cantLineas ( context ); }
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

/** @class_declaration habilitaciones */
//////////////////////////////////////////////////////////////////
//// HABILITACIONES //////////////////////////////////////////////
class habilitaciones extends tipoVenta {
	function habilitaciones( context ) { tipoVenta( context ); } 
	function verificarHabilitaciones() {
		return this.ctx.habilitaciones_verificarHabilitaciones();
	}
}
//// HABILITACIONES //////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration pieDocumento */
/////////////////////////////////////////////////////////////////
//// PIE DE DOCUMENTO ///////////////////////////////////////////
class pieDocumento extends habilitaciones {
	function pieDocumento( context ) { habilitaciones ( context ); }
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

/** @class_declaration periodosFiscales */
/////////////////////////////////////////////////////////////////
//// PERIODOS FISCALES //////////////////////////////////////////
class periodosFiscales extends pieDocumento {
	function periodosFiscales( context ) { pieDocumento ( context ); }
	function init() {
		this.ctx.periodosFiscales_init();
	}
	function validateForm():Boolean {
		return this.ctx.periodosFiscales_validateForm();
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
	function pub_actualizarLineasIva(curFactura:FLSqlCursor):Boolean {
		return this.actualizarLineasIva(curFactura);
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
Este formulario realiza la gestión de los facturas a proveedores.

Las facturas pueden ser generadas de forma manual o a partir de un remito o remitos (facturas automáticas).
\end */
function interna_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	this.iface.lblDatosFacturaAbono = this.child("lblDatosFacturaAbono");
	connect(this.child("tdbLineasFacturasProv").cursor(), "bufferCommited()", this, "iface.calcularTotales");
	connect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.child("tbnBuscarFactura"), "clicked()", this, "iface.buscarFactura()");
	connect(this.child("tbnTraza"), "clicked()", this, "iface.mostrarTraza()");
	connect(this.child("tbnActualizarIva"), "clicked()", this, "iface.actualizarIvaClicked()");

	this.child("tbnBuscarFactura").setDisabled(true);
	if (cursor.modeAccess() == cursor.Insert) {
		this.child("fdbCodEjercicio").setValue(flfactppal.iface.pub_ejercicioActual());
		this.child("fdbCodDivisa").setValue(flfactppal.iface.pub_valorDefectoEmpresa("coddivisa"));
		this.child("fdbCodPago").setValue(flfactppal.iface.pub_valorDefectoEmpresa("codpago"));
		this.child("fdbCodAlmacen").setValue(flfactppal.iface.pub_valorDefectoEmpresa("codalmacen"));
		this.child("fdbTasaConv").setValue(util.sqlSelect("divisas", "tasaconv", "coddivisa = '" + this.child("fdbCodDivisa").value() + "'"));
	}
	else {
		if ( flfacturac.iface.pub_esNotaCredito(cursor.valueBuffer("tipoventa")) || flfacturac.iface.pub_esNotaDebito(cursor.valueBuffer("tipoventa")) ) {
			this.iface.mostrarDatosFactura(util.sqlSelect("facturasprov", "idfacturarect", "codigo = '" + this.child("fdbCodigo").value() + "'"));
			if (cursor.modeAccess() != cursor.Browse)
				this.child("tbnBuscarFactura").setDisabled(false);
		}
	}

	if (parseFloat(cursor.valueBuffer("idasiento")) != 0)
		this.child("ckbContabilizada").checked = true;

	if (cursor.valueBuffer("automatica") == true) {
		this.child("toolButtomInsert").setDisabled(true);
		this.child("toolButtonDelete").setDisabled(true);
		this.child("toolButtonEdit").setDisabled(true);
		this.child("tdbLineasFacturasProv").setReadOnly(true);
		this.child("fdbCodProveedor").setDisabled(true);
		this.child("fdbNombreProveedor").setDisabled(true);
		this.child("fdbCifNif").setDisabled(true);
		this.child("fdbCodDivisa").setDisabled(true);
		this.child("fdbTasaConv").setDisabled(true);
	}

	this.iface.inicializarControles();

	var filtroProveedor:String = "NOT debaja";
	this.child("fdbCodProveedor").setFilter(filtroProveedor);
}

function interna_calculateField(fN:String):String
{
	var valor:String;
	var cursor:FLSqlCursor = this.cursor();
	switch (fN) {
		case "total": {
			valor = formfacturasprov.iface.pub_commonCalculateField(fN, cursor);
			break;
		}
		default: {
			valor = formfacturasprov.iface.pub_commonCalculateField(fN, cursor);
			break;
		}
	}
	return valor;
}

function interna_validateForm()
{
	var cursor:FLSqlCursor = this.cursor();	
	var util:FLUtil = new FLUtil();

	var idFactura = cursor.valueBuffer("idfactura");
	if(!idFactura)
		return false;

	var codProveedor = this.child("fdbCodProveedor").value();
	var codproveedor = cursor.valueBuffer("codproveedor");
	var qryNum:FLSqlQuery = new FLSqlQuery;
	with (qryNum) {
		setTablesList("facturasprov");
		setSelect("numproveedor");
		setFrom("facturasprov");
		setWhere("idfactura <> " + idFactura + " AND codproveedor = '" + codproveedor + "'");
		setForwardOnly(true);
	}
	if (!qryNum.exec())
		return false;
	
	while (qryNum.next()) {
		if (qryNum.value("numproveedor") && qryNum.value("numproveedor") == cursor.valueBuffer("numproveedor")) {
		var res:Number = MessageBox.information(util.translate("scripts", "Hay otra factura con el mismo número de proveedor.\n¿Desea continuar?"), MessageBox.Yes, MessageBox.No);
		if (res != 	MessageBox.Yes)
			return false;
		}
	}

	if(!flfacturac.iface.pub_validarIvaProveedor(codProveedor,idFactura,"lineasfacturasprov","idfactura"))
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

	this.child("tdbLineasIvaFactprov").setReadOnly(true);
	this.child("tbnActualizarIva").enabled = false;
	this.iface.verificarHabilitaciones();
}

function oficial_calcularTotales()
{
	this.child("fdbNeto").setValue(this.iface.calculateField("neto"));
	this.child("fdbTotalIva").setValue(this.iface.calculateField("totaliva"));
	this.child("fdbTotal").setValue(this.iface.calculateField("total"));

	this.iface.actualizarLineasIva(this.cursor());
	this.child("tdbLineasIvaFactprov").refresh();
	this.child("tbnActualizarIva").enabled = false;

	this.iface.verificarHabilitaciones();
}

function oficial_bufferChanged(fN:String)
{
		var util:FLUtil = new FLUtil();
		switch (fN) {
		/** \C
		El --total-- es el --neto-- más el --totaliva--
		\end */
		case "neto":
		case "totaliva":{
						this.child("fdbTotal").setValue(this.iface.calculateField("total"));
						break;
				}
		/** \C
		El --totaleuros-- es el producto del --total-- por la --tasaconv--
		\end */
		case "total":
		case "tasaconv":{
						this.child("fdbTotalEuros").setValue(this.iface.calculateField("totaleuros"));
						break;
				}
	}
}

function oficial_verificarHabilitaciones()
{
		var util:FLUtil = new FLUtil();
		if (!util.sqlSelect("lineasfacturasprov", "idfactura", "idfactura = " + this.cursor().valueBuffer("idfactura"))) {
				this.child("fdbCodAlmacen").setDisabled(false);
				this.child("fdbCodDivisa").setDisabled(false);
				this.child("fdbTasaConv").setDisabled(false);
		} else {
				this.child("fdbCodAlmacen").setDisabled(true);
				this.child("fdbCodDivisa").setDisabled(true);
				this.child("fdbTasaConv").setDisabled(true);
		}
}

/** \D
Actualiza (borra y reconstruye) los datos referentes a la factura en la tabla de agrupaciones por IVA (lineasivafactprov)
@param curFactura: Cursor posicionado en la factura
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
	
	if (!util.sqlDelete("lineasivafactprov", "idfactura = " + idFactura))
		return false;

	var codImpuestoAnt:Number = 0;
	var codImpuesto:Number = 0;
	var iva:Number;
	var totalNeto:Number = 0;
	var totalIva:Number = 0;
	var totalLinea:Number = 0;
	var acumNeto:Number = 0;
	var acumIva:Number = 0;
	
	var curLineaIva:FLSqlCursor = new FLSqlCursor("lineasivafactprov");
	var qryLineasFactura:FLSqlQuery = new FLSqlQuery;
	with (qryLineasFactura) {
		setTablesList("lineasfacturasprov");
		setSelect("codimpuesto, iva, pvptotal");
		setFrom("lineasfacturasprov");
		setWhere("idfactura = " + idFactura + " AND pvptotal <> 0 ORDER BY codimpuesto");
		setForwardOnly(true);
	}
	if (!qryLineasFactura.exec())
		return false;
	
	while (qryLineasFactura.next()) {
		codImpuesto = qryLineasFactura.value("codimpuesto");
		if (codImpuestoAnt != 0 && codImpuestoAnt != codImpuesto) {
			totalNeto = util.roundFieldValue(totalNeto, "lineasivafactprov", "neto");
			totalIva = util.roundFieldValue((iva * totalNeto) / 100, "lineasivafactprov", "totaliva");
			totalLinea = parseFloat(totalNeto) + parseFloat(totalIva);
			totalLinea = util.roundFieldValue(totalLinea, "lineasivafactprov", "totallinea");
			
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
		iva = parseFloat(qryLineasFactura.value("iva"));
		totalNeto += parseFloat(qryLineasFactura.value("pvptotal"));
	}

	if (totalNeto != 0) {
		totalNeto = util.roundFieldValue(netoExacto - acumNeto, "lineasivafactprov", "neto");
		totalIva = util.roundFieldValue(ivaExacto - acumIva, "lineasivafactprov", "totaliva");
		totalLinea = parseFloat(totalNeto) + parseFloat(totalIva);
		totalLinea = util.roundFieldValue(totalLinea, "lineasivafactprov", "totallinea");

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

/* \D Muebra el formulario de busqueda de facturas de cliente filtrando las facturas 
que no estan abonadas y que no son la factura que se esta editando.
\end */
function oficial_buscarFactura()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	if ( cursor.isNull("codproveedor")) {
		MessageBox.warning(util.translate("scripts", "Debe indicar un Proveedor"), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	var ruta:Object = new FLFormSearchDB("busfactprov");
	var curFacturas:FLSqlCursor = ruta.cursor();
	
	var codProveedor:String = cursor.valueBuffer("codproveedor");
	var masFiltro:String = "";
	if (codProveedor)
		masFiltro += " AND codproveedor = '" + codProveedor + "'";
	
	if (cursor.modeAccess() == cursor.Insert)
		curFacturas.setMainFilter("rectificada = false AND tipoventa NOT LIKE 'Nota de %'" + masFiltro);
	else
		curFacturas.setMainFilter("rectificada = false AND tipoventa NOT LIKE 'Nota de %' AND idfactura <> " + cursor.valueBuffer("idfactura") + masFiltro);

	ruta.setMainWidget();
	var idFactura:String = ruta.exec("idfactura");

	if (!idFactura) {
		return false;
	}

	var query:FLSqlQuery = new FLSqlQuery();
	query.setTablesList("facturasprov");
	query.setSelect("codigo, codpago");
	query.setFrom("facturasprov");
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
		var curLineas:FLSqlCursor = this.child("tdbLineasFacturasProv").cursor();
		if (!curLineas.commitBufferCursorRelation()) {
			return false;
		}
	}

	var curLineaOriginal:FLSqlCursor = new FLSqlCursor("lineasfacturasprov");
	this.iface.curLineaRectificacion_ = new FLSqlCursor("lineasfacturasprov");

	var camposLinea:Array = util.nombreCampos("lineasfacturasprov");
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
	this.child("tdbLineasFacturasProv").refresh();

	return true;
}

function oficial_copiarCampoLineaRec(nombreCampo:String, curLineaOriginal:FLSqlCursor, factor:Number):Boolean
{
	var util:FLUtil = new FLUtil;
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
		case "cantidadprevia": {
			this.iface.curLineaRectificacion_.setValueBuffer(nombreCampo, 0);
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
		case "idsubcuenta": {
			if (curLineaOriginal.isNull(nombreCampo)) {
				this.iface.curLineaRectificacion_.setNull(nombreCampo);
			} else {
				this.iface.curLineaRectificacion_.setValueBuffer("idsubcuenta", util.sqlSelect("co_subcuentas", "idsubcuenta", "codsubcuenta = '" + curLineaOriginal.valueBuffer("codsubcuenta") + "' AND codejercicio = '" + cursor.valueBuffer("codejercicio") + "'"));
			}
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
	
	q.setTablesList("facturasprov");
	q.setSelect("codigo,fecha");
	q.setFrom("facturasprov");
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
	flfacturac.iface.pub_mostrarTraza(this.cursor().valueBuffer("codigo"), "facturasprov");
}

/** \D Llama a la función de actualizar líneas de IVA cuando se pulsa el botón
\end */
function oficial_actualizarIvaClicked()
{
	this.iface.actualizarLineasIva(this.cursor());
	this.child("tdbLineasIvaFactprov").refresh();
	this.child("tbnActualizarIva").enabled = false;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

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

/** @class_definition cantLineas */
/////////////////////////////////////////////////////////////////
//// CANT LINEAS ////////////////////////////////////////////////

function cantLineas_validateForm()
{
	if ( !this.iface.__validateForm() )
		return false;

	// Chequear que haya alguna línea cargada
	var hayLineas:FLSqlCursor = this.child("tdbLineasFacturasProv").cursor();
	hayLineas.select("idfactura = " + this.cursor().valueBuffer("idfactura"));
	if (hayLineas.size() < 1) {
		return false;
	}

	return true;
}

//// CANT LINEAS //////////////////////////////////////////////
///////////////////////////////////////////////////////////////

/** @class_definition ordenCampos */
/////////////////////////////////////////////////////////////////
//// ORDEN_CAMPOS ///////////////////////////////////////////////

function ordenCampos_init()
{
	this.iface.__init();

	var orden:Array = [ "referencia", "descripcion", "cantidad", "pvpunitario", "pvpsindto", "pvptotal", "totalconiva", "codimpuesto", "iva", "dtolineal", "dtopor", "numserie", "codsubcuenta" ];

	this.child("tdbLineasFacturasProv").setOrderCols(orden);
}

//// ORDEN_CAMPOS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition tipoVenta */
//////////////////////////////////////////////////////////////////
//// TIPO VENTA //////////////////////////////////////////////////

function tipoVenta_init()
{
	this.iface.__init();

	if ( this.cursor().modeAccess() == this.cursor().Insert )
		this.iface.bufferChanged("tipoventa");

	if ( this.cursor().modeAccess() == this.cursor().Edit )
		this.child("fdbTipoVenta").setDisabled(true);
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
				case "Nota de Crédito A": {
					valor = flfactppal.iface.pub_valorDefectoEmpresa("codserie_notacred_a");
					break;
				}
				case "Nota de Crédito B": {
					valor = flfactppal.iface.pub_valorDefectoEmpresa("codserie_notacred_b");
					break;
				}
				case "Nota de Débito A": {
					valor = flfactppal.iface.pub_valorDefectoEmpresa("codserie_notadeb_a");
					break;
				}
				case "Nota de Débito B": {
					valor = flfactppal.iface.pub_valorDefectoEmpresa("codserie_notadeb_b");
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

			if ( flfacturac.iface.pub_esNotaCredito(cursor.valueBuffer("tipoventa")) || flfacturac.iface.pub_esNotaDebito(cursor.valueBuffer("tipoventa")) ) {
				this.child("tbnBuscarFactura").setDisabled(false);
				this.child("tbwFactura").showPage("datos");
			} else {
				this.child("tbnBuscarFactura").setDisabled(true);
				this.iface.lblDatosFacturaAbono.text = "";

				if ( !cursor.isNull("idfacturarect") ) {
					cursor.setNull("idfacturarect");
					// restaurar la forma de pago predefinida para el proveedor
					if ( !cursor.isNull("codproveedor") ) {
						var codPago:String = util.sqlSelect("proveedores", "codpago", "codproveedor = '" + cursor.valueBuffer("codproveedor") + "'");
						this.child("fdbCodPago").setValue(codPago);
					}
				}
				cursor.setValueBuffer("codigorect", "");
			}

			break;
		}
		case "codproveedor": {
			if (cursor.valueBuffer("codproveedor") && cursor.valueBuffer("codproveedor") != "") {
				var regimenIva:Boolean = util.sqlSelect("proveedores", "regimeniva", "codproveedor = '" + cursor.valueBuffer("codproveedor") + "'");
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
}

//// HABILITACIONES //////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition pieDocumento */
//////////////////////////////////////////////////////////////////
//// PIE DE DOCUMENTO ////////////////////////////////////////////

function pieDocumento_init()
{
	this.iface.__init();

	connect(this.child("tdbPieDocumento").cursor(), "bufferCommited()", this, "iface.calcularTotales");

	this.child("tdbLineasIvaFactprov").setFindHidden(true);
	this.child("tdbLineasIvaFactprov").setFilterHidden(true);

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
	
	if (!util.sqlDelete("lineasivafactprov", "idfactura = " + idFactura))
		return false;

	var codImpuestoAnt:Number = 0;
	var codImpuesto:Number = 0;
	var iva:Number;
	var totalNeto:Number = 0;
	var totalIva:Number = 0;
	var totalLinea:Number = 0;
	var acumNeto:Number = 0;
	var acumIva:Number = 0;
	
	var curLineaIva:FLSqlCursor = new FLSqlCursor("lineasivafactprov");
	var qryLineasFactura:FLSqlQuery = new FLSqlQuery;
	with (qryLineasFactura) {
		setTablesList("lineasfacturasprov,piefacturasprov,piedocumentos");
		setSelect("li.codimpuesto, li.iva, li.pvptotal");
		setFrom("( SELECT lf.codimpuesto, lf.iva, lf.pvptotal FROM lineasfacturasprov AS lf WHERE lf.idfactura = " + idFactura + " AND lf.pvptotal <> 0 UNION SELECT pd.codimpuesto, pf.totaliva, pf.totalinc FROM piefacturasprov AS pf INNER JOIN piedocumentos AS pd ON pf.codpie = pd.codpie WHERE pf.idfactura = " + idFactura + " AND pf.incluidoneto = true AND pf.totalinc <> 0) AS li");
		setWhere("1=1");
		setOrderBy("li.codimpuesto");
		setForwardOnly(true);
	}
	if (!qryLineasFactura.exec())
		return false;
	
	while (qryLineasFactura.next()) {
		codImpuesto = qryLineasFactura.value("li.codimpuesto");
		if (codImpuestoAnt != 0 && codImpuestoAnt != codImpuesto) {

			totalNeto = util.roundFieldValue(totalNeto, "lineasivafactprov", "neto");
			totalIva = util.roundFieldValue((iva * totalNeto) / 100, "lineasivafactprov", "totaliva");
			totalLinea = parseFloat(totalNeto) + parseFloat(totalIva);
			totalLinea = util.roundFieldValue(totalLinea, "lineasivafactprov", "totallinea");
			
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
		iva = parseFloat(qryLineasFactura.value("li.iva"));
		totalNeto += parseFloat(qryLineasFactura.value("li.pvptotal"));
	}

	if (totalNeto != 0) {
		totalNeto = util.roundFieldValue(netoExacto - acumNeto, "lineasivafactprov", "neto");
		totalIva = util.roundFieldValue(ivaExacto - acumIva, "lineasivafactprov", "totaliva");
		totalLinea = parseFloat(totalNeto) + parseFloat(totalIva);
		totalLinea = util.roundFieldValue(totalLinea, "lineasivafactprov", "totallinea");

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

/** @class_definition periodosFiscales */
//////////////////////////////////////////////////////////////////
//// PERIODOS FISCALES ///////////////////////////////////////////

function periodosFiscales_init()
{
	this.iface.__init();

	if ( this.cursor().modeAccess() == this.cursor().Insert ) {
		var util:FLUtil = new FLUtil();
		var cursor:FLSqlCursor = this.cursor();

		var fecha:String = cursor.valueBuffer("fecha");
		var codPeriodo:String = util.sqlSelect("periodos", "codperiodo", "fechainicio <= '" + fecha + "' AND fechafin >= '" + fecha + "' AND codejercicio = '" + cursor.valueBuffer("codejercicio") + "'");

		this.child("fdbCodPeriodo").setValue(codPeriodo);
	}
}

function periodosFiscales_validateForm():Boolean
{
	if (!this.iface.__validateForm())
		return false;

	var util:FLUtil = new FLUtil();

	var codPeriodo:String = this.cursor().valueBuffer("codperiodo");
	if (!codPeriodo) {
		MessageBox.warning(util.translate("scripts", "Debe indicar el período fiscal al que se imputa la factura"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	var estado:String = util.sqlSelect("periodos", "estado", "codperiodo = '" + codPeriodo + "'");
	if (estado == "CERRADO") {
		MessageBox.warning(util.translate("scripts", "No puede incluirse la factura en un período fiscal cerrado.\nDebe crear un nuevo período fiscal para el ejercicio actual."), MessageBox.Ok, MessageBox.NoButton);
		return false;
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
