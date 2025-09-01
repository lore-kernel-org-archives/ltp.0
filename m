Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE6ECA0FF0
	for <ltp@archiver.kernel.org>; Mon,  1 Sep 2025 10:38:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9009D3CD2C8
	for <ltp@archiver.kernel.org>; Mon,  1 Sep 2025 12:38:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E19293CD1DB
 for <ltp@lists.linux.it>; Mon,  1 Sep 2025 12:38:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2714B200225
 for <ltp@lists.linux.it>; Mon,  1 Sep 2025 12:38:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B0A151F388;
 Mon,  1 Sep 2025 10:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756723086;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3nMbn44Yq34UIF0frP56M7YCOuJM5iho4mH8qsxxGH0=;
 b=qTfSNP7jn/3UOQFpe6gkzzgzkdtDWBCVX8Jwvr9qgwHP60qK6wnx7rqScZO4ccG03l9oQv
 utXu82YlAwiJBrkzgZNHM0NXdKSjNmvLbG4Jf3yaT4nUTfoWmyPSWhdGSjwwtyHN5ySCuN
 kfmPHdBPibxIMBTAsaszzSasIeyTcH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756723086;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3nMbn44Yq34UIF0frP56M7YCOuJM5iho4mH8qsxxGH0=;
 b=HLISP82afMZUEfWHyae8KddNyy2YgMmnagie91eKh+I6F3HwrMyeOJ8qA4a+L1Mr12tJS6
 wXTRIva91fBdy6Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756723086;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3nMbn44Yq34UIF0frP56M7YCOuJM5iho4mH8qsxxGH0=;
 b=qTfSNP7jn/3UOQFpe6gkzzgzkdtDWBCVX8Jwvr9qgwHP60qK6wnx7rqScZO4ccG03l9oQv
 utXu82YlAwiJBrkzgZNHM0NXdKSjNmvLbG4Jf3yaT4nUTfoWmyPSWhdGSjwwtyHN5ySCuN
 kfmPHdBPibxIMBTAsaszzSasIeyTcH4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756723086;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3nMbn44Yq34UIF0frP56M7YCOuJM5iho4mH8qsxxGH0=;
 b=HLISP82afMZUEfWHyae8KddNyy2YgMmnagie91eKh+I6F3HwrMyeOJ8qA4a+L1Mr12tJS6
 wXTRIva91fBdy6Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 80F0F136ED;
 Mon,  1 Sep 2025 10:38:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id bV+IHo53tWgKBQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 01 Sep 2025 10:38:06 +0000
Date: Mon, 1 Sep 2025 12:38:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250901103805.GA30224@pevik>
References: <20250901074758.5094-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250901074758.5094-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.com:email,imap1.dmz-prg2.suse.org:helo];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] ioctl_loop01.c: Use proper device for
 partitioning
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> This is same patch used on ioctl09,the page cache of loop0 can cache old
> version of the partition table which is then used by the partitioning
> code. Fix the problem by calling parted against the loop device directly.

