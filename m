Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36149C9830E
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 11:26:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 869EC3E658D
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 13:26:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CFCC83E6569
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 13:25:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5C48060048E
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 13:25:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9A0C0200BD;
 Thu, 24 Sep 2026 11:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790249121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b/hu0kKdh3/8A/IjAsBf5blU5NzDmARZsXMjnRNkOWM=;
 b=yxvkYofSN5gEqRtNEUjZqU4Gxb8aqBzXbBMyAzkiYRDYQN7DnU4Fy2GYp+34tIGsBg+M/M
 rrGYBCbr0vmvC+Yv6Nk4o6/a4fQzXqIfp2qd5DQF2e01zA6NKUcxlBh7u0fVOOFYJsh2bW
 Fy1KUVQlSa89SO6oPCaud00h3Sa3Asc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790249121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b/hu0kKdh3/8A/IjAsBf5blU5NzDmARZsXMjnRNkOWM=;
 b=UnM4Ndl4j6DlgmL0lq+qsJoLSc9GF8r+rcE4cE1OAm71CzS4C0nkg3EsdCHX4kSNBNIWyn
 7EjBJbC4RqweRRBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790249117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b/hu0kKdh3/8A/IjAsBf5blU5NzDmARZsXMjnRNkOWM=;
 b=eTxq20i9ZB/hRNpql9OCzNjgv/rkXYO9d0BmEb8FpdAM6nApU42X+q0UNU5yKdv7pUNy6g
 ssxAArjHIhQvTgxUOBt0KEpdaxyJBilsBHxEc5KTAlnPTcHDKIscvXDdF0c9xgWo84aciR
 UZbqPGPLbQS/bCvzA/NIP/nml2YO0ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790249117;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b/hu0kKdh3/8A/IjAsBf5blU5NzDmARZsXMjnRNkOWM=;
 b=th7WsafERUvzVcbozkB+Zuc1CJ8elhXIc6tpLaMpqU23fHiMvuC1DmVc0UTBMH+mtqZfop
 xLFliqOAfkQEBACw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FC3C13929;
 Thu, 24 Sep 2026 11:25:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id y/X9L5sItWoLIQAAD6G6ig:T4
 (envelope-from <pvorel@suse.cz>); Thu, 24 Sep 2026 11:25:17 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 24 Sep 2026 13:25:14 +0200
Message-ID: <20260924112514.2375626-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924112514.2375626-1-pvorel@suse.cz>
References: <20260924112514.2375626-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] shmctl03: Use safe_shmctl(), TST_EXP_LE_LU()
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

Shorten code with safe function and test macro.
Link manpage.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: it can be postponed after the release.

 testcases/kernel/syscalls/shmctl/shmctl03.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/shmctl/shmctl03.c b/testcases/kernel/syscalls/shmctl/shmctl03.c
index 0a4e27ce98..46ab989b10 100644
--- a/testcases/kernel/syscalls/shmctl/shmctl03.c
+++ b/testcases/kernel/syscalls/shmctl/shmctl03.c
@@ -1,11 +1,12 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2020 Cyril Hrubis <chrubis@suse.cz>
+ * Copyright (c) Linux Test Project, 2026
  */
 
 /*\
- * Call shmctl() with IPC_INFO flag and check that the data are consistent with
- * /proc/sys/kernel/shm*.
+ * Call :manpage:`shmctl(2)` with IPC_INFO flag and check that the data are
+ * consistent with /proc/sys/kernel/shm*.
  */
 
 #define _GNU_SOURCE
@@ -17,18 +18,8 @@ static void verify_ipcinfo(void)
 {
 	struct shminfo info;
 
-	TEST(shmctl(0, IPC_INFO, (struct shmid_ds *)&info));
-
-	if (TST_RET < 0) {
-		tst_res(TFAIL | TTERRNO,
-			"shmctl(0, IPC_INFO, ...) returned %li", TST_RET);
-		return;
-	}
-
-	if (info.shmmin != 1)
-		tst_res(TFAIL, "shmmin = %li, expected 1", info.shmmin);
-	else
-		tst_res(TPASS, "shmmin = 1");
+	safe_shmctl(__FILE__, __LINE__, 0, IPC_INFO, ((struct shmid_ds *)&info));
+	TST_EXP_LE_LU(info.shmmin, 1);
 
 	if (tst_is_compat_mode() && info.shmmax == INT_MAX) {
 		unsigned long long shmmax;
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
