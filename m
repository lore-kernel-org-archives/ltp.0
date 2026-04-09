Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9709DE9DE6D
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 08:56:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D47DA3E1CD9
	for <ltp@archiver.kernel.org>; Thu,  9 Apr 2026 10:56:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 150DF3E1CD9
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 10:55:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 735836006F5
 for <ltp@lists.linux.it>; Thu,  9 Apr 2026 10:55:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 30F224EE5C;
 Thu,  9 Apr 2026 08:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775724949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jfa7+HcI+W1exQip+lAK6EpBDACOqlmfovmaFCxUeQM=;
 b=WQ6HAf0/3PIwY1ZjqnRN/YK9WT4xuJgpm0Ug05DbNTD3WJtOFfRJdedg6MLHN5AYNkgbVQ
 NggGOSgg+MqvDSyvepkK6zsyw4BZNl2aCUYF0Z3P1+P7Q0oNMC39YVFy5pyyhBv2iVJOmj
 I65fcc1ahK+zuhM3P4vJfgBpgbV5ka0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775724949;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jfa7+HcI+W1exQip+lAK6EpBDACOqlmfovmaFCxUeQM=;
 b=Rrs28PbZRUz1uiiDCOxIn3McYN/nOQO8y3xbCAgXTUd3ykYQ3ODrp+RZL1oIPSEPfxwZr2
 6i05OC8G8uXiNWDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775724949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jfa7+HcI+W1exQip+lAK6EpBDACOqlmfovmaFCxUeQM=;
 b=WQ6HAf0/3PIwY1ZjqnRN/YK9WT4xuJgpm0Ug05DbNTD3WJtOFfRJdedg6MLHN5AYNkgbVQ
 NggGOSgg+MqvDSyvepkK6zsyw4BZNl2aCUYF0Z3P1+P7Q0oNMC39YVFy5pyyhBv2iVJOmj
 I65fcc1ahK+zuhM3P4vJfgBpgbV5ka0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775724949;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jfa7+HcI+W1exQip+lAK6EpBDACOqlmfovmaFCxUeQM=;
 b=Rrs28PbZRUz1uiiDCOxIn3McYN/nOQO8y3xbCAgXTUd3ykYQ3ODrp+RZL1oIPSEPfxwZr2
 6i05OC8G8uXiNWDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03B6C4A0B3;
 Thu,  9 Apr 2026 08:55:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CaMuOpRp12n+KgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 09 Apr 2026 08:55:48 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 09 Apr 2026 10:55:47 +0200
MIME-Version: 1.0
Message-Id: <20260409-clock_settime_fix-v4-1-1cbd6d006cea@suse.com>
X-B4-Tracking: v=1; b=H4sIAJJp12kC/4XNQQrCMBCF4atI1kaSmZBaV95DpLTJxAZtI00tS
 undTbtRRHT5P5hvRhap8xTZbjWyjgYffWhTqPWKmbpsT8S9Tc1AgBaIkptLMOciUt/7hgrn73x
 LSsrMmkqLnKW7a0dpXszDMXXtYx+6x/JikPP6Sxskl9y6koS2DhTqfbxF2pjQsBkb4C8ACSAAc
 IRZXslPAF+AEl8BTIADiwIzgZXN3oBpmp7EFONYMwEAAA==
X-Change-ID: 20260331-clock_settime_fix-8e4117dcb609
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775724948; l=22492;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=vWou2GvVqGZRYCafBDTR9TIJ+eLtymuey4Qi886lIa0=;
 b=h4TzXUSqGZA4PtTkdVmpRxo6llAJ29xjMHK987L2FYd8QDKJKGEu50QgLnhs5EvH2UvUYzwKH
 lFx6uaLodaLDhGaUwNfA92bROQmeG8R4WiBjksJwMGt3zVmIF6j5g9l
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] clock_settime: Detect external clock adjustments
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

