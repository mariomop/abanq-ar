/***************************************************************************
                 lineasregstocks.qs  -  description
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
	function validateForm():Boolean { return this.ctx.interna_validateForm(); }
	function acceptedForm() { return this.ctx.interna_acceptedForm(); }
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

/** @class_declaration traza */
/////////////////////////////////////////////////////////////////
//// TRAZABILIDAD ///////////////////////////////////////////////
class traza extends oficial {
    function traza( context ) { oficial ( context ); }
	function init() {
		return this.ctx.traza_init();
	}
}
//// TRAZABILIDAD ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration controlUsuario */
/////////////////////////////////////////////////////////////////
//// CONTROL_USUARIO ////////////////////////////////////////////
class controlUsuario extends traza {
    function controlUsuario( context ) { traza ( context ); }
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
/** \C 
En modo inserción, los valores de --cantidadini-- y --cantidadfin-- aparecen informados con la cantidad actual

En modo edición, no es posible cambiar los valores de --cantidadfin--, --fecha-- y --motivo--
\end */
function interna_init()
{
		var cursor:FLSqlCursor = this.cursor();
		if (cursor.modeAccess() == cursor.Insert) {
				this.child("fdbCantidadIni").setValue(cursor.cursorRelation().valueBuffer("cantidad"));
				this.child("fdbCantidadFin").setValue(cursor.cursorRelation().valueBuffer("cantidad"));
		} else {
				this.child("fdbCantidadFin").setDisabled(true);
				this.child("fdbMotivo").setDisabled(true);
				this.child("fdbFecha").setDisabled(true);
		}
}

function interna_validateForm():Boolean
{
/** \C
El valor de --cantidadfin-- debe ser mayor que cero
\end */
		var util:FLUtil = new FLUtil();
		var cantidadFin:Number = this.child("fdbCantidadFin").value();
		
		if (cantidadFin < 0) {
				MessageBox.critical(util.translate("scripts", "La cantidad debe ser mayor que cero"),
						MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
		}
/** \C
El valor de --cantidadfin-- debe ser distinta de la --cantidadini--
\end */
		if (cantidadFin == this.child("fdbCantidadIni").value()) {
				MessageBox.critical(util.translate("scripts", "Las cantidad nueva es igual a la inicial"),
						MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
		}
		return true;
}

/** \D
La --cantidadfin-- se actualiza en las regularizaciones de stocks
\end */
function interna_acceptedForm()
{
/*
		var cursor:FLSqlCursor = this.cursor();
		if (cursor.modeAccess() == cursor.Insert)
				formRecordregstocks.iface.pub_cambiarCantidad(cursor.valueBuffer("cantidadfin"));
*/
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition traza */
/////////////////////////////////////////////////////////////////
//// TRAZABILIDAD ///////////////////////////////////////////////
function traza_init()
{
	this.iface.__init();

	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	var referencia:String = util.sqlSelect("stocks", "referencia", "idstock = " + cursor.valueBuffer("idstock"));
	if (util.sqlSelect("articulos", "porlotes", "referencia = '" + referencia + "'")) {
		MessageBox.information(util.translate("scripts", "El artículo del stock seleccionado se controla por lotes.\nPara regularizar el stock debe crear un movimiento de regularización en el lote correspondiente."), MessageBox.Ok, MessageBox.NoButton);
		this.child("pushButtonCancel").animateClick();
	}
}
//// TRAZABILIDAD ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition controlUsuario */
/////////////////////////////////////////////////////////////////
//// CONTROL_USUARIO ////////////////////////////////////////////

function controlUsuario_init()
{
	if (this.cursor().modeAccess() == this.cursor().Insert) {
		if ( !flfactppal.iface.pub_usuarioCreado(sys.nameUser()) ) {
			flfactppal.iface.pub_mensajeControlUsuario("NO_USUARIO", "Regularizaciones de stocks");
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