Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwang@redhat.com>) id 1ZHr6b-0006M6-He
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2015 10:18:29 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZHr6Z-0004tR-9S
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2015 10:18:29 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 43EAC91E88
	for <ltp-list@lists.sourceforge.net>;
	Wed, 22 Jul 2015 10:02:14 +0000 (UTC)
Received: from dhcp-13-206.nay.redhat.com (dhcp-12-104.nay.redhat.com
	[10.66.12.104])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t6MA29bM008867
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 22 Jul 2015 06:02:13 -0400
From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Jul 2015 18:02:07 +0800
Message-Id: <1437559327-22256-1-git-send-email-liwang@redhat.com>
Subject: [LTP] [Patch v2] mem/hugeshmat04: check if system 'shmmax' large
	enough
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

V1 --> V2
	 Just try to setup 'SHMMAX' to a large size then do the test
	 before we waive it.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index 7f0fbca..d6092d9 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -59,6 +59,7 @@ static long huge_free;
 static long huge_free2;
 static long hugepages;
 static long orig_hugepages;
+static long orig_shmmax, new_shmmax;
 
 static void shared_hugepage(void);
 
@@ -128,8 +129,13 @@ void setup(void)
 	tst_require_root(NULL);
 
 	mem_total = read_meminfo("MemTotal:");
-	if (mem_total < 2L*1024*1024) {
-		tst_resm(TCONF, "Test requires more than 2GB of RAM");
+	SAFE_FILE_SCANF(NULL, PATH_SHMMAX, "%ld", &orig_shmmax);
+	SAFE_FILE_PRINTF(NULL, PATH_SHMMAX, "%ld", (long)SIZE);
+	SAFE_FILE_SCANF(NULL, PATH_SHMMAX, "%ld", &new_shmmax);
+
+	if (mem_total < 2L*1024*1024 || new_shmmax < SIZE) {
+		tst_resm(TCONF,
+			"Test requires more than 2GB of RAM or need a lager 'shmmax' value for testing");
 		tst_exit();
 	}
 
@@ -150,4 +156,6 @@ void setup(void)
 void cleanup(void)
 {
 	set_sys_tune("nr_hugepages", orig_hugepages, 0);
+	SAFE_FILE_PRINTF(NULL, PATH_SHMMAX, "%ld", orig_shmmax);
+
 }
-- 
1.8.3.1


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
