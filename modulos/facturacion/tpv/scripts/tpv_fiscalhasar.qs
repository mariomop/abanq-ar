/***************************************************************************
                 tpv_fiscalhasar.qs  -  description
                             -------------------
    begin                : mar feb 9 2010
    copyright            : Silix
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
//     function main() { this.ctx.interna_main(); }
}
//// INTERNA /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////
class oficial extends interna {
	// Caracter separador de campo
	const FS = String.fromCharCode( 28 );

	// Tipo de comprobante fiscal
	const FACTURA_A = "A";
	const FACTURA_BC = "B";
	const RECIBO_A = "a";
	const RECIBO_BC = "b";
	const NOTA_DEBITO_A = "D";
	const NOTA_DEBITO_BC = "E";

	// Responsabilidad frente al IVA
	/** Responsabilidad frente al IVA: Responsable inscripto */
	const RESPONSABLE_INSCRIPTO = "I";
	/** Responsabilidad frente al IVA: Responsable no inscripto */
	const RESPONSABLE_NO_INSCRIPTO = "N";
	/** Responsabilidad frente al IVA: Exento */
	const EXENTO = "E";
	/** Responsabilidad frente al IVA: No responsable */
	const NO_RESPONSABLE = "A";
	/** Responsabilidad frente al IVA: Consumidor final */
	const CONSUMIDOR_FINAL = "C";
	/** Responsabilidad frente al IVA: Responsable no inscripto, venta de bienes de uso */
	const RESPONSABLE_NO_INSCRIPTO_BIENES_DE_USO = "B";
	/** Responsabilidad frente al IVA: Responsable monotributo */
	const RESPONSABLE_MONOTRIBUTO = "M";
	/** Responsabilidad frente al IVA: Monotributista social */
	const MONOTRIBUTISTA_SOCIAL = "S";
	/** Responsabilidad frente al IVA: Pequeño contribuyente eventual */
	const PEQUENO_CONTRIBUYENTE_EVENTUAL = "S";
	/** Responsabilidad frente al IVA: Pequeño contribuyente eventual social */
	const PEQUENO_CONTRIBUYENTE_EVENTUAL_SOCIAL = "S";
	/** Responsabilidad frente al IVA: No categorizado */
	const NO_CATEGORIZADO = "T";

	// Tipo de documento  
	/** C.U.I.T. */
	const CUIT = "C";
	/** C.U.I.L. */
	const CUIL = "L";
	/** Libreta de enrolamiento */
	const LIBRETA_DE_ENROLAMIENTO = "0";
	/** Libreta cívica */
	const LIBRETA_CIVICA = "1";
	/** Documento nacional de identidad */
	const DNI = "2";
	/** Pasaporte */
	const PASAPORTE = "3";
	/** Cédula de identidad */
	const CEDULA = "4";
	/** Sin calificador */
	const SIN_CALIFICADOR = " ";

	// Formato de código de barras
	/** Código de barras EAN 13 */
	const EAN_13 = 1;
	/** Código de barras EAN 8 */
	const EAN_8 = 2;
	/** Código de barras UPCA */
	const UPCA  = 3;
	/** Código de barras ITS 2 de 5 */
	const ITS = 4;
	
	///////////////////////////////////////////////////////////////////////
	// Códigos de los comandos
	///////////////////////////////////////////////////////////////////////
	
	// Comandos de configuración y consulta

	/** Consultar estado. (0x2A) */
	const CMD_STATUS_REQUEST		= "*";
	/** Consultar estado intermedio. (0xA1) */
	const CMD_STATPRN			= "¡";
	/** Consultar versión del controlador fiscal. (0x7F) */
	const CMD_GET_FISCAL_DEVICE_VERSION	= String.fromCharCode( 127 );
	/** Dar de baja la memoria fiscal. (0xB1) */
	const CMD_KILL_FISCAL_MEMORY		= String.fromCharCode( 177 );
	/** Cambiar velocidad de comunicación. (0xA0) */
	const CMD_SET_COM_SPEED			= String.fromCharCode( 160 );
	/** Cambiar fecha y hora. (0x58) */
	const CMD_SET_DATE_TIME			= "X";
	/** Consultar fecha y hora. (0x59) */
	const CMD_GET_DATE_TIME			= "Y";
	/** Cargar configuración, comando nuevo. (0x95) */
	const CMD_SET_GENERAL_CONFIGURATION	= String.fromCharCode( 149 );
	/** Consultar configuración, comando nuevo. (0x96) */
	const CMD_GET_GENERAL_CONFIGURATION	= String.fromCharCode( 150 );
	/** Cargar configuración, comando viejo. (0x65) */
	const CMD_SET_CONFIGURATION_BY_BLOCK	= "e";
	/** Consultar configuración, comando viejo. (0x66) */
	const CMD_GET_CONFIGURATION_BY_BLOCK	= "f";
	/** Cargar configuración por parámetro. (0x64) */
	const CMD_SET_CONFIGURATION_BY_ONE	= "d";
	/** Consultar datos de inicialización. (0x73) */
	const CMD_GET_INIT_DATA			= "s";
	/** Cambiar responsabilidad frente al IVA. (0x63) */
	const CMD_CHANGE_IVA_RESPONSIBILITY	= "c";
	/** Cambiar número de Ingresos Brutos. (0x6E) */
	const CMD_CHANGE_IB_NUMBER		= "n";
	/** Cargar nombre de fantasía del propietario. (0x5F) */
	const CMD_SET_FANTASY_NAME		= "_";
	/** Consultar nombre de fantasía del propietario. (0x92) */
	const CMD_GET_FANTASY_NAME		= String.fromCharCode( 146 );
	/** Cargar encabezamiento y pie de documentos. (0x5D) */
	const CMD_SET_HEADER_TRAILER		= "]";
	/** Consultar encabezamiento y pie de documentos. (0x5E) */
	const CMD_GET_HEADER_TRAILER 		= "^";
	/** Cargar logotipo del cliente. (0x90) */
	const CMD_STORE_LOGO_DATA		= String.fromCharCode( 144 );
	/** Borrar logotipo del cliente. (0x91) */
	const CMD_RESET_LOGO_DATA		= String.fromCharCode( 145 );

	// Comandos de control fiscal

	/** Consultar capacidad restante de registros diarios. (0x37) */
	const CMD_GET_HISTORY_CAPACITY		= "7";
	/** Cerrar jornada fiscal imprimiendo reporte. (0x39) */
	const CMD_DAILY_CLOSE			= "9";
	/** Imprimir reporte de auditoría por fecha. (0x3A) */
	const CMD_DAILY_CLOSE_BY_DATE		= ":";
	/** Imprimir reporte de auditoría por número de Z. (0x3B) */
	const CMD_DAILY_CLOSE_BY_NUMBER		= ";";
	/** Consultar registro diario. (0x3C) */
	const CMD_GET_DAILY_REPORT		= "<";
	/** Consultar memoria de trabajo. (0x67) */
	const CMD_GET_WORKING_MEMORY		= "g";
	/** Iniciar consulta de la información de IVA. (0x70) */
	const CMD_SEND_FIRST_IVA		= "p";
	/** Continuar consulta de la información de IVA. (0x71) */
	const CMD_NEXT_TRANSMISSION		= "q";

	// Comandos comunes a varios tipos de documentos

	/** Cancelar documento. (0x98) */
	const CMD_CANCEL_DOCUMENT		= String.fromCharCode( 152 );
	/** Reimprimir el último documento emitido. (0x99) */
	const CMD_REPRINT_DOCUMENT		= String.fromCharCode( 153 );
	/** Cargar código de barras. (0x5A) */
	const CMD_SET_BAR_CODE			= "Z";
	/** Cargar datos del cliente. (0x62) */
	const CMD_SET_CUSTOMER_DATA		= "b";
	/** Cargar información de remito o de comprobante original. (0x93) */
	const CMD_SET_EMBARK_NUMBER		= String.fromCharCode( 147 );
	/** Consultar información de remito o de comprobante original. (0x94) */
	const CMD_GET_EMBARK_NUMBER		= String.fromCharCode( 148 );
	/** Avanzar papel de ticket. (0x50) */
	const CMD_FEED_TICKET			= "P";
	/** Avanzar papel de auditoría. (0x51) */
	const CMD_FEED_JOURNAL			= "Q";
	/** Avanzar papeles de ticket y auditoría. (0x52) */
	const CMD_FEED_TICKET_AND_JOURNAL	= "R";

	// Comandos de documentos fiscales

	/** DF: Abrir documento fiscal. (0x40) */
	const CMD_OPEN_FISCAL_RECEIPT		= "@";
	/** DF: Imprimir texto fiscal. (0x41) */
	const CMD_PRINT_FISCAL_TEXT		= "A";
	/** DF: Imprimir ítem. (0x42) */
	const CMD_PRINT_LINE_ITEM		= "B";
	/** DF: Descuento o recargo sobre el último ítem. (0x55) */
	const CMD_LAST_ITEM_DISCOUNT		= "U";
	/** DF: Descuento general. (0x54) */
	const CMD_GENERAL_DISCOUNT		= "T";
	/** DF: Devolución de envases, bonificaciones y recargos. (0x6D) */
	const CMD_RETURN_RECHARGE		= "m";
	/** DF: Recargo de IVA a responsable no inscripto. (0x61) */
	const CMD_CHARGE_NON_REGISTERED_TAX	= "a";
	/** DF: Percepciones sobre el IVA. (0x60) */
	const CMD_PERCEPTIONS			= "`";
	/** DF: Consultar subtotal. (0x43) */
	const CMD_SUBTOTAL			= "C";
	/** DF: Definir líneas de texto en recibos. (0x97) */
	const CMD_RECEIPT_TEXT			= String.fromCharCode( 151 );
	/** DF: Imprimir total y pago. (0x44) */
	const CMD_TOTAL_TENDER			= "D";
	/** DF: Cerrar documento fiscal. (0x45) */
	const CMD_CLOSE_FISCAL_RECEIPT		= "E";

	// Comandos de documentos no fiscales

	/** DNF: Abrir documento no fiscal en impresora Ticket. (0x48) */
	const CMD_OPEN_NON_FISCAL_RECEIPT	= "H";
	/** DNF: Abrir documento no fiscal en impresora Slip. (0x47) */
	const CMD_OPEN_NFD_SLIP			= "G";
	/** DNF: Imprimir texto no fiscal. (0x49) */
	const CMD_PRINT_NON_FISCAL_TEXT		= "I";
	/** DNF: Cerrar documento no fiscal. (0x4A) */
	const CMD_CLOSE_NON_FISCAL_RECEIPT	= "J";
	/** DNF: Cortar documento no fiscal. (0x4B) */
	const CMD_CUT_NFD			= "K";

	// Comandos de documentos no fiscales homologados

	/** DNFH: Abrir documento no fiscal homologado. (0x80) */
	const CMD_OPEN_DNFH			= String.fromCharCode( 128 );
	/** DNFH: Imprimir ítem en remito u orden de salida. (0x82) */
	const CMD_PRINT_EMBARK_ITEM		= String.fromCharCode( 130 );
	/** DNFH: Imprimir ítem en resumen de cuenta o en cargo a la habitación. (0x83) */
	const CMD_PRINT_ACCOUNT_ITEM		= String.fromCharCode( 131 );
	/** DNFH: Imprimir ítem en cotización. (0x84) */
	const CMD_PRINT_QUOTATION_ITEM		= String.fromCharCode( 132 );
	/** DNFH: Cerrar documento no fiscal homologado. (0x81) */
	const CMD_CLOSE_DNFH			= String.fromCharCode( 129 );
	/** Imprimir documento no fiscal homologado para farmacias. (0x68) */
	const CMD_PRINT_PHARMACY_NFHD		= "h";
	/** Imprimir documento no fiscal homologado para reparto. (0x69) */
	const CMD_PRINT_DELIVERY_NFHD		= "i";

	// Comandos de documentos voucher

	/** Voucher: Iniciar carga de datos del voucher. (0x6A) */
	const CMD_SET_VOUCHER_DATA_1		= "j";
	/** Voucher: Finalizar carga de datos del voucher. (0x6B) */
	const CMD_SET_VOUCHER_DATA_2		= "k";
	/** Voucher: Imprimir voucher. (0x6C) */
	const CMD_PRINT_VOUCHER			= "l";

	// Otros comandos

	/** Abrir cajón de dinero. (0x7B) */
	const CMD_OPEN_DRAWER			= "{";
	/** Escribir en visor. (0xB2) */
	const CMD_WRITE_DISPLAY			= String.fromCharCode( 178 );
	/** Seleccionar fuente de doble ancho para imprimir la línea */
	const CMD_DOUBLE_WIDTH			= String.fromCharCode( 244 );

	///////////////////////////////////////////////////////////////////////
	// ESTADO DE IMPRESORA 
	///////////////////////////////////////////////////////////////////////

	/** Impresora ocupada. (Bit 0 del estado de impresora) */
	const PST_PRINTER_BUSY			= 0x0001;
	/** Error de impresora. (Bit 2 del estado de impresora) */
	const PST_PRINTER_ERROR			= 0x0004;
	/** Impresora fuera de línea. No ha podido comunicarse con la impresora dentro del período de tiempo establecido. (Bit 3 del estado de impresora) */
	const PST_PRINTER_OFFLINE		= 0x0008;
	/** Falta papel del diario. (Bit 4 del estado de impresora) */
	const PST_JOURNAL_PAPER_OUT		= 0x0010;
	/** Falta papel de tickets. (Bit 5 del estado de impresora) */
	const PST_TICKET_PAPER_OUT		= 0x0020;
	/** Buffer de impresión lleno. Cualquier comando que se envíe 
	 * cuando este bit está en 1 no se ejecuta y debe ser reenviado 
	 * por la aplicación. (Bit 6 del estado de impresora) */
	const PST_PRINT_BUFFER_FULL		= 0x0040;
	/** Buffer de impresión vacío. Todos los comandos fueron 
	 * enviados a la impresora. (Bit 7 del estado de impresora) */
	const PST_PRINT_BUFFER_EMPTY		= 0x0080;
	/** Tapa de impresora abierta. (Bit 8 del estado de impresora) */
	const PST_PRINTER_COVER_OPEN		= 0x0100;

	/** Cajón de dinero cerrado o ausente. (Bit 14 del estado de impresora) */
	const PST_MONEY_DRAWER_CLOSED		= 0x4000;
	/** Suma lógica (OR) de los bits 2 a 5, 8 y 14. Este bit se 
	 * encuentra en 1 siempre que alguno de los bits mencionados 
	 * se encuentre en 1. (Bit 15 del estado de impresora) */
	const PST_BITWISE_OR			= 0x8000;

	///////////////////////////////////////////////////////////////////////
	// ESTADO FISCAL 
	///////////////////////////////////////////////////////////////////////
	
	/** Error en chequeo de memoria fiscal. Al encenderse la 
	 * impresora se produjo un error en el checksum. La impresora no 
	 * funcionará. (Bit 0 de estado fiscal) */
	const FST_FISCAL_MEMORY_CRC_ERROR	= 0x0001;
	/** Error en chequeo de memoria de trabajo. Al encenderse la impresora 
	 * se produjo un error en el checksum. La impresora no funcionará. 
	 * (Bit 1 de estado fiscal) */
	const FST_WORKING_MEMORY_CRC_ERROR	= 0x0002;
	/** Comando desconocido. El comando recibido no fue reconocido. 
	 * (Bit 3 de estado fiscal) */
	const FST_UNKNOWN_COMMAND		= 0x0008;
	/** Datos inválidos en un campo. Uno de los campos del comando recibido 
	 * tiene datos no válidos (por ejemplo, datos no numéricos en un campo 
	 * numérico). (Bit 4 de estado fiscal) */
	const FST_INVALID_DATA_FIELD		= 0x0010;
	/** Comando inválido para el estado fiscal actual. Se ha recibido un 
	 * comando que no es válido en el estado actual del controlador (por 
	 * ejemplo, abrir un documento no fiscal cuando se encuentra abierto un 
	 * documento fiscal). (Bit 5 de estado fiscal) */
	const FST_INVALID_COMMAND		= 0x0020;
	/** Desborde de acumulador. El acumulador de una transacción, del total 
	 * diario o del IVA se desbordará a raíz de un comando recibido. El comando 
	 * no es ejecutado. Este bit debe ser monitoreado por la aplicación para 
	 * emitir el correspondiente aviso. (Bit 6 de estado fiscal) */
	const FST_ACCUMULATOR_OVERFLOW		= 0x0040;
	/** Memoria fiscal llena, bloqueada o dada de baja. No se permite abrir un 
	 * comprobante fiscal. (Bit 7 de estado fiscal) */
	const FST_FISCAL_MEMORY_FULL		= 0x0080;
	/** Memoria fiscal a punto de llenarse. La memoria fiscal tiene 30 o menos 
	 * registros libres. Este bit debe ser monitoreado por la aplicación para 
	 * emitir el correspondiente aviso. (Bit 8 de estado fiscal) */
	const FST_FISCAL_MEMORY_ALMOST_FULL	= 0x0100;
	/** Terminal fiscal certificada. Indica que la impresora ha sido 
	 * inicializada. (Bit 9 de estado fiscal) */
	const FST_DEVICE_CERTIFIED		= 0x0200;
	/** Terminal fiscal fiscalizada. Indica que la impresora ha sido 
	 * inicializada. (Bit 10 de estado fiscal) */
	const FST_DEVICE_FISCALIZED		= 0x0400;
	/** Error en ingreso de fecha. Se ha ingresado una fecha inválida. 
	 * Para volver el bit a 0 debe ingresarse una fecha válida. 
	 * (Bit 11 de estado fiscal) */
	const FST_DATE_ERROR			= 0x0800;
	/** Documento fiscal abierto. Este bit se encuentra en 1 siempre que un 
	 * documento fiscal (factura, recibo oficial o nota de crédito) se encuentra 
	 * abierto. (Bit 12 de estado fiscal) */
	const FST_FISCAL_DOCUMENT_OPEN		= 0x1000;
	/** Documento abierto (solo impresoras que soportan STATPRN). Este bit se 
	 * encuentra en 1 siempre que un documento (fiscal, no fiscal o no fiscal 
	 * homologado) se encuentra abierto. (Bit 13 de estado fiscal) */
	const FST_DOCUMENT_OPEN			= 0x2000;
	/** Estado intermedio (STATPRN) activo (solo impresoras que soportan 
	 * STATPRN). Este bit se encuentra en 1 cuando se intenta enviar un 
	 * comando estando activado el STATPRN. El comando es rechazado. 
	 * (Bit 14 de estado fiscal) */
	const FST_STATPRN_ACTIVE		= 0x4000;
	/** Documento abierto en impresora Ticket (solo impresoras que no soportan 
	 * STATPRN). (Bit 13 de estado fiscal) */
	const FST_DOCUMENT_OPEN_TICKET		= 0x2000;
	/** Documento abierto en impresora Slip (solo impresoras que no 
	 * soportan STATPRN). (Bit 14 de estado fiscal) */
	const FST_DOCUMENT_OPEN_SLIP		= 0x4000;
	/** Suma lógica (OR) de los bits 0 a 8. Este bit se encuentra en 1 
	 * siempre que alguno de los bits mencionados se encuentre en 1. 
	 * (Bit 15 de estado fiscal) */
	const FST_BITWISE_OR			= 0x8000;

	/** Conjunto de caracteres para realizar la conversión a string de los paquetes fiscales */
	var encoding = "ISO8859_1";	// ISO 8859-1, Latin alphabet No. 1.
	/** Año base para validación de fechas */
	var baseRolloverYear = 1997;
	/** Estado actual de la impresora */
	var printerStatus;
	/** Estado actual del controlador fiscal */
	var fiscalStatus;
	/** Posibles mensajes de estado de la impresora */
	var printerStatusMsgs;
	/** Posibles mensajes de estado del controlador fiscal */
	var fiscalStatusMsgs;
	/** Códigos de mensajes de estado de la impresora */
	var printerStatusCodes:Array = [ PST_PRINTER_ERROR, PST_PRINTER_OFFLINE, PST_JOURNAL_PAPER_OUT, PST_TICKET_PAPER_OUT, PST_PRINTER_COVER_OPEN, PST_MONEY_DRAWER_CLOSED, PST_BITWISE_OR, PST_PRINTER_BUSY, PST_PRINT_BUFFER_FULL, PST_PRINT_BUFFER_EMPTY ];
	/** Códigos de mensajes de estado del controlador fiscal */
	var fiscalStatusCodes:Array = [ FST_FISCAL_MEMORY_CRC_ERROR, FST_WORKING_MEMORY_CRC_ERROR, FST_UNKNOWN_COMMAND, FST_INVALID_DATA_FIELD, FST_INVALID_COMMAND, FST_ACCUMULATOR_OVERFLOW, FST_FISCAL_MEMORY_FULL, FST_FISCAL_MEMORY_ALMOST_FULL, FST_DATE_ERROR, FST_STATPRN_ACTIVE, FST_DOCUMENT_OPEN_TICKET, FST_DOCUMENT_OPEN_SLIP, FST_BITWISE_OR, FST_FISCAL_DOCUMENT_OPEN, FST_DOCUMENT_OPEN, FST_DEVICE_CERTIFIED, FST_DEVICE_FISCALIZED ];

	/** Mapeo entre categorias de IVA de las clases de documentos y los valores
	 * esperados por las impresoras fiscales de esta marca. */
	var ivaResponsabilities;
	/** Mapeo entre los tipos de identificación de clientes de las clases
	 * de documentos y los valores esperados por las impresoras de esta marca. */
	var identificationTypes;
	/** Mapeo entre los tipos de documentos de las clases de documentos y 
	 * los valores esperados por las impresoras de esta marca. */
	var documentTypes;

	///////////////////////////////////////////////////////////////////////
	// Funciones generales
	///////////////////////////////////////////////////////////////////////
	function oficial( context ) { interna( context ); } 

	function getModelo():String {
		return this.ctx.oficial_getModelo();
	}
	function buildCommand(cmd:Array):String {
		return this.ctx.oficial_buildCommand(cmd);
	}
	function formatText(text:String, maxLength:Number):String {
		return this.ctx.oficial_formatText(text, maxLength);
	}
	function formatNumber(number:Number, integerPart:Number, decimalPart:Number):String {
		return this.ctx.oficial_formatNumber(number, integerPart, decimalPart);
	}
	function formatDate(date:Date):String {
		return this.ctx.oficial_formatDate(date);
	}
	function formatTime(date:Date):String {
		return this.ctx.oficial_formatTime(date);
	}
	function formatDocType(docType:String):String {
		return this.ctx.oficial_formatDocType(docType);
	}
	function formatDocNumber(docType:String, docNumber:String):String {
		return this.ctx.oficial_formatDocNumber(docType, docNumber);
	}
	function formatIVAResponsability(ivaResponsability:String):String {
		return this.ctx.oficial_formatIVAResponsability(ivaResponsability);
	}
	function formatComprobante(comprobante:String):String {
		return this.ctx.oficial_formatComprobante(comprobante);
	}

	///////////////////////////////////////////////////////////////////////
	// Funciones para el estatus de la impresora e identificación de errores
	///////////////////////////////////////////////////////////////////////
	function procesarEstadoImpresora(status:Number) {
		return this.ctx.oficial_procesarEstadoImpresora(status);
	}
	function getEstadoImpresora():Number {
		return this.ctx.oficial_getEstadoImpresora();
	}
	function getEstadoImpresoraMsgs():String {
		return this.ctx.oficial_getEstadoImpresoraMsgs();
	}

	function procesarEstadoFiscal(status:Number) {
		return this.ctx.oficial_procesarEstadoFiscal(status);
	}
	function getEstadoFiscal():Number {
		return this.ctx.oficial_getEstadoFiscal();
	}
	function getEstadoFiscalMsgs():String {
		return this.ctx.oficial_getEstadoFiscalMsgs();
	}

	///////////////////////////////////////////////////////////////////////
	// Comandos de inicialización, baja y configuración.
	///////////////////////////////////////////////////////////////////////
	function cmdSetComSpeed(speed:Number):String {
		return this.ctx.oficial_cmdSetComSpeed(speed);
	}
	function cmdSetGeneralConfiguration(printConfigReport:Boolean, loadDefaultData:Boolean,
			finalConsumerLimit:Number, ticketInvoiceLimit:Number, ivaNonInscript:Number, 
			copies:Number, printChange:Boolean, printLabels:Boolean, ticketCutType:String, printFramework:Boolean, 
			reprintDocuments:Boolean, balanceText:String, paperSound:Boolean, paperSize:String):String {
		return this.ctx.oficial_cmdSetGeneralConfiguration(printConfigReport, loadDefaultData,
				finalConsumerLimit, ticketInvoiceLimit, ivaNonInscript, 
				copies, printChange, printLabels, ticketCutType, printFramework, 
				reprintDocuments, balanceText, paperSound, paperSize);
	}
	function cmdChangeIVAResponsibility(ivaResponsability:String):String {
		return this.ctx.oficial_cmdChangeIVAResponsibility(ivaResponsability);
	}

	///////////////////////////////////////////////////////////////////////
	// Comandos de diagnóstico y consulta
	///////////////////////////////////////////////////////////////////////
	function cmdStatusRequest():String {
		return this.ctx.oficial_cmdStatusRequest();
	}
	function cmdSTATPRN():String {
		return this.ctx.oficial_cmdSTATPRN();
	}
	function cmdGetGeneralConfigurationData():String {
		return this.ctx.oficial_cmdGetGeneralConfigurationData();
	}

	///////////////////////////////////////////////////////////////////////
	// Comandos de control fiscal
	///////////////////////////////////////////////////////////////////////
	function cmdDailyClose(docType:String):String {
		return this.ctx.oficial_cmdDailyClose(docType);
	}
	function cmdGetWorkingMemory():String {
		return this.ctx.oficial_cmdGetWorkingMemory();
	}
	function cmdSendFirstIVA():String {
		return this.ctx.oficial_cmdSendFirstIVA();
	}

	///////////////////////////////////////////////////////////////////////
	// Comandos de comprobante fiscal y nota de crédito
	///////////////////////////////////////////////////////////////////////
	function cmdOpenFiscalReceipt(docType:String):String {
		return this.ctx.oficial_cmdOpenFiscalReceipt(docType);
	}
	function cmdPrintFiscalText(text:String, display:Number):String {
		return this.ctx.oficial_cmdPrintFiscalText(text, display);
	}
	function cmdPrintLineItem(description:String, quantity:Number, price:Number, ivaPercent:Number,
			substract:Boolean, internalTaxes:Number, basePrice:Boolean, display:Number):String {
		return this.ctx.oficial_cmdPrintLineItem(description, quantity, price, ivaPercent,
				substract, internalTaxes, basePrice, display);
	}
	// igual a la anterior, pero añade el parámetro descMaxLength, para aquellas impresoras en las que es distinta la logitud máxima en el campo descripción
	function cmdPrintLineItem(description:String, quantity:Number, price:Number, ivaPercent:Number,
			substract:Boolean, internalTaxes:Number, basePrice:Boolean, display:Number, descMaxLength:Number):String {
		return this.ctx.oficial_cmdPrintLineItem(description, quantity, price, ivaPercent,
				substract, internalTaxes, basePrice, display, descMaxLength);
	}
	function cmdLastItemDiscount(description:String, amount:Number, substract:Boolean, baseAmount:Boolean, display:Number):String {
		return this.ctx.oficial_cmdLastItemDiscount(description, amount, substract, baseAmount, display);
	}
	function cmdGeneralDiscount(description:String, amount:Number, substract:Boolean, baseAmount:Boolean, display:Number):String {
		return this.ctx.oficial_cmdGeneralDiscount(description, amount, substract, baseAmount, display);
	}
	function cmdPerceptions(description:String, amount:Number, alicuotaIVA:Number):String {
		return this.ctx.oficial_cmdPerceptions(description, amount, alicuotaIVA);
	}
	function cmdSubtotal(print:Boolean, display:Number):String {
		return this.ctx.oficial_cmdSubtotal(print, display);
	}
	function cmdTotalTender(description:String, amount:Number, cancel:Boolean, display:Number):String {
		return this.ctx.oficial_cmdTotalTender(description, amount, cancel, display);
	}

	function cmdCloseFiscalReceipt(copies:Number):String {
		return this.ctx.oficial_cmdCloseFiscalReceipt(copies);
	}
	
	///////////////////////////////////////////////////////////////////////
	// Comandos de comprobante no fiscal
	///////////////////////////////////////////////////////////////////////
	function cmdOpenNonFiscalReceipt():String {
		return this.ctx.oficial_cmdOpenNonFiscalReceipt();
	}
	function cmdPrintNonFiscalText(text:String, display:Number):String {
		return this.ctx.oficial_cmdPrintNonFiscalText(text, display);
	}

	function cmdCloseNonFiscalReceipt(copies:Number):String {
		return this.ctx.oficial_cmdCloseNonFiscalReceipt(copies);
	}
	
	///////////////////////////////////////////////////////////////////////
	// Comandos de documentos no fiscales homologados
	///////////////////////////////////////////////////////////////////////
	function cmdOpenDNFH(docType:String, identification:String):String {
		return this.ctx.oficial_cmdOpenDNFH(docType, identification);
	}
	function cmdPrintEmbarkItem(description:String, quantity:Number, display:Number):String {
		return this.ctx.oficial_cmdPrintEmbarkItem(description, quantity, display);
	}
	function cmdPrintAccountItem(date:Date, docNumber:String, description:String, debitAmount:Number, creditAmount:Number, display:Number):String {
		return this.ctx.oficial_cmdPrintAccountItem(date, docNumber, description, debitAmount, creditAmount, display);
	}
	function cmdPrintQuotationItem(description:String, display:Number):String {
		return this.ctx.oficial_cmdPrintQuotationItem(description, display);
	}
	function cmdCloseDNFH(copies:Number):String {
		return this.ctx.oficial_cmdCloseDNFH(copies);
	}
	
	///////////////////////////////////////////////////////////////////////
	// Comandos comunes a varios tipos de documentos
	///////////////////////////////////////////////////////////////////////
	function cmdCancelDocument():String {
		return this.ctx.oficial_cmdCancelDocument();
	}
	function cmdReprint():String {
		return this.ctx.oficial_cmdReprint();
	}
	function cmdBarCode(codeType:Number, data:String, printNumbers:Boolean):String {
		return this.ctx.oficial_cmdBarCode(codeType, data, printNumbers);
	}
	
	///////////////////////////////////////////////////////////////////////
	// Comandos de fecha, hora, encabezamiento y cola de documentos
	///////////////////////////////////////////////////////////////////////
	function cmdSetDateTime(dateTime:Date):String {
		return this.ctx.oficial_cmdSetDateTime(dateTime);
	}
	function cmdGetDateTime():String {
		return this.ctx.oficial_cmdGetDateTime();
	}
	function cmdSetFantasyName(line:Number, text:String):String {
		return this.ctx.oficial_cmdSetFantasyName(line, text);
	}
	function cmdGetFantasyName(line:Number):String {
		return this.ctx.oficial_cmdGetFantasyName(line);
	}
	function cmdSetHeaderTrailer(line:Number, text:String):String {
		return this.ctx.oficial_cmdSetHeaderTrailer(line, text);
	}
	function cmdGetHeaderTrailer(line:Number):String {
		return this.ctx.oficial_cmdGetHeaderTrailer(line);
	}
	function cmdSetCustomerData(name:String, customerDocNumber:String, ivaResponsibility:String, docType:String, location:String):String {
		return this.ctx.oficial_cmdSetCustomerData(name, customerDocNumber, ivaResponsibility, docType, location);
	}
	function cmdSetEmbarkNumber(line:Number, text:String):String {
		return this.ctx.oficial_cmdSetEmbarkNumber(line, text);
	}
	function cmdGetEmbarkNumber(line:Number):String {
		return this.ctx.oficial_cmdGetEmbarkNumber(line)
	}
	
	///////////////////////////////////////////////////////////////////////
	// Comandos para tipos de letra
	///////////////////////////////////////////////////////////////////////
	function cmdDoubleWidth():String {
		return this.ctx.oficial_cmdDoubleWidth();
	}

}

