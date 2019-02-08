From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Fri, 8 Feb 2019 11:34:01 -0200
Subject: [LTP] [PATCH v2 1/2] syscalls/clock_gettime: create
 clock_gettime syscall tests
In-Reply-To: <20190208132956.18990-1-rafael.tinoco@linaro.org>
References: <20190207123137.GA9277@rei>
 <20190208132956.18990-1-rafael.tinoco@linaro.org>
Message-ID: <C6777BF2-0ADF-45B7-B788-BDF333BA057F@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it


> diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c b/=
testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
> new file mode 100644
> index 000000000..4db52c09d
> --- /dev/null
> +++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime02.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Linaro Limited. All rights reserved.
> + * Author: Rafael David Tinoco <rafael.tinoco@linaro.org>
> + */
> +/*
> + * Bad argument tests for clock_gettime(2) on multiple clocks:
> + *
> + *  1) MAX_CLOCKS
> + *  2) MAX_CLOCKS + 1
> + *  3) CLOCK_REALTIME
> + *  4) CLOCK_MONOTONIC
> + *  5) CLOCK_PROCESS_CPUTIME_ID
> + *  6) CLOCK_THREAD_CPUTIME_ID
> + *  7) CLOCK_REALTIME_COARSE
> + *  8) CLOCK_MONOTONIC_COARSE
> + *  9) CLOCK_MONOTONIC_RAW
> + * 10) CLOCK_BOOTTIME
> + */
> +
> +#include "config.h"
> +#include "tst_test.h"
> +#include "lapi/syscalls.h"
> +#include "lapi/posix_clocks.h"
> +#include "tst_timer.h"
> +#include =E2=80=9Ctst_safe_clocks.h"

<garbage>

> +#include <stdio.h>
> +
> +#define DELTA_SEC 10
> +#define NSEC_PER_SEC (1000000000L)

</garbage>

Sorry, sent out the patch too soon. Let me know if you can amend it, removi=
ng those 3 lines, or you want me to submit it again.=20

Thanks a lot.
