Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6BECF99351
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 08:43:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8659F3E5376
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 10:43:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D0653E1AA2
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:41:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1E99314004F2
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:41:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CFC686A83C;
 Thu, 23 Apr 2026 08:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776933695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U4bp4TDQgb751QUtIIAgKBpWnji37n+BeC73axwoTR0=;
 b=QTX2Ml11Rs4s2kpoaij2TM/hk6R5R5pX2fzg9ixtk0DqgJoY6dJrcUt5X1GBg/poMQPSdQ
 29yDqQktxmh8BG0oLali5J2jtsPZxVAFqlC7GezOh5XMxrT/HDnNTZqFUqTnEfl0MJHgVz
 7f6f832ZX8uIWQrX9oSkhSchDyUQbeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776933695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U4bp4TDQgb751QUtIIAgKBpWnji37n+BeC73axwoTR0=;
 b=4UEa6wvjQy06H8Z7S2pI8ErHvCTntQLcgsYMy2v6H+ZeEBvaX6jrdjGwHB6DnqhoLDXAIu
 m1WpBIdoT5lSgaAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QTX2Ml11;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4UEa6wvj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776933695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U4bp4TDQgb751QUtIIAgKBpWnji37n+BeC73axwoTR0=;
 b=QTX2Ml11Rs4s2kpoaij2TM/hk6R5R5pX2fzg9ixtk0DqgJoY6dJrcUt5X1GBg/poMQPSdQ
 29yDqQktxmh8BG0oLali5J2jtsPZxVAFqlC7GezOh5XMxrT/HDnNTZqFUqTnEfl0MJHgVz
 7f6f832ZX8uIWQrX9oSkhSchDyUQbeg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776933695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U4bp4TDQgb751QUtIIAgKBpWnji37n+BeC73axwoTR0=;
 b=4UEa6wvjQy06H8Z7S2pI8ErHvCTntQLcgsYMy2v6H+ZeEBvaX6jrdjGwHB6DnqhoLDXAIu
 m1WpBIdoT5lSgaAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9FCD0593A3;
 Thu, 23 Apr 2026 08:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QGh4JT/b6Wl6fgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 23 Apr 2026 08:41:35 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 23 Apr 2026 10:41:22 +0200
Message-ID: <20260423084123.657690-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423084123.657690-1-pvorel@suse.cz>
References: <20260423084123.657690-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,suse.com,redhat.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 R_RATELIMIT(0.00)[to_ip_from(RLmduujpsdff44oyku5bsyor5h)];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CFC686A83C
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 6/6] lib: Print TCONF on LTP_REPRODUCIBLE_OUTPUT=1
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

It'll be better for Valgrind developers to know, that test is skipped.
TCONF is not printed that often and because output of the message is
trimmed, it will not be that disruptive.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v5 (it can be squashed, but I wanted to point this out and get Martin's ack).

 doc/users/setup_tests.rst | 6 +++---
 lib/tst_test.c            | 4 +---
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
index 491a5b003a..43573c8fb1 100644
--- a/doc/users/setup_tests.rst
+++ b/doc/users/setup_tests.rst
@@ -43,9 +43,9 @@ users.
        Shell language: ``TST_NEEDS_DEVICE=1``.
 
    * - LTP_REPRODUCIBLE_OUTPUT
-     - When set to ``1`` or ``y`` uppress printing TCONF, TINFO and TDEBUG
-       messages and discards the actual content of the other messages printed
-       by the test (suitable for a reproducible output).
+     - When set to ``1`` or ``y`` uppress printing TINFO and TDEBUG messages
+       and discards the actual content of the other messages printed by the
+       test (suitable for a reproducible output).
 
    * - LTP_SINGLE_FS_TYPE
      - Specifies single filesystem to run the test on instead all supported
diff --git a/lib/tst_test.c b/lib/tst_test.c
index a0b55049ff..469a3f6b65 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -306,8 +306,6 @@ static void print_result(const char *file, const int lineno, int ttype,
 		res = "TBROK";
 	break;
 	case TCONF:
-		if (reproducible_output)
-			return;
 		res = "TCONF";
 	break;
 	case TWARN:
@@ -675,7 +673,7 @@ static void print_help(void)
 	fprintf(stderr, "LTP_DEV                  Path to the block device to be used (for .needs_device)\n");
 	fprintf(stderr, "LTP_DEV_FS_TYPE          Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
 	fprintf(stderr, "LTP_DEBUG                Print debug messages (set 1(y) or 2)\n");
-	fprintf(stderr, "LTP_REPRODUCIBLE_OUTPUT  Values 1 or y suppress printing TCONF, TINFO and TDEBUG messages and\n"
+	fprintf(stderr, "LTP_REPRODUCIBLE_OUTPUT  Values 1 or y suppress printing TINFO and TDEBUG messages and\n"
 			"                         discards the actual content of all other messages\n");
 	fprintf(stderr, "LTP_SINGLE_FS_TYPE       Specifies filesystem instead all supported (for .all_filesystems)\n");
 	fprintf(stderr, "LTP_FORCE_SINGLE_FS_TYPE Testing only. The same as LTP_SINGLE_FS_TYPE but ignores test skiplist.\n");
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
