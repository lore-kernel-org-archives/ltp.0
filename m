Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36832CA0EE8
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 07:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758095881; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=8tfNbdFVrEh/ocpjCk7qwDdb5igrndazspZC4eQ08Vo=;
 b=EEBOozu0I2cZLepV48Iq4AqL5wmnx6SaMcOQr3tpnPfKuyGIszrZ+70fIOYGVc79gI2w3
 kLgMqEuzcAm0OdFqYkVzc25cGVKofmHZ4GhmVPtnteTiZCQgJV24Xf0fsH9zb/99JFVqdNQ
 aTvy+11OknliFEC3+Xzii5PtR38kDCQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77A013CDBE7
	for <ltp@archiver.kernel.org>; Wed, 17 Sep 2025 09:58:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CE0B3CD858
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 09:57:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 572891400C67
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 09:57:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758095856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ny8zjO7w54/u5MkHhTGTHxgrkzVQTR77iuLzzDDmRiA=;
 b=CEUf2aPnprffWcd747hkucdGkx1Ne8FsfuleAyjdqC/79NR8tHjRDZM9ILOZyNq/eAZQkT
 GWU3sLjt31SO7iEzGJEz2UI+fcWH47/9kAWMuUoLnM3zTV3ZtZO7ILlyP1jPpgR3zUlP4P
 zwBltsttwZXhRyT8Vg108wvuJ+W0Xho=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-7S_O64xbPWaATnUHZE3zxA-1; Wed,
 17 Sep 2025 03:57:34 -0400
X-MC-Unique: 7S_O64xbPWaATnUHZE3zxA-1
X-Mimecast-MFC-AGG-ID: 7S_O64xbPWaATnUHZE3zxA_1758095853
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F8F618004D8
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 07:57:33 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.112.245])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3C44119560BA
 for <ltp@lists.linux.it>; Wed, 17 Sep 2025 07:57:31 +0000 (UTC)
To: ltp@lists.linux.it
Date: Wed, 17 Sep 2025 15:57:29 +0800
Message-ID: <20250917075729.30093-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PMwZUxw6aHSlX7-tuhhCQv4vqqVWySL6t2TA3KE4Y90_1758095853
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mmap22: Improve MAP_DROPPABLE test stability using
 mincore()
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The current mmap22 test validates MAP_DROPPABLE by writing to the
allocated memory and checking for zero-filled pages under memory
pressure. However, this approach is unreliable because:

  - Child process memory pressure (malloc + single writes) may not
    reliably trigger cgroup memory reclaim.
  - Checking memory content (alloc[i] == 0) is insufficient to
    confirm kernel reclamation, as pages may remain resident but not
    overwritten.
  - Race conditions during child cleanup could leave residual cgroup
    processes.

Error logs:

   command: mmap22
   tst_tmpdir.c:316: TINFO: Using /tmp/LTP_mmaxrtyKb as tmpdir (xfs filesystem)
   tst_test.c:1953: TINFO: LTP version: 20250530
   tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.12.0-130.1445_2041086229.el10.x86_64+rt/build/.config'
   tst_test.c:1774: TINFO: Overall timeout per run is 0h 05m 54s
   tst_test.c:1837: TINFO: Killed the leftover descendant processes
   tst_test.c:1846: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
   tst_test.c:1848: TBROK: Test killed! (timeout?)
   tst_cgroup.c:1043: TBROK: unlinkat(5</sys/fs/cgroup/ltp>, 'test-92902', AT_REMOVEDIR): EBUSY (16)
   ...

This patch improves the test in the following ways:

  * Use mincore() to precisely detect if MAP_DROPPABLE pages have
    been reclaimed by the kernel.
  * Replace the old child loop with a stronger memory pressure loop
    (malloc + memset), ensuring cgroup limits are hit quickly.
  * Use SAFE_KILL + SAFE_WAITPID for robust child cleanup.
  * Extend runtime and add short sleeps to reduce busy looping and
    stabilize test results.
  * Record page size during setup for consistent use across functions.

As a result, the test becomes more stable, deterministic, and easier
to reproduce under different kernels and configurations.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/syscalls/mmap/mmap22.c | 78 ++++++++++++++++---------
 1 file changed, 52 insertions(+), 26 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap22.c b/testcases/kernel/syscalls/mmap/mmap22.c
index 1507fdfa7..b9db8e1b6 100644
--- a/testcases/kernel/syscalls/mmap/mmap22.c
+++ b/testcases/kernel/syscalls/mmap/mmap22.c
@@ -9,12 +9,19 @@
  * Test mmap(2) with MAP_DROPPABLE flag.
  *
  * Test base on kernel selftests/mm/droppable.c
