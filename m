Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shuang.qiu@oracle.com>) id 1VEA4V-0001tF-Tu
	for ltp-list@lists.sourceforge.net; Tue, 27 Aug 2013 03:35:59 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VEA4V-0000Ph-58
	for ltp-list@lists.sourceforge.net; Tue, 27 Aug 2013 03:35:59 +0000
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r7R3Zqhk010179
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Aug 2013 03:35:53 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
	by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r7R3Zq8m004770
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Aug 2013 03:35:52 GMT
Received: from abhmt109.oracle.com (abhmt109.oracle.com [141.146.116.61])
	by userz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r7R3ZpmI002973
	for <ltp-list@lists.sourceforge.net>; Tue, 27 Aug 2013 03:35:51 GMT
From: shuang.qiu@oracle.com
Date: Tue, 27 Aug 2013 11:34:59 +0800
Message-Id: <1377574499-9993-1-git-send-email-shuang.qiu@oracle.com>
Subject: [LTP] [PATCH] Using bigger map size to run the memcg_stress test
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

While running memcg_stress test,it may make the memory discontinuous
randomly.Which sometimes will make the following hugepage testcases failed because
there is not enough continuous memory for huge page.i.e.:
hugemmap01    0  TINFO  :  set nr_hugepages to 128
hugemmap01    1  TBROK  :  nr_hugepages = 100, but expect 128
...
We'd better using bigger map size(2M) to run the memcg_stress test
rather than default pagesize.

Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
---
 .../memcg/stress/memcg_process_stress.c            |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c b/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c
index 92627fe..d88eb5f 100644
--- a/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c
+++ b/testcases/kernel/controllers/memcg/stress/memcg_process_stress.c
@@ -48,18 +48,18 @@ void touch_memory()
 void sigusr_handler(int __attribute__ ((unused)) signo)
 {
 	int i;
-	int pagesize;
+	int mapsize;
 
-	pagesize = getpagesize();
+	mapsize = 2 * 1024 * 1024;
 
-	nr_page = ceil((double)memsize / pagesize);
+	nr_page = ceil((double)memsize / mapsize);
 
 	pages = calloc(nr_page, sizeof(char *));
 	if (pages == NULL)
 		errx(1, "calloc failed");
 
 	for (i = 0; i < nr_page; i++) {
-		pages[i] = mmap(NULL, pagesize, PROT_WRITE | PROT_READ,
+		pages[i] = mmap(NULL, mapsize, PROT_WRITE | PROT_READ,
 				MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 		if (pages[i] == MAP_FAILED)
 			err(1, "map failed\n");
-- 
1.7.7


------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
