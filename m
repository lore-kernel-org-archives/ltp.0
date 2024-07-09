Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0EE7C3DA42
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 21:13:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EB483D3946
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 23:13:22 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 327073D390E
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 23:13:06 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3F06E10007AC
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 23:13:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6055621A8B;
 Tue,  9 Jul 2024 21:13:04 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07CA11369A;
 Tue,  9 Jul 2024 21:13:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zo4uOt+njWaDFQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 09 Jul 2024 21:13:03 +0000
Date: Tue, 9 Jul 2024 23:13:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240709211302.GA214763@pevik>
References: <20240709-stat04-v2-0-2693a473a2ab@suse.com>
 <20240709-stat04-v2-1-2693a473a2ab@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240709-stat04-v2-1-2693a473a2ab@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 6055621A8B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/5] Add stat04 test
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

Hi all,

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> This test has been extracted from symlink01 test and it checks that
> stat() executed on file provide the same information of symlink linking
> to it.

> Reviewed-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  runtest/smoketest                         |   4 +-
>  runtest/syscalls                          |   4 +-
>  testcases/kernel/syscalls/stat/.gitignore |   2 +
>  testcases/kernel/syscalls/stat/stat04.c   | 120 ++++++++++++++++++++++++++++++
>  4 files changed, 126 insertions(+), 4 deletions(-)

> diff --git a/runtest/smoketest b/runtest/smoketest
> index f6f14fd2b..5608417f9 100644
> --- a/runtest/smoketest
> +++ b/runtest/smoketest
> @@ -8,8 +8,8 @@ time01 time01
>  wait02 wait02
>  write01 write01
>  symlink01 symlink01
> -stat04 symlink01 -T stat04
> -utime07 utime07
> +stat04 stat04
> +utime01A symlink01 -T utime01
nit: Why replace utime07 with utime01? I suggest to merge without this change
(modify only stat04).

Original test also tested ENOENT and ELOOP, but we have this in stat03.c.
(you probably have been discussing this previously.)

@Cyril: will you add your RBT (you reviewed v1).

>  rename01A symlink01 -T rename01
>  splice02 splice02 -s 20
>  df01_sh df01.sh
> diff --git a/runtest/syscalls b/runtest/syscalls
> index b6cadb2df..1e1203503 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1535,8 +1535,8 @@ stat02 stat02
>  stat02_64 stat02_64
>  stat03 stat03
>  stat03_64 stat03_64
> -stat04 symlink01 -T stat04
> -stat04_64 symlink01 -T stat04_64
> +stat04 stat04
> +stat04_64 stat04_64

OT: Out of curiosity, I'm looking into
testcases/kernel/syscalls/utils/newer_64.mk, I have no idea why there is
utils/newer_64.h part.

>  statfs01 statfs01
>  statfs01_64 statfs01_64
> diff --git a/testcases/kernel/syscalls/stat/.gitignore b/testcases/kernel/syscalls/stat/.gitignore
> index fa0a4ce9f..0a62dc6ee 100644
> --- a/testcases/kernel/syscalls/stat/.gitignore
> +++ b/testcases/kernel/syscalls/stat/.gitignore
> @@ -4,3 +4,5 @@
>  /stat02_64
>  /stat03
>  /stat03_64
> +/stat04
> +/stat04_64
> diff --git a/testcases/kernel/syscalls/stat/stat04.c b/testcases/kernel/syscalls/stat/stat04.c
> new file mode 100644
> index 000000000..4609f02d8
> --- /dev/null
> +++ b/testcases/kernel/syscalls/stat/stat04.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

Also, original test was GPL v2 only, but with rewrite like this I guess we can
have GPL v2+.

