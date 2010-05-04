/**************************************************************************
                 trazadoc.qs  -  description
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
	var tblDocs:QTable;
	var filaActual:Number;
	var clienteProveedor:String;
	var PRESUPUESTOS:Number = 0;
	var PEDIDOS:Number = 1;
	var ALBARANES:Number = 2;
	var FACTURAS:Number = 3;
	var RECIBOS:Number = 4;
	var PAGOS:Number = 5;
	var PAGOS_ID:Number = 6;
    function oficial( context ) { interna( context ); } 
	function tblDocsClicked(row:Number, col:Number) {
		return this.ctx.oficial_tblDocsClicked(row, col);
	}
	function dibOrigenFacCli(codigo:String, fila:Number):Number {
		return this.ctx.oficial_dibOrigenFacCli(codigo, fila);
	}
	function dibOrigenFacProv(codigo:String, fila:Number):Number {
		return this.ctx.oficial_dibOrigenFacProv(codigo, fila);
	}
	function dibOrigenAlbCli(codigo:String, fila:Number):Number {
		return this.ctx.oficial_dibOrigenAlbCli(codigo, fila);
	}
	function dibOrigenAlbProv(codigo:String, fila:Number):Number {
		return this.ctx.oficial_dibOrigenAlbProv(codigo, fila);
	}
	function dibOrigenPedCli(codigo:String, fila:Number):Number {
		return this.ctx.oficial_dibOrigenPedCli(codigo, fila);
	}
	function dibDestinoRecCli(codigo:String, fila:Number):Number {
		return this.ctx.oficial_dibDestinoRecCli(codigo, fila);
	}
	function dibDestinoRecProv(codigo:String, fila:Number):Number {
		return this.ctx.oficial_dibDestinoRecProv(codigo, fila);
	}
	function dibDestinoFacCli(codigo:String, fila:Number):Number {
		return this.ctx.oficial_dibDestinoFacCli(codigo, fila);
	}
	function dibDestinoFacProv(codigo:String, fila:Number):Number {
		return this.ctx.oficial_dibDestinoFacProv(codigo, fila);
	}
	function dibDestinoAlbCli(codigo:String, fila:Number):Number {
		return this.ctx.oficial_dibDestinoAlbCli(codigo, fila);
	}
	function dibDestinoAlbProv(codigo:String, fila:Number):Number {
		return this.ctx.oficial_dibDestinoAlbProv(codigo, fila);
	}
	function dibDestinoPedCli(codigo:String, fila:Number):Number {
		return this.ctx.oficial_dibDestinoPedCli(codigo, fila);
	}
	function dibDestinoPedProv(codigo:String, fila:Number):Number {
		return this.ctx.oficial_dibDestinoPedProv(codigo, fila);
	}
	function dibDestinoPreCli(codigo:String, fila:Number):Number {
		return this.ctx.oficial_dibDestinoPreCli(codigo, fila);
	}
	function datosPresupuestoCli(codigo:String) {
		return this.ctx.oficial_datosPresupuestoCli(codigo);
	}
	function datosPresupuestoProv(codigo:String) {
		return this.ctx.oficial_datosPresupuestoCli(codigo);
	}
	function datosPedidoCli(codigo:String) {
		return this.ctx.oficial_datosPedidoCli(codigo);
	}
	function datosPedidoProv(codigo:String) {
		return this.ctx.oficial_datosPedidoProv(codigo);
	}
	function datosAlbaranCli(codigo:String) {
		return this.ctx.oficial_datosAlbaranCli(codigo);
	}
	function datosAlbaranProv(codigo:String) {
		return this.ctx.oficial_datosAlbaranProv(codigo);
	}
	function datosFacturaCli(codigo:String) {
		return this.ctx.oficial_datosFacturaCli(codigo);
	}
	function datosFacturaProv(codigo:String) {
		return this.ctx.oficial_datosFacturaProv(codigo);
	}
	function datosReciboCli(codigo:String) {
		return this.ctx.oficial_datosReciboCli(codigo);
	}
	function datosReciboProv(codigo:String) {
		return this.ctx.oficial_datosReciboProv(codigo);
	}
	function datosPagoDevolCli(codigo:String) {
		return this.ctx.oficial_datosPagoDevolCli(codigo);
	}
	function datosPagoDevolProv(codigo:String) {
		return this.ctx.oficial_datosPagoDevolProv(codigo);
	}
	function verDocumento() {
		return this.ctx.oficial_verDocumento();
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration funServiciosCli */
//////////////////////////////////////////////////////////////////
//// FUN_SERVICIOS_CLI /////////////////////////////////////////////////////
class funServiciosCli extends oficial {
	var SERVICIOS:Number = 7;
	function funServiciosCli( context ) { oficial( context ); } 
	function init() { return this.ctx.funServiciosCli_init(); }
	function datosServicioCli(codigo:String) {
		return this.ctx.funServiciosCli_datosServicioCli(codigo);
	}
	function dibOrigenSerCli(codigo:String, fila:Number):Number {
		return this.ctx.funServiciosCli_dibOrigenSerCli(codigo, fila);
	}
	function dibDestinoSerCli(codigo:String, fila:Number):Number {
		return this.ctx.funServiciosCli_dibDestinoSerCli(codigo, fila);
	}
	function dibOrigenAlbCli(codigo:String, fila:Number):Number {
		return this.ctx.funServiciosCli_dibOrigenAlbCli(codigo, fila);
	}
	function tblDocsClicked(row:Number, col:Number) {
		return this.ctx.funServiciosCli_tblDocsClicked(row, col);
	}
	function verDocumento() {
		return this.ctx.funServiciosCli_verDocumento();
	}
}
//// FUN_SERVICIOS_CLI /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends funServiciosCli {
    function head( context ) { funServiciosCli ( context ); }
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
Este formulario muestra los documentos relacionados con un documento de facturación.
\end */
function interna_init()
{
	this.iface.tblDocs = this.child("tblDocs");
	var cursor:FLSqlCursor = this.cursor();

	var codigo:String = cursor.valueBuffer("codigo");
	var tipo:String = cursor.valueBuffer("tipo");
	
	this.iface.tblDocs.setNumCols(7);
	this.iface.tblDocs.setColumnWidth(0, 130);
	this.iface.tblDocs.setColumnWidth(1, 130);
	this.iface.tblDocs.setColumnWidth(2, 130);
	this.iface.tblDocs.setColumnWidth(3, 130);
	this.iface.tblDocs.setColumnWidth(4, 150);
	this.iface.tblDocs.setColumnWidth(5, 90);
	this.iface.tblDocs.hideColumn(6);
	this.iface.tblDocs.setColumnLabels("/", "Presupuestos/Pedidos/Remitos/Facturas/Facturas/Pagos/");

	this.iface.filaActual = 0;
	switch (tipo) {
		case "presupuestoscli": {
			this.iface.tblDocs.insertRows(this.iface.tblDocs.numRows());
			this.iface.tblDocs.setText(0, this.iface.PRESUPUESTOS, codigo);
			this.iface.dibDestinoPreCli(codigo, 0);
			this.iface.clienteProveedor = "cliente";
			break;
		}
		case "pedidoscli": {
			this.iface.tblDocs.insertRows(this.iface.tblDocs.numRows());
			this.iface.tblDocs.setText(0, this.iface.PEDIDOS, codigo);
			this.iface.dibOrigenPedCli(codigo, 0);
			this.iface.dibDestinoPedCli(codigo, 0);
			this.iface.clienteProveedor = "cliente";
			break;
		}
		case "pedidosprov": {
			this.iface.tblDocs.insertRows(this.iface.tblDocs.numRows());
			this.iface.tblDocs.setText(0, this.iface.PEDIDOS, codigo);
			this.iface.dibDestinoPedProv(codigo, 0);
			this.iface.clienteProveedor = "proveedor";
			break;
		}
		case "albaranescli": {
			this.iface.tblDocs.insertRows(this.iface.tblDocs.numRows());
			this.iface.tblDocs.setText(0, this.iface.ALBARANES, codigo);
			this.iface.dibOrigenAlbCli(codigo, 0);
			this.iface.dibDestinoAlbCli(codigo, 0);
			this.iface.clienteProveedor = "cliente";
			break;
		}
		case "albaranesprov": {
			this.iface.tblDocs.insertRows(this.iface.tblDocs.numRows());
			this.iface.tblDocs.setText(0, this.iface.ALBARANES, codigo);
			this.iface.dibOrigenAlbProv(codigo, 0);
			this.iface.dibDestinoAlbProv(codigo, 0);
			this.iface.clienteProveedor = "proveedor";
			break;
		}
		case "facturascli": {
			this.iface.tblDocs.insertRows(this.iface.tblDocs.numRows());
			this.iface.tblDocs.setText(0, this.iface.FACTURAS, codigo);
			this.iface.dibOrigenFacCli(codigo, 0);
			this.iface.dibDestinoFacCli(codigo, 0);
			this.iface.clienteProveedor = "cliente";
			break;
		}
		case "facturasprov": {
			this.iface.tblDocs.insertRows(this.iface.tblDocs.numRows());
			this.iface.tblDocs.setText(0, this.iface.FACTURAS, codigo);
			this.iface.dibOrigenFacProv(codigo, 0);
			this.iface.dibDestinoFacProv(codigo, 0);
			this.iface.clienteProveedor = "proveedor";
			break;
		}
	}
	connect(this.iface.tblDocs, "currentChanged(int, int)", this, "iface.tblDocsClicked");
	connect(this.child("pbnVerDocumento"), "clicked()", this, "iface.verDocumento");
	this.child("pbnVerDocumento").enabled = false;

}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Muestra los datos del documento seleccionado
\end */
function oficial_tblDocsClicked(row:Number, col:Number)
{
	var codigo:String;
	if (col == this.iface.PAGOS)
		codigo = this.iface.tblDocs.text(row, this.iface.PAGOS_ID);
	else
		codigo = this.iface.tblDocs.text(row, col);
	if (!codigo || codigo == "") {
		this.child("lblDatosDoc").text = "";
		this.child("pbnVerDocumento").enabled = false;
		return;
	}

	switch (col) {
		case this.iface.PRESUPUESTOS: {
			if (this.iface.clienteProveedor == "cliente")
				this.iface.datosPresupuestoCli(codigo);
			this.child("pbnVerDocumento").enabled = true;
			break;
		}
		case this.iface.PEDIDOS: {
			if (this.iface.clienteProveedor == "cliente")
				this.iface.datosPedidoCli(codigo);
			else
				this.iface.datosPedidoProv(codigo);
			this.child("pbnVerDocumento").enabled = true;
			break;
		}
		case this.iface.ALBARANES: {
			if (this.iface.clienteProveedor == "cliente")
				this.iface.datosAlbaranCli(codigo);
			else
				this.iface.datosAlbaranProv(codigo);
			this.child("pbnVerDocumento").enabled = true;
			break;
		}
		case this.iface.FACTURAS: {
			if (this.iface.clienteProveedor == "cliente")
				this.iface.datosFacturaCli(codigo);
			else
				this.iface.datosFacturaProv(codigo);
			this.child("pbnVerDocumento").enabled = true;
			break;
		}
		case this.iface.RECIBOS: {
			if (this.iface.clienteProveedor == "cliente")
				this.iface.datosReciboCli(codigo);
			else
				this.iface.datosReciboProv(codigo);
			this.child("pbnVerDocumento").enabled = true;
			break;
		}
		case this.iface.PAGOS: {
			if (this.iface.clienteProveedor == "cliente")
				this.iface.datosPagoDevolCli(codigo);
			else
				this.iface.datosPagoDevolProv(codigo);
			this.child("pbnVerDocumento").enabled = false;
			break;
		}
	}
}

