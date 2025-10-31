Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65D40CCF9E3
	for <ltp@archiver.kernel.org>; Fri, 31 Oct 2025 00:45:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 961F43CC68A
	for <ltp@archiver.kernel.org>; Fri, 31 Oct 2025 01:45:04 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70F943C592D
 for <ltp@lists.linux.it>; Fri, 31 Oct 2025 01:44:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DCEFA2009BB
 for <ltp@lists.linux.it>; Fri, 31 Oct 2025 01:44:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D444D1F6E6;
 Fri, 31 Oct 2025 00:44:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761871486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mBRS84K62xeUQbfSXDj5xQrXlnlZ6XrjQdq/n9cT2ik=;
 b=uqYhU/3FVA2fUJX9wRZZc4DeMNCYH3XxthAXIGdkMHX8BOY3QNgDRsdicClK00LtutSt5h
 GhsZnOmRHwmIxjI8ZGHAF2WioJV5Fzx0/GITvTjuKkNuJfja1VlRpwhiZWOP+lpi+iYOuz
 FyRqo8ojsUGwbQzskmWbs8zEVzaXUCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761871486;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mBRS84K62xeUQbfSXDj5xQrXlnlZ6XrjQdq/n9cT2ik=;
 b=IUactIbedUfXAl06mSitI2q/64XsQuzAw4AUYoL6NvbpE/VahDIBms9Sbr7kG18Q+4DV9V
 Iy51b0h2bPLmhJDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="wlUct/hi";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="T1eECV/c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1761871485; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mBRS84K62xeUQbfSXDj5xQrXlnlZ6XrjQdq/n9cT2ik=;
 b=wlUct/hikvvFTYqov9JbkEfDNXuGRdnDosupZ1Ur7PuKWAs00Q3B3eMvOVXIUkBEKFm2tU
 rKLzIUvilIgqpPKnFIvX1c2BXZv/O233pn56NRnJoSK3AR39WJnZBeEpRC0AN989nKf5MI
 TuwgRY4v6+K/qeU8gwdxIS0bBL9WzxY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1761871485;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mBRS84K62xeUQbfSXDj5xQrXlnlZ6XrjQdq/n9cT2ik=;
 b=T1eECV/c+Gy+7qar8S4hdj2wgMkafCveVgwYM2qYubiYGKXoEnIR03g7GxEGtIDLrb42G5
 OJbCVM/3ZBUL4iBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6D5713393;
 Fri, 31 Oct 2025 00:44:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SEcEMH0GBGn2bgAAD6G6ig
 (envelope-from <akumar@suse.de>); Fri, 31 Oct 2025 00:44:45 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Fri, 31 Oct 2025 01:44:44 +0100
Message-ID: <20251031004445.25185-1-akumar@suse.de>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: D444D1F6E6
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+];
 DKIM_TRACE(0.00)[suse.de:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] swapon03: Correct the test swapfile name for
 swapoff() to work
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

Fix an obvious mistake in the test. It remained hidden as test used
to run successfully and was never executing it.
On failure, it causes umount to fail as we do not swapoff() for the
edge case swapfile, and also causes breakage in subsequent filesystems
as we use the same loop device.

swapon03.c:63: TINFO: Successfully created 22 swap files
swapon03.c:64: TINFO: create a swapfile size of 1 megabytes (MB)
swapon03.c:105: TFAIL: swapon(mntpoint/testswap, 0) succeeded
tst_device.c:417: TINFO: umount('mntpoint') failed with EBUSY, try  1...
tst_device.c:421: TINFO: Likely gvfsd-trash is probing newly mounted fs, kill it to speed up tests.
tst_device.c:417: TINFO: umount('mntpoint') failed with EBUSY, try  2...
tst_device.c:417: TINFO: umount('mntpoint') failed with EBUSY, try  3...
...
...
tst_device.c:417: TINFO: umount('mntpoint') failed with EBUSY, try 49...
tst_device.c:417: TINFO: umount('mntpoint') failed with EBUSY, try 50...
tst_device.c:428: TWARN: Failed to umount('mntpoint') after 50 retries
tst_test.c:1956: TINFO: === Testing on ext3 ===
tst_test.c:1280: TINFO: Formatting /dev/loop0 with ext3 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
/dev/loop0 is mounted; will not make a filesystem here!
tst_test.c:1280: TWARN: mkfs may have failed because the device is busy (e.g., udisks2 probing). Consider disabling background probing services.
tst_test.c:1280: TBROK: mkfs.ext3 failed with exit code 1
Summary:
passed   0
failed   1
broken   1
skipped  0
warnings 2
tst_device.c:270: TWARN: ioctl(/dev/loop0, LOOP_CLR_FD, 0) no ENXIO for too long
tst_tmpdir.c:347: TWARN: tst_rmdir: rmobj(/var/tmp/LTP_swa5hk5Lk) failed: unlink(/var/tmp/LTP_swa5hk5Lk/mntpoint) failed; errno=21: EISDIR

Fixes: 8fd941649a ("syscalls/swapon03: Simply this case")
Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/swapon/swapon03.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/swapon/swapon03.c b/testcases/kernel/syscalls/swapon/swapon03.c
index 0068560fe..d6445d5fc 100644
--- a/testcases/kernel/syscalls/swapon/swapon03.c
+++ b/testcases/kernel/syscalls/swapon/swapon03.c
@@ -97,7 +97,7 @@ static void clean_swap(void)
 		check_and_swapoff(filename);
 	}
 
-	check_and_swapoff("testfile");
+	check_and_swapoff(TEST_FILE);
 }
 
 static void verify_swapon(void)
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
