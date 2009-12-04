/***************************************************************************
                 ejercicios.qs  -  description
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
	function validateForm():Boolean {return this.ctx.interna_validateForm(); }
	function calculateCounter():String {return this.ctx.interna_calculateCounter(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	function oficial( context ) { interna( context ); }
	function buscarPlanContable(cursor:FLSqlCursor):Boolean {
		return this.ctx.oficial_buscarPlanContable(cursor);
	} 
	function copiarSubcuentasCliProv(codEjFuente:String, codEjDestino:String):Boolean {
		return this.ctx.oficial_copiarSubcuentasCliProv(codEjFuente, codEjDestino);
	}
}
//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration pgc2008 */
/////////////////////////////////////////////////////////////////
//// PGC 2008 //////////////////////////////////////////////////////
class pgc2008 extends oficial 
{
    function pgc2008( context ) { oficial ( context ); }
	
	function init() { this.ctx.pgc2008_init(); }
	
	function validateForm():Boolean {
		return this.ctx.pgc2008_validateForm(); 
	}
	
	function buscarPlanContable(cursor:FLSqlCursor):Boolean {
		return this.ctx.pgc2008_buscarPlanContable(cursor);
	} 
	function copiarPGC(ejercicioAnt:String, ejercicioAct:String, longSubcuenta:Number):Boolean {
		return this.ctx.pgc2008_copiarPGC(ejercicioAnt, ejercicioAct, longSubcuenta);
	} 
	function buscarPlanContable90(cursor:FLSqlCursor):Boolean {
		return this.ctx.pgc2008_buscarPlanContable90(cursor);
	} 
	function comprobarSubcuentasCopia(ejercicioAnt:String, ejercicioAct:String):Boolean {
		return this.ctx.pgc2008_comprobarSubcuentasCopia(ejercicioAnt, ejercicioAct);
	}
}
//// PGC 2008 //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration periodosFiscales */
/////////////////////////////////////////////////////////////////
//// PERIODOS FISCALES //////////////////////////////////////////
class periodosFiscales extends pgc2008 {
	function periodosFiscales( context ) { pgc2008 ( context ); }
	function validateForm():Boolean {
		return this.ctx.periodosFiscales_validateForm();
	}
}
//// PERIODOS FISCALES //////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration silixSeries */
/////////////////////////////////////////////////////////////////
//// SILIX SERIES ///////////////////////////////////////////////
class silixSeries extends periodosFiscales {
    function silixSeries( context ) { periodosFiscales ( context ); }
	function validateForm():Boolean {
		return this.ctx.silixSeries_validateForm();
	}
}
//// SILIX SERIES ///////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends silixSeries {
    function head( context ) { silixSeries ( context ); }
}
//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration ifaceCtx */
/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////
class ifaceCtx extends head {
    function ifaceCtx( context ) { head( context ); }
    function pub_buscarPlanContable(cursor:FLSqlCursor):Boolean {
		return this.buscarPlanContable(cursor);
	}
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
/** \C La fecha de inicio de un nuevo ejercicio ser� el d�a siguiente al fin del �ltimo ejercicio. Si no existen ejercicios, la fecha ser� la de inicio de a�o actual.

La fecha de fin por defecto ser� la fecha de fin del a�o de la fecha de inicio

Si el m�dulo de contabilidad est� cargado, al dar de alta un nuevo ejercicio se busca el plan general contable asociado al mismo. De no encontrarlo se consulta si se desea crear un plan contable para el ejercicio o copiar uno ya existente. Si se selecciona copiar un plan anterior, se abre la ventana de ejercicios para escoger el ejercicio del cual se copiar� el plan.
\end */
function interna_init()
{
	var cursor:FLSqlCursor = this.cursor();
	var util:FLUtil = new FLUtil();
	if (cursor.modeAccess() == cursor.Insert) {
		var ultEjercicio:String = util.sqlSelect("ejercicios", "fechafin",
				" 1 = 1 ORDER BY fechafin DESC");
		if (ultEjercicio) {
				this.child("fdbFechaInicio").setValue(util.addDays(ultEjercicio, 1));
		} else {
				var hoy:Date = new Date()
				var fechaInicio:Date = new Date(hoy.getYear(), 1, 1);
				this.child("dedFechaInicio").setValue(fechaInicio);
		}
		var fechaInicio:Date = new Date(Date.parse(cursor.valueBuffer("fechainicio").toString().substring(0, 10)));
		var fechaFin:Date = new Date(fechaInicio.getYear(), 12, 31);
		this.child("fdbFechaFin").setValue(fechaFin);
	}
	if (cursor.modeAccess() == cursor.Edit){
		if(util.sqlSelect("co_epigrafes","idepigrafe","codejercicio = '" + cursor.valueBuffer("codejercicio") + "'"))
			this.child("fdbLongSubcuenta").setDisabled(true);
	}

	if (sys.isLoadedModule("flcontppal")) {
		this.child("tbwSecuencias").setTabEnabled("secuenciascon", true);
	} else {
		this.child("tbwSecuencias").setTabEnabled("secuenciascon", false);
	}
}

function interna_validateForm():Boolean
{
		var fechaInicio:String = this.child("fdbFechaInicio").value();
		var fechaFin:String = this.child("fdbFechaFin").value();
		var util:FLUtil = new FLUtil;

/** \C
La fecha de inicio del ejercicio debe ser menor que la de fin
\end */
		if (fechaInicio > fechaFin) {
				MessageBox.warning(util.translate("scripts", "La fecha de inicio del ejercicio debe ser menor que la de fin"),
						 MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
		}

/** \C
Al menos una secuencia por serie debe a�adirse al ejercicio
\end */
		var cursor:FLSqlCursor = new FLSqlCursor("secuenciasejercicios");
		cursor.select("upper(codejercicio) = '" +
				this.cursor().valueBuffer("codejercicio").upper() + "';");
		if (!cursor.first()) {
				MessageBox.warning(util.translate("scripts", "Debe a�adir al menos una secuencia para el ejercicio\nen \"Secuencias por serie\""), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
		}

/** \C
La longitud de la subcuenta debe estar entre 5 y 15 caracteres
\end */
	var longSubcuenta:Number = parseFloat(this.cursor().valueBuffer("longsubcuenta"));
	if (longSubcuenta < 5 || longSubcuenta > 15) {
		MessageBox.warning(util.translate("scripts", "La longitud de la subcuenta debe estar entre 5 y 15 caracteres"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

	if (sys.isLoadedModule("flcontppal")) {
		if (!util.sqlSelect("co_epigrafes", "codejercicio", "codejercicio = '" + this.cursor().valueBuffer("codejercicio") + "'")) {
			MessageBox.information(util.translate("scripts", "Para generar el Plan General Contable asociado a este ejercicio use el bot�n 'PGC' del formulario maestro de ejercicios"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		}
	}
	return true;
}

function interna_calculateCounter():String
{
		var util:FLUtil = new FLUtil();
		return util.nextCounter("codejercicio", this.cursor());
}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

/** \D Busca el plan general contable asociado al ejercicio actual. Si no lo encuentra da la opci�n de crear un nuevo plan o copiar uno ya existente
@param cursor Cursor del ejercicio actual
@return Verdadero si no hay error en la funci�n, falso en caso contrario
\end */
function oficial_buscarPlanContable(cursor:FLSqlCursor):Boolean
{
	var ejercicio:String = cursor.valueBuffer("codejercicio");
	var logdigitos:Number = cursor.valueBuffer("longsubcuenta");
	var util:FLUtil = new FLUtil;
	//si el ejercicio no tiene ningun plan contable asignado
	if (!util.sqlSelect("co_epigrafes", "codejercicio", "codejercicio = '" + ejercicio + "'")) {
		if (util.sqlSelect("ejercicios", "count(codejercicio)", "1 = 1") == 1)
		{
			flcontppal.iface.pub_generarPGC(ejercicio);
			flcontppal.iface.pub_generarSubcuentas(ejercicio,logdigitos);
			return true;
		}

		var dialog:Object = new Dialog(util.translate("scripts", "Generar Plan Contable"), 0, "gerenarPGC");
		
		dialog.OKButtonText = util.translate ("scripts","Aceptar");
		dialog.cancelButtonText = util.translate ("scripts","Cancelar");

		var bgroup:Object = new GroupBox;
		dialog.add(bgroup);

		var nuevoPlan:Object = new RadioButton;
		nuevoPlan.text = util.translate ("scripts","Crear nuevo Plan General Contable");
		nuevoPlan.checked = true;
		bgroup.add(nuevoPlan);

		var anteriorPlan:Object = new RadioButton;
		anteriorPlan.text = util.translate ("scripts","Seleccionar un ejercicio anterior y copiar su Plan General Contable");
		anteriorPlan.checked = false;
		bgroup.add(anteriorPlan);

		if (!dialog.exec())
			return true;

		if (nuevoPlan.checked == true){
/** \D Si se selecciona crear un nuevo plan, se llama a flcontppal.generarPGC, que cargar� el plan por defecto y lo asociar� al ejercicio
\end */
			flcontppal.iface.pub_generarPGC(ejercicio);
			flcontppal.iface.pub_generarSubcuentas(ejercicio,logdigitos);
		}
		else {
/** \D Si se selecciona copiar un plan anterior, se abre la ventana de ejercicios para escoger el ejercicio del cual se copiar� el plan. Los pasos seguidos son los siguientes:
\end */
			var idEpigrafe:Number;
			var idEpigrafeNuevo:Number;
			var idPadre:Number;
			var idPadreNuevo:Number;
			var idCuenta:Number;
			var idCuentaNueva:Number;
			var codEpigrafe:String;
			var codPadre:String;
			var f:Object = new FLFormSearchDB("ejercicios");
			f.setMainWidget();
			f.cursor().setMainFilter("codejercicio <> '" + ejercicio + "'");
			var ejeranterior:String = f.exec("codejercicio");
			
			if (!ejeranterior)
				return false;
			cursor.setValueBuffer("longsubcuenta", util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + ejeranterior + "'"));
/** \D Se buscan los datos de la tabla epigrafes del ejercicio anterior y se insertan en el nuevo ejercicio
\end */
			var qryEpigrafe:FLSqlQuery = new FLSqlQuery;
			with(qryEpigrafe){
				setTablesList ("co_epigrafes,co_epigrafes");
				setSelect("e.idpadre,e.idepigrafe,e.codepigrafe,e.descripcion,p.codepigrafe");
				setFrom("co_epigrafes e LEFT OUTER JOIN co_epigrafes p ON e.idpadre = p.idepigrafe");
				setWhere("e.codejercicio = '" + ejeranterior +"'");
			}
			if (!qryEpigrafe.exec())
				return;

			var i:Number = 0;
			var j:Number = 0;

			var totalEpigrafes:Number = util.sqlSelect("co_epigrafes e LEFT OUTER JOIN co_epigrafes p ON e.idpadre = p.idepigrafe", "COUNT(e.idepigrafe)", "e.codejercicio = '" + ejeranterior + "'", "co_epigrafes");

			util.createProgressDialog(util.translate("scripts", "Copiando Plan General Contable"), totalEpigrafes);

			while(qryEpigrafe.next()){
				idPadre = qryEpigrafe.value(0);
				idEpigrafe = qryEpigrafe.value(1);
				codEpigrafe = qryEpigrafe.value(2);
				var curEpigrafe:FLSqlCursor = new FLSqlCursor ("co_epigrafes");
				curEpigrafe.setModeAccess (curEpigrafe.Insert);
				curEpigrafe.refreshBuffer();
				curEpigrafe.setValueBuffer("codejercicio",ejercicio);
				curEpigrafe.setValueBuffer("codepigrafe",codEpigrafe);
				curEpigrafe.setValueBuffer("descripcion",qryEpigrafe.value(3));
				if(idPadre) {
					idPadreNuevo = util.sqlSelect("co_epigrafes", "idepigrafe", "codepigrafe = '" + qryEpigrafe.value(4) + "'" + " AND codejercicio = '" + ejercicio + "'");
					curEpigrafe.setValueBuffer("idpadre",idPadreNuevo);
				}
				if (!curEpigrafe.commitBuffer())
					return false;
				idEpigrafeNuevo  = curEpigrafe.valueBuffer("idepigrafe");

/** \D	Para las cuentas existentes para cada epigrafe, el idepigrafe, el idpadre y el codepigrafe son el mismo que el de el epigrafe al que pertenecen
\end */
				var qryCuentas:FLSqlQuery = new FLSqlQuery;
				with(qryCuentas){
					setTablesList ("co_cuentas");
					setSelect("codcuenta,descripcion,idcuentaesp,codepigrafe,codbalance,idcuenta");
					setFrom("co_cuentas");
					setWhere("idepigrafe = " + idEpigrafe);
				}
				if (!qryCuentas.exec())
					return;
				while(qryCuentas.next()) {
					idCuenta = qryCuentas.value(5);
					var curCuentas:FLSqlCursor = new FLSqlCursor ("co_cuentas");
					curCuentas.setModeAccess (curCuentas.Insert);
					curCuentas.refreshBuffer();
					curCuentas.setValueBuffer("codejercicio",ejercicio);
					curCuentas.setValueBuffer("codcuenta",qryCuentas.value(0));
					curCuentas.setValueBuffer("idepigrafe",idEpigrafeNuevo);
					curCuentas.setValueBuffer("codepigrafe",qryCuentas.value(3));
					curCuentas.setValueBuffer("descripcion",qryCuentas.value(1));
					curCuentas.setValueBuffer("idcuentaesp",qryCuentas.value(2));
					curCuentas.setValueBuffer("codbalance",qryCuentas.value(4));
					curCuentas.commitBuffer();
					codigocuenta = qryCuentas.value(0);
/** \D Se busca el idcuenta que se genera para cada cuenta para posteriormente poderlo enlazar con las subcuentas
\end */
					idCuentaNueva = curCuentas.valueBuffer("idcuenta");
					var qrySubCuentas:FLSqlQuery = new FLSqlQuery;
/** \D Se busca	la subcuenta para cada cuenta encontrada con el mismo ejercicio e idcuenta
\end */
					with(qrySubCuentas){
						setTablesList ("co_subcuentas");
						setSelect("codsubcuenta,codcuenta,descripcion,coddivisa,codimpuesto,iva,idcuentaesp");
						setFrom("co_subcuentas");
						setWhere("idcuenta = " + idCuenta);
					}
					if (!qrySubCuentas.exec())
						return;
					while(qrySubCuentas.next()){
						var curSubCuentas:FLSqlCursor = new FLSqlCursor ("co_subcuentas");
						curSubCuentas.setModeAccess (curSubCuentas.Insert);
						curSubCuentas.refreshBuffer();
						curSubCuentas.setValueBuffer("codejercicio", ejercicio);
						curSubCuentas.setValueBuffer("codsubcuenta", qrySubCuentas.value(0));
						curSubCuentas.setValueBuffer("idcuenta", idCuentaNueva);
						curSubCuentas.setValueBuffer("codcuenta", qrySubCuentas.value(1));
						curSubCuentas.setValueBuffer("descripcion", qrySubCuentas.value(2));
						curSubCuentas.setValueBuffer("coddivisa", qrySubCuentas.value(3));
						curSubCuentas.setValueBuffer("codimpuesto", qrySubCuentas.value(4));
						curSubCuentas.setValueBuffer("iva", qrySubCuentas.value(5));
						curSubCuentas.setValueBuffer("idcuentaesp", qrySubCuentas.value(6));
						if (!curSubCuentas.commitBuffer())
							return;
					}
			}
				i++
				if (j++ > totalEpigrafes/10) {
					j = 0;
					util.setProgress(i);
				}
			}
			util.setProgress(totalEpigrafes);
			util.destroyProgressDialog();
			
			if (!this.iface.copiarSubcuentasCliProv(ejeranterior, ejercicio))
				return false;
		}
	}
	return true;
}

/** \D Copia las asociaciones subcuentas - clientes y subcuentas - proveedores de un ejercicio a otro
@param codEjFuente: C�digo del ejercicio desde el que se copiar�n las asociaciones
@param codEjDestino: C�digo del ejercicio al que se copiar�n las asociaciones
@return	True si la copia se realiza de forma correcta, false en caso contrario
*/
function oficial_copiarSubcuentasCliProv(codEjFuente:String, codEjDestino:String):Boolean
{
	var util:FLUtil = new FLUtil;
	
	var idSubcuenta:String;
	var paso:Number = 0;
	
	var qryCli:FLSqlQuery = new FLSqlQuery;
	qryCli.setTablesList("co_subcuentascli,clientes");
	qryCli.setSelect("s.codsubcuenta, s.codcliente, c.nombre");
	qryCli.setFrom("co_subcuentascli s INNER JOIN clientes c ON s.codcliente = c.codcliente");
	qryCli.setWhere("s.codejercicio = '" + codEjFuente + "'");
	if (!qryCli.exec())
		return false;
	
	util.createProgressDialog(util.translate("scripts", "Copiando subcuentas por cliente"), qryCli.size());
	util.setProgress(0);
	while (qryCli.next()) {
		idSubcuenta = flfactppal.iface.pub_crearSubcuenta(qryCli.value(0), qryCli.value(2), "CLIENT", codEjDestino);
		if (!idSubcuenta)
			return false;
		if (!flfactppal.iface.pub_crearSubcuentaCli(qryCli.value(0), idSubcuenta, qryCli.value(1), codEjDestino))
			return false;
		util.setProgress(paso++);
	}
	util.setProgress(qryCli.size());
	util.destroyProgressDialog();
	
	var qryProv:FLSqlQuery = new FLSqlQuery;
	qryProv.setTablesList("co_subcuentasprov,proveedores");
	qryProv.setSelect("s.codsubcuenta, s.codproveedor, p.nombre");
	qryProv.setFrom("co_subcuentasprov s INNER JOIN proveedores p ON s.codproveedor = p.codproveedor");
	qryProv.setWhere("s.codejercicio = '" + codEjFuente + "'");
	if (!qryProv.exec())
		return false;
	
	util.createProgressDialog(util.translate("scripts", "Copiando subcuentas por proveedor"), qryProv.size());
	util.setProgress(0);
	while (qryProv.next()) {
		idSubcuenta = flfactppal.iface.pub_crearSubcuenta(qryProv.value(0), qryProv.value(2), "PROVEE", codEjDestino);
		if (!idSubcuenta)
			return false;
		if (!flfactppal.iface.pub_crearSubcuentaProv(qryProv.value(0), idSubcuenta, qryProv.value(1), codEjDestino))
			return false;
		util.setProgress(paso++);
	}
	util.setProgress(qryProv.size());
	util.destroyProgressDialog();
	
	return true;
}
//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition pgc2008 */
/////////////////////////////////////////////////////////////////
//// PGC 2008 //////////////////////////////////////////////////////

function pgc2008_init()
{
	this.iface.__init();

	var util:FLUtil = new FLUtil;
	var cursor:FLSqlCursor = this.cursor();
	
	if (cursor.modeAccess() == cursor.Edit){
		if(util.sqlSelect("co_epigrafes","idepigrafe","codejercicio = '" + cursor.valueBuffer("codejercicio") + "'"))
			this.child("fdbPlanContable").setDisabled(true);
	}
}

function pgc2008_comprobarSubcuentasCopia(ejercicioAnt:String, ejercicioAct:String):Boolean
{
	var util:FLUtil = new FLUtil;	
	var paso:Number = 0;	
	
	var qrySubCuentas:FLSqlQuery = new FLSqlQuery;			
	qrySubCuentas.setTablesList ("co_subcuentas");
	qrySubCuentas.setSelect("codsubcuenta,codcuenta,saldo");
	qrySubCuentas.setFrom("co_subcuentas");
	qrySubCuentas.setWhere("codejercicio = '" + ejercicioAnt + "' order by codsubcuenta");
	
	if (!qrySubCuentas.exec())
		return;
	
	util.createProgressDialog(util.translate("scripts", "Comprobando Subcuentas"), qrySubCuentas.size());
	
	var curSubCuentas:FLSqlCursor = new FLSqlCursor ("co_subcuentas");
		
	var cuentasPerdidas:String = "";
	
	while(qrySubCuentas.next()) {
	
		util.setProgress(paso++);
	
		codCuenta08 = flcontppal.iface.convertirCodCuenta(qrySubCuentas.value(1));
			
		//Si no existe y no hay saldo, se ignora
		if (!codCuenta08 && parseFloat(qrySubCuentas.value(2)))
			cuentasPerdidas += "\n" + qrySubCuentas.value(1) + " " + qrySubCuentas.value(0);
	}

	if (cuentasPerdidas) {
		MessageBox.information(util.translate("scripts", "Las siguientes cuentas/subcuentas con saldo no tienen correspondencia en el nuevo PGC\nDebe establecer su correspondencia en:\nM�dulo principal de financiera / Configuraci�n / Correspondencias 90-08:") + "\n" + cuentasPerdidas, MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		util.destroyProgressDialog();
		return false;
	}

	util.destroyProgressDialog();
	return true;
}


function pgc2008_buscarPlanContable(cursor:FLSqlCursor):Boolean
{
	if (cursor.valueBuffer("plancontable") != "08")
		return this.iface.buscarPlanContable90(cursor);

	var ejercicio:String = cursor.valueBuffer("codejercicio");
	var logdigitos:Number = cursor.valueBuffer("longsubcuenta");
	var util:FLUtil = new FLUtil;
	
	//si el ejercicio no tiene ningun plan contable asignado
	if (util.sqlSelect("co_epigrafes", "codejercicio", "codejercicio = '" + ejercicio + "'"))
		return;
		 
	// Si s�lo hay un ejercicio
	if (util.sqlSelect("ejercicios", "count(codejercicio)", "longsubcuenta = " + logdigitos) == 1) {
		
		res = MessageBox.warning(util.translate("scripts", "S�lo existe este ejercicio con el mismo n�mero de d�gitos por subcuenta. Se crear� un nuevo plan contable.\n�Continuar?"),
				 MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
		if (res != MessageBox.Yes)
			return;
	
		flcontppal.iface.pub_generarPGC(ejercicio);
		return true;
	}

	var dialog:Object = new Dialog(util.translate("scripts", "Generar Plan Contable"), 0, "generarPGC");
	
	dialog.OKButtonText = util.translate ("scripts","Aceptar");
	dialog.cancelButtonText = util.translate ("scripts","Cancelar");

	var bgroup:Object = new GroupBox;
	dialog.add(bgroup);

	var nuevoPlan:Object = new RadioButton;
	nuevoPlan.text = util.translate ("scripts","Crear nuevo Cuadro de cuentas");
	nuevoPlan.checked = true;
	bgroup.add(nuevoPlan);

	var anteriorPlan:Object = new RadioButton;
	anteriorPlan.text = util.translate ("scripts","Seleccionar un ejercicio anterior y copiar su Cuadro de cuentas");
	anteriorPlan.checked = false;
	bgroup.add(anteriorPlan);

	if (!dialog.exec())
		return true;

	if (nuevoPlan.checked == true){
		flcontppal.iface.pub_generarPGC(ejercicio);
		return true;
	}
		
		
	var dialog:Object = new Dialog(util.translate("scripts", "Seleccionar ejercicio"), 0, "");
	
	dialog.OKButtonText = util.translate ("scripts","Aceptar");
	dialog.cancelButtonText = util.translate ("scripts","Cancelar");

	var bgroup:Object = new GroupBox;
	dialog.add(bgroup);
	
	var curTab:FLSqlCursor = new FLSqlCursor("ejercicios");
	curTab.select("codejercicio <> '" + ejercicio + "'");
	var botonesEj:Array = [];
	var paso:Number = 0;
	
	while(curTab.next()) {
	
		if (curTab.valueBuffer("longsubcuenta") != logdigitos)
			continue;
	
		botonesEj[paso] = new Array(2);
		botonesEj[paso]["codEjercicio"] = curTab.valueBuffer("codejercicio");
		botonEj = new RadioButton;
		botonEj.text = curTab.valueBuffer("codejercicio") + " - " + curTab.valueBuffer("nombre");
		if (!paso)
			botonEj.checked = true;		
		bgroup.add(botonEj);
		
		botonesEj[paso]["boton"] = botonEj;		
		paso++;
	}

	if (!dialog.exec())
		return true;
	
	var ejeranterior:String;
	for (i = 0; i < botonesEj.length; i++) {
		botonEj = botonesEj[i]["boton"];
		if (botonEj.checked) {
			ejeranterior = botonesEj[i]["codEjercicio"];
			break;
		}
	}
	
	if (!ejeranterior)
		return false;
		
	cursor.setValueBuffer("longsubcuenta", util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + ejeranterior + "'"));

	var curTransaccion:FLSqlCursor = new FLSqlCursor("empresa");
	curTransaccion.transaction(false);
	try {
		if (this.iface.copiarPGC(ejeranterior, ejercicio, logdigitos)) {
			curTransaccion.commit();
		} else {
			curTransaccion.rollback();
			return false;
		}
	} catch (e) {
		curTransaccion.rollback();
		MessageBox.warning(util.translate("scripts", "Error al copiar el PGC: ") + e, MessageBox.Ok, MessageBox.NoButton);
		return false;
	}
	
	return true;
}


function pgc2008_copiarPGC(ejercicioAnt:String, ejercicioAct:String, longSubcuenta:Number):Boolean
{
	var util:FLUtil = new FLUtil;	
	
	var planContableAnt = util.sqlSelect("ejercicios", "plancontable", "codejercicio = '" + ejercicioAnt + "'");
	if (planContableAnt != "08")
		if (!this.iface.comprobarSubcuentasCopia(ejercicioAnt, ejercicioAct))
			return false;

	// Se genera el cuadro de cuentas como si fuera un ejercicio est�ndar pero las subcuentas se copian
	flcontppal.iface.generarCuadroCuentas(ejercicioAct);
	flcontppal.iface.generarCodigosBalance2008(); // S�lo si no existen
	flcontppal.iface.actualizarCuentas2008(ejercicioAct);
	flcontppal.iface.actualizarCuentas2008ba(ejercicioAct);
	flcontppal.iface.generarCorrespondenciasCC(ejercicioAct);
	flcontppal.iface.actualizarCuentasEspeciales(ejercicioAct);
	
	var paso:Number = 0;	
	
	var qrySubCuentas:FLSqlQuery = new FLSqlQuery;			
	qrySubCuentas.setTablesList ("co_subcuentas");
	qrySubCuentas.setSelect("codsubcuenta,codcuenta,descripcion,coddivisa,codimpuesto,iva,saldo,idcuentaesp");
	qrySubCuentas.setFrom("co_subcuentas");
	qrySubCuentas.setWhere("codejercicio = '" + ejercicioAnt + "'");
	
	if (!qrySubCuentas.exec())
		return;
	
	util.createProgressDialog(util.translate("scripts", "Copiando Subcuentas"), qrySubCuentas.size());
	
	var curSubCuentas:FLSqlCursor = new FLSqlCursor ("co_subcuentas");
	curSubCuentas.setActivatedCommitActions(false);
	
	var cuentasPerdidas:String = "";
	var descripcion:String;
	while (qrySubCuentas.next()) {
	
		util.setProgress(paso++);
	
		// Caso 1: de 90 a 08
		if (planContableAnt != "08") {
			// A qu� cuenta 08 corresponde esta cuenta 90?
			codCuenta08 = flcontppal.iface.convertirCodCuenta(qrySubCuentas.value(1));
			idCuenta08 = util.sqlSelect("co_cuentas", "idcuenta", "codcuenta = '" + codCuenta08 + "' and codejercicio = '" + ejercicioAct + "'");
			
			if (!idCuenta08) {
				//Si no hay saldo, se ignora
				if (parseFloat(qrySubCuentas.value(6)))
					cuentasPerdidas += "\n" + qrySubCuentas.value(1) + " " + qrySubCuentas.value(0);
				continue;
			}
			
			codSubcuenta08 = flcontppal.iface.convertirCodSubcuenta(ejercicioAnt, qrySubCuentas.value(0));
			descripcion = qrySubCuentas.value("descripcion");
		} else {
			// Caso 2: de 08 a 08
			codCuenta08 = qrySubCuentas.value(1);
			idCuenta08 = util.sqlSelect("co_cuentas", "idcuenta", "codcuenta = '" + codCuenta08 + "' and codejercicio = '" + ejercicioAct + "'");
			codSubcuenta08 = qrySubCuentas.value(0);
			if (!idCuenta08) {
				continue;
			}
			descripcion = qrySubCuentas.value("descripcion");
		}
		
		// Existe ya?
		curSubCuentas.select("codsubcuenta = '" + codSubcuenta08 + "' AND codejercicio = '" + ejercicioAct + "'");
		if (curSubCuentas.first()) {
			continue;
		}

			
		// La descripcion no debe tener ya el c�digo antes. "225. Otras instalaciones" -> "Otras instalaciones"
/*		descripcion = qrySubCuentas.value(2);
		if (descripcion.search(".") > -1) {
			partesDescripcion = descripcion.split(". ");
			if (partesDescripcion.length == 2)
				descripcion = partesDescripcion[1];
		}*/
		
		curSubCuentas.setModeAccess (curSubCuentas.Insert);
		curSubCuentas.refreshBuffer();
		curSubCuentas.setValueBuffer("codejercicio",ejercicioAct);
		curSubCuentas.setValueBuffer("codsubcuenta",codSubcuenta08);
		curSubCuentas.setValueBuffer("idcuenta",idCuenta08);
		curSubCuentas.setValueBuffer("codcuenta",codCuenta08);
		curSubCuentas.setValueBuffer("descripcion",descripcion);
		curSubCuentas.setValueBuffer("coddivisa",qrySubCuentas.value(3));
		curSubCuentas.setValueBuffer("codimpuesto",qrySubCuentas.value(4));
		curSubCuentas.setValueBuffer("iva",qrySubCuentas.value(5));
		curSubCuentas.setValueBuffer("idcuentaesp",qrySubCuentas.value("idcuentaesp"));
		if (!curSubCuentas.commitBuffer())
			return;
	}
	
	util.destroyProgressDialog();
	
	// Genera las subcuentas del nuevo PGC que no existen en el ejercicio anterior
	flcontppal.iface.generarSubcuentas(ejercicioAct, longSubcuenta);
	
	if (!this.iface.copiarSubcuentasCliProv(ejercicioAnt, ejercicioAct))
		return false;

	if (cuentasPerdidas)
		MessageBox.information(util.translate("scripts", "Las siguientes cuentas/subcuentas con saldo no se pudieron copiar\nporque no existe una correspondencia con el nuevo plan contable\nDeber� migrar su saldo a otras cuentas antes de cerrar el ejercicio:") + "\n" + cuentasPerdidas,
				 MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);

	MessageBox.information(util.translate("scripts", "Se copi� el cuadro de cuentas"),
			 MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);

	return true;
}

/** \D Es el mismo que oficial pero no deja copiar de 08 a 90
\end */
function pgc2008_buscarPlanContable90(cursor:FLSqlCursor):Boolean
{
	var ejercicio:String = cursor.valueBuffer("codejercicio");
	var logdigitos:Number = cursor.valueBuffer("longsubcuenta");
	var util:FLUtil = new FLUtil;
	//si el ejercicio no tiene ningun plan contable asignado
	if (!util.sqlSelect("co_epigrafes", "codejercicio", "codejercicio = '" + ejercicio + "'")) {
		if (util.sqlSelect("ejercicios", "count(codejercicio)", "1 = 1") == 1)
		{
			flcontppal.iface.pub_generarPGC(ejercicio);
			flcontppal.iface.pub_generarSubcuentas(ejercicio,logdigitos);
			return true;
		}

		var dialog:Object = new Dialog(util.translate("scripts", "Generar Plan Contable"), 0, "gerenarPGC");
		
		dialog.OKButtonText = util.translate ("scripts","Aceptar");
		dialog.cancelButtonText = util.translate ("scripts","Cancelar");

		var bgroup:Object = new GroupBox;
		dialog.add(bgroup);

		var nuevoPlan:Object = new RadioButton;
		nuevoPlan.text = util.translate ("scripts","Crear nuevo Cuadro de cuentas");
		nuevoPlan.checked = true;
		bgroup.add(nuevoPlan);

		var anteriorPlan:Object = new RadioButton;
		anteriorPlan.text = util.translate ("scripts","Seleccionar un ejercicio anterior y copiar su Cuadro de cuentas");
		anteriorPlan.checked = false;
		bgroup.add(anteriorPlan);

		if (!dialog.exec())
			return true;

		if (nuevoPlan.checked == true){
/** \D Si se selecciona crear un nuevo plan, se llama a flcontppal.generarPGC, que cargar� el plan por defecto y lo asociar� al ejercicio
\end */
			flcontppal.iface.pub_generarPGC(ejercicio);
			flcontppal.iface.pub_generarSubcuentas(ejercicio,logdigitos);
		}
		else {
/** \D Si se selecciona copiar un plan anterior, se abre la ventana de ejercicios para escoger el ejercicio del cual se copiar� el plan. Los pasos seguidos son los siguientes:
\end */
			var idEpigrafe:Number;
			var idEpigrafeNuevo:Number;
			var idPadre:Number;
			var idPadreNuevo:Number;
			var idCuenta:Number;
			var idCuentaNueva:Number;
			var codEpigrafe:String;
			var codPadre:String;
			var f:Object = new FLFormSearchDB("ejercicios");
			f.setMainWidget();
			
			// CAMBIO respecto de oficial
			f.cursor().setMainFilter("codejercicio <> '" + ejercicio + "' AND plancontable <> '08'");
			
			var ejeranterior:String = f.exec("codejercicio");
			
			if (!ejeranterior)
				return false;
			cursor.setValueBuffer("longsubcuenta", util.sqlSelect("ejercicios", "longsubcuenta", "codejercicio = '" + ejeranterior + "'"));
/** \D Se buscan los datos de la tabla epigrafes del ejercicio anterior y se insertan en el nuevo ejercicio
\end */
			var qryEpigrafe:FLSqlQuery = new FLSqlQuery;
			with(qryEpigrafe){
				setTablesList ("co_epigrafes,co_epigrafes");
				setSelect("e.idpadre,e.idepigrafe,e.codepigrafe,e.descripcion,p.codepigrafe");
				setFrom("co_epigrafes e LEFT OUTER JOIN co_epigrafes p ON e.idpadre = p.idepigrafe");
				setWhere("e.codejercicio = '" + ejeranterior +"'");
			}
			if (!qryEpigrafe.exec())
				return;

			var i:Number = 0;
			var j:Number = 0;

			var totalEpigrafes:Number = util.sqlSelect("co_epigrafes e LEFT OUTER JOIN co_epigrafes p ON e.idpadre = p.idepigrafe", "COUNT(e.idepigrafe)", "e.codejercicio = '" + ejeranterior + "'", "co_epigrafes");

			util.createProgressDialog(util.translate("scripts", "Copiando Cuadro de cuentas"), totalEpigrafes);

			while(qryEpigrafe.next()){
				idPadre = qryEpigrafe.value(0);
				idEpigrafe = qryEpigrafe.value(1);
				codEpigrafe = qryEpigrafe.value(2);
				var curEpigrafe:FLSqlCursor = new FLSqlCursor ("co_epigrafes");
				curEpigrafe.setModeAccess (curEpigrafe.Insert);
				curEpigrafe.refreshBuffer();
				curEpigrafe.setValueBuffer("codejercicio",ejercicio);
				curEpigrafe.setValueBuffer("codepigrafe",codEpigrafe);
				curEpigrafe.setValueBuffer("descripcion",qryEpigrafe.value(3));
				if(idPadre) {
					idPadreNuevo = util.sqlSelect("co_epigrafes", "idepigrafe", "codepigrafe = '" + qryEpigrafe.value(4) + "'" + " AND codejercicio = '" + ejercicio + "'");
					curEpigrafe.setValueBuffer("idpadre",idPadreNuevo);
				}
				if (!curEpigrafe.commitBuffer())
					return false;
				idEpigrafeNuevo  = curEpigrafe.valueBuffer("idepigrafe");

/** \D	Para las cuentas existentes para cada epigrafe, el idepigrafe, el idpadre y el codepigrafe son el mismo que el de el epigrafe al que pertenecen
\end */
				var qryCuentas:FLSqlQuery = new FLSqlQuery;
				with(qryCuentas){
					setTablesList ("co_cuentas");
					setSelect("codcuenta,descripcion,idcuentaesp,codepigrafe,codbalance,idcuenta");
					setFrom("co_cuentas");
					setWhere("idepigrafe = " + idEpigrafe);
				}
				if (!qryCuentas.exec())
					return;
				while(qryCuentas.next()) {
					idCuenta = qryCuentas.value(5);
					var curCuentas:FLSqlCursor = new FLSqlCursor ("co_cuentas");
					curCuentas.setModeAccess (curCuentas.Insert);
					curCuentas.refreshBuffer();
					curCuentas.setValueBuffer("codejercicio",ejercicio);
					curCuentas.setValueBuffer("codcuenta",qryCuentas.value(0));
					curCuentas.setValueBuffer("idepigrafe",idEpigrafeNuevo);
					curCuentas.setValueBuffer("codepigrafe",qryCuentas.value(3));
					curCuentas.setValueBuffer("descripcion",qryCuentas.value(1));
					curCuentas.setValueBuffer("idcuentaesp",qryCuentas.value(2));
					curCuentas.setValueBuffer("codbalance",qryCuentas.value(4));
					curCuentas.commitBuffer();
					codigocuenta = qryCuentas.value(0);
/** \D Se busca el idcuenta que se genera para cada cuenta para posteriormente poderlo enlazar con las subcuentas
\end */
					idCuentaNueva = curCuentas.valueBuffer("idcuenta");
					var qrySubCuentas:FLSqlQuery = new FLSqlQuery;
/** \D Se busca	la subcuenta para cada cuenta encontrada con el mismo ejercicio e idcuenta
\end */
					with(qrySubCuentas){
						setTablesList ("co_subcuentas");
						setSelect("codsubcuenta,codcuenta,descripcion,coddivisa,codimpuesto,iva");
						setFrom("co_subcuentas");
						setWhere("idcuenta = " + idCuenta);
					}
					if (!qrySubCuentas.exec())
						return;
					while(qrySubCuentas.next()){
						var curSubCuentas:FLSqlCursor = new FLSqlCursor ("co_subcuentas");
						curSubCuentas.setModeAccess (curSubCuentas.Insert);
						curSubCuentas.refreshBuffer();
						curSubCuentas.setValueBuffer("codejercicio",ejercicio);
						curSubCuentas.setValueBuffer("codsubcuenta",qrySubCuentas.value(0));
						curSubCuentas.setValueBuffer("idcuenta",idCuentaNueva);
						curSubCuentas.setValueBuffer("codcuenta",qrySubCuentas.value(1));
						curSubCuentas.setValueBuffer("descripcion",qrySubCuentas.value(2));
						curSubCuentas.setValueBuffer("coddivisa",qrySubCuentas.value(3));
						curSubCuentas.setValueBuffer("codimpuesto",qrySubCuentas.value(4));
						curSubCuentas.setValueBuffer("iva",qrySubCuentas.value(5));
						if (!curSubCuentas.commitBuffer())
							return;
					}
			}
				i++
				if (j++ > totalEpigrafes/10) {
					j = 0;
					util.setProgress(i);
				}
			}
			util.setProgress(totalEpigrafes);
			util.destroyProgressDialog();
			
			if (!this.iface.copiarSubcuentasCliProv(ejeranterior, ejercicio))
				return false;
		}
	}
	return true;
}

function pgc2008_validateForm():Boolean
{
		var fechaInicio:String = this.child("fdbFechaInicio").value();
		var fechaFin:String = this.child("fdbFechaFin").value();
		var util:FLUtil = new FLUtil;

/** \C
La fecha de inicio del ejercicio debe ser menor que la de fin
\end */
		if (fechaInicio > fechaFin) {
				MessageBox.warning(util.translate("scripts", "La fecha de inicio del ejercicio debe ser menor que la de fin"),
						 MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
		}

/** \C
Al menos una secuencia por serie debe a�adirse al ejercicio
\end */
		var cursor:FLSqlCursor = new FLSqlCursor("secuenciasejercicios");
		cursor.select("upper(codejercicio) = '" +
				this.cursor().valueBuffer("codejercicio").upper() + "';");
		if (!cursor.first()) {
				MessageBox.warning(util.translate("scripts", "Debe a�adir al menos una secuencia para el ejercicio\nen \"Secuencias por serie\""), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				return false;
		}

/** \C
La longitud de la subcuenta debe estar entre 5 y 15 caracteres
\end */
	var longSubcuenta:Number = parseFloat(this.cursor().valueBuffer("longsubcuenta"));
	if (longSubcuenta < 5 || longSubcuenta > 15) {
		MessageBox.warning(util.translate("scripts", "La longitud de la subcuenta debe estar entre 5 y 15 caracteres"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

	if (sys.isLoadedModule("flcontppal")) {
		if (!util.sqlSelect("co_epigrafes", "codejercicio", "codejercicio = '" + this.cursor().valueBuffer("codejercicio") + "'")) {
			MessageBox.information(util.translate("scripts", "Para generar el cuadro de cuentas asociado a este ejercicio,\nuse el bot�n 'Cuadro de cuentas' del formulario maestro de ejercicios"), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		}
	}
	return true;
}

//// PGC 2008 //////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////


/** @class_definition periodosFiscales */
//////////////////////////////////////////////////////////////////
//// PERIODOS FISCALES ///////////////////////////////////////////

function periodosFiscales_validateForm():Boolean
{
	if (!this.iface.__validateForm())
		return false;

	var util:FLUtil = new FLUtil();

	var cursor:FLSqlCursor = new FLSqlCursor("periodos");
	cursor.select("upper(codejercicio) = '" + this.cursor().valueBuffer("codejercicio").upper() + "'");
	if (!cursor.first()) {
		MessageBox.warning(util.translate("scripts", "Debe a�adir al menos un per�odo para el ejercicio."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
		return false;
	}

	return true;
}

//// PERIODOS FISCALES ///////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_definition silixSeries */
/////////////////////////////////////////////////////////////////
//// SILIX SERIES ///////////////////////////////////////////////

function silixSeries_validateForm():Boolean
{
	var util:FLUtil = new FLUtil();
	var cursor:FLSqlCursor = this.cursor();
	var curSec:FLSqlCursor = new FLSqlCursor("secuenciasejercicios");
	curSec.select("upper(codejercicio) = '" + cursor.valueBuffer("codejercicio").upper() + "';");
	if (!curSec.first()) {
		var ejercicioAnterior:String = util.sqlSelect("ejercicios", "codejercicio", " 1 = 1 ORDER BY fechafin DESC");
		if (ejercicioAnterior) {
			var curSecAnterior:FLSqlCursor = new FLSqlCursor("secuenciasejercicios");
			curSecAnterior.select("codejercicio = '" + ejercicioAnterior + "'");
			if (curSecAnterior.size() > 0) {
				var ans = MessageBox.information(util.translate("scripts", "Est� creando un nuevo ejercicio:\n �Desea copiar las series manejadas en el ejercicio anterior?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
				if (ans == MessageBox.Yes) {
					if (!this.child("tdbSecuencias").cursor().commitBufferCursorRelation())
						return false;
					while (curSecAnterior.next()) {
						curSec.setModeAccess(curSec.Insert);
						curSec.refreshBuffer();
						curSec.setValueBuffer("codejercicio", cursor.valueBuffer("codejercicio"));
						curSec.setValueBuffer("codserie", curSecAnterior.valueBuffer("codserie"));
						if (!curSec.commitBuffer())
							return false;

						var secuencias:FLSqlCursor = new FLSqlCursor("secuencias");
						var secuenciasAnt:FLSqlCursor = new FLSqlCursor("secuencias");
						secuenciasAnt.select("id = " + curSecAnterior.valueBuffer("id"));
						while (secuenciasAnt.next()) {
							secuencias.setModeAccess(secuencias.Insert);
							secuencias.refreshBuffer();
							secuencias.setValueBuffer("id", curSec.valueBuffer("id"));
							secuencias.setValueBuffer("nombre", secuenciasAnt.valueBuffer("nombre"));
							secuencias.setValueBuffer("descripcion", secuenciasAnt.valueBuffer("descripcion"));
							secuencias.setValueBuffer("valor", 1);
							secuencias.setValueBuffer("valorout", secuenciasAnt.valueBuffer("valorout"));
							if (!secuencias.commitBuffer())
								return false;
						}
					}
					MessageBox.information(util.translate("scripts", "Las series fueron copiadas correctamente."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				}
			}
		} else {
			var curSeries:FLSqlCursor = new FLSqlCursor("series");
			curSeries.select();
			if (curSeries.size() > 0) {
				var ans = MessageBox.information(util.translate("scripts", "Est� creando un ejercicio:\n �Desea cargar todas las series existentes para este ejercicio?"), MessageBox.Yes, MessageBox.No, MessageBox.NoButton);
				if (ans == MessageBox.Yes) {
					if (!this.child("tdbSecuencias").cursor().commitBufferCursorRelation())
						return false;
					while (curSeries.next()) {
						curSec.setModeAccess(curSec.Insert);
						curSec.refreshBuffer();
						curSec.setValueBuffer("codejercicio", cursor.valueBuffer("codejercicio"));
						curSec.setValueBuffer("codserie", curSeries.valueBuffer("codserie"));
						if (!curSec.commitBuffer())
							return false;
					}
					MessageBox.information(util.translate("scripts", "Las series fueron cargadas correctamente."), MessageBox.Ok, MessageBox.NoButton, MessageBox.NoButton);
				}
			}
		}
	}

	if ( !this.iface.__validateForm() )
		return false;

	return true;
}

//// SILIX SERIES /////////////////////////////////////////////
///////////////////////////////////////////////////////////////

/** @class_definition head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////