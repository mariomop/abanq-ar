/***************************************************************************
                 i_masterbalancepyg.qs  -  description
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
//////////////////////////
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
	var totalIva_:Number;
    function oficial( context ) { interna( context ); } 
	function lanzar() {
			return this.ctx.oficial_lanzar();
	}
	function iva(nodo:FLDomNode, campo:String):String {
		return this.ctx.oficial_iva(nodo, campo);
	}
	function totalIva(nodo:FLDomNode, campo:String):String {
		return this.ctx.oficial_totalIva(nodo, campo);
	}
	function initReport(nodo:FLDomNode, campo:String):String {
		return this.ctx.oficial_initReport(nodo, campo);
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
	function pub_iva(nodo:FLDomNode, campo:String):String {
		return this.iva(nodo, campo);
	}
	function pub_totalIva(nodo:FLDomNode, campo:String):String {
		return this.totalIva(nodo, campo);
	}
	function pub_initReport(nodo:FLDomNode, campo:String):String {
		return this.initReport(nodo, campo);
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
/** \C El botón de impresión lanza el informe
\end */
function interna_init()
{ 
		connect(this.child("toolButtonPrint"), "clicked()", this, "iface.lanzar()");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D Lanza el informe. Añade al WHERE de la consulta la condición de que sólo se muestren las partidas cuya subcuenta pertenece a una cuenta de tipo especial de I.V.A. repercutido.
\end */
function oficial_lanzar()
{
		var cursor:FLSqlCursor = this.cursor()
		if (!cursor.isValid())
				return;

		var nombreInforme:String = cursor.action();
		var nombreReport:String = nombreInforme;
		var conIva:Boolean = cursor.valueBuffer("coniva");

		var orderBy:String;
		if (cursor.valueBuffer("numeracionauto")) {
				nombreReport = nombreReport + "_n";
				flcontinfo.iface.pub_resetearNumFactura(parseFloat(cursor.valueBuffer("numdesde")));
				
				orderBy = "co_partidas.codserie, co_asientos.fecha, co_partidas.idasiento";
		} else
			orderBy = "co_partidas.codserie, co_partidas.factura, co_asientos.fecha, co_partidas.idasiento";
		
		var masWhere:String;
// 		var ctaIVAEUE:Array = flfacturac.iface.pub_datosCtaEspecial("IVAEUE", cursor.valueBuffer("i_co__cuentas_codejercicio"));
// 		if (ctaIVAEUE.error == 0) {
// 			masWhere = " AND (co_cuentas.idcuentaesp = 'IVAREP' OR sc1.idsubcuenta = " + ctaIVAEUE["idsubcuenta"] + ")";
// 		} else {
// 			masWhere = " AND co_cuentas.idcuentaesp = 'IVAREP'";
// 		}
		masWhere = " AND sc1.idcuentaesp IN ('IVAREP', 'IVAEUE', 'IVARXP', 'IVAREX')";
	
		if (conIva) {
			masWhere += " AND co_partidas.iva <> 0";
			masWhere += " AND (series.siniva IS NULL OR series.siniva = false)";
		}

		flcontinfo.iface.pub_lanzarInforme(cursor, nombreInforme, nombreReport, orderBy, "", masWhere, cursor.valueBuffer("id"));
		
}

/** \D Obtiene la suma de IVA
\end */
function oficial_iva(nodo:FLDomNode, campo:String):String
{
	var util:FLUtil = new FLUtil;
	var iva:Number = parseFloat(nodo.attributeValue("(co_partidas.haber - co_partidas.debe)"));
	var baseImponible:Number = parseFloat(nodo.attributeValue("co_partidas.baseimponible"));
	var valor:Number = baseImponible + iva;
	this.iface.totalIva_ += valor;
	return valor;
}

function oficial_initReport(nodo:FLDomNode, campo:String):String
{
	this.iface.totalIva_ = 0;
}

function oficial_totalIva(nodo:FLDomNode, campo:String):String
{
	return this.iface.totalIva_;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
