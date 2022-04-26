Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93F3C433F5
	for <ltp@archiver.kernel.org>; Tue, 26 Apr 2022 12:41:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 806693CA2D8
	for <ltp@archiver.kernel.org>; Tue, 26 Apr 2022 14:41:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01BEC3C95F9
 for <ltp@lists.linux.it>; Tue, 26 Apr 2022 14:41:02 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C635714004EF
 for <ltp@lists.linux.it>; Tue, 26 Apr 2022 14:41:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 04B2A210EC;
 Tue, 26 Apr 2022 12:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650976861; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=maMzHuaL81Yn5/nX2UjUycG0eOSIZBb16KXHDzc0+98=;
 b=h3m57yIUHEuf4aE8HCc0UE2fRqRMUWAjiQHoVZat0mN3huPDP5QbCCDYZuSbvkAdIi8mPY
 Kmb+NsSgB/Ykj0LheRu6C9CzzRL5JfJ7/5J8L3nDn0JYKso7rX70SJEBfm+JjV4tgbwDpL
 JFr54VvCdcVaK4TLiFpazmPYzUIEK/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650976861;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=maMzHuaL81Yn5/nX2UjUycG0eOSIZBb16KXHDzc0+98=;
 b=hBwoP2QXfk3RuWJBOv+4SlRCeUUSvLW74dwDu+0BKU89TgoDyhKja3wkixvdkxI2aC2K2e
 XHyZHLGmGtWrIwAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D964613AD5;
 Tue, 26 Apr 2022 12:41:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vtmEM1zoZ2LkFgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 26 Apr 2022 12:41:00 +0000
