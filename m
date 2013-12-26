Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Vw6uu-0005wT-Bv
	for ltp-list@lists.sourceforge.net; Thu, 26 Dec 2013 09:07:44 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vw6ut-0007Qy-4z
	for ltp-list@lists.sourceforge.net; Thu, 26 Dec 2013 09:07:44 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rBQ97bsC011201
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Dec 2013 09:07:37 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBQ97aHd002170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Dec 2013 09:07:36 GMT
Received: from ubhmt120.oracle.com (ubhmt120.oracle.com [156.151.24.25])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBQ97al6027343
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Dec 2013 09:07:36 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 26 Dec 2013 13:07:21 +0400
Message-Id: <1388048842-28373-5-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1388048842-28373-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1388048842-28373-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 4/5] rpc-tirpc-full-test-suite: pass exit value to the
	wrapper
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

Exit values from the test cases were not passed to the rpc_ts_run.sh,
therefore ltp-pan couldn't see any failures in it.

Fixed this.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../rpc_addrmanagmt_basic_lib.sh                   |   14 +++++++-----
 .../rpc_auth_basic_lib.sh                          |   11 ++++++---
 .../rpc_broadc_basic_lib.sh                        |    2 +
 .../rpc_createdestroy_basic_lib.sh                 |   21 ++++++++-----------
 .../rpc-tirpc-full-test-suite/rpc_err_basic_lib.sh |   21 ++++++++-----------
 .../rpc_regunreg_basic_lib.sh                      |   12 ++++++----
 .../rpc_stdcall_basic_lib.sh                       |   17 +++++++--------
 .../rpc/rpc-tirpc-full-test-suite/rpc_ts_run.sh    |    4 +++
 8 files changed, 54 insertions(+), 48 deletions(-)

diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_addrmanagmt_basic_lib.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_addrmanagmt_basic_lib.sh
index 331a28f..226a779 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_addrmanagmt_basic_lib.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_addrmanagmt_basic_lib.sh
@@ -69,12 +69,13 @@ $REMOTESHELL $SERVERUSER@$SERVERIP "$TESTSERVER_1 $PROGNUMNOSVC"&
 sleep $SERVERTIMEOUT
 
 ### SCRIPT LIST HERE !!! ###
-./$SCRIPTSDIR/rpc_addrmanagmt_pmap_set.sh
-./$SCRIPTSDIR/rpc_addrmanagmt_pmap_unset.sh
-./$SCRIPTSDIR/rpc_addrmanagmt_pmap_getport.sh
-./$SCRIPTSDIR/rpc_addrmanagmt_pmap_getmaps.sh
-./$SCRIPTSDIR/rpc_addrmanagmt_pmap_rmtcall.sh
-./$SCRIPTSDIR/rpc_addrmanagmt_get_myaddress.sh
+exit_status=0
+scripts="pmap_set pmap_unset pmap_getport pmap_getmaps \
+pmap_rmtcall get_myaddress"
+for script in $scripts; do
+	./$SCRIPTSDIR/rpc_addrmanagmt_${script}.sh
+	exit_status=$(( $exit_status + $? ))
+done
 
 #-- Cleanup
 $REMOTESHELL $SERVERUSER@$SERVERIP "killall -9 "$TESTSERVER_1_BIN
@@ -82,3 +83,4 @@ $REMOTESHELL $SERVERUSER@$SERVERIP "killall -9 "$TESTSERVER_1_BIN
 # ***************
 # *** RESULTS ***
 # ***************
+exit $exit_status
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_auth_basic_lib.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_auth_basic_lib.sh
index 31acf3a..db6137c 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_auth_basic_lib.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_auth_basic_lib.sh
@@ -69,10 +69,12 @@ $REMOTESHELL $SERVERUSER@$SERVERIP "$TESTSERVER_1 $PROGNUMNOSVC"&
 sleep $SERVERTIMEOUT
 
 ### SCRIPT LIST HERE !!! ###
-./$SCRIPTSDIR/rpc_auth_authnone_create.sh
-./$SCRIPTSDIR/rpc_auth_authunix_create.sh
-./$SCRIPTSDIR/rpc_auth_authunix_create_default.sh
-./$SCRIPTSDIR/rpc_auth_auth_destroy.sh
+exit_status=0
+scripts="authnone_create authunix_create authunix_create_default auth_destroy"
+for script in $scripts; do
+	./$SCRIPTSDIR/rpc_auth_${script}.sh
+	exit_status=$(( $exit_status + $? ))
+done
 
 #-- Cleanup
 $REMOTESHELL $SERVERUSER@$SERVERIP "killall -9 "$TESTSERVER_1_BIN
@@ -80,3 +82,4 @@ $REMOTESHELL $SERVERUSER@$SERVERIP "killall -9 "$TESTSERVER_1_BIN
 # ***************
 # *** RESULTS ***
 # ***************
