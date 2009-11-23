/***************************************************************************
                 flfactalma.qs  -  description
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
	function afterCommit_stocks(curStock:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_stocks(curStock);
	}
	function beforeCommit_stocks(curStock:FLSqlCursor):Boolean {
		return this.ctx.interna_beforeCommit_stocks(curStock);
	}
	function afterCommit_lineastransstock(curLTS:FLSqlCursor):Boolean {
		return this.ctx.interna_afterCommit_lineastransstock(curLTS);
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	function oficial( context ) { interna( context ); } 
	function cambiarStock(codAlmacen:String, referencia:String, variacion:Number, campo:String):Boolean {
		return this.ctx.oficial_cambiarStock(codAlmacen, referencia, variacion, campo);
	}
	function cambiarCosteMedio(referencia:String):Boolean {
		return this.ctx.oficial_cambiarCosteMedio(referencia);
	}
	function controlStockPedidosCli(curLP:FLSqlCursor):Boolean {
		return this.ctx.oficial_controlStockPedidosCli(curLP);
	}
	function controlStockPedidosProv(curLP:FLSqlCursor):Boolean {
		return this.ctx.oficial_controlStockPedidosProv(curLP);
	}
	function controlStockAlbaranesCli(curLA:FLSqlCursor):Boolean {
		return this.ctx.oficial_controlStockAlbaranesCli(curLA);
	}
	function controlStockAlbaranesProv(curLA:FLSqlCursor):Boolean {
		return this.ctx.oficial_controlStockAlbaranesProv(curLA);
	}
	function controlStockFacturasCli(curLF:FLSqlCursor):Boolean {
		return this.ctx.oficial_controlStockFacturasCli(curLF);
	}
	function controlStockComandasCli(curLV:FLSqlCursor):Boolean {
		return this.ctx.oficial_controlStockComandasCli(curLV);
	}
	function controlStockFacturasProv(curLF:FLSqlCursor):Boolean {
		return this.ctx.oficial_controlStockFacturasProv(curLF);
	}
	function crearStock(codAlmacen:String, referencia:String):Number {
		return this.ctx.oficial_crearStock(codAlmacen, referencia);
	}
	function controlStockLineasTrans(curLTS:FLSqlCursor):Boolean {
		return this.ctx.oficial_controlStockLineasTrans(curLTS);
	}
	function controlStockValesTPV(curLinea:FLSqlCursor):Boolean {
		return this.ctx.oficial_controlStockValesTPV(curLinea);
	}
	function controlStock( curLinea:FLSqlCursor, campo:String, signo:Number, codAlmacen:String ):Boolean {
		return this.ctx.oficial_controlStock( curLinea, campo, signo, codAlmacen );
	}
	function controlStockPteRecibir(curLinea:FLSqlCursor, codAlmacen:String):Boolean {
		return this.ctx.oficial_controlStockPteRecibir(curLinea, codAlmacen);
	}
	function actualizarStockPteRecibir(referencia:String, codAlmacen:String, idPedido:String):Boolean {
		return this.ctx.oficial_actualizarStockPteRecibir(referencia, codAlmacen, idPedido);
	}
	function controlStockReservado(curLinea:FLSqlCursor, codAlmacen:String):Boolean {
		return this.ctx.oficial_controlStockReservado(curLinea, codAlmacen);
	}
	function actualizarStockReservado(referencia:String, codAlmacen:String, idPedido:String):Boolean {
		return this.ctx.oficial_actualizarStockReservado(referencia, codAlmacen, idPedido);
	}
	function comprobarStock(curStock:FLSqlCursor):Boolean {
		return this.ctx.oficial_comprobarStock(curStock);
	}
	function valorDefectoAlmacen(fN:String):String {
		return this.ctx.oficial_valorDefectoAlmacen(fN);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration pedidosauto */
/////////////////////////////////////////////////////////////////
//// PEDIDOS_AUTO ///////////////////////////////////////////////
class pedidosauto extends oficial {
	function pedidosauto( context ) { oficial ( context ); }
	function controlStockAlbaranesProv(curLA:FLSqlCursor):Boolean {
		return this.ctx.pedidosauto_controlStockAlbaranesProv(curLA);
	}
}
//// PEDIDOS_AUTO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
class lotes extends pedidosauto {
	function lotes( context ) { pedidosauto ( context ); }
	function cambiarStock(codAlmacen:String, referencia:String, variacion:Number, campo:String):Boolean {
		return this.ctx.lotes_cambiarStock(codAlmacen, referencia, variacion, campo);
	}
	function afterCommit_movilote(curMoviLote:FLSqlCursor):Boolean {
		return this.ctx.lotes_afterCommit_movilote(curMoviLote);
	}
	function beforeCommit_movilote(curMoviLote:FLSqlCursor):Boolean {
		return this.ctx.lotes_beforeCommit_movilote(curMoviLote);
	}
	function controlStockLineasTrans(curLTS:FLSqlCursor):Boolean {
		return this.ctx.lotes_controlStockLineasTrans(curLTS);
	}
	function afterCommit_lineastrazabilidadinterna(curLA:FLSqlCursor):Boolean {
		return this.ctx.lotes_afterCommit_lineastrazabilidadinterna(curLA);
	}
	function controlStockTrazabilidadInterna(curLTI:FLSqlCursor):Boolean {
		return this.ctx.lotes_controlStockTrazabilidadInterna(curLTI);
	}
}
//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration articuloscomp */
/////////////////////////////////////////////////////////////////
//// ARTICULOSCOMP //////////////////////////////////////////////
class articuloscomp extends lotes {
	function articuloscomp( context ) { lotes ( context ); }
	function cambiarStock(codAlmacen:String, referencia:String, variacion:Number, campo:String):Boolean {
		return this.ctx.articuloscomp_cambiarStock(codAlmacen, referencia, variacion, campo);
	}
	function pvpCompuesto(referencia:String):Number {
		return this.ctx.articuloscomp_pvpCompuesto(referencia);
	}
	function beforeCommit_articulos(curArticulo:FLSqlCursor):Boolean {
		return this.ctx.articuloscomp_beforeCommit_articulos(curArticulo);
	}
	function actualizarUnidad(referencia:String,unidad:String):Boolean {
		return this.ctx.articuloscomp_actualizarUnidad(referencia,unidad);
	}
	function calcularFiltroReferencia(referencia:String):String {
		return this.ctx.articuloscomp_calcularFiltroReferencia(referencia);
	}
	function afterCommit_articuloscomp(curAC:FLSqlCursor):Boolean {
		return this.ctx.articuloscomp_afterCommit_articuloscomp(curAC);
	}
	function afterCommit_tiposopcionartcomp(curTOAC:FLSqlCursor):Boolean {
		return this.ctx.articuloscomp_afterCommit_tiposopcionartcomp(curTOAC);
	}
	function comprobarPadresVariables(referencia:String):Boolean {
		return this.ctx.articuloscomp_comprobarPadresVariables(referencia);
	}
	function beforeCommit_opcionesarticulocomp(curOP:FLSqlCursor):Boolean {
		return this.ctx.articuloscomp_beforeCommit_opcionesarticulocomp(curOP);
	}
}
//// ARTICULOSCOMP //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration funNumSerie */
//////////////////////////////////////////////////////////////////
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////////
class funNumSerie extends articuloscomp {
	function funNumSerie( context ) { articuloscomp( context ); } 
	function insertarNumSerie(referencia:String, numSerie:String, idAlbaran:Number, idFactura:Number ):Boolean {
		return this.ctx.funNumSerie_insertarNumSerie(referencia, numSerie, idAlbaran, idFactura);
	}
	function borrarNumSerie(referencia:String, numSerie:String ):Boolean {
		return this.ctx.funNumSerie_borrarNumSerie(referencia, numSerie);
	}
	function borrarNumSerie(referencia:String, numSerie:String ):Boolean {
		return this.ctx.funNumSerie_borrarNumSerie(referencia, numSerie);
	}
	function modificarNumSerie(referencia:String, numserie:String, campo:String, valor:Number):Boolean {
		return this.ctx.funNumSerie_modificarNumSerie(referencia, numserie, campo, valor);
	}
	function afterCommit_numerosserie(curNS:FLSqlCursor):Boolean {
		return this.ctx.funNumSerie_afterCommit_numerosSerie(curNS);
	}
	function controlStockLineasTrans(curLTS:FLSqlCursor):Boolean {
		return this.ctx.funNumSerie_controlStockLineasTrans(curLTS);
	}
}
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// COSTOS /////////////////////////////////////////////////////
class costos extends funNumSerie {
	function costos( context ) { funNumSerie ( context ); }
	function cambiarCosteUltimo(referencia:String):Boolean {
		return this.ctx.costos_cambiarCosteUltimo(referencia);
	}
	function cambiarCosteMaximo(referencia:String):Boolean {
		return this.ctx.costos_cambiarCosteMaximo(referencia);
	}
	function cambiarCosteProveedor(curL:FLSqlCursor):Boolean {
		return this.ctx.costos_cambiarCosteProveedor(curL);
	}
}
//// COSTOS /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration lineasArticulos */
/////////////////////////////////////////////////////////////////
//// LINEAS_ARTICULOS ///////////////////////////////////////////
class lineasArticulos extends costos {
	function lineasArticulos( context ) { costos ( context ); }

