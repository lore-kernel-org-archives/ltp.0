Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D04CAFF885D
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 12:25:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A4C93D073E
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 14:25:11 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC44B3C9B85
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 14:24:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 39D851A003D2
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 14:24:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 157006A83A;
 Tue, 28 Apr 2026 12:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777379091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HzzH64yGxX+IJzZd59TZINRbLor8Qp901vHQfFHENqk=;
 b=wfT/vGiOnDGAShA/vateCS9liLhBx40/A4mg4pklOKMf/exwlnym7x46BmN1XcPBj1/A53
 aFUw0BPjDQB+3VYhEOVK5Z1sp9OaRh8dYolLqytHdQMg6I2VYdiPkVgbBnUA16Fp5XflnQ
 IcfNDlI/ikPFj3FjOzWjHWtv1NEMD8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777379091;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HzzH64yGxX+IJzZd59TZINRbLor8Qp901vHQfFHENqk=;
 b=UaGvqW4cf+M2W18LU7X4jDEuXl/6WqJHcqtl4Hdr3L//fG28ptCQxezcoEJHNcWUtkQcUA
 IGDt23M87wtWKuAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="wfT/vGiO";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=UaGvqW4c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777379091; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HzzH64yGxX+IJzZd59TZINRbLor8Qp901vHQfFHENqk=;
 b=wfT/vGiOnDGAShA/vateCS9liLhBx40/A4mg4pklOKMf/exwlnym7x46BmN1XcPBj1/A53
 aFUw0BPjDQB+3VYhEOVK5Z1sp9OaRh8dYolLqytHdQMg6I2VYdiPkVgbBnUA16Fp5XflnQ
 IcfNDlI/ikPFj3FjOzWjHWtv1NEMD8I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777379091;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HzzH64yGxX+IJzZd59TZINRbLor8Qp901vHQfFHENqk=;
 b=UaGvqW4cf+M2W18LU7X4jDEuXl/6WqJHcqtl4Hdr3L//fG28ptCQxezcoEJHNcWUtkQcUA
 IGDt23M87wtWKuAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDB63593B0;
 Tue, 28 Apr 2026 12:24:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4x5QOBKn8GkLLAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 28 Apr 2026 12:24:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 28 Apr 2026 14:24:50 +0200
MIME-Version: 1.0
Message-Id: <20260428-fix_clock_settime_helper-v2-1-26cce3b7d706@suse.com>
X-B4-Tracking: v=1; b=H4sIABGn8GkC/42NUQ6CMBBEr0L225q2QVC/uIchRMpiNwIl3dpoS
 O9u5QR+vsnMmw0YPSHDtdjAYyQmt2TQhwKMvS8PFDRkBi11JUtViZHenZmceXaMIdCMncVpRS+
 Gsh7l0Et5qhHyfPWYu7v61ma2xMH5z/4U1S/9QxqVUEKf6zJX9UX1Y8MvxqNxM7QppS+MMFQBv
 wAAAA==
X-Change-ID: 20260416-fix_clock_settime_helper-d47f0db0057e
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777379090; l=5079;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=pgS1EXFWNt+JtXyk9qSzVMcN/zYmNJLE2nCbyjUrk4A=;
 b=i3xKHvnFgAE/GTCY5HrNFpg2USDtiznx6TtW8ZSx7PgnwQPpIw9Zw3G9OfxEMuVe45DY02VPo
 Q7KyWh44YqQDPA8I8mWRX5zD9tHglej6buNGWsaetPJitI98/Yrsarq
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:mid,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 157006A83A
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] clock_settime: use POSIX runtime detection for
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
Changes in v2:
- add testcases/open_posix_testsuite/include/clock.h helper
- Link to v1: https://lore.kernel.org/r/20260416-fix_clock_settime_helper-v1-1-2874202291bf@suse.com
---
 .../conformance/interfaces/clock_settime/helpers.h | 67 ++++++++++++----------
 testcases/open_posix_testsuite/include/clock.h     | 23 ++++++++
 2 files changed, 59 insertions(+), 31 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/helpers.h b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/helpers.h
index 37bf30926f039553e9e370751b7938ca5ea1d00a..2802b694133b90f478ee10073bcdfa0e34320f7d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/helpers.h
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/helpers.h
@@ -13,7 +13,12 @@
  * by those tests.
  */
 
+#ifndef CLOCK_SETTIME_HELPERS_H
+#define CLOCK_SETTIME_HELPERS_H
+
 #include <stdlib.h>
+#include <unistd.h>
+#include "clock.h"
 
 static int getBeforeTime(struct timespec *tpget)
 {
@@ -37,53 +42,53 @@ static int setBackTime(struct timespec tpset)
 
 #define PTS_MONO_MAX_RETRIES 3
 
-#ifdef _POSIX_MONOTONIC_CLOCK
-static struct timespec _pts_mono_start;
+static struct timespec pts_mono_start;
 
 static inline int pts_mono_time_start(void)
 {
-	if (clock_gettime(CLOCK_MONOTONIC, &_pts_mono_start) != 0) {
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
 		perror("clock_gettime(CLOCK_MONOTONIC) failed");
 		return -1;
 	}
+#endif
 	return 0;
 }
 
 static inline int pts_mono_time_check(unsigned int expected_secs)
 {
-	struct timespec now;
-	long elapsed;
-
-	if (clock_gettime(CLOCK_MONOTONIC, &now) != 0) {
-		perror("clock_gettime(CLOCK_MONOTONIC) failed");
-		return -1;
-	}
+#ifdef _POSIX_MONOTONIC_CLOCK
+	if (pts_mono_available()) {
+		struct timespec now;
+		long elapsed;
 
-	elapsed = now.tv_sec - _pts_mono_start.tv_sec;
+		if (clock_gettime(CLOCK_MONOTONIC, &now) != 0) {
+			perror("clock_gettime(CLOCK_MONOTONIC) failed");
+			return -1;
+		}
 
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
+		elapsed = now.tv_sec - pts_mono_start.tv_sec;
 
-	if (!warned) {
-		printf("CLOCK_MONOTONIC unavailable, test may fail due to clock adjustment\n");
-		warned = 1;
+		if (labs(elapsed - (long)expected_secs) > 1) {
+			printf("Clock adjustment detected (elapsed %lds, expected ~%us)\n",
+			       elapsed, expected_secs);
+			return 1;
+		}
+		return 0;
 	}
-	return 0;
-}
-
-static inline int pts_mono_time_check(unsigned int expected_secs)
-{
+#endif
 	(void)expected_secs;
 	return 0;
 }
-#endif
 
+#endif /* CLOCK_SETTIME_HELPERS_H */
diff --git a/testcases/open_posix_testsuite/include/clock.h b/testcases/open_posix_testsuite/include/clock.h
new file mode 100644
index 0000000000000000000000000000000000000000..351064f988bd1af75aa16da03bf8a545990bbbfc
--- /dev/null
+++ b/testcases/open_posix_testsuite/include/clock.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (c) 2026, Linux Test Project
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef PTS_CLOCK_H
+#define PTS_CLOCK_H
+
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
+#endif /* PTS_CLOCK_H */

---
base-commit: 068617a55d86f94c21cc8cbaef1c8dd7b31531e3
change-id: 20260416-fix_clock_settime_helper-d47f0db0057e

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
