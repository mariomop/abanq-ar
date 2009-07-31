/***************************************************************************
                 seleccionarticulos.qs  -  descripcion
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
	var pbnRStockOrd:Object;
	var tdbArticulos:Object;
	var tdbArticulosSel:Object;
	
    function oficial( context ) { interna( context ); } 
	function desconectar() {
		return this.ctx.oficial_desconectar();
	}
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function pbnResetearStockOrd_clicked() {
		return this.ctx.oficial_pbnResetearStockOrd_clicked();
	}
	function seleccionar() {
		return this.ctx.oficial_seleccionar();
	}
	function seleccionarTodos() {
		return this.ctx.oficial_seleccionarTodos();
	}
	function quitar() {
		return this.ctx.oficial_quitar();
	}
	function quitarTodos() {
		return this.ctx.oficial_quitarTodos();
	}
	function refrescarTablas() {
		return this.ctx.oficial_refrescarTablas();
	}
	function establecerFiltro() {
		return this.ctx.oficial_establecerFiltro();
	}
	function isNumeric(checkstring:String):Boolean {
		return this.ctx.oficial_isNumeric(checkstring);
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
Este formulario muestra una lista de lineas de proveedor que cumplen un determinado filtro, y permite al usuario seleccionar uno o más lineas de la lista
\end */
function interna_init()
{
	var cursor:FLSqlCursor = this.cursor();
	
	this.iface.pbnRStockOrd = this.child("pbnResetearStockOrd");
	this.iface.tdbArticulos = this.child("tdbArticulos");
	this.iface.tdbArticulosSel = this.child("tdbArticulosSel");
	
	this.iface.tdbArticulos.setReadOnly(true);
	this.iface.tdbArticulosSel.setReadOnly(true);
	
	this.child("chkFiltrarArtProv").checked = "true";
	this.child("chkFiltrarArtStockFis").checked = "true";
	this.child("chkFiltrarArtStockMin").checked = "true";
	this.child("chkFiltrarArtStockOrd").checked = "true";
	
	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.iface.pbnRStockOrd, "clicked()", this, "iface.pbnResetearStockOrd_clicked");
	connect(this.child("chkFiltrarArtProv"), "clicked()", this, "iface.refrescarTablas");
	connect(this.child("chkFiltrarArtStockFis"), "clicked()", this, "iface.refrescarTablas");
	connect(this.child("chkFiltrarArtStockMin"), "clicked()", this, "iface.refrescarTablas");
	connect(this.child("chkFiltrarArtStockOrd"), "clicked()", this, "iface.refrescarTablas");
	connect(this.iface.tdbArticulos.cursor(), "recordChoosed()", this, "iface.seleccionar()");
	connect(this.iface.tdbArticulosSel.cursor(), "recordChoosed()", this, "iface.quitar()");
	connect(this.child("pbnSeleccionar"), "clicked()", this, "iface.seleccionar()");
	connect(this.child("pbnSeleccionarTodos"), "clicked()", this, "iface.seleccionarTodos()");
	connect(this.child("pbnQuitar"), "clicked()", this, "iface.quitar()");
	connect(this.child("pbnQuitarTodos"), "clicked()", this, "iface.quitarTodos()");
	connect(form, "closed()", this, "iface.desconectar");
	
	this.iface.refrescarTablas();
	this.child("fdbProveedor").setFocus();

}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_desconectar()
{
	disconnect(this.cursor(), "bufferChanged(QString)", this, "iface.bufferChanged");
	disconnect(this.child("chkFiltrarArtProv"), "clicked()", this, "iface.filtrarArtProv");
	disconnect(this.child("chkFiltrarArtStockFis"), "clicked()", this, "iface.filtrarArtStockFis");
	disconnect(this.child("chkFiltrarArtStockMin"), "clicked()", this, "iface.filtrarArtStockMin");
}

/** \C
\end */
function oficial_bufferChanged(fN:String)
{
	switch(fN) {
		case "codproveedor":
			var codProveedor:String = this.cursor().valueBuffer("codproveedor");
			if (!codProveedor)
				return;			
			var miVar:FLVar = new FLVar();
			if (!miVar.set("CODPROVTEMP", codProveedor))
				return false;
			this.iface.refrescarTablas();
			break;
		case "cantidadmin":
			this.iface.refrescarTablas();
			break;
	}
}


/** \C
Al pulsar el botón de resetear les unidades pedidos 
\end */
function oficial_pbnResetearStockOrd_clicked()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	var codProveedor:String = cursor.valueBuffer("codproveedor");
	var res:Number = MessageBox.warning(util.translate("scripts", "Esta acción reseteará todas las unidades pedidas\n pendientes de servir en pedidos automáticos para este proveedor!\n\n¿Estás seguro?"), MessageBox.Ok, MessageBox.Cancel);
	if (res == MessageBox.Cancel)
		return;
	
	var clausulaSelect:String = "referencia IN (SELECT referencia FROM articulosprov WHERE codproveedor = '" + codProveedor + "')";
	
	var curArticulos:FLSqlCursor = new FLSqlCursor("articulos");
	curArticulos.select(clausulaSelect);
	while (curArticulos.next()) {
		curArticulos.setModeAccess(curArticulos.Edit);
		curArticulos.refreshBuffer();
		// curArticulos.setAtomicValueBuffer("stockord", 0); 
		curArticulos.setValueBuffer("stockord", 0);
	if (!curArticulos.commitBuffer())
			return false;
	}

	return true;
}

