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

/** @class_declaration desbloqueoStock */
/////////////////////////////////////////////////////////////////
//// DESBLOQUEO AL MODIFICAR STOCK //////////////////////////////
/* El objetivo de esta extensión es permitir que dos o más usuarios puedan trabajar simultánemente, sin bloquearse, sobre el stock de un artículo */
class desbloqueoStock extends multiFamilia {
    function desbloqueoStock( context ) { multiFamilia ( context ); }
	function controlMoviStock( curLinea:FLSqlCursor, tipoDoc:String, campo:String, signo:Number, codAlmacen:String ):Boolean {
		return this.ctx.desbloqueoStock_controlMoviStock( curLinea, tipoDoc, campo, signo, codAlmacen );
	}
	function cambiarMoviStock(codAlmacen:String, referencia:String, tipoDoc:String, idDoc:Number, idLinea:Number, variacion:Number, campo:String, numSerie:String, eliminado:String):Boolean {
		return this.ctx.desbloqueoStock_cambiarMoviStock(codAlmacen, referencia, tipoDoc, idDoc, idLinea, variacion, campo, numSerie, eliminado);
	}
	function crearMoviStock(codAlmacen:String, referencia:String, tipoDoc:String, idLinea:Number, numSerie:String):Number {
		return this.ctx.desbloqueoStock_crearMoviStock(codAlmacen, referencia, tipoDoc, idLinea, numSerie);
	}
	function comprobarStock(codAlmacen:String, referencia:String, cantidad:Number, disponible:Number):Boolean {
		return this.ctx.desbloqueoStock_comprobarStock(codAlmacen, referencia, cantidad, disponible);
	}
	function controlStockFacturasCli(curLF:FLSqlCursor):Boolean {
		return this.ctx.desbloqueoStock_controlStockFacturasCli(curLF);
	}
	function controlStockAlbaranesCli(curLA:FLSqlCursor):Boolean {
		return this.ctx.desbloqueoStock_controlStockAlbaranesCli(curLA);
	}
	function controlStockPedidosCli(curLP:FLSqlCursor):Boolean {
		return this.ctx.desbloqueoStock_controlStockPedidosCli(curLP);
	}
	function controlStockFacturasProv(curLF:FLSqlCursor):Boolean {
		return this.ctx.desbloqueoStock_controlStockFacturasProv(curLF);
	}
	function controlStockAlbaranesProv(curLA:FLSqlCursor):Boolean {
		return this.ctx.desbloqueoStock_controlStockAlbaranesProv(curLA);
	}
	function controlStockComandasCli(curLV:FLSqlCursor):Boolean {
		return this.ctx.desbloqueoStock_controlStockComandasCli(curLV);
	}
	function controlStockValesTPV(curLinea:FLSqlCursor):Boolean {
		return this.ctx.desbloqueoStock_controlStockValesTPV(curLinea);
	}
}
//// DESBLOQUEO AL MODIFICAR STOCK //////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration desbloqueoStockLotes */
/////////////////////////////////////////////////////////////////
//// DESBLOQUEO AL MODIFICAR STOCK LOTES ////////////////////////
/* El objetivo de esta extensión es permitir que dos o más usuarios puedan trabajar simultánemente, sin bloquearse, sobre el stock de un artículo controlado por lotes */
class desbloqueoStockLotes extends desbloqueoStock {
    function desbloqueoStockLotes( context ) { desbloqueoStock ( context ); }
	function afterCommit_movilote(curMoviLote:FLSqlCursor):Boolean {
		return this.ctx.desbloqueoStockLotes_afterCommit_movilote(curMoviLote);
	}
	function cambiarStockLote(curMoviLote:FLSqlCursor):Boolean {
		return this.ctx.desbloqueoStockLotes_cambiarStockLote(curMoviLote);
	}
	function beforeCommit_transstock(curTS:FLSqlCursor):Boolean {
		return this.ctx.desbloqueoStockLotes_beforeCommit_transstock(curTS);
	}
	function controlStockTrazabilidadInterna(curLTI:FLSqlCursor):Boolean {
		return this.ctx.desbloqueoStockLotes_controlStockTrazabilidadInterna(curLTI);
	}
	function beforeCommit_trazabilidadinterna(curTI:FLSqlCursor):Boolean {
		return this.ctx.desbloqueoStockLotes_beforeCommit_trazabilidadinterna(curTI);
	}
}
//// DESBLOQUEO AL MODIFICAR STOCK LOTES ////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration desbloqueoStockNumSerie */
//////////////////////////////////////////////////////////////////
//// DESBLOQUEO NUMEROS SERIE ////////////////////////////////////
class desbloqueoStockNumSerie extends desbloqueoStockLotes {
	function desbloqueoStockNumSerie( context ) { desbloqueoStockLotes( context ); } 
	function afterCommit_numerosserie(curNS:FLSqlCursor):Boolean {
		return this.ctx.desbloqueoStockNumSerie_afterCommit_numerosserie(curNS);
	}
	function actualizarStockNumSerie(codAlmacen:String, referencia:String):Boolean {
		return this.ctx.desbloqueoStockNumSerie_actualizarStockNumSerie(codAlmacen, referencia);
	}
}
//// DESBLOQUEO NUMEROS SERIE ////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends desbloqueoStockNumSerie {
    function head( context ) { desbloqueoStockNumSerie ( context ); }
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
	function pub_actualizarStockNumSerie(codAlmacen:String, referencia:String):Boolean {
		return this.actualizarStockNumSerie(codAlmacen, referencia);
	}
}
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubLotes */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class pubLotes extends ifaceCtx {
	function pubLotes( context ) { ifaceCtx( context ); }
	function pub_cambiarStockLote(curMoviLote:FLSqlCursor):Boolean {
		return this.cambiarStockLote(curMoviLote);
	}
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
	var util:FLUtil = new FLUtil();

	switch(curArticulo.modeAccess()) {
		case curArticulo.Edit:
			var unidadAnterior:String = curArticulo.valueBufferCopy("codunidad");
			var unidadActual:String = curArticulo.valueBuffer("codunidad");
			if (unidadAnterior != unidadActual) {
				if ( util.sqlSelect("articuloscomp", "id", "refcomponente = '" + curArticulo.valueBuffer("referencia") + "'") ) {
					MessageBox.information(util.translate("scripts","Ha cambiado la unidad del artículo. Se va a actualizar esta unidad para los artículos compuestos."),MessageBox.Ok, MessageBox.NoButton);
					if (!this.iface.actualizarUnidad(curArticulo.valueBuffer("referencia"),unidadActual))
						return false;
				}
			}
		break;
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

/** @class_declaration desbloqueoStock */
/////////////////////////////////////////////////////////////////
//// DESBLOQUEO AL MODIFICAR STOCK //////////////////////////////

/* El objetivo de esta extensión es permitir que dos o más usuarios puedan trabajar simultánemente, sin bloquearse, sobre el stock de un artículo */

/** \D Incrementa o decrementa el stock que figura en la tabla movistock, en función de la variación experimentada por una línea de un documento de facturación específico
@param	curLinea: Cursor posicionado en la línea de documento de facturación
@param	tipoDoc: tipo de documento asociado al movimiento (RP,FP,PC,RC,FC,RE,TR,MI). Ver movistock.mtd
@param	campo: Campo a modificar
@param	signo: Indica si la cantidad debe sumarse o restarse del stock
@param	codAlmacen: Código del almacén asociado al stock a modificar
@return	True si el control se realiza correctamente, false en caso contrario
*/
function desbloqueoStock_controlMoviStock( curLinea:FLSqlCursor, tipoDoc:String, campo:String, signo:Number, codAlmacen:String ):Boolean 
{
	var util:FLUtil = new FLUtil();
	
	var linea = "idlinea";
	if (curLinea.table() == "tpv_lineascomanda")
		linea = "idtpv_linea";
	
	var idDoc:Number = 0;
	var numSerie = "";
	switch (curLinea.table()) {
		case "lineasfacturascli":
		case "lineasfacturasprov": {
			idDoc = curLinea.valueBuffer("idfactura")
			numSerie = curLinea.valueBuffer("numserie");
			break;
		}
		case "lineasalbaranescli":
		case "lineasalbaranesprov": {
			idDoc = curLinea.valueBuffer("idalbaran");
			numSerie = curLinea.valueBuffer("numserie");
			break;
		}
		case "lineaspedidoscli": {
			idDoc = curLinea.valueBuffer("idpedido");
			break;
		}
		case "tpv_lineascomanda": {
			idDoc = util.sqlSelect("tpv_comandas", "iddocumento", "idtpv_comanda = " + curLinea.valueBuffer("idtpv_comanda"));
			numSerie = curLinea.valueBuffer("numserie");
			break;
		}
		case "lineastransstock": {
			idDoc = curLinea.valueBuffer("idtrans");
			break;
		}
		case "lineastrazabilidadinterna": {
			idDoc = curLinea.valueBuffer("codtrazainterna");
			break;
		}
	}
	
	var variacion:Number;
	var cantidad:Number = parseFloat( curLinea.valueBuffer( "cantidad" ) );
	var cantidadPrevia:Number = parseFloat( curLinea.valueBuffer( "cantidadprevia" ) );
	if (isNaN(cantidadPrevia) || !cantidadPrevia)
		cantidadPrevia = 0;
	
// 	if ( curLinea.table() == "lineaspedidoscli" || curLinea.table() == "lineaspedidosprov" ) {
// 		cantidad -= parseFloat( curLinea.valueBuffer( "totalenalbaran" ) );
// 		cantidadPrevia -= parseFloat( curLinea.valueBufferCopy( "totalenalbaran" ) );
// 	}

	switch(curLinea.modeAccess()) {
		case curLinea.Insert: {
			variacion = signo * cantidad;
			if ( !this.iface.cambiarMoviStock( codAlmacen, curLinea.valueBuffer( "referencia" ), tipoDoc, idDoc, curLinea.valueBuffer( linea ), variacion, campo, numSerie, "false" ) )
				return false;
			break;
		}
		case curLinea.Del: {
			variacion = signo * -1 * cantidad;
			if ( !this.iface.cambiarMoviStock( codAlmacen, curLinea.valueBuffer( "referencia" ), tipoDoc, idDoc, curLinea.valueBuffer( linea ), variacion, campo, numSerie, "true" ) )
				return false;
			break;
		}
		case curLinea.Edit: {
			if (curLinea.valueBuffer( "referencia" ) != curLinea.valueBufferCopy( "referencia" )) {
				variacion = signo * -1 * cantidadPrevia;
				if ( !this.iface.cambiarMoviStock( codAlmacen, curLinea.valueBufferCopy( "referencia" ), tipoDoc, idDoc, curLinea.valueBuffer( linea ), variacion, campo, numSerie, "true" ) )
					return false;
				variacion = signo * cantidad;
				if ( !this.iface.cambiarMoviStock( codAlmacen, curLinea.valueBuffer( "referencia" ), tipoDoc, idDoc, curLinea.valueBuffer( linea ), variacion, campo, numSerie, "false" ) )
					return false;
			}
			else if ( numSerie != "" && (numSerie != curLinea.valueBufferCopy( "numserie" )) ) {
				variacion = signo * -1 * cantidadPrevia;
				if ( !this.iface.cambiarMoviStock( codAlmacen, curLinea.valueBuffer( "referencia" ), tipoDoc, idDoc, curLinea.valueBuffer( linea ), variacion, campo, curLinea.valueBufferCopy( "numserie" ), "true" ) )
					return false;
				variacion = signo * cantidad;
				if ( !this.iface.cambiarMoviStock( codAlmacen, curLinea.valueBuffer( "referencia" ), tipoDoc, idDoc, curLinea.valueBuffer( linea ), variacion, campo, numSerie, "false" ) )
					return false;
			}
			else {
				if(cantidad != cantidadPrevia) {
					variacion = (cantidad - cantidadPrevia) * signo;
					if (!this.iface.cambiarMoviStock( codAlmacen, curLinea.valueBuffer( "referencia" ), tipoDoc, idDoc, curLinea.valueBuffer( linea ), variacion, campo, numSerie, "false" ) )
						return false;
				}
			}
			break;
		}
	}

	return true;
}

/** \D Cambia el valor del stock en la tabla movistock. Se comprueba si el valor de la variación es negativo y mayor al stock actual, en cuyo caso se avisa al usuario de la falta de existencias
@param codAlmacen Código del almacén
@param referencia Referencia del artículo
@param tipoDoc: tipo de documento asociado al movimiento (RP,FP,PC,RC,FC,RE,TR,MI). Ver movistock.mtd
@param idDoc id del documento
@param idLinea id de la línea del documento
@param variación Variación en el número de existencias del artículo
@param campo: Nombre del campo a modificar. Si el campo es vacío o es --cantidad-- se llama a la función padre
@param numSerie Número de serie, si el artículo es controlado por número de serie
@param eliminado Indica si el movimiento de stock refiere a una línea que ha sido eliminada
@return True si la modificación tuvo éxito, false en caso contrario
\end */
function desbloqueoStock_cambiarMoviStock(codAlmacen:String, referencia:String, tipoDoc:String, idDoc:Number, idLinea:Number, variacion:Number, campo:String, numSerie:String, eliminado:String ):Boolean
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

	///////////	stock: chequear disponibilidad
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
	
	var cantidadPrevia:Number = parseFloat( curStock.valueBuffer( campo ) );
	var nuevaCantidad:Number = cantidadPrevia + parseFloat( variacion );
	var disponible:Number;
	if (campo == "cantidad" || campo == "reservada") {
		var disponible:Number = formRecordregstocks.iface.pub_commonCalculateField("disponible", curStock);
	}

	if (!this.iface.comprobarStock(codAlmacen, referencia, nuevaCantidad, disponible)) {
		return false;
	}
	
	/////////	movistock
	var idMoviStock = util.sqlSelect("movistock", "idmovistock", "referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "' AND tipodoc = '" + tipoDoc + "' AND idlinea = " + idLinea + " AND numserie = '" + numSerie + "'");
	if ( !idMoviStock ) {
		idMoviStock = this.iface.crearMoviStock( codAlmacen, referencia, tipoDoc, idLinea, numSerie );
		if ( !idMoviStock ) {
			return false;
		}
	}
	var curMoviStock:FLSqlCursor = new FLSqlCursor( "movistock" );
	curMoviStock.select( "idmovistock = " + idMoviStock );
	if ( !curMoviStock.first() ) {
		return false;
	}
	
	curMoviStock.setModeAccess( curMoviStock.Edit );
	curMoviStock.refreshBuffer();
	curMoviStock.setValueBuffer( "variacion", parseFloat( variacion ) );
	curMoviStock.setValueBuffer( "numserie", numSerie );
	curMoviStock.setValueBuffer( "iddoc", idDoc );
	curMoviStock.setValueBuffer( "eliminado", eliminado );
	if ( !curMoviStock.commitBuffer() ) {
		return false;
	}

	return true;
}

/** \D Crea un registro de stock para el almacén, artículo e idlínea especificados en la tabla movistock
@param	codAlmacen: Almacén
@param	referencia: Referencia del artículo
@param tipoDoc: Tipo del documento (factura, remito, etc)
@param idLinea: id de la línea del documento
@param	referencia: Referencia del artículo
@return	identificador del stock o false si hay error
\end */
function desbloqueoStock_crearMoviStock(codAlmacen:String, referencia:String, tipoDoc:String, idLinea:Number, numSerie:String):Number
{
	var util:FLUtil = new FLUtil;
	var curMoviStock:FLSqlCursor = new FLSqlCursor("movistock");
	with(curMoviStock) {
		setModeAccess(Insert);
		refreshBuffer();
		setValueBuffer("codalmacen", codAlmacen);
		setValueBuffer("referencia", referencia);
		setValueBuffer("tipodoc", tipoDoc);
		setValueBuffer("idlinea", idLinea);
		setValueBuffer("numserie", numSerie);
		setValueBuffer("variacion", 0);
		if (!commitBuffer())
			return false;
	}
	return curMoviStock.valueBuffer("idmovistock");
}

/** \D Comprueba, en el caso de que el artículo no permita ventas sin stock, si el stock que se va a guardar incumple dicha condición
@param	codAlmacen: Almacén
@param	referencia: Referencia del artículo
@param	cantidad: cantidad en stock
@param	disponible: cantidad disponible
@return	True si la comprobación es correcta, false en caso contrario
\end */
function desbloqueoStock_comprobarStock(codAlmacen:String, referencia:String, cantidad:Number, disponible:Number):Boolean
{
	var util:FLUtil = new FLUtil();
	if (util.sqlSelect("articulos", "controlstock", "referencia = '" + referencia + "'")) {
		return true;
	}

	var stockPedidos:Boolean = flfactppal.iface.pub_valorDefectoEmpresa("stockpedidos");

	var cantidadControl:Number;
	if (stockPedidos) {
		cantidadControl = disponible;
	} else {
		cantidadControl = cantidad;
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

/** \C
Esta función se sobrepone a la oficial con el objetivo de que no se bloquee el artículo cuyo stock en determinado almacén está siendo modificado.
No se invoca la función controlStock(), que es la que produce el bloqueo del artículo-almacén en la tabla "stock", sino que se utiliza una tabla auxiliar, "movistock"
\end */
function desbloqueoStock_controlStockFacturasCli(curLF:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLF.valueBuffer("referencia") + "'"))
		return true;

	if(util.sqlSelect("facturascli", "automatica", "idfactura = " + curLF.valueBuffer("idfactura")))
		return true;

	var codAlmacen = util.sqlSelect("facturascli", "codalmacen", "idfactura = " + curLF.valueBuffer("idfactura"));
	if (!codAlmacen || codAlmacen == "")
		return true;
		
	if (!this.iface.controlMoviStock(curLF, "FC", "cantidad", -1, codAlmacen))
		return false;

	return true;
}

/** \C
Esta función se sobrepone a la oficial con el objetivo de que no se bloquee el artículo cuyo stock en determinado almacén está siendo modificado.
No se invoca la función controlStock(), que es la que produce el bloqueo del artículo-almacén en la tabla "stock", sino que se utiliza una tabla auxiliar, "movistock"
Actualiza el stock correspondiente al artículo seleccionado en la línea en caso de que no venga de un pedido, o que la opción general de control de stocks en pedidos esté inhabilitada
\end */
function desbloqueoStock_controlStockAlbaranesCli(curLA:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLA.valueBuffer("referencia") + "'"))
		return true;

	if ((curLA.valueBuffer("idlineapedido") != 0) && flfactppal.iface.pub_valorDefectoEmpresa("stockpedidos"))
		return true;

	var codAlmacen:String = util.sqlSelect("albaranescli", "codalmacen", "idalbaran = " + curLA.valueBuffer("idalbaran"));
	if (!codAlmacen || codAlmacen == "")
		return true;

	if (!this.iface.controlMoviStock(curLA, "RC", "cantidad", -1, codAlmacen))
		return false;

	return true;
}

