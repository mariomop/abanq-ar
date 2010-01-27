/***************************************************************************
                 masterfacturasprov.qs  -  description
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
	var pbnAFactura:Object;
	var tdbRecords:FLTableDB;
	var tbnImprimir:Object;
	var curFactura:FLSqlCursor;
	var curLineaFactura:FLSqlCursor;
    function oficial( context ) { interna( context ); } 
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.oficial_commonCalculateField(fN, cursor);
	}
	function asociarAFactura() {
		return this.ctx.oficial_asociarAFactura();
	}
	function whereAgrupacion(curAgrupar:FLSqlCursor):String {
		return this.ctx.oficial_whereAgrupacion(curAgrupar);
	}
	function sinIVA(cursor:FLSqlCursor):Boolean {
		return this.ctx.oficial_sinIVA(cursor);
	}
	function copiarFactura_clicked() {
		return this.ctx.oficial_copiarFactura_clicked();
	}
	function copiarFactura(curFactura:FLSqlCursor):Number {
		return this.ctx.oficial_copiarFactura(curFactura);
	}
	function copiadatosFactura(curFactura:FLSqlCursor):Boolean {
		return this.ctx.oficial_copiadatosFactura(curFactura);
	}
	function copiaLineasFactura(idFacturaOrigen:Number,idFacturaDestino:Number):Boolean {
		return this.ctx.oficial_copiaLineasFactura(idFacturaOrigen,idFacturaDestino);
	}
	function copiaLineaFactura(curLineaFactura:FLSqlCursor, idFactura:Number):Number {
		return this.ctx.oficial_copiaLineaFactura(curLineaFactura, idFactura);
	}
	function totalesFactura():Boolean {
		return this.ctx.oficial_totalesFactura();
	}
	function copiadatosLineaFactura(curLineaFactura:FLSqlCursor):Boolean {
		return this.ctx.oficial_copiadatosLineaFactura(curLineaFactura);
	}
	function dameDatosAgrupacionAlbaranes(curAgruparAlbaranes:FLSqlCursor):Array {
		return this.ctx.oficial_dameDatosAgrupacionAlbaranes(curAgruparAlbaranes);
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
	function copiadatosLineaFactura(curLineaFactura:FLSqlCursor):Boolean {
		return this.ctx.totalesIva_copiadatosLineaFactura(curLineaFactura);
	}
}
//// TOTALES CON IVA ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_declaration impresiones */
/////////////////////////////////////////////////////////////////
//// IMPRESIONES ////////////////////////////////////////////////
class impresiones extends totalesIva {
	var tbnImprimir:Object;

    function impresiones( context ) { totalesIva ( context ); }
	function init() { this.ctx.impresiones_init(); }
	function imprimir(codFactura:String) {
		return this.ctx.impresiones_imprimir(codFactura);
	}
}
//// IMPRESIONES ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_declaration ordenCampos */
/////////////////////////////////////////////////////////////////
//// ORDEN_CAMPOS ///////////////////////////////////////////////
class ordenCampos extends impresiones {
    function ordenCampos( context ) { impresiones ( context ); }
	function init() {
		this.ctx.ordenCampos_init();
	}
}
//// ORDEN_CAMPOS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration tipoVenta */
/////////////////////////////////////////////////////////////////
//// TIPO DE VENTA //////////////////////////////////////////////
class tipoVenta extends ordenCampos {
	function tipoVenta( context ) { ordenCampos ( context ); }
	function copiadatosFactura(curFactura:FLSqlCursor):Boolean {
		return this.ctx.tipoVenta_copiadatosFactura(curFactura);
	}
}
//// TIPO DE VENTA  /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pieDocumento */
/////////////////////////////////////////////////////////////////
//// PIE DE DOCUMENTO ///////////////////////////////////////////
class pieDocumento extends tipoVenta {
	var curPieFactura:FLSqlCursor;

