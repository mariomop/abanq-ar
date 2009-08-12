/***************************************************************************
                 se_mastercontratos.qs  -  description
                             -------------------
    begin                : lun jun 20 2005
    copyright            : (C) 2005 by InfoSiAL S.L.
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
////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_declaration interna */
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
class oficial extends interna 
{
	var tableDBRecords;
	var chkVigentes;
	var deFecha;
	
    function oficial( context ) { interna( context ); } 
    function procesarEstado() {
        return this.ctx.oficial_procesarEstado();
    }
    function facturar(codigo:String) { 
    	return this.ctx.oficial_facturar(codigo);
    }
    function facturarContrato() {
    	return this.ctx.oficial_facturarContrato();
    }
    function generarPeriodo(codContrato:String) { 
    	return this.ctx.oficial_generarPeriodo(codContrato);
    }
    function generarFactura(idPeriodo:Number, codCliente:String, codContrato:String, coste:Number):Boolean { 
    	return this.ctx.oficial_generarFactura(idPeriodo, codCliente, codContrato, coste);
    }
	function numMeses(periodo:String):Number { 
		return this.ctx.oficial_numMeses(periodo);
	}
	function actualizarPeriodo(idPeriodo, idFactura) { 
		return this.ctx.oficial_actualizarPeriodo(idPeriodo, idFactura);
	}
	function actualizarContrato(idPeriodo) { 
		return this.ctx.oficial_actualizarContrato(idPeriodo);
	}
	function cambiochkVigentes() {	
		return this.ctx.oficial_cambiochkVigentes();
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration ordenCampos */
/////////////////////////////////////////////////////////////////
//// ORDEN_CAMPOS ///////////////////////////////////////////////
class ordenCampos extends oficial {
    function ordenCampos( context ) { oficial ( context ); }
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
	this.iface.chkVigentes = this.child("chkVigentes");
	this.iface.tableDBRecords = this.child("tableDBRecords");
	connect( this.child("pbnFacturar"), "clicked()", this, "iface.facturar" );
	connect( this.child("pbnFacturarContrato"), "clicked()", this, "iface.facturarContrato" );
	connect(this.iface.chkVigentes, "clicked()", this, "iface.cambiochkVigentes");
	connect(this.iface.tableDBRecords, "currentChanged()", this, "iface.procesarEstado");
	this.iface.chkVigentes.checked = false;

	this.iface.procesarEstado();
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_procesarEstado()
{
	if (this.cursor().isValid()) {
		this.child("pbnFacturar").enabled = true;
		this.child("pbnFacturarContrato").enabled = true;
	} else {
		this.child("pbnFacturar").enabled = false;
		this.child("pbnFacturarContrato").enabled = false;
	}
}

/** \D
Genera los períodos de actualización para el contrato seleccionado
\end */
function oficial_facturarContrato()
{
	if (!this.cursor().isValid()) {
		this.iface.procesarEstado();
		return;
	}

	return this.iface.facturar(this.cursor().valueBuffer("codigo"));
}

/** \D
Genera los períodos de actualización para el mes presente y factura.
Se genera un periodo por cada contrato vigente.
\end */
function oficial_facturar(codigo:String)
{
	var util:FLUtil = new FLUtil();
	
	var res = MessageBox.information(util.translate("scripts", "A continuación se generarán los períodos a fecha actual y las facturas correspondientes.\n\n¿Continuar?"),
			MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
	if (res != MessageBox.Yes)
		return;
	
	var hoy = new Date();
	
	var curTab:FLSqlCursor = new FLSqlCursor("contratos");
	var curPed:FLSqlCursor = new FLSqlCursor("periodoscontratos");
	
	if (codigo)
		curTab.select("estado = 'Vigente' AND codigo = '" + codigo + "'");
	else
		curTab.select("estado = 'Vigente'");
	
	var totalSteps:Number = curTab.size();
	if (!totalSteps) {
		MessageBox.information(util.translate("scripts", "No se encontraron contratos pendientes de facturar"), MessageBox.Ok, MessageBox.NoButton);
		return;
	}
		
	util.createProgressDialog( util.translate( "scripts", "Generando facturación" ), totalSteps);
	var step:Number = 0;
	
	var clientesFacturados:String = "";
	
	while(curTab.next()) {

		codContrato = curTab.valueBuffer("codigo");
		codCliente = curTab.valueBuffer("codcliente");
		
		// Generar período si no existe
		var ultimaFecha = util.sqlSelect("periodoscontratos", "fechafin", "codcontrato ='" + codContrato + "' order by fechafin DESC")
		if (ultimaFecha < hoy)
			this.iface.generarPeriodo(curTab);
		
		// Generar factura si procede de todos los periodos ptes de facturar hasta hoy
		curPed.select("codcontrato ='" + codContrato + "' AND facturado = false AND fechainicio <= '" + hoy + "'");
		while (curPed.next()) {
			this.iface.generarFactura(curPed.valueBuffer("id"), codCliente, codContrato, curTab.valueBuffer("coste"));
			clientesFacturados += "\n- Contrato: " + codContrato + "  |  Cliente: " + util.sqlSelect("clientes", "nombre", "codcliente = '" +  codCliente + "'");
		}
		
		util.setProgress( step );
		step++;
	}
	
	util.destroyProgressDialog();	
	
	if (clientesFacturados)
		mensaje = util.translate("scripts", "Se facturaron los contratos siguientes:\n") + clientesFacturados;
	else
		mensaje = util.translate("scripts", "No se encontraron contratos pendientes de facturar");
	
	MessageBox.information(mensaje, MessageBox.Ok, MessageBox.NoButton);
}


/** \D
Genera el registro correspondiente a un periodo de actualización
@param codContrato Código del contrato al que pertenece el periodo
\end */
function oficial_generarPeriodo(curCon:FLSqlCursor) 
{
	var util:FLUtil = new FLUtil();
	
	var fechaInicio:Date = new Date();
	fechaInicio.setDate(1);
	
	var fechaFin = util.addMonths(fechaInicio, this.iface.numMeses(curCon.valueBuffer("periodopago")) - 1);
	
	var ultimoDia:Number = 31;
	fechaFin.setDate(ultimoDia--);
	while (!fechaFin) {
		fechaFin = fechaFin = util.addMonths(fechaInicio, this.iface.numMeses(curCon.valueBuffer("periodopago")) - 1);
		fechaFin.setDate(ultimoDia--);
	}

	var curPeriodo:FLSqlCursor = new FLSqlCursor("periodoscontratos");
	with(curPeriodo) {
		setModeAccess(Insert);
		refreshBuffer();		
		setValueBuffer("codcontrato", codContrato);
		setValueBuffer("fechainicio", fechaInicio);
		setValueBuffer("fechafin", fechaFin);
		setValueBuffer("facturado", false);
		setValueBuffer("referencia", curCon.valueBuffer("referencia"));
		setValueBuffer("coste", curCon.valueBuffer("coste"));
		setValueBuffer("totalconiva", curCon.valueBuffer("totalconiva"));
		setValueBuffer("codimpuesto", curCon.valueBuffer("codimpuesto"));
		
		if (!commitBuffer()) return;
	}
}


/** \D
Genera la factura correspondiente a un periodo de actualizacion. Si el periodo fue
pagado en una factura anterior por varios meses, busca el id de dicha factura y lo asocia
al periodo

@param idPeriodo Identificador del periodo de actualizacion
@param codCliente Código del cliente al que se factura
@param coste Coste mensual del servicio
\end */
function oficial_generarFactura(idPeriodo:Number, codCliente:String, codContrato:String, coste:Number):Boolean
{
	var util:FLUtil = new FLUtil();
	
	var fecha:String;
	var hora:String;
	var hoy:Date = new Date();
	fecha = hoy.toString();
	hora = hoy.toString().right(8);
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("clientes");
	q.setFrom("clientes");
	q.setSelect("nombre,cifnif,coddivisa,codpago,codserie,codagente");
	q.setWhere("codcliente = '" + codCliente + "'");
	
	if (!q.exec()) return;
	if (!q.first()) {
		MessageBox.warning(util.translate("scripts", "Error al obtener los datos del cliente\nNo se generará la factura de este cliente: ") + codCliente,
			MessageBox.Ok, MessageBox.NoButton);
		return;
	}
	
	var qDir:FLSqlQuery = new FLSqlQuery();
	qDir.setTablesList("dirclientes");
	qDir.setFrom("dirclientes");
	qDir.setSelect("id,direccion,codpostal,ciudad,provincia,codpais");
	qDir.setWhere("codcliente = '" + codCliente + "' and domfacturacion = '" + true + "'");
	
	if (!qDir.exec()) return;
	if (!qDir.first()) {
		MessageBox.warning(util.translate("scripts", "Error al obtener la dirección del cliente\nAsegúrate de que este cliente tiene una dirección de facturación\nNo se generará la factura de este cliente: ") + codCliente,
			MessageBox.Ok, MessageBox.NoButton);
		return;
	}
	
	var curFactura:FLSqlCursor = new FLSqlCursor("facturascli");
	var numeroFactura:Number = flfacturac.iface.pub_siguienteNumero(q.value(4),flfactppal.iface.pub_ejercicioActual(), "nfacturacli");
	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();

	with(curFactura) {
		setModeAccess(Insert);
		refreshBuffer();
		
		setValueBuffer("codigo", flfacturac.iface.pub_construirCodigo(q.value(4), codEjercicio, numeroFactura));
		setValueBuffer("numero", numeroFactura);
		setValueBuffer("recfinanciero", 0);
		
		setValueBuffer("codcliente", codCliente);
		setValueBuffer("nombrecliente", q.value(0));
		setValueBuffer("cifnif", q.value(1));
		
		setValueBuffer("codejercicio", codEjercicio);
		setValueBuffer("coddivisa", q.value(2));
		setValueBuffer("codpago", q.value(3));
		setValueBuffer("codalmacen", flfactppal.iface.pub_valorDefectoEmpresa("codalmacen"));
		setValueBuffer("codserie", q.value(4));
		setValueBuffer("tasaconv", util.sqlSelect("divisas", "tasaconv", "coddivisa = '" + q.value(2) + "'"));
		setValueBuffer("fecha", fecha);
		setValueBuffer("hora", hora);
		
		setValueBuffer("codagente", q.value(5));
		setValueBuffer("porcomision", util.sqlSelect("agentes", "porcomision", "codagente = '" + q.value(5) + "'"));
				
		setValueBuffer("coddir", qDir.value(0));
		setValueBuffer("direccion", qDir.value(1));
		setValueBuffer("codpostal", qDir.value(2));
		setValueBuffer("ciudad", qDir.value(3));
		setValueBuffer("provincia", qDir.value(4));
		setValueBuffer("codpais", qDir.value(5));
	}
	
	if (!curFactura.commitBuffer()) {
		return false;
	}

	
	var datosPeriodo = flfactppal.iface.pub_ejecutarQry("periodoscontratos", "codcontrato,fechainicio,fechafin,referencia,coste,totalconiva,codimpuesto", "id = " + idPeriodo);
	
	var iva:Number = 0;
	var datosImpuesto = flfactppal.iface.pub_ejecutarQry("impuestos", "iva", "codimpuesto = '" + datosPeriodo.codimpuesto + "'");
	if (datosImpuesto.result == 1) {
		iva = datosImpuesto.iva;
	}
	
	var idFactura:Number = curFactura.valueBuffer("idfactura");
	var curLineaFactura:FLSqlCursor = new FLSqlCursor("lineasfacturascli");
	var descripcion = util.sqlSelect("contratos", "descripcion", "codigo = '" + codContrato + "'");
	if (!descripcion)
		descripcion = "";

	with(curLineaFactura) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("idfactura", idFactura);
		setValueBuffer("referencia", datosPeriodo.referencia);
		setValueBuffer("descripcion", descripcion + " / Periodo " + datosPeriodo.fechainicio.toString().left(10) + "-" + datosPeriodo.fechafin.toString().left(10));
		setValueBuffer("pvpunitario", datosPeriodo.coste);
		setValueBuffer("pvpsindto", datosPeriodo.coste);
		setValueBuffer("cantidad", 1);
		setValueBuffer("pvptotal", datosPeriodo.coste);
		setValueBuffer("totalconiva", datosPeriodo.totalconiva);
		setValueBuffer("codimpuesto", datosPeriodo.codimpuesto);
		setValueBuffer("iva", iva);
		setValueBuffer("dtolineal", 0);
		setValueBuffer("dtopor", 0);
	}
	if (!curLineaFactura.commitBuffer())
		return false;
	
	curFactura.select("idfactura = " + idFactura);
	
	if (curFactura.first()) {
		
		if (!formRecordfacturascli.iface.pub_actualizarLineasIva(curFactura))
			return false;
	
		with(curFactura) {
			setModeAccess(Edit);
			refreshBuffer();
			setValueBuffer("neto", formfacturascli.iface.pub_commonCalculateField("neto", curFactura));
			setValueBuffer("totaliva", formfacturascli.iface.pub_commonCalculateField("totaliva", curFactura));
			setValueBuffer("total", formfacturascli.iface.pub_commonCalculateField("total", curFactura));
			setValueBuffer("totaleuros", formfacturascli.iface.pub_commonCalculateField("totaleuros", curFactura));
			setValueBuffer("codigo", formfacturascli.iface.pub_commonCalculateField("codigo", curFactura));
		}
		
		if (!curFactura.commitBuffer())
			return false;
	}
	
	this.iface.actualizarPeriodo(idPeriodo, idFactura);
	this.iface.actualizarContrato(idPeriodo);
	
	return true;
}


/** \D
Una vez realizada la factura, actualiza el periodo de actualización marcándolo
como facturado y registrando el número de factura

@param idPeriodo Identificador del periodo de actualizacion
@param idFactura Identificador de la factura
\end */
function oficial_actualizarPeriodo(idPeriodo, idFactura)
{
	var curPeriodo:FLSqlCursor = new FLSqlCursor("periodoscontratos");
	with(curPeriodo) {
		select("id = "  + idPeriodo);
		first();
		setModeAccess(Edit);
		refreshBuffer();
		setValueBuffer("facturado", true);
		setValueBuffer("idfactura", idFactura);
		commitBuffer();
	}
}

/** \D
Actualiza el contrato al que pertenece el período de actualización con la fecha 
de último pago.
@param idPeriodo Identificador del periodo de actualizacion
\end */
function oficial_actualizarContrato(idPeriodo)
{
	var util:FLUtil = new FLUtil();
	var codContrato:String = util.sqlSelect("periodoscontratos", "codcontrato", "id = " + idPeriodo);
	
	var hoy = new Date();
	var curContrato:FLSqlCursor = new FLSqlCursor("contratos");
	with(curContrato) {
		select("codigo = '" + codContrato + "'");
		first();
		setModeAccess(Edit);
		refreshBuffer();
		setValueBuffer("ultimopago", hoy);
		commitBuffer();
	}
}

/** \D
Devuelve el número de meses de un período

@param periodo Tipo de cuota (mensual, semestral, etc)
@return Número de meses del período
\end */
function oficial_numMeses(periodo:String):Number 
{	
	var arrayMeses:Array;
	arrayMeses["Mensual"] = 1;
	arrayMeses["Bimestral"] = 2;
	arrayMeses["Trimestral"] = 3;
	arrayMeses["Semestral"] = 6;
	arrayMeses["Anual"] = 12;
	arrayMeses["Bienal"] = 24;

	return arrayMeses[periodo];
}

/** \D Muestra sólo los períodos pendientes de facturar
\end */
function oficial_cambiochkVigentes()
{ 
	if(this.iface.chkVigentes.checked == true)
		this.iface.tableDBRecords.cursor().setMainFilter("estado = 'Vigente'");
	else
		this.iface.tableDBRecords.cursor().setMainFilter("");
	
	this.iface.tableDBRecords.refresh();
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition ordenCampos */
/////////////////////////////////////////////////////////////////
//// ORDEN_CAMPOS ///////////////////////////////////////////////

function ordenCampos_init()
{
	this.iface.__init();

	var orden:Array = [ "codigo", "estado", "codcliente", "tipocontrato", "referencia", "descripcion", "coste", "totalconiva", "codimpuesto", "periodopago", "ultimopago", "fechainicio", "idusuario", "observaciones" ];

	this.iface.tableDBRecords.setOrderCols(orden);
}

//// ORDEN_CAMPOS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
