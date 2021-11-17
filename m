Return-Path: <SRS0=ZNpR=QE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D59BC433EF
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 07:07:52 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B800C61BE5
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 07:07:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B800C61BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7AB253C87DC
	for <ltp@archiver.kernel.org>; Wed, 17 Nov 2021 08:07:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 449A53C87D3
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 08:07:38 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4851D601CD7
 for <ltp@lists.linux.it>; Wed, 17 Nov 2021 08:07:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637132848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gD0yNUerdxID5vn9PFToQv6M0ws45AaJrSXsRUlOML8=;
 b=eWwUMtKPDi0QHnPxx4jFkpAeNEjO/k2EXZSiILyb5UgsRr0jGxtMRDITjLnnkNvMgmWO//
 ydqQ+3/4QHDfqNr2XDcvcSEcnZDgWJJ43xQLT4bXNyODmiUURd97mC9npyXoosPMhrL8ZF
 uIAeHC42+h9xNeundneOfp7zXWuB2NY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-125-XfVsw7-pPUa9EBS92p2x6g-1; Wed, 17 Nov 2021 02:07:14 -0500
X-MC-Unique: XfVsw7-pPUa9EBS92p2x6g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C321B87122E;
 Wed, 17 Nov 2021 07:07:12 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AFE775F4E0;
 Wed, 17 Nov 2021 07:07:11 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 17 Nov 2021 15:07:07 +0800
Message-Id: <20211117070708.2174932-2-liwang@redhat.com>
In-Reply-To: <20211117070708.2174932-1-liwang@redhat.com>
References: <20211117070708.2174932-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/3] testcase: make use of .supported_archs
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

In some places, we have to keep ifdefs to make the compiler work
with unportable code.

Signed-off-by: Li Wang <liwang@redhat.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
---
 configure.ac                                  |  1 +
 testcases/cve/meltdown.c                      | 16 ++++++-----
 testcases/kernel/syscalls/ptrace/ptrace07.c   | 11 ++++----
 testcases/kernel/syscalls/ptrace/ptrace08.c   | 22 ++++++++-------
 testcases/kernel/syscalls/ptrace/ptrace09.c   | 11 +++++---
 testcases/kernel/syscalls/ptrace/ptrace10.c   | 12 +++++----
 .../syscalls/set_mempolicy/set_mempolicy05.c  | 27 +++++++++----------
 7 files changed, 54 insertions(+), 46 deletions(-)