	function pieDocumento( context ) { tipoVenta ( context ); }
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.pieDocumento_commonCalculateField(fN, cursor);
	}
	function copiaPiesFactura(idFacturaOrigen:Number,idFacturaDestino:Number):Boolean {
		return this.ctx.pieDocumento_copiaPiesFactura(idFacturaOrigen,idFacturaDestino);
	}
	function copiaPieFactura(curPieFactura:FLSqlCursor, idFactura:Number):Number {
		return this.ctx.pieDocumento_copiaPieFactura(curPieFactura, idFactura);
	}
	function datosPieFactura(curPieFactura:FLSqlCursor):Boolean {
		return this.ctx.pieDocumento_datosPieFactura(curPieFactura);
	}
	function copiadatosFactura(curFactura:FLSqlCursor):Boolean {
		return this.ctx.pieDocumento_copiadatosFactura(curFactura);
	}
}
//// PIE DE DOCUMENTO  //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration periodosFiscales */
/////////////////////////////////////////////////////////////////
//// PERIODOS FISCALES //////////////////////////////////////////
class periodosFiscales extends pieDocumento {
	function periodosFiscales( context ) { pieDocumento ( context ); }
	function copiadatosFactura(curFactura:FLSqlCursor):Boolean {
		return this.ctx.periodosFiscales_copiadatosFactura(curFactura);
	}
}
//// PERIODOS FISCALES //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends periodosFiscales {
    function head( context ) { periodosFiscales ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
	function pub_commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.commonCalculateField(fN, cursor);
	}
	function pub_whereAgrupacion(curAgrupar:FLSqlCursor):String {
		return this.whereAgrupacion(curAgrupar);
	}
	function pub_imprimir(codFactura:String) {
		return this.imprimir(codFactura);
	}
	function pub_sinIVA(cursor:FLSqlCursor):Boolean {
		return this.sinIVA(cursor);
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
/** \C
Este es el formulario maestro de facturas a proveedor.
\end */
function interna_init()
{
	this.iface.pbnAFactura = this.child("pbnAsociarAFactura");
	this.iface.tdbRecords= this.child("tableDBRecords");
	this.iface.tbnImprimir = this.child("toolButtonPrint");

	connect(this.iface.pbnAFactura, "clicked()", this, "iface.asociarAFactura()");
	connect(this.iface.tbnImprimir, "clicked()", this, "iface.imprimir");
	connect(this.child("toolButtonCopy"), "clicked()", this, "iface.copiarFactura_clicked()");
}

/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_commonCalculateField(fN:String, cursor:FLSqlCursor):String
{
	var util:FLUtil = new FLUtil();
	var valor:String;

	/** \C
	El --código-- se construye como la concatenación de --codserie--, --codejercicio-- y --numero--
	\end */
	if (fN == "codigo")
		valor = flfacturac.iface.pub_construirCodigo(cursor.valueBuffer("codserie"), cursor.valueBuffer("codejercicio"), cursor.valueBuffer("numero"));

	switch (fN) {
	/** \C
	El --total-- es el --neto-- más el --totaliva--
	\end */
	case "total": {
			var neto:Number = parseFloat(cursor.valueBuffer("neto"));
			var totalIva:Number = parseFloat(cursor.valueBuffer("totaliva"));
			valor = neto + totalIva;
			valor = parseFloat(util.roundFieldValue(valor, "facturasprov", "total"));
			break;
		}
		/** \C
		El --totaleuros-- es el producto del --total-- por la --tasaconv--
		\end */
		case "totaleuros": {
			var total:Number = parseFloat(cursor.valueBuffer("total"));
			var tasaConv:Number = parseFloat(cursor.valueBuffer("tasaconv"));
			valor = total * tasaConv;
			valor = parseFloat(util.roundFieldValue(valor, "facturasprov", "totaleuros"));
			break;
		}
		/** \C
		El --neto-- es la suma del pvp total de las líneas de remito
		\end */
		case "neto": {
			valor = util.sqlSelect("lineasfacturasprov", "SUM(pvptotal)", "idfactura = " + cursor.valueBuffer("idfactura"));
			valor = parseFloat(util.roundFieldValue(valor, "facturasprov", "neto"));
			break;
		}
		/** \C
		El --totaliva-- es la suma del iva correspondiente a las líneas de remito
		\end */
		case "totaliva": {
			if (this.iface.sinIVA(cursor))
				valor = 0;
			else {
				valor = util.sqlSelect("lineasfacturasprov", "SUM((pvptotal * iva) / 100)", "idfactura = " + cursor.valueBuffer("idfactura"));
				valor = parseFloat(util.roundFieldValue(valor, "facturasprov", "totaliva"));
			}
			break;
		}
	}
	return valor;
}

/** \C
Al pulsar el botón de asociar a factura se abre la ventana de agrupar remitos de proveedor
\end */
function oficial_asociarAFactura()
{
	var util:FLUtil = new FLUtil;
	var f:Object = new FLFormSearchDB("agruparalbaranesprov");
	var cursor:FLSqlCursor = f.cursor();
	var where:String;
	var codProveedor:String;
	var codAlmacen:String;

	cursor.setActivatedCheckIntegrity(false);
	cursor.select();
	if (!cursor.first()) {
		cursor.setModeAccess(cursor.Insert);
	} else {
		cursor.setModeAccess(cursor.Edit);
	}

	f.setMainWidget();
	cursor.refreshBuffer();
	var acpt:String = f.exec("id");
	if (acpt) {
		cursor.commitBuffer();

		var curAgruparAlbaranes:FLSqlCursor = new FLSqlCursor("agruparalbaranesprov");
		curAgruparAlbaranes.select();
		if (curAgruparAlbaranes.first()) {
			where = this.iface.whereAgrupacion(curAgruparAlbaranes);
			var excepciones:FLSqlCursor = curAgruparAlbaranes.valueBuffer("excepciones");
			if (!excepciones.isEmpty()) {
				where += " AND idalbaran NOT IN (" + excepciones + ")";
			}
			var qryAgruparAlbaranes:FLSqlQuery = new FLSqlQuery;
			qryAgruparAlbaranes.setTablesList("albaranesprov");
			qryAgruparAlbaranes.setSelect("codproveedor,codalmacen");
			qryAgruparAlbaranes.setFrom("albaranesprov");
			qryAgruparAlbaranes.setWhere(where + " GROUP BY codproveedor,codalmacen");

			if (!qryAgruparAlbaranes.exec()) {
				return;
			}

			var totalProv:Number = qryAgruparAlbaranes.size();
			util.createProgressDialog(util.translate("scripts", "Generando facturas"), totalProv);
			util.setProgress(1);
			var j:Number = 0;
			
			var curAlbaran:FLSqlCursor = new FLSqlCursor("albaranesprov");
			var whereFactura:String;
			var datosAgrupacion:Array = [];
			while (qryAgruparAlbaranes.next()) {
				codProveedor = qryAgruparAlbaranes.value(0);
				codAlmacen = qryAgruparAlbaranes.value(1);
				whereFactura = where;
				if(codProveedor && codProveedor != "")
					whereFactura += " AND codproveedor = '" + codProveedor + "'";
				if(codAlmacen && codAlmacen != "")
				 	whereFactura += " AND codalmacen = '" + codAlmacen + "'";

				curAlbaran.transaction(false);
				try {
					curAlbaran.select(whereFactura);
					if (!curAlbaran.first()) {
						curAlbaran.rollback();
						util.destroyProgressDialog();
						return;
					}

					datosAgrupacion = this.iface.dameDatosAgrupacionAlbaranes(curAgruparAlbaranes);
					if (formalbaranesprov.iface.pub_generarFactura(whereFactura, curAlbaran, datosAgrupacion)) {
						curAlbaran.commit();
					} else {
						MessageBox.warning(util.translate("scripts", "Falló la inserción de la factura correspondiente al cliente: ") + codProveedor, MessageBox.Ok, MessageBox.NoButton);
						curAlbaran.rollback();
						util.destroyProgressDialog();
						return;
					}
				} catch (e) {
					curAlbaran.rollback();
					MessageBox.critical(util.translate("scripts", "Error al generar la factura:") + e, MessageBox.Ok, MessageBox.NoButton);
				}
				util.setProgress(++j);
			}
			util.setProgress(totalProv);
			util.destroyProgressDialog();
		}

		f.close();
		this.iface.tdbRecords.refresh();
	}
}
/** \D
Construye un array con los datos de la factura a generar especificados en el formulario de agrupación de remitos
@param curAgruparAlbaranes: Cursor de la tabla agruparalbaranesprov que contiene los valores
@return Array
\end */
function oficial_dameDatosAgrupacionAlbaranes(curAgruparAlbaranes:FLSqlCursor):Array
{
	var res:Array = [];
	res["fecha"] = curAgruparAlbaranes.valueBuffer("fecha");
	res["hora"] = curAgruparAlbaranes.valueBuffer("hora");
	res["codejercicio"] = curAgruparAlbaranes.valueBuffer("codejercicio");
	res["codperiodo"] = curAgruparAlbaranes.valueBuffer("codperiodo");

	return res;
}

/** \D
Construye la sentencia WHERE de la consulta que buscará los remitos a agrupar
@param curAgrupar: Cursor de la tabla agruparalbaranescli que contiene los valores de los criterios de búsqueda
@return Sentencia where
\end */
function oficial_whereAgrupacion(curAgrupar:FLSqlCursor):String
{
		var codProveedor:String = curAgrupar.valueBuffer("codproveedor");
		var nombre:String = curAgrupar.valueBuffer("nombre");
		var cifNif:String = curAgrupar.valueBuffer("cifnif");
		var codAlmacen:String = curAgrupar.valueBuffer("codalmacen");
		var codPago:String = curAgrupar.valueBuffer("codpago");
		var codDivisa:String = curAgrupar.valueBuffer("coddivisa");
		var codSerie:String = curAgrupar.valueBuffer("codserie");
		var fechaDesde:String = curAgrupar.valueBuffer("fechadesde");
		var fechaHasta:String = curAgrupar.valueBuffer("fechahasta");
		var where:String = "albaranesprov.ptefactura = 'true'";
		if (codProveedor && !codProveedor.isEmpty())
				where += " AND albaranesprov.codproveedor = '" + codProveedor + "'";
		if (cifNif && !cifNif.isEmpty())
				where += " AND albaranesprov.cifnif = '" + cifNif + "'";
		if (codAlmacen && !codAlmacen.isEmpty())
				where = where + " AND albaranesprov.codalmacen = '" + codAlmacen + "'";
		where = where + " AND albaranesprov.fecha >= '" + fechaDesde + "'";
		where = where + " AND albaranesprov.fecha <= '" + fechaHasta + "'";
		if (codPago && !codPago.isEmpty())
				where = where + " AND albaranesprov.codpago = '" + codPago + "'";
		if (codDivisa && !codDivisa.isEmpty())
				where = where + " AND albaranesprov.coddivisa = '" + codDivisa + "'";
		if (codSerie && !codSerie.isEmpty())
				where = where + " AND codserie = '" + codSerie + "'";

		return where;
}

function oficial_sinIVA(cursor:FLSqlCursor):Boolean
{
	return !flfacturac.iface.pub_tieneIvaDocProveedor(cursor.valueBuffer("codserie"), cursor.valueBuffer("codproveedor"));
}

function oficial_copiarFactura_clicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	
	cursor.transaction(false);
	try {
		if (this.iface.copiarFactura(cursor))
			cursor.commit();
		else
			cursor.rollback();
	}
	catch (e) {
		cursor.rollback();
		MessageBox.critical(util.translate("scripts", "Hubo un error en la copia de la factura:") + "\n" + e, MessageBox.Ok, MessageBox.NoButton);
	}
	
	this.iface.tdbRecords.refresh();
}

