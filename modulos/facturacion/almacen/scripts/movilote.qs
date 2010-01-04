/***************************************************************************
                 movilote.qs  -  description
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
	function init() {
		return this.ctx.interna_init();
	}
	function validateForm():Boolean {
		return this.ctx.interna_validateForm();
	}

}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
/////////////////////////////////////////////////////////////////
//// OFICIAL ////////////////////////////////////////////////////
class oficial extends interna {
	var pbnCrearLote:Object;
    function oficial( context ) { interna ( context ); }
	function bufferChanged(fN:String) {
		this.ctx.oficial_bufferChanged(fN);
	}
	function docJustificativo() {
		return this.ctx.oficial_docJustificativo();
	}
	function pbnConsultarDocClicked() {
		return this.ctx.oficial_pbnConsultarDocClicked();
	}
	function datosMoviLote(accion:String):Array {
		return this.ctx.oficial_datosMoviLote(accion);
	}
	function tratarCantidad(accion:String):Boolean {
		return this.ctx.oficial_tratarCantidad(accion);
	}
	function crearLote_clicked():Boolean {
		return this.ctx.oficial_crearLote_clicked();
	}
}
//// OFICIAL ////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

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

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends controlUsuario {
    function head( context ) { controlUsuario ( context ); }
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
/** \C Los movimientos de lote son creados al dar de alta una línea de factura o remito, o al generar manualmente un movimiento de regularización. Los valores de  --tipo-- y --docorigen-- se seleccionarán automáticamente en base al tipo de documento que se esté creando, pudiendo modificarse el campo --tipo-- de entrada a salida o viceversa (p.e. en el caso de facturas de abono). 

El --idstock-- será el correspondiente a la referencia del artículo introducido en la línea del documento y al almacén establecido para el documento. 

En el caso de las regularizaciones el --docorigen-- tendrá el valor NO (sin documento de origen).
\end */
function interna_init()
{
	var util:FLUtil = new FLUtil();
	var curMoviLotes:FLSqlCursor = this.cursor();
	var curRelacionado:FLSqlCursor = curMoviLotes.cursorRelation();
	this.iface.pbnCrearLote = this.child("pbnCrearLote");

	if (curRelacionado.action() == "lotes")
		this.iface.pbnCrearLote.close();
	else
		connect(this.iface.pbnCrearLote, "clicked()", this, "iface.crearLote_clicked");

	connect(this.child("pbnConsultarDoc"), "clicked()", this, "iface.pbnConsultarDocClicked");
	connect(curMoviLotes, "bufferChanged(QString)", this, "iface.bufferChanged");

	switch (curMoviLotes.modeAccess()) {
		case curMoviLotes.Insert: {
			var tipo:String;
			var docOrigen:String;
			var idStock:String;
			var codAlmacen:String;
			var referencia:String = curRelacionado.valueBuffer("referencia");
			var datosMovimiento:Array = this.iface.datosMoviLote(curRelacionado.action());
			if (!datosMovimiento) {
				MessageBox.critical(util.translate("scripts", "Ha habido un error al obtener los datos del movimiento de lotes actual.\nEl formulario se cerrará"), MessageBox.Ok, MessageBox.NoButton);
				this.child("pushButtonCancel").animateClick();
				return true;
			}

			curMoviLotes.setValueBuffer("tipo", datosMovimiento.tipo);
			curMoviLotes.setValueBuffer("docorigen", datosMovimiento.docOrigen);
			curMoviLotes.setValueBuffer("idstock", datosMovimiento.idStock);

			if (curMoviLotes.valueBuffer("docorigen") == "FC" || curMoviLotes.valueBuffer("docorigen") == "RC" || curMoviLotes.valueBuffer("docorigen") == "PC") {
				var codLoteDefecto:String = util.sqlSelect("lotes", "codlote", "referencia = '" + referencia + "' AND (enalmacen > 0 AND caducidad >= CURRENT_DATE) ORDER BY caducidad ASC");
				curMoviLotes.setValueBuffer("codlote", codLoteDefecto);
			}

			if (curMoviLotes.valueBuffer("docorigen") == "PC" && !flfactppal.iface.pub_valorDefectoEmpresa("stockpedidos") && flfactppal.iface.pub_valorDefectoEmpresa("lotepedidos")) {
				curMoviLotes.setValueBuffer("reserva", true);
			}

			this.child("fdbCodLote").editor().setFocus();
			this.child("pbnConsultarDoc").setDisabled(true);
			break;
		}
		case curMoviLotes.Browse: {
			this.child("pbnCrearLote").setDisabled(true);
			break;
		}
	}

	this.child("fdbDocOrigen").setDisabled(true);
	this.child("fdbTipo").setDisabled(true);
	switch (curRelacionado.action()) {
		case "lotes": {
			if (curMoviLotes.valueBuffer("tipo") != "Regularización" && curMoviLotes.modeAccess() == curMoviLotes.Edit) {
				MessageBox.information(util.translate("scripts", "El tipo del movimiento seleccionado no es de regularización.\nPara editar este movimiento debe hacerlo desde el correspondiente remito o factura."), MessageBox.Ok, MessageBox.NoButton);
				this.child("pushButtonCancel").animateClick();
			}
			if (cursor.modeAccess() == cursor.Insert())
				this.child("fdbIdStock").setFilter("referencia = '" + curRelacionado.valueBuffer("referencia") + "'");
			else
				this.child("fdbIdStock").setDisabled(true);
			break;
		}
		default: {
			this.child("fdbIdStock").setDisabled(true);
		}
	}

	this.iface.tratarCantidad(curRelacionado.action());

	this.iface.docJustificativo();
	this.iface.bufferChanged("codlote");
}

