From: vaishnavi.d <vaishnavi.d@zilogic.com>
Date: Fri, 21 Dec 2018 11:06:48 -0000
Subject: [LTP] [PATCH v2] Test statx syscall for SYNC_FLAGS
References: <20180917075248.28004-1-kewal@zilogic.com>
 <20181220082009.GA27700@dell5510>
Message-ID: <7723ae02218c2bbca1a40d9c701a7bb2.squirrel@pike.zilogic.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi,

> Hi Kewal,
>
>> +++ b/testcases/kernel/syscalls/statx/statx07.c
> ...
>> + * Minimum kernel version required is 4.11.
>> + */
>
> One more thing, you need to define _GNU_SOURCE here as it's needed for
> glibc and
> thus used for detection in m4/ltp-statx.m4.
>
>
> #define _GNU_SOURCE
>
>> +#include <netdb.h>
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <linux/limits.h>
>> +#include <sys/mount.h>
>> +#include "tst_test.h"
>> +#include "lapi/stat.h"
>
> Without it it fails on glibc >= 2.28
> https://travis-ci.org/pevik/ltp/builds/470077800
>
> I thing it'd be better to remove _GNU_SOURCE from statx0*.c and put it
> into
> lapi/stat.h.

These changes have already been made in v5 of this test case. This patch
has been renamed to syscalls/statx: Add test for sync flags. Waiting for
the tst_get_tmpdir() function to be ported to new library for the patch to
be merged.

Regards,
Vaishnavi D


