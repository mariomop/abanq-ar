/***************************************************************************
                 albaranescli.qs  -  description
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
// 	function recordDelBeforelineasalbaranescli() { return this.ctx.interna_recordDelBeforelineasalbaranescli(); }
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
	function calcularTotales() {
		return this.ctx.oficial_calcularTotales();
	}
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function verificarHabilitaciones() {
		return this.ctx.oficial_verificarHabilitaciones();
	}
	function mostrarTraza() {
		return this.ctx.oficial_mostrarTraza();
	}
	function aplicarComision_clicked() {
		return this.ctx.oficial_aplicarComision_clicked();
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration funServiciosCli */
//////////////////////////////////////////////////////////////////
//// FUN_SERVICIOS_CLI /////////////////////////////////////////////////////
class funServiciosCli extends oficial {
	function funServiciosCli( context ) { oficial( context ); } 
	function init() { return this.ctx.funServiciosCli_init(); }
}
//// FUN_SERVICIOS_CLI /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration numeroSecuencia */
//////////////////////////////////////////////////////////////////
//// NUMERO SECUENCIA ////////////////////////////////////////////
class numeroSecuencia extends funServiciosCli {
	function numeroSecuencia( context ) { funServiciosCli( context ); } 
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
	function actualizarPieDocumento(curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.pieDocumento_actualizarPieDocumento(curAlbaran);
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

/** @class_declaration pubModoAcceso */
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
Este formulario realiza la gestion de los albaranes a clientes.

Los albaranes pueden ser generados de forma manual o a partir de uno o mas pedidos.
\end */
function interna_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	
	this.iface.bloqueoProvincia = false;
	this.iface.pbnAplicarComision = this.child("pbnAplicarComision");

    connect(this.iface.pbnAplicarComision, "clicked()", this, "iface.aplicarComision_clicked()");
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.child("tdbLineasAlbaranesCli").cursor(), "bufferCommited()", this, "iface.calcularTotales()");
	connect(this.child("tbnTraza"), "clicked()", this, "iface.mostrarTraza()");

	this.iface.pbnAplicarComision.setDisabled(true);

	if (cursor.modeAccess() == cursor.Insert) {
		cursor.setValueBuffer("codejercicio", flfactppal.iface.pub_ejercicioActual());
		this.child("fdbCodDivisa").setValue(flfactppal.iface.pub_valorDefectoEmpresa("coddivisa"));
		this.child("fdbCodPago").setValue(flfactppal.iface.pub_valorDefectoEmpresa("codpago"));
		this.child("fdbCodAlmacen").setValue(flfactppal.iface.pub_valorDefectoEmpresa("codalmacen"));
		this.child("fdbTasaConv").setValue(util.sqlSelect("divisas", "tasaconv","coddivisa = '" + this.child("fdbCodDivisa").value() + "'"));
	}

	this.iface.inicializarControles();

	var filtroCliente:String = "NOT debaja";
	this.child("fdbCodCliente").setFilter(filtroCliente);
}

function interna_calculateField(fN:String):String
{
		return formalbaranescli.iface.pub_commonCalculateField(fN, this.cursor());
}

// function interna_recordDelBeforelineasalbaranescli()
// {
// 	var curLineaAlbaran:FLSqlCursor = this.child("tdbLineasAlbaranesCli").cursor();
// 	var idLineaPedido:Number = parseFloat(curLineaAlbaran.valueBuffer("idlineapedido"));
// 
// 	if (idLineaPedido != 0) {
// 		var idPedido:Number = curLineaAlbaran.valueBuffer("idpedido");
// 		var idLineaAlbaran:Number = curLineaAlbaran.valueBuffer("idlinea");
// 		formalbaranescli.iface.pub_restarCantidad(idLineaPedido, idLineaAlbaran);
// 		formRecordlineasalbaranescli.iface.pub_actualizarEstadoPedido(idPedido);
// 	}
// }

