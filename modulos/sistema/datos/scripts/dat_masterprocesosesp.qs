/***************************************************************************
                          dat_masterprocesosesp.qs
                            -------------------
   begin                : jue ene 20 2005
   copyright            : (C) 2005 by InfoSiAL S.L.
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
    function oficial( context ) { interna( context ); } 
	function ejecutarFuncion() { return this.ctx.oficial_ejecutarFuncion(); }
	function generarCSVs() { return this.ctx.oficial_generarCSVs();}
	function crearFicheroAsientos() { return this.ctx.oficial_crearFicheroAsientos();}
	function crearFicheroPC_Sub() { return this.ctx.oficial_crearFicheroPC_Sub();}
	function crearFicheroPC_SubCOD() { return this.ctx.oficial_crearFicheroPC_SubCOD();}
	function actualizarSubcuentas() { return this.ctx.oficial_actualizarSubcuentas();}
	function actualizarNumerosFacturacion() { return this.ctx.oficial_actualizarNumerosFacturacion();}
	function actualizarValoresFacturacion() { return this.ctx.oficial_actualizarValoresFacturacion() ;}
	function actualizarValorFacturacion(tabla, tablaLineas, campoID, msg) { return this.ctx.oficial_actualizarValorFacturacion(tabla, tablaLineas, campoID, msg) ;}
	function actualizarSecuencia(tablaOrigen, campoSecuencia, ejercicio, codSerie) { return this.ctx.oficial_actualizarSecuencia(tablaOrigen, campoSecuencia, ejercicio, codSerie);}
	function actualizarIVA(tipoTabla, msg) { return this.ctx.oficial_actualizarIVA(tipoTabla, msg);}
	function actualizarLineasIva(tipoTabla, idFactura) { return this.ctx.oficial_actualizarLineasIva(tipoTabla, idFactura);}
	function procesarPlazosPago() { return this.ctx.oficial_procesarPlazosPago();}
	function procesarComentarios() { return this.ctx.oficial_procesarComentarios(); }
	function comentariosTabla(ficheroCSV, tabla, indCampoClaveF, indCampoComF, campoClaveT, campoComT, esFacturacion) { return this.ctx.oficial_comentariosTabla(ficheroCSV, tabla, indCampoClaveF, indCampoComF, campoClaveT, campoComT, esFacturacion); }
	function codigoFacturacion(tabla, campos) {return this.ctx.oficial_codigoFacturacion(tabla, campos) ;}
	function crearFicheroRappels() { return this.ctx.oficial_crearFicheroRappels();}
	function completarBancos() { return this.ctx.oficial_completarBancos();}
	function completarBancosTabla(fichero, indCampoEntidad, indCampoNombre):Number { return this.ctx.oficial_completarBancosTabla(fichero, indCampoEntidad, indCampoNombre);}
	function actualizarSaldos() { return this.ctx.oficial_actualizarSaldos();}
	function completarFyR() { return this.ctx.oficial_completarFyR();}
	function completarFacturas() { return this.ctx.oficial_completarFacturas();}
	function completarRecibos() { return this.ctx.oficial_completarRecibos();}
	function actualizarSubcuentasCli() { return this.ctx.oficial_actualizarSubcuentasCli();}
	function actualizarSubcuentasProv() { return this.ctx.oficial_actualizarSubcuentasProv();}
	function trocearFichero() { return this.ctx.oficial_trocearFichero();}
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

////////////////////////////////////////////////////////////////////////////
//// DEFINICION ////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////

/** @class_definition interna */
//////////////////////////////////////////////////////////////////
//// INTERNA /////////////////////////////////////////////////////

function init() {
    this.iface.init();
}

/** \C 
Los procesos especiales son procesos QSA independientes definidos dentro del código
del presente script (dat_masterprocesosesp.qs). Estos procesos realizan tareas diversas
que son necesarias a la hora de realizar grandes procesos de migración de datos; algunos
realizan conversión masiva de ficheros DBF a CSV, otros obtienen un fichero CSV de 
asientos a partir de un fichero de diario, etc.

Generalmente estos procesos son característicos de determinadas aplicaciones de las cuales
FacturaLUX importa los datos. Para el uso de estos procesos especiales, remitirse a la 
guía de importación correspondiente.
\end */
function interna_init() {
	connect( this.child( "pbnEjecutar" ), "clicked()", this, "iface.ejecutarFuncion" );
	connect(this.child("tableDBRecords"), "currentChanged()", this.child("tableDBRecords"), "refresh()");
}
//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////


