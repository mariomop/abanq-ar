/***************************************************************************
                 flfactinfo.qs  -  description
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
	var variosIvas_:Boolean;
	var acumulados:Array = []; // Acumulados de valores numéricos en el informe
	var cuentaAcum:Array = []; // Almacena cuántos valores se han acumulado en cada índice del array acumulados
	var ultIdDocPagina:String;
	var paginaActual:Number;
    function oficial( context ) { interna( context ); }
	function datosPieFactura(nodo:FLDomNode, campo:String):Number {
		return this.ctx.oficial_datosPieFactura(nodo, campo);
	}
	function crearInforme(nombreInforme:String) {
		return this.ctx.oficial_crearInforme(nombreInforme);
	}
	function lanzarInforme(cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String, etiquetas:Boolean, impDirecta:Boolean, whereFijo:String, nombreReport:String, numCopias:Number, impresora:String, pdf:Boolean) {
		return this.ctx.oficial_lanzarInforme(cursor, nombreInforme, orderBy, groupBy, etiquetas, impDirecta, whereFijo, nombreReport, numCopias, impresora, pdf);
	}
	function seleccionEtiquetaInicial():Array {
		return this.ctx.oficial_seleccionEtiquetaInicial();
	}
	function establecerConsulta(cursor:FLSqlCursor, nombreConsulta:String, orderBy:String, groupBy:String, whereFijo:String):FLSqlQuery {
		return this.ctx.oficial_establecerConsulta(cursor, nombreConsulta, orderBy, groupBy, whereFijo);
	}
	function obtenerSigno(s:String):String {
		return this.ctx.oficial_obtenerSigno(s);
	}
	function fieldName(s:String):String {
		return this.ctx.oficial_fieldName(s);
	}
	function obtenerAcumulado(nodo:FLDomNode, campo:String):String {
		return this.ctx.oficial_obtenerAcumulado(nodo,campo);
	}
	function acumularValor(nodo:FLDomNode, campo:String):String {
		return this.ctx.oficial_acumularValor(nodo, campo);
	}
	function restaurarAcumulado(nodo:FLDomNode, campo:String):String {
		return this.ctx.oficial_restaurarAcumulado(nodo, campo);
	}
	function logo(nodo:FLDomNode, campo:String):String {
		return this.ctx.oficial_logo(nodo, campo);
	}
	function porIVA(nodo:FLDomNode, campo:String):String {
		return this.ctx.oficial_porIVA(nodo, campo);
	}
	function desgloseIva(nodo:FLDomNode, campo:String):String {
		return this.ctx.oficial_desgloseIva(nodo, campo);
	}
	function desgloseBaseImponible(nodo:FLDomNode, campo:String):String {
		return this.ctx.oficial_desgloseBaseImponible(nodo, campo);
	}
	function desgloseTotal(nodo:FLDomNode, campo:String):String {
		return this.ctx.oficial_desgloseTotal(nodo, campo);
	}
	function vencimiento(nodo:FLDomNode, campo:String):String {
		return this.ctx.oficial_vencimiento(nodo, campo);
	}
	function reemplazar(cadena:String, patronOrigen:String, patronDestino:String):String {
		return this.ctx.oficial_reemplazar(cadena, patronOrigen, patronDestino);
	}
	function cuentaFacturaCli(nodo:FLDomNode, campo:String):String {
		return this.ctx.oficial_cuentaFacturaCli(nodo, campo);
	}
	function numPagina(nodo:FLDomNode, campo:String):String {
		return this.ctx.oficial_numPagina(nodo, campo);
	}
	function aplicarCriterio(tabla:String, campo:String, valor:String, signo:String):String {
		return this.ctx.oficial_aplicarCriterio(tabla, campo, valor, signo);
	}
	function ampliarWhere(nombreConsulta:String):String {
		return this.ctx.oficial_ampliarWhere(nombreConsulta);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration infoVtos */
/////////////////////////////////////////////////////////////////
//// INFO_VENCIMIENTOS //////////////////////////////////////////
class infoVtos extends oficial {
    function infoVtos( context ) { oficial ( context ); }
	function cabeceraVencimientos(nodo:FLDomNode, campo:String):String {
		return this.ctx.infoVtos_cabeceraVencimientos(nodo, campo);
	}
}
//// INFO_VENCIMIENTOS //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration recibosProv */
/////////////////////////////////////////////////////////////////
//// RECIBOS PROV ///////////////////////////////////////////////
class recibosProv extends infoVtos {
    function recibosProv( context ) { infoVtos ( context ); }
	function aplicarCriterio(tabla:String, campo:String, valor:String, signo:String):String {
		return this.ctx.recibosProv_aplicarCriterio(tabla, campo, valor, signo);
	}
}
//// RECIBOS PROV ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration funServiciosCli */
//////////////////////////////////////////////////////////////////
//// FUN_SERVICIOS_CLI /////////////////////////////////////////////////////
class funServiciosCli extends recibosProv {
	function funServiciosCli( context ) { recibosProv( context ); } 
	function servicioConContrato(nodo:FLDomNode):String { 
		return funServiciosCli_servicioConContrato(nodo)
	}
	function encabezadoAlbaranFactura(nodo:FLDomNode):String { 
		return funServiciosCli_encabezadoAlbaranFactura(nodo)
	}
	function datosClienteServicio(nodo:FLDomNode):String { 
		return funServiciosCli_datosClienteServicio(nodo)
	}
}
//// FUN_SERVICIOS_CLI /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration articuloscomp */
/////////////////////////////////////////////////////////////////
//// ARTICULOSCOMP //////////////////////////////////////////////
class articuloscomp extends funServiciosCli {
    function articuloscomp( context ) { funServiciosCli ( context ); }
	function crearTabla(tipoDoc:String,idDoc:Number):Boolean {
		return this.ctx.articuloscomp_crearTabla(tipoDoc,idDoc);
	}
	function crearLinea(referencia:String,cantidad:Number,idLinea:Number):Boolean {
		return this.ctx.articuloscomp_crearLinea(referencia,cantidad,idLinea);
	}
}
//// ARTICULOSCOMP //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration funNumAcomp */
//////////////////////////////////////////////////////////////////
//// FUN_NUM_ACOMP /////////////////////////////////////////////////////

class funNumAcomp extends articuloscomp {
	function funNumAcomp( context ) { articuloscomp( context ); } 	
	function crearTabla(tipoDoc:String,idDoc:Number):Boolean {
		return this.ctx.funNumAcomp_crearTabla(tipoDoc,idDoc);
	}
}

//// FUN_NUM_ACOMP /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////


