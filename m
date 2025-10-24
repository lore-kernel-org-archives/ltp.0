Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BAB6CCD1BF
	for <ltp@archiver.kernel.org>; Fri, 24 Oct 2025 02:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1761274772; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=tCwWFFBiDRUL9AaZeYE42j+ml/aExggDRqnyQVj+2vA=;
 b=MqLeQkPLv+SWsOWiam9lijEL/ZSiUfZzoQ4mLwscMTxqxitlwt/ZsKZUtwFcIIFnWYY7P
 ezyOK0e9/TdoIUkewk+jd8TdaNLnLmyHi4tSFsnePr3rU1V24R1c4gqi7gmn7w0HvDTcg3p
 S0BCgwf8nf1+srQeMQEgSRKUktA7FWc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3738D3CF29E
	for <ltp@archiver.kernel.org>; Fri, 24 Oct 2025 04:59:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAE823CE054
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 04:59:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CDFEE1A001B7
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 04:59:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761274748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qEs6eCQd5ZZVMTHOcW8LLQReImBRudNnRcAA9k3lrMQ=;
 b=Ip2vEQSgpjHZn6kGn5Dx5LcCPbYV1t0G29nuvwg21P+3tzxDPocNLlE/OtpBOecleyCPOu
 7peFrm/dKgkYx4bpsZcnFeI5pUxjELl86Jd54WpraGsA+vkEPlSBgpQatFbfFEBpni7WSX
 9yBXO+baAKFOpUzPAI9cg2trqXD65Sw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-kzY388OAMgqPmG7iOh7vXQ-1; Thu,
 23 Oct 2025 22:59:06 -0400
X-MC-Unique: kzY388OAMgqPmG7iOh7vXQ-1
X-Mimecast-MFC-AGG-ID: kzY388OAMgqPmG7iOh7vXQ_1761274745
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42C6D1954210
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 02:59:05 +0000 (UTC)
Received: from chunfulap.redhat.com (unknown [10.72.112.180])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBADA19540EB
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 02:59:03 +0000 (UTC)
To: ltp@lists.linux.it
Date: Fri, 24 Oct 2025 10:58:58 +0800
Message-ID: <20251024025858.523028-1-chwen@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: unbzfd1beb3lljYr3_zr8OKmpl0Qbik2Wi2eTAJAgBs_1761274745
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v15] Add tls parameter and flag:CLONE_SETTLS cover for
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
 include/lapi/tls.h                          | 102 ++++++++++++++++++
 runtest/syscalls                            |   2 +
 testcases/kernel/syscalls/clone/.gitignore  |   1 +
 testcases/kernel/syscalls/clone/clone10.c   | 100 ++++++++++++++++++
 testcases/kernel/syscalls/clone3/.gitignore |   1 +
 testcases/kernel/syscalls/clone3/clone304.c | 110 ++++++++++++++++++++
 6 files changed, 316 insertions(+)
 create mode 100644 include/lapi/tls.h
 create mode 100644 testcases/kernel/syscalls/clone/clone10.c
 create mode 100644 testcases/kernel/syscalls/clone3/clone304.c

diff --git a/include/lapi/tls.h b/include/lapi/tls.h
new file mode 100644
index 000000000..801e765a3
--- /dev/null
+++ b/include/lapi/tls.h
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Red Hat Inc. All Rights Reserved.
+ * Author: Chunfu Wen <chwen@redhat.com>
+ */
+
+/*\
+ * tls init/alloc/free common functions
+ */
+
+#ifndef _LAPI_TLS_H
+#define _LAPI_TLS_H
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
+// Structure mimicking glibc's TCB to be simplified for x86_64
+typedef struct {
+    void *tcb;
+    void *dtv;
+    void *self;
+    int multiple_threads;
+    char padding[64];
+} tcb_t;
+#endif
+
+// Global pointers for TLS management
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
+	// Set up a minimal TCB for x86_64
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
+	usleep(1000);
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
+#endif // _LAPI_TLS_H
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
diff --git a/testcases/kernel/syscalls/clone/clone10.c b/testcases/kernel/syscalls/clone/clone10.c
new file mode 100644
index 000000000..fa5928459
--- /dev/null
+++ b/testcases/kernel/syscalls/clone/clone10.c
@@ -0,0 +1,100 @@
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
+// Global pointers for TLS management
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
+	// Set the %fs register to point to the TCB
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
index 000000000..7cfc81ad0
--- /dev/null
+++ b/testcases/kernel/syscalls/clone3/clone304.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2025 Red Hat Inc. All Rights Reserved.
+ * Author: Chunfu Wen <chwen@redhat.com>
+ */
+
+/*\
+ * Test that in a thread started by clone3() that runs in the same address
+ * space (CLONE_VM) but with a different TLS (CLONE_SETTLS) writtes to a
+ * thread local variables are not propagated back from the cloned thread.
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
+#include "lapi/tls.h"
+
+#define TLS_EXP 100
+
+#define CHILD_STACK_SIZE (1024*1024)
+
+// Global pointers for TLS management
+void *tls_ptr;
+struct user_desc *tls_desc;
+
+static int pidfd, child_tid, parent_tid;
+static struct clone_args *args;
+static void *child_stack;
+
+/* TLS variable to validate in child */
+static __thread int tls_var;
+
+static int test_flags = CLONE_VM | CLONE_FS | CLONE_FILES | CLONE_SIGHAND | CLONE_SETTLS;
+
+static int check_tls_in_child(void)
+{
+	tls_var = TLS_EXP + 1;
+	tst_res(TINFO, "Child (PID: %d, TID: %d): TLS value set to: %d", getpid(),  gettid(), tls_var);
+
+	free_tls();
+	tst_syscall(__NR_exit, 0);
+	return 0;
+}
+
+static void run(void)
+{
+	pid_t pid;
+
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
+	waitpid(pid, NULL, 0);
+
+	if (tls_var == TLS_EXP) {
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
+	init_tls();
+}
+
+static void cleanup(void)
+{
+	free(child_stack);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_checkpoints = 1,
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
