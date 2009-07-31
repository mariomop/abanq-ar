/***************************************************************************
                             fldatosppal.qs
                            -------------------
   begin                : lun dic 13 2004
   copyright            : (C) 2004-2005 by InfoSiAL S.L.
   email                : mail@infosial.com
***************************************************************************/
/***************************************************************************
 *   This program is free software; you can redistribute it and/or modify  *
 *   it under the terms of the GNU General Public License as published by  *
 *   the Free Software Foundation; version 2 of the License.               *
 ***************************************************************************/ 
/***************************************************************************
   Este  programa es software libre. Puede redistribuirlo y/o modificarlo
   bajo  los  términos  de  la  Licencia  Pública General de GNU   en  su
   versión 2, publicada  por  la  Free  Software Foundation.
 ***************************************************************************/

/** @file */

////////////////////////////////////////////////////////////////////////////
//// DECLARACION ///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_declaration interna */
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
	var sep:String = "ð";
	var registrosEliminados:Number;
	var myUtil:FLUtil = new FLUtil();
    function oficial( context ) { interna( context ); } 
	function ejecutarQry( tabla, campos, where, listaTablas ):Array { return this.ctx.oficial_ejecutarQry( tabla, campos, where, listaTablas ); }
	function datoCampo( tipo, datoValor, datoFichero, linea ):String { return this.ctx.oficial_datoCampo( tipo, datoValor, datoFichero, linea ); }
	function vaciarTabla(tabla, progress, checkI, forzarDelLocks) { return this.ctx.oficial_vaciarTabla(tabla, progress, checkI, forzarDelLocks); }
	function comprobarLocks(tabla, forzarDelLocks) { return this.ctx.oficial_comprobarLocks(tabla, forzarDelLocks); }
	function numLineas(file) { return this.ctx.oficial_numLineas(file); }
	function lineasTablas(listaTablas, dir) { return this.ctx.oficial_lineasTablas(listaTablas, dir) ;}
	function crearProgress(label, numPasos) { return this.ctx.oficial_crearProgress(label, numPasos) ;}
	function setProgress(valor)  { return this.ctx.oficial_setProgress(valor) ;}
	function destroyProgress()  { return this.ctx.oficial_destroyProgress() ;}
	function numRegistros(listaTablas):Number  { return this.ctx.oficial_numRegistros(listaTablas) ;}
	function cerosIzquierda(numero, totalCifras):String { return this.ctx.oficial_cerosIzquierda(numero, totalCifras) ;}
	function ejercicioDefecto():String  { return this.ctx.oficial_ejercicioDefecto() ;}
	function serieDefecto():String  { return this.ctx.oficial_serieDefecto() ;}
	function provincia(codProvincia):String { return this.ctx.oficial_provincia(codProvincia) ;}
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
	function pub_ejecutarQry( tabla, campos, where, listaTablas ):Array { return this.ejecutarQry( tabla, campos, where, listaTablas ); }
	function pub_datoCampo( tipo, datoValor, datoFichero, linea ):String { return this.datoCampo( tipo, datoValor, datoFichero, linea ); }
	function pub_vaciarTabla(tabla, progress, checkI, forzarDelLocks) { return this.vaciarTabla(tabla, progress, checkI, forzarDelLocks); }
	function pub_numLineas(file) { return this.numLineas(file); }
	function pub_lineasTablas(listaTablas, dir) { return this.lineasTablas(listaTablas, dir) ;}
	function pub_crearProgress(label, numPasos) { return this.crearProgress(label, numPasos) ;}
	function pub_setProgress(valor)  { return this.setProgress(valor) ;}
	function pub_destroyProgress()  { return this.destroyProgress() ;}
	function pub_numRegistros(listaTablas):Number  { return this.numRegistros(listaTablas) ;}
	function pub_cerosIzquierda(numero, totalCifras):String { return this.cerosIzquierda(numero, totalCifras) ;}
	function pub_ejercicioDefecto():String  { return this.ejercicioDefecto() ;}
	function pub_serieDefecto():String  { return this.serieDefecto() ;}
	function pub_provincia(codProvincia):String { return this.provincia(codProvincia) ;}
}

const iface = new ifaceCtx( this );
//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_definition interna */
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////

function init() {
    this.iface.init();
}

