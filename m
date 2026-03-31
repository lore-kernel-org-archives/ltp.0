Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E6B31061B3F
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 12:37:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECBA13E4ED9
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 14:37:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEF533C9314
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 14:37:12 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 052BB600687
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 14:37:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A7C044D1E3;
 Tue, 31 Mar 2026 12:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774960629; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=92+oPd689+hb96NfcS9GL+gJkp+dzhQTwt0yf/uJyCg=;
 b=1/9IzcWvfborpJqw8B5rijQuX4MqmBpvhGMZoQZSTrLNbHVT+xRkaGlfgz/Y5dig3goNhv
 wT4Q6CGZcrdgJOHEEbmvWBWhJ24lfJvJTfPT0KhT67OBt+lTU/z35AmJECxImnW+sJKc8k
 ZCRxrcDL1AAyMo7L5A8i07siA61Wvhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774960629;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=92+oPd689+hb96NfcS9GL+gJkp+dzhQTwt0yf/uJyCg=;
 b=/BTcB89iqPu61Dl38cJApSfMa/WIpgTgxchm6XXVaznV2Fgry/MVv1m9Z2hS5Ky6SRmQUG
 UAizfJAnHy7J3uBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=sDzAmThw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Xqpbmj6i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774960628; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=92+oPd689+hb96NfcS9GL+gJkp+dzhQTwt0yf/uJyCg=;
 b=sDzAmThwDkYrVyRMu14I/U2I/+O4sELr3arr5NyXHUzCrvML9Vuph66aZ9fowrv0EphkvB
 mkJSPaUlCQHMqs9qU7TRQ61g58IWYqi2L0dgbCMKAZtqR3ZBOQNkKNInYikm0/zQ33xZLI
 4qkAQflYN+TV0aJm24+TEg0hdxdO7Xw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774960628;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=92+oPd689+hb96NfcS9GL+gJkp+dzhQTwt0yf/uJyCg=;
 b=Xqpbmj6i2A7eY8Oxk4gNF2W3uy/u1fQ/LO/u0IqJ+A+DKKQVUYCzCNXMbamY2hv7hT5MZP
 8bSret2sqdUMD+DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 769B24A0A2;
 Tue, 31 Mar 2026 12:37:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id l7neGvS/y2k6IgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 31 Mar 2026 12:37:08 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 31 Mar 2026 14:37:03 +0200
MIME-Version: 1.0
Message-Id: <20260331-clock_settime_fix-v2-1-e222fe379b16@suse.com>
X-B4-Tracking: v=1; b=H4sIAO6/y2kC/32NWw6CMBBFt0Lm25o+SH18sQ9DCLZTmSjUdLDRE
 PZuZQF+npPccxdgTIQM52qBhJmY4lRA7ypwQz/dUJAvDFpqK41Rwj2iu3eM80wjdoHe4oi1Ugf
 vrlaeoOyeCYvempe28EA8x/TZLrL62X+1rIQSPvQorQ+6NrbhF+PexRHadV2/r5lZQLEAAAA=
X-Change-ID: 20260331-clock_settime_fix-8e4117dcb609
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774960628; l=14424;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=ClqqumL4eet1PbQoWvl19cSftotOt0t+nf0xd5YXUc8=;
 b=9bE4YKdCX3TucIrtNebnFi/q2cLNBFcx0fzN4zU9dOGhojVi+dmpD1w9IZSwHnwuB3rCH14OT
 xViPnDCjb9MBlmbCExH6wkh28jqUyGqx2Cc2HtDwu4vCiVG4ETOBCLx
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,anthropic.com:email,suse.de:dkim,suse.com:mid,suse.com:email];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A7C044D1E3
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] clock_settime: Detect external clock adjustments
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
and producing spurious failures.

