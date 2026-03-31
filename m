Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC3D61061B37
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 12:12:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6A96E3E1CAA
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 14:12:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A4013CC93E
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 14:11:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A6C8F10009F5
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 14:11:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 394975BD89;
 Tue, 31 Mar 2026 12:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774959106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wo9nfZhlJhzzwvwvKDZ9KS2qEUgcH2OuzUWtXklPXYQ=;
 b=Oqdw2hy7gpEyheV1dut4Lt+jhL+ICdQetghMhhvrAAsYdIENYHaJVEVBFT39wFJPbjd3hA
 6zeiFsBqQVGoZNtcywlmi/bQjGYE0Br7bkUXHovjarAFxEiYxysQnTU5uf6OkeT0LaMu/b
 WsskpEZlt20QSE8Y/ul6/EBDkAvui7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774959106;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wo9nfZhlJhzzwvwvKDZ9KS2qEUgcH2OuzUWtXklPXYQ=;
 b=wToujE16JRFuIUpS9rxhBrMfNLTREFGVrrdj3kBRlIhUt31hLIYYXZItJjM/8VYiycCUo6
 lWwh7Hy+PUmBeJDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774959106; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wo9nfZhlJhzzwvwvKDZ9KS2qEUgcH2OuzUWtXklPXYQ=;
 b=Oqdw2hy7gpEyheV1dut4Lt+jhL+ICdQetghMhhvrAAsYdIENYHaJVEVBFT39wFJPbjd3hA
 6zeiFsBqQVGoZNtcywlmi/bQjGYE0Br7bkUXHovjarAFxEiYxysQnTU5uf6OkeT0LaMu/b
 WsskpEZlt20QSE8Y/ul6/EBDkAvui7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774959106;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wo9nfZhlJhzzwvwvKDZ9KS2qEUgcH2OuzUWtXklPXYQ=;
 b=wToujE16JRFuIUpS9rxhBrMfNLTREFGVrrdj3kBRlIhUt31hLIYYXZItJjM/8VYiycCUo6
 lWwh7Hy+PUmBeJDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69E194A0A2;
 Tue, 31 Mar 2026 12:11:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NjdJFgG6y2mWBwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 31 Mar 2026 12:11:45 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 31 Mar 2026 14:11:44 +0200
MIME-Version: 1.0
Message-Id: <20260331-clock_settime_fix-v1-1-dfae06df2436@suse.com>
X-B4-Tracking: v=1; b=H4sIAP+5y2kC/x2MWwqAIBAAryL7naAZ9rhKhJRutVQWGhFEd0/6n
 IGZByIGwggNeyDgRZF2n0BmDOzc+wk5ucSQi1wLpSS3624XE/E8aUMz0s0rLKQsnR20qCF1R8C
 k/2fbve8HmNZC4WMAAAA=
X-Change-ID: 20260331-clock_settime_fix-8e4117dcb609
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774959105; l=12123;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=bTw1tt8Dkpi/21emNIqxNNDGu6MJrbKe9SzojacQ38s=;
 b=nW1DMlk2z5SmzKBei77OUpII71ABZxZlC+X5qflSHQWxI5eyEz9aveyQpnriJ55cVWDPa+ODj
 lzbEYHgsueaBYFIpZSHe9oB4CKtSpg2cqEISkwHRCvHVuxVPYjMNSeE
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid,suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] clock_settime: Detect external clock adjustments via
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

These tests manipulate CLOCK_REALTIME to verify timer and
clock_nanosleep behavior, but NTP or VM time sync can also adjust
CLOCK_REALTIME during the test, causing timers to fire at wrong times
and producing spurious failures.

