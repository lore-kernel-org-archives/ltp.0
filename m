Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0040C3ABA8
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 05:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745904477; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=aTF5/7Qk54RLenCb+EV2sXHAdhBY3ty9eGDT4x/txFQ=;
 b=A3tKKZPKgZqurEeDCFJBV2LPElOBxNP8URrxAReotG2vq/vA70YMQhdnr+ZmbjQa0XKpe
 1JxfPJ/UHs0kQhQujC6m4weGpu0oUssv/Ft1hXs8tKSuw1s6/5mQXCEsFzrSARGTpEBs17X
 4BSHQ3S+1QVAbZos9Kqh+F4xe1qzKtg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29B3F3CBBEC
	for <ltp@archiver.kernel.org>; Tue, 29 Apr 2025 07:27:57 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A21133CA658
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 07:27:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 014AA14002B7
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 07:27:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745904452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TPex6vz1MlDYedM9EVUPDP1M2ceMPUPjGxZEhCat4s0=;
 b=ScqAJ0JUvyLnrwEhb4m5y9iMpkZl8pHtgICoIP0lqtou2bgf3dWvKLRCXCDi29VN+mx7uB
 JsBBxIslv5FmZ/UEzkGLD02NsupSV+2LiqTWszVZAOC7j3/4vsHioFaZcP+GbJnByq/kGQ
 xRSR5hpOIfH+nbh8uTklOHjlkJHydu4=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-KOR-euKoORiWgt6_YVFz-Q-1; Tue,
 29 Apr 2025 01:27:30 -0400
