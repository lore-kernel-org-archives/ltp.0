Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 733ADC19F2A
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 16:08:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B6A603C9427
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 18:08:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CBD203C0428
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 18:08:40 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 132E510000EE
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 18:08:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id F12EE37B85;
 Thu,  4 Aug 2022 16:08:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659629317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=noJz8o297JP5rpMEay+X3zzv5xUJQJeULlWukbIPPt4=;
 b=IKGUON3o/YZV2S6lkkCqEqYozhPRS+UD4l95iVv8v3ZW2G6206uAVUVEbbaFpQPhdeXRBW
 A3am+zQ0kDpLnHmpntvG47rKdvyIFgCYf3feaYfBzQ80EkJy4+XYkHauKO2epvyWkS90GH
 3KTPWZS87MJYaCl48uya6YYKLr7X2A0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659629317;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=noJz8o297JP5rpMEay+X3zzv5xUJQJeULlWukbIPPt4=;
 b=Py1lLcQZ9TrUOrlgdxTW+7Bnj+hFQRJUJXAIW6yCFw09BvzzCgUoHCnk3QaRthJcFPvUIT
 TYCysKxzON3/gBDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0BFB13434;
 Thu,  4 Aug 2022 16:08:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wXfcMQXv62KCIgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 04 Aug 2022 16:08:37 +0000
