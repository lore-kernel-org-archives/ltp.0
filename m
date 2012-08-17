Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1T2GzN-0007h0-2f
	for ltp-list@lists.sourceforge.net; Fri, 17 Aug 2012 07:29:01 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1T2GzM-0003CR-0h
	for ltp-list@lists.sourceforge.net; Fri, 17 Aug 2012 07:29:01 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q7H7Ssth006320
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 17 Aug 2012 03:28:54 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id q7H7SpKT016867
	for <ltp-list@lists.sourceforge.net>; Fri, 17 Aug 2012 03:28:53 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 17 Aug 2012 09:28:44 +0200
Message-Id: <38044efb8d3a35d8ad3942316828b861310822e5.1345188176.git.jstancek@redhat.com>
In-Reply-To: <9018a236d9800df20fe96edaec0d03149f6d26ca.1345188176.git.jstancek@redhat.com>
References: <9018a236d9800df20fe96edaec0d03149f6d26ca.1345188176.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 3/3] new syscall test: migrate_pages02
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

Use migrate_pages() syscall and check that
shared/non-shared memory is migrated to desired node.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../syscalls/migrate_pages/migrate_pages02.c       |  347 ++++++++++++++++++++
 1 files changed, 347 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/migrate_pages/migrate_pages02.c

diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
new file mode 100644
index 0000000..73177ca
--- /dev/null
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -0,0 +1,347 @@
+/*
+ * Copyright (C) 2012 Linux Test Project, Inc.
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
+ * use migrate_pages() and check that address is on correct node
+ * 1. process A can migrate its non-shared mem with CAP_SYS_NICE
+ * 2. process A can migrate its non-shared mem without CAP_SYS_NICE
+ * 3. process A can migrate shared mem only with CAP_SYS_NICE
+ * 4. process A can migrate non-shared mem in process B with same effective uid
+ * 5. process A can migrate non-shared mem in process B with CAP_SYS_NICE
+ */
+#include <sys/types.h>
+#include <sys/syscall.h>
+#include <sys/wait.h>
+#include <sys/mman.h>
+#include <errno.h>
+#if HAVE_NUMA_H
+#include <numa.h>
+#endif
+#if HAVE_NUMAIF_H
+#include <numaif.h>
+#endif
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <pwd.h>
+#include "config.h"
+#include "test.h"
+#include "usctest.h"
+#include "safe_macros.h"
+#include "linux_syscall_numbers.h"
+#include "numa_helper.h"
+#include "migrate_pages_common.h"
+
+char *TCID = "migrate_pages02";
+int  TST_TOTAL = 1;
+
+#if defined(__NR_migrate_pages) && HAVE_NUMA_H && HAVE_NUMAIF_H
+static const char drop_caches_fname[] = "/proc/sys/vm/drop_caches";
+static char nobody_uid[] = "nobody";
+static struct passwd *ltpuser;
+static int *nodes;
+static int num_nodes;
+
+static void setup(void);
+static void cleanup(void);
+
+static void drop_caches(void)
+{
+	int ret;
+	FILE *f;
+
+	f = fopen(drop_caches_fname, "w");
+	if (f) {
+		ret = fprintf(f, "1");
+		fclose(f);
+		if (ret < 1)
+			tst_brkm(TBROK, cleanup, "Failed to drop caches");
+	} else
+		tst_brkm(TBROK, cleanup, "Failed to open drop_caches");
+}
+
+static int migrate_to_node(int pid, int node)
+{
+	unsigned long nodemask_size, max_node;
+	unsigned long *old_nodes, *new_nodes;
+	int i;
+
+	tst_resm(TPASS, "pid(%d) migrate pid %d to node -> %d",
+		getpid(), pid, node);
+	max_node = get_max_node();
+	nodemask_size = max_node/8+1;
+	old_nodes = SAFE_MALLOC(NULL, nodemask_size);
+	new_nodes = SAFE_MALLOC(NULL, nodemask_size);
+
+	memset(old_nodes, 0, nodemask_size);
+	memset(new_nodes, 0, nodemask_size);
+	for (i = 0; i < num_nodes; i++)
+		set_bit(old_nodes, nodes[i], 1);
+	set_bit(new_nodes, node, 1);
+
+	TEST(syscall(__NR_migrate_pages, pid, max_node, old_nodes, new_nodes));
+	if (TEST_RETURN == -1)
+		tst_resm(TFAIL|TERRNO, "migrate_pages failed ");
+	return TEST_RETURN;
+}
+
+static int addr_on_node(void *addr)
+{
+	int node;
+	int ret;
+
+	ret = syscall(__NR_get_mempolicy, &node, NULL, (unsigned long)0,
+			(unsigned long) addr, MPOL_F_NODE | MPOL_F_ADDR);
+	if (ret == -1) {
+		tst_resm(TBROK | TERRNO, "error getting memory policy "
+				"for page %p", addr);
+	}
+	return node;
+}
+
+static int check_addr_on_node(void *addr, int exp_node)
+{
+	int node;
+
+	node = addr_on_node(addr);
+	if (node == exp_node) {
+		tst_resm(TPASS, "pid(%d) addr %p is on expected node: %d",
+				getpid(), addr, exp_node);
+		return 0;
+	} else {
+		tst_resm(TFAIL, "pid(%d) addr %p not on expected node: %d "
+				", expected %d", getpid(), addr, node,
+				exp_node);
+		return 1;
+	}
+}
+
+static void test_migrate_current_process(int node1, int node2,
+	int cap_sys_nice)
+{
+	char *testp, *testp2;
+	int ret, status;
+	pid_t child;
+
+	/* parent can migrate its non-shared memory */
+	tst_resm(TINFO, "current_process, cap_sys_nice: %d", cap_sys_nice);
+	testp = SAFE_MALLOC(NULL, getpagesize());
+	testp[0] = 0;
+	tst_resm(TINFO, "private anonymous: %p", testp);
+	migrate_to_node(0, node2);
+	check_addr_on_node(testp, node2);
+	migrate_to_node(0, node1);
+	check_addr_on_node(testp, node1);
+	free(testp);
+
+	/* parent can migrate shared memory with CAP_SYS_NICE */
+	testp2 = mmap(NULL, getpagesize(), PROT_READ|PROT_WRITE,
+		MAP_ANONYMOUS|MAP_SHARED, 0, 0);
+	if (testp2 == MAP_FAILED)
+		tst_brkm(TBROK|TERRNO, cleanup, "mmap failed");
+	testp2[0] = 1;
+	tst_resm(TINFO, "shared anonymous: %p", testp2);
+	migrate_to_node(0, node2);
+	check_addr_on_node(testp2, node2);
+
+	/* shared mem is on node2, try to migrate in child to node1 */
+	fflush(stdout);
+	child = fork();
+	switch (child) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+		break;
+	case 0:
+		tst_resm(TINFO, "child shared anonymous, cap_sys_nice: %d",
+			cap_sys_nice);
+		testp = SAFE_MALLOC(NULL, getpagesize());
+		testp[0] = 1;
+		testp2[0] = 1;
+		if (!cap_sys_nice)
+			if (seteuid(ltpuser->pw_uid) == -1)
+				tst_brkm(TBROK|TERRNO, NULL, "seteuid failed");
+
+		migrate_to_node(0, node1);
+		/* child can migrate non-shared memory */
+		ret = check_addr_on_node(testp, node1);
+
+		free(testp);
+		munmap(testp2, getpagesize());
+		exit(ret);
+	default:
+		if (waitpid(child, &status, 0) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+			tst_resm(TFAIL, "child returns %d", status);
+		if (cap_sys_nice)
+			/* child can migrate shared memory only
+			 * with CAP_SYS_NICE */
+			check_addr_on_node(testp2, node1);
+		else
+			check_addr_on_node(testp2, node2);
+		munmap(testp2, getpagesize());
+	}
+}
+
+static void test_migrate_other_process(int node1, int node2,
+	int cap_sys_nice)
+{
+	char *testp;
+	int status, ret, tmp;
+	pid_t child;
+	int child_ready[2];
+	int pages_migrated[2];
+
+	/* setup pipes to synchronize child/parent */
+	if (pipe(child_ready) == -1)
+		tst_resm(TBROK | TERRNO, "pipe #1 failed");
+	if (pipe(pages_migrated) == -1)
+		tst_resm(TBROK | TERRNO, "pipe #2 failed");
+
+	tst_resm(TINFO, "other_process, cap_sys_nice: %d", cap_sys_nice);
+
+	fflush(stdout);
+	child = fork();
+	switch (child) {
+	case -1:
+		tst_brkm(TBROK|TERRNO, cleanup, "fork");
+		break;
+	case 0:
+		close(child_ready[0]);
+		close(pages_migrated[1]);
+
+		testp = SAFE_MALLOC(NULL, getpagesize());
+		testp[0] = 0;
+
+		/* make sure we are on node1 */
+		migrate_to_node(0, node1);
+		check_addr_on_node(testp, node1);
+
+		if (seteuid(ltpuser->pw_uid) == -1)
+			tst_brkm(TBROK|TERRNO, NULL, "seteuid failed");
+
+		/* signal parent it's OK to migrate child and wait */
+		if (write(child_ready[1], &tmp, 1) != 1)
+			tst_brkm(TBROK|TERRNO, NULL, "write #1 failed");
+		if (read(pages_migrated[0], &tmp, 1) != 1)
+			tst_brkm(TBROK|TERRNO, NULL, "read #1 failed");
+
+		/* parent can migrate child process with same euid */
+		/* parent can migrate child process with CAP_SYS_NICE */
+		ret = check_addr_on_node(testp, node2);
+
+		free(testp);
+		close(child_ready[1]);
+		close(pages_migrated[0]);
+		exit(ret);
+	default:
+		close(child_ready[1]);
+		close(pages_migrated[0]);
+
+		if (!cap_sys_nice)
+			if (seteuid(ltpuser->pw_uid) == -1)
+				tst_brkm(TBROK|TERRNO, NULL, "seteuid failed");
+
+		/* wait until child is ready on node1, then migrate and
+		 * signal to check current node */
+		if (read(child_ready[0], &tmp, 1) != 1)
+			tst_brkm(TBROK|TERRNO, NULL, "read #2 failed");
+		migrate_to_node(child, node2);
+		if (write(pages_migrated[1], &tmp, 1) != 1)
+			tst_brkm(TBROK|TERRNO, NULL, "write #2 failed");
+
+		if (waitpid(child, &status, 0) == -1)
+			tst_brkm(TBROK|TERRNO, cleanup, "waitpid");
+		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
+			tst_resm(TFAIL, "child returns %d", status);
+		close(child_ready[0]);
+		close(pages_migrated[1]);
+
+		/* reset euid, so this testcase can be used in loop */
+		if (!cap_sys_nice)
+			if (seteuid(0) == -1)
+				tst_brkm(TBROK|TERRNO, NULL, "seteuid failed");
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	int lc;
+
+	setup();
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		test_migrate_current_process(nodes[0], nodes[1], 1);
+		test_migrate_current_process(nodes[0], nodes[1], 0);
+		test_migrate_other_process(nodes[0], nodes[1], 1);
+		test_migrate_other_process(nodes[0], nodes[1], 0);
+	}
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	int ret;
+
+	tst_require_root(NULL);
+	TEST(syscall(__NR_migrate_pages, 0, 0, NULL, NULL));
+
+	if (numa_available() == -1)
+		tst_brkm(TCONF, NULL, "NUMA not available");
+
+	ret = get_allowed_nodes_arr(NH_MEMS, &num_nodes, &nodes);
+	if (ret < 0)
+		tst_brkm(TBROK|TERRNO, NULL, "get_allowed_nodes(): %d", ret);
+
+	if (num_nodes < 2)
+		tst_brkm(TCONF, NULL, "at least 2 allowed NUMA nodes"
+				" are required");
+	else if (tst_kvercmp(2, 6, 18) < 0)
+		tst_brkm(TCONF, NULL, "2.6.18 or greater kernel required");
+
+	ltpuser = getpwnam(nobody_uid);
+	if (ltpuser == NULL)
+		tst_brkm(TBROK|TERRNO, NULL, "getpwnam failed");
+
+	/* free some memory on each node, if there is no free
+	 * memory on nodes we use migrate_pages won't work */
+	drop_caches();
+
+	TEST_PAUSE;
+}
+
+static void cleanup(void)
+{
+	free(nodes);
+	TEST_CLEANUP;
+}
+
+#else /* __NR_migrate_pages */
+int main(void)
+{
+	tst_brkm(TCONF, NULL, "System doesn't support __NR_migrate_pages"
+			" or libnuma is not available");
+}
+#endif
-- 
1.7.1


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
