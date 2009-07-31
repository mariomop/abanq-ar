/***************************************************************************
                 stocks.qs  -  description
                             -------------------
    begin                : lun sep 26 2005
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

/** @class_declaration lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
class lotes extends interna {
    var porLotes:Boolean;
	function lotes( context ) { interna ( context ); }
	function init() {
		return this.ctx.lotes_init();
	}
	function tbnTransferencia_clicked() {
		return this.ctx.lotes_tbnTransferencia_clicked();
	}
	function calcularCantidad() {
		return this.ctx.lotes_calcularCantidad();
	}
	function calculateField(fN:String):String {
		return this.ctx.lotes_calculateField(fN);
	}
	function borrarRegistro() { 
		return this.ctx.lotes_borrarRegistro();
	}
	function editarRegistro() { 
		return this.ctx.lotes_editarRegistro();
	}
}
//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends lotes {
    function head( context ) { lotes ( context ); }
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

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
/** \C Si el stock seleccionado corresponde a un artículo con control de lotes, la tabla de movimientos asociados se habilitará, mostrando los movimientos asociados al stock seleccionado. Los movimientos mostrados serán los asociados al stock que correspondan a lotes activos, es decir, que su campo 'En almacén' no sea 0, o su fecha de caducidad no se haya cumplido

Al pulsar sobre el botón 'Crear regularización', se abrirá la ventana de movimientos de stock para que el usuario cree un movimiento de tipo 'Regularización'. Sólo se permitirá editar los movimientos de dicho tipo. 

Al pulsar sobre el botón 'Transferencia' se abrirá el formulario de transferencias
*/
function lotes_init()
{
	connect(this.child("tbnTransferencia"), "clicked()", this, "iface.tbnTransferencia_clicked");
	connect(this.child("toolButtonEditMovi"), "clicked()", this, "iface.editarRegistro()");
	connect(this.child("toolButtonDeleteMov"), "clicked()", this, "iface.borrarRegistro()");
	connect(this.child("tdbMoviLote").cursor(), "bufferCommited()", this, "iface.calcularCantidad");
	
	
	
	var curRelacionado:FLSqlCursor = this.cursor().cursorRelation();
	
	if(!curRelacionado.valueBuffer("porlotes")){
		this.iface.porLotes = false;
		this.child("gbxMovimientod").setDisabled(true);
	}
	else {
		this.iface.porLotes = true;
		var qLotes:FLSqlQuery = new FLSqlQuery();
		qLotes.setTablesList("lotes");
		qLotes.setFrom("lotes");
		qLotes.setSelect("codlote");
		qLotes.setWhere("referencia = '" + curRelacionado.valueBuffer("referencia") + "' AND (enalmacen > 0 OR caducidad > CURRENT_DATE)");
	
		if (!qLotes.exec()) 
			return false;
	
		var lista:String = "";
		while(qLotes.next())
			lista += "'" + qLotes.value(0) + "',";
		lista = lista.left(lista.length -1)
		if(lista != "")
			this.child("tdbMoviLote").cursor().setMainFilter("codlote IN (" + lista + ")");
		this.child("tdbMoviLote").refresh();
		this.iface.calcularCantidad();
		this.child("fdbCantidad").setDisabled(true);
	}
	
	this.iface.calcularCantidad();
}