+ *
+ * Ensure that memory allocated with MAP_DROPPABLE can be reclaimed
+ * under memory pressure within a cgroup.
  */
 
 #define _GNU_SOURCE
 #include <errno.h>
 #include <stdio.h>
 #include <sys/types.h>
+#include <sys/mman.h>
+#include <unistd.h>
+#include <signal.h>
+#include <sys/wait.h>
 #include "tst_test.h"
 #include "lapi/mmap.h"
 
@@ -22,13 +29,24 @@
 #define ALLOC_SIZE (128 * TST_MB)
 
 static struct tst_cg_group *cg_child;
+static pid_t child;
+static int page_size;
+
+static void stress_child(void)
+{
+	for (;;) {
+		char *buf = malloc(page_size);
+		if (!buf)
+			exit(1);
+		memset(buf, 'B', page_size);
+	}
+}
 
 static void test_mmap(void)
 {
-	size_t alloc_size = ALLOC_SIZE;
-	size_t page_size = getpagesize();
 	char *alloc;
-	pid_t child;
+	unsigned char *vec;
+	size_t npages = ALLOC_SIZE / page_size;
 
 	cg_child = tst_cg_group_mk(tst_cg, "child");
 	SAFE_CG_PRINTF(tst_cg, "memory.max", "%d", MEM_LIMIT);
@@ -38,38 +56,45 @@ static void test_mmap(void)
 		SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%d", MEM_LIMIT);
 	SAFE_CG_PRINTF(cg_child, "cgroup.procs", "%d", getpid());
 
-	alloc = SAFE_MMAP(0, alloc_size, PROT_READ | PROT_WRITE,
+	alloc = SAFE_MMAP(0, ALLOC_SIZE, PROT_READ | PROT_WRITE,
 			MAP_ANONYMOUS | MAP_DROPPABLE, -1, 0);
 
-	memset(alloc, 'A', alloc_size);
-	for (size_t i = 0; i < alloc_size; i += page_size) {
-		if (alloc[i]  != 'A')
-			tst_res(TFAIL, "memset failed");
-	}
+	memset(alloc, 'A', ALLOC_SIZE);
+
+	vec = SAFE_MALLOC(npages);
 
 	child = SAFE_FORK();
-	if (!child) {
-		for (;;)
-			*(char *)malloc(page_size) = 'B';
-	}
+	if (!child)
+		stress_child();
 
-	while (1) {
-		for (size_t i = 0; i < alloc_size; i += page_size) {
-			if (!tst_remaining_runtime()) {
-				tst_res(TFAIL, "MAP_DROPPABLE did not drop memory within the timeout period.");
-				goto kill_child;
-			}
-			if (!alloc[i]) {
-				tst_res(TPASS, "MAP_DROPPABLE test pass.");
-				goto kill_child;
+	for (;;) {
+		if (!tst_remaining_runtime()) {
+			tst_res(TFAIL, "MAP_DROPPABLE did not drop pages within timeout");
+			goto cleanup;
+		}
+
+		if (mincore(alloc, ALLOC_SIZE, vec) == -1)
+			tst_brk(TBROK | TERRNO, "mincore failed");
+
+		for (size_t i = 0; i < npages; i++) {
+			if (!(vec[i] & 1)) {
+				tst_res(TPASS, "MAP_DROPPABLE page reclaimed by kernel");
+				goto cleanup;
 			}
 		}
+
+		usleep(100000);
 	}
 
-kill_child:
-	SAFE_KILL(child, SIGKILL);
-	SAFE_WAITPID(child, NULL, 0);
-	SAFE_MUNMAP(alloc, alloc_size);
+cleanup:
+	if (child > 0) {
+		SAFE_KILL(child, SIGKILL);
+		SAFE_WAITPID(child, NULL, 0);
+	}
+	SAFE_MUNMAP(alloc, ALLOC_SIZE);
+	free(vec);
+	SAFE_CG_PRINTF(tst_cg_drain, "cgroup.procs", "%d", getpid());
+	cg_child = tst_cg_group_rm(cg_child);
 }
 
 static void setup(void)
@@ -84,6 +109,7 @@ static void setup(void)
 		tst_brk(TBROK | TERRNO, "mmap() MAP_DROPPABLE failed");
 
 	SAFE_MUNMAP(addr, 1);
+	page_size = getpagesize();
 }
 
 static void cleanup(void)
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
