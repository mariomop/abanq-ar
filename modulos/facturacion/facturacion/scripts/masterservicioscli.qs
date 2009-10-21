/***************************************************************************
                 masterservicioscli.qs  -  description
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

/** @class_declaration  oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	var pbnGAlbaran:Object;
	var tdbRecords:FLTableDB;
    function oficial( context ) { interna( context ); } 
	function procesarEstado() {
		return this.ctx.oficial_procesarEstado();
	}
	function pbnGenerarAlbaran_clicked() {
		return this.ctx.oficial_pbnGenerarAlbaran_clicked();
	}
	function generarAlbaran(where:String, cursor:FLSqlCursor):Number {
		return this.ctx.oficial_generarAlbaran(where, cursor);
	}
	function commonCalculateField(fN:String, cursor:FLSqlCursor):String {
		return this.ctx.oficial_commonCalculateField(fN, cursor);
	}
	function copiaLineas(idServicio:Number, idAlbaran:Number):Boolean {
		return this.ctx.oficial_copiaLineas(idServicio, idAlbaran);
	}
	function copiaLineaServicio(curLineaServicio:FLSqlCursor, idAlbaran:Number):Number {
		return this.ctx.oficial_copiaLineaServicio(curLineaServicio, idAlbaran);
	}
	function actualizarDatosServicio(where:String, idAlbaran:String):Boolean {
		return this.ctx.oficial_actualizarDatosServicio(where, idAlbaran);
	}
	function datosLineaServicio(curLineaServicio:FLSqlCursor,curLineaAlbaran:FLSqlCursor,idAlbaran:Number):Boolean {
		return this.ctx.oficial_datosLineaServicio(curLineaServicio,curLineaAlbaran,idAlbaran);
	}
	function datosAlbaran(cursor:FLSqlCursor,curAlbaran:FLSqlCursor,where:String):Boolean {
		return this.ctx.oficial_datosAlbaran(cursor,curAlbaran,where);
	}
	function totalesAlbaran(curAlbaran:FLSqlCursor):Boolean {
		return this.ctx.oficial_totalesAlbaran(curAlbaran);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration servIvaInc */
/////////////////////////////////////////////////////////////////
//// SERV_IVAINC ////////////////////////////////////////////////
class servIvaInc extends oficial {
    function servIvaInc( context ) { oficial ( context ); }
	function datosLineaServicio(curLineaServicio:FLSqlCursor,curLineaAlbaran:FLSqlCursor,idAlbaran:Number):Boolean {
		return this.ctx.servIvaInc_datosLineaServicio(curLineaServicio,curLineaAlbaran,idAlbaran);
	}
}
//// SERV_IVAINC ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration nsServicios */
//////////////////////////////////////////////////////////////////
//// NS_SERVICIOS /////////////////////////////////////////////////////
class nsServicios extends servIvaInc {
	function nsServicios( context ) { servIvaInc( context ); } 	
	function copiaLineaServicio(curLineaServicio:FLSqlCursor, idAlbaran:Number):Number {
		return this.ctx.nsServicios_copiaLineaServicio(curLineaServicio, idAlbaran);
	}
}
//// NS_SERVICIOS /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration funNumServAcomp */
//////////////////////////////////////////////////////////////////
//// FUN_NUM_SERV_ACOMP /////////////////////////////////////////////////////

class funNumServAcomp extends nsServicios {
	function funNumServAcomp( context ) { nsServicios( context ); } 	
	function copiaLineaServicio(curLineaServicio:FLSqlCursor, idAlbaran:Number):Number {
		return this.ctx.funNumServAcomp_copiaLineaServicio(curLineaServicio, idAlbaran);
	}
}

//// FUN_NUM_SERV_ACOMP /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration fechas */
/////////////////////////////////////////////////////////////////
//// FECHAS /////////////////////////////////////////////////
class fechas extends funNumServAcomp {
	var fechaDesde:Object;
	var fechaHasta:Object;
	var ejercicio:String;

