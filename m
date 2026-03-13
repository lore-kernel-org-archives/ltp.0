Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED6B105F7A6
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 14:26:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC7453E52AF
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 15:26:41 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42FEE3E52A6
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 15:26:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C96C11001195
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 15:26:08 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B13DF4D291;
 Fri, 13 Mar 2026 14:26:07 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2605140584;
 Fri, 13 Mar 2026 14:26:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EErxBH8etGlfQQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 13 Mar 2026 14:26:07 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 13 Mar 2026 15:25:59 +0100
Message-ID: <20260313142600.243939-6-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313142600.243939-1-pvorel@suse.cz>
References: <20260313142600.243939-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: B13DF4D291
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 5/6] [WIP,RFC] tst_run.sh: Run setup() only once
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
Cc: Sebastian Chlad <sebastian.chlad@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Both C API and tst_test.sh shell API run test only once.
Fix shell loader API also to run setup only once.
This reuses functionality added in the previous commit.

Fixes: 8202494493 ("shell lib: Add basic support for test setup")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: this is still not working on iterations (-i2), because
static int iterations is from tst_test.c is not propagated to
tst_run_shell.c. I wonder if I should set the value as environment
variable or add it into struct context.

 testcases/lib/tst_run.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_run.sh b/testcases/lib/tst_run.sh
index e876fd8946..b78c7be03a 100644
--- a/testcases/lib/tst_run.sh
+++ b/testcases/lib/tst_run.sh
@@ -15,7 +15,7 @@ fi
 
 if [ -n "$TST_SETUP" ]; then
 	if command -v $TST_SETUP >/dev/null 2>/dev/null; then
-		$TST_SETUP
+		[ "$1" != 1 ] || $TST_SETUP
 	else
 		tst_brk TBROK "TST_SETUP=$TST_SETUP declared, but function not defined (or cmd not found)"
 	fi
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
