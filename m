Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5B76F99351
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 08:42:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C35633E1B4F
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 10:42:31 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE37D3E5378
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:41:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 664512009E1
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:41:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D5EA35BD62;
 Thu, 23 Apr 2026 08:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776933694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bNjw4sBufMBg598T/qzoANemJq101BaMJwzT18Nt3pM=;
 b=YWQ/O8b9gwKNoLjDUtkgVyP0Hx+0mnJEEsofRd5JS68QyMfwu0Hf1r0jIxw7TbPoWOXuUL
 b6RtJzjSHy/s0rDPURq3sxeny4HI4Tbtx1v7/B1SFyAPdiWBTNLICDG8WOt6BAINlM4nlZ
 XcjAyMh/jf5zPbdLj2KTgIqLQvXPr2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776933694;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bNjw4sBufMBg598T/qzoANemJq101BaMJwzT18Nt3pM=;
 b=EfYzKpE7MTMmzCbwdcJSAlWwvqNl9wEKKKU/ziy0pnDUadk6mzPatOzbC9Zlq4D2w2Vq7W
 xg9PUJY4AkrG9UDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="YWQ/O8b9";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EfYzKpE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776933694; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bNjw4sBufMBg598T/qzoANemJq101BaMJwzT18Nt3pM=;
 b=YWQ/O8b9gwKNoLjDUtkgVyP0Hx+0mnJEEsofRd5JS68QyMfwu0Hf1r0jIxw7TbPoWOXuUL
 b6RtJzjSHy/s0rDPURq3sxeny4HI4Tbtx1v7/B1SFyAPdiWBTNLICDG8WOt6BAINlM4nlZ
 XcjAyMh/jf5zPbdLj2KTgIqLQvXPr2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776933694;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bNjw4sBufMBg598T/qzoANemJq101BaMJwzT18Nt3pM=;
 b=EfYzKpE7MTMmzCbwdcJSAlWwvqNl9wEKKKU/ziy0pnDUadk6mzPatOzbC9Zlq4D2w2Vq7W
 xg9PUJY4AkrG9UDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DCAE593B1;
 Thu, 23 Apr 2026 08:41:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cM3yHz7b6Wl6fgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 23 Apr 2026 08:41:34 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 23 Apr 2026 10:41:18 +0200
Message-ID: <20260423084123.657690-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423084123.657690-1-pvorel@suse.cz>
References: <20260423084123.657690-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,suse.com,redhat.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[7]; TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Queue-Id: D5EA35BD62
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/6] lib: Rename variable LTP_ENABLE_DEBUG =>
 LTP_DEBUG
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

1) LTP_DEBUG is shorter to write.
2) Enable is usually meant as boolean (on/off), that hides possible 2
value even more.

Reviewed-by: Li Wang <liwang@redhat.com>
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/developers/debugging.rst     | 2 +-
 doc/old/C-Test-API.asciidoc      | 2 +-
 doc/users/setup_tests.rst        | 2 +-
 lib/newlib_tests/tst_res_flags.c | 2 +-
 lib/tst_test.c                   | 6 +++---
 5 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/doc/developers/debugging.rst b/doc/developers/debugging.rst
index 52f881c5c8..36dda0d90f 100644
--- a/doc/developers/debugging.rst
+++ b/doc/developers/debugging.rst
@@ -9,7 +9,7 @@ Debug messages
 --------------
 
 The LTP framework supports ``TDEBUG`` flag test debug messages. These
-messages can be enabled using the ``-D[1,2]`` parameter or setting ``LTP_ENABLE_DEBUG=1,2``
+messages can be enabled using the ``-D[1,2]`` parameter or setting ``LTP_DEBUG=1,2``
 environment variable (see :doc:`../users/setup_tests`).
 
 The ``-D`` parameter also supports the following verbosity levels:
