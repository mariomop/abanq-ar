/***************************************************************************
                 visor.qs  -  description
                             -------------------
    begin                : abr 26 2007
    copyright          : (C) 2007 by Zikzakmedia S.L.
    email                : jesteve@zikzakmedia.com
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
    function main() { this.ctx.interna_main(); }
    function init() { this.ctx.interna_init(); }
    function calculateField(fN:String):String { return this.ctx.interna_calculateField(fN); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var infoReferencia:Object;
	var txtReferencia:Object;
	var txtDesArticulo:Object;
	var txtPvpArticulo:Object;

	function oficial( context ) { interna( context ); } 
	function actualizarVisor() { return this.ctx.oficial_actualizarVisor(); }
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
function interna_main()
{
	var f:Object = new FLFormSearchDB("visorprecios");
	f.setMainWidget();
		f.child("pushButtonAccept").setDisabled(true);
	f.exec("nombre");
}

function interna_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	this.iface.infoReferencia = this.child("infoReferencia");
	this.iface.txtReferencia = this.child("txtReferencia");
	this.iface.txtDesArticulo = this.child("txtDesArticulo");
	this.iface.txtPvpArticulo = this.child("txtPvpArticulo");

	connect(this.iface.infoReferencia, "returnPressed()", this, "iface.actualizarVisor()");

	this.child("txtNombre").text = util.sqlSelect("empresa","nombre","1=1");
	this.child("flLogo").setValue(util.sqlSelect("empresa","logo","1=1"));
}

function interna_calculateField(nombreCampo:String):String
{
	var util:FLUtil = new FLUtil();
	var valor:String;
	var cursor:FLSqlCursor = this.cursor();

	switch (nombreCampo) {
		case "desarticulo": {
			valor = util.sqlSelect("articulos", "descripcion", "referencia = '" + this.iface.txtReferencia.text + "'");
			if (!valor)
				valor = "";
			break;
		}
		case "pvparticulo": {
			valor = util.sqlSelect("articulos", "pvp", "referencia = '" + this.iface.txtReferencia.text + "'");
			if (!valor)
				valor = "0";
			break;
		}
		case "ivaarticulo": {
			valor = util.sqlSelect("articulos", "codimpuesto", "referencia = '" + this.iface.txtReferencia.text + "'");
			if (!valor)
				valor = "";
			break;
		}
		case "ivaincluido": {
			valor = util.sqlSelect("articulos", "ivaincluido", "referencia = '" + this.iface.txtReferencia.text + "'");
			break;
		}
	}
	
	return valor;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_actualizarVisor()
{
	var util:FLUtil = new FLUtil();
	var valor:Number;

	/* Al cambiar la --referencia-- se calcula su descripción y precio unitario */
	this.iface.txtReferencia.text = this.iface.infoReferencia.text;
	this.iface.txtDesArticulo.text = this.iface.calculateField("desarticulo");
	valor = util.sqlSelect("impuestos", "iva", "codimpuesto = '" + this.iface.calculateField("ivaarticulo") + "'");
	
	if ( this.iface.calculateField("ivaincluido") )
	    valor = this.iface.calculateField("pvparticulo");
	else
	    valor = this.iface.calculateField("pvparticulo")*(1+valor/100);
	this.iface.txtPvpArticulo.text = Math.round(valor * 100) / 100; 
	this.iface.infoReferencia.text = "";
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
