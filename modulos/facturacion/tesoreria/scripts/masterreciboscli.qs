/***************************************************************************
                 masterreciboscli.qs  -  description
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
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
    function oficial( context ) { interna( context ); } 
	function imprimir(codRecibo:String) {
		return this.ctx.oficial_imprimir(codRecibo)
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration fechas */
/////////////////////////////////////////////////////////////////
//// FECHAS /////////////////////////////////////////////////
class fechas extends oficial {
	var tdbRecords:FLTableDB;
	var fechaDesde:Object;
	var fechaHasta:Object;
	var cbxEstado:Object;

    function fechas( context ) { oficial ( context ); }
	function init() {
		this.ctx.fechas_init();
	}
	function actualizarFiltro() {
		return this.ctx.fechas_actualizarFiltro();
	}
	function actualizarFiltroCombo() {
		return this.ctx.fechas_actualizarFiltroCombo();
	}
}
//// FECHAS /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_declaration ordenCampos */
/////////////////////////////////////////////////////////////////
//// ORDEN_CAMPOS ///////////////////////////////////////////////
class ordenCampos extends fechas {
    function ordenCampos( context ) { fechas ( context ); }
	function init() {
		this.ctx.ordenCampos_init();
	}
}
//// ORDEN_CAMPOS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends ordenCampos {
    function head( context ) { ordenCampos ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
	function pub_imprimir(codRecibo:String) {
		return this.imprimir(codRecibo);
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
function interna_init()
{
		this.child("tableDBRecords").setEditOnly(true);
		connect(this.child("toolButtonPrint"), "clicked()", this, "iface.imprimir");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D
Crea un informe con el listado de registros de la remesa. Funciona cuando está cargado el módulo de informes
\end */
function oficial_imprimir(codRecibo:String)
{
	if (sys.isLoadedModule("flfactinfo")) {
		var codigo:String;
		if (codRecibo) {
			codigo = codRecibo;
		} else {
			if (!this.cursor().isValid())
				return;
			codigo = this.cursor().valueBuffer("codigo");
		}
		var curImprimir:FLSqlCursor = new FLSqlCursor("i_reciboscli");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_reciboscli_codigo", codigo);
		curImprimir.setValueBuffer("h_reciboscli_codigo", codigo);
		flfactinfo.iface.pub_lanzarInforme(curImprimir, "i_reciboscli");
	} else
			flfactppal.iface.pub_msgNoDisponible("Informes");
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition fechas */
/////////////////////////////////////////////////////////////////
//// FECHAS /////////////////////////////////////////////////////

function fechas_init()
{
	this.iface.__init();

	this.iface.tdbRecords = this.child("tableDBRecords");
	this.iface.fechaDesde = this.child("dateFrom");
	this.iface.fechaHasta = this.child("dateTo");
	this.iface.cbxEstado = this.child("cbxEstado");

	var mostrarDias:Number = flfactppal.iface.pub_valorDefectoEmpresa("filtroreciboscli");
	if (!mostrarDias || isNaN(mostrarDias) || mostrarDias == 0)
		mostrarDias = 1;
	mostrarDias = (mostrarDias * -1 ) + 1;

	var util:FLUtil = new FLUtil;
	var d = new Date();
	this.iface.fechaDesde.date = new Date( util.addDays(d.toString().left(10), mostrarDias) );
	this.iface.fechaHasta.date = new Date();

	connect(this.iface.fechaDesde, "valueChanged(const QDate&)", this, "iface.actualizarFiltro");
	connect(this.iface.fechaHasta, "valueChanged(const QDate&)", this, "iface.actualizarFiltro");
	connect(this.iface.cbxEstado, "activated(int)", this, "iface.actualizarFiltroCombo");

	this.iface.actualizarFiltro();
}

function fechas_actualizarFiltro()
{
	var desde:String = this.iface.fechaDesde.date.toString().left(10);
	var hasta:String = this.iface.fechaHasta.date.toString().left(10);

	if (desde == "" || hasta == "")
		return;

	var estado:Number = this.iface.cbxEstado.currentItem;
	var filtro:String = "fecha >= '" + desde + "' AND fecha <= '" + hasta + "'";

	switch (estado) {
		case 0: {
			break;
		}
		case 1: {
			filtro += " AND estado = 'Pendiente'";
			break;
		}
		case 2: {
			filtro += " AND estado = 'Pagado'";
			break;
		}
	}

	this.cursor().setMainFilter(filtro);

	this.iface.tdbRecords.refresh();
	this.cursor().last();
	this.iface.tdbRecords.setCurrentRow(this.cursor().at());
}

/* La única diferencia entre esta función y "actualizarFiltro()" es el setFocus() que aparece al final.
   Este setFocus() es práctico cuando se cambia el combobox, pero resulta molesto cuando se cambia la fecha.
 */
function fechas_actualizarFiltroCombo()
{
	var desde:String = this.iface.fechaDesde.date.toString().left(10);
	var hasta:String = this.iface.fechaHasta.date.toString().left(10);

	if (desde == "" || hasta == "")
		return;

	var estado:Number = this.iface.cbxEstado.currentItem;
	var filtro:String = "fecha >= '" + desde + "' AND fecha <= '" + hasta + "'";

	switch (estado) {
		case 0: {
			break;
		}
		case 1: {
			filtro += " AND estado = 'Pendiente'";
			break;
		}
		case 2: {
			filtro += " AND estado = 'Pagado'";
			break;
		}
	}

	this.cursor().setMainFilter(filtro);

	this.iface.tdbRecords.refresh();
	this.cursor().last();
	this.iface.tdbRecords.setCurrentRow(this.cursor().at());
	this.iface.tdbRecords.setFocus();
}

//// FECHAS /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ordenCampos */
/////////////////////////////////////////////////////////////////
//// ORDEN_CAMPOS ///////////////////////////////////////////////

function ordenCampos_init()
{
	this.iface.__init();

	var orden:Array = [ "codigo", "estado", "nombrecliente", "importe", "coddivisa", "importeeuros", "fecha", "fechav", "idremesa", "idpagomulti", "codcliente", "cifnif", "direccion", "codpostal", "ciudad", "provincia", "codpais", "texto" ];

	this.iface.tdbRecords.setOrderCols(orden);
	this.iface.tdbRecords.setFocus();
}

//// ORDEN_CAMPOS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
