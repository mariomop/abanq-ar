/***************************************************************************
                 presupuestoscli.qs  -  description
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
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_declaration interna */
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
	var pbnAplicarComision:Object;
    function oficial( context ) { interna( context ); } 
	function inicializarControles() {
		return this.ctx.oficial_inicializarControles();
	}
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function calcularTotales() {
		return this.ctx.oficial_calcularTotales();
	}
	function verificarHabilitaciones() {
		return this.ctx.oficial_verificarHabilitaciones();
	}
	function mostrarTraza() {
		return this.ctx.oficial_mostrarTraza();
	}
	function datosDefectoCRM() {
		return this.ctx.oficial_datosDefectoCRM();
	}
	function copiarDatosCliente(curTarjeta:FLSqlCursor) {
		return this.ctx.oficial_copiarDatosCliente(curTarjeta);
	}
	function aplicarComision_clicked() {
		return this.ctx.oficial_aplicarComision_clicked();
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
	function actualizarPieDocumento(curPresupuesto:FLSqlCursor):Boolean {
		return this.ctx.pieDocumento_actualizarPieDocumento(curPresupuesto);
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

////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_definition interna */
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
/** \C
Este formulario realiza la gestión de los pedidos a clientes.

Los pedidos pueden ser generados de forma manual o a partir de un presupuesto previo.
\end */
function interna_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	this.iface.bloqueoProvincia = false;
	this.iface.pbnAplicarComision = this.child("pbnAplicarComision");

    connect(this.iface.pbnAplicarComision, "clicked()", this, "iface.aplicarComision_clicked()");
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.child("tdbLineasPresupuestosCli").cursor(), "bufferCommited()", this, "iface.calcularTotales()");
	connect(this.child("tbnTraza"), "clicked()", this, "iface.mostrarTraza()");

	this.iface.pbnAplicarComision.setDisabled(true);

	if (cursor.modeAccess() == cursor.Insert) {
		this.child("fdbCodEjercicio").setValue(flfactppal.iface.pub_ejercicioActual());
		this.child("fdbCodDivisa").setValue(flfactppal.iface.pub_valorDefectoEmpresa("coddivisa"));
		this.child("fdbCodPago").setValue(flfactppal.iface.pub_valorDefectoEmpresa("codpago"));
		this.child("fdbCodAlmacen").setValue(flfactppal.iface.pub_valorDefectoEmpresa("codalmacen"));
		this.child("fdbTasaConv").setValue(util.sqlSelect("divisas", "tasaconv", "coddivisa = '" + this.child("fdbCodDivisa").value() + "'"));
	}

	if (sys.isLoadedModule("flcrm_ppal")) {
		var curRel:FLSqlCursor = cursor.cursorRelation();
		if (curRel && curRel.action() == "crm_oportunidadventa") {
			
			this.child("fdbCodCliente").setValue(curRel.valueBuffer("codcliente"));
			var curTarjeta:FLSqlCursor = curRel.cursorRelation();
			var codCliente:String = curRel.valueBuffer("codcliente");
			
			if (!codCliente || codCliente == "") {
				var codTarjeta:String = "";
				var vieneDeTarjeta:Boolean = false;
				if (!curTarjeta || curTarjeta.action() != "crm_tarjetas") {
					codTarjeta = curRel.valueBuffer("codtarjeta");
					
					if(codTarjeta && codTarjeta != "") {
						curTarjeta = new FLSqlCursor("crm_tarjetas");
						curTarjeta.select("codtarjeta = '" + codTarjeta + "'");
						
						if(curTarjeta.first()) {
							curTarjeta.refreshBuffer();
							vieneDeTarjeta = true
						}
					}
				}
				if (vieneDeTarjeta)
					this.iface.copiarDatosCliente(curTarjeta);
			}
		}
		if (cursor.modeAccess() == cursor.Insert)
			this.iface.datosDefectoCRM();
	} else {
		this.child("tbwPresupuesto").setTabEnabled("crm", false);
	}

	this.iface.inicializarControles();
}

/** \U
Los valores de los campos de este formulario se calculan en el script asociado al formulario maestro
\end */
function interna_calculateField(fN:String):String
{
		return formpresupuestoscli.iface.pub_commonCalculateField(fN, this.cursor());
}

function interna_validateForm()
{
	var cursor:FLSqlCursor = this.cursor();	

	var idPresupuesto = cursor.valueBuffer("idpresupuesto");
	if(!idPresupuesto)
		return false;

	var codCliente = this.child("fdbCodCliente").value();
	
	if(!flfacturac.iface.pub_validarIvaCliente(codCliente,idPresupuesto,"lineaspresupuestoscli","idpresupuesto"))
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
		this.iface.verificarHabilitaciones();
}

