/***************************************************************************
                      cuentascli.qs  -  description
                             -------------------
    begin                : lun ago 25 2008
    copyright            : (C) 2008 by Silix
    email                : contacto@silix.com.ar
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

/** @class_declaration ctasCtes */
/////////////////////////////////////////////////////////////////
//// CTASCTES ///////////////////////////////////////////////////
class ctasCtes extends oficial {
	var tdbRecibosPendientes:FLTableDB;
	var tdbRecibosPagados:FLTableDB;
	var fechaDesdePendiente:Object;
	var fechaHastaPendiente:Object;
	var fechaDesdePagado:Object;
	var fechaHastaPagado:Object;

	function ctasCtes( context ) { oficial( context ); }
	function init() {
		this.ctx.ctasCtes_init();
	}
	function calcularSaldo() {
		return this.ctx.ctasCtes_calcularSaldo();
	}
	function actualizarFiltroPendiente() {
		return this.ctx.ctasCtes_actualizarFiltroPendiente();
	}
	function actualizarFiltroPagado() {
		return this.ctx.ctasCtes_actualizarFiltroPagado();
	}
	function filtroMora() {
		return this.ctx.ctasCtes_filtroMora();
	}
	function imprimir() {
		return this.ctx.ctasCtes_imprimir();
	}
	function verCliente() {
		return this.ctx.ctasCtes_verCliente();
	}
}
//// CTASCTES ///////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends ctasCtes {
    function head( context ) { ctasCtes ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
	function ifaceCtx( context ) { head( context ); }
}
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

const iface = new ifaceCtx( this );

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ctasCtes */
//////////////////////////////////////////////////////////////////
//// CTASCTES ////////////////////////////////////////////////////

function ctasCtes_init()
{
	this.iface.tdbRecibosPendientes = this.child("tdbRecibosPendientes");
	this.iface.tdbRecibosPagados = this.child("tdbRecibosPagados");

	this.iface.fechaDesdePendiente = this.child("dateFromPendiente");
	this.iface.fechaHastaPendiente = this.child("dateToPendiente");

	this.iface.fechaDesdePagado = this.child("dateFromPagado");
	this.iface.fechaHastaPagado = this.child("dateToPagado");

	var d = new Date();
	this.iface.fechaDesdePendiente.date = new Date(d.getYear(), 1, 1);
	this.iface.fechaDesdePagado.date = new Date(d.getYear(), d.getMonth(), 1);
	this.iface.fechaHastaPendiente.date = new Date();
	this.iface.fechaHastaPagado.date = new Date();

	connect(this.iface.fechaDesdePendiente, "valueChanged(const QDate&)", this, "iface.actualizarFiltroPendiente");
	connect(this.iface.fechaHastaPendiente, "valueChanged(const QDate&)", this, "iface.actualizarFiltroPendiente");
	connect(this.iface.fechaDesdePagado, "valueChanged(const QDate&)", this, "iface.actualizarFiltroPagado");
	connect(this.iface.fechaHastaPagado, "valueChanged(const QDate&)", this, "iface.actualizarFiltroPagado");
	connect(this.child("chkFiltroMora"), "clicked()", this, "iface.filtroMora");
	connect(this.child("tbnCliente"), "clicked()", this, "iface.verCliente");

	this.iface.tdbRecibosPendientes.setReadOnly(true);
	this.iface.tdbRecibosPagados.setReadOnly(true);

	this.iface.actualizarFiltroPendiente();
	this.iface.actualizarFiltroPagado();

	connect(this.child("toolButtonPrint"), "clicked()", this, "iface.imprimir");

	this.iface.calcularSaldo();
}

function ctasCtes_calcularSaldo()
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();
	var codCliente:String = cursor.valueBuffer("codcliente");

	var saldo:Number = parseFloat( util.sqlSelect( "reciboscli", "SUM(importe)", "estado <> 'Pagado' AND codcliente='" + codCliente + "'") );
	if (!saldo || isNaN(saldo))
		saldo = 0;

	this.child("lblSaldoCuenta").setText(saldo);
}

function ctasCtes_actualizarFiltroPendiente()
{
	var desde = this.iface.fechaDesdePendiente.date.toString().left(10);
	var hasta = this.iface.fechaHastaPendiente.date.toString().left(10);

	if (desde == "" || hasta == "")
		return;

	this.iface.tdbRecibosPendientes.cursor().setMainFilter("estado = 'Emitido' AND fecha >= '" + desde + "'" + " AND " + "fecha <= '" + hasta + "'");
	this.iface.tdbRecibosPendientes.refresh();
}

function ctasCtes_actualizarFiltroPagado()
{
	var desde = this.iface.fechaDesdePagado.date.toString().left(10);
	var hasta = this.iface.fechaHastaPagado.date.toString().left(10);

	if (desde == "" || hasta == "")
		return;

	this.iface.tdbRecibosPagados.cursor().setMainFilter("estado = 'Pagado' AND fecha >= '" + desde + "'" + " AND " + "fecha <= '" + hasta + "'");
	this.iface.tdbRecibosPagados.refresh();
}

function ctasCtes_filtroMora()
{
	if (this.child("chkFiltroMora").checked) {
		this.iface.fechaDesdePendiente.setDisabled(true);
		this.iface.fechaHastaPendiente.setDisabled(true);

		var util:FLUtil = new FLUtil();
		var hoy = new Date();
		var fechaV:String = hoy;
		this.iface.tdbRecibosPendientes.cursor().setMainFilter("estado = 'Emitido' AND fechav < '" + fechaV + "'");
		this.iface.tdbRecibosPendientes.refresh();

	} else {
		this.iface.fechaDesdePendiente.setDisabled(false);
		this.iface.fechaHastaPendiente.setDisabled(false);

		this.iface.actualizarFiltroPendiente();
	}
}

function ctasCtes_imprimir()
{
	if (sys.isLoadedModule("flfactinfo")) {

		if (!this.cursor().isValid())
			return;

		var codCliente:String;
		codCliente = this.cursor().valueBuffer("codcliente");

		var whereFijo:String = "";
		whereFijo += " reciboscli.estado = 'Emitido'";

		var curImprimir:FLSqlCursor = new FLSqlCursor("i_rescuentascli");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("i_reciboscli_codcliente", codCliente);
		if (this.child("chkFiltroMora").checked) {
			var util:FLUtil = new FLUtil();
			var hoy = new Date();
			var fechaV:String = hoy;

			curImprimir.setValueBuffer("h_reciboscli_fechav", fechaV);
		} else {
			curImprimir.setValueBuffer("d_reciboscli_fecha", this.iface.fechaDesdePendiente.date.toString().left(10));
			curImprimir.setValueBuffer("h_reciboscli_fecha", this.iface.fechaHastaPendiente.date.toString().left(10));
		}
		flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_rescuentascli", "", "", "", "", whereFijo);
	} else {
		flfactppal.iface.pub_msgNoDisponible("Informes");
	}
}

function ctasCtes_verCliente()
{
	var codCliente:String = this.cursor().valueBuffer("codcliente");

	var cursor:FLSqlCursor;
	cursor = new FLSqlCursor("clientes");
	cursor.select("codcliente = '" + codCliente + "'");
	if (!cursor.first())
		return false;

	cursor.browseRecord();
}

//// CTASCTES ////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
