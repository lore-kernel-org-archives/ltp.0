Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94349F99351
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 08:43:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4269B3E2D7A
	for <ltp@archiver.kernel.org>; Thu, 23 Apr 2026 10:43:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C57913E5376
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:41:45 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B1A54600958
 for <ltp@lists.linux.it>; Thu, 23 Apr 2026 10:41:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 59BB15BD7F;
 Thu, 23 Apr 2026 08:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776933695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vVFaAOtXw1M/P29c1VpezOR5DSTvLL+6Yi0g/yrp8Ok=;
 b=UbzzO80HW+1UTigDDLMgy2E80VQLIT2jtsa7P9sFHFlQQY2XQMcvVwZy9+Y4ulbv8CfgAq
 nkPPOXJ9SmQbB21aktI52n6+KwTRVZqVZqx199gk9vmg0lm5wyDbPGUkd7GG7p1+GQjYa3
 0SljaKQaf1wd5Dqmb/5hzKgg1vsO97g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776933695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vVFaAOtXw1M/P29c1VpezOR5DSTvLL+6Yi0g/yrp8Ok=;
 b=458teu6O0ZK4O9abSoPy8zZrBkOQ7LQQod9tgwBDx+PY54HiFO6geRgMpHUOOzHgDp/XLy
 hOJZhn+WMafd9rAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UbzzO80H;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=458teu6O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776933695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vVFaAOtXw1M/P29c1VpezOR5DSTvLL+6Yi0g/yrp8Ok=;
 b=UbzzO80HW+1UTigDDLMgy2E80VQLIT2jtsa7P9sFHFlQQY2XQMcvVwZy9+Y4ulbv8CfgAq
 nkPPOXJ9SmQbB21aktI52n6+KwTRVZqVZqx199gk9vmg0lm5wyDbPGUkd7GG7p1+GQjYa3
 0SljaKQaf1wd5Dqmb/5hzKgg1vsO97g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776933695;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vVFaAOtXw1M/P29c1VpezOR5DSTvLL+6Yi0g/yrp8Ok=;
 b=458teu6O0ZK4O9abSoPy8zZrBkOQ7LQQod9tgwBDx+PY54HiFO6geRgMpHUOOzHgDp/XLy
 hOJZhn+WMafd9rAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 29CEA593B1;
 Thu, 23 Apr 2026 08:41:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qIavCD/b6Wl6fgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 23 Apr 2026 08:41:35 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 23 Apr 2026 10:41:20 +0200
Message-ID: <20260423084123.657690-5-pvorel@suse.cz>
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
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+];
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,suse.com,redhat.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Queue-Id: 59BB15BD7F
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 4/6] doc: newlib_tests: Update debugging parameters
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

* Improve wording in doc/developers/debugging.rst. Not mention 'y'
  (enough for user is to know 1 and 2 + 'y' is mentioned at -h).
* Mention all -D and LTP_DEBUG parameters in library test.
* Keep info about the levels in developers/debugging.rst, link page in
  user/setup_tests.
* Remove values from old doc (we have enough places to sync on changes,
  let's drop the old doc).

Follow-up: b415265cb3 ("doc/setup_tests: Document LTP_ENABLE_DEBUG=2")
Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
Reviewed-by: Li Wang <wangli.ahau@gmail.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/developers/debugging.rst     | 4 ++--
 doc/old/C-Test-API.asciidoc      | 4 ++--
 doc/users/setup_tests.rst        | 2 +-
 lib/newlib_tests/tst_res_flags.c | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/doc/developers/debugging.rst b/doc/developers/debugging.rst
index 4e162068b4..6062fdece0 100644
--- a/doc/developers/debugging.rst
+++ b/doc/developers/debugging.rst
@@ -9,10 +9,10 @@ Debug messages
 --------------
 
 The LTP framework supports ``TDEBUG`` flag test debug messages. These
-messages can be enabled using the ``-D[1,2]`` parameter or setting ``LTP_DEBUG=1,2``
+messages can be enabled using the ``-D`` parameter or setting ``LTP_DEBUG``
 environment variable (see :doc:`../users/setup_tests`).
 
-The ``-D`` parameter also supports the following verbosity levels:
+Both ``-D`` parameter and ``LTP_DEBUG`` support the following verbosity levels:
 
   ``-D1`` (or ``-D``): Enable debug logs for the test process only.
   ``-D2``: Enable verbose debug logs for both the test and library processes.
diff --git a/doc/old/C-Test-API.asciidoc b/doc/old/C-Test-API.asciidoc
index 7c5ad923dd..38dae98663 100644
--- a/doc/old/C-Test-API.asciidoc
+++ b/doc/old/C-Test-API.asciidoc
@@ -232,8 +232,8 @@ Printf-like function to report test result, it's mostly used with ttype:
 | 'TPASS'  | Test has passed.
 | 'TFAIL'  | Test has failed.
 | 'TINFO'  | General message.
-| 'TDEBUG' | Debug message (new C API only, printed with '-D' or via 'LTP_DEBUG=1' or 'y'
-             environment variable), only for messages which would be too verbose for normal run.
+| 'TDEBUG' | Debug message (new C API only, enabled via '-D' or 'LTP_DEBUG' environment variable)
+             only for messages which would be too verbose for normal run.
 | 'TWARN'  | Something went wrong but we decided to continue. Mostly used in cleanup functions.
 |==============================
 
diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
index a42c397feb..6f1d996e18 100644
--- a/doc/users/setup_tests.rst
+++ b/doc/users/setup_tests.rst
@@ -92,7 +92,7 @@ users.
 
    * - LTP_DEBUG
      - Enable debug info (value ``1`` (``y``) or ``2`` for more verbose level).
-       Equivalent of ``-D`` parameter.
+       Equivalent of the ``-D`` parameter (see :doc:`../developers/debugging`).
 
 Test specific environment variables
 -----------------------------------
diff --git a/lib/newlib_tests/tst_res_flags.c b/lib/newlib_tests/tst_res_flags.c
index 9993d0f87d..cda0970702 100644
--- a/lib/newlib_tests/tst_res_flags.c
+++ b/lib/newlib_tests/tst_res_flags.c
@@ -21,7 +21,7 @@ static struct tcase {
 	{FLAG(TCONF)},
 	{FLAG(TWARN)},
 	{FLAG(TINFO)},
-	{FLAG(TDEBUG), " (printed only with -D[1,2] or LTP_DEBUG=1,2)"},
+	{FLAG(TDEBUG), " (printed only with -D[1,2] or LTP_DEBUG=1(y),2)"},
 };
 
 static void do_cleanup(void)
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
