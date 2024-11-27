Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2792D6ACC3
	for <ltp@archiver.kernel.org>; Wed, 27 Nov 2024 12:13:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E41193DB67A
	for <ltp@archiver.kernel.org>; Wed, 27 Nov 2024 13:13:01 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 25D303C724A
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 13:12:45 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 554A2100E338
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 13:12:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732709562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bA7wa30jvq9JO9aLoVki3boPGgrzTgLlcuLGO6/hqw8=;
 b=bd1ibfNbF8dLMlHM80jIrpmiWd4+emKXcjBhqFYj0W5jIAOmP/Crb4PoxV2ky9M/4KLJc1
 zSDc4DfPLlEHUKg4gZLeW211CKKibeKzwR+3TzvbhQs9D437c+1rtkNGi7FkS9H9XtQe08
 RgptamZ1jYdcSkCr6My992ZO1CV6Y00=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-617-zA1D9MlXP-qxpht_ycR7qg-1; Wed,
 27 Nov 2024 07:12:41 -0500
X-MC-Unique: zA1D9MlXP-qxpht_ycR7qg-1
X-Mimecast-MFC-AGG-ID: zA1D9MlXP-qxpht_ycR7qg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 40BCD19560AA
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 12:12:40 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 02F4E300019E
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 12:12:38 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 27 Nov 2024 20:12:32 +0800
Message-ID: <20241127121233.14638-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ACo4QIQW22WsVnndGL3qttDBpNJRT8Er09g1c7Sl1dw_1732709560
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] lib: add extra calibrated runtime to slow tests
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

This patch inspired by Cyril's work ec14f4572d ("sched:
starvation: Autocallibrate the timeout"), introduces a CPU
calibration mechanism to enhance test runtime calculations.

The new tst_callibrate function measures CPU performance,
and in combination with tst_kconfig_debug_matches which
detects enabled debug-kernel configurations, computes an
extra_runtime adjustment.

The multiply_runtime function now incorporates this adjustment
to account for debug overhead, reducing the likelihood of
timeouts while maintaining adaptability for slower systems.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/tst_kconfig.h | 32 ++++++++++++++++++++++++++++++++
 include/tst_timer.h   | 30 ++++++++++++++++++++++++++++++
 lib/tst_test.c        |  5 ++++-
 3 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
index 23f807409..5746925df 100644
--- a/include/tst_kconfig.h
+++ b/include/tst_kconfig.h
@@ -98,4 +98,36 @@ struct tst_kcmdline_var {
  */
 void tst_kcmdline_parse(struct tst_kcmdline_var params[], size_t params_len);
 
+/*
+ * List of debug-kernel config options that may degrade performance when enabled.
+ */
+static const char * const tst_kconf_debug_options[][2] = {
+	{"CONFIG_PROVE_LOCKING=y", NULL},
+	{"CONFIG_LOCKDEP=y", NULL},
+	{"CONFIG_DEBUG_SPINLOCK=y", NULL},
+	{"CONFIG_DEBUG_RT_MUTEXES=y", NULL},
+	{"CONFIG_DEBUG_MUTEXES=y", NULL},
+	{"CONFIG_DEBUG_PAGEALLOC=y", NULL},
+	{"CONFIG_KASAN=y", NULL},
+	{"CONFIG_SLUB_RCU_DEBUG=y", NULL},
+	{"CONFIG_TRACE_IRQFLAGS=y", NULL},
+	{"CONFIG_LATENCYTOP=y", NULL},
+	{"CONFIG_DEBUG_NET=y", NULL},
+	{"CONFIG_EXT4_DEBUG=y", NULL},
+	{"CONFIG_QUOTA_DEBUG=y", NULL},
+	{"CONFIG_FAULT_INJECTION=y", NULL},
+	{"CONFIG_DEBUG_OBJECTS=y", NULL},
+	{NULL, NULL}
+};
+
+static inline int tst_kconfig_debug_matches(void)
+{
+	int i, num = 1;
+
+	for (i = 0; tst_kconf_debug_options[i][0] != NULL; i++)
+		num += !tst_kconfig_check(tst_kconf_debug_options[i]);
+
+	return num;
+}
+
 #endif	/* TST_KCONFIG_H__ */
diff --git a/include/tst_timer.h b/include/tst_timer.h
index 6fb940020..268fc8389 100644
--- a/include/tst_timer.h
+++ b/include/tst_timer.h
@@ -17,6 +17,7 @@
 #include <mqueue.h>
 #include <time.h>
 #include "tst_test.h"
+#include "tst_clocks.h"
 #include "lapi/common_timers.h"
 #include "lapi/posix_types.h"
 #include "lapi/syscalls.h"
@@ -1074,4 +1075,33 @@ static inline long long tst_timer_elapsed_us(void)
 	return tst_timespec_to_us(tst_timer_elapsed());
 }
 
+#define CALLIBRATE_LOOPS 120000000
+
+/*
+ * Measures the time taken by the CPU to perform a specified
+ * number of empty loops for calibration.
+ */
+static inline int tst_callibrate(void)
+{
+	int i;
+	struct timespec start, stop;
+	long long diff;
+
+	for (i = 0; i < CALLIBRATE_LOOPS; i++)
+		__asm__ __volatile__ ("" : "+g" (i) : :);
+
+	tst_clock_gettime(CLOCK_MONOTONIC_RAW, &start);
+
+	for (i = 0; i < CALLIBRATE_LOOPS; i++)
+		__asm__ __volatile__ ("" : "+g" (i) : :);
+
+	tst_clock_gettime(CLOCK_MONOTONIC_RAW, &stop);
+
+	diff = tst_timespec_diff_us(stop, start);
+
+	tst_res(TINFO, "CPU did %i loops in %llius", CALLIBRATE_LOOPS, diff);
+
+	return diff;
+}
+
 #endif /* TST_TIMER */
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 8db554dea..296683ffb 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -549,13 +549,16 @@ static void parse_mul(float *mul, const char *env_name, float min, float max)
 static int multiply_runtime(int max_runtime)
 {
 	static float runtime_mul = -1;
+	static int extra_runtime = 0;
 
 	if (max_runtime <= 0)
 		return max_runtime;
 
 	parse_mul(&runtime_mul, "LTP_RUNTIME_MUL", 0.0099, 100);
 
-	return max_runtime * runtime_mul;
+	extra_runtime = (tst_callibrate() / 1000) * tst_kconfig_debug_matches();
+
+	return (max_runtime + extra_runtime) * runtime_mul;
 }
 
 static struct option {
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