/** \C
Esta función se sobrepone a la oficial con el objetivo de que no se bloquee el artículo cuyo stock en determinado almacén está siendo modificado.
\end */
function desbloqueoStock_controlStockPedidosCli(curLP:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	
	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLP.valueBuffer("referencia") + "'"))
		return true;

	var codAlmacen:String = util.sqlSelect("pedidoscli", "codalmacen", "idpedido = " + curLP.valueBuffer("idpedido"));
	if (!codAlmacen || codAlmacen == "")
		return true;
	
	var stockPedidos:Boolean = flfactppal.iface.pub_valorDefectoEmpresa("stockpedidos");

	if(stockPedidos) {
		if (!this.iface.controlMoviStock(curLP, "PC", "cantidad", -1, codAlmacen))
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
Esta función se sobrepone a la oficial con el objetivo de que no se bloquee el artículo cuyo stock en determinado almacén está siendo modificado.
\end */
function desbloqueoStock_controlStockFacturasProv(curLF:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;

	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLF.valueBuffer("referencia") + "'"))
		return true;

	if(util.sqlSelect("facturasprov", "automatica", "idfactura = " + curLF.valueBuffer("idfactura")))
		return true;

	var codAlmacen:String = util.sqlSelect("facturasprov", "codalmacen", "idfactura = " + curLF.valueBuffer("idfactura"));
	if (!codAlmacen || codAlmacen == "")
		return true;

	if (!this.iface.controlMoviStock(curLF, "FP", "cantidad", 1, codAlmacen))
			return false;

	return true;
}

