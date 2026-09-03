Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A99C624A4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 11:18:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F01F3E9846
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 13:18:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 581F03E9820
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 13:18:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 926106007A1
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 13:18:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 61D3321EBA;
 Thu,  3 Sep 2026 11:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788434292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0DJqLgMdTrUTVDFA4brNHEg2DrrITVA2CtMDUOvNePw=;
 b=3RLkeW4lTo7GdBg19VN9Wk3/wKuiuDyViQVxJPK8IcbghNqr6hJUZIoZINGBQ+PADrI3cg
 ezXxZSJ04wqRvJOxoZygLe+9E//1vl16Hb7mpkzYsyW8XM0cFj1fStsgTBirF+UfHQLiiC
 a1bGiflLXMU3ManZ9YTwrujbhlbpGpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788434292;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0DJqLgMdTrUTVDFA4brNHEg2DrrITVA2CtMDUOvNePw=;
 b=sDg6Z93C7B9f5cvSxL3u+c2yDqGRmeqVPLrDfcYlS80dB5zeBAWUn4x7d0exBbTCcmbBhK
 K4wBFE5JfL0nvlAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788434288; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0DJqLgMdTrUTVDFA4brNHEg2DrrITVA2CtMDUOvNePw=;
 b=RS7r59+pZ2XLPTMwaa8njltX5pJBtnFkzUIA6qH4xvZ8TF65WaFVpUECa2OAjeMRooZ7vY
 UMz82zLm1nR9nYACicgcvRJyZ2InjSog5lvMcFfNBaeRoxB24BDqdxu8kERjRojh7VhgVp
 48TnMYQClps3TkuWxlZgakjfOVglygs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788434288;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0DJqLgMdTrUTVDFA4brNHEg2DrrITVA2CtMDUOvNePw=;
 b=+fgcVmIDuPcd0W8+x9rt7K1vQUAK8q+8gwTVQHeYfT9es7td6BJvt1qazsbLbNCn5zR7ED
 iE1VqG9mH3IFi2Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3828C136E6;
 Thu,  3 Sep 2026 11:18:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id spCuDXBXmWrGUgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 03 Sep 2026 11:18:08 +0000
