class ApiUrl {
  static const baseURL = 'https://coind.in-am.it/gmaoCS02/api/';

  static const authentication = 'auth/v1/authenticate';

  static const attore = 'entities/v1/actor?filter[code]=';
  static const tecnici =
      'entities/v1/technician?include=actor&filter[statusCode]=ACTIVE&sort=code';
  static const linee = 'entities/v1/box?filter[eqptType]=LINEA&sort=code';
  static const macchine = 'entities/v1/material?filter[statusCode]=VALIDATE';
  static const legami =
      'entities/v1/linkequipment?include=parent,child&filter[junction.id]=18772c37196-7f3&filter[linkEnd]=2200-12-31T01:00:00.000';
  static const interventiEImpianti =
      'entities/v1/woeqpt?include=eqpt,WO,WO.createdBy,WO.actionType,WO.assignedTo,WO.equipments,WO.longDesc&filter[directEqpt]=true&filter[WO.statusCode]=AWAITINGREAL,INPROGRESS,PAUSE';
  static const interventiEImpiantiPrincipaliCompletati =
      'entities/v1/woeqpt?include=eqpt,WO,WO.createdBy,WO.actionType,WO.assignedTo,WO.equipments,WO.longDesc&filter[directEqpt]=true&filter[WO.statusCode]=CLOSED&filter[WO.xtraTxt14]=NO';
}
