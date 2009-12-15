/***************************************************************************
                 masterfamilias.qs  -  description
                             -------------------
    begin                : lun abr 26 2006
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

/** \D Sólo familias de primer nivel
*/
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
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration silixSeleccionar */
/////////////////////////////////////////////////////////////////
//// SILIXSELECCIONAR ///////////////////////////////////////////
class silixSeleccionar extends oficial {
	var tdbRecords:FLTableDB;

    function silixSeleccionar( context ) { oficial ( context ); }
	function init() {
		this.ctx.silixSeleccionar_init();
	}
	function seleccionCheckOnOff() {
		this.ctx.silixSeleccionar_seleccionCheckOnOff();
	}
	function seleccionVerificarHabilitaciones() {
		this.ctx.silixSeleccionar_seleccionVerificarHabilitaciones();
	}
	function seleccionTodo() {
		this.ctx.silixSeleccionar_seleccionTodo();
	}
	function seleccionNada() {
		this.ctx.silixSeleccionar_seleccionNada();
	}

	function pbnAccionAlmacen_clicked() {
		this.ctx.silixSeleccionar_pbnAccionAlmacen_clicked();
	}
	function lanzarAccion_almacenMarcacion(curAccion:FLSqlCursor) {
		this.ctx.silixSeleccionar_lanzarAccion_almacenMarcacion(curAccion);
	}
	function lanzarAccion_almacenFamiliaMadre(curAccion:FLSqlCursor) {
		this.ctx.silixSeleccionar_lanzarAccion_almacenFamiliaMadre(curAccion);
	}
	function lanzarAccion_almacenUnidad(curAccion:FLSqlCursor) {
		this.ctx.silixSeleccionar_lanzarAccion_almacenUnidad(curAccion);
	}

}
//// SILIXSELECCIONAR ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends silixSeleccionar {
    function head( context ) { silixSeleccionar ( context ); }
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