	function afterCommit_lineastrazabilidadinterna(curLA:FLSqlCursor):Boolean {
		return this.ctx.lineasArticulos_afterCommit_lineastrazabilidadinterna(curLA);
	}

	function generarLineaSalida(documento:String, curLS:FLSqlCursor):Boolean {
		return this.ctx.lineasArticulos_generarLineaSalida(documento, curLS);
	}
	function borrarLineaSalida(curLS:FLSqlCursor, nombreIdLinea:String, nombreIdTabla:String) {
		return this.ctx.lineasArticulos_borrarLineaSalida(curLS, nombreIdLinea, nombreIdTabla);
	}

	function generarLineaEntrada(documento:String, curLE:FLSqlCursor):Boolean {
		return this.ctx.lineasArticulos_generarLineaEntrada(documento, curLE);
	}
	function borrarLineaEntrada(curLE:FLSqlCursor, nombreIdLinea:String, nombreIdTabla:String) {
		return this.ctx.lineasArticulos_borrarLineaEntrada(curLE, nombreIdLinea, nombreIdTabla);
	}
}
//// LINEAS_ARTICULOS ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration controlUsuario */
/////////////////////////////////////////////////////////////////
//// CONTROL_USUARIO ////////////////////////////////////////////
class controlUsuario extends lineasArticulos {
    function controlUsuario( context ) { lineasArticulos ( context ); }

	function beforeCommit_lineasregstocks(curLRS:FLSqlCursor):Boolean {
		return this.ctx.controlUsuario_beforeCommit_lineasregstocks(curLRS);
	}
	function beforeCommit_trazabilidadinterna(curTI:FLSqlCursor):Boolean {
		return this.ctx.controlUsuario_beforeCommit_trazabilidadinterna(curTI);
	}
	function beforeCommit_transstock(curTS:FLSqlCursor):Boolean {
		return this.ctx.controlUsuario_beforeCommit_transstock(curTS);
	}
	function beforeCommit_movilote(curMoviLote:FLSqlCursor):Boolean {
		return this.ctx.controlUsuario_beforeCommit_movilote(curMoviLote);
	}
}
//// CONTROL_USUARIO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration multiFamilia */
/////////////////////////////////////////////////////////////////
//// MULTI FAMILIA //////////////////////////////////////////////
class multiFamilia extends controlUsuario {
    function multiFamilia( context ) { controlUsuario ( context ); }
	function afterCommit_familias(cursor:FLSqlCursor):Boolean {
		return this.ctx.multiFamilia_afterCommit_familias(cursor);
	}
}
//// MULTI FAMILIA //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends multiFamilia {
    function head( context ) { multiFamilia ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
	function ifaceCtx( context ) { head( context ); }
	function pub_cambiarStock(codAlmacen:String, referencia:String, variacion:Number, campo:String, noAvisar:Boolean ):Boolean {
		return this.cambiarStock(codAlmacen, referencia, variacion,campo, noAvisar);
	}
	function pub_crearStock(codAlmacen:String, referencia:String):Number {
		return this.crearStock(codAlmacen, referencia);
	}
	function pub_cambiarCosteMedio(referencia:String):Boolean {
		return this.cambiarCosteMedio(referencia);
	}
	function pub_controlStockPedidosCli(curLP:FLSqlCursor):Boolean {
		return this.controlStockPedidosCli(curLP);
	}
	function pub_controlStockPedidosProv(curLP:FLSqlCursor):Boolean {
		return this.controlStockPedidosProv(curLP);
	}
	function pub_controlStockAlbaranesCli(curLA:FLSqlCursor):Boolean {
		return this.controlStockAlbaranesCli(curLA);
	}
	function pub_controlStockAlbaranesProv(curLA:FLSqlCursor):Boolean {
		return this.controlStockAlbaranesProv(curLA);
	}
	function pub_controlStockFacturasCli(curLF:FLSqlCursor):Boolean {
		return this.controlStockFacturasCli(curLF);
	}
	function pub_controlStockComandasCli(curLV:FLSqlCursor):Boolean {
		return this.controlStockComandasCli(curLV);
	}
	function pub_controlStockFacturasProv(curLF:FLSqlCursor):Boolean {
		return this.controlStockFacturasProv(curLF);
	}
	function pub_controlStockValesTPV(curLinea:FLSqlCursor):Boolean {
		return this.controlStockValesTPV(curLinea);
	}
	function pub_valorDefectoAlmacen(fN:String):String {
		return this.valorDefectoAlmacen(fN);
	}
}
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubLotes */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class pubLotes extends ifaceCtx {
	function pubLotes( context ) { ifaceCtx( context ); }
}
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubArticulosComp */
/////////////////////////////////////////////////////////////////
//// PUB_ARTICULOSCOMP //////////////////////////////////////////
class pubArticulosComp extends pubLotes {
	function pubArticulosComp( context ) { pubLotes( context ); }
	function pub_pvpCompuesto(referencia:String):Number {
		return this.pvpCompuesto(referencia);
	}
	function pub_calcularFiltroReferencia(referencia:String):String {
		return this.calcularFiltroReferencia(referencia);
	}
}
//// PUB_ARTICULOSCOMP //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubCostos */
/////////////////////////////////////////////////////////////////
//// PUB_COSTOS /////////////////////////////////////////////////
class pubCostos extends pubArticulosComp {
	function pubCostos( context ) { pubArticulosComp( context ); }
	function pub_cambiarCosteUltimo(referencia:String):Boolean {
		return this.cambiarCosteUltimo(referencia);
	}
	function pub_cambiarCosteMaximo(referencia:String):Boolean {
		return this.cambiarCosteMaximo(referencia);
	}
	function pub_cambiarCosteProveedor(curL:FLSqlCursor):Boolean {
		return this.cambiarCosteProveedor(curL);
	}
}
//// PUB_COSTOS /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