+exit $exit_status
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_broadc_basic_lib.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_broadc_basic_lib.sh
index 7910ae1..92290a2 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_broadc_basic_lib.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_broadc_basic_lib.sh
@@ -70,6 +70,7 @@ sleep $SERVERTIMEOUT
 
 ### SCRIPT LIST HERE !!! ###
 ./$SCRIPTSDIR/rpc_broadc_clnt_broadcast.sh
+exit_status=$?
 
 #-- Cleanup
 $REMOTESHELL $SERVERUSER@$SERVERIP "killall -9 "$TESTSERVER_1_BIN
@@ -77,3 +78,4 @@ $REMOTESHELL $SERVERUSER@$SERVERIP "killall -9 "$TESTSERVER_1_BIN
 # ***************
 # *** RESULTS ***
 # ***************
+exit $exit_status
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_createdestroy_basic_lib.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_createdestroy_basic_lib.sh
index 4d5d01e..a16bca5 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_createdestroy_basic_lib.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_createdestroy_basic_lib.sh
@@ -69,18 +69,14 @@ $REMOTESHELL $SERVERUSER@$SERVERIP "$TESTSERVER_1 $PROGNUMNOSVC"&
 sleep $SERVERTIMEOUT
 
 ### SCRIPT LIST HERE !!! ###
-./$SCRIPTSDIR/rpc_createdestroy_svc_destroy.sh
-./$SCRIPTSDIR/rpc_createdestroy_svcfd_create.sh
-./$SCRIPTSDIR/rpc_createdestroy_svctcp_create.sh
-./$SCRIPTSDIR/rpc_createdestroy_svcudp_create.sh
-./$SCRIPTSDIR/rpc_createdestroy_svcraw_create.sh
-./$SCRIPTSDIR/rpc_createdestroy_svcudp_bufcreate.sh
-./$SCRIPTSDIR/rpc_createdestroy_clnt_destroy.sh
-./$SCRIPTSDIR/rpc_createdestroy_clnt_create.sh
-./$SCRIPTSDIR/rpc_createdestroy_clntraw_create.sh
-./$SCRIPTSDIR/rpc_createdestroy_clnttcp_create.sh
-./$SCRIPTSDIR/rpc_createdestroy_clntudp_create.sh
-./$SCRIPTSDIR/rpc_createdestroy_clntudp_bufcreate.sh
+exit_status=0
+scripts="svc_destroy svcfd_create svctcp_create svcudp_create svcraw_create \
+svcudp_bufcreate clnt_destroy clnt_create clntraw_create clnttcp_create \
+clntudp_create clntudp_bufcreate"
+for script in $scripts; do
+	./$SCRIPTSDIR/rpc_createdestroy_${script}.sh
+	exit_status=$(( $exit_status + $? ))
+done
 
 #-- Cleanup
 $REMOTESHELL $SERVERUSER@$SERVERIP "killall -9 "$TESTSERVER_1_BIN
@@ -88,3 +84,4 @@ $REMOTESHELL $SERVERUSER@$SERVERIP "killall -9 "$TESTSERVER_1_BIN
 # ***************
 # *** RESULTS ***
 # ***************
+exit $exit_status
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_err_basic_lib.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_err_basic_lib.sh
index c56b513..84d3039 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_err_basic_lib.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_err_basic_lib.sh
@@ -69,18 +69,14 @@ $REMOTESHELL $SERVERUSER@$SERVERIP "$TESTSERVER_1 $PROGNUMNOSVC"&
 sleep $SERVERTIMEOUT
 
 ### SCRIPT LIST HERE !!! ###
-./$SCRIPTSDIR/rpc_err_clnt_pcreateerror.sh
-./$SCRIPTSDIR/rpc_err_clnt_perrno.sh
-./$SCRIPTSDIR/rpc_err_clnt_perror.sh
-./$SCRIPTSDIR/rpc_err_clnt_spcreateerror.sh
-./$SCRIPTSDIR/rpc_err_clnt_sperrno.sh
-./$SCRIPTSDIR/rpc_err_clnt_sperror.sh
-./$SCRIPTSDIR/rpc_err_svcerr_noproc.sh
-./$SCRIPTSDIR/rpc_err_svcerr_noprog.sh
-./$SCRIPTSDIR/rpc_err_svcerr_progvers.sh
-./$SCRIPTSDIR/rpc_err_svcerr_systemerr.sh
-./$SCRIPTSDIR/rpc_err_svcerr_auth.sh
-./$SCRIPTSDIR/rpc_err_svcerr_weakauth.sh
+exit_status=0
+scripts="clnt_pcreateerror clnt_perrno clnt_perror clnt_spcreateerror \
+clnt_sperrno clnt_sperror svcerr_noproc svcerr_noprog svcerr_progvers \
+svcerr_systemerr svcerr_auth svcerr_weakauth"
+for script in $scripts; do
+	./$SCRIPTSDIR/rpc_err_${script}.sh
+	exit_status=$(( $exit_status + $? ))
+done
 
 #-- Cleanup
 $REMOTESHELL $SERVERUSER@$SERVERIP "killall -9 "$TESTSERVER_1_BIN
