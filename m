Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xu.simon@oracle.com>) id 1WSiXQ-0004eh-EX
	for ltp-list@lists.sourceforge.net; Wed, 26 Mar 2014 07:46:16 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WSiXP-0001lU-IH
	for ltp-list@lists.sourceforge.net; Wed, 26 Mar 2014 07:46:16 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s2Q7k8OD005769
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Mar 2014 07:46:09 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2Q7k7XE009262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Mar 2014 07:46:08 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s2Q7k6Gw020077
	for <ltp-list@lists.sourceforge.net>; Wed, 26 Mar 2014 07:46:07 GMT
From: Simon Xu <xu.simon@oracle.com>
Date: Wed, 26 Mar 2014 15:45:53 +0800
Message-Id: <1395819953-934-1-git-send-email-xu.simon@oracle.com>
Subject: [LTP]  [PATCH] finger01: fix grep command
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

'grep "*:finger"' doesn't work with netstat output such as:

tcp6   0   0 [::]:finger    [::]:*    LISTEN

Use 'grep ":finger"' which always works.

Signed-off-by: Simon Xu <xu.simon@oracle.com>
---
 testcases/network/tcp_cmds/finger/finger01 | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/tcp_cmds/finger/finger01 b/testcases/network/tcp_cmds/finger/finger01
index 81da3e0..203d746 100755
--- a/testcases/network/tcp_cmds/finger/finger01
+++ b/testcases/network/tcp_cmds/finger/finger01
@@ -61,12 +61,12 @@ do_setup()
 
     [ "$LUSER" = "root" ] || end_testcase "MUST BE root to run the test!"
 
-    FINGER=$(netstat -a | grep "*:finger" |awk '{print $6}')
+    FINGER=$(netstat -a | grep ":finger" |awk '{print $6}')
     if [ "$FINGER" != "LISTEN" ]; then
         end_testcase "Please start fingerd locally."
     fi
 
-    FINGER=$(rsh -n $RHOST netstat -a |grep "*:finger"|awk '{print $6}')
+    FINGER=$(rsh -n $RHOST netstat -a |grep ":finger"|awk '{print $6}')
     if [ "$FINGER" != "LISTEN" ]; then
         end_testcase "Please start fingerd on remote host."
     fi
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