function oficial_copiarFactura(curFactura:FLSqlCursor):Number
{
	var util:FLUtil = new FLUtil();
	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Copiando factura..." ), 9 );
	
	if (!this.iface.curFactura)
		this.iface.curFactura = new FLSqlCursor("facturasprov");

	util.setProgress( ++paso );
	
	this.iface.curFactura.setModeAccess(this.iface.curFactura.Insert);
	this.iface.curFactura.refreshBuffer();
	
	util.setProgress( ++paso );
	
	if (!this.iface.copiadatosFactura(curFactura)) {
		util.destroyProgressDialog();
		return false;
	}
	
	util.setProgress( ++paso );
	
	if (!this.iface.curFactura.commitBuffer()) {
		util.destroyProgressDialog();
		return false;
	}
	
	util.setProgress( ++paso );
	
	var idFactura:Number = this.iface.curFactura.valueBuffer("idfactura");

	if (!this.iface.copiaLineasFactura(curFactura.valueBuffer("idfactura"), idFactura)) {
		util.destroyProgressDialog(); 
		return false;
	}
	
	util.setProgress( ++paso );
	
	// Copia los pies de factura
	if (!this.iface.copiaPiesFactura(curFactura.valueBuffer("idfactura"), idFactura)) {
		util.destroyProgressDialog();
		return false;
	}

	util.setProgress( ++paso );
	
	this.iface.curFactura.select("idfactura = " + idFactura);
	if (this.iface.curFactura.first()) {
		this.iface.curFactura.setModeAccess(this.iface.curFactura.Edit);
		this.iface.curFactura.refreshBuffer();
	
		util.setProgress( ++paso );
		
		if (!this.iface.totalesFactura()) {
			util.destroyProgressDialog();
			return false;
		}
		
		util.setProgress( ++paso );
		
		if (this.iface.curFactura.commitBuffer() == false) {
			util.destroyProgressDialog();
			return false;
		}
		
		util.setProgress( ++paso );
	}
	
	util.destroyProgressDialog();
	
	return idFactura;
}

