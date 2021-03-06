/***************************************************************************
                 acciones_articulosprincipal.qs  -  description
                             -------------------
    begin                : mie nov 18 2009
    copyright            : (C) 2009 by Silix
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
	function init() {
		this.ctx.interna_init();
	}
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	function oficial( context ) { interna( context ); }
	function inicializarControles() {
		this.ctx.oficial_inicializarControles();
	}
	function verificarHabilitaciones() {
		this.ctx.oficial_verificarHabilitaciones();
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

/** @class_declaration ifaceCtx*/
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

function interna_init()
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();

	connect (this.child("ckbProveedor"), "clicked()", this, "iface.verificarHabilitaciones()");
	connect (this.child("ckbAgente"), "clicked()", this, "iface.verificarHabilitaciones()");
	connect (this.child("ckbDivisa"), "clicked()", this, "iface.verificarHabilitaciones()");
	connect (this.child("ckbImpuesto"), "clicked()", this, "iface.verificarHabilitaciones()");

	this.iface.inicializarControles();
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_inicializarControles()
{
	this.iface.verificarHabilitaciones();
}

function oficial_verificarHabilitaciones()
{
	// Proveedor
	if ( this.child("ckbProveedor").checked )
		this.child("gbxProveedor").setDisabled(false);
	else
		this.child("gbxProveedor").setDisabled(true);

	// Agente
	if ( this.child("ckbAgente").checked )
		this.child("gbxAgente").setDisabled(false);
	else
		this.child("gbxAgente").setDisabled(true);

	// Divisa
	if ( this.child("ckbDivisa").checked )
		this.child("gbxDivisa").setDisabled(false);
	else
		this.child("gbxDivisa").setDisabled(true);

	// Impuesto
	if ( this.child("ckbImpuesto").checked )
		this.child("gbxImpuesto").setDisabled(false);
	else
		this.child("gbxImpuesto").setDisabled(true);
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
