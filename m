Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B6BC433FE
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 13:55:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB6023C973F
	for <ltp@archiver.kernel.org>; Thu, 27 Jan 2022 14:55:47 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 470013C96EC
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 14:55:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6536014004EF
 for <ltp@lists.linux.it>; Thu, 27 Jan 2022 14:55:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8C7D71F3A9;
 Thu, 27 Jan 2022 13:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643291736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s6Rjnh8bI0x4yvC8IPGuJQ1oJZi0qNVglGnDAZwSDKg=;
 b=cbpzhugNAMWTWQzgg0aYPhX349IyWRMMqc/+3kjmCrYBIfgzGqZLstDvNfAdM7dTmDiVKk
 DJZpmJ5250bZ0Z9U1yh3yKbL3yBMStu/td9BG2MFkEcskMiNYsHtrNPJRDZsGWtOg/GFvL
 DCkVEolM2or1PvMSH2zlbga0QCDY1DM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643291736;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=s6Rjnh8bI0x4yvC8IPGuJQ1oJZi0qNVglGnDAZwSDKg=;
 b=+tAxGu0AKc1t2FQC3shc3vx1P03Mkx8nEjiCNbTHPcIihnTcwiB74qgf+SZUJSgy+JZF5+
 3E3lvIK39FTY05BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 75E8413BE5;
 Thu, 27 Jan 2022 13:55:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pULRGlik8mHTLgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 27 Jan 2022 13:55:36 +0000
Date: Thu, 27 Jan 2022 14:57:27 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Dai Shili <daisl.fnst@fujitsu.com>
Message-ID: <YfKkxx1y4Ctgn0IX@yuki>
References: <Ye6sWQ/kRf1V1FWy@yuki>
 <1643166057-25026-1-git-send-email-daisl.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1643166057-25026-1-git-send-email-daisl.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/statx09: Add new test
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
> new file mode 100644
> index 0000000..0125fa8
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

I haven't caught that in the previous review, however in userspace we
are use the stdint types so this should:

* include stdint.h instead of linux/types.h
* replace __u32 with uint32_t
* replace __u64 with uint64_t

