Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WSSI8-00026q-Fc
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 14:25:24 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WSSI7-000653-Ai
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 14:25:24 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2PEPH47030990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:17 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2PEPGv0005212
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:17 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2PEPGmj005209
	for <ltp-list@lists.sourceforge.net>; Tue, 25 Mar 2014 14:25:16 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 25 Mar 2014 18:24:35 +0400
Message-Id: <1395757480-27424-10-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1395757480-27424-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1395757480-27424-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH V2 09/14] runtest files for rpc-tirpc basic test cases
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

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 runtest/rpc_tests   |   56 +++++++++++++++++++++++++++++++++++++++++++++++++++
 runtest/tirpc_tests |   50 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 106 insertions(+), 0 deletions(-)
 create mode 100644 runtest/rpc_tests
 create mode 100644 runtest/tirpc_tests

diff --git a/runtest/rpc_tests b/runtest/rpc_tests
new file mode 100644
index 0000000..dcb2bcb
--- /dev/null
+++ b/runtest/rpc_tests
@@ -0,0 +1,56 @@
+rpc_pmap_set rpc_test.sh -c rpc_pmap_set
+rpc_pmap_unset rpc_test.sh -c rpc_pmap_unset
+rpc_pmap_getport rpc_test.sh -s rpc_svc_1 -c rpc_pmap_getport
+rpc_pmap_getmaps rpc_test.sh -s rpc_svc_1 -c rpc_pmap_getmaps
+rpc_pmap_rmtcall rpc_test.sh -s rpc_svc_1 -c rpc_pmap_rmtcall
+rpc_get_myaddress rpc_test.sh -c rpc_get_myaddress
+
+rpc_authnone_create rpc_test.sh -c rpc_authnone_create
+rpc_authunix_create rpc_test.sh -c rpc_authunix_create
+rpc_authunix_create_default rpc_test.sh -c rpc_authunix_create_default
+rpc_auth_destroy rpc_test.sh -c rpc_auth_destroy
+
+rpc_clnt_broadcast rpc_test.sh -s rpc_svc_1 -c rpc_clnt_broadcast
+
+rpc_svc_destroy rpc_test.sh -c rpc_svc_destroy
+rpc_svcfd_create rpc_test.sh -c rpc_svcfd_create
+rpc_svctcp_create rpc_test.sh -c rpc_svctcp_create
+rpc_svcudp_create rpc_test.sh -c rpc_svcudp_create
+rpc_svcraw_create rpc_test.sh -c rpc_svcraw_create
+rpc_svcudp_bufcreate rpc_test.sh -c rpc_svcudp_bufcreate
+rpc_clnt_destroy rpc_test.sh -s rpc_svc_1 -c rpc_clnt_destroy
+rpc_clnt_create rpc_test.sh -s rpc_svc_1 -c rpc_clnt_create
+rpc_clntraw_create rpc_test.sh -s rpc_svc_1 -c rpc_clntraw_create
+rpc_clnttcp_create rpc_test.sh -s rpc_svc_1 -c rpc_clnttcp_create
+rpc_clntudp_create rpc_test.sh -s rpc_svc_1 -c rpc_clntudp_create
+rpc_clntudp_bufcreate rpc_test.sh -s rpc_svc_1 -c rpc_clntudp_bufcreate
+
+rpc_clnt_pcreateerror rpc_test.sh -s rpc_svc_1 -c rpc_clnt_pcreateerror
+rpc_clnt_perrno rpc_test.sh -s rpc_svc_1 -c rpc_clnt_perrno
+rpc_clnt_perror rpc_test.sh -s rpc_svc_1 -c rpc_clnt_perror
+rpc_clnt_spcreateerror rpc_test.sh -s rpc_svc_1 -c rpc_clnt_spcreateerror
+rpc_clnt_sperrno rpc_test.sh -s rpc_svc_1 -c rpc_clnt_sperrno
+rpc_clnt_sperror rpc_test.sh -s rpc_svc_1 -c rpc_clnt_sperror
+rpc_svcerr_noproc rpc_test.sh -s rpc_svc_1 -c rpc_svcerr_noproc
+rpc_svcerr_noprog rpc_test.sh -c rpc_svcerr_noprog
+rpc_svcerr_progvers rpc_test.sh -s rpc_svc_1 -c rpc_svcerr_progvers
+rpc_svcerr_systemerr rpc_test.sh -s rpc_svc_1 -c rpc_svcerr_systemerr
+rpc_svcerr_auth rpc_test.sh -s rpc_svc_1 -c rpc_svcerr_auth
+rpc_svcerr_weakauth rpc_test.sh -s rpc_svc_1 -c rpc_svcerr_weakauth
+
+rpc_xprt_register rpc_test.sh -c rpc_xprt_register
+rpc_xprt_unregister rpc_test.sh -c rpc_xprt_unregister
+rpc_svc_register rpc_test.sh -c rpc_svc_register
+rpc_svc_unregister rpc_test.sh -c rpc_svc_unregister
+rpc_registerrpc rpc_test.sh -c rpc_registerrpc
+
+rpc_clnt_call rpc_test.sh -s rpc_svc_1 -c rpc_clnt_call
+rpc_callrpc rpc_test.sh -s rpc_svc_1 -c rpc_callrpc
+rpc_clnt_freeres rpc_test.sh -s rpc_svc_1 -c rpc_clnt_freeres
+rpc_clnt_geterr rpc_test.sh -s rpc_svc_1 -c rpc_clnt_geterr
+rpc_clnt_control rpc_test.sh -s rpc_svc_1 -c rpc_clnt_control
+rpc_svc_getcaller rpc_test.sh -s rpc_svc_1 -c rpc_svc_getcaller
+rpc_svc_freeargs rpc_test.sh -s rpc_svc_1 -c rpc_svc_freeargs
+#TODO
+#rpc_svc_getargs
+#rpc_svc_sendreply
diff --git a/runtest/tirpc_tests b/runtest/tirpc_tests
new file mode 100644
index 0000000..ba96749
--- /dev/null
+++ b/runtest/tirpc_tests
@@ -0,0 +1,50 @@
+tirpc_rpcb_getaddr rpc_test.sh -s tirpc_svc_3 -c tirpc_rpcb_getaddr
+tirpc_rpcb_getmaps rpc_test.sh -s tirpc_svc_3 -c tirpc_rpcb_getmaps
+
+tirpc_authnone_create rpc_test.sh -c tirpc_authnone_create
+tirpc_authsys_create rpc_test.sh -s tirpc_svc_1 -c tirpc_authsys_create
+tirpc_authsys_create_default rpc_test.sh -c tirpc_authsys_create_default
+tirpc_authdes_create rpc_test.sh -s tirpc_svc_1 -c tirpc_authdes_create
+tirpc_authdes_seccreate rpc_test.sh -s tirpc_svc_1 -c tirpc_authdes_seccreate
+
+tirpc_clnt_dg_create rpc_test.sh -s tirpc_svc_5 -c tirpc_clnt_dg_create
+tirpc_svc_dg_create rpc_test.sh -c tirpc_svc_dg_create
+tirpc_clnt_vc_create rpc_test.sh -s tirpc_svc_5 -c tirpc_clnt_vc_create
+tirpc_svc_vc_create rpc_test.sh -c tirpc_svc_vc_create
+tirpc_bottomlevel_clnt_call rpc_test.sh -s tirpc_svc_5 -c tirpc_bottomlevel_clnt_call
+
+tirpc_clnt_pcreateerror rpc_test.sh -s tirpc_svc_11 -c tirpc_clnt_pcreateerror
+tirpc_clnt_perrno rpc_test.sh -s tirpc_svc_11 -c tirpc_clnt_perrno
+tirpc_clnt_perror rpc_test.sh -s tirpc_svc_11 -c tirpc_clnt_perror
+tirpc_svcerr_noproc rpc_test.sh -s tirpc_svc_11 -c tirpc_svcerr_noproc
+tirpc_svcerr_noprog rpc_test.sh -s tirpc_svc_11 -c tirpc_svcerr_noprog
+tirpc_svcerr_progvers rpc_test.sh -s tirpc_svc_11 -c tirpc_svcerr_progvers
+tirpc_svcerr_systemerr rpc_test.sh -s tirpc_svc_11 -c tirpc_svcerr_systemerr
+tirpc_svcerr_weakauth rpc_test.sh -s tirpc_svc_11 -c tirpc_svcerr_weakauth
+
+tirpc_clnt_tli_create rpc_test.sh -s tirpc_svc_4 -c tirpc_clnt_tli_create
+tirpc_svc_tli_create rpc_test.sh -c tirpc_svc_tli_create
+tirpc_rpcb_set rpc_test.sh -c tirpc_rpcb_set
+tirpc_rpcb_unset rpc_test.sh -c tirpc_rpcb_unset
+tirpc_rpcb_rmtcall rpc_test.sh -s tirpc_svc_4 -c tirpc_rpcb_rmtcall
+tirpc_svc_reg rpc_test.sh -c tirpc_svc_reg
+tirpc_svc_unreg rpc_test.sh -c tirpc_svc_unreg
+tirpc_expertlevel_clnt_call rpc_test.sh -s tirpc_svc_4 -c tirpc_expertlevel_clnt_call
+
+tirpc_clnt_tp_create rpc_test.sh -s tirpc_svc_3 -c tirpc_clnt_tp_create
+tirpc_clnt_tp_create_timed rpc_test.sh -s tirpc_svc_3 -c tirpc_clnt_tp_create_timed
+tirpc_svc_tp_create rpc_test.sh -c tirpc_svc_tp_create
+tirpc_interlevel_clnt_call rpc_test.sh -s tirpc_svc_3 -c tirpc_interlevel_clnt_call
+tirpc_clnt_control rpc_test.sh -s tirpc_svc_3 -c tirpc_clnt_control
+
+tirpc_rpc_reg rpc_test.sh -c tirpc_rpc_reg
+tirpc_rpc_call rpc_test.sh -s tirpc_svc_1 -c tirpc_rpc_call
+tirpc_rpc_broadcast rpc_test.sh -s tirpc_svc_1 -c tirpc_rpc_broadcast
+tirpc_rpc_broadcast_exp rpc_test.sh -s tirpc_svc_1 -c tirpc_rpc_broadcast_exp -e "1 2"
+
+tirpc_clnt_create rpc_test.sh -s tirpc_svc_2 -c tirpc_clnt_create
+tirpc_clnt_create_timed rpc_test.sh -s tirpc_svc_2 -c tirpc_clnt_create_timed
+tirpc_svc_create rpc_test.sh -c tirpc_svc_create
+tirpc_toplevel_clnt_call rpc_test.sh -s tirpc_svc_2 -c tirpc_toplevel_clnt_call
+tirpc_clnt_destroy rpc_test.sh -s tirpc_svc_2 -c tirpc_clnt_destroy
+tirpc_svc_destroy rpc_test.sh -c tirpc_svc_destroy
-- 
1.7.1


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