/** @class_declaration infoCliProv */
/////////////////////////////////////////////////////////////////
//// INFOCLIPROV //////////////////////////////////////////////////
class infoCliProv extends funNumAcomp {
	var idInformeActual:Number;
	function infoCliProv( context ) { funNumAcomp ( context ); }
	function cabeceraClientes(nodo:FLDomNode, campo:String):String {
		return this.ctx.infoCliProv_cabeceraClientes(nodo, campo);
	}
	function cabeceraProveedores(nodo:FLDomNode, campo:String):String {
		return this.ctx.infoCliProv_cabeceraProveedores(nodo, campo);
	}
	function establecerId(id:Number) {
		return this.ctx.infoCliProv_establecerId(id);
	}
}
//// INFOCLIPROV //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubInfoCliProv */
/////////////////////////////////////////////////////////////////
//// PUBINFOCLIPROV //////////////////////////////////////////////////
class pubInfoCliProv extends infoCliProv {
	function pubInfoCliProv( context ) { infoCliProv ( context ); }
	function pub_cabeceraClientes(nodo:FLDomNode, campo:String):String {
		return this.cabeceraClientes(nodo, campo);
	}
	function pub_cabeceraProveedores(nodo:FLDomNode, campo:String):String {
		return this.cabeceraProveedores(nodo, campo);
	}
	function pub_establecerId(id:Number) {
		return this.establecerId(id);
	}
}

//// PUBINFOCLIPROV //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration datos */
/////////////////////////////////////////////////////////////////
//// DATOS //////////////////////////////////////////////////////
class datos extends pubInfoCliProv {
    function datos( context ) { pubInfoCliProv ( context ); }
	function obtenerCodigo(nodo:FLDomNode, campo:String):String {
		return this.ctx.datos_obtenerCodigo(nodo, campo);
	}

}
//// DATOS //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends datos {
    function head( context ) { datos ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
	function ifaceCtx( context ) { head( context ); }
	function pub_lanzarInforme(cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String, etiquetas:Boolean, impDirecta:Boolean, whereFijo:String, nombreReport:String, numCopias:Number, impresora:String, pdf:Boolean) {
	return this.lanzarInforme(cursor, nombreInforme, orderBy, groupBy, etiquetas, impDirecta, whereFijo, nombreReport, numCopias, impresora, pdf);
	}
	function pub_datosPieFactura(nodo:FLDomNode, campo:String):Number {
		return this.datosPieFactura(nodo, campo);
	}
	function pub_logo(nodo:FLDomNode, campo:String):String {
		return this.logo(nodo, campo);
	}
	function pub_porIVA(nodo:FLDomNode, campo:String):String {
		return this.porIVA(nodo, campo);
	}
	function pub_desgloseIva(nodo:FLDomNode, campo:String):String {
		return this.desgloseIva(nodo, campo);
	}
	function pub_desgloseBaseImponible(nodo:FLDomNode, campo:String):String {
		return this.desgloseBaseImponible(nodo, campo);
	}
	function pub_desgloseTotal(nodo:FLDomNode, campo:String):String {
		return this.desgloseTotal(nodo, campo);
	}
}
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubInfoVtos */
/////////////////////////////////////////////////////////////////
//// PUB_INFO_VENCIMIENTOS //////////////////////////////////////
class pubInfoVtos extends ifaceCtx {
    function pubInfoVtos( context ) { ifaceCtx ( context ); }
	function pub_cabeceraVencimientos(nodo:FLDomNode, campo:String):String {
		return this.cabeceraVencimientos(nodo, campo);
	}
}
//// PUB_INFO_VENCIMIENTOS //////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubarticuloscomp */
/////////////////////////////////////////////////////////////////
//// ARTICULOSCOMP //////////////////////////////////////////////
class pubarticuloscomp extends pubInfoVtos {
    function pubarticuloscomp( context ) { pubInfoVtos ( context ); }
	function pub_crearTabla(tipoDoc:String,idDoc:Number):Boolean {
		return this.crearTabla(tipoDoc,idDoc);
	}
}
//// ARTICULOSCOMP //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration pubDatos */
/////////////////////////////////////////////////////////////////
//// PUB_DATOS //////////////////////////////////////////////////
class pubDatos extends pubarticuloscomp {
    function pubDatos( context ) { pubarticuloscomp ( context ); }
	function pub_obtenerCodigo(nodo:FLDomNode, campo:String):String {
		return this.obtenerCodigo(nodo, campo);
	}
}
//// PUB_DATOS //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

const iface = new pubDatos( this );

