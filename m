Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB0CD44D42
	for <ltp@archiver.kernel.org>; Wed,  6 Nov 2024 10:34:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CDFC3D313A
	for <ltp@archiver.kernel.org>; Wed,  6 Nov 2024 11:34:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 31ED83D3148
 for <ltp@lists.linux.it>; Wed,  6 Nov 2024 11:34:12 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 729C360007A
 for <ltp@lists.linux.it>; Wed,  6 Nov 2024 11:34:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B9C321F88E;
 Wed,  6 Nov 2024 10:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730889249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3UvQ4XORobF9ceN0TSMDWFiZhTjc1xbRGX1/tw8B+R8=;
 b=N3Gczshu5S/5AL7Sj3+xpUsyTBx0X4hkob6LTCnz7VjvbZ1elhr116IUE8EEng03OaB0Hp
 XV4CXNgjdVYKXtR84MEcLwvAN5c3MI35ah2eysX13A5TYjyEPZNGHbA55Oqw7FZRYdFJXC
 wpZsYmyt/1oeHcu6R0L5ETevrDqDcs8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730889249;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3UvQ4XORobF9ceN0TSMDWFiZhTjc1xbRGX1/tw8B+R8=;
 b=AWP085FMs+cC4p4grR5Hgm3K+Y90i9DhRWQkt+QCiQGCUa1egcsW4x0H07g8oUIl/OVGpB
 HmaYsrWZX3YdOBBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1730889249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3UvQ4XORobF9ceN0TSMDWFiZhTjc1xbRGX1/tw8B+R8=;
 b=N3Gczshu5S/5AL7Sj3+xpUsyTBx0X4hkob6LTCnz7VjvbZ1elhr116IUE8EEng03OaB0Hp
 XV4CXNgjdVYKXtR84MEcLwvAN5c3MI35ah2eysX13A5TYjyEPZNGHbA55Oqw7FZRYdFJXC
 wpZsYmyt/1oeHcu6R0L5ETevrDqDcs8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1730889249;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3UvQ4XORobF9ceN0TSMDWFiZhTjc1xbRGX1/tw8B+R8=;
 b=AWP085FMs+cC4p4grR5Hgm3K+Y90i9DhRWQkt+QCiQGCUa1egcsW4x0H07g8oUIl/OVGpB
 HmaYsrWZX3YdOBBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A835A13736;
 Wed,  6 Nov 2024 10:34:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id epcfKCFGK2dVaQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 06 Nov 2024 10:34:09 +0000
Date: Wed, 6 Nov 2024 11:34:14 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZytGJscp13xbE1_K@yuki.lan>
References: <20240331021720.9527-1-wegao@suse.com>
 <20240415114652.22687-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240415114652.22687-1-wegao@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
Subject: Re: [LTP] [PATCH v4] ioctl_fiemap01: New test for fiemap ioctl()
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
> +/*\
> + * [Description]
> + *
> + * Verify basic fiemap ioctl.

This should explain better what the test actually does.

We are doing several things here, that should be described including
checks for invalid flags, empty file, and then finally check that we get
sane data extend data from the call in two different situations. These
subtests should be described here.

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
> +static void check_extent(struct fiemap *fiemap, unsigned int fm_mapped_extents, int index_extents, int fe_flags, unsigned int min_fe_physical, unsigned int fe_length)

Didn't make check complain that this line is too long?

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
> +	int fd;
> +	struct fiemap *fiemap;
> +	struct statvfs fs_info;
> +	unsigned long blk_size;
> +
> +	SAFE_CHDIR(MNTPOINT);
> +	fd = SAFE_OPEN(TESTFILE, O_RDWR | O_CREAT, 0644);
> +
> +	if (statvfs(".", &fs_info) != 0)
> +		tst_brk(TBROK, "statvfs failed");

It would be nicer if we added SAFE_STATVFS() in a separate patch and
then used it here.

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
> +		"Check extent fm_mapped_extents is 0");
                   ^
		   Maybe better "Empty file should have 0 extends mapped"

Or something that actually explains better why it should be 0.

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
> +	},
> +	.test_all = verify_ioctl,
> +	.needs_root = 1,
> +};
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
