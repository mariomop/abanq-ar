/***************************************************************************
                 lineasservicioscli.qs  -  description
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
    function ivaIncluido( context ) { oficial( context ); }
	function init() {
		return this.ctx.ivaIncluido_init();
	}
}
//// IVAINCLUIDO /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration nsServicios */
//////////////////////////////////////////////////////////////////
//// NS_SERVICIOS /////////////////////////////////////////////////////
class nsServicios extends ivaIncluido {
	function nsServicios( context ) { ivaIncluido( context ); } 	
	function init() { return this.ctx.nsServicios_init(); }
	function validateForm():Boolean { return this.ctx.nsServicios_validateForm(); }
	function bufferChanged(fN:String) { return this.ctx.nsServicios_bufferChanged(fN); }
	function controlCantidad(cantidadAuno:Boolean) { return this.ctx.nsServicios_controlCantidad(cantidadAuno); }
}
//// NS_SERVICIOS /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration funNumServAcomp */
//////////////////////////////////////////////////////////////////
//// FUN_NUM_SERV_ACOMP /////////////////////////////////////////////////////

class funNumServAcomp extends nsServicios {
	function funNumServAcomp( context ) { nsServicios( context ); } 	
	function init() { return this.ctx.funNumServAcomp_init(); }
	function validateForm():Boolean { return this.ctx.funNumServAcomp_validateForm(); }
	function bufferChanged(fN:String) { return this.ctx.funNumServAcomp_bufferChanged(fN); }
	function regenerarNumSerieComp() { return this.ctx.funNumServAcomp_regenerarNumSerieComp(); }
	function controlNumSerieComp(regenerar:Boolean) { return this.ctx.funNumServAcomp_controlNumSerieComp(regenerar); }
	function borrarNumSerieComp() { return this.ctx.funNumServAcomp_borrarNumSerieComp(); }
	function buscarReferencia() { return this.ctx.funNumServAcomp_buscarReferencia(); }
}

//// FUN_NUM_SERV_ACOMP /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends funNumServAcomp {
    function head( context ) { funNumServAcomp ( context ); }
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
Este formulario realiza la gestión de las líneas de servicios a clientes.
\end */
function interna_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this, "closed()", this, "iface.desconectar");

	if (cursor.modeAccess() == cursor.Insert) {
		this.child("fdbDtoPor").setValue(this.iface.calculateField("dtopor"));
		if(!cursor.cursorRelation().valueBuffer("codagente") || cursor.cursorRelation().valueBuffer("codagente") == "")
			this.child("fdbPorComision").setDisabled(true);
		else
			this.child("fdbPorComision").setValue(this.iface.calculateField("porcomision"));
	}

	this.child("lblComision").setText(this.iface.calculateField("lblComision"));
	this.child("lblDtoPor").setText(this.iface.calculateField("lbldtopor"));

	if (cursor.modeAccess() == cursor.Insert || cursor.modeAccess() == cursor.Edit) {
		if ( !flfacturac.iface.pub_tieneIvaDocCliente(cursor.cursorRelation().valueBuffer("codserie"), cursor.cursorRelation().valueBuffer("codcliente")) ) {
			this.child("fdbCodImpuesto").setValue("EXENTO");
			this.child("fdbCodImpuesto").setDisabled(true);
			this.child("fdbIva").setDisabled(true);
		}
	}

	this.iface.filtrarArticulos();
}

/** \C
Los campos calculados de este formulario son los mismos que los del formulario de líneas de pedido a cliente
\end */
function interna_calculateField(fN:String):String
{
		return formRecordlineaspedidoscli.iface.pub_commonCalculateField(fN, this.cursor());
}

