Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tangchen@cn.fujitsu.com>) id 1PanZq-0006sL-2A
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 11:00:18 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PanZp-0002bn-1W
	for ltp-list@lists.sourceforge.net; Thu, 06 Jan 2011 11:00:18 +0000
Received: from tang.cn.fujitsu.com (tang.cn.fujitsu.com [10.167.250.3])
	by song.cn.fujitsu.com (Postfix) with ESMTP id 5C2E117013B
	for <ltp-list@lists.sourceforge.net>;
	Thu,  6 Jan 2011 19:00:08 +0800 (CST)
Received: from mailserver.fnst.cn.fujitus.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id p06At2JY019158
	for <ltp-list@lists.sourceforge.net>; Thu, 6 Jan 2011 18:55:02 +0800
Message-ID: <4D25A136.2020400@cn.fujitsu.com>
Date: Thu, 06 Jan 2011 19:02:14 +0800
From: tangchen <tangchen@cn.fujitsu.com>
MIME-Version: 1.0
References: <4D259E4A.2050704@cn.fujitsu.com>
In-Reply-To: <4D259E4A.2050704@cn.fujitsu.com>
Subject: [LTP]  [PATCH 05/13]Add some preprocessor variables
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

KSM is not supported on RHEL5.

Signed-off-by: Tang Chen <tangchen@cn.fujitsu.com>
---
  testcases/kernel/mem/ksm/ksm01.c        |   18 +++++++++++++++---
  testcases/kernel/syscalls/mmap/mmap10.c |    6 +++++-
  2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/mem/ksm/ksm01.c 
b/testcases/kernel/mem/ksm/ksm01.c
index 09f71d7..2b10fef 100644
--- a/testcases/kernel/mem/ksm/ksm01.c
+++ b/testcases/kernel/mem/ksm/ksm01.c
@@ -70,11 +70,15 @@
  #include "test.h"
  #include "usctest.h"

-#define _PATH_KSM    "/sys/kernel/mm/ksm/"
-#define MB        (1024 * 1024)

  char *TCID = "ksm01";
  int TST_TOTAL = 1;
+
+#ifdef    MADV_MERGEABLE
+
+#define _PATH_KSM    "/sys/kernel/mm/ksm/"
+#define MB        (1024 * 1024)
+
  static int opt_num, opt_size;
  static char *opt_numstr, *opt_sizestr;
  /* memory pointer to identify per process, MB, and byte like
@@ -536,4 +540,12 @@ void group_check(int run, int pages_shared, int 
pages_sharing,
      check("pages_unshared", NULL, pages_unshared);
      check("sleep_millisecs", NULL, sleep_millisecs);
      check("pages_to_scan", NULL, pages_to_scan);
-}
\ No newline at end of file
+}
+
+#else
+int main(int argc, char *argv[])
+{
+    tst_brkm(TRETR, tst_exit, "KSM is unsupported");
+}
+#endif
+
diff --git a/testcases/kernel/syscalls/mmap/mmap10.c 
b/testcases/kernel/syscalls/mmap/mmap10.c
index b31975e..e3a158e 100644
--- a/testcases/kernel/syscalls/mmap/mmap10.c
+++ b/testcases/kernel/syscalls/mmap/mmap10.c
@@ -115,9 +115,13 @@ void mmapzero(void)
      if (x == MAP_FAILED)
          tst_brkm(TBROK|TERRNO, cleanup, "mmap");
      if (opt_ksm) {
+#ifdef    MADV_MERGEABLE
          tst_resm(TINFO, "add to KSM regions.");
          if (madvise(x, SIZE+SIZE-4096, MADV_MERGEABLE) == -1)
              tst_brkm(TBROK|TERRNO, cleanup, "madvise");
+#else
+        tst_brkm(TRETR, cleanup, "KSM is unsupported.");
+#endif
      }
      x[SIZE] = 0;

@@ -175,4 +179,4 @@ void help(void)
  {
      printf("  -a      Test anonymous pages\n");
      printf("  -s      Add to KSM regions\n");
-}
\ No newline at end of file
+}
-- 
1.7.0.4


-- 
Best Regards,
Tang chen



------------------------------------------------------------------------------
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, and, 
should the need arise, upgrade to a full multi-node Oracle RAC database 
without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