function oficial_copiadatosFactura(curFactura:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	var fecha:String;
	var hora:String;
	var codEjercicio:String;
	if (curFactura.action() == "facturasprov") {
		codEjercicio = flfactppal.iface.pub_ejercicioActual();
		var hoy:Date = new Date();
		fecha = hoy.toString();
		hora = hoy.toString().right(8);
	} else {
		codEjercicio = curFactura.valueBuffer("codejercicio");
		fecha = curFactura.valueBuffer("fecha");
		hora = curFactura.valueBuffer("hora");
	}
	
	var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(fecha, codEjercicio, "facturasprov");
	if (!datosDoc.ok)
		return false;
	if (datosDoc.modificaciones == true) {
		codEjercicio = datosDoc.codEjercicio;
		fecha = datosDoc.fecha;
	}
	
	with (this.iface.curFactura) {
		setValueBuffer("codserie", curFactura.valueBuffer("codserie"));
		setValueBuffer("codejercicio", codEjercicio);
		setValueBuffer("fecha", fecha);
		setValueBuffer("hora", hora);
		setValueBuffer("codalmacen", curFactura.valueBuffer("codalmacen"));
		setValueBuffer("codpago", curFactura.valueBuffer("codpago"));
		setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
		setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
		setValueBuffer("codproveedor", curFactura.valueBuffer("codproveedor"));
		setValueBuffer("cifnif", curFactura.valueBuffer("cifnif"));
		setValueBuffer("nombre", curFactura.valueBuffer("nombre"));
		setValueBuffer("numproveedor", curFactura.valueBuffer("numproveedor"));
		setValueBuffer("automatica", false);
		setValueBuffer("observaciones", curFactura.valueBuffer("observaciones"));
		setValueBuffer("nogenerarasiento", curFactura.valueBuffer("nogenerarasiento"));
		setNull("idasiento");
		setValueBuffer("decredito", curFactura.valueBuffer("decredito"));
		setValueBuffer("dedebito", curFactura.valueBuffer("dedebito"));
		setValueBuffer("idfacturarect", curFactura.valueBuffer("idfacturarect"));
		setValueBuffer("codigorect", curFactura.valueBuffer("codigorect"));
		if (curFactura.valueBuffer("idpagodevol") != 0)
			setValueBuffer("idpagodevol", curFactura.valueBuffer("idpagodevol"));
	}
	return true;
}

