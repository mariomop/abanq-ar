/***************************************************************************
                 se_mastercontratos.qs  -  description
                             -------------------
    begin                : lun jun 20 2005
    copyright            : (C) 2005 by InfoSiAL S.L.
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
    function validateForm() { return this.ctx.interna_validateForm(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna 
{
    function oficial( context ) { interna( context ); } 
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration ivaIncluido */
//////////////////////////////////////////////////////////////////
//// IVAINCLUIDO /////////////////////////////////////////////////////
class ivaIncluido extends oficial {
    function ivaIncluido( context ) { oficial( context ); } 	
	function init() {
		this.ctx.ivaIncluido_init();
	}
	function calculateField(fN:String):String {
		return this.ctx.ivaIncluido_calculateField(fN);
	}
	function bufferChanged(fN:String) {
		return this.ctx.ivaIncluido_bufferChanged(fN);
	}
}
//// IVAINCLUIDO /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration totalesIva */
/////////////////////////////////////////////////////////////////
//// TOTALES CON IVA ////////////////////////////////////////////
class totalesIva extends ivaIncluido {
    function totalesIva( context ) { ivaIncluido ( context ); }
	function calculateField(fN:String):String {
		return this.ctx.totalesIva_calculateField(fN);
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
}

function interna_validateForm()
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil;

	var fechaInicio:String = cursor.valueBuffer("fechainicio");
	var fechaFin:String = cursor.valueBuffer("fechafin");
	
	if (fechaInicio > fechaFin) {
		MessageBox.warning(util.translate("scripts","La fecha de fin no puede ser menor que la fecha de inicio"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	
	if (util.sqlSelect("periodoscontratos", "id", 
		"codcontrato = '" + cursor.valueBuffer("codcontrato") + "' AND " + 
		"id <> " + cursor.valueBuffer("id") + " AND " + 
		"((fechainicio <= '" + fechaInicio + "' AND fechafin >= '" + fechaInicio + "') OR " +
		"(fechainicio <= '" + fechaFin + "' AND fechafin >= '" + fechaFin + "'))")) {
				MessageBox.critical(util.translate("scripts","Este período se superpone a uno ya existente"),MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
	}
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition ivaIncluido */
//////////////////////////////////////////////////////////////////
//// IVAINCLUIDO /////////////////////////////////////////////////////

function ivaIncluido_init()
{
	var cursor:FLSqlCursor = this.cursor();
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
}


function ivaIncluido_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	
	switch (fN) {
		case "referencia": {
			cursor.setValueBuffer("coste", this.iface.calculateField("coste"));
			break;
		}
	}
}

function ivaIncluido_calculateField(fN:String):String
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	var valor:String;
	var referencia:String = cursor.valueBuffer("referencia");
	
	switch (fN) {
		case "coste": {
			var q:FLSqlQuery = new FLSqlQuery();
			
			q.setTablesList("articulos");
			q.setSelect("pvp,ivaincluido,codimpuesto");
			q.setFrom("articulos");
			q.setWhere("referencia = '" + referencia + "'");
			if (!q.exec())
				return false;
			if (!q.first())
				return false;

			valor = parseFloat(q.value("pvp"));

			var ivaIncluido:Boolean = q.value("ivaincluido");
			if (ivaIncluido) {
				var iva:Number = util.sqlSelect("impuestos", "iva", "codimpuesto = '" + q.value("codimpuesto") + "'");
				valor = parseFloat(valor) / (1 + iva / 100);
			}
			break;
		}
	}
	return valor;
}
//// IVAINCLUIDO /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_definition totalesIva */
/////////////////////////////////////////////////////////////////
//// TOTALES CON IVA ////////////////////////////////////////////

function totalesIva_calculateField(fN:String):String
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	var valor:String;
	var referencia:String = cursor.valueBuffer("referencia");

	switch (fN) {
		case "totalconiva":{
			valor = parseFloat(cursor.valueBuffer("coste"));

			var ivaIncluido:Boolean = util.sqlSelect("articulos", "ivaincluido", "referencia = '" + referencia + "'");
			if (ivaIncluido) {
				var iva:Number = util.sqlSelect("impuestos", "iva", "codimpuesto = '" + cursor.valueBuffer("codimpuesto") + "'");
				valor = parseFloat(valor) * (1 + iva / 100);
			}
			valor = util.roundFieldValue(valor, "periodoscontratos", "totalconiva");
			break;
		}
		default:
			return this.iface.__calculateField(fN);
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
