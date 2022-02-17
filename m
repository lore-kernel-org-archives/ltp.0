Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1DD7C433F5
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 11:18:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 455C93CA0B3
	for <ltp@archiver.kernel.org>; Thu, 17 Feb 2022 12:18:45 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2B5E03C020F
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 12:18:31 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 872A0100143E
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 12:18:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1645096709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=UI94eJLEKz0g/piSujVSk2RTXn2oHuq0klIbGXLarNs=;
 b=UBg7VhjrU8q6qsJg+p8jaN0ow2NDGBZ0r4Ul5WhvU6w9OeVFgWutUTnd6ZGlDkBR39wal7
 7ni9NFB6ccILP/6dpKXDazhrCdWwoPX6u+R/itAd5dJKcII6SHTUKtB2jUtoLgLU5Eq9Qy
 TrQdnRTrRz7w9oCg71Rl7kNJUpvLZ4o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-644-OHxJqjgCPqGjoCkLg1Igsg-1; Thu, 17 Feb 2022 06:18:27 -0500
X-MC-Unique: OHxJqjgCPqGjoCkLg1Igsg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E7DE801AA6
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 11:18:27 +0000 (UTC)
Received: from janakin.usersys.redhat.com (unknown [10.40.192.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 89E2C6E1B2
 for <ltp@lists.linux.it>; Thu, 17 Feb 2022 11:18:26 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 17 Feb 2022 12:18:22 +0100
Message-Id: <b32ed0e56099520bc3e75455e2472841aa0b3020.1645096642.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jstancek@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/perf_event_open03: skip test on slower
 systems
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

Some systems (specially with combination of -debug kernel
with KASAN enabled) have trouble completing this test
in specified timeout.

Lowering number of iterations would make the test condition
less accurate as it's based on global counter.

Instead, calculate the rate of iterations system can do in
first 5 seconds and used that to decide whether to continue
to run the test. If the rate is too slow, TCONF after 5
seconds.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../perf_event_open/perf_event_open03.c       | 43 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 2 deletions(-)

.needs_cmds = NULL gets rid of compile warning.

diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
index dcb70962771c..c7bf123a04b4 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open03.c
@@ -16,13 +16,16 @@
 
 #include "config.h"
 #include "tst_test.h"
+#include "tst_timer_test.h"
 #include "lapi/syscalls.h"
 
 #include "perf_event_open.h"
 
 #define INTEL_PT_PATH "/sys/bus/event_source/devices/intel_pt/type"
 
+const int iterations = 12000000;
 static int fd = -1;
+static int timeout;
 
 static void setup(void)
 {
@@ -39,6 +42,38 @@ static void setup(void)
 
 	SAFE_FILE_SCANF(INTEL_PT_PATH, "%d", &ev.type);
 	fd = perf_event_open(&ev, getpid(), -1, -1, 0);
+
+	timeout = tst_timeout_remaining();
+}
+
+/*
+ * Check how fast we can do the iterations after 5 seconds of runtime.
+ * If the rate is too small to complete for current timeout then
+ * stop the test.
+ */
+static void check_progress(int i)
+{
+	static float iter_per_ms;
+	long long elapsed_ms;
+
+	if (iter_per_ms)
+		return;
+
+	if (i % 1000 != 0)
+		return;
+
+	tst_timer_stop();
+	elapsed_ms = tst_timer_elapsed_ms();
+	if (elapsed_ms > 5000) {
+		iter_per_ms = (float) i / elapsed_ms;
+		tst_res(TINFO, "rate: %f iters/ms", iter_per_ms);
+		tst_res(TINFO, "needed rate for current test timeout: %f iters/ms",
+			(float) iterations / (timeout * 1000));
+
+		if (iter_per_ms * 1000 * (timeout - 1) < iterations)
+			tst_brk(TCONF, "System too slow to complete"
+				" test in specified timeout");
+	}
 }
 
 static void run(void)
@@ -47,10 +82,13 @@ static void run(void)
 	int i;
 
 	diff = SAFE_READ_MEMINFO("MemAvailable:");
+	tst_timer_start(CLOCK_MONOTONIC);
 
 	/* leak about 100MB of RAM */
-	for (i = 0; i < 12000000; i++)
+	for (i = 0; i < iterations; i++) {
 		ioctl(fd, PERF_EVENT_IOC_SET_FILTER, "filter,0/0@abcd");
+		check_progress(i);
+	}
 
 	diff -= SAFE_READ_MEMINFO("MemAvailable:");
 
@@ -75,5 +113,6 @@ static struct tst_test test = {
 		{"linux-git", "7bdb157cdebb"},
 		{"CVE", "2020-25704"},
 		{}
-	}
+	},
+	.needs_cmds = NULL,
 };
-- 
2.27.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