function oficial_copiaLineasFactura(idFacturaOrigen:Number, idFacturaDestino:Number):Boolean
{
	var curLineaFactura:FLSqlCursor = new FLSqlCursor("lineasfacturasprov");
	curLineaFactura.select("idfactura = " + idFacturaOrigen);
	
	while (curLineaFactura.next()) {
		curLineaFactura.setModeAccess(curLineaFactura.Browse);
		if (!this.iface.copiaLineaFactura(curLineaFactura, idFacturaDestino))
			return false;
	}
	return true;
}

function oficial_copiaLineaFactura(curLineaFactura:FLSqlCursor, idFactura:Number):Number
{
	if (!this.iface.curLineaFactura)
		this.iface.curLineaFactura = new FLSqlCursor("lineasfacturasprov");
	
	with (this.iface.curLineaFactura) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idfactura", idFactura);
	}
	
	if (!this.iface.copiadatosLineaFactura(curLineaFactura))
		return false;
		
	if (!this.iface.curLineaFactura.commitBuffer())
			return false;
	
	return this.iface.curLineaFactura.valueBuffer("idlinea");
}

function oficial_copiadatosLineaFactura(curLineaFactura:FLSqlCursor):Boolean
{
	with (this.iface.curLineaFactura) {
		setValueBuffer("referencia", curLineaFactura.valueBuffer("referencia"));
		setValueBuffer("descripcion", curLineaFactura.valueBuffer("descripcion"));
		setValueBuffer("pvpunitario", curLineaFactura.valueBuffer("pvpunitario"));
		setValueBuffer("pvpsindto", curLineaFactura.valueBuffer("pvpsindto"));
		setValueBuffer("cantidad", curLineaFactura.valueBuffer("cantidad"));
		setValueBuffer("pvptotal", curLineaFactura.valueBuffer("pvptotal"));
		setValueBuffer("codimpuesto", curLineaFactura.valueBuffer("codimpuesto"));
		setValueBuffer("iva", curLineaFactura.valueBuffer("iva"));
		setValueBuffer("dtolineal", curLineaFactura.valueBuffer("dtolineal"));
		setValueBuffer("dtopor", curLineaFactura.valueBuffer("dtopor"));
	}
	return true;
}


