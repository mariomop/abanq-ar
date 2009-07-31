/**************************************************************************
                 seleclote.qs  -  description
                             -------------------
    begin                : mar mov 27 2007
    copyright            : (C) 2007 by InfoSiAL S.L.
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
	var tbnAceptar:Object;
	var tbnCancelar:Object;
	var pbnCrearLote:Object;
    function oficial( context ) { interna( context ); }
	function aceptarFormulario() {
		return this.ctx.oficial_aceptarFormulario();
	}
	function cancelarFormulario() {
		return this.ctx.oficial_cancelarFormulario();
	}
	function crearLote() {
		return this.ctx.oficial_crearLote();
	}
	function crearLote_clicked():Boolean {
		return this.ctx.oficial_crearLote_clicked();
	}
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
function interna_init()
{
	this.iface.tbnAceptar = this.child("tbnAceptar");
	this.iface.tbnCancelar = this.child("tbnCancelar");
	this.child("pushButtonAccept").close();
	this.child("pushButtonCancel").close();
	this.iface.pbnCrearLote = this.child("pbnCrearLote");

	connect(this.iface.pbnCrearLote, "clicked()", this, "iface.crearLote_clicked");
	this.child("fdbCodLote").setFilter("(caducidad IS NULL OR caducidad > CURRENT_DATE) AND enalmacen > 0 AND lotes.referencia = '" + this.cursor().valueBuffer("referencia") + "'");
	
	connect(this.iface.tbnAceptar, "clicked()", this, "iface.aceptarFormulario");
	connect(this.iface.tbnCancelar, "clicked()", this, "iface.cancelarFormulario");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_aceptarFormulario()
{
	var util:FLUtil;
	var codLote:String = this.cursor().valueBuffer("codlote");
	var referencia:String =this.cursor().valueBuffer("referencia");
	if(!codLote || codLote == "") {
		MessageBox.warning(util.translate("scripts", "Debe establecer un código de Lote"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

	if(!util.sqlSelect("lotes","codlote","codlote = '" + codLote + "' AND referencia = '" + referencia + "'")) {
		MessageBox.warning(util.translate("scripts", "El lote establecido no existe para el artículo %1").arg(referencia), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

	var canLote:Number = parseFloat(this.cursor().valueBuffer("canlote"));
	var resto:Number = parseFloat(this.cursor().valueBuffer("resto"));
	if(canLote > resto) {
		MessageBox.warning(util.translate("scripts", "La cantidad total de los lotes asignados no puede ser mayor que la cantidad total de la línea."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

	this.child("pushButtonAccept").animateClick();
}

function oficial_cancelarFormulario()
{
	this.child("pushButtonCancel").animateClick();
}

function oficial_crearLote_clicked():Boolean
{
	
	var util:FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var codNuevoLote:String = "";
	var referencia:String = cursor.valueBuffer("referencia");

	var f:Object = new FLFormSearchDB("insertarlotes");
	var curLotes:FLSqlCursor = f.cursor();
	curLotes.setModeAccess(curLotes.Insert);
	curLotes.refreshBuffer();
	curLotes.setValueBuffer("referencia",referencia);
	f.setMainWidget();
	curLotes.setValueBuffer("referencia",referencia);
	f.exec("codlote");
	
	if (f.accepted()) {
		if(!curLotes.commitBuffer())
			return false;
		codNuevoLote = curLotes.valueBuffer("codlote");
	}

	if(codNuevoLote && codNuevoLote != "")
		cursor.setValueBuffer("codlote",codNuevoLote);	

	return true;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
