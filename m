From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 20 Jun 2019 17:43:35 +0300
Subject: [LTP] [PATCH v2] syscalls/ioctl08: add file deduplication
	testcases
In-Reply-To: <20190325101404.GA20297@dell5510>
References: <20190322133228.18901-1-camann@suse.com>
 <20190325101404.GA20297@dell5510>
Message-ID: <CAOQ4uxhT_BwUA=3sFdhdKfYhMeBqMPwe1sHvXR5jLaDu8u+2zQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Mar 25, 2019 at 12:14 PM Petr Vorel <pvorel@suse.cz> wrote:
>
> Hi Christian,
>
> > This adds tests for the ioctl request FIDEDUPERANGE
> > on a btrfs device.
>
> > These tests set the contents of two files, and checks
> > if the following entities are set correctly after
> > the ioctl call:
>
> > - errno (set by ioctl)
> > - number of deduplicated bytes
> > - status field of the file_dedupe_range_info struct
>
> ...
> > +++ b/testcases/kernel/syscalls/ioctl/ioctl08.c
> > @@ -0,0 +1,131 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2019 SUSE LLC
> > + * Author: Christian Amann <camann@suse.com>
> > + *
> > + */
> > +
> > +/*
> > + * Tests the ioctl functionality to deduplicate fileranges using
> > + * btrfs filesystem.
> > + *
> > + * 1)        Sets the same contents for two files and deduplicates it.
> > + *   Deduplicates 3 bytes and set the status to
> > + *   FILE_DEDUPE_RANGE_SAME.
> > + * 2)        Sets different content for two files and tries to
> > + *   deduplicate it. 0 bytes get deduplicated and status is
> > + *   set to FILE_DEDUPE_RANGE_DIFFERS.
> > + * 3)        Sets same content for two files but sets the length to
> > + *   deduplicate to -1. ioctl(FIDEDUPERANGE) fails with EINVAL.
> > + */
> > +
> LGTM, going to apply it with adding
> #include "config.h" here (that's needed for detecting HAVE_STRUCT_FILE_DEDUPE_RANGE


FYI, This test fails on kernel without btrfs support.

WARNING: failed to open /dev/btrfs-control, skipping device
registration: No such file or directory
safe_macros.c:757: BROK: tst_test.c:752: mount(/dev/loop0, mnt_point,
btrfs, 0, (nil)) failed: ENODEV

Thanks,
Amir.
