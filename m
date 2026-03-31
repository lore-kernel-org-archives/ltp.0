Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43B751061B3F
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 12:43:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D69E03E2F7E
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 14:43:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D42E03C9314
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 14:43:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B8A591400770
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 14:43:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 00B585BCC3;
 Tue, 31 Mar 2026 12:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774960981; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2dZUmZMnw3F0IoY83OcmXK0joa1UAllf+kijxIg4BGw=;
 b=CkDu4bFx50SkZfpoN5v5uyTPgrLySeqjnAXxFIpWkYdrm9ELjDKGXiZH98cPtEfN0/CDob
 geX1AZvCQ71gm2Gab949MAfLF4gY/rPFRNx83J11wxFiSjx/GTIg73sAkxyD53Hx1o/vt9
 oTRYit5ZOgaSUAH3jY9yR+u+sdGitpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774960981;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2dZUmZMnw3F0IoY83OcmXK0joa1UAllf+kijxIg4BGw=;
 b=5WwJo+sbUvXOSAD763XANw1rs0/U+GzdAp4B4LYfOiTotwIjZfSwwViTwplVWycpykpVC0
 XFGcAUxArhpmNCDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774960979; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2dZUmZMnw3F0IoY83OcmXK0joa1UAllf+kijxIg4BGw=;
 b=kUEYARGJ+1PQQQDlTjQKiHyxNDish1ZmYKyLPg+qkcq3PndQmL6e3jGV7UimQhAhjBQKL2
 XAUdCX/cm3wwWhul9RD3kEKBjjsw3r1NZ1VlIZ688cCPb+kIqtaM9ooi9M3L94aN4X0lN2
 kTgoboHMqtsA9/MabR6fK1OQ4QsxL3g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774960979;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2dZUmZMnw3F0IoY83OcmXK0joa1UAllf+kijxIg4BGw=;
 b=6UB3uRbzYWysU0KL4fwvIbO3GxU7h+2dtQEch+V98YwwCh7r/qiLimzzpVVxfFGgKqkMFG
 DJfH3ENx4KI4d2Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C41594A0A2;
 Tue, 31 Mar 2026 12:42:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jMbMLVLBy2mhKAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 31 Mar 2026 12:42:58 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 31 Mar 2026 14:42:58 +0200
MIME-Version: 1.0
Message-Id: <20260331-nanosleep_posix_fix-v2-1-a0b72e6d586d@suse.com>
X-B4-Tracking: v=1; b=H4sIAFHBy2kC/32NQQqDMBBFryKzbooTaSJd9R4iEuJYB9pEMq1YJ
 Hdv6gG6fA/++zsIJSaBa7VDopWFYyigTxX42YU7KR4Lg661qZsGVXAhyoNoGZYovA0Tb8oYNNp
 575BGKMslUdFHtesLzyyvmD7HyYo/+7+3okJlna3t1Fq8tPomb6Gzj0/oc85fKaa3DLUAAAA=
X-Change-ID: 20260331-nanosleep_posix_fix-66162acca1ed
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774960978; l=11289;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=sDDzPrfLLFkMuIea4Z8QGR5Mnru/MTnxI72dqKgm308=;
 b=1uCc9LRFcAUzUgNa8WRZvgxvVs+Hg/DErJ91HYCjN6EHx+t4y0DXyrB504CkBnUAkmY0u6HZL
 LrwB4UtOtakAjhK1CNGd8Oc8sVXbYjOapN2QPRD6//zYRSZraEyV0gb
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[anthropic.com:email, suse.com:mid,
 suse.com:email, imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] nanosleep: Use CLOCK_MONOTONIC for elapsed time
 measurement
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
Cc: Claude <noreply@anthropic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Andrea Cervesato <andrea.cervesato@suse.com>

All nanosleep POSIX conformance tests used CLOCK_REALTIME to measure
elapsed sleep duration. CLOCK_REALTIME can jump due to NTP corrections,
VM time sync, or other wall-clock adjustments, causing sporadic test
failures where measured time far exceeds expected sleep duration.

Switch to CLOCK_MONOTONIC which is immune to wall-clock changes and is
the correct clock for measuring elapsed durations. Guard with
_POSIX_MONOTONIC_CLOCK and fall back to CLOCK_REALTIME with a warning
on systems where CLOCK_MONOTONIC is unavailable.

Co-authored-by: Claude <noreply@anthropic.com>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- introduce TEST_CLOCK to select the right available clock type
- print a message in case CLOCK_MONOTONIC is not available
- Link to v1: https://lore.kernel.org/r/20260331-nanosleep_posix_fix-v1-1-7a707f871582@suse.com
---
 .../conformance/interfaces/nanosleep/1-1.c                 | 14 ++++++++++++--
 .../conformance/interfaces/nanosleep/1-2.c                 | 14 ++++++++++++--
 .../conformance/interfaces/nanosleep/1-3.c                 | 14 ++++++++++++--
 .../conformance/interfaces/nanosleep/10000-1.c             | 14 ++++++++++++--
 .../conformance/interfaces/nanosleep/2-1.c                 | 14 ++++++++++++--
 .../conformance/interfaces/nanosleep/3-2.c                 | 14 ++++++++++++--
 .../conformance/interfaces/nanosleep/7-2.c                 | 14 ++++++++++++--
 7 files changed, 84 insertions(+), 14 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-1.c
