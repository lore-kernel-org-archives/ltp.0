Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFF95C433FE
	for <ltp@archiver.kernel.org>; Sat, 12 Nov 2022 04:01:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 630813CD696
	for <ltp@archiver.kernel.org>; Sat, 12 Nov 2022 05:01:38 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BCE33CD5FE
 for <ltp@lists.linux.it>; Sat, 12 Nov 2022 05:01:18 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0CD3C1400C68
 for <ltp@lists.linux.it>; Sat, 12 Nov 2022 05:01:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668225675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=siU7atMT8ANcT6E2woCf/jDBKmT8NTAX1nMhpE6pCEo=;
 b=FvDteVvQoEMrVV94rKmtglnb/BEpgQnIY+ouL7gshs72gjk63EWP3RNx+yIw7SjSviua97
 6NeY2ichZ5RRGqbpO2El+eQiyjfHeLcib7Lq9DPy9c4wpS9qoWRmVXVWsGkpDw0V9a0Ss+
 8boXcqwk1VM++KqbLZUGBe/s3NeUwVI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-Ny4YuvtZMkKFQ3FZU1l8KQ-1; Fri, 11 Nov 2022 23:01:14 -0500
X-MC-Unique: Ny4YuvtZMkKFQ3FZU1l8KQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB265858F17;
 Sat, 12 Nov 2022 04:01:13 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 199B240C83EF;
 Sat, 12 Nov 2022 04:01:11 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sat, 12 Nov 2022 12:01:07 +0800
Message-Id: <20221112040107.3953862-2-liwang@redhat.com>
In-Reply-To: <20221112040107.3953862-1-liwang@redhat.com>
References: <20221112040107.3953862-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] getitimer01: add checking for nonzero timer
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
Cc: rpalethorpe@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

By default a new process disabled the timer and getitimer()
returned zero value. But we also need to check if the timer
is correct when reset to nonzero.

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
      The reason for using jiffy instead of time_step is that it only
      checks the timer is set expectedly but not really expired. So we
      use a rough value in the macro definition is enough.

 .../kernel/syscalls/getitimer/getitimer01.c   | 84 ++++++++++++++++---
 1 file changed, 71 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/getitimer/getitimer01.c b/testcases/kernel/syscalls/getitimer/getitimer01.c
index 5ecfac55c..a49f63a85 100644
--- a/testcases/kernel/syscalls/getitimer/getitimer01.c
+++ b/testcases/kernel/syscalls/getitimer/getitimer01.c
@@ -12,25 +12,83 @@
  */
 
 #include "tst_test.h"
+#include "tst_safe_clocks.h"
 
-static int itimer_name[] = {
-	ITIMER_REAL,
-	ITIMER_VIRTUAL,
-	ITIMER_PROF,
+#define SEC  100
+#define USEC 10000
+
+static struct itimerval *value;
+static long jiffy;
+
+static struct tcase {
+	int which;
+	char *des;
+} tcases[] = {
+	{ITIMER_REAL,    "ITIMER_REAL"},
+	{ITIMER_VIRTUAL, "ITIMER_VIRTUAL"},
+	{ITIMER_PROF,    "ITIMER_PROF"},
 };
 
-static void run(void)
+static void set_setitimer_value(int sec, int usec)
 {
-	long unsigned int i;
-	struct itimerval value;
+	value->it_value.tv_sec = sec;
+	value->it_value.tv_usec = usec;
+	value->it_interval.tv_sec = sec;
+	value->it_interval.tv_usec = usec;
+}
 
-	for (i = 0; i < ARRAY_SIZE(itimer_name); i++) {
-		TST_EXP_PASS(getitimer(itimer_name[i], &value));
-		TST_EXP_EQ_LI(value.it_value.tv_sec, 0);
-		TST_EXP_EQ_LI(value.it_value.tv_usec, 0);
-	}
+static void verify_getitimer(unsigned int i)
+{
+	struct tcase *tc = &tcases[i];
+
+	tst_res(TINFO, "tc->which = %s", tc->des);
+
+	TST_EXP_PASS(getitimer(tc->which, value));
+	TST_EXP_EQ_LI(value->it_value.tv_sec, 0);
+	TST_EXP_EQ_LI(value->it_value.tv_usec, 0);
+	TST_EXP_EQ_LI(value->it_interval.tv_sec, 0);
+	TST_EXP_EQ_LI(value->it_interval.tv_usec, 0);
+
+	set_setitimer_value(SEC, USEC);
+	TST_EXP_PASS(setitimer(tc->which, value, NULL));
+
+	set_setitimer_value(0, 0);
+	TST_EXP_PASS(getitimer(tc->which, value));
+
+	TST_EXP_EQ_LI(value->it_interval.tv_sec, SEC);
+	TST_EXP_EQ_LI(value->it_interval.tv_usec, USEC);
+
+	tst_res(TINFO, "value->it_value.tv_sec=%ld, value->it_value.tv_usec=%ld",
+			value->it_value.tv_sec, value->it_value.tv_usec);
+
+	/*
+	 * ITIMER_VIRTUAL and ITIMER_PROF timers always expire a
+	 * TICK_NSEC (jiffy) afterward the elapsed time to make
+	 * sure that at least time counters take effect.
+	 */
+	long margin = (tc->which == ITIMER_REAL) ? 0 : jiffy;
+
+	if (value->it_value.tv_sec > SEC ||
+			value->it_value.tv_usec > USEC + margin)
+		tst_res(TFAIL, "timer value is not within the expected range");
+	else
+		tst_res(TPASS, "timer value is within the expected range");
+}
+
+static void setup(void)
+{
+	struct timespec time_res;
+
+	SAFE_CLOCK_GETRES(CLOCK_MONOTONIC_COARSE, &time_res);
+	jiffy = (time_res.tv_nsec + 999) / 1000;
 }
 
 static struct tst_test test = {
-	.test_all = run
+	.tcnt = ARRAY_SIZE(tcases),
+	.setup = setup,
+	.test = verify_getitimer,
+	.bufs = (struct tst_buffers[]) {
+		{&value,  .size = sizeof(struct itimerval)},
+		{}
+	}
 };
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
