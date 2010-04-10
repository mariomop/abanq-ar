/***************************************************************************
                 lineasfacturasprov.qs  -  description
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
	function validateForm():Boolean { return this.ctx.interna_validateForm(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var longSubcuenta:Number;
	var bloqueoSubcuenta:Boolean;
	var ejercicioActual:String;
	var posActualPuntoSubcuenta:Number;
	
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
	function bufferChanged(fN:String) { return this.ctx.funNumSerie_bufferChanged(fN); }
	function controlCantidad(cantidadAuno:Boolean) { return this.ctx.funNumSerie_controlCantidad(cantidadAuno); }
	function validateForm() { return this.ctx.funNumSerie_validateForm(); }
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
Este formulario realiza la gesti�n de las l�neas de facturas a proveedores.
\end */
function interna_init()
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil;
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.child("chkFiltrarArtProv"), "clicked()", this, "iface.filtrarArticulos");
	connect(form, "closed()", this, "iface.desconectar");

	if (cursor.modeAccess() == cursor.Insert) {
		this.child("fdbDtoPor").setValue(this.iface.calculateField("dtopor"));
	}

	this.child("lblDtoPor").setText(this.iface.calculateField("lbldtopor"));
	
	if (sys.isLoadedModule("flcontppal")) {
		this.iface.ejercicioActual = flfactppal.iface.pub_ejercicioActual();
		this.iface.longSubcuenta = util.sqlSelect("ejercicios", "longsubcuenta", 
				"codejercicio = '" + this.iface.ejercicioActual + "'");
		this.iface.bloqueoSubcuenta = false;
		this.iface.posActualPuntoSubcuenta = -1;
		this.child("fdbIdSubcuenta").setFilter("codejercicio = '" + this.iface.ejercicioActual + "'");
	} else
		this.child("gbxContabilidad").enabled = false;
		
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
Los campos calculados de este formulario son los mismos que los del formulario de l�neas de pedido a proveedor
\end */
function interna_calculateField(fN:String):String
{
		var util:FLUtil = new FLUtil();
		var cursor:FLSqlCursor = this.cursor();
		switch(fN) {
				case "codsubcuenta":
						return util.sqlSelect("articulos", "codsubcuentacom", 
								"referencia = '" + cursor.valueBuffer("referencia") + "'");
						break
				default:
						return formRecordlineaspedidosprov.iface.pub_commonCalculateField(fN, cursor);
		}
}