//// OFICIAL /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

/** @class_declaration implementaciones */
/////////////////////////////////////////////////////////////
//// IMPLEMENTACIONES  //////////////////////////////////////
class implementaciones extends oficial {
	function implementaciones( context ) { oficial ( context ); }

	function cmdSetGeneralConfiguration(printConfigReport:Boolean, loadDefaultData:Boolean, finalConsumerLimit:Number, ticketInvoiceLimit:Number,
			ivaNonInscript:Number, copies:Number, printChange:Boolean, printLabels:Boolean, ticketCutType:String, printFramework:Boolean, 
			reprintDocuments:Boolean, balanceText:String, paperSound:Boolean, paperSize:String):String {
		return this.ctx.implementaciones_cmdSetGeneralConfiguration(printConfigReport, loadDefaultData, finalConsumerLimit, ticketInvoiceLimit,
			ivaNonInscript, copies, printChange, printLabels, ticketCutType, printFramework, 
			reprintDocuments, balanceText, paperSound, paperSize);
	}
	function cmdPrintFiscalText(text:String, display:Number):String {
		return this.ctx.implementaciones_cmdPrintFiscalText(text, display);
	}
	function cmdPrintLineItem(description:String, quantity:Number, price:Number, ivaPercent:Number,
			substract:Boolean, internalTaxes:Number, basePrice:Boolean, display:Number):String {
		return this.ctx.implementaciones_cmdPrintLineItem(description, quantity, price, ivaPercent,
				substract, internalTaxes, basePrice, display);
	}
	function cmdLastItemDiscount(description:String, amount:Number, substract:Boolean, baseAmount:Boolean, display:Number):String {
		return this.ctx.implementaciones_cmdLastItemDiscount(description, amount, substract, baseAmount, display);
	}
	function cmdSubtotal(print:Boolean, display:Number):String {
		return this.ctx.implementaciones_cmdSubtotal(print, display);
	}
	function cmdTotalTender(description:String, amount:Number, cancel:Boolean, display:Number):String {
		return this.ctx.implementaciones_cmdTotalTender(description, amount, cancel, display);
	}
	function cmdCloseFiscalReceipt(copies:Number):String {
		return this.ctx.implementaciones_cmdCloseFiscalReceipt(copies);
	}
	function cmdCloseDNFH(copies:Number):String {
		return this.ctx.implementaciones_cmdCloseDNFH(copies);
	}
}
//// IMPLEMENTACIONES ///////////////////////////////////////
/////////////////////////////////////////////////////////////

