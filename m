Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1T6hhH-0007Fs-IS
	for ltp-list@lists.sourceforge.net; Wed, 29 Aug 2012 12:48:39 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T6hhG-0008CH-G6
	for ltp-list@lists.sourceforge.net; Wed, 29 Aug 2012 12:48:39 +0000
From: Zhouping Liu <zliu@redhat.com>
Date: Wed, 29 Aug 2012 20:42:59 +0800
Message-Id: <cd572cfe7fb9a357ce92149957ed2a3779c542d3.1346244062.git.zliu@redhat.com>
Subject: [LTP]  [PATCH 1/3] tunable: reduce the min_free_kbytes tunable
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
To: LTP list <ltp-list@lists.sourceforge.net>

Setting min_free_kbytes too high will cause system hangs,
especially in i386 arch, using less than 5% of total memory
can avoid it, so choose %5 of free memory or 2% of total memory.
Thanks Shuang pointed out it.

also, in order to enlarge the coverage, the patch adds a new
case item: 2 * default tunable

Signed-off-by: Zhouping Liu <zliu@redhat.com>
Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
---
 testcases/kernel/mem/tunable/min_free_kbytes.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/mem/tunable/min_free_kbytes.c b/testcases/kernel/mem/tunable/min_free_kbytes.c
index 00ead04..f8288ec 100644
--- a/testcases/kernel/mem/tunable/min_free_kbytes.c
+++ b/testcases/kernel/mem/tunable/min_free_kbytes.c
@@ -10,7 +10,8 @@
  * the current free memory with the tunable value repeatedly.
  *
  * a) default min_free_kbytes with all overcommit memory policy
- * b) half of mem_free with all overcommit memory policy
+ * b) 2x default value with all overcommit memory policy
+ * c) 5% of MemFree or %2 MemTotal with all overcommit memory policy
  *
  ********************************************************************
  * Copyright (C) 2012 Red Hat, Inc.
@@ -115,20 +116,27 @@ int main(int argc, char *argv[])
 static void test_tune(unsigned long overcommit_policy)
 {
 	int status;
-	int pid[2];
+	int pid[3];
 	int ret, i;
-	unsigned long tune, memfree;
+	unsigned long tune, memfree, memtotal;
 
 	set_sys_tune("overcommit_memory", overcommit_policy, 1);
 
-	for (i = 0; i < 2; i++) {
+	for (i = 0; i < 3; i++) {
 		/* case1 */
 		if (i == 0)
 			set_sys_tune("min_free_kbytes", default_tune, 1);
 		/* case2 */
-		else {
+		else if (i == 1) {
+			set_sys_tune("min_free_kbytes", 2 * default_tune, 1);
+		/* case3 */
+		} else {
 			memfree = read_meminfo("MemFree:");
-			tune = memfree / 2;
+			memtotal = read_meminfo("MemTotal:");
+			tune = memfree / 20;
+			if (tune > (memtotal / 50))
+				tune = memtotal / 50;
+
 			set_sys_tune("min_free_kbytes", tune, 1);
 		}
 
-- 
1.7.11.2


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