Date: Thu, 3 Sep 2026 13:18:16 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aplXeHUVD9HrVU_n@yuki.lan>
References: <20260828-swapon_discard_coverage-v3-0-136924a1a730@suse.com>
 <20260828-swapon_discard_coverage-v3-2-136924a1a730@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260828-swapon_discard_coverage-v3-2-136924a1a730@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] swapon04: Add test for discard flags
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) Linux Test Project, 2026
> + */
> +
> +/*\
> + * Check that :manpage:`swapon(2)` discard flags control swapon-time area discard:
> + *
> + * - With 0 (no flags), the swap area is not discarded at swapon.
> + * - With SWAP_FLAG_DISCARD, the swap area is discarded at swapon.
> + * - With SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE, the swap area is discarded at swapon.
> + * - With SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_PAGES, swapon-time area discard
> + *   is disabled (page-cluster discard only).
> + * - With SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE | SWAP_FLAG_DISCARD_PAGES,
> + *   SWAP_FLAG_DISCARD_ONCE takes precedence and discards the swap area at swapon.
> + * - With SWAP_FLAG_DISCARD_ONCE or SWAP_FLAG_DISCARD_PAGES alone (without the
> + *   SWAP_FLAG_DISCARD master enable bit), discard is not enabled.
> + *
> + * [Algorithm]
> + *
> + * - Create a backing file on the test filesystem and fill it completely.
> + * - Attach the backing file to a loop device supporting discard.
> + * - For each test case, populate the backing file and format it with mkswap.
> + * - Record the allocated block count before swapon().
> + * - Call swapon() with the test case flags.
> + * - Verify whether the allocated block count dropped (discarded) or remained.
> + * - Call swapoff() to reset the swap device state.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <sys/stat.h>
> +#include <unistd.h>
> +
> +#include "tst_test.h"
> +#include "tse_swap.h"
> +#include "lapi/syscalls.h"
> +#include "lapi/fallocate.h"
> +
> +#define MNTPOINT "mntpoint"
> +#define BACKING_FILE MNTPOINT "/swap_backing_file"
> +#define SWAP_SIZE_MB 16
> +
> +static char loop_dev[PATH_MAX];
> +static int loop_dev_id = -1;
> +static int loop_attached;
> +static int swap_active;
> +static size_t max_header_blocks;
> +
> +static struct tcase {
> +	int flags;
> +	int exp_discard;
> +	const char *desc;
> +} tcases[] = {
> +	{
> +		.desc = "0 (no flags)",
> +	},
> +	{
> +		.flags = SWAP_FLAG_DISCARD,
> +		.exp_discard = 1,
> +		.desc = "SWAP_FLAG_DISCARD",
> +	},
> +	{
> +		.flags = SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE,
> +		.exp_discard = 1,
> +		.desc = "SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE",
> +	},
> +	{
> +		.flags = SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_PAGES,
> +		.desc = "SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_PAGES",
> +	},
> +	{
> +		.flags = SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE | SWAP_FLAG_DISCARD_PAGES,
> +		.exp_discard = 1,
> +		.desc = "SWAP_FLAG_DISCARD | SWAP_FLAG_DISCARD_ONCE | SWAP_FLAG_DISCARD_PAGES",
> +	},
> +	{
> +		.flags = SWAP_FLAG_DISCARD_ONCE,
> +		.desc = "SWAP_FLAG_DISCARD_ONCE (alone without master flag)",
> +	},
> +	{
> +		.flags = SWAP_FLAG_DISCARD_PAGES,
> +		.desc = "SWAP_FLAG_DISCARD_PAGES (alone without master flag)",
> +	},
> +};
> +
> +static void setup(void)
> +{
> +	char discard_path[PATH_MAX];
> +	unsigned long discard_max_bytes = 0;
> +	size_t page_size, blk_size, alloc_units;
> +	struct stat st;
> +	int fd;
> +
> +	if (access("/proc/swaps", F_OK))
> +		tst_brk(TCONF, "swap is not supported by kernel");

It's probably better to have CONFIG_SWAP=y in .needs_kconfigs instead.

> +	fd = SAFE_OPEN(BACKING_FILE, O_RDWR | O_CREAT | O_TRUNC, 0600);
> +	TEST(fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0, 4096));
> +
> +	if (TST_RET != 0) {
> +		SAFE_CLOSE(fd);
> +
> +		if (TST_ERR == EOPNOTSUPP || TST_ERR == ENOSYS) {
> +			tst_brk(TCONF, "Filesystem %s does not support FALLOC_FL_PUNCH_HOLE",
> +				tst_device->fs_type);
> +		}
> +
> +		tst_brk(TBROK | TERRNO, "fallocate() error");
> +	}

What is this part for? We puch hole into an empty file?

> +	SAFE_FTRUNCATE(fd, SWAP_SIZE_MB * TST_MB);
> +	SAFE_CLOSE(fd);
> +
> +	loop_dev_id = tst_find_free_loopdev(loop_dev, sizeof(loop_dev));
> +	if (loop_dev_id < 0)
> +		tst_brk(TBROK, "No free loop device found");
> +
> +	if (tst_attach_device(loop_dev, BACKING_FILE))
> +		tst_brk(TBROK, "Failed to attach %s to %s", loop_dev, BACKING_FILE);
> +	loop_attached = 1;
> +
> +	snprintf(discard_path, sizeof(discard_path),
> +		 "/sys/block/loop%d/queue/discard_max_bytes", loop_dev_id);
> +	if (FILE_SCANF(discard_path, "%lu", &discard_max_bytes) != 0 || discard_max_bytes == 0) {
> +		tst_brk(TCONF, "Loop device %s does not support discard on %s",
> +			loop_dev, tst_device->fs_type);
> +	}
> +
> +	SAFE_STAT(BACKING_FILE, &st);
> +
> +	page_size = getpagesize();
> +	blk_size = st.st_blksize;
> +	alloc_units = page_size > blk_size ? page_size : blk_size;
> +
> +	/* Minimum 512-byte blocks for 1 page + small tolerance for filesystem metadata */
> +	max_header_blocks = (alloc_units / 512) * 2;
> +}
> +
> +static void verify_swapon(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	int fd;
> +	struct stat st;
> +	blkcnt_t blocks_before, blocks_after;
> +	const char *const mkswap_argv[] = {"mkswap", loop_dev, NULL};
> +
> +	tst_res(TINFO, "Testing swapon(%s, %s)", loop_dev, tc->desc);
> +
> +	tst_fill_file(BACKING_FILE, 'A', TST_MB, SWAP_SIZE_MB);
> +
> +	fd = SAFE_OPEN(BACKING_FILE, O_RDONLY);
> +	SAFE_FSYNC(fd);
> +	SAFE_CLOSE(fd);
> +
> +	tst_cmd(mkswap_argv, "/dev/null", "/dev/null", TST_CMD_TCONF_ON_MISSING);

We need .needs_cmds = {"mkswap", NULL} for this.

> +	SAFE_STAT(BACKING_FILE, &st);
> +	blocks_before = st.st_blocks;
> +
> +	if (!blocks_before)
> +		tst_brk(TBROK, "Backing file has 0 allocated blocks");
> +
> +	TEST(tst_syscall(__NR_swapon, loop_dev, tc->flags));

Any reason we are using raw syscall instead of libc swapon() here?

> +	if (TST_RET != 0) {
> +		tst_res(TFAIL | TTERRNO, "swapon(%s, %s)", loop_dev, tc->desc);
> +		return;
> +	}

TST_EXP_PASS() ?

> +	swap_active = 1;
> +
> +	SAFE_STAT(BACKING_FILE, &st);
> +	blocks_after = st.st_blocks;
> +
> +	if (tc->exp_discard)
> +		TST_EXP_LE_LU(blocks_after, max_header_blocks);
> +	else
> +		TST_EXP_EQ_LI(blocks_after, blocks_before);
> +
> +	if (tst_syscall(__NR_swapoff, loop_dev) != 0)
> +		tst_brk(TBROK | TTERRNO, "swapoff(%s) failed", loop_dev);

Here as well why the raw syscall?

> +	swap_active = 0;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (swap_active && tst_syscall(__NR_swapoff, loop_dev) != 0)
> +		tst_res(TWARN | TTERRNO, "swapoff(%s) failed", loop_dev);
> +	swap_active = 0;
> +
> +	if (loop_attached)
> +		tst_detach_device(loop_dev);
> +	loop_attached = 0;

It's not needed to clear the flags here, the process does exit(0) right
after cleanup() is called.

> +}
> +
> +static struct tst_test test = {
> +	.needs_root = 1,
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test = verify_swapon,
> +	.tcnt = ARRAY_SIZE(tcases),
> +};
> 
> -- 
> 2.51.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
