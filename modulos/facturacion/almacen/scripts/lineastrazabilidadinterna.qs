/***************************************************************************
                 lineastrazabilidadinterna.qs  -  description
                             -------------------
    begin                : vie sep 19 2008
    copyright            : (C) 2008 by InfoSiAL S.L.
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
    function init() { 
	return this.ctx.interna_init(); 
    }
    function calculateField(fN:String):String {
	return this.ctx.interna_calculateField(fN);
    }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
    var porLotes:Boolean;
    function oficial( context ) { interna( context ); } 
	function desconectar() {
		return this.ctx.oficial_desconectar();
	}
	function bufferChanged(fN:String) {
		return this.ctx.oficial_bufferChanged(fN);
	}
	function habilitarControlesPorLotes()  {
		return this.ctx.oficial_habilitarControlesPorLotes();
	}
	function calcularCantidad() {
		return this.ctx.oficial_calcularCantidad();
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
/** \C
Este formulario realiza la gestión de las líneas de trazabilidad interna.
\end */
function interna_init()
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();

	connect(cursor, "bufferChanged(QString)", this, "iface.bufferChanged");
	connect(this.child("tdbMoviLote").cursor(), "bufferCommited()", this, "iface.calcularCantidad()");

	this.iface.habilitarControlesPorLotes();
	this.child("fdbReferencia").editor().setFocus();
}

/** \D Calcula el valor de un campo
@param	fN: Nombre del campo
@return	Valor del campo calculado
\end */
function interna_calculateField(fN:String):String
{
	var res:String;
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	switch (fN) {
		case "cantidad": {
			if (this.iface.porLotes) {
debug("idlinea " + cursor.valueBuffer("idlinea"));
				res = util.sqlSelect("movilote", "SUM(cantidad)", "docorigen = 'TI' AND idlineati = " + cursor.valueBuffer("idlinea"));
			}
			break;
		}
	}
	return res;
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \C Si el artículo seleccionado está gestionado por lotes se inhabilitará el campo --cantidad--, que tomará el valor de la suma del campo cantidad de los movimientos asociados a la línea. Si no está gestionado por lotes, se inhabilitará la sección 'Movimientos de lotes'.
\end */
function oficial_bufferChanged(fN:String) {
	
	switch (fN) {
		case "referencia": {
			this.iface.habilitarControlesPorLotes();
			break;
		}
	}
}

/** \D Habilita y pone los valores iniciales para los controles del formulario en función de si el artículo seleccionado es por lotes o no
\end */
function oficial_habilitarControlesPorLotes() 
{
	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	this.iface.porLotes = util.sqlSelect("articulos", "porlotes", "referencia = '" + cursor.valueBuffer("referencia") + "'");
	if (this.iface.porLotes) {
		this.child("gbxMoviLote").setDisabled(false);
		this.child("fdbCantidad").setDisabled(true);
		this.iface.calcularCantidad();
	} else {
		this.child("gbxMoviLote").setDisabled(true);
		this.child("fdbCantidad").setDisabled(false);
		this.child("fdbReferencia").setDisabled(false);
	}
}

/** \D Calcula la cantidad como suma de los movimientos asociados a la línea. 
Si hay uno o más movimientos, la referencia no podrá ser modificada
\end */
function oficial_calcularCantidad()
{
debug("CC");
	if (this.child("tdbMoviLote").cursor().size() > 0) {
		this.child("fdbReferencia").setDisabled(true);
	} else {
		this.child("fdbReferencia").setDisabled(false);
	}
		
	this.cursor().setValueBuffer("cantidad", this.iface.calculateField("cantidad"));
}


//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
////////////////////////////////////////////////////////////////