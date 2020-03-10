From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 10 Mar 2020 13:06:44 +0100
Subject: [LTP] [PATCH 7/8] containers/timens: Add basic error test
In-Reply-To: <20200305134834.16736-8-chrubis@suse.cz>
References: <20200305134834.16736-1-chrubis@suse.cz>
 <20200305134834.16736-8-chrubis@suse.cz>
Message-ID: <87eeu0fm7f.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Cyril Hrubis <chrubis@suse.cz> writes:

> Add basic error handling test for the /proc/$PID/timens_offsets file.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  runtest/containers                            |  1 +
>  testcases/kernel/containers/timens/.gitignore |  1 +
>  testcases/kernel/containers/timens/Makefile   |  6 ++
>  testcases/kernel/containers/timens/timens01.c | 75 +++++++++++++++++++
>  4 files changed, 83 insertions(+)
>  create mode 100644 testcases/kernel/containers/timens/.gitignore
>  create mode 100644 testcases/kernel/containers/timens/Makefile
>  create mode 100644 testcases/kernel/containers/timens/timens01.c
>
> diff --git a/runtest/containers b/runtest/containers
> index 1006d8d35..23e4a533d 100644
> --- a/runtest/containers
> +++ b/runtest/containers
> @@ -90,3 +90,4 @@ userns07 userns07
>  sysinfo03 sysinfo03
>  clock_nanosleep03 clock_nanosleep03
>  clock_gettime03 clock_gettime03
> +timens01 timens01
> diff --git a/testcases/kernel/containers/timens/.gitignore b/testcases/kernel/containers/timens/.gitignore
> new file mode 100644
> index 000000000..bcd2dd9dd
> --- /dev/null
> +++ b/testcases/kernel/containers/timens/.gitignore
> @@ -0,0 +1 @@
> +timens01
> diff --git a/testcases/kernel/containers/timens/Makefile b/testcases/kernel/containers/timens/Makefile
> new file mode 100644
> index 000000000..5ea7d67db
> --- /dev/null
> +++ b/testcases/kernel/containers/timens/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/containers/timens/timens01.c b/testcases/kernel/containers/timens/timens01.c
> new file mode 100644
> index 000000000..08bc449f9
> --- /dev/null
> +++ b/testcases/kernel/containers/timens/timens01.c
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> +
> +  Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
> +
> + */
> +/*
> +
> +  Basic test for timens_offsets error handling.
> +
> +  After a call to unshare(CLONE_NEWTIME) a new timer namespace is created, the
> +  process that has called the unshare() can adjust offsets for CLOCK_MONOTONIC
> +  and CLOCK_BOOTTIME for its children by writing to the '/proc/self/timens_offsets'.
> +
> + */
> +
> +#define _GNU_SOURCE
> +#include "lapi/setns.h"
> +#include "lapi/namespaces_constants.h"
> +#include "lapi/posix_clocks.h"
> +#include "tst_test.h"
> +
> +static struct tcase {
> +	const char *offsets;
> +	int exp_err;
> +} tcases[] = {
> +	/* obvious garbage */

You could include these comments in the struct and print them.

-- 
Thank you,
Richard.
