From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 16 Jan 2020 12:52:27 +0100
Subject: [LTP] [PATCH v4] syscalls/newmount: new test case for new mount
 API
In-Reply-To: <20200116075633.29752-1-zlang@redhat.com>
References: <20200116075633.29752-1-zlang@redhat.com>
Message-ID: <20200116115227.GA19435@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zorro,

> Linux supports new mount syscalls from 5.2, so add new test cases
> to cover these new API. This newmount01 case make sure new API -
> fsopen(), fsconfig(), fsmount() and move_mount() can mount a
> filesystem, then can be unmounted.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Hi,

> V4 made a few changes as https://patchwork.ozlabs.org/patch/1206389/#2341154

> And as I said in https://patchwork.ozlabs.org/comment/2342190, the
> TST_FS_SKIP_FUSE flag won't help to skip linux kernel internal ntfs and
> vfat test for this case.
+1

...
> --- /dev/null
> +++ b/m4/ltp-newmount.m4
> @@ -0,0 +1,10 @@
> +dnl SPDX-License-Identifier: GPL-2.0-or-later
> +dnl Copyright (C) 2019 Red Hat, Inc. All Rights Reserved.
> +
> +AC_DEFUN([LTP_CHECK_NEWMOUNT],[
> +AC_CHECK_FUNCS(fsopen,,)
> +AC_CHECK_FUNCS(fsconfig,,)
> +AC_CHECK_FUNCS(fsmount,,)
> +AC_CHECK_FUNCS(move_mount,,)
> +AC_CHECK_HEADER(sys/mount.h,,,)
> +])
This should have been in configure.ac as I reported, but that's ok
(can be fixed by person who merges this).

...
> +static struct tst_test test = {
> +	.test_all	= test_newmount,
> +	.cleanup	= cleanup,
> +	.needs_root	= 1,
> +	.mntpoint	= MNTPOINT,
> +	.format_device	= 1,
> +	.all_filesystems = 1,
> +	.dev_fs_flags	= TST_FS_SKIP_FUSE,
OK, I was wrong, as you found in [1], test shouldn't have .dev_fs_flags   = TST_FS_SKIP_FUSE
(again, can be removed during merge).

I'm just trying to find whether failure caused by CONFIG_NTFS_FS not set,
but mkfs.ntfs installed is a LTP issue or mkfs.ntfs or a kernel issue.

tst_supported_fs_types.c:60: INFO: Kernel supports vfat
tst_supported_fs_types.c:44: INFO: mkfs.vfat does exist
tst_supported_fs_types.c:85: INFO: Filesystem exfat is not supported
tst_supported_fs_types.c:95: INFO: FUSE does support ntfs
tst_supported_fs_types.c:44: INFO: mkfs.ntfs does exist
...
newmount01.c:60: PASS: fsopen vfat
newmount01.c:67: PASS: fsconfig set source to /dev/loop0
newmount01.c:75: PASS: fsconfig create superblock
newmount01.c:82: PASS: fsmount
newmount01.c:90: PASS: move_mount attach to mount point
newmount01.c:94: PASS: new mount works
tst_test.c:1278: INFO: Testing on ntfs
tst_mkfs.c:90: INFO: Formatting /dev/loop0 with ntfs opts='' extra opts=''
The partition start sector was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of sectors per track was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
The number of heads was not specified for /dev/loop0 and it could not be obtained automatically.  It has been set to 0.
To boot from a device, Windows needs the 'partition start sector', the 'sectors per track' and the 'number of heads' to be set.
Windows will not be able to boot from this device.
tst_test.c:1215: INFO: Timeout per run is 0h 05m 00s
newmount01.c:56: FAIL: fsopen ntfs: ENODEV (19)

Kind regards,
Petr

[1] https://lists.linux.it/pipermail/ltp/2020-January/015046.html
