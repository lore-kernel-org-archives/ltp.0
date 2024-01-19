Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A8BC4725D
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 14:43:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D5EFA3CE2D5
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 15:43:54 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 113263CC84E
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 15:43:39 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 66504602385
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 15:43:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 58FE31F7E5;
 Fri, 19 Jan 2024 14:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705675417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v/7c0ybt+wb6ZnzUy0xea7hFsbeH+hipakhUTdxubFc=;
 b=Kcb0VU9WwmYCjv+Tybrtavdy47Tktwt+fF6BLC+dYqng/xu7fJ0nlsAS85KHUOfC+UyvMg
 eYP1v/psTZUVpOQ7LmRHo/HtqwZG//0v2FonYpcw1d6645yaHwmYIvqLZyCceewYwRYw1S
 vLLZFLIEfDeZVNoqT8MMoXVR/PniQFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705675417;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v/7c0ybt+wb6ZnzUy0xea7hFsbeH+hipakhUTdxubFc=;
 b=SrwtMGkcRKGiJ7oanIfY5v9mItCy6wMEF4lh4Rl9nMPyckadESaXjhk0/aNmU47eacs0cp
 w3ocZi+y++N7L/Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705675417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v/7c0ybt+wb6ZnzUy0xea7hFsbeH+hipakhUTdxubFc=;
 b=Kcb0VU9WwmYCjv+Tybrtavdy47Tktwt+fF6BLC+dYqng/xu7fJ0nlsAS85KHUOfC+UyvMg
 eYP1v/psTZUVpOQ7LmRHo/HtqwZG//0v2FonYpcw1d6645yaHwmYIvqLZyCceewYwRYw1S
 vLLZFLIEfDeZVNoqT8MMoXVR/PniQFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705675417;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=v/7c0ybt+wb6ZnzUy0xea7hFsbeH+hipakhUTdxubFc=;
 b=SrwtMGkcRKGiJ7oanIfY5v9mItCy6wMEF4lh4Rl9nMPyckadESaXjhk0/aNmU47eacs0cp
 w3ocZi+y++N7L/Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2605D136F5;
 Fri, 19 Jan 2024 14:43:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8X2/BpmKqmURNwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 19 Jan 2024 14:43:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 19 Jan 2024 15:43:22 +0100
Message-ID: <20240119144322.41928-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Kcb0VU9W;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=SrwtMGkc
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.90 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; R_MISSING_CHARSET(2.50)[];
 BROKEN_CONTENT_TYPE(1.50)[]; RCVD_COUNT_THREE(0.00)[3];
 MX_GOOD(-0.01)[]; DKIM_TRACE(0.00)[suse.cz:+];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-2.59)[98.16%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: 58FE31F7E5
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] swapon01: Test on all filesystems
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

Test on all filesystems to increase coverage.
Skip filesystems which does not support swap (currently bcachefs, btrfs
and tmpfs).

Tested on 5.10, 6.6 and 6.7.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi Li, Cyril,

feel free to postpone this after the release.
If we are for adding this, I'll retest on Monday older filesystems.

man swapon(8) mentions:

   Btrfs
       Swap files on Btrfs are supported since Linux 5.0 on files with nocow
       attribute. See the btrfs(5) manual page for more details.

=> Can we pass "nocow" just to btrfs? Or should it be added to single
test, which uses just btrfs with nocow?

   NFS
       Swap over NFS may not work.

=> I guess this is not important for us, as NFS is not part of
filesystems in .all_filesystems, but maybe we should still add it to the
whitelist?

Kind regards,
Petr

 testcases/kernel/syscalls/swapon/swapon01.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index e59fb20a1..ef4ebfdcf 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -8,6 +8,7 @@
  * [Description]
  *
  * Checks that swapon() succeds with swapfile.
+ * Testing on all filesystems which support swap file.
  */
 
 #include <unistd.h>
@@ -17,13 +18,14 @@
 #include "lapi/syscalls.h"
 #include "libswap.h"
 
-#define SWAP_FILE "swapfile01"
+#define MNTPOINT	"mntpoint"
+#define SWAP_FILE	MNTPOINT"/swapfile01"
 
 static void verify_swapon(void)
 {
 	TST_EXP_PASS(tst_syscall(__NR_swapon, SWAP_FILE, 0));
 
-	if (TST_PASS && tst_syscall(__NR_swapoff, SWAP_FILE) != 0) {
+	if (tst_syscall(__NR_swapoff, SWAP_FILE) != 0) {
 		tst_brk(TBROK | TERRNO,
 				"Failed to turn off swapfile, system reboot recommended");
 	}
@@ -31,13 +33,20 @@ static void verify_swapon(void)
 
 static void setup(void)
 {
-	is_swap_supported(SWAP_FILE);
 	make_swapfile(SWAP_FILE, 0);
 }
 
 static struct tst_test test = {
-	.needs_root = 1,
-	.needs_tmpdir = 1,
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.needs_root = 1, /* for swapon() */
+	.all_filesystems = 1,
 	.test_all = verify_swapon,
-	.setup = setup
+	.setup = setup,
+	.skip_filesystems = (const char *[]) {
+		"bcachefs",
+		"btrfs",
+		"tmpfs",
+		NULL
+	},
 };
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
