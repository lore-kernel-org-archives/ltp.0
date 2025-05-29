Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAF2C5AD49
	for <ltp@archiver.kernel.org>; Thu, 29 May 2025 09:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748510580; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=KvHvDhDCi0fOREc9MHPwbxc/U10Yd43yo5SuMzgMtLs=;
 b=oabAaf5eeqXYazWiZWbVUHGnR70RoYZjgbOqEGVTOfwUoXka63n+yMgHmMWeQ7iisv1zY
 CcNLy+3lYBr1y9ZTBks9Ww/E+En3yJLdSJuP8FiUZ6gUFwpfqycgP2qqxMDfndLFq8wtbEr
 YMChIjxMRqLC/TKD4vO2g7n/0BOg/F4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFE0E3C7C3C
	for <ltp@archiver.kernel.org>; Thu, 29 May 2025 11:23:00 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E70B13C6691
 for <ltp@lists.linux.it>; Thu, 29 May 2025 11:22:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F41521401134
 for <ltp@lists.linux.it>; Thu, 29 May 2025 11:22:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748510556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uMXyl5CLFly/K7jL/b8vzjA5Ok7UH2qfgsJul6H3Gzk=;
 b=QhkeocG8idmfhDGoRWr0uIEMggEuoN0az/FJCrcRHTVfNxoWYMtC3+UNGfpxNJ1iQiKv36
 KQ3cV/Du/uAw5Zyv06aulLgar899FXpuT8fVkWPQ82jNpYUDlo1UV6oYtjQoadAFxkDute
 ogCRZJ7TB7H40dtQR0d35BPGtkt9ouU=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-c4Yv2vtPOj2s3LHVQV7Vig-1; Thu,
 29 May 2025 05:22:34 -0400
X-MC-Unique: c4Yv2vtPOj2s3LHVQV7Vig-1
X-Mimecast-MFC-AGG-ID: c4Yv2vtPOj2s3LHVQV7Vig_1748510553
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CC4B180045B
 for <ltp@lists.linux.it>; Thu, 29 May 2025 09:22:33 +0000 (UTC)
Received: from dell-per430-17.gsslab.pek2.redhat.com
 (dell-per430-17.gsslab.pek2.redhat.com [10.72.36.28])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F1C111954185
 for <ltp@lists.linux.it>; Thu, 29 May 2025 09:22:31 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 29 May 2025 05:22:26 -0400
Message-ID: <20250529092226.1719843-1-chwen@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4PpPqnR8QPu3m_paRDFmRRgbXiCN7pQU7oorRJS26LM_1748510553
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7] Add tls parameter and flag:CLONE_SETTLS cover for
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
Changes in v7:
- remove unnecessary in verify_tls()
- add CFLAGS += -fsanitize=address in Makefile to fix memory double free
  issue

Changes in v6:
- update flag to effective combination
- combine x86_64 with other arches
- rename child function
- remove inproper exit
- remove unused code lines
- remove sleep statement

Changes in v5:
- wrap duplicate code into one single methold
- remove duplicately malloc

Changes in v4:
- remove riscv and loongarch definition

Changes in v3:
- fix missing head file for x86

Changes in v2:
- create separate files for clone and clone3

---
 runtest/syscalls                            |   2 +
 testcases/kernel/syscalls/clone/.gitignore  |   1 +
 testcases/kernel/syscalls/clone/Makefile    |   2 +
 testcases/kernel/syscalls/clone/clone10.c   | 137 +++++++++++++++++
 testcases/kernel/syscalls/clone3/.gitignore |   1 +
 testcases/kernel/syscalls/clone3/clone304.c | 158 ++++++++++++++++++++
 6 files changed, 301 insertions(+)
 create mode 100644 testcases/kernel/syscalls/clone/clone10.c
 create mode 100644 testcases/kernel/syscalls/clone3/clone304.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 844ae7a13..10f64270a 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -122,10 +122,12 @@ clone06 clone06
 clone07 clone07
 clone08 clone08
 clone09 clone09
+clone10 clone10
 
 clone301 clone301
 clone302 clone302
 clone303 clone303
+clone304 clone304
 
 close01 close01
 close02 close02
diff --git a/testcases/kernel/syscalls/clone/.gitignore b/testcases/kernel/syscalls/clone/.gitignore
index 900cac19c..adfb8257d 100644
--- a/testcases/kernel/syscalls/clone/.gitignore
+++ b/testcases/kernel/syscalls/clone/.gitignore
@@ -7,3 +7,4 @@
 /clone07
 /clone08
 /clone09