> +#ifndef FS_IOC_ENABLE_VERITY
> +# define FS_IOC_ENABLE_VERITY    _IOW('f', 133, struct fsverity_enable_arg)
> +#endif
> +
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
> index 0000000..76716bf
> --- /dev/null
> +++ b/m4/ltp-fsverity.m4
> @@ -0,0 +1,10 @@
> +dnl SPDX-License-Identifier: GPL-2.0-or-later
> +dnl Copyright (c) 2022 Fujitsu Ltd.
> +dnl Author: Dai Shili <daisl.fnst@cfujitsu.com>
> +
> +AC_DEFUN([LTP_CHECK_FSVERITY],[
> +	AC_CHECK_HEADERS([linux/fsverity.h], [have_fsverity=yes], [AC_MSG_WARN(missing linux/fsverity.h header)])
> +	if test "x$have_fsverity" = "xyes"; then
> +		AC_CHECK_TYPES(struct fsverity_enable_arg,,,[#include <linux/fsverity.h>])
> +	fi
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
> index 0000000..8fc3703
> --- /dev/null
> +++ b/testcases/kernel/syscalls/statx/statx09.c
> @@ -0,0 +1,172 @@
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

We have the CONFIG_FS_VERITY and e2fsprogs requirements in the tst_test
structure so I wouldn't repeat them here.

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
> +#define TESTFILE_FLAGGED MNTPOINT"/test_file3"
> +#define TESTFILE_UNFLAGGED MNTPOINT"/test_file4"
> +
> +static int fd_flagged, fd_unflagged;
> +static int mount_flag;
> +
> +static const uint32_t hash_algorithms[] = {
> +	FS_VERITY_HASH_ALG_SHA256,
> +};
> +
> +static void test_flagged(void)
> +{
> +	struct statx buf;
> +
> +	TST_EXP_PASS(statx(AT_FDCWD, TESTFILE_FLAGGED, 0, 0, &buf),
> +		"statx(AT_FDCWD, %s, 0, 0, &buf)", TESTFILE_FLAGGED);
> +
> +	if (buf.stx_attributes & STATX_ATTR_VERITY)
> +		tst_res(TPASS, "STATX_ATTR_VERITY flag is set: (%"PRIu64") ", buf.stx_attributes);

The stx_attributes is actually incompatible with PRIu64 so there should
be a cast:

@@ -51,7 +50,7 @@ static void test_flagged(void)
                "statx(AT_FDCWD, %s, 0, 0, &buf)", TESTFILE_FLAGGED);

        if (buf.stx_attributes & STATX_ATTR_VERITY)
-               tst_res(TPASS, "STATX_ATTR_VERITY flag is set: (%"PRIu64") ", buf.stx_attributes);
+               tst_res(TPASS, "STATX_ATTR_VERITY flag is set: (%"PRIu64") ", (uint64_t)buf.stx_attributes);
        else
                tst_res(TFAIL, "STATX_ATTR_VERITY flag is not set");
 }


> +	else
> +		tst_res(TFAIL, "STATX_ATTR_VERITY flag is not set");
> +}
> +
> +static void test_unflagged(void)
> +{
> +	struct statx buf;
> +
> +	TST_EXP_PASS(statx(AT_FDCWD, TESTFILE_UNFLAGGED, 0, 0, &buf),
> +		"statx(AT_FDCWD, %s, 0, 0, &buf)", TESTFILE_UNFLAGGED);
> +
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
> +
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
> +	SAFE_CLOSE(fd_flagged);
> +}
> +
> +static void setup(void)
> +{
> +	TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL));
> +	if (TST_RET) {
> +		if (TST_ERR == EINVAL)
> +			tst_brk(TCONF, "fs-verity not supported on loopdev");
> +
> +		tst_brk(TBROK | TERRNO, "mount() failed with %ld", TST_RET);
> +	}
> +	mount_flag = 1;
> +
> +	fd_unflagged = SAFE_OPEN(TESTFILE_UNFLAGGED, O_RDWR | O_CREAT, 0664);
> +	fd_flagged = SAFE_OPEN(TESTFILE_FLAGGED, O_RDWR | O_CREAT, 0664);
> +	SAFE_FILE_PRINTF(TESTFILE_FLAGGED, "a");

There is no reason to actually open the file descriptors here when the
file is created with SAFE_FILE_PRINTF().

So the whole test can be simplified as:

@@ -36,7 +36,6 @@
 #define TESTFILE_FLAGGED MNTPOINT"/test_file3"
 #define TESTFILE_UNFLAGGED MNTPOINT"/test_file4"

-static int fd_flagged, fd_unflagged;
 static int mount_flag;

 static const uint32_t hash_algorithms[] = {

@@ -85,15 +84,16 @@ static void flag_setup(void)
 {
        int attr, ret;
        struct fsverity_enable_arg enable;
+       int fd;

-       fd_flagged = SAFE_OPEN(TESTFILE_FLAGGED, O_RDONLY, 0664);
+       fd = SAFE_OPEN(TESTFILE_FLAGGED, O_RDONLY, 0664);

-       ret = ioctl(fd_flagged, FS_IOC_GETFLAGS, &attr);
+       ret = ioctl(fd, FS_IOC_GETFLAGS, &attr);
        if (ret < 0) {
                if (errno == ENOTTY)
                        tst_brk(TCONF | TERRNO, "FS_IOC_GETFLAGS not supported");

-               tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_GETFLAGS, ...)", fd_flagged);
+               tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_GETFLAGS, ...)", fd);
        }

        memset(&enable, 0, sizeof(enable));
@@ -105,20 +105,20 @@ static void flag_setup(void)
        enable.sig_size = 0;
        enable.sig_ptr = (intptr_t)NULL;

-       ret = ioctl(fd_flagged, FS_IOC_ENABLE_VERITY, &enable);
+       ret = ioctl(fd, FS_IOC_ENABLE_VERITY, &enable);
        if (ret < 0) {
                if (errno == EOPNOTSUPP) {
                        tst_brk(TCONF,
                                "fs-verity is not supported on the file system or by the kernel");
                }
-               tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_ENABLE_VERITY) failed", fd_flagged);
+               tst_brk(TBROK | TERRNO, "ioctl(%i, FS_IOC_ENABLE_VERITY) failed", fd);
        }

-       ret = ioctl(fd_flagged, FS_IOC_GETFLAGS, &attr);
+       ret = ioctl(fd, FS_IOC_GETFLAGS, &attr);
        if ((ret == 0) && !(attr & FS_VERITY_FL))
-               tst_res(TFAIL, "%i: fs-verity enabled but FS_VERITY_FL bit not set", fd_flagged);
+               tst_res(TFAIL, "%i: fs-verity enabled but FS_VERITY_FL bit not set", fd);

-       SAFE_CLOSE(fd_flagged);
+       SAFE_CLOSE(fd);
 }

 static void setup(void)
@@ -132,21 +132,14 @@ static void setup(void)
        }
        mount_flag = 1;

-       fd_unflagged = SAFE_OPEN(TESTFILE_UNFLAGGED, O_RDWR | O_CREAT, 0664);
-       fd_flagged = SAFE_OPEN(TESTFILE_FLAGGED, O_RDWR | O_CREAT, 0664);
        SAFE_FILE_PRINTF(TESTFILE_FLAGGED, "a");
-       SAFE_CLOSE(fd_flagged);
+       SAFE_FILE_PRINTF(TESTFILE_UNFLAGGED, "a");

        flag_setup();
 }

 static void cleanup(void)
 {
-       if (fd_flagged > 0)
-               SAFE_CLOSE(fd_flagged);
-       if (fd_unflagged > 0)
-               SAFE_CLOSE(fd_unflagged);
-
        if (mount_flag)
                tst_umount(MNTPOINT);
 }

> +	SAFE_CLOSE(fd_flagged);
> +
> +	flag_setup();
> +}
> +
> +static void cleanup(void)
> +{
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
> +	.format_device = 1,
> +	.dev_fs_type = "ext4",
> +	.dev_fs_opts = (const char *const []){"-O verity", NULL},
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

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
