/***************************************************************************
                 formaspago.qs  -  description
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
	function validateForm():Boolean {
		return this.ctx.interna_validateForm();
	}
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
	function insertarZona() {
		return this.ctx.oficial_insertarZona();
	}
	function quitarZona() {
		return this.ctx.oficial_quitarZona();
	}
	function tabSelected(nomTab:String) {
		return this.ctx.oficial_tabSelected(nomTab);
	}
	function controlPorZonas() {
		return this.ctx.oficial_controlPorZonas();
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

/////////////////////////////////////////////////////////////////
//// INTERNA ////////////////////////////////////////////////////

function interna_init()
{
	this.child("tdbZonasVenta").cursor().setMainFilter("codzona not in (select codzona from zonasformaspago where codpago = '" + this.cursor().valueBuffer("codpago") + "')");

	connect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.child("tbIncluir"), "clicked()", this, "iface.insertarZona()");
	connect(this.child("tbExcluir"), "clicked()", this, "iface.quitarZona()");
	connect(this.child("tbwFormasPago"), "currentChanged(QString)", this, "iface.tabSelected");
	
	this.iface.controlPorZonas();
}

function interna_validateForm():Boolean
{
		var cursor:FLSqlCursor = this.cursor();
		var totalAplazado:Number = 0;

/** \C La suma de los % aplazados debe ser igual al 100%"
\end */

		if (cursor.modeAccess() == cursor.Insert || cursor.modeAccess() == cursor.Edit) {
				var query:FLSqlQuery = new FLSqlQuery();
				query.setTablesList("plazos");
				query.setSelect("SUM(aplazado)");
				query.setFrom("plazos");
				query.setWhere("upper(codpago)='" + cursor.valueBuffer("codpago").upper() + "';");
				query.exec();
				if (query.next())
						totalAplazado = parseFloat(query.value(0));

				if (totalAplazado != 100) {
						MessageBox.critical("La suma de los % aplazados debe ser igual al 100%",
								MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
						return false;
				}
		}

		return true;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_bufferChanged(fN:String)
{
	switch (fN) {
		case "controlporzonas":
			this.iface.controlPorZonas();
		break;
	}
}

function oficial_insertarZona()
{
	var util:FLUtil;

	var cursor:FLSqlCursor = this.cursor();
	if (this.cursor().modeAccess() == this.cursor().Insert) {
		if (!this.child("tdbZonasPago").cursor().commitBufferCursorRelation())
			return;
	}

	var curTab:FLSqlCursor = this.child("tdbZonasVenta").cursor();
	if (!curTab.isValid())
		return;
	
	var codZona:String = curTab.valueBuffer("codzona");
	curTab = new FLSqlCursor("zonasformaspago");
	curTab.setModeAccess(curTab.Insert);
	curTab.refreshBuffer();
	curTab.setValueBuffer("codzona", codZona);
	curTab.setValueBuffer("codpago", cursor.valueBuffer("codpago"));
	curTab.commitBuffer();

	this.child("tdbZonasVenta").refresh();
	this.child("tdbZonasPago").refresh();
}

function oficial_quitarZona()
{
	var util:FLUtil;

	var curTab:FLSqlCursor = this.child("tdbZonasPago").cursor();
	if (!curTab.isValid())
		return;
	
	curTab.setModeAccess(curTab.Del);
	curTab.refreshBuffer();
	curTab.commitBuffer();

	this.child("tdbZonasVenta").refresh();
	this.child("tdbZonasPago").refresh();
}

function oficial_tabSelected(nomTab:String)
{
	if (nomTab == "precios")
		this.iface.reloadZonas();
}

function oficial_controlPorZonas()
{
	if (this.cursor().valueBuffer("controlporzonas"))  {
		this.child("tbwFormasPago").setTabEnabled("zonas", true);
	}
	else {
		this.child("tbwFormasPago").setTabEnabled("zonas", false);
	}
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////