diff --git a/configure.ac b/configure.ac
index 859aa9857..9af32c859 100644
--- a/configure.ac
+++ b/configure.ac
@@ -42,6 +42,7 @@ AC_CHECK_DECLS([SEM_STAT_ANY],,,[#include <sys/sem.h>])
 
 AC_CHECK_HEADERS_ONCE([ \
     asm/ldt.h \
+    emmintrin.h \
     ifaddrs.h \
     keyutils.h \
     linux/can.h \
diff --git a/testcases/cve/meltdown.c b/testcases/cve/meltdown.c
index 5a984aba3..2577c1a80 100644
--- a/testcases/cve/meltdown.c
+++ b/testcases/cve/meltdown.c
@@ -6,8 +6,6 @@
 #include "config.h"
 #include "tst_test.h"
 
-#if defined(__x86_64__) || defined(__i386__)
-
 #include <stdio.h>
 #include <string.h>
 #include <signal.h>
@@ -17,6 +15,7 @@
 #include <ctype.h>
 #include <sys/utsname.h>
 
+#ifdef HAVE_EMMINTRIN_H
 #include <emmintrin.h>
 
 #include "tst_tsc.h"
@@ -378,14 +377,17 @@ static struct tst_test test = {
 	.test_all = run,
 	.cleanup = cleanup,
 	.min_kver = "2.6.32",
+	.supported_archs = (const char *const []) {
+		"i386",
+		"x86_64",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"CVE", "2017-5754"},
 		{}
 	}
 };
 
-#else /* #if defined(__x86_64__) || defined(__i386__) */
-
-TST_TEST_TCONF("not x86_64 or i386");
-
-#endif /* #else #if defined(__x86_64__) || defined(__i386__) */
+#else /* HAVE_EMMINTRIN_H */
+	TST_TEST_TCONF("<emmintrin.h> is not supported");
+#endif
diff --git a/testcases/kernel/syscalls/ptrace/ptrace07.c b/testcases/kernel/syscalls/ptrace/ptrace07.c
index 9e3f7511d..da62cadb0 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace07.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace07.c
@@ -48,13 +48,13 @@
 # define NT_X86_XSTATE 0x202
 #endif
 
-#ifdef __x86_64__
 static void check_regs_loop(uint32_t initval)
 {
 	const unsigned long num_iters = 1000000000;
 	uint32_t xmm0[4] = { initval, initval, initval, initval };
 	int status = 1;
 
+#ifdef __x86_64__
 	asm volatile("   movdqu %0, %%xmm0\n"
 		     "   mov %0, %%rbx\n"
 		     "1: dec %2\n"
@@ -68,6 +68,7 @@ static void check_regs_loop(uint32_t initval)
 		     "3:\n"
 		     : "+m" (xmm0), "+r" (status)
 		     : "r" (num_iters) : "rax", "rbx", "xmm0");
+#endif
 
 	if (status) {
 		tst_res(TFAIL,
@@ -178,6 +179,10 @@ static struct tst_test test = {
 	.test_all = do_test,
 	.forks_child = 1,
 	.needs_checkpoints = 1,
+	.supported_archs = (const char *const []) {
+		"x86_64",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "814fb7bb7db5"},
 		{"CVE", "2017-15537"},
@@ -185,7 +190,3 @@ static struct tst_test test = {
 	}
 
 };
-
-#else /* !__x86_64__ */
-	TST_TEST_TCONF("this test is only supported on x86_64");
-#endif /* __x86_64__ */
diff --git a/testcases/kernel/syscalls/ptrace/ptrace08.c b/testcases/kernel/syscalls/ptrace/ptrace08.c
index 170cae64c..20df39a9b 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace08.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace08.c
@@ -43,18 +43,16 @@
 #include "tst_test.h"
 #include "tst_safe_stdio.h"
 
-#if defined(__i386__) || defined(__x86_64__)
-
 static pid_t child_pid;
 
-#if defined(__x86_64__)
-# define KERN_ADDR_MIN 0xffff800000000000
-# define KERN_ADDR_MAX 0xffffffffffffffff
-# define KERN_ADDR_BITS 64
-#elif defined(__i386__)
+#if defined(__i386__)
 # define KERN_ADDR_MIN 0xc0000000
 # define KERN_ADDR_MAX 0xffffffff
 # define KERN_ADDR_BITS 32
+#else
+# define KERN_ADDR_MIN 0xffff800000000000
+# define KERN_ADDR_MAX 0xffffffffffffffff
+# define KERN_ADDR_BITS 64
 #endif
 
 static int deffered_check;
@@ -98,6 +96,7 @@ static void ptrace_try_kern_addr(unsigned long kern_addr)
 	if (SAFE_WAITPID(child_pid, &status, WUNTRACED) != child_pid)
 		tst_brk(TBROK, "Received event from unexpected PID");
 
+#if defined(__i386__) || defined(__x86_64__)
 	SAFE_PTRACE(PTRACE_ATTACH, child_pid, NULL, NULL);
 	SAFE_PTRACE(PTRACE_POKEUSER, child_pid,
 		(void *)offsetof(struct user, u_debugreg[0]), (void *)1);
@@ -127,6 +126,7 @@ static void ptrace_try_kern_addr(unsigned long kern_addr)
 
 	addr = ptrace(PTRACE_PEEKUSER, child_pid,
 	              (void*)offsetof(struct user, u_debugreg[0]), NULL);
+#endif
 
 	if (!deffered_check && addr == kern_addr)
 		tst_res(TFAIL, "Was able to set breakpoint on kernel addr");
@@ -161,6 +161,11 @@ static struct tst_test test = {
 	 * have to skip the test.
 	 */
 	.skip_in_compat = 1,
+	.supported_archs = (const char *const []) {
+		"i386",
+		"x86_64",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "f67b15037a7a"},
 		{"CVE", "2018-1000199"},
@@ -168,6 +173,3 @@ static struct tst_test test = {
 		{}
 	}
 };
-#else
-TST_TEST_TCONF("This test is only supported on x86 systems");
-#endif
diff --git a/testcases/kernel/syscalls/ptrace/ptrace09.c b/testcases/kernel/syscalls/ptrace/ptrace09.c
index 85875ce65..8ccdfcc4b 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace09.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace09.c
@@ -22,7 +22,6 @@
 #include <signal.h>
 #include "tst_test.h"
 
-#if defined(__i386__) || defined(__x86_64__)
 static short watchpoint;
 static pid_t child_pid;
 
@@ -46,6 +45,7 @@ static void run(void)
 {
 	int status;
 
+#if defined(__i386__) || defined(__x86_64__)
 	child_pid = SAFE_FORK();
 
 	if (!child_pid) {
@@ -60,6 +60,7 @@ static void run(void)
 	SAFE_PTRACE(PTRACE_POKEUSER, child_pid,
 		(void *)offsetof(struct user, u_debugreg[7]), (void *)0x30001);
 	SAFE_PTRACE(PTRACE_CONT, child_pid, NULL, NULL);
+#endif
 
 	while (1) {
 		if (SAFE_WAITPID(child_pid, &status, 0) != child_pid)
@@ -92,12 +93,14 @@ static struct tst_test test = {
 	.test_all = run,
 	.cleanup = cleanup,
 	.forks_child = 1,
+	.supported_archs = (const char *const []) {
+		"i386",
+		"x86_64",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d8ba61ba58c8"},
 		{"CVE", "2018-8897"},
 		{}
 	}
 };
-#else
-TST_TEST_TCONF("This test is only supported on x86 systems");
-#endif
diff --git a/testcases/kernel/syscalls/ptrace/ptrace10.c b/testcases/kernel/syscalls/ptrace/ptrace10.c
index b5d6b9f8f..3bd8ca1a9 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace10.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace10.c
@@ -22,8 +22,6 @@
 #include <signal.h>
 #include "tst_test.h"
 
-#if defined(__i386__) || defined(__x86_64__)
-
 static pid_t child_pid;
 
 static void child_main(void)
@@ -45,6 +43,7 @@ static void run(void)
 	if (SAFE_WAITPID(child_pid, &status, WUNTRACED) != child_pid)
 		tst_brk(TBROK, "Received event from unexpected PID");
 
+#if defined(__i386__) || defined(__x86_64__)
 	SAFE_PTRACE(PTRACE_ATTACH, child_pid, NULL, NULL);
 	SAFE_PTRACE(PTRACE_POKEUSER, child_pid,
 		(void *)offsetof(struct user, u_debugreg[0]), (void *)1);
@@ -53,6 +52,7 @@ static void run(void)
 
 	addr = ptrace(PTRACE_PEEKUSER, child_pid,
 	              (void*)offsetof(struct user, u_debugreg[0]), NULL);
+#endif
 
 	if (addr == 2)
 		tst_res(TPASS, "The rd0 was set on second PTRACE_POKEUSR");
@@ -76,11 +76,13 @@ static struct tst_test test = {
 	.test_all = run,
 	.cleanup = cleanup,
 	.forks_child = 1,
+	.supported_archs = (const char *const []) {
+		"i386",
+		"x86_64",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "bd14406b78e6"},
 		{}
 	}
 };
-#else
-TST_TEST_TCONF("This test is only supported on x86 systems");
-#endif
diff --git a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
index 86f6a95dc..c65cb1e18 100644
--- a/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
+++ b/testcases/kernel/syscalls/set_mempolicy/set_mempolicy05.c
@@ -37,18 +37,10 @@
 #include "config.h"
 #include "tst_test.h"
 
-#if defined(__i386__) || defined(__powerpc__)
-
 #include <string.h>
 
 static unsigned int i;
 static int sys_ret;
-#ifdef __i386__
-static const int sys_num = 276;
-static const int mode;
-static const int node_mask_ptr = UINT_MAX;
-static const int node_mask_sz = UINT_MAX;
-#endif
 static volatile char *stack_ptr;
 
 static void run(void)
@@ -58,6 +50,11 @@ static void run(void)
 	register long mode __asm__("r3");
 	register long node_mask_ptr __asm__("r4");
 	register long node_mask_sz __asm__("r5");
+#else
+	const int sys_num = 276;
+	const int mode;
+	const int node_mask_ptr = UINT_MAX;
+	const int node_mask_sz = UINT_MAX;
 #endif
 	char stack_pattern[0x400];
 
@@ -78,7 +75,8 @@ static void run(void)
 		:
 		"memory", "cr0", "r6", "r7", "r8", "r9", "r10", "r11", "r12");
 	sys_ret = mode;
-#else /* __i386__ */
+#endif
+#ifdef __i386__
 	asm volatile (
 		"add $0x400, %%esp\n\t"
 		"int $0x80\n\t"
@@ -114,15 +112,14 @@ static void run(void)
 
 static struct tst_test test = {
 	.test_all = run,
+	.supported_archs = (const char *const []) {
+		"i386",
+		"ppc",
+		NULL
+	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "cf01fb9985e8"},
 		{"CVE", "CVE-2017-7616"},
 		{}
 	}
 };
-
-#else /* #if defined(__x86_64__) || defined(__powerpc__) */
-
-TST_TEST_TCONF("not i386 or powerpc");
-
-#endif /* #else #if defined(__x86_64__) || defined(__powerpc__) */
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