X-MC-Unique: KOR-euKoORiWgt6_YVFz-Q-1
X-Mimecast-MFC-AGG-ID: KOR-euKoORiWgt6_YVFz-Q_1745904450
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D53991956087
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 05:27:29 +0000 (UTC)
Received: from dell-per430-17.gsslab.pek2.redhat.com
 (dell-per430-17.gsslab.pek2.redhat.com [10.72.36.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7702D18001D5
 for <ltp@lists.linux.it>; Tue, 29 Apr 2025 05:27:27 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 29 Apr 2025 01:27:23 -0400
Message-ID: <20250429052723.632452-1-chwen@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: e-xxnImrwlcGxB5m1Xqln-Y26k8DwPHmDBG1InZGwqc_1745904450
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] Add tls parameter and flag:CLONE_SETTLS cover for
 clone and clone3 syscall
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
From: chunfuwen via ltp <ltp@lists.linux.it>
Reply-To: chunfuwen <chwen@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

tls parameter and related flag:CLONE_SETTLS are missed in the testing,
so add them into existed test case

Signed-off-by: chunfuwen <chwen@redhat.com>
---
Changes in v4:
- remove riscv and loongarch definition

Changes in v3:
- fix missing head file for x86

Changes in v2:
- create separate files for clone and clone3

---
 testcases/kernel/syscalls/clone/clone10.c   | 167 ++++++++++++++++++++
 testcases/kernel/syscalls/clone3/clone304.c | 167 ++++++++++++++++++++
 2 files changed, 334 insertions(+)
 create mode 100644 testcases/kernel/syscalls/clone/clone10.c
 create mode 100644 testcases/kernel/syscalls/clone3/clone304.c

diff --git a/testcases/kernel/syscalls/clone/clone10.c b/testcases/kernel/syscalls/clone/clone10.c
new file mode 100644
index 000000000..7f2608503
--- /dev/null
+++ b/testcases/kernel/syscalls/clone/clone10.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Red Hat Inc. All Rights Reserved.
+ * Author: Chunfu Wen <chwen@redhat.com>
+ */
+
+/*\
+ * Add tls parameter and flag:CLONE_SETTLS cover for clone
+ */
+
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <stdio.h>
+#include <errno.h>
+#include <sched.h>
+#include <sys/wait.h>
+#if defined(__i386__)
+#include <asm/ldt.h>
+#endif
+
+#include "tst_test.h"
+#include "clone_platform.h"
+#include "lapi/syscalls.h"
+#include "lapi/futex.h"
+
+#define TLS_SIZE 4096
+#define TLS_ALIGN 16
+
+static pid_t ptid, ctid;
+static void *tls_ptr;
+static void *child_stack;
+static struct user_desc *tls_desc;
+
+/* TLS variable to validate in child */
+static __thread int tls_test_var = 12345;
+
+static int test_flags[] = {
+	CLONE_SETTLS,
+	CLONE_PARENT | CLONE_SETTLS,
+	CLONE_CHILD_SETTID | CLONE_SETTLS,
+	CLONE_PARENT_SETTID | CLONE_VM | CLONE_SETTLS,
+	CLONE_THREAD | CLONE_SIGHAND | CLONE_VM | CLONE_CHILD_CLEARTID | CLONE_SETTLS | SIGCHLD,
+	CLONE_VM | CLONE_FS | CLONE_FILES | CLONE_VFORK | CLONE_SIGHAND | CLONE_SETTLS,
+};
+
+static void init_tls(void)
+{
+#if defined(__x86_64__)
+	/* x86-64: tls_ptr is the new %fs base address */
+	tls_ptr = aligned_alloc(TLS_ALIGN, TLS_SIZE);
+	if (!tls_ptr)
+		tst_brk(TBROK | TERRNO, "aligned_alloc for TLS failed");
+	memset(tls_ptr, 0, TLS_SIZE);
+
+#elif defined(__i386__)
+	/* x86 32-bit: TLS is a struct user_desc */
+	tls_desc = SAFE_MALLOC(sizeof(*tls_desc));
+	memset(tls_desc, 0, sizeof(*tls_desc));
+	tls_desc->entry_number = -1;
+	tls_desc->base_addr = (unsigned long)SAFE_MALLOC(TLS_SIZE);
+	tls_desc->limit = TLS_SIZE;
+	tls_desc->seg_32bit = 1;
+	tls_desc->contents = 0;
+	tls_desc->read_exec_only = 0;
+	tls_desc->limit_in_pages = 0;
+	tls_desc->seg_not_present = 0;
+	tls_desc->useable = 1;
+	tls_ptr = tls_desc;
+#elif defined(__aarch64__) || defined(__powerpc64__) || defined(__s390x__)
+	/*
+	 * Other architectures: detect if dedicated TLS register is available.
+	 * You don't manually touch TPIDR_EL0.
+	 * The kernel automatically writes it into the TPIDR_EL0 register for the new thread after clone() succeeds.
+	 */
+	tls_ptr = aligned_alloc(TLS_ALIGN, TLS_SIZE);
+	if (!tls_ptr)
+		tst_brk(TBROK | TERRNO, "aligned_alloc for TLS failed");
+	memset(tls_ptr, 0, TLS_SIZE);
+#else
+	tst_brk(TCONF, "This architecture does not support TLS");
+#endif
+}
+
+static void free_tls(void)
+{
+#if defined(__x86_64__)
+	free(tls_ptr);
+
+#elif defined(__i386__)
+	if (tls_desc) {
+		free((void *)(uintptr_t)tls_desc->base_addr);
+		free(tls_desc);
+	}
+
+#elif defined(__aarch64__) || defined(__powerpc64__) || defined(__s390x__)
+	free(tls_ptr);
+#endif
+}
+
+static void setup(void)
+{
+	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);
+	init_tls();
+}
+
+static void cleanup(void)
+{
+	free(child_stack);
+	free_tls();
+}
+
+static int check_child(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	if (tls_test_var == 12345)
+		tst_res(TPASS, "Child TLS variable has expected value");
+	else
+		tst_res(TFAIL, "Child TLS variable corrupted or not set");
+
+	tst_syscall(__NR_exit, 0);
+	return 0;
+}
+
+static long clone_child(int flags)
+{
+	TEST(ltp_clone7(flags, check_child, NULL, CHILD_STACK_SIZE,
+		child_stack, &ptid, tls_ptr, &ctid));
+
+	if (TST_RET == -1 && TTERRNO == ENOSYS)
+		tst_brk(TCONF, "clone parameters doesn't match");
+
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "clone() failed");
+
+	return TST_RET;
+}
+
+static void verify_tls(unsigned int i)
+{
+	pid_t child;
+	ctid = -1;
+	struct timespec timeout = { 5 /* sec */, 0 };
+	child = SAFE_FORK();
+	if (!child) {
+		tst_syscall(__NR_getpid);
+		clone_child(test_flags[i]);
+		if (test_flags[i] & CLONE_THREAD) {
+			if (syscall(SYS_futex, &ctid, FUTEX_WAIT, -1, &timeout)) {
+				if (errno != EWOULDBLOCK || ctid == -1) {
+					tst_res(TFAIL | TERRNO,
+						"futex failed, ctid: %d", ctid);
+					exit(0);
+				}
+			}
+		}
+		exit(0);
+	}
+	sleep(1);
+	tst_reap_children();
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(test_flags),
+	.test = verify_tls,
+	.setup = setup,
+	.cleanup = cleanup,
+	.forks_child = 1
+};
diff --git a/testcases/kernel/syscalls/clone3/clone304.c b/testcases/kernel/syscalls/clone3/clone304.c
new file mode 100644
index 000000000..f46d48e34
--- /dev/null
+++ b/testcases/kernel/syscalls/clone3/clone304.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Red Hat Inc. All Rights Reserved.
+ * Author: Chunfu Wen <chwen@redhat.com>
+ */
+
+/*\
+ * Add tls parameter and flag:CLONE_SETTLS cover for clone3
+ */
+
+#define _GNU_SOURCE
+
+#include <stdlib.h>
+#include <sys/wait.h>
+#if defined(__i386__)
+#include <asm/ldt.h>
+#endif
+
+#include "tst_test.h"
+#include "lapi/sched.h"
+#include "lapi/pidfd.h"
+
+#define TLS_SIZE 4096
+#define TLS_ALIGN 16
+
+static int pidfd, child_tid, parent_tid;
+static struct clone_args *args;
+static void *tls_ptr;
+static struct user_desc *tls_desc;
+
+/* TLS variable to validate in child */
+static __thread int tls_test_var = 54321;
+
+static int test_flags[] = {
+	CLONE_FS | CLONE_SETTLS,
+	CLONE_NEWPID | CLONE_SETTLS,
+};
+
+static void *allocate_tls_region(void)
+{
+	void *tls_area = aligned_alloc(TLS_ALIGN, TLS_SIZE);
+	if (!tls_area) {
+		perror("aligned_alloc");
+		exit(EXIT_FAILURE);
+	}
+	memset(tls_area, 0, TLS_SIZE);
+	return tls_area;
+}
+
+static void initialize_tls(void)
+{
+#if defined(__x86_64__)
+	/* x86-64: tls_ptr is the new %fs base address */
+	tls_ptr = aligned_alloc(TLS_ALIGN, TLS_SIZE);
+	if (!tls_ptr)
+		tst_brk(TBROK | TERRNO, "aligned_alloc for TLS failed");
+	memset(tls_ptr, 0, TLS_SIZE);
+
+#elif defined(__i386__)
+	/* x86 32-bit: TLS is a struct user_desc */
+	tls_desc = SAFE_MALLOC(sizeof(*tls_desc));
+	memset(tls_desc, 0, sizeof(*tls_desc));
+	tls_desc->entry_number = -1;
+	tls_desc->base_addr = (unsigned long)SAFE_MALLOC(TLS_SIZE);
+	tls_desc->limit = TLS_SIZE;
+	tls_desc->seg_32bit = 1;
+	tls_desc->contents = 0;
+	tls_desc->read_exec_only = 0;
+	tls_desc->limit_in_pages = 0;
+	tls_desc->seg_not_present = 0;
+	tls_desc->useable = 1;
+
+	tls_ptr = tls_desc;
+#elif defined(__aarch64__) || defined(__powerpc64__) || defined(__s390x__)
+	/*
+	 * Other architectures: detect if dedicated TLS register is available.
+	 * You don't manually touch TPIDR_EL0.
+	 * The kernel automatically writes it into the TPIDR_EL0 register for the new thread after clone() succeeds.
+	 */
+	tls_ptr = aligned_alloc(TLS_ALIGN, TLS_SIZE);
+	if (!tls_ptr)
+		tst_brk(TBROK | TERRNO, "aligned_alloc for TLS failed");
+	memset(tls_ptr, 0, TLS_SIZE);
+#else
+	tst_brk(TCONF, "This architecture does not support TLS");
+#endif
+}
+
+static void free_tls(void)
+{
+#if defined(__x86_64__)
+	free(tls_ptr);
+
+#elif defined(__i386__)
+	if (tls_desc) {
+		free((void *)(uintptr_t)tls_desc->base_addr);
+		free(tls_desc);
+	}
+
+#elif defined(__aarch64__) || defined(__powerpc64__) || defined(__s390x__)
+	free(tls_ptr);
+#endif
+}
+
+static void do_child(void)
+{
+	/* Validate TLS usage */
+	if (tls_test_var == 54321) {
+		tst_res(TPASS, "Child TLS variable has expected value");
+	} else {
+		tst_res(TFAIL, "Child TLS variable corrupted or not set");
+	}
+	exit(0);
+}
+
+static void run(unsigned int n)
+{
+	int status;
+	pid_t pid;
+
+	void *tls_ptr = allocate_tls_region();
+
+	args->flags = test_flags[n];
+	args->pidfd = (uint64_t)(&pidfd);
+	args->child_tid = (uint64_t)(&child_tid);
+	args->parent_tid = (uint64_t)(&parent_tid);
+	args->stack = 0;
+	args->stack_size = 0;
+	args->tls = (uint64_t)tls_ptr;
+
+	TEST(pid = clone3(args, sizeof(*args)));
+	if (pid < 0) {
+		tst_res(TFAIL | TTERRNO, "clone3() failed (%d)", n);
+		free(tls_ptr);
+		return;
+	}
+
+	if (!pid)
+		do_child();
+
+	SAFE_WAITPID(pid, &status, __WALL);
+	free(tls_ptr);
+}
+
+static void setup(void)
+{
+	clone3_supported_by_kernel();
+	initialize_tls();
+}
+
+static void cleanup(void)
+{
+	free_tls();
+}
+
+static struct tst_test test = {
+	.tcnt = ARRAY_SIZE(test_flags),
+	.test = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_checkpoints = 1,
+	.bufs = (struct tst_buffers []) {
+		{&args, .size = sizeof(*args)},
+		{},
+	}
+};
-- 
2.43.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