Co-developed-by: Claude <noreply@anthropic.com>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
I used Claude to generate the right patches to fix sporadic issues in the
clock_settime testing suite. We tried many attempt for fixing it, but the
CLOCK_REALTIME usage seems to be the real issue in here. The idea is that
we use internal Openposix mechanisms to skip tests if CLOCK_MONOTONIC
usage spots a possible interference from external tools.
---
Changes in v4:
- handle return value for helpers functions
- Link to v3: https://lore.kernel.org/r/20260401-clock_settime_fix-v3-1-f2d303703bd7@suse.com

Changes in v3:
- cycle multiple times before failing the tests
	- add helpers functions for CLOCK_MONOTONIC checks
- Link to v2: https://lore.kernel.org/r/20260331-clock_settime_fix-v2-1-e222fe379b16@suse.com

Changes in v2:
- print a message if CLOCK_MONOTONIC is not available
- always verify that CLOCK_MONOTONIC is available
- Link to v1: https://lore.kernel.org/r/20260331-clock_settime_fix-v1-1-dfae06df2436@suse.com
---
 .../conformance/interfaces/clock_settime/4-1.c     |  86 +++++++++------
 .../conformance/interfaces/clock_settime/5-1.c     |  68 +++++++-----
 .../conformance/interfaces/clock_settime/5-2.c     |  58 ++++++----
 .../conformance/interfaces/clock_settime/7-1.c     |  98 ++++++++++-------
 .../conformance/interfaces/clock_settime/7-2.c     | 119 +++++++++++++--------
 .../conformance/interfaces/clock_settime/helpers.h |  55 ++++++++++
 6 files changed, 323 insertions(+), 161 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c
index f8a3e9c542ca8c9767cdd0057005e519f58b2b55..763a68fc2b5b085c67597fafa859b0aa300fb54b 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c
@@ -47,7 +47,7 @@ int main(void)
 	int delta;
 	int sig;
 	sigset_t set;
