/**************************************************************************
                 contratos.qs  -  description
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
	function calculateCounter():String { return this.ctx.interna_calculateCounter(); }
	function calculateField(fN:String):String { return this.ctx.interna_calculateField(fN); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
    function oficial( context ) { interna( context ); } 
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration totalesIva */
/////////////////////////////////////////////////////////////////
//// TOTALES CON IVA ////////////////////////////////////////////
class totalesIva extends oficial {
    function totalesIva( context ) { oficial ( context ); }
	function calculateField(fN:String):String {
		return this.ctx.totalesIva_calculateField(fN);
	}
}
//// TOTALES CON IVA ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration controlUsuario */
/////////////////////////////////////////////////////////////////
//// CONTROL_USUARIO ////////////////////////////////////////////
class controlUsuario extends totalesIva {
    function controlUsuario( context ) { totalesIva ( context ); }
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
	function ordenarColumnas() {
		this.ctx.ordenCampos_ordenarColumnas();
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

/** \D Sólo mostramos las facturas del contrato actual
*/
function interna_init()
{
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("periodoscontratos");
	q.setFrom("periodoscontratos");
	q.setSelect("idfactura");
	q.setWhere("codcontrato = '" + this.cursor().valueBuffer("codigo") + "'");

	q.exec();
	
	var lista:String = "";
	while(q.next()) {
		if (lista) lista += ",";
		lista += q.value(0);
	}

	if (lista)
		this.child("tdbFacturas").cursor().setMainFilter("idfactura IN (" + lista + ")");
	else
		this.child("tdbFacturas").cursor().setMainFilter("idfactura = -1");

	connect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");

	this.child("tdbFacturas").setReadOnly(true);

	var filtroCliente:String = "NOT debaja";
	this.child("fdbCodCliente").setFilter(filtroCliente);
}

function interna_calculateCounter()
{
}

function interna_calculateField(fN:String):String
{
	var util:FLUtil = new FLUtil();
	var valor:String;

	switch (fN) {
	
		case "periodopago":
		
			var tipo:Number = 0;
			var tipos:Array = [];
			tipos["Mensual"] = tipo++;
			tipos["Bimestral"] = tipo++;
			tipos["Trimestral"] = tipo++;
			tipos["Semestral"] = tipo++;
			tipos["Anual"] = tipo++;
			tipos["Bienal"] = tipo;
	
			valor = util.sqlSelect("tiposcontrato", "periodopago", "codigo = '" + this.cursor().valueBuffer("tipocontrato") + "'");
			if (!valor) return "";
			valor = tipos[valor];
		break;
	}
	
	return valor;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_bufferChanged(fN:String)
{
	switch (fN) {
		case "tipocontrato":
			var valor = this.iface.calculateField("periodopago");
			if (valor)
				this.child("fdbPeriodoPago").setValue(valor);
		break;
	}
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition totalesIva */
/////////////////////////////////////////////////////////////////
//// TOTALES CON IVA ////////////////////////////////////////////

function totalesIva_calculateField(fN:String):String
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	var valor:String;
	var referencia:String = cursor.valueBuffer("referencia");

	switch (fN) {
		case "totalconiva":{
			valor = parseFloat(cursor.valueBuffer("coste"));

			var ivaIncluido:Boolean = util.sqlSelect("articulos", "ivaincluido", "referencia = '" + referencia + "'");
			if (!ivaIncluido) {
				var iva:Number = util.sqlSelect("impuestos", "iva", "codimpuesto = '" + cursor.valueBuffer("codimpuesto") + "'");
				valor = parseFloat(valor) * (1 + iva / 100);
			}
			valor = util.roundFieldValue(valor, "contratos", "totalconiva");
			break;
		}
		default:
			return this.iface.__calculateField(fN);
	}

	return valor;
}

//// TOTALES CON IVA ////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition controlUsuario */
/////////////////////////////////////////////////////////////////
//// CONTROL_USUARIO ////////////////////////////////////////////

function controlUsuario_init()
{
	if (this.cursor().modeAccess() == this.cursor().Insert) {
		if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
			flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Contratos");
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

	connect(this.child("tdbContratos"), "currentChanged(QString)", this, "iface.ordenarColumnas()");
}

function ordenCampos_ordenarColumnas()
{
	var orden:Array = [ "codigo", "tipoventa", "claseventa", "numero", "editable", "nombrecliente", "total", "neto", "totaliva", "totalpie", "coddivisa", "tasaconv", "totaleuros", "fecha", "hora", "codserie", "codejercicio", "codperiodo", "codalmacen", "codpago", "codtarifa", "codenvio", "codcliente", "cifnif", "direccion", "codpostal", "ciudad", "provincia", "codpais", "nombre", "apellidos", "empresa", "codagente", "comision", "tpv", "automatica", "rectificada", "codigorect", "costototal", "ganancia", "utilidad", "idusuario", "observaciones" ];

	this.child("tdbFacturas").setOrderCols(orden);
}

//// ORDEN_CAMPOS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
