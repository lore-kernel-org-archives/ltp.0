Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EDADF8A16D
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 12:34:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CD6D13E264F
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 14:34:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7F3A3C1E06
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 14:33:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E57AC200ACB
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 14:33:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 33D2C6A7EC;
 Thu, 16 Apr 2026 12:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776342835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+lc1Q1IiQa7A+4n/lLcvmuYAcs6fJtU/CkuDc1QgUGE=;
 b=1TVIZuZv0OhN6T20ShPlpRw3hJ+OTmtoE21CyX7MSR/rSc9OgY1SbH6Mzc7a+T8QXuwG1M
 1t9fqJEq6Gk8lRxpGfxn1ajdoVRKpxn5wPMU+y5+adVrRFjk6Qr/Ok0mbpOPuPRFloGoXK
 +/yfm8aDL/FA1jLn/Lz5t8hdxfJ2Afs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776342835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+lc1Q1IiQa7A+4n/lLcvmuYAcs6fJtU/CkuDc1QgUGE=;
 b=0GkvmJJ20Liqot/5yOYAwJBUOS4i19eNXxklks8YVxt45vVDm4kgQFqpKBtpreoZwZdmlw
 YJrJXOpup+5Na6BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1TVIZuZv;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0GkvmJJ2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776342835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+lc1Q1IiQa7A+4n/lLcvmuYAcs6fJtU/CkuDc1QgUGE=;
 b=1TVIZuZv0OhN6T20ShPlpRw3hJ+OTmtoE21CyX7MSR/rSc9OgY1SbH6Mzc7a+T8QXuwG1M
 1t9fqJEq6Gk8lRxpGfxn1ajdoVRKpxn5wPMU+y5+adVrRFjk6Qr/Ok0mbpOPuPRFloGoXK
 +/yfm8aDL/FA1jLn/Lz5t8hdxfJ2Afs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776342835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+lc1Q1IiQa7A+4n/lLcvmuYAcs6fJtU/CkuDc1QgUGE=;
 b=0GkvmJJ20Liqot/5yOYAwJBUOS4i19eNXxklks8YVxt45vVDm4kgQFqpKBtpreoZwZdmlw
 YJrJXOpup+5Na6BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BAC7593A3;
 Thu, 16 Apr 2026 12:33:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id unTBADPX4GmaIgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 16 Apr 2026 12:33:55 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 16 Apr 2026 14:33:49 +0200
MIME-Version: 1.0
Message-Id: <20260416-fix_nanosleep_include-v2-1-b3147763acb8@suse.com>
X-B4-Tracking: v=1; b=H4sIACzX4GkC/4WNUQqDMBBEryL73ZSsGJF+9R5FxCabumATyVZpk
 dy9qRfo5xtm3uwglJgELtUOiTYWjqFAfarATmN4kGJXGGpdt7rBVnl+D2EMUWaiZeBg59WRImd
 t5zV6TRrKdklUiof31heeWF4xfY6bDX/pP+OGCpU3XXM3xrTY4FVWobONT+hzzl9v5FiduQAAA
 A==
X-Change-ID: 20260416-fix_nanosleep_include-edcc8f01f0e0
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776342834; l=14089;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=nc2uUj9Eu0ycWT4qdaergJHuOcrAT7DlCaZI4XzcDrg=;
 b=KRloIGpF1DZ99O/hPpzcXFoM66fOUd6HbeW37UcMt//JOAD5ydAih3vfA5WoEM4Vs/3gDz3uV
 e44ZeZnMKLyBnBYLD35OrrepkMoEK4KrOcFYnbeQPN9vfPVj4dzWOSd
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 33D2C6A7EC
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] nanosleep: use POSIX runtime detection for
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

All nanosleep POSIX conformance tests used a compile-time #ifdef on
_POSIX_MONOTONIC_CLOCK to select the clock for measuring elapsed
sleep duration. This was incorrect for two reasons:

1. Three test files (1-1.c, 2-1.c, 10000-1.c) did not include
   <unistd.h>, so the macro was never defined and the tests silently
   fell back to CLOCK_REALTIME.

2. On Linux/glibc, _POSIX_MONOTONIC_CLOCK is defined as 0, meaning
   support is optional and must be verified at runtime via
   sysconf(_SC_MONOTONIC_CLOCK). The #ifdef treated 0 the same as
   >0 (always available), which is not POSIX-correct.

Using CLOCK_REALTIME caused sporadic test failures when NTP or VM
time sync adjusted the wall clock during sleep, producing results
like "slept 32s >> 10s".

Extract the clock selection logic into a shared helpers.h with a
get_supported_clock() function that performs proper POSIX runtime
detection via sysconf(), and use it across all affected tests.

Fixes: f992f6e25fce ("nanosleep: Use CLOCK_MONOTONIC for elapsed time measurement")
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Some nanosleep tests are not recognizing CLOCK_MONOTONIC at runtime
even if it's available:

CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments
sleep 0 sec 30000000 nsec
PASS - slept 0s30078623ns ~= 0s30000000ns
sleep 1 sec 0 nsec
PASS - slept 1s97618ns ~= 1s0ns
sleep 1 sec 30000000 nsec
PASS - slept 1s30109248ns ~= 1s30000000ns
sleep 2 sec 0 nsec
PASS - slept 2s147180ns ~= 2s0ns
sleep 10 sec 5000 nsec
FAIL - slept 32s630120452ns >> 10s5000ns
sleep 13 sec 5 nsec
PASS - slept 13s146848ns ~= 13s5ns
sleep -1 sec -1 nsec
sleep 0 sec -1 nsec
sleep 1 sec 1000000000 nsec
sleep 2 sec 1000000000 nsec
sleep -2147483647 sec -2147483647 nsec
sleep 1 sec 2147483647 nsec
sleep 0 sec 1075002478 nsec
At least one test FAILED
---
Changes in v2:
- add <unistd.h> to imports
- Link to v1: https://lore.kernel.org/r/20260416-fix_nanosleep_include-v1-1-f584b5556141@suse.com
---
 .../conformance/interfaces/nanosleep/1-1.c         | 16 ++++---------
 .../conformance/interfaces/nanosleep/1-2.c         | 16 ++++---------
 .../conformance/interfaces/nanosleep/1-3.c         | 16 ++++---------
 .../conformance/interfaces/nanosleep/10000-1.c     | 16 ++++---------
 .../conformance/interfaces/nanosleep/2-1.c         | 16 ++++---------
 .../conformance/interfaces/nanosleep/3-2.c         | 16 ++++---------
 .../conformance/interfaces/nanosleep/7-2.c         | 16 ++++---------
 .../conformance/interfaces/nanosleep/helpers.h     | 28 ++++++++++++++++++++++
 8 files changed, 56 insertions(+), 84 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-1.c
