/***************************************************************************
                 masterfacturascli.qs  -  description
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
	function calculateField(fN:String):String {this.ctx.interna_calculateField(fN); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var pbnAFactura:Object;
	var tdbRecords:FLTableDB;
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
	var tbnImprimirQuick:Object;

    function impresiones( context ) { totalesIva ( context ); }
	function init() { this.ctx.impresiones_init(); }
	function imprimir(codFactura:String) {
		return this.ctx.impresiones_imprimir(codFactura);
	}
	function imprimirQuick(codFactura:String, impresora:String) {
		return this.ctx.impresiones_imprimirQuick(codFactura, impresora);
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
	function pub_whereAgrupacion(curAgrupar:FLSqlCursor):String {
		return this.whereAgrupacion(curAgrupar);
	}
	function pub_commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.commonCalculateField(fN, cursor);
	}
	function pub_imprimir(codFactura:String):String {
		return this.imprimir(codFactura);
	}
	function pub_imprimirQuick(codFactura:String, impresora:String) {
		return this.imprimirQuick(codFactura, impresora);
	}
	function pub_sinIVA(cursor:FLSqlCursor):Boolean {
		return this.sinIVA(cursor);
	}
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
/** \C
Este es el formulario maestro de facturas a cliente.
\end */
function interna_init()
{
	this.iface.pbnAFactura = this.child("pbnAsociarAFactura");
	this.iface.tdbRecords= this.child("tableDBRecords");

	connect(this.iface.pbnAFactura, "clicked()", this, "iface.asociarAFactura()");
	connect(this.child("toolButtonCopy"), "clicked()", this, "iface.copiarFactura_clicked()");
}

