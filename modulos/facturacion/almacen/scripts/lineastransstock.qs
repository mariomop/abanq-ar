/***************************************************************************
                 lineastransstock.qs  -  description
                             -------------------
    begin                : mar sep 27 2006
    copyright            : (C) 2006 by InfoSiAL S.L.
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
	var canPrevia:Number;
	function oficial( context ) { interna( context ); } 
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function refrescarStock() {
		return this.ctx.oficial_refrescarStock();
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration lotes */
/////////////////////////////////////////////////////////////////
//// TRAZABILIDAD ///////////////////////////////////////////////
class lotes extends oficial {
    function lotes( context ) { oficial ( context ); }
	function init() {
		return this.ctx.lotes_init();
	}
	function bufferChanged(fN:String) {
		return this.ctx.lotes_bufferChanged(fN);
	}
	function validateForm():Boolean {
		return this.ctx.lotes_validateForm();
	}
	function refrescarStock() {
		return this.ctx.lotes_refrescarStock();
	}
}
//// TRAZABILIDAD ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration funNumSerie */
//////////////////////////////////////////////////////////////////
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////////
class funNumSerie extends lotes {
    function funNumSerie( context ) { lotes( context ); }
	function init() {
		this.ctx.funNumSerie_init();
	}
	function bufferChanged(fN:String) {
		this.ctx.funNumSerie_bufferChanged(fN);
	}
	function validateForm():Boolean {
		return this.ctx.funNumSerie_validateForm();
	}
	function refrescarStock() {
		this.ctx.funNumSerie_refrescarStock();
	}
}
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends funNumSerie {
    function head( context ) { funNumSerie ( context ); }
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
\end */
function interna_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	this.iface.canPrevia = cursor.valueBuffer("cantidad");
	this.iface.refrescarStock();

	switch (cursor.modeAccess()) {
		case cursor.Edit: {
			this.child("fdbReferencia").setDisabled(true);
			break;
		}
	}
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	
	switch (fN) {
		case "referencia":
		case "cantidad": {
			this.iface.refrescarStock();
			break;
		}
	}
}

/** \D Muestra las cantidades inicial y final para los almacenes de origen y destino
\end */
function oficial_refrescarStock()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var codAlmaOrigen:String = cursor.cursorRelation().valueBuffer("codalmaorigen");
	var codAlmaDestino:String = cursor.cursorRelation().valueBuffer("codalmadestino");
	this.child("lblAlmacenOrigen").text = util.translate("scripts", "Almacén origen (%1)").arg(codAlmaOrigen);
	this.child("lblAlmacenDestino").text = util.translate("scripts", "Almacén destino (%1)").arg(codAlmaDestino);
		
	var referencia:String = cursor.valueBuffer("referencia");
	if (!referencia || referencia == "") {
		this.child("lblCanInicialOrigen").text = "-";
		this.child("lblCanFinalOrigen").text = "-";
		this.child("lblCanInicialDestino").text = "-";
		this.child("lblCanFinalDestino").text = "-";
		return;
	}

	var cantidad:Number = parseFloat(cursor.valueBuffer("cantidad"));
	if (!cantidad || cantidad== "") {
		cantidad = 0;
	}

	var cantidadOrigen:Number = util.sqlSelect("stocks", "cantidad", "codalmacen = '" + codAlmaOrigen + "' AND referencia = '" + referencia + "'");
	if (!cantidadOrigen || isNaN(cantidadOrigen))
		cantidadOrigen = 0;
	cantidadOrigen += parseFloat(this.iface.canPrevia);
 
	this.child("lblCanInicialOrigen").text = cantidadOrigen;
	this.child("lblCanFinalOrigen").text = cantidadOrigen - cantidad;

	var cantidadDestino:Number = util.sqlSelect("stocks", "cantidad", "codalmacen = '" + codAlmaDestino + "' AND referencia = '" + referencia + "'");
	if (!cantidadDestino || isNaN(cantidadDestino))
		cantidadDestino = 0;
	cantidadDestino -= parseFloat(this.iface.canPrevia);

	this.child("lblCanInicialDestino").text = cantidadDestino;
	this.child("lblCanFinalDestino").text = cantidadDestino + cantidad;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition lotes */
/////////////////////////////////////////////////////////////////
//// TRAZABILIDAD ///////////////////////////////////////////////
function lotes_init()
{
	this.iface.__init();

	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	switch (cursor.modeAccess()) {
		case cursor.Edit: {
			this.child("fdbCodLote").setDisabled(true);
			break;
		}
	}
}

