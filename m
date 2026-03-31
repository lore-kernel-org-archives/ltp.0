Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EC01061B39
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 11:49:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 544CE3E2F7E
	for <ltp@archiver.kernel.org>; Tue, 31 Mar 2026 13:49:42 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A83073C2756
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 13:49:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0B6061A007A2
 for <ltp@lists.linux.it>; Tue, 31 Mar 2026 13:49:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4A2984D1E3;
 Tue, 31 Mar 2026 11:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774957756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N/vKmGkFgcQxk+8GAaAZX9vAQC+0lvTTvtYG1utCWho=;
 b=fJPhs6SFDXwB1WPWt+FDImwzand3AVJbBiPMYU47WjabwpksnuGKKzem6+ofmaN6GJY/Wk
 Axzl6jEtTN/bVR2YL4Su234dOjdhOnVcjHrxRXnvMDygPRWlJb/FkSuK1rAn/iaaOYosB+
 h23R+hmZ4KE86nNR9rorL/sZxS10pz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774957756;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N/vKmGkFgcQxk+8GAaAZX9vAQC+0lvTTvtYG1utCWho=;
 b=AamvQDuGo+uvL049YV6TaMjJMF3waft3G3/4i+Cq71sl7Ug1JAle0s6Zq1OHBQrg36MTkz
 JkwVppY4VnCPalDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774957756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N/vKmGkFgcQxk+8GAaAZX9vAQC+0lvTTvtYG1utCWho=;
 b=fJPhs6SFDXwB1WPWt+FDImwzand3AVJbBiPMYU47WjabwpksnuGKKzem6+ofmaN6GJY/Wk
 Axzl6jEtTN/bVR2YL4Su234dOjdhOnVcjHrxRXnvMDygPRWlJb/FkSuK1rAn/iaaOYosB+
 h23R+hmZ4KE86nNR9rorL/sZxS10pz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774957756;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=N/vKmGkFgcQxk+8GAaAZX9vAQC+0lvTTvtYG1utCWho=;
 b=AamvQDuGo+uvL049YV6TaMjJMF3waft3G3/4i+Cq71sl7Ug1JAle0s6Zq1OHBQrg36MTkz
 JkwVppY4VnCPalDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2813C4A0A2;
 Tue, 31 Mar 2026 11:49:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jrgTCLy0y2kCbwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 31 Mar 2026 11:49:16 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 31 Mar 2026 13:48:56 +0200
MIME-Version: 1.0
Message-Id: <20260331-nanosleep_posix_fix-v1-1-7a707f871582@suse.com>
X-B4-Tracking: v=1; b=H4sIAKe0y2kC/x2MWwqAIBAArxL7neAD/OgqESK61UKouBCCePekz
 xmY6cBYCRm2pUPFl5hymqDWBcLt04WC4mTQUltpjBLJp8wPYnElMzV3UhPWKqt9CF5hhFmWilP
 /1/0Y4wP7bpRxZQAAAA==
X-Change-ID: 20260331-nanosleep_posix_fix-66162acca1ed
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774957756; l=8054;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=tE5g1rymUoaL6FTelQrprJFFa88MW8OBGGZEWaXALLY=;
 b=aXy9bw1qJOubqLfYmx7izzlOv3Oq9/kLsC6piA9UtRqnFC+qyAvTMIMAW94U91SQl8QX0bDi7
 u3ghfUS4be8DlV0z5BJdKNviTIZEm4lA7Eu1wPLpvQ7JAaJMN/1qAW+
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] nanosleep: Use CLOCK_MONOTONIC for elapsed time
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
the correct clock for measuring elapsed durations.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-1.c | 4 ++--
 testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-2.c | 4 ++--
 testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-3.c | 4 ++--
 .../open_posix_testsuite/conformance/interfaces/nanosleep/10000-1.c   | 4 ++--
 testcases/open_posix_testsuite/conformance/interfaces/nanosleep/2-1.c | 4 ++--
 testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-2.c | 4 ++--
 testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-2.c | 4 ++--
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-1.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-1.c
index 687d01e288d914fbbdc18287746f71296c7a4327..d76451e3438e15d44ab2c2b8d0b349e666daec8c 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-1.c
@@ -18,7 +18,7 @@ int main(void)
 	int sleepnsec = 3;
 	int slepts = 0, sleptns = 0;
 