/** \C Si el --tipo-- de un lote es Entrada, la --cantidad-- deberá ser positiva, y si es Salida, deberá ser negativa
\end */
function interna_validateForm():Boolean
{
	var curMoviLotes:FLSqlCursor = this.cursor();
	var curRelacionado:FLSqlCursor = curMoviLotes.cursorRelation();
	var util:FLUtil = new FLUtil();

	var codLote:String = curMoviLotes.valueBuffer("codlote");
	if (!codLote || codLote == "") {
		MessageBox.warning(util.translate("scripts", "Debe establecer el lote"),MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	
	if (!this.iface.tratarCantidad(curRelacionado.action()))
		return false;

	if (curMoviLotes.valueBuffer("tipo") == "Regularización"  && !curRelacionado.valueBuffer("codlote")) {
		MessageBox.warning(util.translate("scripts", "El movimiento debe ser de Entrada o Salida"),MessageBox.Ok, MessageBox.NoButton);
		this.iface.tratarCantidad(curRelacionado.action());
		return false;
	}
	
	if (curMoviLotes.valueBuffer("tipo") != "Regularización"  && curRelacionado.valueBuffer("codlote") && curMoviLotes.valueBuffer("docorigen") == "RE"){
		MessageBox.warning(util.translate("scripts", "El movimiento debe ser de Regularización"),MessageBox.Ok, MessageBox.NoButton);
		this.iface.tratarCantidad(curRelacionado.action());
		return false;
	}
	
	if (curMoviLotes.valueBuffer("tipo") == "Entrada" && curMoviLotes.valueBuffer("cantidad") <= 0) {
		var res:Number = MessageBox.warning(util.translate("scripts", "Se va a generar un movimiento con cantidad negativa para un documento de Entrada.\n¿Desea continuar?"),MessageBox.Yes, MessageBox.No);
		if (res != MessageBox.Yes)
			return false;
		this.iface.tratarCantidad(curRelacionado.action());
	}
	
	if (curMoviLotes.valueBuffer("tipo") == "Salida" && curMoviLotes.valueBuffer("cantidad") >= 0) {
		var res:Number = MessageBox.warning(util.translate("scripts", "Se va a generar un movimiento con cantidad positiva para un documento de Salida.\n¿Desea continuar?"),MessageBox.Yes, MessageBox.No);
		if (res != MessageBox.Yes)
			return false;
		//this.iface.tratarCantidad(curRelacionado.action());
	}

	if (curMoviLotes.valueBuffer("docorigen") == "PC" && flfactppal.iface.pub_valorDefectoEmpresa("stockpedidos")) {
		var cantidadLote:Number = util.sqlSelect("movilote", "SUM(cantidad)", "idstock = " + curMoviLotes.valueBuffer("idstock") + " AND codlote = '" + codLote + "' AND (idlineapc IS NULL OR idlineapc <> " + curMoviLotes.valueBuffer("idlineapc") + ") AND NOT automatico AND NOT reserva");
		if ((curMoviLotes.valueBuffer("cantidad") * -1) > cantidadLote) {
			var resp = MessageBox.warning(util.translate("scripts", "No hay suficiente cantidad de artículos con referencia %1 del lote %2\nen el almacén %3 \n¿Desea continuar generando un stock negativo?").arg(curRelacionado.valueBuffer("referencia")).arg(codLote).arg(curRelacionado.cursorRelation().valueBuffer("codalmacen")), MessageBox.Yes, MessageBox.No);
			if (resp != MessageBox.Yes) {
				this.iface.tratarCantidad(curRelacionado.action());
				return false;
			}
		}
	}
	if (curMoviLotes.valueBuffer("docorigen") == "RC") {
		var cantidadLote:Number = util.sqlSelect("movilote", "SUM(cantidad)", "idstock = " + curMoviLotes.valueBuffer("idstock") + " AND codlote = '" + codLote + "' AND (idlineaac IS NULL OR idlineaac <> " + curMoviLotes.valueBuffer("idlineaac") + ") AND NOT automatico AND NOT reserva");
		if ((curMoviLotes.valueBuffer("cantidad") * -1) > cantidadLote) {
			var resp = MessageBox.warning(util.translate("scripts", "No hay suficiente cantidad de artículos con referencia %1 del lote %2\nen el almacén %3 \n¿Desea continuar generando un stock negativo?").arg(curRelacionado.valueBuffer("referencia")).arg(codLote).arg(curRelacionado.cursorRelation().valueBuffer("codalmacen")), MessageBox.Yes, MessageBox.No);
			if (resp != MessageBox.Yes) {
				this.iface.tratarCantidad(curRelacionado.action());
				return false;
			}
		}
	}
	if (curMoviLotes.valueBuffer("docorigen") == "FC") {
		var cantidadLote:Number = util.sqlSelect("movilote", "SUM(cantidad)", "idstock = " + curMoviLotes.valueBuffer("idstock") + " AND codlote = '" + codLote + "' AND (idlineafc IS NULL OR idlineafc <> " + curMoviLotes.valueBuffer("idlineafc") + ") AND NOT automatico AND NOT reserva");
		if ((curMoviLotes.valueBuffer("cantidad") * -1) > cantidadLote) {
			var resp = MessageBox.warning(util.translate("scripts", "No hay suficiente cantidad de artículos con referencia %1 del lote %2\nen el almacén %3 \n¿Desea continuar generando un stock negativo?").arg(curRelacionado.valueBuffer("referencia")).arg(codLote).arg(curRelacionado.cursorRelation().valueBuffer("codalmacen")), MessageBox.Yes, MessageBox.No);
			if (resp != MessageBox.Yes) {
				this.iface.tratarCantidad(curRelacionado.action());
				return false;
			}
		}
	}
	return true;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////



/** @class_definition oficial */
/////////////////////////////////////////////////////////////////
//// OFICIAL ////////////////////////////////////////////////////
function oficial_bufferChanged(fN:String)
{
	var util:FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	switch(fN) {
		case "codlote": {
			var codLote:String = cursor.valueBuffer("codlote");
			if(!codLote || codLote == "") {
				this.child("tlbCaducidad").setText("");
				break;
			}
				
			if(util.sqlSelect("lotes","codlote","codlote = '" + codLote + "'")) {
				var fCaducidad:Date = util.sqlSelect("lotes","caducidad","codlote = '" + codLote + "'");
				if(!fCaducidad)
					fCaducidad = "";

				var cantAlmacen:Number = parseFloat(util.sqlSelect("lotes","enalmacen","codlote = '" + codLote + "'"));

				if(!cantAlmacen && cantAlmacen != 0)
					cantAlmacen = "";
				this.child("tlbCaducidad").setText("F. Caducidad: " + util.dateAMDtoDMA(fCaducidad) + "                           Cant. en almacén: " + cantAlmacen);
				break;
				
			}
			this.child("tlbCaducidad").setText("El lote especificado no existe");
			
			break;
		}
	}
}

/** \D Muestra los datos del documento justificativo del movimiento en la etiqueta correspondiente
\end */
function oficial_docJustificativo()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	
	switch (cursor.valueBuffer("docorigen")) {
		case "PC" : {
			var idPedido = util.sqlSelect("lineaspedidoscli", "idpedido", "idlinea = " + cursor.valueBuffer("idlineapc"));
			if (idPedido)
				this.child("lblDocumento").text = util.translate("scripts", "Pedido: %1 del cliente %2").arg(util.sqlSelect("pedidoscli", "codigo", "idpedido = " + idPedido)).arg(util.sqlSelect("pedidoscli", "nombrecliente", "idpedido = " + idPedido));
			break;
		}
		case "RC" : {
			var idAlbaran = util.sqlSelect("lineasalbaranescli", "idalbaran", "idlinea = " + cursor.valueBuffer("idlineaac"));
			if (idAlbaran)
				this.child("lblDocumento").text = util.translate("scripts", "Remito: %1 del cliente %2").arg(util.sqlSelect("albaranescli", "codigo", "idalbaran = " + idAlbaran)).arg(util.sqlSelect("albaranescli", "nombrecliente", "idalbaran = " + idAlbaran));
			break;
		}
		case "FC" : {
			var idFactura = util.sqlSelect("lineasfacturascli", "idfactura", "idlinea = " + cursor.valueBuffer("idlineafc"));
			if (idFactura)
				this.child("lblDocumento").text = util.translate("scripts", "Factura: %1 del cliente %2").arg(util.sqlSelect("facturascli", "codigo", "idfactura = " + idFactura)).arg(util.sqlSelect("facturascli", "nombrecliente", "idfactura = " + idFactura));
			break;
		}
		case "RP" : {
			var idAlbaran = util.sqlSelect("lineasalbaranesprov", "idalbaran", "idlinea = " + cursor.valueBuffer("idlineaap"));
			if (idAlbaran)
				this.child("lblDocumento").text = util.translate("scripts", "Remito: %1 del proveedor %2").arg(util.sqlSelect("albaranesprov", "codigo", "idalbaran = " + idAlbaran)).arg(util.sqlSelect("albaranesprov", "nombre", "idalbaran = " + idAlbaran));
			break;
		}
		case "FP" : {
			var idFactura = util.sqlSelect("lineasfacturasprov", "idfactura", "idlinea = " + cursor.valueBuffer("idlineafp"));
			if (idFactura)
				this.child("lblDocumento").text = util.translate("scripts", "Factura: %1 del proveedor %2").arg(util.sqlSelect("facturasprov", "codigo", "idfactura = " + idFactura)).arg(util.sqlSelect("facturasprov", "nombre", "idfactura = " + idFactura));
			break;
		}
		case "TR" : {
			var idTrans = util.sqlSelect("lineastransstock", "idtrans", "idlinea = " + cursor.valueBuffer("idlineats"));
			if (idTrans) {
				var fechaTrans:String = util.sqlSelect("transstock", "fecha", "idtrans = " + idTrans);
				this.child("lblDocumento").text = util.translate("scripts", "Transferencia día %1").arg(util.dateAMDtoDMA(fechaTrans));
			}
			break;
		}
		default : {
			this.child("lblDocumento").text = util.translate("scripts", "(Sin documento)");
			this.child("pbnConsultarDoc").setDisabled(true);
			break;
		}
	}
}

/** \D Muestra los datos del documento justificativo del movimiento en la etiqueta correspondiente
\end */
function oficial_pbnConsultarDocClicked()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	
	switch (cursor.valueBuffer("docorigen")) {
		case "PC" : {
			var idPedido = util.sqlSelect("lineaspedidoscli", "idpedido", "idlinea = " + cursor.valueBuffer("idlineapc"));
			if (idPedido) {
				var curDocumento:FLSqlCursor = new FLSqlCursor("pedidoscli");
				curDocumento.select("idpedido = " + idPedido);
				if (curDocumento.first()) {
					try {
						curDocumento.browseRecord();
					} catch (e) {}
				}
			}
			break;
		}
		case "RC" : {
			var idAlbaran = util.sqlSelect("lineasalbaranescli", "idalbaran", "idlinea = " + cursor.valueBuffer("idlineaac"));
			if (idAlbaran) {
				var curDocumento:FLSqlCursor = new FLSqlCursor("albaranescli");
				curDocumento.select("idalbaran = " + idAlbaran);
				if (curDocumento.first()) {
					try {
						curDocumento.browseRecord();
					} catch (e) {}
				}
			}
			break;
		}
		case "FC" : {
			var idFactura = util.sqlSelect("lineasfacturascli", "idfactura", "idlinea = " + cursor.valueBuffer("idlineafc"));
			if (idFactura) {
				var curDocumento:FLSqlCursor = new FLSqlCursor("facturascli");
				curDocumento.select("idfactura = " + idFactura);
				if (curDocumento.first()) {
					try {
						curDocumento.browseRecord();
					} catch (e) {}
				}
			}
			break;
		}
		case "RP" : {
			var idAlbaran = util.sqlSelect("lineasalbaranesprov", "idalbaran", "idlinea = " + cursor.valueBuffer("idlineaap"));
			if (idAlbaran) {
				var curDocumento:FLSqlCursor = new FLSqlCursor("albaranesprov");
				curDocumento.select("idalbaran = " + idAlbaran);
				if (curDocumento.first()) {
					try {
						curDocumento.browseRecord();
					} catch (e) {}
				}
			}
			break;
		}
		case "FP" : {
			var idFactura = util.sqlSelect("lineasfacturasprov", "idfactura", "idlinea = " + cursor.valueBuffer("idlineafp"));
			if (idFactura) {
				var curDocumento:FLSqlCursor = new FLSqlCursor("facturasprov");
				curDocumento.select("idfactura = " + idFactura);
				if (curDocumento.first()) {
					try {
						curDocumento.browseRecord();
					} catch (e) {}
				}
			}
			break;
		}
		case "TR" : {
			var idTrans = util.sqlSelect("lineastransstock", "idtrans", "idlinea = " + cursor.valueBuffer("idlineats"));
			if (idTrans) {
				var curDocumento:FLSqlCursor = new FLSqlCursor("transstock");
				curDocumento.select("idtrans = " + idTrans);
				if (curDocumento.first()) {
					try {
						curDocumento.browseRecord();
					} catch (e) {}
				}
			}
			break;
		}
	}
}

/** \D Calcula los datos del movimiento en función de la acción desde donde se llama al formulario
@param	accion: Acción
@return	Datos del movimiento
* Tipo (Entrada, Salida, Regularización, etc)
* DocOrigen (AC -Remito de cliente-, FC -Factura de cliente-, etc.)
* codAlmacen
* idStock
\end */
function oficial_datosMoviLote(accion:String):Array
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var curRelacionado:FLSqlCursor = cursor.cursorRelation();

	var datos:Array = [];
	var referencia:String = curRelacionado.valueBuffer("referencia");
	switch (accion) {
		case "lineaspedidoscli": {
			datos.tipo = "Salida";
			datos.docOrigen = "PC";
			datos.codAlmacen = util.sqlSelect("pedidoscli", "codalmacen", "idpedido = " + curRelacionado.valueBuffer("idpedido"));
			datos.idStock = util.sqlSelect("stocks", "idstock", "codalmacen = '" + datos.codAlmacen + "' AND referencia = '" + referencia + "'");
			if (!datos.idStock) {
				datos.idStock = flfactalma.iface.pub_crearStock(datos.codAlmacen, referencia);
				if (!datos.idStock)
					return false;
			}

			this.child("fdbCodLote").setFilter("1=1 AND lotes.referencia = '" + referencia + "' AND enalmacen > 0");
			break;
		}
		case "lineasalbaranescli": {
			datos.tipo = "Salida";
			datos.docOrigen = "RC";
			datos.codAlmacen = util.sqlSelect("albaranescli", "codalmacen", "idalbaran = " + curRelacionado.valueBuffer("idalbaran"));
			datos.idStock = util.sqlSelect("stocks", "idstock", "codalmacen = '" + datos.codAlmacen + "' AND referencia = '" + referencia + "'");
			if (!datos.idStock) {
				datos.idStock = flfactalma.iface.pub_crearStock(datos.codAlmacen, referencia);
				if (!datos.idStock)
					return false;
			}
			this.child("fdbCodLote").setFilter("1=1 AND lotes.referencia = '" + referencia + "' AND enalmacen > 0");
			break;
		}
		case "lineasalbaranesprov":{
			datos.tipo = "Entrada";
			datos.docOrigen = "RP";
			datos.codAlmacen = util.sqlSelect("albaranesprov", "codalmacen", "idalbaran = " + curRelacionado.valueBuffer("idalbaran"));
			datos.idStock = util.sqlSelect("stocks", "idstock", "codalmacen = '" + datos.codAlmacen + "' AND referencia = '" + referencia + "'");
			if (!datos.idStock) {
				datos.idStock = flfactalma.iface.pub_crearStock(datos.codAlmacen, referencia);
				if (!datos.idStock)
					return false;
			}
			this.child("fdbCodLote").setFilter("1=1 AND lotes.referencia = '" + referencia + "'");
			break;
		}
		case "lineasfacturascli":{
			datos.tipo = "Salida";
			datos.docOrigen = "FC";
			datos.codAlmacen = util.sqlSelect("facturascli", "codalmacen", "idfactura = " + curRelacionado.valueBuffer("idfactura"));
			datos.idStock = util.sqlSelect("stocks", "idstock", "codalmacen = '" + datos.codAlmacen + "' AND referencia = '" + referencia + "'");
			if (!datos.idStock) {
				datos.idStock = flfactalma.iface.pub_crearStock(datos.codAlmacen, referencia);
				if (!datos.idStock)
					return false;
			}
			this.child("fdbCodLote").setFilter("1=1 AND lotes.referencia = '" + referencia + "' AND enalmacen > 0");
			break;
		}
		case "lineasfacturasprov":{
			datos.tipo = "Entrada";
			datos.docOrigen = "FP";
			datos.codAlmacen = util.sqlSelect("facturasprov", "codalmacen", "idfactura = " + curRelacionado.valueBuffer("idfactura"));
			datos.idStock = util.sqlSelect("stocks", "idstock", "codalmacen = '" + datos.codAlmacen + "' AND referencia = '" + referencia + "'");
			if (!datos.idStock) {
				datos.idStock = flfactalma.iface.pub_crearStock(datos.codAlmacen, referencia);
				if (!datos.idStock)
					return false;
			}
			this.child("fdbCodLote").setFilter("1=1 AND lotes.referencia = '" + referencia + "'");
			break;
		}
		case "lineastrazabilidadinterna":{
			datos.tipo = "M.Interno";
			datos.docOrigen = "MI";
			datos.codAlmacen = util.sqlSelect("trazabilidadinterna", "codalmacen", "codigo = '" + curRelacionado.valueBuffer("codtrazainterna") + "'");
			datos.idStock = util.sqlSelect("stocks", "idstock", "codalmacen = '" + datos.codAlmacen + "' AND referencia = '" + referencia + "'");
			if (!datos.idStock) {
				datos.idStock = flfactalma.iface.pub_crearStock(datos.codAlmacen, referencia);
				if (!datos.idStock)
					return false;
			}
			this.child("fdbCodLote").setFilter("1=1 AND lotes.referencia = '" + referencia + "'");
			break;
		}
		case "lotes": {
			datos.tipo = "Regularización";
			datos.docOrigen = "RE";
			datos.idStock = "";
			this.child("fdbCodLote").setFilter("1=1 AND lotes.referencia = '" + referencia + "'");
			break;
		}
	}
	return datos;
}