index 687d01e288d914fbbdc18287746f71296c7a4327..75b34346f13d9b62e2333dbc78023a812fc9c908 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-1.c
@@ -12,13 +12,23 @@
 #include <time.h>
 #include "posixtest.h"
 
+#ifdef _POSIX_MONOTONIC_CLOCK
+#define TEST_CLOCK CLOCK_MONOTONIC
+#else
+#define TEST_CLOCK CLOCK_REALTIME
+#endif
+
 int main(void)
 {
 	struct timespec tssleepfor, tsstorage, tsbefore, tsafter;
 	int sleepnsec = 3;
 	int slepts = 0, sleptns = 0;
 
-	if (clock_gettime(CLOCK_REALTIME, &tsbefore) == -1) {
+#ifndef _POSIX_MONOTONIC_CLOCK
+	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
+#endif
+
+	if (clock_gettime(TEST_CLOCK, &tsbefore) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
@@ -30,7 +40,7 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
-	if (clock_gettime(CLOCK_REALTIME, &tsafter) == -1) {
+	if (clock_gettime(TEST_CLOCK, &tsafter) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-2.c
index 76f31982508dc87a4f400022cd46fe766071f27d..4a38bd507bba47792b942feb53954b95e92dc222 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-2.c
@@ -15,13 +15,23 @@
 #include <sys/wait.h>
 #include "posixtest.h"
 
+#ifdef _POSIX_MONOTONIC_CLOCK
+#define TEST_CLOCK CLOCK_MONOTONIC
+#else
+#define TEST_CLOCK CLOCK_REALTIME
+#endif
+
 int main(void)
 {
 	struct timespec tssleepfor, tsstorage, tsbefore, tsafter;
 	int sleepsec = 30;
 	int pid;
 
-	if (clock_gettime(CLOCK_REALTIME, &tsbefore) == -1) {
+#ifndef _POSIX_MONOTONIC_CLOCK
+	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
+#endif
+
+	if (clock_gettime(TEST_CLOCK, &tsbefore) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
@@ -46,7 +56,7 @@ int main(void)
 			perror("Error waiting for child to exit\n");
 			return PTS_UNRESOLVED;
 		}
-		if (clock_gettime(CLOCK_REALTIME, &tsafter) == -1) {
+		if (clock_gettime(TEST_CLOCK, &tsafter) == -1) {
 			perror("Error in clock_gettime()\n");
 			return PTS_UNRESOLVED;
 		}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-3.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-3.c
index 31ac00858018c3741758d0b5f2bf28f87aa6c1bf..7d5600788d6bc4682f228ccc7c669576827c397a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-3.c
@@ -16,6 +16,12 @@
 #include <sys/wait.h>
 #include "posixtest.h"
 
+#ifdef _POSIX_MONOTONIC_CLOCK
+#define TEST_CLOCK CLOCK_MONOTONIC
+#else
+#define TEST_CLOCK CLOCK_REALTIME
+#endif
+
 static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
 	printf("In handler\n");
@@ -28,7 +34,11 @@ int main(void)
 	int pid;
 	struct sigaction act;
 
-	if (clock_gettime(CLOCK_REALTIME, &tsbefore) == -1) {
+#ifndef _POSIX_MONOTONIC_CLOCK
+	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
+#endif
+
+	if (clock_gettime(TEST_CLOCK, &tsbefore) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
@@ -64,7 +74,7 @@ int main(void)
 			perror("Error waiting for child to exit\n");
 			return PTS_UNRESOLVED;
 		}
-		if (clock_gettime(CLOCK_REALTIME, &tsafter) == -1) {
+		if (clock_gettime(TEST_CLOCK, &tsafter) == -1) {
 			perror("Error in clock_gettime()\n");
 			return PTS_UNRESOLVED;
 		}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/10000-1.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/10000-1.c
index 883885df434fb4ba3bb555dd565880f14623a984..ebcf366acb52fd149f19951a6e4e0764bd503807 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/10000-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/10000-1.c
@@ -19,6 +19,12 @@
 #include <errno.h>
 #include "posixtest.h"
 
+#ifdef _POSIX_MONOTONIC_CLOCK
+#define TEST_CLOCK CLOCK_MONOTONIC
+#else
+#define TEST_CLOCK CLOCK_REALTIME
+#endif
+
 #define NUMVALID 6
 #define NUMINVALID 7
 
@@ -51,18 +57,22 @@ int main(void)
 	int failure = 0;
 	int slepts = 0, sleptns = 0;
 
+#ifndef _POSIX_MONOTONIC_CLOCK
+	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
+#endif
+
 	for (i = 0; i < NUMVALID; i++) {
 		tssleepfor.tv_sec = sleepvalid[i][0];
 		tssleepfor.tv_nsec = sleepvalid[i][1];
 		printf("sleep %d sec %d nsec\n",
 		       (int)tssleepfor.tv_sec, (int)tssleepfor.tv_nsec);
-		if (clock_gettime(CLOCK_REALTIME, &tsbefore) == -1) {
+		if (clock_gettime(TEST_CLOCK, &tsbefore) == -1) {
 			perror("Error in clock_gettime()\n");
 			return PTS_UNRESOLVED;
 		}
 
 		if (nanosleep(&tssleepfor, &tsstorage) == 0) {
-			if (clock_gettime(CLOCK_REALTIME, &tsafter) == -1) {
+			if (clock_gettime(TEST_CLOCK, &tsafter) == -1) {
 				perror("Error in clock_gettime()\n");
 				return PTS_UNRESOLVED;
 			}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/2-1.c
index cce3941e7be7212ea286647ec601d3ecbb9bb85a..8586e0ecec023029b60bce8ad5e1e72206daee34 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/2-1.c
@@ -13,6 +13,12 @@
 #include <time.h>
 #include "posixtest.h"
 
+#ifdef _POSIX_MONOTONIC_CLOCK
+#define TEST_CLOCK CLOCK_MONOTONIC
+#else
+#define TEST_CLOCK CLOCK_REALTIME
+#endif
+
 #define NUMINTERVALS 13
 int main(void)
 {
@@ -25,7 +31,11 @@ int main(void)
 	int failure = 0;
 	int slepts, sleptns;
 
-	if (clock_gettime(CLOCK_REALTIME, &tsbefore) == -1) {
+#ifndef _POSIX_MONOTONIC_CLOCK
+	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
+#endif
+
+	if (clock_gettime(TEST_CLOCK, &tsbefore) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
@@ -38,7 +48,7 @@ int main(void)
 			return PTS_UNRESOLVED;
 		}
 
-		if (clock_gettime(CLOCK_REALTIME, &tsafter) == -1) {
+		if (clock_gettime(TEST_CLOCK, &tsafter) == -1) {
 			perror("Error in clock_gettime()\n");
 			return PTS_UNRESOLVED;
 		}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-2.c
index bfc271edf25f9cd0f343eef11b335d5da20eb646..1329a7e988055ed3815e4e4037f331f576264d1a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-2.c
@@ -16,6 +16,12 @@
 #include <stdlib.h>
 #include "posixtest.h"
 
+#ifdef _POSIX_MONOTONIC_CLOCK
+#define TEST_CLOCK CLOCK_MONOTONIC
+#else
+#define TEST_CLOCK CLOCK_REALTIME
+#endif
+
 #define SLEEPSEC 5
 
 #define CHILDPASS 0		//if interrupted, child will return 0
@@ -26,7 +32,11 @@ int main(void)
 	int pid, slepts;
 	struct timespec tsbefore, tsafter;
 
-	if (clock_gettime(CLOCK_REALTIME, &tsbefore) != 0) {
+#ifndef _POSIX_MONOTONIC_CLOCK
+	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
+#endif
+
+	if (clock_gettime(TEST_CLOCK, &tsbefore) != 0) {
 		perror("clock_gettime() did not return success\n");
 		return PTS_UNRESOLVED;
 	}
@@ -74,7 +84,7 @@ int main(void)
 			return PTS_FAIL;
 		}
 
-		if (clock_gettime(CLOCK_REALTIME, &tsafter) == -1) {
+		if (clock_gettime(TEST_CLOCK, &tsafter) == -1) {
 			perror("Error in clock_gettime()\n");
 			return PTS_UNRESOLVED;
 		}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-2.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-2.c
index caf4470e4a26b27ec79deed27c147e2feceffdf8..70eeca9ff8eb10ac052b81f102853747a5066685 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-2.c
@@ -17,6 +17,12 @@
 #include <stdlib.h>
 #include "posixtest.h"
 
+#ifdef _POSIX_MONOTONIC_CLOCK
+#define TEST_CLOCK CLOCK_MONOTONIC
+#else
+#define TEST_CLOCK CLOCK_REALTIME
+#endif
+
 #define CHILDSUCCESS 1
 #define CHILDFAILURE 0
 
@@ -34,7 +40,11 @@ int main(void)
 	int pid;
 	struct sigaction act;
 
-	if (clock_gettime(CLOCK_REALTIME, &tsbefore) == -1) {
+#ifndef _POSIX_MONOTONIC_CLOCK
+	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
+#endif
+
+	if (clock_gettime(TEST_CLOCK, &tsbefore) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
@@ -60,7 +70,7 @@ int main(void)
 			return CHILDFAILURE;
 		}
 
-		if (clock_gettime(CLOCK_REALTIME, &tsafter) == -1) {
+		if (clock_gettime(TEST_CLOCK, &tsafter) == -1) {
 			perror("Error in clock_gettime()\n");
 			return CHILDFAILURE;
 		}

---
base-commit: 4688c20c01eece869b59e05ca3dd68c43e0d6af7
change-id: 20260331-nanosleep_posix_fix-66162acca1ed

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