-	if (clock_gettime(CLOCK_REALTIME, &tsbefore) == -1) {
+	if (clock_gettime(CLOCK_MONOTONIC, &tsbefore) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
@@ -30,7 +30,7 @@ int main(void)
 		return PTS_UNRESOLVED;
 	}
 
-	if (clock_gettime(CLOCK_REALTIME, &tsafter) == -1) {
+	if (clock_gettime(CLOCK_MONOTONIC, &tsafter) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-2.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-2.c
index 76f31982508dc87a4f400022cd46fe766071f27d..f72cbcfbbe06a0059bbc17ad617ca76c65651a93 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-2.c
@@ -21,7 +21,7 @@ int main(void)
 	int sleepsec = 30;
 	int pid;
 
-	if (clock_gettime(CLOCK_REALTIME, &tsbefore) == -1) {
+	if (clock_gettime(CLOCK_MONOTONIC, &tsbefore) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
@@ -46,7 +46,7 @@ int main(void)
 			perror("Error waiting for child to exit\n");
 			return PTS_UNRESOLVED;
 		}
-		if (clock_gettime(CLOCK_REALTIME, &tsafter) == -1) {
+		if (clock_gettime(CLOCK_MONOTONIC, &tsafter) == -1) {
 			perror("Error in clock_gettime()\n");
 			return PTS_UNRESOLVED;
 		}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-3.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-3.c
index 31ac00858018c3741758d0b5f2bf28f87aa6c1bf..07ce767123443cea2754c8b5ff2a20ed536cbfec 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-3.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/1-3.c
@@ -28,7 +28,7 @@ int main(void)
 	int pid;
 	struct sigaction act;
 
-	if (clock_gettime(CLOCK_REALTIME, &tsbefore) == -1) {
+	if (clock_gettime(CLOCK_MONOTONIC, &tsbefore) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
@@ -64,7 +64,7 @@ int main(void)
 			perror("Error waiting for child to exit\n");
 			return PTS_UNRESOLVED;
 		}
-		if (clock_gettime(CLOCK_REALTIME, &tsafter) == -1) {
+		if (clock_gettime(CLOCK_MONOTONIC, &tsafter) == -1) {
 			perror("Error in clock_gettime()\n");
 			return PTS_UNRESOLVED;
 		}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/10000-1.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/10000-1.c
index 883885df434fb4ba3bb555dd565880f14623a984..8bd372f590314faa8f15fccbe5325e9fa31a6f95 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/10000-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/10000-1.c
@@ -56,13 +56,13 @@ int main(void)
 		tssleepfor.tv_nsec = sleepvalid[i][1];
 		printf("sleep %d sec %d nsec\n",
 		       (int)tssleepfor.tv_sec, (int)tssleepfor.tv_nsec);
-		if (clock_gettime(CLOCK_REALTIME, &tsbefore) == -1) {
+		if (clock_gettime(CLOCK_MONOTONIC, &tsbefore) == -1) {
 			perror("Error in clock_gettime()\n");
 			return PTS_UNRESOLVED;
 		}
 
 		if (nanosleep(&tssleepfor, &tsstorage) == 0) {
-			if (clock_gettime(CLOCK_REALTIME, &tsafter) == -1) {
+			if (clock_gettime(CLOCK_MONOTONIC, &tsafter) == -1) {
 				perror("Error in clock_gettime()\n");
 				return PTS_UNRESOLVED;
 			}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/2-1.c
index cce3941e7be7212ea286647ec601d3ecbb9bb85a..f44d0f938a586defa3ef244371f1850865801afa 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/2-1.c
@@ -25,7 +25,7 @@ int main(void)
 	int failure = 0;
 	int slepts, sleptns;
 
-	if (clock_gettime(CLOCK_REALTIME, &tsbefore) == -1) {
+	if (clock_gettime(CLOCK_MONOTONIC, &tsbefore) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
@@ -38,7 +38,7 @@ int main(void)
 			return PTS_UNRESOLVED;
 		}
 
-		if (clock_gettime(CLOCK_REALTIME, &tsafter) == -1) {
+		if (clock_gettime(CLOCK_MONOTONIC, &tsafter) == -1) {
 			perror("Error in clock_gettime()\n");
 			return PTS_UNRESOLVED;
 		}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-2.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-2.c
index bfc271edf25f9cd0f343eef11b335d5da20eb646..201ab72a5d4a5a345839fb87f4f1621c70a5bb36 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/3-2.c
@@ -26,7 +26,7 @@ int main(void)
 	int pid, slepts;
 	struct timespec tsbefore, tsafter;
 
-	if (clock_gettime(CLOCK_REALTIME, &tsbefore) != 0) {
+	if (clock_gettime(CLOCK_MONOTONIC, &tsbefore) != 0) {
 		perror("clock_gettime() did not return success\n");
 		return PTS_UNRESOLVED;
 	}
@@ -74,7 +74,7 @@ int main(void)
 			return PTS_FAIL;
 		}
 
-		if (clock_gettime(CLOCK_REALTIME, &tsafter) == -1) {
+		if (clock_gettime(CLOCK_MONOTONIC, &tsafter) == -1) {
 			perror("Error in clock_gettime()\n");
 			return PTS_UNRESOLVED;
 		}
diff --git a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-2.c b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-2.c
index caf4470e4a26b27ec79deed27c147e2feceffdf8..eab419591ab0c27a5d2dfb556cf2f13f7cc25e6e 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-2.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/nanosleep/7-2.c
@@ -34,7 +34,7 @@ int main(void)
 	int pid;
 	struct sigaction act;
 
-	if (clock_gettime(CLOCK_REALTIME, &tsbefore) == -1) {
+	if (clock_gettime(CLOCK_MONOTONIC, &tsbefore) == -1) {
 		perror("Error in clock_gettime()\n");
 		return PTS_UNRESOLVED;
 	}
@@ -60,7 +60,7 @@ int main(void)
 			return CHILDFAILURE;
 		}
 
-		if (clock_gettime(CLOCK_REALTIME, &tsafter) == -1) {
+		if (clock_gettime(CLOCK_MONOTONIC, &tsafter) == -1) {
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
