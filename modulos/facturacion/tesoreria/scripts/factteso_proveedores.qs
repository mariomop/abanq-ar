/***************************************************************************
                 factteso_proveedores.qs  -  description
                             -------------------
    begin                : mie jul 29 2009
    copyright            : (C) 2009 by Silix
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
	var tdbConsultaEntradas:FLTableDB;
	var fechaDesdePendiente:Object;
	var fechaHastaPendiente:Object;
	var fechaDesdePagado:Object;
	var fechaHastaPagado:Object;
	var fechaDesdeConsultaEntradas:Object;
	var fechaHastaConsultaEntradas:Object;

	function ctasCtes( context ) { oficial( context ); }
	function init() {
		this.ctx.ctasCtes_init();
	}
	function validateForm():Boolean {
		return this.ctx.ctasCtes_validateForm();
	}
	function bufferChanged(fN:String) {
		this.ctx.ctasCtes_bufferChanged(fN);
	}
	function calculateField(fN:String) {
		return this.ctx.ctasCtes_calculateField(fN);
	}
	function calcularSaldo() {
		this.ctx.ctasCtes_calcularSaldo();
	}
	function actualizarFiltroPendiente() {
		this.ctx.ctasCtes_actualizarFiltroPendiente();
	}
	function actualizarFiltroPagado() {
		this.ctx.ctasCtes_actualizarFiltroPagado();
	}
	function actualizarFiltroConsultaEntradas() {
		this.ctx.ctasCtes_actualizarFiltroConsultaEntradas();
	}
	function filtroMora() {
		this.ctx.ctasCtes_filtroMora();
	}
	function imprimir() {
		this.ctx.ctasCtes_imprimir();
	}
	function verEntrada() {
		this.ctx.ctasCtes_verEntrada();
	}
	function imprimirEntradas() {
		this.ctx.ctasCtes_imprimirEntradas();
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

const iface = new ifaceCtx( this );
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

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
	try {	// funci�n de FLFormDB agregada por Silix
		this.setCaptionWidget("Cuenta corriente de Proveedor");
	} catch (e) {}

	this.iface.tdbRecibosPendientes = this.child("tdbRecibosPendientes");
	this.iface.tdbRecibosPagados = this.child("tdbRecibosPagados");
	this.iface.tdbConsultaEntradas = this.child("tdbConsultaEntradas");

	this.iface.fechaDesdePendiente = this.child("dateFromPendiente");
	this.iface.fechaHastaPendiente = this.child("dateToPendiente");

	this.iface.fechaDesdePagado = this.child("dateFromPagado");
	this.iface.fechaHastaPagado = this.child("dateToPagado");

	this.iface.fechaDesdeConsultaEntradas = this.child("dateFromConsultaEntradas");
	this.iface.fechaHastaConsultaEntradas = this.child("dateToConsultaEntradas");

	var d = new Date();
	this.iface.fechaDesdePendiente.date = new Date(d.getYear(), 1, 1);
	this.iface.fechaDesdePagado.date = new Date(d.getYear(), d.getMonth(), 1);
	this.iface.fechaDesdeConsultaEntradas.date = new Date(d.getYear(), 1, 1);
	this.iface.fechaHastaPendiente.date = new Date();
	this.iface.fechaHastaPagado.date = new Date();
	this.iface.fechaHastaConsultaEntradas.date = new Date();

	connect(this.iface.fechaDesdePendiente, "valueChanged(const QDate&)", this, "iface.actualizarFiltroPendiente");
	connect(this.iface.fechaHastaPendiente, "valueChanged(const QDate&)", this, "iface.actualizarFiltroPendiente");
	connect(this.iface.fechaDesdePagado, "valueChanged(const QDate&)", this, "iface.actualizarFiltroPagado");
	connect(this.iface.fechaHastaPagado, "valueChanged(const QDate&)", this, "iface.actualizarFiltroPagado");
	connect(this.iface.fechaDesdeConsultaEntradas, "valueChanged(const QDate&)", this, "iface.actualizarFiltroConsultaEntradas");
	connect(this.iface.fechaHastaConsultaEntradas, "valueChanged(const QDate&)", this, "iface.actualizarFiltroConsultaEntradas");
	connect(this.child("chkFiltroMora"), "clicked()", this, "iface.filtroMora");

	this.iface.tdbRecibosPendientes.setReadOnly(true);
	this.iface.tdbRecibosPagados.setReadOnly(true);
	this.iface.tdbConsultaEntradas.setFindHidden(true);
	this.iface.tdbConsultaEntradas.setFilterHidden(true);

	this.iface.actualizarFiltroPendiente();
	this.iface.actualizarFiltroPagado();
	this.iface.actualizarFiltroConsultaEntradas();

	connect(this.child("toolButtonPrint"), "clicked()", this, "iface.imprimir");
	connect(this.child("toolButtonZoomEntrada"), "clicked()", this, "iface.verEntrada");
	connect(this.child("toolButtonPrintEntradas"), "clicked()", this, "iface.imprimirEntradas");
	connect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");

	this.iface.calcularSaldo();
}

function ctasCtes_validateForm():Boolean
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil;
	/** \C Si el proveedor est� de baja, la fecha de comienzo de la baja debe estar informada
	\end */
	if (cursor.valueBuffer("debaja") && cursor.isNull("fechabaja")) {
		MessageBox.warning(util.translate("scripts", "Si el proveedor est� de baja debe introducir la correspondiente fecha de inicio de la baja"), MessageBox.Ok, MessageBox.NoButton)
		return false;
	}

	return true;
}

