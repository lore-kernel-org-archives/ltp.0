Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72177C19F2E
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 16:44:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9D153C9E08
	for <ltp@archiver.kernel.org>; Thu, 27 Feb 2025 17:43:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4665F3C19BA
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 17:43:43 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 96262658F26
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 17:43:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A5A8921174;
 Thu, 27 Feb 2025 16:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740674621;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fT3EUkwmPSw8u4t+xKmlozUsY5tmmQQ1LG0OJlLH+AI=;
 b=L0ZDS2r4dLMyqlATatU9jM8iEYMKPcKzCqSSsNXxT/YjvBU+uAtp8LD3v3NCgSRrFZDgMS
 yadS5ZrD3iHeLc87IHESqRIeY4hdjOgMlGZp7u2QsTZCwF/mvDB9MafU7LaoNSaWidRuT2
 JwTwRunuwy2qBcvi2ezI2jw/DJAlhj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740674621;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fT3EUkwmPSw8u4t+xKmlozUsY5tmmQQ1LG0OJlLH+AI=;
 b=KpmL6cSJN60IqxQhAg0PkXaPTEI43bkImVQH6V5za3D0nUsehjDRD8I9bjEUJiVLDhLjIE
 2mNVZFIDjiTYWjBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740674621;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fT3EUkwmPSw8u4t+xKmlozUsY5tmmQQ1LG0OJlLH+AI=;
 b=L0ZDS2r4dLMyqlATatU9jM8iEYMKPcKzCqSSsNXxT/YjvBU+uAtp8LD3v3NCgSRrFZDgMS
 yadS5ZrD3iHeLc87IHESqRIeY4hdjOgMlGZp7u2QsTZCwF/mvDB9MafU7LaoNSaWidRuT2
 JwTwRunuwy2qBcvi2ezI2jw/DJAlhj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740674621;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fT3EUkwmPSw8u4t+xKmlozUsY5tmmQQ1LG0OJlLH+AI=;
 b=KpmL6cSJN60IqxQhAg0PkXaPTEI43bkImVQH6V5za3D0nUsehjDRD8I9bjEUJiVLDhLjIE
 2mNVZFIDjiTYWjBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5024E13888;
 Thu, 27 Feb 2025 16:43:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RUN9DjyWwGdsJgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 27 Feb 2025 16:43:40 +0000
Date: Thu, 27 Feb 2025 17:43:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250227164338.GG3130282@pevik>
References: <20240415114652.22687-1-wegao@suse.com>
 <20241212085058.29551-1-wegao@suse.com>
 <20241212085058.29551-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241212085058.29551-3-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/2] ioctl_fiemap01: New test for fiemap ioctl()
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

...
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_fiemap01.c
> @@ -0,0 +1,122 @@
> +// SPDX-License-Identifier: GPL-2.0-only
Please GPL-2.0-or-later.

> +/*
> + * Copyright (c) 2023 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * [Description]
Please remove this [Description].
> + *
> + * Verify basic fiemap ioctl functionality, including:
There needs to be an empty line. NOTE: if you add list (numbered or not) blank
line is required otherwise it's everything inline. If you build the docs you
would see it yourself.

> + * - The ioctl returns EBADR if it receives invalid fm_flags.
> + * - 0 extents are reported for an empty file.
> + * - The ioctl correctly retrieves single and multiple extent mappings after writing to the file.
> + */
> +
> +#include <linux/fs.h>
I suppose we need <linux/fs.h>

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
> +						unsigned int fe_length)
> +{
> +	TST_EXP_EXPR(fiemap->fm_mapped_extents == fm_mapped_extents,
> +		"Check extent fm_mapped_extents is %d", fm_mapped_extents);
> +	TST_EXP_EXPR(fiemap->fm_extents[index_extents].fe_flags & fe_flags,
> +		"Check fe_flags is %d", fe_flags);
> +	TST_EXP_EXPR(fiemap->fm_extents[index_extents].fe_physical >= min_fe_physical,
> +		"Check fe_physical > %d", min_fe_physical);
> +	TST_EXP_EXPR(fiemap->fm_extents[index_extents].fe_length == fe_length,
> +		"Check fe_length is %d", fe_length);
> +}
> +
> +static void verify_ioctl(void)
> +{
> +	int fd, ret;
> +	struct fiemap *fiemap;
> +	struct statvfs fs_info;
> +	unsigned long blk_size;
> +
> +	SAFE_CHDIR(MNTPOINT);
IMHO this will not work with -i2, it should be in the setup().

> +	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
> +
> +	SAFE_STATVFS(".", &fs_info);

And probably these two as well.

> +
> +	blk_size = fs_info.f_bsize;
> +
> +	fiemap = SAFE_MALLOC(sizeof(struct fiemap) + sizeof(struct fiemap_extent) * NUM_EXTENT);
> +	fiemap->fm_start = 0;
> +	fiemap->fm_length = ~0ULL;
> +	fiemap->fm_extent_count = 1;
> +	fiemap->fm_flags = FIEMAP_FLAG_XATTR;
> +
> +	ret = ioctl(fd, FS_IOC_FIEMAP, fiemap);
> +	if (ret == -1) {
> +		if (errno == ENOTTY)
> +			tst_res(TCONF, "ioctl(FS_IOC_FIEMAP) not implemented");
I wonder if it's safe to put errno == ENOTTY check into SAFE_IOCTL().
We have similar checks in safe_socket() and other.

e.g.:
#define TTYPE (errno == ENOTTY ? TCONF : TBROK)

Maybe it's not safe, ENOTTY might be caused by some test error which deserves
TBROK:

       ENOTTY fd is not associated with a character special device.

       ENOTTY The specified operation does not apply to the kind of object that the file descriptor fd references.


If check used here here, it should be followed by tst_brk(), right?

> +	}
> +
> +	fiemap->fm_flags = -1;
> +	TST_EXP_FAIL(ioctl(fd, FS_IOC_FIEMAP, fiemap), EBADR);
> +
> +	fiemap->fm_flags =  0;
> +	TST_EXP_PASS(ioctl(fd, FS_IOC_FIEMAP, fiemap));
> +	print_extens(fiemap);
> +	TST_EXP_EXPR(fiemap->fm_mapped_extents == 0,
> +		"Empty file should have 0 extends mapped");
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
> +static struct tst_test test = {
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,
> +	.skip_filesystems = (const char *const[]) {
> +		"exfat", "vfat", "ntfs", "tmpfs", NULL

Is the function unimplemented on these (even on tmpfs)? I would expect that but
better to explain in the commit message why it's skipped.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
