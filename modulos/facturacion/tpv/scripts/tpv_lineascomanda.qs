/***************************************************************************
                 tpv_lineascomanda.qs  -  description
                             -------------------
    begin                : lun ago 19 2005
    copyright            : Por ahora (C) 2005 by InfoSiAL S.L.
    email                : lveb@telefonica.net
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
	function calcularPvpTarifa(referencia:String, codTarifa:String):Number {
		return this.ctx.oficial_calcularPvpTarifa(referencia, codTarifa);
	}
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.oficial_commonCalculateField(fN, cursor);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration funNumSerie */
//////////////////////////////////////////////////////////////////
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////////
class funNumSerie extends oficial {
	function funNumSerie( context ) { oficial( context ); }
	function init() {
		return this.ctx.funNumSerie_init();
	}
	function validateForm():Boolean {
		return this.ctx.funNumSerie_validateForm();
	}
	function bufferChanged(fN:String) {
		return this.ctx.funNumSerie_bufferChanged(fN);
	}
	function controlCantidad(cantidadAuno:Boolean) {
		return this.ctx.funNumSerie_controlCantidad(cantidadAuno);
	}
}
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration tpvNsAcomp */
//////////////////////////////////////////////////////////////////
//// TPV_NS_ACOMP /////////////////////////////////////////////////////

class tpvNsAcomp extends funNumSerie {
	function tpvNsAcomp( context ) { funNumSerie( context ); } 	
	function init() { return this.ctx.tpvNsAcomp_init(); }
	function validateForm():Boolean { return this.ctx.tpvNsAcomp_validateForm(); }
	function bufferChanged(fN:String) { return this.ctx.tpvNsAcomp_bufferChanged(fN); }
	function regenerarNumSerieComp() { return this.ctx.tpvNsAcomp_regenerarNumSerieComp(); }
	function controlNumSerieComp(regenerar:Boolean) { return this.ctx.tpvNsAcomp_controlNumSerieComp(regenerar); }
	function borrarNumSerieComp() { return this.ctx.tpvNsAcomp_borrarNumSerieComp(); }
}