/** Dibuja los presupuestos que originan el pedido de cliente indicado, a partir de la fila de la tabla indicada
@param	codigo: Código del pedido
@param	fila: Fila en la que comenzar a dibujar
@return	última fila dibujada
\end */
function oficial_dibOrigenPedCli(codigo:String, fila:Number):Number
{

	var qryPresupuestos:FLSqlQuery = new FLSqlQuery();
	with (qryPresupuestos) {
		setTablesList("pedidoscli,presupuestoscli");
		setSelect("pr.codigo");
		setFrom("pedidoscli p INNER JOIN presupuestoscli pr ON p.idpresupuesto = pr.idpresupuesto");
		setWhere("p.codigo = '" + codigo + "' GROUP BY pr.codigo ORDER BY pr.codigo");
		setForwardOnly(true);
	}
	if (!qryPresupuestos.exec())
		return -1;
	while (qryPresupuestos.next()) {
		fila++;

		if (this.iface.tblDocs.numRows() == fila)
			this.iface.tblDocs.insertRows(fila);
		this.iface.tblDocs.setText(fila, this.iface.PRESUPUESTOS, qryPresupuestos.value("pr.codigo"));
	}
	return fila;
}

/** Dibuja los pedidos que originan el remito de cliente indicado, a partir de la fila de la tabla indicada
@param	codigo: Código del remito
@param	fila: Fila en la que comenzar a dibujar
@return	última fila dibujada
\end */
function oficial_dibOrigenAlbCli(codigo:String, fila:Number):Number
{

	var qryPedidos:FLSqlQuery = new FLSqlQuery();
	with (qryPedidos) {
		setTablesList("pedidoscli,lineasalbaranescli,albaranescli");
		setSelect("p.codigo");
		setFrom("albaranescli a INNER JOIN lineasalbaranescli la ON a.idalbaran = la.idalbaran INNER JOIN pedidoscli p ON la.idpedido = p.idpedido");
		setWhere("a.codigo = '" + codigo + "' GROUP BY p.codigo ORDER BY p.codigo");
		setForwardOnly(true);
	}
	if (!qryPedidos.exec())
		return -1;
	while (qryPedidos.next()) {
		fila++;

		if (this.iface.tblDocs.numRows() == fila)
			this.iface.tblDocs.insertRows(fila);
		this.iface.tblDocs.setText(fila, this.iface.PEDIDOS, qryPedidos.value("p.codigo"));
		fila = this.iface.dibOrigenPedCli(qryPedidos.value("p.codigo"), fila);
		if (fila == -1)
			return -1;
	}
	return fila;
}