Use CLOCK_MONOTONIC as a sideband check to detect external interference.
If the monotonic elapsed time is anomalous, report UNTESTED instead of
a false FAIL. Guard the checks with _POSIX_MONOTONIC_CLOCK since
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
Changes in v2:
- print a message if CLOCK_MONOTONIC is not available
- always verify that CLOCK_MONOTONIC is available
- Link to v1: https://lore.kernel.org/r/20260331-clock_settime_fix-v1-1-dfae06df2436@suse.com
---
 .../conformance/interfaces/clock_settime/4-1.c     | 36 ++++++++++++++++++
 .../conformance/interfaces/clock_settime/5-1.c     | 43 +++++++++++++++++++++-
 .../conformance/interfaces/clock_settime/5-2.c     | 43 +++++++++++++++++++++-
 .../conformance/interfaces/clock_settime/7-1.c     | 38 +++++++++++++++++++
 .../conformance/interfaces/clock_settime/7-2.c     | 41 ++++++++++++++++++++-
 5 files changed, 198 insertions(+), 3 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c
index f8a3e9c542ca8c9767cdd0057005e519f58b2b55..5f3f816a5fc71a9e62bb3577e1a18a19f987a802 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c
@@ -42,6 +42,9 @@ int main(void)
 {
 	struct sigevent ev;
 	struct timespec tpT0, tpT2, tpreset;
+#ifdef _POSIX_MONOTONIC_CLOCK
+	struct timespec mono_before, mono_after;
+#endif
 	struct itimerspec its;
 	timer_t tid;
 	int delta;
@@ -55,6 +58,10 @@ int main(void)
 		return PTS_UNTESTED;
 	}
 
