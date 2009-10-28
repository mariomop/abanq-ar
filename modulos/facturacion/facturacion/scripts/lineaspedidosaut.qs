/***************************************************************************
                 lineaspedidosaut.qs  -  description
                             -------------------
    begin                : 31.08.2007
    copyright            : (C) 2007 by Mathias Behrle
    email                : mathiasb@behrle.dyndns.org
    partly based on code by
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
	function filtrarArticulos() {
		return this.ctx.oficial_filtrarArticulos();
	}
	function datosTablaPadre(cursor:FLSqlCursor):Array {
		return this.ctx.oficial_datosTablaPadre(cursor);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration totalesIva */
/////////////////////////////////////////////////////////////////
//// TOTALES CON IVA ////////////////////////////////////////////
class totalesIva extends oficial {
    function totalesIva( context ) { oficial ( context ); }
	function commonBufferChanged(fN:String, miForm:Object) {
		return this.ctx.totalesIva_commonBufferChanged(fN, miForm);
	}
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.totalesIva_commonCalculateField(fN, cursor);
	}
}
//// TOTALES CON IVA ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends totalesIva {
    function head( context ) { totalesIva ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
		function pub_commonCalculateField(fN:String, cursor:FLSqlCursor):String {
				return this.commonCalculateField(fN, cursor);
		}
		function pub_commonBufferChanged(fN:String, miForm:Object) {
				return this.commonBufferChanged(fN, miForm);
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
Este formulario realiza la gesti�n de las l�neas de pedidos automaticos a proveedores.
\end */
function interna_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(form, "closed()", this, "iface.desconectar");
	if (cursor.modeAccess() == cursor.Insert)
		this.child("fdbDtoPor").setValue(this.iface.calculateField("dtopor"));

	this.child("lblDtoPor").setText(this.iface.calculateField("lblDtoPor"));
	this.child("lblStockFis").setText(this.iface.calculateField("lblStockFis"));

	
	if (cursor.modeAccess() == cursor.Insert || cursor.modeAccess() == cursor.Edit) {
		if ( !flfacturac.iface.pub_tieneIvaDocProveedor(cursor.cursorRelation().valueBuffer("codserie"), cursor.cursorRelation().valueBuffer("codproveedor")) ) {
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
	El --pvpunitario-- ser� el correspondiente al coste por proveedor y moneda correspondiente a la --referencia-- seleccionada
	\end */
	/** \C
	El --codimpuesto-- ser� el correspondiente a la --referencia-- seleccionada
	\end */
	/** \C
	El --iva-- ser� el correspondiente al --codimpuesto-- en la tabla de impuestos
	\end */
	/** \C
	El --pvptotal-- ser� el --pvpsindto-- menos el --dtopor-- y menos el --dtolineal--
	\end */
	/** \C
	El --dtopor-- ser� el descuento asociado al proveedor
	\end */
	/** \C
	El --pvpsindto-- ser� el producto del campo --cantidad-- por el campo --pvpunitario--
	\end */
}

function interna_validateForm():Boolean
{
	/** \C
	La cantidad de art�culos especificada ser� mayor o igual que la del --totalenalbaran--
	\end */
/*	if (parseFloat(this.cursor().valueBuffer("cantidad")) < parseFloat(this.cursor().valueBuffer("totalenalbaran")))
		return false;
	else*/
		return true;
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
	Al cambiar la --cantidad-- o el --pvpunitario-- se mostrar� el valor asociado de --pvptotal--
	\end */
	/** \C
	Al cambiar el --pvpsindto--, el --dtopor-- o el --dtolineal-- se mostrar� el valor asociado de --pvptotal--
	\end */
}

function oficial_commonBufferChanged(fN:String, miForm:Object)
{
	switch (fN) {
		case "referencia":{
			var util:FLUtil = new FLUtil();
			miForm.child("fdbPvpUnitario").setValue(this.iface.commonCalculateField("pvpunitario", miForm.cursor()));
			miForm.child("lblStockFis").setText(this.iface.commonCalculateField("lblStockFis", miForm.cursor()));
			miForm.child("fdbRefProveedor").setValue(this.iface.commonCalculateField("fdbRefProveedor", miForm.cursor()));
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
	}
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
		case "pvpsindto":{
			valor = parseFloat(cursor.valueBuffer("pvpunitario")) * parseFloat(cursor.valueBuffer("cantidad"));
			valor = util.roundFieldValue(valor, "lineaspedidosprov", "pvptotal");
			break;
		}
		case "codimpuesto":{
			var codProveedor:String = util.sqlSelect(tablaPadre, "codproveedor", wherePadre);
			var codSerie:String = util.sqlSelect(tablaPadre, "codserie", wherePadre);
			if (flfacturac.iface.pub_tieneIvaDocProveedor(codSerie, codProveedor))
				valor = util.sqlSelect("articulos", "codimpuesto", "referencia = '" + cursor.valueBuffer("referencia") + "'");
			else
				valor = "EXENTO";
			break;
		}
		case "iva":{
			valor = util.sqlSelect("impuestos", "iva", "codimpuesto = '" + cursor.valueBuffer("codimpuesto") + "'");
			break;
		}
		case "lbldtopor":{
			valor = (cursor.valueBuffer("pvpsindto") * cursor.valueBuffer("dtopor")) / 100;
			valor = util.roundFieldValue(valor, "lineaspedidosprov", "pvpsindto");
			break;
		}
		case "pvptotal":{
			var dtoPor:Number = (cursor.valueBuffer("pvpsindto") * cursor.valueBuffer("dtopor")) / 100;
			dtoPor = util.roundFieldValue(dtoPor, "lineaspedidosprov", "pvpsindto");
			valor = cursor.valueBuffer("pvpsindto") - parseFloat(dtoPor) - cursor.valueBuffer("dtolineal");
			break;
		}
		case "dtopor":{
			var codProveedor:String = util.sqlSelect(tablaPadre, "codproveedor", wherePadre);
			valor = flfactppal.iface.pub_valorQuery("descuentosproveedores,descuentos", "SUM(d.dto)", "descuentosproveedores dc INNER JOIN descuentos d ON dc.coddescuento = d.coddescuento", "dc.codproveedor = '" + codProveedor + "'");
			break;
		}
		case "pvpunitario":{
			var codProveedor:String = util.sqlSelect(tablaPadre, "codproveedor", wherePadre);
			var codDivisa:String = util.sqlSelect(tablaPadre, "coddivisa", wherePadre);
			valor = util.sqlSelect("articulosprov", "coste", "referencia = '" + cursor.valueBuffer("referencia") + "' AND codproveedor = '" + codProveedor + "' AND coddivisa = '" + codDivisa + "'");
			break;
		}
		case "lblStockFis":{
			if (sys.isLoadedModule("flfactalma")) {
				var stockFisico:Number = util.sqlSelect("stocks", "SUM(cantidad)", "referencia = '" + cursor.valueBuffer("referencia") + "'");
				valor = util.translate("scripts", "Stock f�sico:  ") + stockFisico + "  ";
			}
			break;
		}
		case "fdbRefProveedor":{
			var codProveedor:String = util.sqlSelect(tablaPadre, "codproveedor", wherePadre);
			valor = util.sqlSelect("articulosprov", "refproveedor", "referencia = '" + cursor.valueBuffer("referencia") + "' AND codproveedor = '" + codProveedor  + "'");
			break;
		}
	}
	return valor;
}

function oficial_filtrarArticulos()
{
	var filtroReferencia:String = "";
	if (filtroReferencia != "") {
		filtroReferencia += " AND ";
	}
	filtroReferencia += "secompra AND NOT debaja";

	this.child("fdbReferencia").setFilter(filtroReferencia);
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
		case "lineaspedidosprov": {
			datos.where = "idpedido = "+ cursor.valueBuffer("idpedido");
			datos.tabla = "pedidosprov";
			break;
		}
		case "lineasalbaranesprov": {
			datos.where = "idalbaran = "+ cursor.valueBuffer("idalbaran");
			datos.tabla = "albaranesprov";
			break;
		}
		case "lineasfacturasprov": {
			datos.where = "idfactura = "+ cursor.valueBuffer("idfactura");
			datos.tabla = "facturasprov";
			break;
		}
		case "lineaspedidosaut": {
			datos.where = "idpedidoaut = "+ cursor.valueBuffer("idpedidoaut");
			datos.tabla = "pedidosaut";
			break;
		}
	}
	return datos;
}

//// OFICIAL /////////////////////////////////////////////////////
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
			valor = util.roundFieldValue(valor, "lineaspedidosaut", "totalconiva");
			break;
		}
		default:
			return this.iface.__commonCalculateField(fN, cursor);
	}

	return valor;
}

//// TOTALES CON IVA ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
