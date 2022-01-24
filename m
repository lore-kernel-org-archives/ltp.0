Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D87B0C433F5
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 13:39:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBB003C8907
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 14:39:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 205ED3C14B2
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 14:39:00 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1142C1A0092C
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 14:38:55 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A71721F38B;
 Mon, 24 Jan 2022 13:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643031534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZphHHSWIeHTT8EexlL/lJX9G/RzPci01c8RGuNcBZw0=;
 b=I6jHrU1GzPHRiqWsfBo3vUyZonM+zK/r+TSooKwjaEbIRR99WSgRZgUOINJNd0gXVkK1se
 gVEJpF/rWzhqPrp1+wjLNr65T8FoBmdbDzIBVwIOw/lnmg9RYowy+0NPs9y7UDTiQznLOI
 ktu5XUylmUwvq6FMrF+cWZOtMs7qdA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643031534;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZphHHSWIeHTT8EexlL/lJX9G/RzPci01c8RGuNcBZw0=;
 b=B59y72fp10FdgE7B86o6Ojd6rb3A0VoXtrIpb2O18Kzz0khmVNsTgY7Xop7UzFcGrSIGL8
 SOg5Wt2MQSXt0pAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 795B713BC1;
 Mon, 24 Jan 2022 13:38:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LrZ9G+6r7mGVWQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 24 Jan 2022 13:38:54 +0000
Date: Mon, 24 Jan 2022 14:40:41 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Dai Shili <daisl.fnst@fujitsu.com>
Message-ID: <Ye6sWQ/kRf1V1FWy@yuki>
References: <1643001572-1567-1-git-send-email-daisl.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1643001572-1567-1-git-send-email-daisl.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RESEND] syscalls/statx09: Add new test
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
> Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
> ---
>  configure.ac                               |   1 +
>  include/lapi/fs.h                          |   4 +
>  include/lapi/fsverity.h                    |  38 ++++++
>  include/lapi/stat.h                        |   4 +
>  m4/ltp-fsverity.m4                         |  22 ++++
>  runtest/syscalls                           |   1 +
>  testcases/kernel/syscalls/statx/.gitignore |   1 +
>  testcases/kernel/syscalls/statx/statx09.c  | 200 +++++++++++++++++++++++++++++
>  8 files changed, 271 insertions(+)
>  create mode 100644 include/lapi/fsverity.h
>  create mode 100644 m4/ltp-fsverity.m4
>  create mode 100644 testcases/kernel/syscalls/statx/statx09.c
> 
> diff --git a/configure.ac b/configure.ac
> index 3c56d19..aeb486f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -367,6 +367,7 @@ LTP_CHECK_SELINUX
>  LTP_CHECK_SYNC_ADD_AND_FETCH
>  LTP_CHECK_SYSCALL_EVENTFD
>  LTP_CHECK_SYSCALL_FCNTL
> +LTP_CHECK_FSVERITY
>  
>  if test "x$with_numa" = xyes; then
>  	LTP_CHECK_SYSCALL_NUMA
> diff --git a/include/lapi/fs.h b/include/lapi/fs.h
> index aafeab4..27b3a18 100644
> --- a/include/lapi/fs.h
> +++ b/include/lapi/fs.h
> @@ -41,6 +41,10 @@
>  #define FS_NODUMP_FL	   0x00000040 /* do not dump file */
>  #endif
>  
> +#ifndef FS_VERITY_FL
> +#define FS_VERITY_FL	   0x00100000 /* Verity protected inode */
> +#endif
> +
>  /*
>   * Helper function to get MAX_LFS_FILESIZE.
>   * Missing PAGE_SHIFT on some libc prevents defining MAX_LFS_FILESIZE.
> diff --git a/include/lapi/fsverity.h b/include/lapi/fsverity.h
> new file mode 100644
> index 0000000..30a3c2a
> --- /dev/null
> +++ b/include/lapi/fsverity.h
> @@ -0,0 +1,38 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> + * Author: Dai Shili <daisl.fnst@cn.fujitsu.com>
> + */
> +#ifndef LAPI_FSVERITY_H__
> +#define LAPI_FSVERITY_H__
> +
> +#include "config.h"
> +#include <linux/types.h>
> +
> +#ifdef HAVE_LINUX_FSVERITY_H
> +#include <linux/fsverity.h>
> +#endif
> +
> +#ifndef FS_VERITY_HASH_ALG_SHA256
> +# define FS_VERITY_HASH_ALG_SHA256       1
> +#endif
> +
> +#ifndef FS_IOC_ENABLE_VERITY
> +# define FS_IOC_ENABLE_VERITY    _IOW('f', 133, struct fsverity_enable_arg)
> +#endif
> +
> +#ifndef HAVE_STRUCT_FSVERITY_ENABLE_ARG
> +struct fsverity_enable_arg {
> +	__u32 version;
> +	__u32 hash_algorithm;
> +	__u32 block_size;
> +	__u32 salt_size;
> +	__u64 salt_ptr;
> +	__u32 sig_size;
> +	__u32 __reserved1;
> +	__u64 sig_ptr;
> +	__u64 __reserved2[11];
> +};
> +#endif

