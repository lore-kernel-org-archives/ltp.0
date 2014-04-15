Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1WZzHO-0001Yy-3g
	for ltp-list@lists.sourceforge.net; Tue, 15 Apr 2014 09:03:46 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WZzHN-00023Z-66
	for ltp-list@lists.sourceforge.net; Tue, 15 Apr 2014 09:03:46 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with
	ESMTP id s3F93cdB000414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 15 Apr 2014 09:03:39 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by ucsinet22.oracle.com (8.14.5+Sun/8.14.5) with ESMTP id
	s3F93bA8013574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 15 Apr 2014 09:03:38 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	s3F93bjm024791
	for <ltp-list@lists.sourceforge.net>; Tue, 15 Apr 2014 09:03:37 GMT
From: shuang.qiu@oracle.com
Date: Tue, 15 Apr 2014 17:02:15 +0800
Message-Id: <1397552535-6822-1-git-send-email-shuang.qiu@oracle.com>
Subject: [LTP] [PATCH] containers/netns:parameters are not correct when
	calling crtchild() function
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

From: Shuang Qiu <shuang.qiu@oracle.com>

The numbers of parameters for crtchild() function which called in
two_children_ns.c and par_chld_ipv6.c is not correct.And it will make
the child process to be a zombie process.

Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
---
 testcases/kernel/containers/netns/par_chld_ipv6.c  |    4 ++--
 .../kernel/containers/netns/two_children_ns.c      |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/containers/netns/par_chld_ipv6.c b/testcases/kernel/containers/netns/par_chld_ipv6.c
index f0d17ba..68c671f 100644
--- a/testcases/kernel/containers/netns/par_chld_ipv6.c
+++ b/testcases/kernel/containers/netns/par_chld_ipv6.c
@@ -45,7 +45,7 @@
 #include "test.h"
 #include "config.h"
 
-extern int crtchild(char *);
+extern int crtchild(char *, char *);
 
 char *TCID = "netns_ipv6";
 int TST_TOTAL = 1;
@@ -95,7 +95,7 @@ int main()
 #else
 		tst_resm(TCONF, "System doesn't have unshare support");
 #endif
-		return crtchild(child);
+		return crtchild(child, NULL);
 	} else {
 
 		//parent
diff --git a/testcases/kernel/containers/netns/two_children_ns.c b/testcases/kernel/containers/netns/two_children_ns.c
index 235d9c4..4d7808c 100644
--- a/testcases/kernel/containers/netns/two_children_ns.c
+++ b/testcases/kernel/containers/netns/two_children_ns.c
@@ -47,7 +47,7 @@
 #include "libclone.h"
 #include "config.h"
 
-extern int crtchild(char *);
+extern int crtchild(char *, char *);
 
 char *TCID = "netns_2children";
 int TST_TOTAL = 1;
@@ -109,7 +109,7 @@ int main()
 				return ret;
 			}
 #endif
-			return crtchild(child[i]);
+			return crtchild(child[i], NULL);
 		} else {
 			//Parent
 
-- 
1.7.7


------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
