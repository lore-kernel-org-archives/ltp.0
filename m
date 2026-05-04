Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9F98FF885A
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 09:40:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CBBB3E499A
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 11:40:16 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 449A13E28D7
 for <ltp@lists.linux.it>; Mon,  4 May 2026 11:39:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2753860075F
 for <ltp@lists.linux.it>; Mon,  4 May 2026 11:39:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A4C266A81B;
 Mon,  4 May 2026 09:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777887594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RSrsWlizHCaS/5yvP8VnOcDAUmTCTY4p5i4pdcAcP4k=;
 b=H2P57aH8fStTfM83YUuzkj31SywPLKEQ2XPKRQXh5gHKde1yyu3XbQBhdUZkov5guoF9UO
 yfnPbcogWcNnWH3Rni9mYtQUTQmDpXxhlQC21xq7AQUjmSi08+g/xv1NvQC93lgIWb54dk
 l0WnXBGFvk/JN6r3c3uODLGgTkOCsd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777887594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RSrsWlizHCaS/5yvP8VnOcDAUmTCTY4p5i4pdcAcP4k=;
 b=OYm09T1fjPiMEka+1GeVGDZrbaaOtyNSwMDBDR04JeWhE9XxemVOA17QGhp2DkOMAR7QYb
 IJa8QZH7MckwusCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=H2P57aH8;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=OYm09T1f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777887594; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RSrsWlizHCaS/5yvP8VnOcDAUmTCTY4p5i4pdcAcP4k=;
 b=H2P57aH8fStTfM83YUuzkj31SywPLKEQ2XPKRQXh5gHKde1yyu3XbQBhdUZkov5guoF9UO
 yfnPbcogWcNnWH3Rni9mYtQUTQmDpXxhlQC21xq7AQUjmSi08+g/xv1NvQC93lgIWb54dk
 l0WnXBGFvk/JN6r3c3uODLGgTkOCsd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777887594;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=RSrsWlizHCaS/5yvP8VnOcDAUmTCTY4p5i4pdcAcP4k=;
 b=OYm09T1fjPiMEka+1GeVGDZrbaaOtyNSwMDBDR04JeWhE9XxemVOA17QGhp2DkOMAR7QYb
 IJa8QZH7MckwusCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 834E3593A3;
 Mon,  4 May 2026 09:39:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sJHnHWpp+GnsLgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 May 2026 09:39:54 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 04 May 2026 11:39:51 +0200
MIME-Version: 1.0
Message-Id: <20260504-fix_clock_settime_helper-v4-1-403149f43d30@suse.com>
X-B4-Tracking: v=1; b=H4sIAGZp+GkC/43OTQ7CIBAF4KsY1mIQCD+uvIdpmkqnQmxLA0g0T
 e8u7UY3Ji5fMvO9N6MIwUFEp92MAmQXnR9L4PsdMrYZb4BdWzKihArCqcade9am9+ZeR0jJDVB
 b6CcIWApJJFHQat6h8j4FKLcbfalK7oIfcLIBmm9Q/QYzxUdMhTHArrKVRJzjI8LB+GHlrYvJh
 9c2PLO15I+NmW0kUYbpVnGtP2S1LMsbDcSdDQ4BAAA=
X-Change-ID: 20260429-fix_clock_settime_helper-7670708ed94f
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777887594; l=8633;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=xvFqvMhfNt11XV3hmMjilLczt/uB/iNninRzLcH52Fk=;
 b=lSGwV6qSfE+N0v32/NMUpuVqauILv72iOCuwY4LYzKYYimk/2x0+4FlP0fUSvOdq1VOU8crWy
 FpZEI+7/YZLBq6dGODhk9mtfu+RWGH9lhiGXSsiHeROPI+2t1vZwZRe
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A4C266A81B
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] clock_settime: use POSIX runtime detection for
 CLOCK_MONOTONIC
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

The clock_settime helpers.h used a compile-time #ifdef on
_POSIX_MONOTONIC_CLOCK to select between real and stub
implementations of pts_mono_time_start()/pts_mono_time_check().