/** @class_declaration head */
/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////
class head extends implementaciones {
    function head( context ) { implementaciones ( context ); }
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

function interna_init() 
{

}

//// INTERNA /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_definition oficial */
//////////////////////////////////////////////////////////////////
//// OFICIAL /////////////////////////////////////////////////////

function oficial_getModelo():String {
	var util:FLUtil = new FLUtil();
	var codPuntoVenta:String = util.readSettingEntry("scripts/fltpv_ppal/codTerminal");
	var qry:FLSqlQuery = new FLSqlQuery();
	qry.setTablesList("tpv_puntosventa");
	qry.setSelect("tipoimpresora,fiscalhasar,tipoimpresorafiscalhasar");
	qry.setFrom("tpv_puntosventa");
	qry.setWhere("codtpv_puntoventa = '" + codPuntoVenta + "'");
	if (!qry.exec()) return "";
	if (!qry.first()) return "";
	if (qry.value("tipoimpresora") == "Fiscal" && qry.value("fiscalhasar"))
		return qry.value("tipoimpresorafiscalhasar");
	else return "";
}

function oficial_buildCommand(cmd:Array):String {
	return cmd.join(this.iface.FS);
}

function oficial_formatText(text:String, maxLength:Number):String {
	if (text != "" && text.length > maxLength)
		text = text.substring(0, maxLength);
	return text;
}

function oficial_formatNumber(number:Number, integerPart:Number, decimalPart:Number):String {
	var num:String = number.toString();
	var pointIndex = num.indexOf(".");
	if (pointIndex == -1) {
		num = number.toString() + ".";
		for ( var i:Number = 1; i <= decimalPart; num += "0", i++);
	} else if (num.substring(pointIndex + 1).length > decimalPart)
		num = num.substring(0, num.indexOf(".") + decimalPart);
	return num;
}

function oficial_formatDate(date:Date):String {
	var text:String = date.getYear().toString();
	return text.right(2) + date.getMonth().toString() + date.getDate().toString();
}

function oficial_formatTime(date:Date):String {
	return date.getHours().toString() + date.getMinutes().toString() + date.getSeconds().toString();
}

function oficial_formatDocType(docType:String):String {
	var result:String;
	switch (docType) {
		case "DNI":
			result = this.iface.DNI;
			break;
		case "CUIT":
			result = this.iface.CUIT;
			break;
		case "CUIL":
			result = this.iface.CUIL;
			break;
		case "LE":
			result = this.iface.LIBRETA_DE_ENROLAMIENTO;
			break;
		case "LC":
			result = this.iface.LIBRETA_CIVICA;
			break;
		case "Pasaporte":
			result = this.iface.PASAPORTE;
			break;
		case "Cédula":
			result = this.iface.CEDULA;
			break;
		default:
			result = this.iface.SIN_CALIFICADOR;
			break;
	}
	return result;
}

function oficial_formatDocNumber(docType:String, docNumber:String):String {
	var result:String = docNumber;
	if (docNumber != "" || docNumber != undefined) {
		if (docType == "DNI") {
			var regExp:RegExp = /\./;
			regExp.global = true;
			result = docNumber.replace(regExp, "");
		}
		else if (docType == "CUIT" || docType == "CUIL") {
			var regExp:RegExp = new RegExp( "-" );
			regExp.global = true;
			result = docNumber.replace(regExp, "");
		}
	}
	return result;
}

function oficial_formatIVAResponsability(ivaResponsability:String):String {
	var result:String;
	switch (ivaResponsability) {
		case "Consumidor Final":
			result = this.iface.CONSUMIDOR_FINAL;
			break;
		case "Responsable Inscripto":
			result = this.iface.RESPONSABLE_INSCRIPTO;
			break;
		case "Responsable No Inscripto":
			result = this.iface.RESPONSABLE_NO_INSCRIPTO;
			break;
		case "Exento":
			result = this.iface.EXENTO;
			break;
		case "No Responsable":
			result = this.iface.NO_RESPONSABLE;
			break;
		case "Responsable No Inscripto Bienes de Uso":
			result = this.iface.RESPONSABLE_NO_INSCRIPTO_BIENES_DE_USO;
			break;
		case "Responsable Monotributo":
			result = this.iface.RESPONSABLE_MONOTRIBUTO;
			break;
		case "Monotributista Social":
			result = this.iface.MONOTRIBUTISTA_SOCIAL;
			break;
		case "Pequeño Contribuyente Eventual":
			result = this.iface.PEQUENO_CONTRIBUYENTE_EVENTUAL;
			break;
		case "Pequeño Contribuyente Eventual Social":
			result = this.iface.PEQUENO_CONTRIBUYENTE_EVENTUAL_SOCIAL;
			break;
		case "No Categorizado":
			result = this.iface.NO_CATEGORIZADO;
			break;
		default:
			result = this.iface.NO_CATEGORIZADO;
			break;
	}
	return result;
}

function oficial_formatComprobante(comprobante:String):String {
	var result:String = "";
	switch (comprobante) {
		case "Factura A": {
			result = this.iface.FACTURA_A;
			break;
		}
		case "Factura B":
		case "Factura C": {
			result = this.iface.FACTURA_BC;
			break;
		}
	}
	return result;
}

function oficial_procesarEstadoImpresora(status:Number) {
	for (var i = 0; i < this.iface.printerStatusCodes.length; i++) {
		var bitwise = status & this.iface.printerStatusCodes[i];
		if (bitwise) {
			this.iface.printerStatus = bitwise;
			break;
		}
	}
	if (this.iface.printerStatus != undefined || this.iface.printerStatus != 0) {
		switch (this.iface.printerStatus) {
			case this.iface.PST_PRINTER_BUSY: {
				this.iface.printerStatusMsgs = "La impresora se encuentra momentáneamente ocupada.";
				break;
			}
			case this.iface.PST_PRINTER_ERROR: {
				this.iface.printerStatusMsgs = "Error de impresora: se ha interrumpido la comunicación entre el controlador fiscal y la impresora.";
				break;
			}
			case this.iface.PST_PRINTER_OFFLINE: {
				this.iface.printerStatusMsgs = "Impresora fuera de línea: no ha podido comunicarse con la impresora dentro del período de tiempo establecido.";
				break;
			}
			case this.iface.PST_JOURNAL_PAPER_OUT: {
				this.iface.printerStatusMsgs = "El sensor de papel del diario ha detectado falta de papel.";
				break;
			}
			case this.iface.PST_TICKET_PAPER_OUT: {
				this.iface.printerStatusMsgs = "El sensor de papel de tickets ha detectado falta de papel.";
				break;
			}
			case this.iface.PST_PRINT_BUFFER_FULL: {
				this.iface.printerStatusMsgs = "Buffer de impresión lleno.";
				break;
			}
			case this.iface.PST_PRINT_BUFFER_EMPTY: {
				this.iface.printerStatusMsgs = "Buffer de impresión vacío.";
				break;
			}
			case this.iface.PST_PRINTER_COVER_OPEN: {
				this.iface.printerStatusMsgs = "Tapa de impresora abierta.";
				break;
			}
			case this.iface.PST_MONEY_DRAWER_CLOSED: {
				this.iface.printerStatusMsgs = "Cajón de dinero cerrado o ausente.";
				break;
			}
		}
	}
}

function oficial_getEstadoImpresora():Number {
	return this.iface.printerStatus;
}

function oficial_getEstadoImpresoraMsgs():String {
	return this.iface.printerStatusMsgs;
}

function oficial_procesarEstadoFiscal(status:Number) {
	for (var i = 0; i < this.iface.fiscalStatusCodes.length; i++) {
		var bitwise = status & this.iface.fiscalStatusCodes[i];
		if (bitwise) {
			this.iface.fiscalStatus = bitwise;
			break;
		}
	}
	if (this.iface.fiscalStatus != undefined || this.iface.fiscalStatus != 0) {
		switch (this.iface.fiscalStatus) {
			case this.iface.FST_FISCAL_MEMORY_CRC_ERROR: {
				this.iface.fiscalStatusMsgs = "Error en chequeo de memoria fiscal. Al encenderse la impresora se produjo un error en el checksum.";
				break;
			}
			case this.iface.FST_WORKING_MEMORY_CRC_ERROR: {
				this.iface.fiscalStatusMsgs = "Error en chequeo de memoria de trabajo. Al encenderse la impresora se produjo un error en el checksum.";
				break;
			}
			case this.iface.FST_UNKNOWN_COMMAND: {
				this.iface.fiscalStatusMsgs = "Comando desconocido. El comando recibido no fue reconocido.";
				break;
			}
			case this.iface.FST_INVALID_DATA_FIELD: {
				this.iface.fiscalStatusMsgs = "Datos inválidos en un campo. Uno de los campos del comando recibido tiene datos no válidos.";
				break;
			}
			case this.iface.FST_INVALID_COMMAND: {
				this.iface.fiscalStatusMsgs = "Comando inválido para el estado fiscal actual.\nSe ha recibido un comando que no es válido en el estado actual del controlador.";
				break;
			}
			case this.iface.FST_ACCUMULATOR_OVERFLOW: {
				this.iface.fiscalStatusMsgs = "Desborde de acumulador.\nEl acumulador de una transacción, del total diario o del IVA, se desbordará a raíz de un comando recibido.";
				break;
			}
			case this.iface.FST_FISCAL_MEMORY_FULL: {
				this.iface.fiscalStatusMsgs = "Memoria fiscal llena, bloqueada o dada de baja. No se permite abrir un comprobante fiscal.";
				break;
			}
			case this.iface.FST_FISCAL_MEMORY_ALMOST_FULL: {
				this.iface.fiscalStatusMsgs = "Memoria fiscal a punto de llenarse. La memoria fiscal tiene 30 o menos registros libres.";
				break;
			}
			case this.iface.FST_DATE_ERROR: {
				this.iface.fiscalStatusMsgs = "Error en ingreso de fecha. Se ha ingresado una fecha inválida.";
				break;
			}
			case this.iface.FST_DOCUMENT_OPEN_SLIP:
			case this.iface.FST_STATPRN_ACTIVE: {
				/** TODO: La descripción del estado varía de acuerdo con que la impresora soporte o no STATPRN). */
				this.iface.fiscalStatusMsgs = "Estado intermedio (STATPRN) activo";
				break;
			}
			case this.iface.FST_FISCAL_DOCUMENT_OPEN: {
				this.iface.fiscalStatusMsgs = "Documento fiscal abierto.";
				break;
			}
			case this.iface.FST_DOCUMENT_OPEN_TICKET:
			case this.iface.FST_DOCUMENT_OPEN: {
				/** TODO: La descripción del estado varía de acuerdo con que la impresora soporte o no STATPRN). */
				this.iface.fiscalStatusMsgs = "Documento abierto.";
				break;
			}
			case this.iface.FST_DEVICE_CERTIFIED: {
				this.iface.fiscalStatusMsgs = "Terminal fiscal certificada.";
				break;
			}
			case this.iface.FST_DEVICE_FISCALIZED: {
				this.iface.fiscalStatusMsgs = "Terminal fiscal fiscalizada.";
				break;
			}
		}
	}
}

function oficial_getEstadoFiscal():Number {
	return this.iface.fiscalStatus;
}

function oficial_getEstadoFiscalMsgs():String {
	return this.iface.fiscalStatusMsgs;
}

/**
* Comando para almacenar los datos de un código de barras e imprimirlo
* automáticamente.
* @param codeType: tipo del código de barras.
* <ul>
* <li><code>HasarFiscalPrinter.EAN_13</code></li>
* <li><code>HasarFiscalPrinter.EAN_8</code></li>
* <li><code>HasarFiscalPrinter.UPCA</code></li>
* <li><code>HasarFiscalPrinter.ITS</code></li>
* </ul>
* @param data: número del código de barras.
* @param printNumbers: imprimir números.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdBarCode(codeType:Number, data:String, printNumbers:Boolean):String {
	var cmd = new Array(this.iface.CMD_SET_BAR_CODE);
	cmd.push(codeType.toString());
	cmd.push(data);
	if (printNumbers) cmd.push("N"); else cmd.push("x");
	cmd.push("x");
	return this.iface.buildCommand(cmd);
}

/**
* Comando para cancelación del documento abierto.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdCancelDocument():String {
	return this.iface.CMD_CANCEL_DOCUMENT;
}

/**
* Comando que cambia el valor de responsabilidad frente al IVA
* almacenado en la memoria fiscal del controlador.
* @param ivaResponsability: nueva responsabilidad frente al IVA.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdChangeIVAResponsibility(ivaResponsability:String):String {
	var cmd = new Array(this.iface.CMD_CHANGE_IVA_RESPONSIBILITY);
	cmd.push(ivaResponsability);
	return this.iface.buildCommand(cmd);
}

/**
* Comando para cerrar un documento no fiscal homologado.
* @param copies: Cantidad de copias a imprimir. 
* @return String que representa el comando para la impresora.
*/
function oficial_cmdCloseDNFH(copies:Number):String {
	var cmd = new Array(this.iface.CMD_CLOSE_DNFH);
	cmd.push(copies.toString());
	return this.iface.buildCommand(cmd);
}

/**
* Comando para cerrar un comprobante fiscal.
* @param copies: Cantidad de copias a imprimir.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdCloseFiscalReceipt(copies:Number):String {
	var cmd = new Array(this.iface.CMD_CLOSE_FISCAL_RECEIPT);
	cmd.push(copies.toString());
	return this.iface.buildCommand(cmd);
}

/**
* Comando para cerrar un comprobante no fiscal.
* @param copies: Cantidad de copias a imprimir.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdCloseNonFiscalReceipt(copies:Number):String {
	var cmd = new Array(this.iface.CMD_CLOSE_NON_FISCAL_RECEIPT);
	cmd.push(copies.toString());
	return this.iface.buildCommand(cmd);
}

/**
* Comando para cierre de jornada fiscal.
* @param docType: tipo de cierre a realizar.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdDailyClose(docType:String):String {
	var cmd = new Array(this.iface.CMD_DAILY_CLOSE);
	cmd.push(docType);
	return this.iface.buildCommand(cmd);
}

/**
* Comando para establecer a tamaño doble el tipo de letra para 
* imprimir la línea. 
* @return String que representa el comando para la impresora. 
*/
function oficial_cmdDoubleWidth():String {
	return this.iface.CMD_DOUBLE_WIDTH;
}

/**
* Comando que configura en bloque los parámetros de funcionamiento
* del controlador.
* @param printConfigReport: Imprimir el reporte de configuración.
* @param loadDefaultData: carga los valores por defecto de los 
*        parámetros ausentes.  
* @param finalConsumerLimit: monto límite a partir del cual las facturas 
*        y notas de débito a consumidor final deben llevar obligatoriamente
*        los datos del comprador. 
* @param ticketInvoiceLimit: límite de Ticket-Factura.
* @param ivaNotInscript: porcentaje a aplicar a consumidores responsables
*        no inscriptos.
* @param copies: cantidad máxima de copias que se imprimen de cada 
*        documento.
* @param printChange: imprime las leyendas 'CAMBIO $0.00'.
* @param printLabels: imprime los datos de Ingresos Brutos, leyenda
*        'A CONSUMIDOR FINAL' y las líneas en blanco.
* @param ticketCutType: tipo de corte que el troquelador realizará una
*        vez impreso el comprobante. 
* @param printFramework: impresión de marco de los documentos.
* @param reprintDocuments: reimpresión automática de documentos cancelados
*        por corte de energía.
* @param balanceText: texto a imprimir como saldo de medio de pago.
* @param paperSound: emitir señal sonora que indica la falta de papel.
* @param paperSize: tamaño de la hoja.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdSetGeneralConfiguration(printConfigReport:Boolean, loadDefaultData:Boolean, finalConsumerLimit:Number, ticketInvoiceLimit:Number,
			ivaNonInscript:Number, copies:Number, printChange:Boolean, printLabels:Boolean, ticketCutType:String, printFramework:Boolean, 
			reprintDocuments:Boolean, balanceText:String, paperSound:Boolean, paperSize:String):String {
	var cmd = new Array(this.iface.CMD_SET_GENERAL_CONFIGURATION);
	if (printConfigReport) cmd.push("P"); else cmd.push("x");
	if (loadDefaultData) cmd.push("P"); else cmd.push("x");
	cmd.push(this.iface.formatNumber(finalConsumerLimit, 9, 2));
	cmd.push(this.iface.formatNumber(ticketInvoiceLimit, 9, 2));
	cmd.push(this.iface.formatNumber(ivaNonInscript, 2, 2));
	cmd.push(copies.toString());
	if (printChange) cmd.push("P"); else cmd.push("x");
	if (printLabels) cmd.push("P"); else cmd.push("x");
	cmd.push(ticketCutType);
	if (printFramework) cmd.push("P"); else cmd.push("x");
	if (reprintDocuments) cmd.push("P"); else cmd.push("x");
	cmd.push(this.iface.formatText(balanceText, 80));
	if (paperSound) cmd.push("P"); else cmd.push("x");
	cmd.push(paperSize);
	return this.iface.buildCommand(cmd);
}

/**
* Comando para aplicar un descuento o recargo general.
* @param description: descripción del descuento/recargo.
* @param amount: monto a aplicar.
* @param substract: imputación del monto.
*                   <code>True</code> resta en el comprobante fiscal.
*                   <code>False</code> suma en el comprobante fiscal.
* @param baseAmount: indica si el monto tiene el IVA incluído o no.
*                   <code>True</code> indica que el monto no tiene IVA incluído.
*                   <code>False</code> indica que el monto tiene IVA incluído.
* @param display: tipo de impresión.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdGeneralDiscount(description:String, amount:Number, substract:Boolean, baseAmount:Boolean, display:Number):String {
	var cmd = new Array(this.iface.CMD_GENERAL_DISCOUNT);
	cmd.push(this.iface.formatText(description, 50));
	cmd.push(this.iface.formatNumber(amount, 10, 2));
	if (substract) cmd.push("m"); else cmd.push("M");
	cmd.push(display.toString());
	if (baseAmount) cmd.push("x"); else cmd.push("T");
	return this.iface.buildCommand(cmd);
}

/**
* Comando que consulta la configuración del controlador.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdGetGeneralConfigurationData():String {
	return this.iface.CMD_GET_GENERAL_CONFIGURATION;
}

/**
* Comando para consultar la fecha y hora del controlador.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdGetDateTime():String {
	return this.iface.CMD_GET_DATE_TIME;
}

/**
* Comando para consultar información del remito o comprobante original.
* @param line: número de línea a consultar.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdGetEmbarkNumber(line:Number):String {
	var cmd = new Array(this.iface.CMD_GET_EMBARK_NUMBER);
	cmd.push(line.toString());
	return this.iface.buildCommand(cmd);
}

/**
* Comando para consultar el texto del nombre de fantasía del propietario.
* @param line: número de línea del nombre de fantasía.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdGetFantasyName(line:Number):String {
	var cmd = new Array(this.iface.CMD_GET_FANTASY_NAME);
	cmd.push(line.toString());
	return this.iface.buildCommand(cmd);
}

/**
* Comando para consultar el texto de encabezamiento y cola de documentos.
* @param line: número de línea de encabezamiento o cola.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdGetHeaderTrailer(line:Number):String {
	var cmd = new Array(this.iface.CMD_GET_HEADER_TRAILER);
	cmd.push(line.toString());
	return this.iface.buildCommand(cmd);
}

/**
* Comando que consulta los datos guardados en la memoria de trabajo
* durante la jornada fiscal.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdGetWorkingMemory() {
	return this.iface.CMD_GET_WORKING_MEMORY;
}

/**
* Comando para aplicar un decuento/recargo sobre el último item vendido.
* @param description: descripción del descuent/recargo.
* @param amount: monto a aplicar.
* @param substract: Imputación del monto.
*                   <code>True</code> resta en el comprobante fiscal.
*                   <code>False</code> suma en el comprobante fiscal.
* @param baseAmount: Indica si el monto tiene el IVA incluído o no.
*                   <code>True</code> indica que el monto no tiene IVA incluído.
*                   <code>False</code> indica que el monto tiene IVA incluído.
* @param display: tipo de impresión.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdLastItemDiscount(description:String, amount:Number, substract:Boolean, baseAmount:Boolean, display:Number):String {
	var cmd = new Array(this.iface.CMD_LAST_ITEM_DISCOUNT);
	cmd.push(this.iface.formatText(description, 50));
	cmd.push(this.iface.formatNumber(amount, 10, 2));
	if (substract) cmd.push("m"); else cmd.push("M");
	cmd.push(display.toString());
	if (baseAmount) cmd.push("x"); else cmd.push("T");
	return this.iface.buildCommand(cmd);
}

/**
* Comando para abrir un documento no fiscal homologado.
* @param docType: tipo del documento.
* @param identification: identificación del documento.
* @return String que representa el comando para la impresora. 
*/
function oficial_cmdOpenDNFH(docType:String, identification:String):String {
	var cmd = new Array(this.iface.CMD_OPEN_DNFH);
	cmd.push(docType);
	cmd.push("T");
	cmd.push(identification);
	return this.iface.buildCommand(cmd);
}

/**
* Comando para abrir un comprobante fiscal.
* @param docType: tipo del documento.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdOpenFiscalReceipt(docType:String):String {
	var cmd = new Array(this.iface.CMD_OPEN_FISCAL_RECEIPT);
	cmd.push(this.iface.formatComprobante(docType));
	cmd.push("T");
	return this.iface.buildCommand(cmd);
}

/**
* Comando para abrir un comprobante no fiscal.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdOpenNonFiscalReceipt() {
	return this.iface.CMD_OPEN_NON_FISCAL_RECEIPT;
}

/**
* Comando para generar percepciones.
* @param description: Descripción.
* @param amount: monto de la percepción.
* @param alicuotaIVA: alícuota del IVA. Si no se indica ningun porcentaje 
*                     (<code>null</code>) la percepción es general.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdPerceptions(description:String, amount:Number, alicuotaIVA:Number):String {
	var cmd = new Array(this.iface.CMD_PERCEPTIONS);
	if (alicuotaIVA == undefined)
		cmd.push("**.**");
	else
		cmd.push(this.iface.formatNumber(alicuotaIVA, 2, 2));
	cmd.push(this.iface.formatText(description, 20));
	cmd.push(this.iface.formatNumber(amount, 7, 2));
	return this.iface.buildCommand(cmd);
}

/**
* Comando para imprimir item en resumen de cuenta o cargo a la habitación.
* @param date: fecha del comprobante. 
* @param docNumber: número del comprobante.
* @param description: descripción de venta o servicio.
* @param debitAmount: monto del debe.
* @param creditAmount: monto del haber.
* @param display: tipo de impresión.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdPrintAccountItem(date:Date, docNumber:String, description:String, debitAmount:Number, creditAmount:Number, display:Number):String {
	var cmd = new Array(this.iface.CMD_PRINT_ACCOUNT_ITEM);
	cmd.push(this.iface.formatDate(date));
	cmd.push(this.iface.formatText(docNumber, 20));
	cmd.push(this.iface.formatText(description, 60));
	cmd.push(this.iface.formatNumber(debitAmount, 9, 2));
	cmd.push(this.iface.formatNumber(creditAmount, 9, 2));
	cmd.push(display.toString());
	return this.iface.buildCommand(cmd);
}

/**
* Comando para imprimir una línea dividida en dos campos (descripción y
* cantidad) en un documento no fiscal homologado.
* @param description: descriptión del item.
* @param quantity: cantidad del item.
* @param display: tipo de impresión.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdPrintEmbarkItem(description:String, quantity:Number, display:Number):String {
	var cmd = new Array(this.iface.CMD_PRINT_EMBARK_ITEM);
	cmd.push(this.iface.formatText(description, 108));
	cmd.push(this.iface.formatNumber(quantity, 3, 4));
	cmd.push(display.toString());
	return this.iface.buildCommand(cmd);
}

/**
* Comando para imprimir texto fiscal.
* @param text: texto fiscal a imprimir.
* @param display: tipo de impresión.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdPrintFiscalText(text:String, display:Number):String {
	var cmd = new Array(this.iface.CMD_PRINT_FISCAL_TEXT);
	cmd.push(this.iface.formatText(text, 50));
	cmd.push(display.toString());
	return this.iface.buildCommand(cmd);
}

/**
* Comando para imprimir un item fiscal.
* @param description: descripción del item.
* @param quantity: cantidad del item.
* @param price: precio unitario del item.
* @param ivaPercent: porcentaje del IVA que se aplica al item. 
* @param substract: imputación del item.
*                   <code>True</code> resta en el comprobante fiscal.
*                   <code>False</code> suma en el comprobante fiscal.
* @param internalTaxes: impuestos internos.
* @param basePrice: indica si el precio tiene el IVA incluído o no.
*                   <code>True</code> indica que el precio no tiene IVA incluído.
*                   <code>False</code> indica que el precio tiene IVA incluído.
* @param display: tipo de impresión. 
* @return String que representa el comando para la impresora.
*/
function oficial_cmdPrintLineItem(description:String, quantity:Number, price:Number, ivaPercent:Number, substract:Boolean, internalTaxes:Number, basePrice:Boolean, display:Number):String {
	//Most models description max length is 50
	var descMaxLength = 50;
	return cmdPrintLineItem(description, quantity, price, ivaPercent, substract, internalTaxes, basePrice, display, descMaxLength);
}

//Función que permite especificar la longitud máxima de la descripcion, para los modelos que lo requieran.
function oficial_cmdPrintLineItem(description:String, quantity:Number, price:Number, ivaPercent:Number, substract:Boolean, internalTaxes:Number, basePrice:Boolean, display:Number, descMaxLength:Number):String {
	var cmd = new Array(this.iface.CMD_PRINT_LINE_ITEM);
	cmd.push(this.iface.formatText(description, descMaxLength));
	cmd.push(quantity.toString());
	cmd.push(this.iface.formatNumber(price, 5, 4));
	if(ivaPercent == undefined)
		cmd.push("**.**");
	else
		cmd.push(this.iface.formatNumber(ivaPercent, 2, 2));
	if (substract) cmd.push("m"); else cmd.push("M");
	cmd.push(this.iface.formatNumber(internalTaxes, 6, 8));
	cmd.push(display.toString());
	if (basePrice) cmd.push("x"); else cmd.push("T");
	return this.iface.buildCommand(cmd);
}

/**
* Comando para imprimir un texto no fiscal dentro de un comprobante 
* no fiscal.
* @param text: texto a imprimir.
* @param display: tipo de impresión.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdPrintNonFiscalText(text:String, display:Number):String {
	var cmd = new Array(this.iface.CMD_PRINT_NON_FISCAL_TEXT);
	cmd.push(this.iface.formatText(text, 120));
	cmd.push(display.toString());
	return this.iface.buildCommand(cmd);
}

/**
* Comando para imprimir un item en una cotización.
* @param description: descipción del item.
* @param display: tipo de impresión.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdPrintQuotationItem(description:String, display:Number):String {
	var cmd = new Array(this.iface.CMD_PRINT_QUOTATION_ITEM);
	cmd.push(this.iface.formatText(description, 120));
	cmd.push(display.toString());
	return this.iface.buildCommand(cmd);
}

/**
* Comando para reimpremir el último documento emitido.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdReprint() {
	return this.iface.CMD_REPRINT_DOCUMENT;
}

/**
* Comando para iniciar el envío de montos asociados a porcentajes de IVA,
* impuestos internos y percepciones.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdSendFirstIVA() {
	return this.iface.CMD_SEND_FIRST_IVA;
}

/**
*  Comando que establece la velocidad de comunicación entre el host y 
*  el controlador fiscal.
*  @param speed: velocidad de comunicación 
*  <ul>
*  	<li>2400   : 2.400 bps</li>
*  	<li>4800   : 4.800 bps</li>
*  	<li>9600   : 9.600 bps</li>
*  	<li>19200  : 19.200 bps</li>
*  	<li>38400  : 38.400 bps</li>
*  	<li>57600  : 57.600 bps</li>
*  	<li>115200 : 115.200 bps</li>
*  </ul>
*  @return String que representa el comando para la impresora.
**/
function oficial_cmdSetComSpeed(speed:Number):String {
	var cmd = new Array(this.iface.CMD_SET_COM_SPEED);
	cmd.push(speed.toString());
	return this.iface.buildCommand(cmd);
}

/**
* Comando para setear los datos del comprador de la factura.
* @param name: nombre del comprador.
* @param customerDocNumber: nro. de documento / CUIT.
* @param ivaResponsibility: responsabilidad frente al IVA
* <ul>
* 		<li><code>HasarFiscalPrinter.RESPONSABLE_NO_INSCRIPTO</code></li>
* 		<li><code>HasarFiscalPrinter.EXENTO</code></li>
* 		<li><code>NO_RESPONSABLE</code></li>
* 		<li><code>HasarFiscalPrinter.CONSUMIDOR_FINAL</code></li>
* 		<li><code>HasarFiscalPrinter.RESPONSABLE_NO_INSCRIPTO_BIENES_DE_USO</code></li>
* 		<li><code>HasarFiscalPrinter.RESPONSABLE_MONOTRIBUTO</code></li>
* 		<li><code>HasarFiscalPrinter.MONOTRIBUTISTA_SOCIAL</code></li>
* 		<li><code>HasarFiscalPrinter.PEQUENO_CONTRIBUYENTE_EVENTUAL</code></li>
* 		<li><code>HasarFiscalPrinter.PEQUENO_CONTRIBUYENTE_EVENTUAL_SOCIAL</code></li>
* 		<li><code>HasarFiscalPrinter.NO_CATEGORIZADO</code></li>
* </ul>
* @param docType: tipo de documento
* <ul>
* 		<li><code>HasarFiscalPrinter.CUIT</code></li>
* 		<li><code>HasarFiscalPrinter.CUIL</code></li>
* 		<li><code>HasarFiscalPrinter.LIBRETA_DE_ENROLAMIENTO</code></li>
* 		<li><code>HasarFiscalPrinter.LIBRETA_CIVICA</code></li>
* 		<li><code>HasarFiscalPrinter.DNI</code></li>
* 		<li><code>HasarFiscalPrinter.PASAPORTE</code></li>
* 		<li><code>HasarFiscalPrinter.CEDULA</code></li>
* 		<li><code>HasarFiscalPrinter.SIN_CALIFICADOR</code></li>
* </ul>
* @param location: domicilio comercial.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdSetCustomerData(name:String, customerDocNumber:String, ivaResponsibility:String, docType:String, location:String):String {
	var cmd = new Array(this.iface.CMD_SET_CUSTOMER_DATA);
	cmd.push(this.iface.formatText(name, 50));
	cmd.push(this.iface.formatDocNumber(docType,customerDocNumber));
	cmd.push(this.iface.formatIVAResponsability(ivaResponsibility));
	cmd.push(this.iface.formatDocType(docType));
	cmd.push(this.iface.formatText(location, 50));
	return this.iface.buildCommand(cmd);
}

/**
* Comando para asignar la fecha y hora al controlador.
* @param dateTime: fecha y hora.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdSetDateTime(dateTime:Date):String {
	var cmd = new Array(this.iface.CMD_SET_DATE_TIME);
	cmd.push(this.iface.formatDate(dateTime));
	cmd.push(this.iface.formatTime(dateTime));
	return this.iface.buildCommand(cmd);
}

/**
* Comando para cargar información del remito, comprobante original
* o crédito.
* @param line: número de línea del remito o comprobante original.
* @param text: texto de la línea.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdSetEmbarkNumber(line:Number, text:String):String {
	var cmd = new Array(this.iface.CMD_SET_EMBARK_NUMBER);
	cmd.push(line.toString());
	cmd.push(this.iface.formatText(text, 20));
	return this.iface.buildCommand(cmd);
}

/**
* Comando para programar el texto del nombre de fantasía del propietario.
* @param line: número de línea del nombre de fantasía.
* @param text: texto.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdSetFantasyName(line:Number, text:String):String {
	var cmd = new Array(this.iface.CMD_SET_FANTASY_NAME);
	cmd.push(line.toString());
	cmd.push(this.iface.formatText(text, 50));
	return this.iface.buildCommand(cmd);
}

/**
* Comando para programar texto de encabezamiento y cola de documentos.
* @param line: número de línea de encabezamiento o cola.
* @param text: texto de la línea.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdSetHeaderTrailer(line:Number, text:String):String {
	var cmd = new Array(this.iface.CMD_SET_HEADER_TRAILER);
	cmd.push(line.toString());
	cmd.push(this.iface.formatText(text, 120));
	return this.iface.buildCommand(cmd);
}

/**
* Comando que consulta el estado en que se encuentra el controlador fiscal
* y el hardware del impresor aún cuando la impresora no ha terminado de
* procesar el comando.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdSTATPRN():String {
	return this.iface.CMD_STATPRN;
}

/**
* Comando que consulta el estado en que se encuentra el controlador
* fiscal, el hardware del impresor y los documentos emitidos.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdStatusRequest():String {
	return this.iface.CMD_STATUS_REQUEST;
}

/**
* Comando para calcular el subtotal del comprobante abierto.
* @param print: imprime texto y monto.
* @param display: tipo de impresión.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdSubtotal(print:Boolean, display:Number):String {
	var cmd = new Array(this.iface.CMD_SUBTOTAL);
	if (print) cmd.push("P"); else cmd.push("x");
	cmd.push("x");
	cmd.push(display.toString());
	return this.iface.buildCommand(cmd);
}

/**
* Comando para calcular el total del comprobante abierto.
* @param description: descripción.
* @param amount: monto total.
* @param cancel: cancela el comprobante fiscal abierto.
* @param display: tipo de impresión.
* @return String que representa el comando para la impresora.
*/
function oficial_cmdTotalTender(description:String, amount:Number, cancel:Boolean, display:Number):String {
	var cmd = new Array(this.iface.CMD_TOTAL_TENDER);
	cmd.push(this.iface.formatText(description, 80));
	cmd.push(this.iface.formatNumber(amount, 10, 2));
	if (cancel) cmd.push("C"); else cmd.push("T");
	cmd.push(display.toString());
	return this.iface.buildCommand(cmd);
}

//// OFICIAL /////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/** @class_declaration implementaciones */
/////////////////////////////////////////////////////////////
//// IMPLEMENTACIONES  //////////////////////////////////////

function implementaciones_cmdSetGeneralConfiguration(printConfigReport:Boolean, loadDefaultData:Boolean, finalConsumerLimit:Number, ticketInvoiceLimit:Number,
		ivaNonInscript:Number, copies:Number, printChange:Boolean, printLabels:Boolean, ticketCutType:String, printFramework:Boolean, 
		reprintDocuments:Boolean, balanceText:String, paperSound:Boolean, paperSize:String):String {
	var modelo:String = this.iface.getModelo();
	if (modelo == "") return;
	switch (modelo) {
		case "SMH/P-320F":
			return this.iface.__cmdSetGeneralConfiguration(printConfigReport, loadDefaultData, finalConsumerLimit, 0,
				ivaNonInscript, copies, false, false, "", printFramework,
				reprintDocuments, balanceText, paperSound, "");
		default:
			return this.iface.__cmdSetGeneralConfiguration(printConfigReport, loadDefaultData, finalConsumerLimit, ticketInvoiceLimit,
				ivaNonInscript, copies, printChange, printLabels, ticketCutType, printFramework, 
				reprintDocuments, balanceText, paperSound, paperSize);
	}
}

function  implementaciones_cmdPrintFiscalText(text:String, display:Number):String {
	var modelo:String = this.iface.getModelo();
	if (modelo == "") return;
	switch (modelo) {
		case "SMH/P-320F":
			return this.iface.__cmdPrintFiscalText(text, 0);
		default:
			return this.iface.__cmdPrintFiscalText(text, display);
	}
}

function implementaciones_cmdPrintLineItem(description:String, quantity:Number, price:Number, ivaPercent:Number,
		substract:Boolean, internalTaxes:Number, basePrice:Boolean, display:Number):String {
	var modelo:String = this.iface.getModelo();
	if (modelo == "") return;
	switch (modelo) {
		case "SMH/P-320F":
			return this.iface.__cmdPrintLineItem(description, quantity, price, ivaPercent, substract, internalTaxes, basePrice, 0);
		default:
			return this.iface.__cmdPrintLineItem(description, quantity, price, ivaPercent, substract, internalTaxes, basePrice, display);
	}
}

function implementaciones_cmdLastItemDiscount(description:String, amount:Number, substract:Boolean, baseAmount:Boolean, display:Number):String {
	var modelo:String = this.iface.getModelo();
	if (modelo == "") return;
	switch (modelo) {
		case "SMH/P-320F":
			return this.iface.__cmdLastItemDiscount(description, amount, substract, baseAmount, 0);
		default:
			return this.iface.__cmdLastItemDiscount(description, amount, substract, baseAmount, display);
	}
}

function implementaciones_cmdSubtotal(print:Boolean, display:Number):String {
	var modelo:String = this.iface.getModelo();
	if (modelo == "") return;
	switch (modelo) {
		case "SMH/P-320F":
			return this.iface.__cmdSubtotal(print, 0);
		default:
			return this.iface.__cmdSubtotal(print, display);
	}
}

function implementaciones_cmdTotalTender(description:String, amount:Number, cancel:Boolean, display:Number):String {
	var modelo:String = this.iface.getModelo();
	if (modelo == "") return;
	switch (modelo) {
		case "SMH/P-320F":
			return this.iface.__cmdTotalTender(description, amount, cancel, 0);
		default:
			return this.iface.__cmdTotalTender(description, amount, cancel, display);
	}
}

function implementaciones_cmdCloseFiscalReceipt(copies:Number):String {
	var modelo:String = this.iface.getModelo();
	if (modelo == "") return;
	switch (modelo) {
		case "SMH/P-320F":
			// Este modelo no acepta el parámetro de copias.
			return this.iface.CMD_CLOSE_FISCAL_RECEIPT;
		default:
			return this.iface.__cmdCloseFiscalReceipt(copies);
	}
}

function implementaciones_cmdCloseDNFH(copies:Number):String {
	var modelo:String = this.iface.getModelo();
	if (modelo == "") return;
	switch (modelo) {
		case "SMH/P-320F":
			// Este modelo no acepta el parámetro de copias.
			return this.iface.CMD_CLOSE_DNFH;
		default:
			return this.iface.__cmdCloseDNFH(copies);
	}
}

//// IMPLEMENTACIONES ///////////////////////////////////////
/////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// DESARROLLO /////////////////////////////////////////////////

//// DESARROLLO /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

/////////////////////////////////////////////////////////////////
//// INTERFACE  /////////////////////////////////////////////////

//// INTERFACE  /////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