/** \C
Esta función se sobrepone a la oficial -e incorpora la de pedidosauto- con el objetivo de que no se bloquee el artículo cuyo stock en determinado almacén está siendo modificado.
\end */
function desbloqueoStock_controlStockAlbaranesProv(curLA:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	/***  Parte correspondiente a oficial_controlStockAlbaranesProv()  ***/
	/* "for" de un solo ciclo, inventado para emular con un "break" el "return true" de la función original */
	for (var i = 0; i < 1; i++) {
		if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLA.valueBuffer("referencia") + "'"))
			break;

		var codAlmacen:String = util.sqlSelect("albaranesprov", "codalmacen", "idalbaran = " + curLA.valueBuffer("idalbaran"));
		if (!codAlmacen || codAlmacen == "")
			break;
		
		if (!this.iface.controlMoviStock(curLA, "RP", "cantidad", 1, codAlmacen))
			return false;
	}
	
	/***  Parte correspondiente a pedidosauto_controlStockAlbaranesProv()  ***/
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

/** \C
Esta función se sobrepone a la oficial con el objetivo de que no se bloquee el artículo cuyo stock en determinado almacén está siendo modificado.
\end */
function desbloqueoStock_controlStockComandasCli(curLV:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLV.valueBuffer("referencia") + "'")) {
		return true;
	}

	var codAlmacen = util.sqlSelect("tpv_comandas c INNER JOIN tpv_puntosventa pv ON c.codtpv_puntoventa = pv.codtpv_puntoventa", "pv.codalmacen", "idtpv_comanda = " + curLV.valueBuffer("idtpv_comanda"), "tpv_comandas,tpv_puntosventa");
	if (!codAlmacen || codAlmacen == "") {
		return true;
	}
	
	var tipoDoc = "";
	var tipoVenta = util.sqlSelect("tpv_comandas", "tipoventa", "idtpv_comanda = " + curLV.valueBuffer("idtpv_comanda"));
	switch (tipoVenta) {
		case "Factura A":
		case "Factura B":
		case "Factura C":
		case "Ticket":
			tipoDoc = "FC";
			break;
		case "Remito":
			tipoDoc = "RC";
			break;
		case "Pedido":
			tipoDoc = "PC";
			break;
	}
	
	if (!this.iface.controlMoviStock(curLV, tipoDoc, "cantidad", -1, codAlmacen)) {
		return false;
	}

	return true;
}

