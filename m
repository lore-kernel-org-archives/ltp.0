Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E04D7C25B74
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 10:49:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E87F73D073B
	for <ltp@archiver.kernel.org>; Thu, 30 May 2024 12:49:06 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E0583D067C
 for <ltp@lists.linux.it>; Thu, 30 May 2024 12:48:51 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 007E7204B64
 for <ltp@lists.linux.it>; Thu, 30 May 2024 12:48:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 05DED20785;
 Thu, 30 May 2024 10:48:50 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E25A613A42;
 Thu, 30 May 2024 10:48:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ginYNZFZWGZaMAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 30 May 2024 10:48:49 +0000
Date: Thu, 30 May 2024 12:48:41 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZlhZiZBUsEnmtwNT@yuki>
References: <20240530-ioctl_ficlone-v1-0-fa96f07d0fca@suse.com>
 <20240530-ioctl_ficlone-v1-1-fa96f07d0fca@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240530-ioctl_ficlone-v1-1-fa96f07d0fca@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 05DED20785
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] Add ioctl_ficlone01 test
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
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies that ioctl() FICLONE feature clones file content from
> + * one file to an another.
> + *
> + * [Algorithm]
> + *
> + * * populate source file
> + * * clone source content inside destination file
> + * * verify that source content has been cloned inside destination file
> + * * write a single byte inside destination file
> + * * verify that source content didn't change while destination did

This is very minor but I find dashes to be a better choice for lists
inside of C comments.

> + */
> +
> +#include "tst_test.h"
> +#include "lapi/fs.h"
> +
> +#define MNTPOINT "mnt"
> +#define SRCPATH MNTPOINT "/file0"
> +#define DSTPATH MNTPOINT "/file1"
> +
> +#define FILEDATA "qwerty"
> +#define FILESIZE sizeof(FILEDATA)
> +
> +static int src_fd = -1;
> +static int dst_fd = -1;
> +
> +static void run(void)
> +{
> +	char buff[FILESIZE];
> +	struct stat src_stat;
> +	struct stat dst_stat;
> +
> +	src_fd = SAFE_OPEN(SRCPATH, O_CREAT | O_RDWR, 0640);
> +	dst_fd = SAFE_OPEN(DSTPATH, O_CREAT | O_RDWR, 0640);
> +
> +	tst_res(TINFO, "Writing data inside src file");
> +
> +	SAFE_WRITE(1, src_fd, FILEDATA, FILESIZE);
> +	SAFE_FSYNC(src_fd);
> +
> +	TST_EXP_PASS(ioctl(dst_fd, FICLONE, src_fd));
> +	if (TST_RET == -1)
> +		return;
> +
> +	SAFE_FSYNC(dst_fd);
> +
> +	tst_res(TINFO, "Verifing that data is cloned between files");
> +
> +	SAFE_FSTAT(src_fd, &src_stat);
> +	SAFE_FSTAT(dst_fd, &dst_stat);
> +
> +	TST_EXP_EXPR(src_stat.st_ino != dst_stat.st_ino,
> +		"inode is different. %lu != %lu",
> +		src_stat.st_ino,
> +		dst_stat.st_ino);
> +
> +	TST_EXP_EQ_LI(src_stat.st_size, dst_stat.st_size);
> +
> +	SAFE_READ(0, dst_fd, buff, FILESIZE);
> +
> +	TST_EXP_EXPR(!strncmp(buff, FILEDATA, FILESIZE),
> +		"dst file has the src file content (\"%s\" - %ld bytes)",
> +		buff,
> +		FILESIZE);
> +
> +	tst_res(TINFO, "Writing a byte inside dst file");
> +
> +	SAFE_WRITE(SAFE_WRITE_ALL, dst_fd, "a", 1);
> +	SAFE_FSYNC(dst_fd);
> +
> +	tst_res(TINFO, "Verifing that src file content didn't change");
> +
> +	SAFE_FSTAT(src_fd, &src_stat);
> +	SAFE_FSTAT(dst_fd, &dst_stat);
> +
> +	TST_EXP_EQ_LI(dst_stat.st_size, src_stat.st_size + 1);
> +
> +	SAFE_READ(0, src_fd, buff, FILESIZE);
> +
> +	TST_EXP_EXPR(!strncmp(buff, FILEDATA, FILESIZE),
> +		"src file content didn't change");

So you append to the file but then only read the initial part? That does
not sound right. I guess that easiest solution is to seek to the start
of the file or od pwrite() so that we overwrite the first byte rather
than appending.

Or at least check the return value from the read.

> +	SAFE_CLOSE(src_fd);
> +	SAFE_CLOSE(dst_fd);
> +	src_fd = -1;
> +	dst_fd = -1;

This is not needed, the SAFE_CLOSE() macro sets the fd to -1.

> +	remove(SRCPATH);
> +	remove(DSTPATH);

Please use SAFE_UNLINK() instead.

> +}
> +
> +static void cleanup(void)
> +{
> +	if (src_fd != -1)
> +		SAFE_CLOSE(src_fd);
> +
> +	if (dst_fd != -1)
> +		SAFE_CLOSE(dst_fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.cleanup = cleanup,
> +	.min_kver = "4.5",
> +	.needs_root = 1,
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.dev_fs_type = "btrfs",


I suppose that we need .use_filesystems or similar and convert the
dev_fs_type to an array so that we can run this test on xfs as well...

> +};
> 
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
