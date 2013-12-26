Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Vw6up-0002Lf-5b
	for ltp-list@lists.sourceforge.net; Thu, 26 Dec 2013 09:07:39 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vw6uo-0000gV-BG
	for ltp-list@lists.sourceforge.net; Thu, 26 Dec 2013 09:07:39 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rBQ97WrM011148
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Dec 2013 09:07:32 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBQ97VHp001982
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Dec 2013 09:07:31 GMT
Received: from ubhmt120.oracle.com (ubhmt120.oracle.com [156.151.24.25])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBQ97Vvs001969
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Dec 2013 09:07:31 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 26 Dec 2013 13:07:18 +0400
Message-Id: <1388048842-28373-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1388048842-28373-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1388048842-28373-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 1/5] rpc-tirpc-full-test-suite: do not use tst_exit
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

Since nothing from rpc-tirpc-full-test-suite is linked to the
LTP libraries we can't use tst_* functions there.

Use simple return instead.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../rpc/rpc_stdcall_svc_freeargs/1-basic.c         |    2 +-
 .../rpc_suite/rpc/rpc_stdcall_svc_getargs/client.c |    2 +-
 .../rpc/rpc_stdcall_svc_sendreply/client.c         |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/1-basic.c b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/1-basic.c
index aed9fe5..9811ef2 100644
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/1-basic.c
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_freeargs/1-basic.c
@@ -67,5 +67,5 @@ int main(int argn, char *argc[])
 	//normally should be 0: test has passed or 1: test has failed
 	//printf("%d\n", test_status);
 
-	tst_exit();		//test_status;
+	return 0;		//test_status;
 }
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/client.c b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/client.c
index aed9fe5..9811ef2 100644
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/client.c
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_getargs/client.c
@@ -67,5 +67,5 @@ int main(int argn, char *argc[])
 	//normally should be 0: test has passed or 1: test has failed
 	//printf("%d\n", test_status);
 
-	tst_exit();		//test_status;
+	return 0;		//test_status;
 }
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/client.c b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/client.c
index aed9fe5..9811ef2 100644
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/client.c
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/tests_pack/rpc_suite/rpc/rpc_stdcall_svc_sendreply/client.c
@@ -67,5 +67,5 @@ int main(int argn, char *argc[])
 	//normally should be 0: test has passed or 1: test has failed
 	//printf("%d\n", test_status);
 
-	tst_exit();		//test_status;
+	return 0;		//test_status;
 }
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
