Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Vw6uz-0002L8-Ko
	for ltp-list@lists.sourceforge.net; Thu, 26 Dec 2013 09:07:49 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vw6uq-0007Qp-Uv
	for ltp-list@lists.sourceforge.net; Thu, 26 Dec 2013 09:07:49 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rBQ97Yp6011167
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Dec 2013 09:07:35 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBQ97Yo1023161
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Dec 2013 09:07:34 GMT
Received: from ubhmt120.oracle.com (ubhmt120.oracle.com [156.151.24.25])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBQ97Xt6002054
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Dec 2013 09:07:33 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 26 Dec 2013 13:07:19 +0400
Message-Id: <1388048842-28373-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1388048842-28373-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1388048842-28373-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 2/5] rpc-tirpc-full-test-suite: enabled build of the
	rpc test cases
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: vasily.isaenko@oracle.com

Nothing from rpc-tirpc-full-test-suite is built during LTP compilation,
but some of the rpc test cases are needed to run runtest/rpc and
runtest/stress.part3 (executed by ltpstress.sh).

Therefore:
 * Added necessary Makefiles to enable building and installation
   of these test scripts (from 'rpc_ts_wizard.sh -allrpc')
 * Since rpc-tirpc-full-test-suite initially used the '.bin' suffix
   to mark binaries (and LTP doesn't) I removed this suffix from
   the scripts.

It seems that runtest/tirpc is not executed automatically (maybe it's not
used at all now) therefore I've not touched the tirpc part of the suite.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../rpc/rpc-tirpc-full-test-suite/.gitignore       |   91 ++++++++++++++++++++
 .../network/rpc/rpc-tirpc-full-test-suite/Makefile |   27 ++++++
 .../rpc/rpc-tirpc-full-test-suite/Makefile.inc     |    3 +
 .../rpc_addrmanagmt_basic_lib.sh                   |    2 +-
 .../rpc_auth_basic_lib.sh                          |    2 +-
 .../rpc_broadc_basic_lib.sh                        |    2 +-
 .../rpc_createdestroy_basic_lib.sh                 |    2 +-
 .../rpc-tirpc-full-test-suite/rpc_err_basic_lib.sh |    2 +-
 .../rpc_regunreg_basic_lib.sh                      |    2 +-
 .../rpc_stdcall_basic_lib.sh                       |    2 +-
 .../rpc/rpc-tirpc-full-test-suite/rpc_ts_run.sh    |    4 +-
 .../rpc/rpc-tirpc-full-test-suite/scripts/Makefile |   27 ++++++
 .../scripts/rpc_addrmanagmt_get_myaddress.sh       |    2 +-
 .../scripts/rpc_addrmanagmt_pmap_getmaps.sh        |    2 +-
 .../scripts/rpc_addrmanagmt_pmap_getport.sh        |    2 +-
 .../rpc_addrmanagmt_pmap_rmtcall.performance.sh    |    2 +-
 .../scripts/rpc_addrmanagmt_pmap_rmtcall.sh        |    2 +-
 .../scripts/rpc_addrmanagmt_pmap_rmtcall.stress.sh |    2 +-
 .../scripts/rpc_addrmanagmt_pmap_set.sh            |    2 +-
 .../scripts/rpc_addrmanagmt_pmap_unset.sh          |    2 +-
 .../scripts/rpc_auth_auth_destroy.sh               |    2 +-
 .../scripts/rpc_auth_authnone_create.sh            |    2 +-
 .../scripts/rpc_auth_authunix_create.sh            |    2 +-
 .../scripts/rpc_auth_authunix_create_default.sh    |    2 +-
 .../scripts/rpc_broadc_clnt_broadcast.complex.sh   |    2 +-
 .../scripts/rpc_broadc_clnt_broadcast.dataint.sh   |    2 +-
 .../rpc_broadc_clnt_broadcast.performance.sh       |    2 +-
 .../rpc_broadc_clnt_broadcast.scalability.sh       |    2 +-
 .../scripts/rpc_broadc_clnt_broadcast.sh           |    2 +-
 .../scripts/rpc_broadc_clnt_broadcast.stress.sh    |    2 +-
 .../scripts/rpc_createdestroy_clnt_create.sh       |    2 +-
 .../rpc_createdestroy_clnt_create.stress.sh        |    2 +-
 .../scripts/rpc_createdestroy_clnt_destroy.sh      |    2 +-
 .../rpc_createdestroy_clnt_destroy.stress.sh       |    2 +-
 .../rpc_createdestroy_clntraw_create.complex.sh    |    2 +-
 ...rpc_createdestroy_clntraw_create.performance.sh |    2 +-
 .../scripts/rpc_createdestroy_clntraw_create.sh    |    2 +-
 .../rpc_createdestroy_clnttcp_create.limits.sh     |    2 +-
 ...rpc_createdestroy_clnttcp_create.performance.sh |    2 +-
 .../scripts/rpc_createdestroy_clnttcp_create.sh    |    2 +-
 .../rpc_createdestroy_clnttcp_create.stress.sh     |    2 +-
 .../rpc_createdestroy_clntudp_bufcreate.limits.sh  |    2 +-
 .../scripts/rpc_createdestroy_clntudp_bufcreate.sh |    2 +-
 ...rpc_createdestroy_clntudp_create.performance.sh |    2 +-
 .../scripts/rpc_createdestroy_clntudp_create.sh    |    2 +-
 .../rpc_createdestroy_clntudp_create.stress.sh     |    2 +-
 .../scripts/rpc_createdestroy_svc_destroy.sh       |    2 +-
 .../rpc_createdestroy_svc_destroy.stress.sh        |    2 +-
 .../rpc_createdestroy_svcfd_create.limits.sh       |    2 +-
 .../scripts/rpc_createdestroy_svcfd_create.sh      |    2 +-
 .../rpc_createdestroy_svcraw_create.performance.sh |    2 +-
 .../scripts/rpc_createdestroy_svcraw_create.sh     |    2 +-
 .../rpc_createdestroy_svctcp_create.limits.sh      |    2 +-
 .../rpc_createdestroy_svctcp_create.performance.sh |    2 +-
 .../scripts/rpc_createdestroy_svctcp_create.sh     |    2 +-
 .../rpc_createdestroy_svctcp_create.stress.sh      |    2 +-
 .../rpc_createdestroy_svcudp_bufcreate.limits.sh   |    2 +-
 .../scripts/rpc_createdestroy_svcudp_bufcreate.sh  |    2 +-
 .../rpc_createdestroy_svcudp_create.performance.sh |    2 +-
 .../scripts/rpc_createdestroy_svcudp_create.sh     |    2 +-
 .../rpc_createdestroy_svcudp_create.stress.sh      |    2 +-
 .../scripts/rpc_err_clnt_pcreateerror.sh           |    2 +-
 .../scripts/rpc_err_clnt_perrno.sh                 |    2 +-
 .../scripts/rpc_err_clnt_perror.sh                 |    2 +-
 .../scripts/rpc_err_clnt_spcreateerror.sh          |    2 +-
 .../scripts/rpc_err_clnt_sperrno.sh                |    2 +-
 .../scripts/rpc_err_clnt_sperror.sh                |    2 +-
 .../scripts/rpc_err_svcerr_auth.sh                 |    2 +-
 .../scripts/rpc_err_svcerr_noproc.sh               |    2 +-
 .../scripts/rpc_err_svcerr_noprog.sh               |    2 +-
 .../scripts/rpc_err_svcerr_progvers.sh             |    2 +-
 .../scripts/rpc_err_svcerr_systemerr.sh            |    2 +-
 .../scripts/rpc_err_svcerr_weakauth.sh             |    2 +-
 .../scripts/rpc_regunreg_registerrpc.sh            |    2 +-
 .../scripts/rpc_regunreg_svc_register.sh           |    2 +-
 .../scripts/rpc_regunreg_svc_unregister.sh         |    2 +-
 .../scripts/rpc_regunreg_xprt_register.sh          |    2 +-
 .../scripts/rpc_regunreg_xprt_unregister.sh        |    2 +-
 .../scripts/rpc_stdcall_callrpc.dataint.sh         |    2 +-
 .../scripts/rpc_stdcall_callrpc.performance.sh     |    2 +-
 .../scripts/rpc_stdcall_callrpc.scalability.sh     |    2 +-
 .../scripts/rpc_stdcall_callrpc.sh                 |    2 +-
 .../scripts/rpc_stdcall_callrpc.stress.sh          |    2 +-
 .../scripts/rpc_stdcall_clnt_call.complex.sh       |    2 +-
 .../scripts/rpc_stdcall_clnt_call.dataint.sh       |    2 +-
 .../scripts/rpc_stdcall_clnt_call.performance.sh   |    2 +-
 .../scripts/rpc_stdcall_clnt_call.scalability.sh   |    2 +-
 .../scripts/rpc_stdcall_clnt_call.sh               |    2 +-
 .../scripts/rpc_stdcall_clnt_call.stress.sh        |    2 +-
 .../scripts/rpc_stdcall_clnt_control.dataint.sh    |    2 +-
 .../scripts/rpc_stdcall_clnt_control.sh            |    2 +-
 .../scripts/rpc_stdcall_clnt_freeres.sh            |    2 +-
 .../scripts/rpc_stdcall_clnt_geterr.sh             |    2 +-
 .../scripts/rpc_stdcall_svc_freeargs.sh            |    4 +-
 .../scripts/rpc_stdcall_svc_getargs.dataint.sh     |    2 +-
 .../scripts/rpc_stdcall_svc_getargs.sh             |    4 +-
 .../scripts/rpc_stdcall_svc_getcaller.sh           |    2 +-
 .../scripts/rpc_stdcall_svc_sendreply.sh           |    4 +-
 .../rpc-tirpc-full-test-suite/tests_pack/Makefile  |   28 ++++++
 .../rpc-tirpc-full-test-suite/tests_pack/cleaner.c |   48 ++++++++++
 .../tests_pack/cleaner.c.src                       |   48 ----------
 .../tests_pack/rpc_suite/Makefile                  |   24 +++++
 .../tests_pack/rpc_suite/rpc/Makefile              |   24 +++++
 .../tests_pack/rpc_suite/rpc/Makefile.inc          |    1 +
 .../rpc/rpc_addrmanagmt_get_myaddress/Makefile     |   25 ++++++
 .../rpc/rpc_addrmanagmt_pmap_getmaps/Makefile      |   25 ++++++
 .../rpc/rpc_addrmanagmt_pmap_getport/Makefile      |   25 ++++++
 .../rpc/rpc_addrmanagmt_pmap_rmtcall/Makefile      |   25 ++++++
 .../rpc/rpc_addrmanagmt_pmap_set/Makefile          |   25 ++++++
 .../rpc/rpc_addrmanagmt_pmap_unset/Makefile        |   25 ++++++
 .../rpc_suite/rpc/rpc_auth_auth_destroy/Makefile   |   25 ++++++
 .../rpc/rpc_auth_authnone_create/Makefile          |   25 ++++++
 .../rpc/rpc_auth_authunix_create/Makefile          |   25 ++++++
 .../rpc/rpc_auth_authunix_create_default/Makefile  |   25 ++++++
 .../rpc/rpc_broadc_clnt_broadcast/Makefile         |   25 ++++++
 .../rpc/rpc_createdestroy_clnt_create/Makefile     |   25 ++++++
 .../rpc/rpc_createdestroy_clnt_destroy/Makefile    |   25 ++++++
 .../rpc/rpc_createdestroy_clntraw_create/Makefile  |   25 ++++++
 .../rpc/rpc_createdestroy_clnttcp_create/Makefile  |   25 ++++++
 .../rpc_createdestroy_clntudp_bufcreate/Makefile   |   25 ++++++
 .../rpc/rpc_createdestroy_clntudp_create/Makefile  |   25 ++++++
 .../rpc/rpc_createdestroy_svc_destroy/Makefile     |   25 ++++++
 .../rpc/rpc_createdestroy_svcfd_create/Makefile    |   25 ++++++
 .../rpc/rpc_createdestroy_svcraw_create/Makefile   |   25 ++++++
 .../rpc/rpc_createdestroy_svctcp_create/Makefile   |   25 ++++++
 .../rpc_createdestroy_svcudp_bufcreate/Makefile    |   25 ++++++
 .../rpc/rpc_createdestroy_svcudp_create/Makefile   |   25 ++++++
 .../rpc/rpc_err_clnt_pcreateerror/Makefile         |   25 ++++++
 .../rpc_suite/rpc/rpc_err_clnt_perrno/Makefile     |   25 ++++++
 .../rpc_suite/rpc/rpc_err_clnt_perror/Makefile     |   25 ++++++
 .../rpc/rpc_err_clnt_spcreateerror/Makefile        |   25 ++++++
 .../rpc_suite/rpc/rpc_err_clnt_sperrno/Makefile    |   25 ++++++
 .../rpc_suite/rpc/rpc_err_clnt_sperror/Makefile    |   25 ++++++
 .../rpc_suite/rpc/rpc_err_svcerr_auth/Makefile     |   25 ++++++
 .../rpc_suite/rpc/rpc_err_svcerr_noproc/Makefile   |   25 ++++++
 .../rpc_suite/rpc/rpc_err_svcerr_noprog/Makefile   |   25 ++++++
 .../rpc_suite/rpc/rpc_err_svcerr_progvers/Makefile |   25 ++++++
 .../rpc/rpc_err_svcerr_systemerr/Makefile          |   25 ++++++
 .../rpc_suite/rpc/rpc_err_svcerr_weakauth/Makefile |   25 ++++++
 .../rpc/rpc_regunreg_registerrpc/Makefile          |   25 ++++++
 .../rpc/rpc_regunreg_svc_register/Makefile         |   25 ++++++
 .../rpc/rpc_regunreg_svc_unregister/Makefile       |   25 ++++++
 .../rpc/rpc_regunreg_xprt_register/Makefile        |   25 ++++++
 .../rpc/rpc_regunreg_xprt_unregister/Makefile      |   25 ++++++
 .../rpc_suite/rpc/rpc_stdcall_callrpc/Makefile     |   25 ++++++
 .../rpc_suite/rpc/rpc_stdcall_clnt_call/Makefile   |   25 ++++++
 .../rpc/rpc_stdcall_clnt_control/Makefile          |   25 ++++++
 .../rpc/rpc_stdcall_clnt_freeres/Makefile          |   25 ++++++
 .../rpc_suite/rpc/rpc_stdcall_clnt_geterr/Makefile |   25 ++++++
 .../rpc/rpc_stdcall_svc_freeargs/Makefile          |   25 ++++++
 .../rpc_suite/rpc/rpc_stdcall_svc_getargs/Makefile |   25 ++++++
 .../rpc/rpc_stdcall_svc_getcaller/Makefile         |   25 ++++++
 .../rpc/rpc_stdcall_svc_sendreply/Makefile         |   25 ++++++
 .../tests_pack/rpc_svc_1/Makefile                  |   27 ++++++
 154 files changed, 1623 insertions(+), 146 deletions(-)
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/.gitignore
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/Makefile.inc
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c
 delete mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c.src
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/Makefile.inc
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_get_myaddress/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getmaps/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getport/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_set/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_unset/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_auth_auth_destroy/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_auth_authnone_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create_default/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_destroy/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntraw_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcraw_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_bufcreate/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_pcreateerror/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_perrno/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_perror/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_spcreateerror/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperrno/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperror/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_auth/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noproc/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noprog/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_progvers/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_systemerr/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_weakauth/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_register/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_unregister/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_callrpc/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_control/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_freeres/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_geterr/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getcaller/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_svc_1/Makefile

diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/.gitignore b/testcases/network/rpc/rpc-tirpc-full-test-suite/.gitignore
new file mode 100644
index 0000000..56fa637
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/.gitignore
@@ -0,0 +1,91 @@
+/tests_pack/cleaner
+/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_get_myaddress/1-basic
+/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getmaps/1-basic
+/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getport/1-basic
+/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/1-basic
+/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/2-stress
+/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/7-performance
+/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_set/1-basic
+/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_unset/1-basic
+/tests_pack/rpc_suite/rpc/rpc_auth_auth_destroy/1-basic
+/tests_pack/rpc_suite/rpc/rpc_auth_authnone_create/1-basic
+/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create/1-basic
+/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create_default/1-basic
+/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/1-basic
+/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/2-stress
+/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/5-scalability
+/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/6-dataint
+/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/7-performance
+/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/8-complex
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_create/1-basic
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_create/2-stress
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_destroy/1-basic
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_destroy/2-stress
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntraw_create/1-basic
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntraw_create/7-performance
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntraw_create/8-complex
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/1-basic
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/2-stress
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/3-limits
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/7-performance
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/1-basic
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/3-limits
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/1-basic
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/2-stress
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/7-performance
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/1-basic
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/2-stress
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/1-basic
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/3-limits
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcraw_create/1-basic
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcraw_create/7-performance
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/1-basic
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/2-stress
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/3-limits
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/7-performance
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_bufcreate/1-basic
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_bufcreate/3-limits
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/1-basic
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/2-stress
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/7-performance
+/tests_pack/rpc_suite/rpc/rpc_err_clnt_pcreateerror/1-basic
+/tests_pack/rpc_suite/rpc/rpc_err_clnt_perrno/1-basic
+/tests_pack/rpc_suite/rpc/rpc_err_clnt_perror/1-basic
+/tests_pack/rpc_suite/rpc/rpc_err_clnt_spcreateerror/1-basic
+/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperrno/1-basic
+/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperror/1-basic
+/tests_pack/rpc_suite/rpc/rpc_err_svcerr_auth/1-basic
+/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noproc/1-basic
+/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noprog/1-basic
+/tests_pack/rpc_suite/rpc/rpc_err_svcerr_progvers/1-basic
+/tests_pack/rpc_suite/rpc/rpc_err_svcerr_systemerr/1-basic
+/tests_pack/rpc_suite/rpc/rpc_err_svcerr_weakauth/1-basic
+/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/1-basic
+/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_register/1-basic
+/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_unregister/1-basic
+/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/1-basic
+/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/1-basic
+/tests_pack/rpc_suite/rpc/rpc_stdcall_callrpc/1-basic
+/tests_pack/rpc_suite/rpc/rpc_stdcall_callrpc/2-stress
+/tests_pack/rpc_suite/rpc/rpc_stdcall_callrpc/5-scalability
+/tests_pack/rpc_suite/rpc/rpc_stdcall_callrpc/6-dataint
+/tests_pack/rpc_suite/rpc/rpc_stdcall_callrpc/7-performance
+/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/1-basic
+/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/2-stress
+/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/5-scalability
+/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/6-dataint
+/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/7-performance
+/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/8-complex
+/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_control/1-basic
+/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_control/6-dataint
+/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_freeres/1-basic
+/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_geterr/1-basic
+/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/1-basic
+/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/svc
+/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/1-basic
+/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/6-dataint
+/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/client
+/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getcaller/1-basic
+/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/1-basic
+/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/client
+/tests_pack/rpc_svc_1/rpc_svc_1
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/Makefile
new file mode 100644
index 0000000..91f9324
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/Makefile
@@ -0,0 +1,27 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../..
+top_rpcsrcdir		?= $(abs_srcdir)
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+
+INSTALL_TARGETS		:= rpc_ts_run.sh rpc*basic*_lib.sh
+
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/Makefile.inc b/testcases/network/rpc/rpc-tirpc-full-test-suite/Makefile.inc
new file mode 100644
index 0000000..1fafbd4
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/Makefile.inc
@@ -0,0 +1,3 @@
+INSTALL_BASE_DIR	:= testcases/network/rpc
+CUR_DIR			:= $(shell echo $(abs_srcdir) | sed 's/.*testcases\/network\/rpc\///')
+INSTALL_DIR		:= $(INSTALL_BASE_DIR)/$(CUR_DIR)
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_addrmanagmt_basic_lib.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_addrmanagmt_basic_lib.sh
index 64aab7e..331a28f 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_addrmanagmt_basic_lib.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_addrmanagmt_basic_lib.sh
@@ -25,7 +25,7 @@ TESTSUITEDATE="2007-06-04"
 TESTSUITECOMM=""
 
 TESTSERVER_1_PATH="rpc_svc_1"
-TESTSERVER_1_BIN="rpc_svc_1.bin"
+TESTSERVER_1_BIN="rpc_svc_1"
 TESTSERVER_1=$SERVERTSTPACKDIR/$TESTSERVER_1_PATH/$TESTSERVER_1_BIN
 
 export TESTSERVER_1_PATH
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_auth_basic_lib.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_auth_basic_lib.sh
index 1a373a1..31acf3a 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_auth_basic_lib.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_auth_basic_lib.sh
@@ -25,7 +25,7 @@ TESTSUITEDATE="2007-06-05"
 TESTSUITECOMM=""
 
 TESTSERVER_1_PATH="rpc_svc_1"
-TESTSERVER_1_BIN="rpc_svc_1.bin"
+TESTSERVER_1_BIN="rpc_svc_1"
 TESTSERVER_1=$SERVERTSTPACKDIR/$TESTSERVER_1_PATH/$TESTSERVER_1_BIN
 
 export TESTSERVER_1_PATH
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_broadc_basic_lib.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_broadc_basic_lib.sh
index 4e0afde..7910ae1 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_broadc_basic_lib.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_broadc_basic_lib.sh
@@ -25,7 +25,7 @@ TESTSUITEDATE="2007-06-04"
 TESTSUITECOMM=""
 
 TESTSERVER_1_PATH="rpc_svc_1"
-TESTSERVER_1_BIN="rpc_svc_1.bin"
+TESTSERVER_1_BIN="rpc_svc_1"
 TESTSERVER_1=$SERVERTSTPACKDIR/$TESTSERVER_1_PATH/$TESTSERVER_1_BIN
 
 export TESTSERVER_1_PATH
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_createdestroy_basic_lib.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_createdestroy_basic_lib.sh
index 01f93b5..4d5d01e 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_createdestroy_basic_lib.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_createdestroy_basic_lib.sh
@@ -25,7 +25,7 @@ TESTSUITEDATE="2007-"
 TESTSUITECOMM=""
 
 TESTSERVER_1_PATH="rpc_svc_1"
-TESTSERVER_1_BIN="rpc_svc_1.bin"
+TESTSERVER_1_BIN="rpc_svc_1"
 TESTSERVER_1=$SERVERTSTPACKDIR/$TESTSERVER_1_PATH/$TESTSERVER_1_BIN
 
 export TESTSERVER_1_PATH
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_err_basic_lib.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_err_basic_lib.sh
index e155927..c56b513 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_err_basic_lib.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_err_basic_lib.sh
@@ -25,7 +25,7 @@ TESTSUITEDATE="2007-06-05"
 TESTSUITECOMM=""
 
 TESTSERVER_1_PATH="rpc_svc_1"
-TESTSERVER_1_BIN="rpc_svc_1.bin"
+TESTSERVER_1_BIN="rpc_svc_1"
 TESTSERVER_1=$SERVERTSTPACKDIR/$TESTSERVER_1_PATH/$TESTSERVER_1_BIN
 
 export TESTSERVER_1_PATH
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_regunreg_basic_lib.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_regunreg_basic_lib.sh
index d29e603..4db762d 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_regunreg_basic_lib.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_regunreg_basic_lib.sh
@@ -25,7 +25,7 @@ TESTSUITEDATE="2007-05-30"
 TESTSUITECOMM=""
 
 TESTSERVER_1_PATH="rpc_svc_1"
-TESTSERVER_1_BIN="rpc_svc_1.bin"
+TESTSERVER_1_BIN="rpc_svc_1"
 TESTSERVER_1=$SERVERTSTPACKDIR/$TESTSERVER_1_PATH/$TESTSERVER_1_BIN
 
 export TESTSERVER_1_PATH
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_stdcall_basic_lib.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_stdcall_basic_lib.sh
index c06860a..da36131 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_stdcall_basic_lib.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_stdcall_basic_lib.sh
@@ -25,7 +25,7 @@ TESTSUITEDATE="2007-05-31"
 TESTSUITECOMM=""
 
 TESTSERVER_1_PATH="rpc_svc_1"
-TESTSERVER_1_BIN="rpc_svc_1.bin"
+TESTSERVER_1_BIN="rpc_svc_1"
 TESTSERVER_1=$SERVERTSTPACKDIR/$TESTSERVER_1_PATH/$TESTSERVER_1_BIN
 
 export TESTSERVER_1_PATH
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_ts_run.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_ts_run.sh
index 44f2a16..e3fca59 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_ts_run.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_ts_run.sh
@@ -262,9 +262,9 @@ echo "*** End of test run ***">>$TESTRUNDETAILSLOG
 #-- Unreg all procedure
 for ((a=PROGNUMNOSVC; a < `expr $PROGNUMNOSVC + $TESTINSTANCE` ; a++))
 do
-	$REMOTESHELL $SERVERUSER@$SERVERIP "$SERVERTSTPACKDIR/cleaner.bin $a"
+	$REMOTESHELL $SERVERUSER@$SERVERIP "$SERVERTSTPACKDIR/cleaner $a"
 done
 for ((a=PROGNUMBASE; a < `expr $PROGNUMBASE + $TESTINSTANCE` ; a++))
 do
-	$REMOTESHELL $SERVERUSER@$SERVERIP "$SERVERTSTPACKDIR/cleaner.bin $a"
+	$REMOTESHELL $SERVERUSER@$SERVERIP "$SERVERTSTPACKDIR/cleaner $a"
 done
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/Makefile
new file mode 100644
index 0000000..c2d4b55
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/Makefile
@@ -0,0 +1,27 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../..
+top_rpcsrcdir		?= ../
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+
+INSTALL_TARGETS		:= rpc_*.sh
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_get_myaddress.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_get_myaddress.sh
index 2723424..095c851 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_get_myaddress.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_get_myaddress.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_addr-managmt_get_myaddress.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_addrmanagmt_get_myaddress"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_getmaps.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_getmaps.sh
index d270c4a..529a65a 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_getmaps.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_getmaps.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_addr-managmt_pmap_getmaps.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_addrmanagmt_pmap_getmaps"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_getport.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_getport.sh
index 0fba212..72cefec 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_getport.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_getport.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_addr-managmt_pmap_getport.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_addrmanagmt_pmap_getport"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_rmtcall.performance.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_rmtcall.performance.sh
index d080f7d..d563074 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_rmtcall.performance.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_rmtcall.performance.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_addr-managmt_pmap_rmtcall.performance"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall"
-TESTCLIENTBIN="7-performance.bin"
+TESTCLIENTBIN="7-performance"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_rmtcall.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_rmtcall.sh
index 6433f68..b13cc68 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_rmtcall.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_rmtcall.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_addr-managmt_pmap_rmtcall.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_rmtcall.stress.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_rmtcall.stress.sh
index f42f81e..8863596 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_rmtcall.stress.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_rmtcall.stress.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_addr-managmt_pmap_rmtcall.stress"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall"
-TESTCLIENTBIN="2-stress.bin"
+TESTCLIENTBIN="2-stress"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_set.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_set.sh
index 94f7fa9..5bb3b46 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_set.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_set.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_addr-managmt_pmap_set.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_addrmanagmt_pmap_set"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_unset.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_unset.sh
index bfdafb3..c5eea24 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_unset.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_addrmanagmt_pmap_unset.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_addr-managmt_pmap_unset.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_addrmanagmt_pmap_unset"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_auth_auth_destroy.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_auth_auth_destroy.sh
index 91e4e3b..77e74e2 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_auth_auth_destroy.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_auth_auth_destroy.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_auth_auth_destroy.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_auth_auth_destroy"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_auth_authnone_create.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_auth_authnone_create.sh
index 86ff54a..37d7b97 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_auth_authnone_create.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_auth_authnone_create.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_auth_authnone_create.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_auth_authnone_create"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_auth_authunix_create.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_auth_authunix_create.sh
index b673c92..27e0091 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_auth_authunix_create.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_auth_authunix_create.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_auth_authunix_create.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_auth_authunix_create"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_auth_authunix_create_default.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_auth_authunix_create_default.sh
index 440cb00..ca8723f 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_auth_authunix_create_default.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_auth_authunix_create_default.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_auth_authunix_create_default.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_auth_authunix_create_default"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.complex.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.complex.sh
index 38306a4..e23bc48 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.complex.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.complex.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_broadc_clnt_broadcast.complex"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_broadc_clnt_broadcast"
-TESTCLIENTBIN="8-complex.bin"
+TESTCLIENTBIN="8-complex"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.dataint.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.dataint.sh
index 31b4108..2ce80be 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.dataint.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.dataint.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_broadc_clnt_broadcast.dataint"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_broadc_clnt_broadcast"
-TESTCLIENTBIN="6-dataint.bin"
+TESTCLIENTBIN="6-dataint"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.performance.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.performance.sh
index 205f1d1..531c529 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.performance.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.performance.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_broadc_clnt_broadcast.performance"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_broadc_clnt_broadcast"
-TESTCLIENTBIN="7-performance.bin"
+TESTCLIENTBIN="7-performance"
 TESTCLNTMN="7-perf"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.scalability.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.scalability.sh
index e64d9c6..2c11851 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.scalability.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.scalability.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_broadc_clnt_broadcast.scalability"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_broadc_clnt_broadcast"
-TESTCLIENTBIN="5-scalability.bin"
+TESTCLIENTBIN="5-scalability"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.sh
index 358c30a..f3603ae 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.sh
@@ -17,7 +17,7 @@ TESTNAME="rpc_broadc_clnt_broadcast.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_broadc_clnt_broadcast"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.stress.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.stress.sh
index c0bfe56..b06eb40 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.stress.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_broadc_clnt_broadcast.stress.sh
@@ -17,7 +17,7 @@ TESTNAME="rpc_broadc_clnt_broadcast.stress"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_broadc_clnt_broadcast"
-TESTCLIENTBIN="2-stress.bin"
+TESTCLIENTBIN="2-stress"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnt_create.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnt_create.sh
index b67660e..64fe9c9 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnt_create.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnt_create.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_clnt_create.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_clnt_create"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnt_create.stress.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnt_create.stress.sh
index c08cad3..0ce83d6 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnt_create.stress.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnt_create.stress.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_clnt_create.stress"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_clnt_create"
-TESTCLIENTBIN="2-stress.bin"
+TESTCLIENTBIN="2-stress"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnt_destroy.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnt_destroy.sh
index 7e4e09c..6259467 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnt_destroy.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnt_destroy.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_clnt_destroy.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_clnt_destroy"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnt_destroy.stress.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnt_destroy.stress.sh
index 1c91505..37fdd05 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnt_destroy.stress.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnt_destroy.stress.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_clnt_destroy.stress"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_clnt_destroy"
-TESTCLIENTBIN="2-stress.bin"
+TESTCLIENTBIN="2-stress"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntraw_create.complex.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntraw_create.complex.sh
index 82286ab..a1cdce1 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntraw_create.complex.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntraw_create.complex.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_clntraw_create.complex"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_clntraw_create"
-TESTCLIENTBIN="8-complex.bin"
+TESTCLIENTBIN="8-complex"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntraw_create.performance.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntraw_create.performance.sh
index 01f020a..97933f5 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntraw_create.performance.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntraw_create.performance.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_clntraw_create.performance"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_clntraw_create"
-TESTCLIENTBIN="7-performance.bin"
+TESTCLIENTBIN="7-performance"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntraw_create.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntraw_create.sh
index 27145d6..07d54bf 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntraw_create.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntraw_create.sh
@@ -17,7 +17,7 @@ TESTNAME="rpc_create-destroy_clntraw_create"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_clntraw_create"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnttcp_create.limits.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnttcp_create.limits.sh
index ee55f3a..8774373 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnttcp_create.limits.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnttcp_create.limits.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_clnttcp_create.limits"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_clnttcp_create"
-TESTCLIENTBIN="3-limits.bin"
+TESTCLIENTBIN="3-limits"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnttcp_create.performance.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnttcp_create.performance.sh
index e3762aa..8a7167d 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnttcp_create.performance.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnttcp_create.performance.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_clnttcp_create.performance"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_clnttcp_create"
-TESTCLIENTBIN="7-performance.bin"
+TESTCLIENTBIN="7-performance"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnttcp_create.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnttcp_create.sh
index b9cd84b..9bdeb69 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnttcp_create.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnttcp_create.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_clnttcp_create.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_clnttcp_create"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnttcp_create.stress.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnttcp_create.stress.sh
index 2118012..fea5108 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnttcp_create.stress.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clnttcp_create.stress.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_clnttcp_create.stress"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_clnttcp_create"
-TESTCLIENTBIN="2-stress.bin"
+TESTCLIENTBIN="2-stress"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntudp_bufcreate.limits.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntudp_bufcreate.limits.sh
index 884b167..443fc6a 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntudp_bufcreate.limits.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntudp_bufcreate.limits.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_clntudp_bufcreate.limits"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate"
-TESTCLIENTBIN="3-limits.bin"
+TESTCLIENTBIN="3-limits"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntudp_bufcreate.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntudp_bufcreate.sh
index 9ed163e..b8d9790 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntudp_bufcreate.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntudp_bufcreate.sh
@@ -17,7 +17,7 @@ TESTNAME="rpc_create-destroy_clntudp_bufcreate"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntudp_create.performance.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntudp_create.performance.sh
index ab756cd..a82d311 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntudp_create.performance.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntudp_create.performance.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_clntudp_create.performance"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_clntudp_create"
-TESTCLIENTBIN="7-performance.bin"
+TESTCLIENTBIN="7-performance"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntudp_create.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntudp_create.sh
index 462244e..285fb26 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntudp_create.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntudp_create.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_clntudp_create.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_clntudp_create"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntudp_create.stress.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntudp_create.stress.sh
index 29d29e4..5b65ae7 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntudp_create.stress.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_clntudp_create.stress.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_clntudp_create.stress"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_clntudp_create"
-TESTCLIENTBIN="2-stress.bin"
+TESTCLIENTBIN="2-stress"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svc_destroy.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svc_destroy.sh
index 34cffca..bc05174 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svc_destroy.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svc_destroy.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_svc_destroy.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_svc_destroy"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svc_destroy.stress.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svc_destroy.stress.sh
index 4f7b2c7..2bbc4e2 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svc_destroy.stress.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svc_destroy.stress.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_svc_destroy.stress"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_svc_destroy"
-TESTCLIENTBIN="2-stress.bin"
+TESTCLIENTBIN="2-stress"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcfd_create.limits.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcfd_create.limits.sh
index 175395d..b448ce0 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcfd_create.limits.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcfd_create.limits.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_svcfd_create.limits"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_svcfd_create"
-TESTCLIENTBIN="3-limits.bin"
+TESTCLIENTBIN="3-limits"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcfd_create.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcfd_create.sh
index c9e9681..10f325e 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcfd_create.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcfd_create.sh
@@ -17,7 +17,7 @@ TESTNAME="rpc_create-destroy_svcfd_create"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_svcfd_create"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcraw_create.performance.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcraw_create.performance.sh
index 75364bb..ae0bad7 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcraw_create.performance.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcraw_create.performance.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_svcraw_create.performance"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_svcraw_create"
-TESTCLIENTBIN="7-performance.bin"
+TESTCLIENTBIN="7-performance"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcraw_create.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcraw_create.sh
index e1ca0ba..9f3d9a7 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcraw_create.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcraw_create.sh
@@ -17,7 +17,7 @@ TESTNAME="rpc_create-destroy_svcraw_create"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_svcraw_create"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svctcp_create.limits.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svctcp_create.limits.sh
index 8b2c09d..0a3f4c6 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svctcp_create.limits.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svctcp_create.limits.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_svctcp_create.limits"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_svctcp_create"
-TESTCLIENTBIN="3-limits.bin"
+TESTCLIENTBIN="3-limits"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svctcp_create.performance.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svctcp_create.performance.sh
index c3ba3aa..2fa1734 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svctcp_create.performance.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svctcp_create.performance.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_svctcp_create.performance"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_svctcp_create"
-TESTCLIENTBIN="7-performance.bin"
+TESTCLIENTBIN="7-performance"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svctcp_create.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svctcp_create.sh
index d42e6b6..417a7db 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svctcp_create.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svctcp_create.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_svctcp_create.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_svctcp_create"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svctcp_create.stress.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svctcp_create.stress.sh
index f2a5989..4d5d7ff 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svctcp_create.stress.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svctcp_create.stress.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_svctcp_create.stress"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_svctcp_create"
-TESTCLIENTBIN="2-stress.bin"
+TESTCLIENTBIN="2-stress"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcudp_bufcreate.limits.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcudp_bufcreate.limits.sh
index e92d90d..7c18aac 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcudp_bufcreate.limits.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcudp_bufcreate.limits.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_svcudp_bufcreate.limits"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_svcudp_bufcreate"
-TESTCLIENTBIN="3-limits.bin"
+TESTCLIENTBIN="3-limits"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcudp_bufcreate.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcudp_bufcreate.sh
index 283ffe6..94b1231 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcudp_bufcreate.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcudp_bufcreate.sh
@@ -17,7 +17,7 @@ TESTNAME="rpc_create-destroy_svcudp_bufcreate"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_svcudp_bufcreate"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcudp_create.performance.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcudp_create.performance.sh
index e102bdd..cff26bb 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcudp_create.performance.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcudp_create.performance.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_svcudp_create.performance"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_svcudp_create"
-TESTCLIENTBIN="7-performance.bin"
+TESTCLIENTBIN="7-performance"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcudp_create.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcudp_create.sh
index 8fc3011..75a5aaf 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcudp_create.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcudp_create.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_svcudp_create.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_svcudp_create"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcudp_create.stress.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcudp_create.stress.sh
index 62871aa..c4d55b9 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcudp_create.stress.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_createdestroy_svcudp_create.stress.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_create-destroy_svcudp_create.stress"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_createdestroy_svcudp_create"
-TESTCLIENTBIN="2-stress.bin"
+TESTCLIENTBIN="2-stress"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_pcreateerror.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_pcreateerror.sh
index b776722..09667ea 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_pcreateerror.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_pcreateerror.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_err_clnt_pcreateerror.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_err_clnt_pcreateerror"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_perrno.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_perrno.sh
index 000dcfc..b78b7f4 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_perrno.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_perrno.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_err_clnt_perrno.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_err_clnt_perrno"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_perror.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_perror.sh
index 452a8fb..1004b05 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_perror.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_perror.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_err_clnt_perror.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_err_clnt_perror"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_spcreateerror.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_spcreateerror.sh
index 05dcdd6..551d3a4 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_spcreateerror.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_spcreateerror.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_err_clnt_spcreateerror.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_err_clnt_spcreateerror"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_sperrno.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_sperrno.sh
index 3c1c60b..253a998 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_sperrno.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_sperrno.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_err_clnt_sperrno.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_err_clnt_sperrno"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_sperror.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_sperror.sh
index e2c11d5..8432f96 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_sperror.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_clnt_sperror.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_err_clnt_sperror.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_err_clnt_sperror"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_auth.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_auth.sh
index 79b0199..3bebbbc 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_auth.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_auth.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_err_svcerr_auth.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_err_svcerr_auth"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_noproc.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_noproc.sh
index d6111fd..3b30567 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_noproc.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_noproc.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_err_svcerr_noproc.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_err_svcerr_noproc"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_noprog.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_noprog.sh
index a8b727f..e291bb5 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_noprog.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_noprog.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_err_svcerr_noprog.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_err_svcerr_noprog"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_progvers.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_progvers.sh
index 9420d43..784bab4 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_progvers.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_progvers.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_err_svcerr_progvers.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_err_svcerr_progvers"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_systemerr.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_systemerr.sh
index e241e45..afa6fd8 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_systemerr.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_systemerr.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_err_svcerr_systemerr.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_err_svcerr_systemerr"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_weakauth.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_weakauth.sh
index 4dcec41..26cd572 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_weakauth.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_err_svcerr_weakauth.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_err_svcerr_weakauth.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_err_svcerr_weakauth"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_regunreg_registerrpc.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_regunreg_registerrpc.sh
index 3ded1d6..8490704 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_regunreg_registerrpc.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_regunreg_registerrpc.sh
@@ -17,7 +17,7 @@ TESTNAME="rpc_reg-unreg_registerrpc.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_regunreg_registerrpc"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_regunreg_svc_register.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_regunreg_svc_register.sh
index eee7168..2aabf80 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_regunreg_svc_register.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_regunreg_svc_register.sh
@@ -17,7 +17,7 @@ TESTNAME="rpc_reg-unreg_svc_register.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_regunreg_svc_register"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_regunreg_svc_unregister.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_regunreg_svc_unregister.sh
index 001616d..558fac0 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_regunreg_svc_unregister.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_regunreg_svc_unregister.sh
@@ -17,7 +17,7 @@ TESTNAME="rpc_reg-unreg_svc_unregister.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_regunreg_svc_unregister"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_regunreg_xprt_register.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_regunreg_xprt_register.sh
index 8e57ac2..d1d6164 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_regunreg_xprt_register.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_regunreg_xprt_register.sh
@@ -17,7 +17,7 @@ TESTNAME="rpc_reg-unreg_xprt_register.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_regunreg_xprt_register"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_regunreg_xprt_unregister.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_regunreg_xprt_unregister.sh
index d8b31f0..cdb81c4 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_regunreg_xprt_unregister.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_regunreg_xprt_unregister.sh
@@ -17,7 +17,7 @@ TESTNAME="rpc_reg-unreg_xprt_unregister.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_regunreg_xprt_unregister"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_callrpc.dataint.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_callrpc.dataint.sh
index 172f004..fa3ee9a 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_callrpc.dataint.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_callrpc.dataint.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_std-call_callrpc.dataint"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_stdcall_callrpc"
-TESTCLIENTBIN="6-dataint.bin"
+TESTCLIENTBIN="6-dataint"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_callrpc.performance.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_callrpc.performance.sh
index c0d01b7..2516b41 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_callrpc.performance.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_callrpc.performance.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_std-call_callrpc.performance"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_stdcall_callrpc"
-TESTCLIENTBIN="7-performance.bin"
+TESTCLIENTBIN="7-performance"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_callrpc.scalability.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_callrpc.scalability.sh
index 796bda5..0ca7591 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_callrpc.scalability.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_callrpc.scalability.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_std-call_callrpc.scalability"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_stdcall_callrpc"
-TESTCLIENTBIN="5-scalability.bin"
+TESTCLIENTBIN="5-scalability"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_callrpc.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_callrpc.sh
index 4ed8a1b..c1760a6 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_callrpc.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_callrpc.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_std-call_callrpc.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_stdcall_callrpc"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_callrpc.stress.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_callrpc.stress.sh
index 28eb8f1..a62d9d4 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_callrpc.stress.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_callrpc.stress.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_std-call_callrpc.stress"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_stdcall_callrpc"
-TESTCLIENTBIN="2-stress.bin"
+TESTCLIENTBIN="2-stress"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.complex.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.complex.sh
index 76fa974..672c8b0 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.complex.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.complex.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_std-call_clnt_call.complex"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_stdcall_clnt_call"
-TESTCLIENTBIN="8-complex.bin"
+TESTCLIENTBIN="8-complex"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.dataint.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.dataint.sh
index 10549b7..79b6cb5 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.dataint.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.dataint.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_std-call_clnt_call.dataint"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_stdcall_clnt_call"
-TESTCLIENTBIN="6-dataint.bin"
+TESTCLIENTBIN="6-dataint"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.performance.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.performance.sh
index e0cb7b9..29cf2bc 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.performance.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.performance.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_std-call_clnt_call.performance"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_stdcall_clnt_call"
-TESTCLIENTBIN="7-performance.bin"
+TESTCLIENTBIN="7-performance"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.scalability.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.scalability.sh
index f6b7dce..7a67d03 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.scalability.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.scalability.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_std-call_clnt_call.scalability"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_stdcall_clnt_call"
-TESTCLIENTBIN="5-scalability.bin"
+TESTCLIENTBIN="5-scalability"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.sh
index 9598161..cd8801b 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_std-call_clnt_call.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_stdcall_clnt_call"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.stress.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.stress.sh
index 054d5a3..138005d 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.stress.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_call.stress.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_std-call_clnt_call.stress"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_stdcall_clnt_call"
-TESTCLIENTBIN="2-stress.bin"
+TESTCLIENTBIN="2-stress"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_control.dataint.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_control.dataint.sh
index d761c82..d60acfb 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_control.dataint.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_control.dataint.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_std-call_clnt_control.dataint"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_stdcall_clnt_control"
-TESTCLIENTBIN="6-dataint.bin"
+TESTCLIENTBIN="6-dataint"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_control.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_control.sh
index 016533e..b268c64 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_control.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_control.sh
@@ -17,7 +17,7 @@ TESTNAME="rpc_std-call_clnt_control"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_stdcall_clnt_control"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_freeres.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_freeres.sh
index 525ec19..8dcb487 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_freeres.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_freeres.sh
@@ -17,7 +17,7 @@ TESTNAME="rpc_std-call_clnt_freeres.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_stdcall_clnt_freeres"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_geterr.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_geterr.sh
index 6027d3d..01291b4 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_geterr.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_clnt_geterr.sh
@@ -17,7 +17,7 @@ TESTNAME="rpc_std-call_clnt_geterr"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_stdcall_clnt_geterr"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_freeargs.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_freeargs.sh
index d074ff5..3af075b 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_freeargs.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_freeargs.sh
@@ -17,9 +17,9 @@ TESTNAME="rpc_std-call_svc_freeargs.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_stdcall_svc_freeargs"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
-TESTSVCBIN="svc.bin"
+TESTSVCBIN="svc"
 TESTSVC=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTSVCBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_getargs.dataint.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_getargs.dataint.sh
index 0f8d686..4af8218 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_getargs.dataint.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_getargs.dataint.sh
@@ -17,7 +17,7 @@ TESTNAME="RPC_std-call_svc_getargs.dataint"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_stdcall_svc_getargs"
-TESTCLIENTBIN="6-dataint.bin"
+TESTCLIENTBIN="6-dataint"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_getargs.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_getargs.sh
index 1eea921..2878ffa 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_getargs.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_getargs.sh
@@ -17,9 +17,9 @@ TESTNAME="rpc_std-call_svc_getargs.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_stdcall_svc_getargs"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
-TESTSVCBIN="client.bin"
+TESTSVCBIN="client"
 TESTSVC=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTSVCBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_getcaller.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_getcaller.sh
index 6aa48f2..f5ddc70 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_getcaller.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_getcaller.sh
@@ -17,7 +17,7 @@ TESTNAME="rpc_std-call_svc_getcaller.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_stdcall_svc_getcaller"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_sendreply.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_sendreply.sh
index 466e43d..66e3a24 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_sendreply.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_sendreply.sh
@@ -17,9 +17,9 @@ TESTNAME="rpc_std-call_svc_sendreply.basic"
 TESTVERS="1.0"
 # test binaries, used to call
 TESTCLIENTPATH="rpc_suite/rpc/rpc_stdcall_svc_sendreply"
-TESTCLIENTBIN="1-basic.bin"
+TESTCLIENTBIN="1-basic"
 TESTCLIENT=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTCLIENTBIN
-TESTSVCBIN="client.bin"
+TESTSVCBIN="client"
 TESTSVC=$CLIENTTSTPACKDIR/$TESTCLIENTPATH/$TESTSVCBIN
 # table to save all tests result
 result=
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/Makefile
new file mode 100644
index 0000000..3bbbb8d
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/Makefile
@@ -0,0 +1,28 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../..
+top_rpcsrcdir		?= ../
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+
+CPPFLAGS	+= -I/usr/include/tirpc
+LDLIBS		+= -ltirpc -lpthread
+
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c
new file mode 100644
index 0000000..a23d378
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c
@@ -0,0 +1,48 @@
+/*
+* Copyright (c) Bull S.A.  2007 All Rights Reserved.
+*
+* This program is free software; you can redistribute it and/or modify it
+* under the terms of version 2 of the GNU General Public License as
+* published by the Free Software Foundation.
+*
+* This program is distributed in the hope that it would be useful, but
+* WITHOUT ANY WARRANTY; without even the implied warranty of
+* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+*
+* Further, this software is distributed without any warranty that it is
+* free of the rightful claim of any third person regarding infringement
+* or the like.  Any license provided herein, whether implied or
+* otherwise, applies only to this software file.  Patent licenses, if
+* any, provided herein do not apply to combinations of this program with
+* other software, or any other product whatsoever.
+*
+* You should have received a copy of the GNU General Public License along
+* with this program; if not, write the Free Software Foundation, Inc.,
+* 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+*
+* History:
+* Created by: Cyril Lacabanne (Cyril.Lacabanne@bull.net)
+*
+*/
+
+#include <stdio.h>
+#include <tirpc/netconfig.h>
+#include <sys/socket.h>
+#include <tirpc/rpc/rpc.h>
+#include <tirpc/rpc/types.h>
+#include <tirpc/rpc/xdr.h>
+#include <tirpc/rpc/svc.h>
+#include <errno.h>
+
+//Standard define
+#define VERSNUM 1
+
+int main(int argn, char *argc[])
+{
+	//Server parameter is : argc[1] : Server Program Number
+	int progNum = atoi((char *)argc[1]);
+
+	svc_unreg(progNum, VERSNUM);
+
+	return 0;
+}
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c.src b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c.src
deleted file mode 100644
index a23d378..0000000
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/cleaner.c.src
+++ /dev/null
@@ -1,48 +0,0 @@
-/*
-* Copyright (c) Bull S.A.  2007 All Rights Reserved.
-*
-* This program is free software; you can redistribute it and/or modify it
-* under the terms of version 2 of the GNU General Public License as
-* published by the Free Software Foundation.
-*
-* This program is distributed in the hope that it would be useful, but
-* WITHOUT ANY WARRANTY; without even the implied warranty of
-* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-*
-* Further, this software is distributed without any warranty that it is
-* free of the rightful claim of any third person regarding infringement
-* or the like.  Any license provided herein, whether implied or
-* otherwise, applies only to this software file.  Patent licenses, if
-* any, provided herein do not apply to combinations of this program with
-* other software, or any other product whatsoever.
-*
-* You should have received a copy of the GNU General Public License along
-* with this program; if not, write the Free Software Foundation, Inc.,
-* 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-*
-* History:
-* Created by: Cyril Lacabanne (Cyril.Lacabanne@bull.net)
-*
-*/
-
-#include <stdio.h>
-#include <tirpc/netconfig.h>
-#include <sys/socket.h>
-#include <tirpc/rpc/rpc.h>
-#include <tirpc/rpc/types.h>
-#include <tirpc/rpc/xdr.h>
-#include <tirpc/rpc/svc.h>
-#include <errno.h>
-
-//Standard define
-#define VERSNUM 1
-
-int main(int argn, char *argc[])
-{
-	//Server parameter is : argc[1] : Server Program Number
-	int progNum = atoi((char *)argc[1]);
-
-	svc_unreg(progNum, VERSNUM);
-
-	return 0;
-}
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/Makefile
new file mode 100644
index 0000000..189451d
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/Makefile
@@ -0,0 +1,24 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../..
+top_rpcsrcdir           ?= ../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/Makefile
new file mode 100644
index 0000000..5d40dc1
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/Makefile
@@ -0,0 +1,24 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../..
+top_rpcsrcdir           ?= ../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/Makefile.inc b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/Makefile.inc
new file mode 100644
index 0000000..980858c
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/Makefile.inc
@@ -0,0 +1 @@
+LDLIBS		+= -lnsl
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_get_myaddress/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_get_myaddress/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_get_myaddress/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getmaps/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getmaps/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getmaps/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getport/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getport/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getport/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_set/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_set/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_set/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_unset/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_unset/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_unset/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_auth_auth_destroy/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_auth_auth_destroy/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_auth_auth_destroy/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_auth_authnone_create/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_auth_authnone_create/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_auth_authnone_create/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create_default/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create_default/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create_default/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_create/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_create/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_create/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_destroy/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_destroy/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_destroy/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntraw_create/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntraw_create/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntraw_create/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcraw_create/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcraw_create/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcraw_create/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_bufcreate/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_bufcreate/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_bufcreate/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_pcreateerror/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_pcreateerror/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_pcreateerror/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_perrno/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_perrno/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_perrno/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_perror/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_perror/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_perror/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_spcreateerror/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_spcreateerror/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_spcreateerror/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperrno/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperrno/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperrno/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperror/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperror/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperror/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_auth/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_auth/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_auth/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noproc/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noproc/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noproc/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noprog/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noprog/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noprog/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_progvers/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_progvers/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_progvers/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_systemerr/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_systemerr/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_systemerr/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_weakauth/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_weakauth/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_err_svcerr_weakauth/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_register/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_register/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_register/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_unregister/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_unregister/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_unregister/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_callrpc/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_callrpc/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_callrpc/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_control/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_control/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_control/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_freeres/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_freeres/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_freeres/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_geterr/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_geterr/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_geterr/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getcaller/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getcaller/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getcaller/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/Makefile
new file mode 100644
index 0000000..c2cea11
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/Makefile
@@ -0,0 +1,25 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../../../..
+top_rpcsrcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_svc_1/Makefile b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_svc_1/Makefile
new file mode 100644
index 0000000..0989112
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_svc_1/Makefile
@@ -0,0 +1,27 @@
+#
+#    Copyright (C) 2013, Oracle and/or its affiliates. All Rights Reserved.
+#
+#    This program is free software; you can redistribute it and/or modify
+#    it under the terms of the GNU General Public License as published by
+#    the Free Software Foundation; either version 2 of the License, or
+#    (at your option) any later version.
+#
+#    This program is distributed in the hope that it will be useful,
+#    but WITHOUT ANY WARRANTY; without even the implied warranty of
+#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+#    GNU General Public License for more details.
+#
+#    You should have received a copy of the GNU General Public License along
+#    with this program; if not, write to the Free Software Foundation, Inc.,
+#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+#
+
+top_srcdir		?= ../../../../../..
+top_rpcsrcdir		?= ../..
+
+include $(top_srcdir)/include/mk/env_pre.mk
+include $(top_rpcsrcdir)/Makefile.inc
+
+LDLIBS		+= -lnsl
+
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
1.7.1


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
