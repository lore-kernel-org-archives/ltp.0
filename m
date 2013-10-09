Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VTtXy-00033F-No
	for ltp-list@lists.sourceforge.net; Wed, 09 Oct 2013 13:11:26 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VTtXw-0002lI-HG
	for ltp-list@lists.sourceforge.net; Wed, 09 Oct 2013 13:11:26 +0000
Received: from ucsinet22.oracle.com (ucsinet22.oracle.com [156.151.31.94])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r99DBHuq010584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Oct 2013 13:11:18 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by ucsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r99DBHIc000409
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Oct 2013 13:11:17 GMT
Received: from abhmt107.oracle.com (abhmt107.oracle.com [141.146.116.59])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r99DBGeN028359
	for <ltp-list@lists.sourceforge.net>; Wed, 9 Oct 2013 13:11:17 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed,  9 Oct 2013 17:11:09 +0400
Message-Id: <1381324269-29300-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] tst_kvercmp2: Criteria for Oracle Linux UEK kernels
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
 lib/tst_kvercmp.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
index a703c47..a950120 100644
--- a/lib/tst_kvercmp.c
+++ b/lib/tst_kvercmp.c
@@ -95,8 +95,12 @@ int tst_kvercmp2(int r1, int r2, int r3, struct tst_kern_exv *vers)
 
 	uname(&uval);
 	kver = uval.release;
-	if (strstr(kver, ".el5")) {
+	if (strstr(kver, ".el5uek")) {
+		cur_dist_name = "OL5UEK";
+	} else if (strstr(kver, ".el5")) {
 		cur_dist_name = "RHEL5";
+	} else if (strstr(kver, ".el6uek")) {
+		cur_dist_name = "OL6UEK";
 	} else if (strstr(kver, ".el6")) {
 		cur_dist_name = "RHEL6";
 	}
-- 
1.7.1


------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
