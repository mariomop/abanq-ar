/***************************************************************************
                 masterpedidosaut.qs  -  descripcion
                             -------------------
    begin                : 22-01-2007
    copyright            : (C) 2007 by Mathias Behrle
    email                : mathiasb@behrle.dyndns.org
    partly based on code by
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
	var pbnGPedido:Object;
	var curPedido:FLSqlCursor;
	var curLineaPedido:FLSqlCursor;
	var tdbRecords:FLTableDB;

    function oficial( context ) { interna( context ); } 
	function procesarEstado() {
		return this.ctx.oficial_procesarEstado();
	}
	function imprimir(codPedido:String, nombreReport:String) {
		return this.ctx.oficial_imprimir(codPedido,nombreReport);
	}
	function pbnGenerarPedido_clicked() {
		return this.ctx.oficial_pbnGenerarPedido_clicked();
	}
	function generarPedido(cursor:FLSqlCursor):Number {
		return this.ctx.oficial_generarPedido(cursor);
	}
	function copiaLineas(idPedidoAut:Number, idPedido:Number):Boolean {
		return this.ctx.oficial_copiaLineas(idPedidoAut, idPedido);
	}
	function copiaLineaPedidoAut(curLineaPedidoAut:FLSqlCursor, idPedido:Number):Number {
		return this.ctx.oficial_copiaLineaPedidoAut(curLineaPedidoAut, idPedido);
	}
	function totalesPedido():Boolean {
		return this.ctx.oficial_totalesPedido();
	}
	function datosPedido(curPedidoAut:FLSqlCursor):Boolean {
		return this.ctx.oficial_datosPedido(curPedidoAut);
	}
	function datosLineaPedido(curLineaPedidoAut:FLSqlCursor):Boolean {
		return this.ctx.oficial_datosLineaPedido(curLineaPedidoAut);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration fechas */
/////////////////////////////////////////////////////////////////
//// FECHAS /////////////////////////////////////////////////
class fechas extends oficial {
	var fechaDesde:Object;
	var fechaHasta:Object;