const iface = new pubCostos( this );

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
/** \D Si no hay ningún almacén en la tabla almacenes se inserta uno por defecto
\end */
function interna_init()
{
	var cursor:FLSqlCursor = new FLSqlCursor("almacenes");
	cursor.select();
	if (!cursor.first()) {
		var util:FLUtil = new FLUtil();
		MessageBox.information(util.translate("scripts",
			"Se insertará un almacén por defecto y algunos valores iniciales para empezar a trabajar."),
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		with (cursor) {
			setModeAccess(Insert);
			refreshBuffer();
			setValueBuffer("codalmacen","ALG");
			setValueBuffer("nombre", util.translate("scripts","ALMACEN GENERAL"));
			commitBuffer();
		}
		delete cursor;

		cursor = new FLSqlCursor("empresa");
		cursor.select();
		if (cursor.first()) {
			with (cursor) {
				setModeAccess(cursor.Edit);
				refreshBuffer();
				if (!valueBuffer("codalmacen")) {
					setValueBuffer("codalmacen","ALG");
					commitBuffer();
				}
			}
		}
		delete cursor;

		cursor = new FLSqlCursor("factalma_general");
		cursor.select();
		if (!cursor.first()) {
			with (cursor) {
				setModeAccess(cursor.Insert);
				refreshBuffer();
				setValueBuffer("coddivisa","$");
				setValueBuffer("codimpuesto","GRAVADO");
				setValueBuffer("ivaincluido", false);
				commitBuffer();
			}
		}
	}
}

/** \D
Actualiza el stock físico total en la tabla de artículos
\end */
function interna_afterCommit_stocks(curStock:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	var referencia:String = curStock.valueBuffer("referencia");
	var stockFisico:Number = util.sqlSelect("stocks", "SUM(cantidad)", "referencia = '" + referencia + "'");
	switch (curStock.modeAccess()) {
		case curStock.Edit:
			var refAnterior:String = curStock.valueBufferCopy("referencia");
			if (referencia != refAnterior) {
				if (!util.sqlUpdate("articulos", "stockfis", stockFisico, "referencia = '" + refAnterior + "'"))
					return false;
			}
		case curStock.Insert:
// 			if((curStock.valueBufferCopy("cantidad") != curStock.valueBuffer("cantidad")) || (curStock.valueBufferCopy("reservada") != curStock.valueBuffer("reservada"))) {
// 				curStock.setValueBuffer("disponible",parseFloat(curStock.valueBuffer("cantidad")) - parseFloat(curStock.valueBuffer("reservada")));
// 			}
		case curStock.Del:
			if (!util.sqlUpdate("articulos", "stockfis", stockFisico, "referencia = '" + referencia + "'"))
				return false;
	}
	return true;
}

/** \D
Avisa al usuario en caso de querer borrar un stock con cantidad distinta de 0
\end */
function interna_beforeCommit_stocks(curStock:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	switch (curStock.modeAccess()) {
		case curStock.Del: {
			if (parseFloat(curStock.valueBuffer("cantidad")) != 0) {
				var res:Number = MessageBox.warning(util.translate("scripts", "Va a eliminar un registro de stock con cantidad distinta de 0.\n¿Está seguro?"), MessageBox.No, MessageBox.Yes);
				if (res != MessageBox.Yes)
					return false;
			}
		}
	}
	return true;
}

function interna_afterCommit_lineastransstock(curLTS:FLSqlCursor):Boolean {
	return this.iface.controlStockLineasTrans(curLTS);
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Cambia el valor del stock en un determinado almacén. Se comprueba si el valor de la variación es negativo y mayor al stock actual, en cuyo caso se avisa al usuario de la falta de existencias

@param codAlmacen Código del almacén
@param referencia Referencia del artículo
@param variación Variación en el número de existencias del artículo
@param	campo: Nombre del campo a modificar. Si el campo es vacío o es --cantidad-- se llama a la función padre
@return True si la modificación tuvo éxito, false en caso contrario
\end */
function oficial_cambiarStock(codAlmacen:String, referencia:String, variacion:Number, campo:String, noAvisar:Boolean ):Boolean
{
	var util:FLUtil = new FLUtil();
	if (referencia == "" || !referencia) {
		return true;
	}

	if (codAlmacen == "" || !codAlmacen) {
		return true;
	}

	if ( !campo || campo == "") {
		return false;
	}

	var idStock:String;
	idStock = util.sqlSelect("stocks", "idstock", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "'");
	if ( !idStock ) {
		idStock = this.iface.crearStock( codAlmacen, referencia );
		if ( !idStock ) {
			return false;
		}
	}
	var curStock:FLSqlCursor = new FLSqlCursor( "stocks" );
	curStock.select( "idstock = " + idStock );
	if ( !curStock.first() ) {
		return false;
	}
	
	curStock.setModeAccess( curStock.Edit );
	curStock.refreshBuffer();
	
	var cantidadPrevia:Number = parseFloat( curStock.valueBuffer( campo ) );
	var nuevaCantidad:Number = cantidadPrevia + parseFloat( variacion );

// 	if (nuevaCantidad < 0 && campo == "cantidad") {
// 		if (!util.sqlSelect("articulos", "controlstock", "referencia = '" + referencia + "'")) {
// 			MessageBox.warning( util.translate("scripts", "El artículo %1 no permite ventas sin stock. Este movimiento dejaría el stock de %2 con cantidad %3.\n").arg(referencia).arg(codAlmacen).arg(nuevaCantidad), MessageBox.Ok, MessageBox.NoButton);
// 			return false;
// 		}
// 	}

	curStock.setValueBuffer( campo, nuevaCantidad );
	if (campo == "cantidad" || campo == "reservada") {
		curStock.setValueBuffer("disponible", formRecordregstocks.iface.pub_commonCalculateField("disponible", curStock));
	}

	if (!this.iface.comprobarStock(curStock)) {
		return false;
	}

	if ( !curStock.commitBuffer() ) {
		return false;
	}

	return true;
}

/** \D Comprueba, en el caso de que el artículo no permita ventas sin stock, si el stock que se va a guardar incumple dicha condición
@param	curStock: Cursor a guardar
@return	True si la comprobación es correcta, false en caso contrario
\end */
function oficial_comprobarStock(curStock:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	var referencia:String = curStock.valueBuffer("referencia");
	var codAlmacen:String = curStock.valueBuffer("codalmacen");
	if (util.sqlSelect("articulos", "controlstock", "referencia = '" + referencia + "'")) {
		return true;
	}

	var stockPedidos:Boolean = flfactppal.iface.pub_valorDefectoEmpresa("stockpedidos");

	var cantidadControl:Number;
	if (stockPedidos) {
		cantidadControl = curStock.valueBuffer("disponible");
	} else {
		cantidadControl = curStock.valueBuffer("cantidad");
	}
	if (cantidadControl < 0) {
		var nombreCantidad:String;
		if (stockPedidos) {
			nombreCantidad = util.translate("scripts", "cantidad disponible");
		} else {
			nombreCantidad = util.translate("scripts", "cantidad en stock");
		}
		if (!util.sqlSelect("articulos", "controlstock", "referencia = '" + referencia + "'")) {
			MessageBox.warning( util.translate("scripts", "El artículo %1 no permite ventas sin stock. Este movimiento dejaría el stock de %2 con %3 %4.\n").arg(referencia).arg(codAlmacen).arg(nombreCantidad).arg(cantidadControl), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	}
	return true;
}

/** \D Recalcula el coste medio de compra de un artículo como media del coste en todos los albaranes de proveedor

@param referencia Referencia del artículo
@return True si la modificación tuvo éxito, false en caso contrario
\end */
function oficial_cambiarCosteMedio(referencia:String):Boolean
{
	if (referencia == "")
		return true;

	var util:FLUtil = new FLUtil();

	var whereCantidad:String = "";
	var cantLineas:Number = this.iface.valorDefectoAlmacen("cantlineascostemedio");
	if (parseFloat(cantLineas) != 0 )
		whereCantidad = " AND idlinea IN (SELECT idlinea FROM lineasfacturasprov ORDER BY idlinea DESC LIMIT " + cantLineas + ")";

	var sumCant:Number = util.sqlSelect("lineasfacturasprov", "SUM(cantidad)", "referencia = '" + referencia + "'" + whereCantidad);
	if ( !sumCant || sumCant == 0)
		return true;
	var cM:Number = util.sqlSelect("lineasfacturasprov lf INNER JOIN facturasprov f ON lf.idfactura = f.idfactura", "(SUM(lf.pvptotal*f.tasaconv) / SUM(lf.cantidad))", "lf.referencia = '" + referencia + "'" + whereCantidad, "lineasfacturasprov,facturasprov");
	if (!cM)
		cM = 0;

	var curArticulo:FLSqlCursor = new FLSqlCursor("articulos");
	curArticulo.select("referencia = '" + referencia + "'");
	if (curArticulo.first()) {
		curArticulo.setModeAccess(curArticulo.Edit);
		curArticulo.refreshBuffer();
		curArticulo.setValueBuffer("costemedio", cM);
		curArticulo.commitBuffer();
	}

	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function oficial_controlStockPedidosCli(curLP:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	
	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLP.valueBuffer("referencia") + "'"))
		return true;

	var codAlmacen:String = util.sqlSelect("pedidoscli", "codalmacen", "idpedido = " + curLP.valueBuffer("idpedido"));
	if (!codAlmacen || codAlmacen == "")
		return true;
	
	var stockPedidos:Boolean = flfactppal.iface.pub_valorDefectoEmpresa("stockpedidos");

	if(stockPedidos) {
		if (!this.iface.controlStock(curLP, "cantidad", -1, codAlmacen))
			return false;
	}
	else {
		if (!this.iface.controlStockReservado(curLP, codAlmacen)) {
			return false;
		}
	}

	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function oficial_controlStockPedidosProv(curLP:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	
	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLP.valueBuffer("referencia") + "'"))
		return true;

	var codAlmacen:String = util.sqlSelect("pedidosprov", "codalmacen", "idpedido = " + curLP.valueBuffer("idpedido"));
	if (!codAlmacen || codAlmacen == "")
		return true;
	
	if (!this.iface.controlStockPteRecibir(curLP, codAlmacen)) {
		return false;
	}
	
	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
en caso de que no venga de un pedido, o que la opción general de control
de stocks en pedidos esté inhabilitada
\end */
function oficial_controlStockAlbaranesCli(curLA:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLA.valueBuffer("referencia") + "'"))
		return true;

	if ((curLA.valueBuffer("idlineapedido") != 0) && flfactppal.iface.pub_valorDefectoEmpresa("stockpedidos"))
		return true;

	var codAlmacen:String = util.sqlSelect("albaranescli", "codalmacen", "idalbaran = " + curLA.valueBuffer("idalbaran"));
	if (!codAlmacen || codAlmacen == "")
		return true;

	if (!this.iface.controlStock( curLA, "cantidad", -1, codAlmacen ))
		return false;

	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function oficial_controlStockFacturasCli(curLF:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLF.valueBuffer("referencia") + "'"))
		return true;

	if(util.sqlSelect("facturascli", "automatica", "idfactura = " + curLF.valueBuffer("idfactura")))
		return true;

	var codAlmacen = util.sqlSelect("facturascli", "codalmacen", "idfactura = " + curLF.valueBuffer("idfactura"));
	if (!codAlmacen || codAlmacen == "")
		return true;
		
	if (!this.iface.controlStock(curLF, "cantidad", -1, codAlmacen))
		return false;

	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function oficial_controlStockComandasCli(curLV:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLV.valueBuffer("referencia") + "'")) {
		return true;
	}

	var codAlmacen = util.sqlSelect("tpv_comandas c INNER JOIN tpv_puntosventa pv ON c.codtpv_puntoventa = pv.codtpv_puntoventa", "pv.codalmacen", "idtpv_comanda = " + curLV.valueBuffer("idtpv_comanda"), "tpv_comandas,tpv_puntosventa");
	if (!codAlmacen || codAlmacen == "") {
		return true;
	}
	
	if (!this.iface.controlStock(curLV, "cantidad", -1, codAlmacen)) {
		return false;
	}

	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function oficial_controlStockAlbaranesProv(curLA:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLA.valueBuffer("referencia") + "'"))
		return true;

	var codAlmacen:String = util.sqlSelect("albaranesprov", "codalmacen", "idalbaran = " + curLA.valueBuffer("idalbaran"));
	if (!codAlmacen || codAlmacen == "")
		return true;
	
	if (!this.iface.controlStock(curLA, "cantidad", 1, codAlmacen))
			return false;

	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function oficial_controlStockFacturasProv(curLF:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLF.valueBuffer("referencia") + "'"))
		return true;

	if(util.sqlSelect("facturasprov", "automatica", "idfactura = " + curLF.valueBuffer("idfactura")))
		return true;

	var codAlmacen:String = util.sqlSelect("facturasprov", "codalmacen", "idfactura = " + curLF.valueBuffer("idfactura"));
	if (!codAlmacen || codAlmacen == "")
		return true;

	if (!this.iface.controlStock(curLF, "cantidad", 1, codAlmacen))
			return false;

	return true;
}