On Linux/glibc, _POSIX_MONOTONIC_CLOCK is defined as 0, meaning
support is optional and must be verified at runtime via
sysconf(_SC_MONOTONIC_CLOCK). The #ifdef treated 0 the same as
>0 (always available), which is not POSIX-correct.

Replace the compile-time #ifdef/#else split with a runtime
pts_mono_available() helper that performs proper POSIX detection
via sysconf(). Extract pts_mono_available() into the shared
include/clock.h so it can be reused by nanosleep helpers as well.
Also add a missing #ifndef include guard and #include <unistd.h>
so _POSIX_MONOTONIC_CLOCK is always defined.

Fixes: 9ecb4a004b18 ("clock_settime: Detect external clock adjustments via CLOCK_MONOTONIC")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v4:
- verify that CLOCK_MONOTONIC exists vs _POSIX_MONOTONIC_CLOCK
- Link to v3: https://lore.kernel.org/r/20260429-fix_clock_settime_helper-v3-1-2608c39d8499@suse.com
---
 .../conformance/interfaces/clock_settime/4-1.c     |  1 +
 .../conformance/interfaces/clock_settime/5-1.c     |  1 +
 .../conformance/interfaces/clock_settime/5-2.c     |  1 +
 .../conformance/interfaces/clock_settime/7-1.c     |  1 +
 .../conformance/interfaces/clock_settime/7-2.c     |  1 +
 .../conformance/interfaces/clock_settime/helpers.h | 56 +---------------
 testcases/open_posix_testsuite/include/clock.h     | 77 ++++++++++++++++++++++
 7 files changed, 85 insertions(+), 53 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c
index 631aad7debb242df88bd3493319a82add7e9f0e9..ebd609963a3651212447ff2ab0885e20b19ba302 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c
@@ -28,6 +28,7 @@
 #include <signal.h>
 #include <unistd.h>
 #include "posixtest.h"
+#include "clock.h"
 #include "helpers.h"
 
 // SLEEPTIME < TIMEROFFSET
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-1.c
index ff8660f18e73df472463ebd7316a436402b1b6ba..06023036cf4c704c43ec64cfaed75157973f3524 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-1.c
@@ -23,6 +23,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include "posixtest.h"
+#include "clock.h"
 #include "helpers.h"
 
 #define TIMERSEC 5
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-2.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-2.c
index de1a8e422f86e2cd71e8237fe77d5083f541b599..bb4e86c2fef77e75f9216c7fe59930d71e5715a0 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-2.c
@@ -23,6 +23,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include "posixtest.h"
+#include "clock.h"
 #include "helpers.h"
 
 #define TIMERSEC 5
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-1.c
index 7009b38b42a730a3526724c14843f1656a16d30a..0ed40fe612506d5a571003d4d9b592a3faab608c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-1.c
@@ -24,6 +24,7 @@
 #include <unistd.h>
 #include <sys/wait.h>
 #include "posixtest.h"
+#include "clock.h"
 #include "helpers.h"
 
 #define SLEEPOFFSET 5
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-2.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-2.c
index 6713369be4c31c4076a493a224a85f24b5120a83..6162152e574e51cfce095b518314132d331ee68f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-2.c
@@ -23,6 +23,7 @@
 #include <unistd.h>
 #include <sys/wait.h>
 #include "posixtest.h"
+#include "clock.h"
 #include "helpers.h"
 
 #define SLEEPOFFSET 5
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/helpers.h b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/helpers.h
index 37bf30926f039553e9e370751b7938ca5ea1d00a..c559c189c163d7f7e1fb995b0806933504b278ab 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/helpers.h
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/helpers.h
@@ -13,7 +13,8 @@
  * by those tests.
  */
 
-#include <stdlib.h>
+#ifndef CLOCK_SETTIME_HELPERS_H
+#define CLOCK_SETTIME_HELPERS_H
 
 static int getBeforeTime(struct timespec *tpget)
 {
@@ -35,55 +36,4 @@ static int setBackTime(struct timespec tpset)
 	return PTS_PASS;
 }
 