function lotes_bufferChanged(fN:String)
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	
	switch (fN) {
		case "referencia": {
			if (!util.sqlSelect("articulos", "porlotes", "referencia = '" + cursor.valueBuffer("referencia") + "'")) {
				this.child("fdbCodLote").setValue("");
				this.child("fdbCodLote").setDisabled(true);
			} else {
				this.child("fdbCodLote").setDisabled(false);
			}
			this.iface.__bufferChanged(fN);
			break;
		}
		case "codlote": {
			this.iface.refrescarStock();
		}
		default: {
			this.iface.__bufferChanged(fN);
		}
	}
}

function lotes_validateForm():Boolean
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	
	if (!util.sqlSelect("articulos", "porlotes", "referencia = '" + cursor.valueBuffer("referencia") + "'"))
		return true;

	var codLote:String = cursor.valueBuffer("codlote");
	if (!codLote) {
		MessageBox.warning(util.translate("scripts", "Debe ingresar el lote del artículo."), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	/** \C El lote y artículo especificados deben coincidir
	\end */
	if (!util.sqlSelect("lotes", "codlote", "codlote = '" + codLote + "' AND referencia = '" + cursor.valueBuffer("referencia") + "'")) {
		MessageBox.warning(util.translate("scripts", "El lote y el artículo especificados no coinciden"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	/** \C Si el artículo está gestionado por lotes las cantidades de destino deben ser positivas o cero \end */
	var canFinalOrigen:Number = parseFloat(this.child("lblCanFinalOrigen").text);
	var canFinalDestino:Number = parseFloat(this.child("lblCanFinalDestino").text);
	if (canFinalOrigen < 0 || canFinalDestino < 0) {
		MessageBox.warning(util.translate("scripts", "Si el artículo está gestionado por lotes las cantidades de destino deben ser positivas o cero"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	return true;
}

/** \D Muestra las cantidades inicial y final para los almacenes de origen y destino
\end */
function lotes_refrescarStock()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var codAlmaOrigen:String = cursor.cursorRelation().valueBuffer("codalmaorigen");
	var codAlmaDestino:String = cursor.cursorRelation().valueBuffer("codalmadestino");
	this.child("lblAlmacenOrigen").text = util.translate("scripts", "Almacén origen (%1)").arg(codAlmaOrigen);
	this.child("lblAlmacenDestino").text = util.translate("scripts", "Almacén destino (%1)").arg(codAlmaDestino);
	
	var referencia:String = cursor.valueBuffer("referencia");
	var codLote:String = cursor.valueBuffer("codlote");

	if (!referencia || referencia == "") {
		this.child("lblCanInicialOrigen").text = "-";
		this.child("lblCanFinalOrigen").text = "-";
		this.child("lblCanInicialDestino").text = "-";
		this.child("lblCanFinalDestino").text = "-";
		return;
	}

	if (!util.sqlSelect("articulos", "porlotes", "referencia = '" + referencia + "'"))
		return this.iface.__refrescarStock();

	if (!codLote || codLote == "") {
		this.child("lblCanInicialOrigen").text = "-";
		this.child("lblCanFinalOrigen").text = "-";
		this.child("lblCanInicialDestino").text = "-";
		this.child("lblCanFinalDestino").text = "-";
		return;
	}
	
	var cantidad:Number = parseFloat(cursor.valueBuffer("cantidad"));
	if (!cantidad || cantidad== "") {
		cantidad = 0;
	}

	var idStockOrigen:String = util.sqlSelect("stocks", "idstock", "codalmacen = '" + codAlmaOrigen + "' AND referencia = '" + referencia + "'");
	var cantidadOrigen:Number;
	if (idStockOrigen) {
		cantidadOrigen = util.sqlSelect("movilote", "SUM(cantidad)", "codlote = '" + codLote + "' AND idstock = " + idStockOrigen);
		if (!cantidadOrigen || isNaN(cantidadOrigen))
			cantidadOrigen = 0;
	} else {
		cantidadOrigen = 0;
	}
	cantidadOrigen += parseFloat(this.iface.canPrevia);
 
	this.child("lblCanInicialOrigen").text = cantidadOrigen;
	this.child("lblCanFinalOrigen").text = cantidadOrigen - cantidad;

	var idStockDestino:String = util.sqlSelect("stocks", "idstock", "codalmacen = '" + codAlmaDestino + "' AND referencia = '" + referencia + "'");
	var cantidadDestino:Number;
	if (idStockDestino) {
		cantidadDestino = util.sqlSelect("movilote", "SUM(cantidad)", "codlote = '" + codLote + "' AND idstock = " + idStockDestino);
		if (!cantidadDestino || isNaN(cantidadDestino))
			cantidadDestino = 0;
	} else {
		cantidadDestino = 0;
	}
	cantidadDestino -= parseFloat(this.iface.canPrevia);

	this.child("lblCanInicialDestino").text = cantidadDestino;
	this.child("lblCanFinalDestino").text = cantidadDestino + cantidad;
}

//// TRAZABILIDAD ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition funNumSerie */
/////////////////////////////////////////////////////////////////
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////

function funNumSerie_init()
{
	this.iface.__init();

	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	switch (cursor.modeAccess()) {
		case cursor.Edit: {
			this.child("fdbNumSerie").setDisabled(true);
			if (util.sqlSelect("articulos", "controlnumserie", "referencia = '" + cursor.valueBuffer("referencia") + "'"))
				this.child("fdbCantidad").setDisabled(true);
			break;
		}
	}
}

function funNumSerie_bufferChanged(fN:String)
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	
	switch (fN) {
		case "referencia": {
			if (!util.sqlSelect("articulos", "controlnumserie", "referencia = '" + cursor.valueBuffer("referencia") + "'")) {
				this.child("fdbCantidad").setDisabled(false);
				this.child("fdbNumSerie").setValue("");
				this.child("fdbNumSerie").setDisabled(true);
			} else {
				cursor.setValueBuffer("cantidad", 1);
				this.child("fdbCantidad").setDisabled(true);
				this.child("fdbNumSerie").setDisabled(false);
			}
			this.iface.__bufferChanged(fN);
			break;
		}
		case "numserie": {
			this.iface.refrescarStock();
		}
		default: {
			this.iface.__bufferChanged(fN);
		}
	}
}

function funNumSerie_validateForm():Boolean
{
	if (!this.iface.__validateForm())
		return false;

	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	if (!util.sqlSelect("articulos", "controlnumserie", "referencia = '" + cursor.valueBuffer("referencia") + "'"))
		return true;

	var numSerie:String = cursor.valueBuffer("numserie");
	if (!numSerie) {
		MessageBox.warning(util.translate("scripts", "Debe ingresar el número de serie del artículo."), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	if (!util.sqlSelect("numerosserie", "id", "numserie = '" + numSerie + "' AND referencia = '" + cursor.valueBuffer("referencia") + "'")) {
		MessageBox.warning(util.translate("scripts", "El número de serie y el artículo especificados no coinciden"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	if ( util.sqlSelect("numerosserie", "codalmacen", "numserie = '" + numSerie + "' AND referencia = '" + cursor.valueBuffer("referencia") + "'") != cursor.cursorRelation().valueBuffer("codalmaorigen")) {
		MessageBox.warning(util.translate("scripts", "El número de serie no pertenece al almacén origen"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

	if ( util.sqlSelect("numerosserie", "vendido", "numserie = '" + numSerie + "' AND referencia = '" + cursor.valueBuffer("referencia") + "'")) {
		MessageBox.warning(util.translate("scripts", "El número de serie corresponde a un artículo ya vendido"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

	return true;
}

/** \D Muestra las cantidades inicial y final para los almacenes de origen y destino
\end */
function funNumSerie_refrescarStock()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var codAlmaOrigen:String = cursor.cursorRelation().valueBuffer("codalmaorigen");
	var codAlmaDestino:String = cursor.cursorRelation().valueBuffer("codalmadestino");
	this.child("lblAlmacenOrigen").text = util.translate("scripts", "Almacén origen (%1)").arg(codAlmaOrigen);
	this.child("lblAlmacenDestino").text = util.translate("scripts", "Almacén destino (%1)").arg(codAlmaDestino);
	
	var referencia:String = cursor.valueBuffer("referencia");
	if (!referencia || referencia == "") {
		this.child("lblCanInicialOrigen").text = "-";
		this.child("lblCanFinalOrigen").text = "-";
		this.child("lblCanInicialDestino").text = "-";
		this.child("lblCanFinalDestino").text = "-";
		return;
	}

	if (!util.sqlSelect("articulos", "controlnumserie", "referencia = '" + referencia + "'"))
		return this.iface.__refrescarStock();

	var cantidad:Number = parseFloat(cursor.valueBuffer("cantidad"));
	if (!cantidad || cantidad== "") {
		cantidad = 0;
	}

	var cantidadOrigen:Number = util.sqlSelect("numerosserie", "COUNT(*)", "codalmacen = '" + codAlmaOrigen + "' AND referencia = '" + referencia + "'");
	if (!cantidadOrigen || isNaN(cantidadOrigen))
		cantidadOrigen = 0;
	cantidadOrigen += parseFloat(this.iface.canPrevia);
 
	this.child("lblCanInicialOrigen").text = cantidadOrigen;
	this.child("lblCanFinalOrigen").text = cantidadOrigen - cantidad;

	var cantidadDestino:Number = util.sqlSelect("numerosserie", "COUNT(*)", "codalmacen = '" + codAlmaDestino + "' AND referencia = '" + referencia + "'");
	if (!cantidadDestino || isNaN(cantidadDestino))
		cantidadDestino = 0;
	cantidadDestino -= parseFloat(this.iface.canPrevia);

	this.child("lblCanInicialDestino").text = cantidadDestino;
	this.child("lblCanFinalDestino").text = cantidadDestino + cantidad;
}

//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////