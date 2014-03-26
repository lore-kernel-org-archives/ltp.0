Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1WSqgF-0007px-1c
	for ltp-list@lists.sourceforge.net; Wed, 26 Mar 2014 16:27:55 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WSqgE-000399-9y
	for ltp-list@lists.sourceforge.net; Wed, 26 Mar 2014 16:27:55 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2QGRl5F012771
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Mar 2014 16:27:48 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2QGRl39008369
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Mar 2014 16:27:47 GMT
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2QGRkt8024969
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Mar 2014 16:27:46 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Thu, 27 Mar 2014 00:27:39 +0800
Message-Id: <1395851259-14416-1-git-send-email-xu.simon@oracle.com>
In-Reply-To: <20140326131946.GD9168@rei.suse.cz>
References: <20140326131946.GD9168@rei.suse.cz>
Subject: [LTP]  [PATCH] xinetd_test.sh: restart xinetd by restart_daemon()
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
 testcases/network/xinetd/xinetd_tests.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/network/xinetd/xinetd_tests.sh b/testcases/network/xinetd/xinetd_tests.sh
index dac23a8..38cd7b0 100755
--- a/testcases/network/xinetd/xinetd_tests.sh
+++ b/testcases/network/xinetd/xinetd_tests.sh
@@ -63,6 +63,8 @@ init()
     export TST_TOTAL=2
     export TCID="xinetd"
     export TST_COUNT=0
+    export XINETD_DAEMON='xinetd'
+    . daemonlib.sh
 
     # Inititalize cleanup function.
     trap "cleanup" 0
@@ -226,7 +228,7 @@ cleanup()
         sleep 1s
 
         # restoring original services
-        /etc/init.d/xinetd restart > $LTPTMP/tst_xinetd.err 2>&1
+        restart_daemon $XINETD_DAEMON > $LTPTMP/tst_xinetd.err 2>&1
         RC=$?
         if [ $RC -ne 0 ]
         then
@@ -285,7 +287,7 @@ test01()
     sleep 1s
 
     # restart xinetd to re-start the services
-    /etc/init.d/xinetd restart > $LTPTMP/tst_xinetd.out 2>&1
+    restart_daemon $XINETD_DAEMON > $LTPTMP/tst_xinetd.out 2>&1
     RC=$?
     if [ $RC -ne 0 ]
     then
@@ -352,7 +354,7 @@ test01()
     sleep 1s
 
     # restart services.
-    /etc/init.d/xinetd restart > $LTPTMP/tst_xinetd.out 2>&1
+    restart_daemon $XINETD_DAEMON > $LTPTMP/tst_xinetd.out 2>&1
     RC=$?
     if [ $RC -ne 0 ]
     then
-- 
1.9.1


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
