Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD45C105F7AE
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 14:26:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 672EA3E5798
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 15:26:57 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 378FE3E52AC
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 15:26:11 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 96EB960094C
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 15:26:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B0C8E5BCFF;
 Fri, 13 Mar 2026 14:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773411965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1qhP41Y2o6x7uDAcpqts/LywcFux00hnbdQNGachi+4=;
 b=LROw9A4tABfUSivB80YtCTXcNVyeI2yIwR44w7NS0+DXBln6tqDzPe5WnflC/AW820B2UW
 uuWmkUohC0zu0X9C4W75mgmtRhdbCNKaB+/KSXIhlA25vKjm2Pzn3dkmXU2z5XgpUg7Rkj
 QoWlZWuu9yBKo/N8xuvH80VkuZD4uXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773411965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1qhP41Y2o6x7uDAcpqts/LywcFux00hnbdQNGachi+4=;
 b=c78C5GWcl2xlYmgcR2Ce8tP/osRAednFo9Kzlh+WoOIelPRkZv/CXCKICu1/oo5FoERpTY
 8cSBwlxjBMYOqMCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773411965; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1qhP41Y2o6x7uDAcpqts/LywcFux00hnbdQNGachi+4=;
 b=LROw9A4tABfUSivB80YtCTXcNVyeI2yIwR44w7NS0+DXBln6tqDzPe5WnflC/AW820B2UW
 uuWmkUohC0zu0X9C4W75mgmtRhdbCNKaB+/KSXIhlA25vKjm2Pzn3dkmXU2z5XgpUg7Rkj
 QoWlZWuu9yBKo/N8xuvH80VkuZD4uXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773411965;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1qhP41Y2o6x7uDAcpqts/LywcFux00hnbdQNGachi+4=;
 b=c78C5GWcl2xlYmgcR2Ce8tP/osRAednFo9Kzlh+WoOIelPRkZv/CXCKICu1/oo5FoERpTY
 8cSBwlxjBMYOqMCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 587CC40586;
 Fri, 13 Mar 2026 14:26:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IJnAEn0etGlfQQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 13 Mar 2026 14:26:05 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 13 Mar 2026 15:25:55 +0100
Message-ID: <20260313142600.243939-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260313142600.243939-1-pvorel@suse.cz>
References: <20260313142600.243939-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/6] tst_run.sh: Fix passing arguments
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

tst_run_script() in C API correctly sets environment, but it have to be
also passed to the shell functions.

Before:

$ ./shell_loader_tcnt.sh
...
shell_loader_tcnt.sh:-1: TPASS: Iteration
shell_loader_tcnt.sh:-1: TPASS: Iteration

After:
shell_loader_tcnt.sh:-1: TPASS: Iteration 0
shell_loader_tcnt.sh:-1: TPASS: Iteration 1

Fixes: 8202494493 ("shell lib: Add basic support for test setup")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: not only for TST_CNT like variable, but also for other future
getopts support (needed by tst_net.sh tests).

 testcases/lib/tst_run.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_run.sh b/testcases/lib/tst_run.sh
index 841b5fd141..e876fd8946 100644
--- a/testcases/lib/tst_run.sh
+++ b/testcases/lib/tst_run.sh
@@ -1,7 +1,7 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2025 Cyril Hrubis <chrubis@suse.cz>
-# Copyright (c) 2025 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2025-2026 Petr Vorel <pvorel@suse.cz>
 
 . tst_env.sh
 
@@ -21,4 +21,4 @@ if [ -n "$TST_SETUP" ]; then
 	fi
 fi
 
-tst_test
+tst_test "$@"
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
