Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1Vw6uv-0005x3-VW
	for ltp-list@lists.sourceforge.net; Thu, 26 Dec 2013 09:07:45 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vw6uv-0000gt-7r
	for ltp-list@lists.sourceforge.net; Thu, 26 Dec 2013 09:07:45 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rBQ97cK8011211
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Dec 2013 09:07:39 GMT
Received: from aserz7021.oracle.com (aserz7021.oracle.com [141.146.126.230])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBQ97bVS027365
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Dec 2013 09:07:38 GMT
Received: from ubhmt120.oracle.com (ubhmt120.oracle.com [156.151.24.25])
	by aserz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rBQ97bq1023232
	for <ltp-list@lists.sourceforge.net>; Thu, 26 Dec 2013 09:07:37 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 26 Dec 2013 13:07:22 +0400
Message-Id: <1388048842-28373-6-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <1388048842-28373-1-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1388048842-28373-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH 5/5] rpc_stdcall_basic_lib: fixed IS_EX match
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

Since we stripped off the '.bin' suffix from the
binaries of rpc-tirpc-full-test-suite, the IS_EX condition
in some of rpc_stdcall_basic_lib match false conditions.

Use full cmdline for grep.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../scripts/rpc_stdcall_svc_freeargs.sh            |    2 +-
 .../scripts/rpc_stdcall_svc_getargs.sh             |    2 +-
 .../scripts/rpc_stdcall_svc_sendreply.sh           |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_freeargs.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_freeargs.sh
index 3af075b..36b1d33 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_freeargs.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_freeargs.sh
@@ -104,7 +104,7 @@ then
 	exit 2
 fi
 
-IS_EX=`$REMOTESHELL $CLIENTUSER@$CLIENTIP "ps -e | grep $TESTSVCBIN"`
+IS_EX=`$REMOTESHELL $CLIENTUSER@$CLIENTIP "ps -ef | grep $TESTSVC | grep -v grep"`
 
 if [ "$IS_EX" ]
 then
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_getargs.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_getargs.sh
index 2878ffa..f62c514 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_getargs.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_getargs.sh
@@ -104,7 +104,7 @@ then
 	exit 2
 fi
 
-IS_EX=`$REMOTESHELL $CLIENTUSER@$CLIENTIP "ps -e | grep $TESTSVCBIN"`
+IS_EX=`$REMOTESHELL $CLIENTUSER@$CLIENTIP "ps -ef | grep $TESTSVC | grep -v grep"`
 
 if [ "$IS_EX" ]
 then
diff --git a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_sendreply.sh b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_sendreply.sh
index 66e3a24..f8df4fc 100755
--- a/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_sendreply.sh
+++ b/testcases/network/rpc/rpc-tirpc-full-test-suite/scripts/rpc_stdcall_svc_sendreply.sh
@@ -104,7 +104,7 @@ then
 	exit 2
 fi
 
-IS_EX=`$REMOTESHELL $CLIENTUSER@$CLIENTIP "ps -e | grep $TESTSVCBIN"`
+IS_EX=`$REMOTESHELL $CLIENTUSER@$CLIENTIP "ps -ef | grep $TESTSVC | grep -v grep"`
 
 if [ "$IS_EX" ]
 then
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
