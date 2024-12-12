Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F03ADE7717F
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 09:30:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6245C3C00FF
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 10:30:04 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C35B93C00FF
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 10:29:49 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 003FC64ADB4
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 10:29:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733995787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FtHUP0fgQg/OohCqlqw+foQdx0MhLeO+2VowIZm0ieg=;
 b=CXcXEnim82skHRnS9tEUXnK0GraVhV8npqJ9g92ywreyoUxrOhkiJB7OkqBN81jeEPeS70
 McAVjqnWEMMct6wjNAsdcWpCMLjhswLAllVWEvIkuu5bE58KrW21oNNt3HhQvg45lPaolR
 zMZsfq+WupMHzgs0fqrFO9AvIJR6i00=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-vyRwBH5qNn6ZPDzwkUSH7A-1; Thu,
 12 Dec 2024 04:29:43 -0500
X-MC-Unique: vyRwBH5qNn6ZPDzwkUSH7A-1
X-Mimecast-MFC-AGG-ID: vyRwBH5qNn6ZPDzwkUSH7A
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C19671956086; Thu, 12 Dec 2024 09:29:41 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.182])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 65CB51956052; Thu, 12 Dec 2024 09:29:38 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it,
	wegao@suse.com
Date: Thu, 12 Dec 2024 10:29:24 +0100
Message-ID: <30448a47662f0cf71acddd2f12eb2a08092309a3.1733995467.git.jstancek@redhat.com>
In-Reply-To: <CAASaF6xtjp4cTWydtqfUsqMe0q0fym+_Dhqg=KAWPgF=CM6DBw@mail.gmail.com>
References: <CAASaF6xtjp4cTWydtqfUsqMe0q0fym+_Dhqg=KAWPgF=CM6DBw@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yw86fBQE5Ydp0WsqxVO_QnlcDzdcI_dQY0RmMosaZmM_1733995782
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] hugemmap34: change how test finds suitable huge page
 and stack for test
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
Cc: samir@linux.vnet.ibm.com, mkoutny@suse.com, emunson@mgebm.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The test is trying to find a place for huge page with mmap(MAP_FIXED_NOREPLACE)
starting at top of stack and going downwards until it succeeds. The problem
is that before it finds one, it goes over other existing mappings. So, child
process does crash when trying to extend stack, but not because it hits
mapped huge page, it hits one of the existing mappings. This search is slow,
specially on -debug kernels.

This patch changes the test, by giving child process a separate stack that is
always immediately above a huge page. Setup temporarily allocates huge pages and
uses those addresses to map potential child stacks. When it allocates huge page
and finds that mapping after it is one of child stacks, it uses that pair
for the test.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/mem/hugetlb/hugemmap/hugemmap34.c  | 151 ++++++++++++++----
 1 file changed, 118 insertions(+), 33 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
index a7a88fbb2d9e..91b070a8462e 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap34.c
@@ -20,25 +20,32 @@
  * huge page-only segment -- resulting in bugs.
  */
 
+#define _GNU_SOURCE
 #include "lapi/mmap.h"
 #include "hugetlb.h"
 #include <errno.h>
+#include <inttypes.h>
+#include <sched.h>
 
 #ifdef __LP64__
 #define STACK_ALLOCATION_SIZE	(256*1024*1024)
 #else
 #define STACK_ALLOCATION_SIZE	(16*1024*1024)
 #endif
-#define PALIGN(p, a) ((void *)LTP_ALIGN((unsigned long)(p), (a)))
 #define MNTPOINT "hugetlbfs/"
-static int  fd = -1;
-static unsigned long long hpage_size;
-static int page_size;
+#define PATH_HUGEPAGE "/sys/kernel/mm/hugepages"
+
+#define STACKS_MAX 64
 
+static int  fd = -1;
+static uintptr_t hpage_size, stacks[STACKS_MAX];
+static int stacks_num;
+static void *hpage_addr, *stack_addr;
+static void **shared_area;
 
-void do_child(void *stop_address)
+int do_child(void *stop_address)
 {
-	volatile int *x;
+	volatile char *x;
 
 	/* corefile from this process is not interesting and limiting
 	 * its size can save a lot of time. '1' is a special value,
@@ -46,57 +53,77 @@ void do_child(void *stop_address)
 	 * sets limit to RLIM_INFINITY.
 	 */
 	tst_no_corefile(1);
+	tst_res(TINFO, "Child process starting with top of stack at %p", &x);
 
 	do {
 		x = alloca(STACK_ALLOCATION_SIZE);
+		*shared_area = (void *)x;
 		*x = 1;
 	} while ((void *)x >= stop_address);
+	exit(0);
 }
 
 static void run_test(void)
 {
 	int pid, status;
-	void *stack_address, *mmap_address, *heap_address, *map;
 
-	stack_address = alloca(0);
-	heap_address = sbrk(0);
-
-	/*
-	 * paranoia: start mapping two hugepages below the start of the stack,
-	 * in case the alignment would cause us to map over something if we
-	 * only used a gap of one hugepage.
-	 */
-	mmap_address = PALIGN(stack_address - 2 * hpage_size, hpage_size);
-	do {
-		map = mmap(mmap_address, hpage_size, PROT_READ|PROT_WRITE,
-				MAP_SHARED | MAP_FIXED_NOREPLACE, fd, 0);
-		if (map == MAP_FAILED) {
-			if (errno == ENOMEM) {
-				tst_res(TCONF, "There is no enough memory in the system to do mmap");
-				return;
-			}
-		}
-		mmap_address -= hpage_size;
-		/*
-		 * if we get all the way down to the heap, stop trying
-		 */
-	} while (mmap_address <= heap_address);
-	pid = SAFE_FORK();
+	pid = ltp_clone(CLONE_VM | CLONE_VFORK | SIGCHLD, do_child,
+		hpage_addr, hpage_size, stack_addr);
 	if (pid == 0)
-		do_child(mmap_address);
+		do_child(hpage_addr);
 
 	SAFE_WAITPID(pid, &status, 0);
+	tst_res(TINFO, "Child process extended stack up to %p, failed at %p",
+		*shared_area, *shared_area - STACK_ALLOCATION_SIZE);
 	if (WIFSIGNALED(status) && WTERMSIG(status) == SIGSEGV)
 		tst_res(TPASS, "Child killed by %s as expected", tst_strsig(SIGSEGV));
 	else
 		tst_res(TFAIL, "Child: %s", tst_strstatus(status));
 }
 
