/***************************************************************************
                 masterlotes.qs  -  description
                             -------------------
    begin                : mie nov 22 2006
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
    var chkOcultarCaducados:Object;
	var tbnImprimir:Object;
	var tdbRecords:Object;
	var filtroPrevio:String;

	function oficial( context ) { interna( context ); }
	function chkOcultarCaducadosClicked() {
		return this.ctx.oficial_chkOcultarCaducadosClicked();
	}
	function imprimir() {
		return this.ctx.oficial_imprimir();
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
/** \C La tabla de regularizaciones de stocks se muestra en modo de sólo lectura
\end */
function interna_init()
{
	this.iface.chkOcultarCaducados = this.child("chkOcultarCaducados");
	this.iface.tdbRecords = this.child("tableDBRecords");
	this.iface.tbnImprimir = this.child("toolButtonPrint");
	this.iface.filtroPrevio = this.cursor().mainFilter();

	connect(this.iface.chkOcultarCaducados, "clicked()", this, "iface.chkOcultarCaducadosClicked()");
	connect(this.iface.tbnImprimir, "clicked()", this, "iface.imprimir()");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_chkOcultarCaducadosClicked()
{
	var cursor:FLSqlCursor = this.cursor();
	var filtro:String = this.iface.filtroPrevio;
	if (this.iface.chkOcultarCaducados.checked) {
		if (this.iface.filtroPrevio && this.iface.filtroPrevio != "") {
			filtro += " AND "
		}
		filtro += "(caducidad IS NULL OR caducidad > CURRENT_DATE)";
	}
	cursor.setMainFilter(filtro);
	this.iface.tdbRecords.refresh();
}

/** \C
Al pulsar el botón imprimir se lanzará el informe correspondiente a la factura seleccionada (en caso de que el módulo de informes esté cargado)
\end */
function oficial_imprimir()
{
	if (sys.isLoadedModule("flfactinfo")) {
		var util:FLUtil = new FLUtil;
		var codLote:String = this.cursor().valueBuffer("codlote");

		var curImprimir:FLSqlCursor = new FLSqlCursor("i_movilote");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("i_lotes_codlote", codLote);
		flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_movilote");
	} else
		flfactppal.iface.pub_msgNoDisponible("Informes");
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
