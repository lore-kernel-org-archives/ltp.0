Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C92C9830E
	for <ltp@archiver.kernel.org>; Fri, 25 Sep 2026 08:29:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A1C23E615B
	for <ltp@archiver.kernel.org>; Fri, 25 Sep 2026 10:29:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4117C3E61C4
 for <ltp@lists.linux.it>; Fri, 25 Sep 2026 10:28:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3840614004EE
 for <ltp@lists.linux.it>; Fri, 25 Sep 2026 10:28:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6DBD71FCCF;
 Fri, 25 Sep 2026 08:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790324927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cT+u9Y3U1r7y7RSFArNo5BIvVXG5o3WivuGs9GmvGwY=;
 b=wKoHHV0QOwGqsVSjjZumvjaUIYq+4QE5VzoVSAmsIzOORVmuRspGOzMPw0NTenJab2Eq5K
 lotKV5CVvk6mblrzOgSaGiUur+CUsOz1fI2AYl3p8bceLLp4ofZQ/RouWyxnUrnaH+QW39
 IXv86JDgYYYTojkdoxCMikQ7o44H84Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790324927;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cT+u9Y3U1r7y7RSFArNo5BIvVXG5o3WivuGs9GmvGwY=;
 b=OaCXwY0JYCGXf7R0vTN4GDvE9MX+AKr5K7dJUbYtlqGkhus4/5RS2prM46ln1mFEamnUWV
 KR9VTCusFTJUbLCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790324923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cT+u9Y3U1r7y7RSFArNo5BIvVXG5o3WivuGs9GmvGwY=;
 b=Z9WTNLhisg6uSrphCypYH5HstdOjxdhzflB1huhVQZ20sxbnzxmU1Qx06gurQwMurQ35YV
 3xUwBZ54iPKXuuiKege1zc2Y0twjYFlKtloO7Abm+UI/s4BFyslH4c4Rrq5JgZUYqyl8qS
 hHkyvvWDioHBDKXhz/R1lGlV9M5n4L0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790324923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cT+u9Y3U1r7y7RSFArNo5BIvVXG5o3WivuGs9GmvGwY=;
 b=ic/Nq9vX+hhCu7SPU2/6beBQPIZORVcR4/LU/SyrrYGxJg3Kv4xQpbbjTSrB+vKy/rhpW5
 DmLV3qsxwH1MWYAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1522A1389C;
 Fri, 25 Sep 2026 08:28:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HWSGF7owtmohTwAAD6G6ig:T3
 (envelope-from <pvorel@suse.cz>); Fri, 25 Sep 2026 08:28:43 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 25 Sep 2026 10:28:40 +0200
Message-ID: <20260925082840.2408504-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925082840.2408504-1-pvorel@suse.cz>
References: <20260925082840.2408504-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] shmctl03: Use test macros
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

Use test macros to shorten the code.
Link manpage.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/shmctl/shmctl03.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/syscalls/shmctl/shmctl03.c b/testcases/kernel/syscalls/shmctl/shmctl03.c
index f2b735dc85..bccab5ba37 100644
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
@@ -18,18 +19,11 @@ static void verify_ipcinfo(void)
 	struct shminfo info;
 	unsigned long shmmax;
 
-	TEST(shmctl(0, IPC_INFO, (struct shmid_ds *)&info));
-
-	if (TST_RET < 0) {
-		tst_res(TFAIL | TTERRNO,
-			"shmctl(0, IPC_INFO, ...) returned %li", TST_RET);
+	TST_EXP_POSITIVE(shmctl(0, IPC_INFO, (struct shmid_ds *)&info));
+	if (!TST_PASS)
 		return;
-	}
 
-	if (info.shmmin != 1)
-		tst_res(TFAIL, "shmmin = %li, expected 1", info.shmmin);
-	else
-		tst_res(TPASS, "shmmin = 1");
+	TST_EXP_EQ_LU(info.shmmin, 1);
 
 	SAFE_FILE_SCANF(PATH_KERN_SHMMAX, "%lu", &shmmax);
 	if (tst_is_compat_mode() && info.shmmax == INT_MAX)
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