Shouldn't this structure fallback be defined before the
FS_IOC_ENABLE_VERITY?

> +#endif
> diff --git a/include/lapi/stat.h b/include/lapi/stat.h
> index d596058..ce1f2b6 100644
> --- a/include/lapi/stat.h
> +++ b/include/lapi/stat.h
> @@ -223,6 +223,10 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
>  # define STATX_ATTR_AUTOMOUNT	0x00001000
>  #endif
>  
> +#ifndef STATX_ATTR_VERITY
> +# define STATX_ATTR_VERITY	0x00100000
> +#endif
> +
>  #ifndef AT_SYMLINK_NOFOLLOW
>  # define AT_SYMLINK_NOFOLLOW	0x100
>  #endif
> diff --git a/m4/ltp-fsverity.m4 b/m4/ltp-fsverity.m4
> new file mode 100644
> index 0000000..3d466f5
> --- /dev/null
> +++ b/m4/ltp-fsverity.m4
> @@ -0,0 +1,22 @@
> +dnl SPDX-License-Identifier: GPL-2.0-or-later
> +dnl Copyright (c) 2022 Fujitsu Ltd.
> +dnl Author: Dai Shili <daisl.fnst@cfujitsu.com>
> +
> +AC_DEFUN([LTP_CHECK_FSVERITY],[
> +	AC_CHECK_HEADERS([linux/fsverity.h], [have_fsverity=yes] ,[AC_MSG_WARN(missing linux/fsverity.h header)])
> +	if test "x$have_fsverity" = "xyes"; then
> +		AC_COMPILE_IFELSE([AC_LANG_SOURCE([
> +#include <linux/fsverity.h>
> +int main(void) {
> +	struct fsverity_enable_arg tst_fsverity_enable_arg;
> +	return 0;
> +}])], [has_fsverity_enable_arg="yes"])
> +	fi
> +
> +if test "x$has_fsverity_enable_arg" = "xyes"; then
> +	AC_DEFINE(HAVE_STRUCT_FSVERITY_ENABLE_ARG, 1, [Define to 1 if you have struct fsverity_enable_arg])
> +	AC_MSG_RESULT(yes)
> +else
> +	AC_MSG_RESULT(no)
> +fi

This whole AC_COMPILE_IFELSE() should probably be just:

AC_CHECK_TYPES(struct fsverity_enable_arg,,,[#include <linux/fsverity.h>])

> +])
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 3b2deb6..7ba0331 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1744,6 +1744,7 @@ statx05 statx05
>  statx06 statx06
>  statx07 statx07
>  statx08 statx08
> +statx09 statx09
>  
>  membarrier01 membarrier01
>  
> diff --git a/testcases/kernel/syscalls/statx/.gitignore b/testcases/kernel/syscalls/statx/.gitignore
> index 4db060d..1cea43c 100644
> --- a/testcases/kernel/syscalls/statx/.gitignore
> +++ b/testcases/kernel/syscalls/statx/.gitignore
> @@ -6,3 +6,4 @@
>  /statx06
>  /statx07
>  /statx08
> +/statx09
> diff --git a/testcases/kernel/syscalls/statx/statx09.c b/testcases/kernel/syscalls/statx/statx09.c
> new file mode 100644
> index 0000000..38f7ca7
> --- /dev/null
> +++ b/testcases/kernel/syscalls/statx/statx09.c
> @@ -0,0 +1,200 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> + * Author: Dai Shili <daisl.fnst@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This code tests if the attributes field of statx received expected value.
> + * File set with following flags by using SAFE_IOCTL:
> + *
> + * - STATX_ATTR_VERITY: statx() system call sets STATX_ATTR_VERITY if the file
> + * has fs-verity enabled. This can perform better than FS_IOC_GETFLAGS and
> + * FS_IOC_MEASURE_VERITY because it doesn't require opening the file,
> + * and opening verity files can be expensive.
> + *
> + * Minimum Linux version required is v5.5.
> + * fs-verity is currently supported by the ext4 and f2fs filesystems.
> + * The CONFIG_FS_VERITY kconfig option must be enabled to use fs-verity
> + * on either filesystem.
> + * ext4 supports fs-verity since Linux v5.4 and e2fsprogs v1.45.2.
> + */
> +
> +#define _GNU_SOURCE
> +#include <sys/mount.h>
> +#include <stdlib.h>
> +#include <linux/ioctl.h>
> +#include "tst_test.h"
> +#include "lapi/fs.h"
> +#include "lapi/fsverity.h"
> +#include "lapi/stat.h"
> +#include <inttypes.h>
> +
> +#define MNTPOINT "mnt_point"
> +#define TESTFILE_FLAGGED MNTPOINT"/test_file1"
> +#define TESTFILE_UNFLAGGED MNTPOINT"/test_file2"
> +
> +static int fd_flagged, fd_unflagged, clear_flags;
> +static int mount_flag;
> +static char wrbuf[5];
> +
> +static const uint32_t hash_algorithms[] = {
> +	FS_VERITY_HASH_ALG_SHA256,
> +};
> +
> +static void test_flagged(void)
> +{
> +	struct statx buf;
> +
> +	TEST(statx(AT_FDCWD, TESTFILE_FLAGGED, 0, 0, &buf));
> +	if (TST_RET == 0)
> +		tst_res(TPASS,
> +			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)", TESTFILE_FLAGGED);
> +	else
> +		tst_brk(TFAIL | TTERRNO,
> +			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)", TESTFILE_FLAGGED);

Just use TST_EXP_PASS().

> +	if (buf.stx_attributes & STATX_ATTR_VERITY)
> +		tst_res(TPASS, "STATX_ATTR_VERITY flag is set: (%"PRIu64") ", buf.stx_attributes);
> +	else
> +		tst_res(TFAIL, "STATX_ATTR_VERITY flag is not set");
> +}
> +
> +static void test_unflagged(void)
> +{
> +	struct statx buf;
> +
> +	TEST(statx(AT_FDCWD, TESTFILE_UNFLAGGED, 0, 0, &buf));
> +	if (TST_RET == 0)
> +		tst_res(TPASS,
> +			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)",
> +			TESTFILE_UNFLAGGED);
> +	else
> +		tst_brk(TFAIL | TTERRNO,
> +			"sys_statx(AT_FDCWD, %s, 0, 0, &buf)",
> +			TESTFILE_UNFLAGGED);

Here as well.

> +	if ((buf.stx_attributes & STATX_ATTR_VERITY) == 0)
> +		tst_res(TPASS, "STATX_ATTR_VERITY flag is not set");
> +	else
> +		tst_res(TFAIL, "STATX_ATTR_VERITY flag is set");
> +}
> +
> +static struct test_cases {
> +	void (*tfunc)(void);
> +} tcases[] = {
> +	{&test_flagged},
> +	{&test_unflagged},
> +};
> +
> +static void run(unsigned int i)
> +{
> +	tcases[i].tfunc();
> +}
> +
> +static void flag_setup(void)
> +{
> +	int attr, ret;
> +	struct fsverity_enable_arg enable;
> +
> +	fd_flagged = SAFE_OPEN(TESTFILE_FLAGGED, O_RDONLY, 0664);
> +	fd_unflagged = SAFE_OPEN(TESTFILE_UNFLAGGED, O_RDWR | O_CREAT, 0664);

What is this file descriptor even used for?

I guess that we can create this file in the test setup as well and there
is no point in doing anything with the unflagged file here.

> +	ret = ioctl(fd_flagged, FS_IOC_GETFLAGS, &attr);
> +	if (ret < 0) {
> +		if (errno == ENOTTY)
> +			tst_brk(TCONF | TERRNO, "FS_IOC_GETFLAGS not supported");
> +
> +		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_GETFLAGS, ...)", fd_flagged);
> +	}
> +
> +	memset(&enable, 0, sizeof(enable));
> +	enable.version = 1;
> +	enable.hash_algorithm = hash_algorithms[0];
> +	enable.block_size = 4096;
> +	enable.salt_size = 0;
> +	enable.salt_ptr = (intptr_t)NULL;
> +	enable.sig_size = 0;
> +	enable.sig_ptr = (intptr_t)NULL;
> +
> +	ret = ioctl(fd_flagged, FS_IOC_ENABLE_VERITY, &enable);
> +	if (ret < 0) {
> +		if (errno == EOPNOTSUPP) {
> +			tst_brk(TCONF,
> +				"fs-verity is not supported on the file system or by the kernel");
> +		}
> +		tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_ENABLE_VERITY) failed", fd_flagged);
> +	}
> +
> +	ret = ioctl(fd_flagged, FS_IOC_GETFLAGS, &attr);
> +	if ((ret == 0) && !(attr & FS_VERITY_FL))
> +		tst_res(TFAIL, "%i: fs-verity enabled but FS_VERITY_FL bit not set", fd_flagged);
> +
> +	clear_flags = 1;
> +}
> +
> +static void setup(void)
> +{
> +	const char *fs_opts[] = {"-O verity", NULL};
> +
> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);

