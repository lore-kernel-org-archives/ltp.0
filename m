Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 012A8C4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:38:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 888A33CF861
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:38:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 446A53CF82A
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:35 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 32FB1140873C
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 37FEB375A9;
 Thu, 11 Apr 2024 14:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlOa9I8x6zjz8wOM/nujEBnkguka4XsTtTw4/GvtGi0=;
 b=HCeZ1XmB6nprJ3a4prufDaz8LzwY7rIGE50UhPLRHv9M9IFeY0sv88m0D77NhHh6wMvEb+
 aii6L2QakENhK3U5UVpGxvSsghUpIpmj5co71b/WqBC9KnrzrpRgC9VN6p3GKxLVCkRPrG
 FEe/+p/SsSay+gt/JeBTxdEcBUfH+Ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845833;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlOa9I8x6zjz8wOM/nujEBnkguka4XsTtTw4/GvtGi0=;
 b=H2lM/5mW60hDIYfuXCXd06HXUSa84MFD5IFVo/pfdpFW2d1P8uQjROL93VQ1Tn6+nRes0D
 GzUHPnVlilTz+MDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlOa9I8x6zjz8wOM/nujEBnkguka4XsTtTw4/GvtGi0=;
 b=HCeZ1XmB6nprJ3a4prufDaz8LzwY7rIGE50UhPLRHv9M9IFeY0sv88m0D77NhHh6wMvEb+
 aii6L2QakENhK3U5UVpGxvSsghUpIpmj5co71b/WqBC9KnrzrpRgC9VN6p3GKxLVCkRPrG
 FEe/+p/SsSay+gt/JeBTxdEcBUfH+Ow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845833;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlOa9I8x6zjz8wOM/nujEBnkguka4XsTtTw4/GvtGi0=;
 b=H2lM/5mW60hDIYfuXCXd06HXUSa84MFD5IFVo/pfdpFW2d1P8uQjROL93VQ1Tn6+nRes0D
 GzUHPnVlilTz+MDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1F9731386E;
 Thu, 11 Apr 2024 14:30:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aBo2Bgn0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:33 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:30:17 +0200
Message-ID: <20240411143025.352507-24-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411143025.352507-1-pvorel@suse.cz>
References: <20240411143025.352507-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-2.99)[99.97%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 23/31] read02: Remove UCLINUX
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/read/read02.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/testcases/kernel/syscalls/read/read02.c b/testcases/kernel/syscalls/read/read02.c
index 9199a95f6..3b4af1643 100644
--- a/testcases/kernel/syscalls/read/read02.c
+++ b/testcases/kernel/syscalls/read/read02.c
@@ -52,9 +52,7 @@ static struct tcase {
 } tcases[] = {
 	{&badfd, &bufaddr, 1, EBADF},
 	{&fd2, &bufaddr, 1, EISDIR},
-#ifndef UCLINUX
 	{&fd3, &outside_buf, 1, EFAULT},
-#endif
 	{&fd4, &addr4, 1, EINVAL},
 	{&fd4, &addr5, 4096, EINVAL},
 };
@@ -98,10 +96,8 @@ static void setup(void)
 
 	fd3 = SAFE_OPEN("test_file", O_RDWR);
 
-#if !defined(UCLINUX)
 	outside_buf = SAFE_MMAP(0, 1, PROT_NONE,
 				MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
-#endif
 
 	addr4 = SAFE_MEMALIGN(getpagesize(), (4096 * 10));
 	addr5 = addr4 + 1;
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
