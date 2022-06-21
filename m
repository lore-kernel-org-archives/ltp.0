Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901D0C43334
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 03:47:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5535E3C93D9
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 05:47:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 230873C075E
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 05:47:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6CF6D1400211
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 05:47:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655783254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cud/RJwvf1MrmDPFE/IwDIJRc2ySgV/Z6+rOzHu4Nzs=;
 b=fC7Mkedob/nqZzjePJxlKfKEKxbRQm7nQ97F9PZjUrK91EYb8zVFl3iaJw/VeJTwiYFLWf
 52sohby3U4YODw+xbKCj2rDxkW6D2I19K8ouBaPZ7qV8UaTZ04dpCGJJxpNNeOokGppaM0
 AfAzVlYt9gRpV9uXkwcIGesfXu9zx+k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-zGBVtlG2PuCBO_idQF8i_A-1; Mon, 20 Jun 2022 23:47:33 -0400
X-MC-Unique: zGBVtlG2PuCBO_idQF8i_A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1177F811E7A;
 Tue, 21 Jun 2022 03:47:33 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3268140CFD0A;
 Tue, 21 Jun 2022 03:47:30 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Tue, 21 Jun 2022 11:47:29 +0800
Message-Id: <20220621034729.551200-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] madvise06: shrink to 3 MADV_WILLNEED pages to
 stabilize the test
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
Cc: Paul Bunyan <pbunyan@redhat.com>, Rafael Aquini <aquini@redhat.com>,
 Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Paul Bunyan reports that the madvise06 test fails intermittently with many
LTS kernels, after checking with mm developer we prefer to think this is
more like a test issue (but not kernel bug):

   madvise06.c:231: TFAIL: 4 pages were faulted out of 2 max

So this improvement is target to reduce the false positive happens from
three points:

  1. Adding the while-loop to give more chances for madvise_willneed()
     reads memory asynchronously
  2. Raise value of `loop` to let test waiting for more times if swapchache
     haven't reached the expected
  3. Shrink to only 3 pages for verifying MADV_WILLNEED that to make the
     system easily takes effect on it

From Rafael Aquini:

  The problem here is that MADV_WILLNEED is an asynchronous non-blocking
  hint, which will tell the kernel to start doing read-ahead work for the
  hinted memory chunk, but will not wait up for the read-ahead to finish.
  So, it is possible that when the dirty_pages() call start re-dirtying
  the pages in that target area, is racing against a scheduled swap-in
  read-ahead that hasn't yet finished. Expecting faulting only 2 pages
  out of 102400 also seems too strict for a PASS threshold.

Note:
  As Rafael suggested, another possible approach to tackle this failure
  is to tally up, and loosen the threshold to more than 2 major faults
  after a call to madvise() with MADV_WILLNEED.
  But from my test, seems the faulted-out page shows a significant
  variance in different platforms, so I didn't take this way.

Btw, this patch get passed on my two easy reproducible systems more than 1000 times

Reported-by: Paul Bunyan <pbunyan@redhat.com>
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Rafael Aquini <aquini@redhat.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
---
 testcases/kernel/syscalls/madvise/madvise06.c | 21 +++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index 6d218801c..27aff18f1 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -164,7 +164,7 @@ static int get_page_fault_num(void)
 
 static void test_advice_willneed(void)
 {
-	int loops = 50, res;
+	int loops = 100, res;
 	char *target;
 	long swapcached_start, swapcached;
 	int page_fault_num_1, page_fault_num_2;
@@ -202,23 +202,32 @@ static void test_advice_willneed(void)
 		"%s than %ld Kb were moved to the swap cache",
 		res ? "more" : "less", PASS_THRESHOLD_KB);
 
-
-	TEST(madvise(target, PASS_THRESHOLD, MADV_WILLNEED));
+	loops = 100;
+	SAFE_FILE_LINES_SCANF("/proc/meminfo", "SwapCached: %ld", &swapcached_start);
+	TEST(madvise(target, pg_sz * 3, MADV_WILLNEED));
 	if (TST_RET == -1)
 		tst_brk(TBROK | TTERRNO, "madvise failed");
+	do {
+		loops--;
+		usleep(100000);
+		if (stat_refresh_sup)
+			SAFE_FILE_PRINTF("/proc/sys/vm/stat_refresh", "1");
+		SAFE_FILE_LINES_SCANF("/proc/meminfo", "SwapCached: %ld",
+				&swapcached);
+	} while (swapcached < swapcached_start + pg_sz*3/1024 && loops > 0);
 
 	page_fault_num_1 = get_page_fault_num();
 	tst_res(TINFO, "PageFault(madvice / no mem access): %d",
 			page_fault_num_1);
-	dirty_pages(target, PASS_THRESHOLD);
+	dirty_pages(target, pg_sz * 3);
 	page_fault_num_2 = get_page_fault_num();
 	tst_res(TINFO, "PageFault(madvice / mem access): %d",
 			page_fault_num_2);
 	meminfo_diag("After page access");
 
 	res = page_fault_num_2 - page_fault_num_1;
-	tst_res(res < 3 ? TPASS : TFAIL,
-		"%d pages were faulted out of 2 max", res);
+	tst_res(res == 0 ? TPASS : TFAIL,
+		"%d pages were faulted out of 3 max", res);
 
 	SAFE_MUNMAP(target, CHUNK_SZ);
 }
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
