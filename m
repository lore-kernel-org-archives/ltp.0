Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C151FCEDD97
	for <ltp@archiver.kernel.org>; Tue, 18 Nov 2025 14:37:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 418553CEF41
	for <ltp@archiver.kernel.org>; Tue, 18 Nov 2025 15:37:06 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4A0B3CF08F
 for <ltp@lists.linux.it>; Tue, 18 Nov 2025 15:36:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3FECE1400993
 for <ltp@lists.linux.it>; Tue, 18 Nov 2025 15:36:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B40F51FEF4;
 Tue, 18 Nov 2025 14:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763476574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RfSs1RAqVqfU4vvlVTO/ih3jZ2aXTgzzlPaOtaSsJyA=;
 b=Jsoquansx8hLPZctdjI5B+CAuth++IBJLKxXkX3bOzJluguvwuikCjCBEaMV9Z28xiUTy8
 inM3aPMr2Z3U/srF2/K5Hqyjt28P5F0//SF+CQM1dd2XFMb/D5h9dHF5i/kFFSbwHfAYgR
 Umc+9T4IFxt6UaFprNJqHWU9918ny1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763476574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RfSs1RAqVqfU4vvlVTO/ih3jZ2aXTgzzlPaOtaSsJyA=;
 b=Fyihx/MZfMaGulHVJILnaUxbs7hyRe5it6P5UIUVsCInIQb4hRLV3Mixw1GENKchVp6Rfv
 8eb4AR9yNrXNtEBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Jsoquans;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Fyihx/MZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1763476574; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RfSs1RAqVqfU4vvlVTO/ih3jZ2aXTgzzlPaOtaSsJyA=;
 b=Jsoquansx8hLPZctdjI5B+CAuth++IBJLKxXkX3bOzJluguvwuikCjCBEaMV9Z28xiUTy8
 inM3aPMr2Z3U/srF2/K5Hqyjt28P5F0//SF+CQM1dd2XFMb/D5h9dHF5i/kFFSbwHfAYgR
 Umc+9T4IFxt6UaFprNJqHWU9918ny1A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1763476574;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RfSs1RAqVqfU4vvlVTO/ih3jZ2aXTgzzlPaOtaSsJyA=;
 b=Fyihx/MZfMaGulHVJILnaUxbs7hyRe5it6P5UIUVsCInIQb4hRLV3Mixw1GENKchVp6Rfv
 8eb4AR9yNrXNtEBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 811C13EA62;
 Tue, 18 Nov 2025 14:36:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gKH3HV6EHGnZCAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 18 Nov 2025 14:36:14 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 18 Nov 2025 15:36:06 +0100
Message-ID: <20251118143607.45308-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251118143607.45308-1-pvorel@suse.cz>
References: <20251118143607.45308-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: B40F51FEF4
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] swapon03: Remove fork in setup
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

This is probably some leftover from the conversion to the new library.
Not only this is not necessary, it also masks proper results propagation
from the MAKE_SMALL_SWAPFILE() because there is at least one
tst_brk(TCONF, "") in there that will be converted to TBROK here.

Use safe version SAFE_MAKE_SMALL_SWAPFILE() instead of
MAKE_SMALL_SWAPFILE() to quit early during setup.

Because we don't have SAFE_SWAPON(), quit if TST_EXP_PASS_SILENT()
fails.

Also remove SAFE_SETEUID(0) which was probably due fork().

Fixes: fe1782ed66 ("syscalls/swapon03: use tst_max_swapfiles() and GET_USED_SWAPFILES() API")
Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
New in v3.

 testcases/kernel/syscalls/swapon/swapon03.c | 33 +++++++--------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index d6445d5fc4..c014a48912 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -1,8 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 /*
+ * Copyright (c) Linux Test Project, 2009-2025
  * Copyright (c) International Business Machines Corp., 2007
  * Created by <rsalveti@linux.vnet.ibm.com>
- *
  */
 
 /*\
@@ -27,13 +27,9 @@ static int swapfiles;
 
 static int setup_swap(void)
 {
-	pid_t pid;
-	int status;
 	int j, max_swapfiles, used_swapfiles;
 	char filename[FILENAME_MAX];
 
-	SAFE_SETEUID(0);
-
 	/* Determine how many more files are to be created */
 	max_swapfiles = tst_max_swapfiles();
 	used_swapfiles = tst_count_swaps();
@@ -41,24 +37,18 @@ static int setup_swap(void)
 	if (swapfiles > max_swapfiles)
 		swapfiles = max_swapfiles;
 
-	pid = SAFE_FORK();
-	if (pid == 0) {
-		/*create and turn on remaining swapfiles */
-		for (j = 0; j < swapfiles; j++) {
-
-			/* Create the swapfile */
-			snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j + 2);
-			MAKE_SMALL_SWAPFILE(filename);
+	/*create and turn on remaining swapfiles */
+	for (j = 0; j < swapfiles; j++) {
 
-			/* turn on the swap file */
-			TST_EXP_PASS_SILENT(swapon(filename, 0));
-		}
-		exit(0);
-	} else
-		waitpid(pid, &status, 0);
+		/* Create the swapfile */
+		snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j + 2);
+		SAFE_MAKE_SMALL_SWAPFILE(filename);
 
-	if (WEXITSTATUS(status))
-		tst_brk(TFAIL, "Failed to setup swap files");
+		/* turn on the swap file */
+		TST_EXP_PASS_SILENT(swapon(filename, 0));
+		if (!TST_PASS)
+			tst_brk(TFAIL, "Failed to setup swap files");
+	}
 
 	tst_res(TINFO, "Successfully created %d swap files", swapfiles);
 	MAKE_SMALL_SWAPFILE(TEST_FILE);
@@ -127,7 +117,6 @@ static struct tst_test test = {
 	.mount_device = 1,
 	.all_filesystems = 1,
 	.needs_root = 1,
-	.forks_child = 1,
 	.test_all = verify_swapon,
 	.setup = setup,
 	.cleanup = cleanup
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
