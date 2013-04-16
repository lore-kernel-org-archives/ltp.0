Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1US38K-0003bE-Bt
	for ltp-list@lists.sourceforge.net; Tue, 16 Apr 2013 10:29:04 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1US38J-0001E3-D9
	for ltp-list@lists.sourceforge.net; Tue, 16 Apr 2013 10:29:04 +0000
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r3GASvvx017758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 16 Apr 2013 06:28:58 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Tue, 16 Apr 2013 18:26:33 +0800
Message-Id: <a6942bb2d9d35f695b5067a7008620110c769222.1366107814.git.zliu@redhat.com>
In-Reply-To: <231291fe0dff5b700bdd3f3a01c9cb7c9a96f73a.1366107814.git.zliu@redhat.com>
References: <cover.1366107814.git.zliu@redhat.com>
	<4c3dabc00aa1d0ff3b4cf06b8b5004e39f76199c.1366107814.git.zliu@redhat.com>
	<231291fe0dff5b700bdd3f3a01c9cb7c9a96f73a.1366107814.git.zliu@redhat.com>
In-Reply-To: <cover.1366107814.git.zliu@redhat.com>
References: <cover.1366107814.git.zliu@redhat.com>
Subject: [LTP] [PATCH v5 3/3] mm/thp: add new case thp05
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
To: LTP List <ltp-list@lists.sourceforge.net>

added new case thp05, which is used to test transparent hugepage
under mempolicy - NUMA.

Tested-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 runtest/mm                       |   3 +
 testcases/kernel/mem/thp/thp05.c | 155 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 158 insertions(+)
 create mode 100644 testcases/kernel/mem/thp/thp05.c

diff --git a/runtest/mm b/runtest/mm
index 3fbb20f..7c7abf1 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -87,6 +87,9 @@ thp03 thp03
 thp04_1 thp04
 thp04_2 thp04 -n 10 -N 20
 thp04_3 thp04 -n 1 -N 300
+thp05_1 thp05
+thp05_2 thp05 -n 10 -N 20
+thp05_3 thp05 -n 1 -N 300
 
 vma01 vma01
 vma02 vma02
