/***************************************************************************
                 acciones_familiasalmacen.qs  -  description
                             -------------------
    begin                : mar dic 15 2009
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
	function bufferChanged(fN:String) {
		this.ctx.oficial_bufferChanged(fN);
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

	connect (cursor, "bufferChanged(QString)", this, "iface.bufferChanged");

	connect (this.child("ckbMarcacion"), "clicked()", this, "iface.verificarHabilitaciones()");
	connect (this.child("ckbFamiliaMadre"), "clicked()", this, "iface.verificarHabilitaciones()");
	connect (this.child("ckbUnidad"), "clicked()", this, "iface.verificarHabilitaciones()");

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
	// Marcación
	if ( this.child("ckbMarcacion").checked )
		this.child("gbxMarcacion").setDisabled(false);
	else
		this.child("gbxMarcacion").setDisabled(true);

	// Familia madre
	if ( this.child("ckbFamiliaMadre").checked )
		this.child("gbxFamiliaMadre").setDisabled(false);
	else
		this.child("gbxFamiliaMadre").setDisabled(true);

	// Unidad
	if ( this.child("ckbUnidad").checked )
		this.child("gbxUnidad").setDisabled(false);
	else
		this.child("gbxUnidad").setDisabled(true);
}

function oficial_bufferChanged(fN:String)
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	switch (fN) {
	}
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
