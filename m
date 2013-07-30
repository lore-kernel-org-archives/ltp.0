Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1V4AH1-0008Lv-0i
	for ltp-list@lists.sourceforge.net; Tue, 30 Jul 2013 13:47:35 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1V4AGx-0000nR-MV
	for ltp-list@lists.sourceforge.net; Tue, 30 Jul 2013 13:47:34 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r6UDlOsb026044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jul 2013 13:47:25 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r6UDlN6T007373
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jul 2013 13:47:24 GMT
Received: from abhmt111.oracle.com (abhmt111.oracle.com [141.146.116.63])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r6UDlMIo024062
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jul 2013 13:47:22 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 30 Jul 2013 17:47:11 +0400
Message-Id: <1375192031-10636-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: [LTP] [PATCH] max_map_count: corrected max_map_count condition
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
Cc: bob.picco@oracle.com

From: Stanislav kholmanskikh <stanislav.kholmanskikh@oracle.com>

* kernel test for max_map_count_sysctl is:
   /* Too many mappings? */
   if (mm->map_count > sysctl_max_map_count)
     return -ENOMEM;
  so in LTP test map_count should be greater than max_map_count by 1

* only [vsyscall] is allocated without incrementing mm->map_count

Author: Bob Picco <bob.picco@oracle.com>

Signed-off-by: Stanislav kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 testcases/kernel/mem/tunable/max_map_count.c |   41 +++++++++++++++++--------
 1 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/mem/tunable/max_map_count.c b/testcases/kernel/mem/tunable/max_map_count.c
index e948868..01fbe5e 100644
--- a/testcases/kernel/mem/tunable/max_map_count.c
+++ b/testcases/kernel/mem/tunable/max_map_count.c
@@ -14,20 +14,16 @@
  * The program trys to invoke mmap() endless until triggering MAP_FAILED,
  * then read the process's maps file /proc/[pid]/maps, save the line number
  * to map_count variable, and compare it with /proc/sys/vm/max_map_count,
- * map_count should less than max_map_count.
- * Note: There are two special vmas VDSO and VSYSCALL, which are allocated
- * via install_special_mapping(), install_specail_mapping() allows the VMAs
- * to be allocated and inserted without checking the sysctl_map_map_count,
- * and each /proc/<pid>/maps has both at the end:
- * # cat /proc/self/maps
+ * map_count should be greater than max_map_count by 1;
+ *
+ * Note: On some architectures there is a special vma VSYSCALL, which
+ * is allocated without incrementing mm->map_count variable. On these
+ * architectures each /proc/<pid>/maps has at the end:
  * ...
  * ...
- * 7fff7b9ff000-7fff7ba00000 r-xp 00000000 00:00 0           [vdso]
  * ffffffffff600000-ffffffffff601000 r-xp 00000000 00:00 0   [vsyscall]
  *
- * so during comparing with map_count and /proc/sys/vm/max_map_count,
- * we should except the two special vmas from map_count:
- * map_count -= 2;
+ * so we ignore this line during /proc/[pid]/maps reading.
  *
  * ********************************************************************
  * Copyright (C) 2012 Red Hat, Inc.
@@ -121,6 +117,21 @@ void cleanup(void)
 	TEST_CLEANUP;
 }
 
+/* This is a filter to exclude map entries which aren't accounted
+ * for in the vm_area_struct's map_count.
+ */
+#if defined(__x86_64__) || defined(__x86__)
+static int filter_map(char *buf)
+{
+	return strcmp(buf, "[vsyscall]") == 0;
+}
+#else
+static int filter_map(char *buf)
+{
+	return 0;
+}
+#endif
+
 static long count_maps(pid_t pid)
 {
 	FILE *fp;
@@ -136,8 +147,7 @@ static long count_maps(pid_t pid)
 	while (getline(&line, &len, fp) != -1) {
 		/* exclude vdso and vsyscall */
 		if (sscanf(line, "%*p-%*p %*4s %*p %*2d:%*2d %*d %s", buf) ==
-		    1 && ((strcmp(buf, "[vdso]") == 0) ||
-			  (strcmp(buf, "[vsyscall]") == 0)))
+				1 && filter_map(buf))
 			continue;
 		map_count++;
 	}
@@ -202,7 +212,12 @@ static void max_map_count_test(void)
 			tst_brkm(TBROK, cleanup, "child did not stopped");
 
 		map_count = count_maps(pid);
-		if (map_count == max_maps)
+		/* Note max_maps will be exceeded by one for
+		 * the sysctl setting of max_map_count. This
+		 * is the mm failure point at the time of
+		 * writing this COMMENT!
+		*/
+		if (map_count == (max_maps + 1))
 			tst_resm(TPASS, "%ld map entries in total "
 				 "as expected.", max_maps);
 		else
-- 
1.7.1


------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
