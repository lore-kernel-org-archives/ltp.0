Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22762F8A171
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 13:01:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC9AD3E4AD2
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 15:01:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68AAD3E1685
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 15:01:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1E702600AD1
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 15:01:02 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6CF875BD7D;
 Thu, 16 Apr 2026 13:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776344462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DsjoFYEYgu/QbZu8RRooZNushuASSxkldLeCQiDB7Co=;
 b=Ma7fQros/G0zdA49Z40Xg09Na251kVIojUXWoqxzs2VVxtY6XSnVTHd9O+9uVFvmn/sqdt
 kci1f1ylCfCG7+7emDLojPjI/jwGu2/xKPN49tHBdpws8uN/g0STmM+T/To2ahGmrFhgos
 iWN9e7mqI4vpdJ5bkCVzGcgg3SNaOrg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776344462;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DsjoFYEYgu/QbZu8RRooZNushuASSxkldLeCQiDB7Co=;
 b=7t/sLOMyJeeFaFHBXrAybivsqhgJHSwNNZK2cmivcjjNpHAg3b6uRG9dXbBqhmBkuugBzL
 seaxrOC5JTqoZdCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776344461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DsjoFYEYgu/QbZu8RRooZNushuASSxkldLeCQiDB7Co=;
 b=A5dwI5/lAjhr7OLxeX2kFbqrQyh+Gh52Er+LRkjCztBAuPYNIIbo9uuxFL9JuU5hSY5rQY
 itlpgBDoMF7ACSAbumsicVvTg1RjUnkTk4LbAVNCqjcNbr6JjfD8sL/nZkuDqS0noZfHkk
 8XFN8TSfoQiB7lfeMxLRZ9kp9gZudmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776344461;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DsjoFYEYgu/QbZu8RRooZNushuASSxkldLeCQiDB7Co=;
 b=J3bLZwYTisD3lyqaxtuukq6W8B9Xw7O6MA1X5rQodgRqMrgE6jReQnio8sqZoybPF8BNUm
 ZnqbnaYgiGkPTxCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B2FF593A3;
 Thu, 16 Apr 2026 13:01:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id szMMEI3d4GnUPQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 16 Apr 2026 13:01:01 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 Apr 2026 15:01:00 +0200
MIME-Version: 1.0
Message-Id: <20260416-fix_clock_settime_helper-v1-1-2874202291bf@suse.com>
X-B4-Tracking: v=1; b=H4sIAIvd4GkC/x2MSwqAMBDFriKztjCKH/AqIkXbpw5+aYsI4t0tL
 gNJHvJwAk9N8pDDJV6OPUKWJmTmfp+gxEamnPOKi6xSo9zarIdZtEcIskHPWE84ZYt6ZDswlzU
 o5qdDdP91273vB/Kw6CBqAAAA
X-Change-ID: 20260416-fix_clock_settime_helper-d47f0db0057e
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776344461; l=4148;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=70LUBT04Z3zHf5DWXoaacy5QinYOUj1McgJT5YOW/Mc=;
 b=b4w30k5dQ5dPzhslAJgOTwassrH+ZAU+OcoGN58ms9sPkFfiVFoTyzGN1xYgIKO2iIO5LUYk0
 xAV30qVfNDJAaWhW6S1itwdQ0h+bH0w1Be+DZg9ZmhdoihOeuaneayd
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
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] clock_settime: use POSIX runtime detection for
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
via sysconf(). Also add a missing #ifndef include guard and
#include <unistd.h> so _POSIX_MONOTONIC_CLOCK is always defined.

Fixes: 9ecb4a004b18 ("clock_settime: Detect external clock adjustments via CLOCK_MONOTONIC")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .../conformance/interfaces/clock_settime/helpers.h | 76 +++++++++++++---------
 1 file changed, 46 insertions(+), 30 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/helpers.h b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/helpers.h
index 37bf30926f039553e9e370751b7938ca5ea1d00a..b568ec8122d3bba8246b09a5b694f1263084a408 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/helpers.h
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/helpers.h
@@ -13,7 +13,11 @@
  * by those tests.
  */
 
+#ifndef CLOCK_SETTIME_HELPERS_H
+#define CLOCK_SETTIME_HELPERS_H
+
 #include <stdlib.h>
+#include <unistd.h>
 
 static int getBeforeTime(struct timespec *tpget)
 {
@@ -37,53 +41,65 @@ static int setBackTime(struct timespec tpset)
 
 #define PTS_MONO_MAX_RETRIES 3
 
+static struct timespec pts_mono_start;
+
+static inline int pts_mono_available(void)
+{
 #ifdef _POSIX_MONOTONIC_CLOCK
-static struct timespec _pts_mono_start;
+	if (_POSIX_MONOTONIC_CLOCK > 0)
+		return 1;
+
+	if (!_POSIX_MONOTONIC_CLOCK && sysconf(_SC_MONOTONIC_CLOCK) > 0)
+		return 1;
+#endif
+	return 0;
+}
 
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

---
base-commit: 620d596c79493af089ba6a1c4dc79efcc76a67c7
change-id: 20260416-fix_clock_settime_helper-d47f0db0057e

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
