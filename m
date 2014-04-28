Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WelvH-0004R6-Ae
	for ltp-list@lists.sourceforge.net; Mon, 28 Apr 2014 13:48:43 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Welv8-00032J-As
	for ltp-list@lists.sourceforge.net; Mon, 28 Apr 2014 13:48:43 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3SDmRWA020215
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Apr 2014 13:48:28 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3SDmQtQ028498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Apr 2014 13:48:26 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3SDmQwq025539
	for <ltp-list@lists.sourceforge.net>; Mon, 28 Apr 2014 13:48:26 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Mon, 28 Apr 2014 17:48:19 +0400
Message-Id: <1398692899-20204-1-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20140423155553.GB16286@rei.suse.cz>
References: <20140423155553.GB16286@rei.suse.cz>
Subject: [LTP] [PATCH V3 05/14] rpc-tirpc: enabled building of the test
	binaries
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

rpc-tirpc test suite is built only if libtirpc is present on
the host.

We link each binary with -ltirpc, because libtirpc is pretty mature now.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/network/rpc/Makefile                     |    4 +
 testcases/network/rpc/rpc-tirpc/.gitignore         |  211 ++++++++++++++++++++
 testcases/network/rpc/rpc-tirpc/Makefile           |   22 ++
 .../network/rpc/rpc-tirpc/tests_pack/Makefile      |   23 ++
 .../network/rpc/rpc-tirpc/tests_pack/Makefile.inc  |   20 ++
 .../rpc/rpc-tirpc/tests_pack/rpc_suite/Makefile    |   22 ++
 .../rpc-tirpc/tests_pack/rpc_suite/rpc/Makefile    |   22 ++
 .../rpc/rpc_addrmanagmt_get_myaddress/Makefile     |   23 ++
 .../rpc/rpc_addrmanagmt_pmap_getmaps/Makefile      |   23 ++
 .../rpc/rpc_addrmanagmt_pmap_getport/Makefile      |   23 ++
 .../rpc/rpc_addrmanagmt_pmap_rmtcall/Makefile      |   23 ++
 .../rpc/rpc_addrmanagmt_pmap_set/Makefile          |   23 ++
 .../rpc/rpc_addrmanagmt_pmap_unset/Makefile        |   23 ++
 .../rpc_suite/rpc/rpc_auth_auth_destroy/Makefile   |   23 ++
 .../rpc/rpc_auth_authnone_create/Makefile          |   23 ++
 .../rpc/rpc_auth_authunix_create/Makefile          |   23 ++
 .../rpc/rpc_auth_authunix_create_default/Makefile  |   23 ++
 .../rpc/rpc_broadc_clnt_broadcast/Makefile         |   23 ++
 .../rpc/rpc_createdestroy_clnt_create/Makefile     |   23 ++
 .../rpc/rpc_createdestroy_clnt_destroy/Makefile    |   23 ++
 .../rpc/rpc_createdestroy_clntraw_create/Makefile  |   23 ++
 .../rpc/rpc_createdestroy_clnttcp_create/Makefile  |   23 ++
 .../rpc_createdestroy_clntudp_bufcreate/Makefile   |   23 ++
 .../rpc/rpc_createdestroy_clntudp_create/Makefile  |   23 ++
 .../rpc/rpc_createdestroy_svc_destroy/Makefile     |   23 ++
 .../rpc/rpc_createdestroy_svcfd_create/Makefile    |   23 ++
 .../rpc/rpc_createdestroy_svcraw_create/Makefile   |   23 ++
 .../rpc/rpc_createdestroy_svctcp_create/Makefile   |   23 ++
 .../rpc_createdestroy_svcudp_bufcreate/Makefile    |   23 ++
 .../rpc/rpc_createdestroy_svcudp_create/Makefile   |   23 ++
 .../rpc/rpc_err_clnt_pcreateerror/Makefile         |   23 ++
 .../rpc_suite/rpc/rpc_err_clnt_perrno/Makefile     |   23 ++
 .../rpc_suite/rpc/rpc_err_clnt_perror/Makefile     |   23 ++
 .../rpc/rpc_err_clnt_spcreateerror/Makefile        |   23 ++
 .../rpc_suite/rpc/rpc_err_clnt_sperrno/Makefile    |   23 ++
 .../rpc_suite/rpc/rpc_err_clnt_sperror/Makefile    |   23 ++
 .../rpc_suite/rpc/rpc_err_svcerr_auth/Makefile     |   23 ++
 .../rpc_suite/rpc/rpc_err_svcerr_noproc/Makefile   |   23 ++
 .../rpc_suite/rpc/rpc_err_svcerr_noprog/Makefile   |   23 ++
 .../rpc_suite/rpc/rpc_err_svcerr_progvers/Makefile |   23 ++
 .../rpc/rpc_err_svcerr_systemerr/Makefile          |   23 ++
 .../rpc_suite/rpc/rpc_err_svcerr_weakauth/Makefile |   23 ++
 .../rpc/rpc_regunreg_registerrpc/Makefile          |   23 ++
 .../rpc/rpc_regunreg_svc_register/Makefile         |   23 ++
 .../rpc/rpc_regunreg_svc_unregister/Makefile       |   23 ++
 .../rpc/rpc_regunreg_xprt_register/Makefile        |   23 ++
 .../rpc/rpc_regunreg_xprt_unregister/Makefile      |   23 ++
 .../rpc_suite/rpc/rpc_stdcall_callrpc/Makefile     |   23 ++
 .../rpc_suite/rpc/rpc_stdcall_clnt_call/Makefile   |   23 ++
 .../rpc/rpc_stdcall_clnt_control/Makefile          |   23 ++
 .../rpc/rpc_stdcall_clnt_freeres/Makefile          |   23 ++
 .../rpc_suite/rpc/rpc_stdcall_clnt_geterr/Makefile |   23 ++
 .../rpc/rpc_stdcall_svc_freeargs/Makefile          |   23 ++
 .../rpc_suite/rpc/rpc_stdcall_svc_getargs/Makefile |   23 ++
 .../rpc/rpc_stdcall_svc_getcaller/Makefile         |   23 ++
 .../rpc/rpc_stdcall_svc_sendreply/Makefile         |   23 ++
 .../rpc-tirpc/tests_pack/rpc_suite/tirpc/Makefile  |   22 ++
 .../tirpc/tirpc_addrmanagmt_rpcb_getaddr/Makefile  |   23 ++
 .../tirpc/tirpc_addrmanagmt_rpcb_getmaps/Makefile  |   23 ++
 .../tirpc/tirpc_auth_authdes_create/Makefile       |   23 ++
 .../tirpc/tirpc_auth_authdes_seccreate/Makefile    |   23 ++
 .../tirpc/tirpc_auth_authnone_create/Makefile      |   23 ++
 .../tirpc/tirpc_auth_authsys_create/Makefile       |   23 ++
 .../tirpc_auth_authsys_create_default/Makefile     |   23 ++
 .../tirpc/tirpc_bottomlevel_clnt_call/Makefile     |   23 ++
 .../tirpc_bottomlevel_clnt_dg_create/Makefile      |   23 ++
 .../tirpc_bottomlevel_clnt_vc_create/Makefile      |   23 ++
 .../tirpc/tirpc_bottomlevel_svc_dg_create/Makefile |   23 ++
 .../tirpc/tirpc_bottomlevel_svc_vc_create/Makefile |   23 ++
 .../tirpc/tirpc_err_clnt_pcreateerror/Makefile     |   23 ++
 .../rpc_suite/tirpc/tirpc_err_clnt_perrno/Makefile |   23 ++
 .../rpc_suite/tirpc/tirpc_err_clnt_perror/Makefile |   23 ++
 .../tirpc/tirpc_err_svcerr_noproc/Makefile         |   23 ++
 .../tirpc/tirpc_err_svcerr_noprog/Makefile         |   23 ++
 .../tirpc/tirpc_err_svcerr_progvers/Makefile       |   23 ++
 .../tirpc/tirpc_err_svcerr_systemerr/Makefile      |   23 ++
 .../tirpc/tirpc_err_svcerr_weakauth/Makefile       |   23 ++
 .../tirpc/tirpc_expertlevel_clnt_call/Makefile     |   23 ++
 .../tirpc_expertlevel_clnt_tli_create/Makefile     |   23 ++
 .../tirpc/tirpc_expertlevel_rpcb_rmtcall/Makefile  |   23 ++
 .../tirpc/tirpc_expertlevel_rpcb_set/Makefile      |   23 ++
 .../tirpc/tirpc_expertlevel_rpcb_unset/Makefile    |   23 ++
 .../tirpc/tirpc_expertlevel_svc_reg/Makefile       |   23 ++
 .../tirpc_expertlevel_svc_tli_create/Makefile      |   23 ++
 .../tirpc/tirpc_expertlevel_svc_unreg/Makefile     |   23 ++
 .../tirpc/tirpc_interlevel_clnt_call/Makefile      |   23 ++
 .../tirpc/tirpc_interlevel_clnt_control/Makefile   |   23 ++
 .../tirpc/tirpc_interlevel_clnt_tp_create/Makefile |   23 ++
 .../tirpc_interlevel_clnt_tp_create_timed/Makefile |   23 ++
 .../tirpc/tirpc_interlevel_svc_tp_create/Makefile  |   23 ++
 .../tirpc/tirpc_simple_rpc_broadcast/Makefile      |   23 ++
 .../tirpc/tirpc_simple_rpc_broadcast_exp/Makefile  |   23 ++
 .../rpc_suite/tirpc/tirpc_simple_rpc_call/Makefile |   23 ++
 .../rpc_suite/tirpc/tirpc_simple_rpc_reg/Makefile  |   23 ++
 .../tirpc/tirpc_toplevel_clnt_call/Makefile        |   23 ++
 .../tirpc/tirpc_toplevel_clnt_create/Makefile      |   23 ++
 .../tirpc_toplevel_clnt_create_timed/Makefile      |   23 ++
 .../tirpc/tirpc_toplevel_clnt_destroy/Makefile     |   23 ++
 .../tirpc/tirpc_toplevel_svc_create/Makefile       |   23 ++
 .../tirpc/tirpc_toplevel_svc_destroy/Makefile      |   23 ++
 .../rpc/rpc-tirpc/tests_pack/rpc_svc_1/Makefile    |   23 ++
 .../rpc/rpc-tirpc/tests_pack/rpc_svc_2/Makefile    |   23 ++
 .../rpc/rpc-tirpc/tests_pack/tirpc_svc_1/Makefile  |   23 ++
 .../rpc/rpc-tirpc/tests_pack/tirpc_svc_11/Makefile |   23 ++
 .../rpc/rpc-tirpc/tests_pack/tirpc_svc_2/Makefile  |   23 ++
 .../rpc/rpc-tirpc/tests_pack/tirpc_svc_3/Makefile  |   23 ++
 .../rpc/rpc-tirpc/tests_pack/tirpc_svc_4/Makefile  |   23 ++
 .../rpc/rpc-tirpc/tests_pack/tirpc_svc_5/Makefile  |   23 ++
 .../rpc/rpc-tirpc/tests_pack/tirpc_svc_6/Makefile  |   23 ++
 .../rpc/rpc-tirpc/tests_pack/tirpc_svc_7/Makefile  |   23 ++
 .../rpc/rpc-tirpc/tests_pack/tirpc_svc_8/Makefile  |   23 ++
 .../rpc/rpc-tirpc/tests_pack/tirpc_svc_9/Makefile  |   23 ++
 112 files changed, 2738 insertions(+), 0 deletions(-)
 create mode 100644 testcases/network/rpc/rpc-tirpc/.gitignore
 create mode 100644 testcases/network/rpc/rpc-tirpc/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_get_myaddress/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getmaps/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getport/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_set/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_unset/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_auth_destroy/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authnone_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create_default/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_destroy/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntraw_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcraw_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_bufcreate/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_pcreateerror/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_perrno/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_perror/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_spcreateerror/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperrno/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperror/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_auth/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noproc/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noprog/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_progvers/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_systemerr/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_weakauth/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_register/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_unregister/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_callrpc/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_control/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_freeres/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_geterr/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getcaller/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getaddr/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getmaps/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_seccreate/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authnone_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create_default/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_pcreateerror/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noproc/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noprog/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_progvers/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_systemerr/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_weakauth/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_tli_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_set/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_unset/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_tli_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_control/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create_timed/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_svc_tp_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_destroy/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_create/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_destroy/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_1/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_2/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_1/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_11/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_2/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_3/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_4/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_6/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_7/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_8/Makefile
 create mode 100644 testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_9/Makefile