/** \D Refresca las tablas, en función del filtro y de los datos seleccionados hasta el momento
*/
function oficial_refrescarTablas()
{
	var datos:String = this.cursor().valueBuffer("datos");
	this.iface.establecerFiltro();
	var filtro:String = this.cursor().valueBuffer("filtro");
	
	if (filtro && filtro != "")
		filtro += " AND ";
	if (!datos || datos == "") {
		this.iface.tdbArticulos.setFilter(filtro + "1 = 1");
		this.iface.tdbArticulosSel.setFilter(filtro + "1 = 2");
	} else {
		// cost ~ 8700
		this.iface.tdbArticulos.setFilter(filtro + "articulos.referencia NOT IN (" + datos + ")");
		// first statement in filter has to be 1=1 to workaround bug 1780329 
		// cost ~ 4100
		this.iface.tdbArticulosSel.setFilter("1=1 AND articulos.referencia IN (" + datos + ")");
	}
	debug(this.iface.tdbArticulos.cursor().mainFilter());
	this.iface.tdbArticulos.refresh();
	this.iface.tdbArticulosSel.refresh();
}

/** \D Incluye un articulo en la lista de datos
*/
function oficial_seleccionar()
{
	var cursor:FLSqlCursor = this.cursor();
	var datos:String = cursor.valueBuffer("datos");
	var referencia:String = this.iface.tdbArticulos.cursor().valueBuffer("referencia");
	if (!referencia)
		return;
	if (!datos || datos == "")
		datos = "'" + referencia + "'";
	else
		datos += "," + "'" + referencia + "'";
		
	cursor.setValueBuffer("datos", datos);
	
	this.iface.refrescarTablas();
}

/** \D Incluye todos los articulos en la lista de datos
*/
function oficial_seleccionarTodos()
{debug(1);
	var cursor:FLSqlCursor = this.cursor();
	var datos:String = cursor.valueBuffer("datos");
	var curLineas:FLSqlCursor = this.iface.tdbArticulos.cursor();
	switch (curLineas.size()) {
		case 0: {debug(curLineas.size());
			return;
		}
		default: {debug("default");debug(curLineas.size());
			curLineas.first();
			referencia = curLineas.valueBuffer("referencia");
debug(datos);
debug(referencia);
			if (!datos || datos == "")
				datos = "'" + referencia + "'";
			else
				datos += "," + "'" + referencia + "'";
			
			while (curLineas.next()) {
				referencia = curLineas.valueBuffer("referencia");
debug(datos);
debug(referencia);
				if (!datos || datos == "")
					datos = "'" + referencia + "'";
				else
					datos += "," + "'" + referencia + "'";
			}
		break;
		}
	}
	debug(2);
	cursor.setValueBuffer("datos", datos);
	this.iface.refrescarTablas();
debug("fin");
}

/** \D Quira un articulo de la lista de datos
*/
function oficial_quitar()
{
	var cursor:FLSqlCursor = this.cursor();
	var datos:String = cursor.valueBuffer("datos");
	var referencia:String = this.iface.tdbArticulosSel.cursor().valueBuffer("referencia");
	if (!referencia)
		return;
	
	if (!datos || datos == "")
		return;
	var lineas:Array = datos.split(",");
	var datosNuevos:String = "";
	for (var i:Number = 0; i < lineas.length; i++) {
		if (lineas[i] != "'" + referencia + "'") {
			if (datosNuevos == "") 
				datosNuevos = lineas[i];
			else
				datosNuevos += "," + lineas[i];
		}
	}
	cursor.setValueBuffer("datos", datosNuevos);
	this.iface.refrescarTablas();
}

/** \D Quira todos los articulos de la lista de datos
*/
function oficial_quitarTodos()
{
	var cursor:FLSqlCursor = this.cursor();
	cursor.setValueBuffer("datos", "");
	this.iface.refrescarTablas();
}

/** \D Muestra únicamente los artículos que cumplen un determinado filtro
*/
function oficial_establecerFiltro()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	
	var filtro:String = "articulos.auslaufartikel = FALSE";
	if (this.child("chkFiltrarArtProv").checked)
		filtro += " AND articulosprov.codproveedor = '" + cursor.valueBuffer("codproveedor") + "'";
			
	if (this.child("chkFiltrarArtStockOrd").checked)
		filtro += " AND articulos.stockmin - articulos.stockfis - articulos.stockord >= " + cursor.valueBuffer("cantidadmin");
	else
		if (this.child("chkFiltrarArtStockFis").checked)
			filtro += " AND articulos.stockord < articulos.stockmin";

	if (this.child("chkFiltrarArtStockMin").checked)
		filtro += " AND articulos.stockmin > 0";
			
			
	var q:FLSqlQuery = new FLSqlQuery("qry_articulos_composed");
	q.setSelect("articulos.referencia, articulosprov.id");
	q.setWhere(filtro);
	q.setOrderBy("articulos.referencia");
	q.exec();
	var lastRef:String = "";
	var excluir:String = "";
	while(q.next()) {
		if (q.value(0) == lastRef) {
			if (excluir) excluir += ",";
			excluir += q.value(1);
		}
		lastRef = q.value(0);
	}
	
	if (excluir)
		filtro += " AND (articulosprov.id is null OR articulosprov.id NOT IN (" + excluir + "))";
			
	debug(filtro);
	
	cursor.setValueBuffer("filtro", filtro);
}

function oficial_isNumeric(checkstring:String):Boolean
{
   var validChars:String = "0123456789.";
   var isNumber:Boolean = true;
   var charPos:String;

   for (i = 0; i < checkstring.length && isNumber == true; i++) {
      charPos = checkstring.charAt(i);
      if (validChars.indexOf(charPos) == -1)
         isNumber = false;
   }
   return isNumber;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
