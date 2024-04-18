Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F8CC4345F
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 14:13:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 090D23CFC3B
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 16:13:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CA383CFC16
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 16:13:24 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3B2471007CB5
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 16:13:22 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D3DE93501C;
 Thu, 18 Apr 2024 14:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713449601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vkT3wBDCnQxj8kwQeI67l4hG6yFhuoLiMBldmXiDg3Y=;
 b=DHegNFX2vH6dYtHQW0N2hUSDz+CqqIFw3ADCcyo0ySQsnLDJfuowW9YWoead1BIO5PFTeQ
 GPHnQqhQHtPXH9JJ8U1QiigyIqLj1WzRsXKMGpCEwX/ZOvjb2n598NSxR/eAQMQED/rph8
 dIrv7Mcc1YYoGg5Cb6hOBYvYtsvtk6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713449601;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vkT3wBDCnQxj8kwQeI67l4hG6yFhuoLiMBldmXiDg3Y=;
 b=j/nkSMYJKQU4htt87haDUGK58rI47m70nJSGRPZAYAZl+/BxYa2oKNLySZzZb6IbmNx0ZV
 ApjgDWT8daljuRAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=FiBgiqrY;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1ymSvgKh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713449599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vkT3wBDCnQxj8kwQeI67l4hG6yFhuoLiMBldmXiDg3Y=;
 b=FiBgiqrYdll44Hn8I4WYx1F2xrKBHRIn61KB20HaXEKMmCD+PIk1M7/s1/RpwzBLKqlBH6
 Ff4GJ64GJVb8gx+AQ1WOUdCawbCtOticu7Foy3IyUD4idG25VxhKX7fWsbLC6iDWQkBhqO
 M7lOTRr96FG8OlZBjFu9iH6Th0PqPLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713449599;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vkT3wBDCnQxj8kwQeI67l4hG6yFhuoLiMBldmXiDg3Y=;
 b=1ymSvgKh5uWpHP0jjUgfSrTCOG8K6IagGua1U912Jrq9Qb09eSboE914smRUK3+czQqQdp
 7EfutsuU0YOaBRBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A691C13894;
 Thu, 18 Apr 2024 14:13:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WNKtJ38qIWbOHwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 18 Apr 2024 14:13:19 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 18 Apr 2024 16:13:10 +0200
Message-ID: <20240418141312.99794-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240418141312.99794-1-pvorel@suse.cz>
References: <20240418141312.99794-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D3DE93501C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] swapoff0[12]: Remove unneeded tst_brk()
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

SAFE_MAKE_SWAPFILE_BLKS() calls make_swapfile() with safe parameter == 1,
therefore passes TST_CMD_PASS_RETVAL | TST_CMD_TCONF_ON_MISSING to
tst_cmd() and following functions, which leads to quit testing due
tst_brkm(TCONF, ...).

This is a left over from transition from tst_fill_file() which does not
have safe parameter to make_swapfile() in 6249e87b5 (swapoff01.c) and
009a407a0 (swapoff02.c).

Fixes: 6249e87b5 ("libswap: customize swapfile size")
Fixes: 009a407a0 ("swapon/off: enable all_filesystem in swap test")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/swapoff/swapoff01.c | 4 +---
 testcases/kernel/syscalls/swapoff/swapoff02.c | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/swapoff/swapoff01.c b/testcases/kernel/syscalls/swapoff/swapoff01.c
index cf13907e7..314630267 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff01.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff01.c
@@ -43,9 +43,7 @@ static void verify_swapoff(void)
 static void setup(void)
 {
 	is_swap_supported(TEST_FILE);
-
-	if (SAFE_MAKE_SWAPFILE_BLKS(SWAP_FILE, 65536))
-		tst_brk(TBROK, "Failed to create file for swap");
+	SAFE_MAKE_SWAPFILE_BLKS(SWAP_FILE, 65536);
 }
 
 static struct tst_test test = {
diff --git a/testcases/kernel/syscalls/swapoff/swapoff02.c b/testcases/kernel/syscalls/swapoff/swapoff02.c
index 61536dda4..5a15826e4 100644
--- a/testcases/kernel/syscalls/swapoff/swapoff02.c
+++ b/testcases/kernel/syscalls/swapoff/swapoff02.c
@@ -87,9 +87,7 @@ static void setup(void)
 	nobody_uid = nobody->pw_uid;
 
 	is_swap_supported(TEST_FILE);
-
-	if (SAFE_MAKE_SWAPFILE_BLKS(SWAP_FILE, 10))
-		tst_brk(TBROK, "Failed to create file for swap");
+	SAFE_MAKE_SWAPFILE_BLKS(SWAP_FILE, 10);
 }
 
 static struct tst_test test = {
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
