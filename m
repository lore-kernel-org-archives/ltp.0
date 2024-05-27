Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D84F0C25B7E
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 13:58:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 158E33D0404
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 15:58:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC2333C2FAF
 for <ltp@lists.linux.it>; Mon, 27 May 2024 15:58:19 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D8EBB1A00CDB
 for <ltp@lists.linux.it>; Mon, 27 May 2024 15:58:18 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 136DB21AE1
 for <ltp@lists.linux.it>; Mon, 27 May 2024 13:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716818297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kWE0pRhZyo3aE73uepaVKvjLPXvXYj6A7qyaM8OPehQ=;
 b=ZkixCrhZnAsLxA8CT/sRZDg7m+DsfAz8BO/3qD7UK9NtL0eAbosc+xkBTw5ShPoLVfDHVr
 Qqt3Fy0pgFCCT1UbIj1AMw2ZE6ztphkvxuMHNRVXKp83mzWYZRz71uL544IghhFZIVy2p0
 y/Dziz15O1BlLuU928lE8Uo8EUy0oA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716818297;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kWE0pRhZyo3aE73uepaVKvjLPXvXYj6A7qyaM8OPehQ=;
 b=fArceUGejDzaDk5MiUAbtHnhD716r5CeoEtw4NdQGFI5lMoxbmOvm2nF7F3pT0lU19Gwq6
 fvLdk41Ypb4/PxBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZkixCrhZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fArceUGe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716818297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kWE0pRhZyo3aE73uepaVKvjLPXvXYj6A7qyaM8OPehQ=;
 b=ZkixCrhZnAsLxA8CT/sRZDg7m+DsfAz8BO/3qD7UK9NtL0eAbosc+xkBTw5ShPoLVfDHVr
 Qqt3Fy0pgFCCT1UbIj1AMw2ZE6ztphkvxuMHNRVXKp83mzWYZRz71uL544IghhFZIVy2p0
 y/Dziz15O1BlLuU928lE8Uo8EUy0oA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716818297;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kWE0pRhZyo3aE73uepaVKvjLPXvXYj6A7qyaM8OPehQ=;
 b=fArceUGejDzaDk5MiUAbtHnhD716r5CeoEtw4NdQGFI5lMoxbmOvm2nF7F3pT0lU19Gwq6
 fvLdk41Ypb4/PxBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BF1F13A56
 for <ltp@lists.linux.it>; Mon, 27 May 2024 13:58:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1TSuAnmRVGbRVwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 27 May 2024 13:58:17 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 27 May 2024 15:57:17 +0200
Message-ID: <20240527135718.29451-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 136DB21AE1
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] kvm_pagefault01: Do not write into tdp_mmu sysfile
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

The tdp_mmu sysfile was made read-only in kernel v6.3. Do not modify
it but only reload vendor KVM modules if needed. Some kernel versions
before v6.3 have writable tdp_mmu sysfile which appears to be
independent from vendor KVM module settings. Print a warning about
false negatives if tdp_mmu appears enabled after reloading KVM
modules. It is unclear if that state may impact bug reproducibility.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/kvm/kvm_pagefault01.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/testcases/kernel/kvm/kvm_pagefault01.c b/testcases/kernel/kvm/kvm_pagefault01.c
index 91891848a..3dd2fa249 100644
--- a/testcases/kernel/kvm/kvm_pagefault01.c
+++ b/testcases/kernel/kvm/kvm_pagefault01.c
@@ -193,16 +193,14 @@ static void reload_module(const char *module, char *arg)
 
 static void disable_tdp(void)
 {
-	if (!access(TDP_MMU_SYSFILE, F_OK)) {
-		/* FIXME: Is setting tdp_mmu=0 sufficient to disable TDP? */
-		return;
-	}
-
 	if (read_bool_sys_param(TDP_AMD_SYSFILE) > 0)
 		reload_module("kvm_amd", "npt=0");
 
 	if (read_bool_sys_param(TDP_INTEL_SYSFILE) > 0)
 		reload_module("kvm_intel", "ept=0");
+
+	if (read_bool_sys_param(TDP_MMU_SYSFILE) > 0)
+		tst_res(TINFO, "tdp_mmu is enabled, beware of false negatives");
 }
 
 static void setup(void)
@@ -216,11 +214,6 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = tst_kvm_cleanup,
 	.needs_root = 1,
-	.save_restore = (const struct tst_path_val[]) {
-		{"/sys/module/kvm/parameters/tdp_mmu", "0",
-			TST_SR_SKIP_MISSING | TST_SR_TCONF_RO},
-		{}
-	},
 	.supported_archs = (const char *const []) {
 		"x86_64",
 		NULL
-- 
2.44.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