Message-ID: <c266e389-c6f4-502f-523d-6d51fbf3ed58@suse.cz>
Date: Thu, 4 Aug 2022 18:08:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Yang Xu <xuyang2018.jy@fujitsu.com>, ltp@lists.linux.it
References: <1659497063-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1659497063-2212-2-git-send-email-xuyang2018.jy@fujitsu.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <1659497063-2212-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] syscalls/openat: Add new regression test
 when using open(O_TMPFILE) under umask
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
Cc: brauner@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 03. 08. 22 5:24, Yang Xu wrote:
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
> v1-v2:
> no change
>  runtest/syscalls                            |   2 +-
>  testcases/kernel/syscalls/openat/.gitignore |   1 +
>  testcases/kernel/syscalls/openat/openat04.c | 194 ++++++++++++++++++++
>  3 files changed, 196 insertions(+), 1 deletion(-)
>  create mode 100644 testcases/kernel/syscalls/openat/openat04.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 3847e8af2..448b5613c 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -920,10 +920,10 @@ open12 open12
>  open13 open13
>  open14 open14
>  
> -#openat test cases
>  openat01 openat01
>  openat02 openat02
>  openat03 openat03
> +openat04 openat04
>  
>  openat201 openat201
>  openat202 openat202
> diff --git a/testcases/kernel/syscalls/openat/.gitignore b/testcases/kernel/syscalls/openat/.gitignore
> index 2928dae22..2d15872ab 100644
> --- a/testcases/kernel/syscalls/openat/.gitignore
> +++ b/testcases/kernel/syscalls/openat/.gitignore
> @@ -2,3 +2,4 @@
>  /openat02
>  /openat02_child
>  /openat03
> +/openat04
> diff --git a/testcases/kernel/syscalls/openat/openat04.c b/testcases/kernel/syscalls/openat/openat04.c
> new file mode 100644
> index 000000000..323d9a971
> --- /dev/null
> +++ b/testcases/kernel/syscalls/openat/openat04.c
> @@ -0,0 +1,194 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Check setgid strip logic whether works correctly when creating tmpfile under
> + * filesystem without posix acl supported(by using noacl mount option). Test it
> + * with umask S_IXGRP and also check file mode whether has filtered S_IXGRP.
> + *
> + * Fixed in:
> + *
> + *  commit ac6800e279a22b28f4fc21439843025a0d5bf03e
> + *  Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + *  Date:   Thu July 14 14:11:26 2022 +0800
> + *
> + *  fs: Add missing umask strip in vfs_tmpfile
> + *
> + * The most code is pasted form creat09.c.
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdlib.h>
> +#include <sys/types.h>
> +#include <pwd.h>
> +#include <sys/mount.h>
> +#include <fcntl.h>
> +#include <unistd.h>
> +#include <stdio.h>
> +#include "tst_test.h"
> +#include "tst_uid.h"
> +#include "tst_safe_file_at.h"
> +
> +#define MODE_RWX        0777
> +#define MODE_SGID       (S_ISGID|0777)
> +#define MNTPOINT	"mntpoint"
> +#define WORKDIR		MNTPOINT "/testdir"
> +#define OPEN_FILE	"open.tmp"
> +
> +static gid_t free_gid;
> +static int tmpfile_fd = -1, dir_fd = -1, mount_flag;
> +static struct passwd *ltpuser;
> +
> +static void do_mount(const char *source, const char *target,
> +	const char *filesystemtype, unsigned long mountflags,
> +	const void *data)
> +{
> +	TEST(mount(source, target, filesystemtype, mountflags, data));
> +
> +	if (TST_RET == -1 && TST_ERR == EINVAL)
> +		tst_brk(TCONF, "Kernel does not support noacl feature");
> +
> +	if (TST_RET == -1) {
> +		tst_brk(TBROK | TTERRNO, "mount(%s, %s, %s, %lu, %p) failed",
> +			source, target, filesystemtype, mountflags, data);
> +	}
> +

The tst_brk() calls above and below are identical. You can either remove
the one above, or change the error message to "Invalid return value" below.

> +	if (TST_RET) {
> +		tst_brk(TBROK | TTERRNO, "mount(%s, %s, %s, %lu, %p) failed",
> +			source, target, filesystemtype, mountflags, data);
> +	}
> +
> +	mount_flag = 1;
> +}
> +
> +static void open_tmpfile_supported(int dirfd)
> +{
> +	TEST(openat(dirfd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID));
> +
> +	if (TST_RET == -1) {
> +		if (errno == ENOTSUP)
> +			tst_brk(TCONF, "fs doesn't support O_TMPFILE");
> +		else
> +			tst_brk(TBROK | TTERRNO, "open(%d, O_TMPFILE) failed", dirfd);
> +	}

What if openat() returns some other negative value?

> +
> +	SAFE_CLOSE(TST_RET);
> +}
> +
> +static void setup(void)
> +{
> +	struct stat buf;
> +
> +	ltpuser = SAFE_GETPWNAM("nobody");
> +
> +	do_mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, "noacl");
> +
> +	tst_res(TINFO, "User nobody: uid = %d, gid = %d", (int)ltpuser->pw_uid,
> +		(int)ltpuser->pw_gid);
> +	free_gid = tst_get_free_gid(ltpuser->pw_gid);
> +
> +	/* Create directories and set permissions */
> +	SAFE_MKDIR(WORKDIR, MODE_RWX);
> +	dir_fd = SAFE_OPEN(WORKDIR, O_RDONLY, O_DIRECTORY);
> +	open_tmpfile_supported(dir_fd);
> +
> +	SAFE_CHOWN(WORKDIR, ltpuser->pw_uid, free_gid);
> +	SAFE_CHMOD(WORKDIR, MODE_SGID);
> +	SAFE_STAT(WORKDIR, &buf);
> +
> +	if (!(buf.st_mode & S_ISGID))
> +		tst_brk(TBROK, "%s: Setgid bit not set", WORKDIR);
> +
> +	if (buf.st_gid != free_gid) {
> +		tst_brk(TBROK, "%s: Incorrect group, %u != %u", WORKDIR,
> +			buf.st_gid, free_gid);
> +	}
> +}
> +
> +static void file_test(int dfd, const char *path, int flags)
> +{
> +	struct stat buf;
> +
> +	TST_EXP_PASS_SILENT(fstatat(dfd, path, &buf, flags));
> +	if (!TST_PASS) {
> +		tst_res(TFAIL, "fstat failed");
> +		return;
> +	}
> +
> +	if (buf.st_gid != free_gid) {
> +		tst_res(TFAIL, "%s: Incorrect group, %u != %u", path,
> +			buf.st_gid, free_gid);
> +	} else {
> +		tst_res(TPASS, "%s: Owned by correct group", path);
> +	}
> +
> +	if (buf.st_mode & S_ISGID)
> +		tst_res(TFAIL, "%s: Setgid bit is set", path);
> +	else
> +		tst_res(TPASS, "%s: Setgid bit not set", path);
> +
> +	if (buf.st_mode & S_IXGRP)
> +		tst_res(TFAIL, "%s: S_IXGRP bit is set", path);
> +	else
> +		tst_res(TPASS, "%s: S_IXGRP bit is not set", path);
> +}
> +
> +static void run(void)
> +{
> +	int pid;
> +	char path[PATH_MAX];
> +
> +	pid = SAFE_FORK();

You don't need to fork() here. Just change EUID/GID at the end of
setup() like in creat09 and then change EUID back at the beginning of
cleanup().

> +	if (pid == 0) {
> +		  /* Switch user */
> +		SAFE_SETGID(ltpuser->pw_gid);
> +		SAFE_SETREUID(-1, ltpuser->pw_uid);
> +
> +		umask(S_IXGRP);
> +		tmpfile_fd = SAFE_OPENAT(dir_fd, ".", O_TMPFILE | O_RDWR, MODE_SGID);
> +		snprintf(path, PATH_MAX, "/proc/self/fd/%d", tmpfile_fd);
> +		SAFE_LINKAT(AT_FDCWD, path, dir_fd, OPEN_FILE, AT_SYMLINK_FOLLOW);
> +		file_test(dir_fd, OPEN_FILE, 0);
> +		SAFE_CLOSE(tmpfile_fd);
> +		/* Cleanup between loops */
> +		tst_purge_dir(WORKDIR);
> +	}
> +
> +	tst_reap_children();
> +}
> +
> +static void cleanup(void)
> +{
> +	if (tmpfile_fd >= 0)
> +		SAFE_CLOSE(tmpfile_fd);
> +	if (dir_fd >= 0)
> +		SAFE_CLOSE(dir_fd);
> +	if (mount_flag && tst_umount(MNTPOINT))
> +		tst_res(TWARN | TERRNO, "umount(%s)", MNTPOINT);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.forks_child = 1,
> +	.all_filesystems = 1,
> +	.format_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.skip_filesystems = (const char*[]) {
> +		"exfat",
> +		"ntfs",
> +		"vfat",
> +		NULL
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "ac6800e279a2"},
> +		{}
> +	},
> +};


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