/** \D En los documentos de cliente la cantidad se muestra cambiada de signo para facilitar su edición. Para ello se cambia el signo al iniciarse y cerrarse el formulario.
@param accion: Nombre de la acción desde la que se llama al formulario de movimiento de lotes
\end */
function oficial_tratarCantidad(accion:String):Boolean
{
	var cursor:FLSqlCursor = this.cursor();
	switch (accion) {
		case "lineaspedidoscli":
		case "lineasalbaranescli":
		case "lineasfacturascli":
		case "tpv_lineascomanda": {
			this.child("fdbCantidad").setValue(parseFloat(cursor.valueBuffer("cantidad")) * -1);
			break;
		}
	}
	return true;
}

function oficial_crearLote_clicked():Boolean
{
	
	var util:FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	var codNuevoLote:String = "";
	var referencia:String = cursor.cursorRelation().valueBuffer("referencia");

	var f:Object = new FLFormSearchDB("insertarlotes");
	var curLotes:FLSqlCursor = f.cursor();
	curLotes.setModeAccess(curLotes.Insert);
	curLotes.refreshBuffer();
	curLotes.setValueBuffer("referencia",referencia);
	f.setMainWidget();
	curLotes.setValueBuffer("referencia",referencia);
	f.exec("codlote");
	
	if (f.accepted()) {
		if(!curLotes.commitBuffer())
			return false;
		codNuevoLote = curLotes.valueBuffer("codlote");
	}

	if(codNuevoLote && codNuevoLote != "")
		cursor.setValueBuffer("codlote",codNuevoLote);	

	return true;
}
//// OFICIAL ////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition controlUsuario */
/////////////////////////////////////////////////////////////////
//// CONTROL_USUARIO ////////////////////////////////////////////

function controlUsuario_init()
{
	if (this.cursor().modeAccess() == this.cursor().Insert) {
		if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
			flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Movimientos de lotes");
		}
	}

	this.iface.__init();
}

//// CONTROL_USUARIO //////////////////////////////////////////
///////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////