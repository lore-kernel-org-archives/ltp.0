From: Sumit Garg <sumit.garg@linaro.org>
Date: Wed, 20 Feb 2019 14:04:01 +0530
Subject: [LTP] [PATCH v3 7/7] syscalls/sync_file_range: add sync device
	test-case
In-Reply-To: <20190219142058.GF32031@rei.lan>
References: <1550568500-10871-1-git-send-email-sumit.garg@linaro.org>
 <1550568500-10871-8-git-send-email-sumit.garg@linaro.org>
 <20190219142058.GF32031@rei.lan>
Message-ID: <CAFA6WYNMD=8UUvqKByZOTq5ZDH_6HwQerO=6=o7wYV+CmiGBfQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 19 Feb 2019 at 19:51, Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > sync_file_range02 tests to sync file data range having large dirty file
> > pages to block device. Also, it tests all supported filesystems on a
> > test block device.
> >
> > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > ---
> >  runtest/syscalls                                   |  1 +
> >  .../kernel/syscalls/sync_file_range/.gitignore     |  1 +
> >  .../syscalls/sync_file_range/sync_file_range02.c   | 70 ++++++++++++++++++++++
> >  3 files changed, 72 insertions(+)
> >  create mode 100644 testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
> >
> > diff --git a/runtest/syscalls b/runtest/syscalls
> > index aaad651..70d3561 100644
> > --- a/runtest/syscalls
> > +++ b/runtest/syscalls
> > @@ -1353,6 +1353,7 @@ syncfs01 syncfs01
> >
> >  #testcases for sync_file_range
> >  sync_file_range01 sync_file_range01
> > +sync_file_range02 sync_file_range02
> >
> >  syscall01 syscall01
> >
> > diff --git a/testcases/kernel/syscalls/sync_file_range/.gitignore b/testcases/kernel/syscalls/sync_file_range/.gitignore
> > index 3f6bd75..e6485f7 100644
> > --- a/testcases/kernel/syscalls/sync_file_range/.gitignore
> > +++ b/testcases/kernel/syscalls/sync_file_range/.gitignore
> > @@ -1 +1,2 @@
> >  /sync_file_range01
> > +/sync_file_range02
> > diff --git a/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
> > new file mode 100644
> > index 0000000..fb7a5f7
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/sync_file_range/sync_file_range02.c
> > @@ -0,0 +1,70 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2019 Linaro Limited. All rights reserved.
> > + * Author: Sumit Garg <sumit.garg@linaro.org>
> > + */
> > +
> > +/*
> > + * sync_file_range02
> > + *
> > + * It basically tests sync_file_range() to sync test file range having large
> > + * dirty file pages to block device. Also, it tests all supported filesystems
> > + * on a test block device.
> > + */
> > +
> > +#define _GNU_SOURCE
> > +#include <errno.h>
> > +#include <stdlib.h>
> > +#include <stdio.h>
> > +#include <sys/types.h>
> > +#include "tst_sync_device.h"
> > +#include "tst_test.h"
> > +#include "lapi/sync_file_range.h"
> > +#include "check_sync_file_range.h"
> > +
> > +#define MNTPOINT             "mnt_point"
> > +#define TST_FILE             MNTPOINT"/test"
> > +#define TST_FILE_SIZE_MB     32
> > +#define SIZE_MB                      (1024*1024)
> > +
> > +static void verify_sync_file_range(void)
> > +{
> > +     int fd;
> > +
> > +     fd = tst_sync_device_write(TST_FILE, TST_FILE_SIZE_MB);
> > +
> > +     TEST(sync_file_range(fd, 0, TST_FILE_SIZE_MB * SIZE_MB,
> > +                          SYNC_FILE_RANGE_WAIT_BEFORE |
> > +                          SYNC_FILE_RANGE_WRITE |
> > +                          SYNC_FILE_RANGE_WAIT_AFTER));
> > +     if (TST_RET != 0)
> > +             tst_brk(TFAIL | TTERRNO, "sync_file_range() failed");
> > +
> > +     if (tst_sync_device_check(TST_FILE_SIZE_MB))
> > +             tst_res(TPASS, "Test file range synced to device");
> > +     else
> > +             tst_res(TFAIL, "Failed to sync test file range to device");
> > +}
> > +
> > +static void setup(void)
> > +{
> > +     tst_sync_device_init(tst_device->dev);
> > +}
> > +
> > +static void cleanup(void)
> > +{
> > +     if (!check_sync_file_range())
> > +             tst_brk(TCONF, "sync_file_range() not supported");
>
> This check is supposed to be in the test setup, right?
>

Ah, right. I will correct it.

-Sumit

> > +     tst_sync_device_cleanup();
> > +}
> > +
> > +static struct tst_test test = {
> > +     .needs_root = 1,
> > +     .mount_device = 1,
> > +     .all_filesystems = 1,
> > +     .mntpoint = MNTPOINT,
> > +     .setup = setup,
> > +     .cleanup = cleanup,
> > +     .test_all = verify_sync_file_range,
> > +};
> > --
> > 2.7.4
> >
>
> --
> Cyril Hrubis
> chrubis@suse.cz
