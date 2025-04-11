Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B9B2C369A2
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 15:40:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99E803CB5DD
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 17:40:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DDBC3CB233
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 17:40:30 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A3FBF1A00E4B
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 17:40:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CA6511F457;
 Fri, 11 Apr 2025 15:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744386027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9mjqGKO5ZI/AKjkMUXMrUi+Z++qnyARVGY5FGv17eoo=;
 b=I3pSQFWw8/XuwysIek1DmbQiBBDrhxgipH80Uo7ejtsic4XKp/XgWBXZvEKFkuB8Hr6JKU
 OYSzPmr236Z2LX0tRctgct4kpev/hNyHcInn4OovaKyzsiQHiorZQFMAetJm75+J9SD1EP
 7Dr9NwOG00dB/Spu50nGD5P2G2r/P/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744386027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9mjqGKO5ZI/AKjkMUXMrUi+Z++qnyARVGY5FGv17eoo=;
 b=4EItie53lJiiUgJBBPqpcRI888iEH7Ig0H1FaSnpna0wi8BxsXjGe1V4sqq90M9hWHqj5m
 b9aUtKqhPVTDiJDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744386027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9mjqGKO5ZI/AKjkMUXMrUi+Z++qnyARVGY5FGv17eoo=;
 b=I3pSQFWw8/XuwysIek1DmbQiBBDrhxgipH80Uo7ejtsic4XKp/XgWBXZvEKFkuB8Hr6JKU
 OYSzPmr236Z2LX0tRctgct4kpev/hNyHcInn4OovaKyzsiQHiorZQFMAetJm75+J9SD1EP
 7Dr9NwOG00dB/Spu50nGD5P2G2r/P/w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744386027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9mjqGKO5ZI/AKjkMUXMrUi+Z++qnyARVGY5FGv17eoo=;
 b=4EItie53lJiiUgJBBPqpcRI888iEH7Ig0H1FaSnpna0wi8BxsXjGe1V4sqq90M9hWHqj5m
 b9aUtKqhPVTDiJDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABD2013886;
 Fri, 11 Apr 2025 15:40:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id VMY5KOs3+WfZIQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 11 Apr 2025 15:40:27 +0000