+/clone10
diff --git a/testcases/kernel/syscalls/clone/Makefile b/testcases/kernel/syscalls/clone/Makefile
index 1957711b0..5467eb532 100644
--- a/testcases/kernel/syscalls/clone/Makefile
+++ b/testcases/kernel/syscalls/clone/Makefile
@@ -7,4 +7,6 @@ include $(top_srcdir)/include/mk/testcases.mk
 
 CFLAGS += -Wl,-z,now
 
+CFLAGS += -fsanitize=address
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/clone/clone10.c b/testcases/kernel/syscalls/clone/clone10.c
new file mode 100644
index 000000000..3d4951993
--- /dev/null
+++ b/testcases/kernel/syscalls/clone/clone10.c
@@ -0,0 +1,137 @@
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
+
+#if defined(__i386__)
+#include <asm/ldt.h>
+#endif
+
+#include "tst_test.h"
+#include "clone_platform.h"
+#include "lapi/syscalls.h"
+
+#define TLS_EXP 100
+#define TLS_SIZE 4096
+#define TLS_ALIGN 16
+
+static __thread int tls_var = 0;
+
+static void *tls_ptr;
+static struct user_desc *tls_desc;
+static char *child_stack;
+static volatile int child_done = 0;
+
+static int flags = CLONE_THREAD |  CLONE_VM | CLONE_FS | CLONE_FILES | CLONE_SIGHAND | CLONE_SETTLS;
+
+static void *allocate_tls_area(void)
+{
+	void *tls_area = aligned_alloc(TLS_ALIGN, TLS_SIZE);
+	if (!tls_area)
+		tst_brk(TBROK | TERRNO, "aligned_alloc failed");
+	memset(tls_area, 0, TLS_SIZE);
+
+	return tls_area;
+}
+
+static void init_tls(void)
+{
+#if defined(__x86_64__) || defined(__aarch64__) || defined(__s390x__)
+	tls_ptr = allocate_tls_area();
+
+#elif defined(__i386__)
+	tls_ptr = allocate_tls_area();
+	tls_desc = SAFE_MALLOC(sizeof(*tls_desc));
+	memset(tls_desc, 0, sizeof(*tls_desc));
+	tls_desc->entry_number = -1;
+	tls_desc->base_addr = (unsigned long)tls_ptr;
+	tls_desc->limit = TLS_SIZE;
+	tls_desc->seg_32bit = 1;
+	tls_desc->contents = 0;
+	tls_desc->read_exec_only = 0;
+	tls_desc->limit_in_pages = 0;
+	tls_desc->seg_not_present = 0;
+	tls_desc->useable = 1;
+
+#else
+	tst_brk(TCONF, "Unsupported architecture for TLS");
+#endif
+}
+
+static void free_tls(void)
+{
+#if defined(__x86_64__) || defined(__aarch64__) || defined(__s390x__)
+	if (tls_ptr) {
+		free(tls_ptr);
+		tls_ptr = NULL;
+	}
+#elif defined(__i386__)
+	if (tls_desc) {
+		free((void *)(uintptr_t)tls_desc->base_addr);
+		free(tls_desc);
+		tls_desc = NULL;
+	}
+#endif
+}
+
+static int touch_tls_in_child(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+	tls_var = TLS_EXP + 1;
+	tst_res(TINFO, "Child (PID: %d, TID: %d): TLS value set to: %d", getpid(),  gettid(), tls_var);
+
+	child_done = 1;
+	return 0;
+}
+
+static void verify_tls(void)
+{
+	tls_var = TLS_EXP;
+
+	TEST(ltp_clone7(flags, touch_tls_in_child, NULL, CHILD_STACK_SIZE, child_stack, NULL, tls_ptr, NULL));
+
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "clone() failed");
+
+	while (!child_done)
+		sched_yield();
+
+	if (TLS_EXP == tls_var) {
+		tst_res(TPASS,
+			"Parent (PID: %d, TID: %d): TLS value correct: %d",
+			getpid(), gettid(), tls_var);
+	} else {
+		tst_res(TFAIL,
+			"Parent (PID: %d, TID: %d): TLS value mismatch: got %d, expected %d",
+			getpid(), gettid(), tls_var, TLS_EXP);
+	}
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
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = verify_tls,
+};
diff --git a/testcases/kernel/syscalls/clone3/.gitignore b/testcases/kernel/syscalls/clone3/.gitignore
index 10369954b..e9b5312f4 100644
--- a/testcases/kernel/syscalls/clone3/.gitignore
+++ b/testcases/kernel/syscalls/clone3/.gitignore
@@ -1,3 +1,4 @@
 clone301
 clone302
 clone303
