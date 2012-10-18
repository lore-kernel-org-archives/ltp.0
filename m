Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1TOpeZ-000465-Is
	for ltp-list@lists.sourceforge.net; Thu, 18 Oct 2012 12:56:47 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TOpeT-0000Et-Qe
	for ltp-list@lists.sourceforge.net; Thu, 18 Oct 2012 12:56:47 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q9ICuZrx015823
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Oct 2012 08:56:35 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with
	ESMTP id q9ICuVXc003245
	for <ltp-list@lists.sourceforge.net>; Thu, 18 Oct 2012 08:56:35 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 18 Oct 2012 14:56:24 +0200
Message-Id: <cf915a2efb79d200cc9f3b6c017eccf6feb870c9.1350564702.git.jstancek@redhat.com>
In-Reply-To: <cover.1350564702.git.jstancek@redhat.com>
References: <cover.1350564702.git.jstancek@redhat.com>
Subject: [LTP] [PATCH 3/3 v2] new syscall test: migrate_pages02
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
 runtest/syscalls                                   |    1 +
 .../syscalls/migrate_pages/migrate_pages02.c       |  363 ++++++++++++++++++++
 2 files changed, 364 insertions(+), 0 deletions(-)
 create mode 100644 testcases/kernel/syscalls/migrate_pages/migrate_pages02.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 9daf234..78f3bd3 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -518,6 +518,7 @@ memcmp01 memcmp01
 memcpy01 memcpy01
 
 migrate_pages01 migrate_pages01
+migrate_pages02 migrate_pages02
 
 mlockall01 mlockall01
 mlockall02 mlockall02
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
new file mode 100644
index 0000000..840aa2b
--- /dev/null
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages02.c
@@ -0,0 +1,363 @@
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
+#define NODE_MIN_FREEMEM 32*1024*1024
+
+char *TCID = "migrate_pages02";
+int  TST_TOTAL = 1;
+
+#if defined(__NR_migrate_pages) && HAVE_NUMA_H && HAVE_NUMAIF_H
+static char nobody_uid[] = "nobody";
+static struct passwd *ltpuser;
+static int *nodes, nodeA, nodeB;
+static int num_nodes;
+
+static void setup(void);
+static void cleanup(void);
+
+option_t options[] = {
+	{ NULL, NULL, NULL }
+};
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
+	char *msg;
+
+	msg = parse_opts(argc, argv, options, NULL);
+	if (msg != NULL)
+		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
+
+	setup();
+	for (lc = 0; TEST_LOOPING(lc); lc++) {
+		Tst_count = 0;
+		test_migrate_current_process(nodeA, nodeB, 1);
+		test_migrate_current_process(nodeA, nodeB, 0);
+		test_migrate_other_process(nodeA, nodeB, 1);
+		test_migrate_other_process(nodeA, nodeB, 0);
+	}
+	cleanup();
+	tst_exit();
+}
+
+static void setup(void)
+{
+	int ret, i;
+	long long freep, maxA, maxB, node_size;
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
+	/* get 2 nodes with max free mem */
+	maxA = maxB = 0;
+	nodeA = nodeB = -1;
+	for (i=0; i<num_nodes; i++) {
+		node_size = numa_node_size64(nodes[i], &freep);
+		if (node_size < 0)
+			tst_brkm(TBROK|TERRNO, NULL, "numa_node_size64 failed");
+		if (freep > NODE_MIN_FREEMEM) {
+			if (freep > maxA) {
+				maxB = maxA;
+				nodeB = nodeA;
+				maxA = freep;
+				nodeA = nodes[i];
+			} else if (freep > maxB) {
+				maxB = freep;
+				nodeB = nodes[i];
+			}
+		}
+	}
+
+	if (nodeA == -1 || nodeB == -1)
+		tst_brkm(TCONF, NULL, "at least 2 NUMA nodes with free mem > %d are needed", NODE_MIN_FREEMEM);
+	tst_resm(TINFO, "Using nodes: %d %d", nodeA, nodeB);
+
+	ltpuser = getpwnam(nobody_uid);
+	if (ltpuser == NULL)
+		tst_brkm(TBROK|TERRNO, NULL, "getpwnam failed");
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
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
