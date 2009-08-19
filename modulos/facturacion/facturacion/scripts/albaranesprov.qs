/***************************************************************************
                 albaranesprov.qs  -  description
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
// 	function recordDelBeforelineasalbaranesprov() { return this.ctx.interna_recordDelBeforelineasalbaranesprov(); }
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

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends habilitaciones {
    function head( context ) { habilitaciones ( context ); }
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
Este formulario realiza la gestión de los albaranes a proveedores.

Los albaranes pueden ser generados de forma manual o a partir de uno o más pedidos.
\end */
function interna_init()
{
		var util:FLUtil = new FLUtil();
		var cursor:FLSqlCursor = this.cursor();

		connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
		connect(this.child("tdbLineasAlbaranesProv").cursor(), "bufferCommited()", this, "iface.calcularTotales()");
		connect(this.child("tbnTraza"), "clicked()", this, "iface.mostrarTraza()");

		if (cursor.modeAccess() == cursor.Insert) {
				this.child("fdbCodEjercicio").setValue(flfactppal.iface.pub_ejercicioActual());
				this.child("fdbCodDivisa").setValue(flfactppal.iface.pub_valorDefectoEmpresa("coddivisa"));
				this.child("fdbCodPago").setValue(flfactppal.iface.pub_valorDefectoEmpresa("codpago"));
				this.child("fdbCodAlmacen").setValue(flfactppal.iface.pub_valorDefectoEmpresa("codalmacen"));
				this.child("fdbTasaConv").setValue(util.sqlSelect("divisas", "tasaconv","coddivisa = '" + this.child("fdbCodDivisa").value() + "'"));
		}

		this.iface.inicializarControles();
}

// function interna_recordDelBeforelineasalbaranesprov()
// {
// 	var cursor:FLSqlCursor = this.cursor();
// 	var curLineaAlbaran:FLSqlCursor = this.child("tdbLineasAlbaranesProv").cursor();
// 
// 	var idLineaPedido:Number = curLineaAlbaran.valueBuffer("idlineapedido");
// 	if (idLineaPedido != "0") {
// 		var idPedido:Number = curLineaAlbaran.valueBuffer("idpedido");
// 		var idLineaAlbaran:Number = curLineaAlbaran.valueBuffer("idlinea");
// 		formalbaranesprov.iface.pub_restarCantidad(idLineaPedido, idLineaAlbaran);
// 		formRecordlineasalbaranesprov.iface.pub_actualizarEstadoPedido(idPedido);
// 	}
// }

function interna_calculateField(fN:String):String
{
		var valor:String;
		var cursor:FLSqlCursor = this.cursor();
		switch (fN) {
		case "total":{
						this.child("lblRecFinanciero").setText((parseFloat(cursor.valueBuffer("recfinanciero")) * cursor.valueBuffer("neto")) / 100);
						valor = formalbaranesprov.iface.pub_commonCalculateField(fN, cursor);
						break;
				}
		default:{
						valor = formalbaranesprov.iface.pub_commonCalculateField(fN, cursor);
						break;
				}
		}
		return valor;
}

function interna_validateForm()
{
	var cursor:FLSqlCursor = this.cursor();	

	var idAlbaran = cursor.valueBuffer("idalbaran");
	if(!idAlbaran)
		return false;

	var codProveedor = this.child("fdbCodProveedor").value();
	
	if(!flfacturac.iface.pub_validarIvaProveedor(codProveedor,idAlbaran,"lineasalbaranesprov","idalbaran"))
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

function oficial_calcularTotales()
{
	this.child("fdbNeto").setValue(this.iface.calculateField("neto"));
	this.child("fdbTotalIva").setValue(this.iface.calculateField("totaliva"));
	this.iface.verificarHabilitaciones();
}

function oficial_bufferChanged(fN:String)
{
		switch (fN) {
		/** \C
		El --total-- es el --neto-- más el --totaliva-- más el --recfinanciero--
		\end */
		case "recfinanciero":
		case "neto":
		case "totaliva":{
						var total:Number = this.iface.calculateField("total");
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

function oficial_verificarHabilitaciones()
{
		var util:FLUtil = new FLUtil;
		if (!util.sqlSelect("lineasalbaranesprov", "idalbaran", "idalbaran = " + this.cursor().valueBuffer("idalbaran"))) {
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
	flfacturac.iface.pub_mostrarTraza(this.cursor().valueBuffer("codigo"), "albaranesprov");
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
			flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Remitos");
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
	var hayLineas:FLSqlCursor = this.child("tdbLineasAlbaranesProv").cursor();
	hayLineas.select("idalbaran = " + this.cursor().valueBuffer("idalbaran"));
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

	var orden:Array = [ "referencia", "descripcion", "cantidad", "pvpunitario", "pvpsindto", "pvptotal", "totalconiva", "codimpuesto", "iva", "dtolineal", "dtopor", "numserie" ];

	this.child("tdbLineasAlbaranesProv").setOrderCols(orden);
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
						cursor.setValueBuffer("tipoventa", "Remito");
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

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