/** \D Sólo mostramos familias de primer nivel
*/
function interna_init()
{
// 	this.child("tableDBRecords").cursor().setMainFilter("codmadre = ''");
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition silixSeleccionar */
/////////////////////////////////////////////////////////////////
//// SILIXSELECCIONAR //////////////////////////////////////////////////

function silixSeleccionar_init()
{
	this.iface.__init();

	this.iface.tdbRecords = this.child("tableDBRecords");

	connect(this.child("pbnCheckOnOff"), "clicked()", this, "iface.seleccionCheckOnOff");

	connect(this.child("pbnSeleccionarTodo"), "clicked()", this, "iface.seleccionTodo");
	connect(this.child("pbnSeleccionarNada"), "clicked()", this, "iface.seleccionNada");

	connect(this.child("pbnAccionAlmacen"), "clicked()", this, "iface.pbnAccionAlmacen_clicked()");

	this.iface.seleccionVerificarHabilitaciones();
}

function silixSeleccionar_seleccionCheckOnOff()
{
	if ( this.iface.tdbRecords.checkColumnEnabled ) {
		// Deshabilitar check
		this.iface.tdbRecords.clearChecked();
		this.iface.tdbRecords.setCheckColumnEnabled(false);
		this.iface.tdbRecords.setOrderCols(this.iface.tdbRecords.orderCols());
		this.iface.tdbRecords.refresh();
	} else {
		// Habilitar check
		this.iface.tdbRecords.setCheckColumnEnabled(true);
		this.iface.tdbRecords.refresh();
		this.iface.tdbRecords.setOrderCols(this.iface.tdbRecords.orderCols());
	}

	this.iface.tdbRecords.setFocus();
	this.iface.seleccionVerificarHabilitaciones();
}

function silixSeleccionar_seleccionVerificarHabilitaciones()
{
	if ( this.iface.tdbRecords.checkColumnEnabled ) {
		// Check habilitado
		this.child("pbnCheckOnOff").setOn(true);

		this.child("pbnSeleccionarTodo").setDisabled(false);
		this.child("pbnSeleccionarNada").setDisabled(false);

		this.child("pbnAccionAlmacen").setDisabled(false);
	}
	else {
		// Check deshabilitado
		this.child("pbnCheckOnOff").setOn(false);

		this.child("pbnSeleccionarTodo").setDisabled(true);
		this.child("pbnSeleccionarNada").setDisabled(true);

		this.child("pbnAccionAlmacen").setDisabled(true);
	}
}

function silixSeleccionar_seleccionTodo()
{
	var util:FLUtil = new FLUtil();

	var cursor:FLSqlCursor = new FLSqlCursor("familias");
	cursor.setMainFilter(this.iface.tdbRecords.filter());
	cursor.select();

	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Seleccionando %1 familias..." ).arg(cursor.size()), cursor.size() );

	while (cursor.next()) {
		this.iface.tdbRecords.setPrimaryKeyChecked(cursor.valueBuffer("codfamilia"), true)
		util.setProgress( ++paso );
	}
	util.destroyProgressDialog();
	this.iface.tdbRecords.refresh();
}

function silixSeleccionar_seleccionNada()
{
	this.iface.tdbRecords.clearChecked();
	this.iface.tdbRecords.refresh();
}

function silixSeleccionar_pbnAccionAlmacen_clicked()
{
	var f:Object = new FLFormSearchDB("acciones_familiasalmacen");
	var cursor:FLSqlCursor = f.cursor();

	cursor.select();
	if (!cursor.first())
		cursor.setModeAccess(cursor.Insert);
	else
		cursor.setModeAccess(cursor.Edit);

	f.setMainWidget();
	cursor.refreshBuffer();
	var commitOk:Boolean = false;
	var acpt:Boolean;
	cursor.transaction(false);
	while (!commitOk) {
		acpt = false;
		f.exec("id");
		acpt = f.accepted();
		if (!acpt) {
			if (cursor.rollback())
				commitOk = true;
		} else {
			if (cursor.commitBuffer()) {
				cursor.commit();
				commitOk = true;
			}
		}
	}
	if (!acpt)
		return;

	if ( f.child("ckbMarcacion").checked )
		this.iface.lanzarAccion_almacenMarcacion(cursor);

	if ( f.child("ckbFamiliaMadre").checked )
		this.iface.lanzarAccion_almacenFamiliaMadre(cursor);

	if ( f.child("ckbUnidad").checked )
		this.iface.lanzarAccion_almacenUnidad(cursor);
}

function silixSeleccionar_lanzarAccion_almacenMarcacion(curAccion:FLSqlCursor)
{
	var util:FLUtil = new FLUtil();

	var datos:String = [];
	datos = this.iface.tdbRecords.primarysKeysChecked();
	var lista:String = datos.join();
	if (!lista)
		return;

	var curFamilias:FLSqlCursor = new FLSqlCursor("familias");
	curFamilias.setMainFilter(this.iface.tdbRecords.filter());
	curFamilias.select("codfamilia IN ('" + lista.replace(/,/g,"', '") + "')");

	var marcacion:Number = curAccion.valueBuffer("marcacion");
	if (!marcacion || isNaN(marcacion))
		marcacion = 0;

	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Ejecutando acción..." ), curFamilias.size() );

	while (curFamilias.next()) {
		curFamilias.setModeAccess(curFamilias.Edit);
		curFamilias.refreshBuffer();

		curFamilias.setValueBuffer("marcacion", marcacion);

		if (!curFamilias.commitBuffer()) {
			MessageBox.critical(util.translate("scripts", "Se produjo un error al ejecutar la acción"), MessageBox.Ok, MessageBox.NoButton);
			util.destroyProgressDialog();
			return;
		}
		util.setProgress( ++paso );
	}
	util.destroyProgressDialog();
	MessageBox.information(util.translate("scripts", "Acción completada"), MessageBox.Ok, MessageBox.NoButton);
}

function silixSeleccionar_lanzarAccion_almacenFamiliaMadre(curAccion:FLSqlCursor)
{
	var util:FLUtil = new FLUtil();

	var datos:String = [];
	datos = this.iface.tdbRecords.primarysKeysChecked();
	var lista:String = datos.join();
	if (!lista)
		return;

	var curFamilias:FLSqlCursor = new FLSqlCursor("familias");
	curFamilias.setMainFilter(this.iface.tdbRecords.filter());
	curFamilias.select("codfamilia IN ('" + lista.replace(/,/g,"', '") + "')");

	var descExtFamiliaMadre:String = "";
	if (curAccion.valueBuffer("codmadre")) {
		descExtFamiliaMadre = util.sqlSelect("familias", "descripcionextendida", "codfamilia = '" + curAccion.valueBuffer("codmadre") + "'");
		descExtFamiliaMadre += " > ";
	}

	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Ejecutando acción..." ), curFamilias.size() );

	while (curFamilias.next()) {
		curFamilias.setModeAccess(curFamilias.Edit);
		curFamilias.refreshBuffer();

		if (curFamilias.valueBuffer("codfamilia") != curAccion.valueBuffer("codmadre")) {
			curFamilias.setValueBuffer("codmadre", curAccion.valueBuffer("codmadre"));
			curFamilias.setValueBuffer("descripcionextendida", descExtFamiliaMadre + curFamilias.valueBuffer("descripcion"));
		}

		if (!curFamilias.commitBuffer()) {
			MessageBox.critical(util.translate("scripts", "Se produjo un error al ejecutar la acción"), MessageBox.Ok, MessageBox.NoButton);
			util.destroyProgressDialog();
			return;
		}
		util.setProgress( ++paso );
	}
	util.destroyProgressDialog();
	MessageBox.information(util.translate("scripts", "Acción completada"), MessageBox.Ok, MessageBox.NoButton);
}

function silixSeleccionar_lanzarAccion_almacenUnidad(curAccion:FLSqlCursor)
{
	var util:FLUtil = new FLUtil();

	var datos:String = [];
	datos = this.iface.tdbRecords.primarysKeysChecked();
	var lista:String = datos.join();
	if (!lista)
		return;

	var curFamilias:FLSqlCursor = new FLSqlCursor("familias");
	curFamilias.setMainFilter(this.iface.tdbRecords.filter());
	curFamilias.select("codfamilia IN ('" + lista.replace(/,/g,"', '") + "')");

	var paso:Number = 0;
	util.createProgressDialog( util.translate( "scripts", "Ejecutando acción..." ), curFamilias.size() );

	while (curFamilias.next()) {
		curFamilias.setModeAccess(curFamilias.Edit);
		curFamilias.refreshBuffer();

		curFamilias.setValueBuffer("codunidad", curAccion.valueBuffer("codunidad"));

		if (!curFamilias.commitBuffer()) {
			MessageBox.critical(util.translate("scripts", "Se produjo un error al ejecutar la acción"), MessageBox.Ok, MessageBox.NoButton);
			util.destroyProgressDialog();
			return;
		}
		util.setProgress( ++paso );
	}
	util.destroyProgressDialog();
	MessageBox.information(util.translate("scripts", "Acción completada"), MessageBox.Ok, MessageBox.NoButton);
}

//// SILIXSELECCIONAR ///////////////////////////////////////////
////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
