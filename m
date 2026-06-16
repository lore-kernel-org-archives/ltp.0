Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E26FCD98CF
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 08:57:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F20A3E5998
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 10:57:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5173F3C96A5
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 10:57:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A64E56008DA
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 10:57:23 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6D1916C01A;
 Tue, 16 Jun 2026 08:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781600242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gcY9R0KZRX3DmXtmEMIN/lApQubc9l9N2IomiaCzhGY=;
 b=Ep2Na/zLx98uvs0JInPOJB26DffhLH9TGmFInreiSvg0IqWY4FymfOc+dCt+6yvhj5npFX
 HvhoQGuLswvcK1JLgrdbZh3dYsf9Teh8nuR9vH6+3MAoi/l0X3IlQx0VG+FB5HzRjrS+Uc
 eDMN6xBxbfwEJDzyL02FadJU63QXmvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781600242;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gcY9R0KZRX3DmXtmEMIN/lApQubc9l9N2IomiaCzhGY=;
 b=zatS7OD69nQoDn3kJ44ScX7qa/6yycU31fYAqSoiHLplt9Bh2E5vL2qt80VqCb/Lt64B/N
 RrXZ2fN6Tp1XifCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="Ep2Na/zL";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=zatS7OD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781600242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gcY9R0KZRX3DmXtmEMIN/lApQubc9l9N2IomiaCzhGY=;
 b=Ep2Na/zLx98uvs0JInPOJB26DffhLH9TGmFInreiSvg0IqWY4FymfOc+dCt+6yvhj5npFX
 HvhoQGuLswvcK1JLgrdbZh3dYsf9Teh8nuR9vH6+3MAoi/l0X3IlQx0VG+FB5HzRjrS+Uc
 eDMN6xBxbfwEJDzyL02FadJU63QXmvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781600242;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gcY9R0KZRX3DmXtmEMIN/lApQubc9l9N2IomiaCzhGY=;
 b=zatS7OD69nQoDn3kJ44ScX7qa/6yycU31fYAqSoiHLplt9Bh2E5vL2qt80VqCb/Lt64B/N
 RrXZ2fN6Tp1XifCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BA68779A8;
 Tue, 16 Jun 2026 08:57:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1S2OEPIPMWpOGAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 16 Jun 2026 08:57:22 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 16 Jun 2026 10:57:22 +0200
MIME-Version: 1.0
Message-Id: <20260616-fix_clock_gettime_openposix-v1-1-ae4ade48039d@suse.com>
X-B4-Tracking: v=1; b=H4sIAPEPMWoC/x3MQQqAIBBA0avErBNKwrCrREhMYw2VikYE4d2Tl
 g8+/4VEkSnBUL0Q6ebE3hW0dQW4zW4lwUsxyEaqRrVKWH4MHh53s9J18UnGB3LBJ34Eqr7XqG2
 3aAnlECKV/L+PU84fHuK6IW0AAAA=
X-Change-ID: 20260616-fix_clock_gettime_openposix-c6779c9f4d92
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781600242; l=3870;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=CA19IXO1HVs+Nb84OB5Ktq1Qk8Y6DTLky1hC7QPw3n4=;
 b=hqa5SlG1oxHTz+KRyicERrs04bwy1M1zGkpJh84eZ2qVPz8hJTyjeW3UBzwEsO4Joj9pOFjUg
 0qcyXZDp43SB/c5sw/2K5PeMBAAM1gb4v7Gh+81I19BnAoeXGS1qrfG
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6D1916C01A
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] clock_settime/4-1: CLOCK_MONOTONIC for timer
 validation
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

During test execution, any service which is operating on clock might
interfere with the final result. For this reason, we use CLOCK_MONOTONIC
(when available) in order to the compute the right delta between
clock_gettime() calls.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .../conformance/interfaces/clock_settime/4-1.c     | 36 ++++++++++++++++------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c
index ebd609963a3651212447ff2ab0885e20b19ba302..cd33ccde5030f54e2c60ee5e2c616dea6c375910 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_settime/4-1.c
@@ -16,12 +16,10 @@
  * - set time back to T0
  * - wait for the timer to expire
  * - get time T2
