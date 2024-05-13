Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78E63C25B75
	for <ltp@archiver.kernel.org>; Mon, 13 May 2024 13:08:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08DD33CF0D3
	for <ltp@archiver.kernel.org>; Mon, 13 May 2024 15:08:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9D4D3C70AC
 for <ltp@lists.linux.it>; Mon, 13 May 2024 15:08:27 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 61E8C208181
 for <ltp@lists.linux.it>; Mon, 13 May 2024 15:08:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A246F5BFB9
 for <ltp@lists.linux.it>; Mon, 13 May 2024 13:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715605705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+aUCP08EE05ylJHx7N1BDraaXhZWZhTqY5cU2cVi+vE=;
 b=MKtbIESKk7wo7xJYEXLD815yIBnEoxYVO1aVhV91zrIq9hOjRlCU1zr2C/t1n1yQxAeYUG
 CEyXuHIVsAMTDJjwXC3iT6VwIuqmmvQB0F3LSjSWlyOuqEE7Wl/Kn42v4mwhTt+Q8xCc6M
 Mqe5KajcUBLeGf9lEL4Q9mEveJ3EMs4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715605705;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+aUCP08EE05ylJHx7N1BDraaXhZWZhTqY5cU2cVi+vE=;
 b=yu6ngH2JuV3P6IzBF3WmfXFSdMHmI6Nv5Ckg+75kO+oRFf13GIFAKG/xZJ8f69zywhoFy3
 /UQlwtYFIoCaGBBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MKtbIESK;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=yu6ngH2J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1715605705; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+aUCP08EE05ylJHx7N1BDraaXhZWZhTqY5cU2cVi+vE=;
 b=MKtbIESKk7wo7xJYEXLD815yIBnEoxYVO1aVhV91zrIq9hOjRlCU1zr2C/t1n1yQxAeYUG
 CEyXuHIVsAMTDJjwXC3iT6VwIuqmmvQB0F3LSjSWlyOuqEE7Wl/Kn42v4mwhTt+Q8xCc6M
 Mqe5KajcUBLeGf9lEL4Q9mEveJ3EMs4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1715605705;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+aUCP08EE05ylJHx7N1BDraaXhZWZhTqY5cU2cVi+vE=;
 b=yu6ngH2JuV3P6IzBF3WmfXFSdMHmI6Nv5Ckg+75kO+oRFf13GIFAKG/xZJ8f69zywhoFy3
 /UQlwtYFIoCaGBBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 96C8E13A52
 for <ltp@lists.linux.it>; Mon, 13 May 2024 13:08:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0J5gJMkQQmZ0BAAAD6G6ig
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Mon, 13 May 2024 13:08:25 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon, 13 May 2024 15:08:24 +0200
Message-ID: <20240513130825.11190-1-akumar@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240507165300.GA157588@pevik>
References: <20240507165300.GA157588@pevik>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A246F5BFB9
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] syscalls/mmap08: Use macro TST_EXP_FAIL_PTR_VOID()
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/mmap/mmap08.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/testcases/kernel/syscalls/mmap/mmap08.c b/testcases/kernel/syscalls/mmap/mmap08.c
index 5c9fd782c..f023446f5 100644
--- a/testcases/kernel/syscalls/mmap/mmap08.c
+++ b/testcases/kernel/syscalls/mmap/mmap08.c
@@ -8,7 +8,7 @@
 /*\
  * [Description]
  *
- * verify that, mmap() calls fails with errno EBADF when a file mapping
+ * Verify that, mmap() calls fails with errno EBADF when a file mapping
  * is requested but the fd is not a valid file descriptor.
  */
 
@@ -27,15 +27,10 @@ static void setup(void)
 
 static void run(void)
 {
-	TESTPTR(mmap(NULL, page_sz, PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0));
+	TST_EXP_FAIL_PTR_VOID(mmap(NULL, page_sz, PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0), EBADF);
 
-	if (TST_RET_PTR != MAP_FAILED) {
-		tst_res(TFAIL, "mmap() passed unexpectedly");
+	if(TST_RET_PTR != MAP_FAILED) {
 		SAFE_MUNMAP(TST_RET_PTR, page_sz);
-	} else if (TST_ERR == EBADF) {
-		tst_res(TPASS, "mmap() failed with EBADF");
-	} else {
-		tst_res(TFAIL | TERRNO, "mmap() failed with an invalid errno");
 	}
 }
 
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
