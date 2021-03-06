/***************************************************************************
                 i_masterfacturascli.qs  -  description
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
	function obtenerParamInforme():Array {
		return this.ctx.oficial_obtenerParamInforme();
	}
	function facturaRectificada(nodo:FLDomNode, campo:String):String {
		return this.ctx.oficial_facturaRectificada(nodo,campo);
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
	function pub_facturaRectificada(nodo:FLDomNode, campo:String):String {
		return this.facturaRectificada(nodo, campo);
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
	var cursor:FLSqlCursor = this.cursor();
	var pI = this.iface.obtenerParamInforme();
	if (!pI)
		return;

	flfactinfo.iface.pub_lanzarInforme(cursor, pI.nombreInforme, pI.orderBy,"",false,false,pI.whereFijo);
}

/** \D Obtiene un array con los par�metros necesarios para establecer el informe
@return	array de par�metros o false si hay error
\end */
function oficial_obtenerParamInforme():Array
{
	var paramInforme:Array = [];
	paramInforme["nombreInforme"] = false;
	paramInforme["orderBy"] = false;
	paramInforme["groupBy"] = false;
	paramInforme["etiquetas"] = false;
	paramInforme["impDirecta"] = false;
	paramInforme["whereFijo"] = false;
	paramInforme["nombreReport"] = false;
	paramInforme["numCopias"] = false;

	var cursor:FLSqlCursor = this.cursor();
	var seleccion:String = cursor.valueBuffer("id");
	if (!seleccion)
		return false;
	paramInforme.nombreInforme = cursor.action();
	paramInforme.orderBy = "";
	var o:String = "";
	for (var i:Number = 1; i < 3; i++) {
		o = formi_albaranescli.iface.pub_obtenerOrden(i, cursor, "facturascli");
		if (o) {
			if (paramInforme.orderBy == "")
				paramInforme.orderBy = o;
			else
				paramInforme.orderBy += ", " + o;
		}
	}
	
	if(paramInforme.nombreInforme != "i_resfacturascli") {
		if (paramInforme.orderBy)
			paramInforme.orderBy += ",";
		paramInforme.orderBy += " lineasfacturascli.idalbaran, lineasfacturascli.referencia, lineasfacturascli.idlinea";
	}
	
	if (cursor.valueBuffer("codintervalo")) {
		var intervalo:Array = [];
		intervalo = flfactppal.iface.pub_calcularIntervalo(cursor.valueBuffer("codintervalo"));
		cursor.setValueBuffer("d_facturascli_fecha", intervalo.desde);
		cursor.setValueBuffer("h_facturascli_fecha", intervalo.hasta);
	}

	var where:String = "";
	if (cursor.valueBuffer("rectificada")) {
		where = "facturascli.rectificada";
	}
	if (cursor.valueBuffer("decredito")) {
		where = "facturascli.tipoventa = 'Nota de Cr�dito'";
	}
	if (cursor.valueBuffer("dedebito")) {
		where = "facturascli.tipoventa = 'Nota de D�bito'";
	}
	if (cursor.valueBuffer("filtrarimportes")) {
		if (!cursor.isNull("desdeimporte")) {
			if (where != "") {
				where += " AND ";
			}
			where += "facturascli.total >= " + cursor.valueBuffer("desdeimporte");
		}
		if (!cursor.isNull("hastaimporte")) {
			if (where != "") {
				where += " AND ";
			}
			where += "facturascli.total <= " + cursor.valueBuffer("hastaimporte");
		}
	}
	paramInforme.whereFijo = where;
	
	return paramInforme;
}

function oficial_facturaRectificada(nodo:FLDomNode, campo:String):String
{
	var util:FLUtil = new FLUtil;
	var idFacturaRect:String = nodo.attributeValue("facturascli.idfacturarect");
	var coFacturaRect:String = util.sqlSelect("facturascli", "codigo", "idfactura = " + idFacturaRect);
	if (coFacturaRect)
		return util.translate("scripts", "**** Rectifica a la factura %1 ****").arg(coFacturaRect);
	else
		return "";
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition csv */
/////////////////////////////////////////////////////////////////
//// CSV ////////////////////////////////////////////////////////

function csv_init()
{
	this.iface.__init();

	if (this.cursor().action() == "i_resfacturascli")
		connect (this.child("toolButtonCSV"), "clicked()", this, "iface.lanzarCSV()");
}

function csv_lanzarCSV()
{
	var cursor:FLSqlCursor = this.cursor();
	var pI = this.iface.obtenerParamInforme();
	if (!pI)
		return;

	var cabecera:String = "C�digo;Fecha;Cliente;CUIT/DNI;Neto;IVA;Otros;Total;Div;";
	var indices = [ 8, 9, 11, 12, 13, 14, 15, 16, 17 ];

	flfactinfo.iface.pub_lanzarInformeCSV(cursor, pI.nombreInforme, pI.orderBy, "", pI.whereFijo, pI.nombreInforme, cabecera, indices);
}

//// CSV ////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
