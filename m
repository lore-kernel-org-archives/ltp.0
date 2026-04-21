Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF387F8FA8C
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 15:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776785096; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=hI+2R97vKbLVbz5bKNgV4Qn6SAsApvW/UFT+7zP/Mg4=;
 b=pU5PBdXPOT7uiR2fcSDjgh8Eyvyw3j84o1nGt4DAPyeXHC2147Y8Dadr99o9D+gf9SWcl
 VpsPtWzsLSfENC5q8OvNGm1b2UMmzc/wNzy1d4vwiERDNyQDduL4fy6TvTpLtd8KeJxyIC6
 i9cQKHUbudwcZ2ZzkPnzWPjAOln40UE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 747683E53C8
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 17:24:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA1313C5376
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 17:24:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3253F200B60
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 17:24:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776785071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dtkxcBkZY4zFR1j1MvEGK2uN/6eEnCfNoC5HyE95XF8=;
 b=Vlrt/Tfh6kga25g9aurmY/U04IBhnG3hSXEk1xH+pA0TV1Q1GfaM3kgbKcv9DOVrfy7nZ6
 iJL5Nar0Hq1bawHYtnvcNf7qnzymeJFnoRlljD9DC7kf1CMO0iwvnvCL7LcM4OuH0RkJc8
 cd0LEgsYR+p2agO9bRZ2WpIs8M+2IiI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-663-qKpv5TBEMcWLyzEwGSc77w-1; Tue,
 21 Apr 2026 11:24:29 -0400
X-MC-Unique: qKpv5TBEMcWLyzEwGSc77w-1
X-Mimecast-MFC-AGG-ID: qKpv5TBEMcWLyzEwGSc77w_1776785069
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A64E119560B7; Tue, 21 Apr 2026 15:24:28 +0000 (UTC)
Received: from workstation.redhat.com (unknown [10.44.48.31])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3EC401956095; Tue, 21 Apr 2026 15:24:26 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 21 Apr 2026 17:23:49 +0200
Message-ID: <20260421152349.1673057-1-mcermak@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: n_VkGjPEdNRvfbAqFOsaL1fgWZRvlzSWj2hS0pt-EXs_1776785069
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] Make userfaultfd0{1, 3,
 4} LTP tests valgrind compatible
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
From: Martin Cermak via ltp <ltp@lists.linux.it>
Reply-To: Martin Cermak <mcermak@redhat.com>
Cc: valgrind-developers@lists.sourceforge.net, mcermak@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Historically a page fault is handled in the linux kernel. The
userfaultfd mechanism [1] was introduced in Linux 4.3 (2015) to allow
custom handling page faults in userspace. It allows for custom page
fault handling strategies such as lazy loading, live migration of qemu
VMs, etc.  With userfaultfd, kernel communicates with userspace via a
file descriptor (userfaultfd).  Userfaultfd LTP tests cover this.

These tests set up a main thread and a page fault handler thread.  Once
a page fault happens in the main thread, kernel stops it, and let's the
handler take care of the page fault.

This is a problem for Valgrind, because it serializes the threads
execution (using one "big mutex", VG_(acquire_BigLock)).  Once kernel
stops the main thread, under valgrind, the handler thread doesn't have
a chance to handle the page fault.  Valgrind stalls till the timeout
(adjustable via LTP_TIMEOUT_MUL ;)

However, some of the testcases can be easily changed to use forked
processes instead of threads.  That's what this patch does.  When
client program forks, Valgrind forks too, and that allows for the needed
parallelism to handle the page fault.

This redesign can't be easily done with some of the tests, such as e.g.
userfaultfd02 where both the main thread and the handler thread need to
share the address space.  That could be done via clone() and is proven
to work.  But unfortunately there is another Valgrind limitation in clone
flags it supports, so this also isn't a practical way to go.

That said, this update tweaks userfaultfd01, userfaultfd03, and
userfaultfd04 in a way that they become "compatible" with Valgrind.
It's a test coverage improvement.

[1] https://www.kernel.org/doc/html/latest/admin-guide/mm/userfaultfd.html
---
 .../kernel/syscalls/userfaultfd/userfaultfd01.c   | 13 +++++++++----
 .../kernel/syscalls/userfaultfd/userfaultfd03.c   | 15 ++++++++++-----
 .../kernel/syscalls/userfaultfd/userfaultfd04.c   | 13 +++++++++----
 3 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
