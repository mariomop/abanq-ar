/***************************************************************************
                 lineasalbaranescli.qs  -  description
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
	function actualizarEstadoPedido(idPedido:Number, curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.oficial_actualizarEstadoPedido(idPedido, curAlbaran);
	}
	function actualizarLineaPedido(idLineaPedido:Number, idPedido:Number, referencia:String, idAlbaran:Number, cantidadLineaAlbaran:Number):Boolean {
		return this.ctx.oficial_actualizarLineaPedido(idLineaPedido, idPedido, referencia, idAlbaran, cantidadLineaAlbaran);
	}
	function obtenerEstadoPedido(idPedido:Number):String {
		return this.ctx.oficial_obtenerEstadoPedido(idPedido);
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

/** @class_declaration funNumSerie */
//////////////////////////////////////////////////////////////////
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////////
class funNumSerie extends lotes {
	function funNumSerie( context ) { lotes( context ); } 	
	function init() { return this.ctx.funNumSerie_init(); }
	function validateForm():Boolean { return this.ctx.funNumSerie_validateForm(); }
	function bufferChanged(fN:String) { return this.ctx.funNumSerie_bufferChanged(fN); }
	function controlCantidad(cantidadAuno:Boolean) { return this.ctx.funNumSerie_controlCantidad(cantidadAuno); }
}
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration funNumAcomp */
//////////////////////////////////////////////////////////////////
//// FUN_NUM_ACOMP /////////////////////////////////////////////////////

class funNumAcomp extends funNumSerie {
	function funNumAcomp( context ) { funNumSerie( context ); } 	
	function init() { return this.ctx.funNumAcomp_init(); }
	function validateForm():Boolean { return this.ctx.funNumAcomp_validateForm(); }
	function bufferChanged(fN:String) { return this.ctx.funNumAcomp_bufferChanged(fN); }
	function regenerarNumSerieComp() { return this.ctx.funNumAcomp_regenerarNumSerieComp(); }
	function controlNumSerieComp(regenerar:Boolean) { return this.ctx.funNumAcomp_controlNumSerieComp(regenerar); }
	function borrarNumSerieComp() { return this.ctx.funNumAcomp_borrarNumSerieComp(); }
}