function interna_acceptedForm()
{
		var cursor:FLSqlCursor = this.cursor();
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

/** \C
Las dependencias entre controles de este formulario son las mismas que las del formulario de líneas de pedido a cliente
\end \end */
function oficial_bufferChanged(fN:String)
{
	formRecordlineaspedidoscli.iface.pub_commonBufferChanged(fN, form);
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
//// IVAINCLUIDO /////////////////////////////////////////////////

function ivaIncluido_init()
{
	formRecordlineaspedidoscli.iface.pub_commonBufferChanged("ivaincluido", form);
	this.iface.__init();
}

//// IVAINCLUIDO /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_definition nsServicios */
/////////////////////////////////////////////////////////////////
//// NS_SERVICIOS /////////////////////////////////////////////////

function nsServicios_init()
{
	this.iface.__init();
	
	var cursor:FLSqlCursor = this.cursor();
	
	if (cursor.modeAccess() == cursor.Edit) {	
		this.iface.controlCantidad(true);
		if (cursor.valueBuffer("numserie")) {
			this.child("fdbNumSerie").setDisabled(true);
			this.child("fdbReferencia").setDisabled(true);
		}
	}
}

function nsServicios_bufferChanged(fN:String)
{
	switch (fN) {
		case "referencia":
			this.iface.controlCantidad(true);
		break;
	}
	
	return this.iface.__bufferChanged(fN);
}


function nsServicios_controlCantidad(cantidadAuno:Boolean)
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

function nsServicios_validateForm():Boolean
{
	if (this.cursor().modeAccess() == this.cursor().Edit) 
		return true;
		
	var util:FLUtil = new FLUtil();	
	if (this.cursor().valueBuffer("numserie") && util.sqlSelect("numerosserie", "id", "numserie = '" + this.cursor().valueBuffer("numserie") + "' AND vendido = 'true'"))
	{
		MessageBox.warning(util.translate("scripts", "Este número de serie corresponde a un artículo ya vendido"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}	
	return true;
}

//// NS_SERVICIOS /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition funNumServAcomp */
/////////////////////////////////////////////////////////////////
//// FUN_NUM_SERV_ACOMP /////////////////////////////////////////////////

function funNumServAcomp_init()
{
	this.iface.__init();
	this.iface.controlNumSerieComp();
}

/**
Se comprueba que el número de serie no existe en una línea de ns
*/
function funNumServAcomp_validateForm():Boolean
{
	var util:FLUtil = new FLUtil();
	if (util.sqlSelect("lineasserviciosclins", "idlinea", 
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
function funNumServAcomp_regenerarNumSerieComp()
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
		
	var curTab:FLSqlCursor = this.child("tdbLineasServiciosCliNS").cursor();
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

function funNumServAcomp_bufferChanged(fN:String)
{
	this.iface.__bufferChanged(fN);
	
	switch (fN) {
		/** Si el artículo tiene componentes se habilita el cuadro de números de serie
		*/
		case "referencia":
			this.iface.controlNumSerieComp(true);
		break;

		/** Si el se rellena antes el número se busca la referencia
		*/
		case "numserie":
			if (!this.cursor().valueBuffer("referencia"))
				this.iface.buscarReferencia();
		break;
	}
}

/** Si el artículo tiene componentes se habilita el cuadro de números de serie
*/
function funNumServAcomp_controlNumSerieComp(regenerar:Boolean)
{
	var util:FLUtil = new FLUtil();
	if (util.sqlSelect("articuloscomp", "refcompuesto", "refcompuesto = '" + this.cursor().valueBuffer("referencia") + "'")) {
		
		if (regenerar)
			this.iface.regenerarNumSerieComp();
		
		this.child("gbxNumSerieComp").setDisabled(false);
		
		// Si hay componentes con NS hay que forzar a 1 la cantidad
		var curTab:FLSqlCursor = this.child("tdbLineasServiciosCliNS").cursor();
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

/** Si el se rellena antes el número se busca la referencia
*/
function funNumServAcomp_buscarReferencia()
{
	var util:FLUtil = new FLUtil();
	var referencia:String = util.sqlSelect("numerosserie", "referencia", "numserie = '" + this.cursor().valueBuffer("numserie") + "' AND vendido = false");
	if (referencia)
		this.child("fdbReferencia").setValue(referencia);
}

/** Borra los registros de números de serie de componentes
*/
function funNumServAcomp_borrarNumSerieComp()
{
	var curTab:FLSqlCursor = this.child("tdbLineasServiciosCliNS").cursor();
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

//// FUN_NUM_SERV_ACOMP /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////