Date: Tue, 26 Apr 2022 14:43:15 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Chen Hanxiao <chenhx.fnst@fujitsu.com>
Message-ID: <Ymfo4yKddW7OWfRO@yuki>
References: <20220425060806.1038-1-chenhx.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220425060806.1038-1-chenhx.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/mount_setattr01: Add basic functional
 test
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
> The mount_setattr() system call changes the mount properties of
> a mount or an entire mount tree. Here we check whether the mount
> attributes are set correctly.
> 
> Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
> Signed-off-by: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> ---
> v3:
>   1) fix doc issue
>   2) fix bugs according to Petr's comments
> v2:
>   1) fix bugs according to Cyril's comments
>   2) just set and test mount attributes, remove attr_clr section.
> 
>  include/lapi/fsmount.h                        |  45 ++++++
>  runtest/syscalls                              |   2 +
>  .../kernel/syscalls/mount_setattr/.gitignore  |   1 +
>  .../kernel/syscalls/mount_setattr/Makefile    |   6 +
>  .../syscalls/mount_setattr/mount_setattr01.c  | 135 ++++++++++++++++++
>  5 files changed, 189 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/mount_setattr/.gitignore
>  create mode 100644 testcases/kernel/syscalls/mount_setattr/Makefile
>  create mode 100644 testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
> 
> diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
> index 377af85ec..2aa92dc0c 100644
> --- a/include/lapi/fsmount.h
> +++ b/include/lapi/fsmount.h
> @@ -16,6 +16,42 @@
>  #include "lapi/fcntl.h"
>  #include "lapi/syscalls.h"
>  
> +/*
> + * Mount attributes.
> + */
> +#ifndef MOUNT_ATTR_RDONLY
> +# define MOUNT_ATTR_RDONLY       0x00000001 /* Mount read-only */
> +#endif
> +#ifndef MOUNT_ATTR_NOSUID
> +# define MOUNT_ATTR_NOSUID       0x00000002 /* Ignore suid and sgid bits */
> +#endif
> +#ifndef MOUNT_ATTR_NODEV
> +# define MOUNT_ATTR_NODEV        0x00000004 /* Disallow access to device special files */
> +#endif
> +#ifndef MOUNT_ATTR_NOEXEC
> +# define MOUNT_ATTR_NOEXEC       0x00000008 /* Disallow program execution */
> +#endif
> +#ifndef MOUNT_ATTR_NODIRATIME
> +# define MOUNT_ATTR_NODIRATIME   0x00000080 /* Do not update directory access times */
> +#endif
> +#ifndef MOUNT_ATTR_NOSYMFOLLOW
> +# define MOUNT_ATTR_NOSYMFOLLOW  0x00200000 /* Do not follow symlinks */
> +#endif
> +
> +#ifndef ST_NOSYMFOLLOW
> +# define ST_NOSYMFOLLOW 0x2000 /* do not follow symlinks */
> +#endif
> +
> +/*
> + * mount_setattr()
> + */
> +struct mount_attr {
> +	uint64_t attr_set;
> +	uint64_t attr_clr;
> +	uint64_t propagation;
> +	uint64_t userns_fd;
> +};
> +
>  #ifndef HAVE_FSOPEN
>  static inline int fsopen(const char *fsname, unsigned int flags)
>  {
> @@ -62,6 +98,15 @@ static inline int open_tree(int dirfd, const char *pathname, unsigned int flags)
>  }
>  #endif /* HAVE_OPEN_TREE */
>  
> +#ifndef HAVE_MOUNT_SETATTR
> +static inline int mount_setattr(int dirfd, const char *from_pathname, unsigned int flags,
> +				struct mount_attr *attr, size_t size)
> +{
> +	return tst_syscall(__NR_mount_setattr, dirfd, from_pathname, flags,
> +			   attr, size);
> +}
> +#endif /* HAVE_MOUNT_SETATTR */
> +
>  /*
>   * New headers added in kernel after 5.2 release, create them for old userspace.
>  */
> diff --git a/runtest/syscalls b/runtest/syscalls
> index d43d6983b..307f9bed1 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -803,6 +803,8 @@ mount04 mount04
>  mount05 mount05
>  mount06 mount06
>  
> +mount_setattr01 mount_setattr01
> +
>  move_mount01 move_mount01
>  move_mount02 move_mount02
>  
> diff --git a/testcases/kernel/syscalls/mount_setattr/.gitignore b/testcases/kernel/syscalls/mount_setattr/.gitignore
> new file mode 100644
> index 000000000..52a77b9ca
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mount_setattr/.gitignore
> @@ -0,0 +1 @@
> +/mount_setattr01
> diff --git a/testcases/kernel/syscalls/mount_setattr/Makefile b/testcases/kernel/syscalls/mount_setattr/Makefile
> new file mode 100644
> index 000000000..5ea7d67db
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mount_setattr/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
> new file mode 100644
> index 000000000..f56409a40
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> + * Author: Dai Shili <daisl.fnst@fujitsu.com>
> + * Author: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Basic mount_setattr() test.
> + * Test whether the basic mount attributes are set correctly.
> + *
> + * Verify some MOUNT_SETATTR(2) attributes:
> + *
> + * - 1) MOUNT_ATTR_RDONLY - makes the mount read-only
> + * - 2) MOUNT_ATTR_NOSUID - causes the mount not to honor the
> + *     set-user-ID and set-group-ID mode bits and file capabilities
> + *     when executing programs.
> + * - 3) MOUNT_ATTR_NODEV - prevents access to devices on this mount
> + * - 4) MOUNT_ATTR_NOEXEC - prevents executing programs on this mount
> + * - 5) MOUNT_ATTR_NOSYMFOLLOW - prevents following symbolic links
> + *    on this mount
> + * - 6) MOUNT_ATTR_NODIRATIME - prevents updating access time for
> + *    directories on this mount
> + *
> + * The functionality was added in v5.12.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <sys/statvfs.h>
> +#include "tst_test.h"
> +#include "lapi/fsmount.h"
> +#include "lapi/stat.h"
> +
> +#define MNTPOINT        "mntpoint"
> +#define OT_MNTPOINT     "ot_mntpoint"
> +#define TCASE_ENTRY(attrs, exp_attrs)   \
> +	{                                \
> +		.name = #attrs,                 \
> +		.mount_attrs = attrs,           \
> +		.expect_attrs = exp_attrs       \
> +	}
> +
> +static int dir_created;
> +static int mount_flag, otfd;
                            ^
			    This has to be set to -1 here

