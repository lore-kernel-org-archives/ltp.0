Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1WT01h-0005K8-Tj
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 02:26:41 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WT01h-0002xQ-1I
	for ltp-list@lists.sourceforge.net; Thu, 27 Mar 2014 02:26:41 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2R2QYRO032324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 02:26:35 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s2R2QXkC021754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 02:26:34 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2R2QXTs012956
	for <ltp-list@lists.sourceforge.net>; Thu, 27 Mar 2014 02:26:33 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Thu, 27 Mar 2014 10:26:26 +0800
Message-Id: <1395887186-14605-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <20140326170027.GA11941@rei.Home>
References: <20140326170027.GA11941@rei.Home>
Subject: [LTP] [PATCH V2] xinetd_test.sh: restart xinetd by restart_daemon()
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

Signed-off-by: Simon Xu <xu.simon@oracle.com>
---
 testcases/network/xinetd/xinetd_tests.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
index dac23a8..813a3f3 100755
--- a/testcases/network/xinetd/xinetd_tests.sh
+++ b/testcases/network/xinetd/xinetd_tests.sh
@@ -63,6 +63,7 @@ init()
     export TST_TOTAL=2
     export TCID="xinetd"
     export TST_COUNT=0
+    . daemonlib.sh
 
     # Inititalize cleanup function.
     trap "cleanup" 0
@@ -226,7 +227,7 @@ cleanup()
         sleep 1s
 
         # restoring original services
-        /etc/init.d/xinetd restart > $LTPTMP/tst_xinetd.err 2>&1
+        restart_daemon xinetd > $LTPTMP/tst_xinetd.err 2>&1
         RC=$?
         if [ $RC -ne 0 ]
         then
@@ -285,7 +286,7 @@ test01()
     sleep 1s
 
     # restart xinetd to re-start the services
-    /etc/init.d/xinetd restart > $LTPTMP/tst_xinetd.out 2>&1
+    restart_daemon xinetd > $LTPTMP/tst_xinetd.out 2>&1
     RC=$?
     if [ $RC -ne 0 ]
     then
@@ -352,7 +353,7 @@ test01()
     sleep 1s
 
     # restart services.
-    /etc/init.d/xinetd restart > $LTPTMP/tst_xinetd.out 2>&1
+    restart_daemon xinetd > $LTPTMP/tst_xinetd.out 2>&1
     RC=$?
     if [ $RC -ne 0 ]
     then
-- 
1.9.1


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