/** @class_definition interna */
////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////
function interna_init() {
	var util:FLUtil = new FLUtil;
	util.writeSettingEntry("kugar/banner", "");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
/** \D
Obtiene los datos de totalización de pie de factura
@param	nodo: Nodo XML con los datos de la línea que se va a mostrar en el informe
@param	campo: Campo a mostrar
@return	Valor del campo
\end */
function oficial_datosPieFactura(nodo:FLDomNode, campo:String):Number
{
		var util:FLUtil = new FLUtil();
		var sCampo:String = campo.toString();
		var tablaFacturas:String;
		var tablaIva:String;
		if (sCampo.charAt(0) == "P"
				&& sCampo.charAt(1) == "_") {
				tablaFacturas = "facturasprov";
				tablaIva = "lineasivafactprov";
				campo = "";
				for (var i:Number = 2; i < sCampo.length; i++)
						campo += sCampo.charAt(i);
		} else {
				tablaFacturas = "facturascli";
				tablaIva = "lineasivafactcli";
		}

		var idFactura:Number = nodo.attributeValue(tablaFacturas + ".idfactura");
		var util:FLUtil = new FLUtil;
		var res:Number;
		if (campo == "BI4") {
				res = util.sqlSelect(tablaIva, "neto", "idfactura = " + idFactura + " AND iva = 4");
		} else if (campo == "BI7") {
				res = util.sqlSelect(tablaIva, "neto", "idfactura = " + idFactura + " AND iva = 7");
		} else if (campo == "BI16") {
				res = util.sqlSelect(tablaIva, "neto", "idfactura = " + idFactura + " AND iva = 16");
		} else if (campo == "IVA4") {
				res = util.sqlSelect(tablaIva, "totaliva", "idfactura = " + idFactura + " AND iva = 4");
		} else if (campo == "IVA7") {
				res = util.sqlSelect(tablaIva, "totaliva", "idfactura = " + idFactura + " AND iva = 7");
		} else if (campo == "IVA16") {
				res = util.sqlSelect(tablaIva, "totaliva", "idfactura = " + idFactura + " AND iva = 16");
		} else if (campo == "T4") {
				res = util.sqlSelect(tablaIva, "totallinea", "idfactura = " + idFactura + " AND iva = 4");
		} else if (campo == "T7") {
				res = util.sqlSelect(tablaIva, "totallinea", "idfactura = " + idFactura + " AND iva = 7");
		} else if (campo == "T16") {
				res = util.sqlSelect(tablaIva, "totallinea", "idfactura = " + idFactura + " AND iva = 16");
		}
		if (parseFloat(res) == 0 || !res)
				res = "";
		return res;
}

/** \D
Crea el informe especificado
@param	nombreinforme: Nombre del informe a crear
\end */
function oficial_crearInforme(nombreInforme:String)
{
		if (this.iface.establecerCriteriosBusqueda(nombreInforme) == true);
			this.iface.lanzarInforme(nombreInforme);
}

/** \D Establece la fila y columna de la primera etiqueta a imprimir para los informes de etiquetas
\end */
function oficial_seleccionEtiquetaInicial():Array
{
	var etiquetaInicial:Array = [];
	etiquetaInicial["fila"] = 0;
	etiquetaInicial["col"] = 0;
	var util:FLUtil = new FLUtil;
	var dialog:Object = new Dialog;
	dialog.caption = util.translate("scripts","Elegir fila y columna a imprimir");
	dialog.okButtonText = util.translate("scripts","Aceptar");
	dialog.cancelButtonText = util.translate("scripts","Cancelar");

	var text:Object = new Label;
	text.text = util.translate("scripts","Ha seleccionado un informe de etiquetas,\nelija la fila y la columna a imprimir:");
	dialog.add(text);

	var spbNumColum:Object= new SpinBox;
	spbNumColum.label = util.translate("scripts","Columnas");
	spbNumColum.minimum = 1;
	spbNumColum.maximum = 30;
	dialog.add(spbNumColum);

	var spbNumFila:Object = new SpinBox;
	spbNumFila.label = util.translate("scripts","Filas");
	spbNumFila.minimum = 1;
	spbNumFila.maximum = 30;
	dialog.add(spbNumFila);

	if (dialog.exec()){
		etiquetaInicial["fila"] = spbNumFila.value;
		etiquetaInicial["col"] = spbNumColum.value;
	}
	return etiquetaInicial;
}

/** \D Establece la consulta del informe, creando el where a partir de los campos del cursor
@param	cursor: Cursor posicionado en un registro de criterios de búsqueda
@param	nombreConsulta: Nombre del fichero con la descripción de la consulta
@param	orderBy: Cláusula Order By
@param	groupBy: Cláusula Group By
@param	whereFijo: Cláusula Where que se añade al construido a partir de los campos del cursor
@return	consulta o false si hay error
\end */
function oficial_establecerConsulta(cursor:FLSqlCursor, nombreConsulta:String, orderBy:String, groupBy:String, whereFijo:String):FLSqlQuery
{
	var util:FLUtil = new FLUtil();
	var q:FLSqlQuery = new FLSqlQuery(nombreConsulta);
	var fieldList:String = util.nombreCampos(cursor.table());
	var cuenta:Number = parseFloat(fieldList[0]);

	var signo:String;
	var fN:String;
	var valor:String;
	var primerCriterio:Boolean = false;
	var where:String = "";
	var criterio:String;
	for (var i:Number = 1; i <= cuenta; i++) {
		if (cursor.isNull(fieldList[i])) {
			continue;
		}
		signo = this.iface.obtenerSigno(fieldList[i]);
		if (signo != "") {
			fN = this.iface.fieldName(fieldList[i]);
			valor = cursor.valueBuffer(fieldList[i]);
			criterio = this.iface.aplicarCriterio(cursor.table(), fN, valor, signo);
			if (criterio && criterio != "") {
				if (primerCriterio == true) {
					where += " AND ";
				}
				where += criterio;
				primerCriterio = true;
			}
		}
	}
	
	if (whereFijo && whereFijo != "") {
		if (where == "")
			where = whereFijo;
		else
			where = whereFijo + " AND (" + where + ")";
	}
		
	var ampliarWhere:String = this.iface.ampliarWhere(nombreConsulta);
	if (ampliarWhere)
		if (where)
			where += " AND " + ampliarWhere;
		else
			where += ampliarWhere;
	
	if (groupBy && groupBy != "") {
		if (where == "")
			where = "1 = 1";
		where += " GROUP BY " + groupBy;
	}
	
	q.setWhere(where);
	
	if (orderBy)
		q.setOrderBy(orderBy);
	
	return q;
}

/** Construye un criterio de búsqueda para la consulta
@param	Tabla: Tabla de criterios
@param	Campo: Campo de criterios
@param	Valor: Valor del criterio
@param	Signo: Signo del criterio
@return Criterio (típicamente tabla.campo signo criterio. Ej facturascli.codcliente = '000001')
\end */
function oficial_aplicarCriterio(tabla:String, campo:String, valor:String, signo:String):String
{
	var criterio:String = "";
	switch (tabla) {
		case "i_reciboscli": {
			switch (campo) {
				case "reciboscli.estado": {
					switch (valor) {
						case "Pendiente": {
							criterio = "reciboscli.estado IN ('Emitido', 'Devuelto')";
							break;
						}
					}
					break;
				}
			}
			break;
		}
		case "i_pedidoscli": {
			switch (campo) {
				case "pedidoscli.servido": {
					switch(valor) {
						case "Pendiente": {
							criterio = "pedidoscli.servido IN ('No','Parcial')";
						}
					}
					break;
				}
			}
			break;
		}
		case "i_pedidosprov": {
			switch (campo) {
				case "pedidosprov.servido": {
					switch(valor) {
						case "Pendiente": {
							criterio = "pedidosprov.servido IN ('No','Parcial')";
						}
					}
					break;
				}
			}
			break;
		}
	}

	if (criterio == "") {
		if (valor == "Sí")
			valor = 1;
		if (valor == "No")
			valor = 0;
		if (valor == "Todos")
			valor = "";
		if (!valor.toString().isEmpty()) {
			criterio = campo + " " + signo + " '" + valor + "' ";
		}
	}
	return criterio;
}
/** \D
Lanza un informe
@param	cursor: Cursor con los criterios de búsqueda para la consulta base del informe
@param	nombreinforme: Nombre del informe
@param	orderBy: Cláusula ORDER BY de la consulta base
@param	groupBy: Cláusula GROUP BY de la consulta base
@param	etiquetas: Indicador de si se trata de un informe de etiquetas
@param	impDirecta: Indicador para imprimir directaemnte el informe, sin previsualización
@param	whereFijo: Sentencia where que debe preceder a la sentencia where calculada por la función
\end */
function oficial_lanzarInforme(cursor:FLSqlCursor, nombreInforme:String, orderBy:String, groupBy:String, etiquetas:Boolean, impDirecta:Boolean, whereFijo:String, nombreReport:String, numCopias:Number, impresora:String, pdf:Boolean)
{
	var util:FLUtil = new FLUtil();
	var etiquetaInicial:Array = [];
	if (etiquetas == true) {
		etiquetaInicial = this.iface.seleccionEtiquetaInicial();
	} else {
		etiquetaInicial["fila"] = 0;
		etiquetaInicial["col"] = 0;
	}
	
	this.iface.ultIdDocPagina = "";

	var q:FLSqlQuery = this.iface.establecerConsulta(cursor, nombreInforme, orderBy, groupBy, whereFijo);
debug("------ CONSULTA -------" + q.sql());
	if (q.exec() == false) {
		MessageBox.critical(util.translate("scripts", "Falló la consulta"), MessageBox.Ok, MessageBox.NoButton);
		return;
	} else {
		if (q.first() == false) {
			MessageBox.warning(util.translate("scripts", "No hay registros que cumplan los criterios de búsqueda establecidos"), MessageBox.Ok, MessageBox.NoButton);
			return;
		}
	}

	if (!nombreReport) 
		nombreReport = nombreInforme;
			
	var rptViewer:FLReportViewer = new FLReportViewer();
	rptViewer.setReportTemplate(nombreReport);
	rptViewer.setReportData(q);
	rptViewer.renderReport(etiquetaInicial.fila, etiquetaInicial.col);
	if (numCopias)
		rptViewer.setNumCopies(numCopias);
	if (impresora) {
		try {
			rptViewer.setPrinterName(impresora);
		}
		catch (e) {}
	}
	if (impDirecta) {
		rptViewer.printReport();
	} else if (pdf) { 
		//Si pdf es true, en el parámetro impresora está la ruta completa del fichero pdf
		rptViewer.printReportToPDF(impresora);
	} else {
		rptViewer.exec();
	}
}

/** \D
Obtiene el operador lógico a aplicar en la cláusula where de la consulta a partir de los primeros caracteres del parámetro
@param	s: Nombre del campo que contiene un criterio de búsqueda
@return	Operador lógico a aplicar
\end */
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

/** \D
Obtiene el nombre del campo de la cadena s desde su segunda posición. Sustituye '_' por '.', dos '_" seguidos indica que realmente es '_"
@param	s: Nombre del campo que contiene un criterio de búsqueda
@return	Nombre procesado
\end */
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

/** \D Devuelve el valor del acumulado para el la variable indicada
@param	campo: Identificador del acumulado a devolver
*/
function oficial_obtenerAcumulado(nodo:FLDomNode, campo:String):String 
{
	return this.iface.acumulados[campo];
}

/** \D Acumula el valor del registro actual del informe
@param	campo: String con dos valores separados por '/':
	1. Identificador del acumulado a devolver
	2. Nombre del campo de la consulta del informe cuyo valor hay que acumular
*/
function oficial_acumularValor(nodo:FLDomNode, campo:String):String
{
	var campos:Array = campo.split("/");
	var valor:Number = parseFloat(campos[1]);
	if (isNaN(valor))
		valor = parseFloat(nodo.attributeValue(campos[1]));
	
	if (!this.iface.acumulados[campos[0]]) {
		this.iface.acumulados[campos[0]] = valor;
		this.iface.cuentaAcum[campos[0]] = 1;
	} else {
		this.iface.acumulados[campos[0]] += valor;
		this.iface.cuentaAcum[campos[0]]++;
	}
	return "0";
}

/** \D Restaura la variable del acumulado
@param	campo: Identificador del acumulado a restaurar
*/
function oficial_restaurarAcumulado(nodo:FLDomNode, campo:String):String
{
	this.iface.acumulados[campo] = 0;
	this.iface.cuentaAcum[campo] = 0;
	
	return "0";
}

/** \D
Obtiene el xpm del logo de la empresa
@return xpm del logo
*/
function oficial_logo(nodo:FLDomNode, campo:String):String
{
	var util:FLUtil = new FLUtil;
	return util.sqlSelect("empresa", "logo", "1 = 1");
}

function oficial_porIVA(nodo:FLDomNode, campo:String):String
{
	var util:FLUtil = new FLUtil;
	var idDocumento:String;
	var tablaPadre:String;
	var tabla:String;
	var campoClave:String;
	var porIva:String;
	switch (campo) {
		case "facturacli": {
			tablaPadre = "facturascli";
			tabla = "lineasfacturascli";
			campoClave = "idfactura";
			break;
		}
		case "facturaprov": {
			tablaPadre = "facturasprov";
			tabla = "lineasfacturasprov";
			campoClave = "idfactura";
			break;
		}
	}
	idDocumento = nodo.attributeValue(tablaPadre + "." + campoClave);
	this.iface.variosIvas_ = false;
	porIva = parseFloat(util.sqlSelect(tabla, "iva", campoClave + " = " + idDocumento));
	if (!porIva)
		porIva = 0;

	if (util.sqlSelect(tabla, "iva", campoClave + " = " + idDocumento + " AND iva <> " + porIva)) {
		this.iface.variosIvas_ = true;
		porIva = 0;
	}
	
	return "I.V.A. " + porIva.toString() + "%";
}


function oficial_desgloseIva(nodo:FLDomNode, campo:String):String
{
	if (!this.iface.variosIvas_)
		return "";
	
	var util:FLUtil = new FLUtil;
	var idDocumento:String;
	var tabla:String;
	var campoClave:String;
	switch (campo) {
		case "facturacli": {
			tablaPadre = "facturascli";
			tabla = "lineasivafactcli";
			campoClave = "idfactura";
			break;
		}
		case "facturaprov": {
			tablaPadre = "facturasprov";
			tabla = "lineasivafactprov";
			campoClave = "idfactura";
			break;
		}
	}
	idDocumento = nodo.attributeValue(tablaPadre + "." + campoClave);
	
	var qryIvas:FLSqlQuery = new FLSqlQuery();
	with (qryIvas) {
		setTablesList(tabla);
		setSelect("totaliva");
		setFrom(tabla);
		setWhere(campoClave + " = " + idDocumento + " ORDER BY iva");
	}
	if (!qryIvas.exec())
		return false;
	var listaIvas:String = "";
	while (qryIvas.next()) {
		if (listaIvas != "")
			listaIvas += "\n";
		listaIvas += util.roundFieldValue(qryIvas.value("totaliva"), tabla, "totaliva");
	}
	return listaIvas;
}

function oficial_desgloseBaseImponible(nodo:FLDomNode, campo:String):String
{
	if (!this.iface.variosIvas_)
		return "";
	
	var util:FLUtil = new FLUtil;
	var idDocumento:String;
	var tabla:String;
	var campoClave:String;
	switch (campo) {
		case "facturacli": {
			tablaPadre = "facturascli";
			tabla = "lineasivafactcli";
			campoClave = "idfactura";
			break;
		}
		case "facturaprov": {
			tablaPadre = "facturasprov";
			tabla = "lineasivafactprov";
			campoClave = "idfactura";
			break;
		}
	}
	idDocumento = nodo.attributeValue(tablaPadre + "." + campoClave);
	
	var qryIvas:FLSqlQuery = new FLSqlQuery();
	with (qryIvas) {
		setTablesList(tabla);
		setSelect("iva, neto");
		setFrom(tabla);
		setWhere(campoClave + " = " + idDocumento + " ORDER BY iva");
	}
	if (!qryIvas.exec())
		return false;
	var listaBases:String = "";
	while (qryIvas.next()) {
		if (listaBases != "")
			listaBases += "\n";
		listaBases += "I.V.A. " + qryIvas.value("iva") + "%: " + util.roundFieldValue(qryIvas.value("neto"), tabla, "neto");
	}
	return listaBases;
}

function oficial_desgloseTotal(nodo:FLDomNode, campo:String):String
{
	if (!this.iface.variosIvas_)
		return "";
	
	var util:FLUtil = new FLUtil;
	var idDocumento:String;
	var tabla:String;
	var campoClave:String;
	switch (campo) {
		case "facturacli": {
			tablaPadre = "facturascli";
			tabla = "lineasivafactcli";
			campoClave = "idfactura";
			break;
		}
		case "facturaprov": {
			tablaPadre = "facturasprov";
			tabla = "lineasivafactprov";
			campoClave = "idfactura";
			break;
		}
	}
	idDocumento = nodo.attributeValue(tablaPadre + "." + campoClave);
	
	var qryIvas:FLSqlQuery = new FLSqlQuery();
	with (qryIvas) {
		setTablesList(tabla);
		setSelect("totallinea");
		setFrom(tabla);
		setWhere(campoClave + " = " + idDocumento + " ORDER BY iva");
	}
	if (!qryIvas.exec())
		return false;
	var listaTotal:String = "";
	while (qryIvas.next()) {
		if (listaTotal != "")
			listaTotal += "\n";
		listaTotal += util.roundFieldValue(qryIvas.value("totallinea"), tabla, "totallinea");
	}
	return listaTotal;
}

/** \D
Función para campos calculados que obtiene los vencimientos de una factura de cliente
*/
function oficial_vencimiento(nodo:FLDomNode, campo:String):String
{
	var util:FLUtil = new FLUtil();
	if (!sys.isLoadedModule("flfactteso")) {
		var codPago:String;
		var fecha:String;
		if (campo == "reciboscli"){
			codPago = nodo.attributeValue("facturascli.codpago");
			fecha = nodo.attributeValue("facturascli.fecha");
		}
		else if (campo == "recibosprov"){
			codPago = nodo.attributeValue("facturasprov.codpago");
			fecha = nodo.attributeValue("facturasprov.fecha");
		}
		
		var qryDias:FLSqlQuery = new FLSqlQuery();
		var vencimientos:String = "";
		with(qryDias){
			setTablesList("plazos");
			setSelect("dias");
			setFrom("plazos");
			setWhere("codpago = '" + codPago + "' ORDER BY dias");
		}
		if (!qryDias.exec())
			return "";
			
		while (qryDias.next()) {
			if (vencimientos != "")
					vencimientos += ", ";
			vencimientos += util.dateAMDtoDMA(util.addDays(fecha, qryDias.value(0)));
		}
		var res:String = this.iface.reemplazar(vencimientos, '-', '/')
		return res;
	}
	
	var tabla:String;
	var idFactura:FLDomNode;
	
	if (campo == "reciboscli"){
		tabla = "reciboscli";
		idFactura = nodo.attributeValue("facturascli.idfactura");
	}
	else if (campo == "recibosprov"){	
		tabla = "recibosprov";
		idFactura = nodo.attributeValue("facturasprov.idfactura");
	}
	
	var qryRecibos:FLSqlQuery = new FLSqlQuery();
	var vencimientos:String = "";
	with (qryRecibos) {
		setTablesList(tabla);
		setSelect("fechav, importe");
		setFrom(tabla);
		setWhere("idfactura = '" + idFactura + "' ORDER BY fechav");
	}
	if (!qryRecibos.exec())
		return "";

	var fecha:String;
	while (qryRecibos.next()) {
		fecha = util.dateAMDtoDMA(qryRecibos.value(0));
		if (vencimientos != "")
			vencimientos += "\n";
		vencimientos += this.iface.reemplazar(fecha.substring(0,10), '-', '/');
		vencimientos += ": " + util.formatoMiles(util.roundFieldValue(qryRecibos.value("importe"), "reciboscli", "importe"));
	}
	//var res:String = this.iface.reemplazar(vencimientos, '-', '/')
	//res = this.iface.reemplazar(res, '.', ',')
	return vencimientos;
}

/** \D
Función para campos calculados que obtiene el número de cuenta corriente de la factura.
En primer lugar se busca si la forma de pago es domiciliada o no.
Si lo es, se busca la cuenta de domiciliación del cliente.
Si no lo es o no se encuentra la del cliente, se busca una cuenta de la forma de pago
*/
function oficial_cuentaFacturaCli(nodo:FLDomNode, campo:String):String
{
	var util:FLUtil = new FLUtil;
	var datosCuenta:String;
	var ret:String;
	var codCliente:String = nodo.attributeValue("facturascli.codcliente");
	var codPago:String = nodo.attributeValue("facturascli.codpago");
	var domiciliado:Boolean = util.sqlSelect("formaspago", "domiciliado", "codpago = '" + codPago + "'");
	var codCuenta:String
	
	var tipoCuenta:String;
	
	// Si no hay cliente, se busca la forma de pago
	if (!codCliente)
		tipoCuenta = "formaPago";
	
	else
		if (domiciliado)
			tipoCuenta = "domiciliado";		
		else 
			tipoCuenta = "formaPago";
	
	
	if (tipoCuenta == "domiciliado") {
		codCuenta = util.sqlSelect("clientes", "codcuentadom", "codcliente = '" + codCliente + "'");
		if (codCuenta)
			datosCuenta = flfactppal.iface.pub_ejecutarQry("cuentasbcocli", "ctaentidad,ctaagencia,cuenta", "codcuenta = '" + codCuenta + "'");
	}
	
	if (!codCuenta) {
		codCuenta = util.sqlSelect("formaspago", "codcuenta", "codpago = '" + codPago + "'");		
		if (!codCuenta)
			return "";
		datosCuenta = flfactppal.iface.pub_ejecutarQry("cuentasbanco", "ctaentidad,ctaagencia,cuenta", "codcuenta = '" + codCuenta + "'");
	}
	
	if (datosCuenta.result != 1)
		return "";
	var dc:String = util.calcularDC(datosCuenta.ctaentidad + datosCuenta.ctaagencia) + util.calcularDC(datosCuenta.cuenta);
	ret = datosCuenta.ctaentidad + " " + datosCuenta.ctaagencia + " " + dc + " " + datosCuenta.cuenta;
	return ret;
	
	
	
	
	
	// Si no hay cliente, se busca la forma de pago
	if (!codCliente) {
		codCuenta = util.sqlSelect("formaspago", "codcuenta", "codpago = '" + codPago + "'");		
		if (!codCuenta)
			return "";
		datosCuenta = flfactppal.iface.pub_ejecutarQry("cuentasbanco", "ctaentidad,ctaagencia,cuenta", "codcuenta = '" + codCuenta + "'");
	}
	
	else {
	
		if (domiciliado) {
			codCuenta = util.sqlSelect("clientes", "codcuentadom", "codcliente = '" + codCliente + "'");
			if (codCuenta)
				datosCuenta = flfactppal.iface.pub_ejecutarQry("cuentasbcocli", "ctaentidad,ctaagencia,cuenta", "codcuenta = '" + codCuenta + "'");
			else {
				codCuenta = util.sqlSelect("formaspago", "codcuenta", "codpago = '" + codPago + "'");		
				if (!codCuenta)
					return "";
				datosCuenta = flfactppal.iface.pub_ejecutarQry("cuentasbcocli", "ctaentidad,ctaagencia,cuenta", "codcuenta = '" + codCuenta + "'");
			}
		}
		
		else {
			codCuenta = util.sqlSelect("formaspago", "codcuenta", "codpago = '" + codPago + "'");		
			if (!codCuenta)
				return "";
			datosCuenta = flfactppal.iface.pub_ejecutarQry("cuentasbcocli", "ctaentidad,ctaagencia,cuenta", "codcuenta = '" + codCuenta + "'");
		}
	
	}
	
	
	
	
	
	
	
	var codCuenta:String = util.sqlSelect("clientes", "codcuentadom", "codcliente = '" + codCliente + "'");
	if (codCuenta) {
		datosCuenta = flfactppal.iface.pub_ejecutarQry("cuentasbcocli", "ctaentidad,ctaagencia,cuenta", "codcuenta = '" + codCuenta + "'");
	} else {
		codCuenta = util.sqlSelect("clientes", "codcuentarem", "codcliente = '" + codCliente + "'");
		if (!codCuenta)
			codCuenta = util.sqlSelect("formaspago", "codcuenta", "codpago = '" + codPago + "'");		
		if (!codCuenta)
			return "";
		
		datosCuenta = flfactppal.iface.pub_ejecutarQry("cuentasbanco", "ctaentidad,ctaagencia,cuenta", "codcuenta = '" + codCuenta + "'");
	}
	if (datosCuenta.result != 1)
			return "";
	var dc:String = util.calcularDC(datosCuenta.ctaentidad + datosCuenta.ctaagencia) + util.calcularDC(datosCuenta.cuenta);
	ret = datosCuenta.ctaentidad + " " + datosCuenta.ctaagencia + " " + dc + " " + datosCuenta.cuenta;
	return ret;
}



/** Devuelve el número de página, usado en informes de detalle de
facturación para establecer números por documento, no por páginas totales
del informe
*/
function oficial_numPagina(nodo:FLDomNode, campo:String):String
{
	var codigo:String = nodo.attributeValue(campo);
	
	if (codigo != this.iface.ultIdDocPagina)
		this.iface.paginaActual = 1;
	else
		this.iface.paginaActual++;
		
	this.iface.ultIdDocPagina = codigo;
	return this.iface.paginaActual;
}



/** \D
Reemplaza en una cadena un carácter por otro
@param	cadena: Cadena a tratar
@param	patronOrigen: Caracter a reemplazar
@param	patronDestino: Caracter que sustituye al origen
@return	Cadena tratada
*/
function oficial_reemplazar(cadena:String, patronOrigen:String, patronDestino:String):String
{
	var res:String = "";
	if (cadena != "") {
		for (var i:Number = 0; i < cadena.length; i++) {
			if (cadena.charAt(i) == patronOrigen)
				res += patronDestino;
			else
				res += cadena.charAt(i);
		}
	}
	return res;
}

function oficial_ampliarWhere(nombreConsulta:String):String
{
	var where:String = "";

	switch (nombreConsulta)	{
	
		case "i_pedidosprov":
		case "i_albaranesprov":
		case "i_facturasprov":
			where += "(dirproveedores.direccionppal = true OR dirproveedores.direccion IS NULL)";
		break;
	}
	
	return where;
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition infoVtos */
/////////////////////////////////////////////////////////////////
//// INFO_VENCIMIENTOS //////////////////////////////////////////
function infoVtos_cabeceraVencimientos(nodo:FLDomNode, campo:String):String
{
	switch (campo) {
		case "codejercicio":
			return nodo.attributeValue("criterios.codejercicio");
			break;
		case "empresa":
			return nodo.attributeValue("empresa.nombre");
			break;
		case "fachavtodesde":
			return nodo.attributeValue("criterios.fechavtodesde");
			break;
		case "fachavtohasta":
			return nodo.attributeValue("criterios.fechavtohasta");
			break;
	}
}
//// INFO_VENCIMIENTOS //////////////////////////////////////////
/////////////////////////////////////////////////////////////////
/** @class_definition recibosProv */
/////////////////////////////////////////////////////////////////
//// RECIBOS PROV ///////////////////////////////////////////////
function recibosProv_aplicarCriterio(tabla:String, campo:String, valor:String, signo:String):String
{
	var criterio:String = "";
	switch (tabla) {
		case "i_recibosprov": {
			switch (campo) {
				case "recibosprov.estado": {
					switch (valor) {
						case "Pendiente": {
							criterio = "recibosprov.estado IN ('Emitido', 'Devuelto')";
							break;
						}
					}
					break;
				}
			}
			break;
		}
	}

	if (criterio == "") {
		criterio = this.iface.__aplicarCriterio(tabla, campo, valor, signo);
	}
	return criterio;
}
//// RECIBOS PROV ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition funServiciosCli */
/////////////////////////////////////////////////////////////////
//// FUN_SERVICIOS_CLI /////////////////////////////////////////////////

function funServiciosCli_servicioConContrato(nodo:FLDomNode):String
{
	var util:FLUtil = new FLUtil();
	var contratoMant:Boolean = nodo.attributeValue("servicioscli.contratomant");
	
	if (contratoMant == "true") return "C. Mant";
	return "";
}

function funServiciosCli_encabezadoAlbaranFactura(nodo:FLDomNode):String
{
	var util:FLUtil = new FLUtil();
	var idAlbaran:Number = nodo.attributeValue("albaranescli.idalbaran");
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("servicioscli,tecnicos");
	q.setFrom("servicioscli s INNER JOIN tecnicos t ON s.codtecnico = t.codtecnico");
	q.setSelect("s.numservicio,s.fecha,s.contratomant,s.descripcion,s.solucion,t.apellidos,t.nombre");
	q.setWhere("s.idalbaran = " + idAlbaran);
	
	if (!q.exec()) return false;
	
	if (!q.first()) {
		return "MATERIALES";
	}
	
	var texto:String = 
		util.translate("MetaData", "SERVICIO Nº ") + q.value(0) + "     " + 
		util.translate("MetaData", "Fecha: ") + util.dateAMDtoDMA(q.value(1)) + "     " + 
		util.translate("MetaData", "TÉCNICO: ") + 
		q.value(5) + ", " + q.value(6);
		
	if (q.value(2) == "true")
		texto += "     " + util.translate("MetaData", "C. Mant");
		
	texto += "\n" +
		util.translate("MetaData", "DESCRIPCIÓN: ") +
		q.value(3) + "\n" +
		util.translate("MetaData", "SOLUCIÓN: ") +
		q.value(4);
	
	return texto;	
}

function funServiciosCli_datosClienteServicio(nodo:FLDomNode):String
{
	var util:FLUtil = new FLUtil();
	var codCliente:String = nodo.attributeValue("servicioscli.codcliente");
	
	var nomCliente:String = util.sqlSelect("clientes", "nombre", "codcliente = '" + codCliente + "'");
	
	if (!nomCliente)
		return "";
		
	return nomCliente;
}

//// FUN_SERVICIOS_CLI ///////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition articuloscomp */
/////////////////////////////////////////////////////////////////
//// ARTICULOSCOMP //////////////////////////////////////////////
function articuloscomp_crearTabla(tipoDoc:String,idDoc:Number):Boolean 
{
	var util:FLUtil = new FLUtil();
	var qLineas:FLSqlQuery = new FLSqlQuery();
	var tabla:String;
	var id:String;
	var referencia:String;
	
	util.sqlDelete("i_articuloscomp_buffer","1=1");
	
	switch(tipoDoc){
		case "FC":{
			tabla = "lineasfacturascli";
			id = "idfactura";
			break;
		}
		case "FP":{
			tabla = "lineasfacturasprov";
			id = "idfactura";
			break;
		}
		case "AC":{
			tabla = "lineasalbaranescli";
			id = "idalbaran";
			break;
		}
		case "AP":{
			tabla = "lineasalbaranesprov";
			id = "idalbaran";
			break;
		}
		case "PC":{
			tabla = "lineaspedidoscli";
			id = "idpedido";
			break;
		}
		case "PP":{
			tabla = "lineaspedidosprov";
			id = "idpedido";
			break;
		}
		case "PR":{
			tabla = "lineaspresupuestoscli";
			id = "idpresupuesto";
			break;
		}
		default: return false;
	}
	
	qLineas.setTablesList(tabla);
	qLineas.setSelect("referencia,idlinea,cantidad");
	qLineas.setFrom(tabla);
	qLineas.setWhere(id + " = '" + idDoc + "'");
	
	if(!qLineas.exec())
		return false;
			
	while (qLineas.next()) {
		referencia = qLineas.value(0);
		var q:FLSqlQuery = new FLSqlQuery();
		q.setTablesList("articuloscomp");
		q.setSelect("refcomponente,cantidad");
		q.setFrom("articuloscomp");
		q.setWhere("refcompuesto = '" + referencia + "'");
		
		if(!q.exec())
		return false;
			
		while (q.next()){
			var cantidad:Number = parseFloat(qLineas.value(2)) * parseFloat(q.value(1));
			if(!this.iface.crearLinea(q.value(0),cantidad,qLineas.value(1)))
				return false;
		}
	}
		
	return true;
}

function articuloscomp_crearLinea(refcomponente:String,cantidad:Number,idLinea:Number):Boolean
{
		var util:FLUtil = new FLUtil();
		var cantidad2:Number;
		
		var q:FLSqlQuery = new FLSqlQuery();
		q.setTablesList("articuloscomp");
		q.setSelect("refcomponente,cantidad,codunidad");
		q.setFrom("articuloscomp");
		q.setWhere("refcompuesto = '" + refcomponente + "'");
		
		if(!q.exec())
			return false;
		
		if(!q.first()){
			var curLinea:FLSqlCursor = new FLSqlCursor("i_articuloscomp_buffer");
			with(curLinea) {
				setModeAccess(Insert);
				refreshBuffer();
				setValueBuffer("idlinea", idLinea);
				setValueBuffer("referencia", refcomponente);
				setValueBuffer("descripcion", util.sqlSelect("articulos","descripcion","referencia = '" + refcomponente + "'"));
				setValueBuffer("cantidad", cantidad);
				setValueBuffer("codunidad", util.sqlSelect("articulos","codunidad","referencia = '" + refcomponente + "'"));
			}
			if (!curLinea.commitBuffer())
				return false; 
		} else	
			do {
				cantidad2 = cantidad * parseFloat(q.value(1));
				if(!this.iface.crearLinea(q.value(0), cantidad2, idLinea))
					return false;
			} while (q.next()); 
			
		return true;
}
//// ARTICULOSCOMP //////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition funNumAcomp */
/////////////////////////////////////////////////////////////////
//// FUN_NUM_ACOMP /////////////////////////////////////////////////

/** Para guardar el número de serie en el buffer
*/
function funNumAcomp_crearTabla(tipoDoc:String,idDoc:Number):Boolean 
{
	var util:FLUtil = new FLUtil();
	var qLineas:FLSqlQuery = new FLSqlQuery();
	var tabla:String;
	var id:String;
	var referencia:String;
	
	var curBuff:FLSqlCursor = new FLSqlCursor("i_articuloscomp_buffer");
	var numSerie:String;
	var idLinea:String;
	
	util.sqlDelete("i_articuloscomp_buffer","1=1");
	
	switch(tipoDoc){
		case "FC":{
			tabla = "lineasfacturascli";
			id = "idfactura";
			idLinea = "idlineafactura";
			break;
		}
		case "FP":{
			tabla = "lineasfacturasprov";
			id = "idfactura";
			break;
		}
		case "AC":{
			tabla = "lineasalbaranescli";
			id = "idalbaran";
			idLinea = "idlineaalbaran";
			break;
		}
		case "AP":{
			tabla = "lineasalbaranesprov";
			id = "idalbaran";
			break;
		}
		case "PC":{
			tabla = "lineaspedidoscli";
			id = "idpedido";
			break;
		}
		case "PP":{
			tabla = "lineaspedidosprov";
			id = "idpedido";
			break;
		}
		case "PR":{
			tabla = "lineaspresupuestoscli";
			id = "idpresupuesto";
			break;
		}
		default: return false;
	}
	
	qLineas.setTablesList(tabla);
	qLineas.setSelect("referencia,idlinea,cantidad");
	qLineas.setFrom(tabla);
	qLineas.setWhere(id + " = '" + idDoc + "'");
	
	if(!qLineas.exec())
		return false;
			
	while (qLineas.next()) {
		
		referencia = qLineas.value(0);
		var q:FLSqlQuery = new FLSqlQuery();
		q.setTablesList("articuloscomp");
		q.setSelect("refcomponente,cantidad");
		q.setFrom("articuloscomp");
		q.setWhere("refcompuesto = '" + referencia + "'");
		q.setOrderBy("refcomponente");
		
		if(!q.exec())
		return false;
			
		paso = 0;
		ultRef = "";
		
		while (q.next()){
		
			var cantidad:Number = parseFloat(qLineas.value(2)) * parseFloat(q.value(1));
			
			if(!this.iface.crearLinea(q.value(0),cantidad,qLineas.value(1)))
				return false;
		
			// Número de serie al buffer
			if (!idLinea)
				continue;
		
			if (ultRef != q.value(0)) {
				paso = 0;
				ultRef = q.value(0);
			}
			
			numSerie = util.sqlSelect(tabla + "ns", "numserie", idLinea + " = " + qLineas.value(1) + " AND referencia = '" + q.value(0) + "' ORDER BY numserie OFFSET " + paso);
			
			if (!numSerie) {
				paso++;
				continue;
			}
						
			curBuff.select("idlinea = " + qLineas.value(1) + " AND referencia = '" + q.value(0) + "' ORDER BY id");
			if (curBuff.seek(paso)) {
				curBuff.setModeAccess(curBuff.Edit);
				curBuff.refreshBuffer();
				curBuff.setValueBuffer("numserie", numSerie);
				curBuff.commitBuffer();
			}
		
			paso++;
		}
	}
		
	return true;
}

//// FUN_NUM_ACOMP /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition infoCliProv */
/////////////////////////////////////////////////////////////////
//// INFOCLIPROV //////////////////////////////////////////////////

function infoCliProv_cabeceraClientes(nodo:FLDomNode, campo:String):String
{
	var texCampo:String = new String(campo);

	var util:FLUtil = new FLUtil();

	var texto:String;
	var sep:String = "       ";

	var cri:Array = flfactppal.iface.pub_ejecutarQry("i_clientes", "descripcion,d_clientes_codcliente,h_clientes_codcliente,i_clientes_codagente,i_clientes_codgrupo,i_clientes_codserie,i_clientes_regimeniva,i_dirclientes_codpais","id = '" + this.iface.idInformeActual + "'");

	texto = " " + cri.descripcion + sep + sep;

	if (cri.d_clientes_codcliente || cri.h_clientes_codcliente)
		texto += util.translate("scripts","Clientes");
	
	if (cri.d_clientes_codcliente)		
		texto += " " + util.translate("scripts","desde") + " " + cri.d_clientes_codcliente;
	
	if (cri.h_clientes_codcliente)
		texto += " " + util.translate("scripts","hasta") + " " + cri.h_clientes_codcliente;

	if (cri.i_clientes_codagente)
		texto += sep + util.translate("scripts","Agente") + " " + cri.i_clientes_codagente;

	if (cri.i_clientes_codgrupo)
		texto += sep + util.translate("scripts","Grupo") + " " + cri.i_clientes_codgrupo;

	if (cri.i_clientes_codserie)	
		texto += sep + util.translate("scripts","Serie de facturación") + " " + cri.i_clientes_codserie;

	if (cri.i_clientes_regimeniva && cri.i_clientes_regimeniva != util.translate("scripts","Todos"))
		texto += sep + util.translate("scripts","Régimen I.V.A.") + " " + cri.i_clientes_regimeniva;

	if (cri.i_dirclientes_codpais)
		texto += sep + util.translate("scripts","País") + " " + cri.i_dirclientes_codpais;

	return texto;
}

function infoCliProv_cabeceraProveedores(nodo:FLDomNode, campo:String):String
{
	var texCampo:String = new String(campo);

	var util:FLUtil = new FLUtil();

	var texto:String;
	var sep:String = "       ";

	var cri:Array = flfactppal.iface.pub_ejecutarQry("i_proveedores", "descripcion,d_proveedores_codproveedor,h_proveedores_codproveedor,i_proveedores_codserie,i_proveedores_regimeniva,i_dirproveedores_codpais","id = '" + this.iface.idInformeActual + "'");

	texto = " " + cri.descripcion + sep + sep;

	if (cri.d_proveedores_codproveedor || cri.h_proveedores_codproveedor)
		texto += util.translate("scripts","Proveedores");
	
	if (cri.d_proveedores_codproveedor)		
		texto += " " + util.translate("scripts","desde") + " " + cri.d_proveedores_codproveedor;
	
	if (cri.h_proveedores_codproveedor)
		texto += " " + util.translate("scripts","hasta") + " " + cri.h_proveedores_codproveedor;

	if (cri.i_proveedores_codserie)	
		texto += sep + util.translate("scripts","Serie de facturación") + " " + cri.i_proveedores_codserie;

	if (cri.i_proveedores_regimeniva && cri.i_proveedores_regimeniva != util.translate("scripts","Todos"))
		texto += sep + util.translate("scripts","Régimen I.V.A.") + " " + cri.i_proveedores_regimeniva;

	if (cri.i_dirproveedores_codpais)
		texto += sep + util.translate("scripts","País") + " " + cri.i_dirproveedores_codpais;

	return texto;
}

/** \D Establece el id del informe que está siendo impreso
*/
function infoCliProv_establecerId(id:Number) 
{
	this.iface.idInformeActual = id;
}

//// INFOCLIPROV //////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition datos */
/////////////////////////////////////////////////////////////////
//// DATOS //////////////////////////////////////////////////////

function datos_obtenerCodigo(nodo:FLDomNode, campo:String):String
{
	var codigo:String = nodo.attributeValue(campo);
	if (!codigo || codigo == "")
		return "";

	var util:FLUtil = new FLUtil;

	var tabla:Array = campo.split(".");
	var partesCodigo:Array = codigo.split("-");

	var serie:String = util.sqlSelect("series", "serie", "codserie = '" + partesCodigo[1] + "'");
	var puntoVenta:String = util.sqlSelect("series", "puntoventa", "codserie = '" + partesCodigo[1] + "'");
	var numero:String = partesCodigo[2];

	var prefijo:String = "";
	var sufijo:String = "";

	switch (tabla[0]) {
		case "reciboscli": {
			var idFactura:Number = nodo.attributeValue("reciboscli.idfactura");
			var qryTipoFactura:FLSqlQuery = new FLSqlQuery();
			with (qryTipoFactura) {
				setTablesList("facturascli");
				setSelect("decredito,dedebito");
				setFrom("facturascli");
				setWhere("idfactura = " + idFactura);
			}
			if (!qryTipoFactura.exec() || !qryTipoFactura.first()) {
				prefijo = "#";
				break;
			}

			if (qryTipoFactura.value(0))
				prefijo = "C ";
			else if (qryTipoFactura.value(1))
				prefijo = "D ";
			else
				prefijo = "F ";

			sufijo = " / " + partesCodigo[3];

			break;
		}
		case "facturascli": {
			if (nodo.attributeValue("facturascli.decredito") == "true")
				prefijo = "C ";
			else if (nodo.attributeValue("facturascli.dedebito") == "true")
				prefijo = "D ";
			else
				prefijo = "F ";

			break;
		}
		break;
	}

	var nuevoCodigo:String = prefijo + serie + " " + puntoVenta + "-" + numero + sufijo;

	return nuevoCodigo;
}

//// DATOS //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////