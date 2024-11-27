Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46B4D6ACC0
	for <ltp@archiver.kernel.org>; Wed, 27 Nov 2024 12:13:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35AD63DB674
	for <ltp@archiver.kernel.org>; Wed, 27 Nov 2024 13:13:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9CF913DB67B
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 13:12:51 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1F578101AEA1
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 13:12:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732709567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0LkFsI8Nf5w2rg3MT3pv6ctq22KfcPI+9I2LK0gmYQ=;
 b=Lf7x/TR4E8RWnr3wjeycZnqMQsjmfXV4XF4oF6MXdaxB4Gy+JLLbA1PnapdpeS27avPs2i
 P/KSyLzz99k8d/fDlnUg4sBWyk32ZK534ywwXWKryDabzGjG4iPX5tu7vnv8vvVIm8RnsY
 xxMGJHOirpw3cmrt0uSnbX+5jd92nH4=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-301-VsOd9pqQMACv5ZfahVOsuw-1; Wed,
 27 Nov 2024 07:12:44 -0500
X-MC-Unique: VsOd9pqQMACv5ZfahVOsuw-1
X-Mimecast-MFC-AGG-ID: VsOd9pqQMACv5ZfahVOsuw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A0B231955F77
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 12:12:42 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63440300019E
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 12:12:40 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 27 Nov 2024 20:12:33 +0800
Message-ID: <20241127121233.14638-2-liwang@redhat.com>
In-Reply-To: <20241127121233.14638-1-liwang@redhat.com>
References: <20241127121233.14638-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GE8iDsa-Kw_6V_U8PryDQn3mN_ABRivGSD20S_vsrhA_1732709562
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] starvation: define the max_runtime
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

Signed-off-by: Li Wang <liwang@redhat.com>
---
 .../kernel/sched/cfs-scheduler/starvation.c   | 38 +------------------
 1 file changed, 1 insertion(+), 37 deletions(-)

diff --git a/testcases/kernel/sched/cfs-scheduler/starvation.c b/testcases/kernel/sched/cfs-scheduler/starvation.c
index e707e0865..cd6739a24 100644
--- a/testcases/kernel/sched/cfs-scheduler/starvation.c
+++ b/testcases/kernel/sched/cfs-scheduler/starvation.c
@@ -21,38 +21,9 @@
 #include <sched.h>
 
 #include "tst_test.h"
-#include "tst_safe_clocks.h"
-#include "tst_timer.h"
 
 static char *str_loop;
 static long loop = 1000000;
-static char *str_timeout;
-static int timeout;
-
-#define CALLIBRATE_LOOPS 120000000
-
-static int callibrate(void)
-{
-	int i;
-	struct timespec start, stop;
-	long long diff;
-
-	for (i = 0; i < CALLIBRATE_LOOPS; i++)
-		__asm__ __volatile__ ("" : "+g" (i) : :);
-
-	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC_RAW, &start);
-
-	for (i = 0; i < CALLIBRATE_LOOPS; i++)
-		__asm__ __volatile__ ("" : "+g" (i) : :);
-
-	SAFE_CLOCK_GETTIME(CLOCK_MONOTONIC_RAW, &stop);
-
-	diff = tst_timespec_diff_us(stop, start);
-
-	tst_res(TINFO, "CPU did %i loops in %llius", CALLIBRATE_LOOPS, diff);
-
-	return diff;
-}
 
 static int wait_for_pid(pid_t pid)
 {
@@ -102,13 +73,6 @@ static void setup(void)
 
 	if (tst_parse_long(str_loop, &loop, 1, LONG_MAX))
 		tst_brk(TBROK, "Invalid number of loop number '%s'", str_loop);
-
-	if (tst_parse_int(str_timeout, &timeout, 1, INT_MAX))
-		tst_brk(TBROK, "Invalid number of timeout '%s'", str_timeout);
-	else
-		timeout = callibrate() / 1000;
-
-	tst_set_max_runtime(timeout);
 }
 
 static void handler(int sig LTP_ATTRIBUTE_UNUSED)
@@ -158,8 +122,8 @@ static struct tst_test test = {
 	.forks_child = 1,
 	.options = (struct tst_option[]) {
 		{"l:", &str_loop, "Number of loops (default 2000000)"},
-		{"t:", &str_timeout, "Max timeout (default 240s)"},
 		{}
 	},
+	.max_runtime = 120,
 	.needs_checkpoints = 1,
 };
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
