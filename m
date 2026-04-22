Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C2EF9EDD9
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 14:14:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A4D43E5817
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 16:14:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07CF83E6FD8
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 16:12:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 873CB1000900
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 16:12:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 01D8D5BD5E;
 Wed, 22 Apr 2026 14:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776867162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lw5+co6sZDOxBStV/jjvbKes6LoTuh2CKC3sao1nqDc=;
 b=WDmes9nyAMfAVb6UDNOQ5FvHvrLjFtJ0i6WgVa2zD0DZxzwnReRchMs17nYIUhMXRX3TD/
 6oSKt/zLStkh4ViCVjNpNKlpmrQNZMlxqfsyW41oMACQ2U2x0v2C41sUgyb6rmsmwqeGwm
 Aco3JaAwHo4CjSmBcSZEoN7uj0l8d8A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776867162;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lw5+co6sZDOxBStV/jjvbKes6LoTuh2CKC3sao1nqDc=;
 b=02+8QdyqCtlPaOhEQhkqAchSNQeNfa6uCAE296LqcN//Ld0WM+cZvMdRucmBFrufwY8fps
 YsmKlEU/ZUu0YMCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ONJoUWgP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CXLk9Q3Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776867161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lw5+co6sZDOxBStV/jjvbKes6LoTuh2CKC3sao1nqDc=;
 b=ONJoUWgP2khwoPSwk6iAQLCmyrr5FC/OfPiU8bkff+rmGSaPkF9+ak1CZ/yxHUImB762AL
 KOQyJBNohtMp3W5/GE1sD1RZGmkCWtDnFhaRM/hVWcnTQ0tYNu0cYnVj/tTtTXJnu287z/
 IxbwMVYSJRaZM4zvNTzrMIME4TR2EEg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776867161;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Lw5+co6sZDOxBStV/jjvbKes6LoTuh2CKC3sao1nqDc=;
 b=CXLk9Q3YL4mIwJbs9vklhKiQifNlzWFQxqe4qbQA2KFKLly3Inocxm1C3Ii38fb7n6DDBL
 9qdctRtVl+/XlOBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7DDDF593AF;
 Wed, 22 Apr 2026 14:12:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oPt+HFjX6GnqUwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 22 Apr 2026 14:12:40 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 22 Apr 2026 16:12:34 +0200
Message-ID: <20260422141234.632195-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422141234.632195-1-pvorel@suse.cz>
References: <20260422141234.632195-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,suse.com,redhat.com];
 RCVD_TLS_ALL(0.00)[];
 MAILSPIKE_FAIL(0.00)[2a07:de40:b281:104:10:150:64:97:query timed out];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
 TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 01D8D5BD5E
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 5/5] lib: Merge functionality of LTP_QUIET into
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

Later LTP_QUIET=1 was added which suppresses printing TCONF, TWARN,
TINFO, and TDEBUG messages.

Valgrind project uses both variables but no need to handle them
separately. Therefore merge functionality of LTP_QUIET into
LTP_REPRODUCIBLE_OUTPUT.

LTP_QUIET was not even documented in HTML doc (no need to update docs).

Implements: https://github.com/linux-test-project/ltp/issues/1306
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v4.

 lib/tst_test.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/lib/tst_test.c b/lib/tst_test.c
index 12f7489d4e..51d64e8414 100644
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
+	fprintf(stderr, "LTP_REPRODUCIBLE_OUTPUT  Values 1 or y suppress printing TCONF, TWARN, TINFO, and TDEBUG messages and");
+	fprintf(stderr, "                         discards the actual content of all other messages");
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