//// TPV_NS_ACOMP /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration ivaIncluido */
//////////////////////////////////////////////////////////////////
//// IVA INCLUIDO ////////////////////////////////////////////////
class ivaIncluido extends tpvNsAcomp {
	var bloqueoPrecio:Boolean;
    function ivaIncluido( context ) { tpvNsAcomp( context ); } 	
	function init() {
		return this.ctx.ivaIncluido_init();
	}
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.ivaIncluido_commonCalculateField(fN, cursor);
	}
	function bufferChanged(fN:String) {
		return this.ctx.ivaIncluido_bufferChanged(fN);
	}
	function habilitarPorIvaIncluido() {
		return this.ctx.ivaIncluido_habilitarPorIvaIncluido();
	}
}
//// IVA INCLUIDO ////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration totalesIva */
/////////////////////////////////////////////////////////////////
//// TOTALES CON IVA ////////////////////////////////////////////
class totalesIva extends ivaIncluido {
    function totalesIva( context ) { ivaIncluido ( context ); }
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.totalesIva_commonCalculateField(fN, cursor);
	}
	function bufferChanged(fN:String, miForm:Object) {
		return this.ctx.totalesIva_bufferChanged(fN, miForm);
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
	function pub_calcularPvpTarifa(referencia:String, codTarifa:String):Number {
		return this.calcularPvpTarifa(referencia, codTarifa);
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
function interna_init()
{
	var cursor:FLSqlCursor = this.cursor();
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(form, "closed()", this, "iface.desconectar");

	if (cursor.modeAccess() == cursor.Insert)
		this.child("fdbDtoPor").setValue(this.iface.calculateField("dtopor"));

	this.child("lblDtoPor").setText(this.iface.calculateField("lbldtopor"));
}

function interna_calculateField(fN:String):String
{
	return this.iface.commonCalculateField(fN, this.cursor());
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_commonCalculateField(fN:String, cursor:FLSqlCursor):String
{
	var util:FLUtil = new FLUtil();
	var valor:String;

	switch (fN) {
		/** \C
		El --pvpunitario-- se calcula como el pvp establecido para el artículo seleccionado
		*/
		case "pvpunitario":{
			valor = this.iface.calcularPvpTarifa(cursor.valueBuffer("referencia"), cursor.cursorRelation().valueBuffer("codtarifa"));
			valor = util.roundFieldValue(valor, "tpv_lineascomanda", "pvpunitario");
			break;
		}
		/** \C
		El --pvpsindto-- es el el --pvpunitario-- multiplicado por la --cantidad--
		*/
		case "pvpsindto":{
			valor = parseFloat(cursor.valueBuffer("pvpunitario")) * parseFloat(cursor.valueBuffer("cantidad"));
			valor = util.roundFieldValue(valor, "tpv_lineascomanda", "pvpsindto");
			break;
		}
		case "iva":{
			valor = util.sqlSelect("impuestos", "iva", "codimpuesto = '" + cursor.valueBuffer("codimpuesto") + "'");
			if (!valor)
				valor = 0;
			break;
		}
		/** \C
		El descuento se calcula como el --pvpsindto-- por el porcentaje de descuento
		*/
		case "lbldtopor":{
			valor = (cursor.valueBuffer("pvpsindto") * cursor.valueBuffer("dtopor")) / 100;
			valor = util.roundFieldValue(valor, "tpv_lineascomanda", "pvpsindto");
			break;
		}
		/** \C
		El --pvptotal-- es el --pvpsindto-- menos el descuento menos el descuento lineal
		*/
		case "pvptotal": {
			var dtoPor:Number = (cursor.valueBuffer("pvpsindto") * cursor.valueBuffer("dtopor")) / 100;
			dtoPor = util.roundFieldValue(dtoPor, "tpv_lineascomanda", "pvpsindto");
			valor = cursor.valueBuffer("pvpsindto") - parseFloat(dtoPor) - cursor.valueBuffer("dtolineal");
			break;
		}
		case "dtopor":{
			valor = cursor.valueBuffer("dtopor");
			break;
		}
	}
	return valor;
}

/** \D
Desconecta la función bufferChanged conectada en el init
*/
function oficial_desconectar()
{
		disconnect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");
}

function oficial_bufferChanged(fN:String)
{
	switch (fN) {
		/** \C
		Al cambiar la referencia se recalculan el --pvpunitario-- y el --codimpuesto--
		*/
		case "referencia":{
			this.child("fdbPvpUnitario").setValue(this.iface.calculateField("pvpunitario"));
			this.child("fdbCodImpuesto").setValue(this.iface.calculateField("codimpuesto"));
			break;
		}
		/** \C
		Al cambiar el --codimpuesto-- se recalcula el porcentaje de iva que se aplicará
		*/
		case "codimpuesto":{
			this.child("fdbIva").setValue(this.iface.calculateField("iva"));
			break;
		}
		/** \C
		Al cambiar la --cantidad-- o el --pvpunitario-- se recalcula el --pvpsindto--
		*/
		case "cantidad":
		case "pvpunitario":{
			this.child("fdbPvpSinDto").setValue(this.iface.calculateField("pvpsindto"));
			break;
		}
		case "pvpsindto":
		case "dtopor":{
			this.child("lblDtoPor").setText(this.iface.calculateField("lbldtopor"));
		}
		/** \C
		Al cambiar el --dtolineal-- se recalcula el --pvptotal--
		*/
		case "dtolineal":{
			this.child("fdbPvpTotal").setValue(this.iface.calculateField("pvptotal"));
			break;
		}
	}
}

/** \D
Calcula el --pvpunitario-- aplicandole la tarifa establecida el el formulario de edición de comandas
@param referencia identificador del artíuclo
@param codTarifa identificador de la tarifa
@return devuelve el pvp del articulo con la tarifa apliada si la tiene o el pvp del artículo si no hay ninguna tarifa especificada
*/
function oficial_calcularPvpTarifa(referencia:String, codTarifa:String):Number
{
	var util:FLUtil = new FLUtil();
	var pvp:Number;

	if (codTarifa)
		pvp = util.sqlSelect("articulostarifas", "pvp", "referencia = '" + referencia + "' AND codtarifa = '" + codTarifa + "'");
		
	if (!pvp)
		pvp = util.sqlSelect("articulos", "pvp", "referencia = '" + referencia + "'");
	
	return pvp;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition funNumSerie */
/////////////////////////////////////////////////////////////////
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////
function funNumSerie_init()
{
	this.iface.__init();
	
	var cursor:FLSqlCursor = this.cursor();
	if (cursor.modeAccess() == cursor.Edit)
		this.iface.controlCantidad(true);
}

function funNumSerie_bufferChanged(fN:String)
{
	switch (fN) {
		case "referencia":
			this.iface.controlCantidad(true);
		break;
	}
	
	return this.iface.__bufferChanged(fN);
}

function funNumSerie_controlCantidad(cantidadAuno:Boolean)
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	
	if (util.sqlSelect("articulos", "controlnumserie", "referencia = '" + cursor.valueBuffer("referencia") + "'")) {
		if (cantidadAuno) 
			cursor.setValueBuffer("cantidad", 1);
		this.child("fdbCantidad").setDisabled(true);
		this.child("fdbNumSerie").setDisabled(false);
	}
	else {
		this.child("fdbCantidad").setDisabled(false);
		this.child("fdbNumSerie").setDisabled(true);
	}
}

function funNumSerie_validateForm():Boolean
{
	if (!this.cursor().valueBuffer("numserie"))
		return true;

	var util:FLUtil = new FLUtil();
	var idFactura:String = this.cursor().cursorRelation().valueBuffer("iddocumento");
	if (// Si existe un número de serie que no es de este remito
		util.sqlSelect("numerosserie", "id", 
			"numserie = '" + this.cursor().valueBuffer("numserie") + "'" +
			" AND referencia = '" +	this.cursor().valueBuffer("referencia") + "'" +
			" AND idfacturaventa <> " + idFactura +
			" AND vendido = 'true'")
		// Salvo que sea otra línea de este mismo remito
		|| util.sqlSelect("tpv_lineascomanda", "idtpv_linea", 
			"numserie = '" + this.cursor().valueBuffer("numserie") + "'" +
			" AND idtpv_linea <> " + this.cursor().valueBuffer("idtpv_linea")))
	{
		MessageBox.warning(util.translate("scripts", "Este número de serie corresponde a un artículo ya vendido"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	return true;
}

//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////

/** @class_definition tpvNsAcomp */
/////////////////////////////////////////////////////////////////
//// TPV_NS_ACOMP /////////////////////////////////////////////////

function tpvNsAcomp_init()
{
	this.iface.__init();
	this.iface.controlNumSerieComp();
}

/**
Se comprueba que el número de serie no existe en una línea de ns
*/
function tpvNsAcomp_validateForm():Boolean
{
	var util:FLUtil = new FLUtil();
	if (util.sqlSelect("tpv_lineascomandans", "idlinea", 
			"numserie = '" + this.cursor().valueBuffer("numserie") + "'"))
	{
		MessageBox.warning(util.translate("scripts", "Este número de serie corresponde a un artículo ya vendido"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}	
	
	return this.iface.__validateForm();
}

/**
Cuando la referencia es un artículo compuesto, se regeneran las líneas de 
números de serie si alguno de los componentes se controla por ns
*/
function tpvNsAcomp_regenerarNumSerieComp()
{
	var util:FLUtil = new FLUtil();
	var referencia:String = this.cursor().valueBuffer("referencia");
	
	var qry:FLSqlQuery = new FLSqlQuery();
	qry.setTablesList("articuloscomp,articulos");
	qry.setSelect("ac.refcomponente,ac.cantidad,a.controlnumserie");
	qry.setFrom("articuloscomp ac INNER JOIN articulos a ON ac.refcomponente = a.referencia");
	qry.setWhere("refcompuesto = '" + referencia + "'");
	
	if(!qry.exec())
		return;
		
	if(!qry.size())
		return;
		
	try {
		res = this.cursor().commitBuffer();
	}
	catch (e) {
		this.cursor().rollback();
		return;
	}
	
	if (!res)
		return;
		
	this.iface.borrarNumSerieComp();
		
	var curTab:FLSqlCursor = this.child("tdbLineasComandaNS").cursor();
	var refComp:String = "";
	var cantidad:Number = 0;
	
	while (qry.next()) {
		
		if (!qry.value(2))
			continue;
		
		refComp = qry.value(0);
		cantidad = parseFloat(qry.value(1));
		
		for (i = 0; i < cantidad; i++) {
			curTab.setModeAccess(curTab.Insert);
			curTab.refreshBuffer();
			curTab.setValueBuffer("referencia", refComp);
			curTab.commitBuffer();
		}
	}
	
}

function tpvNsAcomp_bufferChanged(fN:String)
{
	this.iface.__bufferChanged(fN);

	switch (fN) {
		/** Si el artículo tiene componentes se habilita el cuadro de números de serie
		*/
		case "referencia":
			this.iface.controlNumSerieComp(true);
		break;
	}
}

/** Si el artículo tiene componentes se habilita el cuadro de números de serie
*/
function tpvNsAcomp_controlNumSerieComp(regenerar:Boolean)
{
	var util:FLUtil = new FLUtil();
	if (util.sqlSelect("articuloscomp", "refcompuesto", "refcompuesto = '" + this.cursor().valueBuffer("referencia") + "'")) {
		
		if (regenerar)
			this.iface.regenerarNumSerieComp();
		
		this.child("gbxNumSerieComp").setDisabled(false);
		
		// Si hay componentes con NS hay que forzar a 1 la cantidad
		var curTab:FLSqlCursor = this.child("tdbLineasComandaNS").cursor();
		curTab.select();
		if (curTab.first()) {
			this.cursor().setValueBuffer("cantidad", 1);
			this.child("fdbCantidad").setDisabled(true);
		}
	}
	else {
		this.iface.borrarNumSerieComp();
		this.child("gbxNumSerieComp").setDisabled(true);
		this.child("fdbCantidad").setDisabled(false);
	}
}

/** Borra los registros de números de serie de componentes
*/
function tpvNsAcomp_borrarNumSerieComp()
{
	var curTab:FLSqlCursor = this.child("tdbLineasComandaNS").cursor();
	curTab.select();
	while(curTab.next()) {
		curTab.setModeAccess(curTab.Del)
		curTab.refreshBuffer();
		curTab.commitBuffer();
	}
	curTab.select();
	while(curTab.next()) {
		curTab.setModeAccess(curTab.Del)
		curTab.refreshBuffer();
		curTab.commitBuffer();
	}
}

//// TPV_NS_ACOMP /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ivaIncluido */
//////////////////////////////////////////////////////////////////
//// IVAINCLUIDO /////////////////////////////////////////////////
function ivaIncluido_init()
{
	this.iface.habilitarPorIvaIncluido();
	this.iface.__init();
}

function ivaIncluido_bufferChanged(fN:String)
{
//debug("BCH " + fN);
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	
	switch (fN) {
		case "referencia": {
// 			this.iface.__bufferChanged(fN);
			this.iface.bloqueoPrecio = true;
			var ivaIncluido:Boolean = this.iface.commonCalculateField("ivaincluido", cursor);
			this.child("fdbIvaIncluido").setValue(ivaIncluido);
			this.child("fdbCodImpuesto").setValue(this.iface.commonCalculateField("codimpuesto", cursor));
			if (ivaIncluido) {
				this.child("fdbPvpUnitarioIva").setValue(this.iface.commonCalculateField("pvpunitarioiva", cursor));
				cursor.setValueBuffer("pvpunitario", this.iface.commonCalculateField("pvpunitario2", cursor));
			} else {
				cursor.setValueBuffer("pvpunitario", this.iface.commonCalculateField("pvpunitario", cursor));
				this.child("fdbPvpUnitarioIva").setValue(this.iface.commonCalculateField("pvpunitarioiva2", cursor));
			}
			this.iface.bloqueoPrecio = false;
			break;
		}
		case "codimpuesto": {
			this.child("fdbIva").setValue(this.iface.commonCalculateField("iva", this.cursor()));
			break;
		}
		case "ivaincluido": {
			this.iface.habilitarPorIvaIncluido();
			break;
		}
		case "iva": {
			if (!this.iface.bloqueoPrecio) {
				this.iface.bloqueoPrecio = true;
				if (cursor.valueBuffer("ivaincluido")) {
					this.child("fdbPvpUnitarioIva").setValue(this.iface.commonCalculateField("pvpunitarioiva2", cursor));
				} else {
					cursor.setValueBuffer("pvpunitario", this.iface.commonCalculateField("pvpunitario2", cursor));
				}
				this.iface.bloqueoPrecio = false;
			}
			break;
		}
		case "pvpunitarioiva": {
			if (!this.iface.bloqueoPrecio) {
				this.iface.bloqueoPrecio = true;
				cursor.setValueBuffer("pvpunitario", this.iface.commonCalculateField("pvpunitario2", this.cursor()));
				this.iface.bloqueoPrecio = false;
			}
			break;
		}
		case "pvpunitario": {
			if (!this.iface.bloqueoPrecio) {
				this.iface.bloqueoPrecio = true;
				this.child("fdbPvpUnitarioIva").setValue(this.iface.commonCalculateField("pvpunitarioiva2", this.cursor()));
				this.iface.bloqueoPrecio = false;
			}
		}
		case "cantidad": {
			if (cursor.valueBuffer("ivaincluido")) {
				cursor.setValueBuffer("pvpsindto", this.iface.commonCalculateField("pvpsindto", this.cursor()));
			} else {
				return this.iface.__bufferChanged(fN);
			}
			break;
		}
		case "pvpsindto":
		case "dtopor": {
			this.child("lblDtoPor").setText(this.iface.commonCalculateField("lbldtopor", this.cursor()));
		}
		case "dtolineal": {
			if (cursor.valueBuffer("ivaincluido")) {
				cursor.setValueBuffer("pvptotal", this.iface.commonCalculateField("pvptotal", this.cursor()));
			} else {
				return this.iface.__bufferChanged(fN);
			}
			break;
		}
		default:
			return this.iface.__bufferChanged(fN);
	}
}

function ivaIncluido_habilitarPorIvaIncluido()
{
	var cursor:FLSqlCursor = this.cursor();
	if (cursor.modeAccess() != cursor.Browse) {
		if (this.cursor().valueBuffer("ivaincluido")) {
			this.child("fdbPvpUnitario").setDisabled(true);
			this.child("fdbPvpUnitarioIva").setDisabled(false);
		}
		else {
			this.child("fdbPvpUnitario").setDisabled(false);
			this.child("fdbPvpUnitarioIva").setDisabled(true);
		}
	}
}
function ivaIncluido_commonCalculateField(fN, cursor):String
{
//debug("CF " + fN);
	var util:FLUtil = new FLUtil();
	var valor:String;
	var referencia:String = cursor.valueBuffer("referencia");

	switch (fN) {
		case "codimpuesto": {
			var codCliente:String = util.sqlSelect(tablaPadre, "codcliente", wherePadre);
			var codSerie:String = util.sqlSelect(tablaPadre, "codserie", wherePadre);
			if (flfacturac.iface.pub_tieneIvaDocCliente(codSerie, codCliente)) {
				valor = util.sqlSelect("articulos", "codimpuesto", "referencia = '" + cursor.valueBuffer("referencia") + "'");
			} else {
				valor = "EXENTO";
			}
			break;
		}
		case "pvpunitarioiva": {
			valor = this.iface.__commonCalculateField("pvpunitario", cursor);
			break;
		}
		case "pvpunitarioiva2": {
			var iva:Number = parseFloat(cursor.valueBuffer("iva"));
			if (isNaN(iva)) {
				iva = 0;
			}
			valor = cursor.valueBuffer("pvpunitario") * ((100 + iva) / 100);
			break;
		}
		case "pvpunitario2": {
			var iva:Number = parseFloat(cursor.valueBuffer("iva"));
			if (isNaN(iva)) {
				iva = 0;
			}
//debug("iva = " + iva);
			valor = parseFloat(cursor.valueBuffer("pvpunitarioiva")) / ((100 + iva) / 100);
			break;
		}
		case "pvpsindto": {
			valor = parseFloat(cursor.valueBuffer("pvpunitario")) * parseFloat(cursor.valueBuffer("cantidad"));
			break;
		}
		case "ivaincluido": {
			valor = util.sqlSelect("articulos", "ivaincluido", "referencia = '" + referencia + "'");
			break;
		}
		default: {
			valor = this.iface.__commonCalculateField(fN, cursor);
		}
	}
//debug("CF " + fN + " = " + valor);
	return valor;
}

//// IVAINCLUIDO /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition totalesIva */
/////////////////////////////////////////////////////////////////
//// TOTALES CON IVA ////////////////////////////////////////////

function totalesIva_bufferChanged(fN:String, miForm:Object)
{
	var util:FLUtil = new FLUtil();
	
	switch (fN) {
		case "codimpuesto":{
			this.iface.__bufferChanged(fN, miForm);
			this.cursor().setValueBuffer("totalconiva", this.iface.calculateField("totalconiva"));
			break;
		}
		case "pvpsindto":
		case "dtopor":{
			this.iface.__bufferChanged(fN, miForm);
			this.cursor().setValueBuffer("totalconiva", this.iface.calculateField("totalconiva"));
			break;
		}
		case "dtolineal":{
			this.iface.__bufferChanged(fN, miForm);
			this.cursor().setValueBuffer("totalconiva", this.iface.calculateField("totalconiva"));
			break;
		}
		default:
			return this.iface.__bufferChanged(fN, miForm);
	}
}

function totalesIva_commonCalculateField(fN, cursor):String
{
	var util:FLUtil = new FLUtil();
	var valor:String;
	
	switch (fN) {
		case "totalconiva": {
			var pvpTotal:Number = cursor.valueBuffer("pvptotal");
			var iva:Number = parseFloat(cursor.valueBuffer("iva"));
			if ( isNaN(iva) )
				iva = 0;
			valor = parseFloat(pvpTotal) * (1 + iva / 100);
			valor = util.roundFieldValue(valor, "tpv_lineascomanda", "totalconiva");
			break;
		}
		default: {
			valor = this.iface.__commonCalculateField(fN, cursor);
			break;
		}
	}

	return valor;
}

//// TOTALES CON IVA ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////