index 7368d3863..c927cda95 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
@@ -57,7 +57,7 @@ static void reset_pages(void)
 	SAFE_MUNMAP(copy_page, page_size);
 }
 
-static void *handle_thread(void)
+static void *pagefault_handler(void)
 {
 	static struct uffd_msg msg;
 	struct uffdio_copy uffdio_copy = {};
@@ -91,7 +91,7 @@ static void *handle_thread(void)
 
 static void run(unsigned int i)
 {
-	pthread_t thr;
+	pid_t pid;
 	struct uffdio_api uffdio_api = {};
 	struct uffdio_register uffdio_register;
 	struct tcase *tc = &tcases[i];
@@ -112,7 +112,11 @@ static void run(unsigned int i)
 
 	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
 
-	SAFE_PTHREAD_CREATE(&thr, NULL, (void *) handle_thread, NULL);
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		pagefault_handler();
+		_exit(0);
+	}
 
 	char c = page[0xf];
 
@@ -121,7 +125,7 @@ static void run(unsigned int i)
 	else
 		tst_res(TFAIL, "Pagefault not handled!");
 
-	SAFE_PTHREAD_JOIN(thr, NULL);
+	SAFE_WAITPID(pid, NULL, 0);
 	reset_pages();
 }
 
@@ -129,4 +133,5 @@ static struct tst_test test = {
 	.setup = setup,
 	.test = run,
 	.tcnt = ARRAY_SIZE(tcases),
+	.forks_child = 1,
 };
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
index b65f39eca..f5d3be1ae 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd03.c
@@ -61,7 +61,7 @@ static void reset_pages(void)
 	SAFE_MUNMAP(copy_page, page_size);
 }
 
-static void *handle_thread(void)
+static void *pagefault_handler(void)
 {
 	static struct uffd_msg msg;
 	struct uffdio_copy uffdio_copy = {};
@@ -95,7 +95,7 @@ static void *handle_thread(void)
 
 static void run(void)
 {
-	pthread_t thr;
+	pid_t pid;
 	struct uffdio_api uffdio_api = {};
 	struct uffdio_register uffdio_register;
 
@@ -112,7 +112,11 @@ static void run(void)
 
 	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
 
-	SAFE_PTHREAD_CREATE(&thr, NULL, (void *) handle_thread, NULL);
+	pid = SAFE_FORK();
+		if (pid == 0) {
+		pagefault_handler();
+		_exit(0);
+	}
 
 	char c = page[0xf];
 
@@ -121,7 +125,7 @@ static void run(void)
 	else
 		tst_res(TFAIL, "Pagefault not handled via /dev/userfaultfd");
 
-	SAFE_PTHREAD_JOIN(thr, NULL);
+	SAFE_WAITPID(pid, NULL, 0);
 	reset_pages();
 }
 
@@ -132,5 +136,6 @@ static struct tst_test test = {
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_USERFAULTFD=y",
 		NULL
-	}
+	},
+	.forks_child = 1,
 };
diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c
index 4eb811e45..13883a711 100644
--- a/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c
+++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd04.c
@@ -33,7 +33,7 @@ static void reset_pages(void)
 	SAFE_MUNMAP(page, page_size);
 }
 
-static void *handle_thread(void)
+static void *pagefault_handler(void)
 {
 	static struct uffd_msg msg;
 	struct uffdio_zeropage uffdio_zeropage = {};
@@ -64,7 +64,7 @@ static void *handle_thread(void)
 
 static void run(void)
 {
-	pthread_t thr;
+	pid_t pid;
 	struct uffdio_api uffdio_api = {};
 	struct uffdio_register uffdio_register;
 
@@ -81,7 +81,11 @@ static void run(void)
 
 	SAFE_IOCTL(uffd, UFFDIO_REGISTER, &uffdio_register);
 
-	SAFE_PTHREAD_CREATE(&thr, NULL, (void *) handle_thread, NULL);
+	pid = SAFE_FORK();
+	if (pid == 0) {
+		pagefault_handler();
+		_exit(0);
+	}
 
 	for (int i = 0; i < page_size; i++) {
 		if (page[i] != 0) {
@@ -92,10 +96,11 @@ static void run(void)
 
 	tst_res(TPASS, "Pagefault handled with UFFDIO_ZEROPAGE");
 
-	SAFE_PTHREAD_JOIN(thr, NULL);
+	SAFE_WAITPID(pid, NULL, 0);
 	reset_pages();
 }
 
 static struct tst_test test = {
 	.test_all = run,
+	.forks_child = 1,
 };
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
