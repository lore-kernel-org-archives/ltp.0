Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07317CDB463
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 16:25:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83FC03D0246
	for <ltp@archiver.kernel.org>; Wed, 11 Oct 2023 18:25:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 644B03C8B68
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 18:24:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7D6781400C40
 for <ltp@lists.linux.it>; Wed, 11 Oct 2023 18:24:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3284E21865;
 Wed, 11 Oct 2023 16:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697041473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ob2LIWIgdPv6DvjyUuzU8bQ3hHrsp7LXxh3/GjHCWc=;
 b=1nLVxdlKFtdorzJkYbWBkYQ0yD/5x1RfAFGaaK9BSta4k5TRbLk8cUrI+jb/6F/USJ60E/
 ojYSbMkvEIzRI+ZuWR7H3gHMuzZqV1zaL7QWK8TaXdyMUmtpUeQylIhvdl59bqzwRwrNNQ
 sPIpVMvjhCXGWSXvVIZXmd5TfpQHmZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697041473;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ob2LIWIgdPv6DvjyUuzU8bQ3hHrsp7LXxh3/GjHCWc=;
 b=0xtZOPjjWQrdb9iiJuYmGxfu6RYjLeYZhd5D1rD7iRySZnyiXijHvFbBGNtXc0pJtgkQaz
 2Dult1LY7C9ufiDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4592134F5;
 Wed, 11 Oct 2023 16:24:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GK9+KEDMJmVIKwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 11 Oct 2023 16:24:32 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 11 Oct 2023 18:24:27 +0200
Message-ID: <20231011162428.583911-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231011162428.583911-1-pvorel@suse.cz>
References: <20231011162428.583911-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.90 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 R_MISSING_CHARSET(2.50)[]; MIME_GOOD(-0.10)[text/plain];
 BROKEN_CONTENT_TYPE(1.50)[]; RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] swapon01: Test on all filesystems
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Test on all filesystems to increase coverage.  btrfs and tmpfs
currently does not support swap file, but keep it in case this get
changed in the future.

Testing on all filesystems usually requests root, but we don't require
it with .needs_root = 1. But using swapon() requires it as well, thus
keep it defined.

Also detect the support on the same file as which is being tested.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
IMHO it's not a big slowdown thus I keep btrfs and tmpfs.
They might get support one day.

 testcases/kernel/syscalls/swapon/swapon01.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
index b5c3f359c..6b7f96cf7 100644
--- a/testcases/kernel/syscalls/swapon/swapon01.c
+++ b/testcases/kernel/syscalls/swapon/swapon01.c
@@ -9,6 +9,9 @@
  * Checks that swapon() succeds with swapfile.
  */
 
+#define MNTPOINT	"mntpoint"
+#define SWAP_FILE	MNTPOINT"/swapfile01"
+
 #include <unistd.h>
 #include <errno.h>
 #include <stdlib.h>
@@ -18,14 +21,14 @@
 
 static void verify_swapon(void)
 {
-	TEST(tst_syscall(__NR_swapon, "./swapfile01", 0));
+	TEST(tst_syscall(__NR_swapon, SWAP_FILE, 0));
 
 	if (TST_RET == -1) {
 		tst_res(TFAIL | TTERRNO, "Failed to turn on swapfile");
 	} else {
 		tst_res(TPASS, "Succeeded to turn on swapfile");
 		/*we need to turn this swap file off for -i option */
-		if (tst_syscall(__NR_swapoff, "./swapfile01") != 0) {
+		if (tst_syscall(__NR_swapoff, SWAP_FILE) != 0) {
 			tst_brk(TBROK | TERRNO, "Failed to turn off swapfile,"
 				" system reboot after execution of LTP "
 				"test suite is recommended.");
@@ -35,13 +38,15 @@ static void verify_swapon(void)
 
 static void setup(void)
 {
-	is_swap_supported("./tstswap");
-	make_swapfile("swapfile01", 0);
+	is_swap_supported(SWAP_FILE);
+	make_swapfile(SWAP_FILE, 0);
 }
 
 static struct tst_test test = {
-	.needs_root = 1,
-	.needs_tmpdir = 1,
+	.mntpoint = MNTPOINT,
+	.mount_device = 1,
+	.needs_root = 1, /* for swapon() */
+	.all_filesystems = 1,
 	.test_all = verify_swapon,
 	.setup = setup
 };
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
