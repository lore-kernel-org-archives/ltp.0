Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A3DC02181
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 14:34:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4233A3C1C7A
	for <ltp@archiver.kernel.org>; Mon, 20 Jan 2025 15:34:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 024B63C02C4
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 15:34:29 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 474C91420349
 for <ltp@lists.linux.it>; Mon, 20 Jan 2025 15:34:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C607B1F7BC;
 Mon, 20 Jan 2025 14:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737383667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PJF0bBHjRowUCxoFy3L17yrYsEXjheybx7HiuenCZAU=;
 b=lv/OByctgoqxUaSVVkwEVk5bVL3ErfMfqWXE2aRhy9czq3bxxubL22raQHg7/wW4A1nKXj
 fDODMPX6PHxHNbGULwettQvFNKq+aQM8N5TBE1CI8fPkNGHuUxL+y7bPBg3vxaueIVGq+A
 B7HiVuuRv9n0HfshBSptT0f1UuhxdBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737383667;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PJF0bBHjRowUCxoFy3L17yrYsEXjheybx7HiuenCZAU=;
 b=psKXNUhvKeq6gDJWq0G3xjlzXwUOiwsJwyMe2VQF11EH9DRoGixCcqDVvSjg3PcujgVBef
 9TXKz0//gWK+YaBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737383667; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PJF0bBHjRowUCxoFy3L17yrYsEXjheybx7HiuenCZAU=;
 b=lv/OByctgoqxUaSVVkwEVk5bVL3ErfMfqWXE2aRhy9czq3bxxubL22raQHg7/wW4A1nKXj
 fDODMPX6PHxHNbGULwettQvFNKq+aQM8N5TBE1CI8fPkNGHuUxL+y7bPBg3vxaueIVGq+A
 B7HiVuuRv9n0HfshBSptT0f1UuhxdBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737383667;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PJF0bBHjRowUCxoFy3L17yrYsEXjheybx7HiuenCZAU=;
 b=psKXNUhvKeq6gDJWq0G3xjlzXwUOiwsJwyMe2VQF11EH9DRoGixCcqDVvSjg3PcujgVBef
 9TXKz0//gWK+YaBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85A6A139CB;
 Mon, 20 Jan 2025 14:34:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id q+4bH/NejmfaMwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 20 Jan 2025 14:34:27 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 20 Jan 2025 15:34:20 +0100
Message-ID: <20250120143420.815363-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[8];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lib: Remove CONFIG_LATENCYTOP as "slow" kernel
 option
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
Cc: Alessandro Carminati <acarmina@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CONFIG_LATENCYTOP enables a kernel latency tracking infrastructure that is
used by the "latencytop" userspace tool. The latency that is tracked is not
else consuming CPU), but instead, it is the latency an application encounters
because the kernel sleeps on its behalf for various reasons.

This code tracks 2 levels of statistics:
1) System level latency
2) Per process latency

IMHO this option is safe unless one runs latencytop userspace tool while
testing LTP.

Motivation for this is the openSUSE and some SLES kernels use
CONFIG_LATENCYTOP and all tests are working with a default timeout.
starvation.c is disabled with TCONF on slow kernels, which previously
worked well on kernels with CONFIG_LATENCYTOP.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
NOTE: I would like to get this merged before upcoming release.

Kind regards,
Petr

 lib/tst_kconfig.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 66402e370d..9bcd577210 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -644,7 +644,6 @@ static struct tst_kconfig_var slow_kconfigs[] = {
 	TST_KCONFIG_INIT("CONFIG_KASAN"),
 	TST_KCONFIG_INIT("CONFIG_SLUB_RCU_DEBUG"),
 	TST_KCONFIG_INIT("CONFIG_TRACE_IRQFLAGS"),
-	TST_KCONFIG_INIT("CONFIG_LATENCYTOP"),
 	TST_KCONFIG_INIT("CONFIG_DEBUG_NET"),
 	TST_KCONFIG_INIT("CONFIG_EXT4_DEBUG"),
 	TST_KCONFIG_INIT("CONFIG_QUOTA_DEBUG"),
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