/** \D Lanza la ejecución de la función cuyo registro está seleccionado en el
formulario maestro
\end */
function oficial_ejecutarFuncion()
{
	var util:FLUtil = new FLUtil();
	var funcion:String = this.cursor().valueBuffer( "funcion" ).toString();
	
	switch ( funcion ) {

		case "generarCSVs": {
				this.iface.generarCSVs();
				break;
		}
		
		case "crearFicheroAsientos": {
				this.iface.crearFicheroAsientos();
				break;
		}
		
		case "actualizarSubcuentas": {
				this.iface.actualizarSubcuentas();
				break;
		}
		
		case "actualizarNumerosFacturacion": {
				this.iface.actualizarNumerosFacturacion();
				break;
		}
		
		case "actualizarValoresFacturacion": {
				this.iface.actualizarValoresFacturacion();
				break;
		}
		
		case "procesarPlazosPago": {
				this.iface.procesarPlazosPago();
				break;
		}
		
		case "procesarComentarios": {
				this.iface.procesarComentarios();
				break;
		}
		
		case "crearFicheroRappels": {
				this.iface.crearFicheroRappels();
				break;
		}
		
		case "completarBancos": {
				this.iface.completarBancos();
				break;
		}
		
		case "actualizarSaldos": {
				this.iface.actualizarSaldos();
				break;
		}
		
		case "completarFyR": {
				this.iface.completarFyR();
				break;
		}
		
		case "crearFicheroPC_Sub": {
				this.iface.crearFicheroPC_Sub();
				break;
		}
		
		case "crearFicheroPC_SubCOD": {
				this.iface.crearFicheroPC_SubCOD();
				break;
		}
		
		case "actualizarSubcuentasCli": {
				this.iface.actualizarSubcuentasCli();
				break;
		}
		
		case "actualizarSubcuentasProv": {
				this.iface.actualizarSubcuentasProv();
				break;
		}
		
		case "trocearFichero": {
				this.iface.trocearFichero();
				break;
		}		
		    
		default:
			MessageBox.warning( util.translate( "scripts", "La función seleccionada no existe"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
	}
}

/** \D Genera los ficheros CSV a partir de los originales dbf. En el directorio de datos
de origen busca todos los que tienen extensión dbf y los convierte uno por uno a formato
csv mediante el script 'dbf' contenido en el fichero bin de la instalación de FacturaLUX
\end */
function oficial_generarCSVs()
{
	var util:FLUtil = new FLUtil();
	
	var rutaDatos:String = util.sqlSelect("dat_opciones", "rutaDatos", "");
	if (!File.isDir(rutaDatos)) {
		MessageBox.warning( util.translate( "scripts", "La ruta de datos no ha sido establecida\nPuedes hacerlo en el formulario de ficheros"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return 0;
	}
	
	var dir = new Dir(rutaDatos);
	var listaDBF = dir.entryList("*.dbf;*.DBF");
	
	var ficheroCSV:String;
	var ficheroDBF:String;
	var arg0:String;
	var arg1:String;
	var arg2:String;
	var arg3:String;
	var F;
	
	util.createProgressDialog( util.translate( "scripts",
							"Creando ficheros CSV..." ), listaDBF.length );
	util.setProgress(1);
	var paso:Number = 0;
	var pasoF:Number = 0;
	
	for (var i = 0; i < listaDBF.length; ++i) {
		
		ficheroDBF = rutaDatos + listaDBF[i];
		F = new File(ficheroDBF);
		ficheroCSV = rutaDatos + "/" + F.baseName.lower() + ".csv";
		ficheroCSV = ficheroCSV;
		
		if (File.exists(ficheroCSV)) continue;
		pasoF++;
		
		util.setProgress(paso++);
		util.setLabelText(util.translate( "scripts", "Convirtiendo fichero %1 a CSV...").arg(F.baseName));
		
		arg0 = sys.installPrefix() + "/bin/dbf";
		arg1 = " --csv " + ficheroCSV;
		arg2 = " --separator " + this.iface.sep + " ";
		arg3 = ficheroDBF;
	
		debug(arg0 + arg1 + arg2 + arg3);
		
		Process.execute( arg0 + arg1 + arg2 + arg3 );

	}
	util.destroyProgressDialog();

	MessageBox.information ( util.translate( "scripts", "Proceso finalizado. Ficheros creados: " + pasoF), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}

/** \D Los asientos procedentes de contaplus se encuentran dentro del fichero de diario,
que contiene las partidas. Esta función recorre ese fichero y crea un nuevo fichero
sólo con datos de los asientos, que serán importados en el proceso correspondiente.
\end */
function oficial_crearFicheroAsientos()
{
	var util:FLUtil = new FLUtil();

	var rutaDatos:String = util.sqlSelect("dat_opciones", "rutaDatos", "");
	var fichero = rutaDatos + "diario.csv";
	if (!File.exists(fichero)) {
		MessageBox.warning( util.translate( "scripts", "No existe el fichero ") + fichero, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return 0;
	}
	
	var fichDiario = new File( fichero );
	var numLineas = fldatosppal.iface.pub_numLineas(fichDiario);
	
	if (!numLineas) return;
	
	var fichAsientos = new File( fichDiario.path + "/asientos.csv" );
	
	try {
		fichAsientos.open( File.WriteOnly );
	}
	catch (e) {
		MessageBox.warning( util.translate( "scripts", "Imposible abrir el fichero ") + fichAsientos.name + util.translate( "scripts", " para escritura\nCompruebe que la ruta es válida y que los permisos de escritura son correctos"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return false;
	}
	
	var linea:String = "";
	var campos:Array;
	var numAsiento:Number;
	var lastNumAsiento:Number = -1;
	var paso:Number = 0;
	var pasoA:Number = 0;
	
	util.createProgressDialog( util.translate( "scripts",
							"Creando fichero de asientos..." ), numLineas );
	util.setProgress(1);
							
	fichDiario.open( File.ReadOnly );
	if ( !fichDiario.eof )
			linea = fichDiario.readLine();
	fichAsientos.write(linea, linea.length);
	
	while ( !fichDiario.eof ) {
	
		linea = fichDiario.readLine();
		campos = linea.split(this.iface.sep);
		numAsiento = campos[0];
		
		if (numAsiento != lastNumAsiento) {
			lastNumAsiento = numAsiento;
			fichAsientos.write(linea, linea.length);
			pasoA++;
		}
		
		util.setProgress(paso++);
	}
	
	util.destroyProgressDialog();

	fichDiario.close();
	fichAsientos.close();
		
	MessageBox.information ( util.translate( "scripts", "Proceso finalizado. Asientos registrados: ") + pasoA + 
			util.translate( "scripts", "\n\nFichero de asientos creado:\n") + fichAsientos.fullName,
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
}

/** \D Una vez importadas las subcuentas y, a continuación generado el PGC, este proceso
actualiza los campos idcuenta de las subcuentas, que hasta ese momento estaban vacíos
\end */
function oficial_actualizarSubcuentas()
{
	var util:FLUtil = new FLUtil();
	
	var curCuenta:FLSqlCursor = new FLSqlCursor("co_subcuentas");
	var idCuenta:Number;	
	var codCuenta:String;
	var codEjercicio:String;
	var paso:Number = 0;
	
	var numSubcuentas:Number = util.sqlSelect("co_subcuentas", "count(idsubcuenta)", "idcuenta is null");
	
	if (numSubcuentas == 0) {
		MessageBox.information ( util.translate( "scripts", "No hay subcuentas para actualizar. No es necesario este proceso"),
				MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
			
	util.createProgressDialog( util.translate( "scripts", "Actualizando subcuentas..." ), numSubcuentas );
	util.setProgress(1);
	
	curCuenta.select("idcuenta is null");
	while (curCuenta.next()) {
		curCuenta.setModeAccess(curCuenta.Edit);
		curCuenta.refreshBuffer();
		codCuenta = curCuenta.valueBuffer("codcuenta");
		codEjercicio = curCuenta.valueBuffer("codejercicio");
		idCuenta = util.sqlSelect("co_cuentas", "idcuenta", "codcuenta = '" + codCuenta + "' AND codejercicio = '" + codEjercicio + "'");
		curCuenta.setValueBuffer("idcuenta", idCuenta);
 		curCuenta.commitBuffer();
		util.setProgress(paso++);
	}
	
	util.destroyProgressDialog();
	MessageBox.information ( util.translate( "scripts", "Proceso finalizado. Subcuentas actualizadas: ") + paso,
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
}

/** \D Actualiza las secuencias por serie según la facturación importada, a fin de que
se pueda seguir facturando
\end */
function oficial_actualizarNumerosFacturacion()
{
	var util:FLUtil = new FLUtil();
	var ejercicio:String = fldatosppal.iface.pub_ejercicioDefecto();
	var codSerie:String;
	var qSerie:FLSqlQuery = new FLSqlQuery();
	qSerie.setTablesList("series");
	qSerie.setFrom("series");
	qSerie.setSelect("codserie");
	if (!qSerie.exec()) return;
	
	while (qSerie.next()) {
		codSerie = qSerie.value(0);
		this.iface.actualizarSecuencia("presupuestoscli", "npresupuestocli", ejercicio, codSerie);
		this.iface.actualizarSecuencia("pedidoscli", "npedidocli", ejercicio, codSerie);
		this.iface.actualizarSecuencia("albaranescli", "nalbarancli", ejercicio, codSerie);
		this.iface.actualizarSecuencia("facturascli", "nfacturacli", ejercicio, codSerie);
		this.iface.actualizarSecuencia("pedidosprov", "npedidoprov", ejercicio, codSerie);
		this.iface.actualizarSecuencia("albaranesprov", "nalbaranprov", ejercicio, codSerie);
		this.iface.actualizarSecuencia("facturasprov", "nfacturaprov", ejercicio, codSerie);
	}
	MessageBox.information ( util.translate( "scripts", "Proceso finalizado. Actualizadas las series del ejercicio ") + ejercicio,
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
}

/** \D Actualiza una secuencia por serie de una tabla
@param tablaOrigen Nombre de la tabla de facturación cuya secuencia hay que actualizar
@param campoSecuencia Nombre del campo de la tabla que contiene la secuencia
@param ejercicio Ejercicio sobre el que se realiza la actualización
@param codSerie Serie de facturación sobre la que se realiza la actualización
\end */
function oficial_actualizarSecuencia(tablaOrigen, campoSecuencia, ejercicio, codSerie)
{
	var util:FLUtil = new FLUtil();
	var q:FLSqlQuery = new FLSqlQuery();
	
	var maxNumero:Number = -1;
	var actual:Number;
		
	q.setTablesList(tablaOrigen);
	q.setFrom(tablaOrigen);
	q.setSelect("numero");
	q.setWhere("codSerie ='" + codSerie + "'");
	if (!q.exec()) return;
	
	while (q.next()) {
		actual = parseInt(q.value(0));
		if (actual > maxNumero) maxNumero = actual;
	}
	if (maxNumero == -1) return;
	
	
	var curSec:FLSqlCursor = new FLSqlCursor("secuenciasejercicios");
	curSec.select("codEjercicio = '" + ejercicio + "' AND codserie = '" + codSerie + "'");
	if (curSec.first()) {
		curSec.setModeAccess(curSec.Edit);
		curSec.refreshBuffer();
		curSec.setValueBuffer(campoSecuencia, maxNumero + 1);
		curSec.commitBuffer();
	}
}

/** \D Recalcula los campos de total en la facturación después de haberse
importado las líneas, y crea las líneas de IVA en las facturas
\end */
function oficial_actualizarValoresFacturacion()
{
	var util:FLUtil = new FLUtil();
	this.iface.actualizarValorFacturacion("presupuestoscli", "lineaspresupuestoscli", "idpresupuesto", util.translate( "scripts","Presupuestos de Cliente"));
	this.iface.actualizarValorFacturacion("pedidoscli", "lineaspedidoscli", "idpedido", util.translate( "scripts","Pedidos de Cliente"));
	this.iface.actualizarValorFacturacion("pedidosprov", "lineaspedidosprov", "idpedido", util.translate( "scripts","Pedidos de Proveedor"));
	this.iface.actualizarValorFacturacion("albaranescli", "lineasalbaranescli", "idalbaran", util.translate( "scripts","Albaranes de Cliente"));
	this.iface.actualizarValorFacturacion("albaranesprov", "lineasalbaranesprov", "idalbaran", util.translate( "scripts","Albaranes de Proveedor"));
	this.iface.actualizarValorFacturacion("facturascli", "lineasfacturascli", "idfactura", util.translate( "scripts","Facturas de Cliente"));
 	this.iface.actualizarValorFacturacion("facturasprov", "lineasfacturasprov", "idfactura", util.translate( "scripts","Facturas de Proveedor"));
	
	this.iface.actualizarIVA("cli", util.translate( "scripts","I.V.A. en facturas de Cliente"));
	this.iface.actualizarIVA("prov", util.translate( "scripts","I.V.A. en facturas de Proveedor"));
	
	MessageBox.information ( util.translate( "scripts", "Proceso finalizado"),
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
}

/** \D Actualiza los valores de totales de facturación
@param tabla Nombre de la tabla: facturascli, pedidoscli...
@param tablaLineas Nombre de la tabla de líneas correspondiente
@param campoID Nombre del campo clave de la tabla
@param msg Mensaje que aparecerá en la barra de progreso
\end */
function oficial_actualizarValorFacturacion(tabla, tablaLineas, campoID, msg)
{
	var util:FLUtil = new FLUtil();
	
	var numDocs:Number = util.sqlSelect( tabla, "count(*)", "");
	util.createProgressDialog( util.translate( "scripts",
							"Procesando ") + msg + "...", numDocs );
	util.setProgress(1);
	var paso:Number = 0;
	
	var curTabla:FLSqlCursor = new FLSqlCursor(tabla);
	var total:Number;
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList(tablaLineas);
	q.setFrom(tablaLineas);
	q.setSelect("SUM(pvptotal), SUM(pvptotal*iva/100)");
	
	curTabla.setActivatedCommitActions(false);
	curTabla.select();
	while (curTabla.next()) {
		q.setWhere(campoID + " = " + curTabla.valueBuffer(campoID))
		if (!q.exec()) continue;
		if (!q.first()) continue;
		
		curTabla.setModeAccess(curTabla.Edit);
		curTabla.refreshBuffer();
		curTabla.setValueBuffer("neto", q.value(0));
		curTabla.setValueBuffer("totaliva", q.value(1));
	 	total = q.value(0) + q.value(1);
		curTabla.setValueBuffer("total", total);
		curTabla.setValueBuffer("totaleuros", total * parseFloat(curTabla.valueBuffer("tasaconv")));
		
		curTabla.commitBuffer();
		
		util.setProgress(paso++);
	}
	
	util.destroyProgressDialog();
	curTabla.setActivatedCommitActions(true);
}

/** \D Recorre una tabla de facturas para is creando las líneas de IVA
@param tipoTabla Valores cli (cliente) o prov (proveedor)
@param msg Mensaje que aparecerá en la barra de progreso
\end */
function oficial_actualizarIVA(tipoTabla, msg)
{
	var util:FLUtil = new FLUtil();
	
	var tabla:String = "facturas" + tipoTabla;
	
	var codEjercicio:String = fldatosppal.iface.pub_ejercicioDefecto();
	var numDocs:Number = util.sqlSelect( tabla, "count(*)", "codejercicio = '" + codEjercicio + "'");
	util.createProgressDialog( util.translate( "scripts",
							"Procesando ") + msg + "...", numDocs );
	util.setProgress(1);
	var paso:Number = 0;
	
	var curTabla:FLSqlCursor = new FLSqlCursor(tabla);
	var total:Number;
	
	curTabla.setActivatedCommitActions(false);
	curTabla.select("codejercicio = '" + codEjercicio + "'");
	while (curTabla.next()) {
		this.iface.actualizarLineasIva(tipoTabla, curTabla.valueBuffer("idfactura"));
		util.setProgress(paso++);
	}
	
	util.destroyProgressDialog();
	curTabla.setActivatedCommitActions(true);
}

/** \D Crea las líneas de IVA en una factura
@param tipoTabla Valores cli (cliente) o prov (proveedor)
@param idFactura Valor de idfactura
\end */
function oficial_actualizarLineasIva(tipoTabla, idFactura)
{
		var util = new FLUtil();
		var curLineaIva = new FLSqlCursor("lineasivafact" + tipoTabla);
		curLineaIva.select("idfactura = " + idFactura);
		while (curLineaIva.next()) {
				curLineaIva.setModeAccess(curLineaIva.Del);
				curLineaIva.refreshBuffer();
				curLineaIva.commitBuffer();
		}

		curLineasFactura = new FLSqlCursor("lineasfacturas" + tipoTabla);
		curLineasFactura.select("idfactura = " + idFactura + " ORDER BY iva");
		var ivaAnt = 0;
		var iva;
		var codImpuesto = "";
		var totalNeto = 0;
		var totalIva = 0;
		var totalLinea = 0;
		while (curLineasFactura.next()) {
			iva = curLineasFactura.valueBuffer("iva");
			if (ivaAnt != iva) {
				totalIva = (ivaAnt * totalNeto) / 100;
				totalLinea = totalNeto + parseFloat(totalIva);

				codImpuesto = util.sqlSelect("impuestos", "codimpuesto", "iva = " + ivaAnt);
				
				curLineaIva.setModeAccess(curLineaIva.Insert);
				curLineaIva.refreshBuffer();
				curLineaIva.setValueBuffer("idfactura", idFactura);
				curLineaIva.setValueBuffer("iva", ivaAnt);
				if (codImpuesto)
						curLineaIva.setValueBuffer("codimpuesto", codImpuesto);
				curLineaIva.setValueBuffer("neto", totalNeto);
				curLineaIva.setValueBuffer("totaliva", totalIva);
				curLineaIva.setValueBuffer("totallinea", totalLinea);
				curLineaIva.commitBuffer();
				
				totalNeto = 0;
			}
			ivaAnt = iva;
			iva = parseFloat(curLineasFactura.valueBuffer("iva"));
			totalNeto += parseFloat(curLineasFactura.valueBuffer("pvptotal"));
		}

		if (totalNeto != 0) {
				totalIva = util.roundFieldValue((iva * totalNeto) / 100, "lineasivafact" + tipoTabla, "totaliva");
				totalLinea = totalNeto + parseFloat(totalIva);

				with(curLineaIva) {
						setModeAccess(Insert);
						refreshBuffer();
						setValueBuffer("idfactura", idFactura);
						setValueBuffer("iva", iva);
						setValueBuffer("neto", totalNeto);
						setValueBuffer("totaliva", totalIva);
						setValueBuffer("totallinea", totalLinea);
						commitBuffer();
				}
		}
		return true;
}

/** \D Después de haber importado la tabla de formas de pago, es necesario
actualizar los plazos de pago para cada forma de pago.
\end */
function oficial_procesarPlazosPago()
{
	var util:FLUtil = new FLUtil();
	var rutaDatos:String = util.sqlSelect("dat_opciones", "rutaDatos", "");
	if (!File.isDir(rutaDatos)) {
		MessageBox.warning( util.translate( "scripts", "La ruta de datos no ha sido establecida\nPuedes hacerlo en el formulario de ficheros"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return 0;
	}
	
	var fichero = rutaDatos + "fpago.csv";
	if (!File.exists(fichero)) {
		MessageBox.warning( util.translate( "scripts", "No existe el fichero ") + fichero, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return 0;
	}
	
	var totalSteps:Number = formRecorddat_ficheros.iface.pub_numeroLineas( fichero );
	var lineas:Array = formRecorddat_ficheros.iface.pub_leerLineas( fichero, 0, totalSteps );
	
	var linea:String;
	var codPago:String;
	var porc:Array;
	var dias:Array;
	
	var curTabla:FLSqlCursor = new FLSqlCursor("plazos");
	
	for ( i = 0; i < lineas.length; i++ ) {
		linea = lineas[ i ].split( this.iface.sep );
		codPago = linea[0];
		porc[0] = linea[4];
		dias[0] = linea[5];
		porc[1] = linea[6];
		dias[1] = linea[7];
		porc[2] = linea[8];
		dias[2] = linea[9];
		porc[3] = linea[10];
		dias[3] = linea[11];
		porc[4] = linea[12];
		dias[4] = linea[13];

		curTabla.select("codpago = '" + codPago + "'");
		while (curTabla.next()) {
			curTabla.setModeAccess(curTabla.Del);
			curTabla.commitBuffer();
		}
		
		for ( j = 0; j < 5; j++ ) {
			if (porc[j] > 0) {
				curTabla.setModeAccess(curTabla.Insert);
				curTabla.refreshBuffer();
				curTabla.setValueBuffer("codpago", codPago);
				curTabla.setValueBuffer("aplazado", porc[j]);
				curTabla.setValueBuffer("dias", dias[j]);
				curTabla.commitBuffer();
			}
		}
	}
	MessageBox.information ( util.translate( "scripts", "Proceso finalizado"),
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
}

/** \D Los campos de observaciones en clientes, proveedores, artículos y documentos
de facturación están en ficheros independientes en facturaplus. Este proceso lee dichos
ficheros e importa las observaciones a FacturaLUX
\end */
function oficial_procesarComentarios()
{
	var util:FLUtil = new FLUtil();
	var rutaDatos:String = util.sqlSelect("dat_opciones", "rutaDatos", "");
	if (!File.isDir(rutaDatos)) {
		MessageBox.warning( util.translate( "scripts", "La ruta de datos no ha sido establecida\nPuedes hacerlo en el formulario de ficheros"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return 0;
	}
	
	this.iface.comentariosTabla(rutaDatos + "clientec.csv", "clientes", 0, 1, "codcliente", "observaciones");
	this.iface.comentariosTabla(rutaDatos + "proveedc.csv", "proveedores", 0, 1, "codproveedor", "observaciones");
	this.iface.comentariosTabla(rutaDatos + "articulc.csv", "articulos", 0, 1, "referencia", "observaciones");
	
	this.iface.comentariosTabla(rutaDatos + "preclic.csv", "presupuestoscli", 0, 1, "codigo", "observaciones", true);
	this.iface.comentariosTabla(rutaDatos + "pedclic.csv", "pedidoscli", 0, 1, "codigo", "observaciones", true);
	this.iface.comentariosTabla(rutaDatos + "pedproc.csv", "pedidosprov", 0, 1, "codigo", "observaciones", true);
	this.iface.comentariosTabla(rutaDatos + "albclic.csv", "albaranescli", 0, 1, "codigo", "observaciones", true);
	this.iface.comentariosTabla(rutaDatos + "albproc.csv", "albaranesprov", 0, 1, "codigo", "observaciones", true);
	this.iface.comentariosTabla(rutaDatos + "facclic.csv", "facturascli", 0, 2, "codigo", "observaciones", true);
	
	MessageBox.information ( util.translate( "scripts", "Proceso finalizado"),
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
}

/** \D Importa las observaciones procedentes de un fichero CSV a una tabla
@param ficheroCSV Fichero origen con los datos
@param tabla Nombre de la tabla sobre la que se guardarán las observaciones
@param indCampoClaveF Posición en el fichero del campo que identifica al registro
@param indCampoComF Posición en el fichero del campo que contiene la observación
@param campoClaveT Nombre del campo clave de la tabla
@param campoComT Nombre del campo de observaciones de la tabla
@param esFacturacion Indica si se trata de una tabla de facturación
\end */
function oficial_comentariosTabla(ficheroCSV, tabla, indCampoClaveF, indCampoComF, campoClaveT, campoComT, esFacturacion)
{
	var util:FLUtil = new FLUtil();
	
	if (!File.exists(ficheroCSV)) {
		MessageBox.warning( util.translate( "scripts", "No fue posible crear el fichero\n%1\na partir del DBF.\n\nAsegúrese de que los permisos de escritura son correctos" ).arg( ficheroCSV ), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
	
	var totalSteps:Number = formRecorddat_ficheros.iface.pub_numeroLineas( ficheroCSV );
	var lineas:Array = formRecorddat_ficheros.iface.pub_leerLineas( ficheroCSV, 0, totalSteps );
	
	util.createProgressDialog( util.translate( "scripts",
							"Procesando comentarios de ") + tabla + "...", totalSteps );
	util.setProgress(1);
	var paso:Number = 0;
	
	var linea:String;
	var clave;
	var comentario:String;
	
	
	var curTabla:FLSqlCursor = new FLSqlCursor(tabla);
	curTabla.setActivatedCommitActions(false);
	
	curTabla.select();
	while (curTabla.next()) {
		curTabla.setModeAccess(curTabla.Edit);
		curTabla.refreshBuffer();
		curTabla.setValueBuffer(campoComT, "");
		curTabla.commitBuffer();
	}
	
	for ( i = 1; i < lineas.length; i++ ) {
		
		linea = lineas[ i ].split( this.iface.sep );
		if (linea.length < 2) continue;
		
		if (esFacturacion)
				clave = this.iface.codigoFacturacion(tabla, linea);
		else
				clave = linea[indCampoClaveF];
		
		comentario = linea[indCampoComF];
		util.setProgress(paso++);
		if (comentario.length < 2) continue;
		
		curTabla.select(campoClaveT + " = '" + clave + "'");
		if (curTabla.first()) {
			curTabla.setModeAccess(curTabla.Edit);
			curTabla.refreshBuffer();
			curTabla.setValueBuffer(campoComT, curTabla.valueBuffer(campoComT) + comentario);
			curTabla.commitBuffer();
		}
	}
	
	util.destroyProgressDialog();
	curTabla.setActivatedCommitActions(true);
}

/** \D Obtiene el código de un documento de facturación a partir de un array obtenido de un
registro del fichero CSV
@param tabla Nombre de la tabla
@param campos Array con los datos de una línea del fichero CSV
\end */
function oficial_codigoFacturacion(tabla, campos)
{
	var codEjercicio:String = fldatosppal.iface.pub_ejercicioDefecto();
	var codSerie:String = fldatosppal.iface.pub_serieDefecto();
	var codigo:String
	
	switch(tabla) {
		case "presupuestoscli":
		case "pedidoscli":
		case "pedidosprov":
		case "albaranescli":
		case "albaranesprov":
			numero = campos[0];
			codigo = fldatosppal.iface.pub_cerosIzquierda(codEjercicio, 4) + 
			fldatosppal.iface.pub_cerosIzquierda(codSerie, 2) +
			fldatosppal.iface.pub_cerosIzquierda(numero, 6);			
		break;
		
		case "facturascli":
		case "facturasprov":
			codSerie = campos[0];
			numero = campos[1];
			codigo = fldatosppal.iface.pub_cerosIzquierda(codEjercicio, 4) + 
			fldatosppal.iface.pub_cerosIzquierda(codSerie, 2) +
			fldatosppal.iface.pub_cerosIzquierda(numero, 6);			
		break;
	}
	return codigo;
}

/** \D Obtiene el código de un documento de facturación a partir de un array obtenido de un
registro del fichero CSV
@param tabla Nombre de la tabla
@param campos Array con los datos de una línea del fichero CSV
\end */
function oficial_crearFicheroRappels()
{
	var util:FLUtil = new FLUtil();

	var res:String = FileDialog.getOpenFileName( util.translate( "scripts", "Texto CSV (*.txt;*.csv;)" ), util.translate( "scripts", "Elegir Fichero rappels.csv" ) );
	
	if ( !File.exists( res ) ) {
		MessageBox.information( util.translate( "scripts", "Ruta errónea" ),
								MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return ;
	}
	
	var fichIntervalos = new File( res );
	var numLineas = fldatosppal.iface.pub_numLineas(fichIntervalos);
	
	if (!numLineas) {
		MessageBox.warning( util.translate( "scripts", "No hay datos en el fichero de Rappels"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return false;
	}
	
	var fichRappels = new File( fichIntervalos.path + "/tiposrappel.csv" );
	
	try {
		fichRappels.open( File.WriteOnly );
	}
	catch (e) {
		MessageBox.warning( util.translate( "scripts", "Imposible abrir el fichero ") + fichRappels.name + util.translate( "scripts", " para escritura\nCompruebe que la ruta es válida y que los permisos de escritura son correctos"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return false;
	}
	
	var linea:String = "";
	var campos:Array;
	var numAsiento:Number;
	var lastNumAsiento:Number = -1;
	var paso:Number = 0;
	var pasoR:Number = 0;
	
	util.createProgressDialog( util.translate( "scripts",
							"Creando fichero de asientos..." ), numLineas );
	util.setProgress(1);
							
	fichIntervalos.open( File.ReadOnly );
	if ( !fichIntervalos.eof )
			linea = fichIntervalos.readLine();
	fichRappels.write(linea, linea.length);
	
	while ( !fichIntervalos.eof ) {
	
		linea = fichIntervalos.readLine();
		campos = linea.split(this.iface.sep);
		numAsiento = campos[0];
		
		if (numAsiento != lastNumAsiento) {
			lastNumAsiento = numAsiento;
			fichRappels.write(linea, linea.length);
			pasoA++;
		}
		
		util.setProgress(paso++);
	}
	
	util.destroyProgressDialog();

	fichIntervalos.close();
	fichRappels.close();
		
	MessageBox.information ( util.translate( "scripts", "Proceso finalizado. Rappels registrados: ") + pasoR + 
			util.translate( "scripts", "\n\nFichero de rappels creado:\n") + fichRappels.fullName,
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
}

function oficial_completarBancos()
{
	var util:FLUtil = new FLUtil();
	var rutaDatos:String = util.sqlSelect("dat_opciones", "rutaDatos", "");
	if (!File.isDir(rutaDatos)) {
		MessageBox.warning( util.translate( "scripts", "La ruta de datos no ha sido establecida\nPuedes hacerlo en el formulario de ficheros"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
	
	var numNuevos:Number = 0;
	numNuevos += this.iface.completarBancosTabla(rutaDatos + "clientes.csv",16,12);
	
	MessageBox.information ( util.translate( "scripts", "Proceso finalizado. Nuevos bancos insertados: ") + numNuevos,
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
}

function oficial_completarBancosTabla(fichero, indCampoEntidad, indCampoNombre):Number
{
	var util:FLUtil = new FLUtil();
	var F = new File(fichero);
	var numLineas = fldatosppal.iface.pub_numLineas(F);
	
	if (!numLineas) {
		MessageBox.warning( util.translate( "scripts", "No hay datos en el fichero de Clientes"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return false;
	}
	
	var lineas:Array = formRecorddat_ficheros.iface.pub_leerLineas( fichero, 0, numLineas );
	var curBancos:FLSqlCursor = new FLSqlCursor("bancos");
	
	var linea:String = "";
	var campos:Array;
	var entidad:String;
	var nombre:String;
	var paso:Number = 0;
	var pasoB:Number = 0;
	
	util.createProgressDialog( util.translate( "scripts",
							"Actualizando bancos..." ), numLineas );
	util.setProgress(1);
							
	for ( i = 1; i < lineas.length; i++ ) {
	
		linea = lineas[i];
		campos = linea.split(this.iface.sep);
		entidad = campos[indCampoEntidad];
		if (!entidad) continue;
		nombre = campos[indCampoNombre];
		if (!nombre) nombre = "...";
		
		curBancos.select("entidad = '" + entidad + "'");
		if (!curBancos.first() && entidad) {
			curBancos.setModeAccess(curBancos.Insert);
			curBancos.refreshBuffer();
			curBancos.setValueBuffer("entidad", entidad);
			curBancos.setValueBuffer("nombre", nombre);
			curBancos.commitBuffer();
			pasoB++;
		}
		
		util.setProgress(paso++);
	}
	
	util.destroyProgressDialog();

	F.close();
	return pasoB;
}

function oficial_actualizarSaldos()
{
	var util:FLUtil = new FLUtil();
	
	var codEjercicio:String = fldatosppal.iface.pub_ejercicioDefecto();
	var numSubcuentas:Number = util.sqlSelect("co_subcuentas", "count(idsubcuenta)", "codejercicio = '" + codEjercicio + "'");
	var paso:Number = 0;
	
	var q:FLSqlQuery = new FLSqlQuery();
	q.setTablesList("co_subcuentas");
	q.setFrom("co_subcuentas");
	q.setSelect("idsubcuenta");
	q.setWhere("codejercicio = '" + codEjercicio + "'")
	
	if (!q.exec()) { 
		MessageBox.warning( util.translate( "scripts", "Se produjo un error en la consulta"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return false;
	}
	
	util.createProgressDialog( util.translate( "scripts",
							"Calculando saldos de las Subcuentas..." ), numSubcuentas );
	
	while(q.next()) {
		flcontppal.iface.pub_calcularSaldo(q.value(0));
		util.setProgress(paso++);
	}

	util.destroyProgressDialog();

	MessageBox.information ( util.translate( "scripts", "Proceso finalizado. Subcuentas actualizadas: " + paso), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
}


function oficial_completarFyR() 
{
	var util:FLUtil = new FLUtil();
	
	var numFacturas:Number = this.iface.completarFacturas();
	var numRecibos:Number = this.iface.completarRecibos();
	
	MessageBox.information ( util.translate( "scripts", 
		"Proceso finalizado\n\nFacturas actualizadas: ") + numFacturas + 
		util.translate( "scripts", "\nRecibos actualizados: ") + numRecibos,
		MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
	return true;
}


function oficial_completarFacturas()
{
	var util:FLUtil = new FLUtil();
	
	var rutaDatos:String = util.sqlSelect("dat_opciones", "rutaDatos", "");
	if (!File.isDir(rutaDatos)) {
		MessageBox.warning( util.translate( "scripts", "La ruta de datos no ha sido establecida\nPuedes hacerlo en el formulario de ficheros"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
	
	if (!File.exists(rutaDatos + "facclid.csv")) {
		MessageBox.warning( util.translate( "scripts", "No existe el fichero facclid.csv"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
	
	var F = new File(rutaDatos + "facclid.csv");
	var numLineas = fldatosppal.iface.pub_numLineas(F);
	
	if (!numLineas) {
		MessageBox.warning( util.translate( "scripts", "No hay datos en el fichero facclid.csv"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return false;
	}
	
	var codEjercicio:String = fldatosppal.iface.pub_ejercicioDefecto();
	
	var lineas:Array = formRecorddat_ficheros.iface.pub_leerLineas( rutaDatos + "facclid.csv", 0, numLineas );
	
	var linea:String = "";
	var campos:Array;
	var codigo:String;
	var codSerie:String;
	var numero:Number;
	var paso:Number = 0;
	var pasoF:Number = 0;
	
	var curFacturas:FLSqlCursor = new FLSqlCursor("facturascli");
	
	util.createProgressDialog( util.translate( "scripts",
							"Actualizando facturas..." ), numLineas );
	util.setProgress(1);
							
	for ( i = 1; i < lineas.length; i++ ) {
	
		linea = lineas[i];
		campos = linea.split(this.iface.sep);
		codSerie = campos[0];
		numero = campos[1];
		codigo = fldatosppal.iface.pub_cerosIzquierda(codEjercicio, 4) + 
				fldatosppal.iface.pub_cerosIzquierda(codSerie, 2) +
				fldatosppal.iface.pub_cerosIzquierda(numero, 6);
				
		curFacturas.select("codigo = '" + codigo + "'");
		if (curFacturas.first()) {
			curFacturas.setModeAccess(curFacturas.Edit);
			curFacturas.refreshBuffer();
			curFacturas.setValueBuffer("nombrecliente", campos[2]);
			curFacturas.setValueBuffer("direccion", campos[3]);
			curFacturas.setValueBuffer("ciudad", campos[4]);
			curFacturas.setValueBuffer("provincia", fldatosppal.iface.pub_provincia(campos[5]));
			curFacturas.setValueBuffer("codpostal", campos[6]);
			curFacturas.setValueBuffer("cifnif", campos[7]);
			curFacturas.setValueBuffer("codpais", campos[8]);
			curFacturas.commitBuffer();
			pasoF++;
		}
		
		util.setProgress(paso++);
	}
	
	util.destroyProgressDialog();

	F.close();
	return pasoF;	
}

function oficial_completarRecibos()
{
	var util:FLUtil = new FLUtil();
	
	var rutaDatos:String = util.sqlSelect("dat_opciones", "rutaDatos", "");
	if (!File.isDir(rutaDatos)) {
		MessageBox.warning( util.translate( "scripts", "La ruta de datos no ha sido establecida\nPuedes hacerlo en el formulario de ficheros"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
	
	if (!File.exists(rutaDatos + "facclid.csv")) {
		MessageBox.warning( util.translate( "scripts", "No existe el fichero facclid.csv"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
	
	var F = new File(rutaDatos + "facclid.csv");
	var numLineas = fldatosppal.iface.pub_numLineas(F);
	
	if (!numLineas) {
		MessageBox.warning( util.translate( "scripts", "No hay datos en el fichero facclid.csv"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return false;
	}
	
	var codEjercicio:String = fldatosppal.iface.pub_ejercicioDefecto();
	
	var lineas:Array = formRecorddat_ficheros.iface.pub_leerLineas( rutaDatos + "facclid.csv", 0, numLineas );
	
	var linea:String = "";
	var campos:Array;
	var codigo:String;
	var codSerie:String;
	var numero:Number;
	var paso:Number = 0;
	var pasoR:Number = 0;
	
	var curRecibos:FLSqlCursor = new FLSqlCursor("reciboscli");
	
	util.createProgressDialog( util.translate( "scripts",
							"Actualizando recibos..." ), numLineas );
	util.setProgress(1);
							
	for ( i = 1; i < lineas.length; i++ ) {
	
		linea = lineas[i];
		campos = linea.split(this.iface.sep);
		codSerie = campos[0];
		numero = campos[1];
		codigo = fldatosppal.iface.pub_cerosIzquierda(codEjercicio, 4) + 
				fldatosppal.iface.pub_cerosIzquierda(codSerie, 2) +
				fldatosppal.iface.pub_cerosIzquierda(numero, 6);
				
		curRecibos.select("substring(codigo from 1 for 12) = '" + codigo + "'");
		if (curRecibos.first()) {
			curRecibos.setModeAccess(curRecibos.Edit);
			curRecibos.refreshBuffer();
			curRecibos.setValueBuffer("nombrecliente", campos[2]);
			curRecibos.setValueBuffer("direccion", campos[3]);
			curRecibos.setValueBuffer("ciudad", campos[4]);
			curRecibos.setValueBuffer("provincia", fldatosppal.iface.pub_provincia(campos[5]));
			curRecibos.setValueBuffer("codpostal", campos[6]);
			curRecibos.setValueBuffer("cifnif", campos[7]);
			curRecibos.setValueBuffer("codpais", campos[8]);
			curRecibos.commitBuffer();
			pasoR++;
		}
		
		util.setProgress(paso++);
	}
	
	util.destroyProgressDialog();

	F.close();
	return pasoR;	
}

/** Crea los ficheros csv de clientes y proveedores a partir del fichero de subcuentas
*/
function oficial_crearFicheroPC_Sub()
{
	var util:FLUtil = new FLUtil();
	
	var rutaDatos:String = util.sqlSelect("dat_opciones", "rutaDatos", "");
	if (!File.isDir(rutaDatos)) {
		MessageBox.warning( util.translate( "scripts", "La ruta de datos no ha sido establecida\nPuedes hacerlo en el formulario de ficheros"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
	
	if (!File.exists(rutaDatos + "subcta.csv")) {
		MessageBox.warning( util.translate( "scripts", "No existe el fichero subcta.csv"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
	
	var fichSubcuentas = new File( rutaDatos + "subcta.csv" );
	var numLineas = fldatosppal.iface.pub_numLineas(fichSubcuentas);
	
	if (!numLineas) return;
	
	var fichCliSub = new File( fichSubcuentas.path + "/clientes_subcta.csv" );
	
	try {
		fichCliSub.open( File.WriteOnly );
	}
	catch (e) {
		MessageBox.warning( util.translate( "scripts", "Imposible abrir el fichero ") + fichCliSub.name + util.translate( "scripts", " para escritura\nCompruebe que la ruta es válida y que los permisos de escritura son correctos"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return false;
	}
	
	var fichProvSub = new File( fichSubcuentas.path + "/proveedores_subcta.csv" );
	
	try {
		fichProvSub.open( File.WriteOnly );
	}
	catch (e) {
		MessageBox.warning( util.translate( "scripts", "Imposible abrir el fichero ") + fichProvSub.name + util.translate( "scripts", " para escritura\nCompruebe que la ruta es válida y que los permisos de escritura son correctos"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return false;
	}
	
	var linea:String = "";
	var campos:Array;
	var codSubcuenta:String;
	var paso:Number = 0;
	var pasoA:Number = 0;
	var codigos:Array;
	
	var curClientes = new FLSqlCursor("clientes");
	var codCliente:String = util.nextCounter("codcliente", curClientes);
	var lenCodCliente:Number = codCliente.length;
	var numCliente = parseInt(codCliente);
	
	var curProveedores = new FLSqlCursor("proveedores");
	var codProveedor:String = util.nextCounter("codproveedor", curProveedores);
	var lenCodProveedor:Number = codProveedor.length;
	var numProveedor = parseInt(codProveedor);
	
	
	util.createProgressDialog( util.translate( "scripts",
							"Creando ficheros de clientes y proveedores por subcuenta..." ), numLineas );
	util.setProgress(1);
							
	fichSubcuentas.open( File.ReadOnly );
	if ( !fichSubcuentas.eof ) {
		linea = fichSubcuentas.readLine();
		lineaC = "CODCLI" + this.iface.sep + linea;
		lineaP = "CODPROV" + this.iface.sep + linea;
	}
	fichCliSub.write(lineaC, lineaC.length);
	fichProvSub.write(lineaP, lineaP.length);
	
	while ( !fichSubcuentas.eof ) {
	
		linea = fichSubcuentas.readLine();
		campos = linea.split(this.iface.sep);
		codSubcuenta = campos[0];
		
		if (codSubcuenta.substring(1,3) == "43") {
			
			codCliente = numCliente.toString();
			for (var i = codCliente.length; i < lenCodCliente; i++)
					codCliente = "0" + codCliente;
		
			linea = codCliente + this.iface.sep + linea;
			fichCliSub.write(linea, linea.length);
			numCliente++;
			pasoA++;
		}
		
		if (codSubcuenta.substring(1,3) == "40" || codSubcuenta.substring(1,3) == "41") {
			
			codProveedor = numProveedor.toString();
			for (var i = codProveedor.length; i < lenCodProveedor; i++)
					codProveedor = "0" + codProveedor;
		
			linea = codProveedor + this.iface.sep + linea;
			fichProvSub.write(linea, linea.length);
			numProveedor++;
			pasoA++;
		}
		
		util.setProgress(paso++);
	}
	
	util.destroyProgressDialog();

	fichSubcuentas.close();
	fichProvSub.close();
		
	MessageBox.information ( util.translate( "scripts", "Proceso finalizado. Proveedores y clientes registrados: ") + pasoA + 
			util.translate( "scripts", "\n\nFichero de clientes por subcuenta creado:\n") + fichCliSub.fullName + 
			util.translate( "scripts", "\nFichero de proveedores por subcuenta creado:\n") + fichProvSub.fullName, 
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
}

/** Crea los ficheros csv de clientes y proveedores a partir del fichero de subcuentas
respetando los códigos de cliente/prov con los de subcuenta
Puede dar repeticiones
*/
function oficial_crearFicheroPC_SubCOD()
{
	var util:FLUtil = new FLUtil();
	
	var rutaDatos:String = util.sqlSelect("dat_opciones", "rutaDatos", "");
	if (!File.isDir(rutaDatos)) {
		MessageBox.warning( util.translate( "scripts", "La ruta de datos no ha sido establecida\nPuedes hacerlo en el formulario de ficheros"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
	
	if (!File.exists(rutaDatos + "subcta.csv")) {
		MessageBox.warning( util.translate( "scripts", "No existe el fichero subcta.csv"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return;
	}
	
	var fichSubcuentas = new File( rutaDatos + "subcta.csv" );
	var numLineas = fldatosppal.iface.pub_numLineas(fichSubcuentas);
	
	if (!numLineas) return;
	
	var fichCliSub = new File( fichSubcuentas.path + "/clientes_subcta.csv" );
	
	try {
		fichCliSub.open( File.WriteOnly );
	}
	catch (e) {
		MessageBox.warning( util.translate( "scripts", "Imposible abrir el fichero ") + fichCliSub.name + util.translate( "scripts", " para escritura\nCompruebe que la ruta es válida y que los permisos de escritura son correctos"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return false;
	}
	
	var fichProvSub = new File( fichSubcuentas.path + "/proveedores_subcta.csv" );
	
	try {
		fichProvSub.open( File.WriteOnly );
	}
	catch (e) {
		MessageBox.warning( util.translate( "scripts", "Imposible abrir el fichero ") + fichProvSub.name + util.translate( "scripts", " para escritura\nCompruebe que la ruta es válida y que los permisos de escritura son correctos"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return false;
	}
	
	var linea:String = "";
	var campos:Array;
	var codSubcuenta:String;
	var paso:Number = 0;
	var pasoA:Number = 0;
	var codigos:Array;
	
	var curClientes = new FLSqlCursor("clientes");
	var codCliente:String = util.nextCounter("codcliente", curClientes);
	var numCliente:Number = 0;
	var lenCodCliente:Number = codCliente.length;
	
	var curProveedores = new FLSqlCursor("proveedores");
	var codProveedor:String = util.nextCounter("codproveedor", curProveedores);
	var numProveedor:Number = 0;
	var lenCodProveedor:Number = codProveedor.length;
	
	
	util.createProgressDialog( util.translate( "scripts",
							"Creando ficheros de clientes y proveedores por subcuenta..." ), numLineas );
	util.setProgress(1);
							
	fichSubcuentas.open( File.ReadOnly );
	if ( !fichSubcuentas.eof ) {
		linea = fichSubcuentas.readLine();
		lineaC = "CODCLI" + this.iface.sep + linea;
		lineaP = "CODPROV" + this.iface.sep + linea;
	}
	fichCliSub.write(lineaC, lineaC.length);
	fichProvSub.write(lineaP, lineaP.length);
	
	while ( !fichSubcuentas.eof ) {
	
		linea = fichSubcuentas.readLine();
		campos = linea.split(this.iface.sep);
		codSubcuenta = campos[0];
		
		if (codSubcuenta.substring(1,3) == "43") {
			
			codCliente = codSubcuenta.substring(3, codSubcuenta.length - 1);
			for (var i = codCliente.length; i < lenCodCliente; i++)
					codCliente = "0" + codCliente;
		
			linea = codCliente + this.iface.sep + linea;
			fichCliSub.write(linea, linea.length);
			numCliente++;
			pasoA++;
		}
		
		if (codSubcuenta.substring(1,3) == "40" || codSubcuenta.substring(1,3) == "41") {
			
			codProveedor = codSubcuenta.substring(3, codSubcuenta.length - 1);
			for (var i = codProveedor.length; i < lenCodProveedor; i++)
					codProveedor = "0" + codProveedor;
		
			linea = codProveedor + this.iface.sep + linea;
			fichProvSub.write(linea, linea.length);
			numProveedor++;
			pasoA++;
		}
		
		util.setProgress(paso++);
	}
	
	util.destroyProgressDialog();

	fichSubcuentas.close();
	fichProvSub.close();
		
	MessageBox.information ( util.translate( "scripts", "Proceso finalizado. Proveedores y clientes registrados: ") + pasoA + 
			util.translate( "scripts", "\n\nFichero de clientes por subcuenta creado:\n") + fichCliSub.fullName + 
			util.translate( "scripts", "\nFichero de proveedores por subcuenta creado:\n") + fichProvSub.fullName, 
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
}

function oficial_actualizarSubcuentasCli()
{
	var util:FLUtil = new FLUtil();
	var paso:Number = 0;
	var actualizar:Boolean = false;
	
	var cursor:FLSqlCursor = new FLSqlCursor("clientes");
	cursor.select("codsubcuenta is null and idsubcuenta is null");
	
	util.createProgressDialog( util.translate( "scripts", "Actualizando subcuentas de clientes..." ), cursor.size() );
	util.setProgress(1);
	
	var curScta:FLSqlCursor = new FLSqlCursor("co_subcuentas");
	while (cursor.next()) {
	    actualizar = false;
    	    var nombre:String = cursor.valueBuffer("nombre");
	    util.setLabelText(nombre);
	    curScta.select("descripcion like '" + nombre + "%'");
		
	    if (!curScta.first()) {
		var trozo = nombre.length / 3;
		curScta.select("descripcion like '" + nombre.left(trozo) + "%" + nombre.right(trozo) + "%' or descripcion like '"+ nombre.left(1) + "%" + nombre.mid(trozo,trozo) + "%' and codcuenta='430'");
		while (curScta.next()) {
		    var res = MessageBox.warning( util.translate( "scripts", "No se ha encontrado subcuenta para el cliente " + nombre +
									 ".\nSin embargo parece que esta se le parece :\n " + curScta.valueBuffer("codsubcuenta") + "  " + 
									 curScta.valueBuffer("descripcion") + "\n\n¿La utilizo para actualizar este cliente?" ), 
						  MessageBox.No, MessageBox.Yes, MessageBox.NoButton );
		    if ( res == MessageBox.Yes ) {
			actualizar = true;
			break;
		    }
		}
	    } else
		    actualizar = true;

		if (actualizar) {
		    cursor.setModeAccess(cursor.Edit);
		    cursor.refreshBuffer();
		    util.setLabelText(curScta.valueBuffer("codsubcuenta") );
		    cursor.setValueBuffer("codsubcuenta", curScta.valueBuffer("codsubcuenta"));
		    cursor.setValueBuffer("idsubcuenta", curScta.valueBuffer("idsubcuenta"));
		    cursor.commitBuffer();
		}
		util.setProgress(paso++);
	}
	
	util.destroyProgressDialog();
}

function oficial_actualizarSubcuentasProv()
{
    var util:FLUtil = new FLUtil();
	var paso:Number = 0;
	var actualizar:Boolean = false;
	
	var cursor:FLSqlCursor = new FLSqlCursor("proveedores");
	cursor.select("codsubcuenta is null and idsubcuenta is null");
	
	util.createProgressDialog( util.translate( "scripts", "Actualizando subcuentas de proveedores..." ), cursor.size() );
	util.setProgress(1);
	
	var curScta:FLSqlCursor = new FLSqlCursor("co_subcuentas");
	while (cursor.next()) {
	    actualizar = false;
    	    var nombre:String = cursor.valueBuffer("nombre");
	    util.setLabelText(nombre);
	    curScta.select("descripcion like '" + nombre + "%'");
		
	    if (!curScta.first()) {
		var trozo = nombre.length / 3;
		curScta.select("descripcion like '" + nombre.left(trozo) + "%" + nombre.right(trozo) + "%' or descripcion like '"+ nombre.left(1) + "%" + nombre.mid(trozo,trozo) + "%' and (codcuenta='400' or codcuenta='410')");
		while (curScta.next()) {
		    var res = MessageBox.warning( util.translate( "scripts", "No se ha encontrado subcuenta para el proveedor " + nombre +
									 ".\nSin embargo parece que esta se le parece :\n " + curScta.valueBuffer("codsubcuenta") + "  " + 
									 curScta.valueBuffer("descripcion") + "\n\n¿La utilizo para actualizar este cliente?" ), 
						  MessageBox.No, MessageBox.Yes, MessageBox.NoButton );
		    if ( res == MessageBox.Yes ) {
			actualizar = true;
			break;
		    }
		}
	    } else
		    actualizar = true;

		if (actualizar) {
		    cursor.setModeAccess(cursor.Edit);
		    cursor.refreshBuffer();
		    util.setLabelText(curScta.valueBuffer("codsubcuenta") );
		    cursor.setValueBuffer("codsubcuenta", curScta.valueBuffer("codsubcuenta"));
		    cursor.setValueBuffer("idsubcuenta", curScta.valueBuffer("idsubcuenta"));
		    cursor.commitBuffer();
		}
		util.setProgress(paso++);
	}
	
	util.destroyProgressDialog();
}

// Divide un fichero CSV demasiado largo en ficheros de n registros
function oficial_trocearFichero() 
{
	var util:FLUtil = new FLUtil();
	var res:String = FileDialog.getOpenFileName( util.translate( "scripts", "Texto CSV (*.txt;*.csv;)" ), util.translate( "scripts", "Elegir Fichero csv" ) );
	
	if ( !File.exists( res ) ) {
		MessageBox.information( util.translate( "scripts", "Ruta errónea" ),
								MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return ;
	}
	
	var fichPadre = new File( res );
	var numLineas = fldatosppal.iface.pub_numLineas(fichPadre);
	
	var encabezados:String = "";
	var linea:String = "";
	var paso:Number = 0;
	var pasoT:Number = 0;
	var numHijo:Number = 1;
	var lineasFichero:Number = Input.getText( util.translate( "scripts", "Introduce el número de registros por fichero" ) );
	lineasFichero = parseInt(lineasFichero);
	
	if (!numLineas) {
		MessageBox.warning( util.translate( "scripts", "No hay datos en el fichero"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return false;
	}
	
	var fichHijo = new File( fichPadre.path + "/" + fichPadre.baseName + "_" + numHijo + ".csv" );
	
	try {
		fichHijo.open( File.WriteOnly );
	}
	catch (e) {
		MessageBox.warning( util.translate( "scripts", "Imposible abrir el fichero ") + fichHijo.name + util.translate( "scripts", " para escritura\nCompruebe que la ruta es válida y que los permisos de escritura son correctos"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
		return false;
	}
	
	util.createProgressDialog( util.translate( "scripts","Creando ficheros..." ), numLineas );
	util.setProgress(1);
							
	fichPadre.open( File.ReadOnly );
	if ( !fichPadre.eof )
			encabezados = fichPadre.readLine();
	fichHijo.write(encabezados, encabezados.length);
	
	while ( !fichPadre.eof ) {
		linea = fichPadre.readLine();
		fichHijo.write(linea, linea.length);
		util.setProgress(pasoT++);
		if (++paso == lineasFichero) {
			paso = 0;
			numHijo++;
			fichHijo.close();
			fichHijo = new File( fichPadre.path + "/" + fichPadre.baseName + "_" + numHijo + ".csv" );
			fichHijo.open( File.WriteOnly );
			fichHijo.write(encabezados, encabezados.length);
		}
	}
	
	util.destroyProgressDialog();

	fichPadre.close();
	fichHijo.close();
		
	MessageBox.information ( util.translate( "scripts", "Proceso finalizado. Ficheros creados: ") + numHijo,			
			MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton );
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////