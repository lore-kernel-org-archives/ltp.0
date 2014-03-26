Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1WSiI9-0000nb-AZ
	for ltp-list@lists.sourceforge.net; Wed, 26 Mar 2014 07:30:29 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WSiI8-00006X-Cu
	for ltp-list@lists.sourceforge.net; Wed, 26 Mar 2014 07:30:29 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2Q7UMVX020660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Mar 2014 07:30:22 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s2Q7UL4j013842
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Mar 2014 07:30:21 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2Q7ULVw008585
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Mar 2014 07:30:21 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Wed, 26 Mar 2014 15:29:58 +0800
Message-Id: <1395818998-836-1-git-send-email-xu.simon@oracle.com>
Subject: [LTP]  [PATCH] xinetd_tests.sh: support systemd restart
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

Support xinetd service restart by systemd, which is used in recent
Linux releases, e.g. RHEL7.

Signed-off-by: Simon Xu <xu.simon@oracle.com>
---
 testcases/network/xinetd/xinetd_tests.sh | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
index dac23a8..14b5c21 100755
--- a/testcases/network/xinetd/xinetd_tests.sh
+++ b/testcases/network/xinetd/xinetd_tests.sh
@@ -59,6 +59,12 @@ chk_ifexists()
 #               - non-zero on failure.
 init()
 {
+    if [ -f "/usr/lib/systemd/system/xinetd.service" ]; then
+        RESTARTCMD="systemctl restart xinetd.service"
+    else
+        RESTARTCMD="/etc/init.d/xinetd restart"
+    fi
+
     # Initialize global variables.
     export TST_TOTAL=2
     export TCID="xinetd"
@@ -226,7 +232,7 @@ cleanup()
         sleep 1s
 
         # restoring original services
-        /etc/init.d/xinetd restart > $LTPTMP/tst_xinetd.err 2>&1
+        $RESTARTCMD > $LTPTMP/tst_xinetd.err 2>&1
         RC=$?
         if [ $RC -ne 0 ]
         then
@@ -285,7 +291,7 @@ test01()
     sleep 1s
 
     # restart xinetd to re-start the services
-    /etc/init.d/xinetd restart > $LTPTMP/tst_xinetd.out 2>&1
+    $RESTARTCMD > $LTPTMP/tst_xinetd.out 2>&1
     RC=$?
     if [ $RC -ne 0 ]
     then
@@ -352,7 +358,7 @@ test01()
     sleep 1s
 
     # restart services.
-    /etc/init.d/xinetd restart > $LTPTMP/tst_xinetd.out 2>&1
+    $RESTARTCMD > $LTPTMP/tst_xinetd.out 2>&1
     RC=$?
     if [ $RC -ne 0 ]
     then
-- 
1.8.5.4


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