/** Dibuja los pedidos que originan el remito de proveedor indicado, a partir de la fila de la tabla indicada
@param	codigo: Código del remito
@param	fila: Fila en la que comenzar a dibujar
@return	última fila dibujada
\end */
function oficial_dibOrigenAlbProv(codigo:String, fila:Number):Number
{

	var qryPedidos:FLSqlQuery = new FLSqlQuery();
	with (qryPedidos) {
		setTablesList("pedidosprov,lineasalbaranesprov,albaranesprov");
		setSelect("p.codigo");
		setFrom("albaranesprov a INNER JOIN lineasalbaranesprov la ON a.idalbaran = la.idalbaran INNER JOIN pedidosprov p ON la.idpedido = p.idpedido");
		setWhere("a.codigo = '" + codigo + "' GROUP BY p.codigo ORDER BY p.codigo");
		setForwardOnly(true);
	}
	if (!qryPedidos.exec())
		return -1;
	while (qryPedidos.next()) {
		fila++;

		if (this.iface.tblDocs.numRows() == fila)
			this.iface.tblDocs.insertRows(fila);
		this.iface.tblDocs.setText(fila, this.iface.PEDIDOS, qryPedidos.value("p.codigo"));
	}
	return fila;
}

/** Dibuja los remitos que originan la factura de cliente indicado, a partir de la fila de la tabla indicada
@param	codigo: Código de la factura
@param	fila: Fila en la que comenzar a dibujar
@return	última fila dibujada
\end */
function oficial_dibOrigenFacCli(codigo:String, fila:Number):Number
{

	var qryAlbaranes:FLSqlQuery = new FLSqlQuery();
	with (qryAlbaranes) {
		setTablesList("albaranescli,facturascli");
		setSelect("a.codigo");
		setFrom("facturascli f INNER JOIN albaranescli a ON f.idfactura = a.idfactura");
		setWhere("f.codigo = '" + codigo + "' GROUP BY a.codigo ORDER BY a.codigo");
		setForwardOnly(true);
	}
	if (!qryAlbaranes.exec())
		return -1;
	while (qryAlbaranes.next()) {
		fila++;

		if (this.iface.tblDocs.numRows() == fila)
			this.iface.tblDocs.insertRows(fila);
		this.iface.tblDocs.setText(fila, this.iface.ALBARANES, qryAlbaranes.value("a.codigo"));
		fila = this.iface.dibOrigenAlbCli(qryAlbaranes.value("a.codigo"), fila);
		if (fila == -1)
			return -1;
	}
	return fila;
}

/** Dibuja los remitos que originan la factura de proveedor indicado, a partir de la fila de la tabla indicada
@param	codigo: Código de la factura
@param	fila: Fila en la que comenzar a dibujar
@return	última fila dibujada
\end */
function oficial_dibOrigenFacProv(codigo:String, fila:Number):Number
{

	var qryAlbaranes:FLSqlQuery = new FLSqlQuery();
	with (qryAlbaranes) {
		setTablesList("albaranesprov,facturasprov");
		setSelect("a.codigo");
		setFrom("facturasprov f INNER JOIN albaranesprov a ON f.idfactura = a.idfactura");
		setWhere("f.codigo = '" + codigo + "' GROUP BY a.codigo ORDER BY a.codigo");
		setForwardOnly(true);
	}
	if (!qryAlbaranes.exec())
		return -1;
	while (qryAlbaranes.next()) {
		fila++;

		if (this.iface.tblDocs.numRows() == fila)
			this.iface.tblDocs.insertRows(fila);
		this.iface.tblDocs.setText(fila, this.iface.ALBARANES, qryAlbaranes.value("a.codigo"));
		fila = this.iface.dibOrigenAlbProv(qryAlbaranes.value("a.codigo"), fila);
		if (fila == -1)
			return -1;
	}
	return fila;
}

/** Dibuja los pedidos destino del presupuesto de cliente indicado, a partir de la fila de la tabla indicada
@param	codigo: Código del presupuesto
@param	fila: Fila en la que comenzar a dibujar
@return	última fila dibujada
\end */
function oficial_dibDestinoPreCli(codigo:String, fila:Number):Number
{
	var qryPedidos:FLSqlQuery = new FLSqlQuery();
	with (qryPedidos) {
		setTablesList("pedidoscli,presupuestoscli");
		setSelect("p.codigo");
		setFrom("presupuestoscli pr INNER JOIN pedidoscli p ON pr.idpresupuesto = p.idpresupuesto");
		setWhere("pr.codigo = '" + codigo + "' GROUP BY p.codigo ORDER BY p.codigo");
		setForwardOnly(true);
	}
	if (!qryPedidos.exec())
		return -1;
	while (qryPedidos.next()) {
		fila++;

		if (this.iface.tblDocs.numRows() == fila)
			this.iface.tblDocs.insertRows(fila);
		this.iface.tblDocs.setText(fila, this.iface.PEDIDOS, qryPedidos.value("p.codigo"));
		fila = this.iface.dibDestinoPedCli(qryPedidos.value("p.codigo"), fila);
		if (fila == -1)
			return -1;
	}
	return fila;
}


/** Dibuja los remitos destino del pedido de cliente indicado, a partir de la fila de la tabla indicada
@param	codigo: Código del pedido
@param	fila: Fila en la que comenzar a dibujar
@return	última fila dibujada
\end */
function oficial_dibDestinoPedCli(codigo:String, fila:Number):Number
{
	var qryAlbaranes:FLSqlQuery = new FLSqlQuery();
	with (qryAlbaranes) {
		setTablesList("pedidoscli,albaranescli,lineasalbaranescli");
		setSelect("a.codigo");
		setFrom("pedidoscli p INNER JOIN lineasalbaranescli la ON p.idpedido = la.idpedido INNER JOIN albaranescli a ON la.idalbaran = a.idalbaran");
		setWhere("p.codigo = '" + codigo + "' GROUP BY a.codigo ORDER BY a.codigo");
		setForwardOnly(true);
	}
	if (!qryAlbaranes.exec())
		return -1;
	while (qryAlbaranes.next()) {
		fila++;

		if (this.iface.tblDocs.numRows() == fila)
			this.iface.tblDocs.insertRows(fila);
		this.iface.tblDocs.setText(fila, this.iface.ALBARANES, qryAlbaranes.value("a.codigo"));
		fila = this.iface.dibDestinoAlbCli(qryAlbaranes.value("a.codigo"), fila);
		if (fila == -1)
			return -1;
	}
	return fila;
}

