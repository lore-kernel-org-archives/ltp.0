Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D678FC3271E
	for <ltp@archiver.kernel.org>; Fri,  5 Jul 2024 03:15:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17D663D3D29
	for <ltp@archiver.kernel.org>; Fri,  5 Jul 2024 05:15:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D095C3D3CE9
 for <ltp@lists.linux.it>; Fri,  5 Jul 2024 05:15:13 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 849CA600F8D
 for <ltp@lists.linux.it>; Fri,  5 Jul 2024 05:15:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720149310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=papE8zaFuP2O5faDmq71axnYBZVZR6shGu76OLKtqts=;
 b=HFf0Cu2Sl7wrlKAOVAL1Vf57N1q9MgOtBk+QUpzmM+HghPBcR8NnH+v3z0GMiKpqKkPGlD
 U79qTPBhy0bvjb3hrIIbM/JtvE89VEKitCZNsl+yHpZqt6wgUoH6JZb3FTeEDdO33P1YqH
 WfIZ47YcLWrJsaWVNMG2Z1szgK+ek8A=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-MfJEDZqLOxKHYvr1Uy3FHw-1; Thu,
 04 Jul 2024 23:15:08 -0400
X-MC-Unique: MfJEDZqLOxKHYvr1Uy3FHw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0F20196CE3E; Fri,  5 Jul 2024 03:15:07 +0000 (UTC)
Received: from fedora-laptop.redhat.com (unknown [10.72.116.64])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 720D83000180; Fri,  5 Jul 2024 03:15:04 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri,  5 Jul 2024 11:15:02 +0800
Message-ID: <20240705031502.9041-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] perf_event_open: improve the memory leak detection
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

The goal is to add more robust memory leak detection by periodically
sampling memory availability during the test run and checking for
significant decreases in available memory.

To avoid false postive:
  perf_event_open03.c:95: TFAIL: Likely kernel memory leak detected

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../perf_event_open/perf_event_open03.c       | 32 +++++++++++++++----
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
index 7dd31d3d2..1aab43e82 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
@@ -26,6 +26,7 @@
 const int iterations = 12000000;
 static int fd = -1;
 static int runtime;
+static int sample;
 
 static void setup(void)
 {
@@ -77,22 +78,41 @@ static void check_progress(int i)
 
 static void run(void)
 {
-	long diff;
+	long diff, diff_total, mem_avail, mem_avail_prev;
 	int i;
 
-	diff = SAFE_READ_MEMINFO("MemAvailable:");
+	sample = 0;
+	diff_total = 0;
+
+	mem_avail_prev = SAFE_READ_MEMINFO("MemAvailable:");
 	tst_timer_start(CLOCK_MONOTONIC);
 
 	/* leak about 100MB of RAM */
 	for (i = 0; i < iterations; i++) {
 		ioctl(fd, PERF_EVENT_IOC_SET_FILTER, "filter,0/0@abcd");
 		check_progress(i);
-	}
 
-	diff -= SAFE_READ_MEMINFO("MemAvailable:");
+		/*
+		 * Every 1200000 iterations, calculate the difference in memory
+		 * availability. If the difference is greater than 10 * 1024 (10MB),
+		 * increment the sample counter and log the event.
+		 */
+		if ((i % 1200000) == 0) {
+			mem_avail = SAFE_READ_MEMINFO("MemAvailable:");
+			diff = mem_avail_prev - mem_avail;
+			diff_total += diff;
+
+			if (diff > 20 * 1024) {
+				sample++;
+				tst_res(TINFO, "MemAvailable decreased by %ld kB at iteration %d", diff, i);
+			}
+
+			mem_avail_prev = mem_avail;
+		}
+	}
 
-	if (diff > 50 * 1024)
-		tst_res(TFAIL, "Likely kernel memory leak detected");
+	if ((sample > 5) || (diff_total > 100 * 1024))
+		tst_res(TFAIL, "Likely kernel memory leak detected, total decrease: %ld kB", diff_total);
 	else
 		tst_res(TPASS, "No memory leak found");
 }
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