function interna_init() {
	var util:FLUtil = new FLUtil();
	util.writeSettingEntry("Geometry/fldatosppal/Maximized", "true");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

// Ejecuta la query especificada y devuelve un array con los
// datos de los campos seleccionados
// Devuelve un campo extra 'result' que es 1 = Ok, 0 = Error, -1 No encontrado
function oficial_ejecutarQry( tabla, campos, where, listaTablas ):Array 
{
	var campo:Array = campos.split( "," );
	var valor:Array = [];
	valor[ "result" ] = 1;
	var query:FLSqlQuery = new FLSqlQuery();
	if ( listaTablas )
		query.setTablesList( listaTablas );
	else
		query.setTablesList( tabla );
	query.setSelect( campo );
	query.setFrom( tabla );
	query.setWhere( where + ";" );
	if ( query.exec() ) {
		if ( query.next() ) {
			for ( var i = 0; i < campo.length; i++ ) {
				valor[ campo[ i ] ] = query.value( i );
			}
		} else {
			valor.result = -1;
		}
	} else {
		MessageBox.critical
		( this.iface.myUtil.translate( "scripts", "Falló la consulta" ) + query.sql(),
		  MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		valor.result = 0;
	}

	return valor;
}

function oficial_datoCampo( tipo, datoValor, datoFichero, linea ):String
{
	var valor:String;

	var argumentos:String = "";
	for ( i = 0; i < linea.length - 1; i++ ) {
		argumentos = argumentos + linea[ i ] + this.iface.sep;
	}
	argumentos = argumentos + linea[ i ];
	
	switch ( tipo ) {

	case "valor":
		valor = datoValor;
		break;

	case "funcion":
		var codigoFuncion:String = this.iface.ejecutarQry( "dat_funciones", "codigo",
		                                 "id = '" + datoValor + "'", "dat_funciones" );
		codigoFuncion = codigoFuncion[ "codigo" ];
		var funcion = new Function( codigoFuncion );
		valor = funcion( argumentos );
		break;

	default:
		valor = datoFichero;
	}
	return valor;
}


function oficial_vaciarTabla(tabla, progress, checkI, forzarDelLocks)
{
	this.iface.comprobarLocks(tabla, forzarDelLocks);
	
	var curTabla:FLSqlCursor = new FLSqlCursor(tabla);
	var seguir:Boolean = false;

	curTabla.select();
 	curTabla.setActivatedCheckIntegrity(checkI);
	
	this.iface.myUtil.setLabelText(this.iface.myUtil.translate( "scripts", "Vaciando tabla ") + tabla.toUpperCase() + this.iface.myUtil.translate( "scripts", "\n\nProgreso total:"));
	
	while ( curTabla.next() ) {
	
		curTabla.setModeAccess( curTabla.Del );		
		curTabla.refreshBuffer();
		if (!curTabla.commitBuffer() && !seguir)  {
			var res = MessageBox.critical( this.iface.myUtil.translate( "scripts", "Hubo un problema al eliminar los registros de la tabla ") + tabla.toUpperCase() + this.iface.myUtil.translate( "scripts", "\n¿Continuar la eliminación de datos de esta tabla?\n\nEste mensaje no se repetirá para esta tabla. Pulse cancelar para detener todo el proceso" ), MessageBox.No, MessageBox.Yes, MessageBox.Cancel );
			
			if ( res == MessageBox.Cancel )
				return "cancel";
			if ( res != MessageBox.Yes )
				return false;
			else
				seguir = true;
		}
		this.iface.myUtil.setProgress( this.iface.registrosEliminados++ );
	}
	
	curTabla.setActivatedCheckIntegrity(true);
}

function oficial_comprobarLocks(tabla, forzarDelLocks)
{
	var contenido:String = this.iface.myUtil.sqlSelect( "flfiles", "contenido", "nombre = '" + tabla + ".mtd'" );
	var campoUnLock:String = "";
	var campoPK:String = "";
	
	xmlTabla = new FLDomDocument();
	xmlTabla.setContent(contenido);
	
	var listaCampos:Array = xmlTabla.elementsByTagName("field");
	for (var i = 0; i < listaCampos.length(); i++) {
	
		nodoCampo = listaCampos.item(i);

		if (nodoCampo.namedItem("type")) 
			if (nodoCampo.namedItem("type").toElement().text() == "unlock") 
				campoUnLock = nodoCampo.namedItem("name").toElement().text();	
				
		if (nodoCampo.namedItem("pk")) 
			if (nodoCampo.namedItem("pk").toElement().text() == "true") 
				campoPK = nodoCampo.namedItem("name").toElement().text();	
	}
	
	if (campoUnLock != "") {
	
		if (!forzarDelLocks) {
			var res = MessageBox.critical( this.iface.myUtil.translate( "scripts", "La tabla " ) + tabla.toUpperCase() + this.iface.myUtil.translate( "scripts", " puede contener algunos registros bloqueados.\n¿Desea forzar la eliminación de todos los registros?" ), MessageBox.No, MessageBox.Yes, MessageBox.NoButton );
			
			if ( res != MessageBox.Yes )
				return;
		}
		
		var curTabla:FLSqlCursor = new FLSqlCursor(tabla);
		var curTablaUnLock:FLSqlCursor;
		
		curTabla.select(campoUnLock + " = false");
		while ( curTabla.next() ) {
			
			curTabla.setModeAccess( curTabla.Browse );			
			curTabla.refreshBuffer();
			
			curTablaUnLock = new FLSqlCursor(tabla);
			curTablaUnLock.select(campoPK + " = '" + curTabla.valueBuffer(campoPK) + "'");
			
			curTablaUnLock.first();
			curTablaUnLock.setModeAccess( curTabla.Edit );			
			curTablaUnLock.refreshBuffer();
 			curTablaUnLock.setUnLock(campoUnLock, true);
			
		}
	}
}


function oficial_numLineas(file)
{
	try {
		file.open( File.ReadOnly );
	}
	catch (e) {
		debug(e);
		var res = MessageBox.warning( this.iface.myUtil.translate( "scripts", "Imposible leer los datos del fichero ") + file.name + this.iface.myUtil.translate( "scripts", "\n\nSi la tabla correspondiente a este fichero debe ser importada, compruebe\nque la ruta es válida y que los permisos de lectura son correctos\n\n¿Continuar la importación?"), MessageBox.No, MessageBox.Yes, MessageBox.NoButton );
		if ( res != MessageBox.Yes )
			return "error";
		else
			return 0;
	}
	
	var lineas:Number = 0;
	while ( !file.eof ) {
		file.readLine();
		lineas++;
	}
	
	file.close();
	
	return lineas - 1;
}

// Devuelve el total de líneas de los ficheros a importar para un conjunto de tablas
// Usado en los progressDialog
function oficial_lineasTablas(listaTablas, dir)
{
	var numLineasF:Number;
	var numLineasT:Number = 0;
	var file;
	
	for (var i = 0; i < listaTablas.length; i++) {
		file = new File(dir + listaTablas[i] + ".csv");
		numLineasF = this.iface.numLineas(file);
		
		if (numLineasF != "error") 
			numLineasT += numLineasF;
		else 
			return "error";
	}
	return numLineasT;
}

// Devuelve el total de líneas de los ficheros a importar para un conjunto de tablas
// Usado en los progressDialog
function oficial_numRegistros(listaTablas):Number
{
	var numRegistrosT:Number = 0;
	
	for (var i = 0; i < listaTablas.length; i++) {
		numRegistrosT += this.iface.myUtil.sqlSelect( listaTablas[i], "count(*)", "1=1" );
	}
	
	return numRegistrosT;
}

// Pone el contador de líneas importadas a cero y crea el progressDialog
function oficial_crearProgress(label, numPasos)
{
	this.iface.myUtil.createProgressDialog( label, numPasos );
	this.iface.registrosEliminados = 0;
}

function oficial_setProgress(valor)
{
	this.iface.myUtil.setProgress( valor );
}

function oficial_destroyProgress()
{
	this.iface.myUtil.destroyProgressDialog();
}

function oficial_cerosIzquierda(numero:String, totalCifras:Number):String
{
	var i:Number, j:Number;
	var valor:String = numero;
	for (i = 0; (numero.toString().charAt(i)); i++);
	if (i < totalCifras)
			for (j = i; j < totalCifras; j++)
					valor = "0" + valor;
	return valor;
}

function oficial_ejercicioDefecto():String
{
	var util:FLUtil = new FLUtil();
	return util.sqlSelect("empresa", "codejercicio", "1=1");
}

function oficial_serieDefecto():String
{
	var util:FLUtil = new FLUtil();
	return util.sqlSelect("empresa", "codserie", "1=1");
}

function oficial_provincia(codProvincia):String
{
	var prov:Array = new Array;
	
	prov["0001"]="Alava";
	prov["0002"]="Albacete";
	prov["0003"]="Alicante";
	prov["0004"]="Almería";
	prov["0005"]="Avila";
	prov["0006"]="Badajoz";
	prov["0007"]="Baleares";
	prov["0008"]="Barcelona";
	prov["0009"]="Burgos";
	prov["0010"]="Cáceres";
	prov["0011"]="Cadiz";
	prov["0012"]="Castellón";
	prov["0013"]="Ciudad - Real";
	prov["0014"]="Córdoba";
	prov["0015"]="La Coruña";
	prov["0016"]="Cuenca";
	prov["0017"]="Gerona";
	prov["0018"]="Granada";
	prov["0019"]="Guadalajara";
	prov["0020"]="Guipuzcoa";
	prov["0021"]="Huelva";
	prov["0022"]="Huesca";
	prov["0023"]="Jaén";
	prov["0024"]="León";
	prov["0025"]="Lerida";
	prov["0026"]="La Rioja";
	prov["0027"]="Lugo";
	prov["0028"]="Madrid";
	prov["0029"]="Málaga";
	prov["0030"]="Murcia";
	prov["0031"]="Pamplona";
	prov["0032"]="Orense";
	prov["0033"]="Oviedo";
	prov["0034"]="Palencia";
	prov["0035"]="Gran Canaria";
	prov["0036"]="Pontevedra";
	prov["0037"]="Salamanca";
	prov["0038"]="Sta Cruz de Tenerife";
	prov["0039"]="Santander";
	prov["0040"]="Segovia";
	prov["0041"]="Sevilla";
	prov["0042"]="Soria";
	prov["0043"]="Tarragona";
	prov["0044"]="Teruel";
	prov["0045"]="Toledo";
	prov["0046"]="Valencia";
	prov["0047"]="Valladolid";
	prov["0048"]="Vizcaya";
	prov["0049"]="Zamora";
	prov["0050"]="Zaragoza";
	prov["0051"]="Ceuta";
	prov["0052"]="Melilla";
	
	if (codProvincia > "0000" && codProvincia < "0052") return prov[codProvincia];
	return "";
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////