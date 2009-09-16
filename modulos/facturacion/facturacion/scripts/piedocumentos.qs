/***************************************************************************
                 piedocumentos.qs  -  description
                             -------------------
    begin                : vie ago 21 2009
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

/** @class_declaration pieDocumento */
/////////////////////////////////////////////////////////////////
//// PIE DE DOCUMENTO ///////////////////////////////////////////
class pieDocumento extends oficial {
	var ejercicioActual:String;
	var longSubcuenta:Number;
	var contabilidadCargada:Boolean;
	var posActualPuntoSubcuenta:Number;
	var bloqueoSubcuenta:Boolean;
	
	function pieDocumento( context ) { oficial ( context ); }
	function init() {
		this.ctx.pieDocumento_init();
	}
	function validateForm():Boolean {
		return this.ctx.pieDocumento_validateForm();
	}
	function bufferChanged(fN:String) {
		this.ctx.pieDocumento_bufferChanged(fN);
	}
}
//// PIE DE DOCUMENTO  //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends pieDocumento {
    function head( context ) { pieDocumento( context ); }
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

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition pieDocumento */
//////////////////////////////////////////////////////////////////
//// PIE DE DOCUMENTO ////////////////////////////////////////////

function pieDocumento_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	if (sys.isLoadedModule("flcontppal")) {
		this.iface.contabilidadCargada = true;
		this.iface.ejercicioActual = flfactppal.iface.pub_ejercicioActual();
		this.iface.longSubcuenta = util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + this.iface.ejercicioActual + "'");
		this.iface.bloqueoSubcuenta = false;
		this.iface.posActualPuntoSubcuenta = -1;
		this.child("fdbIdSubcuenta").setFilter("codejercicio = '" + this.iface.ejercicioActual + "'");
	} else {
		this.child("gbxContabilidad").enabled = false;
	}

	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");

	this.iface.bufferChanged("incluidoneto");
}

function pieDocumento_validateForm()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	if ( cursor.valueBuffer("incluidoneto") && !cursor.valueBuffer("codimpuesto") ) {
		MessageBox.warning("Si el pie de documento se incluye en el Neto debe especificar el tipo de IVA que se le aplica.", MessageBox.Ok, MessageBox.NoButton);
		return false;
	}

	if (sys.isLoadedModule("flcontppal")) {
		var codSubcuenta:String = cursor.valueBuffer("codsubcuenta");
		if ((!codSubcuenta || codSubcuenta == "") && !cursor.valueBuffer("incluidoneto")) {
			var res:Number = MessageBox.warning(util.translate("scripts", "No ha establecido la subcuenta contable asociada al pie de documento.\nEsto provocará que, al crear facturas con pies asociados a este pie de documento, la generación del asiento contable falle.\n¿Desea continuar?"), MessageBox.Yes, MessageBox.No);
			if (res != MessageBox.Yes)
				return false;
		}
	}

	return true;
}

function pieDocumento_bufferChanged(fN:String)
{
	var cursor:FLSqlCursor = this.cursor();

	switch (fN) {
		case "incluidoneto": {
			if (cursor.valueBuffer("incluidoneto")) {
				this.child("fdbCodImpuesto").setDisabled(false);
			} else {
				this.child("fdbCodImpuesto").setValue("");
				this.child("fdbCodImpuesto").setDisabled(true);
			}
			break;
		}
		case "codsubcuenta": {
			if (!this.iface.bloqueoSubcuenta) {
				this.iface.bloqueoSubcuenta = true;
				this.iface.posActualPuntoSubcuenta = flcontppal.iface.pub_formatearCodSubcta(this, "fdbCodSubcuenta", this.iface.longSubcuenta, this.iface.posActualPuntoSubcuenta);
				this.iface.bloqueoSubcuenta = false;
			}
			break;
		}
	}
}

//// PIE DE DOCUMENTO ////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
