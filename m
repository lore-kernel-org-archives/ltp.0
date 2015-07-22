Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <liwang@redhat.com>) id 1ZHq8x-0007xg-BV
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2015 09:16:51 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZHq8w-0003Ak-6G
	for ltp-list@lists.sourceforge.net; Wed, 22 Jul 2015 09:16:51 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (Postfix) with ESMTPS id E78E0347A53
	for <ltp-list@lists.sourceforge.net>;
	Wed, 22 Jul 2015 09:16:43 +0000 (UTC)
Received: from dhcp-13-206.nay.redhat.com (dhcp-12-104.nay.redhat.com
	[10.66.12.104])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id t6M9GdWF007637
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <ltp-list@lists.sourceforge.net>; Wed, 22 Jul 2015 05:16:42 -0400
From: Li Wang <liwang@redhat.com>
Date: Wed, 22 Jul 2015 17:16:37 +0800
Message-Id: <1437556597-21540-1-git-send-email-liwang@redhat.com>
Subject: [LTP] [PATCH] mem/hugeshmat04: check if system 'shmmax' large enough
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

Sometimes, the testcase fail like:
	hugeshmat04    0  TINFO  :  set nr_hugepages to 512
	hugeshmat04    1  TBROK  :  hugeshmat04.c:103: shmget: errno=EINVAL(22): Invalid argument
	hugeshmat04    2  TBROK  :  hugeshmat04.c:103: Remaining cases broken
	hugeshmat04    0  TINFO  :  set nr_hugepages to 0

The testbed info:
	# cat /proc/sys/kernel/shmmax
	536870912
	# uname -r
	3.10.0-295.el7.x86_64

The reason is that the 'shmmax' of a system is not enough for shmget() function to get 1G memory.
On RHEL7 system, we have a BUG to enlarge this value, but I can't guarantee this programe could
running well with other distribution. So, a proposed path as follow:

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
index 7f0fbca..aeac3f7 100644
--- a/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
+++ b/testcases/kernel/mem/hugetlb/hugeshmat/hugeshmat04.c
@@ -123,13 +123,15 @@ void shared_hugepage(void)
 
 void setup(void)
 {
-	long mem_total, hpage_size;
+	long mem_total, hpage_size, shmmax;
 
 	tst_require_root(NULL);
 
 	mem_total = read_meminfo("MemTotal:");
-	if (mem_total < 2L*1024*1024) {
-		tst_resm(TCONF, "Test requires more than 2GB of RAM");
+	SAFE_FILE_SCANF(NULL, PATH_SHMMAX, "%ld", &shmmax);
+	if (mem_total < 2L*1024*1024 || shmmax < SIZE) {
+		tst_resm(TCONF,
+			"Test requires more than 2GB of RAM or need a lager 'shmmax' value for testing");
 		tst_exit();
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