Otherwise we will close fd 0 in a case that the test did exit before we
opened the fd.

> +static struct tcase {
> +	char *name;
> +	unsigned int mount_attrs;
> +	unsigned int expect_attrs;
> +} tcases[] = {
> +	TCASE_ENTRY(MOUNT_ATTR_RDONLY, ST_RDONLY),
> +	TCASE_ENTRY(MOUNT_ATTR_NOSUID, ST_NOSUID),
> +	TCASE_ENTRY(MOUNT_ATTR_NODEV, ST_NODEV),
> +	TCASE_ENTRY(MOUNT_ATTR_NOEXEC, ST_NOEXEC),
> +	TCASE_ENTRY(MOUNT_ATTR_NOSYMFOLLOW, ST_NOSYMFOLLOW),
> +	TCASE_ENTRY(MOUNT_ATTR_NODIRATIME, ST_NODIRATIME),
> +};
> +
> +static void cleanup(void)
> +{
> +	if (otfd > -1)
> +		SAFE_CLOSE(otfd);
> +	if (mount_flag && tst_is_mounted_at_tmpdir(OT_MNTPOINT)) {

I would simply trust the mount_flag here, no need for the additional
tests.

> +		mount_flag = 0;

Also no need to zero the flag here.

> +		SAFE_UMOUNT(OT_MNTPOINT);
> +	}

This shouldn't be any more complicated than:

	if (mount_flag)
		SAFE_UMOUNT(OT_MNTPOINT);

> +	if (dir_created)
> +		SAFE_RMDIR(OT_MNTPOINT);

There is no need remove the directory here, the test library will remove
the temporary directory created for the test recursively.

> +}
> +
> +static void setup(void)
> +{
> +	fsopen_supported_by_kernel();
> +	SAFE_MKDIR(OT_MNTPOINT, 0777);
> +	dir_created = 1;
> +}
> +
> +static void run(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	struct mount_attr attr = {
> +		.attr_set = tc->mount_attrs,
> +	};
> +	struct statvfs buf;
> +
> +	TST_EXP_FD_SILENT(open_tree(AT_FDCWD, MNTPOINT, AT_EMPTY_PATH |
> +		AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE));
> +	if (!TST_PASS)
> +		goto out;

We can do just return here, no need to do any cleanup here.

> +	otfd = (int)TST_RET;
> +
> +	TST_EXP_PASS_SILENT(mount_setattr(otfd, "", AT_EMPTY_PATH, &attr, sizeof(attr)),
> +		"%s set", tc->name);
> +	if (!TST_PASS)
> +		return;

And here we should close the file descriptor.

> +	TST_EXP_PASS_SILENT(move_mount(otfd, "", AT_FDCWD, OT_MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
> +	if (!TST_PASS)
> +		goto out;
> +	mount_flag = 1;
> +
> +	TST_EXP_PASS_SILENT(statvfs(OT_MNTPOINT, &buf), "statvfs sucess");
> +	if (!TST_PASS)
> +		goto out;
> +
> +	if (buf.f_flag & tc->expect_attrs)
> +		tst_res(TPASS, "%s is actually set as expected", tc->name);
> +	else
> +		tst_res(TFAIL, "%s is not actually set as expected", tc->name);
> +
> +out:
> +	if (otfd > -1)
> +		SAFE_CLOSE(otfd);
> +
> +	if (tst_is_mounted_at_tmpdir(OT_MNTPOINT)) {
> +		mount_flag = 0;
> +		SAFE_UMOUNT(OT_MNTPOINT);
> +	}


Generally the cleanup here is really messed up. What we do is to put the
cleanup in a reverse order and put goto labels between cleanup steps so
that we don't have to do any checks such as:

	...

	if (fd < 0)
		goto ret0;

	...

	if (ret < 0)
		goto ret1;

	...

ret1:
	SAFE_UMOUNT(MNTPOINT);
ret0:
	SAFE_CLOSE(fd);


> +}
> +
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.mount_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.all_filesystems = 1,
> +	.skip_filesystems = (const char *const []){"fuse", NULL},
> +};

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
