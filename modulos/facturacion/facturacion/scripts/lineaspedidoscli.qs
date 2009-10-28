/***************************************************************************
                 lineaspedidoscli.qs  -  description
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
	function acceptedForm() { return this.ctx.interna_acceptedForm(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
    function oficial( context ) { interna( context ); } 
	function desconectar() {
		return this.ctx.oficial_desconectar();
	}
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function commonBufferChanged(fN:String, miForm:Object) {
		return this.ctx.oficial_commonBufferChanged(fN, miForm);
	}
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.oficial_commonCalculateField(fN, cursor);
	}
	function obtenerTarifa(codCliente:String, cursor:FLSqlCursor):String {
		return this.ctx.oficial_obtenerTarifa(codCliente, cursor);
	}
	function datosTablaPadre(cursor:FLSqlCursor):Array {
		return this.ctx.oficial_datosTablaPadre(cursor);
	}
	function filtrarArticulos() {
		return this.ctx.oficial_filtrarArticulos();
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration ivaIncluido */
//////////////////////////////////////////////////////////////////
//// IVAINCLUIDO /////////////////////////////////////////////////
class ivaIncluido extends oficial {
	var bloqueoPrecio:Boolean;
    function ivaIncluido( context ) { oficial( context ); } 	
	function init() {
		return this.ctx.ivaIncluido_init();
	}
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.ivaIncluido_commonCalculateField(fN, cursor);
	}
	function commonBufferChanged(fN:String, miForm:Object) {
			return this.ctx.ivaIncluido_commonBufferChanged(fN, miForm);
	}
	function habilitarPorIvaIncluido(miForm:Object) {
		return this.ctx.ivaIncluido_habilitarPorIvaIncluido(miForm);
	}
}
//// IVAINCLUIDO /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
class lotes extends ivaIncluido {
	var porLotes:Boolean;
	
