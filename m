Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37A6D3514B
	for <ltp@archiver.kernel.org>; Wed,  1 Apr 2026 07:21:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E2003E2F65
	for <ltp@archiver.kernel.org>; Wed,  1 Apr 2026 09:21:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A0233CC387
 for <ltp@lists.linux.it>; Wed,  1 Apr 2026 09:21:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3E264200AC1
 for <ltp@lists.linux.it>; Wed,  1 Apr 2026 09:21:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2BA494D1E6;
 Wed,  1 Apr 2026 07:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775028081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Lg/89ZpKpaNq1bb8r72HR+xYfj1NVx//5bSGEL3grw=;
 b=2MpSUHcIP0iIQ7XVQwMlB9jgbHW44lHom2+U4ZMCtt8jWrMWpi6aUePe7OuU9M7f0u49eV
 cajKknM389UwIwVm6qBL34s+IBUtGEhSLKxAJGnO5tdq9qnO+9t9YQDZWL5mW/2p7JEB2d
 /Nclj4sOsqyvrHw2VLiDytXBngKZlvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775028081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Lg/89ZpKpaNq1bb8r72HR+xYfj1NVx//5bSGEL3grw=;
 b=DQsN+eTVHPBId+becPovX8J0EGWqbuL8S1rMSYCR21nF/d/nbTzG3sofpwr2hjmDPNA7H9
 DqhrDhggXj+tn/AA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2MpSUHcI;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DQsN+eTV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775028081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Lg/89ZpKpaNq1bb8r72HR+xYfj1NVx//5bSGEL3grw=;
 b=2MpSUHcIP0iIQ7XVQwMlB9jgbHW44lHom2+U4ZMCtt8jWrMWpi6aUePe7OuU9M7f0u49eV
 cajKknM389UwIwVm6qBL34s+IBUtGEhSLKxAJGnO5tdq9qnO+9t9YQDZWL5mW/2p7JEB2d
 /Nclj4sOsqyvrHw2VLiDytXBngKZlvo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775028081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5Lg/89ZpKpaNq1bb8r72HR+xYfj1NVx//5bSGEL3grw=;
 b=DQsN+eTVHPBId+becPovX8J0EGWqbuL8S1rMSYCR21nF/d/nbTzG3sofpwr2hjmDPNA7H9
 DqhrDhggXj+tn/AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EF9324A0B0;
 Wed,  1 Apr 2026 07:21:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3mqlOHDHzGlXQAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 01 Apr 2026 07:21:20 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 01 Apr 2026 09:21:19 +0200
MIME-Version: 1.0
Message-Id: <20260401-clock_settime_fix-v3-1-f2d303703bd7@suse.com>
X-B4-Tracking: v=1; b=H4sIAG7HzGkC/4XNQQ6CMBCF4auQWVvTTkkRV97DGALtVBqFmhYbD
 eHuFlaudPm/ZL6ZIVJwFOFYzBAouej8mEPuCtB9O16JOZMbkKPiUgqm717fmkjT5AZqrHuxA5V
 CVEZ3iteQ7x6B8ryZ50vu3sXJh/f2Iol1/aUlwQQztiWujMVSqlN8RtprP8CKJfwLYAYIES3Jq
 u7EN7Asywf7QGLP8gAAAA==
X-Change-ID: 20260331-clock_settime_fix-8e4117dcb609
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775028080; l=23647;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=wdXs0GYG+UslE1DEIKKHybORbh7ESjYUPqIID/fpv6A=;
 b=jFaJV+3lZpdiqc26VHzltX2J8J6bNva1p2QZdpbbKteV4jj60IN6CT0Kee4+Woq6mUM80juwq
 8+bERV+QBxWBJ5wbhGY/w653auoHF0d5e300596G0Ot9IbyqHNSlK+P
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
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.com:mid,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 2BA494D1E6
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] clock_settime: Detect external clock adjustments
 via CLOCK_MONOTONIC
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

These tests manipulate CLOCK_REALTIME to verify timer and
clock_nanosleep behavior, but NTP or VM time sync can also adjust
CLOCK_REALTIME during the test, causing timers to fire at wrong times
and producing sporadic failures.

