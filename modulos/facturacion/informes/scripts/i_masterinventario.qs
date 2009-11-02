/***************************************************************************
                 i_masterinventario.qs  -  description
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
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var totalAlmacen_:Number;
	var totalInforme_:Number;
    function oficial( context ) { interna( context ); } 
	function lanzar() {
			return this.ctx.oficial_lanzar();
	}
	function obtenerOrden(nivel:Number, cursor:FLSqlCursor):String {
			return this.ctx.oficial_obtenerOrden(nivel, cursor);
	}
	function costeArticulo(nodo:FLDomNode, campo:String):String {
		return this.ctx.oficial_costeArticulo(nodo, campo);
	}
	function totalAlmacen(nodo:FLDomNode, campo:String):String {
		return this.ctx.oficial_totalAlmacen(nodo, campo);
	}
	function totalInforme(nodo:FLDomNode, campo:String):String {
		return this.ctx.oficial_totalInforme(nodo, campo);
	}
	function iniciarTotales(nodo:FLDomNode, campo:String):String {
		return this.ctx.oficial_iniciarTotales(nodo, campo);
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
	function pub_lanzar() {
		return this.lanzar();
	}
	function pub_costeArticulo(nodo:FLDomNode, campo:String):String {
		return this.costeArticulo(nodo, campo);
	}
	function pub_totalAlmacen(nodo:FLDomNode, campo:String):String {
		return this.totalAlmacen(nodo, campo);
	}
	function pub_totalInforme(nodo:FLDomNode, campo:String):String {
		return this.totalInforme(nodo, campo);
	}
	function pub_iniciarTotales(nodo:FLDomNode, campo:String):String {
		return this.iniciarTotales(nodo, campo);
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
function interna_init()
{
		connect (this.child("toolButtonPrint"), "clicked()", this, "iface.lanzar()");
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_lanzar()
{
	this.iface.totalAlmacen_ = 0;
	this.iface.totalInforme_ = 0;
	var cursor:FLSqlCursor = this.cursor();
	var seleccion:String = cursor.valueBuffer("id");
	if (!seleccion)
			return;
			
	var nombreInforme:String = cursor.action();
	var orderBy:String = "";
	var o:String = "";
	for (var i:Number = 1; i < 3; i++) {
		o = this.iface.obtenerOrden(i, cursor);
		if (o) {
			if (orderBy == "") {
				orderBy = o;
			} else {
				orderBy += ", " + o;
			}
		}
	}
	var whereFijo:String = "articulos.nostock <> true";
	flfactinfo.iface.pub_lanzarInforme(cursor, nombreInforme, orderBy, "", false, false, whereFijo);
}

function oficial_obtenerOrden(nivel:Number, cursor:FLSqlCursor):String
{
	var ret:String = "";
	var orden:String = cursor.valueBuffer("orden" + nivel.toString());
	switch(nivel) {
		case 1: {
			switch(orden) {
				case "C�digo": {
					ret += "almacenes.codalmacen";
					break;
				}
				case "Nombre": {
					ret += "almacenes.nombre";
					break;
				}
			}
			break;
		}
		break;
		case 2: {
			switch(orden) {
				case "Referencia": {
					ret += "stocks.referencia";
					break;
				}
				case "Descripci�n": {
					ret += "articulos.descripcion";
					break;
				}
			}
			break;
		}
		break;
	}
	if (ret != "") {
		var tipoOrden:String = cursor.valueBuffer("tipoorden" + nivel.toString());
		switch(tipoOrden) {
			case "Descendente": {
				ret += " DESC";
				break;
			}
		}
	}

	if (nivel == 1 && orden != 1) {
		if (ret == "") {
			ret += "almacenes.codalmacen";
		} else {
			ret += ", almacenes.codalmacen";
		}
	}

	return ret;
}

function oficial_costeArticulo(nodo:FLDomNode, campo:String):String
{
	var util:FLUtil = new FLUtil;
	var tipoValoracion:String = nodo.attributeValue("almacenes.tipovaloracion");
	var campoRed:String;
	var tablaRed:String;
	var valor:Number;
	switch (tipoValoracion) {
		case util.translate("scripts","Costo m�ximo"): {
			valor = nodo.attributeValue("articulos.costemaximo")
			tablaRed = "articulos";
			campoRed = "costemaximo";
			break;
		}
		case util.translate("scripts","�ltimo costo"): {
			valor = nodo.attributeValue("articulos.costeultimo")
			tablaRed = "articulos";
			campoRed = "costeultimo";
			break;
		}
		case util.translate("scripts","Costo medio"): {
			valor = nodo.attributeValue("articulos.costemedio")
			tablaRed = "articulos";
			campoRed = "costemedio";
			break;
		}
		case util.translate("scripts","Precio de venta"): {
			var porPvp:Number = parseFloat(nodo.attributeValue("almacenes.porpvp"));
			valor = parseFloat(nodo.attributeValue("articulos.pvp")) * porPvp / 100;
			tablaRed = "articulos";
			campoRed = "pvp";
			break;
		}
	}
	if (campo == "total") {
		var cantidad:Number = parseFloat(nodo.attributeValue("stocks.cantidad"));
		valor = parseFloat(valor) * parseFloat(cantidad);
		if (isNaN(this.iface.totalAlmacen_)) {
			this.iface.totalAlmacen_ = 0;
		}
		this.iface.totalAlmacen_ += parseFloat(valor);
		
		if (isNaN(this.iface.totalInforme_)) {
			this.iface.totalInforme_ = 0;
		}
		this.iface.totalInforme_ += parseFloat(valor);
	}
	valor = util.roundFieldValue(valor, tablaRed, campoRed);

	return valor;
}

function oficial_totalAlmacen(nodo:FLDomNode, campo:String):String
{
	var valor:Number  = this.iface.totalAlmacen_;
	if (campo == "reiniciar") {
		this.iface.totalAlmacen_ = 0;
	}
	return valor;
}

function oficial_totalInforme(nodo:FLDomNode, campo:String):String
{
	var valor:Number  = this.iface.totalInforme_;
	return valor;
}

function oficial_iniciarTotales(nodo:FLDomNode, campo:String):String
{
	this.iface.totalAlmacen_ = 0;
	this.iface.totalInforme_ = 0;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