/** \C
Esta función se sobrepone a la oficial con el objetivo de que no se bloquee el artículo cuyo stock en determinado almacén está siendo modificado.
\end */
function desbloqueoStock_controlStockValesTPV(curLinea:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLinea.valueBuffer("referencia") + "'"))
		return true;

	var codAlmacen:String = curLinea.valueBuffer("codalmacen");
	if (!codAlmacen || codAlmacen == "")
		return true;

	var tipoDoc = "";
	var tipoVenta = util.sqlSelect("tpv_comandas", "tipoventa", "idtpv_comanda = " + curLV.valueBuffer("idtpv_comanda"));
	switch (tipoVenta) {
		case "Factura A":
		case "Factura B":
		case "Factura C":
		case "Ticket":
			tipoDoc = "FC";
			break;
		case "Remito":
			tipoDoc = "RC";
			break;
		case "Pedido":
			tipoDoc = "PC";
			break;
	}
	
	if (!this.iface.controlMoviStock(curLinea, tipoDoc, "cantidad", 1, codAlmacen))
		return false;

	return true;
}

//// DESBLOQUEO AL MODIFICAR STOCK //////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration desbloqueoStockLotes */
/////////////////////////////////////////////////////////////////
//// DESBLOQUEO AL MODIFICAR STOCK LOTES ////////////////////////

