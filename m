From: Li Wang <liwang@redhat.com>
Date: Sun, 16 Feb 2020 15:32:47 +0800
Subject: [LTP] [PATCH v6 2/2] syscalls/fsmount01: Add test for new mount
 API v5.2
In-Reply-To: <20200207144105.19947-2-pvorel@suse.cz>
References: <20200207144105.19947-1-pvorel@suse.cz>
 <20200207144105.19947-2-pvorel@suse.cz>
Message-ID: <CAEemH2f0db1i7Tpg-4jqa5h5j9KZpH+d4aRg-M3Xn3Mw9NU1eA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

[CC Viresh Kumar]

Patch v6 looks almost good besides tiny issues:

I don't like the commit summary with kernel version number, can we just
note as:
    "syscalls/fsmount01: Add test for fsmount series API"?

On Fri, Feb 7, 2020 at 10:41 PM Petr Vorel <pvorel@suse.cz> wrote:

> From: Zorro Lang <zlang@redhat.com>
>
> Add basic tests tests for new mount API from kernel v5.2.
> Testing mount and umount filesystems with fsopen(), fsconfig(),
> fsmount() and move_mount().
>
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> Reported-by: Cyril Hrubis <chrubis@suse.cz>
> [ pvorel: cleanup autotools and other fixes ]
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  configure.ac                                  |  4 +
>  include/lapi/newmount.h                       | 95 +++++++++++++++++++
>  include/lapi/syscalls/powerpc64.in            |  4 +
>

Is there any reason why only add syscall num for ppc64?


>
> diff --git a/configure.ac b/configure.ac
> index df4e8c832..05b7d0a72 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -80,6 +80,9 @@ AC_CHECK_FUNCS([ \
>      execveat \
>      fallocate \
>      fchownat \
> +    fsconfig \
> +    fsmount \
> +    fsopen \
>      fstatat \
>      getdents \
>      getdents64 \
> @@ -88,6 +91,7 @@ AC_CHECK_FUNCS([ \
>      mkdirat \
>      mknodat \
>      modify_ldt \
> +    move_mount \
>      name_to_handle_at \
>      openat \
>      pidfd_open \
> diff --git a/include/lapi/newmount.h b/include/lapi/newmount.h
> new file mode 100644
> index 000000000..d4efdb300
> --- /dev/null
> +++ b/include/lapi/newmount.h
>

Maybe rename to fsmount.h is better? Now we think it new since mainline
v5.2 is new to us, one year later it probably not new actually, to use a
name can indicate the functionality is wiser I guess.

BTW, I like the way Viresh Kumar gives in his fsmount.h, it looks more tidy
and clean.
http://lists.linux.it/pipermail/ltp/2020-February/015413.html



> --- /dev/null
> +++ b/testcases/kernel/syscalls/fsmount/fsmount01.c
> @@ -0,0 +1,94 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2019 Red Hat, Inc.  All rights reserved.
> + * Author: Zorro Lang <zlang@redhat.com>
> + *
> + * Use new mount API from v5.2 (fsopen(), fsconfig(), fsmount(),
> move_mount())
> + * to mount a filesystem without any specified mount options.
> + */
> +
> +#include <sys/mount.h>
> +
> +#include "tst_test.h"
> +#include "lapi/newmount.h"
> +#include "tst_safe_stdio.h"
> +
> +#define LINELENGTH 256
> +#define MNTPOINT "newmount_point"
> +static int sfd, mfd, is_mounted;
> +
> +static int ismount(char *mntpoint)
> +{
> +       int ret = 0;
> +       FILE *file;
> +       char line[LINELENGTH];
> +
> +       file = SAFE_FOPEN("/proc/mounts", "r");
> +
> +       while (fgets(line, sizeof(line), file)) {
> +               if (strstr(line, mntpoint) != NULL) {
> +                       ret = 1;
> +                       break;
> +               }
> +       }
> +       SAFE_FCLOSE(file);
> +       return ret;
> +}
> +
> +static void cleanup(void)
> +{
> +       if (is_mounted)
> +               SAFE_UMOUNT(MNTPOINT);
> +}
> +
> +static void test_newmount(void)
>

static void test_fsmount(void)? Or, static void run(void).


> +{
> +       TEST(fsopen(tst_device->fs_type, FSOPEN_CLOEXEC));
> +       if (TST_RET < 0)
> +               tst_brk(TBROK | TTERRNO, "fsopen %s", tst_device->fs_type);
> +       sfd = TST_RET;
> +       tst_res(TPASS, "fsopen %s", tst_device->fs_type);
> +
> +       TEST(fsconfig(sfd, FSCONFIG_SET_STRING, "source", tst_device->dev,
> 0));
> +       if (TST_RET < 0)
> +               tst_brk(TBROK | TTERRNO,
> +                       "fsconfig set source to %s", tst_device->dev);
> +       tst_res(TPASS, "fsconfig set source to %s", tst_device->dev);
> +
> +
> +       TEST(fsconfig(sfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0));
> +       if (TST_RET < 0)
> +               tst_brk(TBROK | TTERRNO, "fsconfig create superblock");
> +       tst_res(TPASS, "fsconfig create superblock");
> +
> +       TEST(fsmount(sfd, FSMOUNT_CLOEXEC, 0));
> +       if (TST_RET < 0)
> +               tst_brk(TBROK | TTERRNO, "fsmount");
> +       mfd = TST_RET;
> +       tst_res(TPASS, "fsmount");
> +       SAFE_CLOSE(sfd);
> +
> +       TEST(move_mount(mfd, "", AT_FDCWD, MNTPOINT,
> MOVE_MOUNT_F_EMPTY_PATH));
> +       if (TST_RET < 0)
> +               tst_brk(TBROK | TTERRNO, "move_mount attach to mount
> point");
> +       is_mounted = 1;
> +       tst_res(TPASS, "move_mount attach to mount point");
> +       SAFE_CLOSE(mfd);
> +
> +       if (ismount(MNTPOINT)) {
> +               tst_res(TPASS, "new mount API from v5.2 works");
>

Can we avoid appearance the v5.2? I guess many Enterprise Linux
Distributions will backport the fsmount() series API, v5.2 in test log
looks strange if the kernel is older than it.



> +               SAFE_UMOUNT(MNTPOINT);
> +               is_mounted = 0;
> +       } else
> +               tst_res(TFAIL, "new mount API from v5.2 works");
>
no v5.2


> +}
> +
> +static struct tst_test test = {
> +       .test_all = test_newmount,
> +       .cleanup = cleanup,
> +       .needs_root = 1,
> +       .mntpoint = MNTPOINT,
> +       .format_device = 1,
> +       .all_filesystems = 1,
> +       .dev_fs_flags = TST_FS_SKIP_FUSE,
> +};
> --
> 2.24.1
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200216/3ca8f298/attachment.htm>