/** Dibuja los remitos destino del pedido de proveedor indicado, a partir de la fila de la tabla indicada
@param	codigo: Código del pedido
@param	fila: Fila en la que comenzar a dibujar
@return	última fila dibujada
\end */
function oficial_dibDestinoPedProv(codigo:String, fila:Number):Number
{
	var qryAlbaranes:FLSqlQuery = new FLSqlQuery();
	with (qryAlbaranes) {
		setTablesList("pedidosprov,albaranesprov,lineasalbaranesprov");
		setSelect("a.codigo");
		setFrom("pedidosprov p INNER JOIN lineasalbaranesprov la ON p.idpedido = la.idpedido INNER JOIN albaranesprov a ON la.idalbaran = a.idalbaran");
		setWhere("p.codigo = '" + codigo + "' GROUP BY a.codigo ORDER BY a.codigo");
		setForwardOnly(true);
	}
	if (!qryAlbaranes.exec())
		return -1;
	while (qryAlbaranes.next()) {
		fila++;

		if (this.iface.tblDocs.numRows() == fila)
			this.iface.tblDocs.insertRows(fila);
		this.iface.tblDocs.setText(fila, this.iface.ALBARANES, qryAlbaranes.value("a.codigo"));
		fila = this.iface.dibDestinoAlbProv(qryAlbaranes.value("a.codigo"), fila);
		if (fila == -1)
			return -1;
	}
	return fila;
}

/** Dibuja las facturas destino del remito de cliente indicado, a partir de la fila de la tabla indicada
@param	codigo: Código del remito
@param	fila: Fila en la que comenzar a dibujar
@return	última fila dibujada
\end */
function oficial_dibDestinoAlbCli(codigo:String, fila:Number):Number
{
	var qryFacturas:FLSqlQuery = new FLSqlQuery();
	with (qryFacturas) {
		setTablesList("facturascli,albaranescli");
		setSelect("f.codigo");
		setFrom("albaranescli a INNER JOIN facturascli f ON a.idfactura = f.idfactura");
		setWhere("a.codigo = '" + codigo + "' GROUP BY f.codigo ORDER BY f.codigo");
		setForwardOnly(true);
	}
	if (!qryFacturas.exec())
		return -1;
	while (qryFacturas.next()) {
		fila++;

		if (this.iface.tblDocs.numRows() == fila)
			this.iface.tblDocs.insertRows(fila);
		this.iface.tblDocs.setText(fila, this.iface.FACTURAS, qryFacturas.value("f.codigo"));
		fila = this.iface.dibDestinoFacCli(qryFacturas.value("f.codigo"), fila);
		if (fila == -1)
			return -1;
	}
	return fila;
}

/** Dibuja las facturas destino del remito de proveedor indicado, a partir de la fila de la tabla indicada
@param	codigo: Código del remito
@param	fila: Fila en la que comenzar a dibujar
@return	última fila dibujada
\end */
function oficial_dibDestinoAlbProv(codigo:String, fila:Number):Number
{
	var qryFacturas:FLSqlQuery = new FLSqlQuery();
	with (qryFacturas) {
		setTablesList("facturasprov,albaranesprov");
		setSelect("f.codigo");
		setFrom("albaranesprov a INNER JOIN facturasprov f ON a.idfactura = f.idfactura");
		setWhere("a.codigo = '" + codigo + "' GROUP BY f.codigo ORDER BY f.codigo");
		setForwardOnly(true);
	}
	if (!qryFacturas.exec())
		return -1;
	while (qryFacturas.next()) {
		fila++;

		if (this.iface.tblDocs.numRows() == fila)
			this.iface.tblDocs.insertRows(fila);
		this.iface.tblDocs.setText(fila, this.iface.FACTURAS, qryFacturas.value("f.codigo"));
		fila = this.iface.dibDestinoFacProv(qryFacturas.value("f.codigo"), fila);
		if (fila == -1)
			return -1;
	}
	return fila;
}

/** Dibuja los recibos destino de la factura de cliente indicada, a partir de la fila de la tabla indicada
@param	codigo: Código de factura
@param	fila: Fila en la que comenzar a dibujar
@return	última fila dibujada
\end */
function oficial_dibDestinoFacCli(codigo:String, fila:Number):Number
{
	var qryRecibos:FLSqlQuery = new FLSqlQuery();
	with (qryRecibos) {
		setTablesList("reciboscli,facturascli");
		setSelect("r.codigo");
		setFrom("facturascli f INNER JOIN reciboscli r ON f.idfactura = r.idfactura");
		setWhere("f.codigo = '" + codigo + "' GROUP BY r.codigo ORDER BY r.codigo");
		setForwardOnly(true);
	}
	if (!qryRecibos.exec())
		return -1;
	while (qryRecibos.next()) {
		fila++;

		if (this.iface.tblDocs.numRows() == fila)
			this.iface.tblDocs.insertRows(fila);
		this.iface.tblDocs.setText(fila, this.iface.RECIBOS, qryRecibos.value("r.codigo"));
		fila = this.iface.dibDestinoRecCli(qryRecibos.value("r.codigo"), fila);
		if (fila == -1)
			return -1;
	}
	return fila;
}

/** Dibuja los recibos destino de la factura de proveedor indicada, a partir de la fila de la tabla indicada
@param	codigo: Código de factura
@param	fila: Fila en la que comenzar a dibujar
@return	última fila dibujada
\end */
function oficial_dibDestinoFacProv(codigo:String, fila:Number):Number
{
	var qryRecibos:FLSqlQuery = new FLSqlQuery();
	with (qryRecibos) {
		setTablesList("recibosprov,facturasprov");
		setSelect("r.codigo");
		setFrom("facturasprov f INNER JOIN recibosprov r ON f.idfactura = r.idfactura");
		setWhere("f.codigo = '" + codigo + "' GROUP BY r.codigo ORDER BY r.codigo");
		setForwardOnly(true);
	}
	if (!qryRecibos.exec())
		return -1;
	while (qryRecibos.next()) {
		fila++;

		if (this.iface.tblDocs.numRows() == fila)
			this.iface.tblDocs.insertRows(fila);
		this.iface.tblDocs.setText(fila, this.iface.RECIBOS, qryRecibos.value("r.codigo"));
		fila = this.iface.dibDestinoRecProv(qryRecibos.value("r.codigo"), fila);
		if (fila == -1)
			return -1;
	}
	return fila;
}

/** Dibuja los pagos destino del recibo de cliente indicado, a partir de la fila de la tabla indicada
@param	codigo: Código de recibo
@param	fila: Fila en la que comenzar a dibujar
@return	última fila dibujada
\end */
function oficial_dibDestinoRecCli(codigo:String, fila:Number):Number
{
	var util:FLUtil = new FLUtil;
	var qryPD:FLSqlQuery = new FLSqlQuery();
	with (qryPD) {
		setTablesList("pagosdevolcli,reciboscli");
		setSelect("pd.idpagodevol, pd.fecha, pd.tipo");
		setFrom("reciboscli r INNER JOIN pagosdevolcli pd ON r.idrecibo = pd.idrecibo");
		setWhere("r.codigo = '" + codigo + "' GROUP BY pd.idpagodevol, pd.fecha, pd.tipo ORDER BY pd.idpagodevol, pd.fecha, pd.tipo");
		setForwardOnly(true);
	}
	if (!qryPD.exec())
		return -1;
	while (qryPD.next()) {
		fila++;

		if (this.iface.tblDocs.numRows() == fila)
			this.iface.tblDocs.insertRows(fila);
		var pagoDevol:String;
		if (qryPD.value("pd.tipo") == "Pago")
			pagoDevol = "P";
		else
			pagoDevol = "D";
		this.iface.tblDocs.setText(fila, this.iface.PAGOS, util.translate("scripts", "%1 (%2)").arg(util.dateAMDtoDMA(qryPD.value("pd.fecha"))).arg(pagoDevol));
		this.iface.tblDocs.setText(fila, this.iface.PAGOS_ID, qryPD.value("pd.idpagodevol"));
	}
	return fila;
}

