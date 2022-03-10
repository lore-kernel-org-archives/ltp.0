Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B42FC433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 13:03:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0FC93C6FD5
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 14:03:54 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1CDC3C05C3
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 14:03:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0A5E91000604
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 14:03:42 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 080781F381;
 Thu, 10 Mar 2022 13:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646917422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tTdpxwi3Mj954ZjoX5cDRsH4JQZ8xvCYWIOke8Ph19g=;
 b=CD3vwU6Zbm/hw7ptYto7BU/tpRWFIphudFSpeJU7OR9KUrOwNLU2ulPdo8cweCF9jW7b7v
 U7VSOmdy8MSO+gtr1FC8XikX2Ht8HffxV5/80FyQ7xdWCssbMMHARsj937l2uLp2BuF2PK
 Ls8qNhY+B3+AQOTbp5u3TNjDv+2cgyo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646917422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tTdpxwi3Mj954ZjoX5cDRsH4JQZ8xvCYWIOke8Ph19g=;
 b=tzC6idHHpcsVvXa4xezn1mNLNWPvomp1wteB+iwp2ky0KiIoe0tKYLVkI8zTiez+eYr8gT
 XdbJWKcGrCn8ZwCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6A6213A3D;
 Thu, 10 Mar 2022 13:03:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XFjcMy33KWLrOAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 10 Mar 2022 13:03:41 +0000
Date: Thu, 10 Mar 2022 14:06:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Dai Shili <daisl.fnst@fujitsu.com>
Message-ID: <Yin3uN8lLAioAJ9m@yuki>
References: <1646943582-13826-1-git-send-email-daisl.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1646943582-13826-1-git-send-email-daisl.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/mount_setattr01: Add basic functional
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
> diff --git a/include/lapi/fsmount.h b/include/lapi/fsmount.h
> index fa25306..99d0a0a 100644
> --- a/include/lapi/fsmount.h
> +++ b/include/lapi/fsmount.h
> @@ -15,6 +15,26 @@
>  #include "lapi/fcntl.h"
>  #include "lapi/syscalls.h"
>  
> +/*
> + * Mount attributes.
> + */
> +#define MOUNT_ATTR_RDONLY       0x00000001 /* Mount read-only */
> +#define MOUNT_ATTR_NOSUID       0x00000002 /* Ignore suid and sgid bits */
> +#define MOUNT_ATTR_NODEV        0x00000004 /* Disallow access to device special files */
> +#define MOUNT_ATTR_NOEXEC       0x00000008 /* Disallow program execution */
> +#define MOUNT_ATTR_NODIRATIME   0x00000080 /* Do not update directory access times */
> +#define MOUNT_ATTR_NOSYMFOLLOW  0x00200000 /* Do not follow symlinks */

These have to be defined only if they are missing, otherwise we will end
up with redefition warnings once glibc add these constants, i.e.

#ifndef MOUNT_ATTR_RDONLY
# define MOUNT_ATTR_RDONLY 0x00000001
#endif

...

