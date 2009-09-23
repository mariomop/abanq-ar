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

/** @class_declaration ivaIncluido */
//////////////////////////////////////////////////////////////////
//// IVAINCLUIDO /////////////////////////////////////////////////////
class ivaIncluido extends oficial {
    function ivaIncluido( context ) { oficial( context ); } 	
	function calculateField(fN:String):String {
		return this.ctx.ivaIncluido_calculateField(fN);
	}
	function bufferChanged(fN:String) {
		return this.ctx.ivaIncluido_bufferChanged(fN);
	}
}
//// IVAINCLUIDO /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration totalesIva */
/////////////////////////////////////////////////////////////////
//// TOTALES CON IVA ////////////////////////////////////////////
class totalesIva extends ivaIncluido {
    function totalesIva( context ) { ivaIncluido ( context ); }
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


/** @class_definition ivaIncluido */
//////////////////////////////////////////////////////////////////
//// IVAINCLUIDO /////////////////////////////////////////////////////

function ivaIncluido_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();
	
	switch (fN) {
		case "tipocontrato": {
			this.iface.__bufferChanged(fN);
			cursor.setValueBuffer("referencia", this.iface.calculateField("referencia"));
			break;
		}
		case "referencia": {
			cursor.setValueBuffer("coste", this.iface.calculateField("coste"));
			break;
		}
		default:
			this.iface.__bufferChanged(fN);
	}
}

function ivaIncluido_calculateField(fN:String)
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	var valor:String;
	var referencia:String = cursor.valueBuffer("referencia");
	
	switch (fN) {
		case "referencia": {
			valor = util.sqlSelect("tiposcontrato", "referencia", "codigo = '" + cursor.valueBuffer("tipocontrato") + "'");
			break;
		}
		case "coste": {
			var q:FLSqlQuery = new FLSqlQuery();
			
			q.setTablesList("articulos");
			q.setSelect("pvp,ivaincluido,codimpuesto");
			q.setFrom("articulos");
			q.setWhere("referencia = '" + referencia + "'");
			if (!q.exec())
				return false;
			if (!q.first())
				return false;

			valor = parseFloat(q.value("pvp"));

			var ivaIncluido:Boolean = q.value("ivaincluido");
			if (ivaIncluido) {
				var iva:Number = util.sqlSelect("impuestos", "iva", "codimpuesto = '" + q.value("codimpuesto") + "'");
				valor = parseFloat(valor) / (1 + iva / 100);
			}
			break;
		}
		default:
			valor = this.iface.__calculateField(fN);
	}
	return valor;
}
//// IVAINCLUIDO /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


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
			if (ivaIncluido) {
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

	var orden:Array = [ "codigo", "tipoventa", "editable", "nombrecliente", "neto", "totaliva", "total", "coddivisa", "tasaconv", "totaleuros", "fecha", "hora", "codserie", "numero", "codejercicio", "codalmacen", "codpago", "codenvio", "codcliente", "cifnif", "direccion", "codpostal", "ciudad", "provincia", "codpais", "nombre", "apellidos", "empresa", "codagente", "porcomision", "tpv", "automatica", "rectificada", "decredito", "dedebito", "codigorect", "costototal", "ganancia", "utilidad", "idusuario", "observaciones" ];

	this.child("tdbFacturas").setOrderCols(orden);
}

//// ORDEN_CAMPOS ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