diff --git a/testcases/kernel/mem/thp/thp05.c b/testcases/kernel/mem/thp/thp05.c
new file mode 100644
index 0000000..434d150
--- /dev/null
+++ b/testcases/kernel/mem/thp/thp05.c
@@ -0,0 +1,155 @@
+/*
+ * Copyright (C) 2013 Linux Test Project
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of version 2 of the GNU General Public
+ * License as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it would be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
+ *
+ * Further, this software is distributed without any warranty that it
+ * is free of the rightful claim of any third person regarding
+ * infringement or the like.  Any license provided herein, whether
+ * implied or otherwise, applies only to this software file.  Patent
+ * licenses, if any, provided herein do not apply to combinations of
+ * this program with other software, or any other product whatsoever.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+ * 02110-1301, USA.
+ */
+
+/*
+ * The case is designed to test the functionality of transparent
+ * hugepage - THP under mempolicy (NUMA)
+ *
+ * when one process allocate hugepage aligned anonymous pages,
+ * kernel thread 'khugepaged' controlled by sysfs knobs
+ * /sys/kernel/mm/transparent_hugepage/ will scan them, and make
+ * them as transparent hugepage if they are suited, you can find out
+ * how many transparent hugepages are there in one process from
+ * /proc/<pid>/smaps, among the file contents, 'AnonHugePages' entry
+ * stand for transparent hugepage.
+ */
+
+#include <sys/types.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include "numa_helper.h"
+#include "test.h"
+#include "usctest.h"
+#include "mem.h"
+
+char *TCID = "thp05";
+int TST_TOTAL = 1;
+
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+		&& HAVE_MPOL_CONSTANTS
+
+option_t thp_options[] = {
+	{"n:", &opt_nr_children, &opt_nr_children_str},
+	{"N:", &opt_nr_thps, &opt_nr_thps_str},
+	{NULL, NULL, NULL}
+};
+
+static int pre_thp_scan_sleep_millisecs;
+static int pre_thp_alloc_sleep_millisecs;
+static char pre_thp_enabled[BUFSIZ];
+
+int main(int argc, char *argv[])
+{
+	int lc;
+	char *msg;
+	int nr_children = 2, nr_thps = 64;
+
+	msg = parse_opts(argc, argv, thp_options, thp_usage);
+	if (msg != NULL)
+		tst_brkm(TBROK, tst_exit, "OPTION PARSING ERROR - %s", msg);
+	check_thp_options(&nr_children, &nr_thps);
+
+	setup();
+
+	tst_resm(TINFO, "Start to test transparent hugepage...");
+	tst_resm(TINFO, "There are %d children allocating %d "
+			"transparent hugepages", nr_children, nr_thps);
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		tst_resm(TINFO, "THP on MPOL_BIND mempolicy...");
+		test_transparent_hugepage(nr_children, nr_thps, 1, MPOL_BIND);
+
+		tst_resm(TINFO, "THP on MPOL_INTERLEAVE mempolicy...");
+		test_transparent_hugepage(nr_children, nr_thps, 1,
+					  MPOL_INTERLEAVE);
+
+		tst_resm(TINFO, "THP on MPOL_PREFERRED mempolicy...");
+		test_transparent_hugepage(nr_children, nr_thps, 1,
+					  MPOL_PREFERRED);
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+void setup(void)
+{
+	char path[BUFSIZ];
+
+	tst_require_root(NULL);
+
+	if (access(PATH_THP, F_OK) == -1)
+		tst_brkm(TCONF, NULL, "THP is not enabled");
+
+	if (!is_numa(NULL))
+		tst_brkm(TCONF, NULL, "The case need a NUMA system.");
+
+	SAFE_FILE_SCANF(NULL, PATH_KHPD "scan_sleep_millisecs",
+			"%d", &pre_thp_scan_sleep_millisecs);
+	SAFE_FILE_PRINTF(NULL, PATH_KHPD "scan_sleep_millisecs", "%d", 0);
+
+	SAFE_FILE_SCANF(NULL, PATH_KHPD "alloc_sleep_millisecs",
+			"%d", &pre_thp_alloc_sleep_millisecs);
+	SAFE_FILE_PRINTF(NULL, PATH_KHPD "alloc_sleep_millisecs", "%d", 0);
+
+	SAFE_FILE_SCANF(NULL, PATH_THP "enabled", "%[^\n]", pre_thp_enabled);
+	SAFE_FILE_PRINTF(NULL, PATH_THP "enabled", "%s", "always");
+
+	tst_sig(FORK, DEF_HANDLER, NULL);
+	TEST_PAUSE;
+}
+
+void cleanup(void)
+{
+	SAFE_FILE_PRINTF(NULL, PATH_KHPD "scan_sleep_millisecs",
+			 "%d", pre_thp_scan_sleep_millisecs);
+
+	SAFE_FILE_PRINTF(NULL, PATH_KHPD "alloc_sleep_millisecs",
+			 "%d", pre_thp_alloc_sleep_millisecs);
+
+	if (strcmp(pre_thp_enabled, "[always] madvise never") == 0)
+		SAFE_FILE_PRINTF(NULL, PATH_THP "enabled", "%s", "always");
+	else if (strcmp(pre_thp_enabled, "always [madvise] never") == 0)
+		SAFE_FILE_PRINTF(NULL, PATH_THP "enabled", "%s", "madvise");
+	else
+		SAFE_FILE_PRINTF(NULL, PATH_THP "enabled", "%s", "never");
+
+	TEST_CLEANUP;
+}
+
+#else /* no NUMA */
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "no NUMA development packages installed.");
+}
+#endif
-- 
1.7.11.7


------------------------------------------------------------------------------
Precog is a next-generation analytics platform capable of advanced
analytics on semi-structured data. The platform includes APIs for building
apps and a phenomenal toolset for data science. Developers can use
our toolset for easy data analysis & visualization. Get a free account!
http://www2.precog.com/precogplatform/slashdotnewsletter
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
