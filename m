Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E1FC3DA70
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 15:21:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B9B73D1DCC
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 17:21:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAF273D1D2D
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 17:21:07 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DE60F1001578
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 17:21:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E5C3321B36
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 15:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722352866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=G59PIlwffJG18dtqf4H2C84RBBBToZhb7hhY+aVdpOY=;
 b=is++o0Sh5W2HklsKURaneNiln0MWxkGR6Fixa43G24XN4z4KiQuNJK+oHzKvWrpPZmifT+
 nWm/eghk/jTHZWPoMJr8Mh3DHFKDs5rx312rnXGNlMKDJeHcyx7QDq+bw1LfEsH36QMTcL
 wItWVFWB9FPM3BnqVOHlu0JO6AuxkGs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722352866;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=G59PIlwffJG18dtqf4H2C84RBBBToZhb7hhY+aVdpOY=;
 b=N0PJeOOLFl79trzi+dt0LPYRjdVMGc3HPXdmlpTCkmKvD5fH4cfj0l/b03gyU1VnRG5QyX
 WwAN39MWqtwLj0Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722352865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=G59PIlwffJG18dtqf4H2C84RBBBToZhb7hhY+aVdpOY=;
 b=aAjGVbbJkpnCsroTZ7DTZ+2FmzTdn4DIJPj0H81X0teX8o+Ea9s/cCcoTcVutf05/hNqQD
 lWOzE3YjRA7+5Q6bO1YBfielcUccLDbDKnR8GTV7EybXahu7bMBzmSP62gx65zQwfGy04e
 XZ2BZR9nneaSZnfnpO0a33jTMcBaNZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722352865;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=G59PIlwffJG18dtqf4H2C84RBBBToZhb7hhY+aVdpOY=;
 b=1ahkhZpv3hIELpw4Kxyy/6Pvyxtxt3Hk5foZfH/4NRLKTtEnDdZlCvyF0wfg65qK570LDj
 oSa2Gbc3HzT9BvDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE32913983
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 15:21:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5kwGNuEEqWYZfQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 15:21:05 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Jul 2024 17:20:05 +0200
Message-ID: <20240730152006.20018-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.60 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] timer_settime01: Check signal timing
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

Add a new check that the timer signal does not get delivered too early.
Also fix a bug where tc->it_value_tv_usec was ignored in TIMER_ABSTIME
subtests.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../syscalls/timer_settime/timer_settime01.c  | 49 +++++++++++++------
 1 file changed, 33 insertions(+), 16 deletions(-)

diff --git a/testcases/kernel/syscalls/timer_settime/timer_settime01.c b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
index 6fa1e7487..f8e7ffa22 100644
--- a/testcases/kernel/syscalls/timer_settime/timer_settime01.c
+++ b/testcases/kernel/syscalls/timer_settime/timer_settime01.c
@@ -58,8 +58,11 @@ static struct time64_variants variants[] = {
 
 static volatile int caught_signal;
 
-static void clear_signal(void)
+static void clear_signal(clock_t clock, const struct tst_ts *exptime)
 {
+	struct time64_variants *tv = &variants[tst_variant];
+	struct tst_ts curtime = { .type = tv->ts_type };
+
 	/*
 	 * The busy loop is intentional. The signal is sent after X
 	 * seconds of CPU time has been accumulated for the process and
@@ -74,6 +77,17 @@ static void clear_signal(void)
 	}
 
 	caught_signal = 0;
+
+	if (tv->clock_gettime(clock, tst_ts_get(&curtime)) < 0) {
+		tst_res(TFAIL, "clock_gettime(%s) failed",
+			get_clock_str(clock));
+		return;
+	}
+
+	if (tst_ts_lt(curtime, *exptime)) {
+		tst_res(TFAIL, "Timer %s expired too early",
+			get_clock_str(clock));
+	}
 }
 
 static void sighandler(int sig)
@@ -116,22 +130,22 @@ static void run(unsigned int n)
 		memset(&new_set, 0, sizeof(new_set));
 		memset(&old_set, 0, sizeof(old_set));
 
-		new_set.type = old_set.type = tv->ts_type;
+		new_set.type = old_set.type = timenow.type = tv->ts_type;
 		val = tc->it_value_tv_usec;
 
-		if (tc->flag & TIMER_ABSTIME) {
-			timenow.type = tv->ts_type;
-			if (tv->clock_gettime(clock, tst_ts_get(&timenow)) < 0) {
-				tst_res(TFAIL,
-					"clock_gettime(%s) failed - skipping the test",
-					get_clock_str(clock));
-				continue;
-			}
-			tst_ts_add_us(timenow, val);
+		if (tv->clock_gettime(clock, tst_ts_get(&timenow)) < 0) {
+			tst_res(TFAIL,
+				"clock_gettime(%s) failed - skipping the test",
+				get_clock_str(clock));
+			continue;
+		}
+
+		timenow = tst_ts_add_us(timenow, val);
+
+		if (tc->flag & TIMER_ABSTIME)
 			tst_its_set_value_from_ts(&new_set, timenow);
-		} else {
+		else
 			tst_its_set_value_from_us(&new_set, val);
-		}
 
 		tst_its_set_interval_from_us(&new_set, tc->it_interval_tv_usec);
 
@@ -157,11 +171,14 @@ static void run(unsigned int n)
 				tst_its_get_value_nsec(new_set));
 		}
 
-		clear_signal();
+		clear_signal(clock, &timenow);
 
 		/* Wait for another event when interval was set */
-		if (tc->it_interval_tv_usec)
-			clear_signal();
+		if (tc->it_interval_tv_usec) {
+			timenow = tst_ts_add_us(timenow,
+				tc->it_interval_tv_usec);
+			clear_signal(clock, &timenow);
+		}
 
 		tst_res(TPASS, "timer_settime(%s) passed",
 			get_clock_str(clock));
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