> +/*
> + * mount_setattr()
> + */
> +struct mount_attr {
> +	__u64 attr_set;
> +	__u64 attr_clr;
> +	__u64 propagation;
> +	__u64 userns_fd;

These should be uint64_t, we cannot use the kernel types in userspace.

> +};
> +
>  #ifndef HAVE_FSOPEN
>  static inline int fsopen(const char *fsname, unsigned int flags)
>  {
> @@ -61,6 +81,15 @@ static inline int open_tree(int dirfd, const char *pathname, unsigned int flags)
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
> index 6186bfc..1a47a2e 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -800,6 +800,8 @@ mount04 mount04
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
> index 0000000..52a77b9
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mount_setattr/.gitignore
> @@ -0,0 +1 @@
> +/mount_setattr01
> diff --git a/testcases/kernel/syscalls/mount_setattr/Makefile b/testcases/kernel/syscalls/mount_setattr/Makefile
> new file mode 100644
> index 0000000..5ea7d67
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
> index 0000000..b4b1d85
> --- /dev/null
> +++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> + * Author: Dai Shili <daisl.fnst@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * Basic mount_setattr() test.
> + * Test whether the basic mount attributes are set and cleared correctly.
> + *
> + * Minimum Linux version required is v5.12.
> + */
> +
> +#include "tst_test.h"
> +#include "lapi/fsmount.h"
> +#include "lapi/stat.h"
> +
> +#define MNTPOINT        "mntpoint"
> +#define OT_MNTPOINT     "ot_mntpoint"
> +#define TCASE_ENTRY(_mount_attrs)	{.name = #_mount_attrs, .mount_attrs = _mount_attrs}
                          ^
Please do not use identifiers starting with underscore, these are
reserved for kernel and libc.

> +
> +static int dir_created;
> +
> +static struct tcase {
> +	char *name;
> +	unsigned int mount_attrs;
> +} tcases[] = {
> +	TCASE_ENTRY(MOUNT_ATTR_RDONLY),
> +	TCASE_ENTRY(MOUNT_ATTR_NOSUID),
> +	TCASE_ENTRY(MOUNT_ATTR_NODEV),
> +	TCASE_ENTRY(MOUNT_ATTR_NOEXEC),
> +	TCASE_ENTRY(MOUNT_ATTR_NOSYMFOLLOW),
> +	TCASE_ENTRY(MOUNT_ATTR_NODIRATIME),
> +};
> +
> +static void cleanup(void)
> +{
> +	if (dir_created)
> +		SAFE_RMDIR(OT_MNTPOINT);

No need to rmdir anything, it will be removed by the test library along
with the test temporary directory.

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
> +	int otfd;
> +	struct tcase *tc = &tcases[n];
> +	struct mount_attr attr = {
> +		.attr_set = tc->mount_attrs,
> +	};
> +
> +	TEST(otfd = open_tree(AT_FDCWD, MNTPOINT, AT_EMPTY_PATH |
> +		AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE));
> +	if (otfd == -1) {
> +		tst_res(TFAIL | TTERRNO, "open_tree() failed");
> +		return;
> +	}

This can be just TST_EXP_FD()

> +	TEST(mount_setattr(otfd, "", AT_EMPTY_PATH, &attr, sizeof(attr)));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "mount_setattr() set attr %s failed.", tc->name);
> +		return;
> +	}

and this can be TST_EXP_PASS()


And here we should check if the attribute was really changed.

I guess that we can add functions to verify most of the attributes, e.g.
for RDONLY we can add a function that tries to open file for writing and
expects that it fails with EROFS if the attribute has been set.

> +	attr.attr_clr = tc->mount_attrs;

This does not have any efect at all unless we also reset attr_set.
Accordinlgy to the manual page kernel first clears attributes then sets
them, so as long as the attr_set remains set to tc->mount_attrs the
following mount_setattr() is no-op.

> +	TEST(mount_setattr(otfd, "", AT_EMPTY_PATH, &attr, sizeof(attr)));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "mount_setattr() clear attr %s failed.", tc->name);
> +		return;
> +	}

This can be just TST_EXP_PASS()

And here we should check that the attribute has been reset, e.g. for
RDONLY attribute we should check that files can be opened for writing
again.


> +	TEST(move_mount(otfd, "", AT_FDCWD, OT_MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "move_mount() failed");
> +		return;
> +	}

I do not get why we do move the mount at all, this is supposed to be a
simple test for mount_setattr().

> +	SAFE_CLOSE(otfd);
> +
> +	if (tst_is_mounted_at_tmpdir(OT_MNTPOINT)) {
> +		SAFE_UMOUNT(OT_MNTPOINT);
> +		tst_res(TPASS, "mount_setattr() set and clear attr %s passed.", tc->name);
> +	}
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
> -- 
> 1.8.3.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