Date: Fri, 11 Apr 2025 17:40:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <Z_k4BUjWJmgI1-_J@yuki.lan>
References: <20241212085058.29551-1-wegao@suse.com>
 <20250410054956.5071-1-wegao@suse.com>
 <20250410054956.5071-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250410054956.5071-3-wegao@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.com:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/2] ioctl_fiemap01: New test for fiemap ioctl()
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c b/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c
> new file mode 100644
> index 000000000..82f67adcf
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c
> @@ -0,0 +1,119 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * Verify basic fiemap ioctl functionality, including:
> + *
> + * - The ioctl returns EBADR if it receives invalid fm_flags.
> + * - 0 extents are reported for an empty file.
> + * - The ioctl correctly retrieves single and multiple extent mappings after writing to the file.
> + */
> +
> +#include <linux/fs.h>
> +#include <linux/fiemap.h>
> +#include <stdlib.h>
> +#include <sys/statvfs.h>
> +
> +#include "tst_test.h"
> +
> +#define MNTPOINT "mntpoint"
> +#define TESTFILE "testfile"
> +#define NUM_EXTENT 3
> +
> +static void print_extens(struct fiemap *fiemap)
> +{
> +	tst_res(TDEBUG, "File extent count: %u", fiemap->fm_mapped_extents);
> +
> +	for (unsigned int i = 0; i < fiemap->fm_mapped_extents; ++i) {
> +		tst_res(TDEBUG, "Extent %u: Logical offset: %llu, Physical offset: %llu, flags: %u, Length: %llu",
> +				i + 1,
> +				fiemap->fm_extents[i].fe_logical,
> +				fiemap->fm_extents[i].fe_physical,
> +				fiemap->fm_extents[i].fe_flags,
> +				fiemap->fm_extents[i].fe_length);
> +	}
> +}
> +
> +static void check_extent(struct fiemap *fiemap, unsigned int fm_mapped_extents,
> +						int index_extents, int fe_flags,
> +						unsigned int min_fe_physical,

There is no point in passing the value of min_fe_physical if we just
pass 1 in all cases, we can just hardcode the value in the function.

> +						unsigned int fe_length)
> +{
> +	TST_EXP_EXPR(fiemap->fm_mapped_extents == fm_mapped_extents,
> +		"Check extent fm_mapped_extents is %d", fm_mapped_extents);

This check should be done in a separate function instead, because we
want to check all three extents in the last test and there is no point
in checking this three times.

Also we do have TST_EXP_EQ_UI() which should be used in the cases we are
testing for equality.

> +	TST_EXP_EXPR(fiemap->fm_extents[index_extents].fe_flags & fe_flags,
                                                                ^
This does not really work if we want to assert if the last flag was set
only on the last.

I.e. if for the last test we do:

	check_extent(fiemap, NUM_EXTENT, 0, 0, blk_size);
        check_extent(fiemap, NUM_EXTENT, 1, 0, blk_size);
        check_extent(fiemap, NUM_EXTENT, 2, FIEMAP_EXTENT_LAST, blk_size);

The fe_flags test fails because we get zero. What we have to do instead
is to pass the mask and the value and check for equality as:

	TST_EXP_EQ_UI((fiemap->fm_extents[index_extents].fe_flags & fe_mask) == fe_flags);

And then we call it like:

	check_extent(fiemap, NUM_EXTENT, 0, FIEMAP_EXTENT_LAST, 0, blk_size);
        check_extent(fiemap, NUM_EXTENT, 1, FIEMAP_EXTENT_LAST, 0, blk_size);
        check_extent(fiemap, NUM_EXTENT, 2, FIEMAP_EXTENT_LAST, FIEMAP_EXTENT_LAST, blk_size);

> +		"Check fe_flags is %d", fe_flags);
> +	TST_EXP_EXPR(fiemap->fm_extents[index_extents].fe_physical >= min_fe_physical,
> +		"Check fe_physical > %d", min_fe_physical);
> +	TST_EXP_EXPR(fiemap->fm_extents[index_extents].fe_length == fe_length,
                        ^
			And lastly but not least it would be shorter to
			get the pointer to the extent and the start as:

struct fiemap_extent *extent = &fieamp->fm_extents[index_extents];

And then do just extent->fe_foo in all cases.

> +		"Check fe_length is %d", fe_length);
> +}
> +
> +static void verify_ioctl(void)
> +{
> +	int fd;
> +	struct fiemap *fiemap;
> +	struct statvfs fs_info;
> +	unsigned long blk_size;
> +
> +	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
> +
> +	SAFE_STATVFS(".", &fs_info);
> +
> +	blk_size = fs_info.f_bsize;
> +
> +	fiemap = SAFE_MALLOC(sizeof(struct fiemap) + sizeof(struct fiemap_extent) * NUM_EXTENT);
> +	fiemap->fm_start = 0;
> +	fiemap->fm_length = ~0ULL;
> +	fiemap->fm_extent_count = 1;
> +
> +	fiemap->fm_flags = -1;
> +	TST_EXP_FAIL(ioctl(fd, FS_IOC_FIEMAP, fiemap), EBADR);
> +
> +	fiemap->fm_flags =  0;
> +	TST_EXP_PASS(ioctl(fd, FS_IOC_FIEMAP, fiemap));
> +	print_extens(fiemap);
> +	TST_EXP_EXPR(fiemap->fm_mapped_extents == 0,
> +		"Empty file should have 0 extends mapped");
                                             ^
					  extents
> +
> +	char *buf = SAFE_MALLOC(blk_size);
> +
> +	SAFE_WRITE(SAFE_WRITE_ANY, fd, buf, blk_size);
> +	fiemap->fm_flags = FIEMAP_FLAG_SYNC;
> +	TST_EXP_PASS(ioctl(fd, FS_IOC_FIEMAP, fiemap));
> +	print_extens(fiemap);
> +	check_extent(fiemap, 1, 0, FIEMAP_EXTENT_LAST, 1, blk_size);
> +
> +	fiemap->fm_extent_count = NUM_EXTENT;
> +	SAFE_LSEEK(fd, 2 * blk_size, SEEK_SET);
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, blk_size);
> +	SAFE_LSEEK(fd, 4 * blk_size, SEEK_SET);
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, blk_size);
> +	TST_EXP_PASS(ioctl(fd, FS_IOC_FIEMAP, fiemap));
> +	print_extens(fiemap);
> +	check_extent(fiemap, NUM_EXTENT, NUM_EXTENT - 1, FIEMAP_EXTENT_LAST, 1, blk_size);
> +
> +	free(buf);
> +	free(fiemap);
> +	SAFE_CLOSE(fd);
> +	SAFE_UNLINK(TESTFILE);
> +}
> +
> +static void setup(void)
> +{
> +	SAFE_CHDIR(MNTPOINT);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,
> +	.skip_filesystems = (const char *const[]) {
> +		"exfat", "vfat", "fuse", "ntfs", "tmpfs", NULL
> +	},
> +	.test_all = verify_ioctl,
> +	.needs_root = 1,
> +};
> -- 
> 2.35.3
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
