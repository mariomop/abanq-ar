/***************************************************************************
                 servicioscli.qs  -  description
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
	function calculateField(fN:String):String { return this.ctx.interna_calculateField(fN); }
	function calculateCounter():String { return this.ctx.interna_calculateCounter(); }
	function validateForm():Boolean { return this.ctx.interna_validateForm(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna 
{
	var refHora:String;
	var refDesp:String;
	var pbnAplicarComision:Object;

    function oficial( context ) { interna( context ); } 
	function bufferChanged(fN:String) {
			return this.ctx.oficial_bufferChanged(fN);
	}
	function calcularTotales() {
			return this.ctx.oficial_calcularTotales();
	}
	function generarCostes() {
			return this.ctx.oficial_generarCostes();
	}
	function mostrarTraza() {
		return this.ctx.oficial_mostrarTraza();
	}
	function aplicarComision_clicked() {
		return this.ctx.oficial_aplicarComision_clicked();
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration controlUsuario */
/////////////////////////////////////////////////////////////////
//// CONTROL_USUARIO ////////////////////////////////////////////
class controlUsuario extends oficial {
    function controlUsuario( context ) { oficial ( context ); }
	function init() {
		return this.ctx.controlUsuario_init();
	}
}
//// CONTROL_USUARIO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ordenCampos */
/////////////////////////////////////////////////////////////////
//// ORDEN_CAMPOS ///////////////////////////////////////////////
class ordenCampos extends controlUsuario {
    function ordenCampos( context ) { controlUsuario ( context ); }
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
	function init() {
		this.ctx.tipoVenta_init();
	}
	function bufferChanged(fN:String) {
		return this.ctx.tipoVenta_bufferChanged(fN);
	}
}
//// TIPO DE VENTA  /////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends tipoVenta {
    function head( context ) { tipoVenta ( context ); }
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
Este formulario realiza la gestión de los remitos a clientes.

Los remitos pueden ser generados de forma manual o a partir de uno o más pedidos.
\end */
function interna_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.child("tdbLineasServiciosCli").cursor(), "bufferCommited()", this, "iface.calcularTotales()");
	connect(this.child("pbnGenerarCostes"), "clicked()", this, "iface.generarCostes");
	connect(this.child("tbnTraza"), "clicked()", this, "iface.mostrarTraza()");

	this.iface.refHora = "HMN";
	this.iface.refDesp = "DSP";

	this.iface.pbnAplicarComision = this.child("pbnAplicarComision");
	connect(this.iface.pbnAplicarComision, "clicked()", this, "iface.aplicarComision_clicked()");
	this.iface.pbnAplicarComision.setDisabled(true);

	if ( !sys.isLoadedModule("flcrm_ppal") ) {
		this.child("tbwServicio").setTabEnabled("incidencias", false);
		this.child("tbwServicio").setTabEnabled("comunicaciones", false);
	}
}

/** \D Calcula un nuevo número de servicio
\end */
function interna_calculateCounter()
{
	var util:FLUtil = new FLUtil();
	return util.nextCounter("numservicio", this.cursor());
}

function interna_calculateField(fN:String, cursor:FLSqlCursor):String
{
		var util:FLUtil = new FLUtil();
		var valor:String;
		var cursor:FLSqlCursor = this.cursor();

		switch (fN) {
		/** \C
		El --total-- es el --neto-- más el --totaliva--
		\end */
		case "total":
			var neto:Number = parseFloat(cursor.valueBuffer("neto"));
			var totalIva:Number = parseFloat(cursor.valueBuffer("totaliva"));
			valor = neto + totalIva;
			break;
		/** \C
		El --neto-- es la suma del pvp total de las líneas de servicio
		\end */
		case "neto":
			valor = util.sqlSelect("lineasservicioscli", "SUM(pvptotal)", "idservicio = " + cursor.valueBuffer("idservicio"));
			break;
		/** \C
		El --totaliva-- es la suma del iva correspondiente a las líneas de servicio
		\end */
		case "totaliva":
			valor = util.sqlSelect("lineasservicioscli", "SUM((pvptotal * iva) / 100)", "idservicio = " + cursor.valueBuffer("idservicio"));
			valor = parseFloat(util.roundFieldValue(valor, "servicioscli", "totaliva"));
			break;

		case "comision":
			valor = util.sqlSelect("lineasservicioscli", "SUM((porcomision*pvptotal)/100)", "idservicio = " + cursor.valueBuffer("idservicio"));
			valor = parseFloat(util.roundFieldValue(valor, "servicioscli", "comision"));
			break;
		}

		return valor;
}