    function fechas( context ) { oficial ( context ); }
	function init() {
		this.ctx.fechas_init();
	}
	function actualizarFiltro() {
		return this.ctx.fechas_actualizarFiltro();
	}
}
//// FECHAS /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_declaration totalesIva */
/////////////////////////////////////////////////////////////////
//// TOTALES CON IVA ////////////////////////////////////////////
class totalesIva extends fechas {
    function totalesIva( context ) { fechas ( context ); }
	function datosLineaPedido(curLineaPedidoAut:FLSqlCursor):Boolean {
		return this.ctx.totalesIva_datosLineaPedido(curLineaPedidoAut);
	}
}
//// TOTALES CON IVA ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends totalesIva {
    function head( context ) { totalesIva ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
	function pub_imprimir(codPedido:String) {
		return this.imprimir(codPedido);
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

	this.iface.pbnGPedido = this.child("pbnGenerarPedido");
	this.iface.tdbRecords = this.child("tableDBRecords");

	connect(this.iface.tdbRecords, "currentChanged()", this, "iface.procesarEstado()");
	connect(this.iface.pbnGPedido, "clicked()", this, "iface.pbnGenerarPedido_clicked");
	connect(this.child("toolButtonPrint"), "clicked()", this, "iface.imprimir");

	this.iface.procesarEstado();
}


//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \C
Al pulsar el bot�n imprimir se lanzar� el informe correspondiente al pedido seleccionado (en caso de que el m�dulo de informes est� cargado)
\end */
function oficial_imprimir(codPedido:String, nombreReport:String)
{
	return; // No existe a�n el informe de pedidos autom�ticos.

	if (sys.isLoadedModule("flfactinfo")) {
		var codigo:String;
		if (codPedido) {
			codigo = codPedido;
		} else {
			if (!this.cursor().isValid())
				return;
			codigo = this.cursor().valueBuffer("codigo");
		}
		var nombreInforme:String = "i_pedidosaut";
		var curImprimir:FLSqlCursor = new FLSqlCursor("i_pedidosaut");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_pedidosaut_codigo", codigo);
		curImprimir.setValueBuffer("h_pedidosaut_codigo", codigo);

		if (nombreReport)
			flfactinfo.iface.pub_lanzarInforme(curImprimir, nombreInforme, "", "", false, false, "", nombreReport);
		else
			flfactinfo.iface.pub_lanzarInforme(curImprimir, nombreInforme);

	} else
		flfactppal.iface.pub_msgNoDisponible("Informes");
}


function oficial_procesarEstado()
{
	if (this.cursor().isValid() && this.cursor().valueBuffer("editable") == true) {
		this.iface.pbnGPedido.enabled = true;
	} else {
		this.iface.pbnGPedido.enabled = false;
	}
}

/** \C
Al pulsar el bot�n de generar pedido se crear� el remito correspondiente al pedido automatico seleccionado.
\end */
function oficial_pbnGenerarPedido_clicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	if (!this.cursor().isValid()) {
		this.iface.procesarEstado();
		return;
	}
	if (cursor.valueBuffer("editable") == false) {
		MessageBox.warning(util.translate("scripts", "El pedido ya est� generado"), MessageBox.Ok, MessageBox.NoButton);
		this.iface.procesarEstado();
		return;
	}
	var res:Number = MessageBox.warning(util.translate("scripts", "Se generar� un pedido a partir del registro seleccionado.\n�Desea continuar?"), MessageBox.Yes, MessageBox.No);
	if (res != MessageBox.Yes)
		return;

	this.iface.pbnGPedido.setEnabled(false);

	cursor.transaction(false);
	try {
		if (this.iface.generarPedido(cursor))
			cursor.commit();
		else
			cursor.rollback();
	}
	catch (e) {
		cursor.rollback();
		MessageBox.critical(util.translate("scripts", "Hubo un error en la generaci�n del pedido:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
	}
	this.iface.tdbRecords.refresh();
	this.iface.procesarEstado();
}


/** \D
Genera el pedido asociado a un pedido automatico
@param cursor: Cursor con los datos principales que se copiar�n del pedido automatico al pedido real
@return True: Copia realizada con �xito, False: Error
\end */
function oficial_generarPedido(curPedidoAut:FLSqlCursor):Number
{
	var util:FLUtil = new FLUtil();
	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Generando pedido..." ), 10 );

	if (!this.iface.curPedido)
		this.iface.curPedido = new FLSqlCursor("pedidosprov");
	
	util.setProgress( ++paso );
	
	var idPedidoAut:String = curPedidoAut.valueBuffer("idpedidoaut");
	
	this.iface.curPedido.setModeAccess(this.iface.curPedido.Insert);
	this.iface.curPedido.refreshBuffer();
	this.iface.curPedido.setValueBuffer("idpedidoaut", idPedidoAut);
	
	util.setProgress( ++paso );
	
	if (!this.iface.datosPedido(curPedidoAut)) {
		util.destroyProgressDialog();
		return false;
	}
	
	util.setProgress( ++paso );
	
	if (!this.iface.curPedido.commitBuffer()) {
		util.destroyProgressDialog();
		return false;
	}
	
	util.setProgress( ++paso );
	
	var idPedido:Number = this.iface.curPedido.valueBuffer("idpedido");
	var curPedidoAuts:FLSqlCursor = new FLSqlCursor("pedidosaut");
	curPedidoAuts.select("idpedidoaut = " + idPedidoAut);
	if (!curPedidoAuts.first()) {
		util.destroyProgressDialog();
		return false;
	}
	
	util.setProgress( ++paso );
	
	curPedidoAuts.setModeAccess(curPedidoAuts.Edit);
	curPedidoAuts.refreshBuffer();
	if (!this.iface.copiaLineas(idPedidoAut, idPedido)) {
		util.destroyProgressDialog();
		return false;
	}
	
	util.setProgress( ++paso );
	
	curPedidoAuts.setValueBuffer("idpedido", idPedido);
	curPedidoAuts.setValueBuffer("editable", false);
	if (!curPedidoAuts.commitBuffer()) {
		util.destroyProgressDialog();
		return false;
	}
	
	util.setProgress( ++paso );
	
	this.iface.curPedido.select("idpedido = " + idPedido);
	if (this.iface.curPedido.first()) {
		this.iface.curPedido.setModeAccess(this.iface.curPedido.Edit);
		this.iface.curPedido.refreshBuffer();
		this.iface.curPedido.setValueBuffer("idpedidoaut", idPedidoAut);
		
		util.setProgress( ++paso );
		
		if (!this.iface.totalesPedido()) {
			util.destroyProgressDialog();
			return false;
		}
		
		util.setProgress( ++paso );
		
		if (this.iface.curPedido.commitBuffer() == false) {
			util.destroyProgressDialog();
			return false;
		}
		
		util.setProgress( ++paso );
	}

	util.destroyProgressDialog();

	return idPedido;
}

/** \D Informa los datos de un pedido a partir de los de un pedido automatico
@param	curPedidoAut: Cursor que contiene los datos a incluir en el pedido
@return	True si el c�lculo se realiza correctamente, false en caso contrario
\end */
function oficial_datosPedido(curPedidoAut:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var fecha:String;
	if (curPedidoAut.action() == "pedidosaut") {
		var hoy:Date = new Date();
		fecha = hoy.toString();
	} else
		fecha = curPedidoAut.valueBuffer("fecha");
	
	var codProveedor:String = curPedidoAut.valueBuffer("codproveedor");
	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	var codAlmacen:String = flfactppal.iface.pub_valorDefectoEmpresa("codalmacen");
	var tasaConv:Number = util.sqlSelect("divisas", "tasaconv", "coddivisa = '" + curPedidoAut.valueBuffer("coddivisa") + "'");
	var qryDatosProv:FLSqlQuery = new FLSqlQuery();
	with (qryDatosProv) {
		setTablesList("proveedores");
		setSelect("cifnif,numcliente,codpago");
		setFrom("proveedores");
		setWhere("codproveedor = '" + codProveedor + "'");
		setForwardOnly(true);
	}
	if (!qryDatosProv.exec())
		return;
	qryDatosProv.first();
	
	var codPago:String = qryDatosProv.value("codpago");
	var cifNif:String = qryDatosProv.value("cifnif");
	var numCliente:String = qryDatosProv.value("numcliente");
	
	var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(fecha, codEjercicio, "pedidosprov");
	if (!datosDoc.ok)
		return false;
	if (datosDoc.modificaciones == true) {
		codEjercicio = datosDoc.codEjercicio;
		fecha = datosDoc.fecha;
	}

	with (this.iface.curPedido) {
		setValueBuffer("fecha", fecha);
		setValueBuffer("nombre", curPedidoAut.valueBuffer("nombreproveedor"));
		setValueBuffer("cifnif", cifNif);
		setValueBuffer("codproveedor", codProveedor);
		setValueBuffer("coddivisa", curPedidoAut.valueBuffer("coddivisa"));
		setValueBuffer("codserie", curPedidoAut.valueBuffer("codserie"));
		setValueBuffer("codejercicio", codEjercicio);
		setValueBuffer("codalmacen", codAlmacen);
		setValueBuffer("codpago", codPago);
		setValueBuffer("tasaconv", tasaConv);
		setValueBuffer("numcliente", numCliente);
	}
	
	return true;
}

/** \D Informa los datos de un pedido referentes a totales (I.V.A., neto, etc.)
@return	True si el c�lculo se realiza correctamente, false en caso contrario
\end */
function oficial_totalesPedido():Boolean
{
	var util:FLUtil = new FLUtil;
	var curPedido:FLSqlCursor = this.iface.curPedido;
	var neto:Number = formpedidosprov.iface.pub_commonCalculateField("neto", this.iface.curPedido);

	with (this.iface.curPedido) {
		setValueBuffer("neto", neto);
		setValueBuffer("totaliva", formpedidosprov.iface.pub_commonCalculateField("totaliva", curPedido));
		setValueBuffer("total", formpedidosprov.iface.pub_commonCalculateField("total", curPedido));
		setValueBuffer("totaleuros", formpedidosprov.iface.pub_commonCalculateField("totaleuros", curPedido));
	}
	return true;
}

/** \D
Copia las l�neas de un pedido automatico como l�neas de su pedido asociado
@param idPedidoAut: Identificador del pedido automatico
@param idPedido: Identificador del pedido real
\end */
function oficial_copiaLineas(idPedidoAut:Number, idPedido:Number):Boolean
{
	var codProveedor:String = this.iface.curPedido.valueBuffer("codproveedor");
	var referencia:String;
	var variacion:Number;	
	var curLineaPedidoAut:FLSqlCursor = new FLSqlCursor("lineaspedidosaut");
	curLineaPedidoAut.select("idpedidoaut = " + idPedidoAut);
	while (curLineaPedidoAut.next()) {
		curLineaPedidoAut.setModeAccess(curLineaPedidoAut.Browse);
		curLineaPedidoAut.refreshBuffer();
		referencia = curLineaPedidoAut.valueBuffer("referencia");
		variacion = curLineaPedidoAut.valueBuffer("cantidad");
		if (!this.iface.copiaLineaPedidoAut(curLineaPedidoAut, idPedido))
			return false;
		if (!flfacturac.iface.pub_cambiarStockOrd(referencia, variacion))
			return false;
	}
	return true;
}


function oficial_copiaLineaPedidoAut(curLineaPedidoAut:FLSqlCursor, idPedido:Number):Number
{
	if (!this.iface.curLineaPedido)
		this.iface.curLineaPedido = new FLSqlCursor("lineaspedidosprov");
	
	with (this.iface.curLineaPedido) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idpedido", idPedido);
	}
	
	if (!this.iface.datosLineaPedido(curLineaPedidoAut))
		return false;
	if (!this.iface.curLineaPedido.commitBuffer())
		return false;
	
	return this.iface.curLineaPedido.valueBuffer("idlinea");
}

/** \D Copia los datos de una l�nea de pedido automatico en una l�nea de pedido
@param	curLineaPedidoAut: Cursor que contiene los datos a incluir en la l�nea de pedido
@return	True si la copia se realiza correctamente, false en caso contrario
\end */
function oficial_datosLineaPedido(curLineaPedidoAut:FLSqlCursor):Boolean
{
	with (this.iface.curLineaPedido) {
		setValueBuffer("pvpunitario", curLineaPedidoAut.valueBuffer("pvpunitario"));
		setValueBuffer("pvpsindto", curLineaPedidoAut.valueBuffer("pvpsindto"));
		setValueBuffer("pvptotal", curLineaPedidoAut.valueBuffer("pvptotal"));
		setValueBuffer("cantidad", curLineaPedidoAut.valueBuffer("cantidad"));
		setValueBuffer("referencia", curLineaPedidoAut.valueBuffer("referencia"));
		setValueBuffer("descripcion", curLineaPedidoAut.valueBuffer("descripcion"));
		setValueBuffer("codimpuesto", curLineaPedidoAut.valueBuffer("codimpuesto"));
		setValueBuffer("iva", curLineaPedidoAut.valueBuffer("iva"));
		setValueBuffer("dtolineal", curLineaPedidoAut.valueBuffer("dtolineal"));
		setValueBuffer("dtopor", curLineaPedidoAut.valueBuffer("dtopor"));
		setValueBuffer("idpedidoaut", curLineaPedidoAut.valueBuffer("idpedidoaut"));
	}
	return true;
}

function oficial_copiaLineaPedidoAut(curLineaPedidoAut:FLSqlCursor, idPedido:Number):Number
{
	if (!this.iface.curLineaPedido)
		this.iface.curLineaPedido = new FLSqlCursor("lineaspedidosprov");
	
	with (this.iface.curLineaPedido) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idpedido", idPedido);
	}
	
	if (!this.iface.datosLineaPedido(curLineaPedidoAut))
		return false;
	if (!this.iface.curLineaPedido.commitBuffer())
		return false;
	
	return this.iface.curLineaPedido.valueBuffer("idlinea");
}

