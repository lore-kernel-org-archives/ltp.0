Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69E1FC25B75
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 07:50:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C97253CFF5D
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 09:50:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DB383C02C0
 for <ltp@lists.linux.it>; Tue, 21 May 2024 09:50:02 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 809756002F9
 for <ltp@lists.linux.it>; Tue, 21 May 2024 09:50:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0739D345B7;
 Tue, 21 May 2024 07:50:01 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFE0313A79;
 Tue, 21 May 2024 07:50:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AGzULShSTGYMFwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 21 May 2024 07:50:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 May 2024 09:49:55 +0200
Message-ID: <20240521074955.78675-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240521074955.78675-1-pvorel@suse.cz>
References: <20240521074955.78675-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 0739D345B7
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/3] libswap: Remove function description
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

We have docs in libswap.h, better not duplicate the description.

Fixes: 703406ba4 ("doc: libltpswap: Add kerneldoc")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v2

 libs/libltpswap/libswap.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
index e587f315e..ce419a76e 100644
--- a/libs/libltpswap/libswap.c
+++ b/libs/libltpswap/libswap.c
@@ -241,9 +241,6 @@ bool is_swap_supported(const char *filename)
 	return true;
 }
 
-/*
- * Get kernel constant MAX_SWAPFILES value.
- */
 int tst_max_swapfiles(void)
 {
 	unsigned int swp_migration_num = 0, swp_hwpoison_num = 0,
@@ -296,9 +293,6 @@ int tst_max_swapfiles(void)
 		- swp_device_num - swp_pte_marker_num;
 }
 
-/*
- * Get the used swapfiles number.
- */
 int tst_count_swaps(void)
 {
 	FILE *fp;
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
