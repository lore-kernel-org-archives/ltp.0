Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56568FF885A
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 13:20:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6F703E620F
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 15:20:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC3043E17C4
 for <ltp@lists.linux.it>; Mon,  4 May 2026 15:20:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 172E4600799
 for <ltp@lists.linux.it>; Mon,  4 May 2026 15:20:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6C7986B1D9;
 Mon,  4 May 2026 13:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777900819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GXBSEev/XIauEByfBj9T1u9Mjsw1S3FL0ryKiTQ9kIY=;
 b=V8gbatKOw6VMER6aSfQfSnrdslH2BcrW9T3xKCPghmaEeHBjTfLnGw39FBYEEBaACM5YqD
 dnwpqjHGeBXMojF3jR88/NqU5yaj8GvwBlM42fJa00UBXmk/KIrcOFIdR8EuIwsrUUwa+t
 8ACNwOULOHs6kLkAurZslOAFwrjtG4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777900819;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GXBSEev/XIauEByfBj9T1u9Mjsw1S3FL0ryKiTQ9kIY=;
 b=Yq5eE02bknU4D0DTYdqHDy3DP1pI/JskwL4l40vBKG6qGfouivujIQ5x+/Dj/tAWgB5lqr
 eU6Jj3PxTu28ySCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=V8gbatKO;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Yq5eE02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777900819; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GXBSEev/XIauEByfBj9T1u9Mjsw1S3FL0ryKiTQ9kIY=;
 b=V8gbatKOw6VMER6aSfQfSnrdslH2BcrW9T3xKCPghmaEeHBjTfLnGw39FBYEEBaACM5YqD
 dnwpqjHGeBXMojF3jR88/NqU5yaj8GvwBlM42fJa00UBXmk/KIrcOFIdR8EuIwsrUUwa+t
 8ACNwOULOHs6kLkAurZslOAFwrjtG4o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777900819;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GXBSEev/XIauEByfBj9T1u9Mjsw1S3FL0ryKiTQ9kIY=;
 b=Yq5eE02bknU4D0DTYdqHDy3DP1pI/JskwL4l40vBKG6qGfouivujIQ5x+/Dj/tAWgB5lqr
 eU6Jj3PxTu28ySCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44384593A3;
 Mon,  4 May 2026 13:20:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wYxqDhOd+Gl/EAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 04 May 2026 13:20:19 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 04 May 2026 15:20:18 +0200
MIME-Version: 1.0
Message-Id: <20260504-fix_nanosleep_pts_get_clock-v1-1-754e299f929d@suse.com>
X-B4-Tracking: v=1; b=H4sIABGd+GkC/x3MUQqEIBRG4a3EfU6wKBnaSoSY/TWXCRVvRBDtP
 ZnHDw7nJkFmCA3VTRknC8dQ0NQV+a8LGxQvxdTq1uhed2rlywYXouxAsukQu+Gwfo/+p2Dmpfm
 YuV87TeWQMkr+v4/T87xGIHKsbQAAAA==
X-Change-ID: 20260504-fix_nanosleep_pts_get_clock-e6bd186b5f40
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777900819; l=13153;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=WdFV76zBSk7NpKtvJw66J1xCUnFp4gIzXqFoCRi+Ug8=;
 b=NKvl6Y4TDjOeAtzwV41b/WXsuK1JK82ulHCo7ZIrPx40ByBB7ffVp0XGlVHQDJukQDZA184Ru
 M0t5l5qnuWlDxEt76TOB38q8k3aTyPq+oK25qbRm72SnAfEJ2S0PR+S
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email,suse.de:dkim];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:mid,suse.com:email,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 6C7986B1D9
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] nanosleep: use POSIX runtime detection for
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

The compile-time #ifdef _POSIX_MONOTONIC_CLOCK check was incorrect:
three tests did not include <unistd.h> so the macro was never defined,
and on Linux/glibc it is set to 0 which requires a runtime sysconf()
check. This caused tests to silently fall back to CLOCK_REALTIME,
leading to sporadic failures when NTP or VM time sync adjusted the
wall clock during sleep.

