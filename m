Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C3CF99355
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 08:42:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC1213E4ACB
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 10:42:48 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E57A53E2D79
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:41:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 87B41600958
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:41:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 99AA26A833;
 Thu, 23 Apr 2026 08:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776933695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9baD9gSDr7FVLUAzvlku5cy+ZyjKuhqIfpcbeBt9tdo=;
 b=TkCFP9wUXpQYgnmvQ1p83L5NkjRG8bgZe2DapKEmEFV/2iQMc5oU5cJz8zJT2rozqfXP71
 YuRZvoPBak6x8BoefhY7a4vGQtq76vZ507MC89GU/0gtKedbiVdvKSnW9mZl9Z+xMhVtuO
 CrOHRk6SyP0JFGxozMEtzLdJFcA9ygY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776933695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9baD9gSDr7FVLUAzvlku5cy+ZyjKuhqIfpcbeBt9tdo=;
 b=Bb660Rq5xCqROf2vGN+j26CwegcxQyC3kh3cLQ2l1t6/ygHGPrGHoKPpVkPlzyFnQ7Elbz
 dc2yQJYJqvwyLwBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=TkCFP9wU;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Bb660Rq5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776933695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9baD9gSDr7FVLUAzvlku5cy+ZyjKuhqIfpcbeBt9tdo=;
 b=TkCFP9wUXpQYgnmvQ1p83L5NkjRG8bgZe2DapKEmEFV/2iQMc5oU5cJz8zJT2rozqfXP71
 YuRZvoPBak6x8BoefhY7a4vGQtq76vZ507MC89GU/0gtKedbiVdvKSnW9mZl9Z+xMhVtuO
 CrOHRk6SyP0JFGxozMEtzLdJFcA9ygY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776933695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9baD9gSDr7FVLUAzvlku5cy+ZyjKuhqIfpcbeBt9tdo=;
 b=Bb660Rq5xCqROf2vGN+j26CwegcxQyC3kh3cLQ2l1t6/ygHGPrGHoKPpVkPlzyFnQ7Elbz
 dc2yQJYJqvwyLwBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6290E593B0;
 Thu, 23 Apr 2026 08:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UOWaFj/b6Wl6fgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 23 Apr 2026 08:41:35 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 23 Apr 2026 10:41:21 +0200
Message-ID: <20260423084123.657690-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423084123.657690-1-pvorel@suse.cz>
References: <20260423084123.657690-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,suse.com,redhat.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 R_RATELIMIT(0.00)[to_ip_from(RLmduujpsdff44oyku5bsyor5h)];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Queue-Id: 99AA26A833
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 5/6] lib: Merge functionality of LTP_QUIET into
 LTP_REPRODUCIBLE_OUTPUT
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
Cc: Martin Cermak <mcermak@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

LTP_REPRODUCIBLE_OUTPUT=1 environment variable was added in 5894abc5f to
help valgrind to use LTP for testing. It discards the actual content of
the messages printed by the test (removes everything after printing
TINFO/TPASS/TFAIL/... flag).

Later LTP_QUIET=1 was added which suppresses printing TCONF, TINFO, and
TDEBUG messages.

Valgrind project uses both variables but no need to handle them
separately. Therefore merge functionality of LTP_QUIET into
LTP_REPRODUCIBLE_OUTPUT.

LTP_QUIET was not even documented in HTML doc.

Also fix help description, because TWARN was not skipped, although doc
claimed to do.

Implements: https://github.com/linux-test-project/ltp/issues/1306
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v4->v5:
* Remove wrongly stated TWARN (error on code on master)
* Fix missing new lines in help (AI)
* Use single fprintf (Li)

 doc/users/setup_tests.rst |  5 +++--
 lib/tst_test.c            | 16 +++++-----------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
index 6f1d996e18..491a5b003a 100644
--- a/doc/users/setup_tests.rst
+++ b/doc/users/setup_tests.rst
@@ -43,8 +43,9 @@ users.
        Shell language: ``TST_NEEDS_DEVICE=1``.
 
    * - LTP_REPRODUCIBLE_OUTPUT
-     - When set to ``1`` or ``y`` discards the actual content of the messages
-       printed by the test (suitable for a reproducible output).
+     - When set to ``1`` or ``y`` uppress printing TCONF, TINFO and TDEBUG
+       messages and discards the actual content of the other messages printed
+       by the test (suitable for a reproducible output).
 
    * - LTP_SINGLE_FS_TYPE
      - Specifies single filesystem to run the test on instead all supported
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 12f7489d4e..a0b55049ff 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -68,7 +68,6 @@ static int iterations = 1;
 static float duration = -1;
 static float timeout_mul = -1;
 static int reproducible_output;
-static int quiet_output;
 
 struct context {
 	int32_t lib_pid;
@@ -307,7 +306,7 @@ static void print_result(const char *file, const int lineno, int ttype,
 		res = "TBROK";
 	break;
 	case TCONF:
-		if (quiet_output)
+		if (reproducible_output)
 			return;
 		res = "TCONF";
 	break;
@@ -315,12 +314,12 @@ static void print_result(const char *file, const int lineno, int ttype,
 		res = "TWARN";
 	break;
 	case TINFO:
-		if (quiet_output)
+		if (reproducible_output)
 			return;
 		res = "TINFO";
 	break;
 	case TDEBUG:
-		if (quiet_output)
+		if (reproducible_output)
 			return;
 		res = "TDEBUG";
 	break;
@@ -676,8 +675,8 @@ static void print_help(void)
 	fprintf(stderr, "LTP_DEV                  Path to the block device to be used (for .needs_device)\n");
 	fprintf(stderr, "LTP_DEV_FS_TYPE          Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
 	fprintf(stderr, "LTP_DEBUG                Print debug messages (set 1(y) or 2)\n");
-	fprintf(stderr, "LTP_REPRODUCIBLE_OUTPUT  Values 1 or y discard the actual content of the messages printed by the test\n");
-	fprintf(stderr, "LTP_QUIET                Values 1 or y will suppress printing TCONF, TWARN, TINFO, and TDEBUG messages\n");
+	fprintf(stderr, "LTP_REPRODUCIBLE_OUTPUT  Values 1 or y suppress printing TCONF, TINFO and TDEBUG messages and\n"
+			"                         discards the actual content of all other messages\n");
 	fprintf(stderr, "LTP_SINGLE_FS_TYPE       Specifies filesystem instead all supported (for .all_filesystems)\n");
 	fprintf(stderr, "LTP_FORCE_SINGLE_FS_TYPE Testing only. The same as LTP_SINGLE_FS_TYPE but ignores test skiplist.\n");
 	fprintf(stderr, "LTP_TIMEOUT_MUL          Timeout multiplier (must be a number >=1)\n");
@@ -1398,7 +1397,6 @@ static void do_setup(int argc, char *argv[])
 {
 	char *tdebug_env = getenv("LTP_DEBUG");
 	char *reproducible_env = getenv("LTP_REPRODUCIBLE_OUTPUT");
-	char *quiet_env = getenv("LTP_QUIET");
 
 	if (!tst_test)
 		tst_brk(TBROK, "No tests to run");
@@ -1429,10 +1427,6 @@ static void do_setup(int argc, char *argv[])
 	    (!strcmp(reproducible_env, "1") || !strcmp(reproducible_env, "y")))
 		reproducible_output = 1;
 
-	if (quiet_env &&
-	    (!strcmp(quiet_env, "1") || !strcmp(quiet_env, "y")))
-		quiet_output = 1;
-
 	assert_test_fn();
 
 	TCID = tcid = get_tcid(argv);
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
