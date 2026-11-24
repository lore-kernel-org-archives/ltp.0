Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC2B606A31E
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Sf43vOX4
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6ED783E9ED0
	for <ltp@archiver.kernel.org>; Tue, 24 Nov 2026 14:13:13 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9C703E9153
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 14:12:56 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 03E3D60019B
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 14:12:56 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4a35ac4475dso33231965e9.2
 for <ltp@lists.linux.it>; Tue, 24 Nov 2026 05:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795525975; x=1796130775; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=oivTCqFaw7uIZTxm22BPNsfLfu/L8PPZfsC/nTE+VLs=;
 b=Sf43vOX4iFmdhvDj2bLElc2bGXlFHrzRl708kf6yGORkq4MeqFoaEa/Pmwxf4L89g7
 7Mc/xhn41X0TfKeac/+IX68SONIgPm7QxjAumo8/pUK6dlFFdZbTvOLo4Xr8EUfOwacy
 DRquom9rKHmRoq1CxeXNNNp5o9C7LifPzGxBLG9y+M3cEkjeTEGyEQPe0jFNWHN4gwma
 cSX4rzVFMTOqfmEheEj4fqGCLtGs+9T5RnyQFOf3CaAVOLRRZpsAbfP9JU6PgZ9ga5FI
 qNag9dnFznyYL5gJ8sfuOyDjKCY0MSmu5s8OosY2Cf6ZAVtEBrwKrN0n7b9EqsGMQLlD
 6nwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795525975; x=1796130775;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oivTCqFaw7uIZTxm22BPNsfLfu/L8PPZfsC/nTE+VLs=;
 b=pgUO+fK1mgPHJHe9Tocqeq6MRJ9Mlvi2s+1QwLLe9D6canG2nbJabSFjji1nRnF7dn
 CA0EUGJSjLJaeN7xebS4dRTUzNMM9tTCLK/czK0cmY8sLg5L9eYANhP1RftSnxoHzAo4
 ABF5dFa2xsJKbA1NM4QmsfBExw6Dj5SeRzgdDp4C3PPZS3LMJEmXfIiDLV642IZczskK
 ypfcKXxriMU7Z38mq4MiOABc94P0Jvwn7ethF3QPR8Xyp/OJeIMHxe1eW+nAzehmHNVU
 kBwS86OpwiYJ0sXAei638CV+yVI03ASTFWvX7k4+2fQFIaV3vGzNKpAd/qsoqi+ygX9/
 kMPw==
X-Gm-Message-State: APuU4Z9E8k8ur5NSrBVN/9aa3YLyEjBafSzn+3q7qNSVur55Ipbz//la
 LeDT44NkTUVX4mtVdfNkkv/spkpqMOlbs4HQOz7ryAK/6ozMuuqbyAcTQe4AEtQx
X-Gm-Gg: AZFdTZeFKofVgeOWoRX1vbN8JCATDYgY4xB/6FekWv83KDYpMdTnXY5S0EdI2Yl7o6K
 MYULRbDGxR3HYQf/yMBcyjOPDUqntSzoGJfDqKvjiqHBy2sVYmTvNuwgqh77iFAkdp4B28QHGnc
 J/Gk10ifHb2upYTI0EJR1UNn9tAHssgokKT+I2EFdQc3mTt7JY7HE3P8e1Dm4zntfTEaaDagOOR
 fxF+kvSWhutyKwHmw0077chh4TKnMqLHZ9kCk/YwtFKXXJhNX7Az1dB7EzGFqt4GBuCLt/RsyJK
 /SuxUkXhxgmS11pF7Rhm7thahk66mHSNHkcbHzrR+Wku9yCdJhKhRBzFOGUJNOvenXrc5wxj5jM
 wBntPAfUqa51IRM7Q9D7bAOWtbAFqM9vLxas55y+2K4CZTiz8dwP3+bXE2tQ2BogpHUwIDL3JEC
 nBiy5YXlrjr//PzNILyzil7eUwB5j8z1rvo88F48QxhdUJkmZ3A1HkGRkP0LzPVWySJ/CoLX3lM
 SVG/yxOOfm2RysGjsAMjowOGlh0Fb1W2qPpEFbN3s+k8W0+9vxTqj9HH3zpAr1GFT57joUhMJal
 JZcvEq/VHvXxq3qgR7uehYQ7E8hjl4WpY38xWPf9SRFwCEkw8lbuTVl3pQgRVphw7Gdv7Y09RyK
 /C+MUE+Nudfmhy4kd2u71sgNVCgBO3GPMlESs+sKBWArdPJK53I4Yv1qAnXpcxV8rpMgKeNI0fd
 0XZcLBjQY=