function oficial_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	switch (fN) {
		/** \C
		El --total-- es el --neto-- más el --totaliva--
		\end */
		case "neto":
		case "totaliva":{
			var total:String = this.iface.calculateField("total");
			this.child("fdbTotal").setValue(total);
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

/** \U
Calcula los campos que son resultado de una suma de las líneas de pedido
\end */
function oficial_calcularTotales()
{
	this.child("fdbNeto").setValue(this.iface.calculateField("neto"));
	this.child("fdbTotalIva").setValue(this.iface.calculateField("totaliva"));
	this.child("fdbTotal").setValue(this.iface.calculateField("total"));
	this.child("fdbComision").setValue(this.iface.calculateField("comision"));
	this.iface.verificarHabilitaciones();
}

/** \U
Verifica que los campos --codalmacen--, --coddivisa-- y ..tasaconv-- estén habilitados en caso de que el pedido no tenga líneas asociadas.
\end */
function oficial_verificarHabilitaciones()
{
	var util:FLUtil = new FLUtil();
	var idPresupuesto:Number = util.sqlSelect("lineaspresupuestoscli", "idpresupuesto", "idpresupuesto = " + this.cursor().valueBuffer("idpresupuesto"));
	if (!idPresupuesto) {
		this.child("fdbCodAlmacen").setDisabled(false);
		this.child("fdbCodDivisa").setDisabled(false);
		this.child("fdbTasaConv").setDisabled(false);
	} else {
		this.child("fdbCodAlmacen").setDisabled(true);
		this.child("fdbCodDivisa").setDisabled(true);
		this.child("fdbTasaConv").setDisabled(true);
	}
}

function oficial_mostrarTraza()
{
	flfacturac.iface.pub_mostrarTraza(this.cursor().valueBuffer("codigo"), "presupuestoscli");
}

/** \C Introduce los datos de un cliente o tarjeta en el caso de que el presupuesto se esté creando desde el formulario de edición de oportunidades de venta del módulo de CRM
\end */
function oficial_datosDefectoCRM()
{
	var cursor:FLSqlCursor = this.cursor();
	var curRel:FLSqlCursor = cursor.cursorRelation();

	if (!curRel)
		return;
	if (curRel.table() != "crm_oportunidadventa")
		return;

	var codCliente:String = curRel.valueBuffer("codcliente");
	if (codCliente && codCliente != "") {
		this.child("fdbCodCliente").setValue(codCliente);
		return;
	}

	var codTarjeta:String = curRel.valueBuffer("codtarjeta");
	if (codTarjeta && codTarjeta != "") {
		var qryTarjeta:FLSqlQuery = new FLSqlQuery;
		with (qryTarjeta) {
			setTablesList("crm_tarjetas");
			setSelect("nombre, codcliente, cifnif, coddir, direccion, ciudad, codpostal, provincia, codpais");
			setFrom("crm_tarjetas");
			setWhere("codtarjeta = '" + codTarjeta + "'");
			setForwardOnly(true);
		}
		if (!qryTarjeta.exec())
			return false;
		if (!qryTarjeta.first())
			return false;

		this.child("fdbCodCliente").setValue(qryTarjeta.value("codcliente"));
		this.child("fdbNombreCliente").setValue(qryTarjeta.value("nombre"));
		this.child("fdbCifNif").setValue(qryTarjeta.value("cifnif"));
		var codDir:Number = parseFloat(qryTarjeta.value("coddir"))
		if (codDir && codDir != 0)
			this.child("fdbCodDir").setValue(codDir);
		this.child("fdbDireccion").setValue(qryTarjeta.value("direccion"));
		this.child("fdbCiudad").setValue(qryTarjeta.value("ciudad"));
		this.child("fdbCodPostal").setValue(qryTarjeta.value("codpostal"));
		this.child("fdbProvincia").setValue(qryTarjeta.value("provincia"));
		this.child("fdbCodPais").setValue(qryTarjeta.value("codpais"));
	}
}

function oficial_copiarDatosCliente(curTarjeta:FLSqlCursor)
{
	this.child("fdbNombreCliente").setValue(curTarjeta.valueBuffer("nombre"));
	this.child("fdbCifNif").setValue(curTarjeta.valueBuffer("cifnif"));
	this.child("fdbCodDir").setValue(curTarjeta.valueBuffer("coddir"));
	this.child("fdbDireccion").setValue(curTarjeta.valueBuffer("direccion"));
	this.child("fdbCiudad").setValue(curTarjeta.valueBuffer("ciudad"));
	this.child("fdbProvincia").setValue(curTarjeta.valueBuffer("provincia"));
	this.child("fdbCodPostal").setValue(curTarjeta.valueBuffer("codpostal"));
	this.child("fdbCodPais").setValue(curTarjeta.valueBuffer("codpais"));
	this.child("fdbIdProvincia").setValue(curTarjeta.valueBuffer("idprovincia"));
}

function oficial_aplicarComision_clicked()
{
	var util:FLUtil;
	
	var idPresupuesto:Number = this.cursor().valueBuffer("idpresupuesto");
	if(!idPresupuesto)
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
		if(!flfacturac.iface.pub_aplicarComisionLineas(codAgente,"lineaspresupuestoscli","idpresupuesto = " + idPresupuesto)) {
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
	this.child("tdbLineasPresupuestosCli").refresh()
}
//// OFICIAL/////////////////////////////////////////////////////
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
		// Inicialización del número de secuencia del presupuesto
		var idSec:Number = util.sqlSelect("secuenciasejercicios", "id", "codejercicio = '" + codEjercicio + "' AND codserie = '" + codSerie + "'");
		var numero:Number = util.sqlSelect("secuencias", "valorout", "id = " + idSec + " AND nombre = 'npresupuestocli'");
		if ( !numero || isNaN(numero) )
			numero = 0;
		this.child("fdbNumero").setValue(numero.toString());
		//cursor.setValueBuffer("numero", numero.toString());
	}

	this.iface.__init();
}

function numeroSecuencia_calculateField(fN:String):String
{
	var util:FLUtil = new FLUtil();
	var valor:String;
	switch (fN) {
		case "numero": {
			var idSec:Number = util.sqlSelect("secuenciasejercicios", "id", "codejercicio = '" + this.child("fdbCodEjercicio").value() + "' AND codserie = '" + this.child("fdbCodSerie").value() + "'");
			if (!idSec) {
				valor = 0;
				break;
			}
			var numero:Number = util.sqlSelect("secuencias", "valorout", "id = " + idSec + " AND nombre = 'npresupuestocli'");
			if ( !numero || isNaN(numero) )
				numero = 0;
			valor = numero.toString();
			break;
		}
		default:
			valor = formpresupuestoscli.iface.pub_commonCalculateField(fN, this.cursor());
			break;
	}
	return valor;
}

function numeroSecuencia_acceptedForm()
{
	// al dar "Aceptar" en el presupuesto se incrementa el número de secuencia
	var cursor:FLSqlCursor = this.cursor();
	if ( this.iface.modoAcceso == this.cursor().Insert ) {
		var cursorSecuencias:FLSqlCursor = new FLSqlCursor("secuenciasejercicios");
		cursorSecuencias.setActivatedCheckIntegrity(false);
		cursorSecuencias.select("upper(codserie) = '" + cursor.valueBuffer("codserie") + "' AND upper(codejercicio) = '" + cursor.valueBuffer("codejercicio") + "'");
		if (cursorSecuencias.next()) {
			var cursorSecs:FLSqlCursor = new FLSqlCursor( "secuencias" );
			cursorSecs.setActivatedCheckIntegrity( false );
			var idSec:Number = cursorSecuencias.valueBuffer( "id" );
			cursorSecs.select( "id = " + idSec + " AND nombre = 'npresupuestocli'" );
			if (cursorSecs.next()) {
				cursorSecs.setModeAccess( cursorSecs.Edit );
				cursorSecs.refreshBuffer();
				var numerosiguiente:Number = parseInt(cursor.valueBuffer("numero"), 10) + 1;
				cursorSecs.setValueBuffer( "valorout", numerosiguiente );
				cursorSecs.commitBuffer();
			}
			else {
				cursorSecs.setModeAccess( cursorSecs.Insert );
				cursorSecs.refreshBuffer();
				cursorSecs.setValueBuffer( "id", idSec );
				cursorSecs.setValueBuffer( "nombre", "npresupuestocli" );
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

	// Chequear que haya alguna línea cargada
	var hayLineas:FLSqlCursor = this.child("tdbLineasPresupuestosCli").cursor();
	hayLineas.select("idpresupuesto = " + this.cursor().valueBuffer("idpresupuesto"));
	if (hayLineas.size() < 1) {
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
			flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Presupuestos");
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

	var orden:Array = [ "referencia", "descripcion", "cantidad", "pvpunitario", "pvpsindto", "pvptotal", "totalconiva", "codimpuesto", "iva", "dtolineal", "dtopor", "porcomision", "costounitario", "costototal", "ganancia", "utilidad" ];

	this.child("tdbLineasPresupuestosCli").setOrderCols(orden);
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
				case "Presupuesto": {
					valor = flfactppal.iface.pub_valorDefectoEmpresa("codserie_presupuesto");
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
					case "Responsable Monotributo":
					case "Responsable Inscripto":
					case "Responsable No Inscripto": {
						cursor.setValueBuffer("tipoventa", "Presupuesto");
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

function pieDocumento_actualizarPieDocumento(curPresupuesto:FLSqlCursor):Boolean
{
	// Acá se deberían actualizar los pie de presupuesto que dependan del neto

	return true;
}

//// PIE DE DOCUMENTO ////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition head */
//////////////////////////////////////////////////////////////////
//// DESARROLLO //////////////////////////////////////////////////

//// DESARROLLO //////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////