function interna_validateForm():Boolean
{
	var util:FLUtil = new FLUtil;	
	
	var codEjercicio:String = flfactppal.iface.pub_ejercicioActual();
	var datosEjercicio = flfactppal.iface.pub_ejecutarQry("ejercicios", "fechainicio,fechafin", "codejercicio = '" + codEjercicio + "'");
	if (datosEjercicio.result > 0)
		if (this.cursor().valueBuffer("fecha") < datosEjercicio.fechainicio || this.cursor().valueBuffer("fecha") > datosEjercicio.fechafin) {
			MessageBox.warning(util.translate("scripts", "La fecha del servicio no corresponde al ejercicio actual ") + codEjercicio, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_calcularTotales()
{
	var util:FLUtil = new FLUtil;	

	this.child("fdbNeto").setValue(this.iface.calculateField("neto"));
	this.child("fdbTotalIva").setValue(this.iface.calculateField("totaliva"));
	this.child("fdbComision").setValue(this.iface.calculateField("comision"));
}

function oficial_bufferChanged(fN:String)
{
		var util:FLUtil = new FLUtil();
		switch (fN) {
			/** \C
			El --total-- es el --neto-- más el --totaliva--
			\end */
			case "neto":
			case "totaliva": {
				this.child("fdbTotal").setValue(this.iface.calculateField("total"));
				break;
			}
			case "total": {
				this.child("fdbComision").setValue(this.iface.calculateField("comision"));
				break;
			}
			case "codagente": {
				this.iface.pbnAplicarComision.setDisabled(false);
				break;
			}
		}
}

function oficial_generarCostes()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	
	if (cursor.modeAccess() == cursor.Insert) {
		var curDir:FLSqlCursor = this.child("tdbLineasServiciosCli").cursor();
		curDir.setModeAccess( curDir.Insert );
		if ( !curDir.commitBufferCursorRelation() )
			debug( "NO COMMIT" );
	}
	
	
	// Línea de horas de mano de obra ////////////////////////////////////////////
	
	var datosArt = flfactppal.iface.pub_ejecutarQry("articulos", "descripcion,pvp,codimpuesto", "referencia = '" + this.iface.refHora + "'");
	if (datosArt["result"] == -1) {
		MessageBox.warning(util.translate("scripts","No se encuentra el artículo de hora técnica.\nDebe crearlo con la referencia ") + this.iface.refHora, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	
	var codTarifa:String = util.sqlSelect("clientes c INNER JOIN gruposclientes gc ON c.codgrupo = gc.codgrupo", "gc.codtarifa", "codcliente = '" + cursor.valueBuffer("codcliente") + "'", "clientes,gruposclientes");
	if (codTarifa)
		var valor:Number = util.sqlSelect("articulostarifas", "pvp", "referencia = '" + this.iface.refHora + "' AND codtarifa = '" + codTarifa + "'");
	if (valor)
		datosArt["pvp"] = valor;
	
	// datos de IVA
	var iva:Number = 0;
	var datosIVA = flfactppal.iface.pub_ejecutarQry("impuestos", "iva", "codimpuesto = '" + datosArt["codimpuesto"] + "'");
	if (datosIVA["result"] == 1) {
		iva = datosIVA["iva"];
	}
	
	var curLineaServicio:FLSqlCursor = new FLSqlCursor("lineasservicioscli");
		
	curLineaServicio.select("idservicio = " + cursor.valueBuffer("idservicio") + " AND referencia = '" + this.iface.refHora + "'");
	if (curLineaServicio.first()) {
		MessageBox.warning(util.translate("scripts","Este servicio ya tiene una línea de mano de obra"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
	}
	else {
		var horas:Number = parseInt(cursor.valueBuffer("horas")) + (parseInt(cursor.valueBuffer("minutos")) / 60);
		
		if (horas == 0) {
			MessageBox.warning(util.translate("scripts","Para generar la línea de mano de obra el tiempo empleado debe ser mayor de cero"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		} else {
			curLineaServicio.setModeAccess(curLineaServicio.Insert);
			curLineaServicio.refreshBuffer();
			curLineaServicio.setValueBuffer("idservicio", cursor.valueBuffer("idservicio"));
			curLineaServicio.setValueBuffer("referencia", this.iface.refHora);
			curLineaServicio.setValueBuffer("descripcion", datosArt["descripcion"]);
			curLineaServicio.setValueBuffer("cantidad", horas);
			curLineaServicio.setValueBuffer("iva", iva);
			curLineaServicio.setValueBuffer("codimpuesto", datosArt["codimpuesto"]);
			curLineaServicio.setValueBuffer("pvpunitario", datosArt["pvp"]);
			curLineaServicio.setValueBuffer("pvpsindto", datosArt["pvp"] * horas);
			curLineaServicio.setValueBuffer("pvptotal", datosArt["pvp"] * horas);
			if (!curLineaServicio.commitBuffer())
				return false;
		}
	}				
		
	
	// Línea de desplazamiento	////////////////////////////////////////////
	
	datosArt = flfactppal.iface.pub_ejecutarQry("articulos", "descripcion,pvp,codimpuesto", "referencia = '" + this.iface.refDesp + "'");
	if (datosArt["result"] == -1) {
		MessageBox.warning(util.translate("scripts","No se encuentra el artículo de desplazamiento.\nDebe crearlo con la referencia ") + this.iface.refDesp, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	
	codTarifa = util.sqlSelect("clientes c INNER JOIN gruposclientes gc ON c.codgrupo = gc.codgrupo", "gc.codtarifa", "codcliente = '" + cursor.valueBuffer("codcliente") + "'", "clientes,gruposclientes");
	if (codTarifa)
		valor = util.sqlSelect("articulostarifas", "pvp", "referencia = '" + this.iface.refDesp + "' AND codtarifa = '" + codTarifa + "'");
	if (valor)
		datosArt["pvp"] = valor;
	
	// datos de IVA
	iva = 0;
	datosIVA = flfactppal.iface.pub_ejecutarQry("impuestos", "iva", "codimpuesto = '" + datosArt["codimpuesto"] + "'");
	
	if (datosIVA["result"] == 1) {
		iva = datosIVA["iva"];
	}
	
	curLineaServicio.select("idservicio = " + cursor.valueBuffer("idservicio") + " AND referencia = '" + this.iface.refDesp + "'");
	if (curLineaServicio.first()) {
		MessageBox.warning(util.translate("scripts","Este servicio ya tiene una línea de desplazamiento"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
	}
	else {
		curLineaServicio.setModeAccess(curLineaServicio.Insert);
		curLineaServicio.refreshBuffer();
		curLineaServicio.setValueBuffer("idservicio", cursor.valueBuffer("idservicio"));
		curLineaServicio.setValueBuffer("referencia", this.iface.refDesp);
		curLineaServicio.setValueBuffer("descripcion", datosArt["descripcion"]);
		curLineaServicio.setValueBuffer("cantidad", 1);
		curLineaServicio.setValueBuffer("iva", iva);
		curLineaServicio.setValueBuffer("codimpuesto", datosArt["codimpuesto"]);
		curLineaServicio.setValueBuffer("pvpunitario", datosArt["pvp"]);
		curLineaServicio.setValueBuffer("pvpsindto", datosArt["pvp"]);
		curLineaServicio.setValueBuffer("pvptotal", datosArt["pvp"]);
		if (!curLineaServicio.commitBuffer())
			return false;
	}
							
	this.child("tdbLineasServiciosCli").refresh();
	this.iface.calcularTotales();
}

function oficial_mostrarTraza()
{
	flfacturac.iface.pub_mostrarTraza(this.cursor().valueBuffer("numservicio"), "servicioscli");
}

function mostrarfabricante()
{
	//flfacturac.iface.
}

function oficial_aplicarComision_clicked()
{
	var util:FLUtil;
	
	var idServicio:Number = this.cursor().valueBuffer("idservicio");
	if(!idServicio)
		return;
	var codAgente:String = this.cursor().valueBuffer("codagente");
	if(!codAgente || codAgente == "")
		return;

	var res:Number = MessageBox.information(util.translate("scripts", "¿Seguro que desea actualizar la comisión en todas las líneas?"), MessageBox.Yes, MessageBox.No);
	if(res != MessageBox.Yes)
		return;

	var cursor:FLSqlCursor = new FLSqlCursor("empresa");
	cursor.transaction(false);

	try {
		if(!flfacturac.iface.pub_aplicarComisionLineas(codAgente,"lineasservicioscli","idservicio = " + idServicio)) {
			cursor.rollback();
			return;
		}
		else {
			cursor.commit();
		}
	} catch (e) {
		MessageBox.critical(util.translate("scripts", "Hubo un error al aplicarse la comisión en las líneas.\n%1").arg(e), MessageBox.Ok, MessageBox.NoButton);
		cursor.rollback();
		return false;
	}

	MessageBox.information(util.translate("scripts", "La comisión se actualizó correctamente."), MessageBox.Ok, MessageBox.NoButton);

	this.iface.pbnAplicarComision.setDisabled(true);
	this.child("tdbLineasServiciosCli").refresh()
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition controlUsuario */
/////////////////////////////////////////////////////////////////
//// CONTROL_USUARIO ////////////////////////////////////////////

function controlUsuario_init()
{
	if (this.cursor().modeAccess() == this.cursor().Insert) {
		if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
			flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Servicios");
		}
	}

	this.iface.__init();
}

//// CONTROL_USUARIO //////////////////////////////////////////
///////////////////////////////////////////////////////////////

/** @class_definition ordenCampos */
/////////////////////////////////////////////////////////////////
//// ORDEN_CAMPOS ///////////////////////////////////////////////

function ordenCampos_init()
{
	this.iface.__init();

	var orden:Array = [ "referencia", "descripcion", "cantidad", "pvpunitario", "pvpsindto", "pvptotal", "totalconiva", "codimpuesto", "iva", "dtolineal", "dtopor", "porcomision", "numserie" ];

	this.child("tdbLineasServiciosCli").setOrderCols(orden);
}

//// ORDEN_CAMPOS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition tipoVenta */
//////////////////////////////////////////////////////////////////
//// TIPO VENTA //////////////////////////////////////////////////

function tipoVenta_init()
{
	this.iface.__init();

	if ( this.cursor().modeAccess() == this.cursor().Insert )
		this.cursor().setValueBuffer("codserie", flfactppal.iface.pub_valorDefectoEmpresa("codserie_b"));
}

function tipoVenta_bufferChanged(fN:String)
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	switch (fN) {
		case "codcliente": {
			if (cursor.valueBuffer("codcliente") && cursor.valueBuffer("codcliente") != "") {
				var regimenIva:Boolean = util.sqlSelect("clientes", "regimeniva", "codcliente = '" + cursor.valueBuffer("codcliente") + "'");
				switch ( regimenIva ) {
					case "Consumidor Final":
					case "Exento":
					case "No Responsable":
					case "Responsable Monotributo": {
						cursor.setValueBuffer("codserie", flfactppal.iface.pub_valorDefectoEmpresa("codserie_b"));
						break;
					}
					case "Responsable Inscripto":
					case "Responsable No Inscripto": {
						cursor.setValueBuffer("codserie", flfactppal.iface.pub_valorDefectoEmpresa("codserie_a"));
						break;
					}
				}
			}
			break;
		}
		default:
			this.iface.__bufferChanged(fN);
	}
}
//// TIPO VENTA //////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
