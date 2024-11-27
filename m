Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E52D609AC
	for <ltp@archiver.kernel.org>; Wed, 27 Nov 2024 07:48:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E3D03DB52C
	for <ltp@archiver.kernel.org>; Wed, 27 Nov 2024 08:48:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1C5F3DB41C
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 08:48:25 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 291672000DC
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 08:48:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732693703;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=axZ6TduTKL9/KByYR0pJ+mF8E1MLTOkgY7kaybfdx6E=;
 b=JmxyhmmB6CFT3sDh57vLSQSuB7c8D5JWNAlHwDDENs532lfAIfxvV/+GK1bndZmCS+PXJF
 ESdlz6lVw3YtQQpf7WyWGfGJ2OxvYPE+Qkm6ug2qXTS8tcoWUivKWjpLv6uwnzQBgk4BGg
 HLZpLHx2oudCKhggtLdSIV6lnW4zgEQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-244-6JNhU8uhNfOyVsy-Y7alZw-1; Wed,
 27 Nov 2024 02:48:21 -0500
X-MC-Unique: 6JNhU8uhNfOyVsy-Y7alZw-1
X-Mimecast-MFC-AGG-ID: 6JNhU8uhNfOyVsy-Y7alZw
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 701E3195609E
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 07:48:20 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3356E1956054
 for <ltp@lists.linux.it>; Wed, 27 Nov 2024 07:48:18 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Wed, 27 Nov 2024 15:48:13 +0800
Message-ID: <20241127074813.10322-1-liwang@redhat.com>
In-Reply-To: <CAEemH2e3H0w52LKXs+UURdg5dq2bP5dXokWYb98DxHu5qcsOQg@mail.gmail.com>
References: <CAEemH2e3H0w52LKXs+UURdg5dq2bP5dXokWYb98DxHu5qcsOQg@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 00Nl8OrqULDqxEQapKKTWPJ_ejw3QDuWlagyVCQiJ1E_1732693700
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [Draft PATCH] lib: add TST_DYNAMICAL_RUNTIME option
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

Hi, this is a draft patch to reflect the method came up in the thread,
if people agree I will polish it and send a complete one later.

Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/tst_kconfig.h | 44 +++++++++++++++++++++++++++++++++++++++++++
 include/tst_test.h    |  1 +
 include/tst_timer.h   | 30 +++++++++++++++++++++++++++++
 lib/tst_test.c        | 12 ++++++++----
 4 files changed, 83 insertions(+), 4 deletions(-)

diff --git a/include/tst_kconfig.h b/include/tst_kconfig.h
index 23f807409..8f5bc06a7 100644
--- a/include/tst_kconfig.h
+++ b/include/tst_kconfig.h
@@ -98,4 +98,48 @@ struct tst_kcmdline_var {
  */
 void tst_kcmdline_parse(struct tst_kcmdline_var params[], size_t params_len);
 
+/*
+ * List of debug-related kernel config options that may degrade performance when enabled.
+ */
+static const char * const tst_kconf_debug_options[][2] = {
+	/* Lock debugging */
+	{"CONFIG_PROVE_LOCKING=y", NULL},
+	{"CONFIG_LOCKDEP=y", NULL},
+	{"CONFIG_DEBUG_SPINLOCK=y", NULL},
+
+	/* Mutexes debugging */
+	{"CONFIG_DEBUG_RT_MUTEXES=y", NULL},
+	{"CONFIG_DEBUG_MUTEXES=y", NULL},
+
+	/* Memory debugging */
+	{"CONFIG_DEBUG_PAGEALLOC=y", NULL},
+	{"CONFIG_KASAN=y", NULL},
+	{"CONFIG_SLUB_RCU_DEBUG=y", NULL},
+
+	/* Tracing and profiling */
+	{"CONFIG_TRACE_IRQFLAGS=y", NULL},
+	{"CONFIG_LATENCYTOP=y", NULL},
+	{"CONFIG_DEBUG_NET=y", NULL},
+
+	/* Filesystem debugging */
+	{"CONFIG_EXT4_DEBUG=y", NULL},
+	{"CONFIG_QUOTA_DEBUG=y", NULL},
+
+	/* Miscellaneous debugging */
+	{"CONFIG_FAULT_INJECTION=y", NULL},
+	{"CONFIG_DEBUG_OBJECTS=y", NULL},
+
+	{NULL, NULL} /* End of the array */
+};
+
+static inline int tst_kconfig_debug_matches(void)
+{
+	int i, num = 1;
+
+	for (i = 0; tst_kconf_debug_options[i][0] != NULL; i++)
+		num += tst_kconfig_check(tst_kconf_debug_options[i]);
+
+	return num;
+}
+
 #endif	/* TST_KCONFIG_H__ */
diff --git a/include/tst_test.h b/include/tst_test.h
index 8d1819f74..483b707d3 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -235,6 +235,7 @@ struct tst_tag {
 extern unsigned int tst_variant;
 
 #define TST_UNLIMITED_RUNTIME (-1)
+#define TST_DYNAMICAL_RUNTIME (-2)
 
 /**
  * struct tst_ulimit_val - An ulimit resource and value.
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
index 8db554dea..8a4460944 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1265,8 +1265,8 @@ static void do_setup(int argc, char *argv[])
 	if (!tst_test)
 		tst_brk(TBROK, "No tests to run");
 
-	if (tst_test->max_runtime < -1) {
-		tst_brk(TBROK, "Invalid runtime value %i",
+	if (tst_test->max_runtime < -2) {
+		tst_brk(TBROK, "Invalid runtime value %d",
 			results->max_runtime);
 	}
 
@@ -1695,7 +1695,6 @@ unsigned int tst_remaining_runtime(void)
 	return 0;
 }
 
-
 unsigned int tst_multiply_timeout(unsigned int timeout)
 {
 	parse_mul(&timeout_mul, "LTP_TIMEOUT_MUL", 0.099, 10000);
@@ -1715,8 +1714,13 @@ static void set_timeout(void)
 		return;
 	}
 
+	if (results->max_runtime == TST_DYNAMICAL_RUNTIME) {
+		tst_res(TINFO, "Timeout is decited in running time");
+		results->max_runtime = (tst_callibrate() / 1000) * tst_kconfig_debug_matches();
+	}
+
 	if (results->max_runtime < 0) {
-		tst_brk(TBROK, "max_runtime must to be >= -1! (%d)",
+		tst_brk(TBROK, "max_runtime must to be >= -2! (%d)",
 			results->max_runtime);
 	}
 
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
