Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC79C9831C
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 11:25:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6BB923E6570
	for <ltp@archiver.kernel.org>; Thu, 24 Sep 2026 13:25:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 848173CD88C
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 13:25:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1A77210000CD
 for <ltp@lists.linux.it>; Thu, 24 Sep 2026 13:25:21 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2B65F21F18;
 Thu, 24 Sep 2026 11:25:17 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790249117; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RkQd5c0FceVhDrzmfBHI/7hlxgxyPQaK7BaXnjm8vT0=;
 b=Di735c+9Ip7sLYgAbieaXCakHde+RQ3IZXfvll+JgBmYkdGVEIw8LrZpvLgVCIBHELtbK0
 boEv0rRqonGkPCLZJAVdZa1lvloigviwWHuZFx1URY/eECetcue+eAoMBhQ52jh8q1pTLd
 OZm2mlvkuRgJMiYmI36Qrbe6vFhOzH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790249117;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RkQd5c0FceVhDrzmfBHI/7hlxgxyPQaK7BaXnjm8vT0=;
 b=xTXhILVBMgXRb6xqOUYT3ZxUTNv5Z9P2s6GhJBF1YPS6ErGMX8xmHPgEg+nhReuh7Bhc6K
 OcbboATIaI/OUnCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB568136ED;
 Thu, 24 Sep 2026 11:25:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id y/X9L5sItWoLIQAAD6G6ig:T3
 (envelope-from <pvorel@suse.cz>); Thu, 24 Sep 2026 11:25:16 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 24 Sep 2026 13:25:13 +0200
Message-ID: <20260924112514.2375626-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924112514.2375626-1-pvorel@suse.cz>
References: <20260924112514.2375626-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2B65F21F18
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/3] shmctl03: Fix shmmax clamped to INT_MAX in
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

Kernel clamped /proc/sys/kernel/shmmax in 32bit compat mode
to INT_MAX due change in kernel v2.6.22 in commit
af7c693f14606 ("Cap shmmax at INT_MAX in compat shminfo").
Reflect that.

Reported-by: Wei Gao <wegao@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
[ pvorel: check PATH_KERN_SHMMAX >= INT_MAX, separate into its own
commit, write the commit message ]
Co-developed-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/shmctl/shmctl03.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/shmctl/shmctl03.c b/testcases/kernel/syscalls/shmctl/shmctl03.c
index 9e1c2f0990..0a4e27ce98 100644
--- a/testcases/kernel/syscalls/shmctl/shmctl03.c
+++ b/testcases/kernel/syscalls/shmctl/shmctl03.c
@@ -30,7 +30,14 @@ static void verify_ipcinfo(void)
 	else
 		tst_res(TPASS, "shmmin = 1");
 
-	TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
+	if (tst_is_compat_mode() && info.shmmax == INT_MAX) {
+		unsigned long long shmmax;
+		SAFE_FILE_SCANF(PATH_KERN_SHMMAX, "%llu", &shmmax);
+		TST_EXP_LE_LU(INT_MAX, shmmax);
+	} else {
+		TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
+	}
+
 	TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni);
 	TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall);
 }
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
