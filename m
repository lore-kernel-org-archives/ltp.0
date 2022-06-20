Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F40BC433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 06:35:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B97B3C9185
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 08:35:15 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E64053C215A
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 08:35:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7C3A7600810
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 08:35:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655706902;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1eoAWF0llfDblTKQ8BR/lmSTlRHdJDimYaLtJLK/tR0=;
 b=AI8tUE/quQ36X8VC9SeBV4/fdZ1HootjzXqrhl6ABQgiXHRll7bwBzE0sdUqpxqS4FjoTX
 77n8QlTd6ObTd7Wgd6TF5iL1pzuvCbSUe18gd6ccxFtKcmP79AmDBLnLzoWJYPG+Ck3sno
 +PPuGQyRIv6PfNKMBo9IYv+5ckwHues=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-gOhByEFkO0Ghx95AXswNTA-1; Mon, 20 Jun 2022 02:35:00 -0400
X-MC-Unique: gOhByEFkO0Ghx95AXswNTA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B6D1B185A7BA;
 Mon, 20 Jun 2022 06:34:59 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6B4391121314;
 Mon, 20 Jun 2022 06:34:58 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Mon, 20 Jun 2022 14:34:56 +0800
Message-Id: <20220620063456.528113-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] swapping01: make use of remaining runtime in test
 looping
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

Here go with default to 10 minutes for max_runtime. At the same time limit
the loop that waits for the swap usage to settle to run for a reminder
of max_runtime/2 instead of the hardcoded 30 seconds.

This fix can significantly improve timeouts on slower systems:

  # free -h
                total        used        free      shared  buff/cache   available
  Mem:          2.9Gi       1.1Gi       1.1Gi        20Mi       732Mi       1.5Gi
  Swap:         2.0Gi          0B       2.0Gi

  # time ./swapping01
  tst_kconfig.c:82: TINFO: Parsing kernel config '/boot/config-4.18.0-309.el8.x86_64+debug'
  tst_test.c:1528: TINFO: Timeout per run is 0h 02m 00s
  swapping01.c:110: TINFO: available physical memory: 1545 MB
  swapping01.c:113: TINFO: try to allocate: 2008 MB
  swapping01.c:152: TPASS: no heavy swapping detected, 218 MB swapped.
  ...

  real    0m34.241s
  user    0m0.386s
  sys     0m16.040s

Co-developed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/kernel/mem/swapping/swapping01.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/mem/swapping/swapping01.c b/testcases/kernel/mem/swapping/swapping01.c
index f6133cc0d..fc225e4a6 100644
--- a/testcases/kernel/mem/swapping/swapping01.c
+++ b/testcases/kernel/mem/swapping/swapping01.c
@@ -58,6 +58,7 @@ static long swap_free_init;
 static long mem_over;
 static long mem_over_max;
 static pid_t pid;
+static unsigned int start_runtime;
 
 static void test_swapping(void)
 {
@@ -67,6 +68,8 @@ static void test_swapping(void)
 	FILE *file;
 	char line[PATH_MAX];
 
+	start_runtime = tst_remaining_runtime();
+
 	file = SAFE_FOPEN("/proc/swaps", "r");
 	while (fgets(line, sizeof(line), file)) {
 		if (strstr(line, "/dev/zram")) {
@@ -122,7 +125,7 @@ static void do_alloc(int allow_raise)
 
 static void check_swapping(void)
 {
-	int status, i;
+	int status;
 	long swap_free_now, swapped;
 
 	/* wait child stop */
@@ -131,14 +134,14 @@ static void check_swapping(void)
 		tst_brk(TBROK, "child was not stopped.");
 
 	/* Still occupying memory, loop for a while */
-	i = 0;
-	while (i < 30) {
+	while (tst_remaining_runtime() > start_runtime/2) {
 		swap_free_now = SAFE_READ_MEMINFO("SwapFree:");
 		sleep(1);
-		if (labs(swap_free_now - SAFE_READ_MEMINFO("SwapFree:")) < 10)
+		long diff = labs(swap_free_now - SAFE_READ_MEMINFO("SwapFree:"));
+		if (diff < 10)
 			break;
 
-		i++;
+		tst_res(TINFO, "SwapFree difference %li", diff);
 	}
 
 	swapped = SAFE_READ_PROC_STATUS(pid, "VmSwap:");
@@ -159,6 +162,7 @@ static struct tst_test test = {
 	.needs_root = 1,
 	.forks_child = 1,
 	.min_mem_avail = 10,
+	.max_runtime = 600,
 	.test_all = test_swapping,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_SWAP=y",
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