X-Received: by 2002:a05:600c:3b1d:b0:4bb:6991:2330 with SMTP id
 5b1f17b1804b1-4bb8881a890mr300665845e9.22.1795525975126; 
 Tue, 24 Nov 2026 05:12:55 -0800 (PST)
Received: from localhost.localdomain
 (cmbg-20-b2-v4wan-172845-cust780.vm17.cable.virginm.net. [81.105.27.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb9067846esm270492475e9.4.2026.11.24.05.12.54
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 24 Nov 2026 05:12:54 -0800 (PST)
From: Pradeep Susarla <pradeep.susarla@gmail.com>
To: ltp@lists.linux.it
Date: Tue, 24 Nov 2026 13:12:37 +0000
Message-ID: <20261124131237.53712-1-pradeep.susarla@gmail.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] migrate_pages01: Convert to new API
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: Pradeep Susarla <pradeep.susarla@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Rewrite the test using the new test API:

- Use TST_EXP_PASS() and TST_EXP_FAIL() instead of the legacy
  check_ret() and check_errno() helpers. Nothing else uses them, so
  remove them from migrate_pages_common.c, which then no longer needs
  test.h.
- Look up the allowed nodes once in setup() with get_allowed_nodes_arr()
  instead of calling is_numa() and get_allowed_nodes().
- Run the EPERM check in a SAFE_FORK() child and reap it with
  tst_reap_children().
- Replace tst_require_root() with .needs_root.
- Add a description of what is tested.

The tested cases are unchanged.

Signed-off-by: Pradeep Susarla <pradeep.susarla@gmail.com>
---

Notes:
    Tested on a single-node x86_64 VM (kernel 6.18): all 9 checks pass, also with -i 3.
    migrate_pages02 and migrate_pages03 still build against the trimmed
    migrate_pages_common.c. make check-migrate_pages01 is clean.

 .../syscalls/migrate_pages/migrate_pages01.c  | 313 +++++++-----------
 .../migrate_pages/migrate_pages_common.c      |  28 --
 .../migrate_pages/migrate_pages_common.h      |   2 -
 3 files changed, 128 insertions(+), 215 deletions(-)

diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
index 428ca9a4..5112d6d6 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages01.c
@@ -1,252 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2012 Linux Test Project, Inc.
+ * Copyright (c) 2026 Pradeep Susarla <pradeep.susarla@gmail.com>
+ */
+
+/*\
+ * Verify the errors returned by :manpage:`migrate_pages(2)`:
  *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of version 2 of the GNU General Public
- * License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- *
- * Further, this software is distributed without any warranty that it
- * is free of the rightful claim of any third person regarding
- * infringement or the like.  Any license provided herein, whether
- * implied or otherwise, applies only to this software file.  Patent
- * licenses, if any, provided herein do not apply to combinations of
- * this program with other software, or any other product whatsoever.
+ * - ESRCH when pid is -1 or no process with that pid exists
+ * - EINVAL when maxnode is invalid
+ * - EFAULT when old_nodes and new_nodes point to an invalid address,
+ *   a PROT_NONE mapping or an unmapped page
+ * - EINVAL when new_nodes contains a node that is not allowed
+ * - EPERM when an unprivileged process tries to migrate the pages of a
+ *   process owned by another user
  *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
- * 02110-1301, USA.
+ * Also verify that migrating the pages of the calling process from a node
+ * to the same node succeeds.
  */
 
-/*
- * errno tests for migrate_pages() syscall
- */
-#include <sys/types.h>
-#include <sys/syscall.h>
-#include <sys/wait.h>
-#include <sys/mman.h>
 #include <errno.h>
-#include <stdio.h>
+#include <pwd.h>
 #include <stdlib.h>
 #include <string.h>
 #include <unistd.h>
-#include <pwd.h>
+#include <sys/mman.h>
 
-#include "test.h"
-#include "tso_safe_macros.h"
+#include "tst_test.h"
 #include "lapi/syscalls.h"
 #include "numa_helper.h"
 #include "migrate_pages_common.h"
 
-char *TCID = "migrate_pages01";
-int TST_TOTAL = 1;
-
-option_t options[] = {
-	{NULL, NULL, NULL}
-};
-
 #ifdef HAVE_NUMA_V2
 
 static unsigned long *sane_old_nodes;
 static unsigned long *sane_new_nodes;
-static int sane_nodemask_size;
-static int sane_max_node;
-
-static void setup(void);
-static void cleanup(void);
+static unsigned long *invalid_new_nodes;
+static unsigned long sane_max_node;
+static size_t sane_nodemask_size;
+static int invalid_node = -1;
+static int *nodes;
+static int num_nodes;
+static struct passwd *ltpuser;
+
+static long sys_migrate_pages(pid_t pid, unsigned long maxnode,
+			      const unsigned long *old_nodes,
+			      const unsigned long *new_nodes)
+{
+	return tst_syscall(__NR_migrate_pages, pid, maxnode, old_nodes,
+			   new_nodes);
+}
 
-static void test_sane_nodes(void)
+static void verify_sane_nodes(void)
 {
-	tst_resm(TINFO, "test_empty_mask");
-	TEST(tst_syscall(__NR_migrate_pages, 0, sane_max_node,
-		     sane_old_nodes, sane_new_nodes));
-	check_ret(0);
+	TST_EXP_PASS(sys_migrate_pages(0, sane_max_node, sane_old_nodes,
+				       sane_new_nodes),
+		     "migrate_pages() from node %d to node %d",
+		     nodes[0], nodes[0]);
 }
 
-static void test_invalid_pid(void)
+static void verify_invalid_pid(void)
 {
-	pid_t invalid_pid = -1;
-
-	tst_resm(TINFO, "test_invalid_pid -1");
-	TEST(tst_syscall(__NR_migrate_pages, invalid_pid, sane_max_node,
-		     sane_old_nodes, sane_new_nodes));
-	check_ret(-1);
-	check_errno(ESRCH);
-
-	tst_resm(TINFO, "test_invalid_pid unused pid");
-	invalid_pid = tst_get_unused_pid(cleanup);
-	TEST(tst_syscall(__NR_migrate_pages, invalid_pid, sane_max_node,
-		     sane_old_nodes, sane_new_nodes));
-	check_ret(-1);
-	check_errno(ESRCH);
+	pid_t unused_pid = tst_get_unused_pid();
+
+	TST_EXP_FAIL(sys_migrate_pages(-1, sane_max_node, sane_old_nodes,
+				       sane_new_nodes),
+		     ESRCH, "migrate_pages() with pid -1");
+
+	TST_EXP_FAIL(sys_migrate_pages(unused_pid, sane_max_node,
+				       sane_old_nodes, sane_new_nodes),
+		     ESRCH, "migrate_pages() with unused pid %d", unused_pid);
 }
 
-static void test_invalid_masksize(void)
+static void verify_invalid_masksize(void)
 {
-	tst_resm(TINFO, "test_invalid_masksize");
-	TEST(tst_syscall(__NR_migrate_pages, 0, -1, sane_old_nodes,
-		     sane_new_nodes));
-	check_ret(-1);
-	check_errno(EINVAL);
+	TST_EXP_FAIL(sys_migrate_pages(0, -1, sane_old_nodes, sane_new_nodes),
+		     EINVAL, "migrate_pages() with maxnode -1");
 }
 
-static void test_invalid_mem(void)
+static void verify_invalid_mem(void)
 {
 	unsigned long *p;
+	int pagesize = getpagesize();
+
+	TST_EXP_FAIL(sys_migrate_pages(0, sane_max_node, (void *)-1,
+				       (void *)-1),
+		     EFAULT, "migrate_pages() with invalid address");
+
+	p = SAFE_MMAP(NULL, pagesize, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS,
+		      -1, 0);
+	TST_EXP_FAIL(sys_migrate_pages(0, sane_max_node, p, p),
+		     EFAULT, "migrate_pages() with PROT_NONE mapping");
 
-	tst_resm(TINFO, "test_invalid_mem -1");
-	TEST(tst_syscall(__NR_migrate_pages, 0, sane_max_node, -1, -1));
-	check_ret(-1);
-	check_errno(EFAULT);
-
-	tst_resm(TINFO, "test_invalid_mem invalid prot");
-	p = mmap(NULL, getpagesize(), PROT_NONE,
-		 MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-	if (p == MAP_FAILED)
-		tst_brkm(TBROK | TERRNO, cleanup, "mmap");
-	TEST(tst_syscall(__NR_migrate_pages, 0, sane_max_node, p, p));
-	check_ret(-1);
-	check_errno(EFAULT);
-
-	SAFE_MUNMAP(cleanup, p, getpagesize());
-	tst_resm(TINFO, "test_invalid_mem unmmaped");
-	TEST(tst_syscall(__NR_migrate_pages, 0, sane_max_node, p, p));
-	check_ret(-1);
-	check_errno(EFAULT);
+	SAFE_MUNMAP(p, pagesize);
+	TST_EXP_FAIL(sys_migrate_pages(0, sane_max_node, p, p),
+		     EFAULT, "migrate_pages() with unmapped page");
 }
 
-static void test_invalid_nodes(void)
+static void verify_invalid_nodes(void)
 {
-	int *nodes;
-	int num_nodes, ret, i;
-	int invalid_node = 0;
-	unsigned long *old_nodes, *new_nodes;
-
-	tst_resm(TINFO, "test_invalid_nodes");
-	ret = get_allowed_nodes_arr(NH_MEMS, &num_nodes, &nodes);
-	if (ret < 0)
-		tst_brkm(TBROK | TERRNO, cleanup,
-			 "get_allowed_nodes_arr: %d", ret);
-
-	/* get first node which is not in nodes */
-	for (i = 0; i < num_nodes; i++, invalid_node++)
-		if (invalid_node != nodes[i])
-			break;
-	if (invalid_node < sane_max_node) {
-		old_nodes = SAFE_MALLOC(NULL, sane_nodemask_size);
-		new_nodes = SAFE_MALLOC(NULL, sane_nodemask_size);
-		memcpy(old_nodes, sane_old_nodes, sane_nodemask_size);
-		memset(new_nodes, 0, sane_nodemask_size);
-		set_bit(new_nodes, invalid_node, 1);
-
-		TEST(tst_syscall(__NR_migrate_pages, 0, sane_max_node,
-			     old_nodes, new_nodes));
-		check_ret(-1);
-		check_errno(EINVAL);
-		free(old_nodes);
-		free(new_nodes);
-	} else {
-		tst_resm(TCONF, "All possible nodes are present");
+	if (invalid_node < 0) {
+		tst_res(TCONF, "All possible nodes are allowed");
+		return;
 	}
 
-	free(nodes);
+	TST_EXP_FAIL(sys_migrate_pages(0, sane_max_node, sane_old_nodes,
+				       invalid_new_nodes),
+		     EINVAL, "migrate_pages() to not allowed node %d",
+		     invalid_node);
 }
 
-static void test_invalid_perm(void)
+static void verify_invalid_perm(void)
 {
-	char nobody_uid[] = "nobody";
-	struct passwd *ltpuser;
-	int status;
-	pid_t child_pid;
-	pid_t parent_pid;
-	int ret = 0;
-
-	tst_resm(TINFO, "test_invalid_perm");
-	parent_pid = getpid();
-	fflush(stdout);
-	child_pid = fork();
-	switch (child_pid) {
-	case -1:
-		tst_brkm(TBROK | TERRNO, cleanup, "fork");
-		break;
-	case 0:
-		ltpuser = getpwnam(nobody_uid);
-		if (ltpuser == NULL)
-			tst_brkm(TBROK | TERRNO, NULL, "getpwnam failed");
-		SAFE_SETUID(NULL, ltpuser->pw_uid);
-		TEST(tst_syscall(__NR_migrate_pages, parent_pid,
-			     sane_max_node, sane_old_nodes, sane_new_nodes));
-		ret |= check_ret(-1);
-		ret |= check_errno(EPERM);
-		exit(ret);
-	default:
-		SAFE_WAITPID(cleanup, child_pid, &status, 0);
-		if (!WIFEXITED(status) || WEXITSTATUS(status) != 0)
-			tst_resm(TFAIL, "child returns %d", status);
+	pid_t parent_pid = getpid();
+
+	if (!SAFE_FORK()) {
+		SAFE_SETUID(ltpuser->pw_uid);
+		TST_EXP_FAIL(sys_migrate_pages(parent_pid, sane_max_node,
+					       sane_old_nodes, sane_new_nodes),
+			     EPERM, "migrate_pages() of root process as %s",
+			     ltpuser->pw_name);
+		exit(0);
 	}
+
+	tst_reap_children();
 }
 
-int main(int argc, char *argv[])
+static void run(void)
 {
-	int lc;
-
-	tst_parse_opts(argc, argv, options, NULL);
-
-	setup();
-	for (lc = 0; TEST_LOOPING(lc); lc++) {
-		tst_count = 0;
-		test_sane_nodes();
-		test_invalid_pid();
-		test_invalid_masksize();
-		test_invalid_mem();
-		test_invalid_nodes();
-		test_invalid_perm();
-	}
-	cleanup();
-	tst_exit();
+	verify_sane_nodes();
+	verify_invalid_pid();
+	verify_invalid_masksize();
+	verify_invalid_mem();
+	verify_invalid_nodes();
+	verify_invalid_perm();
 }
 
 static void setup(void)
 {
-	int node, ret;
+	int i, node = 0;
 
-	tst_require_root();
-	TEST(tst_syscall(__NR_migrate_pages, 0, 0, NULL, NULL));
+	tst_syscall(__NR_migrate_pages, 0, 0, NULL, NULL);
 
-	if (!is_numa(NULL, NH_MEMS, 1))
-		tst_brkm(TCONF, NULL, "requires NUMA with at least 1 node");
+	if (get_allowed_nodes_arr(NH_MEMS, &num_nodes, &nodes) < 0)
+		tst_brk(TBROK | TERRNO, "get_allowed_nodes_arr() failed");
 
-	ret = get_allowed_nodes(NH_MEMS, 1, &node);
-	if (ret < 0)
-		tst_brkm(TBROK | TERRNO, NULL, "get_allowed_nodes_arr: %d",
-			 ret);
+	if (num_nodes < 1)
+		tst_brk(TCONF, "requires NUMA with at least 1 node");
 
-	sane_max_node = LTP_ALIGN(get_max_node(), sizeof(unsigned long)*8);
+	sane_max_node = LTP_ALIGN(get_max_node(), sizeof(unsigned long) * 8);
 	sane_nodemask_size = sane_max_node / 8;
-	sane_old_nodes = SAFE_MALLOC(NULL, sane_nodemask_size);
-	sane_new_nodes = SAFE_MALLOC(NULL, sane_nodemask_size);
+
+	sane_old_nodes = SAFE_MALLOC(sane_nodemask_size);
+	sane_new_nodes = SAFE_MALLOC(sane_nodemask_size);
 	memset(sane_old_nodes, 0, sane_nodemask_size);
 	memset(sane_new_nodes, 0, sane_nodemask_size);
+	set_bit(sane_old_nodes, nodes[0], 1);
+	set_bit(sane_new_nodes, nodes[0], 1);
 
-	set_bit(sane_old_nodes, node, 1);
-	set_bit(sane_new_nodes, node, 1);
+	/* find the first node that is not allowed */
+	for (i = 0; i < num_nodes; i++, node++) {
+		if (node != nodes[i])
+			break;
+	}
+
+	if ((unsigned long)node < sane_max_node) {
+		invalid_node = node;
+		invalid_new_nodes = SAFE_MALLOC(sane_nodemask_size);
+		memset(invalid_new_nodes, 0, sane_nodemask_size);
+		set_bit(invalid_new_nodes, invalid_node, 1);
+	}
 
-	TEST_PAUSE;
+	ltpuser = SAFE_GETPWNAM("nobody");
 }
 
 static void cleanup(void)
 {
+	free(invalid_new_nodes);
 	free(sane_old_nodes);
 	free(sane_new_nodes);
+	free(nodes);
 }
 
+static struct tst_test test = {
+	.needs_root = 1,
+	.forks_child = 1,
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+};
+
 #else
-int main(void)
-{
-	tst_brkm(TCONF, NULL, NUMA_ERROR_MSG);
-}
+TST_TEST_TCONF(NUMA_ERROR_MSG);
 #endif
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages_common.c b/testcases/kernel/syscalls/migrate_pages/migrate_pages_common.c
index 49f61949..7f6aeea7 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages_common.c
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages_common.c
@@ -22,7 +22,6 @@
  * 02110-1301, USA.
  */
 
-#include "test.h"
 #include "migrate_pages_common.h"
 
 void set_bit(unsigned long *b, unsigned int n, unsigned int v)
@@ -32,30 +31,3 @@ void set_bit(unsigned long *b, unsigned int n, unsigned int v)
 	else
 		b[n / bitsperlong] &= ~(1UL << (n % bitsperlong));
 }
-
-int check_ret(long expected_ret)
-{
-	if (expected_ret == TEST_RETURN) {
-		tst_resm(TPASS, "expected ret success: "
-			 "returned value = %ld", TEST_RETURN);
-		return 0;
-	} else
-		tst_resm(TFAIL, "unexpected failure - "
-			 "returned value = %ld, expected: %ld",
-			 TEST_RETURN, expected_ret);
-	return 1;
-}
-
-int check_errno(long expected_errno)
-{
-	if (TEST_ERRNO == expected_errno) {
-		tst_resm(TPASS | TTERRNO, "expected failure");
-		return 0;
-	} else if (TEST_ERRNO == 0)
-		tst_resm(TFAIL, "call succeeded unexpectedly");
-	else
-		tst_resm(TFAIL | TTERRNO, "unexpected failure - "
-			 "expected = %ld : %s, actual",
-			 expected_errno, strerror(expected_errno));
-	return 1;
-}
diff --git a/testcases/kernel/syscalls/migrate_pages/migrate_pages_common.h b/testcases/kernel/syscalls/migrate_pages/migrate_pages_common.h
index d821b07b..b9d15a55 100644
--- a/testcases/kernel/syscalls/migrate_pages/migrate_pages_common.h
+++ b/testcases/kernel/syscalls/migrate_pages/migrate_pages_common.h
@@ -28,6 +28,4 @@
 #define bitsperlong (8 * sizeof(unsigned long))
 
 void set_bit(unsigned long *b, unsigned int n, unsigned int v);
-int check_ret(long expected_ret);
-int check_errno(long expected_errno);
 #endif
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
