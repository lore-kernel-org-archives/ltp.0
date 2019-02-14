From: Sumit Garg <sumit.garg@linaro.org>
Date: Thu, 14 Feb 2019 17:17:06 +0530
Subject: [LTP] [PATCH] syscalls: add syscall syncfs test
In-Reply-To: <5C65517C.6050101@cn.fujitsu.com>
References: <1550137891-19991-1-git-send-email-sumit.garg@linaro.org>
 <5C65517C.6050101@cn.fujitsu.com>
Message-ID: <CAFA6WYMwUKE5FHEeJJBMcm3Ua2pGZ-Jq2k6D2oJfHgv5EBYyfA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

Hi Xiao,

Thanks for your review comments.

On Thu, 14 Feb 2019 at 17:01, Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
>
> Hi Sumit,
>
> On 2019/02/14 17:51, Sumit Garg wrote:
> > syncfs01 tests to sync filesystem having large dirty file pages to block
> > device. Also, it tests all supported filesystems on a test block device.
> >
> > Signed-off-by: Sumit Garg<sumit.garg@linaro.org>
> > ---
> >
> > Fixes: https://github.com/linux-test-project/ltp/issues/294
> >
> >   runtest/syscalls                            |   2 +
> >   testcases/kernel/syscalls/syncfs/.gitignore |   1 +
> >   testcases/kernel/syscalls/syncfs/Makefile   |   8 ++
> >   testcases/kernel/syscalls/syncfs/syncfs01.c | 110 +++++++++++++++++++=
+++++++++
> >   4 files changed, 121 insertions(+)
> >   create mode 100644 testcases/kernel/syscalls/syncfs/.gitignore
> >   create mode 100644 testcases/kernel/syscalls/syncfs/Makefile
> >   create mode 100644 testcases/kernel/syscalls/syncfs/syncfs01.c
> >
> > diff --git a/runtest/syscalls b/runtest/syscalls
> > index 668c87c..9442740 100644
> > --- a/runtest/syscalls
> > +++ b/runtest/syscalls
> > @@ -1346,6 +1346,8 @@ symlinkat01 symlinkat01
> >   sync01 sync01
> >   sync02 sync02
> >
> > +syncfs01 syncfs01
> > +
> >   #testcases for sync_file_range
> >   sync_file_range01 sync_file_range01
> >
> > diff --git a/testcases/kernel/syscalls/syncfs/.gitignore b/testcases/ke=
rnel/syscalls/syncfs/.gitignore
> > new file mode 100644
> > index 0000000..6066295
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/syncfs/.gitignore
> > @@ -0,0 +1 @@
> > +syncfs01
> > diff --git a/testcases/kernel/syscalls/syncfs/Makefile b/testcases/kern=
el/syscalls/syncfs/Makefile
> > new file mode 100644
> > index 0000000..3e6c2f4
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/syncfs/Makefile
> > @@ -0,0 +1,8 @@
> > +# Copyright (c) 2019 - Linaro Limited. All rights reserved.
> > +# SPDX-License-Identifier: GPL-2.0-or-later
> > +
> > +top_srcdir             ?=3D ../../../..
> > +
> > +include $(top_srcdir)/include/mk/testcases.mk
> > +
> > +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> > diff --git a/testcases/kernel/syscalls/syncfs/syncfs01.c b/testcases/ke=
rnel/syscalls/syncfs/syncfs01.c
> > new file mode 100644
> > index 0000000..35a8ae8
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/syncfs/syncfs01.c
> > @@ -0,0 +1,110 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2019 Linaro Limited. All rights reserved.
> > + * Author: Sumit Garg<sumit.garg@linaro.org>
> > + */
> > +
> > +/*
> > + * Test syncfs
> > + *
> > + * It basically tests syncfs() to sync filesystem having large dirty f=
ile
> > + * pages to block device. Also, it tests all supported filesystems on =
a test
> > + * block device.
> > + */
> > +
> > +#define _GNU_SOURCE
> > +#include<stdlib.h>
> > +#include<stdio.h>
> > +#include<sys/types.h>
> > +#include<sys/wait.h>
>
> Unused <sys/wait.h> ?
>

Ok, will remove it.

