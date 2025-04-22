Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF42C369CB
	for <ltp@archiver.kernel.org>; Tue, 22 Apr 2025 09:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745314410; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=8uBhGN9hmNSfLxX064sKNuuh2o99fl/giW+q+6aoMRc=;
 b=jZ+lccMj6p4tVf3glaDEvXRnuu3PFmY8WMXB9tlK4svmGoxQS0UUWlvCWnHcjYrCnWxml
 26ySax4xraHS2pc7mbX2nlW2a7jmtqjGji4TyPr1tM5l7OFH51gZdbiACLNTyVHn/DzfQ9B
 9OK7PMT9A0N2U4KLHEJAyL4z6wqpopY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BAF0B3C299C
	for <ltp@archiver.kernel.org>; Tue, 22 Apr 2025 11:33:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B0753C071B
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 11:33:08 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B14E62009C3
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 11:33:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745314385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IczstL5qXuEZmaSNwbLfhDyiKqFqgjU/zvJ01XhH/aY=;
 b=MtJhCq4n674RdxtZu8DIQymdae6sua3MKzW8Nz0cT2Pefll28qche8kmOQ1IAhTJVaypf1
 TAr+9zMiM7niJjM3v4aB1tPHzHdB5+RBOe2bzwAdtJfcKdL8IVZEct4scoSUzMcZrxZpg7
 xmOjjKMWj0HFybO8q4HJGQiIUx48Zf0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-62-T8PMTcxWP3iioNNe6a15EA-1; Tue,
 22 Apr 2025 05:33:03 -0400
X-MC-Unique: T8PMTcxWP3iioNNe6a15EA-1
X-Mimecast-MFC-AGG-ID: T8PMTcxWP3iioNNe6a15EA_1745314383
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DB1AF1800360
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 09:33:02 +0000 (UTC)
Received: from dell-per430-17.gsslab.pek2.redhat.com
 (dell-per430-17.gsslab.pek2.redhat.com [10.72.36.28])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C0FBE1956095
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 09:33:01 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 22 Apr 2025 05:32:57 -0400
Message-ID: <20250422093257.299066-1-chwen@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6LSBRDrqed0EbotzN70mhQVykmv1XEPSdNa8wux0foU_1745314383
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Add tls parameter and flag:CLONE_SETTLS cover for
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
 testcases/kernel/syscalls/clone/clone08.c   | 40 ++++++++++++++++++---
 testcases/kernel/syscalls/clone3/clone301.c | 36 ++++++++++++++++---
 2 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/clone/clone08.c b/testcases/kernel/syscalls/clone/clone08.c
index dd97f3ff1..f5a8119a8 100644
--- a/testcases/kernel/syscalls/clone/clone08.c
+++ b/testcases/kernel/syscalls/clone/clone08.c
@@ -17,7 +17,11 @@
 #include "lapi/syscalls.h"
 #include "lapi/futex.h"
 
+#define TLS_SIZE 4096
+#define TLS_ALIGN 16
+
 static pid_t ptid, ctid, tgid;
+static void *tls_ptr;
 static void *child_stack;
 
 static void test_clone_parent(int t);
@@ -32,6 +36,9 @@ static int child_clone_parent_settid(void *);
 static void test_clone_thread(int t);
 static int child_clone_thread(void *);
 