/** Dibuja los pagos destino del recibo de proveedor indicado, a partir de la fila de la tabla indicada
@param	codigo: Código de recibo
@param	fila: Fila en la que comenzar a dibujar
@return	última fila dibujada
\end */
function oficial_dibDestinoRecProv(codigo:String, fila:Number):Number
{
	var util:FLUtil = new FLUtil;
	var qryPD:FLSqlQuery = new FLSqlQuery();
	with (qryPD) {
		setTablesList("pagosdevolprov,recibosprov");
		setSelect("pd.idpagodevol, pd.fecha, pd.tipo");
		setFrom("recibosprov r INNER JOIN pagosdevolprov pd ON r.idrecibo = pd.idrecibo");
		setWhere("r.codigo = '" + codigo + "' GROUP BY pd.idpagodevol, pd.fecha, pd.tipo ORDER BY pd.idpagodevol, pd.fecha, pd.tipo");
		setForwardOnly(true);
	}
	if (!qryPD.exec())
		return -1;
	while (qryPD.next()) {
		fila++;

		if (this.iface.tblDocs.numRows() == fila)
			this.iface.tblDocs.insertRows(fila);
		var pagoDevol:String;
		if (qryPD.value("pd.tipo") == "Pago")
			pagoDevol = "P";
		else
			pagoDevol = "D";
		this.iface.tblDocs.setText(fila, this.iface.PAGOS, util.translate("scripts", "%1 (%2)").arg(util.dateAMDtoDMA(qryPD.value("pd.fecha"))).arg(pagoDevol));
		this.iface.tblDocs.setText(fila, this.iface.PAGOS_ID, qryPD.value("pd.idpagodevol"));
	}
	return fila;
}

/** \D Muestra los datos principales del presupuesto indicado
@param	codigo: Código del presupuesto
\end */
function oficial_datosPresupuestoCli(codigo:String)
{
	var util:FLUtil = new FLUtil;
	var qry:FLSqlQuery = new FLSqlQuery();
	with (qry) {
		setTablesList("presupuestoscli");
		setSelect("codcliente, nombrecliente, total, editable, coddivisa, fecha");
		setFrom("presupuestoscli");
		setWhere("codigo = '" + codigo + "'");
		setForwardOnly(true);
	}
	if (!qry.exec())
		return false;
	if (!qry.first())
		return false;

	var estado:String;	
	if (qry.value("editable"))
		estado = util.translate("scripts", "Pendiente de aprobación");
	else
		estado = util.translate("scripts", "Aprobado");
	var texto:String = util.translate("scripts", "Presupuesto %1\nCliente %2 - %3\nImporte: %4 %5\nFecha: %6").arg(codigo).arg(qry.value("codcliente")).arg(qry.value("nombrecliente")).arg(util.roundFieldValue(qry.value("total"), "presupuestoscli", "total")).arg(qry.value("coddivisa")).arg(util.dateAMDtoDMA(qry.value("fecha")));
	texto += "\n" + estado;
	this.child("lblDatosDoc").text = texto;
}

/** \D Muestra los datos principales del pedido indicado
@param	codigo: Código del pedido
\end */
function oficial_datosPedidoCli(codigo:String)
{
	var util:FLUtil = new FLUtil;
	var qry:FLSqlQuery = new FLSqlQuery();
	with (qry) {
		setTablesList("pedidoscli");
		setSelect("codcliente, nombrecliente, total, servido, coddivisa, fecha");
		setFrom("pedidoscli");
		setWhere("codigo = '" + codigo + "'");
		setForwardOnly(true);
	}
	if (!qry.exec())
		return false;
	if (!qry.first())
		return false;

	var estado:String;	
	if (qry.value("servido") == util.translate("scripts", "Sí"))
		estado = util.translate("scripts", "Sí");
	else if (qry.value("servido") == util.translate("scripts", "No"))
		estado = util.translate("scripts", "No");
	else
		estado = util.translate("scripts", "Parcial");

	var texto:String = util.translate("scripts", "Pedido %1\nCliente %2 - %3\nImporte: %4 %5\nServido: %6\nFecha: %7").arg(codigo).arg(qry.value("codcliente")).arg(qry.value("nombrecliente")).arg(util.roundFieldValue(qry.value("total"), "pedidoscli", "total")).arg(qry.value("coddivisa")).arg(estado).arg(util.dateAMDtoDMA(qry.value("fecha")));
	this.child("lblDatosDoc").text = texto;
}

/** \D Muestra los datos principales del pedido indicado
@param	codigo: Código del pedido
\end */
function oficial_datosPedidoProv(codigo:String)
{
	var util:FLUtil = new FLUtil;
	var qry:FLSqlQuery = new FLSqlQuery();
	with (qry) {
		setTablesList("pedidosprov");
		setSelect("codproveedor, nombre, total, servido, coddivisa, fecha");
		setFrom("pedidosprov");
		setWhere("codigo = '" + codigo + "'");
		setForwardOnly(true);
	}
	if (!qry.exec())
		return false;
	if (!qry.first())
		return false;

	var estado:String;	
	if (qry.value("servido") == util.translate("scripts", "Sí"))
		estado = util.translate("scripts", "Sí");
	else if (qry.value("servido") == util.translate("scripts", "No"))
		estado = util.translate("scripts", "No");
	else
		estado = util.translate("scripts", "Parcial");

	var texto:String = util.translate("scripts", "Pedido %1\nProveedor %2 - %3\nImporte: %4 %5\nServido: %6\nFecha: %7").arg(codigo).arg(qry.value("codproveedor")).arg(qry.value("nombre")).arg(util.roundFieldValue(qry.value("total"), "pedidosprov", "total")).arg(qry.value("coddivisa")).arg(estado).arg(util.dateAMDtoDMA(qry.value("fecha")));
	this.child("lblDatosDoc").text = texto;
}

/** \D Muestra los datos principales del remito indicado
@param	codigo: Código del remito
\end */
function oficial_datosAlbaranCli(codigo:String)
{
	var util:FLUtil = new FLUtil;
	var qry:FLSqlQuery = new FLSqlQuery();
	with (qry) {
		setTablesList("albaranescli");
		setSelect("codcliente, nombrecliente, total, coddivisa, fecha");
		setFrom("albaranescli");
		setWhere("codigo = '" + codigo + "'");
		setForwardOnly(true);
	}
	if (!qry.exec())
		return false;
	if (!qry.first())
		return false;

	var texto:String = util.translate("scripts", "Remito %1\nCliente %2 - %3\nImporte: %4 %5\nFecha: %6").arg(codigo).arg(qry.value("codcliente")).arg(qry.value("nombrecliente")).arg(util.roundFieldValue(qry.value("total"), "albaranescli", "total")).arg(qry.value("coddivisa")).arg(util.dateAMDtoDMA(qry.value("fecha")));
	this.child("lblDatosDoc").text = texto;
}

