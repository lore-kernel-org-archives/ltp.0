Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85DEC6FA82
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 11:41:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C80173CABF8
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 13:41:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C07B3CAAD5
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 13:40:51 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A5E6E600D21
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 13:40:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CABC71F8C6;
 Tue, 13 Sep 2022 11:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663069249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EAQcBvGKSZoCrSxM2eZrF+YgCvJsAYRJcbqXgrixbKw=;
 b=ucvYlmCycGyCXN8FJEah4NnWQZrHTOAAOA1R6VJusv496aliTEOm9AaRLbKBTiMyKDME59
 el9PSb/77v0vw7+FKm+UfGytQSbydDmShTAP17cK5rkRgykB3Ul6un1sG5H5366etldo9z
 PqY0qekr6Rxkmtp2gblbNPubopydPRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663069249;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EAQcBvGKSZoCrSxM2eZrF+YgCvJsAYRJcbqXgrixbKw=;
 b=eCmMl+7olNF32JAsou5M9QfBARMKNXM6YkGAEiTZoswTd7MFlGamGxM1jq0ktKwT3GPH3q
 NCxJ9X+RdmB+XkDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B6CCE139B3;
 Tue, 13 Sep 2022 11:40:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +YFhK0FsIGPZagAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 13 Sep 2022 11:40:49 +0000
Date: Tue, 13 Sep 2022 13:42:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YyBstRuPEtZNp887@yuki>
References: <c266e389-c6f4-502f-523d-6d51fbf3ed58@suse.cz>
 <1660555627-2269-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1660555627-2269-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1660555627-2269-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] syscalls/openat: Add new regression test
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
Cc: brauner@kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
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
                           ^
			   POSIX ACL

Both of these are acronyms and should be spelled with uppercase.

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
> +	} else if (TST_RET) {

There is no need for else if we do tst_brk() in the previous if ()

> +		tst_brk(TBROK, "Invalid return value %ld", TST_RET);
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
                                                      ^
						      openat
> +	} else if (TST_RET < 0) {

Here as well.

> +		tst_brk(TBROK, "Invalid return value %ld", TST_RET);
                                       ^
				       openat()
> +	}
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
> +
> +	/* Switch user */
> +	SAFE_SETGID(ltpuser->pw_gid);
> +	SAFE_SETREUID(-1, ltpuser->pw_uid);
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

If nothing else this part is really ugly, it's a misuse of the
TST_EXP_PASS_SILENT() macro and you even print the TFAIL message
manually for the second time.

This should really be replaced with SAFE_FSTATAT() after a patch that
adds SAFE_FSTATAT() to the test library.

> +	if (buf.st_gid != free_gid) {
> +		tst_res(TFAIL, "%s: Incorrect group, %u != %u", path,
> +			buf.st_gid, free_gid);
> +	} else {
> +		tst_res(TPASS, "%s: Owned by correct group", path);
> +	}

TST_EXP_EQ_LI(buf.st_gid, free_gid);

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
> +	char path[PATH_MAX];
> +
> +	umask(S_IXGRP);
> +	tmpfile_fd = SAFE_OPENAT(dir_fd, ".", O_TMPFILE | O_RDWR, MODE_SGID);
> +	snprintf(path, PATH_MAX, "/proc/self/fd/%d", tmpfile_fd);
> +	SAFE_LINKAT(AT_FDCWD, path, dir_fd, OPEN_FILE, AT_SYMLINK_FOLLOW);
> +	file_test(dir_fd, OPEN_FILE, 0);
> +	SAFE_CLOSE(tmpfile_fd);
> +	/* Cleanup between loops */
> +	tst_purge_dir(WORKDIR);
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_SETREUID(-1, 0);
> +
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
> -- 
> 2.23.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