+/* TLS variable to validate in child */
+static __thread int tls_test_var = 12345;
+
 /*
  * Children cloned with CLONE_VM should avoid using any functions that
  * might require dl_runtime_resolve, because they share thread-local
@@ -46,14 +53,14 @@ static struct test_case {
 	void (*testfunc)(int);
 	int (*do_child)(void *);
 } test_cases[] = {
-	{"CLONE_PARENT", CLONE_PARENT | SIGCHLD,
+	{"CLONE_PARENT", CLONE_PARENT | CLONE_SETTLS | SIGCHLD,
 	 test_clone_parent, child_clone_parent},
-	{"CLONE_CHILD_SETTID", CLONE_CHILD_SETTID | SIGCHLD,
+	{"CLONE_CHILD_SETTID", CLONE_CHILD_SETTID | CLONE_SETTLS | SIGCHLD,
 	 test_clone_tid, child_clone_child_settid},
-	{"CLONE_PARENT_SETTID", CLONE_PARENT_SETTID | CLONE_VM | SIGCHLD,
+	{"CLONE_PARENT_SETTID", CLONE_PARENT_SETTID | CLONE_VM | CLONE_SETTLS | SIGCHLD,
 	 test_clone_tid, child_clone_parent_settid},
 	{"CLONE_THREAD", CLONE_THREAD | CLONE_SIGHAND | CLONE_VM |
-	 CLONE_CHILD_CLEARTID | SIGCHLD,
+	 CLONE_CHILD_CLEARTID | CLONE_SETTLS | SIGCHLD,
 	 test_clone_thread, child_clone_thread},
 };
 
@@ -66,17 +73,24 @@ static void do_test(unsigned int i)
 static void setup(void)
 {
 	child_stack = SAFE_MALLOC(CHILD_STACK_SIZE);
+	tls_ptr = aligned_alloc(TLS_ALIGN, TLS_SIZE);
+	if (!tls_ptr) {
+		perror("aligned_alloc");
+		exit(EXIT_FAILURE);
+	}
+	memset(tls_ptr, 0, TLS_SIZE);
 }
 
 static void cleanup(void)
 {
 	free(child_stack);
+	free(tls_ptr);
 }
 
 static long clone_child(const struct test_case *t)
 {
 	TEST(ltp_clone7(t->flags, t->do_child, NULL, CHILD_STACK_SIZE,
-		child_stack, &ptid, NULL, &ctid));
+		child_stack, &ptid, tls_ptr, &ctid));
 
 	if (TST_RET == -1 && TTERRNO == ENOSYS)
 		tst_brk(TCONF, "clone does not support 7 args");
@@ -87,6 +101,14 @@ static long clone_child(const struct test_case *t)
 	return TST_RET;
 }
 
+static void validate_tls(void)
+{
+	if (tls_test_var == 12345)
+		tst_res(TPASS, "Child TLS variable has expected value");
+	else
+		tst_res(TFAIL, "Child TLS variable corrupted or not set");
+}
+
 static void test_clone_parent(int t)
 {
 	pid_t child;
@@ -102,6 +124,8 @@ static void test_clone_parent(int t)
 
 static int child_clone_parent(void *arg LTP_ATTRIBUTE_UNUSED)
 {
+	validate_tls();
+
 	if (parent_ppid == getppid()) {
 		tst_res(TPASS, "clone and forked child has the same parent");
 	} else {
@@ -120,6 +144,8 @@ static void test_clone_tid(int t)
 
 static int child_clone_child_settid(void *arg LTP_ATTRIBUTE_UNUSED)
 {
+	validate_tls();
+
 	if (ctid == tst_syscall(__NR_getpid))
 		tst_res(TPASS, "clone() correctly set ctid");
 	else
@@ -130,6 +156,8 @@ static int child_clone_child_settid(void *arg LTP_ATTRIBUTE_UNUSED)
 
 static int child_clone_parent_settid(void *arg LTP_ATTRIBUTE_UNUSED)
 {
+	validate_tls();
+
 	if (ptid == tst_syscall(__NR_getpid))
 		tst_res(TPASS, "clone() correctly set ptid");
 	else
@@ -175,6 +203,8 @@ static void test_clone_thread(int t)
 
 static int child_clone_thread(void *arg LTP_ATTRIBUTE_UNUSED)
 {
+	validate_tls();
+
 	if (tgid == tst_syscall(__NR_getpid))
 		tst_res(TPASS, "clone has the same thread id");
 	else
diff --git a/testcases/kernel/syscalls/clone3/clone301.c b/testcases/kernel/syscalls/clone3/clone301.c
index deed30b9f..9571c9f5c 100644
--- a/testcases/kernel/syscalls/clone3/clone301.c
+++ b/testcases/kernel/syscalls/clone3/clone301.c
@@ -18,22 +18,38 @@
 
 #define CHILD_SIGNAL	SIGUSR1
 #define DATA	777
+#define TLS_SIZE 4096
+#define TLS_ALIGN 16
 
 static int pidfd, child_tid, parent_tid, parent_received_signal;
 static volatile int child_received_signal, child_data;
 static struct clone_args *args;
 
+/* TLS variable to validate in child */
+static __thread int tls_test_var = 12345;
+
 static struct tcase {
 	uint64_t flags;
 	int exit_signal;
 } tcases[] = {
 	{0, SIGCHLD},
 	{0, SIGUSR2},
-	{CLONE_FS, SIGCHLD},
-	{CLONE_NEWPID, SIGCHLD},
-	{CLONE_PARENT_SETTID | CLONE_CHILD_SETTID | CLONE_PIDFD, SIGCHLD},
+	{CLONE_FS | CLONE_SETTLS, SIGCHLD},
+	{CLONE_NEWPID | CLONE_SETTLS, SIGCHLD},
+	{CLONE_PARENT_SETTID | CLONE_CHILD_SETTID | CLONE_PIDFD | CLONE_SETTLS, SIGCHLD},
 };
 
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
 static void parent_rx_signal(int sig)
 {
 	parent_received_signal = sig;
@@ -67,6 +83,13 @@ static void do_child(int clone_pidfd)
 {
 	int count = 1000;
 
+	/* Validate TLS usage */
+	if (tls_test_var == 12345) {
+		tst_res(TPASS, "Child TLS variable has expected value");
+	} else {
+		tst_res(TFAIL, "Child TLS variable corrupted or not set");
+	}
+
 	if (clone_pidfd) {
 		child_received_signal = 0;
 		child_data = 0;
@@ -111,6 +134,8 @@ static void run(unsigned int n)
 	int status, clone_pidfd = tc->flags & CLONE_PIDFD;
 	pid_t pid;
 
+	void *tls_ptr = allocate_tls_region();
+
 	args->flags = tc->flags;
 	args->pidfd = (uint64_t)(&pidfd);
 	args->child_tid = (uint64_t)(&child_tid);
@@ -118,7 +143,7 @@ static void run(unsigned int n)
 	args->exit_signal = tc->exit_signal;
 	args->stack = 0;
 	args->stack_size = 0;
-	args->tls = 0;
+	args->tls = (uint64_t)tls_ptr;
 
 	parent_received_signal = 0;
 	SAFE_SIGACTION(tc->exit_signal, &psig_action, NULL);
@@ -126,6 +151,7 @@ static void run(unsigned int n)
 	TEST(pid = clone3(args, sizeof(*args)));
 	if (pid < 0) {
 		tst_res(TFAIL | TTERRNO, "clone3() failed (%d)", n);
+		free(tls_ptr);
 		return;
 	}
 
@@ -139,11 +165,13 @@ static void run(unsigned int n)
 		TEST(pidfd_send_signal(pidfd, CHILD_SIGNAL, &uinfo, 0));
 		if (TST_RET != 0) {
 			tst_res(TFAIL | TTERRNO, "pidfd_send_signal() failed");
+			free(tls_ptr);
 			return;
 		}
 	}
 
 	SAFE_WAITPID(pid, &status, __WALL);
+	free(tls_ptr);
 
 	if (!parent_received_signal) {
 		tst_res(TFAIL, "Parent haven't got signal");
-- 
2.43.5


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
