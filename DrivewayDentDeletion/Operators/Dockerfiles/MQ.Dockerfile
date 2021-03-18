FROM cp.icr.io/cp/ibm-mqadvanced-server-integration@sha256:d64782959306134778612d3e14cce1bef43cfd35910227a3a90d7dce95168f75
RUN echo -e "\
DEFINE QLOCAL('AccidentIn') DEFPSIST(YES) \n\
DEFINE QLOCAL('AccidentOut') DEFPSIST(YES) \n\
DEFINE QLOCAL('BumperIn') DEFPSIST(YES) \n\
DEFINE QLOCAL('BumperOut') DEFPSIST(YES) \n\
DEFINE QLOCAL('CrumpledIn') DEFPSIST(YES) \n\
DEFINE QLOCAL('CrumpledOut') DEFPSIST(YES) \n\
DEFINE CHANNEL(ACE_SVRCONN) CHLTYPE(SVRCONN) TRPTYPE(TCP) SSLCAUTH(REQUIRED) SSLCIPH('ECDHE_RSA_AES_128_CBC_SHA256') \n\
ALTER AUTHINFO(SYSTEM.DEFAULT.AUTHINFO.IDPWOS) AUTHTYPE(IDPWOS) ADOPTCTX(YES) CHCKCLNT(OPTIONAL) CHCKLOCL(OPTIONAL) AUTHENMD(OS) \n\
SET CHLAUTH('ACE_SVRCONN') TYPE(SSLPEERMAP) SSLPEER('CN=application1,OU=app team1') USERSRC(MAP) MCAUSER('mqm') ACTION(ADD) \n\
REFRESH SECURITY TYPE(CONNAUTH) \n\
SET AUTHREC PRINCIPAL('mqm') OBJTYPE(QMGR) AUTHADD(CONNECT,INQ) \n\
SET AUTHREC PROFILE('AccidentIn') PRINCIPAL('mqm') OBJTYPE(QUEUE) AUTHADD(BROWSE,GET,INQ,PUT) \n\
SET AUTHREC PROFILE('AccidentOut') PRINCIPAL('mqm') OBJTYPE(QUEUE) AUTHADD(BROWSE,GET,INQ,PUT) \n\
SET AUTHREC PROFILE('BumperIn') PRINCIPAL('mqm') OBJTYPE(QUEUE) AUTHADD(BROWSE,GET,INQ,PUT) \n\
SET AUTHREC PROFILE('BumperOut') PRINCIPAL('mqm') OBJTYPE(QUEUE) AUTHADD(BROWSE,GET,INQ,PUT) \n\
SET AUTHREC PROFILE('CrumpledIn') PRINCIPAL('mqm') OBJTYPE(QUEUE) AUTHADD(BROWSE,GET,INQ,PUT) \n\
SET AUTHREC PROFILE('CrumpledOut') PRINCIPAL('mqm') OBJTYPE(QUEUE) AUTHADD(BROWSE,GET,INQ,PUT) \n\
REFRESH SECURITY" >/etc/mqm/aceldap.mqsc
RUN cat /etc/mqm/aceldap.mqsc