Use CLOCK_MONOTONIC as a sideband check to detect external interference.
If the monotonic elapsed time is anomalous, report UNTESTED instead of
a false FAIL.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
I used Claude to generate the right patches to fix sporadic issues in the
clock_settime testing suite. We tried many attempt for fixing it, but the
CLOCK_REALTIME usage seems to be the real issue in here. The idea is that
we use internal Openposix mechanisms to skip tests if CLOCK_MONOTONIC
usage spots a possible interference from external tools.
---
 .../conformance/interfaces/clock_settime/4-1.c     | 26 +++++++++++++++++
 .../conformance/interfaces/clock_settime/5-1.c     | 33 +++++++++++++++++++++-
 .../conformance/interfaces/clock_settime/5-2.c     | 33 +++++++++++++++++++++-
 .../conformance/interfaces/clock_settime/7-1.c     | 28 ++++++++++++++++++
 .../conformance/interfaces/clock_settime/7-2.c     | 31 +++++++++++++++++++-
 5 files changed, 148 insertions(+), 3 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c
index f8a3e9c542ca8c9767cdd0057005e519f58b2b55..005d440985a71f62ede60b7696f6bd6f8d48f4b9 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c
@@ -42,6 +42,7 @@ int main(void)
 {
 	struct sigevent ev;
 	struct timespec tpT0, tpT2, tpreset;
+	struct timespec mono_before, mono_after;
 	struct itimerspec its;
 	timer_t tid;
 	int delta;
@@ -82,6 +83,11 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
+	if (clock_gettime(CLOCK_MONOTONIC, &mono_before) != 0) {
+		perror("clock_gettime() was not successful\n");
+		return PTS_UNRESOLVED;
+	}
+
 	if (timer_create(CLOCK_REALTIME, &ev, &tid) != 0) {
 		perror("timer_create() did not return success\n");
 		return PTS_UNRESOLVED;
@@ -116,10 +122,30 @@ int main(void)
 
 	delta = tpT2.tv_sec - its.it_value.tv_sec;
 
+	if (clock_gettime(CLOCK_MONOTONIC, &mono_after) != 0) {
+		perror("clock_gettime() was not successful\n");
+		return PTS_UNRESOLVED;
+	}
+
 	// add back time waited to reset value and reset time
 	tpreset.tv_sec += tpT2.tv_sec - tpT0.tv_sec;
 	setBackTime(tpreset);
 
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
+
 	printf("delta: %d\n", delta);
 	if ((delta <= ACCEPTABLEDELTA) && (delta >= 0)) {
 		printf("Test PASSED\n");
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-1.c
index 75fa591e014601b2ef9308a118992a704365392b..1d450c5f9feef0bafcfbb1b847bec33cb3e49a1f 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-1.c
@@ -46,9 +46,11 @@ int main(void)
 	struct sigevent ev;
 	struct sigaction act;
 	struct timespec tsclock, ts, tsleft, tsreset;
+	struct timespec mono_before, mono_after;
 	struct itimerspec its;
 	timer_t tid;
 	sigset_t set;
+	int ns_ret;
 
 	/* Check that we're root...can't call clock_settime with CLOCK_REALTIME otherwise */
 	if (getuid() != 0) {
@@ -97,6 +99,11 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
+	if (clock_gettime(CLOCK_MONOTONIC, &mono_before) != 0) {
+		perror("clock_gettime() was not successful\n");
+		return PTS_UNRESOLVED;
+	}
+
 	if (clock_gettime(CLOCK_REALTIME, &tsclock) != 0) {
 		printf("clock_gettime() did not return success\n");
 		return PTS_UNRESOLVED;
@@ -112,7 +119,31 @@ int main(void)
 	ts.tv_sec = TIMERSEC + SLEEPDELTA;
 	ts.tv_nsec = 0;
 
-	if (nanosleep(&ts, &tsleft) != -1) {
+	ns_ret = nanosleep(&ts, &tsleft);
+
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
+
+	if (ns_ret != -1) {
 		printf("nanosleep() not interrupted\n");
 		return PTS_FAIL;
 	}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-2.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-2.c
index b8a60028c6d3d1a3c0d75922f39697b57329c440..67f90f2fb7d1d841c914614d57bccab1fe7d3537 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/5-2.c
@@ -46,9 +46,11 @@ int main(void)
 	struct sigevent ev;
 	struct sigaction act;
 	struct timespec tsclock, ts, tsleft, tsreset;
+	struct timespec mono_before, mono_after;
 	struct itimerspec its;
 	timer_t tid;
 	sigset_t set;
+	int ns_ret;
 
 	/* Check that we're root...can't call clock_settime with CLOCK_REALTIME otherwise */
 	if (getuid() != 0) {
@@ -97,6 +99,11 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
+	if (clock_gettime(CLOCK_MONOTONIC, &mono_before) != 0) {
+		perror("clock_gettime() was not successful\n");
+		return PTS_UNRESOLVED;
+	}
+
 	if (clock_gettime(CLOCK_REALTIME, &tsclock) != 0) {
 		printf("clock_gettime() did not return success\n");
 		return PTS_UNRESOLVED;
@@ -112,7 +119,31 @@ int main(void)
 	ts.tv_sec = TIMERSEC + SLEEPDELTA;
 	ts.tv_nsec = 0;
 
-	if (nanosleep(&ts, &tsleft) != -1) {
+	ns_ret = nanosleep(&ts, &tsleft);
+
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
+
+	if (ns_ret != -1) {
 		printf("nanosleep() not interrupted\n");
 		return PTS_FAIL;
 	}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-1.c
index 569eae904ef2eff41441029d3427313107febe53..ca325abb133195dad75f957f599a936a049bf657 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-1.c
@@ -36,6 +36,7 @@
 int main(void)
 {
 	struct timespec tsT0, tsT1;
+	struct timespec mono_before, mono_after;
 	int pid;
 
 	/* Check that we're root...can't call clock_settime with CLOCK_REALTIME otherwise */
@@ -49,6 +50,11 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
+	if (clock_gettime(CLOCK_MONOTONIC, &mono_before) != 0) {
+		perror("clock_gettime() was not successful\n");
+		return PTS_UNRESOLVED;
+	}
+
 	if ((pid = fork()) == 0) {
 		/* child here */
 		int flags = 0;
@@ -100,9 +106,31 @@ int main(void)
 			return PTS_UNRESOLVED;
 		}
 
+		if (clock_gettime(CLOCK_MONOTONIC, &mono_after) != 0) {
+			perror("clock_gettime() was not successful\n");
+			return PTS_UNRESOLVED;
+		}
+
 		getBeforeTime(&tsreset);	// get current time
 		tsreset.tv_sec += SMALLTIME;
 		setBackTime(tsreset);
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
+
 		if (WIFEXITED(i) && WEXITSTATUS(i)) {
 			printf("Test PASSED\n");
 			return PTS_PASS;
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-2.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-2.c
index 7c340b6c97ce03a1b04709f06996e5a66e1a653a..1eced660640881e559e8b739e1a59df8897b17d4 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/7-2.c
@@ -31,6 +31,7 @@
 
 #define CHILDPASS 1
 #define CHILDFAIL 0
+#define CHILDUNTESTED 2
 
 int main(void)
 {
@@ -58,13 +59,38 @@ int main(void)
 		/* child here */
 		int flags = 0;
 		struct timespec tsT3;
+		struct timespec mono_start, mono_end;
 
 		flags |= TIMER_ABSTIME;
+
+		if (clock_gettime(CLOCK_MONOTONIC, &mono_start) != 0) {
+			perror("clock_gettime() was not successful\n");
+			return CHILDFAIL;
+		}
+
 		if (clock_nanosleep(CLOCK_REALTIME, flags, &tsT1, NULL) != 0) {
 			printf("clock_nanosleep() did not return success\n");
 			return CHILDFAIL;
 		}
 
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
+
 		if (clock_gettime(CLOCK_REALTIME, &tsT3) != 0) {
 			perror("clock_gettime() did not return success\n");
 			return CHILDFAIL;
@@ -105,7 +131,10 @@ int main(void)
 
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