/** \D Crea un registro de stock para el almacén y artículo especificados
@param	codAlmacen: Almacén
@param	referencia: Referencia del artículo
@return	identificador del stock o false si hay error
\end */
function oficial_crearStock(codAlmacen:String, referencia:String):Number
{
	var util:FLUtil = new FLUtil;
	var curStock:FLSqlCursor = new FLSqlCursor("stocks");
	with(curStock) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("codalmacen", codAlmacen);
		setValueBuffer("referencia", referencia);
		setValueBuffer("nombre", util.sqlSelect("almacenes", "nombre", "codalmacen = '" + codAlmacen + "'"));
		setValueBuffer("cantidad", 0);
		if (!commitBuffer())
			return false;
	}
	return curStock.valueBuffer("idstock");
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function oficial_controlStockLineasTrans(curLTS:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	var codAlmacenOrigen:String = util.sqlSelect("transstock", "codalmaorigen", "idtrans = " + curLTS.valueBuffer("idtrans"));
	if (!codAlmacenOrigen || codAlmacenOrigen == "")
		return true;
		
	var codAlmacenDestino:String = util.sqlSelect("transstock", "codalmadestino", "idtrans = " + curLTS.valueBuffer("idtrans"));
	if (!codAlmacenDestino || codAlmacenDestino == "")
		return true;
	
	if (!this.iface.controlStock(curLTS, "cantidad", -1, codAlmacenOrigen))
			return false;

	if (!this.iface.controlStock(curLTS, "cantidad", 1, codAlmacenDestino))
			return false;

	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function oficial_controlStockValesTPV(curLinea:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLinea.valueBuffer("referencia") + "'"))
		return true;

	var codAlmacen:String = curLinea.valueBuffer("codalmacen");
	if (!codAlmacen || codAlmacen == "")
		return true;
	
	if (!this.iface.controlStock(curLinea, "cantidad", 1, codAlmacen))
			return false;

	return true;
}

/** \D Incrementa o decrementa el stock en función de la variación experimentada por una línea de documento de facturación
@param	curLinea: Cursor posicionado en la línea de documento de facturación
@param	campo: Campo a modificar
@param	operación: Indica si la cantidad debe sumarse o restarse del stock
@param	codAlmacen: Código del almacén asociado al stock a modificar
@return	True si el control se realiza correctamente, false en caso contrario
*/
function oficial_controlStock( curLinea:FLSqlCursor, campo:String, signo:Number, codAlmacen:String ):Boolean 
{
	var variacion:Number;
	var cantidad:Number = parseFloat( curLinea.valueBuffer( "cantidad" ) );
	var cantidadPrevia:Number = parseFloat( curLinea.valueBufferCopy( "cantidad" ) );

// 	if ( curLinea.table() == "lineaspedidoscli" || curLinea.table() == "lineaspedidosprov" ) {
// 		cantidad -= parseFloat( curLinea.valueBuffer( "totalenalbaran" ) );
// 		cantidadPrevia -= parseFloat( curLinea.valueBufferCopy( "totalenalbaran" ) );
// 	}

	switch(curLinea.modeAccess()) {
		case curLinea.Insert: {
			variacion = signo * cantidad;
			if ( !this.iface.cambiarStock( codAlmacen, curLinea.valueBuffer( "referencia" ), variacion, campo ) )
				return false;
			break;
		}
		case curLinea.Del: {
			variacion = signo * -1 * cantidad;
			if ( !this.iface.cambiarStock( codAlmacen, curLinea.valueBuffer( "referencia" ), variacion, campo ) )
				return false;
			break;
		}
		case curLinea.Edit: {
			if (curLinea.valueBuffer( "referencia" ) != curLinea.valueBufferCopy( "referencia" )) {
				variacion = signo * -1 * cantidadPrevia;
				if ( !this.iface.cambiarStock( codAlmacen, curLinea.valueBufferCopy( "referencia" ), variacion, campo ) )
					return false;
				variacion = signo * cantidad;
				if ( !this.iface.cambiarStock( codAlmacen, curLinea.valueBuffer( "referencia" ), variacion, campo, true ) )
					return false;
			}
			else {
				if(cantidad != cantidadPrevia);
				variacion = (cantidad - cantidadPrevia) * signo;
				if (!this.iface.cambiarStock( codAlmacen, curLinea.valueBuffer( "referencia" ), variacion, campo) )
					return false;
			}
			break;
		}
	}

	return true;
}

function oficial_controlStockPteRecibir(curLinea:FLSqlCursor, codAlmacen:String):Boolean
{
	var util:FLUtil = new FLUtil;
	
	var idPedido:String = curLinea.valueBuffer("idpedido");
	var referencia:String = curLinea.valueBuffer("referencia");
	if (referencia && referencia != "") {
		if (!this.iface.actualizarStockPteRecibir(referencia, codAlmacen, idPedido)) {
			return false;
		}
	}

	var referenciaPrevia:String = curLinea.valueBufferCopy("referencia");
	if (referenciaPrevia && referenciaPrevia != "" && referenciaPrevia != referencia) {
		if (!this.iface.actualizarStockPteRecibir(referenciaPrevia, codAlmacen, idPedido)) {
			return false;
		}
	}
 
	return true;
}

function oficial_actualizarStockPteRecibir(referencia:String, codAlmacen:String, idPedido:String):Boolean
{
	var util:FLUtil = new FLUtil;
	
	var idStock:String = util.sqlSelect("stocks", "idstock", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "'");
	if ( !idStock ) {
		idStock = this.iface.crearStock( codAlmacen, referencia );
		if ( !idStock ) {
			return false;
		}
	}
	var pteRecibir:Number = util.sqlSelect("lineaspedidosprov lp INNER JOIN pedidosprov p ON lp.idpedido = p.idpedido", "sum(lp.cantidad - lp.totalenalbaran)", "p.codalmacen = '" + codAlmacen + "' AND (p.servido IN ('No', 'Parcial') OR p.idpedido = " + idPedido + ") AND lp.referencia = '" + referencia + "' AND (lp.cerrada IS NULL OR lp.cerrada = false)", "lineaspedidosprov,pedidosprov");

	if (isNaN(pteRecibir)) {
		pteRecibir = 0;
	}
	
	var curStock:FLSqlCursor = new FLSqlCursor("stocks");
	curStock.select("idstock = " + idStock);
	if (!curStock.first()) {
		return false;
	}
	curStock.setModeAccess(curStock.Edit);
	curStock.refreshBuffer();
	curStock.setValueBuffer("pterecibir", pteRecibir);
	if (!curStock.commitBuffer()) {
		return false;
	}
	return true;
}

function oficial_controlStockReservado(curLinea:FLSqlCursor, codAlmacen:String):Boolean
{
	var util:FLUtil = new FLUtil;
	
	var idPedido:String = curLinea.valueBuffer("idpedido");
	var referencia:String = curLinea.valueBuffer("referencia");
	if (referencia && referencia != "") {
		if (!this.iface.actualizarStockReservado(referencia, codAlmacen, idPedido)) {
			return false;
		}
	}

	var referenciaPrevia:String = curLinea.valueBufferCopy("referencia");
	if (referenciaPrevia && referenciaPrevia != "" && referenciaPrevia != referencia) {
		if (!this.iface.actualizarStockReservado(referenciaPrevia, codAlmacen, idPedido)) {
			return false;
		}
	}
 
	return true;
}

function oficial_actualizarStockReservado(referencia:String, codAlmacen:String, idPedido:String):Boolean
{
	var util:FLUtil = new FLUtil;
	
	var idStock:String = util.sqlSelect("stocks", "idstock", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "'");
	if ( !idStock ) {
		idStock = this.iface.crearStock( codAlmacen, referencia );
		if ( !idStock ) {
			return false;
		}
	}

	var reservada:Number = util.sqlSelect("lineaspedidoscli lp INNER JOIN pedidoscli p ON lp.idpedido = p.idpedido", "sum(lp.cantidad - lp.totalenalbaran)", "p.codalmacen = '" + codAlmacen + "' AND (p.servido IN ('No', 'Parcial') OR p.idpedido = " + idPedido + ") AND lp.referencia = '" + referencia + "' AND (lp.cerrada IS NULL OR lp.cerrada = false)", "lineaspedidoscli,pedidoscli");
	if (isNaN(reservada)) {
		reservada = 0;
	}

	var curStock:FLSqlCursor = new FLSqlCursor("stocks");
	curStock.select("idstock = " + idStock);
	if (!curStock.first()) {
		return false;
	}
	curStock.setModeAccess(curStock.Edit);
	curStock.refreshBuffer();
	curStock.setValueBuffer("reservada", reservada);
	curStock.setValueBuffer("disponible", formRecordregstocks.iface.pub_commonCalculateField("disponible", curStock));
	if (!this.iface.comprobarStock(curStock)) {
		return false;
	}
	if (!curStock.commitBuffer()) {
		return false;
	}
	return true;
}