/** \D Muestra los datos principales del remito indicado
@param	codigo: Código del remito
\end */
function oficial_datosAlbaranProv(codigo:String)
{
	var util:FLUtil = new FLUtil;
	var qry:FLSqlQuery = new FLSqlQuery();
	with (qry) {
		setTablesList("albaranesprov");
		setSelect("codproveedor, nombre, total, coddivisa, fecha");
		setFrom("albaranesprov");
		setWhere("codigo = '" + codigo + "'");
		setForwardOnly(true);
	}
	if (!qry.exec())
		return false;
	if (!qry.first())
		return false;

	var texto:String = util.translate("scripts", "Remito %1\nProveedor %2 - %3\nImporte: %4 %5\nFecha: %6").arg(codigo).arg(qry.value("codproveedor")).arg(qry.value("nombre")).arg(util.roundFieldValue(qry.value("total"), "albaranesprov", "total")).arg(qry.value("coddivisa")).arg(util.dateAMDtoDMA(qry.value("fecha")));
	this.child("lblDatosDoc").text = texto;
}

/** \D Muestra los datos principales de la factura indicada
@param	codigo: Código del remito
\end */
function oficial_datosFacturaCli(codigo:String)
{
	var util:FLUtil = new FLUtil;
	var qry:FLSqlQuery = new FLSqlQuery();
	with (qry) {
		setTablesList("facturascli");
		setSelect("codcliente, nombrecliente, total, coddivisa, fecha");
		setFrom("facturascli");
		setWhere("codigo = '" + codigo + "'");
		setForwardOnly(true);
	}
	if (!qry.exec())
		return false;
	if (!qry.first())
		return false;

	var texto:String = util.translate("scripts", "Factura %1\nCliente %2 - %3\nImporte: %4 %5\nFecha: %6").arg(codigo).arg(qry.value("codcliente")).arg(qry.value("nombrecliente")).arg(util.roundFieldValue(qry.value("total"), "facturascli", "total")).arg(qry.value("coddivisa")).arg(util.dateAMDtoDMA(qry.value("fecha")));
	this.child("lblDatosDoc").text = texto;
}

/** \D Muestra los datos principales de la factura indicada
@param	codigo: Código del remito
\end */
function oficial_datosFacturaProv(codigo:String)
{
	var util:FLUtil = new FLUtil;
	var qry:FLSqlQuery = new FLSqlQuery();
	with (qry) {
		setTablesList("facturasprov");
		setSelect("codproveedor, nombre, total, coddivisa, fecha");
		setFrom("facturasprov");
		setWhere("codigo = '" + codigo + "'");
		setForwardOnly(true);
	}
	if (!qry.exec())
		return false;
	if (!qry.first())
		return false;

	var texto:String = util.translate("scripts", "Factura %1\nProveedor %2 - %3\nImporte: %4 %5\nFecha: %6").arg(codigo).arg(qry.value("codproveedor")).arg(qry.value("nombre")).arg(util.roundFieldValue(qry.value("total"), "facturasprov", "total")).arg(qry.value("coddivisa")).arg(util.dateAMDtoDMA(qry.value("fecha")));
	this.child("lblDatosDoc").text = texto;
}

/** \D Muestra los datos principales del recibo indicado
@param	codigo: Código del remito
\end */
function oficial_datosReciboCli(codigo:String)
{
	var util:FLUtil = new FLUtil;
	var qry:FLSqlQuery = new FLSqlQuery();
	with (qry) {
		setTablesList("reciboscli");
		setSelect("codcliente, nombrecliente, importe, coddivisa, estado, fecha");
		setFrom("reciboscli");
		setWhere("codigo = '" + codigo + "'");
		setForwardOnly(true);
	}
	if (!qry.exec())
		return false;
	if (!qry.first())
		return false;

	var estado:String = util.translate("scripts", qry.value("estado"));

	var texto:String = util.translate("scripts", "Factura %1\nCliente %2 - %3\nImporte: %4 %5\nEstado: %6\nFecha: %7").arg(codigo).arg(qry.value("codcliente")).arg(qry.value("nombrecliente")).arg(util.roundFieldValue(qry.value("importe"), "reciboscli", "importe")).arg(qry.value("coddivisa")).arg(estado).arg(util.dateAMDtoDMA(qry.value("fecha")));
	this.child("lblDatosDoc").text = texto;
}

/** \D Muestra los datos principales del recibo indicado
@param	codigo: Código del remito
\end */
function oficial_datosReciboProv(codigo:String)
{
	var util:FLUtil = new FLUtil;
	var qry:FLSqlQuery = new FLSqlQuery();
	with (qry) {
		setTablesList("recibosprov");
		setSelect("codproveedor, nombreproveedor, importe, coddivisa, estado, fecha");
		setFrom("recibosprov");
		setWhere("codigo = '" + codigo + "'");
		setForwardOnly(true);
	}
	if (!qry.exec())
		return false;
	if (!qry.first())
		return false;

	var estado:String = util.translate("scripts", qry.value("estado"));

	var texto:String = util.translate("scripts", "Factura %1\nProveedor %2 - %3\nImporte: %4 %5\nEstado: %6\nFecha: %7").arg(codigo).arg(qry.value("codproveedor")).arg(qry.value("nombreproveedor")).arg(util.roundFieldValue(qry.value("importe"), "recibosprov", "importe")).arg(qry.value("coddivisa")).arg(estado).arg(util.dateAMDtoDMA(qry.value("fecha")));
	this.child("lblDatosDoc").text = texto;
}

/** \D Muestra los datos principales del pago de recibo indicado
@param	codigo: Código del pago
\end */
function oficial_datosPagoDevolCli(codigo:String)
{
	var util:FLUtil = new FLUtil;
	var qry:FLSqlQuery = new FLSqlQuery();
	with (qry) {
		setTablesList("pagosdevolcli,reciboscli");
		setSelect("r.codigo, r.codcliente, r.nombrecliente, r.importe, r.coddivisa, pd.tipo, pd.fecha");
		setFrom("pagosdevolcli pd INNER JOIN reciboscli r ON pd.idrecibo = r.idrecibo");
		setWhere("pd.idpagodevol = " + codigo);
		setForwardOnly(true);
	}
	if (!qry.exec())
		return false;
	if (!qry.first())
		return false;

	var tipo:String = util.translate("scripts", qry.value("pd.tipo"));

	var texto:String = util.translate("scripts", "%1 factura %2\nCliente %3 - %4\nImporte: %7 %6\nFecha: %7").arg(tipo).arg(qry.value("r.codigo")).arg(qry.value("r.codcliente")).arg(qry.value("r.nombrecliente")).arg(util.roundFieldValue(qry.value("r.importe"), "reciboscli", "importe")).arg(qry.value("r.coddivisa")).arg(util.dateAMDtoDMA(qry.value("pd.fecha")));
	this.child("lblDatosDoc").text = texto;
}

