/***************************************************************************
                 i_mastermovilote.qs  -  description
                             -------------------
    begin                : jue nov 23 2006
    copyright            : (C) 2006 by InfoSiAL S.L.
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
	function origenDest(nodo:FLDomNode, campo:String):String {
		return this.ctx.oficial_origenDest(nodo, campo);
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
	function pub_origenDest(nodo:FLDomNode, campo:String):String {
		return this.origenDest(nodo, campo);
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
			
	var nombreInforme:String = cursor.action();
	var where:String = "NOT movilote.automatico AND NOT movilote.reserva";
	flfactinfo.iface.pub_lanzarInforme(cursor, nombreInforme, "", "", false, false, where);
}

/** \D Construye la descripción del documento de destino con sus datos más relevantes 
\end */
function oficial_origenDest(nodo:FLDomNode, campo:String):String
{
	var util:FLUtil = new FLUtil;

	var docOrigen:String = nodo.attributeValue("movilote.docorigen");
	var valor:String = "";

	switch (docOrigen) {
		case "RC" : {
			var idOrigen:String = nodo.attributeValue("movilote.idlineaac");
			var idAlbaran = util.sqlSelect("lineasalbaranescli", "idalbaran", "idlinea = " + idOrigen);
			if (idAlbaran)
				valor = util.translate("scripts", "Remito: %1 del cliente %2: %3").arg(util.sqlSelect("albaranescli", "codigo", "idalbaran = " + idAlbaran)).arg(util.sqlSelect("albaranescli", "codcliente", "idalbaran = " + idAlbaran)).arg(util.sqlSelect("albaranescli", "nombrecliente", "idalbaran = " + idAlbaran));
			break;
		}
		case "FC" : {
			var idOrigen:String = nodo.attributeValue("movilote.idlineafc");
			var idFactura = util.sqlSelect("lineasfacturascli", "idfactura", "idlinea = " + idOrigen);
			if (idFactura)
				valor = util.translate("scripts", "Factura: %1 del cliente %2: %3").arg(util.sqlSelect("facturascli", "codigo", "idfactura = " + idFactura)).arg(util.sqlSelect("facturascli", "codcliente", "idfactura = " + idFactura)).arg(util.sqlSelect("facturascli", "nombrecliente", "idfactura = " + idFactura));
			break;
		}
		case "RP" : {
			var idOrigen:String = nodo.attributeValue("movilote.idlineaap");
			var idAlbaran = util.sqlSelect("lineasalbaranesprov", "idalbaran", "idlinea = " + idOrigen);
			if (idAlbaran)
				valor = util.translate("scripts", "Remito: %1 del proveedor %2: %3").arg(util.sqlSelect("albaranesprov", "codigo", "idalbaran = " + idAlbaran)).arg(util.sqlSelect("albaranesprov", "codproveedor", "idalbaran = " + idAlbaran)).arg(util.sqlSelect("albaranesprov", "nombre", "idalbaran = " + idAlbaran));
			break;
		}
		case "FP" : {
			var idOrigen:String = nodo.attributeValue("movilote.idlineafp");
			var idFactura = util.sqlSelect("lineasfacturasprov", "idfactura", "idlinea = " + idOrigen);
			if (idFactura)
				valor = util.translate("scripts", "Factura: %1 del proveedor %2: %3").arg(util.sqlSelect("facturasprov", "codigo", "idfactura = " + idFactura)).arg(util.sqlSelect("facturasprov", "codproveedor", "idfactura = " + idFactura)).arg(util.sqlSelect("facturasprov", "nombre", "idfactura = " + idFactura));
			break;
		}
		case "TR" : {
			var idOrigen:String = nodo.attributeValue("movilote.idlineats");
			var idTrans = util.sqlSelect("lineastransstock", "idtrans", "idlinea = " + idOrigen);
			if (idTrans) {
				var fechaTrans:String = util.sqlSelect("transstock", "fecha", "idtrans = " + idTrans);
				valor = util.translate("scripts", "Transferencia día %1. %2 -> %3").arg(util.dateAMDtoDMA(fechaTrans)).arg(util.sqlSelect("transstock", "codalmaorigen", "idtrans = " + idTrans)).arg(util.sqlSelect("transstock", "codalmadestino", "idtrans = " + idTrans));
			}
			break;
		}
		case "MI" : {
			var q:FLSqlQuery = new FLSqlQuery();
			q.setTablesList("lineastrazabilidadinterna,trazabilidadinterna");
			q.setSelect("t.fecha");
			q.setFrom("lineastrazabilidadinterna l INNER JOIN trazabilidadinterna t ON l.codtrazainterna = t.codigo");
			q.setWhere("l.idlinea = " + nodo.attributeValue("movilote.idlineati"));
			q.setForwardOnly( true ); 
			if (!q.exec()) {
				return false;
			}
			if (q.first()) {
				var fecha:String = util.dateAMDtoDMA(q.value("t.fecha"));
				valor = util.translate("scripts", "Movimiento interno del día %1.").arg(fecha);
			}
			break;
		}
		default : {
			valor = util.translate("scripts", "(Sin documento)");
			break;
		}
	}
	return valor;
}
	
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
