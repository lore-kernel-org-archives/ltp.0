Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B544C61DA4
	for <ltp@archiver.kernel.org>; Sat, 18 Feb 2023 04:09:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0460E3CBE8A
	for <ltp@archiver.kernel.org>; Sat, 18 Feb 2023 05:09:45 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19C073CB10B
 for <ltp@lists.linux.it>; Sat, 18 Feb 2023 05:09:28 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 527D660067F
 for <ltp@lists.linux.it>; Sat, 18 Feb 2023 05:09:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676693365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6h66+29x3ZKbjQIpRjgBMR0d42q09OLcQ0lQPU/zR/4=;
 b=OQeIGv74g/9FV78zxdcFXOlf3JPm5B52LxFAZwDXvdPPMYvgk5QDpKqWU0H46q1WmrzuQf
 zmDdf57Hk0wlp8g7ODirHHZVFLP9l1rK6mFSJ/TF/YD2nnxr6gWk9zOif0bwEJZZjg94Dd
 9qwoAFpZ2VZZRxjWRA5upJGwUFwMnEs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-275-SE_AA9v3NnGnwpSEjShrSg-1; Fri, 17 Feb 2023 23:09:23 -0500
X-MC-Unique: SE_AA9v3NnGnwpSEjShrSg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 818C5185A794;
 Sat, 18 Feb 2023 04:09:23 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com
 (dhcp-66-81-187.nay.redhat.com [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E534240C10FA;
 Sat, 18 Feb 2023 04:09:20 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sat, 18 Feb 2023 12:09:19 +0800
Message-Id: <20230218040919.3548296-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] madvise06: Raise the bar for judging failure
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
Cc: Yongqiang Liu <liuyongqiang13@huawei.com>, Paul Bunyan <pbunyan@redhat.com>,
 Eirik Fuller <efuller@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

There is an intermittent failure which we have observed many times whether
on rhel or mainline kernel. But we're unable to stable reproduce it:

    43	madvise06.c:201: TFAIL: less than 102400 Kb were moved to the swap cache
    ...

However it does not look like a kernel issue, because SwapCached change is
not strictly abiding by the principle of MADV_WILLNEED advice. That means it
all depends on the kernel's specific circumstances. The value of the threshold
is debatable at least from my point of view, its use 1/4 is not guaranteed
100% safe.

As MADV_WILLNEED is just advice to the kernel, not a guarantee. The kernel may
choose to ignore the advice, or may prioritize other memory management tasks
over pre-loading the advised pages.

So this patch is aimed at improving the accuracy and clarity of the test results.
Specifically, the use of two separate variables to track the results of different
comparisons will make it easier to understand what the test is doing.

Additionally, the change to report a test result of "TINFO" instead of "TFAIL"
when the swap cache size is less than expected would be intended to indicate
that this is an acceptable outcome.

Finally, the change to the second tst_res call is intended to make the test more
lenient, as it now passes if either no page faults occur or the swap cache size
is larger than expected.

Reported-by: Paul Bunyan <pbunyan@redhat.com>
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Richard Palethorpe <rpalethorpe@suse.de>
Cc: Yongqiang Liu <liuyongqiang13@huawei.com>
Cc: Eirik Fuller <efuller@redhat.com>
---
 testcases/kernel/syscalls/madvise/madvise06.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise06.c b/testcases/kernel/syscalls/madvise/madvise06.c
index c7967ae6f..5bd428bd9 100644
--- a/testcases/kernel/syscalls/madvise/madvise06.c
+++ b/testcases/kernel/syscalls/madvise/madvise06.c
@@ -164,7 +164,7 @@ static int get_page_fault_num(void)
 
 static void test_advice_willneed(void)
 {
-	int loops = 100, res;
+	int loops = 100, res1, res2;
 	char *target;
 	long swapcached_start, swapcached;
 	int page_fault_num_1, page_fault_num_2;
@@ -197,10 +197,10 @@ static void test_advice_willneed(void)
 	} while (swapcached < swapcached_start + PASS_THRESHOLD_KB && loops > 0);
 
 	meminfo_diag("After madvise");
-	res = swapcached > swapcached_start + PASS_THRESHOLD_KB;
-	tst_res(res ? TPASS : TFAIL,
+	res1 = swapcached > swapcached_start + PASS_THRESHOLD_KB;
+	tst_res(res1 ? TPASS : TINFO,
 		"%s than %ld Kb were moved to the swap cache",
-		res ? "more" : "less", PASS_THRESHOLD_KB);
+		res1 ? "more" : "less", PASS_THRESHOLD_KB);
 
 	loops = 100;
 	SAFE_FILE_LINES_SCANF("/proc/meminfo", "SwapCached: %ld", &swapcached_start);
@@ -225,9 +225,9 @@ static void test_advice_willneed(void)
 			page_fault_num_2);
 	meminfo_diag("After page access");
 
-	res = page_fault_num_2 - page_fault_num_1;
-	tst_res(res == 0 ? TPASS : TFAIL,
-		"%d pages were faulted out of 3 max", res);
+	res2 = page_fault_num_2 - page_fault_num_1;
+	tst_res(((res2 == 0) || res1) ? TPASS : TFAIL,
+		"%d pages were faulted out of 3 max", res2);
 
 	SAFE_MUNMAP(target, CHUNK_SZ);
 }
-- 
2.38.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
