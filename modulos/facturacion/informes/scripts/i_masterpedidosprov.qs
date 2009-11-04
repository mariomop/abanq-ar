/***************************************************************************
                 i_masterpedidosprov.qs  -  description
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
    function oficial( context ) { interna( context ); } 
	function lanzar() {
		return this.ctx.oficial_lanzar();
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration csv */
/////////////////////////////////////////////////////////////////
//// CSV ////////////////////////////////////////////////////////
class csv extends oficial {
    function csv( context ) { oficial ( context ); }
	function init() {
		this.ctx.csv_init();
	}
	function lanzarCSV() {
		return this.ctx.csv_lanzarCSV();
	}
}
//// CSV ////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends csv {
    function head( context ) { csv ( context ); }
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
	var cursor:FLSqlCursor = this.cursor();
	var seleccion:String = cursor.valueBuffer("id");
	if (!seleccion)
		return;

	var nombreInforme:String = cursor.action();
	if (nombreInforme == "i_respedidosprov") {
		switch(cursor.valueBuffer("tipoinforme")) {
			case "Pesos": {
				nombreInforme = "i_respedidosproveuros";
				break;
			}
			case "Moneda original y pesos": {
				nombreInforme = "i_respedidosprovtotaleuros";
				break;
			}
		}
	}

	var orderBy:String = "";
	var o:String = "";
	for (var i:Number = 1; i < 3; i++) {
		o = formi_albaranesprov.iface.pub_obtenerOrden(i, cursor, "pedidosprov");
		if (o) {
			if (orderBy == "")
				orderBy = o;
			else
				orderBy += ", " + o;
		}
	}
	
	var intervalo:Array = [];
	if (cursor.valueBuffer("codintervalo")){
		intervalo = flfactppal.iface.pub_calcularIntervalo(cursor.valueBuffer("codintervalo"));
		cursor.setValueBuffer("d_pedidosprov_fecha",intervalo.desde);
		cursor.setValueBuffer("h_pedidosprov_fecha",intervalo.hasta);
	}

	flfactinfo.iface.pub_lanzarInforme(cursor, nombreInforme, orderBy);
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition csv */
/////////////////////////////////////////////////////////////////
//// CSV ////////////////////////////////////////////////////////

function csv_init()
{
	this.iface.__init();

	if (this.cursor().action() == "i_respedidosprov")
		connect (this.child("toolButtonCSV"), "clicked()", this, "iface.lanzarCSV()");
}

function csv_lanzarCSV()
{
	var cursor:FLSqlCursor = this.cursor();
	var seleccion:String = cursor.valueBuffer("id");
	if (!seleccion)
		return;

	var nombreInforme:String = cursor.action();
	if (nombreInforme == "i_respedidosprov") {
		switch(cursor.valueBuffer("tipoinforme")) {
			case "Pesos": {
				nombreInforme = "i_respedidosproveuros";
				break;
			}
			case "Moneda original y pesos": {
				nombreInforme = "i_respedidosprovtotaleuros";
				break;
			}
		}
	}

	var orderBy:String = "";
	var o:String = "";
	for (var i:Number = 1; i < 3; i++) {
		o = formi_albaranesprov.iface.pub_obtenerOrden(i, cursor, "pedidosprov");
		if (o) {
			if (orderBy == "")
				orderBy = o;
			else
				orderBy += ", " + o;
		}
	}
	
	var intervalo:Array = [];
	if (cursor.valueBuffer("codintervalo")){
		intervalo = flfactppal.iface.pub_calcularIntervalo(cursor.valueBuffer("codintervalo"));
		cursor.setValueBuffer("d_pedidosprov_fecha",intervalo.desde);
		cursor.setValueBuffer("h_pedidosprov_fecha",intervalo.hasta);
	}

	var cabecera:String = "C�digo;Fecha;Proveedor;CUIT/DNI;Neto;IVA;Otros;Total;Div;";
	var indices = [ 8, 9, 11, 12, 13, 14, 15, 16, 17 ];

	flfactinfo.iface.pub_lanzarInformeCSV(cursor, nombreInforme, orderBy, "", "", nombreInforme, cabecera, indices);
}

//// CSV ////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
