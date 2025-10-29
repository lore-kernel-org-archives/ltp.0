Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EC9CCF9E9
	for <ltp@archiver.kernel.org>; Wed, 29 Oct 2025 06:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1761718322; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=CgdPjhF96ZKOq8ydH2g0fz6q8gN/Yrv6KHOxBkppDo8=;
 b=dkp3y0K7rHzfgVV2Rp21CLXmhIilxBVUtNVkPi+/Nz4d8Gea8DOR4lzHFQdEY0ET1zcX5
 unmpLTlQS0utdtrOp6u8OYciWW7B1uTCV0ncPqKT+XRR2OZDAAit/lGu3D0FUt3OnfPdBot
 3+eLNZX2XsZy0ZulGlatB3O67bE+/tQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 652F23CA72C
	for <ltp@archiver.kernel.org>; Wed, 29 Oct 2025 07:12:02 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DFCD3C85F2
 for <ltp@lists.linux.it>; Wed, 29 Oct 2025 07:11:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 01FE02009F2
 for <ltp@lists.linux.it>; Wed, 29 Oct 2025 07:11:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761718299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gv/d3jjT1NpiSmRgPq0i3XhGqlMEn0FIXd58tMQk4Mc=;
 b=YTxMbRe3KNccM/M+03ROHOx8IOgiKyaClFDtzP91UkxEjRgSYUaFhzXbRwxAW4Qv2vuKEO
 KxBoveUny628KaGe1TanQTgksTDqq82AvOe79BdC3xiUAEGcPxHay6olOPcbsU/8cksx8q
 KjbUZs9hkc56yi8lrSRngnGzLY7YdAY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-gtbGJ-NQM4uH8dlWYyG6rg-1; Wed,
 29 Oct 2025 02:11:36 -0400
X-MC-Unique: gtbGJ-NQM4uH8dlWYyG6rg-1
X-Mimecast-MFC-AGG-ID: gtbGJ-NQM4uH8dlWYyG6rg_1761718295
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 773801956095
 for <ltp@lists.linux.it>; Wed, 29 Oct 2025 06:11:35 +0000 (UTC)
