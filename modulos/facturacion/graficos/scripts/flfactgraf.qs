/***************************************************************************
                 flfactgraf.qs  -  description
                             -------------------
    begin                : jue jul 24 2008
    copyright            : (C) 2008 by Silix
    email                : contacto@silix.com.ar
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
	function obtenerSigno(s:String):String {
		return this.ctx.oficial_obtenerSigno(s);
	}
	function fieldName(s:String):String {
		return this.ctx.oficial_fieldName(s);
	}
	function lanzarGrafico(cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String, tabla:String) {
		return this.ctx.oficial_lanzarGrafico(cursor, nombreInforme, orderBy, groupBy, tabla);
	}
	function prepararConsultaInforme(cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String):FLSqlQuery {
		return this.ctx.oficial_prepararConsultaInforme( cursor, nombreInforme, orderBy, groupBy);
	}
	function obtenerEjeY(tabla:String):Array {
		return this.ctx.oficial_obtenerEjeY(tabla);
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
	function pub_lanzarGrafico(cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String, tabla:String) {
		return this.lanzarGrafico(cursor, nombreInforme, orderBy, groupBy, tabla);
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
function interna_init() {
	var util:FLUtil = new FLUtil();
	util.writeSettingEntry("kugar/banner", "");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
function oficial_obtenerSigno(s:String):String
{
	if (s.toString().charAt(1) == "_") {
		switch(s.toString().charAt(0)) {
			case "d": {
				return ">=";
			}
			case "h": {
				return "<=";
			}
			case "i": {
				return "=";
			}
		}
	}
	return  "";
}

function oficial_fieldName(s:String):String
{
	var fN:String = "";
	var c:String;
	for (var i:Number = 2; (s.toString().charAt(i)); i++) {
		c = s.toString().charAt(i);
		if (c == "_")
			if (s.toString().charAt(i + 1) == "_") {
				fN += "_";
				i++;
			} else
				fN += "."
		else
			fN += s.toString().charAt(i);
	}
	return fN;
}


function oficial_lanzarGrafico( cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String, tabla:String )
{
	var q:FLSqlQuery = this.iface.prepararConsultaInforme(cursor, nombreInforme, orderBy);
	if (!q) return false;

	var campos:Array = q.select().split( "," );
	var util:FLUtil = new FLUtil();

	var coorX:String = tabla + ".fecha";
	var compX:Array = coorX.split( "." );
	var tipoX:Number = util.fieldType( compX[1], compX[0] );
	var esFechaX:Boolean = false;
	if ( tipoX == 26 )
		esFechaX = true;
	
	var ejeY:Array = this.iface.obtenerEjeY(tabla);
	var coorY:String = Input.getItem( "Coordenada Y", ejeY, ejeY[0], false, "Coordenada Y" );
	if (!coorY)
		return false;
	coorY = coorY.replace( " ", "" );
	var compY:Array = coorY.split( "." );
	var tipoY:Number = util.fieldType( compY[1], compY[0] );
	var esFechaY:Boolean = false;
	if ( tipoY == 26 )
		esFechaY = true;
	
	if ( q.exec() ) {
		if ( q.size() > 0 ) {
			var stdin:String, datos:String;
			var fechaInicioX:String, fechaFinX:String, fechaInicioY:String, fechaFinY:String;
			if ( esFechaX || esFechaY ) {
				q.first();
				if ( esFechaX )
					fechaInicioX = util.dateAMDtoDMA( q.value( coorX ) );
				else
					fechaInicioX = q.value( coorX );
				if ( esFechaY )
					fechaInicioY = util.dateAMDtoDMA( q.value( coorY ) );
				else
					fechaInicioY = q.value( coorY );
				datos = fechaInicioX + " " + fechaInicioY + "\n";
				q.last();
				if ( esFechaX )
					fechaFinX = util.dateAMDtoDMA( q.value( coorX ) );
				if ( esFechaY )
					fechaFinY = util.dateAMDtoDMA( q.value( coorY ) );
				q.first();
			}
			var tempX:String, tempY:String;
			var cantDatos:Number = 0;
			while ( q.next() ) {
				if ( esFechaX )
					tempX = util.dateAMDtoDMA( q.value( coorX ) );
				else
					tempX = q.value( coorX );
				if ( esFechaY )
					tempY = util.dateAMDtoDMA( q.value( coorY ) );
				else
					tempY = q.value( coorY );
				datos += tempX + " " + tempY + "\n";
				cantDatos += 1;
			}
			stdin = "";
			if ( esFechaX ) {
				stdin += "\nset xdata time";
				stdin += "\nset timefmt \"\%d-\%m-\%Y\"";
				stdin += "\nset xrange [\"" + fechaInicioX + "\" : \"" + fechaFinX + "\"]";
				stdin += "\nset format x \"\%d-\%m\"";
			}
			if ( esFechaY ) {
				stdin += "\nset ydata time";
				stdin += "\nset timefmt \"\%d-\%m-\%Y\"";
				stdin += "\nset yrange [\"" + fechaInicioY + "\" : \"" + fechaFinY +"\"]";
				stdin += "\nset format y \"\%d-\%m\"";
			}
			stdin += "\nset xlabel \"" + "Fecha" + "\"";
			stdin += "\nset ylabel \"" + coorY + "\"";
			stdin += "\nset grid";
			if (cantDatos < 3) {
				stdin += "\nplot '-' using 1:2 t '' with dots ls 1, '-' using 1:2 t '' with lines ls 2\n";
			} else {
				stdin += "\nplot '-' using 1:2 t '' smooth csplines ls 1, '-' using 1:2 t '' with lines ls 2\n";
//				stdin += "\nplot '-' using 1:2 t '' smooth csplines ls 1, '-' using 1:2 t '' smooth bezier ls 2\n";
			}
			stdin += datos;
			stdin += "\ne\n"
			stdin += datos;
			stdin += "\ne\n"

			try { Process.execute( ["gnuplot","-persist"], stdin); }
			catch (e) { MessageBox.critical("Necesita tener instalado gnuplot\npara poder generar gráficos", MessageBox.Ok, MessageBox.NoButton);}
		}
	}
}

function oficial_prepararConsultaInforme( cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String ):FLSqlQuery
{
	var q:FLSqlQuery = new FLSqlQuery(nombreInforme);
	var util:FLUtil = new FLUtil();
	var fieldList:String = util.nombreCampos(cursor.table());
	var cuenta:Number = parseFloat(fieldList[0]);
	var signo:String;
	var fN:String;
	var valor:String;
	var primerCriterio:Boolean = false;
	var where:String = "";
	for (var i:Number = 1; i <= cuenta; i++) {
		if (cursor.isNull(fieldList[i]))
			continue;
		signo = this.iface.obtenerSigno(fieldList[i]);
		if (signo != "") {
			fN = this.iface.fieldName(fieldList[i]);
			valor = cursor.valueBuffer(fieldList[i]);
			if (valor == util.translate("scripts", "Sí"))
				valor = 1;
			if (valor == util.translate("scripts", "No"))
				valor = 0;
			if (valor == util.translate("scripts", "Todos"))
				valor = "";
			if (!valor.toString().isEmpty()) {
				if (primerCriterio == true)
					where += "AND ";
				where += fN + " " + signo + " '" + valor + "' ";
				primerCriterio = true;
			}
		}
	}
	q.setWhere(where);
	if (q.exec() == false) {
		MessageBox.critical(util.translate("scripts", "Falló la consulta"),
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	} else {
	if (q.first() == false) {
		MessageBox.warning(util.translate("scripts",
		"No hay registros que cumplan los criterios de búsqueda establecidos"),
		MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	}
	if (orderBy)
		q.setOrderBy(orderBy);
	return q;
}

function oficial_obtenerEjeY( tabla:String ):Array
{
	var ejeY:Array = [];
	var campos:String;
	switch (tabla) {
		case "facturascli": {
			campos = "facturascli.total,facturascli.neto,facturascli.totaliva";
			ejeY = campos.split(",");
			break;
		}
		case "albaranescli": {
			campos = "albaranescli.total,albaranescli.neto,albaranescli.totaliva";
			ejeY = campos.split(",");
			break;
		}
		case "pedidoscli": {
			campos = "pedidoscli.total,pedidoscli.neto,pedidoscli.totaliva";
			ejeY = campos.split(",");
			break;
		}
		case "presupuestoscli": {
			campos = "presupuestoscli.total,presupuestoscli.neto,presupuestoscli.totaliva";
			ejeY = campos.split(",");
			break;
		}
		case "facturasprov": {
			campos = "facturasprov.total,facturasprov.neto,facturasprov.totaliva";
			ejeY = campos.split(",");
			break;
		}
		case "albaranesprov": {
			campos = "albaranesprov.total,albaranesprov.neto,albaranesprov.totaliva";
			ejeY = campos.split(",");
			break;
		}
		case "pedidosprov": {
			campos = "pedidosprov.total,pedidosprov.neto,pedidosprov.totaliva";
			ejeY = campos.split(",");
			break;
		}
		case "reciboscli": {
			campos = "reciboscli.importe";
			ejeY = campos.split(",");
			break;
		}
		case "recibosprov": {
			campos = "recibosprov.importe";
			ejeY = campos.split(",");
			break;
		}
		break;
	}
	return ejeY;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
