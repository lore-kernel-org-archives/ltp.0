From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 20 Dec 2018 09:20:09 +0100
Subject: [LTP] [PATCH v2] Test statx syscall for SYNC_FLAGS
In-Reply-To: <20180917075248.28004-1-kewal@zilogic.com>
References: <20180917075248.28004-1-kewal@zilogic.com>
Message-ID: <20181220082009.GA27700@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Kewal,

> +++ b/testcases/kernel/syscalls/statx/statx07.c
...
> + * Minimum kernel version required is 4.11.
> + */

One more thing, you need to define _GNU_SOURCE here as it's needed for glibc and
thus used for detection in m4/ltp-statx.m4.


#define _GNU_SOURCE

> +#include <netdb.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <linux/limits.h>
> +#include <sys/mount.h>
> +#include "tst_test.h"
> +#include "lapi/stat.h"

Without it it fails on glibc >= 2.28
https://travis-ci.org/pevik/ltp/builds/470077800

I thing it'd be better to remove _GNU_SOURCE from statx0*.c and put it into
lapi/stat.h.

Kind regards,
Petr