function oficial_valorDefectoAlmacen(fN:String):String
{
	var query:FLSqlQuery = new FLSqlQuery();

	query.setTablesList( "factalma_general" );
	try { query.setForwardOnly( true ); } catch (e) {}
	query.setSelect( fN );
	query.setFrom( "factalma_general" );
	if ( query.exec() )
		if ( query.next() )
			return query.value( 0 );

	return "";
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition pedidosauto */
/////////////////////////////////////////////////////////////////
//// PEDIDOS_AUTO ///////////////////////////////////////////////
function pedidosauto_controlStockAlbaranesProv(curLA:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	
	if (!this.iface.__controlStockAlbaranesProv(curLA))
		return false;
		
	var pedAuto:Boolean = false;
	if (util.sqlSelect("lineaspedidosprov", "idpedidoaut", "idlinea = " + curLA.valueBuffer("idlineapedido")))
		pedAuto = true;


	if (pedAuto) {
		var cantidad:Number = -1 * parseFloat(curLA.valueBuffer("cantidad"));
		if (!flfacturac.iface.pub_cambiarStockOrd(curLA.valueBuffer("referencia"), cantidad))
			return false;
	}
	
	return true;
}
//// PEDIDOS_AUTO ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition lotes */
/////////////////////////////////////////////////////////////////
//// LOTES //////////////////////////////////////////////////////
/** \C El calculo de los stocks se realizará de la forma normal en el caso de que los artículo no estén bajo control por lotes
\end */
function lotes_cambiarStock(codAlmacen:String, referencia:String, variacion:Number, campo:String):Boolean
{
	var util:FLUtil = new FLUtil();
	if (util.sqlSelect("articulos", "porlotes", "referencia = '" + referencia + "'"))
		return true;
	else
		return this.iface.__cambiarStock(codAlmacen, referencia, variacion, campo);
}

/** \C El campo en almacén del lote correspondiente se actualizará. De la misma forma, el campo cantidad del stock asociado se calculará como la suma del campo cantidad de los movimientos que lo componen.
\end */
function lotes_afterCommit_movilote(curMoviLote:FLSqlCursor):Boolean
{
	var codLote:String = curMoviLote.valueBuffer("codlote");
	var idStock:Number = curMoviLote.valueBuffer("idstock");
	var util:FLUtil = new FLUtil();
	
	if (curMoviLote.cursorRelation() && curMoviLote.cursorRelation().action() == "lotes") {
	} else {
		var enAlmacen:Number = util.sqlSelect("movilote", "SUM(cantidad)", "codlote = '" + codLote + "' AND NOT automatico AND NOT reserva");
		if (!enAlmacen)
			enAlmacen = 0;
		if (!util.sqlUpdate("lotes", "enalmacen", enAlmacen, "codlote = '" + codLote + "'"))
			return false;
		if (curMoviLote.modeAccess == curMoviLote.Edit && codLote != curMoviLote.valueBufferCopy("codlote")) {
			enAlmacen = util.sqlSelect("movilote", "SUM(cantidad)", "codlote = '" + curMoviLote.valueBufferCopy("codlote") + "' AND NOT automatico AND NOT reserva");
			if (!enAlmacen)
				enAlmacen = 0;
			if (!util.sqlUpdate("lotes", "enalmacen", enAlmacen, "codlote = '" + curMoviLote.valueBufferCopy("codlote") + "'"))
				return false;
		}
		var idMovilote:Number = curMoviLote.valueBuffer("idmovilote_orig");
		if (curMoviLote.valueBuffer("automatico") || idMovilote) {
			var cantAutomatica:Number = util.sqlSelect("movilote", "SUM(cantidad)", "idmovilote_orig = " + idMovilote);
			if (!cantAutomatica)
				cantAutomatica = 0;
			if (!util.sqlUpdate("movilote", "cantidad_automatica", cantAutomatica, "id = " +  idMovilote))
				return false;
		}
		
	}
	
	var cantidadStock:Number = parseFloat(util.sqlSelect("movilote INNER JOIN lotes ON movilote.codlote = lotes.codlote", "SUM(movilote.cantidad)", "movilote.idstock = " + idStock + " AND NOT movilote.automatico AND NOT movilote.reserva", "movilote,lotes"));
	if (!cantidadStock) cantidadStock = 0;

	var reservadoStock:Number = -1 * parseFloat(util.sqlSelect("movilote INNER JOIN lotes ON movilote.codlote = lotes.codlote", "SUM(movilote.cantidad-movilote.cantidad_automatica)", "movilote.idstock = " + idStock + " AND movilote.reserva", "movilote,lotes"));
	if (!reservadoStock) reservadoStock = 0;

	var disponibleStock:Number = cantidadStock - reservadoStock;

	var curStock:FLSqlCursor = new FLSqlCursor("stocks");
	curStock.select("idstock = " + idStock);
	if(curStock.first()) {
		with(curStock) {
			setModeAccess(Edit);
			refreshBuffer();
			setValueBuffer("cantidad", cantidadStock);
			setValueBuffer("reservada", reservadoStock);
			setValueBuffer("disponible", disponibleStock);
			if(!commitBuffer())
				return false;
		}
	} else
		return false;
	
	return true;
}

function lotes_beforeCommit_movilote(curMoviLote:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	var curRelacionado:FLSqlCursor = curMoviLote.cursorRelation();

	if (curRelacionado && curRelacionado.action() == "lotes") {
		if (curMoviLote.valueBuffer("tipo") != "Regularización") {
			if(curMoviLote.modeAccess() == curMoviLote.Del){
				MessageBox.warning(util.translate("scripts","Sólo puede borrar registros de tipo Regularización"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
			}
		}
	}
	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function lotes_controlStockLineasTrans(curLTS:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	
	var referencia:String = curLTS.valueBuffer("referencia");
	if (!util.sqlSelect("articulos", "porlotes", "referencia = '" + referencia + "'"))
		return this.iface.__controlStockLineasTrans(curLTS);
	var codAlmacenOrigen:String = util.sqlSelect("transstock", "codalmaorigen", "idtrans = " + curLTS.valueBuffer("idtrans"));
	if (!codAlmacenOrigen || codAlmacenOrigen == "")
		return true;
	var idStockOrigen:String = util.sqlSelect("stocks", "idstock", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacenOrigen + "'");
	if (!idStockOrigen) {
		idStockOrigen = this.iface.crearStock(codAlmacenOrigen, referencia);
		if (!idStockOrigen)
			return false;
	}
	
	var codAlmacenDestino:String = util.sqlSelect("transstock", "codalmadestino", "idtrans = " + curLTS.valueBuffer("idtrans"));
	if (!codAlmacenDestino || codAlmacenDestino == "")
		return true;
	var idStockDestino:String = util.sqlSelect("stocks", "idstock", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacenDestino + "'");
	if (!idStockDestino) {
		idStockDestino = this.iface.crearStock(codAlmacenDestino, referencia);
		if (!idStockDestino)
			return false;
	}
	
	var cantidad:Number = parseFloat(curLTS.valueBuffer("cantidad"));
	var codLote:String = curLTS.valueBuffer("codlote");
	var idLinea:String = curLTS.valueBuffer("idlinea");
	
	switch(curLTS.modeAccess()) {
		case curLTS.Insert: {
			var fechaTrans:String = curLTS.cursorRelation().valueBuffer("fecha");
			var curMoviLote:FLSqlCursor = new FLSqlCursor("movilote");
			with(curMoviLote) {
				setModeAccess(Insert);
				refreshBuffer();
				setValueBuffer("codlote", codLote);
				setValueBuffer("idstock", idStockOrigen);
				setValueBuffer("cantidad", (-1 * cantidad));
				setValueBuffer("descripcion", util.translate("scripts", "Transferencia hacia almacén %1").arg(codAlmacenDestino));
				setValueBuffer("fecha", fechaTrans);
				setValueBuffer("tipo", "Transferencia");
				setValueBuffer("docorigen", "TR");
				setValueBuffer("idlineats", idLinea);
				if (!commitBuffer())
					return false;
			}
			with(curMoviLote) {
				setModeAccess(Insert);
				refreshBuffer();
				setValueBuffer("codlote", codLote);
				setValueBuffer("idstock", idStockDestino);
				setValueBuffer("cantidad", cantidad);
				setValueBuffer("descripcion", util.translate("scripts", "Transferencia desde almacén %1").arg(codAlmacenOrigen));
				setValueBuffer("fecha", fechaTrans);
				setValueBuffer("tipo", "Transferencia");
				setValueBuffer("docorigen", "TR");
				setValueBuffer("idlineats", idLinea);
				if (!commitBuffer())
					return false;
			}
			break;
		} case curLTS.Del: {
			
			if (!util.sqlDelete("movilote", "docorigen = 'TR' AND idlineats = " + idLinea + " AND idstock = " + idStockOrigen))
				return false;
			if (!util.sqlDelete("movilote", "docorigen = 'TR' AND idlineats = " + idLinea + " AND idstock = " + idStockDestino))
				return false;
			break;
		} case curLTS.Edit: {
			if (cantidad != curLTS.valueBufferCopy("cantidad")) {
				var cantidadPrevia:Number = parseFloat(curLTS.valueBufferCopy("cantidad"));
				if (!util.sqlUpdate("movilote", "cantidad", (-1 * cantidad), "docorigen = 'TR' AND idlineats = " + idLinea + " AND idstock = " + idStockOrigen))
					return false;
				if (!util.sqlUpdate("movilote", "cantidad", cantidad, "docorigen = 'TR' AND idlineats = " + idLinea + " AND idstock = " + idStockDestino))
					return false;
			}
			break;
		}
	}
	
	return true;
}

/** \C
Actualización del stock correspondiente al artículo seleccionado en la línea
\end */
function lotes_afterCommit_lineastrazabilidadinterna(curLTI:FLSqlCursor):Boolean
{
	if (!flfactalma.iface.controlStockTrazabilidadInterna(curLTI)) {
		return false;
	}
	
	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function lotes_controlStockTrazabilidadInterna(curLTI:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLTI.valueBuffer("referencia") + "'")) {
		return true;
	}

	var codAlmacen:String = util.sqlSelect("trazabilidadinterna", "codalmacen", "codigo = '" + curLTI.valueBuffer("codtrazainterna") + "'");
	if (!codAlmacen || codAlmacen == "") {
		return true;
	}
	
	if (!this.iface.controlStock(curLTI, "cantidad", 1, codAlmacen)) {
		return false;
	}

	return true;
}

//// LOTES //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition articuloscomp */
/////////////////////////////////////////////////////////////////
//// ARTICULOSCOMP //////////////////////////////////////////////
function articuloscomp_cambiarStock(codAlmacen:String, referencia:String, variacion:Number, campo:String):Boolean 
{
	var util:FLUtil = new FLUtil();
	
	if (!util.sqlSelect("articuloscomp","refcompuesto","refcompuesto = '" + referencia + "'")){
		if (!this.iface.__cambiarStock(codAlmacen,referencia,variacion,campo))
			return false;
	} else {
		var qry:FLSqlQuery = new FLSqlQuery();
		qry.setTablesList("articuloscomp");
		qry.setSelect("refcomponente, cantidad");
		qry.setFrom("articuloscomp");
		qry.setWhere("refcompuesto = '" + referencia + "' AND (idtipoopcionart IS NULL OR idtipoopcionart = 0)");
		
		if (!qry.exec())
			return false;
			
		var refComp:String = "";
		var cantidad:Number = 0;
		
		while (qry.next()) {
			refComp = qry.value(0);
			cantidad = variacion * parseFloat(qry.value(1));
			if (!this.iface.cambiarStock(codAlmacen, refComp, cantidad, campo))
				return false;
		}
	}

	return true;
	
}

/** \D Calcula el precio de un artículo compuesto como suma de los precios de sus componentes
@param	referencia: Referencia del artículo cuyo precio se desea calcular
@return: Precio calculado o false si hay error
\end */
function articuloscomp_pvpCompuesto(referencia:String):Number
{
	var util:FLUtil = new FLUtil();
	
	var qry:FLSqlQuery = new FLSqlQuery();
	qry.setTablesList("articuloscomp,articulos");
	qry.setSelect("SUM(a.pvp * ac.cantidad)");
	qry.setFrom("articuloscomp ac INNER JOIN articulos a ON ac.refcomponente = a.referencia");
	qry.setWhere("ac.refcompuesto = '" + referencia + "'");
	
	if(!qry.exec())
		return false;
		
	if (!qry.first())
		return false;
	
	var resultado:Number = util.roundFieldValue(qry.value(0), "articulos", "pvp");
	return resultado;
}

function articuloscomp_beforeCommit_articulos(curArticulo:FLSqlCursor):Boolean
{
	var util:FLUtil;

	switch(curArticulo.modeAccess()) {
		case curArticulo.Edit:
			var unidadAnterior:String = curArticulo.valueBufferCopy("codunidad");
			var unidadActual:String = curArticulo.valueBuffer("codunidad");
			if (unidadAnterior != unidadActual) {
				MessageBox.information(util.translate("scripts","Ha cambiado la unidad del artículo. Se va a actualizar esta unidad para los artículos compuestos."),MessageBox.Ok, MessageBox.NoButton);
				if (!this.iface.actualizarUnidad(curArticulo.valueBuffer("referencia"),unidadActual))
					return false;
			}
		case curArticulo.Insert:
			/// Parcheado ¿por qué hay que ponerloa a cero?
			// Si es un compuesto el stockminimo se pone a cero
// 			if (util.sqlSelect("articuloscomp","id","refcompuesto = '" + curArticulo.valueBuffer("referencia") + "'")) {
// 				if (curArticulo.valueBuffer("stockmin") != 0)
// 					curArticulo.setValueBuffer("stockmin", 0);
// 				if (curArticulo.valueBuffer("stockmax") != 0)
// 					curArticulo.setValueBuffer("stockmax", 0);
// 			}
		break;
	}

	return true;
}

function articuloscomp_actualizarUnidad(referencia:String,unidad:String):Boolean
{
	var curArticulosComp:FLSqlCursor = new FLSqlCursor("articuloscomp");
	curArticulosComp.select("refcomponente = '" + referencia + "'");
	if(!curArticulosComp.first())
		return true;
	
	do {
		curArticulosComp.setModeAccess(curArticulosComp.Edit);
		curArticulosComp.refreshBuffer();
		curArticulosComp.setValueBuffer("codunidad",unidad);
		if(!curArticulosComp.commitBuffer())
			return false;

	} while (curArticulosComp.next());
	
	return true;
}

function articuloscomp_calcularFiltroReferencia(referencia:String):String
{	
	if (!referencia || referencia == "")
		return "";

	var lista:String = "'" + referencia + "'";
	var refCompuesto:String = referencia;
	
	if (refCompuesto && refCompuesto != "") {
		var q:FLSqlQuery = new FLSqlQuery();
		q.setTablesList("articuloscomp");
		q.setSelect("refcompuesto");
		q.setFrom("articuloscomp");
		q.setWhere("refcomponente = '" + refCompuesto + "'");
		if(!q.exec())
			return;

		while (q.next())
			lista = lista + ", " + this.iface.calcularFiltroReferencia(q.value("refcompuesto"));
	}

	return lista;
}

function articuloscomp_afterCommit_tiposopcionartcomp(curTOAC:FLSqlCursor):Boolean
{
	var util:FLUtil;

	var referencia:String = curTOAC.valueBuffer("referencia");
	var variable:Boolean = false;

	if(formRecordarticulos.iface.pub_esArticuloVariable(referencia)) {
		variable = true;
	}

	if(!util.sqlUpdate("articulos","variable",variable,"referencia = '" + referencia + "'"))
		return false;
	if(!this.iface.comprobarPadresVariables(referencia))
		return false;

	return true;
}

function articuloscomp_afterCommit_articuloscomp(curAC:FLSqlCursor):Boolean
{
	var util:FLUtil;

	var referencia:String = curAC.valueBuffer("refcompuesto");
	var variable:Boolean = false;

	if(formRecordarticulos.iface.pub_esArticuloVariable(referencia)) {
		variable = true;
	}

	if(!util.sqlUpdate("articulos","variable",variable,"referencia = '" + referencia + "'"))
		return false;

	if(!this.iface.comprobarPadresVariables(referencia))
		return false;

	return true;
}

function articuloscomp_comprobarPadresVariables(referencia:String):Boolean
{
	var util:FLUtil;

	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("articuloscomp");
	q.setSelect("refcompuesto");
	q.setFrom("articuloscomp");
	q.setWhere("refcomponente = '" + referencia + "'");
	if(!q.exec())
		return;

	var variable:Boolean;
	var refCompuesto:String
	while (q.next()) {
		refCompuesto = q.value("refcompuesto");
		variable = false;

		if(formRecordarticulos.iface.pub_esArticuloVariable(q.value("refcompuesto"))) {
			variable = true;
		}

		if(!util.sqlUpdate("articulos","variable",variable,"referencia = '" + refCompuesto + "'"))
			return false;
		if(!this.iface.comprobarPadresVariables(refCompuesto))
			return false;
	}

	return true;
}

function articuloscomp_beforeCommit_opcionesarticulocomp(curOP:FLSqlCursor):Boolean
{
	var util:FLUtil;
	
	if(curOP.modeAccess() == curOP.Insert || curOP.modeAccess() == curOP.Edit) {
		var idOpcion:Number = curOP.valueBuffer("idopcion");
		var idTipoOpcionArt:Number = curOP.valueBuffer("idtipoopcionart");
		var idOpcionArticulo:Number = curOP.valueBuffer("idopcionarticulo");
	
		if(util.sqlSelect("opcionesarticulocomp","idopcionarticulo","idopcion = " + idOpcion + " AND idtipoopcionart = " + idTipoOpcionArt + " AND idopcionarticulo <> " + idOpcionArticulo)) {
			MessageBox.warning(util.translate("scripts", "Ya existe una opción de este tipo para este artículo"), MessageBox.Ok, MessageBox.NoButton);
			return false;
		}
	}
	
	return true;
}
//// ARTICULOSCOMP //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition funNumSerie */
//////////////////////////////////////////////////////////////////////
//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////

function funNumSerie_insertarNumSerie(referencia:String, numSerie:String, idAlbaran:Number, idFactura:Number ):Boolean 
{
	var util:FLUtil = new FLUtil();
	
	var curNS:FLSqlCursor = new FLSqlCursor("numerosserie");
	
	// Ye existe
	curNS.select("referencia = '" + referencia + "' AND numserie = '" + numSerie + "'");
	if (curNS.first()) return true;
	
	curNS.setModeAccess(curNS.Insert);
	curNS.refreshBuffer();
	curNS.setValueBuffer("referencia", referencia);
	curNS.setValueBuffer("numserie", numSerie);
	if (idAlbaran > -1) {
		curNS.setValueBuffer("idalbarancompra", idAlbaran);
		curNS.setValueBuffer("codalmacen", util.sqlSelect("albaranesprov", "codalmacen", "idalbaran = " + idAlbaran));
	}
	if (idFactura > -1) {
		curNS.setValueBuffer("idfacturacompra", idFactura);
		curNS.setValueBuffer("codalmacen", util.sqlSelect("facturasprov", "codalmacen", "idfactura = " + idFactura));
	}
	if (!curNS.commitBuffer()) return false;
	
	return true;
}

function funNumSerie_borrarNumSerie(referencia:String, numSerie:String ):Boolean 
{
	var curNS:FLSqlCursor = new FLSqlCursor("numerosserie");
	
	curNS.select("referencia = '" + referencia + "' AND numserie = '" + numSerie + "'");
	if (curNS.first()) {
		curNS.setModeAccess(curNS.Del);
		curNS.refreshBuffer();
		if (!curNS.commitBuffer()) return false;
	}
	return true;
}

function funNumSerie_modificarNumSerie(referencia:String, numserie:String, campo:String, valor:Number)
{
	var curNS:FLSqlCursor = new FLSqlCursor("numerosserie");
	curNS.select("referencia = '" + referencia + "' AND numserie = '" + numserie + "'");
	if (curNS.first()) {
		curNS.setModeAccess(curNS.Edit);
		curNS.refreshBuffer();
		curNS.setValueBuffer(campo, valor);
		if (!curNS.commitBuffer()) return false;
	}
	return true;
}

/** Recalcula el stock de unidades del artículo; lo hace para poder introducir números
de serie directamente -sin facturacion-
*/
function funNumSerie_afterCommit_numerosSerie(curNS:FLSqlCursor) 
{
	if (curNS.modeAccess() == curNS.Edit) return true;
	
	var util:FLUtil = new FLUtil();
	var stockNS:Number = util.sqlSelect("numerosserie", "count(id)", "referencia = '" + curNS.valueBuffer("referencia") + "' AND vendido = false AND codalmacen = '" + curNS.valueBuffer("codalmacen") + "'");
	
	var curStock:FLSqlCursor = new FLSqlCursor("stocks");
	curStock.select("referencia = '" + curNS.valueBuffer("referencia") + "' AND codalmacen = '" + curNS.valueBuffer("codalmacen") + "'");
	
	if (curStock.first()) {
		curStock.setModeAccess(curStock.Edit);
		curStock.refreshBuffer();
		curStock.setValueBuffer("cantidad", stockNS);
		if (!curStock.commitBuffer()) {
			MessageBox.warning(util.translate("scripts", "Error al actualizar el stock del artículo por números de serie"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
	}	
	else 
	
	if (curNS.modeAccess() == curNS.Insert) {
		// No hay stock en este almacén, nueva línea de stocks
		curStock.setModeAccess(curStock.Insert);
		curStock.refreshBuffer();
		curStock.setValueBuffer("referencia", curNS.valueBuffer("referencia"));
		curStock.setValueBuffer("codalmacen", curNS.valueBuffer("codalmacen"));
		curStock.setValueBuffer("cantidad", stockNS);
		if (!curStock.commitBuffer()) {
			MessageBox.warning(util.translate("scripts", "Error al actualizar el stock del artículo por números de serie"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
	}
	
	
	return true;
}

/** \C
Actualiza el stock correspondiente al artículo seleccionado en la línea
\end */
function funNumSerie_controlStockLineasTrans(curLTS:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();
	
	var referencia:String = curLTS.valueBuffer("referencia");
	if (!util.sqlSelect("articulos", "controlnumserie", "referencia = '" + referencia + "'"))
		return this.iface.__controlStockLineasTrans(curLTS);

	var codAlmacenOrigen:String = util.sqlSelect("transstock", "codalmaorigen", "idtrans = " + curLTS.valueBuffer("idtrans"));
	if (!codAlmacenOrigen || codAlmacenOrigen == "")
		return true;

	var codAlmacenDestino:String = util.sqlSelect("transstock", "codalmadestino", "idtrans = " + curLTS.valueBuffer("idtrans"));
	if (!codAlmacenDestino || codAlmacenDestino == "")
		return true;
	
	if (!this.iface.controlStock(curLTS, "cantidad", -1, codAlmacenOrigen))
		return false;

	if (!this.iface.controlStock(curLTS, "cantidad", 1, codAlmacenDestino))
		return false;

	var numSerie:String = curLTS.valueBuffer("numserie");
	
	switch (curLTS.modeAccess()) {
		case curLTS.Insert: {
			this.iface.modificarNumSerie(referencia, numSerie, "codalmacen", codAlmacenDestino);
			break;
		} case curLTS.Del: {
			this.iface.modificarNumSerie(referencia, numSerie, "codalmacen", codAlmacenOrigen);
			break;
		}
 	}
	
	return true;
}

//// FUN_NUMEROS_SERIE /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition costos */
/////////////////////////////////////////////////////////////////
//// COSTOS /////////////////////////////////////////////////////

function costos_cambiarCosteUltimo(referencia:String):Boolean
{
	if (referencia == "")
		return true;

	var util:FLUtil = new FLUtil();

	var cant:Number = util.sqlSelect("lineasfacturasprov", "cantidad", "referencia = '" + referencia + "' ORDER BY idlinea DESC LIMIT 1");
	if ( !cant || cant == 0)
		return true;

	var costoUltimo:Number = parseFloat(util.sqlSelect("lineasfacturasprov lf INNER JOIN facturasprov f ON lf.idfactura = f.idfactura", "(lf.pvptotal / lf.cantidad)*f.tasaconv", "lf.referencia = '" + referencia + "' ORDER BY lf.idlinea DESC LIMIT 1", "lineasfacturasprov,facturasprov"));
	if (!costoUltimo)
		costoUltimo = 0;

	var curArticulo:FLSqlCursor = new FLSqlCursor("articulos");
	curArticulo.select("referencia = '" + referencia + "'");
	if (curArticulo.first()) {
		curArticulo.setModeAccess(curArticulo.Edit);
		curArticulo.refreshBuffer();
		curArticulo.setValueBuffer("costeultimo", costoUltimo);
		curArticulo.commitBuffer();
	}

	return true;
}

function costos_cambiarCosteMaximo(referencia:String):Boolean
{
	if (referencia == "")
		return true;

	var util:FLUtil = new FLUtil();

	var costoUltimo:Number = parseFloat(util.sqlSelect("articulos", "costeultimo", "referencia = '" + referencia + "'"));
	if (!costoUltimo)
		costoUltimo = 0;

	var costoMaximo:Number = parseFloat(util.sqlSelect("articulos", "costemaximo", "referencia = '" + referencia + "'"));
	if (!costoMaximo)
		costoMaximo = 0;

	if (costoUltimo > costoMaximo) {
		var curArticulo:FLSqlCursor = new FLSqlCursor("articulos");
		curArticulo.select("referencia = '" + referencia + "'");
		if (curArticulo.first()) {
			curArticulo.setModeAccess(curArticulo.Edit);
			curArticulo.refreshBuffer();
			curArticulo.setValueBuffer("costemaximo", costoUltimo);
			curArticulo.commitBuffer();
		}
	}

	return true;
}

function costos_cambiarCosteProveedor(curL:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	var referencia:String = curL.valueBuffer("referencia");
	var codProveedor:String = util.sqlSelect("facturasprov","codproveedor","idfactura = " + curL.valueBuffer("idfactura"));
	var codDivisa:String = util.sqlSelect("articulosprov","coddivisa","referencia = '" + referencia + "' AND codproveedor = '" + codProveedor + "'");
	var coste:Number = 0;

	var qryLineaFactura:FLSqlQuery = new FLSqlQuery();
	qryLineaFactura.setTablesList("lineasfacturasprov,facturasprov");
	qryLineaFactura.setSelect("lf.pvptotal/lf.cantidad");
	qryLineaFactura.setFrom("lineasfacturasprov lf INNER JOIN facturasprov f ON lf.idfactura = f.idfactura");
	qryLineaFactura.setWhere("lf.referencia = '" + referencia + "' AND f.codproveedor = '" + codProveedor + "' AND f.coddivisa = '" + codDivisa + "'");
	qryLineaFactura.setOrderBy("lf.idlinea DESC LIMIT 1");
	qryLineaFactura.exec();
	if (qryLineaFactura.first()) {
		coste = parseFloat(qryLineaFactura.value(0));
	}

	var curArticuloProv:FLSqlCursor = new FLSqlCursor("articulosprov");
	curArticuloProv.select("referencia = '" + referencia + "' AND codproveedor = '" + codProveedor + "'");
	if (curArticuloProv.first()) {
		curArticuloProv.setModeAccess(curArticuloProv.Edit);
		curArticuloProv.refreshBuffer();
		curArticuloProv.setValueBuffer("coste", coste);
		curArticuloProv.commitBuffer();
	}

	return true;
}

//// COSTOS /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition lineasArticulos */
/////////////////////////////////////////////////////////////////
//// LINEAS_ARTICULOS ///////////////////////////////////////////

function lineasArticulos_afterCommit_lineastrazabilidadinterna(curLA:FLSqlCursor):Boolean
{
	if ( !this.iface.__afterCommit_lineastrazabilidadinterna(curLA) )
		return false;

	if (curLA.modeAccess() == curLA.Insert || curLA.modeAccess() == curLA.Edit) {
		if (curLA.valueBuffer("cantidad") > 0) {
			this.iface.generarLineaEntrada("Mov. interno", curLA);
		}
		else {
			this.iface.generarLineaSalida("Mov. interno", curLA);
		}
	}

	return true;
}

function lineasArticulos_generarLineaSalida(documento:String, curLS:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	var codigo:String = curLS.valueBuffer("codtrazainterna");

	// Si está editando entonces existe una linea de salida; la busco y la borro
	if (curLS.modeAccess() == curLS.Edit) {
		this.iface.borrarLineaSalida(curLS, "idlineatrazainterna", "codtrazainterna");
	}

	var fecha:String = util.sqlSelect("trazabilidadinterna", "fecha", "codigo = '" + codigo + "'");
	var cliente:String = "Usuario: " + util.sqlSelect("usuarios", "nombre", "idusuario = '" + sys.nameUser() + "'");

	var curLineaSalida:FLSqlCursor = new FLSqlCursor("lineassalidasarticulos");
	with (curLineaSalida) {
		setModeAccess(curLineaSalida.Insert);
		refreshBuffer();
		setValueBuffer("idlineatrazainterna", curLS.valueBuffer("idlinea"));
		setValueBuffer("codtrazainterna", curLS.valueBuffer("codtrazainterna"));
		setValueBuffer("referencia", curLS.valueBuffer("referencia"));
		setValueBuffer("descripcion", curLS.valueBuffer("descripcion"));
		setValueBuffer("fecha", fecha );
		setValueBuffer("documento", documento );
		setValueBuffer("codigo", codigo );
		setNull("codcliente");
		setValueBuffer("nombrecliente", cliente);
		setValueBuffer("cantidad", curLS.valueBuffer("cantidad") * -1);
		setValueBuffer("pvpunitario", 0);
		setValueBuffer("pvpsindto", 0);
		setValueBuffer("pvptotal", 0);
		setValueBuffer("totalconiva", 0);
		setValueBuffer("dtolineal", 0);
		setValueBuffer("dtopor", 0);
		setValueBuffer("costounitario", 0);
		setValueBuffer("costototal", 0);
		setValueBuffer("ganancia", 0);
		setValueBuffer("utilidad", 0);
	}
	if (!curLineaSalida.commitBuffer())
		return false;

	return true;
}

function lineasArticulos_borrarLineaSalida(curLS:FLSqlCursor, nombreIdLinea:String, nombreIdTabla:String)
{
	var lineaSalida:FLSqlCursor = new FLSqlCursor("lineassalidasarticulos");
	lineaSalida.select(nombreIdLinea + " = " + curLS.valueBuffer("idlinea") + " AND " + nombreIdTabla + " = '" + curLS.valueBuffer("codtrazainterna") + "'");
	if (lineaSalida.next()) {
		lineaSalida.setActivatedCheckIntegrity(false);
		lineaSalida.setModeAccess(lineaSalida.Del);
		lineaSalida.refreshBuffer();
		lineaSalida.commitBuffer();
	}
}

function lineasArticulos_generarLineaEntrada(documento:String, curLE:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	var codigo:String = curLE.valueBuffer("codtrazainterna");

	// Si está editando entonces existe una linea de entrada; la busco y la borro
	if (curLE.modeAccess() == curLE.Edit) {
		this.iface.borrarLineaEntrada(curLE, "idlineatrazainterna", "codtrazainterna");
	}

	var fecha:String = util.sqlSelect("trazabilidadinterna", "fecha", "codigo = '" + codigo + "'");
	var proveedor:String = "Usuario: " + util.sqlSelect("usuarios", "nombre", "idusuario = '" + sys.nameUser() + "'");

	var curLineaEntrada:FLSqlCursor = new FLSqlCursor("lineasentradasarticulos");
	with (curLineaEntrada) {
		setModeAccess(curLineaEntrada.Insert);
		refreshBuffer();
		setValueBuffer("idlineatrazainterna", curLE.valueBuffer("idlinea"));
		setValueBuffer("codtrazainterna", curLE.valueBuffer("codtrazainterna"));
		setValueBuffer("referencia", curLE.valueBuffer("referencia"));
		setValueBuffer("descripcion", curLE.valueBuffer("descripcion"));
		setValueBuffer("fecha", fecha );
		setValueBuffer("documento", documento );
		setValueBuffer("codigo", codigo );
		setNull("codproveedor");
		setValueBuffer("nombreproveedor", proveedor );
		setValueBuffer("cantidad", curLE.valueBuffer("cantidad"));
		setValueBuffer("pvpunitario", 0);
		setValueBuffer("pvpsindto", 0);
		setValueBuffer("pvptotal", 0);
		setValueBuffer("totalconiva", 0);
		setValueBuffer("dtolineal", 0);
		setValueBuffer("dtopor", 0);
	}
	if (!curLineaEntrada.commitBuffer())
		return false;

	return true;
}

function lineasArticulos_borrarLineaEntrada(curLE:FLSqlCursor, nombreIdLinea:String, nombreIdTabla:String)
{
	var lineaEntrada:FLSqlCursor = new FLSqlCursor("lineasentradasarticulos");
	lineaEntrada.select(nombreIdLinea + " = " + curLE.valueBuffer("idlinea") + " AND " + nombreIdTabla + " = '" + curLE.valueBuffer("codtrazainterna") + "'");
	if (lineaEntrada.next()) {
		lineaEntrada.setActivatedCheckIntegrity(false);
		lineaEntrada.setModeAccess(lineaEntrada.Del);
		lineaEntrada.refreshBuffer();
		lineaEntrada.commitBuffer();
	}
}

//// LINEAS_ARTICULOS ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition controlUsuario */
/////////////////////////////////////////////////////////////////
//// CONTROL_USUARIO ////////////////////////////////////////////

function controlUsuario_beforeCommit_lineasregstocks(curLRS:FLSqlCursor):Boolean
{
	switch (curLRS.modeAccess()) {
		case curLRS.Insert: {
			if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
				flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Regularizaciones de stocks");
				return false;
			} else {
				curLRS.setValueBuffer( "idusuario", sys.nameUser() );
			}
			break;
		}
		break;
	}

	return true;
}

function controlUsuario_beforeCommit_trazabilidadinterna(curTI:FLSqlCursor):Boolean
{
	switch (curTI.modeAccess()) {
		case curTI.Insert: {
			if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
				flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Movimientos internos");
				return false;
			} else {
				curTI.setValueBuffer( "idusuario", sys.nameUser() );
			}
			break;
		}
		break;
	}

	return true;
}

function controlUsuario_beforeCommit_transstock(curTS:FLSqlCursor):Boolean
{
	switch (curTS.modeAccess()) {
		case curTS.Insert: {
			if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
				flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Transferencias de stocks");
				return false;
			} else {
				curTS.setValueBuffer( "idusuario", sys.nameUser() );
			}
			break;
		}
		break;
	}

	return true;
}

function controlUsuario_beforeCommit_movilote(curMoviLote:FLSqlCursor):Boolean
{
	switch (curMoviLote.modeAccess()) {
		case curMoviLote.Insert: {
			if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
				flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Movimientos de lotes");
				return false;
			} else {
				curMoviLote.setValueBuffer( "idusuario", sys.nameUser() );
			}
			break;
		}
		break;
	}

	return this.iface.__beforeCommit_movilote(curMoviLote);
}

//// CONTROL_USUARIO //////////////////////////////////////////
///////////////////////////////////////////////////////////////

/** @class_definition multiFamilia */
/////////////////////////////////////////////////////////////////
//// MULTI FAMILIA //////////////////////////////////////////////

/** \D
Si se modificó la descripción de la familia se actualizan las descripciones extendidas de las familias hijas
\end */
function multiFamilia_afterCommit_familias(cursor:FLSqlCursor):Boolean
{
	if ( cursor.modeAccess() == cursor.Edit ) {

		var descExtFamiliaMadre:String = cursor.valueBuffer("descripcionextendida") + " > ";

		var curFamiliaHija:FLSqlCursor = new FLSqlCursor("familias");
		curFamiliaHija.select("codmadre = '" + cursor.valueBuffer("codfamilia") + "'");
		while (curFamiliaHija.next()) {
			curFamiliaHija.setModeAccess(curFamiliaHija.Edit);
			curFamiliaHija.refreshBuffer();
			curFamiliaHija.setValueBuffer("descripcionextendida", descExtFamiliaMadre + curFamiliaHija.valueBuffer("descripcion"));
			curFamiliaHija.commitBuffer();
		}
	}

	return true;
}

//// MULTI FAMILIA //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////