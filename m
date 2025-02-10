Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03970C02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 11:35:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 895413C989E
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 12:35:36 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA4E33C98A8
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:32:14 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8603A10122B0
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 12:32:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 862E3210FB;
 Mon, 10 Feb 2025 11:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739187132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dFFgS8TsqyIggdm2O4uXCXLogzOjEtY+GSxLyhro3VI=;
 b=l2NUjlyFtvoR4qO8Y+uKpv3ihqjb+LSmB7WjLhya3oisRfPOQ1jz02iPshksAmuSUt3cHV
 x0pQfZOd9Advg9Z2abCBlB9bBflJv8CWJpyiNVwpJoih4cn++PLlyISci5r2qGdVexI0D8
 a2c9Nb/nBcl7hk71LhJV/NtdUHB4lMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739187132;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dFFgS8TsqyIggdm2O4uXCXLogzOjEtY+GSxLyhro3VI=;
 b=w5p+TtKJm2HuiddGjTWf5p+5T3f3NWB1WWSgQfgJz4cfB0zS15OjsH5P4XW8m4iRdFdsjU
 Wcx71Ywk5lnRyQBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739187132; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dFFgS8TsqyIggdm2O4uXCXLogzOjEtY+GSxLyhro3VI=;
 b=l2NUjlyFtvoR4qO8Y+uKpv3ihqjb+LSmB7WjLhya3oisRfPOQ1jz02iPshksAmuSUt3cHV
 x0pQfZOd9Advg9Z2abCBlB9bBflJv8CWJpyiNVwpJoih4cn++PLlyISci5r2qGdVexI0D8
 a2c9Nb/nBcl7hk71LhJV/NtdUHB4lMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739187132;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dFFgS8TsqyIggdm2O4uXCXLogzOjEtY+GSxLyhro3VI=;
 b=w5p+TtKJm2HuiddGjTWf5p+5T3f3NWB1WWSgQfgJz4cfB0zS15OjsH5P4XW8m4iRdFdsjU
 Wcx71Ywk5lnRyQBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FB4E13A62;
 Mon, 10 Feb 2025 11:32:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jCoeGrzjqWf5YQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 10 Feb 2025 11:32:12 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 10 Feb 2025 12:32:07 +0100
Message-ID: <20250210113212.29520-9-chrubis@suse.cz>
X-Mailer: git-send-email 2.45.3
In-Reply-To: <20250210113212.29520-1-chrubis@suse.cz>
References: <20250210113212.29520-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 08/13] testcases/kernel/mem: Move oom() fucntions
 to oom tests
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Functions that are used only by the oom testcases are moved into
oom/oom.h.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/mem/include/mem.h |  10 --
 testcases/kernel/mem/lib/mem.c     | 212 --------------------------
 testcases/kernel/mem/oom/Makefile  |   7 +-
 testcases/kernel/mem/oom/oom.h     | 231 +++++++++++++++++++++++++++++
 testcases/kernel/mem/oom/oom01.c   |   3 +-
 testcases/kernel/mem/oom/oom02.c   |   5 +-
 testcases/kernel/mem/oom/oom03.c   |  11 +-
 testcases/kernel/mem/oom/oom04.c   |   5 +-
 testcases/kernel/mem/oom/oom05.c   |   9 +-
 9 files changed, 256 insertions(+), 237 deletions(-)
 create mode 100644 testcases/kernel/mem/oom/oom.h

diff --git a/testcases/kernel/mem/include/mem.h b/testcases/kernel/mem/include/mem.h
index e0f443b4b..5ebedc175 100644
--- a/testcases/kernel/mem/include/mem.h
+++ b/testcases/kernel/mem/include/mem.h
@@ -14,16 +14,6 @@
 #define PATH_SYSVM		"/proc/sys/vm/"
 #define PATH_MEMINFO		"/proc/meminfo"
 
-/* OOM */
-
-#define LENGTH			(3UL<<30)
-#define NORMAL			1
-#define MLOCK			2
-#define KSM			3
-
-void oom(int testcase, int lite, int retcode, int allow_sigkill);
-void testoom(int mempolicy, int lite, int retcode, int allow_sigkill);
-
 /* KSM */
 
 void create_same_memory(int size, int num, int unit);
diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index c7c05aa03..f3b844994 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -25,218 +25,6 @@
 #include "mem.h"
 #include "numa_helper.h"
 
-/* OOM */
-
-static int alloc_mem(long int length, int testcase)
-{
-	char *s;
-	long i, pagesz = getpagesize();
-	int loop = 10;
-
-	tst_res(TINFO, "thread (%lx), allocating %ld bytes.",
-		(unsigned long) pthread_self(), length);
-
-	s = mmap(NULL, length, PROT_READ | PROT_WRITE,
-		 MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
-	if (s == MAP_FAILED)
-		return errno;
-
-	if (testcase == MLOCK) {
-		while (mlock(s, length) == -1 && loop > 0) {
-			if (EAGAIN != errno)
-				return errno;
-			usleep(300000);
-			loop--;
-		}
-	}
-
-#ifdef HAVE_DECL_MADV_MERGEABLE
-	if (testcase == KSM && madvise(s, length, MADV_MERGEABLE) == -1)
-		return errno;
-#endif
-	for (i = 0; i < length; i += pagesz)
-		s[i] = '\a';
-
-	return 0;
-}
-
-static void *child_alloc_thread(void *args)
-{
-	int ret = 0;
-
-	/* keep allocating until there's an error */
-	while (!ret)
-		ret = alloc_mem(LENGTH, (long)args);
-	exit(ret);
-}
-
-static void child_alloc(int testcase, int lite, int threads)
-{
-	int i;
-	pthread_t *th;
-
-	if (lite) {
-		int ret = alloc_mem(TESTMEM * 2 + MB, testcase);
-		exit(ret);
-	}
-
-	th = malloc(sizeof(pthread_t) * threads);
-	if (!th) {
-		tst_res(TINFO | TERRNO, "malloc");
-		goto out;
-	}
-
-	for (i = 0; i < threads; i++) {
-		TEST(pthread_create(&th[i], NULL, child_alloc_thread,
-			(void *)((long)testcase)));
-		if (TST_RET) {
-			tst_res(TINFO | TRERRNO, "pthread_create");
-			/*
-			 * Keep going if thread other than first fails to
-			 * spawn due to lack of resources.
-			 */
-			if (i == 0 || TST_RET != EAGAIN)
-				goto out;
-		}
-	}
-
-	/* wait for one of threads to exit whole process */
-	while (1)
-		sleep(1);
-out:
-	exit(1);
-}
-
-/*
- * oom - allocates memory according to specified testcase and checks
- *       desired outcome (e.g. child killed, operation failed with ENOMEM)
- * @testcase: selects how child allocates memory
- *            valid choices are: NORMAL, MLOCK and KSM
- * @lite: if non-zero, child makes only single TESTMEM+MB allocation
- *        if zero, child keeps allocating memory until it gets killed
- *        or some operation fails
- * @retcode: expected return code of child process
- *           if matches child ret code, this function reports PASS,
- *           otherwise it reports FAIL
- * @allow_sigkill: if zero and child is killed, this function reports FAIL
- *                 if non-zero, then if child is killed by SIGKILL
- *                 it is considered as PASS
- */
-void oom(int testcase, int lite, int retcode, int allow_sigkill)
-{
-	pid_t pid;
-	int status, threads;
-
-	tst_enable_oom_protection(0);
-
-	switch (pid = SAFE_FORK()) {
-	case 0:
-		tst_disable_oom_protection(0);
-		threads = MAX(1, tst_ncpus() - 1);
-		child_alloc(testcase, lite, threads);
-	default:
-		break;
-	}
-
-	tst_res(TINFO, "expected victim is %d.", pid);
-	SAFE_WAITPID(-1, &status, 0);
-
-	if (WIFSIGNALED(status)) {
-		if (allow_sigkill && WTERMSIG(status) == SIGKILL) {
-			tst_res(TPASS, "victim signalled: (%d) %s",
-				SIGKILL,
-				tst_strsig(SIGKILL));
-		} else {
-			tst_res(TFAIL, "victim signalled: (%d) %s",
-				WTERMSIG(status),
-				tst_strsig(WTERMSIG(status)));
-		}
-	} else if (WIFEXITED(status)) {
-		if (WEXITSTATUS(status) == retcode) {
-			tst_res(TPASS, "victim retcode: (%d) %s",
-				retcode, strerror(retcode));
-		} else {
-			tst_res(TFAIL, "victim unexpectedly ended with "
-				"retcode: %d, expected: %d",
-				WEXITSTATUS(status), retcode);
-		}
-	} else {
-		tst_res(TFAIL, "victim unexpectedly ended");
-	}
-}
-
-#ifdef HAVE_NUMA_V2
-static void set_global_mempolicy(int mempolicy)
-{
-	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
-	int num_nodes, *nodes;
-	int ret;
-
-	if (mempolicy) {
-		ret = get_allowed_nodes_arr(NH_MEMS|NH_CPUS, &num_nodes, &nodes);
-		if (ret != 0)
-			tst_brk(TBROK|TERRNO, "get_allowed_nodes_arr");
-		if (num_nodes < 2) {
-			tst_res(TINFO, "mempolicy need NUMA system support");
-			free(nodes);
-			return;
-		}
-		switch(mempolicy) {
-		case MPOL_BIND:
-			/* bind the second node */
-			set_node(nmask, nodes[1]);
-			break;
-		case MPOL_INTERLEAVE:
-		case MPOL_PREFERRED:
-			if (num_nodes == 2) {
-				tst_res(TINFO, "The mempolicy need "
-					 "more than 2 numa nodes");
-				free(nodes);
-				return;
-			} else {
-				/* Using the 2nd,3rd node */
-				set_node(nmask, nodes[1]);
-				set_node(nmask, nodes[2]);
-			}
-			break;
-		default:
-			tst_brk(TBROK|TERRNO, "Bad mempolicy mode");
-		}
-		if (set_mempolicy(mempolicy, nmask, MAXNODES) == -1)
-			tst_brk(TBROK|TERRNO, "set_mempolicy");
-	}
-}
-#else
-static void set_global_mempolicy(int mempolicy LTP_ATTRIBUTE_UNUSED) { }
-#endif
-
-void testoom(int mempolicy, int lite, int retcode, int allow_sigkill)
-{
-	int ksm_run_orig;
-
-	set_global_mempolicy(mempolicy);
-
-	tst_res(TINFO, "start normal OOM testing.");
-	oom(NORMAL, lite, retcode, allow_sigkill);
-
-	tst_res(TINFO, "start OOM testing for mlocked pages.");
-	oom(MLOCK, lite, retcode, allow_sigkill);
-
-	/*
-	 * Skip oom(KSM) if lite == 1, since limit_in_bytes may vary from
-	 * run to run, which isn't reliable for oom03 cgroup test.
-	 */
-	if (access(PATH_KSM, F_OK) == -1 || lite == 1) {
-		tst_res(TINFO, "KSM is not configed or lite == 1, "
-			 "skip OOM test for KSM pags");
-	} else {
-		tst_res(TINFO, "start OOM testing for KSM pages.");
-		SAFE_FILE_SCANF(PATH_KSM "run", "%d", &ksm_run_orig);
-		SAFE_FILE_PRINTF(PATH_KSM "run", "1");
-		oom(KSM, lite, retcode, allow_sigkill);
-		SAFE_FILE_PRINTF(PATH_KSM "run", "%d", ksm_run_orig);
-	}
-}
 
 /* KSM */
 
diff --git a/testcases/kernel/mem/oom/Makefile b/testcases/kernel/mem/oom/Makefile
index dd55fb8dc..db621b9ce 100644
--- a/testcases/kernel/mem/oom/Makefile
+++ b/testcases/kernel/mem/oom/Makefile
@@ -19,5 +19,10 @@
 top_srcdir		?= ../../../..
 
 include $(top_srcdir)/include/mk/testcases.mk
-include $(top_srcdir)/testcases/kernel/mem/include/libmem.mk
+
+include $(top_srcdir)/testcases/kernel/include/lib.mk
+
+CFLAGS+=-pthread
+LDFLAGS+=-pthread
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/mem/oom/oom.h b/testcases/kernel/mem/oom/oom.h
new file mode 100644
index 000000000..41cc681f9
--- /dev/null
+++ b/testcases/kernel/mem/oom/oom.h
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) Linux Test Project, 2011-2021
+ * Copyright (c) Cyril Hrubis <chrubis@suse.cz> 2024
+ */
+#ifndef OOM_H_
+#define OOM_H_
+
+#include <pthread.h>
+#include "config.h"
+#include "numa_helper.h"
+
+#define PATH_KSM        "/sys/kernel/mm/ksm/"
+
+#define LENGTH			(3UL<<30)
+#define NORMAL			1
+#define MLOCK			2
+#define KSM			3
+
+#ifdef HAVE_NUMA_V2
+static inline void set_global_mempolicy(int mempolicy)
+{
+	unsigned long nmask[MAXNODES / BITS_PER_LONG] = { 0 };
+	int num_nodes, *nodes;
+	int ret;
+
+	if (mempolicy) {
+		ret = get_allowed_nodes_arr(NH_MEMS|NH_CPUS, &num_nodes, &nodes);
+		if (ret != 0)
+			tst_brk(TBROK|TERRNO, "get_allowed_nodes_arr");
+		if (num_nodes < 2) {
+			tst_res(TINFO, "mempolicy need NUMA system support");
+			free(nodes);
+			return;
+		}
+		switch(mempolicy) {
+		case MPOL_BIND:
+			/* bind the second node */
+			set_node(nmask, nodes[1]);
+			break;
+		case MPOL_INTERLEAVE:
+		case MPOL_PREFERRED:
+			if (num_nodes == 2) {
+				tst_res(TINFO, "The mempolicy need "
+					 "more than 2 numa nodes");
+				free(nodes);
+				return;
+			} else {
+				/* Using the 2nd,3rd node */
+				set_node(nmask, nodes[1]);
+				set_node(nmask, nodes[2]);
+			}
+			break;
+		default:
+			tst_brk(TBROK|TERRNO, "Bad mempolicy mode");
+		}
+		if (set_mempolicy(mempolicy, nmask, MAXNODES) == -1)
+			tst_brk(TBROK|TERRNO, "set_mempolicy");
+	}
+}
+#else
+static void set_global_mempolicy(int mempolicy LTP_ATTRIBUTE_UNUSED) { }
+#endif
+
+static int alloc_mem(long int length, int testcase)
+{
+	char *s;
+	long i, pagesz = getpagesize();
+	int loop = 10;
+
+	tst_res(TINFO, "thread (%lx), allocating %ld bytes.",
+		(unsigned long) pthread_self(), length);
+
+	s = mmap(NULL, length, PROT_READ | PROT_WRITE,
+		 MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
+	if (s == MAP_FAILED)
+		return errno;
+
+	if (testcase == MLOCK) {
+		while (mlock(s, length) == -1 && loop > 0) {
+			if (EAGAIN != errno)
+				return errno;
+			usleep(300000);
+			loop--;
+		}
+	}
+
+#ifdef HAVE_DECL_MADV_MERGEABLE
+	if (testcase == KSM && madvise(s, length, MADV_MERGEABLE) == -1)
+		return errno;
+#endif
+	for (i = 0; i < length; i += pagesz)
+		s[i] = '\a';
+
+	return 0;
+}
+
+static void *child_alloc_thread(void *args)
+{
+	int ret = 0;
+
+	/* keep allocating until there's an error */
+	while (!ret)
+		ret = alloc_mem(LENGTH, (long)args);
+	exit(ret);
+}
+
+static void child_alloc(int testcase, int lite, int threads)
+{
+	int i;
+	pthread_t *th;
+
+	if (lite) {
+		int ret = alloc_mem(TESTMEM * 2 + TST_MB, testcase);
+		exit(ret);
+	}
+
+	th = malloc(sizeof(pthread_t) * threads);
+	if (!th) {
+		tst_res(TINFO | TERRNO, "malloc");
+		goto out;
+	}
+
+	for (i = 0; i < threads; i++) {
+		TEST(pthread_create(&th[i], NULL, child_alloc_thread,
+			(void *)((long)testcase)));
+		if (TST_RET) {
+			tst_res(TINFO | TRERRNO, "pthread_create");
+			/*
+			 * Keep going if thread other than first fails to
+			 * spawn due to lack of resources.
+			 */
+			if (i == 0 || TST_RET != EAGAIN)
+				goto out;
+		}
+	}
+
+	/* wait for one of threads to exit whole process */
+	while (1)
+		sleep(1);
+out:
+	exit(1);
+}
+
+/*
+ * oom - allocates memory according to specified testcase and checks
+ *       desired outcome (e.g. child killed, operation failed with ENOMEM)
+ * @testcase: selects how child allocates memory
+ *            valid choices are: NORMAL, MLOCK and KSM
+ * @lite: if non-zero, child makes only single TESTMEM+TST_MB allocation
+ *        if zero, child keeps allocating memory until it gets killed
+ *        or some operation fails
+ * @retcode: expected return code of child process
+ *           if matches child ret code, this function reports PASS,
+ *           otherwise it reports FAIL
+ * @allow_sigkill: if zero and child is killed, this function reports FAIL
+ *                 if non-zero, then if child is killed by SIGKILL
+ *                 it is considered as PASS
+ */
+static inline void oom(int testcase, int lite, int retcode, int allow_sigkill)
+{
+	pid_t pid;
+	int status, threads;
+
+	tst_enable_oom_protection(0);
+
+	switch (pid = SAFE_FORK()) {
+	case 0:
+		tst_disable_oom_protection(0);
+		threads = MAX(1, tst_ncpus() - 1);
+		child_alloc(testcase, lite, threads);
+	default:
+		break;
+	}
+
+	tst_res(TINFO, "expected victim is %d.", pid);
+	SAFE_WAITPID(-1, &status, 0);
+
+	if (WIFSIGNALED(status)) {
+		if (allow_sigkill && WTERMSIG(status) == SIGKILL) {
+			tst_res(TPASS, "victim signalled: (%d) %s",
+				SIGKILL,
+				tst_strsig(SIGKILL));
+		} else {
+			tst_res(TFAIL, "victim signalled: (%d) %s",
+				WTERMSIG(status),
+				tst_strsig(WTERMSIG(status)));
+		}
+	} else if (WIFEXITED(status)) {
+		if (WEXITSTATUS(status) == retcode) {
+			tst_res(TPASS, "victim retcode: (%d) %s",
+				retcode, strerror(retcode));
+		} else {
+			tst_res(TFAIL, "victim unexpectedly ended with "
+				"retcode: %d, expected: %d",
+				WEXITSTATUS(status), retcode);
+		}
+	} else {
+		tst_res(TFAIL, "victim unexpectedly ended");
+	}
+}
+
+static inline void testoom(int mempolicy, int lite, int retcode, int allow_sigkill)
+{
+	int ksm_run_orig;
+
+	set_global_mempolicy(mempolicy);
+
+	tst_res(TINFO, "start normal OOM testing.");
+	oom(NORMAL, lite, retcode, allow_sigkill);
+
+	tst_res(TINFO, "start OOM testing for mlocked pages.");
+	oom(MLOCK, lite, retcode, allow_sigkill);
+
+	/*
+	 * Skip oom(KSM) if lite == 1, since limit_in_bytes may vary from
+	 * run to run, which isn't reliable for oom03 cgroup test.
+	 */
+	if (access(PATH_KSM, F_OK) == -1 || lite == 1) {
+		tst_res(TINFO, "KSM is not configed or lite == 1, "
+			 "skip OOM test for KSM pags");
+	} else {
+		tst_res(TINFO, "start OOM testing for KSM pages.");
+		SAFE_FILE_SCANF(PATH_KSM "run", "%d", &ksm_run_orig);
+		SAFE_FILE_PRINTF(PATH_KSM "run", "1");
+		oom(KSM, lite, retcode, allow_sigkill);
+		SAFE_FILE_PRINTF(PATH_KSM "run", "%d", ksm_run_orig);
+	}
+}
+
+#endif /* OOM_H_ */
diff --git a/testcases/kernel/mem/oom/oom01.c b/testcases/kernel/mem/oom/oom01.c
index 4bca37963..1249f0df4 100644
--- a/testcases/kernel/mem/oom/oom01.c
+++ b/testcases/kernel/mem/oom/oom01.c
@@ -16,7 +16,8 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
-#include "mem.h"
+#include "tst_test.h"
+#include "oom.h"
 
 #define OVERCOMMIT_MEMORY "/proc/sys/vm/overcommit_memory"
 
diff --git a/testcases/kernel/mem/oom/oom02.c b/testcases/kernel/mem/oom/oom02.c
index 50b514cb4..6fbb7db7c 100644
--- a/testcases/kernel/mem/oom/oom02.c
+++ b/testcases/kernel/mem/oom/oom02.c
@@ -16,11 +16,12 @@
 #include <fcntl.h>
 #include <stdio.h>
 #if HAVE_NUMA_H
-#include <numa.h>
+# include <numa.h>
 #endif
 
+#include "tst_test.h"
 #include "numa_helper.h"
-#include "mem.h"
+#include "oom.h"
 
 #ifdef HAVE_NUMA_V2
 
diff --git a/testcases/kernel/mem/oom/oom03.c b/testcases/kernel/mem/oom/oom03.c
index 873a6d84c..dde691a2b 100644
--- a/testcases/kernel/mem/oom/oom03.c
+++ b/testcases/kernel/mem/oom/oom03.c
@@ -16,11 +16,12 @@
 #include <fcntl.h>
 #include <stdio.h>
 #if HAVE_NUMA_H
-#include <numa.h>
+# include <numa.h>
 #endif
 
+#include "tst_test.h"
 #include "numa_helper.h"
-#include "mem.h"
+#include "oom.h"
 
 #ifdef HAVE_NUMA_V2
 
@@ -38,12 +39,12 @@ static void verify_oom(void)
 		 *
 		 * To get more opportunities to reach the swap limitation,
 		 * let's scale down the value of 'memory.swap.max' to only
-		 * 1MB for CGroup v2.
+		 * 1TST_MB for CGroup v2.
 		 */
 		if (!TST_CG_VER_IS_V1(tst_cg, "memory"))
-			SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lu", MB);
+			SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lu", TST_MB);
 		else
-			SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lu", TESTMEM + MB);
+			SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lu", TESTMEM + TST_MB);
 
 		testoom(0, 1, ENOMEM, 1);
 
diff --git a/testcases/kernel/mem/oom/oom04.c b/testcases/kernel/mem/oom/oom04.c
index 1edde3676..5e9ea39e1 100644
--- a/testcases/kernel/mem/oom/oom04.c
+++ b/testcases/kernel/mem/oom/oom04.c
@@ -16,11 +16,12 @@
 #include <fcntl.h>
 #include <stdio.h>
 #if HAVE_NUMA_H
-#include <numa.h>
+# include <numa.h>
 #endif
 
+#include "tst_test.h"
 #include "numa_helper.h"
-#include "mem.h"
+#include "oom.h"
 
 #ifdef HAVE_NUMA_V2
 
diff --git a/testcases/kernel/mem/oom/oom05.c b/testcases/kernel/mem/oom/oom05.c
index 851ec652e..69c824a3f 100644
--- a/testcases/kernel/mem/oom/oom05.c
+++ b/testcases/kernel/mem/oom/oom05.c
@@ -16,11 +16,12 @@
 #include <fcntl.h>
 #include <stdio.h>
 #if HAVE_NUMA_H
-#include <numa.h>
+# include <numa.h>
 #endif
 
+#include "tst_test.h"
 #include "numa_helper.h"
-#include "mem.h"
+#include "oom.h"
 
 #ifdef HAVE_NUMA_V2
 
@@ -46,9 +47,9 @@ static void verify_oom(void)
 		tst_res(TINFO, "OOM on CPUSET & MEMCG with "
 				"special memswap limitation:");
 		if (!TST_CG_VER_IS_V1(tst_cg, "memory"))
-			SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lu", MB);
+			SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lu", TST_MB);
 		else
-			SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lu", TESTMEM + MB);
+			SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lu", TESTMEM + TST_MB);
 
 		testoom(0, 1, ENOMEM, 1);
 
-- 
2.45.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