function interna_validateForm()
{
	var cursor:FLSqlCursor = this.cursor();	

	var idAlbaran = cursor.valueBuffer("idalbaran");
	if(!idAlbaran)
		return false;

	var codCliente = this.child("fdbCodCliente").value();
	
	if(!flfacturac.iface.pub_validarIvaCliente(codCliente,idAlbaran,"lineasalbaranescli","idalbaran"))
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

function oficial_calcularTotales()
{
	var util:FLUtil = new FLUtil;	

	this.child("fdbNeto").setValue(this.iface.calculateField("neto"));
	this.child("fdbTotalIva").setValue(this.iface.calculateField("totaliva"));
	this.child("fdbTotal").setValue(this.iface.calculateField("total"));
	this.child("fdbComision").setValue(this.iface.calculateField("comision"));
	this.iface.verificarHabilitaciones();
}

function oficial_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();
	switch (fN) {
		/** \C
		El --total-- es el --neto-- mas el --totaliva--
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
		El valor de --coddir-- por defecto corresponde a la direccion del cliente marcada como direccion de facturacion
		\end */
		case "codcliente": {
			this.child("fdbCodDir").setValue("0");
			this.child("fdbCodDir").setValue(this.iface.calculateField("coddir"));
			this.child("fdbCodTarifa").setValue(this.iface.calculateField("codtarifa"));
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
	if (!util.sqlSelect("lineasalbaranescli", "idalbaran", "idalbaran = " + this.cursor().valueBuffer("idalbaran"))) {
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

function oficial_mostrarTraza()
{
	flfacturac.iface.pub_mostrarTraza(this.cursor().valueBuffer("codigo"), "albaranescli");
}

function oficial_aplicarComision_clicked()
{
	var util:FLUtil;
	
	var idAlbaran:Number = this.cursor().valueBuffer("idalbaran");
	if(!idAlbaran)
		return;
	var codAgente:String = this.cursor().valueBuffer("codagente");
	if(!codAgente || codAgente == "")
		return;

	var res:Number = MessageBox.information(util.translate("scripts", "�Seguro que desea actualizar la comisi�n en todas las l�neas?"), MessageBox.Yes, MessageBox.No);
	if(res != MessageBox.Yes)
		return;

	var cursor:FLSqlCursor = new FLSqlCursor("empresa");
	cursor.transaction(false);

	try {
		if(!flfacturac.iface.pub_aplicarComisionLineas(codAgente,"lineasalbaranescli","idalbaran = " + idAlbaran)) {
			cursor.rollback();
			return;
		}
		else {
			cursor.commit();
		}
	} catch (e) {
		MessageBox.critical(util.translate("scripts", "Hubo un error al aplicarse la comisi�n en las l�neas.\n%1").arg(e), MessageBox.Ok, MessageBox.NoButton);
		cursor.rollback();
		return false;
	}

	MessageBox.information(util.translate("scripts", "La comisi�n se actualiz� correctamente."), MessageBox.Ok, MessageBox.NoButton);
	this.iface.pbnAplicarComision.setDisabled(true);
	this.child("tdbLineasAlbaranesCli").refresh();
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition funServiciosCli */
/////////////////////////////////////////////////////////////////
//// FUN_SERVICIOS_CLI /////////////////////////////////////////////////

function funServiciosCli_init()
{
	this.iface.__init();

	var idAlbaran:Number = this.cursor().valueBuffer("idalbaran");
	var curServicio:FLSqlCursor = new FLSqlCursor("servicioscli");
	curServicio.select("idalbaran = " + idAlbaran);
	if (curServicio.first()) {
		this.child("fdbCodCliente").setDisabled(true);
		this.child("fdbNombreCliente").setDisabled(true);
		this.child("fdbCifNif").setDisabled(true);
		this.child("fdbCodDivisa").setDisabled(true);
		this.child("fdbTasaConv").setDisabled(true);
	}
}

//// FUN_SERVICIOS_CLI /////////////////////////////////////////////////
///////////////////////////////////////////////////////////////

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
		// Inicializaci�n del n�mero de secuencia del remito
		var numero:Number = 0;
		var idSec:Number = util.sqlSelect("secuenciasejercicios", "id", "codejercicio = '" + codEjercicio + "' AND codserie = '" + codSerie + "'");
		if (idSec) {
			numero = util.sqlSelect("secuencias", "valorout", "id = " + idSec + " AND nombre = 'nalbarancli'");
			if ( !numero || isNaN(numero) )
				numero = 0;
		}
		this.child("fdbNumero").setValue(numero.toString());
	}

	this.iface.__init();
}

function numeroSecuencia_calculateField(fN:String):String
{
	var util:FLUtil = new FLUtil();
	var valor:String;
	switch (fN) {
		case "numero": {
			var idSec:Number = util.sqlSelect("secuenciasejercicios", "id", "codejercicio = '" + this.cursor().valueBuffer("codejercicio") + "' AND codserie = '" + this.cursor().valueBuffer("codserie") + "'");
			if (!idSec) {
				valor = 0;
				break;
			}
			var numero:Number = util.sqlSelect("secuencias", "valorout", "id = " + idSec + " AND nombre = 'nalbarancli'");
			if ( !numero || isNaN(numero) )
				numero = 0;
			valor = numero.toString();
			break;
		}
		default:
			valor = formalbaranescli.iface.pub_commonCalculateField(fN, this.cursor());
			break;
	}
	return valor;
}

function numeroSecuencia_acceptedForm()
{
	// al aceptar el remito se incrementa el n�mero de secuencia
	var cursorAlbaran:FLSqlCursor = this.cursor();
	if ( this.iface.modoAcceso == this.cursor().Insert ) {
		var cursorSecuencias:FLSqlCursor = new FLSqlCursor("secuenciasejercicios");
		cursorSecuencias.setActivatedCheckIntegrity(false);
		cursorSecuencias.select("upper(codserie) = '" + cursorAlbaran.valueBuffer("codserie") + "' AND upper(codejercicio) = '" + cursorAlbaran.valueBuffer("codejercicio") + "'");
		if (cursorSecuencias.next()) {
			var cursorSecs:FLSqlCursor = new FLSqlCursor( "secuencias" );
			cursorSecs.setActivatedCheckIntegrity( false );
			var idSec:Number = cursorSecuencias.valueBuffer( "id" );
			cursorSecs.select( "id = " + idSec + " AND nombre = 'nalbarancli'" );
			if (cursorSecs.next()) {
				cursorSecs.setModeAccess( cursorSecs.Edit );
				cursorSecs.refreshBuffer();
				var numerosiguiente:Number = parseInt(cursorAlbaran.valueBuffer("numero"), 10) + 1;
				cursorSecs.setValueBuffer( "valorout", numerosiguiente );
				cursorSecs.commitBuffer();
			}
			else {
				cursorSecs.setModeAccess( cursorSecs.Insert );
				cursorSecs.refreshBuffer();
				cursorSecs.setValueBuffer( "id", idSec );
				cursorSecs.setValueBuffer( "nombre", "nalbarancli" );
				cursorSecs.setValueBuffer( "valor", 1 );
				var numerosiguiente:Number = parseInt(cursorAlbaran.valueBuffer("numero"), 10) + 1;
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

	// Chequear que haya alguna l�nea cargada
	var hayLineas:FLSqlCursor = this.child("tdbLineasAlbaranesCli").cursor();
	hayLineas.select("idalbaran = " + this.cursor().valueBuffer("idalbaran"));
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

	// si ya se cre�, no permitir cambiar el tipo de venta, codserie ni n�mero
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
			flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Remitos");
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

	var orden:Array = [ "referencia", "descripcion", "cantidad", "pvpunitario", "pvpsindto", "pvptotal", "totalconiva", "codimpuesto", "iva", "dtolineal", "dtopor", "porcomision", "totalenfactura", "costounitario", "costototal", "ganancia", "utilidad", "numserie", "cerrada" ];

	this.child("tdbLineasAlbaranesCli").setOrderCols(orden);
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
				case "Remito": {
					valor = flfactppal.iface.pub_valorDefectoEmpresa("codserie_remito");
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
			cursor.setValueBuffer("codserie", this.iface.calculateField("codserie"));
			break;
		}
		case "codcliente": {
			cursor.setValueBuffer("tipoventa", "Remito");

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

function pieDocumento_actualizarPieDocumento(curAlbaran:FLSqlCursor):Boolean
{
	// Ac� se deber�an actualizar los pie de remito que dependan del neto

	return true;
}

//// PIE DE DOCUMENTO ////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////