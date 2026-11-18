Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02EE606A31C
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=G1oWo7eA;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2nM4ZT/t;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=G1oWo7eA;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=2nM4ZT/t
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 748AA3E9357
	for <ltp@archiver.kernel.org>; Wed, 18 Nov 2026 11:17:09 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 167123E932F
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 11:16:53 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B20152009C7
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 11:16:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 205A11FAA3
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 10:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794997012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=51ux3/sidH3vSPHatGzP5SVwzzxL/7aMSirqjQ6Oh/g=;
 b=G1oWo7eAjGAHi2bcP3lEK7+X9d+/coRAl040I+b+NSuOVEv8aSuTqQbeHnJqJQ+zH/p+7e
 zvHJ+erAyBkcHcYuV2mrm0JmIfxHXutN5XhohTmv1uw9r4BNZD6Mem/+d53y/BGhCgoXoX
 JM30GWhgVYhkCBdmWbqPFukMMiQgYhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794997012;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=51ux3/sidH3vSPHatGzP5SVwzzxL/7aMSirqjQ6Oh/g=;
 b=2nM4ZT/tkAywGMNvEYBCnwsgX19ZYtFPSmYQJRwH8CH8jONNBb1EP+nbnFH+a0rzeYGXZm
 XGC9LHJXdbgWhtDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1794997012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=51ux3/sidH3vSPHatGzP5SVwzzxL/7aMSirqjQ6Oh/g=;
 b=G1oWo7eAjGAHi2bcP3lEK7+X9d+/coRAl040I+b+NSuOVEv8aSuTqQbeHnJqJQ+zH/p+7e
 zvHJ+erAyBkcHcYuV2mrm0JmIfxHXutN5XhohTmv1uw9r4BNZD6Mem/+d53y/BGhCgoXoX
 JM30GWhgVYhkCBdmWbqPFukMMiQgYhc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1794997012;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=51ux3/sidH3vSPHatGzP5SVwzzxL/7aMSirqjQ6Oh/g=;
 b=2nM4ZT/tkAywGMNvEYBCnwsgX19ZYtFPSmYQJRwH8CH8jONNBb1EP+nbnFH+a0rzeYGXZm
 XGC9LHJXdbgWhtDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E6612134E9
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 10:16:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id chbNLxN7/WoyNAAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 18 Nov 2026 10:16:51 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 18 Nov 2026 11:17:20 +0100
Message-ID: <20261118101720.2838268-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-11.80 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -11.80
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sys_rtc01: TCONF on system time mismatch when
 STA_UNSYNC is unset
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

It turns out that the STA_UNSYNC flag is set at boot and cleared by ntp,
so we should skip the TFAIL when the flag is cleared, since that means
that NTP have adjusted the system time and it's possibly out of sync
with RTC.

Fixes: 3d11e5dd622e "sys_rtc01: Report TCONF on system time mismatch when STA_UNSYNC is set"
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/sysfs/class/rtc/sys_rtc01.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/sysfs/class/rtc/sys_rtc01.c b/testcases/kernel/sysfs/class/rtc/sys_rtc01.c
index 0e1c69f95..4857d4a8b 100644
--- a/testcases/kernel/sysfs/class/rtc/sys_rtc01.c
+++ b/testcases/kernel/sysfs/class/rtc/sys_rtc01.c
@@ -43,12 +43,9 @@
  * test performs, so on a long-running system a purely fixed slack would
  * eventually produce false failures even on perfectly healthy hardware.
  *
- * If the system was booted with an RTC that was off the current time and the
- * system clock was later stepped in userspace via :manpage:`clock_settime(2)`
- * or :manpage:`settimeofday(2)` without updating the RTC, the kernel sets
- * STA_UNSYNC and CONFIG_RTC_SYSTOHC does not write the system clock back to
- * the RTC while hctosys remains 1. Report TCONF instead of TFAIL when
- * since_epoch diverges from system time while STA_UNSYNC is set.
+ * If system time was corrected by NTP the kernel clears STA_UNSYNC flag.
+ * Report TCONF instead of TFAIL when since_epoch diverges from system time
+ * when STA_UNSYNC is not set.
  *
  * Under virtualization the slack is additionally multiplied, since a VM's
  * clock (and thus its emulated RTC) commonly lags real time by tens of
@@ -112,14 +109,14 @@ static long read_hctosys(const char *name)
 	return TST_SYSFS_READ_LI(PATH_CLASS_RTC "/%s/hctosys", name);
 }
 
-static int is_clock_unsynced(void)
+static int clock_is_synced(void)
 {
 	struct timex tx = { .modes = 0 };
 
 	if (adjtimex(&tx) == -1)
 		tst_brk(TBROK | TERRNO, "adjtimex() failed");
 
-	return !!(tx.status & STA_UNSYNC);
+	return !(tx.status & STA_UNSYNC);
 }
 
 static void read_rtc_snapshot(const char *name, char *date, size_t date_size,
@@ -217,9 +214,9 @@ static void check_rtc(const char *name, int any_hctosys)
 			"%s: since_epoch (%lld), system time (%lld), diff %llds <= slack %lds",
 			name, (long long)since_epoch, (long long)sys_epoch,
 			diff, slack);
-	} else if (is_clock_unsynced()) {
+	} else if (clock_is_synced()) {
 		tst_res(TCONF,
-			"%s: since_epoch (%lld), system time (%lld), diff %llds > slack %lds (STA_UNSYNC is set)",
+			"%s: since_epoch (%lld), system time (%lld), diff %llds > slack %lds (STA_UNSYNC is not set)",
 			name, (long long)since_epoch, (long long)sys_epoch,
 			diff, slack);
 	} else {
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