function ctasCtes_bufferChanged(fN)
{
	var cursor:FLSqlCursor = this.cursor();
	switch(fN) {
		case "debaja": {
			var fecha:String = this.iface.calculateField("fechabaja");
			this.child("fdbFechaBaja").setValue(fecha);
			if (fecha == "NAN") {
				cursor.setNull("fechabaja");
			}
			break;
		}
	}
}

function ctasCtes_calculateField(fN:String):String
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	var res:String;
	
	switch (fN) {
		case "fechabaja": {
			if (cursor.valueBuffer("debaja")) {
				var hoy:Date = new Date;
				res = hoy.toString();
			} else
				res = "NAN";
			break;
		}
	}
	return res;
}

function ctasCtes_calcularSaldo()
{
	return;
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();
	var codProveedor:String = cursor.valueBuffer("codproveedor");

	var saldoPesos:Number = parseFloat( util.sqlSelect( "recibosprov", "SUM(importe)", "estado <> 'Pagado' AND coddivisa = '$' AND codproveedor='" + codProveedor + "'") );
	if (!saldoPesos || isNaN(saldoPesos))
		saldoPesos = 0;

	var saldoDolares:Number = parseFloat( util.sqlSelect( "recibosprov", "SUM(importe)", "estado <> 'Pagado' AND coddivisa = 'USD' AND codproveedor='" + codProveedor + "'") );
	if (!saldoDolares || isNaN(saldoDolares))
		saldoDolares = 0;

	this.child("lblSaldoCuentaPesos").setText(saldoPesos);
	this.child("lblSaldoCuentaDolares").setText(saldoDolares);
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

function ctasCtes_actualizarFiltroConsultaEntradas()
{
	var desde = this.iface.fechaDesdeConsultaEntradas.date.toString().left(10);
	var hasta = this.iface.fechaHastaConsultaEntradas.date.toString().left(10);

	if (desde == "" || hasta == "")
		return;

	this.iface.tdbConsultaEntradas.cursor().setMainFilter("fecha >= '" + desde + "'" + " AND " + "fecha <= '" + hasta + "'");
	this.iface.tdbConsultaEntradas.refresh();
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

		var codProveedor:String;
		codProveedor = this.cursor().valueBuffer("codproveedor");

		var whereFijo:String = "";

		var curImprimir:FLSqlCursor = new FLSqlCursor("i_recibosprov");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("i_recibosprov_codproveedor", codProveedor);
		if (this.child("chkFiltroMora").checked) {
			var util:FLUtil = new FLUtil();
			var hoy = new Date();
			var fechaV:String = hoy;

			curImprimir.setValueBuffer("h_recibosprov_fechav", fechaV);
		} else {
			curImprimir.setValueBuffer("d_recibosprov_fecha", this.iface.fechaDesdePendiente.date.toString().left(10));
			curImprimir.setValueBuffer("h_recibosprov_fecha", this.iface.fechaHastaPendiente.date.toString().left(10));
		}
		curImprimir.setValueBuffer("i_recibosprov_estado", "Emitido");
		flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_resrecibosprov", "", "", "", "", whereFijo);
	} else {
		flfactppal.iface.pub_msgNoDisponible("Informes");
	}
}

function ctasCtes_verEntrada()
{
	var util:FLUtil;
	var curEntrada:FLSqlCursor = this.iface.tdbConsultaEntradas.cursor();

	if (!curEntrada.isValid()) {
		MessageBox.warning(util.translate("scripts", "No hay ning�n registro seleccionado"), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	var codigo:String = curEntrada.valueBuffer("codigo");
	var cursor:FLSqlCursor;

	switch (curEntrada.valueBuffer("tipo")) {
		case "Factura Contado":
		case "Factura Cta.Cte.":
		case "N. Cr�dito":
		case "N. D�bito": {
			cursor = new FLSqlCursor("facturasprov");
			cursor.select("codigo = '" + codigo + "'");

			if (!cursor.first())
				return;
			cursor.browseRecord();
			break;
		}
		case "Orden Pago": {
			cursor = new FLSqlCursor("pagosmultiprov");
			cursor.select("idpagomulti = " + codigo);

			if (!cursor.first())
				return;
			cursor.browseRecord();
			break;
		}
		break;
	}
}

function ctasCtes_imprimirEntradas()
{
	if (sys.isLoadedModule("flfactinfo")) {

		if (!this.cursor().isValid())
			return;

		var codProveedor:String;
		codProveedor = this.cursor().valueBuffer("codproveedor");

		var whereFijo:String = "";

		var curImprimir:FLSqlCursor = new FLSqlCursor("i_resentradas");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("i_consultaentradas_codproveedor", codProveedor);
		curImprimir.setValueBuffer("d_consultaentradas_fecha", this.iface.fechaDesdeConsultaEntradas.date.toString().left(10));
		curImprimir.setValueBuffer("h_consultaentradas_fecha", this.iface.fechaHastaConsultaEntradas.date.toString().left(10));
		flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_resentradas", "", "", false, false, whereFijo);
	} else
			flfactppal.iface.pub_msgNoDisponible("Informes");
}

//// CTASCTES ////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