function interna_calculateField(fN:String):String
{
	return this.iface.commonCalculateField(fN, this.cursor());
	/** \C
	El --c�digo-- se construye como la concatenaci�n de --codserie--, --codejercicio-- y --numero--
	\end */
	/** \C
	El --total-- es el --neto-- m�s el --totaliva--
	\end */
	/** \C
	El --totaleuros-- es el producto del --total-- por la --tasaconv--
	\end */
	/** \C
	El --neto-- es la suma del pvp total de las l�neas de factura
	\end */
	/** \C
	El --totaliva-- es la suma del iva correspondiente a las l�neas de factura
	\end */
	/** \C
	El --coddir-- corresponde a la direcci�n del cliente marcada como direcci�n de facturaci�n
	\end */
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_commonCalculateField(fN:String, cursor:FLSqlCursor):String
{
	var util:FLUtil = new FLUtil();
	var valor:String;

	if (fN == "codigo")
		valor = flfacturac.iface.pub_construirCodigo(cursor.valueBuffer("codserie"), cursor.valueBuffer("codejercicio"), cursor.valueBuffer("numero"));

	switch (fN) {
		case "total": {
			var neto:Number = parseFloat(cursor.valueBuffer("neto"));
			var totalIva:Number = parseFloat(cursor.valueBuffer("totaliva"));
			valor = neto + totalIva;
			valor = parseFloat(util.roundFieldValue(valor, "facturascli", "total"));
			break;
		}
		case "comision": {
			valor = util.sqlSelect("lineasfacturascli", "SUM((porcomision*pvptotal)/100)", "idfactura = " + cursor.valueBuffer("idfactura"));
			valor = parseFloat(util.roundFieldValue(valor, "facturascli", "comision"));
			break;
		}
		case "totaleuros": {
			var total:Number = parseFloat(cursor.valueBuffer("total"));
			var tasaConv:Number = parseFloat(cursor.valueBuffer("tasaconv"));
			valor = total * tasaConv;
			valor = parseFloat(util.roundFieldValue(valor, "facturascli", "totaleuros"));
			valor = parseFloat(util.roundFieldValue(valor, "facturascli", "totaleuros"));
			break;
		}
		case "neto": {
			valor = util.sqlSelect("lineasfacturascli", "SUM(pvptotal)", "idfactura = " + cursor.valueBuffer("idfactura"));
			valor = parseFloat(util.roundFieldValue(valor, "facturascli", "neto"));
			break;
		}
		case "totaliva": {
			if (this.iface.sinIVA(cursor))
				valor = 0;
			else {
				valor = util.sqlSelect("lineasfacturascli", "SUM((pvptotal * iva) / 100)", "idfactura = " + cursor.valueBuffer("idfactura"));
				valor = parseFloat(util.roundFieldValue(valor, "facturascli", "totaliva"));
			}
			break;
		}
		case "coddir": {
			valor = util.sqlSelect("dirclientes", "id", "codcliente = '" + cursor.valueBuffer("codcliente") +  "' AND domfacturacion = 'true'");
			if (!valor) {
				valor = "";
			}
			break;
		}
		case "provincia": {
			valor = util.sqlSelect("dirclientes", "provincia", "id = " + cursor.valueBuffer("coddir"));
			if (!valor)
				valor = cursor.valueBuffer("provincia");
			break;
		}
		case "codpais": {
			valor = util.sqlSelect("dirclientes", "codpais", "id = " + cursor.valueBuffer("coddir"));
			if (!valor)
				valor = cursor.valueBuffer("codpais");
			break;
		}
		case "codtarifa": {
			valor = util.sqlSelect("clientes c INNER JOIN gruposclientes gc ON c.codgrupo = gc.codgrupo", "gc.codtarifa", "codcliente = '" + cursor.valueBuffer("codcliente") + "'", "clientes,gruposclientes");
			if (!valor)
				valor = "";
			break;
		}
	}
	return valor;
}

/** \C
Al pulsar el bot�n de asociar a factura se abre la ventana de agrupar remitos de cliente
\end */
function oficial_asociarAFactura()
{debug("oficial_asociarAFactura");
	var util:FLUtil = new FLUtil;
	var f:Object = new FLFormSearchDB("agruparalbaranescli");
	var cursor:FLSqlCursor = f.cursor();
	var where:String;
	var codCliente:String;
	var codAlmacen:String;

	cursor.setActivatedCheckIntegrity(false);
	cursor.select();
	if (!cursor.first())
		cursor.setModeAccess(cursor.Insert);
	else
		cursor.setModeAccess(cursor.Edit);

	f.setMainWidget();
	cursor.refreshBuffer();
	var acpt:String = f.exec("id");
debug("acpt " + acpt);
	if (acpt) {
		cursor.commitBuffer();
		var curAgruparAlbaranes:FLSqlCursor = new FLSqlCursor("agruparalbaranescli");
		curAgruparAlbaranes.select();
		if (curAgruparAlbaranes.first()) {
			where = this.iface.whereAgrupacion(curAgruparAlbaranes);
			var excepciones:String = curAgruparAlbaranes.valueBuffer("excepciones");
			if (!excepciones.isEmpty())
				where += " AND idalbaran NOT IN (" + excepciones + ")";

			var qryAgruparAlbaranes:FLSqlCursor = new FLSqlQuery;
			qryAgruparAlbaranes.setTablesList("albaranescli");
			qryAgruparAlbaranes.setSelect("codcliente,codalmacen");
			qryAgruparAlbaranes.setFrom("albaranescli");
			qryAgruparAlbaranes.setWhere(where + " GROUP BY codcliente,codalmacen");

			if (!qryAgruparAlbaranes.exec())
				return;
debug(qryAgruparAlbaranes.sql());
			var totalClientes:Number = qryAgruparAlbaranes.size();
			util.createProgressDialog(util.translate("scripts", "Generando facturas"), totalClientes);
			util.setProgress(1);
			var j:Number = 0;
			
			var curAlbaran:FLSqlCursor = new FLSqlCursor("albaranescli");
			var whereFactura:String;
			var datosAgrupacion:Array = [];
			while (qryAgruparAlbaranes.next()) {
				codCliente = qryAgruparAlbaranes.value(0);
				codAlmacen = qryAgruparAlbaranes.value(1);
				whereFactura = where;
				if(codCliente && codCliente != "")
					 whereFactura += " AND codcliente = '" + codCliente + "'";
				if(codAlmacen && codAlmacen != "")
					whereFactura += " AND codalmacen = '" + codAlmacen + "'";
debug("whereFactura " + whereFactura);
				curAlbaran.transaction(false);
				try {
					curAlbaran.select(whereFactura);
					if (!curAlbaran.first()) {
						curAlbaran.rollback();
						util.destroyProgressDialog();debug("return 1");
						return;
					}
					
					datosAgrupacion = this.iface.dameDatosAgrupacionAlbaranes(curAgruparAlbaranes);
					if (formalbaranescli.iface.pub_generarFactura(whereFactura, curAlbaran, datosAgrupacion)) {
						curAlbaran.commit();
					} else {
						MessageBox.warning(util.translate("scripts", "Fall� la inserci�n de la factura correspondiente al cliente: ") + codCliente, MessageBox.Ok, MessageBox.NoButton);
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
			util.setProgress(totalClientes);
			util.destroyProgressDialog();
		}

		f.close();
		this.iface.tdbRecords.refresh();
	}debug("FIN");
}

/** \D
Construye un array con los datos de la factura a generar especificados en el formulario de agrupaci�n de remitos
@param curAgruparAlbaranes: Cursor de la tabla agruparalbaranescli que contiene los valores
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
Construye la sentencia WHERE de la consulta que buscar� los remitos a agrupar
@param curAgrupar: Cursor de la tabla agruparalbaranescli que contiene los valores de los criterios de b�squeda
@return Sentencia where
\end */
function oficial_whereAgrupacion(curAgrupar:FLSqlCursor):String
{
	var codCliente:String = curAgrupar.valueBuffer("codcliente");
	var nombreCliente:String = curAgrupar.valueBuffer("nombrecliente");
	var cifNif:String = curAgrupar.valueBuffer("cifnif");
	var codAlmacen:String = curAgrupar.valueBuffer("codalmacen");
	var codPago:String = curAgrupar.valueBuffer("codpago");
	var codAgente:String = curAgrupar.valueBuffer("codagente");
	var codDivisa:String = curAgrupar.valueBuffer("coddivisa");
	var codSerie:String = curAgrupar.valueBuffer("codserie");
	var fechaDesde:String = curAgrupar.valueBuffer("fechadesde");
	var fechaHasta:String = curAgrupar.valueBuffer("fechahasta");
	var where:String = "albaranescli.ptefactura = 'true'";
	if (codCliente && !codCliente.isEmpty())
		where += " AND albaranescli.codcliente = '" + codCliente + "'";
	if (cifNif && !cifNif.isEmpty())
		where += " AND albaranescli.cifnif = '" + cifNif + "'";
	if (codAlmacen && !codAlmacen.isEmpty())
		where = where + " AND albaranescli.codalmacen = '" + codAlmacen + "'";
	where = where + " AND albaranescli.fecha >= '" + fechaDesde + "'";
	where = where + " AND albaranescli.fecha <= '" + fechaHasta + "'";
	if (codPago && !codPago.isEmpty())
		where = where + " AND albaranescli.codpago = '" + codPago + "'";
	if (codAgente && !codAgente.isEmpty())
		where = where + " AND albaranescli.codagente = '" + codAgente + "'";
	if (codDivisa && !codDivisa.isEmpty())
		where = where + " AND albaranescli.coddivisa = '" + codDivisa + "'";
	if (codSerie && !codSerie.isEmpty())
		where = where + " AND codserie = '" + codSerie + "'";

	return where;
}

function oficial_sinIVA(cursor:FLSqlCursor):Boolean
{
	return !flfacturac.iface.pub_tieneIvaDocCliente(cursor.valueBuffer("codserie"), cursor.valueBuffer("codcliente"));
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
		this.iface.curFactura = new FLSqlCursor("facturascli");

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
	if (curFactura.action() == "facturascli") {
		codEjercicio = flfactppal.iface.pub_ejercicioActual();
		var hoy:Date = new Date();
		fecha = hoy.toString();
		hora = hoy.toString().right(8);
	} else {
		codEjercicio = curFactura.valueBuffer("codejercicio");
		fecha = curFactura.valueBuffer("fecha");
		hora = curFactura.valueBuffer("hora");
	}
	
	var datosDoc:Array = flfacturac.iface.pub_datosDocFacturacion(fecha, codEjercicio, "facturascli");
	if (!datosDoc.ok)
		return false;
	if (datosDoc.modificaciones == true) {
		codEjercicio = datosDoc.codEjercicio;
		fecha = datosDoc.fecha;
	}
	
	var codDir:Number = util.sqlSelect("dirclientes", "id", "codcliente = '" + curFactura.valueBuffer("codcliente") + "' AND domfacturacion = 'true'");
	with (this.iface.curFactura) {
		setValueBuffer("codserie", curFactura.valueBuffer("codserie"));
		setValueBuffer("codejercicio", codEjercicio);
		setValueBuffer("fecha", fecha);
		setValueBuffer("hora", hora);
		setValueBuffer("codagente", curFactura.valueBuffer("codagente"));
		setValueBuffer("codalmacen", curFactura.valueBuffer("codalmacen"));
		setValueBuffer("codpago", curFactura.valueBuffer("codpago"));
		setValueBuffer("codtarifa", curFactura.valueBuffer("codtarifa"));
		setValueBuffer("coddivisa", curFactura.valueBuffer("coddivisa"));
		setValueBuffer("tasaconv", curFactura.valueBuffer("tasaconv"));
		setValueBuffer("codcliente", curFactura.valueBuffer("codcliente"));
		setValueBuffer("cifnif", curFactura.valueBuffer("cifnif"));
		setValueBuffer("nombrecliente", curFactura.valueBuffer("nombrecliente"));
		if (!codDir) {
			codDir = curFactura.valueBuffer("coddir")
			if (codDir == 0) {
				this.setNull("coddir");
			} else 
				setValueBuffer("coddir", curFactura.valueBuffer("coddir"));
				setValueBuffer("direccion", curFactura.valueBuffer("direccion"));
				setValueBuffer("codpostal", curFactura.valueBuffer("codpostal"));
				setValueBuffer("ciudad", curFactura.valueBuffer("ciudad"));
				setValueBuffer("provincia", curFactura.valueBuffer("provincia"));
				setValueBuffer("apartado", curFactura.valueBuffer("apartado"));
				setValueBuffer("codpais", curFactura.valueBuffer("codpais"));
		} else {
			setValueBuffer("coddir", codDir);
			setValueBuffer("direccion", util.sqlSelect("dirclientes","direccion","id = " + codDir));
			setValueBuffer("codpostal", util.sqlSelect("dirclientes","codpostal","id = " + codDir));
			setValueBuffer("ciudad", util.sqlSelect("dirclientes","ciudad","id = " + codDir));
			setValueBuffer("provincia", util.sqlSelect("dirclientes","provincia","id = " + codDir));
			setValueBuffer("apartado", util.sqlSelect("dirclientes","apartado","id = " + codDir));
			setValueBuffer("codpais", util.sqlSelect("dirclientes","codpais","id = " + codDir));
		}
		setValueBuffer("automatica", false);
		setValueBuffer("observaciones", curFactura.valueBuffer("observaciones"));
		setValueBuffer("editable", true);
		setValueBuffer("nogenerarasiento", curFactura.valueBuffer("nogenerarasiento"));
		setNull("idasiento");
		setValueBuffer("idfacturarect", curFactura.valueBuffer("idfacturarect"));
		setValueBuffer("codigorect", curFactura.valueBuffer("codigorect"));
		setValueBuffer("tpv", false);
		if (curFactura.valueBuffer("idpagodevol") != 0)
			setValueBuffer("idpagodevol", curFactura.valueBuffer("idpagodevol"));
	}
	return true;
}

function oficial_copiaLineasFactura(idFacturaOrigen:Number, idFacturaDestino:Number):Boolean
{
	var curLineaFactura:FLSqlCursor = new FLSqlCursor("lineasfacturascli");
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
		this.iface.curLineaFactura = new FLSqlCursor("lineasfacturascli");
	
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
		setValueBuffer("neto", formfacturascli.iface.pub_commonCalculateField("neto", this));
		setValueBuffer("totaliva", formfacturascli.iface.pub_commonCalculateField("totaliva", this));
		setValueBuffer("total", formfacturascli.iface.pub_commonCalculateField("total", this));
		setValueBuffer("totaleuros", formfacturascli.iface.pub_commonCalculateField("totaleuros", this));
		setValueBuffer("comision", formfacturascli.iface.pub_commonCalculateField("comision", this));
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

	var mostrarDias:Number = flfactppal.iface.pub_valorDefectoEmpresa("filtrofacturascli");
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
	this.iface.tbnImprimirQuick = this.child("tbnPrintQuick");

	connect(this.iface.tbnImprimir, "clicked()", this, "iface.imprimir");
	connect(this.iface.tbnImprimirQuick, "clicked()", this, "iface.imprimirQuick");
}

function impresiones_imprimir(codFactura:String)
{
	if (sys.isLoadedModule("flfactinfo")) {
		var util:FLUtil = new FLUtil();
		var codigo:String;
		var idFactura:Number;
		if (codFactura) {
			codigo = codFactura;
			idFactura = util.sqlSelect("facturascli", "idfactura", "codigo = '" + codFactura + "'");
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

		if ( util.sqlSelect("servicioscli INNER JOIN albaranescli ON servicioscli.idalbaran = albaranescli.idalbaran", "servicioscli.idservicio", "albaranescli.idfactura = " + idFactura, "servicioscli,albaranescli") ) {
			var impServicio:RadioButton = new RadioButton;
			impServicio.text = util.translate ( "scripts", "Imprimir Servicio" );
			impServicio.checked = false;
			bgroup.add( impServicio );
		}

		var impFactura:RadioButton = new RadioButton;
		impFactura.text = util.translate ( "scripts", "Imprimir Factura" );
		impFactura.checked = true;
		bgroup.add( impFactura );

		var impComponentes:CheckBox = new CheckBox;
		impComponentes.text = util.translate ( "scripts", "Imprimir art�culos con sus componentes" );
		impComponentes.checked = flfactppal.iface.pub_valorDefectoEmpresa("imprimircomponentes");
		bgroup.add( impComponentes );

		var impNumSerie:CheckBox = new CheckBox;
		impNumSerie.text = util.translate ( "scripts", "Imprimir n�meros de serie" );
		impNumSerie.checked = flfactppal.iface.pub_valorDefectoEmpresa("imprimirnumserie");
		bgroup.add( impNumSerie );

		if ( !dialog.exec() )
			return true;

		var nombreInforme:String;
		var numCopias:Number = flfactppal.iface.pub_valorDefectoEmpresa("copiasfactura");
		if (!numCopias)
			numCopias = 1;

		if ( impFactura.checked == true) {

			if ( impComponentes.checked == true ) {
				if ( impNumSerie.checked == true ) {
					nombreInforme = "i_facturasclicomp_ns";
					flfactinfo.iface.pub_crearTabla("FC", idFactura);
				} else {
					nombreInforme = "i_facturasclicomp";
					flfactinfo.iface.pub_crearTabla("FC", idFactura);
				}
			} else {
				if ( impNumSerie.checked == true ) {
					nombreInforme = "i_facturascli_ns";
				} else {
					nombreInforme = "i_facturascli";
				}
			}
		}
		else {
			nombreInforme = "i_facturascli_serv";
		}

		var nombreReport:String = nombreInforme;
		if ( util.sqlSelect("facturascli", "claseventa", "codigo = '" + codigo + "'") == "A" )
			nombreReport += "_a";

		var curImprimir:FLSqlCursor = new FLSqlCursor("i_facturascli");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_facturascli_codigo", codigo);
		curImprimir.setValueBuffer("h_facturascli_codigo", codigo);

		flfactinfo.iface.pub_lanzarInforme(curImprimir, nombreInforme, "", "", false, false, "", nombreReport, numCopias);
	} else
		flfactppal.iface.pub_msgNoDisponible("Informes");
}

function impresiones_imprimirQuick(codFactura:String, impresora:String)
{
	if (sys.isLoadedModule("flfactinfo")) {
		var util:FLUtil = new FLUtil();
		var codigo:String;
		var idFactura:Number;
		if (codFactura) {
			codigo = codFactura;
			idFactura = util.sqlSelect("facturascli", "idfactura", "codigo = '" + codFactura + "'");
		}
		else {
			if (!this.cursor().isValid())
				return;
			codigo = this.cursor().valueBuffer("codigo");
			idFactura = this.cursor().valueBuffer("idfactura");
		}

		var impComponentes:Boolean = flfactppal.iface.pub_valorDefectoEmpresa("imprimircomponentes");
		var impNumSerie:Boolean = flfactppal.iface.pub_valorDefectoEmpresa("imprimirnumserie");
		var impDirecta:Boolean = true;

		var nombreInforme:String;
		var numCopias:Number = flfactppal.iface.pub_valorDefectoEmpresa("copiasfactura");
		if (!numCopias)
			numCopias = 1;

		if ( impComponentes == true ) {
			if ( impNumSerie == true ) {
				nombreInforme = "i_facturasclicomp_ns";
				flfactinfo.iface.pub_crearTabla("FC", idFactura);
			} else {
				nombreInforme = "i_facturasclicomp";
				flfactinfo.iface.pub_crearTabla("FC", idFactura);
			}
		} else {
			if ( impNumSerie == true ) {
				nombreInforme = "i_facturascli_ns";
			} else {
				nombreInforme = "i_facturascli";
			}
		}

		var nombreReport:String = nombreInforme;
		if ( util.sqlSelect("facturascli", "claseventa", "codigo = '" + codigo + "'") == "A" )
			nombreReport += "_a";

		var curImprimir:FLSqlCursor = new FLSqlCursor("i_facturascli");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_facturascli_codigo", codigo);
		curImprimir.setValueBuffer("h_facturascli_codigo", codigo);

		flfactinfo.iface.pub_lanzarInforme(curImprimir, nombreInforme, "", "", false, impDirecta, "", nombreReport, numCopias, impresora);
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

	var orden:Array = [ "codigo", "tipoventa", "claseventa", "numero", "editable", "nombrecliente", "total", "neto", "totaliva", "totalpie", "coddivisa", "tasaconv", "totaleuros", "fecha", "hora", "codserie", "codejercicio", "codperiodo", "codalmacen", "codpago", "codtarifa", "codenvio", "codcliente", "cifnif", "direccion", "codpostal", "ciudad", "provincia", "codpais", "codagente", "comision", "tpv", "automatica", "rectificada", "codigorect", "costototal", "ganancia", "utilidad", "idusuario", "observaciones" ];

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
		setValueBuffer("claseventa", curFactura.valueBuffer("claseventa"));
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
			var totalLineas:Number = parseFloat(util.sqlSelect("piefacturascli", "SUM(totalinc)", "idfactura = " + cursor.valueBuffer("idfactura") + " AND incluidoneto = false"));
			if (!totalLineas || isNaN(totalLineas))
				totalLineas = 0;
			valor = totalLineas;
			break;
		}
		case "total": {
			var totalPie:Number = parseFloat(cursor.valueBuffer("totalpie"));
			valor = this.iface.__commonCalculateField(fN, cursor);
			valor += totalPie;
			valor = parseFloat(util.roundFieldValue(valor, "facturascli", "total"));
			break;
		}
		case "neto": {
			var netoPie:Number = parseFloat(util.sqlSelect("piefacturascli", "SUM(totalinc)", "idfactura = " + cursor.valueBuffer("idfactura") + " AND incluidoneto = true"));
			valor = this.iface.__commonCalculateField(fN, cursor);
			valor += netoPie;
			valor = parseFloat(util.roundFieldValue(valor, "facturascli", "neto"));
			break;
		}
		case "totaliva": {
			if (this.iface.sinIVA(cursor))
				valor = 0;
			else {
				var ivaPie:Number = parseFloat(util.sqlSelect("piefacturascli", "SUM(totaliva)", "idfactura = " + cursor.valueBuffer("idfactura") + " AND incluidoneto = true"));
				valor = this.iface.__commonCalculateField(fN, cursor);
				valor += ivaPie;
			}
			valor = parseFloat(util.roundFieldValue(valor, "facturascli", "totaliva"));
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
	var curPieFactura:FLSqlCursor = new FLSqlCursor("piefacturascli");
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
		this.iface.curPieFactura = new FLSqlCursor("piefacturascli");
	
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
	var codPeriodo:String = util.sqlSelect("periodos", "codperiodo", "fechainicio <= '" + fecha + "' AND fechafin >= '" + fecha + "' AND codejercicio = '" + codEjercicio + "'");

	if (!codPeriodo) {
		MessageBox.warning(util.translate("scripts", "No hay abierto un per�odo fiscal para esta fecha"), MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	var estado:String = util.sqlSelect("periodos", "estado", "codperiodo = '" + codPeriodo + "'");
	if (estado == "CERRADO") {
		MessageBox.warning(util.translate("scripts", "El per�odo fiscal para esta fecha ya est� cerrado"), MessageBox.Ok, MessageBox.NoButton);
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