    function lotes( context ) { ivaIncluido ( context ); }
	function init() {
		return this.ctx.lotes_init();
	}
	function bufferChanged(fN:String) {
		return this.ctx.lotes_bufferChanged(fN);
	}
	function calcularCantidad() {
		return this.ctx.lotes_calcularCantidad();
	}
	function calculateField(fN:String):String {
		return this.ctx.lotes_calculateField(fN);
	}
	function habilitarControlesPorLotes()  {
		return this.ctx.lotes_habilitarControlesPorLotes();
	}
}
//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration serviciosCli */
/////////////////////////////////////////////////////////////////
//// SERVICIOS CLI //////////////////////////////////////////////
class serviciosCli extends lotes {
    function serviciosCli( context ) { lotes ( context ); }
	function datosTablaPadre(cursor:FLSqlCursor):Array {
		return this.ctx.serviciosCli_datosTablaPadre(cursor);
	}
}
//// SERVICIOS CLI //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration totalesIva */
/////////////////////////////////////////////////////////////////
//// TOTALES CON IVA ////////////////////////////////////////////
class totalesIva extends serviciosCli {
    function totalesIva( context ) { serviciosCli ( context ); }
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.totalesIva_commonCalculateField(fN, cursor);
	}
	function commonBufferChanged(fN:String, miForm:Object) {
		return this.ctx.totalesIva_commonBufferChanged(fN, miForm);
	}
}
//// TOTALES CON IVA ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration informacionLineas */
/////////////////////////////////////////////////////////////////
//// INFORMACION LINEAS /////////////////////////////////////////
class informacionLineas extends totalesIva {
    function informacionLineas( context ) { totalesIva ( context ); }
	function init() {
		return this.ctx.informacionLineas_init();
	}
	function commonBufferChanged(fN:String, miForm:Object) {
		return this.ctx.informacionLineas_commonBufferChanged(fN, miForm);
	}
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.informacionLineas_commonCalculateField(fN, cursor);
	}
}
//// INFORMACION LINEAS /////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration multiDivisa */
/////////////////////////////////////////////////////////////////
//// MULTI DIVISA ///////////////////////////////////////////////
class multiDivisa extends informacionLineas {
    function multiDivisa( context ) { informacionLineas ( context ); }
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.multiDivisa_commonCalculateField(fN, cursor);
	}
}
//// MULTI DIVISA ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends multiDivisa {
    function head( context ) { multiDivisa ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
		function pub_commonBufferChanged(fN:String, miForm:Object) {
				return this.commonBufferChanged(fN, miForm);
		}
		function pub_commonCalculateField(fN:String, cursor:FLSqlCursor):String {
				return this.commonCalculateField(fN, cursor);
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
Este formulario realiza la gesti�n de las l�neas de pedidos a clientes.
\end */
function interna_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(form, "closed()", this, "iface.desconectar");
	
	var codSerie:String = "";
	var codAgente:String = "";
	var codCliente:String = "";
	
	if(cursor.cursorRelation()) {
		codSerie = cursor.cursorRelation().valueBuffer("codserie");
		codAgente = cursor.cursorRelation().valueBuffer("codagente");
		codCliente = cursor.cursorRelation().valueBuffer("codcliente");
	}
	else {
		var idPedido:Number = cursor.valueBuffer("idpedido");
		if(idPedido) {
			codSerie = util.sqlSelect("pedidoscli", "codserie", "idpedido = " + idPedido);
			codAgente = util.sqlSelect("pedidoscli", "codagente", "idpedido = " + idPedido);
			codCliente = util.sqlSelect("pedidoscli", "codcliente", "idpedido = " + idPedido);
		}
	}

	if (cursor.modeAccess() == cursor.Insert) {
		this.child("fdbDtoPor").setValue(this.iface.calculateField("dtopor"));
		if(!codAgente || codAgente == "")
			this.child("fdbPorComision").setDisabled(true);
		else
			this.child("fdbPorComision").setValue(this.iface.calculateField("porcomision"));
	}

	this.child("lblComision").setText(this.iface.calculateField("lblComision"));
	this.child("lblDtoPor").setText(this.iface.calculateField("lbldtopor"));
	
	if (cursor.modeAccess() == cursor.Insert || cursor.modeAccess() == cursor.Edit) {
		if ( !flfacturac.iface.pub_tieneIvaDocCliente(codSerie, codCliente) ) {
			this.child("fdbCodImpuesto").setValue("EXENTO");
			this.child("fdbCodImpuesto").setDisabled(true);
			this.child("fdbIva").setDisabled(true);
		}
	}

	this.iface.filtrarArticulos();
}

function interna_calculateField(fN:String):String
{
		return this.iface.commonCalculateField(fN, this.cursor());
		/** \C
		El --pvpunitario-- ser� el correspondiente al art�culo seg�n la tarifa asociada al cliente. Si no se ha especificado este dato, se tomar� el pvp asociado al art�culo.
		\end */
		/** \C
		El --pvpsindto-- ser� el producto del campo --cantidad-- por el campo --pvpunitario--
		\end */
		/** \C
		El --iva-- ser� el correspondiente al --codimpuesto-- en la tabla de impuestos
		\end */
		/** \C
		El --pvptotal-- ser� el --pvpsindto-- menos el --dtopor-- y menos el --dtolineal--
		\end */
		/** \Cvar util:FLUtil = new FLUtil();
		El --dtopor-- ser� el descuento asociado al cliente
		\end */
}

function interna_validateForm():Boolean
{
		var cursor:FLSqlCursor = this.cursor();

		/** \C
		La cantidad de art�culos especificada ser� mayor o igual que la del --totalenalbaran--
		\end */
		if (parseFloat(cursor.valueBuffer("cantidad")) < parseFloat(cursor.valueBuffer("totalenalbaran"))) {
				var util:FLUtil = new FLUtil();
				MessageBox.critical(util.translate("scripts","La cantidad especificada no puede ser menor que la servida."),
						MessageBox.Ok, MessageBox.NoButton,MessageBox.NoButton);
				return false;
		}
		return true;
}

function interna_acceptedForm()
{
		disconnect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_desconectar()
{
		disconnect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");
}

function oficial_bufferChanged(fN:String)
{
		this.iface.commonBufferChanged(fN, form);
		/** \C
		Al cambiar la --referencia-- se mostrar�n los valores asociados de --pvpvunitario-- y --codimpuesto--
		\end */
		/** \C
		Al cambiar el --codimpuesto-- se mostrar�n los valores asociados de --iva--
		\end */
		/** \C
		Al cambiar la --cantidad-- o el --pvpunitario-- se mostrar� el valor asociado de --pvpsindto--
		\end */
		/** \C
		Al cambiar el --pvpsindto--, el --dtopor-- o el --dtolineal-- se mostrar� el valor asociado de --pvptotal--
		\end */
}

function oficial_commonBufferChanged(fN:String, miForm:Object)
{
	switch (fN) {
	case "referencia":{
			miForm.child("fdbPvpUnitario").setValue(this.iface.commonCalculateField("pvpunitario", miForm.cursor()));
			miForm.child("fdbCodImpuesto").setValue(this.iface.commonCalculateField("codimpuesto", miForm.cursor()));
			break;
		}
	case "codimpuesto":{
			miForm.child("fdbIva").setValue(this.iface.commonCalculateField("iva", miForm.cursor()));
			break;
		}
	case "cantidad":
	case "pvpunitario":{
			miForm.child("fdbPvpSinDto").setValue(this.iface.commonCalculateField("pvpsindto", miForm.cursor()));
			break;
		}
	case "pvpsindto":
	case "dtopor":{
			miForm.child("lblDtoPor").setText(this.iface.commonCalculateField("lbldtopor", miForm.cursor()));
		}
	case "dtolineal":{
			miForm.child("fdbPvpTotal").setValue(this.iface.commonCalculateField("pvptotal", miForm.cursor()));
			break;
		}
	case "pvptotal":
	case "porcomision":{
		miForm.child("lblComision").setText(this.iface.commonCalculateField("lblComision",miForm.cursor()));
		break;
	}
	}
}

/** \D Obtiene la tarifa asociada a un cliente
@param codCliente: c�digo del cliente
@param cursor: Cursor del documento que busca la tarifa. Para sobreescribir
@return C�digo de la tarifa asociada o false si no tiene ninguna tarifa asociada
\end */
function oficial_obtenerTarifa(codCliente:String, cursor:FLSqlCursor):String
{
	var util:FLUtil = new FLUtil;
	if (cursor.table() == "lineasservicioscli")
		return util.sqlSelect("clientes c INNER JOIN gruposclientes gc ON c.codgrupo = gc.codgrupo", "gc.codtarifa", "codcliente = '" + codCliente + "'", "clientes,gruposclientes");

	return cursor.cursorRelation().valueBuffer("codtarifa");
}

function oficial_commonCalculateField(fN:String, cursor:FLSqlCursor):String
{
	var util:FLUtil = new FLUtil();
	var datosTP:Array = this.iface.datosTablaPadre(cursor);
	if (!datosTP)
		return false;
	var wherePadre:String = datosTP.where;
	var tablaPadre:String = datosTP.tabla;
	
	var valor:String;
	switch (fN) {
		case "pvpunitario":{
			var codCliente:String = util.sqlSelect(tablaPadre, "codcliente", wherePadre);
			var referencia:String = cursor.valueBuffer("referencia");
			var codTarifa:String = this.iface.obtenerTarifa(codCliente, cursor);
			if (codTarifa)
				valor = util.sqlSelect("articulostarifas", "pvp", "referencia = '" + referencia + "' AND codtarifa = '" + codTarifa + "'");
			if (!valor)
				valor = util.sqlSelect("articulos", "pvp", "referencia = '" + referencia + "'");
			var tasaConv:Number = util.sqlSelect(tablaPadre, "tasaconv", wherePadre);
			valor = parseFloat(valor) / tasaConv;
			break;
		}
		case "pvpsindto":{
			valor = parseFloat(cursor.valueBuffer("pvpunitario")) * parseFloat(cursor.valueBuffer("cantidad"));
			valor = util.roundFieldValue(valor, "lineaspedidoscli", "pvpsindto");
			break;
		}
		case "iva": {
			valor = parseFloat(util.sqlSelect("impuestos", "iva", "codimpuesto = '" + cursor.valueBuffer("codimpuesto") + "'"));
			if (isNaN(valor)) {
				valor = 0;
			}
			break;
		}
		case "lbldtopor":{
			valor = (cursor.valueBuffer("pvpsindto") * cursor.valueBuffer("dtopor")) / 100;
			valor = util.roundFieldValue(valor, "lineaspedidoscli", "pvpsindto");
			break;
		}
		case "pvptotal":{
			var dtoPor:Number = (cursor.valueBuffer("pvpsindto") * cursor.valueBuffer("dtopor")) / 100;
			dtoPor = util.roundFieldValue(dtoPor, "lineaspedidoscli", "pvpsindto");
			valor = cursor.valueBuffer("pvpsindto") - parseFloat(dtoPor) - cursor.valueBuffer("dtolineal");
			valor = util.roundFieldValue(valor,cursor.table(),"pvptotal");
			break;
		}
		case "dtopor":{
			var codCliente:String = util.sqlSelect(tablaPadre, "codcliente", wherePadre);
			valor = flfactppal.iface.pub_valorQuery("descuentosclientes,descuentos", "SUM(d.dto)", "descuentosclientes dc INNER JOIN descuentos d ON dc.coddescuento = d.coddescuento", "dc.codcliente = '" + codCliente + "';");
			break;
		}
		case "codimpuesto": {
			var codCliente:String = util.sqlSelect(tablaPadre, "codcliente", wherePadre);
			var codSerie:String = util.sqlSelect(tablaPadre, "codserie", wherePadre);
			if (flfacturac.iface.pub_tieneIvaDocCliente(codSerie, codCliente))
				valor = util.sqlSelect("articulos", "codimpuesto", "referencia = '" + cursor.valueBuffer("referencia") + "'");
			else
				valor = "EXENTO";
			break;
		}
		case "porcomision": {
				var codAgente:String = util.sqlSelect(tablaPadre, "codagente", wherePadre);
				if(!codAgente || codAgente == "") {
					valor = "";
					break;
				}
				var comisionAgente:Number = flfacturac.iface.pub_calcularComisionLinea(codAgente,cursor.valueBuffer("referencia"));
				comisionAgente = util.roundFieldValue(comisionAgente, cursor.table(), "porcomision");
				valor = comisionAgente.toString();
			break;
		}
		case "lblComision": {
			var porComision:Number = parseFloat(cursor.valueBuffer("porcomision"));
			if(!porComision)
				break;
			var pvpTotal:Number = parseFloat(cursor.valueBuffer("pvptotal"));
			var comision:Number = (porComision * pvpTotal) / 100;
			comision = util.roundFieldValue(comision, cursor.table(), "pvptotal");
			valor = comision.toString();
			break;
		}
	}
	return valor;
}

/** \D Devuelve la tabla padre de la tabla par�metro, as� como la cl�usula where necesaria para localizar el registro padre
@param	cursor: Cursor cuyo padre se busca
@return	Array formado por:
	* where: Cl�usula where
	* tabla: Nombre de la tabla padre
o false si hay error
\end */
function oficial_datosTablaPadre(cursor:FLSqlCursor):Array
{
	var datos:Array;
	switch (cursor.table()) {
		case "lineaspresupuestoscli": {
			datos.where = "idpresupuesto = "+ cursor.valueBuffer("idpresupuesto");
			datos.tabla = "presupuestoscli";
			break;
		}
		case "lineaspedidoscli": {
			datos.where = "idpedido = "+ cursor.valueBuffer("idpedido");
			datos.tabla = "pedidoscli";
			break;
		}
		case "lineasalbaranescli": {
			datos.where = "idalbaran = "+ cursor.valueBuffer("idalbaran");
			datos.tabla = "albaranescli";
			break;
		}
		case "lineasfacturascli": {
			datos.where = "idfactura = "+ cursor.valueBuffer("idfactura");
			datos.tabla = "facturascli";
			break;
		}
	}
	return datos;
}

function oficial_filtrarArticulos()
{
	var filtroReferencia:String = "";
	if (filtroReferencia != "") {
		filtroReferencia += " AND ";
	}
	filtroReferencia += "sevende AND NOT debaja";

	this.child("fdbReferencia").setFilter(filtroReferencia);
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ivaIncluido */
//////////////////////////////////////////////////////////////////
//// IVAINCLUIDO /////////////////////////////////////////////////////

function ivaIncluido_init()
{
	this.iface.habilitarPorIvaIncluido(form);
	this.iface.__init();
}

function ivaIncluido_commonBufferChanged(fN:String, miForm:Object)
{
	var util:FLUtil = new FLUtil();
	
	switch (fN) {
		case "referencia": {
			this.iface.bloqueoPrecio = true;
			miForm.child("fdbIvaIncluido").setValue(this.iface.commonCalculateField("ivaincluido", miForm.cursor()));
			miForm.child("fdbPvpUnitarioIva").setValue(this.iface.commonCalculateField("pvpunitarioiva", miForm.cursor()));
			miForm.child("fdbCodImpuesto").setValue(this.iface.commonCalculateField("codimpuesto", miForm.cursor()));
			miForm.cursor().setValueBuffer("pvpunitario", this.iface.commonCalculateField("pvpunitario", miForm.cursor()));
			this.iface.bloqueoPrecio = false;
			break;
		}
		case "codimpuesto": {
			miForm.child("fdbIva").setValue(this.iface.commonCalculateField("iva", miForm.cursor()));
			if (!this.iface.bloqueoPrecio && miForm.cursor().valueBuffer("ivaincluido")) {
				this.iface.bloqueoPrecio = true;
				miForm.cursor().setValueBuffer("pvpunitario", this.iface.commonCalculateField("pvpunitario", miForm.cursor()));
				this.iface.bloqueoPrecio = false;
			}
			break;
		}
		case "ivaincluido":
			this.iface.habilitarPorIvaIncluido(miForm);
		case "pvpunitarioiva": {
			if (!this.iface.bloqueoPrecio) {
				this.iface.bloqueoPrecio = true;
				var pvpUnitario:Number = this.iface.commonCalculateField("pvpunitario", miForm.cursor());
				miForm.cursor().setValueBuffer("pvpunitario", pvpUnitario);
				this.iface.bloqueoPrecio = false;
			}
			break;
		}
		case "pvpunitario":
			if (!this.iface.bloqueoPrecio) {
				this.iface.bloqueoPrecio = true;
				miForm.child("fdbPvpUnitarioIva").setValue(miForm.cursor().valueBuffer("pvpunitarioiva"));
				this.iface.bloqueoPrecio = false;
			}
		case "cantidad": {
			if (miForm.cursor().valueBuffer("ivaincluido")) {
				miForm.cursor().setValueBuffer("pvpsindto", this.iface.commonCalculateField("pvpsindto", miForm.cursor()));
			} else {
				return this.iface.__commonBufferChanged(fN, miForm);
			}
			break;
		}
		case "pvpsindto":
		case "dtopor": {
			miForm.child("lblDtoPor").setText(this.iface.commonCalculateField("lbldtopor", miForm.cursor()));
		}
		case "dtolineal": {
			if (miForm.cursor().valueBuffer("ivaincluido")) {
				miForm.cursor().setValueBuffer("pvptotal", this.iface.commonCalculateField("pvptotal", miForm.cursor()));
			} else {
				return this.iface.__commonBufferChanged(fN, miForm);
			}
			break;
		}
		default:
			return this.iface.__commonBufferChanged(fN, miForm);
	}
}

function ivaIncluido_commonCalculateField(fN, cursor):String 
{
	var util:FLUtil = new FLUtil();
	var valor:String;
	var referencia:String = cursor.valueBuffer("referencia");
	
	switch (fN) {
		case "pvpunitarioiva":
			valor = this.iface.__commonCalculateField("pvpunitario", cursor);
			break;
		case "pvpunitario":
			valor = cursor.valueBuffer("pvpunitarioiva");
			if (cursor.valueBuffer("ivaincluido")) {
				var iva:Number = cursor.valueBuffer("iva");
				if (!iva)
					iva = util.sqlSelect("impuestos", "iva", "codimpuesto = '" + cursor.valueBuffer("codimpuesto") + "'");
				valor = parseFloat(valor) / (1 + iva / 100);
			}
			break;
		case "pvpsindto":
			valor = parseFloat(cursor.valueBuffer("pvpunitario")) * parseFloat(cursor.valueBuffer("cantidad"));
			break;
		
		case "ivaincluido":
			valor = util.sqlSelect("articulos", "ivaincluido", "referencia = '" + referencia + "'");
			break;
		
		case "pvptotal":{
			var dtoPor:Number = (cursor.valueBuffer("pvpsindto") * cursor.valueBuffer("dtopor")) / 100;
			dtoPor = util.roundFieldValue(dtoPor, "lineaspedidoscli", "pvpsindto");
			valor = cursor.valueBuffer("pvpsindto") - parseFloat(dtoPor) - cursor.valueBuffer("dtolineal");
			break;
		}
		default:
			return this.iface.__commonCalculateField(fN, cursor);
	}
	return valor;
}

function ivaIncluido_habilitarPorIvaIncluido(miForm:Object)
{
	if (miForm.cursor().modeAccess() != miForm.cursor().Browse) {
		if (miForm.cursor().valueBuffer("ivaincluido")) {
			miForm.child("fdbPvpUnitario").setDisabled(true);
			miForm.child("fdbPvpUnitarioIva").setDisabled(false);
		}
		else {
			miForm.child("fdbPvpUnitario").setDisabled(false);
			miForm.child("fdbPvpUnitarioIva").setDisabled(true);
		}
	}
}
//// IVAINCLUIDO /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_definition lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
/** \C La tabla de movimientos mostrar� movimientos asociados a la l�nea de remito
\end */
function lotes_init() {
	this.iface.__init();
	
	connect(this.child("tdbMoviLote").cursor(), "bufferCommited()", this, "iface.calcularCantidad()");
	this.iface.habilitarControlesPorLotes();
	this.child("fdbReferencia").editor().setFocus();
}


/** \C Si el art�culo seleccionado est� gestionado por lotes se inhabilitar� el campo --cantidad--, que tomar� el valor de la suma del campo cantidad de los movimientos asociados a la l�nea. Si no est� gestionado por lotes, se inhabilitar� la secci�n 'Movimientos de lotes'.
\end */
function lotes_bufferChanged(fN:String) {
	
	switch (fN) {
		case "referencia": {
			this.iface.habilitarControlesPorLotes();
			this.iface.__bufferChanged(fN);
			break;
		}
		default: {
			this.iface.__bufferChanged(fN);
		}
	}
}

/** \D Calcula la cantidad como suma de los movimientos asociados a la l�nea. 

Si hay uno o m�s movimientos, la referencia no podr� ser modificada
\end */
function lotes_calcularCantidad()
{
	if (this.child("tdbMoviLote").cursor().size() > 0)
		this.child("fdbReferencia").setDisabled(true);
	else 
		this.child("fdbReferencia").setDisabled(false);
		
	this.cursor().setValueBuffer("cantidad", this.iface.calculateField("cantidad"));
}

/** \D Calcula el valor de un campo

@param	fN: Nombre del campo
@return	Valor del campo calculado
\end */
function lotes_calculateField(fN:String):String
{
	var res:String;
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	switch (fN) {
		case "cantidad": {
			if (this.iface.porLotes) {
				res = util.sqlSelect("movilote", "SUM(cantidad)", "docorigen = 'PC' AND idlineapc = " + cursor.valueBuffer("idlinea"));
				res = -1 * parseFloat(res);
			} else
				res = this.iface.__calculateField(fN);
			break;
		}
		default: {
			res = this.iface.__calculateField(fN);
		}
	}
	return res;
}

/** \D Habilita y pone los valores iniciales para los controles del formulario en funci�n de si el art�culo seleccionado es por lotes o no
\end */
function lotes_habilitarControlesPorLotes() 
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	this.iface.porLotes = util.sqlSelect("articulos", "porlotes", "referencia = '" + cursor.valueBuffer("referencia") + "'");
	if (this.iface.porLotes && flfactppal.iface.pub_valorDefectoEmpresa("lotepedidos")) {
		this.child("tbwLinea").setTabEnabled("lotes", true);
		this.child("fdbCantidad").setDisabled(true);
		this.iface.calcularCantidad();
	} else {
		this.child("tbwLinea").setTabEnabled("lotes", false);
		this.child("fdbCantidad").setDisabled(false);
		this.child("fdbReferencia").setDisabled(false);
	}
}
//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition serviciosCli */
/////////////////////////////////////////////////////////////////
//// SERVICIOS CLI //////////////////////////////////////////////
function serviciosCli_datosTablaPadre(cursor:FLSqlCursor):Array
{
	var datos:Array;
	switch (cursor.table()) {
		case "lineasservicioscli": {
			datos.where = "idservicio = "+ cursor.valueBuffer("idservicio");
			datos.tabla = "servicioscli";
			break;
		}
		default: {
			return this.iface.__datosTablaPadre(cursor);
		}
	}
	return datos;
}
//// SERVICIOS CLI //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition totalesIva */
/////////////////////////////////////////////////////////////////
//// TOTALES CON IVA ////////////////////////////////////////////

function totalesIva_commonBufferChanged(fN:String, miForm:Object)
{
	var util:FLUtil = new FLUtil();
	
	switch (fN) {
		case "pvptotal": {
			miForm.child("fdbTotalConIVA").setValue(this.iface.commonCalculateField("totalconiva", miForm.cursor()));
			return this.iface.__commonBufferChanged(fN, miForm);
			break;
		}
		default:
			return this.iface.__commonBufferChanged(fN, miForm);
	}
}

function totalesIva_commonCalculateField(fN, cursor):String
{
	var util:FLUtil = new FLUtil();
	var valor:String;
	
	switch (fN) {
		case "totalconiva":{
			var pvpTotal:Number = cursor.valueBuffer("pvptotal");
			var iva:Number = parseFloat(cursor.valueBuffer("iva"));
			if ( isNaN(iva) )
				iva = 0;
			valor = parseFloat(pvpTotal) * (1 + iva / 100);
			valor = util.roundFieldValue(valor, "lineaspedidoscli", "totalconiva");
			break;
		}
		default:
			return this.iface.__commonCalculateField(fN, cursor);
	}

	return valor;
}

//// TOTALES CON IVA ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition informacionLineas */
/////////////////////////////////////////////////////////////////
//// INFORMACION LINEAS /////////////////////////////////////////

function informacionLineas_init() {
	this.iface.__init();
	
	if (this.cursor().modeAccess() == this.cursor().Edit || this.cursor().modeAccess() == this.cursor().Browse)
		this.child("lblStockFisico").setText(this.iface.commonCalculateField("lblStockFisico", this.cursor()));
}

function informacionLineas_commonBufferChanged(fN:String, miForm:Object)
{
	var util:FLUtil = new FLUtil();

	if (miForm.cursor().table() == "lineasservicioscli")
		return this.iface.__commonBufferChanged(fN, miForm);

	switch (fN) {
		case "referencia": {
			miForm.child("lblStockFisico").setText(this.iface.commonCalculateField("lblStockFisico", miForm.cursor()));
			miForm.child("fdbCostoUnitario").setValue(this.iface.commonCalculateField("costounitario", miForm.cursor()));
			this.iface.__commonBufferChanged(fN, miForm);
			break;
		}
		case "costounitario":
		case "cantidad": {
			miForm.child("fdbCostoTotal").setValue(this.iface.commonCalculateField("costototal", miForm.cursor()));
			this.iface.__commonBufferChanged(fN, miForm);
			break;
		}
		case "pvptotal": {
			miForm.child("fdbGanancia").setValue(this.iface.commonCalculateField("ganancia", miForm.cursor()));
			this.iface.__commonBufferChanged(fN, miForm);
			break;
		}
		case "ganancia": {
			miForm.child("fdbUtilidad").setValue(this.iface.commonCalculateField("utilidad", miForm.cursor()));
			break;
		}
		default:
			this.iface.__commonBufferChanged(fN, miForm);
	}
}

function informacionLineas_commonCalculateField(fN, cursor):String
{
	var util:FLUtil = new FLUtil();
	var valor:String;
	
	switch (fN) {
		case "lblStockFisico":{
			var stockFisico:Number = util.sqlSelect("articulos", "stockfis", "referencia = '" + cursor.valueBuffer("referencia") + "'");
			if (!stockFisico || isNaN(stockFisico))
				valor = 0;
			else
				valor = stockFisico;
			break;
		}
		case "costounitario":{
			var costounitario:Number;
			costounitario = parseFloat(util.sqlSelect("articulos", "costeultimo",  "referencia = '" + cursor.valueBuffer("referencia") + "'"));
			if (!costounitario || isNaN(costounitario)) {
				costounitario = parseFloat(util.sqlSelect("articulos", "costemaximo",  "referencia = '" + cursor.valueBuffer("referencia") + "'"));
			}
			if (!costounitario || isNaN(costounitario)) {
				costounitario = 0;
			}
			valor = util.roundFieldValue(costounitario, cursor.table(), "costounitario");
			break;
		}
		case "costototal":{
			var costototal:Number;
			costototal = parseFloat(cursor.valueBuffer("costounitario")) * parseFloat(cursor.valueBuffer("cantidad"));
			valor = util.roundFieldValue(costototal, cursor.table(), "costototal");
			break;
		}
		case "ganancia":{
			var ganancia:Number;
			ganancia = parseFloat(cursor.valueBuffer("pvptotal")) - parseFloat(cursor.valueBuffer("costototal"));
			valor = util.roundFieldValue(ganancia, cursor.table(), "ganancia");
			break;
		}
		case "utilidad":{
			var utilidad:Number = 0;
			if (parseFloat(cursor.valueBuffer("pvptotal")) != 0)
				utilidad = (parseFloat(cursor.valueBuffer("ganancia")) / parseFloat(cursor.valueBuffer("pvptotal")))*100 ;
			valor = util.roundFieldValue(utilidad, cursor.table(), "utilidad");
			break;
		}
		default:
			return this.iface.__commonCalculateField(fN, cursor);
	}

	return valor;
}

//// INFORMACION LINEAS /////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition multiDivisa */
/////////////////////////////////////////////////////////////////
//// MULTI DIVISA ///////////////////////////////////////////////

function multiDivisa_commonCalculateField(fN, cursor):String
{
	var util:FLUtil = new FLUtil();
	var valor:String;
	
	switch (fN) {
		case "pvpunitarioiva": {
			var codCliente:String = cursor.cursorRelation().valueBuffer("codcliente");
			var referencia:String = cursor.valueBuffer("referencia");
			var codTarifa:String = this.iface.obtenerTarifa(codCliente, cursor);
			if (codTarifa)
				valor = util.sqlSelect("articulostarifas", "pvp", "referencia = '" + referencia + "' AND codtarifa = '" + codTarifa + "'");
			if (!valor)
				valor = util.sqlSelect("articulos", "pvp", "referencia = '" + referencia + "'");

			var codDivisaArt:String = util.sqlSelect("articulos", "coddivisa", "referencia = '" + referencia + "'");
			var tasaConvArt:Number = util.sqlSelect("divisas", "tasaconv", "coddivisa = '" + codDivisaArt + "'");
			var tasaConvDoc:Number = cursor.cursorRelation().valueBuffer("tasaconv");

			if (codDivisaArt != cursor.cursorRelation().valueBuffer("coddivisa"))
				valor = parseFloat(valor) * (parseFloat(tasaConvArt)/parseFloat(tasaConvDoc));
			break;
		}
		case "pvpunitario": {
			valor = cursor.valueBuffer("pvpunitarioiva");
			if (cursor.valueBuffer("ivaincluido")) {
				var iva:Number = cursor.valueBuffer("iva");
				if (!iva)
					iva = util.sqlSelect("impuestos", "iva", "codimpuesto = '" + cursor.valueBuffer("codimpuesto") + "'");
				valor = parseFloat(valor) / (1 + iva / 100);
			}
			break;
		}
		case "ganancia":{
			var ganancia:Number;
			ganancia = parseFloat(cursor.valueBuffer("pvptotal")*cursor.cursorRelation().valueBuffer("tasaconv")) - parseFloat(cursor.valueBuffer("costototal"));
			valor = util.roundFieldValue(ganancia, cursor.table(), "ganancia");
			break;
		}
		case "utilidad":{
			var utilidad:Number = 0;
			if (parseFloat(cursor.valueBuffer("pvptotal")) != 0)
				utilidad = (parseFloat(cursor.valueBuffer("ganancia")) / parseFloat(cursor.valueBuffer("pvptotal")*cursor.cursorRelation().valueBuffer("tasaconv")))*100 ;
			valor = util.roundFieldValue(utilidad, cursor.table(), "utilidad");
			break;
		}
		default:
			return this.iface.__commonCalculateField(fN, cursor);
	}

	return valor;
}

//// MULTI DIVISA ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////