> Link: https://lore.kernel.org/ltp/20250829141932.31997-1-jack@suse.cz/
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/syscalls/ioctl/ioctl_loop01.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> index c9137bf1e..5ee7a474a 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> @@ -98,7 +98,7 @@ static void verify_ioctl_loop(void)
>  static void setup(void)
>  {
>  	int ret;
> -	const char *const cmd_parted[] = {"parted", "-s", "test.img", "mklabel", "msdos", "mkpart",
> +	const char *const cmd_parted[] = {"parted", "-s", dev_path, "mklabel", "msdos", "mkpart",
>  	                                  "primary", "ext4", "1M", "10M", NULL};

Indeed I was able to trigger the same error:

[ 2642.979234] ioctl_loop01
[ 2642.997424] loop8: detected capacity change from 0 to 20480
[ 2643.015094]  loop8: p1
[ 2643.040903] blk_update_request: I/O error, dev loop8, sector 20352 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[ 2643.042105] blk_update_request: I/O error, dev loop8, sector 20352 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[ 2643.043361] Buffer I/O error on dev loop8p1, logical block 2288, async page read
[ 2643.044539] __loop_clr_fd: partition scan of loop8 failed (rc=-16)
[ 2643.097517] blk_update_request: I/O error, dev loop8, sector 20352 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
[ 2643.098175] blk_update_request: I/O error, dev loop8, sector 20352 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
[ 2643.098767] Buffer I/O error on dev loop8p1, logical block 2288, async page read
[ 2643.109133] ioctl_ficlone02
[ 2643.109824] loop8: detected capacity change from 0 to 614400
[ 2643.175605] /dev/zero: Can't open blockdev
[ 2643.307531] EXT4-fs (loop8): mounting ext2 file system using the ext4 subsystem
[ 2643.312401] EXT4-fs (loop8): mounted filesystem without journal. Opts: (null). Quota mode: none.
[ 2643.471527] EXT4-fs (loop8): mounting ext3 file system using the ext4 subsystem
[ 2643.476826] EXT4-fs (loop8): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
[ 2643.644734] EXT4-fs (loop8): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.

But you change introduces one TCONF:

--- old	2025-09-01 05:05:50.401105483 -0400
+++ new	2025-09-01 05:05:01.925105483 -0400
@@ -5,6 +5,7 @@
 tst_kconfig.c:678: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
 tst_test.c:1827: TINFO: Overall timeout per run is 0h 02m 04s
 tst_device.c:99: TINFO: Found free device 6 '/dev/loop6'
+ioctl_loop01.c:119: TCONF: parted exited with 1
 tst_buffers.c:57: TINFO: Test is using guarded buffers
 ioctl_loop01.c:84: TPASS: /sys/block/loop6/loop/partscan = 0
 ioctl_loop01.c:85: TPASS: /sys/block/loop6/loop/autoclear = 0
@@ -12,18 +13,16 @@
 ioctl_loop01.c:56: TPASS: get expected lo_flag 12
 ioctl_loop01.c:58: TPASS: /sys/block/loop6/loop/partscan = 1
 ioctl_loop01.c:59: TPASS: /sys/block/loop6/loop/autoclear = 1
-ioctl_loop01.c:68: TPASS: access /dev/loop6p1 succeeds
-ioctl_loop01.c:74: TPASS: access /sys/block/loop6/loop6p1 succeeds
+ioctl_loop01.c:62: TINFO: Current environment doesn't have parted disk, skip it
 ioctl_loop01.c:90: TINFO: Test flag can be clear
 ioctl_loop01.c:56: TPASS: get expected lo_flag 8
 ioctl_loop01.c:58: TPASS: /sys/block/loop6/loop/partscan = 1
 ioctl_loop01.c:59: TPASS: /sys/block/loop6/loop/autoclear = 0
-ioctl_loop01.c:68: TPASS: access /dev/loop6p1 succeeds
-ioctl_loop01.c:74: TPASS: access /sys/block/loop6/loop6p1 succeeds
+ioctl_loop01.c:62: TINFO: Current environment doesn't have parted disk, skip it
 
 Summary:
-passed   13
+passed   9
 failed   0
 broken   0
-skipped  0
+skipped  1
 warnings 0

That means your change effectively disable that code. => NACK

in ioctl09.c uses the first command with "test.img", then loop device on the
second run.

Surprisingly trying to attach helps 'parted' to use it, although it produces a
warning:

+++ testcases/kernel/syscalls/ioctl/ioctl_loop01.c
@@ -106,6 +106,7 @@ static void setup(void)
                tst_brk(TBROK, "Failed to find free loop device");

        tst_fill_file("test.img", 0, 1024 * 1024, 10);
+       tst_attach_device(dev_path, "test.img");

        ret = tst_cmd(cmd_parted, NULL, NULL, TST_CMD_PASS_RETVAL);
        switch (ret) {

tst_device.c:99: TINFO: Found free device 9 '/dev/loop9'
tst_buffers.c:57: TINFO: Test is using guarded buffers
tst_device.c:176: TWARN: ioctl(/dev/loop9, LOOP_SET_FD, test.img) failed: EBUSY (16)
ioctl_loop01.c:84: TPASS: /sys/block/loop9/loop/partscan = 0
ioctl_loop01.c:85: TPASS: /sys/block/loop9/loop/autoclear = 0
ioctl_loop01.c:86: TPASS: /sys/block/loop9/loop/backing_file = '/tmp/LTP_iocfMLSpX/test.img'
ioctl_loop01.c:56: TPASS: get expected lo_flag 12
ioctl_loop01.c:58: TPASS: /sys/block/loop9/loop/partscan = 1
ioctl_loop01.c:59: TPASS: /sys/block/loop9/loop/autoclear = 1
ioctl_loop01.c:68: TPASS: access /dev/loop9p1 succeeds
ioctl_loop01.c:74: TPASS: access /sys/block/loop9/loop9p1 succeeds
ioctl_loop01.c:90: TINFO: Test flag can be clear
ioctl_loop01.c:56: TPASS: get expected lo_flag 8
ioctl_loop01.c:58: TPASS: /sys/block/loop9/loop/partscan = 1
ioctl_loop01.c:59: TPASS: /sys/block/loop9/loop/autoclear = 0
ioctl_loop01.c:68: TPASS: access /dev/loop9p1 succeeds
ioctl_loop01.c:74: TPASS: access /sys/block/loop9/loop9p1 succeeds

Of course TWARN is also no-go.
@Jan @Cyril @Li Any hint what am I missing.

Besides missing there is missing TST_CMD_TCONF_ON_MISSING on the flags (see
today's fix [1]), but that's minor.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/commit/9691c4b2bea4f772d61ca9e9a93d2087c88f6040

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