/** \D Muestra los datos principales del pago de recibo indicado
@param	codigo: Código del pago
\end */
function oficial_datosPagoDevolProv(codigo:String)
{
	var util:FLUtil = new FLUtil;
	var qry:FLSqlQuery = new FLSqlQuery();
	with (qry) {
		setTablesList("pagosdevolprov,recibosprov");
		setSelect("r.codigo, r.codproveedor, r.nombre, r.importe, r.coddivisa, pd.tipo, pd.fecha");
		setFrom("pagosdevolprov pd INNER JOIN recibosprov r ON pd.idrecibo = r.idrecibo");
		setWhere("pd.idpagodevol = " + codigo);
		setForwardOnly(true);
	}
	if (!qry.exec())
		return false;
	if (!qry.first())
		return false;

	var tipo:String = util.translate("scripts", qry.value("pd.tipo"));

	var texto:String = util.translate("scripts", "%1 factura %2\nProveedor %3 - %4\nImporte: %7 %6\nFecha: %7").arg(tipo).arg(qry.value("r.codigo")).arg(qry.value("r.codproveedor")).arg(qry.value("r.nombre")).arg(util.roundFieldValue(qry.value("r.importe"), "recibosprov", "importe")).arg(qry.value("r.coddivisa")).arg(util.dateAMDtoDMA(qry.value("pd.fecha")));
	this.child("lblDatosDoc").text = texto;
}