> +/*
> + * Copyright (c) 2000 Silicon Graphics, Inc.  All Rights Reserved.
> + *    Author: David Fenner, Jon Hendrickson
> + * Copyright (C) 2024 Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test checks that stat() executed on file provide the same information
> + * of symlink linking to it.
> + */
> +
> +#include <stdlib.h>
> +#include "tst_test.h"
> +
> +#define FILENAME "file.txt"
> +#define MNTPOINT "mntpoint"
> +#define SYMBNAME MNTPOINT"/file_symlink"
> +
> +static char symb_path[PATH_MAX];
> +static char file_path[PATH_MAX];
> +static struct stat *file_stat;
> +static struct stat *symb_stat;
> +static char *tmpdir;
> +
> +static void run(void)
> +{
> +	SAFE_STAT(file_path, file_stat);
> +	SAFE_STAT(symb_path, symb_stat);
> +
> +	TST_EXP_EQ_LI(file_stat->st_dev, symb_stat->st_dev);
> +	TST_EXP_EQ_LI(file_stat->st_mode, symb_stat->st_mode);
> +	TST_EXP_EQ_LI(file_stat->st_nlink, symb_stat->st_nlink);
> +	TST_EXP_EQ_LI(file_stat->st_uid, symb_stat->st_uid);
> +	TST_EXP_EQ_LI(file_stat->st_gid, symb_stat->st_gid);
> +	TST_EXP_EQ_LI(file_stat->st_size, symb_stat->st_size);
> +	TST_EXP_EQ_LI(file_stat->st_atime, symb_stat->st_atime);
> +	TST_EXP_EQ_LI(file_stat->st_mtime, symb_stat->st_mtime);
> +	TST_EXP_EQ_LI(file_stat->st_ctime, symb_stat->st_ctime);
> +}
> +
> +static void setup(void)
> +{
> +	char opt_bsize[32];
> +	const char *const fs_opts[] = {opt_bsize, NULL};
> +	struct stat sb;
> +	int pagesize;
> +	int fd;
> +
> +	tmpdir = tst_get_tmpdir();
> +
> +	if (strlen(tmpdir) >= (PATH_MAX - strlen(FILENAME))) {
> +		tst_brk(TCONF, "Temporary folder name is too long. "
> +			"Can't create file");
> +	}
> +
> +	if (strlen(tmpdir) >= (PATH_MAX - strlen(SYMBNAME))) {
> +		tst_brk(TCONF, "Temporary folder name is too long. "
> +			"Can't create symbolic link");
> +	}

PATH_MAX is 4096, right? Is it really needed to test the length?
> +
> +	/* change st_blksize / st_dev */
> +	SAFE_STAT(".", &sb);
> +	pagesize = sb.st_blksize == 4096 ? 1024 : 4096;
> +
> +	snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", pagesize);
> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
> +	SAFE_MOUNT(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, 0);

Isn't symlink filesystem related? Shouldn't this be run on all_filesystems?
But we could not force block size change.

> +
> +	SAFE_TOUCH(FILENAME, 0777, NULL);
> +
> +	/* change st_nlink */
> +	SAFE_LINK(FILENAME, "linked_file");
> +
> +	/* change st_uid and st_gid */
> +	SAFE_CHOWN(FILENAME, 1000, 1000);
> +
> +	/* change st_size */
> +	fd = SAFE_OPEN(FILENAME, O_WRONLY, 0777);
> +	tst_fill_fd(fd, 'a', TST_KB, 500);
> +	SAFE_CLOSE(fd);
> +
> +	/* change st_atime / st_mtime / st_ctime */
> +	usleep(1001000);
> +
> +	memset(file_path, 0, PATH_MAX);
> +	snprintf(file_path, PATH_MAX, "%s/%s", tmpdir, FILENAME);
> +
> +	memset(symb_path, 0, PATH_MAX);
> +	snprintf(symb_path, PATH_MAX, "%s/%s", tmpdir, SYMBNAME);
> +
> +	SAFE_SYMLINK(file_path, symb_path);
> +}
> +
> +static void cleanup(void)
> +{
> +	free(tmpdir);
nit: I know that tst_get_tmpdir() is first thing in setup(), but I would still
guard it with if (tmpdir) (code may change later).

> +
> +	SAFE_UNLINK(SYMBNAME);
nit: Ideally this would be guarded by flag that SAFE_SYMLINK(file_path,
symb_path) got executed.

> +
> +	if (tst_is_mounted(MNTPOINT))
> +		SAFE_UMOUNT(MNTPOINT);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
nit: useless tag: needs_tmpdir (can be removed before merge).

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +	.needs_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.bufs = (struct tst_buffers []) {
> +		{&file_stat, .size = sizeof(struct stat)},
> +		{&symb_stat, .size = sizeof(struct stat)},
> +		{}
> +	}
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
