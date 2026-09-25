Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B24C8C9830D
	for <ltp@archiver.kernel.org>; Fri, 25 Sep 2026 08:29:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7D7F03E61CA
	for <ltp@archiver.kernel.org>; Fri, 25 Sep 2026 10:29:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8982A3E5BCC
 for <ltp@lists.linux.it>; Fri, 25 Sep 2026 10:28:49 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E37111A01140
 for <ltp@lists.linux.it>; Fri, 25 Sep 2026 10:28:47 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2A0A221998;
 Fri, 25 Sep 2026 08:28:43 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790324923; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cb7PWMKvKtNIHz98xLCrs/yhorjQsH5Ay8ednI759qs=;
 b=s5gw7kiJNE9VCqxSqk2XGNXewE1n0rdp44PojZHFxzsxcWfAP5Ni0UuSiy9zjw47KXUQ3L
 WusyPAGnQEl6uL0OrLOcln7MvBpqHy9+Xorbbr4xBuMYoDmxJIRunb442yKQWGum9vDgb0
 K4c+PmWu5M3Tr7cM604108CMOzHqvIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790324923;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cb7PWMKvKtNIHz98xLCrs/yhorjQsH5Ay8ednI759qs=;
 b=ASUD3OqALth/IiJ9qryv9cmuieZlIczLNKFV8ZCkBktw1ekP+V1k8f8WsmTfS+8aBfk8xK
 EgLjlkXajU7rrrDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5482136F7;
 Fri, 25 Sep 2026 08:28:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HWSGF7owtmohTwAAD6G6ig:T2
 (envelope-from <pvorel@suse.cz>); Fri, 25 Sep 2026 08:28:42 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 25 Sep 2026 10:28:39 +0200
Message-ID: <20260925082840.2408504-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260925082840.2408504-1-pvorel@suse.cz>
References: <20260925082840.2408504-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 2A0A221998
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] shmctl03: Fix shmmax clamped to INT_MAX in
 32bit compat mode
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

Kernel clamped shmmax returned from shmctl(IPC_INFO) in 32bit compat
mode to INT_MAX due to a change in kernel v2.6.22 in commit
af7c693f14606 ("Cap shmmax at INT_MAX in compat shminfo").
Reflect that.

This fixes error:

    shmctl03.c:33: TFAIL: /proc/sys/kernel/shmmax != 2147483647 got 4294967295

Reported-by: Wei Gao <wegao@suse.com>
Suggested-by: Andrea Cervesato <andrea.cervesato@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/shmctl/shmctl03.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/shmctl/shmctl03.c b/testcases/kernel/syscalls/shmctl/shmctl03.c
index 9e1c2f0990..f2b735dc85 100644
--- a/testcases/kernel/syscalls/shmctl/shmctl03.c
+++ b/testcases/kernel/syscalls/shmctl/shmctl03.c
@@ -16,6 +16,7 @@
 static void verify_ipcinfo(void)
 {
 	struct shminfo info;
+	unsigned long shmmax;
 
 	TEST(shmctl(0, IPC_INFO, (struct shmid_ds *)&info));
 
@@ -30,7 +31,12 @@ static void verify_ipcinfo(void)
 	else
 		tst_res(TPASS, "shmmin = 1");
 
-	TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
+	SAFE_FILE_SCANF(PATH_KERN_SHMMAX, "%lu", &shmmax);
+	if (tst_is_compat_mode() && info.shmmax == INT_MAX)
+		TST_EXP_LE_LU(INT_MAX, shmmax);
+	else
+		TST_EXP_EQ_LU(info.shmmax, shmmax);
+
 	TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni);
 	TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall);
 }
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