+#ifndef _POSIX_MONOTONIC_CLOCK
+	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
+#endif
+
 	/*
 	 * set up sigevent for timer
 	 * set up signal set for sigwait
@@ -82,6 +89,13 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
+#ifdef _POSIX_MONOTONIC_CLOCK
+	if (clock_gettime(CLOCK_MONOTONIC, &mono_before) != 0) {
+		perror("clock_gettime() was not successful\n");
+		return PTS_UNRESOLVED;
+	}
+#endif
+
 	if (timer_create(CLOCK_REALTIME, &ev, &tid) != 0) {
 		perror("timer_create() did not return success\n");
 		return PTS_UNRESOLVED;
@@ -120,6 +134,28 @@ int main(void)
 	tpreset.tv_sec += tpT2.tv_sec - tpT0.tv_sec;
 	setBackTime(tpreset);
 
+#ifdef _POSIX_MONOTONIC_CLOCK
+	if (clock_gettime(CLOCK_MONOTONIC, &mono_after) != 0) {
+		perror("clock_gettime() was not successful\n");
+		return PTS_UNRESOLVED;
+	}
+
+	/*
+	 * The expected monotonic elapsed time is SLEEPTIME + TIMEROFFSET
+	 * since after resetting the clock, the timer must wait another
+	 * full TIMEROFFSET. If monotonic time is much shorter, an external
+	 * clock adjustment (NTP, VM sync) interfered with the test.
+	 */
+	if (mono_after.tv_sec - mono_before.tv_sec <
+	    SLEEPTIME + TIMEROFFSET - ACCEPTABLEDELTA) {
+		printf("UNTESTED: external clock adjustment detected "
+		       "(monotonic elapsed %ds, expected ~%ds)\n",
+		       (int)(mono_after.tv_sec - mono_before.tv_sec),
+		       SLEEPTIME + TIMEROFFSET);
+		return PTS_UNTESTED;
+	}
+#endif
+
 	printf("delta: %d\n", delta);
 	if ((delta <= ACCEPTABLEDELTA) && (delta >= 0)) {
 		printf("Test PASSED\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-1.c
index 75fa591e014601b2ef9308a118992a704365392b..da8cbae29fd77fcbca939ac215f5c4d6d450fe31 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-1.c
@@ -46,9 +46,13 @@ int main(void)
 	struct sigevent ev;
 	struct sigaction act;
 	struct timespec tsclock, ts, tsleft, tsreset;
+#ifdef _POSIX_MONOTONIC_CLOCK
+	struct timespec mono_before, mono_after;
+#endif
 	struct itimerspec its;
 	timer_t tid;
 	sigset_t set;
+	int ns_ret;
 
 	/* Check that we're root...can't call clock_settime with CLOCK_REALTIME otherwise */
 	if (getuid() != 0) {
@@ -56,6 +60,10 @@ int main(void)
 		return PTS_UNTESTED;
 	}
 
+#ifndef _POSIX_MONOTONIC_CLOCK
+	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
+#endif
+
 	/*
 	 * set up sigevent for timer
 	 * set up signal set for sigwait
@@ -97,6 +105,13 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
+#ifdef _POSIX_MONOTONIC_CLOCK
+	if (clock_gettime(CLOCK_MONOTONIC, &mono_before) != 0) {
+		perror("clock_gettime() was not successful\n");
+		return PTS_UNRESOLVED;
+	}
+#endif
+
 	if (clock_gettime(CLOCK_REALTIME, &tsclock) != 0) {
 		printf("clock_gettime() did not return success\n");
 		return PTS_UNRESOLVED;
@@ -112,7 +127,33 @@ int main(void)
 	ts.tv_sec = TIMERSEC + SLEEPDELTA;
 	ts.tv_nsec = 0;
 
-	if (nanosleep(&ts, &tsleft) != -1) {
+	ns_ret = nanosleep(&ts, &tsleft);
+
+#ifdef _POSIX_MONOTONIC_CLOCK
+	if (clock_gettime(CLOCK_MONOTONIC, &mono_after) != 0) {
+		perror("clock_gettime() was not successful\n");
+		return PTS_UNRESOLVED;
+	}
+
+	/*
+	 * The relative timer should fire after TIMERSEC regardless of
+	 * clock_settime changes. If monotonic elapsed time is too far
+	 * from TIMERSEC, an external clock adjustment (NTP, VM sync)
+	 * interfered with the test.
+	 */
+	if (labs(mono_after.tv_sec - mono_before.tv_sec - TIMERSEC) >
+	    ACCEPTABLEDELTA + 1) {
+		printf("UNTESTED: external clock adjustment detected "
+		       "(monotonic elapsed %ds, expected ~%ds)\n",
+		       (int)(mono_after.tv_sec - mono_before.tv_sec),
+		       TIMERSEC);
+		tsreset.tv_sec += mono_after.tv_sec - mono_before.tv_sec;
+		setBackTime(tsreset);
+		return PTS_UNTESTED;
+	}
+#endif
+
+	if (ns_ret != -1) {
 		printf("nanosleep() not interrupted\n");
 		return PTS_FAIL;
 	}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-2.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-2.c
index b8a60028c6d3d1a3c0d75922f39697b57329c440..d12d18861ca78b174b47bae69d6e4a1146393159 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-2.c
@@ -46,9 +46,13 @@ int main(void)
 	struct sigevent ev;
 	struct sigaction act;
 	struct timespec tsclock, ts, tsleft, tsreset;
+#ifdef _POSIX_MONOTONIC_CLOCK
+	struct timespec mono_before, mono_after;
+#endif
 	struct itimerspec its;
 	timer_t tid;
 	sigset_t set;
+	int ns_ret;
 
 	/* Check that we're root...can't call clock_settime with CLOCK_REALTIME otherwise */
 	if (getuid() != 0) {
@@ -56,6 +60,10 @@ int main(void)
 		return PTS_UNTESTED;
 	}
 
+#ifndef _POSIX_MONOTONIC_CLOCK
+	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
+#endif
+
 	/*
 	 * set up sigevent for timer
 	 * set up signal set for sigwait
@@ -97,6 +105,13 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
+#ifdef _POSIX_MONOTONIC_CLOCK
+	if (clock_gettime(CLOCK_MONOTONIC, &mono_before) != 0) {
+		perror("clock_gettime() was not successful\n");
+		return PTS_UNRESOLVED;
+	}
+#endif
+
 	if (clock_gettime(CLOCK_REALTIME, &tsclock) != 0) {
 		printf("clock_gettime() did not return success\n");
 		return PTS_UNRESOLVED;
@@ -112,7 +127,33 @@ int main(void)
 	ts.tv_sec = TIMERSEC + SLEEPDELTA;
 	ts.tv_nsec = 0;
 
-	if (nanosleep(&ts, &tsleft) != -1) {
+	ns_ret = nanosleep(&ts, &tsleft);
+
+#ifdef _POSIX_MONOTONIC_CLOCK
+	if (clock_gettime(CLOCK_MONOTONIC, &mono_after) != 0) {
+		perror("clock_gettime() was not successful\n");
+		return PTS_UNRESOLVED;
+	}
+
+	/*
+	 * The relative timer should fire after TIMERSEC regardless of
+	 * clock_settime changes. If monotonic elapsed time is too far
+	 * from TIMERSEC, an external clock adjustment (NTP, VM sync)
+	 * interfered with the test.
+	 */
+	if (labs(mono_after.tv_sec - mono_before.tv_sec - TIMERSEC) >
+	    ACCEPTABLEDELTA + 1) {
+		printf("UNTESTED: external clock adjustment detected "
+		       "(monotonic elapsed %ds, expected ~%ds)\n",
+		       (int)(mono_after.tv_sec - mono_before.tv_sec),
+		       TIMERSEC);
+		tsreset.tv_sec += mono_after.tv_sec - mono_before.tv_sec;
+		setBackTime(tsreset);
+		return PTS_UNTESTED;
+	}
+#endif
+
+	if (ns_ret != -1) {
 		printf("nanosleep() not interrupted\n");
 		return PTS_FAIL;
 	}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-1.c
index 569eae904ef2eff41441029d3427313107febe53..d372d2d48af0a29133eb833979ae37d682768170 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-1.c
@@ -36,6 +36,9 @@
 int main(void)
 {
 	struct timespec tsT0, tsT1;
+#ifdef _POSIX_MONOTONIC_CLOCK
+	struct timespec mono_before, mono_after;
+#endif
 	int pid;
 
 	/* Check that we're root...can't call clock_settime with CLOCK_REALTIME otherwise */
@@ -44,11 +47,22 @@ int main(void)
 		return PTS_UNTESTED;
 	}
 
+#ifndef _POSIX_MONOTONIC_CLOCK
+	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
+#endif
+
 	if (clock_gettime(CLOCK_REALTIME, &tsT0) != 0) {
 		perror("clock_gettime() did not return success\n");
 		return PTS_UNRESOLVED;
 	}
 
+#ifdef _POSIX_MONOTONIC_CLOCK
+	if (clock_gettime(CLOCK_MONOTONIC, &mono_before) != 0) {
+		perror("clock_gettime() was not successful\n");
+		return PTS_UNRESOLVED;
+	}
+#endif
+
 	if ((pid = fork()) == 0) {
 		/* child here */
 		int flags = 0;
@@ -103,6 +117,30 @@ int main(void)
 		getBeforeTime(&tsreset);	// get current time
 		tsreset.tv_sec += SMALLTIME;
 		setBackTime(tsreset);
+
+#ifdef _POSIX_MONOTONIC_CLOCK
+		if (clock_gettime(CLOCK_MONOTONIC, &mono_after) != 0) {
+			perror("clock_gettime() was not successful\n");
+			return PTS_UNRESOLVED;
+		}
+
+		/*
+		 * Expected monotonic elapsed time is SMALLTIME + SLEEPOFFSET
+		 * since after resetting the clock, the child must wait
+		 * another full SLEEPOFFSET. If monotonic time is much
+		 * shorter, an external clock adjustment (NTP, VM sync)
+		 * interfered with the test.
+		 */
+		if (mono_after.tv_sec - mono_before.tv_sec <
+		    SMALLTIME + SLEEPOFFSET - ACCEPTABLEDELTA - 1) {
+			printf("UNTESTED: external clock adjustment detected "
+			       "(monotonic elapsed %ds, expected ~%ds)\n",
+			       (int)(mono_after.tv_sec - mono_before.tv_sec),
+			       SMALLTIME + SLEEPOFFSET);
+			return PTS_UNTESTED;
+		}
+#endif
+
 		if (WIFEXITED(i) && WEXITSTATUS(i)) {
 			printf("Test PASSED\n");
 			return PTS_PASS;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-2.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-2.c
index 7c340b6c97ce03a1b04709f06996e5a66e1a653a..b9f10bfd5dfc517f0372662b1b1247298d2bee32 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-2.c
@@ -31,6 +31,7 @@
 
 #define CHILDPASS 1
 #define CHILDFAIL 0
+#define CHILDUNTESTED 2
 
 int main(void)
 {
@@ -43,6 +44,10 @@ int main(void)
 		return PTS_UNTESTED;
 	}
 
+#ifndef _POSIX_MONOTONIC_CLOCK
+	printf("CLOCK_MONOTONIC unavailable, test may fail due to external clock adjustments\n");
+#endif
+
 	if (clock_gettime(CLOCK_REALTIME, &tsT0) != 0) {
 		perror("clock_gettime() did not return success\n");
 		return PTS_UNRESOLVED;
@@ -58,13 +63,44 @@ int main(void)
 		/* child here */
 		int flags = 0;
 		struct timespec tsT3;
+#ifdef _POSIX_MONOTONIC_CLOCK
+		struct timespec mono_start, mono_end;
+#endif
 
 		flags |= TIMER_ABSTIME;
+
+#ifdef _POSIX_MONOTONIC_CLOCK
+		if (clock_gettime(CLOCK_MONOTONIC, &mono_start) != 0) {
+			perror("clock_gettime() was not successful\n");
+			return CHILDFAIL;
+		}
+#endif
+
 		if (clock_nanosleep(CLOCK_REALTIME, flags, &tsT1, NULL) != 0) {
 			printf("clock_nanosleep() did not return success\n");
 			return CHILDFAIL;
 		}
 
+#ifdef _POSIX_MONOTONIC_CLOCK
+		if (clock_gettime(CLOCK_MONOTONIC, &mono_end) != 0) {
+			perror("clock_gettime() was not successful\n");
+			return CHILDFAIL;
+		}
+
+		/*
+		 * The parent sleeps 1s before jumping the clock forward.
+		 * If clock_nanosleep returned in less than 1s monotonic,
+		 * an external clock adjustment (NTP, VM sync) woke us
+		 * instead of the parent's clock_settime.
+		 */
+		if (mono_end.tv_sec - mono_start.tv_sec < 1) {
+			printf("UNTESTED: external clock adjustment detected "
+			       "(monotonic elapsed %ds)\n",
+			       (int)(mono_end.tv_sec - mono_start.tv_sec));
+			return CHILDUNTESTED;
+		}
+#endif
+
 		if (clock_gettime(CLOCK_REALTIME, &tsT3) != 0) {
 			perror("clock_gettime() did not return success\n");
 			return CHILDFAIL;
@@ -105,7 +141,10 @@ int main(void)
 
 		setBackTime(tsreset);	//should be ~= before time
 
-		if (WIFEXITED(i) && WEXITSTATUS(i)) {
+		if (WIFEXITED(i) && WEXITSTATUS(i) == CHILDUNTESTED) {
+			printf("Test UNTESTED\n");
+			return PTS_UNTESTED;
+		} else if (WIFEXITED(i) && WEXITSTATUS(i)) {
 			printf("Test PASSED\n");
 			return PTS_PASS;
 		} else {

---
base-commit: 4688c20c01eece869b59e05ca3dd68c43e0d6af7
change-id: 20260331-clock_settime_fix-8e4117dcb609

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
