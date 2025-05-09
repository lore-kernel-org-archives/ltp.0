Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 730F6C3ABBC
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 08:33:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA0E43CC199
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 10:33:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B77223CC155
 for <ltp@lists.linux.it>; Fri,  9 May 2025 10:33:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 02676200C20
 for <ltp@lists.linux.it>; Fri,  9 May 2025 10:33:39 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E284C1F45E;
 Fri,  9 May 2025 08:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746779619; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+Qb3gDPazDUuKx/wOH8HQRt3EZEp/z3UHDAfsduU0J4=;
 b=zp50bNUnp7RJ4bQ7kA9fsO4hA2Bx3VKZ8jwjyWHBKNInS+TOp67HFuExlYTIbSrahGPyvz
 J7I+3pGOKX4+/V67u45Y7BqgzKTRFT7Ga3jI/Fl7bp67GTqFfCpPAd9Khw8KDZk87RIWmY
 pKnm+1IrA3nAndxrOWk/Q1d8ebPux+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746779619;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+Qb3gDPazDUuKx/wOH8HQRt3EZEp/z3UHDAfsduU0J4=;
 b=DA/hM4qRiz8veNHynrE/+XibiuWU+P1wxT47z4SqFaeHsIjwTQp9JuEUI073sjCtY68HK1
 c6Z9IFEuMUM4iZBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1746779618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+Qb3gDPazDUuKx/wOH8HQRt3EZEp/z3UHDAfsduU0J4=;
 b=hyAzRCGMrwG1NvR+Zr4YTkfOwQ5ytPWjB0lUXTkXA5XYUKqOlaqKUWWZUf+jSfo+dFHPSS
 ijr6XKM77+EQNfda56zXCZInrUEeEfK7viaWNoEkqRtpvoppomnPL6wXIVp4GXVwRPysYz
 Jgef+KFrc7kXu9ivHvCS/Nk9jZ2MrsE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1746779618;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+Qb3gDPazDUuKx/wOH8HQRt3EZEp/z3UHDAfsduU0J4=;
 b=g4XYbgxrPaB515k3J+UjdaEDaATd+ISmcd28v85UNq+ZopgGDDsXVth/Vpm0e93UWbJE+9
 BKqEH3+EVuXajvAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C68BB13931;
 Fri,  9 May 2025 08:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PXsYLeK9HWgXXAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 09 May 2025 08:33:38 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  9 May 2025 10:34:20 +0200
Message-ID: <20250509083420.26936-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lib: tst_test: Add reproducible output.
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
index 2bb4519dd..3f94a1607 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -64,6 +64,7 @@ static int mntpoint_mounted;
 static int ovl_mounted;
 static struct timespec tst_start_time; /* valid only for test pid */
 static int tdebug;
+static int reproducible_output;
 
 struct results {
 	int passed;
@@ -304,6 +305,9 @@ static void print_result(const char *file, const int lineno, int ttype,
 	str += ret;
 	size -= ret;
 
+	if (reproducible_output)
+		goto print;
+
 	if (tst_color_enabled(STDERR_FILENO))
 		ret = snprintf(str, size, "%s%s: %s", tst_ttype2color(ttype),
 			       res, ANSI_COLOR_RESET);
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
