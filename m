Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VLswB-00044r-Ea
	for ltp-list@lists.sourceforge.net; Tue, 17 Sep 2013 10:55:19 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VLsw6-0008Cc-N7
	for ltp-list@lists.sourceforge.net; Tue, 17 Sep 2013 10:55:19 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r8HAt8kc014448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Sep 2013 10:55:09 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8HAt70J022291
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Sep 2013 10:55:08 GMT
Received: from abhmt116.oracle.com (abhmt116.oracle.com [141.146.116.68])
	by userz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8HAt7KH024297
	for <ltp-list@lists.sourceforge.net>; Tue, 17 Sep 2013 10:55:07 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 17 Sep 2013 14:55:01 +0400
Message-Id: <1379415301-2841-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] syscalls/getgroups: use TCID_DEFINE
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
 testcases/kernel/syscalls/getgroups/getgroups01.c |    2 +-
 testcases/kernel/syscalls/getgroups/getgroups03.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/getgroups/getgroups01.c b/testcases/kernel/syscalls/getgroups/getgroups01.c
index f319ebf..bbb6409 100644
--- a/testcases/kernel/syscalls/getgroups/getgroups01.c
+++ b/testcases/kernel/syscalls/getgroups/getgroups01.c
@@ -60,7 +60,7 @@
 static void setup(void);
 static void cleanup(void);
 
-char *TCID = "getgroups01";
+TCID_DEFINE(getgroups01);
 int TST_TOTAL = 4;
 
 static GID_T gidset[NGROUPS];
diff --git a/testcases/kernel/syscalls/getgroups/getgroups03.c b/testcases/kernel/syscalls/getgroups/getgroups03.c
index 5e46792..e1f879d 100644
--- a/testcases/kernel/syscalls/getgroups/getgroups03.c
+++ b/testcases/kernel/syscalls/getgroups/getgroups03.c
@@ -45,7 +45,7 @@
 
 #define TESTUSER "root"
 
-char *TCID = "getgroups03";
+TCID_DEFINE(getgroups03);
 int TST_TOTAL = 1;
 
 static int ngroups;
-- 
1.7.1


------------------------------------------------------------------------------
LIMITED TIME SALE - Full Year of Microsoft Training For Just $49.99!
1,500+ hours of tutorials including VisualStudio 2012, Windows 8, SharePoint
2013, SQL 2012, MVC 4, more. BEST VALUE: New Multi-Library Power Pack includes
Mobile, Cloud, Java, and UX Design. Lowest price ever! Ends 9/20/13. 
http://pubads.g.doubleclick.net/gampad/clk?id=58041151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