+clone304
diff --git a/testcases/kernel/syscalls/clone3/clone304.c b/testcases/kernel/syscalls/clone3/clone304.c
new file mode 100644
index 000000000..c0e815d28
--- /dev/null
+++ b/testcases/kernel/syscalls/clone3/clone304.c
@@ -0,0 +1,158 @@
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
+
+#if defined(__i386__)
+#include <asm/ldt.h>
+#endif
+
+#include "tst_test.h"
+#include "lapi/sched.h"
+#include "lapi/pidfd.h"
+
+#define TLS_EXP 100
+#define TLS_SIZE 4096
+#define TLS_ALIGN 16
+#define CHILD_STACK_SIZE (1024*1024)
+
+static int pidfd, child_tid, parent_tid;
+static struct clone_args *args;
+static void *tls_ptr;
+static struct user_desc *tls_desc;
+static void *child_stack;
+
+static volatile int child_done = 0;
+/* TLS variable to validate in child */
+static __thread int tls_var = 0;
+
+static int test_flags = CLONE_THREAD |  CLONE_VM | CLONE_FS | CLONE_FILES | CLONE_SIGHAND | CLONE_SETTLS;
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
+#if defined(__x86_64__) || defined(__aarch64__) || defined(__s390x__)
+	tls_ptr = allocate_tls_region();
+
+#elif defined(__i386__)
+	/* x86 32-bit: TLS is a struct user_desc */
+	tls_ptr = allocate_tls_region();
+	tls_desc = SAFE_MALLOC(sizeof(*tls_desc));
+	memset(tls_desc, 0, sizeof(*tls_desc));
+	tls_desc->entry_number = -1;
+	tls_desc->base_addr = (unsigned long)tls_ptr;
+	tls_desc->limit = TLS_SIZE;
+	tls_desc->seg_32bit = 1;
+	tls_desc->contents = 0;
+	tls_desc->read_exec_only = 0;
+	tls_desc->limit_in_pages = 0;
+	tls_desc->seg_not_present = 0;
+	tls_desc->useable = 1;
+
+#else
+	tst_brk(TCONF, "This architecture does not support TLS");
+#endif
+}
+
+static void free_tls(void)
+{
+#if defined(__x86_64__) || defined(__aarch64__) || defined(__s390x__)
+	if (tls_ptr) {
+		free(tls_ptr);
+	}
+#elif defined(__i386__)
+	if (tls_desc) {
+		free((void *)(uintptr_t)tls_desc->base_addr);
+		free(tls_desc);
+	}
+#endif
+}
+
+static int check_tls_in_child(void)
+{
+	tls_var = TLS_EXP + 1;
+	tst_res(TINFO, "Child (PID: %d, TID: %d): TLS value set to: %d", getpid(),  gettid(), tls_var);
+
+	child_done = 1;
+	tst_syscall(__NR_exit, 0);
+	return 0;
+}
+
+static void run(void)
+{
+	pid_t pid;
+	int status;
+	tls_var = TLS_EXP;
+
+	args->flags = test_flags;
+	args->pidfd = (uint64_t)(&pidfd);
+	args->child_tid = (uint64_t)(&child_tid);
+	args->parent_tid = (uint64_t)(&parent_tid);
+	args->stack = (uint64_t)(child_stack);
+	args->stack_size = CHILD_STACK_SIZE;
+	args->tls = (uint64_t)tls_ptr;
+
+	TEST(pid = clone3(args, sizeof(*args)));
+
+	if (TST_RET == -1)
+		tst_brk(TBROK | TTERRNO, "clone() failed");
+
+	if (!pid)
+		check_tls_in_child();
+
+	while (!child_done)
+		sched_yield();
+
+	if (TLS_EXP == tls_var) {
+		tst_res(TPASS,
+			"Parent (PID: %d, TID: %d): TLS value correct: %d",
+			getpid(), gettid(), tls_var);
+	} else {
+		tst_res(TFAIL,
+			"Parent (PID: %d, TID: %d): TLS value mismatch: got %d, expected %d",
+			getpid(), gettid(), tls_var, TLS_EXP);
+	}
+}
+
+static void setup(void)
+{
+	clone3_supported_by_kernel();
+	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);
+	initialize_tls();
+}
+
+static void cleanup(void)
+{
+	free(child_stack);
+	free_tls();
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.bufs = (struct tst_buffers []) {
+		{&args, .size = sizeof(*args)},
+		{},
+	}
+};
-- 
2.43.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