/* El objetivo de esta extensión es permitir que dos o más usuarios puedan trabajar simultánemente, sin bloquearse, sobre el stock de un artículo controlado por lotes */

/** \C Remplaza/anula a la original, "lotes_afterCommit_movilote()". Esa función genera resultados erróneos en el cálculo de la cantidad cuando hay dos usuarios operando al mismo tiempo sobre el mismo lote. Las actualizaciones del campo --enalmacen-- del lote correspondiente y del campo --cantidad-- del stock asociado se realiza al aceptarse el documento en cuestión (factura, remito, etc), no al commitearse el movilote.
\end */
function desbloqueoStockLotes_afterCommit_movilote(curMoviLote:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil;
	switch (curMoviLote.modeAccess()) {
		case curMoviLote.Del: {
			if (!this.iface.cambiarStockLote(curMoviLote)) {
				MessageBox.critical(util.translate("scripts", "Se produjo un error al procesar esta operación.\nPor favor ANOTE la siguiente línea de información y comuníquesela a su soporte técnico:\n\n  FLFACTALMA-0001: ") + curMoviLote.valueBuffer("id"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
			}
		}
	}

	return true;
}

/** \C El campo --enalmacen-- del lote correspondiente se actualizará. De la misma forma, el campo --cantidad-- del stock asociado se calculará como la suma del campo cantidad de los movimientos que lo componen.
\end */
function desbloqueoStockLotes_cambiarStockLote(curMoviLote:FLSqlCursor):Boolean
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

		if (curMoviLote.modeAccess() == curMoviLote.Edit && codLote != curMoviLote.valueBufferCopy("codlote")) {
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

function desbloqueoStockLotes_beforeCommit_transstock(curTS:FLSqlCursor):Boolean
{
	if ( !this.iface.__beforeCommit_transstock(curTS) )
		return false;

	var util:FLUtil = new FLUtil();
	if (curTS.modeAccess() == curTS.Insert || curTS.modeAccess() == curTS.Edit) {
		/*** Obtener las líneas cuyos artículos se manejan por lotes ***/
		var qryLinea:FLSqlQuery = new FLSqlQuery();
		qryLinea.setTablesList("lineastransstock,articulos");
		qryLinea.setSelect("l.idlinea,l.referencia");
		qryLinea.setFrom("lineastransstock l INNER JOIN articulos a ON l.referencia = a.referencia");
		qryLinea.setWhere("a.porlotes = TRUE AND l.idtrans = " + curTS.valueBuffer("idtrans"));
		if(!qryLinea.exec())
			return false;
			
		while (qryLinea.next()) {
			/* En una transferencia se realizan dos movimientos: se extrae de un depósito y se agrega a otro
				-- Primero chequeamos el depósito desde el que se extrae (el que tiene cantidad negativa) */
			var curMoviLote:FLSqlCursor = new FLSqlCursor("movilote");
			curMoviLote.select("docorigen = 'TR' AND idlineats = " + qryLinea.value("l.idlinea") + " AND cantidad < 0");
			if (!curMoviLote.first())
				return false;

			/* Chequear que no hayan tomado del stock mientras se estaba cargando este documento */
			var cantidadLote:Number = util.sqlSelect("movilote", "SUM(cantidad)", "idstock = " + curMoviLote.valueBuffer("idstock") + " AND codlote = '" + curMoviLote.valueBuffer("codlote") + "' AND (idlineats IS NULL OR idlineats <> " + curMoviLote.valueBuffer("idlineats") + ") AND NOT automatico AND NOT reserva");
			if ((curMoviLote.valueBuffer("cantidad") * -1) > cantidadLote) {
				MessageBox.warning(util.translate("scripts", "No hay suficiente cantidad de artículos con referencia %1 del lote %2\nen el almacén %3 \n\nAtención: es posible que, al mismo tiempo que se generaba este documento,\n          otro usuario haya realizado una operación que afectó el stock de este lote").arg(qryLinea.value("l.referencia")).arg(curMoviLote.valueBuffer("codlote")).arg(curTS.valueBuffer("codalmacen")), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
			}

			if (!flfactalma.iface.pub_cambiarStockLote(curMoviLote)) {
				MessageBox.critical(util.translate("scripts", "Se produjo un error al procesar esta operación.\nPor favor ANOTE la siguiente línea de información y comuníquesela a su soporte técnico:\n\n  FLFACTALMA-0002: ") + curTS.valueBuffer("idfactura"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
			}
			
			/* 	-- Por último chequeamos el depósito al que se agrega (el que tiene cantidad positiva) */
			curMoviLote.select("docorigen = 'TR' AND idlineats = " + qryLinea.value("l.idlinea") + " AND cantidad > 0");
			if (!curMoviLote.first())
				return false;

			if (!flfactalma.iface.pub_cambiarStockLote(curMoviLote)) {
				MessageBox.critical(util.translate("scripts", "Se produjo un error al procesar esta operación.\nPor favor ANOTE la siguiente línea de información y comuníquesela a su soporte técnico:\n\n  FLFACTALMA-0003: ") + curTS.valueBuffer("idfactura"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
			}
		}
	}

	return true;
}

/** \C
Esta función se sobrepone a la oficial con el objetivo de que no se bloquee el artículo cuyo stock en determinado almacén está siendo modificado.
No se invoca la función controlStock(), que es la que produce el bloqueo del artículo-almacén en la tabla "stock", sino que se utiliza una tabla auxiliar, "movistock"
\end */
function desbloqueoStockLotes_controlStockTrazabilidadInterna(curLTI:FLSqlCursor):Boolean
{
	var util:FLUtil = new FLUtil();

	if (util.sqlSelect("articulos", "nostock", "referencia = '" + curLTI.valueBuffer("referencia") + "'")) {
		return true;
	}

	var codAlmacen:String = util.sqlSelect("trazabilidadinterna", "codalmacen", "codigo = '" + curLTI.valueBuffer("codtrazainterna") + "'");
	if (!codAlmacen || codAlmacen == "") {
		return true;
	}
	
	if (!this.iface.controlMoviStock(curLTI, "MI", "cantidad", 1, codAlmacen)) {
		return false;
	}

	return true;
}

function desbloqueoStockLotes_beforeCommit_trazabilidadinterna(curTI:FLSqlCursor):Boolean
{
	if ( !this.iface.__beforeCommit_trazabilidadinterna(curTI) )
		return false;

	var util:FLUtil = new FLUtil();
	if (curTI.modeAccess() == curTI.Insert || curTI.modeAccess() == curTI.Edit) {
		/*** Obtener las líneas cuyos artículos se manejan por lotes ***/
		var qryLinea:FLSqlQuery = new FLSqlQuery();
		qryLinea.setTablesList("lineastrazabilidadinterna,articulos");
		qryLinea.setSelect("l.idlinea,l.referencia");
		qryLinea.setFrom("lineastrazabilidadinterna l INNER JOIN articulos a ON l.referencia = a.referencia");
		qryLinea.setWhere("a.porlotes = TRUE AND l.codtrazainterna = '" + curTI.valueBuffer("codigo") + "'");
		if(!qryLinea.exec())
			return false;
			
		while (qryLinea.next()) {
			var curMoviLote:FLSqlCursor = new FLSqlCursor("movilote");
			curMoviLote.select("docorigen = 'MI' AND idlineati = " + qryLinea.value("l.idlinea"));
			if (!curMoviLote.first())
				return false;

			if (!flfactalma.iface.pub_cambiarStockLote(curMoviLote)) {
				MessageBox.critical(util.translate("scripts", "Se produjo un error al procesar esta operación.\nPor favor ANOTE la siguiente línea de información y comuníquesela a su soporte técnico:\n\n  FLFACTALMA-0002: ") + curTS.valueBuffer("idfactura"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
			}
		}
	}

	return true;
}

//// DESBLOQUEO AL MODIFICAR STOCK LOTES ////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration desbloqueoStockNumSerie */
//////////////////////////////////////////////////////////////////
//// DESBLOQUEO NUMEROS SERIE ////////////////////////////////////

/** Esta función anula la oficial --oficial_afterCommit_numerosserie()--.
Si se está cargando un artículo con número de serie desde el formulario de números de serie de Almacén, actualizar el stock.
Caso contrario (se está operando con algún documento comercial, como las facturas, o con el formulario del artículo), no actualizar (se actualiza luego con "actualizarStockNumSerie()")
*/
function desbloqueoStockNumSerie_afterCommit_numerosserie(curNS:FLSqlCursor) 
{
	if (curNS.action() == "numerosserie") {
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
		else if (curNS.modeAccess() == curNS.Insert) {
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
	}
	
	return true;
}

/** Esta función realiza la misma operación que afterCommit_numerosserie(): actualizar el stock de un artículo controlado por número de serie por medio de un simple conteo en la tabla "numerosserie".
Sin embargo, salvo que se esté operando con el formulario de números de serie en el módulo Almacén, esa actualización se pospone hasta el momento en que se acepta el documento (factura, remito, artículo, etc.) dentro del cual se modifica la tabla "numerosserie", a fin de no bloquear el stock.
*/
function desbloqueoStockNumSerie_actualizarStockNumSerie(codAlmacen:String, referencia:String) 
{
	var util:FLUtil = new FLUtil();
	var stockNS:Number = util.sqlSelect("numerosserie", "count(id)", "referencia = '" + referencia + "' AND vendido = false AND codalmacen = '" + codAlmacen + "'");
	
	var curStock:FLSqlCursor = new FLSqlCursor("stocks");
	curStock.select("referencia = '" + referencia + "' AND codalmacen = '" + codAlmacen + "'");
	
	if (curStock.first()) {
		curStock.setModeAccess(curStock.Edit);
		curStock.refreshBuffer();
		curStock.setValueBuffer("cantidad", stockNS);
		if (!curStock.commitBuffer()) {
			MessageBox.warning(util.translate("scripts", "Error al actualizar el stock del artículo por números de serie"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
	}	
	else {
		// No hay stock en este almacén, nueva línea de stocks
		curStock.setModeAccess(curStock.Insert);
		curStock.refreshBuffer();
		curStock.setValueBuffer("referencia", referencia);
		curStock.setValueBuffer("codalmacen", codAlmacen);
		curStock.setValueBuffer("cantidad", stockNS);
		if (!curStock.commitBuffer()) {
			MessageBox.warning(util.translate("scripts", "Error al actualizar el stock del artículo por números de serie"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
			return false;
		}
	}
	
	return true;
}

//// DESBLOQUEO NUMEROS SERIE ////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////