-#define PTS_MONO_MAX_RETRIES 3
-
-#ifdef _POSIX_MONOTONIC_CLOCK
-static struct timespec _pts_mono_start;
-
-static inline int pts_mono_time_start(void)
-{
-	if (clock_gettime(CLOCK_MONOTONIC, &_pts_mono_start) != 0) {
-		perror("clock_gettime(CLOCK_MONOTONIC) failed");
-		return -1;
-	}
-	return 0;
-}
-
-static inline int pts_mono_time_check(unsigned int expected_secs)
-{
-	struct timespec now;
-	long elapsed;
-
-	if (clock_gettime(CLOCK_MONOTONIC, &now) != 0) {
-		perror("clock_gettime(CLOCK_MONOTONIC) failed");
-		return -1;
-	}
-
-	elapsed = now.tv_sec - _pts_mono_start.tv_sec;
-
-	if (labs(elapsed - (long)expected_secs) > 1) {
-		printf("Clock adjustment detected (elapsed %lds, expected ~%us)\n",
-		       elapsed, expected_secs);
-		return 1;
-	}
-	return 0;
-}
-#else
-static inline int pts_mono_time_start(void)
-{
-	static int warned;
-
-	if (!warned) {
-		printf("CLOCK_MONOTONIC unavailable, test may fail due to clock adjustment\n");
-		warned = 1;
-	}
-	return 0;
-}
-
-static inline int pts_mono_time_check(unsigned int expected_secs)
-{
-	(void)expected_secs;
-	return 0;
-}
-#endif
-
+#endif /* CLOCK_SETTIME_HELPERS_H */
diff --git a/testcases/open_posix_testsuite/include/clock.h b/testcases/open_posix_testsuite/include/clock.h
new file mode 100644
index 0000000000000000000000000000000000000000..9a97270cdc7a5ea5c5f52adc5a253eb55912d1aa
--- /dev/null
+++ b/testcases/open_posix_testsuite/include/clock.h
@@ -0,0 +1,77 @@
+/*
+ * Copyright (c) 2026, Linux Test Project
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PTS_CLOCK_H
+#define PTS_CLOCK_H
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <time.h>
+#include <unistd.h>
+
+static inline int pts_mono_available(void)
+{
+#ifdef CLOCK_MONOTONIC
+	if (_POSIX_MONOTONIC_CLOCK > 0)
+		return 1;
+
+	if (!_POSIX_MONOTONIC_CLOCK && sysconf(_SC_MONOTONIC_CLOCK) > 0)
+		return 1;
+#endif
+	return 0;
+}
+
+#define PTS_MONO_MAX_RETRIES 3
+
+static struct timespec pts_mono_start;
+
+static inline int pts_mono_time_start(void)
+{
+	if (!pts_mono_available()) {
+		static int warned;
+
+		if (!warned) {
+			printf("CLOCK_MONOTONIC unavailable, test may fail due to clock adjustment\n");
+			warned = 1;
+		}
+		return 0;
+	}
+
+#ifdef CLOCK_MONOTONIC
+	if (clock_gettime(CLOCK_MONOTONIC, &pts_mono_start) != 0) {
+		perror("clock_gettime(CLOCK_MONOTONIC) failed");
+		return -1;
+	}
+#endif
+	return 0;
+}
+
+static inline int pts_mono_time_check(unsigned int expected_secs)
+{
+#ifdef CLOCK_MONOTONIC
+	if (pts_mono_available()) {
+		struct timespec now;
+		long elapsed;
+
+		if (clock_gettime(CLOCK_MONOTONIC, &now) != 0) {
+			perror("clock_gettime(CLOCK_MONOTONIC) failed");
+			return -1;
+		}
+
+		elapsed = now.tv_sec - pts_mono_start.tv_sec;
+
+		if (labs(elapsed - (long)expected_secs) > 1) {
+			printf("Clock adjustment detected (elapsed %lds, expected ~%us)\n",
+			       elapsed, expected_secs);
+			return 1;
+		}
+		return 0;
+	}
+#endif
+	(void)expected_secs;
+	return 0;
+}
+
+#endif /* PTS_CLOCK_H */

---
base-commit: 73cfad509db014e5a631bd2298f4e9d8ea3ee1c1
change-id: 20260429-fix_clock_settime_helper-7670708ed94f

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
