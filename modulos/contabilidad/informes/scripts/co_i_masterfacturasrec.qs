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
/** \D Lanza el informe. Añade al WHERE de la consulta la condición de que sólo se muestren las partidas cuya subcuenta pertenece a una cuenta de tipo especial de I.V.A. soportado.
\end */
function oficial_lanzar()
{
		var cursor:FLSqlCursor = this.cursor()
		if (!cursor.isValid())
				return;

		var nombreInforme:String = cursor.action();
		var nombreReport:String = nombreInforme;
		var masWhere:String = "";
		var codSerie:String = cursor.valueBuffer("codserie");
		var conIva:Boolean = cursor.valueBuffer("coniva");
		var numeracionAuto:Boolean = cursor.valueBuffer("numeracionauto");
		
		
		var orderBy:String;
		if (numeracionAuto) {
				nombreReport = nombreReport + "_n";
				flcontinfo.iface.pub_resetearNumFactura(parseFloat(cursor.valueBuffer("numdesde")));
				orderBy = "co_partidas.codserie, co_asientos.fecha, co_partidas.idasiento";
		} else
			orderBy = "co_partidas.codserie, co_partidas.factura, co_asientos.fecha, co_partidas.idasiento";

// 		var ctaIVASUE:Array = flfacturac.iface.pub_datosCtaEspecial("IVASUE", cursor.valueBuffer("i_co__cuentas_codejercicio"));
// 		if (ctaIVASUE.error == 0) {
// 			masWhere = " AND (co_cuentas.idcuentaesp = 'IVASOP' OR sc1.idsubcuenta = " + ctaIVASUE["idsubcuenta"] + ")";
// 		} else {
// 			masWhere = " AND co_cuentas.idcuentaesp = 'IVASOP'";
// 		}
		masWhere = " AND sc1.idcuentaesp IN ('IVASOP', 'IVARUE', 'IVASUE', 'IVASIM', 'IVASEX')";
		
		if (codSerie) 
			masWhere += " AND co_partidas.codserie = '" + codSerie + "'";

		if(conIva)
			masWhere += " AND co_partidas.iva <> 0";

		flcontinfo.iface.pub_lanzarInforme(cursor, nombreInforme, nombreReport, orderBy, "", masWhere, cursor.valueBuffer("id"));
}


//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