-	int flags = 0;
+	int attempt, ret;
 
 	/* Check that we're root...can't call clock_settime with CLOCK_REALTIME otherwise */
 	if (geteuid() != 0) {
@@ -77,49 +77,65 @@ int main(void)
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
+		if (pts_mono_time_start() != 0)
+			return PTS_UNRESOLVED;
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
+		ret = pts_mono_time_check(SLEEPTIME + TIMEROFFSET);
+		if (ret < 0)
+			return PTS_UNRESOLVED;
+		if (ret == 0)
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
index 75fa591e014601b2ef9308a118992a704365392b..875cb7a80953d008e93beaa9aa4d88b94d676bec 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-1.c
@@ -49,6 +49,8 @@ int main(void)
 	struct itimerspec its;
 	timer_t tid;
 	sigset_t set;
+	int ns_ret;
+	int attempt, ret;
 
 	/* Check that we're root...can't call clock_settime with CLOCK_REALTIME otherwise */
 	if (getuid() != 0) {
@@ -92,42 +94,60 @@ int main(void)
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
+		if (pts_mono_time_start() != 0)
+			return PTS_UNRESOLVED;
 
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
+		ret = pts_mono_time_check(TIMERSEC);
+		tsreset.tv_sec += TIMERSEC;
+		setBackTime(tsreset);
+
+		if (ret < 0)
+			return PTS_UNRESOLVED;
+		if (ret == 0)
+			break;
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
index b8a60028c6d3d1a3c0d75922f39697b57329c440..81dbeeb361e956e6b64dc582b596685c9750cfea 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-2.c
@@ -49,6 +49,8 @@ int main(void)
 	struct itimerspec its;
 	timer_t tid;
 	sigset_t set;
+	int ns_ret;
+	int attempt, ret;
 
 	/* Check that we're root...can't call clock_settime with CLOCK_REALTIME otherwise */
 	if (getuid() != 0) {
@@ -92,35 +94,55 @@ int main(void)
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
+		if (pts_mono_time_start() != 0)
+			return PTS_UNRESOLVED;
 
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
+		ret = pts_mono_time_check(TIMERSEC);
+		tsreset.tv_sec += TIMERSEC;
+		setBackTime(tsreset);
+
+		if (ret < 0)
+			return PTS_UNRESOLVED;
+		if (ret == 0)
+			break;
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
index 569eae904ef2eff41441029d3427313107febe53..399caee5a44ef356090062030a5a36aa2ccac28e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-1.c
@@ -35,8 +35,9 @@
 
 int main(void)
 {
-	struct timespec tsT0, tsT1;
-	int pid;
+	struct timespec tsT0, tsT1, tsreset;
+	int pid, child_status;
+	int attempt, ret;
 
 	/* Check that we're root...can't call clock_settime with CLOCK_REALTIME otherwise */
 	if (getuid() != 0) {
@@ -44,50 +45,54 @@ int main(void)
 		return PTS_UNTESTED;
 	}
 
-	if (clock_gettime(CLOCK_REALTIME, &tsT0) != 0) {
-		perror("clock_gettime() did not return success\n");
-		return PTS_UNRESOLVED;
-	}
-
-	if ((pid = fork()) == 0) {
-		/* child here */
-		int flags = 0;
-		struct timespec tsT2;
+	for (attempt = 0; attempt < PTS_MONO_MAX_RETRIES; attempt++) {
+		if (clock_gettime(CLOCK_REALTIME, &tsT0) != 0) {
+			perror("clock_gettime() did not return success\n");
+			return PTS_UNRESOLVED;
+		}
 
-		tsT1.tv_sec = tsT0.tv_sec + SLEEPOFFSET;
-		tsT1.tv_nsec = tsT0.tv_nsec;
+		if (pts_mono_time_start() != 0)
+			return PTS_UNRESOLVED;
 
-		flags |= TIMER_ABSTIME;
-		if (clock_nanosleep(CLOCK_REALTIME, flags, &tsT1, NULL) != 0) {
-			printf("clock_nanosleep() did not return success\n");
-			return CHILDFAIL;
+		pid = fork();
+		if (pid < 0) {
+			perror("fork() failed");
+			return PTS_UNRESOLVED;
 		}
+		if (pid == 0) {
+			/* child here */
+			int flags = 0;
+			struct timespec tsT2;
 
-		if (clock_gettime(CLOCK_REALTIME, &tsT2) != 0) {
-			perror("clock_gettime() did not return success\n");
-			return CHILDFAIL;
-		}
+			tsT1.tv_sec = tsT0.tv_sec + SLEEPOFFSET;
+			tsT1.tv_nsec = tsT0.tv_nsec;
+
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
@@ -95,22 +100,33 @@ int main(void)
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
+		ret = pts_mono_time_check(SMALLTIME + SLEEPOFFSET);
+		if (ret < 0)
+			return PTS_UNRESOLVED;
+		if (ret == 0)
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
index 7c340b6c97ce03a1b04709f06996e5a66e1a653a..9a3a1e8678c95aef267f39995c85a35407699c6a 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-2.c
@@ -31,11 +31,14 @@
 
 #define CHILDPASS 1
 #define CHILDFAIL 0
+#define CHILDUNTESTED 2
+#define CHILDUNRESOLVED 3
 
 int main(void)
 {
-	struct timespec tsT0, tsT1, tsT2;
-	int pid;
+	struct timespec tsT0, tsT1, tsT2, tsreset;
+	int pid, child_status;
+	int attempt, ret;
 
 	/* Check that we're root...can't call clock_settime with CLOCK_REALTIME otherwise */
 	if (getuid() != 0) {
@@ -43,53 +46,70 @@ int main(void)
 		return PTS_UNTESTED;
 	}
 
-	if (clock_gettime(CLOCK_REALTIME, &tsT0) != 0) {
-		perror("clock_gettime() did not return success\n");
-		return PTS_UNRESOLVED;
-	}
-
-	tsT1.tv_sec = tsT0.tv_sec + SLEEPOFFSET;
-	tsT1.tv_nsec = tsT0.tv_nsec;
+	for (attempt = 0; attempt < PTS_MONO_MAX_RETRIES; attempt++) {
+		if (clock_gettime(CLOCK_REALTIME, &tsT0) != 0) {
+			perror("clock_gettime() did not return success\n");
+			return PTS_UNRESOLVED;
+		}
 
-	tsT2.tv_sec = tsT1.tv_sec + SMALLTIME;
-	tsT2.tv_nsec = tsT1.tv_nsec;
+		tsT1.tv_sec = tsT0.tv_sec + SLEEPOFFSET;
+		tsT1.tv_nsec = tsT0.tv_nsec;
 
-	if ((pid = fork()) == 0) {
-		/* child here */
-		int flags = 0;
-		struct timespec tsT3;
+		tsT2.tv_sec = tsT1.tv_sec + SMALLTIME;
+		tsT2.tv_nsec = tsT1.tv_nsec;
 
-		flags |= TIMER_ABSTIME;
-		if (clock_nanosleep(CLOCK_REALTIME, flags, &tsT1, NULL) != 0) {
-			printf("clock_nanosleep() did not return success\n");
-			return CHILDFAIL;
+		pid = fork();
+		if (pid < 0) {
+			perror("fork() failed");
+			return PTS_UNRESOLVED;
 		}
+		if (pid == 0) {
+			/* child here */
+			int flags = 0;
+			struct timespec tsT3;
 
-		if (clock_gettime(CLOCK_REALTIME, &tsT3) != 0) {
-			perror("clock_gettime() did not return success\n");
-			return CHILDFAIL;
-		}
+			flags |= TIMER_ABSTIME;
+
+			if (pts_mono_time_start() != 0)
+				return CHILDUNRESOLVED;
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
+			ret = pts_mono_time_check(1);
+			if (ret < 0)
+				return CHILDUNRESOLVED;
+			if (ret > 0)
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
@@ -98,21 +118,34 @@ int main(void)
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
+		if (!WIFEXITED(child_status))
+			break;
+
+		if (WEXITSTATUS(child_status) == CHILDUNRESOLVED)
+			return PTS_UNRESOLVED;
+
+		if (WEXITSTATUS(child_status) != CHILDUNTESTED)
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
index 133a579afa893e90d896d68fc92a93e21ef84efc..37bf30926f039553e9e370751b7938ca5ea1d00a 100644
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
@@ -32,3 +35,55 @@ static int setBackTime(struct timespec tpset)
 	return PTS_PASS;
 }
 
+#define PTS_MONO_MAX_RETRIES 3
+
+#ifdef _POSIX_MONOTONIC_CLOCK
+static struct timespec _pts_mono_start;
+
+static inline int pts_mono_time_start(void)
+{
+	if (clock_gettime(CLOCK_MONOTONIC, &_pts_mono_start) != 0) {
+		perror("clock_gettime(CLOCK_MONOTONIC) failed");
+		return -1;
+	}
+	return 0;
+}
+
+static inline int pts_mono_time_check(unsigned int expected_secs)
+{
+	struct timespec now;
+	long elapsed;
+
+	if (clock_gettime(CLOCK_MONOTONIC, &now) != 0) {
+		perror("clock_gettime(CLOCK_MONOTONIC) failed");
+		return -1;
+	}
+
+	elapsed = now.tv_sec - _pts_mono_start.tv_sec;
+
+	if (labs(elapsed - (long)expected_secs) > 1) {
+		printf("Clock adjustment detected (elapsed %lds, expected ~%us)\n",
+		       elapsed, expected_secs);
+		return 1;
+	}
+	return 0;
+}
+#else
+static inline int pts_mono_time_start(void)
+{
+	static int warned;
+
+	if (!warned) {
+		printf("CLOCK_MONOTONIC unavailable, test may fail due to clock adjustment\n");
+		warned = 1;
+	}
+	return 0;
+}
+
+static inline int pts_mono_time_check(unsigned int expected_secs)
+{
+	(void)expected_secs;
+	return 0;
+}
+#endif
+

---
base-commit: 1c46589251d6efa461d0e837540c990cd6dea188
change-id: 20260331-clock_settime_fix-8e4117dcb609

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