/** \D Sólo permite borrar registros en los que el campo --tipo-- sea Regularización
\end */
function lotes_borrarRegistro() {

	var util:FLUtil = new FLUtil();
	var curMoviLotes:FLSqlCursor = this.child("tdbMoviLote").cursor();
	
	if(this.child("tdbMoviLote").cursor().valueBuffer("tipo") == "Regularización"){
		var res = MessageBox.information(util.translate("scripts","El registro activo será borrado. ¿Está seguro?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
		if(res == MessageBox.Yes){
			curMoviLotes.setModeAccess(curMoviLotes.Del);
			curMoviLotes.commitBuffer();
			curMoviLotes.refresh();
		}
	}
	else
		 MessageBox.warning(util.translate("scripts","Sólo puede borrar registros de tipo Regularización"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}	


/** \D Sólo permite modificar registros en los que el campo --tipo-- sea Regularización
\end */
function lotes_editarRegistro() {

	var util:FLUtil = new FLUtil();
	var curMoviLotes:FLSqlCursor = this.child("tdbMoviLote").cursor();

	if(this.child("tdbMoviLote").cursor().valueBuffer("tipo") == "Regularización")
		curMoviLotes.editRecord();
	else
		MessageBox.warning(util.translate("scripts","Sólo puede editar registros de tipo Regularización"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}	
/** \D Función usada para conectar el evento de cambio de movimientos con el recálculo de la cantidad
\end */
function lotes_calcularCantidad()
{
	this.cursor().setValueBuffer("cantidad", this.iface.calculateField("cantidad"));
}

function lotes_calculateField(fN:String):String
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var res:String;
	switch (fN) {
		case "cantidad": {
			if (this.iface.porLotes) {
				res = util.sqlSelect("movilote", "SUM(cantidad)", "idstock = " + cursor.valueBuffer("idstock")); 
			} else
				res = 0
			break;
		}
		default:
			res = 0
	}
	return res;
}


/* \D Abre el formulario de transferencias de lotes
\end */
function lotes_tbnTransferencia_clicked()
{
	var f:Object = new FLFormSearchDB("translote");
	var curTrans:FLSqlCursor = f.cursor();
	var cursor:FLSqlCursor = this.cursor();

	curTrans.select();
	if (!curTrans.first())
		curTrans.setModeAccess(curTrans.Insert);
	else
		curTrans.setModeAccess(curTrans.Edit);
	
	var idStock:Number = cursor.valueBuffer("idstock");
		
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("movilote");
	q.setFrom("movilote");
	q.setSelect("codlote, SUM(cantidad)");
	q.setWhere("idstock = "+ idStock + " GROUP BY codlote ORDER BY SUM(cantidad) DESC");
	
	if (!q.exec()) 
		return false;
	
	if (!q.first()) 
		return false;
	
	var util:FLUtil = new FLUtil();
	var fechaActual:Date = new Date();
	var stockDestino:Number = util.sqlSelect("stocks","idstock","referencia = '" + cursor.valueBuffer("referencia") + "'");
	curTrans.refreshBuffer();
	curTrans.setValueBuffer("idstockorigen", idStock);
	curTrans.setValueBuffer("idstockdestino",stockDestino);
	curTrans.setValueBuffer("codloteorigen",q.value(0));
	curTrans.setValueBuffer("codlotedestino", q.value(0));
	curTrans.setValueBuffer("fecha",fechaActual);
	curTrans.setValueBuffer("cantidad", q.value(1));
	curTrans.commitBuffer();
	
	curTrans.select();
	curTrans.first();
	curTrans.setModeAccess(curTrans.Edit);
	
	var util:FLUtil = new FLUtil();
	
	f.setMainWidget();
	var idTrans:String = f.exec("id");
	if (idTrans) {
	
		var curMoviLotes:FLSqlCursor = new FLSqlCursor("movilote");
		curMoviLotes.setModeAccess(curMoviLotes.Insert)
		curMoviLotes.refreshBuffer();
		curMoviLotes.setValueBuffer("codlote",curTrans.valueBuffer("codloteorigen"));
		curMoviLotes.setValueBuffer("fecha",curTrans.valueBuffer("fecha"));
		curMoviLotes.setValueBuffer("tipo","Regularización");
		curMoviLotes.setValueBuffer("docorigen","NO");
		curMoviLotes.setValueBuffer("idstock",curTrans.valueBuffer("idstockorigen"));
		curMoviLotes.setValueBuffer("cantidad","-" + curTrans.valueBuffer("cantidad"));
		curMoviLotes.setValueBuffer("descripcion",curTrans.valueBuffer("descripcion"));
		if(!curMoviLotes.commitBuffer())
			return false; 
		var idMovi1:Number = curMoviLotes.valueBuffer("id");
		curMoviLotes.setModeAccess(curMoviLotes.Insert)
		curMoviLotes.refreshBuffer();
		curMoviLotes.setValueBuffer("codlote",curTrans.valueBuffer("codlotedestino"));
		curMoviLotes.setValueBuffer("fecha",curTrans.valueBuffer("fecha"));
		curMoviLotes.setValueBuffer("tipo","Regularización");
		curMoviLotes.setValueBuffer("docorigen","NO");
		curMoviLotes.setValueBuffer("idstock",curTrans.valueBuffer("idstockdestino"));
		curMoviLotes.setValueBuffer("cantidad",curTrans.valueBuffer("cantidad"));
		curMoviLotes.setValueBuffer("descripcion",curTrans.valueBuffer("descripcion"));
		curMoviLotes.setValueBuffer("idtrans",idMovi1);
		if(!curMoviLotes.commitBuffer())
			return false;
		var idMovi2:Number = curMoviLotes.valueBuffer("id");
		curMoviLotes.select("id = " + idMovi1);
		curMoviLotes.first();
		curMoviLotes.setModeAccess(curMoviLotes.Edit)
		curMoviLotes.refreshBuffer();
		curMoviLotes.setValueBuffer("codlote",curTrans.valueBuffer("codloteorigen"));
		curMoviLotes.setValueBuffer("fecha",curTrans.valueBuffer("fecha"));
		curMoviLotes.setValueBuffer("tipo","Regularización");
		curMoviLotes.setValueBuffer("docorigen","NO");
		curMoviLotes.setValueBuffer("idstock",curTrans.valueBuffer("idstockorigen"));
		curMoviLotes.setValueBuffer("cantidad","-" + curTrans.valueBuffer("cantidad"));
		curMoviLotes.setValueBuffer("descripcion",curTrans.valueBuffer("descripcion"));
		curMoviLotes.setValueBuffer("idtrans",idMovi2);
		if(!curMoviLotes.commitBuffer())
			return false; 
		this.child("tdbMoviLote").refresh();
		
		return true;
	}
}

//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////