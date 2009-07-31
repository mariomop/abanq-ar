/***************************************************************************
                 i_mastertotalfacturasprov.qs  -  description
                             -------------------
    begin                : mie oct 31 2007
    copyright            : (C) 2004 by InfoSiAL S.L. Zikzakmedia S.L.
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
	function lanzar() {
		return this.ctx.oficial_lanzar();
	}
	function rellenarDatos(cursor:FLSqlCursor) {
		return this.ctx.oficial_rellenarDatos(cursor);
	}
	function vaciarDatos() {
		return this.ctx.oficial_vaciarDatos();
	}
	function limpiarBuffer() {
		return this.ctx.oficial_limpiarBuffer();
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends oficial {
    function head( context ) { oficial ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
	function pub_rellenarDatos(cursor:FLSqlCursor) {
		return this.rellenarDatos(cursor);
	}
	function pub_vaciarDatos() {
		return this.vaciarDatos();
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
	connect (this.child("toolButtonPrint"), "clicked()", this, "iface.lanzar()");
	connect (this.child("toolButtonLimpiarBuffer"), "clicked()", this, "iface.limpiarBuffer()");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_lanzar()
{
	var cursor:FLSqlCursor = this.cursor();
	var seleccion:String = cursor.valueBuffer("id");
	if (!seleccion)
		return;

	if (cursor.valueBuffer("codintervalo")) {
		var intervalo:Array = [];
		intervalo = flfactppal.iface.pub_calcularIntervalo(cursor.valueBuffer("codintervalo"));
		cursor.setValueBuffer("fechadesde", intervalo.desde);
		cursor.setValueBuffer("fechahasta", intervalo.hasta);
	}

	if (!this.iface.rellenarDatos())
		return;

	var nombreInforme:String = "i_totalfacturas"; //cursor.action();
	var orderBy:String = ""; //i_totalfacturas_buffer.fecha";
	var where:String = "i_totalfacturas_buffer.idsesion = '" + sys.idSession() + "'"; // AND i_totalfacturasprov.id = " + seleccion;
	flfactinfo.iface.pub_lanzarInforme(cursor, nombreInforme, orderBy, false, false, false, where);

	this.iface.vaciarDatos();
}

function oficial_rellenarDatos(cursor:FLSqlCursor)
{
	if (!cursor)
		cursor = this.cursor();
	var util:FLUtil = new FLUtil();
	
	var curTab:FLSqlCursor = new FLSqlCursor("i_totalfacturas_buffer");
 	var paso:Number = 0;
 	
 	var idSesion = sys.idSession();
	
	var fechaDesde = cursor.valueBuffer("fechadesde");
	var fechaHasta = cursor.valueBuffer("fechahasta");
	var codigoDesde:String = cursor.valueBuffer("codigodesde");
	var codigoHasta:String = cursor.valueBuffer("codigohasta");
	var codproveedor:String = cursor.valueBuffer("codproveedor");
	var codserie:String = cursor.valueBuffer("codserie");

	var tipo_total:String = cursor.valueBuffer("tipo_total");
	if (tipo_total == "") tipo_total = "Diarios";

	var q:FLSqlQuery;
	var where:String = "1=1";
	var referencia:String, descripcion:String, nombre:String;
	var movimiento:String, cantidad:Number, precio:Number;
	var fechaFactura:String, fechaAlbaran:String;
	var codFactura:String, codAlbaran:String;

	// PASO 1
	if (fechaDesde)
		where += " AND fecha >= '" + fechaDesde + "'";
	if (fechaHasta)
		where += " AND fecha <= '" + fechaHasta + "'";

	if (codigoDesde)
		where += " AND codigo >= '" + codigoDesde + "'";
	if (codigoHasta)
		where += " AND codigo <= '" + codigoHasta + "'";

	if (codproveedor)
		where += " AND codproveedor = '" + codproveedor + "'";
	if (codserie)
		where += " AND codserie = '" + codserie + "'";

	where += " GROUP BY fecha";

	q = new FLSqlQuery();
	q.setTablesList("facturasprov");
	q.setSelect("fecha,SUM(neto) as neto,SUM(totaliva) as totaliva,SUM(totaleuros) as totaleuros,COUNT(*) as numero");
	q.setFrom("facturasprov");
	q.setWhere(where);
	q.setOrderBy("fecha");
//debug(q.sql());

	paso = 0;

	if (!q.exec()) {
		MessageBox.critical(util.translate("scripts", "Falló la consulta"),
				MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return;
	}

	util.createProgressDialog( util.translate( "scripts", "Recabando datos..." ), q.size() );

	curTab.setModeAccess(curTab.Insert);
	curTab.refreshBuffer();
	var fecha:String, fecha_ant:String = "NULL";
	while(q.next()) {

		util.setProgress(paso++);

		util.setLabelText(util.translate( "scripts", "Recabando datos de ventas" ));
		
		fecha = q.value(0);
		switch (tipo_total) {
		case "Diarios": {
			fecha = flfactppal.iface.pub_cerosIzquierda(fecha.getDate().toString(),2) + "-" + flfactppal.iface.pub_cerosIzquierda(fecha.getMonth().toString(),2) + "-" + fecha.getYear().toString();
			if (fecha_ant != "NULL") {
				curTab.commitBuffer();
				curTab.setModeAccess(curTab.Insert);
				curTab.refreshBuffer();
			}
			break;
		}
		case "Mensuales": {
			fecha = flfactppal.iface.pub_cerosIzquierda(fecha.getMonth().toString(),2) + "-" + fecha.getYear().toString();
			if (fecha != fecha_ant && fecha_ant != "NULL") {
				curTab.commitBuffer();
				curTab.setModeAccess(curTab.Insert);
				curTab.refreshBuffer();
			}
			break;
		}
		case "Trimestrales": {
			fecha = Math.floor((fecha.getMonth()-1)/3)+1 + "T-" + fecha.getYear().toString();
//debug(fecha_ant +" "+ fecha);
			if (fecha != fecha_ant && fecha_ant != "NULL") {
				curTab.commitBuffer();
				curTab.setModeAccess(curTab.Insert);
				curTab.refreshBuffer();
			}
			break;
		}
		}
		curTab.setValueBuffer("fecha", fecha);
		curTab.setValueBuffer("neto",        curTab.valueBuffer("neto")+q.value(1));
		curTab.setValueBuffer("totaliva",    curTab.valueBuffer("totaliva")+q.value(2));
		curTab.setValueBuffer("totaleuros",  curTab.valueBuffer("totaleuros")+q.value(3));
		if (curTab.valueBuffer("numero") == "")
			curTab.setValueBuffer("numero", 0);
		curTab.setValueBuffer("numero",      parseInt(curTab.valueBuffer("numero"))+q.value(4));
		curTab.setValueBuffer("idsesion", idSesion);
		curTab.setValueBuffer("tipo_total", util.translate("scripts", tipo_total));
		fecha_ant = fecha;
	}
	if (fecha_ant != "NULL")
		curTab.commitBuffer();

	util.destroyProgressDialog();
	if (paso == 0) {
		MessageBox.warning(util.translate("scripts",
				"No hay registros que cumplan los criterios de búsqueda establecidos"),
				MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

	return true;
}

function oficial_vaciarDatos()
{
	var util:FLUtil = new FLUtil();
	if (util.sqlDelete("i_totalfacturas_buffer", "idsesion = '" + sys.idSession() + "'"))
		return true;
	
	return false
}


function oficial_limpiarBuffer()
{
	var util:FLUtil = new FLUtil();
	if (util.sqlDelete("i_totalfacturas_buffer", "1=1"))
		MessageBox.information(util.translate("scripts", "Se vació el buffer"),
				MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