Add pts_get_clock() to clock.h and use it in all nanosleep tests
to perform proper POSIX runtime detection via sysconf().

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .../conformance/interfaces/nanosleep/1-1.c               | 16 ++++------------
 .../conformance/interfaces/nanosleep/1-2.c               | 16 ++++------------
 .../conformance/interfaces/nanosleep/1-3.c               | 16 ++++------------
 .../conformance/interfaces/nanosleep/10000-1.c           | 16 ++++------------
 .../conformance/interfaces/nanosleep/2-1.c               | 16 ++++------------
 .../conformance/interfaces/nanosleep/3-2.c               | 16 ++++------------
 .../conformance/interfaces/nanosleep/7-2.c               | 16 ++++------------
 testcases/open_posix_testsuite/include/clock.h           |  9 +++++++++
 8 files changed, 37 insertions(+), 84 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-1.c
index 0f417715bf0a85e926eb9f1e0cf5cf5e9f172547..9d390e3206867b5555eade5a832d832e73c2a11d 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-1.c
@@ -11,24 +11,16 @@
 #include <stdio.h>
 #include <time.h>
 #include "posixtest.h"
-
-#ifdef _POSIX_MONOTONIC_CLOCK
-#define TEST_CLOCK CLOCK_MONOTONIC
-#else
-#define TEST_CLOCK CLOCK_REALTIME
-#endif
+#include "clock.h"
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
 	struct timespec tssleepfor, tsstorage, tsbefore, tsafter;
 	int sleepnsec = 3;
 	int slepts = 0, sleptns = 0;
+	clockid_t test_clock = pts_get_clock();
 