//// FUN_NUM_ACOMP /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration informacionLineas */
/////////////////////////////////////////////////////////////////
//// INFORMACION LINEAS /////////////////////////////////////////
class informacionLineas extends funNumAcomp {
    function informacionLineas( context ) { funNumAcomp ( context ); }
	function init() {
		return this.ctx.informacionLineas_init();
	}
}
//// INFORMACION LINEAS /////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends informacionLineas {
    function head( context ) { informacionLineas ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
	function pub_actualizarLineaPedido(idLineaPedido:Number, idPedido:Number, referencia:String, idAlbaran:Number, cantidadLineaAlbaran:Number):Boolean {
		return this.actualizarLineaPedido(idLineaPedido, idPedido, referencia, idAlbaran, cantidadLineaAlbaran);
	}
	function pub_actualizarEstadoPedido(idPedido:Number, curAlbaran:FLSqlCursor):Boolean {
		return this.actualizarEstadoPedido(idPedido, curAlbaran);
	}
	function pub_obtenerEstadoPedido(idPedido:Number):String {
		return this.obtenerEstadoPedido(idPedido);
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
Este formulario realiza la gestión de las líneas de albaranes a clientes.
\end */
function interna_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(form, "closed()", this, "iface.desconectar");

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
// 		var cursor:FLSqlCursor = this.cursor();
// 		this.iface.actualizarLineaPedido(cursor.valueBuffer("idlineapedido"), cursor.valueBuffer("idpedido") , cursor.valueBuffer("referencia"), cursor.valueBuffer("idalbaran"), cursor.valueBuffer("cantidad"));
// 		this.iface.actualizarEstadoPedido(cursor.valueBuffer("idpedido"), cursor);
}

/** \D Función a sobrecargar
\end */
function interna_validateForm():Boolean
{
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

/** \C
Las dependencias entre controles de este formulario son las mismas que las del formulario de líneas de pedido a cliente
\end \end */
function oficial_bufferChanged(fN:String)
{
		formRecordlineaspedidoscli.iface.pub_commonBufferChanged(fN, form);
}

/** \C
Obtiene el estado de un pedido
@param	idPedido: Id del pedido a actualizar
@return	Estado del pedido
\end */
function oficial_obtenerEstadoPedido(idPedido:Number):String
{
	/// Para mantener la compatibilidad de algunas extensiones
	return flfacturac.iface.obtenerEstadoPedidoCli(idPedido);
}

/** \C
Marca el pedido como servido o parcialmente servido según corresponda.
@param	idPedido: Id del pedido a actualizar
@param	curAlbaran: Cursor posicionado en el remito que modifica el estado del pedido
@return	True si la actualización se realiza correctamente, false en caso contrario
\end */
function oficial_actualizarEstadoPedido(idPedido:Number, curAlbaran:FLSqlCursor):Boolean
{
	/// Para mantener la compatibilidad de algunas extensiones
	return flfacturac.iface.actualizarEstadoPedidoCli(idPedido, curAlbaran);
}

/** \C
Actualiza el campo total en remito de la línea de pedido correspondiente (si existe).
@param	idLineaPedido: Id de la línea a actualizar
@param	idPedido: Id del pedido a actualizar
@param	referencia del artículo contenido en la línea
@param	idAlbaran: Id del remito en el que se sirve el pedido
@param	cantidadLineaAlbaran: Cantidad total de artículos de la referencia actual en el remito
@return	True si la actualización se realiza correctamente, false en caso contrario
\end */
function oficial_actualizarLineaPedido(idLineaPedido:Number, idPedido:Number, referencia:String, idAlbaran:Number, cantidadLineaAlbaran:Number):Boolean
{
	/// Para mantener la compatibilidad de algunas extensiones
	return flfacturac.iface.actualizarLineaPedidoCli(idLineaPedido, idPedido, referencia, idAlbaran, cantidadLineaAlbaran);
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


/** @class_definition lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
/** \C La tabla de movimientos mostrará movimientos asociados a la línea de remito
\end */
function lotes_init() {
	this.iface.__init();
	
	connect(this.child("tdbMoviLote").cursor(), "bufferCommited()", this, "iface.calcularCantidad()");
	this.iface.habilitarControlesPorLotes();
	this.child("fdbReferencia").editor().setFocus();
}


/** \C Si el artículo seleccionado está gestionado por lotes se inhabilitará el campo --cantidad--, que tomará el valor de la suma del campo cantidad de los movimientos asociados a la línea. Si no está gestionado por lotes, se inhabilitará la sección 'Movimientos de lotes'.
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

/** \D Calcula la cantidad como suma de los movimientos asociados a la línea. 

Si hay uno o más movimientos, la referencia no podrá ser modificada
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
				res = util.sqlSelect("movilote", "SUM(cantidad)", "docorigen = 'RC' AND idlineaac = " + cursor.valueBuffer("idlinea"));
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

/** \D Habilita y pone los valores iniciales para los controles del formulario en función de si el artículo seleccionado es por lotes o no
\end */
function lotes_habilitarControlesPorLotes() 
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	this.iface.porLotes = util.sqlSelect("articulos", "porlotes", "referencia = '" + cursor.valueBuffer("referencia") + "'");
	if (this.iface.porLotes) {
		this.child("tbwLinea").setTabEnabled("lotes", true);
		this.child("fdbCantidad").setDisabled(true);
		this.iface.calcularCantidad();
	} else {
		/* El campo fdbCantidad viene habilitado desde la extensión funNumSerie. Sólo se deshabilita si el artículo se controla por números de serie o lotes */ 
		this.child("tbwLinea").setTabEnabled("lotes", false);
// 		this.child("fdbCantidad").setDisabled(false);
		this.child("fdbReferencia").setDisabled(false);
	}
}
//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition funNumSerie */
/////////////////////////////////////////////////////////////////
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////

function funNumSerie_init()
{
// 	this.iface.__init();

	this.child("tbwLinea").setTabEnabled("numserie", false);
	var cursor:FLSqlCursor = this.cursor();
	if (cursor.modeAccess() == cursor.Edit)
		this.iface.controlCantidad(true);

	this.iface.__init();
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

	/* Por defecto habilitamos campo cantidad. Si se controla por número de serie (o por lotes, en la clase extendida), deshabilitamos */
	this.child("fdbCantidad").setDisabled(false);

	if (util.sqlSelect("articulos", "controlnumserie", "referencia = '" + cursor.valueBuffer("referencia") + "'")) {
		if (cantidadAuno) 
			cursor.setValueBuffer("cantidad", 1);
		this.child("fdbCantidad").setDisabled(true);
		this.child("fdbNumSerie").setDisabled(false);
		this.child("fdbNumSerie").setFilter("referencia = '" + cursor.valueBuffer("referencia") + "' AND codalmacen = '" + cursor.cursorRelation().valueBuffer("codalmacen") + "'");
		this.child("tbwLinea").setTabEnabled("numserie", true);
	}
	// agregamos el control de artículos por lotes aquí, para unificar el funcionamiento
	else if (util.sqlSelect("articulos", "porlotes", "referencia = '" + cursor.valueBuffer("referencia") + "'")) {
		this.child("fdbCantidad").setDisabled(true);
	}
	else {
// 		this.child("fdbCantidad").setDisabled(false);
		this.child("fdbNumSerie").setDisabled(true);
		this.child("tbwLinea").setTabEnabled("numserie", false);
	}
}

function funNumSerie_validateForm():Boolean
{
	var util:FLUtil = new FLUtil();	
		
	if (this.cursor().valueBuffer("numserie")) {

		if (// Si existe un número de serie que no es de este remito
			util.sqlSelect("numerosserie", "id", 
				"numserie = '" + this.cursor().valueBuffer("numserie") + "'" +
				" AND referencia = '" +	this.cursor().valueBuffer("referencia") + "'" +
				" AND idalbaranventa <> " + this.cursor().valueBuffer("idalbaran") +
				" AND vendido = 'true'")
			// Salvo que sea otra línea de este mismo remito
			|| util.sqlSelect("lineasalbaranescli", "idlinea", 
				"numserie = '" + this.cursor().valueBuffer("numserie") + "'" +
				" AND referencia = '" +	this.cursor().valueBuffer("referencia") + "'" +
				" AND idalbaran = " + this.cursor().valueBuffer("idalbaran") +
				" AND idlinea <> " + this.cursor().valueBuffer("idlinea")))
		{
			MessageBox.warning(util.translate("scripts", "Este número de serie corresponde a un artículo ya vendido"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
	}	

	return this.iface.__validateForm();
}

//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition funNumAcomp */
/////////////////////////////////////////////////////////////////
//// FUN_NUM_ACOMP /////////////////////////////////////////////////

function funNumAcomp_init()
{
// 	this.iface.__init();
	this.iface.controlNumSerieComp();
	this.iface.__init();
}

/**
Se comprueba que el número de serie no existe en una línea de ns
*/
function funNumAcomp_validateForm():Boolean
{
	var util:FLUtil = new FLUtil();
	if (util.sqlSelect("lineasalbaranesclins", "idlinea", 
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
function funNumAcomp_regenerarNumSerieComp()
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
		
	this.iface.borrarNumSerieComp();
		
	var curTab:FLSqlCursor = this.child("tdbLineasAlbaranesCliNS").cursor();
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

function funNumAcomp_bufferChanged(fN:String)
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
function funNumAcomp_controlNumSerieComp(regenerar:Boolean)
{
	var util:FLUtil = new FLUtil();
	if (util.sqlSelect("articuloscomp", "refcompuesto", "refcompuesto = '" + this.cursor().valueBuffer("referencia") + "'")) {
		
		if (regenerar)
			this.iface.regenerarNumSerieComp();
		
		this.child("gbxNumSerieComp").setDisabled(false);
		
		// Si hay componentes con NS hay que forzar a 1 la cantidad
		var curTab:FLSqlCursor = this.child("tdbLineasAlbaranesCliNS").cursor();
		curTab.select();
		if (curTab.first()) {
			this.child("tbwLinea").setTabEnabled("numserie", true);
			this.cursor().setValueBuffer("cantidad", 1);
			this.child("fdbCantidad").setDisabled(true);
		}
	}
	else {
		this.iface.borrarNumSerieComp();
		this.child("gbxNumSerieComp").setDisabled(true);
		this.iface.controlCantidad(true);
	}
}

/** Borra los registros de números de serie de componentes
*/
function funNumAcomp_borrarNumSerieComp()
{
	var curTab:FLSqlCursor = this.child("tdbLineasAlbaranesCliNS").cursor();
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

//// FUN_NUM_ACOMP /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition informacionLineas */
/////////////////////////////////////////////////////////////////
//// INFORMACION LINEAS /////////////////////////////////////////

function informacionLineas_init() {
	this.iface.__init();
	
	if (this.cursor().modeAccess() == this.cursor().Edit || this.cursor().modeAccess() == this.cursor().Browse) {
		this.child("lblStockAlmacen").setText(formRecordlineaspedidoscli.iface.pub_commonCalculateField("lblStockAlmacen", this.cursor()));
		this.child("lblStockFisico").setText(formRecordlineaspedidoscli.iface.pub_commonCalculateField("lblStockFisico", this.cursor()));
	}
}

//// INFORMACION LINEAS /////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////