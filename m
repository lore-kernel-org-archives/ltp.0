Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF368C48297
	for <ltp@archiver.kernel.org>; Mon, 12 Feb 2024 19:26:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B71533CF3E0
	for <ltp@archiver.kernel.org>; Mon, 12 Feb 2024 20:26:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 081BB3C21DA
 for <ltp@lists.linux.it>; Mon, 12 Feb 2024 20:26:19 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CA100601424
 for <ltp@lists.linux.it>; Mon, 12 Feb 2024 20:26:18 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A5B3521D07;
 Mon, 12 Feb 2024 19:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707765977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uolDUfosHddPxle98NzsxQhfxycfF14Vk2a77JSgHas=;
 b=gcPu7AFkaQG908wYbEOZviBRA3wiSHidM0vPdKxe86p/ZS5IUXsn71cOr3c0/o4UU7R8AC
 SwYUJ7YzEHPutC3B2XOz1EvlTZgNc4IskKUXzGFxVLC8bB5H5PNVTDx0fwDUlu29MfdxAY
 sVGaEem3AeYwO4V3zIR2e9mUYBUvvgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707765977;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uolDUfosHddPxle98NzsxQhfxycfF14Vk2a77JSgHas=;
 b=DkZFHfJ/Wj2CTUC4vQoft03K+lKcc1rP+nTtHCG3TGgDti9RjAJYb+q8bf3Y87yDgwczSJ
 hDD6UYQrTq8S6JBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707765977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uolDUfosHddPxle98NzsxQhfxycfF14Vk2a77JSgHas=;
 b=gcPu7AFkaQG908wYbEOZviBRA3wiSHidM0vPdKxe86p/ZS5IUXsn71cOr3c0/o4UU7R8AC
 SwYUJ7YzEHPutC3B2XOz1EvlTZgNc4IskKUXzGFxVLC8bB5H5PNVTDx0fwDUlu29MfdxAY
 sVGaEem3AeYwO4V3zIR2e9mUYBUvvgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707765977;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uolDUfosHddPxle98NzsxQhfxycfF14Vk2a77JSgHas=;
 b=DkZFHfJ/Wj2CTUC4vQoft03K+lKcc1rP+nTtHCG3TGgDti9RjAJYb+q8bf3Y87yDgwczSJ
 hDD6UYQrTq8S6JBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1CEC813212;
 Mon, 12 Feb 2024 19:26:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id L80KBNlwymUQBgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 12 Feb 2024 19:26:17 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 12 Feb 2024 20:26:12 +0100
Message-ID: <20240212192612.636901-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gcPu7AFk;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="DkZFHfJ/"
X-Spamd-Result: default: False [1.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A5B3521D07
X-Spamd-Bar: +
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] swapon03: swapon() file on mounted filesystem
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

Change in 009a407a0 left the testing actually on TMPDIR (i.e. not on
mounted filesystems), but it also failed on 6.7.0 openSUSE Tumbleweed
kernel (it worked on 6.8.0-rc1):

    # ./swapon03
    tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
    tst_test.c:1701: TINFO: === Testing on ext2 ===
    tst_test.c:1117: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
    mke2fs 1.47.0 (5-Feb-2023)
    tst_test.c:1131: TINFO: Mounting /dev/loop0 to /tmp/LTP_swaqXc3II/mntpoint fstyp=ext2 flags=0
    tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
    Failed to create swapfile: swapfile02
    swapon03.c:181: TFAIL: Failed to setup swaps

While at it, use snprintf() consistently and remove error handling (we
newer use check for snprintf()), use TTERRNO.

Fixes: 009a407a0 ("swapon/off: enable all_filesystem in swap test")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

this is a proper fix, replacing
https://patchwork.ozlabs.org/project/ltp/patch/20240205022857.191692-2-pvorel@suse.cz/

Kind regards,
Petr

 testcases/kernel/syscalls/swapon/swapon03.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index 05fe2045f..2a0fc99e6 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -52,8 +52,7 @@ static void verify_swapon(void)
 	TEST(tst_syscall(__NR_swapon, swap_testfiles[0].filename, 0));
 
 	if ((TST_RET == -1) && (TST_ERR == expected_errno)) {
-		tst_res(TPASS, "swapon(2) got expected failure (%d),",
-			expected_errno);
+		tst_res(TPASS | TTERRNO, "swapon(2) got expected failure");
 	} else if (TST_RET < 0) {
 		tst_res(TFAIL | TTERRNO,
 			"swapon(2) failed to produce expected error "
@@ -151,14 +150,8 @@ static int setup_swap(void)
 		/*create and turn on remaining swapfiles */
 		for (j = 0; j < swapfiles; j++) {
 
-			/* prepare filename for the iteration */
-			if (sprintf(filename, "swapfile%02d", j + 2) < 0) {
-				printf("sprintf() failed to create "
-				       "filename");
-				exit(1);
-			}
-
 			/* Create the swapfile */
+			snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j + 2);
 			make_swapfile(filename, 10, 0);
 
 			/* turn on the swap file */
@@ -196,14 +189,8 @@ static int clean_swap(void)
 	char filename[FILENAME_MAX];
 
 	for (j = 0; j < swapfiles; j++) {
-		if (snprintf(filename, sizeof(filename),
-			     "swapfile%02d", j + 2) < 0) {
-			tst_res(TWARN, "sprintf() failed to create filename");
-			tst_res(TWARN, "Failed to turn off swap files. System"
-				 " reboot after execution of LTP test"
-				 " suite is recommended");
-			return -1;
-		}
+		snprintf(filename, sizeof(filename), "%s%02d", TEST_FILE, j + 2);
+
 		if (check_and_swapoff(filename) != 0) {
 			tst_res(TWARN, "Failed to turn off swap file %s.", filename);
 			return -1;
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