function interna_validateForm():Boolean
{
		
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	var curFactura:FLSqlCursor = cursor.cursorRelation();
		
	if ( flfacturac.iface.pub_esNotaCredito(curFactura.valueBuffer("tipoventa")) && cursor.valueBuffer("cantidad") > 0 ) {
		MessageBox.warning(util.translate("scripts","Si esta creando una Nota de Cr�dito la cantidad del art�culo debe ser negativa."), MessageBox.Ok, MessageBox.NoButton,MessageBox.NoButton);
		return false;
	}
	if ( !flfacturac.iface.pub_esNotaCredito(curFactura.valueBuffer("tipoventa")) && cursor.valueBuffer("pvptotal") < 0 ) {
		MessageBox.warning(util.translate("scripts","Si esta creando una factura que no es Nota de Cr�dito la cantidad total debe ser positiva."), MessageBox.Ok, MessageBox.NoButton,MessageBox.NoButton);
		return false;
	}
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
Las dependencias entre controles de este formulario son las mismas que las del formulario de l�neas de pedido a proveedor
\end */
function oficial_bufferChanged(fN:String)
{
		var cursor:FLSqlCursor = this.cursor();
		var util:FLUtil = new FLUtil();
		
		switch(fN) {
			case "codsubcuenta":
				if (!this.iface.bloqueoSubcuenta) {
					this.iface.bloqueoSubcuenta = true;
					this.iface.posActualPuntoSubcuenta = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuenta", this.iface.longSubcuenta, this.iface.posActualPuntoSubcuenta);
					this.iface.bloqueoSubcuenta = false;
				}
				break;
			case "referencia":
				this.iface.bloqueoSubcuenta = true;
				this.child("fdbCodSubcuenta").setValue(this.iface.calculateField("codsubcuenta"));
				this.iface.bloqueoSubcuenta = false;
				this.child("fdbPvpUnitario").setValue(this.iface.calculateField("pvpunitario", cursor));
				this.child("fdbCodImpuesto").setValue(this.iface.calculateField("codimpuesto", cursor));
				formRecordlineaspedidosprov.iface.pub_commonBufferChanged(fN, form);
				break;
			default:
				formRecordlineaspedidosprov.iface.pub_commonBufferChanged(fN, form);
		}
}

function oficial_filtrarArticulos()
{
	var filtroReferencia:String = "";
	if (filtroReferencia != "") {
		filtroReferencia += " AND ";
	}
	filtroReferencia += "secompra AND NOT debaja";

	if ( this.child("chkFiltrarArtProv").checked ) {
		var codProveedor:String = this.cursor().cursorRelation().valueBuffer("codproveedor");
		if (codProveedor && codProveedor != "") {
			if (filtroReferencia != "")
				filtroReferencia += " AND ";
			filtroReferencia += "referencia IN (SELECT referencia from articulosprov WHERE codproveedor = '" + codProveedor + "')";
		}
	}

	if ( flfacturac.iface.pub_esNotaCredito(this.cursor().cursorRelation().valueBuffer("tipoventa")) || flfacturac.iface.pub_esNotaDebito(this.cursor().cursorRelation().valueBuffer("tipoventa")) ) {
		var idFactura:Number = this.cursor().cursorRelation().valueBuffer("idfacturarect");
		if (idFactura) {
			if (filtroReferencia != "")
				filtroReferencia += " AND ";
			filtroReferencia += "referencia IN (SELECT referencia FROM lineasfacturasprov WHERE idfactura = " + idFactura + ")";
		}
	}

	this.child("fdbReferencia").setFilter(filtroReferencia);
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
/** \C La tabla de movimientos mostrar� movimientos asociados a la l�nea de factura. En el caso de que la factura sea autom�tica (provenga de uno o m�s remitos), la tabla de movimientos estar� vac�a.
\end */
function lotes_init() {
	this.iface.__init();
	
	if (this.cursor().cursorRelation().valueBuffer("automatica")) {
		this.child("tdbMoviLote").setReadOnly(true);
	} else {
		connect(this.child("tdbMoviLote").cursor(), "bufferCommited()", this, "iface.calcularCantidad()");
		this.iface.habilitarControlesPorLotes();
		this.child("fdbReferencia").editor().setFocus();
	}
}


/** \C Si el art�culo seleccionado est� gestionado por lotes se inhabilitar� el campo --cantidad--, que tomar� el valor de la suma del campo cantidad de los movimientos asociados a la l�nea. Si no est� gestionado por lotes, se inhabilitar� la secci�n 'Movimientos de lotes'.
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

/** \D Calcula la cantidad como suma de los movimientos asociados a la l�nea. 

Si hay uno o m�s movimientos, la referencia no podr� ser modificada
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
				res = util.sqlSelect("movilote", "SUM(cantidad)", "docorigen = 'FP' AND idlineafp = " + cursor.valueBuffer("idlinea"));
				if (res == 0)
					res = 1;
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

/** \D Habilita y pone los valores iniciales para los controles del formulario en funci�n de si el art�culo seleccionado es por lotes o no
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
		/* El campo fdbCantidad viene habilitado desde la extensi�n funNumSerie. S�lo se deshabilita si el art�culo se controla por n�meros de serie o lotes */ 
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
	
	var cursor:FLSqlCursor = this.cursor();

	this.child("tbwLinea").setTabEnabled("numserie", false);
	if (cursor.modeAccess() == cursor.Edit) {
		this.iface.controlCantidad(true);
		this.child("fdbNumSerie").setDisabled(true);
		this.child("fdbReferencia").setDisabled(true);
	}

	this.iface.numSerie = cursor.valueBuffer("numserie");

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
	
	/* Por defecto habilitamos campo cantidad. Si se controla por n�mero de serie (o por lotes, en la clase extendida), deshabilitamos */
	this.child("fdbCantidad").setDisabled(false);

	if (util.sqlSelect("articulos", "controlnumserie", "referencia = '" + cursor.valueBuffer("referencia") + "'")) {
		if (cantidadAuno) 
			cursor.setValueBuffer("cantidad", 1);
		this.child("fdbCantidad").setDisabled(true);
		this.child("tbwLinea").setTabEnabled("numserie", true);
		this.child("fdbNumSerie").setDisabled(false);
	}
	else {
// 		this.child("fdbCantidad").setDisabled(false);
		this.child("tbwLinea").setTabEnabled("numserie", false);
		this.child("fdbNumSerie").setDisabled(true);
	}
}

/** \D Controla que el n�mero de serie no est� duplicado, s�lamente cuando no ha cambiado en la
edici�n
*/
function funNumSerie_validateForm():Boolean
{
	if (!this.iface.__validateForm()) return false;

	var cursor:FLSqlCursor = this.cursor();
	if (this.iface.numSerie == cursor.valueBuffer("numserie")) return true;

	switch(cursor.modeAccess()) {
		
		case cursor.Insert:
		case cursor.Edit:
			var util:FLUtil = new FLUtil;
			if (util.sqlSelect("numerosserie", "numserie", "referencia = '" + cursor.valueBuffer("referencia") + "' AND numserie = '" + cursor.valueBuffer("numserie") + "'")) {
				MessageBox.warning(util.translate("scripts", "Este n�mero de serie ya existe para el art�culo ") + cursor.valueBuffer("referencia"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
			}
			break;
	}
	return true;
}

//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
//////////////////////////////////////////////////////////////