Why can't we use the .format_device in tst_test structure along with
dev_fs_opts?

> +	TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL));
> +	if (TST_RET) {
> +		if (TST_RET == -1) {
> +			tst_res(TFAIL | TERRNO, "mount(%s, %s, %s) failed. "
> +				"Loop device does not support fs-verity, pls export LTP_DEV.",
> +					tst_device->dev, MNTPOINT, tst_device->fs_type);

You should really check the TST_ERR here as well. I guess that you get
EINVAL in case that kernel does not support fs-verity?

	if (TST_RET) {
		if (TST_ERR == EINVAL)
			tst_brk(TCONF, "fs-verity not supported on loopdev");

		tst_brk(TBROK | TERRNO "mount() failed with %ld", TST_RET);
	}

Also this code actually uses tst_brk() which exits the test if the mount
failed.


> +		} else {
> +			tst_res(TFAIL | TERRNO, "Invalid mount(%s, %s, %s) return value %ld",
> +				tst_device->dev, MNTPOINT, tst_device->fs_type, TST_RET);
> +		}
> +	}
> +	mount_flag = 1;
> +
> +	fd_flagged = SAFE_OPEN(TESTFILE_FLAGGED, O_RDWR | O_CREAT, 0664);
> +	memset(wrbuf, 'a', 5);
> +	SAFE_WRITE(1, fd_flagged, wrbuf, 5);
> +	SAFE_CLOSE(fd_flagged);

Just use SAFE_FILE_PRINTF() instead.

> +	flag_setup();
> +}
> +
> +static void cleanup(void)
> +{
> +	int attr;
> +
> +	if (clear_flags) {
> +		SAFE_IOCTL(fd_flagged, FS_IOC_GETFLAGS, &attr);
> +		attr &= ~FS_VERITY_FL;
> +		SAFE_IOCTL(fd_flagged, FS_IOC_SETFLAGS, &attr);
> +	}

Is there a reason to clear the flags here? Does that prevent the
MNTPOINT from being unmounted? If not we can remove this piece of code
and also close fd_flagged at the end of the flag_setup() function.

> +	if (fd_flagged > 0)
> +		SAFE_CLOSE(fd_flagged);
> +	if (fd_unflagged > 0)
> +		SAFE_CLOSE(fd_unflagged);
> +
> +	if (mount_flag)
> +		tst_umount(MNTPOINT);
> +}
> +
> +static struct tst_test test = {
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_device = 1,
> +	.dev_fs_type = "ext4",
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_FS_VERITY",
> +		NULL
> +	},
> +	.needs_cmds = (const char *[]) {
> +		"mkfs.ext4 >= 1.45.2",
> +		NULL
> +	}
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
