/***************************************************************************
                 tarifas.qs  -  description
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
    function calculateCounter() { return this.ctx.interna_calculateCounter(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
    function oficial( context ) { interna( context ); } 
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration infoTarifa */
/////////////////////////////////////////////////////////////////
//// INFO TARIFA ////////////////////////////////////////////////
class infoTarifa extends oficial {
    function infoTarifa( context ) { oficial ( context ); }
	function init() {
		return this.ctx.infoTarifa_init();
	}
	function imprimirTarifa(){
		return this.ctx.infoTarifa_imprimirTarifa();
	}
}
//// INFO TARIFA ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_declaration preciosTarifa */
/////////////////////////////////////////////////////////////////
//// PRECIOS TARIFA /////////////////////////////////////////////
class preciosTarifa extends infoTarifa {
    function preciosTarifa( context ) { infoTarifa ( context ); }
	function init() {
		return this.ctx.preciosTarifa_init();
	}
	function pbnActualizar_clicked() {
		return this.ctx.preciosTarifa_pbnActualizar_clicked();
	}
	function actualizarPreciosTarifa():Boolean {
		return this.ctx.preciosTarifa_actualizarPreciosTarifa();
	}
}
//// PRECIOS TARIFA /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends preciosTarifa {
    function head( context ) { preciosTarifa( context ); }
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
function interna_calculateCounter()
{
/*
		var util:FLUtil = new FLUtil();
		return = util.nextCounter("codtarifa", this.cursor());
*/
		return ;
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition infoTarifa */
/////////////////////////////////////////////////////////////////
//// INFO TARIFA ////////////////////////////////////////////////
function infoTarifa_init()
{
	connect(this.child("toolButtonPrint"), "clicked()", this, "iface.imprimirTarifa()");
}

function infoTarifa_imprimirTarifa()
{
	var curTarifa:FLSqlCursor = this.cursor();
	var qryTarifa:FLSqlQuery = new FLSqlQuery;
	var codtarifa:String = curTarifa.valueBuffer("codtarifa");
	if (!codtarifa)
		return;
		 
	qryTarifa.setTablesList("tarifas,articulostarifas,articulos,empresa");
	qryTarifa.setSelect("t.nombre,at.referencia,at.pvp,a.descripcion,empresa.nombre");
	qryTarifa.setFrom("tarifas t,articulostarifas at,articulos a,empresa");
	qryTarifa.setWhere("t.codtarifa = at.codtarifa and at.referencia = a.referencia and t.codtarifa = '" + codtarifa + "' ORDER BY at.referencia");
	
	if (!qryTarifa.exec())
		return;
		
	if (!qryTarifa.first()) {
		return;
	}
		
	var rptViewer:FLReportViewer = new FLReportViewer();
	
	rptViewer.setReportTemplate("articulostarifa");
	rptViewer.setReportData(qryTarifa);
	rptViewer.renderReport();
	rptViewer.exec();
	
}
//// INFO TARIFA ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition preciosTarifa */
/////////////////////////////////////////////////////////////////
//// PRECIOS TARIFA /////////////////////////////////////////////

function preciosTarifa_init()
{
	this.iface.__init();

	connect(this.child("pbnActualizar"), "clicked()", this, "iface.pbnActualizar_clicked()");
}

function preciosTarifa_pbnActualizar_clicked()
{
	var curCommit:FLSqlCursor = new FLSqlCursor("tarifas");

	curCommit.transaction(false);
	try {
		if (this.iface.actualizarPreciosTarifa()) {
			curCommit.commit();
		} else {
			curCommit.rollback();
			return false;
		}
	} catch (e) {
		curCommit.rollback();
		MessageBox.critical(util.translate("scripts", "Hubo un error al actualizar los precios por tarifa: ") + e, MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
}

function preciosTarifa_actualizarPreciosTarifa():Boolean
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var codTarifa:String = cursor.valueBuffer("codtarifa");

	var res:Number = MessageBox.information(util.translate("scripts", "Se van a actualizar los precios de los articulos para la tarifa %1.\n¿Desea continuar?").arg(codTarifa), MessageBox.Yes, MessageBox.No);
	if (res != MessageBox.Yes)
		return false;

	var curArt:FLSqlCursor = this.child("tdbArticulosTarifas").cursor();
	curArt.select("codtarifa = '" + codTarifa + "'");
	util.createProgressDialog(util.translate("scripts", "Actualizando tarifa..."), curArt.size());
	var progreso:Number = 0;
	while (curArt.next()) {
		progreso++;
		util.setProgress(progreso);

		curArt.setModeAccess(curArt.Edit);
		curArt.refreshBuffer();

		var incLineal:Number = parseFloat(cursor.valueBuffer("inclineal"));
		if (!incLineal || isNaN(incLineal))
			incLineal = 0;

		var incPorcentual:Number = cursor.valueBuffer("incporcentual");
		if (!incPorcentual || isNaN(incPorcentual))
			incPorcentual = 0;

		var pvp:Number = util.sqlSelect("articulos","pvp","referencia = '" + curArt.valueBuffer("referencia") + "'");
		if (!pvp || isNaN(pvp))
			pvp = 0;

		var pvpTarifa:Number = ((pvp * (100 + incPorcentual)) / 100) + incLineal;

		curArt.setValueBuffer("pvp", pvpTarifa);
		if (!curArt.commitBuffer()) {
			util.destroyProgressDialog();
			return false;
		}
	}
	util.destroyProgressDialog();
	return true;
}

//// PRECIOS TARIFA /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
