/***************************************************************************
                 tpv_puntosventa.qs  -  description
                             -------------------
    begin                : vie jun 02 2006
    copyright            : Por ahora (C) 2006 by InfoSiAL S.L.
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
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function establecerValoresDefecto() {
		return this.ctx.oficial_establecerValoresDefecto();
	}
	function habilitarVisor() {
		return this.ctx.oficial_habilitarVisor();
	}
	function habilitarTermica() {
		return this.ctx.oficial_habilitarTermica();
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration isernet */
/////////////////////////////////////////////////////////////////
//// ISERNET ////////////////////////////////////////////////////
class isernet extends oficial {
    function isernet( context ) { oficial ( context ); }
	function init() { this.ctx.isernet_init(); }
}
//// ISERNET ////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration impresorasFiscales */
/////////////////////////////////////////////////////////////
//// IMPRESORAS FISCALES ////////////////////////////////////
class impresorasFiscales extends isernet {
    function impresorasFiscales( context ) { isernet ( context ); }
	function init() {
		return this.ctx.impresorasFiscales_init();
	}
	function bufferChanged(fN:String) {
		return this.ctx.impresorasFiscales_bufferChanged(fN);
	}
	function habilitarFiscal() {
		return this.ctx.impresorasFiscales_habilitarFiscal();
	}
}
//// IMPRESORAS FISCALES ////////////////////////////////////
/////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends impresorasFiscales {
    function head( context ) { impresorasFiscales ( context ); }
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
	var cursor:FLSqlCursor = this.cursor();
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.child("pbnEstablecerValores"), "clicked()", this, "iface.establecerValoresDefecto()");

	this.iface.habilitarVisor();
	this.iface.habilitarTermica();
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_establecerValoresDefecto()
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();
	
	var res:Number = MessageBox.information(util.translate("scripts", "Va a establecer los campos a sus valores por defecto.\n¿Está seguro?"),MessageBox.Yes, MessageBox.No);
	if (res != MessageBox.Yes) {
		return false;
	} else {
		cursor.setValueBuffer("baudratevisor","9600");
		cursor.setValueBuffer("bitdatosvisor","8");
		cursor.setValueBuffer("paridadvisor","Sin paridad");
		cursor.setValueBuffer("bitstopvisor","1");
		cursor.setValueBuffer("flowcontrol","FLOW_OFF");
		cursor.setValueBuffer("iniciarvisor","27,64");
		cursor.setValueBuffer("limpiarvisor","12");
		cursor.setValueBuffer("prefprimeralinea","27,81,65");
		cursor.setValueBuffer("sufprimeralinea","13");
		cursor.setValueBuffer("prefsegundalinea","27,81,66");
		cursor.setValueBuffer("sufsegundalinea","13");
	}
}

function oficial_habilitarVisor()
{
	var cursor:FLSqlCursor = this.cursor();
	if (cursor.valueBuffer("usarvisor") == false) {
		this.child("gbxVisor").setDisabled(true);
	} else {
		this.child("gbxVisor").setDisabled(false);
	}
}

function oficial_bufferChanged(fN:String)
{
	switch (fN) {
		case "valoresdefecto": {
			this.iface.establecerValoresDefecto();
			break;
		}
		case "usarvisor": {
			this.iface.habilitarVisor();
			break;
		}
		case "tipoimpresora": {
			this.iface.habilitarTermica();
			break;
		}
	}
}

function oficial_habilitarTermica()
{
	var cursor:FLSqlCursor = this.cursor();
	if (cursor.valueBuffer("tipoimpresora") == "Térmica") {
		this.child("gbxTermica").setEnabled(true);
	} else {
		this.child("gbxTermica").setEnabled(false);
	}
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition isernet */
/////////////////////////////////////////////////////////////////
//// ISERNET ////////////////////////////////////////////////////
function isernet_init()
{
	this.iface.__init();
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	if (cursor.modeAccess() == cursor.Insert) {
		this.child("fdbCodAlmacen").setValue(flfactppal.iface.pub_valorDefectoEmpresa("codalmacen"));
	}
}
//// ISERNET ////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////

/** @class_definition impresorasFiscales */
/////////////////////////////////////////////////////////////
//// IMPRESORAS FISCALES ////////////////////////////////////

function impresorasFiscales_init()
{
	this.iface.__init();

	var util:FLUtil = new FLUtil();
	this.iface.habilitarFiscal();
}

function impresorasFiscales_bufferChanged(fN:String)
{
	this.iface.__bufferChanged(fN);

	switch (fN) {
		case "fiscalhasar":
		case "tipoimpresora": {
			this.iface.habilitarFiscal();
			break;
		}
	}
}

function impresorasFiscales_habilitarFiscal()
{
	var cursor:FLSqlCursor = this.cursor();
	if (cursor.valueBuffer("tipoimpresora") == "Fiscal") {
		this.child("gbxImpresoraFiscal").setEnabled(true);
		if (cursor.valueBuffer("fiscalhasar"))
			this.child("fdbTipoImpresoraFiscalHasar").setDisabled(false);
		else
			this.child("fdbTipoImpresoraFiscalHasar").setDisabled(true);
	} else {
		this.child("gbxImpresoraFiscal").setEnabled(false);
	}
}

//// IMPRESORAS FISCALES ////////////////////////////////////
/////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////