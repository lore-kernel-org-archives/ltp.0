Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB49D3B7CA
	for <ltp@archiver.kernel.org>; Tue, 26 Nov 2024 08:58:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2467D3DAFE9
	for <ltp@archiver.kernel.org>; Tue, 26 Nov 2024 09:58:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 597503D947B
 for <ltp@lists.linux.it>; Tue, 26 Nov 2024 09:58:18 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A44431BE5349
 for <ltp@lists.linux.it>; Tue, 26 Nov 2024 09:58:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732611495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=/j4IJDtC8uABf5dn8XhjqAZPSr/8PD7xEaatswUYNPc=;
 b=HPFiy7WNgt0eRdJ5mx7iwgSPGbTTlkFjsN0tjJIbPrPmQ7DiHOtp9LYvupanM7mr5lQF3i
 njgM2xvEZbmR698V+JSeu6ELAVBGIyit4N7c5ZCsehlF3xhVOlj0XOjpqvyyTP+tus3anu
 tAQ861R+AAr2k7wTkcStnLKk1Uva5wI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-Q49ckYBeNMiIsSsHULEMGQ-1; Tue,
 26 Nov 2024 03:58:14 -0500
X-MC-Unique: Q49ckYBeNMiIsSsHULEMGQ-1
X-Mimecast-MFC-AGG-ID: Q49ckYBeNMiIsSsHULEMGQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EA3B419541A1
 for <ltp@lists.linux.it>; Tue, 26 Nov 2024 08:58:12 +0000 (UTC)
Received: from thoundrobot.redhat.com (unknown [10.72.112.151])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A5AAA1956086
 for <ltp@lists.linux.it>; Tue, 26 Nov 2024 08:58:10 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 26 Nov 2024 16:58:08 +0800
Message-ID: <20241126085808.14616-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l_va4hu34XQeSrRDhyM82JuRTqR9kly025muCmo55SY_1732611493
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] process_madvise01: running the test in mem_cg
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

The MADV_PAGEOUT behavior in the kernel is advisory and may skip
swapping if the system has sufficient free RAM, even when the
advice is explicitly requested. This causes sporadic false positives
in our CI, particularly on systems with large amounts of RAM:

  process_madvise01.c:38: TINFO: Allocate memory: 1048576 bytes
  process_madvise01.c:99: TINFO: Reclaim memory using MADV_PAGEOUT
  process_madvise01.c:62: TFAIL: Expect: Most of the memory has been swapped out: 0kB out of 1024kB

To address this, the patch confines the test to a memory cgroup
with configured limits for memory.max and memory.swap.max, improving
control over memory and swap usage. This reduces the likelihood of
false positives caused by system-wide memory conditions.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../syscalls/process_madvise/process_madvise01.c   | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/process_madvise/process_madvise01.c b/testcases/kernel/syscalls/process_madvise/process_madvise01.c
index 0fd3c1ef4..ca314c4da 100644
--- a/testcases/kernel/syscalls/process_madvise/process_madvise01.c
+++ b/testcases/kernel/syscalls/process_madvise/process_madvise01.c
@@ -23,7 +23,9 @@
 #include "lapi/syscalls.h"
 #include "process_madvise.h"
 
-#define MEM_CHILD	(1 * TST_MB)
+#define MEM_LIMIT   (100 * TST_MB)
+#define MEMSW_LIMIT (200 * TST_MB)
+#define MEM_CHILD   (1   * TST_MB)
 
 static void **data_ptr;
 
@@ -67,6 +69,12 @@ static void child_alloc(void)
 
 static void setup(void)
 {
+	SAFE_CG_PRINTF(tst_cg, "memory.max", "%d", MEM_LIMIT);
+	if (SAFE_CG_HAS(tst_cg, "memory.swap.max"))
+		SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%d", MEMSW_LIMIT);
+
+	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
+
 	data_ptr = SAFE_MMAP(NULL, sizeof(void *),
 			PROT_READ | PROT_WRITE,
 			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
@@ -123,7 +131,9 @@ static struct tst_test test = {
 	.min_kver = "5.10",
 	.needs_checkpoints = 1,
 	.needs_root = 1,
-	.min_swap_avail = MEM_CHILD / TST_MB,
+	.min_mem_avail = 2 * MEM_LIMIT / TST_MB,
+	.min_swap_avail = 2 * MEM_CHILD / TST_MB,
+	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_SWAP=y",
 		NULL
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
