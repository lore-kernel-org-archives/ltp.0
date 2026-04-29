Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 152ACFF8864
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 08:29:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A25D33E2D47
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 10:29:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 83D693D7220
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 10:28:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 055351000A27
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 10:28:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4B50E5BD55;
 Wed, 29 Apr 2026 08:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777451317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qt6B9B0EYPllMwPBsYYfd4Tu4JHQoumRSUrDH5aByB8=;
 b=Bu0VURgYb4RIDEPqERYJ5XPsrj9aIorsCV5uULb9Ev2Q492ilRd2JhVMnF0mjFawJEVYQ5
 wi+nNZuad9yyC1g8MKNIpIcY7sLYo2Svfiq4vzktE/dJInXwlPWfYK8NUZWDSlCDc1O6d6
 ZD3hZi59kJWuRo2qLjdfrGjCNYUui7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777451317;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qt6B9B0EYPllMwPBsYYfd4Tu4JHQoumRSUrDH5aByB8=;
 b=AQn1X7ovjLJTqDqn2EWOWuvAUHsEuXvP7/kvHAMRXHkzSaPVqZ+eV+vXpsfFCclvvBoao6
 9Cks7DdB2/r7nKCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777451317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qt6B9B0EYPllMwPBsYYfd4Tu4JHQoumRSUrDH5aByB8=;
 b=Bu0VURgYb4RIDEPqERYJ5XPsrj9aIorsCV5uULb9Ev2Q492ilRd2JhVMnF0mjFawJEVYQ5
 wi+nNZuad9yyC1g8MKNIpIcY7sLYo2Svfiq4vzktE/dJInXwlPWfYK8NUZWDSlCDc1O6d6
 ZD3hZi59kJWuRo2qLjdfrGjCNYUui7E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777451317;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qt6B9B0EYPllMwPBsYYfd4Tu4JHQoumRSUrDH5aByB8=;
 b=AQn1X7ovjLJTqDqn2EWOWuvAUHsEuXvP7/kvHAMRXHkzSaPVqZ+eV+vXpsfFCclvvBoao6
 9Cks7DdB2/r7nKCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29DDC593B0;
 Wed, 29 Apr 2026 08:28:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pJ4jCDXB8WkpdwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 29 Apr 2026 08:28:37 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 29 Apr 2026 10:28:35 +0200
MIME-Version: 1.0
Message-Id: <20260429-fix_clock_settime_helper-v3-1-2608c39d8499@suse.com>
X-B4-Tracking: v=1; b=H4sIADLB8WkC/3XMQQ6CMBSE4auQt7amFtKCK+9hDMF2kEagpK8SE
 8LdbVy5cfknM99GjOjBdC42ilg9+zDnKA8F2aGbHxDe5SYllZaVakTv360dg322jJT8hHbAuCA
 Ko400soZrqp7yfYnI2y99veXuY5hEGiK6X7D+D65KnITS1qK8G2ekvvCLcbRhon3/AOVZDeS5A
 AAA
X-Change-ID: 20260429-fix_clock_settime_helper-7670708ed94f
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777451317; l=8467;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=ypAJKb2QJBM/OasLlJTAT8siIVcmGCzmSTWJ0Z8Mk3w=;
 b=4D7HbgblEPix3FS16xUEvHhKKeGxfIUGKuX0jXaj83+TZJeeRitO9NYMDNxoVLFBwzgax3krp
 w9GSp3N5MMBDL2WbOqaIknbUdbIo5hEvnTeQPnj2qScnLckRHvHU15m
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] clock_settime: use POSIX runtime detection for
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
index 0000000000000000000000000000000000000000..221dd38ff34b627aa5f6c07825cd7439cf559c74
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
+#ifdef _POSIX_MONOTONIC_CLOCK
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
+#ifdef _POSIX_MONOTONIC_CLOCK
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
+#ifdef _POSIX_MONOTONIC_CLOCK
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
base-commit: 1d2ea5b042a6c6c169689efebd856583200c564f
change-id: 20260429-fix_clock_settime_helper-7670708ed94f

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
