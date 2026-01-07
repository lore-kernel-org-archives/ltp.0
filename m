Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1758CD5854
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 11:50:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C6AD3C302B
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 12:50:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0DB23C2A49
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 12:49:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5014B600072
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 12:49:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EF8E95BF54;
 Wed,  7 Jan 2026 11:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767786585; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/37jgZWktMMxwyrWuNZLCh9A/dDuz8RJyeL1+3ypZM4=;
 b=K5MQgiSrUiZL2i/a6LMFy+O/jG6R3NhahjCFueuB0txATOSr+RJiAeA1qkfVYjwWwIaAHa
 hw/bj1FxPfUjt5SfUWJ38PVbKXU2/4LHQEqHrJkENtp0/1+bTG09iE+sQKxTKSuTlVJQ9a
 wnyB9nk5N+BggfVZrQzS9Fm3hwQiVKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767786585;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/37jgZWktMMxwyrWuNZLCh9A/dDuz8RJyeL1+3ypZM4=;
 b=QFZIyuoS7SBK4S64UeysH/tyuwNSYt5FDzuSoJN5pP0mzRWZz1SRPySCY5LAeszlcZNFoI
 IF+rYNe3D0xtazAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=YoYCDtuI;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VQfxzDXi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767786584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/37jgZWktMMxwyrWuNZLCh9A/dDuz8RJyeL1+3ypZM4=;
 b=YoYCDtuIkytXgjmYvJ1vXTuQK+6hOTZGS4RJnq3MMCzKXTHCf6cZobWCKjiqmdLlVSVfEc
 e58oNMITkFrC5xCN3rnxGT2qm8WgcWrVRrChxI673J5mGwCK3/oNmkZZbsW3i3vQmsaKYb
 Llsdt5+u/Q7i4alUcoVBltYYTA7Y4DY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767786584;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=/37jgZWktMMxwyrWuNZLCh9A/dDuz8RJyeL1+3ypZM4=;
 b=VQfxzDXiU9YjTHg05E8xxcqBEhs2htFOWtvO+WPicSWHxxvxIEmoKpPCB8CFDBzcyc819y
 vZbsjuWKJSq+u0Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F45E3EA63;
 Wed,  7 Jan 2026 11:49:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id BIwPFFhIXmndJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 Jan 2026 11:49:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed,  7 Jan 2026 12:49:33 +0100
Message-ID: <20260107114933.762846-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: EF8E95BF54
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] fw_load: Skip on Lockdown/Secure Boot
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

Similarly to delete_module0[13].c, finit_module02.c and init_module02.c
also fw_load.c cannot load modules due Lockdown/Secure Boot.

fw_load     0  TINFO  :  module signature enforcement: off
insmod: ERROR: could not insert module ltp_fw_load.ko: Key was rejected by service

dmesg:
[    0.000000] [      T0] secureboot: Secure boot enabled
[    0.000000] [      T0] Kernel is locked down from EFI Secure Boot mode; see man kernel_lockdown.7
...
[   17.679826] [   T1591] Loading of unsigned module is rejected

Reported-by: Avinesh Kumar <akumar@suse.de>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
FYI once the test is rewritten into new API, it will just use as in
delete_module0[13].c:

	/* lockdown and SecureBoot requires signed modules */
	.skip_in_lockdown = 1,
	.skip_in_secureboot = 1,

Kind regards,
Petr

 testcases/kernel/firmware/fw_load_user/fw_load.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/firmware/fw_load_user/fw_load.c b/testcases/kernel/firmware/fw_load_user/fw_load.c
index b2ed09e6f3..f5b918a698 100644
--- a/testcases/kernel/firmware/fw_load_user/fw_load.c
+++ b/testcases/kernel/firmware/fw_load_user/fw_load.c
@@ -29,6 +29,7 @@
 #include <string.h>
 
 #include "test.h"
+#include "tst_security.h"
 #include "safe_macros.h"
 #include "old_module.h"
 
@@ -102,6 +103,9 @@ static void help(void)
 
 void setup(int argc, char *argv[])
 {
+	if (tst_lockdown_enabled() > 0 || tst_secureboot_enabled() > 0)
+		tst_brkm(TCONF, NULL, "Cannot load unsigned modules in Lockdown/Secure Boot");
+
 	tst_parse_opts(argc, argv, options, help);
 
 	if (nflag) {
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
