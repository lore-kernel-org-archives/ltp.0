Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zliu@redhat.com>) id 1UHRUp-0001XX-L9
	for ltp-list@lists.sourceforge.net; Mon, 18 Mar 2013 04:16:27 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UHRUo-00080Q-Pm
	for ltp-list@lists.sourceforge.net; Mon, 18 Mar 2013 04:16:27 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r2I4GKKn020090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 18 Mar 2013 00:16:20 -0400
From: Zhouping Liu <zliu@redhat.com>
Date: Mon, 18 Mar 2013 12:14:03 +0800
Message-Id: <58ec015e0776d3acf326aff30a1ea2cac88d3b08.1363579539.git.zliu@redhat.com>
In-Reply-To: <fe29db23d33fb733bdd3348ede14ca78194892d8.1363579539.git.zliu@redhat.com>
References: <cover.1363579539.git.zliu@redhat.com>
	<610d014b3e51b301d3f2adca6e8b068e62aba626.1363579539.git.zliu@redhat.com>
	<ebfb6ab9d3fba5067be674e22118c4cd4cea4ba8.1363579539.git.zliu@redhat.com>
	<60167c77dc6892bb5a1ae232782cffc107368db8.1363579539.git.zliu@redhat.com>
	<2ccf451c55f261c878bdd388e1e1741d2d9c037c.1363579539.git.zliu@redhat.com>
	<fe29db23d33fb733bdd3348ede14ca78194892d8.1363579539.git.zliu@redhat.com>
In-Reply-To: <cover.1363579539.git.zliu@redhat.com>
References: <cover.1363579539.git.zliu@redhat.com>
Subject: [LTP] [PATCH v3 6/7] mm/oom05: new testcase
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

added a new case to test OOM under the combination
of MEMCG and CPUSET.

Signed-off-by: Zhouping Liu <zliu@redhat.com>
---
 runtest/mm                       |   1 +
 testcases/kernel/mem/oom/oom05.c | 147 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+)
 create mode 100644 testcases/kernel/mem/oom/oom05.c

diff --git a/runtest/mm b/runtest/mm
index a8bd605..56b83f8 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -77,6 +77,7 @@ oom01 oom01
 oom02 oom02
 oom03 oom03
 oom04 oom04
+oom05 oom05
 
 swapping01 swapping01 -i 5
 
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
new file mode 100644
index 0000000..0176d42
--- /dev/null
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -0,0 +1,147 @@
+/*
+ * Out Of Memory (OOM) for MEMCG and CPUSET
+ *
+ * The program is designed to cope with unpredictable like amount and
+ * system physical memory, swap size and other VMM technology like KSM,
+ * memcg, memory hotplug and so on which may affect the OOM
+ * behaviours. It simply increase the memory consumption 3G each time
+ * until all the available memory is consumed and OOM is triggered.
+ *
+ * Copyright (C) 2013  Red Hat, Inc.
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
+#include "config.h"
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <stdio.h>
+#include "numa_helper.h"
+#include "test.h"
+#include "usctest.h"
+#include "mem.h"
+
+char *TCID = "oom05";
+int TST_TOTAL = 1;
+
+#if HAVE_NUMA_H && HAVE_LINUX_MEMPOLICY_H && HAVE_NUMAIF_H \
+	&& HAVE_MPOL_CONSTANTS
+
+int main(int argc, char *argv[])
+{
+	char *msg;
+	int lc;
+	int swap_acc_on = 1;
+	char mem[BUFSIZ];
+
+	msg = parse_opts(argc, argv, NULL, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+#if __WORDSIZE == 32
+	tst_brkm(TCONF, NULL, "test is not designed for 32-bit system.");
+#endif
+
+	setup();
+
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		tst_count = 0;
+
+		tst_resm(TINFO, "OOM on CPUSET & MEMCG...");
+		testoom(0, 0);
+
+		/*
+		 * Under NUMA system, the migration of cpuset's memory
+ 		 * is in charge of cpuset.memory_migrate, we can write
+		 * 1 to cpuset.memory_migrate to enable the migration.
+		 */
+		if (is_numa(cleanup)) {
+			write_cpuset_files(CPATH_NEW, "memory_migrate", "1");
+			tst_resm(TINFO, "OOM on CPUSET & MEMCG with "
+					"cpuset.memory_migrate=1");
+			testoom(0, 0);
+		}
+
+		if (access(MEMCG_SW_LIMIT, F_OK) == -1) {
+			if (errno == ENOENT) {
+				tst_resm(TCONF,
+					 "memcg swap accounting is disabled");
+				swap_acc_on = 0;
+			} else
+				tst_brkm(TBROK|TERRNO, cleanup, "access");
+		}
+
+		if (swap_acc_on) {
+			tst_resm(TINFO, "OOM on CPUSET & MEMCG with "
+					"special memswap limitation:");
+			snprintf(mem, BUFSIZ, "%ld", TESTMEM);
+			write_file(MEMCG_SW_LIMIT, mem);
+			testoom(0, 0);
+
+			tst_resm(TINFO, "OOM on CPUSET & MEMCG with "
+					"disabled memswap limitation:");
+			write_file(MEMCG_SW_LIMIT, "-1");
+			testoom(0, 0);
+		}
+	}
+
+	cleanup();
+	tst_exit();
+}
+
+void setup(void)
+{
+	tst_require_root(NULL);
+	tst_sig(FORK, DEF_HANDLER, cleanup);
+	TEST_PAUSE;
+
+	mount_mem("memcg", "cgroup", "memory", MEMCG_PATH, MEMCG_PATH_NEW);
+	mount_mem("cpuset", "cpuset", NULL, CPATH, CPATH_NEW);
+	write_memcg();
+
+	set_sys_tune("overcommit_memory", 1, 1);
+
+	if (is_numa(cleanup))
+		/* For NUMA system, using the first node for cpuset.mems */
+		write_cpusets(get_a_numa_node(cleanup));
+	else
+		/* For nonNUMA system, using node0 for cpuset.mems */
+		write_cpusets(0);
+
+	overcommit = get_sys_tune("overcommit_memory");
+}
+
+void cleanup(void)
+{
+	set_sys_tune("overcommit_memory", overcommit, 0);
+	umount_mem(CPATH, CPATH_NEW);
+	umount_mem(MEMCG_PATH, MEMCG_PATH_NEW);
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
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