diff --git a/testcases/network/rpc/Makefile b/testcases/network/rpc/Makefile
index b783654..39e9faa 100644
--- a/testcases/network/rpc/Makefile
+++ b/testcases/network/rpc/Makefile
@@ -26,4 +26,8 @@ include $(top_srcdir)/include/mk/env_pre.mk
 
 INSTALL_TARGETS		:= *.sh
 
+ifeq ($(TIRPC_LIBS),)
+FILTER_OUT_DIRS		+= rpc-tirpc
+endif
+
 include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/.gitignore b/testcases/network/rpc/rpc-tirpc/.gitignore
new file mode 100644
index 0000000..0db3f81
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/.gitignore
@@ -0,0 +1,211 @@
+/tests_pack/rpc_svc_1/rpc_svc_1
+/tests_pack/rpc_svc_2/rpc_svc_2
+/tests_pack/tirpc_svc_1/tirpc_svc_1
+/tests_pack/tirpc_svc_2/tirpc_svc_2
+/tests_pack/tirpc_svc_3/tirpc_svc_3
+/tests_pack/tirpc_svc_4/tirpc_svc_4
+/tests_pack/tirpc_svc_5/tirpc_svc_5
+/tests_pack/tirpc_svc_6/tirpc_svc_6
+/tests_pack/tirpc_svc_7/tirpc_svc_7
+/tests_pack/tirpc_svc_8/tirpc_svc_8
+/tests_pack/tirpc_svc_9/tirpc_svc_9
+/tests_pack/tirpc_svc_11/tirpc_svc_11
+/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_control/rpc_clnt_control
+/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_control/rpc_clnt_control_dataint
+/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/rpc_svc_sendreply
+/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/rpc_svc_sendreply_client
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntraw_create/rpc_clntraw_create_performance
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntraw_create/rpc_clntraw_create
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntraw_create/rpc_clntraw_create_complex
+/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperrno/rpc_clnt_sperrno
+/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getmaps/rpc_pmap_getmaps
+/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register
+/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_dataint
+/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_performance
+/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_stress
+/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_complex
+/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast
+/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/rpc_clnt_broadcast_scalability
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/rpc_svcudp_create_performance
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/rpc_svcudp_create_stress
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/rpc_svcudp_create
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_bufcreate/rpc_svcudp_bufcreate
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_bufcreate/rpc_svcudp_bufcreate_limits
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcraw_create/rpc_svcraw_create_performance
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcraw_create/rpc_svcraw_create
+/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getport/rpc_pmap_getport
+/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_unregister/rpc_svc_unregister
+/tests_pack/rpc_suite/rpc/rpc_err_svcerr_systemerr/rpc_svcerr_systemerr
+/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_register/rpc_svc_register
+/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create/rpc_authunix_create
+/tests_pack/rpc_suite/rpc/rpc_err_clnt_perror/rpc_clnt_perror
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_create/rpc_clnt_create_stress
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_create/rpc_clnt_create
+/tests_pack/rpc_suite/rpc/rpc_err_svcerr_weakauth/rpc_svcerr_weakauth
+/tests_pack/rpc_suite/rpc/rpc_err_svcerr_progvers/rpc_svcerr_progvers
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_destroy/rpc_clnt_destroy
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_destroy/rpc_clnt_destroy_stress
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/rpc_svctcp_create_stress
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/rpc_svctcp_create_limits
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/rpc_svctcp_create
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/rpc_svctcp_create_performance
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_performance
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_stress
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/rpc_clnttcp_create_limits
+/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noprog/rpc_svcerr_noprog
+/tests_pack/rpc_suite/rpc/rpc_err_clnt_spcreateerror/rpc_clnt_spcreateerror
+/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister
+/tests_pack/rpc_suite/rpc/rpc_err_clnt_perrno/rpc_clnt_perrno
+/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/rpc_svc_getargs_dataint
+/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/rpc_svc_getargs
+/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/rpc_svc_getargs_client
+/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/rpc_clnt_call_performance
+/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/rpc_clnt_call_dataint
+/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/rpc_clnt_call_stress
+/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/rpc_clnt_call_complex
+/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/rpc_clnt_call
+/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/rpc_clnt_call_scalability
+/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/rpc_registerrpc
+/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_get_myaddress/rpc_get_myaddress
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/rpc_svcfd_create
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/rpc_svcfd_create_limits
+/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create_default/rpc_authunix_create_default
+/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperror/rpc_clnt_sperror
+/tests_pack/rpc_suite/rpc/rpc_err_svcerr_auth/rpc_svcerr_auth
+/tests_pack/rpc_suite/rpc/rpc_auth_auth_destroy/rpc_auth_destroy
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create_performance
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/rpc_clntudp_create_stress
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/rpc_clntudp_bufcreate_limits
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/rpc_clntudp_bufcreate
+/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/rpc_svc_freeargs_svc
+/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/rpc_svc_freeargs
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy_stress
+/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy
+/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_unset/rpc_pmap_unset
+/tests_pack/rpc_suite/rpc/rpc_auth_authnone_create/rpc_authnone_create
+/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall_stress
+/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall
+/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/rpc_pmap_rmtcall_performance
+/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_geterr/rpc_clnt_geterr
+/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_set/rpc_pmap_set
+/tests_pack/rpc_suite/rpc/rpc_err_clnt_pcreateerror/rpc_clnt_pcreateerror
+/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getcaller/rpc_svc_getcaller
+/tests_pack/rpc_suite/rpc/rpc_stdcall_callrpc/rpc_callrpc_stress
+/tests_pack/rpc_suite/rpc/rpc_stdcall_callrpc/rpc_callrpc
+/tests_pack/rpc_suite/rpc/rpc_stdcall_callrpc/rpc_callrpc_dataint
+/tests_pack/rpc_suite/rpc/rpc_stdcall_callrpc/rpc_callrpc_scalability
+/tests_pack/rpc_suite/rpc/rpc_stdcall_callrpc/rpc_callrpc_performance
+/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noproc/rpc_svcerr_noproc
+/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_freeres/rpc_clnt_freeres
+/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getmaps/tirpc_rpcb_getmaps
+/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call
+/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_complex
+/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_dataint
+/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_mt
+/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_performance
+/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_scalability
+/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/tirpc_toplevel_clnt_call_stress
+/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror
+/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/tirpc_clnt_perror_complex
+/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create
+/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/tirpc_svc_dg_create_limits
+/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_progvers/tirpc_svcerr_progvers
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_stress
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_mt
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_scalability
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_dataint
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_complex
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/tirpc_rpc_broadcast_performance
+/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_destroy/tirpc_clnt_destroy
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_mt
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/tirpc_rpc_reg_stress
+/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_pcreateerror/tirpc_clnt_pcreateerror
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_complex
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_dataint
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_mt
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_performance
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_scalability
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/tirpc_expertlevel_clnt_call_stress
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_scalability
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_dataint
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_stress
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_complex
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_mt
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall_performance
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/tirpc_rpcb_rmtcall
+/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_seccreate/tirpc_authdes_seccreate
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_set/tirpc_rpcb_set
+/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_weakauth/tirpc_svcerr_weakauth
+/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_systemerr/tirpc_svcerr_systemerr
+/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno
+/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/tirpc_clnt_perrno_complex
+/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create_timed/tirpc_clnt_tp_create_timed_limits
+/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create_timed/tirpc_clnt_tp_create_timed
+/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noproc/tirpc_svcerr_noproc
+/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getaddr/tirpc_rpcb_getaddr
+/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getaddr/tirpc_rpcb_getaddr_limits
+/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create/tirpc_authsys_create
+/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_create/tirpc_svc_create
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_tli_create/tirpc_svc_tli_create_limits
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_tli_create/tirpc_svc_tli_create
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_tli_create/tirpc_clnt_tli_create
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_tli_create/tirpc_clnt_tli_create_limits
+/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create_limits
+/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/tirpc_clnt_dg_create
+/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create_default/tirpc_authsys_create_default
+/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create_limits
+/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/tirpc_svc_vc_create
+/tests_pack/rpc_suite/tirpc/tirpc_auth_authnone_create/tirpc_authnone_create
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_stress
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_scalability
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_dataint
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_mt
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_performance
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_limits
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/tirpc_rpc_broadcast_exp_complex
+/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create_limits
+/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/tirpc_clnt_vc_create
+/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_control/tirpc_clnt_control
+/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_control/tirpc_clnt_control_limits
+/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create/tirpc_clnt_tp_create
+/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_create/tirpc_authdes_create
+/tests_pack/rpc_suite/tirpc/tirpc_interlevel_svc_tp_create/tirpc_svc_tp_create
+/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/tirpc_clnt_create_timed
+/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/tirpc_clnt_create_timed_limits
+/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create/tirpc_clnt_create
+/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noprog/tirpc_svcerr_noprog
+/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call
+/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_complex
+/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_dataint
+/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_mt
+/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_performance
+/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_scalability
+/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/tirpc_bottomlevel_clnt_call_stress
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_performance
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_mt
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_stress
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_dataint
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_complex
+/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/tirpc_rpc_call_scalability
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_mt
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/tirpc_svc_unreg_stress
+/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_destroy/tirpc_svc_destroy
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_mt
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg_stress
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/tirpc_svc_reg
+/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_unset/tirpc_rpcb_unset
+/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call
+/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_complex
+/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_dataint
+/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_mt
+/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_performance
+/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_scalability
+/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/tirpc_interlevel_clnt_call_stress
diff --git a/testcases/network/rpc/rpc-tirpc/Makefile b/testcases/network/rpc/rpc-tirpc/Makefile
new file mode 100644
index 0000000..1620b2c
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/Makefile
@@ -0,0 +1,22 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile
new file mode 100644
index 0000000..6703ebb
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include ./Makefile.inc
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc b/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc
new file mode 100644
index 0000000..ce15573
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/Makefile.inc
@@ -0,0 +1,20 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+LDLIBS		+= $(TIRPC_LIBS)
+CPPFLAGS	+= $(TIRPC_CPPFLAGS) -pthread
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/Makefile
new file mode 100644
index 0000000..c8ac0dd
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/Makefile
@@ -0,0 +1,22 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/Makefile
new file mode 100644
index 0000000..45bc8a6
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/Makefile
@@ -0,0 +1,22 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_get_myaddress/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_get_myaddress/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_get_myaddress/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getmaps/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getmaps/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getmaps/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getport/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getport/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_getport/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_rmtcall/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_set/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_set/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_set/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_unset/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_unset/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_addrmanagmt_pmap_unset/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_auth_destroy/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_auth_destroy/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_auth_destroy/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authnone_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authnone_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authnone_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create_default/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create_default/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_auth_authunix_create_default/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_broadc_clnt_broadcast/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_destroy/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_destroy/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnt_destroy/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntraw_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntraw_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntraw_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clnttcp_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_bufcreate/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_clntudp_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcraw_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcraw_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcraw_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svctcp_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_bufcreate/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_bufcreate/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_bufcreate/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcudp_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_pcreateerror/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_pcreateerror/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_pcreateerror/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_perrno/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_perrno/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_perrno/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_perror/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_perror/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_perror/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_spcreateerror/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_spcreateerror/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_spcreateerror/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperrno/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperrno/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperrno/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperror/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperror/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_clnt_sperror/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_auth/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_auth/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_auth/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noproc/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noproc/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noproc/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noprog/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noprog/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_noprog/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_progvers/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_progvers/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_progvers/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_systemerr/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_systemerr/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_systemerr/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_weakauth/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_weakauth/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_err_svcerr_weakauth/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_registerrpc/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_register/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_register/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_register/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_unregister/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_unregister/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_svc_unregister/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_callrpc/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_callrpc/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_callrpc/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_call/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_control/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_control/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_control/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_freeres/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_freeres/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_freeres/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_geterr/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_geterr/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_clnt_geterr/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getcaller/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getcaller/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getcaller/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/Makefile
new file mode 100644
index 0000000..45bc8a6
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/Makefile
@@ -0,0 +1,22 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(top_srcdir)/include/mk/generic_trunk_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getaddr/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getaddr/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getaddr/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getmaps/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getmaps/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_addrmanagmt_rpcb_getmaps/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_seccreate/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_seccreate/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authdes_seccreate/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authnone_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authnone_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authnone_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create_default/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create_default/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_auth_authsys_create_default/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_call/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_dg_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_clnt_vc_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_dg_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_bottomlevel_svc_vc_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_pcreateerror/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_pcreateerror/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_pcreateerror/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perrno/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_clnt_perror/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noproc/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noproc/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noproc/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noprog/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noprog/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_noprog/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_progvers/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_progvers/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_progvers/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_systemerr/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_systemerr/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_systemerr/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_weakauth/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_weakauth/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_err_svcerr_weakauth/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_call/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_tli_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_tli_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_clnt_tli_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_rmtcall/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_set/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_set/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_set/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_unset/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_unset/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_rpcb_unset/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_reg/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_tli_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_tli_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_tli_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_expertlevel_svc_unreg/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_call/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_control/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_control/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_control/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create_timed/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create_timed/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_clnt_tp_create_timed/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_svc_tp_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_svc_tp_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_interlevel_svc_tp_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_broadcast_exp/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_call/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_simple_rpc_reg/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_call/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_create_timed/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_destroy/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_destroy/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_clnt_destroy/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_create/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_create/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_create/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_destroy/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_destroy/Makefile
new file mode 100644
index 0000000..23bf048
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/tirpc/tirpc_toplevel_svc_destroy/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include $(abs_srcdir)/../../../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_1/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_1/Makefile
new file mode 100644
index 0000000..771888c
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_1/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_2/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_2/Makefile
new file mode 100644
index 0000000..771888c
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_svc_2/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_1/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_1/Makefile
new file mode 100644
index 0000000..771888c
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_1/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_11/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_11/Makefile
new file mode 100644
index 0000000..771888c
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_11/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_2/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_2/Makefile
new file mode 100644
index 0000000..771888c
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_2/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_3/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_3/Makefile
new file mode 100644
index 0000000..771888c
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_3/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_4/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_4/Makefile
new file mode 100644
index 0000000..771888c
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_4/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/Makefile
new file mode 100644
index 0000000..771888c
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_5/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_6/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_6/Makefile
new file mode 100644
index 0000000..771888c
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_6/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_7/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_7/Makefile
new file mode 100644
index 0000000..771888c
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_7/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_8/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_8/Makefile
new file mode 100644
index 0000000..771888c
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_8/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_9/Makefile b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_9/Makefile
new file mode 100644
index 0000000..771888c
--- /dev/null
+++ b/testcases/network/rpc/rpc-tirpc/tests_pack/tirpc_svc_9/Makefile
@@ -0,0 +1,23 @@
+#
+#    Copyright (C) 2014, Oracle and/or its affiliates. All Rights Reserved.
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
+
+include	$(top_srcdir)/include/mk/env_pre.mk
+include ../Makefile.inc
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
-- 
1.7.1


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

