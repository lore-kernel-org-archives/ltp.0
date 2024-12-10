Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF18E77180
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 23:23:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75C573E935F
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 00:23:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FFE13E935F
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 00:23:14 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 53DDE66163C
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 00:23:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4E1F31F38C;
 Tue, 10 Dec 2024 23:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733872993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xrwVdb01dzfQL2bl+eluUARAOJw2uxUbj04p3WnaGKA=;
 b=3Rm/qaoZ6cpm/28s4rra4ofFXKfOTBDZrfisJbaf1+ZUFqFzLF+scnMohQoc7PI0oYW74Z
 h2MHpXtFHNx5V+zVexqZ2MIBEV6b8+xp5ATcjv09jswrvIgTSgEWSww1pLFxnyb4U0DIau
 s74BZ/R2VubD05xkb3w1UYsh5MdRcxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733872993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xrwVdb01dzfQL2bl+eluUARAOJw2uxUbj04p3WnaGKA=;
 b=kVQSP25no8K2DHOyuG3no809jk5X0rZv1y9FE4o3cbtzMAyilbKgQMsEOlUrkRtSrpPCac
 SQ1AXJnSEYsIsrAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="3Rm/qaoZ";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kVQSP25n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733872993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xrwVdb01dzfQL2bl+eluUARAOJw2uxUbj04p3WnaGKA=;
 b=3Rm/qaoZ6cpm/28s4rra4ofFXKfOTBDZrfisJbaf1+ZUFqFzLF+scnMohQoc7PI0oYW74Z
 h2MHpXtFHNx5V+zVexqZ2MIBEV6b8+xp5ATcjv09jswrvIgTSgEWSww1pLFxnyb4U0DIau
 s74BZ/R2VubD05xkb3w1UYsh5MdRcxw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733872993;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xrwVdb01dzfQL2bl+eluUARAOJw2uxUbj04p3WnaGKA=;
 b=kVQSP25no8K2DHOyuG3no809jk5X0rZv1y9FE4o3cbtzMAyilbKgQMsEOlUrkRtSrpPCac
 SQ1AXJnSEYsIsrAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2072B138D2;
 Tue, 10 Dec 2024 23:23:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5USsBmHNWGfnLwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 10 Dec 2024 23:23:13 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 11 Dec 2024 00:23:10 +0100
Message-ID: <20241210232311.385712-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 4E1F31F38C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] hugemmap10: Add TST_SR_TCONF flag to .save_restore
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

Conversion in 0922f44da8 forget to add it.

Fixes: 0922f44da8 ("save_restore: Introduce new struct field for flags")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
index 0e1b645416..181fe5e253 100644
--- a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
+++ b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap10.c
@@ -449,8 +449,8 @@ static struct tst_test test = {
 	.mntpoint = MNTPOINT,
 	.needs_hugetlbfs = 1,
 	.save_restore = (const struct tst_path_val[]) {
-		{PATH_OC_HPAGES, NULL},
-		{PATH_NR_HPAGES, NULL},
+		{PATH_OC_HPAGES, NULL, TST_SR_TCONF},
+		{PATH_NR_HPAGES, NULL, TST_SR_TCONF},
 		{}
 	},
 	.setup = setup,
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
