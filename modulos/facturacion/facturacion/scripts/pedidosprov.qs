/***************************************************************************
                 pedidosprov.qs  -  description
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
	function procesarEstadoLinea() {
		return this.ctx.oficial_procesarEstadoLinea();
	}
	function verificarHabilitaciones() {
		return this.ctx.oficial_verificarHabilitaciones();
	}
	function mostrarTraza() {
		return this.ctx.oficial_mostrarTraza();
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
	function actualizarPieDocumento(curPedido:FLSqlCursor):Boolean {
		return this.ctx.pieDocumento_actualizarPieDocumento(curPedido);
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
Este formulario realiza la gestión de los pedidos a proveedores.

Los pedidos son generados de forma manual.
\end */
function interna_init()
{
		var util:FLUtil = new FLUtil();
		var cursor:FLSqlCursor = this.cursor();
		connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
		connect(this.child("tdbArticulosPedProv").cursor(), "bufferCommited()", this, "iface.calcularTotales()");
		connect(this.child("tdbArticulosPedProv").cursor(), "newBuffer()", this, "iface.procesarEstadoLinea");
		connect(this.child("tbnTraza"), "clicked()", this, "iface.mostrarTraza()");

		if (cursor.modeAccess() == cursor.Insert) {
				this.child("fdbCodEjercicio").setValue(flfactppal.iface.pub_ejercicioActual());
				this.child("fdbCodDivisa").setValue(flfactppal.iface.pub_valorDefectoEmpresa("coddivisa"));
				this.child("fdbCodPago").setValue(flfactppal.iface.pub_valorDefectoEmpresa("codpago"));
				this.child("fdbCodAlmacen").setValue(flfactppal.iface.pub_valorDefectoEmpresa("codalmacen"));
				this.child("fdbTasaConv").setValue(util.sqlSelect("divisas", "tasaconv", "coddivisa = '" + this.child("fdbCodDivisa").value() + "'"));
		}

		this.iface.inicializarControles();
}

/** \U
Los valores de los campos de este formulario se calculan en el script asociado al formulario maestro
\end */
function interna_calculateField(fN:String):String
{
		var valor:String;
		var cursor:FLSqlCursor = this.cursor();
		switch (fN) {
				default: {
						valor = formpedidosprov.iface.pub_commonCalculateField(fN, cursor);
						break;
				}
		}
		return valor;
}

function interna_validateForm():Boolean
{
	var cursor:FLSqlCursor = this.cursor();
	/** \C
	Se establecerá el estado del pedido actual en función de si está No servido, Servido o Parcialmente servido
	\end */
	var estado:String = formRecordlineasalbaranesprov.iface.pub_obtenerEstadoPedido(cursor.valueBuffer("idpedido"));
	
	cursor.setValueBuffer("servido", estado);
	if (estado == "Sí")
			cursor.setValueBuffer("editable", false);

	var cursor:FLSqlCursor = this.cursor();	

	var idPedido = cursor.valueBuffer("idPedido");
	if(!idPedido)
		return false;

	var codProveedor = this.child("fdbCodProveedor").value();
	
	if(!flfacturac.iface.pub_validarIvaProveedor(codProveedor,idPedido,"lineaspedidosprov","idpedido"))
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
		this.child("lblRecFinanciero").setText(this.iface.calculateField("lblRecFinanciero"));
		this.iface.verificarHabilitaciones();
}

/** \U
Calcula los campos que son resultado de una suma de las líneas de pedido
\end */
function oficial_calcularTotales()
{
	this.child("fdbNeto").setValue(this.iface.calculateField("neto"));
	this.child("fdbTotalIva").setValue(this.iface.calculateField("totaliva"));
	this.child("fdbTotal").setValue(this.iface.calculateField("total"));
	this.iface.verificarHabilitaciones();
}

function oficial_bufferChanged(fN:String)
{
		var util:FLUtil = new FLUtil();
		switch (fN) {
		/** \C
		El --total-- es el --neto-- más el --totaliva-- más el --recfinanciero--
		*/
		case "recfinanciero":
		case "neto":
		case "totaliva":{
						var total:String = this.iface.calculateField("total");
						this.child("fdbTotal").setValue(total);
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

/** \U
Inhabilita el botón de borrar líneas si la línea tiene una línea de remito asociada
\end */
function oficial_procesarEstadoLinea()
{
		var curLinea:FLSqlCursor = this.child("tdbArticulosPedProv").cursor();
		if (parseFloat(curLinea.valueBuffer("totalenalbaran")) > 0)
				this.child("toolButtonDelete").setEnabled(false);
		else
				this.child("toolButtonDelete").setEnabled(true);
}

/** \U
Verifica que los campos --codalmacen--, --coddivisa-- y ..tasaconv-- estén habilitados en caso de que el pedido no tenga líneas asociadas.
\end */
function oficial_verificarHabilitaciones()
{
		var util:FLUtil = new FLUtil();
		var idLinea:Number = util.sqlSelect("lineaspedidosprov", "idpedido", "idpedido = " + this.cursor().valueBuffer("idpedido"));
		if (!idLinea) {
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
	flfacturac.iface.pub_mostrarTraza(this.cursor().valueBuffer("codigo"), "pedidosprov");
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
			flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Pedidos");
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
	var hayLineas:FLSqlCursor = this.child("tdbArticulosPedProv").cursor();
	hayLineas.select("idpedido = " + this.cursor().valueBuffer("idpedido"));
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

	var orden:Array = [ "referencia", "descripcion", "cantidad", "pvpunitario", "pvpsindto", "pvptotal", "totalconiva", "codimpuesto", "iva", "dtolineal", "dtopor", "totalenalbaran", "cerrada" ];

	this.child("tdbArticulosPedProv").setOrderCols(orden);
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
				case "Pedido": {
					valor = flfactppal.iface.pub_valorDefectoEmpresa("codserie_pedido");
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
		case "codproveedor": {
			if (cursor.valueBuffer("codproveedor") && cursor.valueBuffer("codproveedor") != "") {
				var regimenIva:Boolean = util.sqlSelect("proveedores", "regimeniva", "codproveedor = '" + cursor.valueBuffer("codproveedor") + "'");
				switch ( regimenIva ) {
					case "Consumidor Final":
					case "Exento":
					case "No Responsable":
					case "Responsable Monotributo":
					case "Responsable Inscripto":
					case "Responsable No Inscripto": {
						cursor.setValueBuffer("tipoventa", "Pedido");
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

function pieDocumento_actualizarPieDocumento(curPedido:FLSqlCursor):Boolean
{
	// Acá se deberían actualizar los pie de pedido que dependan del neto

	return true;
}

//// PIE DE DOCUMENTO ////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