Add pts_mono_time_start()/pts_mono_time_check() helpers to detect
external clock interference using CLOCK_MONOTONIC. When interference
is detected, the test retries up to PTS_MONO_MAX_RETRIES times before
reporting UNTESTED. Guard with _POSIX_MONOTONIC_CLOCK since
CLOCK_MONOTONIC is optional in POSIX.1-2001.

Co-authored-by: Claude <noreply@anthropic.com>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
I used Claude to generate the right patches to fix sporadic issues in the
clock_settime testing suite. We tried many attempt for fixing it, but the
CLOCK_REALTIME usage seems to be the real issue in here. The idea is that
we use internal Openposix mechanisms to skip tests if CLOCK_MONOTONIC
usage spots a possible interference from external tools.
---
Changes in v3:
- cycle multiple times before failing the tests
	- add helpers functions for CLOCK_MONOTONIC checks
- Link to v2: https://lore.kernel.org/r/20260331-clock_settime_fix-v2-1-e222fe379b16@suse.com

Changes in v2:
- print a message if CLOCK_MONOTONIC is not available
- always verify that CLOCK_MONOTONIC is available
- Link to v1: https://lore.kernel.org/r/20260331-clock_settime_fix-v1-1-dfae06df2436@suse.com
---
 .../conformance/interfaces/clock_settime/4-1.c     |  82 +++++++++-------
 .../conformance/interfaces/clock_settime/5-1.c     |  67 ++++++++-----
 .../conformance/interfaces/clock_settime/5-2.c     |  57 +++++++----
 .../conformance/interfaces/clock_settime/7-1.c     |  90 ++++++++++--------
 .../conformance/interfaces/clock_settime/7-2.c     | 105 ++++++++++++---------
 .../conformance/interfaces/clock_settime/helpers.h |  47 +++++++++
 .../conformance/interfaces/nanosleep/7-1.c         |  50 +++++-----
 7 files changed, 308 insertions(+), 190 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c
index f8a3e9c542ca8c9767cdd0057005e519f58b2b55..fd846f6bc9ae9a3fc4f1c51a141ec216b17b5292 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c
@@ -47,7 +47,7 @@ int main(void)
 	int delta;
 	int sig;
 	sigset_t set;
