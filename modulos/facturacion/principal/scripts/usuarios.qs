/***************************************************************************
                 usuarios.qs  -  description
                             -------------------
    begin                : mar nov 18 2008
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
	function validateForm():Boolean { return this.ctx.interna_validateForm(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	function oficial( context ) { interna( context ); }
	function cambiarPassword() {
		this.ctx.oficial_cambiarPassword();
	}
	function syncPass(pass:String) {
		return this.ctx.oficial_syncPass(pass);
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
	var cursor:FLSqlCursor = this.cursor();

	this.child("lineEditPass").text = "";
	this.child("lineEditPass").setDisabled(true);

	connect(this.child("pbnCambiarPassword"), "clicked()", this, "iface.cambiarPassword()");
	connect(this.child("lineEditPass"), "textChanged(QString)", this, "iface.syncPass");

	if ( cursor.modeAccess() == cursor.Browse )
		this.child("pbnCambiarPassword").setDisabled(true);
	else
		this.child("pbnCambiarPassword").setDisabled(false);

	if ( cursor.modeAccess() == cursor.Insert ) {
		this.child("fdbUsuarioCreado").setDisabled(false);
		this.iface.cambiarPassword();
		this.child("fdbIdUsuario").setFocus();
	} else
		this.child("fdbUsuarioCreado").setDisabled(true);
}

function interna_validateForm():Boolean
{
	var util:FLUtil = new FLUtil();

	if (!this.cursor().valueBuffer("idusuario") || !this.cursor().valueBuffer("nombre")) {
		MessageBox.warning(util.translate("scripts", "Debe completar los datos del usuario."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	if (!this.cursor().valueBuffer("coddepartamento")) {
		MessageBox.warning(util.translate("scripts", "Debe indicar el departamento del usuario."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	if (!this.cursor().valueBuffer("password") && !this.cursor().valueBuffer("hash")) {
		MessageBox.warning(util.translate("scripts", "No puede dejar la contraseña en blanco."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}
	return true;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_cambiarPassword()
{
	this.child("lineEditPass").setDisabled(false);
	this.child("lineEditPass").setFocus();
	this.child("pbnCambiarPassword").setDisabled(true);
}

function oficial_syncPass(pass:String)
{
	var cursor:FLSqlCursor = this.cursor();
	cursor.setValueBuffer("password", pass);
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