Received: from dell-per430-17.gsslab.pek2.redhat.com
 (dell-per430-17.gsslab.pek2.redhat.com [10.72.36.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 58B191800579
 for <ltp@lists.linux.it>; Wed, 29 Oct 2025 06:11:33 +0000 (UTC)
To: ltp@lists.linux.it
Date: Wed, 29 Oct 2025 02:11:29 -0400
Message-ID: <20251029061129.3307836-1-chwen@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RT0ASXQ4QS4UWNj2LbSI9zZANWOdcu76Jx9DIboxOzQ_1761718295
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v17] Add tls parameter and flag:CLONE_SETTLS cover for
 clone syscall
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
Changes in v17:
- Remove comment lines as per reviewer's suggestion
- Extend usleep to longer value
- Remove clone304.c as seperate patch submission

Changes in v16:
- Fix clone304.c compiling issue due to older gcc in both opensuse/archive:42.2 and ubuntu:bionic

Changes in v15:
- Fix clone10.c compiling issue due to older gcc in both opensuse/archive:42.2 and ubuntu:bionic

Changes in v14:
- Fix clone304 occasional failure on Fedora x86_64 by removing CLONE_THREAD since threads created with CLONE_THREAD are in the same thre
ad group as the caller

Changes in v13:
- Fix clone304 failure on Fedora x86_64 by moving free_tls() into check_tls_in_child method

Changes in v12:
- Fix make check reporting errors and warnings
- Add the __NR_exit

Changes in v11:
- Put the tls init/alloc/free functions into a common header in lapi/tls.h
- Use TST_CHECKPOINT_* for parent/child synchronization

Changes in v10:
- Fix fedora42 failure by adding tcb
- Add missing usleep(1000) in free_tls

Changes in v9:
- allow small delay by using usleep before call free_tls
- validate ./clone10 -i 10 on aarch64 and x86_64, both pass

Changes in v8:
- call free_tls() in touch_tls_in_child instead of cleanup
- remove CFLAGS += -fsanitize=address in Makefile to fix memory double free
  issue

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
 include/lapi/tls.h                         | 99 ++++++++++++++++++++++
 runtest/syscalls                           |  1 +
 testcases/kernel/syscalls/clone/.gitignore |  1 +
 testcases/kernel/syscalls/clone/clone10.c  | 98 +++++++++++++++++++++
 4 files changed, 199 insertions(+)
 create mode 100644 include/lapi/tls.h
 create mode 100644 testcases/kernel/syscalls/clone/clone10.c

diff --git a/include/lapi/tls.h b/include/lapi/tls.h
new file mode 100644
index 000000000..93a247001
--- /dev/null
+++ b/include/lapi/tls.h
@@ -0,0 +1,99 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Red Hat Inc. All Rights Reserved.
+ * Author: Chunfu Wen <chwen@redhat.com>
+ */
+
+/*\
+ * CLONE_SETTLS init/alloc/free common functions
+ */
+
+#ifndef LAPI_TLS_H__
+#define LAPI_TLS_H__
+
+#include <stdlib.h>
+#include <string.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <unistd.h>
+
+#if defined(__i386__)
+#include <asm/ldt.h>
+#endif
+
+#include "tst_test.h"
+
+#define TLS_SIZE 4096
+#define TLS_ALIGN 16
+
+#if defined(__x86_64__)
+typedef struct {
+	void *tcb;
+	void *dtv;
+	void *self;
+	int multiple_threads;
+	char padding[64];
+} tcb_t;
+#endif
+
+extern void *tls_ptr;
+extern struct user_desc *tls_desc;
+
+static inline void *allocate_tls_area(void)
+{
+	void *tls_area = aligned_alloc(TLS_ALIGN, TLS_SIZE);
+	if (!tls_area)
+	        tst_brk(TBROK | TERRNO, "aligned_alloc failed");
+	memset(tls_area, 0, TLS_SIZE);
+
+#if defined(__x86_64__)
+	tcb_t *tcb = (tcb_t *)tls_area;
+	tcb->tcb = tls_area;
+	tcb->self = tls_area;
+	tcb->multiple_threads = 1;
+#endif
+	return tls_area;
+}
+
+static inline void init_tls(void)
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
+static inline void free_tls(void)
+{
+	usleep(10000);
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
+#endif /* LAPI_TLS_H__ */
diff --git a/runtest/syscalls b/runtest/syscalls
index 844ae7a13..476b4ff17 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -122,6 +122,7 @@ clone06 clone06
 clone07 clone07
 clone08 clone08
 clone09 clone09
+clone10 clone10
 
 clone301 clone301
 clone302 clone302
diff --git a/testcases/kernel/syscalls/clone/.gitignore b/testcases/kernel/syscalls/clone/.gitignore
index 900cac19c..adfb8257d 100644
--- a/testcases/kernel/syscalls/clone/.gitignore
+++ b/testcases/kernel/syscalls/clone/.gitignore
@@ -7,3 +7,4 @@
 /clone07
 /clone08
 /clone09
+/clone10
diff --git a/testcases/kernel/syscalls/clone/clone10.c b/testcases/kernel/syscalls/clone/clone10.c
new file mode 100644
index 000000000..fdba79a43
--- /dev/null
+++ b/testcases/kernel/syscalls/clone/clone10.c
@@ -0,0 +1,98 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Red Hat Inc. All Rights Reserved.
+ * Author: Chunfu Wen <chwen@redhat.com>
+ */
+
+/*\
+ * Test that in a thread started by clone() that runs in the same address
+ * space (CLONE_VM) but with a different TLS (CLONE_SETTLS) writtes to a
+ * thread local variables are not propagated back from the cloned thread.
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
+#include "lapi/tls.h"
+
+#define TLS_EXP 100
+
+#ifndef ARCH_SET_FS
+#define ARCH_SET_FS 0x1002
+#endif
+
+void *tls_ptr;
+struct user_desc *tls_desc;
+
+static __thread int tls_var;
+
+static char *child_stack;
+static volatile int child_done;
+
+static int flags = CLONE_THREAD |  CLONE_VM | CLONE_FS | CLONE_FILES | CLONE_SIGHAND | CLONE_SETTLS;
+
+static int touch_tls_in_child(void *arg LTP_ATTRIBUTE_UNUSED)
+{
+#if defined(__x86_64__)
+	if (syscall(SYS_arch_prctl, ARCH_SET_FS, tls_ptr) == -1)
+		exit(EXIT_FAILURE);
+#endif
+	tls_var = TLS_EXP + 1;
+	tst_res(TINFO, "Child (PID: %d, TID: %d): TLS value set to: %d", getpid(), (pid_t)syscall(SYS_gettid), tls_var);
+
+	TST_CHECKPOINT_WAKE(0);
+	free_tls();
+	tst_syscall(__NR_exit, 0);
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
+	TST_CHECKPOINT_WAIT(0);
+
+	if (tls_var == TLS_EXP) {
+		tst_res(TPASS,
+			"Parent (PID: %d, TID: %d): TLS value correct: %d",
+			getpid(), (pid_t)syscall(SYS_gettid), tls_var);
+	} else {
+		tst_res(TFAIL,
+			"Parent (PID: %d, TID: %d): TLS value mismatch: got %d, expected %d",
+			getpid(), (pid_t)syscall(SYS_gettid), tls_var, TLS_EXP);
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
+}
+
+static struct tst_test test = {
+	    .setup = setup,
+	    .cleanup = cleanup,
+	    .needs_checkpoints = 1,
+	    .test_all = verify_tls,
+};
-- 
2.43.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