- * - ensure that:  T2 >= T1 and (T2-T1) <= ACCEPTABLEDELTA
+ * - ensure the timer fired ~TIMEROFFSET seconds after clock_settime()
+ *   using CLOCK_MONOTONIC when available (immune to NTP adjustments)
  *
  * signal SIGTOTEST is used.
- *
- * adam.li: I think should check that (abs(T2-T1) <= ACCEPTABLEDELTA)
- * 2004-04-30
  */
 #include <stdio.h>
 #include <time.h>
@@ -43,12 +41,14 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 {
 	struct sigevent ev;
 	struct timespec tpT0, tpT2, tpreset;
+	struct timespec mono_before, mono_after;
 	struct itimerspec its;
 	timer_t tid;
-	int delta;
+	long delta;
 	int sig;
 	sigset_t set;
 	int attempt, ret;
+	int use_mono = pts_mono_available();
 
 	/* Check that we're root...can't call clock_settime with CLOCK_REALTIME otherwise */
 	if (geteuid() != 0) {
@@ -103,6 +103,10 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 
 		sleep(SLEEPTIME);
 		getBeforeTime(&tpreset);
+
+		if (use_mono)
+			clock_gettime(CLOCK_MONOTONIC, &mono_before);
+
 		if (clock_settime(CLOCK_REALTIME, &tpT0) != 0) {
 			perror("clock_settime() was not successful");
 			return PTS_UNRESOLVED;
@@ -113,12 +117,24 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 			return PTS_UNRESOLVED;
 		}
 
+		if (use_mono)
+			clock_gettime(CLOCK_MONOTONIC, &mono_after);
+
 		if (clock_gettime(CLOCK_REALTIME, &tpT2) != 0) {
 			printf("clock_gettime() was not successful\n");
 			return PTS_UNRESOLVED;
 		}
 
-		delta = tpT2.tv_sec - its.it_value.tv_sec;
+		/*
+		 * Use CLOCK_MONOTONIC to compute delta when available
+		 * since CLOCK_REALTIME may be adjusted by NTP between
+		 * clock_settime() and clock_gettime(). The timer
+		 * should fire TIMEROFFSET seconds after the reset.
+		 */
+		if (use_mono)
+			delta = (mono_after.tv_sec - mono_before.tv_sec) - TIMEROFFSET;
+		else
+			delta = tpT2.tv_sec - its.it_value.tv_sec;
 
 		// add back time waited to reset value and reset time
 		tpreset.tv_sec += tpT2.tv_sec - tpT0.tv_sec;
@@ -137,13 +153,13 @@ int test_main(int argc PTS_ATTRIBUTE_UNUSED, char **argv PTS_ATTRIBUTE_UNUSED)
 		return PTS_UNTESTED;
 	}
 
-	printf("delta: %d\n", delta);
-	if ((delta <= ACCEPTABLEDELTA) && (delta >= 0)) {
+	printf("delta: %ld\n", delta);
+	if (labs(delta) <= ACCEPTABLEDELTA) {
 		printf("Test PASSED\n");
 		return PTS_PASS;
 	}
 
-	printf("FAIL:  Ended %d, not %d\n",
-	       (int)tpT2.tv_sec, (int)its.it_value.tv_sec);
+	printf("FAIL:  Timer fired %ld seconds %s expected\n",
+	       labs(delta), delta > 0 ? "after" : "before");
 	return PTS_FAIL;
 }

---
base-commit: b4d31ea5d5c16628b9c45932fc98b929ca2ceece
change-id: 20260616-fix_clock_gettime_openposix-c6779c9f4d92

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
