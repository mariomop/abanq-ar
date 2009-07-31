/***************************************************************************
                 factteso_clientes.qs  -  description
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
	var tdbConsultaSalidas:FLTableDB;
	var fechaDesdePendiente:Object;
	var fechaHastaPendiente:Object;
	var fechaDesdePagado:Object;
	var fechaHastaPagado:Object;
	var fechaDesdeConsultaSalidas:Object;
	var fechaHastaConsultaSalidas:Object;

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
	function actualizarFiltroConsultaSalidas() {
		this.ctx.ctasCtes_actualizarFiltroConsultaSalidas();
	}
	function filtroMora() {
		this.ctx.ctasCtes_filtroMora();
	}
	function imprimir() {
		this.ctx.ctasCtes_imprimir();
	}
	function verSalida() {
		this.ctx.ctasCtes_verSalida();
	}
	function imprimirSalidas() {
		this.ctx.ctasCtes_imprimirSalidas();
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
	try {	// función de FLFormDB agregada por Silix
		this.setCaptionWidget("Cuenta corriente de Cliente");
	} catch (e) {}

	this.iface.tdbRecibosPendientes = this.child("tdbRecibosPendientes");
	this.iface.tdbRecibosPagados = this.child("tdbRecibosPagados");
	this.iface.tdbConsultaSalidas = this.child("tdbConsultaSalidas");

	this.iface.fechaDesdePendiente = this.child("dateFromPendiente");
	this.iface.fechaHastaPendiente = this.child("dateToPendiente");

	this.iface.fechaDesdePagado = this.child("dateFromPagado");
	this.iface.fechaHastaPagado = this.child("dateToPagado");

	this.iface.fechaDesdeConsultaSalidas = this.child("dateFromConsultaSalidas");
	this.iface.fechaHastaConsultaSalidas = this.child("dateToConsultaSalidas");

	var d = new Date();
	this.iface.fechaDesdePendiente.date = new Date(d.getYear(), 1, 1);
	this.iface.fechaDesdePagado.date = new Date(d.getYear(), d.getMonth(), 1);
	this.iface.fechaDesdeConsultaSalidas.date = new Date(d.getYear(), 1, 1);
	this.iface.fechaHastaPendiente.date = new Date();
	this.iface.fechaHastaPagado.date = new Date();
	this.iface.fechaHastaConsultaSalidas.date = new Date();

	connect(this.iface.fechaDesdePendiente, "valueChanged(const QDate&)", this, "iface.actualizarFiltroPendiente");
	connect(this.iface.fechaHastaPendiente, "valueChanged(const QDate&)", this, "iface.actualizarFiltroPendiente");
	connect(this.iface.fechaDesdePagado, "valueChanged(const QDate&)", this, "iface.actualizarFiltroPagado");
	connect(this.iface.fechaHastaPagado, "valueChanged(const QDate&)", this, "iface.actualizarFiltroPagado");
	connect(this.iface.fechaDesdeConsultaSalidas, "valueChanged(const QDate&)", this, "iface.actualizarFiltroConsultaSalidas");
	connect(this.iface.fechaHastaConsultaSalidas, "valueChanged(const QDate&)", this, "iface.actualizarFiltroConsultaSalidas");
	connect(this.child("chkFiltroMora"), "clicked()", this, "iface.filtroMora");

	this.iface.tdbRecibosPendientes.setReadOnly(true);
	this.iface.tdbRecibosPagados.setReadOnly(true);
	this.iface.tdbConsultaSalidas.setFindHidden(true);
	this.iface.tdbConsultaSalidas.setFilterHidden(true);

	this.iface.actualizarFiltroPendiente();
	this.iface.actualizarFiltroPagado();
	this.iface.actualizarFiltroConsultaSalidas();

	connect(this.child("toolButtonPrint"), "clicked()", this, "iface.imprimir");
	connect(this.child("toolButtonZoomSalida"), "clicked()", this, "iface.verSalida");
	connect(this.child("toolButtonPrintSalidas"), "clicked()", this, "iface.imprimirSalidas");
	connect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");

	this.iface.calcularSaldo();
}

function ctasCtes_validateForm():Boolean
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil;
	/** \C Si el cliente está de baja, la fecha de comienzo de la baja debe estar informada
	\end */
	if (cursor.valueBuffer("debaja") && cursor.isNull("fechabaja")) {
		MessageBox.warning(util.translate("scripts", "Si el cliente está de baja debe introducir la correspondiente fecha de inicio de la baja"), MessageBox.Ok, MessageBox.NoButton)
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

function ctasCtes_actualizarFiltroConsultaSalidas()
{
	var desde = this.iface.fechaDesdeConsultaSalidas.date.toString().left(10);
	var hasta = this.iface.fechaHastaConsultaSalidas.date.toString().left(10);

	if (desde == "" || hasta == "")
		return;

	this.iface.tdbConsultaSalidas.cursor().setMainFilter("fecha >= '" + desde + "'" + " AND " + "fecha <= '" + hasta + "'");
	this.iface.tdbConsultaSalidas.refresh();
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

function ctasCtes_verSalida()
{
	var util:FLUtil;
	var curSalida:FLSqlCursor = this.iface.tdbConsultaSalidas.cursor();

	if (!curSalida.isValid()) {
		MessageBox.warning(util.translate("scripts", "No hay ningún registro seleccionado"), MessageBox.Ok, MessageBox.NoButton);
		return;
	}

	var codigo:String = curSalida.valueBuffer("codigo");
	var cursor:FLSqlCursor;

	switch (curSalida.valueBuffer("tipo")) {
		case "Factura Contado":
		case "Factura Cta.Cte.":
		case "N. Crédito":
		case "N. Débito": {
			cursor = new FLSqlCursor("facturascli");
			cursor.select("codigo = '" + codigo + "'");

			if (!cursor.first())
				return;
			cursor.browseRecord();
			break;
		}
		case "Recibo Cobro": {
			cursor = new FLSqlCursor("pagosmulticli");
			cursor.select("idpagomulti = " + codigo);

			if (!cursor.first())
				return;
			cursor.browseRecord();
			break;
		}
		break;
	}
}

function ctasCtes_imprimirSalidas()
{
	if (sys.isLoadedModule("flfactinfo")) {

		if (!this.cursor().isValid())
			return;

		var codCliente:String;
		codCliente = this.cursor().valueBuffer("codcliente");

		var whereFijo:String = "";

		var curImprimir:FLSqlCursor = new FLSqlCursor("i_ressalidas");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("i_consultasalidas_codcliente", codCliente);
		curImprimir.setValueBuffer("d_consultasalidas_fecha", this.iface.fechaDesdeConsultaSalidas.date.toString().left(10));
		curImprimir.setValueBuffer("h_consultasalidas_fecha", this.iface.fechaHastaConsultaSalidas.date.toString().left(10));
		flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_ressalidas", "", "", false, false, whereFijo);
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