function oficial_verDocumento()
{
	var columna:Number = this.iface.tblDocs.currentColumn();
	var fila:Number = this.iface.tblDocs.currentRow();
	
	var codigo:String;
	if (columna == this.iface.PAGOS)
		return;
	
	codigo = this.iface.tblDocs.text(fila, columna);
	if (!codigo || codigo == "")
		return;

	var cursor:FLSqlCursor;
	switch (columna) {
		case this.iface.PRESUPUESTOS: {
			if (this.iface.clienteProveedor == "cliente")
				cursor = new FLSqlCursor("presupuestoscli");
			else
				cursor = new FLSqlCursor("presupuestosprov");
			cursor.select("codigo = '" + codigo + "'");
			break;
		}
		case this.iface.PEDIDOS: {
			if (this.iface.clienteProveedor == "cliente")
				cursor = new FLSqlCursor("pedidoscli");
			else
				cursor = new FLSqlCursor("pedidosprov");
			cursor.select("codigo = '" + codigo + "'");
			break;
		}
		case this.iface.ALBARANES: {
			if (this.iface.clienteProveedor == "cliente")
				cursor = new FLSqlCursor("albaranescli");
			else
				cursor = new FLSqlCursor("albaranesprov");
			cursor.select("codigo = '" + codigo + "'");
			break;
		}
		case this.iface.FACTURAS: {
			if (this.iface.clienteProveedor == "cliente")
				cursor = new FLSqlCursor("facturascli");
			else
				cursor = new FLSqlCursor("facturasprov");
			cursor.select("codigo = '" + codigo + "'");
			break;
		}
		case this.iface.RECIBOS: {
			if (this.iface.clienteProveedor == "cliente")
				cursor = new FLSqlCursor("reciboscli");
			else
				cursor = new FLSqlCursor("recibosprov");
			cursor.select("codigo = '" + codigo + "'");
			break;
		}
	}
	if (!cursor.first())
		return false;
	cursor.browseRecord();
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition funServiciosCli */
/////////////////////////////////////////////////////////////////
//// FUN_SERVICIOS_CLI /////////////////////////////////////////////////

function funServiciosCli_init()
{
	this.iface.__init();

	var cursor:FLSqlCursor = this.cursor();
	var tipo:String = cursor.valueBuffer("tipo");
	var codigo:String = cursor.valueBuffer("codigo");
	
	this.iface.tblDocs.setNumCols(8);
	this.iface.tblDocs.setColumnWidth(0, 130);
	this.iface.tblDocs.setColumnWidth(1, 130);
	this.iface.tblDocs.setColumnWidth(2, 130);
	this.iface.tblDocs.setColumnWidth(3, 130);
	this.iface.tblDocs.setColumnWidth(4, 150);
	this.iface.tblDocs.setColumnWidth(5, 90);
	this.iface.tblDocs.setColumnWidth(7, 90);
	this.iface.tblDocs.hideColumn(6);
	this.iface.tblDocs.setColumnLabels("/", "Presupuestos/Pedidos/Remitos/Facturas/Facturas/Pagos/Servicios/Servicios");

	this.iface.filaActual = 0;
	switch (tipo) {
		case "servicioscli": {
			this.iface.tblDocs.insertRows(this.iface.tblDocs.numRows());
			this.iface.tblDocs.setText(0, this.iface.SERVICIOS, codigo);
			this.iface.dibDestinoSerCli(codigo, 0);
			this.iface.clienteProveedor = "cliente";
			break;
		}
		case "albaranescli": {
			this.iface.dibOrigenSerCli(codigo, 0);
			break;
		}
	}
}

/** \D Muestra los datos principales de la factura indicada
@param	codigo: Código del remito
\end */
function funServiciosCli_datosServicioCli(codigo:String)
{
	var util:FLUtil = new FLUtil;
	var qry:FLSqlQuery = new FLSqlQuery();
	with (qry) {
		setTablesList("servicioscli");
		setSelect("codcliente, nombrecliente, total, fecha");
		setFrom("servicioscli");
		setWhere("numservicio = '" + codigo + "'");
		setForwardOnly(true);
	}
	if (!qry.exec())
		return false;
	if (!qry.first())
		return false;

	var texto:String = util.translate("scripts", "Servicio %1\nCliente %2 - %3\nImporte: %4\nFecha: %5").arg(codigo).arg(qry.value("codcliente")).arg(qry.value("nombrecliente")).arg(util.roundFieldValue(qry.value("total"), "servicioscli", "total")).arg(util.dateAMDtoDMA(qry.value("fecha")));
	this.child("lblDatosDoc").text = texto;
}


/** Dibuja los pedidos que originan el remito de cliente indicado, a partir de la fila de la tabla indicada
@param	codigo: Código del remito
@param	fila: Fila en la que comenzar a dibujar
@return	última fila dibujada
\end */
function funServiciosCli_dibOrigenAlbCli(codigo:String, fila:Number):Number
{
	var qryServicios:FLSqlQuery = new FLSqlQuery();
	with (qryServicios) {
		setTablesList("servicioscli,albaranescli");
		setSelect("s.numservicio");
		setFrom("servicioscli s INNER JOIN albaranescli a ON s.idalbaran = a.idalbaran");
		setWhere("a.codigo = '" + codigo + "' GROUP BY s.numservicio ORDER BY s.numservicio");
		setForwardOnly(true);
	}
	if (!qryServicios.exec())
		return this.iface.__dibOrigenAlbCli(codigo, fila);
		
	if (!qryServicios.size())
		return this.iface.__dibOrigenAlbCli(codigo, fila);	
	
	while (qryServicios.next()) {
		this.iface.tblDocs.insertRows(fila);
			
		debug(fila);
		this.iface.tblDocs.setText(fila, this.iface.SERVICIOS, qryServicios.value("s.numservicio"));
	}
	return fila;
}



/** Dibuja los remitos destino del servicio de cliente indicado, a partir de la fila de la tabla indicada
@param	codigo: Código del servicio
@param	fila: Fila en la que comenzar a dibujar
@return	última fila dibujada
\end */
function funServiciosCli_dibDestinoSerCli(codigo:String, fila:Number):Number
{
	var qryAlbaranes:FLSqlQuery = new FLSqlQuery();
	with (qryAlbaranes) {
		setTablesList("servicioscli,albaranescli,lineasalbaranescli");
		setSelect("a.codigo");
		setFrom("servicioscli s INNER JOIN albaranescli a ON s.idalbaran = a.idalbaran");
		setWhere("s.numservicio = '" + codigo + "' GROUP BY a.codigo ORDER BY a.codigo");
		setForwardOnly(true);
	}
	
	if (!qryAlbaranes.exec())
		return -1;
	while (qryAlbaranes.next()) {
		fila++;

		if (this.iface.tblDocs.numRows() == fila)
			this.iface.tblDocs.insertRows(fila);
		this.iface.tblDocs.setText(fila, this.iface.ALBARANES, qryAlbaranes.value("a.codigo"));
		fila = this.iface.dibDestinoAlbCli(qryAlbaranes.value("a.codigo"), fila);
		if (fila == -1)
			return -1;
	}
	return fila;
}

function funServiciosCli_dibOrigenSerCli(codigo:String, fila:Number):Number
{
	var qryAlbaranes:FLSqlQuery = new FLSqlQuery();
	with (qryAlbaranes) {
		setTablesList("servicioscli,albaranescli");
		setSelect("s.numservicio");
		setFrom("servicioscli s INNER JOIN albaranescli a ON s.idalbaran = a.idalbaran");
		setWhere("a.codigo = '" + codigo + "' GROUP BY s.numservicio ORDER BY s.numservicio");
		setForwardOnly(true);
	}
	
	if (!qryAlbaranes.exec())
		return -1;
	while (qryAlbaranes.next()) {
		fila++;

		if (this.iface.tblDocs.numRows() == fila)
			this.iface.tblDocs.insertRows(fila);
		this.iface.tblDocs.setText(fila, this.iface.SERVICIOS, qryAlbaranes.value("s.numservicio"));
	}
}

function funServiciosCli_verDocumento()
{
	var columna:Number = this.iface.tblDocs.currentColumn();
	var fila:Number = this.iface.tblDocs.currentRow();
	
	var codigo:String;
	if (columna == this.iface.PAGOS)
		return;
	
	codigo = this.iface.tblDocs.text(fila, columna);
	if (!codigo || codigo == "")
		return;

	var cursor:FLSqlCursor;
	switch (columna) {
		case this.iface.PRESUPUESTOS: {
			if (this.iface.clienteProveedor == "cliente")
				cursor = new FLSqlCursor("presupuestoscli");
			else
				cursor = new FLSqlCursor("presupuestosprov");
			cursor.select("codigo = '" + codigo + "'");
			break;
		}
		case this.iface.PEDIDOS: {
			if (this.iface.clienteProveedor == "cliente")
				cursor = new FLSqlCursor("pedidoscli");
			else
				cursor = new FLSqlCursor("pedidosprov");
			cursor.select("codigo = '" + codigo + "'");
			break;
		}
		case this.iface.ALBARANES: {
			if (this.iface.clienteProveedor == "cliente")
				cursor = new FLSqlCursor("albaranescli");
			else
				cursor = new FLSqlCursor("albaranesprov");
			cursor.select("codigo = '" + codigo + "'");
			break;
		}
		case this.iface.FACTURAS: {
			if (this.iface.clienteProveedor == "cliente")
				cursor = new FLSqlCursor("facturascli");
			else
				cursor = new FLSqlCursor("facturasprov");
			cursor.select("codigo = '" + codigo + "'");
			break;
		}
		case this.iface.RECIBOS: {
			if (this.iface.clienteProveedor == "cliente")
				cursor = new FLSqlCursor("reciboscli");
			else
				cursor = new FLSqlCursor("recibosprov");
			cursor.select("codigo = '" + codigo + "'");
			break;
		}
		case this.iface.SERVICIOS: {
			cursor = new FLSqlCursor("servicioscli");
			cursor.select("numservicio = '" + codigo + "'");
			break;
		}
	}
	if (!cursor.first())
		return false;
	cursor.browseRecord();
}

function funServiciosCli_tblDocsClicked(row:Number, col:Number)
{
	var codigo:String;
	if (col == this.iface.PAGOS)
		codigo = this.iface.tblDocs.text(row, this.iface.PAGOS_ID);
	else
		codigo = this.iface.tblDocs.text(row, col);
	if (!codigo || codigo == "") {
		this.child("lblDatosDoc").text = "";
		this.child("pbnVerDocumento").enabled = false;
		return;
	}

	switch (col) {
		case this.iface.PRESUPUESTOS: {
			if (this.iface.clienteProveedor == "cliente")
				this.iface.datosPresupuestoCli(codigo);
			this.child("pbnVerDocumento").enabled = true;
			break;
		}
		case this.iface.PEDIDOS: {
			if (this.iface.clienteProveedor == "cliente")
				this.iface.datosPedidoCli(codigo);
			else
				this.iface.datosPedidoProv(codigo);
			this.child("pbnVerDocumento").enabled = true;
			break;
		}
		case this.iface.ALBARANES: {
			if (this.iface.clienteProveedor == "cliente")
				this.iface.datosAlbaranCli(codigo);
			else
				this.iface.datosAlbaranProv(codigo);
			this.child("pbnVerDocumento").enabled = true;
			break;
		}
		case this.iface.FACTURAS: {
			if (this.iface.clienteProveedor == "cliente")
				this.iface.datosFacturaCli(codigo);
			else
				this.iface.datosFacturaProv(codigo);
			this.child("pbnVerDocumento").enabled = true;
			break;
		}
		case this.iface.RECIBOS: {
			if (this.iface.clienteProveedor == "cliente")
				this.iface.datosReciboCli(codigo);
			else
				this.iface.datosReciboProv(codigo);
			this.child("pbnVerDocumento").enabled = true;
			break;
		}
		case this.iface.PAGOS: {
			if (this.iface.clienteProveedor == "cliente")
				this.iface.datosPagoDevolCli(codigo);
			else
				this.iface.datosPagoDevolProv(codigo);
			this.child("pbnVerDocumento").enabled = false;
			break;
		}
		case this.iface.SERVICIOS: {
			this.iface.datosServicioCli(codigo);
			this.child("pbnVerDocumento").enabled = true;
			break;
		}
	}
}
//// FUN_SERVICIOS_CLI ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////