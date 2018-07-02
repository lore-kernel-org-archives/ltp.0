From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 2 Jul 2018 13:46:06 +0300
Subject: [LTP] [PATCH] syscalls/execveat01: new test to verify execveat
	unlinked fd
In-Reply-To: <1530523133.30361.41.camel@mtkswgap22>
References: <1530523133.30361.41.camel@mtkswgap22>
Message-ID: <CAOQ4uxiougz6Zioz+nNx5juFqrU5S+SYM8ZmZ6zkktDsmMNn0Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jul 2, 2018 at 12:18 PM, Eddie.Horng <eddie.horng@mediatek.com> wrote:
>
> Exercise the execveat() syscall to verify an executable is opened then
> unlinked can be executed.
>
> The regression is introduced from 8db6c34f1dbc ("Introduce v3 namespaced
> file capabilities"). Overlayfs and possibly other networking filesystems
> unhash the dentry on unlink, fail on this test with above change.
>
> Signed-off-by: Eddie Horng <eddie.horng@mediatek.com>
> ---

Eddie,

The test looks good to me, minus a few nits below.

What I didn't get is whether or not this is reproducible with
with local file system (e.g. ext4).
From the discussion with Serge on the fix, I though he said that
reproducer does work on ext4, but maybe I misunderstood?
Because I do not understand why this would not reproduce with
local fs.
If indeed the reproducer works on local fs, I think the test should not
be overlayfs specific.


>  configure.ac                                       |   1 +
>  include/lapi/syscalls/arm.in                       |   1 +
>  include/lapi/syscalls/i386.in                      |   1 +
>  include/lapi/syscalls/s390.in                      |   1 +
>  include/lapi/syscalls/x86_64.in                    |   1 +
>  m4/ltp-execveat.m4                                 |  25 ++++
>  testcases/kernel/syscalls/execveat/.gitignore      |   2 +
>  testcases/kernel/syscalls/execveat/Makefile        |  23 ++++
>  testcases/kernel/syscalls/execveat/execveat.h      |  42 ++++++
>  testcases/kernel/syscalls/execveat/execveat01.c    | 142
> +++++++++++++++++++++
>  .../kernel/syscalls/execveat/execveat_child.c      |  32 +++++
>  11 files changed, 271 insertions(+)
>  create mode 100644 m4/ltp-execveat.m4
>  create mode 100644 testcases/kernel/syscalls/execveat/.gitignore
>  create mode 100644 testcases/kernel/syscalls/execveat/Makefile
>  create mode 100644 testcases/kernel/syscalls/execveat/execveat.h
>  create mode 100644 testcases/kernel/syscalls/execveat/execveat01.c
>  create mode 100644 testcases/kernel/syscalls/execveat/execveat_child.c
>
> diff --git a/configure.ac b/configure.ac
> index 9208f1c6c..373d72689 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -196,6 +196,7 @@ LTP_CHECK_FSTATAT
>  LTP_CHECK_MKNODAT
>  LTP_CHECK_READLINKAT
>  LTP_CHECK_OPENAT
> +LTP_CHECK_EXECVEAT
>  LTP_CHECK_RENAMEAT
>  LTP_CHECK_RENAMEAT2
>  LTP_CHECK_FALLOCATE
> diff --git a/include/lapi/syscalls/arm.in b/include/lapi/syscalls/arm.in
> index 71a4b713d..c44adcd7e 100644
> --- a/include/lapi/syscalls/arm.in
> +++ b/include/lapi/syscalls/arm.in
> @@ -340,4 +340,5 @@ sched_getattr (__NR_SYSCALL_BASE+381)
>  renameat2 (__NR_SYSCALL_BASE+382)
>  getrandom (__NR_SYSCALL_BASE+384)
>  memfd_create (__NR_SYSCALL_BASE+385)
> +execveat (__NR_SYSCALL_BASE+387)
>  copy_file_range (__NR_SYSCALL_BASE+391)
> diff --git a/include/lapi/syscalls/i386.in
> b/include/lapi/syscalls/i386.in
> index 0f9601472..19f0148fe 100644
> --- a/include/lapi/syscalls/i386.in
> +++ b/include/lapi/syscalls/i386.in
> @@ -340,4 +340,5 @@ sched_getattr 352
>  renameat2 354
>  getrandom 355
>  memfd_create 356
> +execveat 358
>  copy_file_range 377
> diff --git a/include/lapi/syscalls/s390.in
> b/include/lapi/syscalls/s390.in
> index 98c861f36..d95b282f8 100644
> --- a/include/lapi/syscalls/s390.in
> +++ b/include/lapi/syscalls/s390.in
> @@ -331,4 +331,5 @@ sched_getattr 346
>  renameat2 347
>  getrandom 349
>  memfd_create 350
> +execveat 354
>  copy_file_range 375
> diff --git a/include/lapi/syscalls/x86_64.in
> b/include/lapi/syscalls/x86_64.in
> index 89db79404..7907c3108 100644
> --- a/include/lapi/syscalls/x86_64.in
> +++ b/include/lapi/syscalls/x86_64.in
> @@ -307,4 +307,5 @@ sched_getattr 315
>  renameat2 316
>  getrandom 318
>  memfd_create 319
> +execveat 322
>  copy_file_range 326
> diff --git a/m4/ltp-execveat.m4 b/m4/ltp-execveat.m4
> new file mode 100644
> index 000000000..8cb614715
> --- /dev/null
> +++ b/m4/ltp-execveat.m4
> @@ -0,0 +1,25 @@
> +dnl
> +dnl Copyright (c) Linux Test Project, 2014
> +dnl
> +dnl This program is free software;  you can redistribute it and/or
> modify
> +dnl it under the terms of the GNU General Public License as published
> by
> +dnl the Free Software Foundation; either version 2 of the License, or
> +dnl (at your option) any later version.
> +dnl
> +dnl This program is distributed in the hope that it will be useful,
> +dnl but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +dnl the GNU General Public License for more details.
> +dnl
> +dnl You should have received a copy of the GNU General Public License
> +dnl along with this program;  if not, write to the Free Software
> +dnl Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> 02110-1301 USA
> +dnl
> +
> +dnl
> +dnl LTP_CHECK_EXECVEAT
> +dnl ----------------------------
> +dnl
> +AC_DEFUN([LTP_CHECK_EXECVEAT],[
> +AC_CHECK_FUNCS(execveat,,)
> +])
> diff --git a/testcases/kernel/syscalls/execveat/.gitignore
> b/testcases/kernel/syscalls/execveat/.gitignore
> new file mode 100644
> index 000000000..c0d418603
> --- /dev/null
> +++ b/testcases/kernel/syscalls/execveat/.gitignore
> @@ -0,0 +1,2 @@
> +/execveat01
> +/execveat_child
> diff --git a/testcases/kernel/syscalls/execveat/Makefile
> b/testcases/kernel/syscalls/execveat/Makefile
> new file mode 100644
> index 000000000..0bab6dc83
> --- /dev/null
> +++ b/testcases/kernel/syscalls/execveat/Makefile
> @@ -0,0 +1,23 @@
> +#
> +#  Copyright (C) 2018 MediaTek Inc.  All Rights Reserved.
> +#
> +#  This program is free software;  you can redistribute it and/or
> modify
> +#  it under the terms of the GNU General Public License as published by
> +#  the Free Software Foundation; either version 2 of the License, or
> +#  (at your option) any later version.
> +#
> +#  This program is distributed in the hope that it will be useful,
> +#  but WITHOUT ANY WARRANTY;  without even the implied warranty of
> +#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> +#  the GNU General Public License for more details.
> +#
> +#  You should have received a copy of the GNU General Public License
> +#  along with this program;  if not, write to the Free Software
> +#  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
> 02110-1301  USA
> +#
> +
> +top_srcdir             ?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/execveat/execveat.h
> b/testcases/kernel/syscalls/execveat/execveat.h
> new file mode 100644
> index 000000000..e87974d9c
> --- /dev/null
> +++ b/testcases/kernel/syscalls/execveat/execveat.h
> @@ -0,0 +1,42 @@
> +/*
> + * Copyright (C) 2018 MediaTek Inc.  All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> it
> + * under the terms of version 2 or any later of the GNU General Public
> License
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it
> is
> + * free of the rightful claim of any third person regarding
> infringement
> + * or the like.  Any license provided herein, whether implied or
> + * otherwise, applies only to this software file.  Patent licenses, if
> + * any, provided herein do not apply to combinations of this program
> with
> + * other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License
> along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + *
> + */
> +
> +#ifndef EXECVEAT_H
> +#define EXECVEAT_H
> +
> +#include <sys/types.h>
> +#include "config.h"
> +#include "lapi/syscalls.h"
> +
> +#if !defined(HAVE_EXECVEAT)
> +int execveat(int dirfd, const char *pathname,
> +             char *const argv[], char *const envp[],
> +             int flags)
> +{
> +       return tst_syscall(__NR_execveat, dirfd, pathname, argv, envp, flags);
> +}
> +#endif
> +
> +
> +#endif /* EXECVEAT_H */
> \ No newline at end of file
> diff --git a/testcases/kernel/syscalls/execveat/execveat01.c
> b/testcases/kernel/syscalls/execveat/execveat01.c
> new file mode 100644
> index 000000000..30e4d0cfa
> --- /dev/null
> +++ b/testcases/kernel/syscalls/execveat/execveat01.c
> @@ -0,0 +1,142 @@
> +/*
> + * Copyright (C) 2018 MediaTek Inc.  All Rights Reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> it
> + * under the terms of version 2 or any later of the GNU General Public
> License
> + * as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it would be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> + *
> + * Further, this software is distributed without any warranty that it
> is
> + * free of the rightful claim of any third person regarding
> infringement
> + * or the like.  Any license provided herein, whether implied or
> + * otherwise, applies only to this software file.  Patent licenses, if
> + * any, provided herein do not apply to combinations of this program
> with
> + * other software, or any other product whatsoever.
> + *
> + * You should have received a copy of the GNU General Public License
> along
> + * with this program; if not, write the Free Software Foundation, Inc.,
> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + *
> + * Started by Eddie Horng <eddie.horng@mediatek.com>
> + *
> + * DESCRIPTION
> + *     Check if an unlinked executable can run in overlayfs mount.
> + *     The regression is introduced from 8db6c34f1dbc ("Introduce v3
> + *     namespaced file capabilities"). in security/commoncap.c,
> + *     cap_inode_getsecurity() use d_find_alias() cause unhashed
> dentry
> + *     can't be found. The solution could use d_find_any_alias()
> instead of
> + *     d_find_alias().
> + *
> + *     From kernel 4.14, this case is expected fails, execveat shell
> + *     return EINVAL.
> + *
> + */
> +
> +#define _GNU_SOURCE
> +#include "config.h"
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/stat.h>
> +#include <sys/types.h>
> +#include <errno.h>
> +#include <string.h>
> +#include <sys/syscall.h>
> +#include <sys/mount.h>
> +#include <fcntl.h>
> +#include "tst_test.h"
> +#include "execveat.h"
> +
> +#define OVL_MNT "ovl"
> +#define TEST_APP "execveat_child"
> +#define TEST_FILE_PATH OVL_MNT"/"TEST_APP
> +
> +static int ovl_mounted;
> +
> +static void do_child(void)
> +{
> +       char *argv[2] = {TEST_APP, NULL};
> +       int fd;
> +
> +       fd = SAFE_OPEN(TEST_FILE_PATH, O_PATH);
> +       SAFE_UNLINK(TEST_FILE_PATH);
> +
> +       argv[0] = TEST_FILE_PATH;
> +       TEST(execveat(fd, "", argv, NULL, AT_EMPTY_PATH));
> +       if (TEST_ERRNO == ENOSYS) {
> +               tst_brk(TCONF,
> +                       "execveat is not supported in this kernel.");
> +       }
> +       else if (TEST_RETURN) {
> +               tst_res(TFAIL | TERRNO,
> +                           "execveat() returned unexpected errno");
> +               close(fd);
> +               exit(1);
> +       }
> +}
> +
> +static void verify_execveat(void)
> +{
> +       pid_t pid;
> +       int status;
> +
> +       pid = SAFE_FORK();
> +       if (pid == 0) {
> +               do_child();
> +       }
> +       else {
> +               SAFE_WAITPID(pid, &status, 0);
> +               if (status == 0)
> +                       tst_res(TPASS, "execveat() can run an unlinked executable");
> +       }
> +}
> +
> +static void setup(void)
> +{
> +       int ret;
> +       char path[PATH_MAX];
> +
> +       /* Setup an overlay mount with lower file */
> +       SAFE_MKDIR("lower", 0755);
> +       SAFE_MKDIR("upper", 0755);
> +       SAFE_MKDIR("work", 0755);
> +       SAFE_MKDIR(OVL_MNT, 0755);
> +       ret = mount("overlay", OVL_MNT, "overlay", 0,
> +                   "lowerdir=lower,upperdir=upper,workdir=work");
> +       if (ret < 0) {
> +               if (errno == ENODEV) {
> +                       tst_brk(TCONF,
> +                               "overlayfs is not configured in this kernel.");
> +               } else {
> +                       tst_brk(TBROK | TERRNO,
> +                               "overlayfs mount failed");
> +               }
> +       }
> +       ovl_mounted = 1;
> +
> +       if (tst_get_path(TEST_APP, path, sizeof(path))) {
> +               tst_brk(TBROK | TERRNO,
> +                        "Couldn't found "TEST_APP" binary in $PATH");
> +       }
> +
> +       SAFE_CP(path, TEST_FILE_PATH);

When you run ./execve01 -i 2 to run the test 2 times with the same
setup, test will fail because executable will have been deleted by first run,
so you need to move this CP to child_do.

> +}
> +
> +static void cleanup(void)
> +{
> +       if (ovl_mounted)
> +               SAFE_UMOUNT(OVL_MNT);
> +}
> +
> +static struct tst_test test = {
> +       .needs_root = 1,
> +       .needs_tmpdir = 1,
> +       .forks_child = 1,
> +       .setup = setup,
> +       .cleanup = cleanup,
> +       .test_all = verify_execveat,
> +};
> +
> diff --git a/testcases/kernel/syscalls/execveat/execveat_child.c
> b/testcases/kernel/syscalls/execveat/execveat_child.c
> new file mode 100644
> index 000000000..b2611dc9b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/execveat/execveat_child.c
> @@ -0,0 +1,32 @@
> +/*
> + *
> + *   Copyright (C) 2018 MediaTek Inc.  All Rights Reserved.

I hope IBM won't sue you for ripping off their Copyright from "Hello world!"
program execve_child.c. I bet you can find prior art if they do :-)

Cheers,
Amir.