    function fechas( context ) { funNumServAcomp ( context ); }
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
	function datosLineaServicio(curLineaServicio:FLSqlCursor,curLineaAlbaran:FLSqlCursor,idAlbaran:Number):Boolean {
		return this.ctx.totalesIva_datosLineaServicio(curLineaServicio,curLineaAlbaran,idAlbaran);
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
	function imprimir(numServicio:String) {
		return this.ctx.impresiones_imprimir(numServicio);
	}
	function imprimirQuick(numServicio:String, impresora:String) {
		return this.ctx.impresiones_imprimirQuick(numServicio, impresora);
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
	function pub_commonCalculateField(fN:String, cursor:FLSqlCursor):String {
			return this.commonCalculateField(fN, cursor);
	}
	function pub_generarAlbaran(where:String, cursor:FLSqlCursor):Number {
			return this.generarAlbaran(where, cursor);
	}
	function pub_imprimir(numServicio:String) {
		return this.imprimir(numServicio);
	}
	function pub_imprimirQuick(numServicio:String, impresora:String) {
		return this.imprimirQuick(numServicio, impresora);
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
Este es el formulario maestro de servicios a cliente.
\end */
function interna_init()
{
	this.iface.pbnGAlbaran = this.child("pbnGenerarAlbaran");
	this.iface.tdbRecords = this.child("tableDBRecords");

	connect(this.iface.pbnGAlbaran, "clicked()", this, "iface.pbnGenerarAlbaran_clicked()");
	connect(this.iface.tdbRecords, "currentChanged()", this, "iface.procesarEstado");

	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	var datosEjercicio = flfactppal.iface.pub_ejecutarQry("ejercicios", "fechainicio,fechafin", "codejercicio = '" + codEjercicio + "'");
	if (datosEjercicio.result > 0)
		this.cursor().setMainFilter("fecha >='" + datosEjercicio.fechainicio + "' AND fecha <= '" + datosEjercicio.fechafin + "'");

	this.iface.procesarEstado();
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_procesarEstado()
{
	if (this.cursor().isValid() && this.cursor().valueBuffer("editable") == true) {
		this.iface.pbnGAlbaran.enabled = true;
	} else {
		this.iface.pbnGAlbaran.enabled = false;
	}
}

/** \C
Al pulsar el botón de generar remito se creará el remito correspondiente al servicio seleccionado.
\end */
function oficial_pbnGenerarAlbaran_clicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	if (!this.cursor().isValid()) {
		this.iface.procesarEstado();
		return;
	}
	if (cursor.valueBuffer("editable") == false) {
		MessageBox.warning(util.translate("scripts", "El servicio ya generó un remito"), MessageBox.Ok, MessageBox.NoButton);
		this.iface.procesarEstado();
		return;
	}
	var res:Number = MessageBox.warning(util.translate("scripts", "Se generará un remito a partir del servicio seleccionado.\n¿Desea continuar?"), MessageBox.Yes, MessageBox.No);
	if (res != MessageBox.Yes)
		return;

	this.iface.pbnGAlbaran.setEnabled(false);

	var where:String = "idservicio = " + cursor.valueBuffer("idservicio");

	cursor.transaction(false);
	if (this.iface.generarAlbaran(where, cursor))
			cursor.commit();
	else
			cursor.rollback();

	this.iface.tdbRecords.refresh();
	this.iface.procesarEstado();
}

/** \D 
Genera el remito asociado a uno o más servicios
@param where: Sentencia where para la consulta de búsqueda de los servicios a agrupar
@param cursor: Cursor con los datos principales que se copiarán del servicio al remito
@return Identificador del remito generado. FALSE si hay error
\end */
function oficial_generarAlbaran(where:String, cursor:FLSqlCursor):Number
{
	var util:FLUtil = new FLUtil();

	var curAlbaran:FLSqlCursor = new FLSqlCursor("albaranescli");
	curAlbaran.setModeAccess(curAlbaran.Insert);
	curAlbaran.refreshBuffer();

	if(!this.iface.datosAlbaran(cursor,curAlbaran,where))
		return false;

	if (!curAlbaran.commitBuffer())
		return false;

	var idAlbaran:Number = curAlbaran.valueBuffer("idalbaran");
	var qryServicios:FLSqlQuery = new FLSqlQuery();
	qryServicios.setTablesList("servicioscli");
	qryServicios.setSelect("idservicio");
	qryServicios.setFrom("servicioscli");
	qryServicios.setWhere(where);

	if (!qryServicios.exec())
		return false;

	var idServicio:String;
	while (qryServicios.next()) {
		idServicio = qryServicios.value(0);
		if (!this.iface.copiaLineas(idServicio, idAlbaran))
			return false;
	}
		
	curAlbaran.select("idalbaran = " + idAlbaran);
	if (curAlbaran.first()) {
		curAlbaran.setModeAccess(curAlbaran.Edit);
		curAlbaran.refreshBuffer();
		
		if(!this.iface.totalesAlbaran(curAlbaran))
			return false;
		
		if (!curAlbaran.commitBuffer())
			return false;
	}

	if(!this.iface.actualizarDatosServicio(where, idAlbaran))
		return false;
	
	return idAlbaran;
}

function oficial_totalesAlbaran(curAlbaran:FLSqlCursor):Boolean
{
	with(curAlbaran) {
		setValueBuffer("neto", formalbaranescli.iface.pub_commonCalculateField("neto", curAlbaran));
		setValueBuffer("totaliva", formalbaranescli.iface.pub_commonCalculateField("totaliva", curAlbaran));
		setValueBuffer("total", formalbaranescli.iface.pub_commonCalculateField("total", curAlbaran));
		setValueBuffer("totaleuros", formalbaranescli.iface.pub_commonCalculateField("totaleuros", curAlbaran));
		setValueBuffer("comision", formalbaranescli.iface.pub_commonCalculateField("comision", curAlbaran));
		setValueBuffer("codigo", formalbaranescli.iface.pub_commonCalculateField("codigo", curAlbaran));
	}
	return true;
}

function oficial_datosAlbaran(cursor:FLSqlCursor,curAlbaran:FLSqlCursor,where:String):Boolean
{
	var util:FLUtil;

	var codCliente:String = cursor.valueBuffer("codcliente");
	var codSerie:String = flfactppal.iface.pub_valorDefectoEmpresa("codserie_remito");
	var codAgente:String = cursor.valueBuffer("codagente");
	var datosCliente:Array = flfactppal.iface.pub_ejecutarQry("clientes", "codpago", "codcliente = '" + codCliente + "'");
	
	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();	
	var codAlmacen:String = flfactppal.iface.pub_valorDefectoEmpresa("codalmacen");
	
	var codDivisa:String = cursor.valueBuffer("coddivisa");
	var tasaConv:Number = cursor.valueBuffer("tasaconv");
	
	var codPago:String = datosCliente.codpago;
	if (!codPago) codPago = flfactppal.iface.pub_valorDefectoEmpresa("codpago");
	
	var nomTecnico:String = "";
	var datosTec = flfactppal.iface.pub_ejecutarQry("tecnicos", "nombre,apellidos", "codtecnico = '" + cursor.valueBuffer("codtecnico") + "'");
	if (datosTec["result"] == 1)
		nomTecnico = datosTec["apellidos"] + ", " + datosTec["nombre"];
	
	var observaciones:String = 
		util.translate("MetaData", "SERVICIO Nº ") + cursor.valueBuffer("numservicio") + "     " + 
		util.translate("MetaData", "Fecha: ") + util.dateAMDtoDMA(cursor.valueBuffer("fecha"));
		 
	if (cursor.valueBuffer("contratomant")) {
		observaciones += "    " + util.translate("MetaData", "MANTENIMIENTO");
	}
		
	observaciones += "\n\n" +
		util.translate("MetaData", "TÉCNICO: ") + 
		cursor.valueBuffer("codtecnico") + " - " + nomTecnico + "\n\n" +
		util.translate("MetaData", "DESCRIPCIÓN: ") + "\n" +
		cursor.valueBuffer("descripcion") + "\n\n" +
		util.translate("MetaData", "SOLUCIÓN: ") + "\n" +
		cursor.valueBuffer("solucion");
		

	var fecha:String;
	var hora:String;
	var hoy:Date = new Date();
	fecha = hoy.toString();
	hora = hoy.toString().right(8);

	var numeroAlbaran:Number = flfacturac.iface.pub_siguienteNumero(codSerie, codEjercicio, "nalbarancli");
	if (!numeroAlbaran)
		return false;
	
	with(curAlbaran) {	
		setValueBuffer("numero", numeroAlbaran);
		setValueBuffer("fecha", fecha);
		setValueBuffer("hora", hora);
		setValueBuffer("codejercicio", codEjercicio);
		setValueBuffer("coddivisa", codDivisa);
		setValueBuffer("codpago", codPago);
		setValueBuffer("codalmacen", codAlmacen);
		setValueBuffer("codagente", codAgente);
		setValueBuffer("codserie", codSerie);
		setValueBuffer("tasaconv", tasaConv);
		
		setValueBuffer("codcliente", codCliente);
		setValueBuffer("cifnif", util.sqlSelect("clientes", "cifnif", "codcliente = '" + codCliente + "'"));
		setValueBuffer("nombrecliente", util.sqlSelect("clientes", "nombre", "codcliente = '" + codCliente + "'"));
		
		datosDir = flfactppal.iface.pub_ejecutarQry("dirclientes", "direccion,codpostal,ciudad,provincia,apartado,codpais", "codcliente = '" + codCliente + "' AND domfacturacion = 'true'");		
		if (datosDir["result"] == -1) {
			MessageBox.warning(util.translate("scripts","No se encontró una dirección de facturación para este cliente.\nNo se puede generar el remito"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}	
		setValueBuffer("direccion", datosDir["direccion"]);
		setValueBuffer("codpostal", datosDir["codpostal"]);
		setValueBuffer("ciudad", datosDir["ciudad"]);
		setValueBuffer("provincia", datosDir["provincia"]);
		setValueBuffer("apartado", datosDir["apartado"]);
		setValueBuffer("codpais", datosDir["codpais"]);
		
		setValueBuffer("observaciones", observaciones);	
	}

	return true;
}

function oficial_actualizarDatosServicio(where:String, idAlbaran:String):Boolean
{
	var curServicios:FLSqlCursor = new FLSqlCursor("servicioscli");
	curServicios.select(where);
	while (curServicios.next()) {
		curServicios.setModeAccess(curServicios.Edit);
		curServicios.refreshBuffer();
		curServicios.setValueBuffer("editable", false);
		curServicios.setValueBuffer("idalbaran", idAlbaran);
		if(!curServicios.commitBuffer()) 
			return false;
	}
	return true;
}

/** \D
Copia las líneas de un servicio como líneas de su remito asociado
@param idServicio: Identificador del servicio
@param idAlbaran: Identificador del remito
@return VERDADERO si no hay error. FALSE en otro caso.
\end */
function oficial_copiaLineas(idServicio:Number, idAlbaran:Number):Boolean
{
	var cantidad:Number;
	var totalEnAlbaran:Number;
	var curLineaServicio:FLSqlCursor = new FLSqlCursor("lineasservicioscli");
	curLineaServicio.select("idservicio = " + idServicio);
	while (curLineaServicio.next()) {
		curLineaServicio.setModeAccess(curLineaServicio.Browse);
		curLineaServicio.refreshBuffer();
		if (!this.iface.copiaLineaServicio(curLineaServicio, idAlbaran))
			return false;
	}
	return true;
}

/** \D
Copia una líneas de un servicio en su remito asociado
@param curServicio: Cursor posicionado en la línea de servicio a copiar
@param idAlbaran: Identificador del remito
@return identificador de la línea de remito creada si no hay error. FALSE en otro caso.
\end */
function oficial_copiaLineaServicio(curLineaServicio:FLSqlCursor, idAlbaran:Number):Number
{
	var curLineaAlbaran:FLSqlCursor = new FLSqlCursor("lineasalbaranescli");
	curLineaAlbaran.setModeAccess(curLineaAlbaran.Insert);
	curLineaAlbaran.refreshBuffer();
	
	this.iface.datosLineaServicio(curLineaServicio,curLineaAlbaran,idAlbaran);

	if (!curLineaAlbaran.commitBuffer())
		return false;

	return curLineaAlbaran.valueBuffer("idlinea");
}

function oficial_datosLineaServicio(curLineaServicio:FLSqlCursor,curLineaAlbaran:FLSqlCursor,idAlbaran:Number):Boolean
{
	var cantidad:Number = parseFloat(curLineaServicio.valueBuffer("cantidad"));

	with(curLineaAlbaran) {
		setValueBuffer("idalbaran", idAlbaran);
		setValueBuffer("referencia", curLineaServicio.valueBuffer("referencia"));
		setValueBuffer("descripcion", curLineaServicio.valueBuffer("descripcion"));
		setValueBuffer("pvpunitario", curLineaServicio.valueBuffer("pvpunitario"));
		setValueBuffer("cantidad", cantidad);
		setValueBuffer("pvpsindto", curLineaServicio.valueBuffer("pvpsindto"));
		setValueBuffer("pvptotal", curLineaServicio.valueBuffer("pvptotal"));
		setValueBuffer("codimpuesto", curLineaServicio.valueBuffer("codimpuesto"));
		setValueBuffer("iva", curLineaServicio.valueBuffer("iva"));
		setValueBuffer("dtolineal", curLineaServicio.valueBuffer("dtolineal"));
		setValueBuffer("dtopor", curLineaServicio.valueBuffer("dtopor"));
		setValueBuffer("porcomision", curLineaServicio.valueBuffer("porcomision"));
	}
	return true;
}

function oficial_commonCalculateField(fN:String, cursor:FLSqlCursor):String
{
	var util:FLUtil = new FLUtil();
	var valor:String;

	switch (fN) {
		/** \C
		El --total-- es el --neto-- más el --totaliva--
		\end */
		case "total":
			var neto:Number = parseFloat(cursor.valueBuffer("neto"));
			var totalIva:Number = parseFloat(cursor.valueBuffer("totaliva"));
			valor = neto + totalIva;
			valor = parseFloat(util.roundFieldValue(valor, "servicioscli", "total"));
			break;
		/** \C
		El --neto-- es la suma del pvp total de las líneas de remito
		\end */
		case "neto":
			valor = util.sqlSelect("lineasservicioscli", "SUM(pvptotal)", "idservicio = " + cursor.valueBuffer("idservicio"));
			valor = parseFloat(util.roundFieldValue(valor, "servicioscli", "neto"));
			break;
		/** \C
		El --totaliva-- es la suma del iva correspondiente a las líneas de remito
		\end */
		case "totaliva":
			if (formfacturascli.iface.pub_sinIVA(cursor)) {
				valor = 0;
			} else {
				valor = util.sqlSelect("lineasservicioscli", "SUM((pvptotal * iva) / 100)", "idservicio = " + cursor.valueBuffer("idservicio"));
			}
			valor = parseFloat(util.roundFieldValue(valor, "servicioscli", "totaliva"));
			break;
	}
	return valor;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition servIvaInc */
/////////////////////////////////////////////////////////////////
//// SERV_IVAINC ////////////////////////////////////////////////
function servIvaInc_datosLineaServicio(curLineaServicio:FLSqlCursor,curLineaAlbaran:FLSqlCursor,idAlbaran:Number):Boolean
{
	with(curLineaAlbaran) {
		setValueBuffer("ivaincluido", curLineaServicio.valueBuffer("ivaincluido"));
		setValueBuffer("pvpunitarioiva", curLineaServicio.valueBuffer("pvpunitarioiva"));
	}

	return this.iface.__datosLineaServicio(curLineaServicio,curLineaAlbaran,idAlbaran);;
}

//// SERV_IVAINC ////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition nsServicios */
/////////////////////////////////////////////////////////////////
//// NS_SERVICIOS /////////////////////////////////////////////////

/** Copia el número de serie si procede
*/
function nsServicios_copiaLineaServicio(curLineaServicio:FLSqlCursor, idAlbaran:Number):Number
{
	var idLinea = this.iface.__copiaLineaServicio(curLineaServicio, idAlbaran);
	
	if (!curLineaServicio.valueBuffer("numserie"))
		return idLinea;
	
	var curLA:FLSqlCursor = new FLSqlCursor("lineasalbaranescli");
	curLA.select("idlinea = " + idLinea);
	if (curLA.first()) {
		curLA.setModeAccess(curLA.Edit);
		curLA.refreshBuffer();
		curLA.setValueBuffer("numserie", curLineaServicio.valueBuffer("numserie"));
		if (!curLA.commitBuffer())
			return false;
	}
	
	return idLinea;
}

//// NS_SERVICIOS /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition funNumServAcomp */
/////////////////////////////////////////////////////////////////
//// FUN_NUM_SERV_ACOMP /////////////////////////////////////////////////

/** \D Si la línea es de un compuesto, crea las líneas de factura por NS si procede
@param	curLineaServicio: Cursor que contiene los datos a incluir en la línea de factura
@return	True si la copia se realiza correctamente, false en caso contrario
\end */
function funNumServAcomp_copiaLineaServicio(curLineaServicio:FLSqlCursor, idAlbaran:Number):Number
{
	var idLinea = this.iface.__copiaLineaServicio(curLineaServicio, idAlbaran);
	if(!idLinea)
		return false;
	
	var util:FLUtil = new FLUtil;
	
	var curLNS:FLSqlCursor = new FLSqlCursor("lineasserviciosclins");
	var curLNA:FLSqlCursor = new FLSqlCursor("lineasalbaranesclins");
	
	curLNS.select("idlineaservicio = " + curLineaServicio.valueBuffer("idlinea"));
	while(curLNS.next()) {
		curLNA.setModeAccess(curLNA.Insert);
		curLNA.refreshBuffer();
		curLNA.setValueBuffer("idlineaalbaran", idLinea);
		curLNA.setValueBuffer("referencia", curLNS.valueBuffer("referencia"));
		curLNA.setValueBuffer("numserie", curLNS.valueBuffer("numserie"));
 		curLNA.commitBuffer();
	}
	
	return true;
}

//// FUN_NUM_SERV_ACOMP /////////////////////////////////////////////////
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

	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	if (codEjercicio) {
		this.iface.ejercicio = codEjercicio;
		this.iface.actualizarFiltro();
	}

	this.iface.procesarEstado();
}

function fechas_actualizarFiltro()
{
	var desde:String = this.iface.fechaDesde.date.toString().left(10);
	var hasta:String = this.iface.fechaHasta.date.toString().left(10);

	if (desde == "" || hasta == "")
		return;

//	this.cursor().setMainFilter("codejercicio = '" + this.iface.ejercicio + "' AND  fecha >= '" + desde + "' AND fecha <= '" + hasta + "'");
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

function totalesIva_datosLineaServicio(curLineaServicio:FLSqlCursor,curLineaAlbaran:FLSqlCursor,idAlbaran:Number):Boolean
{
	if(!this.iface.__datosLineaServicio(curLineaServicio,curLineaAlbaran,idAlbaran))
		return false;

	with(curLineaAlbaran) {
		setValueBuffer("totalconiva", curLineaServicio.valueBuffer("totalconiva"));
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

function impresiones_imprimir(numServicio:String)
{
	if (sys.isLoadedModule("flfactinfo")) {
		var util:FLUtil = new FLUtil();
		var numero:String;
		if (numServicio) {
			numero = numServicio;
		}
		else {
			if (!this.cursor().isValid())
				return;
			numero = this.cursor().valueBuffer("numservicio");
		}

		var dialog:Dialog = new Dialog(util.translate ( "scripts", "Imprimir Servicio" ), 0, "imprimir");

		dialog.OKButtonText = util.translate ( "scripts", "Aceptar" );
		dialog.cancelButtonText = util.translate ( "scripts", "Cancelar" );

		var text:Object = new Label;
		text.text = util.translate("scripts","Servicio: ") + numero;
		dialog.add(text);

		var bgroup:GroupBox = new GroupBox;
		bgroup.title = util.translate("scripts", "Opciones");
		dialog.add( bgroup );

		var impServicio:RadioButton = new RadioButton;
		impServicio.text = util.translate ( "scripts", "Imprimir Servicio" );
		impServicio.checked = true;
		bgroup.add( impServicio );

		var impNumSerie:CheckBox = new CheckBox;
		impNumSerie.text = util.translate ( "scripts", "Imprimir números de serie" );
		impNumSerie.checked = flfactppal.iface.pub_valorDefectoEmpresa("imprimirnumserie");
		bgroup.add( impNumSerie );

		if ( !dialog.exec() )
			return true;

		var nombreInforme:String;
		var numCopias:Number = 1;

		if ( impServicio.checked == true) {

			if ( impNumSerie.checked == true ) {
				nombreInforme = "i_servicioscli_ns";
			} else {
				nombreInforme = "i_servicioscli";
			}
		}

		var curImprimir:FLSqlCursor = new FLSqlCursor("i_servicioscli");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_servicioscli_numservicio", numero);
		curImprimir.setValueBuffer("h_servicioscli_numservicio", numero);

		flfactinfo.iface.pub_lanzarInforme(curImprimir, nombreInforme, "", "", false, false, "", nombreInforme, numCopias);
	} else
		flfactppal.iface.pub_msgNoDisponible("Informes");
}

function impresiones_imprimirQuick(numServicio:String, impresora:String)
{
	if (sys.isLoadedModule("flfactinfo")) {
		var util:FLUtil = new FLUtil();
		var numero:String;
		if (numServicio) {
			numero = numServicio;
		}
		else {
			if (!this.cursor().isValid())
				return;
			numero = this.cursor().valueBuffer("numservicio");
		}

		var impNumSerie:Boolean = flfactppal.iface.pub_valorDefectoEmpresa("imprimirnumserie");
		var impDirecta:Boolean = true;

		var nombreInforme:String;
		var numCopias:Number = 1;

		if ( impNumSerie == true ) {
			nombreInforme = "i_servicioscli_ns";
		} else {
			nombreInforme = "i_servicioscli";
		}

		var curImprimir:FLSqlCursor = new FLSqlCursor("i_servicioscli");
		curImprimir.setModeAccess(curImprimir.Insert);
		curImprimir.refreshBuffer();
		curImprimir.setValueBuffer("descripcion", "temp");
		curImprimir.setValueBuffer("d_servicioscli_numservicio", numero);
		curImprimir.setValueBuffer("h_servicioscli_numservicio", numero);

		flfactinfo.iface.pub_lanzarInforme(curImprimir, nombreInforme, "", "", false, impDirecta, "", nombreInforme, numCopias, impresora);
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

	var orden:Array = [ "numservicio", "editable", "codcliente", "nombrecliente", "neto", "totaliva", "total", "coddivisa", "tasaconv", "fecha", "referencia", "numserieap", "accesorios", "desperfectos", "codtecnico", "descripcion", "solucion", "horas", "minutos", "contratomant", "tiposervicio", "estado", "codserie", "codagente", "comision", "idusuario" ];

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