function oficial_totalesFactura():Boolean
{
	with (this.iface.curFactura) {
		setValueBuffer("neto", formfacturasprov.iface.pub_commonCalculateField("neto", this));
		setValueBuffer("totaliva", formfacturasprov.iface.pub_commonCalculateField("totaliva", this));
		setValueBuffer("total", formfacturasprov.iface.pub_commonCalculateField("total", this));
		setValueBuffer("totaleuros", formfacturasprov.iface.pub_commonCalculateField("totaleuros", this));
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

	var mostrarDias:Number = flfactppal.iface.pub_valorDefectoEmpresa("filtrofacturasprov");
	if (!mostrarDias || isNaN(mostrarDias) || mostrarDias == 0)
		mostrarDias = 1;
	mostrarDias = (mostrarDias * -1 ) + 1;

	var util:FLUtil = new FLUtil;
	var d = new Date();
	this.iface.fechaDesde.date = new Date( util.addDays(d.toString().left(10), mostrarDias) );
	this.iface.fechaHasta.date = new Date();

	connect(this.iface.fechaDesde, "valueChanged(const QDate&)", this, "iface.actualizarFiltro");
	connect(this.iface.fechaHasta, "valueChanged(const QDate&)", this, "iface.actualizarFiltro");

	this.iface.actualizarFiltro();
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

function totalesIva_copiadatosLineaFactura(curLineaFactura:FLSqlCursor):Boolean
{
	if(!this.iface.__copiadatosLineaFactura(curLineaFactura))
		return false;

	with (this.iface.curLineaFactura) {
		setValueBuffer("totalconiva", curLineaFactura.valueBuffer("totalconiva"));
	}
	return true;
}

//// TOTALES CON IVA ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition impresiones */
/////////////////////////////////////////////////////////////////
//// IMPRESIONES ////////////////////////////////////////////////

function impresiones_init()
{
	this.iface.__init();

	this.iface.tbnImprimir = this.child("toolButtonPrint");

	connect(this.iface.tbnImprimir, "clicked()", this, "iface.imprimir");
}

function impresiones_imprimir(codFactura:String)
{
	if (sys.isLoadedModule("flfactinfo")) {
		var util:FLUtil = new FLUtil;
		var codigo:String;
		var idFactura:Number;
		if (codFactura) {
			codigo = codFactura;
			idFactura = util.sqlSelect("facturasprov", "idfactura", "codigo = '" + codFactura + "'");
		}
		else {
			if (!this.cursor().isValid())
				return;
			codigo = this.cursor().valueBuffer("codigo");
			idFactura = this.cursor().valueBuffer("idfactura");
		}

		var dialog:Dialog = new Dialog(util.translate ( "scripts", "Imprimir Factura" ), 0, "imprimir");

		dialog.OKButtonText = util.translate ( "scripts", "Aceptar" );
		dialog.cancelButtonText = util.translate ( "scripts", "Cancelar" );

		var text:Object = new Label;
		text.text = util.translate("scripts","Factura: ") + codigo;
		dialog.add(text);

		var bgroup:GroupBox = new GroupBox;
		bgroup.title = util.translate("scripts", "Opciones");
		dialog.add( bgroup );

		var impNormal:RadioButton = new RadioButton;
		impNormal.text = util.translate ( "scripts", "Imprimir normalmente" );
		impNormal.checked = true;
		bgroup.add( impNormal );

		var impComponentes:RadioButton = new RadioButton;
		impComponentes.text = util.translate ( "scripts", "Imprimir artículos con sus componentes" );
		impComponentes.checked = false;
		bgroup.add( impComponentes );

		var impNumSerie:RadioButton = new RadioButton;
		impNumSerie.text = util.translate ( "scripts", "Imprimir números de serie" );
		impNumSerie.checked = false;
		bgroup.add( impNumSerie );

		if ( !dialog.exec() )
			return true;

		var nombreInforme:String;

		if ( impNormal.checked == true ) {
			nombreInforme = "i_facturasprov";
		}
		else if ( impComponentes.checked == true ) {
			nombreInforme = "i_facturasprovcomp";
			flfactinfo.iface.pub_crearTabla("FP", idFactura);
		}
		else if ( impNumSerie.checked == true ) {
			nombreInforme = "i_facturasprov_ns";
		}

		var curImprimir:FLSqlCursor = new FLSqlCursor("i_facturasprov");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_facturasprov_codigo", codigo);
		curImprimir.setValueBuffer("h_facturasprov_codigo", codigo);

		flfactinfo.iface.pub_lanzarInforme(curImprimir, nombreInforme, "", "", false, false, "", nombreInforme);
	} else
		flfactppal.iface.pub_msgNoDisponible("Informes");
}

//// IMPRESIONES ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ordenCampos */
/////////////////////////////////////////////////////////////////
//// ORDEN_CAMPOS ///////////////////////////////////////////////

function ordenCampos_init()
{
	this.iface.__init();

	var orden:Array = [ "codigo", "tipoventa", "editable", "numproveedor", "nombre", "neto", "totaliva", "totalpie", "total", "coddivisa", "tasaconv", "totaleuros", "fecha", "hora", "codserie", "numero", "codejercicio", "codperiodo", "codalmacen", "codpago", "codproveedor", "cifnif", "automatica", "rectificada", "decredito", "dedebito", "codigorect", "idusuario", "observaciones" ];

	this.iface.tdbRecords.setOrderCols(orden);
	this.iface.tdbRecords.setFocus();
}

//// ORDEN_CAMPOS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition tipoVenta */
//////////////////////////////////////////////////////////////////
//// TIPO VENTA //////////////////////////////////////////////////

function tipoVenta_copiadatosFactura(curFactura:FLSqlCursor):Boolean
{
	if (!this.iface.__copiadatosFactura(curFactura))
		return false;

	with (this.iface.curFactura) {
		setValueBuffer("tipoventa", curFactura.valueBuffer("tipoventa"));
	}
	return true;
}

//// TIPO VENTA //////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition pieDocumento */
//////////////////////////////////////////////////////////////////
//// PIE DE DOCUMENTO ////////////////////////////////////////////

function pieDocumento_commonCalculateField(fN:String, cursor:FLSqlCursor):String
{
	var util:FLUtil = new FLUtil();
	var valor:String;
	switch (fN) {
		case "totalpie": {
			var totalLineas:Number = parseFloat(util.sqlSelect("piefacturasprov", "SUM(totalinc)", "idfactura = " + cursor.valueBuffer("idfactura") + " AND incluidoneto = false"));
			if (!totalLineas || isNaN(totalLineas))
				totalLineas = 0;
			valor = totalLineas;
			break;
		}
		case "total": {
			var totalPie:Number = parseFloat(cursor.valueBuffer("totalpie"));
			valor = this.iface.__commonCalculateField(fN, cursor);
			valor += totalPie;
			valor = parseFloat(util.roundFieldValue(valor, "facturasprov", "total"));
			break;
		}
		case "neto": {
			var netoPie:Number = parseFloat(util.sqlSelect("piefacturasprov", "SUM(totalinc)", "idfactura = " + cursor.valueBuffer("idfactura") + " AND incluidoneto = true"));
			valor = this.iface.__commonCalculateField(fN, cursor);
			valor += netoPie;
			valor = parseFloat(util.roundFieldValue(valor, "facturasprov", "neto"));
			break;
		}
		case "totaliva": {
			if (this.iface.sinIVA(cursor))
				valor = 0;
			else {
				var ivaPie:Number = parseFloat(util.sqlSelect("piefacturasprov", "SUM(totaliva)", "idfactura = " + cursor.valueBuffer("idfactura") + " AND incluidoneto = true"));
				valor = this.iface.__commonCalculateField(fN, cursor);
				valor += ivaPie;
			}
			valor = parseFloat(util.roundFieldValue(valor, "facturasprov", "totaliva"));
			break;
		}
		default:{
			valor = this.iface.__commonCalculateField(fN, cursor);
			break;
		}
	}
	return valor;
}

function pieDocumento_copiaPiesFactura(idFacturaOrigen:Number, idFacturaDestino:Number):Boolean
{
	var curPieFactura:FLSqlCursor = new FLSqlCursor("piefacturasprov");
	curPieFactura.select("idfactura = " + idFacturaOrigen);
	
	while (curPieFactura.next()) {
		curPieFactura.setModeAccess(curPieFactura.Browse);
		if (!this.iface.copiaPieFactura(curPieFactura, idFacturaDestino))
			return false;
	}
	return true;
}

function pieDocumento_copiaPieFactura(curPieFactura:FLSqlCursor, idFactura:Number):Number
{
	if (!this.iface.curPieFactura)
		this.iface.curPieFactura = new FLSqlCursor("piefacturasprov");
	
	with (this.iface.curPieFactura) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idfactura", idFactura);
	}
	
	if (!this.iface.datosPieFactura(curPieFactura))
		return false;
		
	if (!this.iface.curPieFactura.commitBuffer())
		return false;
	
	return this.iface.curPieFactura.valueBuffer("idpie");
}

function pieDocumento_datosPieFactura(curPieFactura:FLSqlCursor):Boolean
{
	with (this.iface.curPieFactura) {
		setValueBuffer("codpie", curPieFactura.valueBuffer("codpie"));
		setValueBuffer("descripcion", curPieFactura.valueBuffer("descripcion"));
		setValueBuffer("baseimponible", curPieFactura.valueBuffer("baseimponible"));
		setValueBuffer("incporcentual", curPieFactura.valueBuffer("incporcentual"));
		setValueBuffer("inclineal", curPieFactura.valueBuffer("inclineal"));
		setValueBuffer("totalinc", curPieFactura.valueBuffer("totalinc"));
		setValueBuffer("incluidoneto", curPieFactura.valueBuffer("incluidoneto"));
		setValueBuffer("totaliva", curPieFactura.valueBuffer("totaliva"));
		setValueBuffer("totallinea", curPieFactura.valueBuffer("totallinea"));
	}
	return true;
}

function pieDocumento_copiadatosFactura(curFactura:FLSqlCursor):Boolean
{
	if (!this.iface.__copiadatosFactura(curFactura))
		return false;

	with (this.iface.curFactura) {
		setValueBuffer("totalpie", curFactura.valueBuffer("totalpie"));
	}
	return true;
}

//// PIE DE DOCUMENTO ////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition periodosFiscales */
//////////////////////////////////////////////////////////////////
//// PERIODOS FISCALES ///////////////////////////////////////////

function periodosFiscales_copiadatosFactura(curFactura:FLSqlCursor):Boolean
{
	if (!this.iface.__copiadatosFactura(curFactura))
		return false;

	var util:FLUtil = new FLUtil();

	var fecha:String = this.iface.curFactura.valueBuffer("fecha");
	var codEjercicio:String = this.iface.curFactura.valueBuffer("codejercicio");
	var codPeriodo:String = util.sqlSelect("periodos", "codperiodo", "fechainicio <= '" + fecha + "' AND fechafin >= '" + fecha + "' AND codejercicio = '" + codPeriodo + "'");

	if (!codPeriodo) {
		MessageBox.warning(util.translate("scripts", "No hay abierto un período fiscal para esta fecha"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	var estado:String = util.sqlSelect("periodos", "estado", "codperiodo = '" + codPeriodo + "'");
	if (estado == "CERRADO") {
		MessageBox.warning(util.translate("scripts", "El período fiscal para esta fecha ya está cerrado"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	with (this.iface.curFactura) {
		setValueBuffer("codperiodo", codPeriodo);
	}
	return true;
}

//// PERIODOS FISCALES ///////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////