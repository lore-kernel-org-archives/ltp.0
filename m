Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC2A6C3ABBC
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 09:27:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53B263CC175
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 11:27:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8ECAD3C9FA8
 for <ltp@lists.linux.it>; Fri,  9 May 2025 11:27:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CB48A200C1D
 for <ltp@lists.linux.it>; Fri,  9 May 2025 11:27:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 21DA121125;
 Fri,  9 May 2025 09:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746782856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/FCt5s07ZWaT3S+TmJJ5CYtfJIxOY6u6T7X1mJo1orQ=;
 b=X3iqFz9A+filLFq7VtMhDcRcWHE0HTRKDZ7MP53rKP485dV8zCwIiMMZcs8dcF4zpuI9m8
 o3ehibzRzknFiQyiXF8k3PKFE4LAvLgtPzEKznF9kMbuQrfGOcg1rFJcTpUqoGswYsQzO6
 MhfxOgBjwbSsANHLYbljLS8lwHOli+4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746782856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/FCt5s07ZWaT3S+TmJJ5CYtfJIxOY6u6T7X1mJo1orQ=;
 b=aY0xZBMkFTU+yMrmpD3SU2vprGMb7B1jtrZFMtTiTnju3vUPWSSI2rq3NCTzNsFrTmVaSj
 ncBm551myH2yuEDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JFjXAtMX;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kQmRvS8Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746782855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/FCt5s07ZWaT3S+TmJJ5CYtfJIxOY6u6T7X1mJo1orQ=;
 b=JFjXAtMXs3vF+xEAl/y2CnGgF/9g4wHp7s4rCksPnuM3WeDQ4JL0fvT/snWN0Pu3sDIOwx
 zEolV8LIXobXKdNOrelh3noEsBKSb5Yb9YwhAUAWJ5Wb+oxP1ku4eSAs4iZnM75k6dEMpa
 FtzuV0kcW2tmddTVL2KZ2sc5MCZVbaY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746782855;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/FCt5s07ZWaT3S+TmJJ5CYtfJIxOY6u6T7X1mJo1orQ=;
 b=kQmRvS8QM8+MTiPC7SniZranNMK2j/Fvhbda6ItrjB2N1wlf6GVxszB6z4+gD0doSm4Hit
 b6rCyj9fpB62fMAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F761139D0;
 Fri,  9 May 2025 09:27:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5FnFAofKHWinbQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 09 May 2025 09:27:35 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  9 May 2025 11:28:13 +0200
Message-ID: <20250509092813.12860-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 21DA121125
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.cz:mid];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] lib: tst_test: Add reproducible output.
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
Cc: valgrind-developers@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This commit adds an environment variable LTP_REPRODUCIBLE_OUTPUT that
when set skips printing parts of the test messages that may contain data
that differ on subsequent runs (e.g. pids).

With this you can run a test twice under a different conditions and
check if the test codeflow was identical by simply doing diff of the
outputs from the two runs.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Suggested-by: Martin Doucha <mdoucha@suse.cz>
CC: valgrind-developers@lists.sourceforge.net
---
 lib/tst_test.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 2bb4519dd..f14627544 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -64,6 +64,7 @@ static int mntpoint_mounted;
 static int ovl_mounted;
 static struct timespec tst_start_time; /* valid only for test pid */
 static int tdebug;
+static int reproducible_output;
 
 struct results {
 	int passed;
@@ -312,6 +313,9 @@ static void print_result(const char *file, const int lineno, int ttype,
 	str += ret;
 	size -= ret;
 
+	if (reproducible_output)
+		goto print;
+
 	ssize = size - 2;
 	ret = vsnprintf(str, size, fmt, va);
 	str += MIN(ret, ssize);
@@ -329,6 +333,7 @@ static void print_result(const char *file, const int lineno, int ttype,
 				"Next message is too long and truncated:");
 	}
 
+print:
 	snprintf(str, size, "\n");
 
 	/* we might be called from signal handler, so use write() */
@@ -1312,6 +1317,8 @@ static void do_setup(int argc, char *argv[])
 	if (tst_test->supported_archs && !tst_is_on_arch(tst_test->supported_archs))
 		tst_brk(TCONF, "This arch '%s' is not supported for test!", tst_arch.name);
 
+	reproducible_output = !!getenv("LTP_REPRODUCIBLE_OUTPUT");
+
 	assert_test_fn();
 
 	TCID = tid = get_tid(argv);
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