index 75b34346f13d9b62e2333dbc78023a812fc9c908..803569b138a1f17c0dede0c03406d3c7e52c4215 100644
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
+#include "helpers.h"
 
 int main(void)
 {
 	struct timespec tssleepfor, tsstorage, tsbefore, tsafter;
 	int sleepnsec = 3;
 	int slepts = 0, sleptns = 0;
+	clockid_t test_clock = get_supported_clock();
 
-#ifndef _POSIX_MONOTONIC_CLOCK
-	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
-#endif
-
-	if (clock_gettime(TEST_CLOCK, &tsbefore) == -1) {
+	if (clock_gettime(test_clock, &tsbefore) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
@@ -40,7 +32,7 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
-	if (clock_gettime(TEST_CLOCK, &tsafter) == -1) {
+	if (clock_gettime(test_clock, &tsafter) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-2.c
index 4a38bd507bba47792b942feb53954b95e92dc222..116510ea26ab6b7792c9aba5aa18eb7b926e59df 100644
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
+#include "helpers.h"
 
 int main(void)
 {
 	struct timespec tssleepfor, tsstorage, tsbefore, tsafter;
 	int sleepsec = 30;
 	int pid;
+	clockid_t test_clock = get_supported_clock();
 
-#ifndef _POSIX_MONOTONIC_CLOCK
-	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
-#endif
-
-	if (clock_gettime(TEST_CLOCK, &tsbefore) == -1) {
+	if (clock_gettime(test_clock, &tsbefore) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
@@ -56,7 +48,7 @@ int main(void)
 			perror("Error waiting for child to exit\n");
 			return PTS_UNRESOLVED;
 		}
-		if (clock_gettime(TEST_CLOCK, &tsafter) == -1) {
+		if (clock_gettime(test_clock, &tsafter) == -1) {
 			perror("Error in clock_gettime()\n");
 			return PTS_UNRESOLVED;
 		}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-3.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-3.c
index 7d5600788d6bc4682f228ccc7c669576827c397a..6baed5c89aa5ccb149f0a47da05b17c4880c06d4 100644
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
+#include "helpers.h"
 
 static void handler(int signo PTS_ATTRIBUTE_UNUSED)
 {
@@ -33,12 +28,9 @@ int main(void)
 	int sleepsec = 30;
 	int pid;
 	struct sigaction act;
+	clockid_t test_clock = get_supported_clock();
 
-#ifndef _POSIX_MONOTONIC_CLOCK
-	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
-#endif
-
-	if (clock_gettime(TEST_CLOCK, &tsbefore) == -1) {
+	if (clock_gettime(test_clock, &tsbefore) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
@@ -74,7 +66,7 @@ int main(void)
 			perror("Error waiting for child to exit\n");
 			return PTS_UNRESOLVED;
 		}
-		if (clock_gettime(TEST_CLOCK, &tsafter) == -1) {
+		if (clock_gettime(test_clock, &tsafter) == -1) {
 			perror("Error in clock_gettime()\n");
 			return PTS_UNRESOLVED;
 		}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/10000-1.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/10000-1.c
index ebcf366acb52fd149f19951a6e4e0764bd503807..c9d1cc303c629d7bbcf0fb4451103ef1729e4609 100644
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
+#include "helpers.h"
 
 #define NUMVALID 6
 #define NUMINVALID 7
@@ -56,23 +51,20 @@ int main(void)
 	int i;
 	int failure = 0;
 	int slepts = 0, sleptns = 0;
-
-#ifndef _POSIX_MONOTONIC_CLOCK
-	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
-#endif
+	clockid_t test_clock = get_supported_clock();
 
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
index 8586e0ecec023029b60bce8ad5e1e72206daee34..02b122a786ef4e735d4e74f1a96e5263cd7333b1 100644
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
+#include "helpers.h"
 
 #define NUMINTERVALS 13
 int main(void)
@@ -30,12 +25,9 @@ int main(void)
 	int i;
 	int failure = 0;
 	int slepts, sleptns;
+	clockid_t test_clock = get_supported_clock();
 
-#ifndef _POSIX_MONOTONIC_CLOCK
-	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
-#endif
-
-	if (clock_gettime(TEST_CLOCK, &tsbefore) == -1) {
+	if (clock_gettime(test_clock, &tsbefore) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
@@ -48,7 +40,7 @@ int main(void)
 			return PTS_UNRESOLVED;
 		}
 
-		if (clock_gettime(TEST_CLOCK, &tsafter) == -1) {
+		if (clock_gettime(test_clock, &tsafter) == -1) {
 			perror("Error in clock_gettime()\n");
 			return PTS_UNRESOLVED;
 		}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-2.c
index 1329a7e988055ed3815e4e4037f331f576264d1a..2110e0ddad36877150ba4aacaaf28a079207539a 100644
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
+#include "helpers.h"
 
 #define SLEEPSEC 5
 
@@ -31,12 +26,9 @@ int main(void)
 {
 	int pid, slepts;
 	struct timespec tsbefore, tsafter;
+	clockid_t test_clock = get_supported_clock();
 
-#ifndef _POSIX_MONOTONIC_CLOCK
-	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
-#endif
-
-	if (clock_gettime(TEST_CLOCK, &tsbefore) != 0) {
+	if (clock_gettime(test_clock, &tsbefore) != 0) {
 		perror("clock_gettime() did not return success\n");
 		return PTS_UNRESOLVED;
 	}
@@ -84,7 +76,7 @@ int main(void)
 			return PTS_FAIL;
 		}
 
-		if (clock_gettime(TEST_CLOCK, &tsafter) == -1) {
+		if (clock_gettime(test_clock, &tsafter) == -1) {
 			perror("Error in clock_gettime()\n");
 			return PTS_UNRESOLVED;
 		}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-2.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-2.c
index 70eeca9ff8eb10ac052b81f102853747a5066685..16e44e142473188cdfab70e4d1d334e0bed71d1c 100644
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
+#include "helpers.h"
 
 #define CHILDSUCCESS 1
 #define CHILDFAILURE 0
@@ -39,12 +34,9 @@ int main(void)
 	int sleepsec = 30;
 	int pid;
 	struct sigaction act;
+	clockid_t test_clock = get_supported_clock();
 
-#ifndef _POSIX_MONOTONIC_CLOCK
-	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
-#endif
-
-	if (clock_gettime(TEST_CLOCK, &tsbefore) == -1) {
+	if (clock_gettime(test_clock, &tsbefore) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
@@ -70,7 +62,7 @@ int main(void)
 			return CHILDFAILURE;
 		}
 
-		if (clock_gettime(TEST_CLOCK, &tsafter) == -1) {
+		if (clock_gettime(test_clock, &tsafter) == -1) {
 			perror("Error in clock_gettime()\n");
 			return CHILDFAILURE;
 		}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/helpers.h b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/helpers.h
new file mode 100644
index 0000000000000000000000000000000000000000..a70e4c290c76c61adc55e9b006b65597dde4677d
--- /dev/null
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/helpers.h
@@ -0,0 +1,28 @@
+/*
+ * Copyright (c) 2026, Linux Test Project
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef NANOSLEEP_HELPERS_H
+#define NANOSLEEP_HELPERS_H
+
+#include <stdio.h>
+#include <unistd.h>
+#include <time.h>
+
+static inline clockid_t get_supported_clock(void)
+{
+#ifdef _POSIX_MONOTONIC_CLOCK
+	if (_POSIX_MONOTONIC_CLOCK > 0)
+		return CLOCK_MONOTONIC;
+
+	if (!_POSIX_MONOTONIC_CLOCK && sysconf(_SC_MONOTONIC_CLOCK) > 0)
+		return CLOCK_MONOTONIC;
+#endif
+
+	printf("CLOCK_MONOTONIC unavailable, test may fail due to "
+	       "external clock adjustments\n");
+	return CLOCK_REALTIME;
+}
+
+#endif /* NANOSLEEP_HELPERS_H */

---
base-commit: 620d596c79493af089ba6a1c4dc79efcc76a67c7
change-id: 20260416-fix_nanosleep_include-edcc8f01f0e0

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