> > +#include "tst_test.h"
> > +#include "lapi/fs.h"
> > +#include "lapi/stat.h"
> > +
> > +#define MNTPOINT             "mnt_point"
> > +#define TST_FILE             MNTPOINT"/test"
> > +#define TST_FILE_SIZE_MB     32
> > +#define SIZE_MB                      (1024*1024)
> > +#define MODE                 0644
> > +
> > +static char dev_stat_path[1024];
> > +static char *buffer;
> > +static int fd;
> > +
> > +static void verify_syncfs(void)
> > +{
> > +     char nwrite_sec_val[BUFSIZ];
> > +     int counter;
> > +     unsigned long prev_write_sec =3D 0, write_sec =3D 0;
> > +
> > +     SAFE_FILE_SCANF(dev_stat_path, "%*s %*s %*s %*s %*s %*s %s",
> > +                     nwrite_sec_val);
> > +
> > +     prev_write_sec =3D SAFE_STRTOUL(nwrite_sec_val, 0, ULONG_MAX);
> > +
> > +     fd =3D  SAFE_OPEN(TST_FILE, O_RDWR|O_CREAT, MODE);
> > +
> > +     /* Filling the test file */
> > +     for (counter =3D 0; counter<  TST_FILE_SIZE_MB; counter++)
> > +             SAFE_WRITE(1, fd, buffer, SIZE_MB);
> > +
> > +     TEST(syncfs(fd));
> > +     if (TST_RET !=3D 0)
> > +             tst_brk(TFAIL | TTERRNO, "syncfs(fd) failed");
> > +
> > +     SAFE_FILE_SCANF(dev_stat_path, "%*s %*s %*s %*s %*s %*s %s",
> > +                     nwrite_sec_val);
> > +
> > +     write_sec =3D SAFE_STRTOUL(nwrite_sec_val, 0, ULONG_MAX);
> > +
> > +     if ((write_sec - prev_write_sec) * 512>=3D
> > +         (TST_FILE_SIZE_MB * SIZE_MB))
> > +             tst_res(TPASS, "Test filesystem synced to device");
> > +     else
> > +             tst_res(TFAIL, "Failed to sync test filesystem to device"=
);
> > +
> > +     SAFE_CLOSE(fd);
> > +}
> > +
> > +static void setup(void)
> > +{
> > +     const char *dev;
> > +     struct stat st;
> > +
> > +     dev =3D tst_device->dev;
> > +     if (!dev)
> > +             tst_brk(TCONF, "Failed to acquire test device");
>
> Libary will do this check, so we can remove it.
> Please see the following code at tst_test.c:
> --------------------------------------------------------------------------
>      if (tst_test->needs_device && !mntpoint_mounted) {
>          tdev.dev =3D tst_acquire_device_(NULL, tst_test->dev_min_size);
>
>          if (!tdev.dev)
>              tst_brk(TCONF, "Failed to acquire device");
> --------------------------------------------------------------------------
>

Ok will remove this check.

> > +
> > +     snprintf(dev_stat_path, sizeof(dev_stat_path), "/sys/block/%s/sta=
t",
> > +              strrchr(dev, '/') + 1);
>
> Use tst_device->dev directly.
>

Ok.

> > +
> > +     if (stat(dev_stat_path,&st) !=3D 0)
> > +             tst_brk(TCONF, "Test device stat file: %s not found",
> > +                     dev_stat_path);
> > +
> > +     buffer =3D SAFE_MALLOC(SIZE_MB);
> > +
> > +     memset(buffer, 0, SIZE_MB);
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +     if (buffer)
> > +             free(buffer);
> > +
> > +     if (fd>  0)
> > +             SAFE_CLOSE(fd);
> > +}
> > +
> > +static struct tst_test test =3D {
> > +     .needs_root =3D 1,
> > +     .needs_device =3D 1,
> > +     .format_device =3D 1,
> > +     .mount_device =3D 1,
>
> It is enough to only set '.mount_device', because '.mount_device'
> implies '.needs_device' and '.format_device'
> Please see doc/test-writing-guidelines.txt:
> ------------------------------------------
> If '.mount_device' is set, the device is mounted at '.mntpoint' which is
> used
> to pass a directory name that will be created and used as mount destinati=
on.
> You can pass additional flags and data to the mount command via '.mnt_fla=
gs'
> and '.mnt_data' pointers. Note that '.mount_device' implies '.needs_devic=
e'
> and '.format_device' so there is no need to set the later two.
> ------------------------------------------

Yeah I missed this. Will remove .needs_device and .format_device flags.

> > +     .all_filesystems =3D 1,
> > +     .dev_min_size =3D TST_FILE_SIZE_MB,
> It seems that libary sets the minimal device size to 256M by default, so
> the smaller value will be replaced with 256M.
> Do we have to set the minimal device size to 32M=EF=BC=9F
>

Yes I saw minimal default size to be 256M. I kept 32M here just for
clarity of minimal requirement for this test case. BTW, if you think
it is unnecessary to keep it then I will remove it.

-Sumit

> Best Regards,
> Xiao Yang
> > +     .mntpoint =3D MNTPOINT,
> > +     .setup =3D setup,
> > +     .cleanup =3D cleanup,
> > +     .test_all =3D verify_syncfs,
> > +};
>
>
>