-	int flags = 0;
+	int attempt;
 
 	/* Check that we're root...can't call clock_settime with CLOCK_REALTIME otherwise */
 	if (geteuid() != 0) {
@@ -77,49 +77,61 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
-	if (clock_gettime(CLOCK_REALTIME, &tpT0) != 0) {
-		perror("clock_gettime() was not successful\n");
-		return PTS_UNRESOLVED;
-	}
-
 	if (timer_create(CLOCK_REALTIME, &ev, &tid) != 0) {
 		perror("timer_create() did not return success\n");
 		return PTS_UNRESOLVED;
 	}
 
-	flags |= TIMER_ABSTIME;
-	its.it_interval.tv_sec = 0;
-	its.it_interval.tv_nsec = 0;
-	its.it_value.tv_sec = tpT0.tv_sec + TIMEROFFSET;
-	its.it_value.tv_nsec = tpT0.tv_nsec;
-	if (timer_settime(tid, flags, &its, NULL) != 0) {
-		perror("timer_settime() did not return success\n");
-		return PTS_UNRESOLVED;
-	}
-
-	sleep(SLEEPTIME);
-	getBeforeTime(&tpreset);
-	if (clock_settime(CLOCK_REALTIME, &tpT0) != 0) {
-		perror("clock_settime() was not successful");
-		return PTS_UNRESOLVED;
-	}
-
-	if (sigwait(&set, &sig) == -1) {
-		perror("sigwait() was not successful\n");
-		return PTS_UNRESOLVED;
+	for (attempt = 0; attempt < PTS_MONO_MAX_RETRIES; attempt++) {
+		if (clock_gettime(CLOCK_REALTIME, &tpT0) != 0) {
+			perror("clock_gettime() was not successful\n");
+			return PTS_UNRESOLVED;
+		}
+
+		pts_mono_time_start();
+
+		its.it_interval.tv_sec = 0;
+		its.it_interval.tv_nsec = 0;
+		its.it_value.tv_sec = tpT0.tv_sec + TIMEROFFSET;
+		its.it_value.tv_nsec = tpT0.tv_nsec;
+		if (timer_settime(tid, TIMER_ABSTIME, &its, NULL) != 0) {
+			perror("timer_settime() did not return success\n");
+			return PTS_UNRESOLVED;
+		}
+
+		sleep(SLEEPTIME);
+		getBeforeTime(&tpreset);
+		if (clock_settime(CLOCK_REALTIME, &tpT0) != 0) {
+			perror("clock_settime() was not successful");
+			return PTS_UNRESOLVED;
+		}
+
+		if (sigwait(&set, &sig) == -1) {
+			perror("sigwait() was not successful\n");
+			return PTS_UNRESOLVED;
+		}
+
+		if (clock_gettime(CLOCK_REALTIME, &tpT2) != 0) {
+			printf("clock_gettime() was not successful\n");
+			return PTS_UNRESOLVED;
+		}
+
+		delta = tpT2.tv_sec - its.it_value.tv_sec;
+
+		// add back time waited to reset value and reset time
+		tpreset.tv_sec += tpT2.tv_sec - tpT0.tv_sec;
+		setBackTime(tpreset);
+
+		if (pts_mono_time_check(SLEEPTIME + TIMEROFFSET))
+			break;
 	}
 
-	if (clock_gettime(CLOCK_REALTIME, &tpT2) != 0) {
-		printf("clock_gettime() was not successful\n");
-		return PTS_UNRESOLVED;
+	if (attempt == PTS_MONO_MAX_RETRIES) {
+		printf("UNTESTED: persistent clock interference after %d attempts\n",
+		       PTS_MONO_MAX_RETRIES);
+		return PTS_UNTESTED;
 	}
 
-	delta = tpT2.tv_sec - its.it_value.tv_sec;
-
-	// add back time waited to reset value and reset time
-	tpreset.tv_sec += tpT2.tv_sec - tpT0.tv_sec;
-	setBackTime(tpreset);
-
 	printf("delta: %d\n", delta);
 	if ((delta <= ACCEPTABLEDELTA) && (delta >= 0)) {
 		printf("Test PASSED\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-1.c
index 75fa591e014601b2ef9308a118992a704365392b..76aedcf64c1482f030d74f3e3e7baccb3416701f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-1.c
@@ -49,6 +49,8 @@ int main(void)
 	struct itimerspec its;
 	timer_t tid;
 	sigset_t set;
+	int ns_ret;
+	int attempt;
 
 	/* Check that we're root...can't call clock_settime with CLOCK_REALTIME otherwise */
 	if (getuid() != 0) {
@@ -92,42 +94,59 @@ int main(void)
 	its.it_value.tv_sec = TIMERSEC;
 	its.it_value.tv_nsec = 0;
 
-	if (timer_settime(tid, 0, &its, NULL) != 0) {
-		perror("timer_settime() did not return success\n");
-		return PTS_UNRESOLVED;
-	}
+	for (attempt = 0; attempt < PTS_MONO_MAX_RETRIES; attempt++) {
+		if (timer_settime(tid, 0, &its, NULL) != 0) {
+			perror("timer_settime() did not return success\n");
+			return PTS_UNRESOLVED;
+		}
 
-	if (clock_gettime(CLOCK_REALTIME, &tsclock) != 0) {
-		printf("clock_gettime() did not return success\n");
-		return PTS_UNRESOLVED;
-	}
+		pts_mono_time_start();
 
-	tsclock.tv_sec -= CLOCKOFFSET;
-	getBeforeTime(&tsreset);
-	if (clock_settime(CLOCK_REALTIME, &tsclock) != 0) {
-		printf("clock_settime() was not successful\n");
-		return PTS_UNRESOLVED;
+		if (clock_gettime(CLOCK_REALTIME, &tsclock) != 0) {
+			printf("clock_gettime() did not return success\n");
+			return PTS_UNRESOLVED;
+		}
+
+		tsclock.tv_sec -= CLOCKOFFSET;
+		getBeforeTime(&tsreset);
+		if (clock_settime(CLOCK_REALTIME, &tsclock) != 0) {
+			printf("clock_settime() was not successful\n");
+			return PTS_UNRESOLVED;
+		}
+
+		ts.tv_sec = TIMERSEC + SLEEPDELTA;
+		ts.tv_nsec = 0;
+
+		ns_ret = nanosleep(&ts, &tsleft);
+
+		if (pts_mono_time_check(TIMERSEC)) {
+			tsreset.tv_sec += TIMERSEC;
+			setBackTime(tsreset);
+			break;
+		}
+
+		tsreset.tv_sec += TIMERSEC;
+		setBackTime(tsreset);
 	}
 
-	ts.tv_sec = TIMERSEC + SLEEPDELTA;
-	ts.tv_nsec = 0;
+	if (attempt == PTS_MONO_MAX_RETRIES) {
+		printf("UNTESTED: persistent clock interference after %d attempts\n",
+		       PTS_MONO_MAX_RETRIES);
+		return PTS_UNTESTED;
+	}
 
-	if (nanosleep(&ts, &tsleft) != -1) {
+	if (ns_ret != -1) {
 		printf("nanosleep() not interrupted\n");
 		return PTS_FAIL;
 	}
 
 	if (labs(tsleft.tv_sec - SLEEPDELTA) <= ACCEPTABLEDELTA) {
 		printf("Test PASSED\n");
-		tsreset.tv_sec += TIMERSEC;
-		setBackTime(tsreset);
 		return PTS_PASS;
-	} else {
-		printf("Timer did not last for correct amount of time\n");
-		printf("timer: %d != correct %d\n",
-		       (int)ts.tv_sec - (int)tsleft.tv_sec, TIMERSEC);
-		return PTS_FAIL;
 	}
 
-	return PTS_UNRESOLVED;
+	printf("Timer did not last for correct amount of time\n");
+	printf("timer: %d != correct %d\n",
+	       (int)ts.tv_sec - (int)tsleft.tv_sec, TIMERSEC);
+	return PTS_FAIL;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-2.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-2.c
index b8a60028c6d3d1a3c0d75922f39697b57329c440..d1fe7b6e330827474adc398c923b4e7dffb0a3b8 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-2.c
@@ -49,6 +49,8 @@ int main(void)
 	struct itimerspec its;
 	timer_t tid;
 	sigset_t set;
+	int ns_ret;
+	int attempt;
 
 	/* Check that we're root...can't call clock_settime with CLOCK_REALTIME otherwise */
 	if (getuid() != 0) {
@@ -92,35 +94,54 @@ int main(void)
 	its.it_value.tv_sec = TIMERSEC;
 	its.it_value.tv_nsec = 0;
 
-	if (timer_settime(tid, 0, &its, NULL) != 0) {
-		perror("timer_settime() did not return success\n");
-		return PTS_UNRESOLVED;
-	}
+	for (attempt = 0; attempt < PTS_MONO_MAX_RETRIES; attempt++) {
+		if (timer_settime(tid, 0, &its, NULL) != 0) {
+			perror("timer_settime() did not return success\n");
+			return PTS_UNRESOLVED;
+		}
 
-	if (clock_gettime(CLOCK_REALTIME, &tsclock) != 0) {
-		printf("clock_gettime() did not return success\n");
-		return PTS_UNRESOLVED;
-	}
+		pts_mono_time_start();
 
-	tsclock.tv_sec += CLOCKOFFSET;
-	getBeforeTime(&tsreset);
-	if (clock_settime(CLOCK_REALTIME, &tsclock) != 0) {
-		printf("clock_settime() was not successful\n");
-		return PTS_UNRESOLVED;
+		if (clock_gettime(CLOCK_REALTIME, &tsclock) != 0) {
+			printf("clock_gettime() did not return success\n");
+			return PTS_UNRESOLVED;
+		}
+
+		tsclock.tv_sec += CLOCKOFFSET;
+		getBeforeTime(&tsreset);
+		if (clock_settime(CLOCK_REALTIME, &tsclock) != 0) {
+			printf("clock_settime() was not successful\n");
+			return PTS_UNRESOLVED;
+		}
+
+		ts.tv_sec = TIMERSEC + SLEEPDELTA;
+		ts.tv_nsec = 0;
+
+		ns_ret = nanosleep(&ts, &tsleft);
+
+		if (pts_mono_time_check(TIMERSEC)) {
+			tsreset.tv_sec += TIMERSEC;
+			setBackTime(tsreset);
+			break;
+		}
+
+		tsreset.tv_sec += TIMERSEC;
+		setBackTime(tsreset);
 	}
 
-	ts.tv_sec = TIMERSEC + SLEEPDELTA;
-	ts.tv_nsec = 0;
+	if (attempt == PTS_MONO_MAX_RETRIES) {
+		printf("UNTESTED: persistent clock interference after %d attempts\n",
+		       PTS_MONO_MAX_RETRIES);
+		return PTS_UNTESTED;
+	}
 
-	if (nanosleep(&ts, &tsleft) != -1) {
+	if (ns_ret != -1) {
 		printf("nanosleep() not interrupted\n");
 		return PTS_FAIL;
 	}
 
 	if (labs(tsleft.tv_sec - SLEEPDELTA) <= ACCEPTABLEDELTA) {
 		printf("Test PASSED\n");
-		tsreset.tv_sec += TIMERSEC;
-		setBackTime(tsreset);
 		return PTS_PASS;
 	}
 
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-1.c
index 569eae904ef2eff41441029d3427313107febe53..d05a1ac83debf09d37e7b058699c734e2227c7d9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-1.c
@@ -35,8 +35,9 @@
 
 int main(void)
 {
-	struct timespec tsT0, tsT1;
-	int pid;
+	struct timespec tsT0, tsT1, tsreset;
+	int pid, child_status;
+	int attempt;
 
 	/* Check that we're root...can't call clock_settime with CLOCK_REALTIME otherwise */
 	if (getuid() != 0) {
@@ -44,50 +45,49 @@ int main(void)
 		return PTS_UNTESTED;
 	}
 
-	if (clock_gettime(CLOCK_REALTIME, &tsT0) != 0) {
-		perror("clock_gettime() did not return success\n");
-		return PTS_UNRESOLVED;
-	}
+	for (attempt = 0; attempt < PTS_MONO_MAX_RETRIES; attempt++) {
+		if (clock_gettime(CLOCK_REALTIME, &tsT0) != 0) {
+			perror("clock_gettime() did not return success\n");
+			return PTS_UNRESOLVED;
+		}
 
-	if ((pid = fork()) == 0) {
-		/* child here */
-		int flags = 0;
-		struct timespec tsT2;
+		pts_mono_time_start();
 
-		tsT1.tv_sec = tsT0.tv_sec + SLEEPOFFSET;
-		tsT1.tv_nsec = tsT0.tv_nsec;
+		pid = fork();
+		if (pid == 0) {
+			/* child here */
+			int flags = 0;
+			struct timespec tsT2;
 
-		flags |= TIMER_ABSTIME;
-		if (clock_nanosleep(CLOCK_REALTIME, flags, &tsT1, NULL) != 0) {
-			printf("clock_nanosleep() did not return success\n");
-			return CHILDFAIL;
-		}
+			tsT1.tv_sec = tsT0.tv_sec + SLEEPOFFSET;
+			tsT1.tv_nsec = tsT0.tv_nsec;
 
-		if (clock_gettime(CLOCK_REALTIME, &tsT2) != 0) {
-			perror("clock_gettime() did not return success\n");
-			return CHILDFAIL;
-		}
+			flags |= TIMER_ABSTIME;
+			if (clock_nanosleep(CLOCK_REALTIME, flags, &tsT1, NULL) != 0) {
+				printf("clock_nanosleep() did not return success\n");
+				return CHILDFAIL;
+			}
+
+			if (clock_gettime(CLOCK_REALTIME, &tsT2) != 0) {
+				perror("clock_gettime() did not return success\n");
+				return CHILDFAIL;
+			}
+
+			if (tsT2.tv_sec >= tsT1.tv_sec) {
+				if ((tsT2.tv_sec - tsT1.tv_sec) <= ACCEPTABLEDELTA)
+					return CHILDPASS;
 
-		if (tsT2.tv_sec >= tsT1.tv_sec) {
-			if ((tsT2.tv_sec - tsT1.tv_sec) <= ACCEPTABLEDELTA) {
-				return CHILDPASS;
-			} else {
 				printf("Ended too late.  %d >> %d\n",
 				       (int)tsT2.tv_sec, (int)tsT1.tv_sec);
 				return CHILDFAIL;
 			}
-		} else {
+
 			printf("Did not sleep for long enough %d < %d\n",
 			       (int)tsT2.tv_sec, (int)tsT1.tv_sec);
 			return CHILDFAIL;
 		}
 
-		return CHILDFAIL;
-	} else {
 		/* parent here */
-		int i;
-		struct timespec tsreset;
-
 		sleep(SMALLTIME);
 
 		if (clock_settime(CLOCK_REALTIME, &tsT0) != 0) {
@@ -95,22 +95,30 @@ int main(void)
 			return PTS_UNRESOLVED;
 		}
 
-		if (wait(&i) == -1) {
+		if (wait(&child_status) == -1) {
 			perror("Error waiting for child to exit\n");
 			return PTS_UNRESOLVED;
 		}
 
-		getBeforeTime(&tsreset);	// get current time
+		getBeforeTime(&tsreset);
 		tsreset.tv_sec += SMALLTIME;
 		setBackTime(tsreset);
-		if (WIFEXITED(i) && WEXITSTATUS(i)) {
-			printf("Test PASSED\n");
-			return PTS_PASS;
-		} else {
-			printf("Test FAILED\n");
-			return PTS_FAIL;
-		}
+
+		if (pts_mono_time_check(SMALLTIME + SLEEPOFFSET))
+			break;
+	}
+
+	if (attempt == PTS_MONO_MAX_RETRIES) {
+		printf("UNTESTED: persistent clock interference after %d attempts\n",
+		       PTS_MONO_MAX_RETRIES);
+		return PTS_UNTESTED;
+	}
+
+	if (WIFEXITED(child_status) && WEXITSTATUS(child_status)) {
+		printf("Test PASSED\n");
+		return PTS_PASS;
 	}
 
-	return PTS_UNRESOLVED;
+	printf("Test FAILED\n");
+	return PTS_FAIL;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-2.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-2.c
index 7c340b6c97ce03a1b04709f06996e5a66e1a653a..18b1f47ba91989570052893e3689f75dbc96a6b2 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-2.c
@@ -31,11 +31,13 @@
 
 #define CHILDPASS 1
 #define CHILDFAIL 0
+#define CHILDUNTESTED 2
 
 int main(void)
 {
-	struct timespec tsT0, tsT1, tsT2;
-	int pid;
+	struct timespec tsT0, tsT1, tsT2, tsreset;
+	int pid, child_status;
+	int attempt;
 
 	/* Check that we're root...can't call clock_settime with CLOCK_REALTIME otherwise */
 	if (getuid() != 0) {
@@ -43,53 +45,62 @@ int main(void)
 		return PTS_UNTESTED;
 	}
 
-	if (clock_gettime(CLOCK_REALTIME, &tsT0) != 0) {
-		perror("clock_gettime() did not return success\n");
-		return PTS_UNRESOLVED;
-	}
+	for (attempt = 0; attempt < PTS_MONO_MAX_RETRIES; attempt++) {
+		if (clock_gettime(CLOCK_REALTIME, &tsT0) != 0) {
+			perror("clock_gettime() did not return success\n");
+			return PTS_UNRESOLVED;
+		}
 
-	tsT1.tv_sec = tsT0.tv_sec + SLEEPOFFSET;
-	tsT1.tv_nsec = tsT0.tv_nsec;
+		tsT1.tv_sec = tsT0.tv_sec + SLEEPOFFSET;
+		tsT1.tv_nsec = tsT0.tv_nsec;
 
-	tsT2.tv_sec = tsT1.tv_sec + SMALLTIME;
-	tsT2.tv_nsec = tsT1.tv_nsec;
+		tsT2.tv_sec = tsT1.tv_sec + SMALLTIME;
+		tsT2.tv_nsec = tsT1.tv_nsec;
 
-	if ((pid = fork()) == 0) {
-		/* child here */
-		int flags = 0;
-		struct timespec tsT3;
+		pid = fork();
+		if (pid == 0) {
+			/* child here */
+			int flags = 0;
+			struct timespec tsT3;
 
-		flags |= TIMER_ABSTIME;
-		if (clock_nanosleep(CLOCK_REALTIME, flags, &tsT1, NULL) != 0) {
-			printf("clock_nanosleep() did not return success\n");
-			return CHILDFAIL;
-		}
+			flags |= TIMER_ABSTIME;
 
-		if (clock_gettime(CLOCK_REALTIME, &tsT3) != 0) {
-			perror("clock_gettime() did not return success\n");
-			return CHILDFAIL;
-		}
+			pts_mono_time_start();
+
+			if (clock_nanosleep(CLOCK_REALTIME, flags, &tsT1, NULL) != 0) {
+				printf("clock_nanosleep() did not return success\n");
+				return CHILDFAIL;
+			}
+
+			/*
+			 * The parent sleeps 1s before jumping the clock forward.
+			 * If clock_nanosleep returned too quickly, an external
+			 * clock adjustment (NTP, VM sync) woke us instead of the
+			 * parent's clock_settime.
+			 */
+			if (!pts_mono_time_check(1))
+				return CHILDUNTESTED;
+
+			if (clock_gettime(CLOCK_REALTIME, &tsT3) != 0) {
+				perror("clock_gettime() did not return success\n");
+				return CHILDFAIL;
+			}
+
+			if (tsT3.tv_sec >= tsT2.tv_sec) {
+				if ((tsT3.tv_sec - tsT2.tv_sec) <= ACCEPTABLEDELTA)
+					return CHILDPASS;
 
-		if (tsT3.tv_sec >= tsT2.tv_sec) {
-			if ((tsT3.tv_sec - tsT2.tv_sec) <= ACCEPTABLEDELTA) {
-				return CHILDPASS;
-			} else {
 				printf("Ended too late.  %d >> %d\n",
 				       (int)tsT3.tv_sec, (int)tsT2.tv_sec);
 				return CHILDFAIL;
 			}
-		} else {
+
 			printf("Did not sleep for long enough %d < %d\n",
 			       (int)tsT3.tv_sec, (int)tsT2.tv_sec);
 			return CHILDFAIL;
 		}
 
-		return CHILDFAIL;
-	} else {
 		/* parent here */
-		int i;
-		struct timespec tsreset;
-
 		sleep(1);
 
 		getBeforeTime(&tsreset);
@@ -98,21 +109,29 @@ int main(void)
 			return PTS_UNRESOLVED;
 		}
 
-		if (wait(&i) == -1) {
+		if (wait(&child_status) == -1) {
 			perror("Error waiting for child to exit\n");
 			return PTS_UNRESOLVED;
 		}
 
-		setBackTime(tsreset);	//should be ~= before time
+		setBackTime(tsreset);
 
-		if (WIFEXITED(i) && WEXITSTATUS(i)) {
-			printf("Test PASSED\n");
-			return PTS_PASS;
-		} else {
-			printf("Test FAILED\n");
-			return PTS_FAIL;
-		}
+		if (!WIFEXITED(child_status) ||
+		    WEXITSTATUS(child_status) != CHILDUNTESTED)
+			break;
+	}
+
+	if (attempt == PTS_MONO_MAX_RETRIES) {
+		printf("UNTESTED: persistent clock interference after %d attempts\n",
+		       PTS_MONO_MAX_RETRIES);
+		return PTS_UNTESTED;
+	}
+
+	if (WIFEXITED(child_status) && WEXITSTATUS(child_status) == CHILDPASS) {
+		printf("Test PASSED\n");
+		return PTS_PASS;
 	}
 
-	return PTS_UNRESOLVED;
+	printf("Test FAILED\n");
+	return PTS_FAIL;
 }
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/helpers.h b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/helpers.h
index 133a579afa893e90d896d68fc92a93e21ef84efc..66e22d3903a2569ff22cd3e13d3c82e93424cfb9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/helpers.h
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/helpers.h
@@ -12,6 +12,9 @@
  * in certain tests, they make use of some libraries already included
  * by those tests.
  */
+
+#include <stdlib.h>
+
 static int getBeforeTime(struct timespec *tpget)
 {
 	if (clock_gettime(CLOCK_REALTIME, tpget) != 0) {
@@ -32,3 +35,47 @@ static int setBackTime(struct timespec tpset)
 	return PTS_PASS;
 }
 
+#define PTS_MONO_MAX_RETRIES 3
+
+#ifdef _POSIX_MONOTONIC_CLOCK
+static struct timespec _pts_mono_start;
+
+static inline void pts_mono_time_start(void)
+{
+	clock_gettime(CLOCK_MONOTONIC, &_pts_mono_start);
+}
+
+static inline int pts_mono_time_check(unsigned int expected_secs)
+{
+	struct timespec now;
+	long elapsed;
+
+	clock_gettime(CLOCK_MONOTONIC, &now);
+	elapsed = now.tv_sec - _pts_mono_start.tv_sec;
+
+	if (labs(elapsed - (long)expected_secs) > 1) {
+		printf("Clock adjustment detected (elapsed %lds, expected ~%us)\n",
+		       elapsed, expected_secs);
+		return 0;
+	}
+	return 1;
+}
+#else
+static inline void pts_mono_time_start(void)
+{
+	static int warned;
+
+	if (!warned) {
+		printf("CLOCK_MONOTONIC unavailable, "
+		       "test may fail due to external clock adjustments\n");
+		warned = 1;
+	}
+}
+
+static inline int pts_mono_time_check(unsigned int expected_secs)
+{
+	(void)expected_secs;
+	return 1;
+}
+#endif
+
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-1.c
index e9c8ebe51f07b2ac0bd89433b49526d3e08644bb..e67225e841772aec667b33cf1ed07da507be10f5 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-1.c
@@ -29,12 +29,10 @@ int main(void)
 {
 	struct timespec tssleepfor, tsstorage;
 	int sleepsec = 30;
-	int pid;
+	int pid, i;
 	struct sigaction act;
 
 	if ((pid = fork()) == 0) {
-		/* child here */
-
 		act.sa_handler = handler;
 		act.sa_flags = 0;
 		if (sigemptyset(&act.sa_mask) == -1) {
@@ -51,40 +49,34 @@ int main(void)
 			if (EINTR == errno) {
 				printf("errno == EINTR\n");
 				return CHILDSUCCESS;
-			} else {
-				printf("errno != EINTR\n");
-				return CHILDFAILURE;
 			}
-		} else {
-			printf("nanosleep did not return -1\n");
+
+			printf("errno != EINTR\n");
 			return CHILDFAILURE;
 		}
 
+		printf("nanosleep did not return -1\n");
 		return CHILDFAILURE;
-	} else {
-		/* parent here */
-		int i;
+	}
 
-		sleep(1);
+	sleep(1);
 
-		if (kill(pid, SIGABRT) != 0) {
-			printf("Could not raise signal being tested\n");
-			return PTS_UNRESOLVED;
-		}
+	if (kill(pid, SIGABRT) != 0) {
+		printf("Could not raise signal being tested\n");
+		return PTS_UNRESOLVED;
+	}
 
-		if (wait(&i) == -1) {
-			perror("Error waiting for child to exit\n");
-			return PTS_UNRESOLVED;
-		}
+	if (wait(&i) == -1) {
+		perror("Error waiting for child to exit\n");
+		return PTS_UNRESOLVED;
+	}
 
-		if (WIFEXITED(i) && WEXITSTATUS(i)) {
-			printf("Test PASSED\n");
-			return PTS_PASS;
-		} else {
-			printf("Child did not exit normally.\n");
-			printf("Test FAILED\n");
-			return PTS_FAIL;
-		}
+	if (WIFEXITED(i) && WEXITSTATUS(i)) {
+		printf("Test PASSED\n");
+		return PTS_PASS;
 	}
-	return PTS_UNRESOLVED;
+
+	printf("Child did not exit normally.\n");
+	printf("Test FAILED\n");
+	return PTS_FAIL;
 }

---
base-commit: f992f6e25fce22dd37b37ec324aa1b1b26b3204f
change-id: 20260331-clock_settime_fix-8e4117dcb609

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
