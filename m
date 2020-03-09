From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 09 Mar 2020 14:23:29 +0100
Subject: [LTP] [PATCH 6/8] syscalls/clock_gettime03: Add basic time
 namespace test
In-Reply-To: <20200305134834.16736-7-chrubis@suse.cz>
References: <20200305134834.16736-1-chrubis@suse.cz>
 <20200305134834.16736-7-chrubis@suse.cz>
Message-ID: <87imjdfyr2.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Cyril Hrubis <chrubis@suse.cz> writes:

> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  runtest/containers                            |   1 +
>  runtest/syscalls                              |   1 +
>  .../kernel/syscalls/clock_gettime/.gitignore  |   1 +
>  .../syscalls/clock_gettime/clock_gettime03.c  | 113 ++++++++++++++++++
>  4 files changed, 116 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
>
> diff --git a/runtest/containers b/runtest/containers
> index 8100cd2bc..1006d8d35 100644
> --- a/runtest/containers
> +++ b/runtest/containers
> @@ -89,3 +89,4 @@ userns07 userns07
>  # time namespaces
>  sysinfo03 sysinfo03
>  clock_nanosleep03 clock_nanosleep03
> +clock_gettime03 clock_gettime03
> diff --git a/runtest/syscalls b/runtest/syscalls
> index d19ae0041..778f722a3 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -91,6 +91,7 @@ clock_nanosleep03 clock_nanosleep03
>  
>  clock_gettime01 clock_gettime01
>  clock_gettime02 clock_gettime02
> +clock_gettime03 clock_gettime03
>  leapsec01 leapsec01
>  
>  clock_settime01 clock_settime01
> diff --git a/testcases/kernel/syscalls/clock_gettime/.gitignore b/testcases/kernel/syscalls/clock_gettime/.gitignore
> index ba471c859..9d06613b6 100644
> --- a/testcases/kernel/syscalls/clock_gettime/.gitignore
> +++ b/testcases/kernel/syscalls/clock_gettime/.gitignore
> @@ -1,3 +1,4 @@
>  clock_gettime01
>  clock_gettime02
> +clock_gettime03
>  leapsec01
> diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
> new file mode 100644
> index 000000000..533b3898e
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime03.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> +
> +  Copyright (c) 2020 Cyril Hrubis <chrubis@suse.cz>
> +
> + */
> +/*
> +
> +  Basic test for timer namespaces.
> +
> +  After a call to unshare(CLONE_NEWTIME) a new timer namespace is created, the
> +  process that has called the unshare() can adjust offsets for CLOCK_MONOTONIC
> +  and CLOCK_BOOTTIME for its children by writing to the '/proc/self/timens_offsets'.
> +
> +  The child processes also switch to the initial parent namespace and checks
> +  that the offset is set to 0.
> +
> + */
> +
> +#define _GNU_SOURCE
> +#include "lapi/setns.h"
> +#include "tst_safe_clocks.h"
> +#include "tst_timer.h"
> +#include "lapi/namespaces_constants.h"
> +#include "tst_test.h"
> +
> +static struct tcase {
> +	int clk_id;
> +	int clk_off;
> +	int off;
> +} tcases[] = {
> +	{CLOCK_MONOTONIC, CLOCK_MONOTONIC, 10},
> +	{CLOCK_BOOTTIME, CLOCK_BOOTTIME, 10},
> +
> +	{CLOCK_MONOTONIC, CLOCK_MONOTONIC, -10},
> +	{CLOCK_BOOTTIME, CLOCK_BOOTTIME, -10},
> +
> +	{CLOCK_MONOTONIC_RAW, CLOCK_MONOTONIC, 100},
> +	{CLOCK_MONOTONIC_COARSE, CLOCK_MONOTONIC, 100},
> +};
> +
> +static struct timespec now;
> +static int parent_ns;
> +
> +static void child(struct tcase *tc)
> +{
> +	struct timespec then;
> +	struct timespec parent_then;
> +	long long diff;
> +
> +	SAFE_CLOCK_GETTIME(tc->clk_id, &then);
> +
> +	setns(parent_ns, CLONE_NEWTIME);

Maybe check the error code?

-- 
Thank you,
Richard.
