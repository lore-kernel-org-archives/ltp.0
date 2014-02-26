Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1WIaEm-0004aH-IC
	for ltp-list@lists.sourceforge.net; Wed, 26 Feb 2014 08:53:08 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WIaEk-0003fb-Ml
	for ltp-list@lists.sourceforge.net; Wed, 26 Feb 2014 08:53:08 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s1Q8r06H018529
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Feb 2014 08:53:01 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1Q8qxen011434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Feb 2014 08:52:59 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s1Q8qw8M016844
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Feb 2014 08:52:58 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 26 Feb 2014 12:52:42 +0400
Message-Id: <1393404766-18032-3-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1393404766-18032-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1393404766-18032-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 2/6] utils: .gitignore
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

Added .gitignore file into utils directory.
Added there all build stuff produced by ffsb compilation.
Moved there sctp-related stuff from testcases/network/.gitignore
(it was not done in 6f22494d19b605ded308dc0fa713e91cb873f44a).

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/network/.gitignore |   41 ----------------------------------
 utils/.gitignore             |   50 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 41 deletions(-)
 create mode 100644 utils/.gitignore

diff --git a/testcases/network/.gitignore b/testcases/network/.gitignore
index 5ff27d8..e5fbb88 100644
--- a/testcases/network/.gitignore
+++ b/testcases/network/.gitignore
@@ -26,47 +26,6 @@
 /nfsv4/locks/locktests
 /rpc/basic_tests/rpc01/rpc1
 /rpc/basic_tests/rpc01/rpc_server
-/sctp/func_tests/test_1_to_1_accept_close
-/sctp/func_tests/test_1_to_1_addrs
-/sctp/func_tests/test_1_to_1_connect
-/sctp/func_tests/test_1_to_1_connectx
-/sctp/func_tests/test_1_to_1_events
-/sctp/func_tests/test_1_to_1_initmsg_connect
-/sctp/func_tests/test_1_to_1_nonblock
-/sctp/func_tests/test_1_to_1_recvfrom
-/sctp/func_tests/test_1_to_1_recvmsg
-/sctp/func_tests/test_1_to_1_rtoinfo
-/sctp/func_tests/test_1_to_1_send
-/sctp/func_tests/test_1_to_1_sendmsg
-/sctp/func_tests/test_1_to_1_sendto
-/sctp/func_tests/test_1_to_1_shutdown
-/sctp/func_tests/test_1_to_1_socket_bind_listen
-/sctp/func_tests/test_1_to_1_sockopt
-/sctp/func_tests/test_1_to_1_threads
-/sctp/func_tests/test_assoc_abort
-/sctp/func_tests/test_assoc_shutdown
-/sctp/func_tests/test_autoclose
-/sctp/func_tests/test_basic
-/sctp/func_tests/test_basic_v6
-/sctp/func_tests/test_connect
-/sctp/func_tests/test_connectx
-/sctp/func_tests/test_fragments
-/sctp/func_tests/test_fragments_v6
-/sctp/func_tests/test_getname
-/sctp/func_tests/test_getname_v6
-/sctp/func_tests/test_inaddr_any
-/sctp/func_tests/test_inaddr_any_v6
-/sctp/func_tests/test_peeloff
-/sctp/func_tests/test_peeloff_v6
-/sctp/func_tests/test_recvmsg
-/sctp/func_tests/test_sctp_sendrecvmsg
-/sctp/func_tests/test_sctp_sendrecvmsg_v6
-/sctp/func_tests/test_sockopt
-/sctp/func_tests/test_sockopt_v6
-/sctp/func_tests/test_tcp_style
-/sctp/func_tests/test_tcp_style_v6
-/sctp/func_tests/test_timetolive
-/sctp/func_tests/test_timetolive_v6
 /sockets/ltpClient
 /sockets/ltpServer
 /stress/ns-tools/ns-icmp_redirector
diff --git a/utils/.gitignore b/utils/.gitignore
new file mode 100644
index 0000000..a582748
--- /dev/null
+++ b/utils/.gitignore
@@ -0,0 +1,50 @@
+/ffsb
+/ffsb-6.0-rc2/.deps/
+/ffsb-6.0-rc2/ffsb
+/ffsb-6.0-rc2/Makefile
+/ffsb-6.0-rc2/config.h
+/ffsb-6.0-rc2/config.log
+/ffsb-6.0-rc2/config.status
+/ffsb-6.0-rc2/stamp-h
+/ffsb-6.0-rc2/stamp-h1
+/sctp/func_tests/test_1_to_1_accept_close
+/sctp/func_tests/test_1_to_1_addrs
+/sctp/func_tests/test_1_to_1_connect
+/sctp/func_tests/test_1_to_1_connectx
+/sctp/func_tests/test_1_to_1_events
+/sctp/func_tests/test_1_to_1_initmsg_connect
+/sctp/func_tests/test_1_to_1_nonblock
+/sctp/func_tests/test_1_to_1_recvfrom
+/sctp/func_tests/test_1_to_1_recvmsg
+/sctp/func_tests/test_1_to_1_rtoinfo
+/sctp/func_tests/test_1_to_1_send
+/sctp/func_tests/test_1_to_1_sendmsg
+/sctp/func_tests/test_1_to_1_sendto
+/sctp/func_tests/test_1_to_1_shutdown
+/sctp/func_tests/test_1_to_1_socket_bind_listen
+/sctp/func_tests/test_1_to_1_sockopt
+/sctp/func_tests/test_1_to_1_threads
+/sctp/func_tests/test_assoc_abort
+/sctp/func_tests/test_assoc_shutdown
+/sctp/func_tests/test_autoclose
+/sctp/func_tests/test_basic
+/sctp/func_tests/test_basic_v6
+/sctp/func_tests/test_connect
+/sctp/func_tests/test_connectx
+/sctp/func_tests/test_fragments
+/sctp/func_tests/test_fragments_v6
+/sctp/func_tests/test_getname
+/sctp/func_tests/test_getname_v6
+/sctp/func_tests/test_inaddr_any
+/sctp/func_tests/test_inaddr_any_v6
+/sctp/func_tests/test_peeloff
+/sctp/func_tests/test_peeloff_v6
+/sctp/func_tests/test_recvmsg
+/sctp/func_tests/test_sctp_sendrecvmsg
+/sctp/func_tests/test_sctp_sendrecvmsg_v6
+/sctp/func_tests/test_sockopt
+/sctp/func_tests/test_sockopt_v6
+/sctp/func_tests/test_tcp_style
+/sctp/func_tests/test_tcp_style_v6
+/sctp/func_tests/test_timetolive
+/sctp/func_tests/test_timetolive_v6
-- 
1.7.1


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