@@ -88,3 +84,4 @@ $REMOTESHELL $SERVERUSER@$SERVERIP "killall -9 "$TESTSERVER_1_BIN
 # ***************
 # *** RESULTS ***
 # ***************
+exit $exit_status
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_regunreg_basic_lib.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_regunreg_basic_lib.sh
index 4db762d..65272ae 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_regunreg_basic_lib.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_regunreg_basic_lib.sh
@@ -66,11 +66,12 @@ fi
 sleep $SERVERTIMEOUT
 
 ### SCRIPT LIST HERE !!! ###
-./$SCRIPTSDIR/rpc_regunreg_xprt_register.sh
-./$SCRIPTSDIR/rpc_regunreg_xprt_unregister.sh
-./$SCRIPTSDIR/rpc_regunreg_svc_register.sh
-./$SCRIPTSDIR/rpc_regunreg_svc_unregister.sh
-./$SCRIPTSDIR/rpc_regunreg_registerrpc.sh
+exit_status=0
+scripts="xprt_register xprt_unregister svc_register svc_unregister registerrpc"
+for script in $scripts; do
+	./$SCRIPTSDIR/rpc_regunreg_${script}.sh
+	exit_status=$(( $exit_status + $? ))
+done
 
 #-- Cleanup
 $REMOTESHELL $SERVERUSER@$SERVERIP "killall -9 "$TESTSERVER_1_BIN
@@ -78,3 +79,4 @@ $REMOTESHELL $SERVERUSER@$SERVERIP "killall -9 "$TESTSERVER_1_BIN
 # ***************
 # *** RESULTS ***
 # ***************
+exit $exit_status
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_stdcall_basic_lib.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_stdcall_basic_lib.sh
index da36131..8c51dad 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_stdcall_basic_lib.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_stdcall_basic_lib.sh
@@ -69,15 +69,13 @@ $REMOTESHELL $SERVERUSER@$SERVERIP "$TESTSERVER_1 $PROGNUMNOSVC"&
 sleep $SERVERTIMEOUT
 
 ### SCRIPT LIST HERE !!! ###
-./$SCRIPTSDIR/rpc_stdcall_clnt_call.sh
-./$SCRIPTSDIR/rpc_stdcall_callrpc.sh
-./$SCRIPTSDIR/rpc_stdcall_clnt_freeres.sh
-./$SCRIPTSDIR/rpc_stdcall_clnt_geterr.sh
-./$SCRIPTSDIR/rpc_stdcall_clnt_control.sh
-./$SCRIPTSDIR/rpc_stdcall_svc_getcaller.sh
-./$SCRIPTSDIR/rpc_stdcall_svc_freeargs.sh
-./$SCRIPTSDIR/rpc_stdcall_svc_getargs.sh
-./$SCRIPTSDIR/rpc_stdcall_svc_sendreply.sh
+exit_status=0
+scripts="clnt_call callrpc clnt_freeres clnt_geterr clnt_control \
+svc_getcaller svc_freeargs svc_getargs svc_sendreply"
+for script in $scripts; do
+	./$SCRIPTSDIR/rpc_stdcall_${script}.sh
+	exit_status=$(( $exit_status + $? ))
+done
 
 #-- Cleanup
 $REMOTESHELL $SERVERUSER@$SERVERIP "killall -9 "$TESTSERVER_1_BIN
@@ -85,3 +83,4 @@ $REMOTESHELL $SERVERUSER@$SERVERIP "killall -9 "$TESTSERVER_1_BIN
 # ***************
 # *** RESULTS ***
 # ***************
+exit $exit_status
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_ts_run.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_ts_run.sh
index 66be9b8..f343a2b 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_ts_run.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/rpc_ts_run.sh
@@ -208,12 +208,14 @@ else
 fi
 
 #-- run each test listed in $tstlib script file
+exit_status=0
 for tstssuite in ${TSTSCRTBL[*]}
 do
 	if [ -f "$tstssuite" ]
 	then
 		echo " * running "$tstssuite>>$TESTRUNDETAILSLOG
 		./$tstssuite
+		exit_status=$(( $exit_status + $? ))
 	else
 		echo "/!\ $tstssuite is not a scripts library, skipped"
 	fi
@@ -270,3 +272,5 @@ for ((a=PROGNUMBASE; a < `expr $PROGNUMBASE + $TESTINSTANCE` ; a++))
 do
 	$REMOTESHELL $SERVERUSER@$SERVERIP "$SERVERTSTPACKDIR/cleaner $a"
 done
+
+exit $exit_status
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
