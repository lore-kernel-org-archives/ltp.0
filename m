Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF2DC61DA4
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 08:38:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DE0D3CC258
	for <ltp@archiver.kernel.org>; Mon,  6 Feb 2023 09:38:22 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDC953C2461
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 09:38:12 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6D210600293
 for <ltp@lists.linux.it>; Mon,  6 Feb 2023 09:38:11 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 662C620B48;
 Mon,  6 Feb 2023 08:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675672691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3+S6EE19apyOr+fPZGBzRLZSUZfMX62Ehm6JwgACabU=;
 b=fMWLrnoPe0GOGvivwJX5FVB+VWS6D1K53Oo2U11v1RZUViE0wZBeNeAf9BsAQ+HnsmXZ8t
 FL5Kr2vGJMjIja+id9kw9f/m17BNwxA51aG8gZYDSjF55xT61oRc3RR7wCb4vceiXvDTTH
 FVMYIlyIcTM5y3ZL5GQaimnpmTjD5jE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675672691;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=3+S6EE19apyOr+fPZGBzRLZSUZfMX62Ehm6JwgACabU=;
 b=bLB5p5ji7b1GgETHMlXczEp/Y/TYaxkLYtKLuB6cmD1aBb6Ay5TIwCootUAdKw6StXMGDB
 8YnDcS4zlih8/yDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 362BB138E8;
 Mon,  6 Feb 2023 08:38:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SJPJC3O84GNJHwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 06 Feb 2023 08:38:11 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  6 Feb 2023 09:38:07 +0100
Message-Id: <20230206083807.22740-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] adjtimex02: Remove tests for AJD_OFFSET
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

These tests were for 2.6.26. There is no point to just print:
TCONF: Newer kernels normalize offset value outside range

Also update docs.

NOTE: there was typo AJD_OFFSET in docs (from a46faf2999).

Fixes: 418585c75f ("Remove old kernel version check in C case when using tst_kvercmp")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Or, should we test that kernel normalize offset value outside range?
This should be probably added into new file adjtimex04.c, or at least to
other existing file, because this is test for expected errnos.

Kind regards,
Petr

 testcases/kernel/syscalls/adjtimex/adjtimex02.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/testcases/kernel/syscalls/adjtimex/adjtimex02.c b/testcases/kernel/syscalls/adjtimex/adjtimex02.c
index dab640ff36..e66ba2a5c7 100644
--- a/testcases/kernel/syscalls/adjtimex/adjtimex02.c
+++ b/testcases/kernel/syscalls/adjtimex/adjtimex02.c
@@ -14,11 +14,6 @@
  * - EFAULT with SET_MODE and invalid timex pointer
  * - EINVAL with ADJ_TICK greater than max tick
  * - EINVAL with ADJ_TICK smaller than min tick
- *
- * On kernels older than 2.6.26:
- *
- * - EINVAL with AJD_OFFSET smaller than min offset
- * - EINVAL with AJD_OFFSET greater than max offset
  */
 
 #include <errno.h>
@@ -57,8 +52,6 @@ static struct test_case {
 	{.modes = SET_MODE, .exp_err = EFAULT},
 	{.modes = ADJ_TICK, .lowlimit = 900000, .delta = 1, .exp_err = EINVAL},
 	{.modes = ADJ_TICK, .highlimit = 1100000, .delta = 1, .exp_err = EINVAL},
-	{.modes = ADJ_OFFSET, .highlimit = 512000L, .delta = 1, .exp_err = EINVAL},
-	{.modes = ADJ_OFFSET, .lowlimit = -512000L, .delta = -1, .exp_err = EINVAL},
 };
 
 static struct test_variants
@@ -93,12 +86,6 @@ static void verify_adjtimex(unsigned int i)
 			if (tc[i].highlimit)
 				buf->tick = tc[i].highlimit + tc[i].delta;
 		}
-		if (tc[i].modes == ADJ_OFFSET) {
-			if (tc[i].lowlimit || tc[i].highlimit) {
-				tst_res(TCONF, "Newer kernels normalize offset value outside range");
-				return;
-			}
-		}
 	}
 
 	if (tc[i].exp_err == EFAULT) {
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