+/* Return start address of next mapping or 0 */
+static uintptr_t  get_next_mapping_start(uintptr_t addr)
+{
+	FILE *fp = fopen("/proc/self/maps", "r");
+
+	if (fp == NULL)
+		tst_brk(TBROK | TERRNO, "Failed to open /proc/self/maps.");
+
+	while (!feof(fp)) {
+		uintptr_t start, end;
+		int ret;
+
+		ret = fscanf(fp, "%"PRIxPTR"-%"PRIxPTR" %*[^\n]\n", &start, &end);
+		if (ret != 2) {
+			fclose(fp);
+			tst_brk(TBROK | TERRNO, "Couldn't parse /proc/self/maps line.");
+		}
+
+		if (start > addr) {
+			fclose(fp);
+			return start;
+		}
+	}
+	fclose(fp);
+	return 0;
+}
+
+static int is_addr_in_stacks(uintptr_t addr)
+{
+	int i;
+
+	for (i = 0; i < stacks_num; i++) {
+		if (addr == stacks[i])
+			return 1;
+	}
+	return 0;
+}
+
 void setup(void)
 {
 	struct rlimit r;
+	int i;
 
-	page_size = getpagesize();
 	hpage_size = tst_get_hugepage_size();
 	/*
 	 * Setting the stack size to unlimited.
@@ -107,7 +134,65 @@ void setup(void)
 	SAFE_GETRLIMIT(RLIMIT_STACK, &r);
 	if (r.rlim_cur != RLIM_INFINITY)
 		tst_brk(TCONF, "Stack rlimit must be 'unlimited'");
+
+	if (access(PATH_HUGEPAGE, F_OK))
+		tst_brk(TCONF, "hugetlbfs is not supported");
+
 	fd = tst_creat_unlinked(MNTPOINT, 0);
+
+	/* shared memory to pass a (void *) from child process */
+	shared_area = SAFE_MMAP(0, getpagesize(), PROT_READ|PROT_WRITE,
+		MAP_SHARED|MAP_ANONYMOUS, -1, 0);
+
+	/*
+	 * We search for potential stack addresses by looking at
+	 * places where kernel would map next huge page and occupying that
+	 * address as potential stack. When huge page lands in such place
+	 * that next mapping is one of our stack mappings, we use those
+	 * two for the test. We try to map huge pages in child process so that
+	 * slices in parent are not affected.
+	 */
+	tst_res(TINFO, "searching for huge page and child stack placement");
+	for (i = 0; i < STACKS_MAX; i++) {
+		uintptr_t next_start;
+		int pid, status;
+
+		pid = SAFE_FORK();
+		if (pid == 0) {
+			*shared_area = SAFE_MMAP(0, hpage_size, PROT_READ|PROT_WRITE,
+				MAP_PRIVATE, fd, 0);
+			SAFE_MUNMAP(*shared_area, hpage_size);
+			exit(0);
+		}
+		SAFE_WAITPID(pid, &status, 0);
+		if (status != 0)
+			tst_brk(TFAIL, "Child: %s", tst_strstatus(status));
+
+		next_start = get_next_mapping_start((uintptr_t)*shared_area);
+		if (is_addr_in_stacks(next_start)) {
+			stack_addr = (void *)next_start;
+			hpage_addr = *shared_area;
+			break;
+		}
+
+		tst_res(TINFO, "potential stack at address %p", *shared_area);
+		stacks[stacks_num++] = (uintptr_t) SAFE_MMAP(*shared_area, hpage_size,
+			PROT_READ|PROT_WRITE,
+			MAP_ANONYMOUS|MAP_PRIVATE|MAP_GROWSDOWN, -1, 0);
+	}
+
+	if (!stack_addr)
+		tst_brk(TCONF, "failed to find good place for huge page and stack");
+
+	hpage_addr = mmap(hpage_addr, hpage_size, PROT_READ|PROT_WRITE,
+		MAP_SHARED|MAP_FIXED, fd, 0);
+	if (hpage_addr == MAP_FAILED) {
+		if (errno == ENOMEM)
+			tst_brk(TCONF, "Not enough memory.");
+		tst_brk(TBROK|TERRNO, "mmap failed");
+	}
+	tst_res(TINFO, "huge page is at address %p", hpage_addr);
+	tst_res(TINFO, "using stack is at address %p", stack_addr);
 }
 
 void cleanup(void)
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
