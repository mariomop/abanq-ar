/***************************************************************************
                 lineasalbaranesprov.qs  -  description
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

/** @class_declaration lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
class lotes extends oficial {
	var porLotes:Boolean;
	
    function lotes( context ) { oficial ( context ); }
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
	var numSerie:String;
	function funNumSerie( context ) { lotes( context ); } 	
	function init() { return this.ctx.funNumSerie_init(); }
	function validateForm() { return this.ctx.funNumSerie_validateForm(); }
	function bufferChanged(fN:String) { return this.ctx.funNumSerie_bufferChanged(fN); }
	function controlCantidad(cantidadAuno:Boolean) { return this.ctx.funNumSerie_controlCantidad(cantidadAuno); }
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

/** @class_declaration ifaceCtx*/
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
	function pub_actualizarEstadoPedido(idPedido:Number, curAlbaran:FLSqlCursor):Boolean {
		return this.actualizarEstadoPedido(idPedido, curAlbaran);
	}
	function pub_actualizarLineaPedido(idLineaPedido:Number, idPedido:Number, referencia:String, idAlbaran:Number, cantidadLineaAlbaran:Number) {
		return this.actualizarLineaPedido(idLineaPedido, idPedido, referencia, idAlbaran, cantidadLineaAlbaran);
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
Este formulario realiza la gestión de las líneas de albaranes a proveedores.
\end */
function interna_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.child("chkFiltrarArtProv"), "clicked()", this, "iface.filtrarArticulos");
	connect(form, "closed()", this, "iface.desconectar");

	var codSerieAlbaran:String;

	if(cursor.cursorRelation())
		codSerieAlbaran = cursor.cursorRelation().valueBuffer("codserie");
	else
		codSerieAlbaran = util.sqlSelect("albaranesprov","codserie","idAlbaran = " + cursor.valueBuffer("idalbaran"));

	if (cursor.modeAccess() == cursor.Insert) {
		this.child("fdbDtoPor").setValue(this.iface.calculateField("dtopor"));
	}

	this.child("lblDtoPor").setText(this.iface.calculateField("lbldtopor"));
	
	if (cursor.modeAccess() == cursor.Insert || cursor.modeAccess() == cursor.Edit) {
		if ( !flfacturac.iface.pub_tieneIvaDocProveedor(cursor.cursorRelation().valueBuffer("codserie"), cursor.cursorRelation().valueBuffer("codproveedor")) ) {
			this.child("fdbCodImpuesto").setValue("EXENTO");
			this.child("fdbCodImpuesto").setDisabled(true);
			this.child("fdbIva").setDisabled(true);
		}
	}

	this.iface.filtrarArticulos();
}

/** \C
Los campos calculados de este formulario son los mismos que los del formulario de líneas de pedido a proveedor
\end */
function interna_calculateField(fN:String):String
{
	return formRecordlineaspedidosprov.iface.pub_commonCalculateField(fN, this.cursor());
}

function interna_acceptedForm()
{
// 	var cursor:FLSqlCursor = this.cursor();
// 	this.iface.actualizarLineaPedido(cursor.valueBuffer("idlineapedido"), cursor.valueBuffer("idpedido") , cursor.valueBuffer("referencia"), cursor.valueBuffer("idalbaran"), cursor.valueBuffer("cantidad"));
// 	this.iface.actualizarEstadoPedido(cursor.valueBuffer("idpedido"), cursor);
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
	disconnect(this.child("chkFiltrarArtProv"), "clicked()", this, "iface.filtrarArticulos");
}

/** \C
Las dependencias entre controles de este formulario son las mismas que las del formulario de líneas de pedido a proveedor
\end */
function oficial_bufferChanged(fN:String)
{
		formRecordlineaspedidosprov.iface.pub_commonBufferChanged(fN, form);
}

/** \C
Obtiene el estado de un pedido
@param	idPedido: Id del pedido a actualizar
@return	True si la actualización se realiza correctamente, false en caso contrario
\end */
function oficial_obtenerEstadoPedido(idPedido:Number):String
{
	/// Para mantener la compatibilidad de algunas extensiones
	return flfacturac.iface.obtenerEstadoPedidoProv(idPedido);
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
	return flfacturac.iface.actualizarEstadoPedidoProv(idPedido, curAlbaran);
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
	return flfacturac.iface.actualizarLineaPedidoProv(idLineaPedido, idPedido, referencia, idAlbaran, cantidadLineaAlbaran);
}

/** \D Muestra únicamente los artículos del proveedor
*/
function oficial_filtrarArticulos()
{
	var filtroReferencia:String = "";
	if (filtroReferencia != "") {
		filtroReferencia += " AND ";
	}
	filtroReferencia += "secompra";

	if ( this.child("chkFiltrarArtProv").checked ) {
		var codProveedor:String = this.cursor().cursorRelation().valueBuffer("codproveedor");
		if (codProveedor && codProveedor != "") {
			if (filtroReferencia != "")
				filtroReferencia += " AND ";
			filtroReferencia += "referencia IN (SELECT referencia from articulosprov WHERE codproveedor = '" + codProveedor + "')";
		}
	}

	this.child("fdbReferencia").setFilter(filtroReferencia);
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

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
				res = util.sqlSelect("movilote", "SUM(cantidad)", "docorigen = 'RP' AND idlineaap = " + cursor.valueBuffer("idlinea"));
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
		this.child("tbwLinea").setTabEnabled("lotes", false);
		this.child("fdbCantidad").setDisabled(false);
		this.child("fdbReferencia").setDisabled(false);
	}
}//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition funNumSerie */
/////////////////////////////////////////////////////////////////
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////

function funNumSerie_init()
{
	this.iface.__init();
	
	var cursor:FLSqlCursor = this.cursor();
	if (cursor.modeAccess() == cursor.Edit) {
		this.iface.controlCantidad(true);
		if (cursor.valueBuffer("numserie"))
			this.child("fdbNumSerie").setDisabled(true);
		this.child("fdbReferencia").setDisabled(true);
	}

	this.iface.numSerie = cursor.valueBuffer("numserie");
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

/** \D Controla que el número de serie no está duplicado, sólamente cuando no ha cambiado en la
edición
*/
function funNumSerie_validateForm():Boolean
{
	var cursor:FLSqlCursor = this.cursor();
	if (this.iface.numSerie != cursor.valueBuffer("numserie")) {
	
		switch(cursor.modeAccess()) {
			
			case cursor.Insert:
			case cursor.Edit:
				var util:FLUtil = new FLUtil;
				if (util.sqlSelect("numerosserie", "numserie", "referencia = '" + cursor.valueBuffer("referencia") + "' AND numserie = '" + cursor.valueBuffer("numserie") + "'")) {
					MessageBox.warning(util.translate("scripts", "Este número de serie ya existe para el artículo ") + cursor.valueBuffer("referencia"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
					return false;
				}
				break;
		}
	}

	return this.iface.__validateForm();
}

//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////