-#ifndef _POSIX_MONOTONIC_CLOCK
-	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
-#endif
-
-	if (clock_gettime(TEST_CLOCK, &tsbefore) == -1) {
+	if (clock_gettime(test_clock, &tsbefore) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
@@ -40,7 +32,7 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 		return PTS_UNRESOLVED;
 	}
 
-	if (clock_gettime(TEST_CLOCK, &tsafter) == -1) {
+	if (clock_gettime(test_clock, &tsafter) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-2.c
index 44697324aae218a0b67c32c69e01e01151478ff2..0d608d5127ea0dea5e64ab2b801bc1a5f05965f1 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-2.c
@@ -14,24 +14,16 @@
 #include <unistd.h>
 #include <sys/wait.h>
 #include "posixtest.h"
-
-#ifdef _POSIX_MONOTONIC_CLOCK
-#define TEST_CLOCK CLOCK_MONOTONIC
-#else
-#define TEST_CLOCK CLOCK_REALTIME
-#endif
+#include "clock.h"
 
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
 	struct timespec tssleepfor, tsstorage, tsbefore, tsafter;
 	int sleepsec = 30;
 	int pid;
+	clockid_t test_clock = pts_get_clock();
 
-#ifndef _POSIX_MONOTONIC_CLOCK
-	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
-#endif
-
-	if (clock_gettime(TEST_CLOCK, &tsbefore) == -1) {
+	if (clock_gettime(test_clock, &tsbefore) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
@@ -56,7 +48,7 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 			perror("Error waiting for child to exit\n");
 			return PTS_UNRESOLVED;
 		}
-		if (clock_gettime(TEST_CLOCK, &tsafter) == -1) {
+		if (clock_gettime(test_clock, &tsafter) == -1) {
 			perror("Error in clock_gettime()\n");
 			return PTS_UNRESOLVED;
 		}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-3.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-3.c
index 71a289552227086d5869c4dd8fbe2a5e0697fb61..a7ee7e02616bb412837700c60148fa89756ec48a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-3.c
@@ -15,12 +15,7 @@
 #include <unistd.h>
 #include <sys/wait.h>
 #include "posixtest.h"
-
-#ifdef _POSIX_MONOTONIC_CLOCK
-#define TEST_CLOCK CLOCK_MONOTONIC
-#else
-#define TEST_CLOCK CLOCK_REALTIME
-#endif
+#include "clock.h"
 
 static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
@@ -33,12 +28,9 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 	int sleepsec = 30;
 	int pid;
 	struct sigaction act;
+	clockid_t test_clock = pts_get_clock();
 
-#ifndef _POSIX_MONOTONIC_CLOCK
-	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
-#endif
-
-	if (clock_gettime(TEST_CLOCK, &tsbefore) == -1) {
+	if (clock_gettime(test_clock, &tsbefore) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
@@ -74,7 +66,7 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 			perror("Error waiting for child to exit\n");
 			return PTS_UNRESOLVED;
 		}
-		if (clock_gettime(TEST_CLOCK, &tsafter) == -1) {
+		if (clock_gettime(test_clock, &tsafter) == -1) {
 			perror("Error in clock_gettime()\n");
 			return PTS_UNRESOLVED;
 		}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/10000-1.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/10000-1.c
index e0575029fadd1828fd083ec43b0b96577cd85342..36cf5b90948fb59111f457d2a048f7b47d5df320 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/10000-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/10000-1.c
@@ -18,12 +18,7 @@
 #include <time.h>
 #include <errno.h>
 #include "posixtest.h"
-
-#ifdef _POSIX_MONOTONIC_CLOCK
-#define TEST_CLOCK CLOCK_MONOTONIC
-#else
-#define TEST_CLOCK CLOCK_REALTIME
-#endif
+#include "clock.h"
 
 #define NUMVALID 6
 #define NUMINVALID 7
@@ -56,23 +51,20 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 	int i;
 	int failure = 0;
 	int slepts = 0, sleptns = 0;
-
-#ifndef _POSIX_MONOTONIC_CLOCK
-	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
-#endif
+	clockid_t test_clock = pts_get_clock();
 
 	for (i = 0; i < NUMVALID; i++) {
 		tssleepfor.tv_sec = sleepvalid[i][0];
 		tssleepfor.tv_nsec = sleepvalid[i][1];
 		printf("sleep %d sec %d nsec\n",
 		       (int)tssleepfor.tv_sec, (int)tssleepfor.tv_nsec);
-		if (clock_gettime(TEST_CLOCK, &tsbefore) == -1) {
+		if (clock_gettime(test_clock, &tsbefore) == -1) {
 			perror("Error in clock_gettime()\n");
 			return PTS_UNRESOLVED;
 		}
 
 		if (nanosleep(&tssleepfor, &tsstorage) == 0) {
-			if (clock_gettime(TEST_CLOCK, &tsafter) == -1) {
+			if (clock_gettime(test_clock, &tsafter) == -1) {
 				perror("Error in clock_gettime()\n");
 				return PTS_UNRESOLVED;
 			}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/2-1.c
index d3eb514b5e7ef2382b1a93909f884cee0acb6b0b..82cf275066aa7b0c354b5633b41c8983873250e9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/2-1.c
@@ -12,12 +12,7 @@
 #include <stdio.h>
 #include <time.h>
 #include "posixtest.h"
-
-#ifdef _POSIX_MONOTONIC_CLOCK
-#define TEST_CLOCK CLOCK_MONOTONIC
-#else
-#define TEST_CLOCK CLOCK_REALTIME
-#endif
+#include "clock.h"
 
 #define NUMINTERVALS 13
 int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
@@ -30,12 +25,9 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 	int i;
 	int failure = 0;
 	int slepts, sleptns;
+	clockid_t test_clock = pts_get_clock();
 
-#ifndef _POSIX_MONOTONIC_CLOCK
-	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
-#endif
-
-	if (clock_gettime(TEST_CLOCK, &tsbefore) == -1) {
+	if (clock_gettime(test_clock, &tsbefore) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
@@ -48,7 +40,7 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 			return PTS_UNRESOLVED;
 		}
 
-		if (clock_gettime(TEST_CLOCK, &tsafter) == -1) {
+		if (clock_gettime(test_clock, &tsafter) == -1) {
 			perror("Error in clock_gettime()\n");
 			return PTS_UNRESOLVED;
 		}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-2.c
index 15fb7cd7cbece7ed352a74e56fde2161bbde060d..8f366d9dd16998d899291cf220296dfb6cdfb9a4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-2.c
@@ -15,12 +15,7 @@
 #include <sys/wait.h>
 #include <stdlib.h>
 #include "posixtest.h"
-
-#ifdef _POSIX_MONOTONIC_CLOCK
-#define TEST_CLOCK CLOCK_MONOTONIC
-#else
-#define TEST_CLOCK CLOCK_REALTIME
-#endif
+#include "clock.h"
 
 #define SLEEPSEC 5
 
@@ -31,12 +26,9 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
 	int pid, slepts;
 	struct timespec tsbefore, tsafter;
+	clockid_t test_clock = pts_get_clock();
 
-#ifndef _POSIX_MONOTONIC_CLOCK
-	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
-#endif
-
-	if (clock_gettime(TEST_CLOCK, &tsbefore) != 0) {
+	if (clock_gettime(test_clock, &tsbefore) != 0) {
 		perror("clock_gettime() did not return success\n");
 		return PTS_UNRESOLVED;
 	}
@@ -84,7 +76,7 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 			return PTS_FAIL;
 		}
 
-		if (clock_gettime(TEST_CLOCK, &tsafter) == -1) {
+		if (clock_gettime(test_clock, &tsafter) == -1) {
 			perror("Error in clock_gettime()\n");
 			return PTS_UNRESOLVED;
 		}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-2.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-2.c
index 58698b459defc9746b5acbdd6f9ca366a3668ccb..59ca2d2583f6ff4aca16451e7895b431a5d0d664 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-2.c
@@ -16,12 +16,7 @@
 #include <sys/wait.h>
 #include <stdlib.h>
 #include "posixtest.h"
-
-#ifdef _POSIX_MONOTONIC_CLOCK
-#define TEST_CLOCK CLOCK_MONOTONIC
-#else
-#define TEST_CLOCK CLOCK_REALTIME
-#endif
+#include "clock.h"
 
 #define CHILDSUCCESS 1
 #define CHILDFAILURE 0
@@ -39,12 +34,9 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 	int sleepsec = 30;
 	int pid;
 	struct sigaction act;
+	clockid_t test_clock = pts_get_clock();
 
-#ifndef _POSIX_MONOTONIC_CLOCK
-	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
-#endif
-
-	if (clock_gettime(TEST_CLOCK, &tsbefore) == -1) {
+	if (clock_gettime(test_clock, &tsbefore) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
@@ -70,7 +62,7 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 			return CHILDFAILURE;
 		}
 
-		if (clock_gettime(TEST_CLOCK, &tsafter) == -1) {
+		if (clock_gettime(test_clock, &tsafter) == -1) {
 			perror("Error in clock_gettime()\n");
 			return CHILDFAILURE;
 		}
diff --git a/testcases/open_posix_testsuite/include/clock.h b/testcases/open_posix_testsuite/include/clock.h
index 11c7e949fa4b9b9ba1473b6bd4b54ba70c5ff63c..0073db2c73e575ee537375e7cb571f5a98e14448 100644
--- a/testcases/open_posix_testsuite/include/clock.h
+++ b/testcases/open_posix_testsuite/include/clock.h
@@ -23,6 +23,15 @@ static inline int pts_mono_available(void)
 	return 0;
 }
 
+static inline clockid_t pts_get_clock(void)
+{
+	if (pts_mono_available())
+		return CLOCK_MONOTONIC;
+
+	printf("CLOCK_MONOTONIC unavailable, test may fail due to clock adjustment\n");
+	return CLOCK_REALTIME;
+}
+
 #define PTS_MONO_MAX_RETRIES 3
 
 static struct timespec pts_mono_start;

---
base-commit: 1ad07fa36483b27c781cad63f346e91986b3ac15
change-id: 20260504-fix_nanosleep_pts_get_clock-e6bd186b5f40

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
