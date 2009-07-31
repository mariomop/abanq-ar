/***************************************************************************
                 formaspago.qs  -  description
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
    function validateForm():Boolean {
				return this.ctx.interna_validateForm();
		}
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

/** @class_declaration fluxEcommerce */
/////////////////////////////////////////////////////////////////
//// FLUX ECOMMERCE //////////////////////////////////////////////////////
class fluxEcommerce extends oficial {
    function fluxEcommerce( context ) { oficial ( context ); }
	function init() {
		this.ctx.fluxEcommerce_init();
	}
	function validateForm():Boolean {
		return this.ctx.fluxEcommerce_validateForm();
	}
	function traducirDescripcion() {
		return this.ctx.fluxEcommerce_traducir("descripcion");
	}
	function traducirDescLarga() {
		return this.ctx.fluxEcommerce_traducir("descripcionlarga");
	}
}
//// FLUX ECOMMERCE //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends fluxEcommerce {
    function head( context ) { fluxEcommerce ( context ); }
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
function interna_validateForm():Boolean
{
		var cursor:FLSqlCursor = this.cursor();
		var totalAplazado:Number = 0;

/** \C La suma de los % aplazados debe ser igual al 100%"
\end */

		if (cursor.modeAccess() == cursor.Insert || cursor.modeAccess() == cursor.Edit) {
				var query:FLSqlQuery = new FLSqlQuery();
				query.setTablesList("plazos");
				query.setSelect("SUM(aplazado)");
				query.setFrom("plazos");
				query.setWhere("upper(codpago)='" + cursor.valueBuffer("codpago").upper() + "';");
				query.exec();
				if (query.next())
						totalAplazado = parseFloat(query.value(0));

				if (totalAplazado != 100) {
						MessageBox.critical("La suma de los % aplazados debe ser igual al 100%",
								MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
						return false;
				}
		}

		return true;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition fluxEcommerce */
/////////////////////////////////////////////////////////////////
//// FLUX ECOMMERCE //////////////////////////////////////////////////////

function fluxEcommerce_init()
{
	connect(this.child("pbnTradDescripcion"), "clicked()", this, "iface.traducirDescripcion");
	connect(this.child("pbnTradDescLarga"), "clicked()", this, "iface.traducirDescLarga");

	this.child("fdbDescLarga").setTextFormat(0);
}

function fluxEcommerce_validateForm() 
{
	var util:FLUtil = new FLUtil();
	if (!util.sqlSelect("formaspago", "codpago", "activo = true AND codpago <> '" + this.cursor().valueBuffer("codpago") + "'") && !this.cursor().valueBuffer("activo")) {
		MessageBox.information(util.translate("scripts",
			"Debe existir al menos una forma de pago activa"),
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	
	return this.iface.__validateForm();
}

function fluxEcommerce_traducir(campo)
{
	return flfactppal.iface.pub_traducir("formaspago", campo, this.cursor().valueBuffer("codpago"));
}

//// FLUX ECOMMERCE //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////