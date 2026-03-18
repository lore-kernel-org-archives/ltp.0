Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB01103E18F
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 14:41:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D72C3E613B
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 15:41:42 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BF4B3D0E54
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 15:41:24 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A4083140097F
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 15:41:23 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 791F85BD6B;
 Wed, 18 Mar 2026 14:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773844882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=g7/5MuiDEUYuNY/DdaY9RYk2PIRPp2+jTTfJPqTGRXg=;
 b=aCPeVGXi4L7622gvCmJqs22gh7x1Qo3wXwH5cvt7+nK0te8lfRoskA2v7yTDK51kwdsxVt
 fq/vdhDL+4usprx3CwO0SV0rGz5A90l1xQdGp42sv1J8CG9fQ3RcXkDVSNvE1FyFG00Plt
 1Iy5EwsgEBByEiB+P4H29Mwjhrr7iWo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773844882;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=g7/5MuiDEUYuNY/DdaY9RYk2PIRPp2+jTTfJPqTGRXg=;
 b=LW5WmquqhNF50M+HxIvTy2xGbZzOFRkhiYh7WjZTka+XXBzb/PedAlmnoG34IM2bktQPOx
 r1im0m5h988wSDBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773844881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=g7/5MuiDEUYuNY/DdaY9RYk2PIRPp2+jTTfJPqTGRXg=;
 b=yu7GKdRAfM9wVgaSsGN4gze7x5gIqGEt4Sdb0aclhjX2T4hZaEA23A9ZErVcrB6ABr0gcX
 CWsjbwiHlFKUcabCULtIMWNuzW0Q1v/C/W8RRZ95Qj/gjiPqDxtChYMZaga07qWXssuOfV
 j0IrrN3Hte1ekSdvqFgjOgGGKXAoz90=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773844881;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=g7/5MuiDEUYuNY/DdaY9RYk2PIRPp2+jTTfJPqTGRXg=;
 b=R0+vq416/TpXRs7lWQev2pRdJNB2wG9XR62DMK1d0gPG7MH1g7kq8jZ90XjkaO+EMCYYX3
 dGrn0bDC7VxH92Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C28C24273B;
 Wed, 18 Mar 2026 14:41:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id snD3I5C5umkUcAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 18 Mar 2026 14:41:20 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 18 Mar 2026 15:41:13 +0100
Message-ID: <20260318144113.30981-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[tst_test.sh:url, imap1.dmz-prg2.suse.org:helo,
 suse.cz:mid, suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/1] lib: Print tcnt in tst_{brk,res}()
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

This helps readability on tests with high tcnt.

Inspired by tst_test.sh (shell API) which prints $TST_COUNT in tst_res
and tst_brk.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: testing on open01.c which has tcnt = 2.
Before:
tst_tmpdir.c:308: TINFO: Using /tmp/LTP_opebwazQS as tmpdir (tmpfs filesystem)
tst_test.c:2059: TINFO: LTP version: 20260130-78-g68660b12c8
tst_test.c:1887: TINFO: Overall timeout per run is 0h 00m 30s
open01.c:56: TPASS: sticky bit is set as expected
open01.c:56: TPASS: directory bit is set as expected

With the patch:

tst_tmpdir.c:308: 1 TINFO: Using /tmp/LTP_opezEOyj2 as tmpdir (tmpfs filesystem)
tst_test.c:2059: 1 TINFO: LTP version: 20260130-79-g8d8379aa73
tst_test.c:1887: 1 TINFO: Overall timeout per run is 0h 00m 30s
open01.c:56: 1 TPASS: sticky bit is set as expected
open01.c:56: 2 TPASS: directory bit is set as expected

Setup has "1", cleanup has tcnt + 1. We could even print "0" for setup
or even for cleanup as well.

Kind regards,
Petr

 lib/tst_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 2d62ab164d..b9593b743a 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -69,6 +69,7 @@ static float duration = -1;
 static float timeout_mul = -1;
 static int reproducible_output;
 static int quiet_output;
+static unsigned int tcnt;
 
 struct context {
 	int32_t lib_pid;
@@ -344,7 +345,7 @@ static void print_result(const char *file, const int lineno, int ttype,
 		str_errno = tst_strerrno(int_errno);
 	}
 
-	ret = snprintf(str, size, "%s:%i: ", file, lineno);
+	ret = snprintf(str, size, "%s:%i: %u ", file, lineno, tcnt+1);
 	str += ret;
 	size -= ret;
 
@@ -1705,7 +1706,6 @@ static void heartbeat(void)
 
 static void run_tests(void)
 {
-	unsigned int i;
 	struct results saved_results;
 
 	if (!tst_test->test) {
@@ -1724,10 +1724,10 @@ static void run_tests(void)
 		return;
 	}
 
-	for (i = 0; i < tst_test->tcnt; i++) {
+	for (tcnt = 0; tcnt < tst_test->tcnt; tcnt++) {
 		saved_results = *results;
 		heartbeat();
-		tst_test->test(i);
+		tst_test->test(tcnt);
 
 		if (tst_getpid() != context->main_pid)
 			exit(0);
@@ -1735,7 +1735,7 @@ static void run_tests(void)
 		tst_reap_children();
 
 		if (results_equal(&saved_results, results))
-			tst_brk(TBROK, "Test %i haven't reported results!", i);
+			tst_brk(TBROK, "Test %i haven't reported results!", tcnt);
 	}
 }
 
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
