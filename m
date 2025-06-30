Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B765FC8302F
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 12:54:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45F543C592D
	for <ltp@archiver.kernel.org>; Mon, 30 Jun 2025 14:54:53 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4D203C2557
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 14:54:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A9B06600655
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 14:54:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7F47F1F390
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 12:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751288071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=irCSKa0fnlSbUY3tP4IExxAqyEh13bQvc15r9ibbNRE=;
 b=U6zjmKpB+g2vf3pA3fbyEY7II9qyoLvE0ZLLcr6RcU+5ya1W7M2BlYFQGxqHIAM/mPLibZ
 9ifmZRTp89nggCWaIMSXkpsrQ+3lEp0kF5YT0zk+wca+LbGxmfvL2zFGbiDG/67nRGC0KR
 INnwHOuVIRogppHJi993+bHSkU8tqyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751288071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=irCSKa0fnlSbUY3tP4IExxAqyEh13bQvc15r9ibbNRE=;
 b=xN9wSNSlIH3Nl/j3OdkshCPfTKDyym8HcvQfwGekbLZ/BRjC7TdhqUnZ4uJx/J6IWr0NgY
 5dW3kBmXNjanntDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=U6zjmKpB;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xN9wSNSl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1751288071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=irCSKa0fnlSbUY3tP4IExxAqyEh13bQvc15r9ibbNRE=;
 b=U6zjmKpB+g2vf3pA3fbyEY7II9qyoLvE0ZLLcr6RcU+5ya1W7M2BlYFQGxqHIAM/mPLibZ
 9ifmZRTp89nggCWaIMSXkpsrQ+3lEp0kF5YT0zk+wca+LbGxmfvL2zFGbiDG/67nRGC0KR
 INnwHOuVIRogppHJi993+bHSkU8tqyE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1751288071;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=irCSKa0fnlSbUY3tP4IExxAqyEh13bQvc15r9ibbNRE=;
 b=xN9wSNSlIH3Nl/j3OdkshCPfTKDyym8HcvQfwGekbLZ/BRjC7TdhqUnZ4uJx/J6IWr0NgY
 5dW3kBmXNjanntDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6B61713A6E
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 12:54:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6RcEGQeJYmgiUwAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 12:54:31 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 30 Jun 2025 14:55:09 +0200
Message-ID: <20250630125509.22775-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_TRACE(0.00)[suse.cz:+]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email]
X-Rspamd-Queue-Id: 7F47F1F390
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/statmount{04,05}: Enable on FUSE
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

These tests works fine for me fine on NTFS mounted via FUSE on 6.14

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/statmount/statmount04.c | 4 ----
 testcases/kernel/syscalls/statmount/statmount05.c | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/testcases/kernel/syscalls/statmount/statmount04.c b/testcases/kernel/syscalls/statmount/statmount04.c
index 7fd4fe8c5..332f6dd4d 100644
--- a/testcases/kernel/syscalls/statmount/statmount04.c
+++ b/testcases/kernel/syscalls/statmount/statmount04.c
@@ -92,10 +92,6 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
-	.skip_filesystems = (const char *const []) {
-		"fuse",
-		NULL
-	},
 	.bufs = (struct tst_buffers []) {
 		{&st_mount, .size = sizeof(struct statmount)},
 		{}
diff --git a/testcases/kernel/syscalls/statmount/statmount05.c b/testcases/kernel/syscalls/statmount/statmount05.c
index a517f8212..56a2cb328 100644
--- a/testcases/kernel/syscalls/statmount/statmount05.c
+++ b/testcases/kernel/syscalls/statmount/statmount05.c
@@ -110,10 +110,6 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.mntpoint = MNTPOINT,
 	.all_filesystems = 1,
-	.skip_filesystems = (const char *const []) {
-		"fuse",
-		NULL
-	},
 	.bufs = (struct tst_buffers []) {
 		{&st_mount, .size = SM_SIZE},
 		{}
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