/** \D Copia los datos de una l�nea de pedido automatico en una l�nea de pedido
@param	curLineaPedidoAut: Cursor que contiene los datos a incluir en la l�nea de pedido
@return	True si la copia se realiza correctamente, false en caso contrario
\end */
function oficial_datosLineaPedido(curLineaPedidoAut:FLSqlCursor):Boolean
{
	with (this.iface.curLineaPedido) {
		setValueBuffer("pvpunitario", curLineaPedidoAut.valueBuffer("pvpunitario"));
		setValueBuffer("pvpsindto", curLineaPedidoAut.valueBuffer("pvpsindto"));
		setValueBuffer("pvptotal", curLineaPedidoAut.valueBuffer("pvptotal"));
		setValueBuffer("cantidad", curLineaPedidoAut.valueBuffer("cantidad"));
		setValueBuffer("referencia", curLineaPedidoAut.valueBuffer("referencia"));
		setValueBuffer("descripcion", curLineaPedidoAut.valueBuffer("descripcion"));
		setValueBuffer("codimpuesto", curLineaPedidoAut.valueBuffer("codimpuesto"));
		setValueBuffer("iva", curLineaPedidoAut.valueBuffer("iva"));
		setValueBuffer("dtolineal", curLineaPedidoAut.valueBuffer("dtolineal"));
		setValueBuffer("dtopor", curLineaPedidoAut.valueBuffer("dtopor"));
		setValueBuffer("idpedidoaut", curLineaPedidoAut.valueBuffer("idpedidoaut"));
	}
	return true;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition fechas */
/////////////////////////////////////////////////////////////////
//// FECHAS /////////////////////////////////////////////////////

function fechas_init()
{
	this.iface.__init();

	this.iface.fechaDesde = this.child("dateFrom");
	this.iface.fechaHasta = this.child("dateTo");

	var d = new Date();
	this.iface.fechaDesde.date = new Date(d.getYear(), d.getMonth(), 1);
	this.iface.fechaHasta.date = new Date();

	connect(this.iface.fechaDesde, "valueChanged(const QDate&)", this, "iface.actualizarFiltro");
	connect(this.iface.fechaHasta, "valueChanged(const QDate&)", this, "iface.actualizarFiltro");

	this.iface.actualizarFiltro();

	this.iface.procesarEstado();
}

function fechas_actualizarFiltro()
{
	var desde:String = this.iface.fechaDesde.date.toString().left(10);
	var hasta:String = this.iface.fechaHasta.date.toString().left(10);

	if (desde == "" || hasta == "")
		return;

	this.cursor().setMainFilter("fecha >= '" + desde + "' AND fecha <= '" + hasta + "'");

	this.iface.tdbRecords.refresh();
	this.cursor().last();
	this.iface.tdbRecords.setCurrentRow(this.cursor().at());
}

//// FECHAS /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition totalesIva */
/////////////////////////////////////////////////////////////////
//// TOTALES CON IVA ////////////////////////////////////////////

function totalesIva_datosLineaPedido(curLineaPedidoAut:FLSqlCursor):Boolean
{
	if(!this.iface.__datosLineaPedido(curLineaPedidoAut))
		return false;

	with (this.iface.curLineaPedido) {
		setValueBuffer("totalconiva", curLineaPedidoAut.valueBuffer("totalconiva"));
	}
	return true;
}

//// TOTALES CON IVA ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