diff --git a/doc/old/C-Test-API.asciidoc b/doc/old/C-Test-API.asciidoc
index 44cc4e863b..7c5ad923dd 100644
--- a/doc/old/C-Test-API.asciidoc
+++ b/doc/old/C-Test-API.asciidoc
@@ -232,7 +232,7 @@ Printf-like function to report test result, it's mostly used with ttype:
 | 'TPASS'  | Test has passed.
 | 'TFAIL'  | Test has failed.
 | 'TINFO'  | General message.
-| 'TDEBUG' | Debug message (new C API only, printed with '-D' or via 'LTP_ENABLE_DEBUG=1' or 'y'
+| 'TDEBUG' | Debug message (new C API only, printed with '-D' or via 'LTP_DEBUG=1' or 'y'
              environment variable), only for messages which would be too verbose for normal run.
 | 'TWARN'  | Something went wrong but we decided to continue. Mostly used in cleanup functions.
 |==============================
diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
index 95d4d9e380..a42c397feb 100644
--- a/doc/users/setup_tests.rst
+++ b/doc/users/setup_tests.rst
@@ -90,7 +90,7 @@ users.
      - Disable running test cleanup (defined in ``TST_CLEANUP``).
        Shell API only.
 
-   * - LTP_ENABLE_DEBUG
+   * - LTP_DEBUG
      - Enable debug info (value ``1`` (``y``) or ``2`` for more verbose level).
        Equivalent of ``-D`` parameter.
 
diff --git a/lib/newlib_tests/tst_res_flags.c b/lib/newlib_tests/tst_res_flags.c
index 21637a472b..9993d0f87d 100644
--- a/lib/newlib_tests/tst_res_flags.c
+++ b/lib/newlib_tests/tst_res_flags.c
@@ -21,7 +21,7 @@ static struct tcase {
 	{FLAG(TCONF)},
 	{FLAG(TWARN)},
 	{FLAG(TINFO)},
-	{FLAG(TDEBUG), " (printed only with -D[1,2] or LTP_ENABLE_DEBUG=1,2)"},
+	{FLAG(TDEBUG), " (printed only with -D[1,2] or LTP_DEBUG=1,2)"},
 };
 
 static void do_cleanup(void)
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 229da669fa..c79cabcd7a 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -675,7 +675,7 @@ static void print_help(void)
 	fprintf(stderr, "LTP_COLORIZE_OUTPUT      Force colorized output behaviour (y/1 always, n/0: never)\n");
 	fprintf(stderr, "LTP_DEV                  Path to the block device to be used (for .needs_device)\n");
 	fprintf(stderr, "LTP_DEV_FS_TYPE          Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
-	fprintf(stderr, "LTP_ENABLE_DEBUG         Print debug messages (set 1(y) or 2)\n");
+	fprintf(stderr, "LTP_DEBUG                Print debug messages (set 1(y) or 2)\n");
 	fprintf(stderr, "LTP_REPRODUCIBLE_OUTPUT  Values 1 or y discard the actual content of the messages printed by the test\n");
 	fprintf(stderr, "LTP_QUIET                Values 1 or y will suppress printing TCONF, TWARN, TINFO, and TDEBUG messages\n");
 	fprintf(stderr, "LTP_SINGLE_FS_TYPE       Specifies filesystem instead all supported (for .all_filesystems)\n");
@@ -1400,7 +1400,7 @@ bool tst_cmd_present(const char *cmd)
 
 static void do_setup(int argc, char *argv[])
 {
-	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");
+	char *tdebug_env = getenv("LTP_DEBUG");
 	char *reproducible_env = getenv("LTP_REPRODUCIBLE_OUTPUT");
 	char *quiet_env = getenv("LTP_QUIET");
 
@@ -1451,7 +1451,7 @@ static void do_setup(int argc, char *argv[])
 		else if (!strcmp(tdebug_env, "1") || !strcmp(tdebug_env, "y"))
 			context->tdebug = 1;
 		else
-			tst_res(TWARN, "Invalid LTP_ENABLE_DEBUG value: '%s'", tdebug_env);
+			tst_res(TWARN, "Invalid LTP_DEBUG value: '%s'", tdebug_env);
 
 		if (context->tdebug)
 			tst_res(TINFO, "Enabling debug info (level %d)", context->tdebug);
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
