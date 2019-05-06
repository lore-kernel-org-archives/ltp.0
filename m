From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 6 May 2019 23:09:21 +0200
Subject: [LTP] [PATCH v2] syscalls/rt_sigqueueinfo01: rewrote testcase
In-Reply-To: <20190425085204.11036-1-camann@suse.com>
References: <20190425085204.11036-1-camann@suse.com>
Message-ID: <20190506210921.GB9828@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Christian,

> The previous implementation only tested if the syscall can
> be called at all. Now it also checks if the correct signal
> and data is sent and received.

> Signed-off-by: Christian Amann <camann@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Thanks for your patch.
Minor comments, not relevant to the actual testing below.

Kind regards,
Petr

>  testcases/kernel/syscalls/rt_sigqueueinfo/Makefile |   2 +
>  .../syscalls/rt_sigqueueinfo/rt_sigqueueinfo.h     |  22 +++
>  .../syscalls/rt_sigqueueinfo/rt_sigqueueinfo01.c   | 188 +++++++++++----------
>  3 files changed, 125 insertions(+), 87 deletions(-)
>  create mode 100644 testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo.h

> diff --git a/testcases/kernel/syscalls/rt_sigqueueinfo/Makefile b/testcases/kernel/syscalls/rt_sigqueueinfo/Makefile
> index 2ef86f06f..498ba8e31 100644
> --- a/testcases/kernel/syscalls/rt_sigqueueinfo/Makefile
> +++ b/testcases/kernel/syscalls/rt_sigqueueinfo/Makefile
> @@ -21,3 +21,5 @@ top_srcdir		?= ../../../..
>  include $(top_srcdir)/include/mk/testcases.mk

>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> +
> +rt_sigqueueinfo01: CFLAGS += -pthread
> diff --git a/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo.h b/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo.h
> new file mode 100644
> index 000000000..927e4bf3b
> --- /dev/null
> +++ b/testcases/kernel/syscalls/rt_sigqueueinfo/rt_sigqueueinfo.h
Do you plan to add more rt_sigqueueinfo() tests? Otherwise we might just add
this content into C file.

> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 SUSE LLC
> + * Author: Christian Amann <camann@suse.com>
> + */
> +
> +#ifdef HAVE_STRUCT_SIGACTION_SA_SIGACTION
Also I'd use this guard only in C file (IMHO not required for header) and load
this header after this guard.

> +
> +#ifndef __RT_SIGQUEUEINFO_H__
> +#define __RT_SIGQUEUEINFO_H__
> +
> +#define gettid() syscall(SYS_gettid)
I guess this does not clash even with glibc 2.30, which added gettid(), because
we don't include <sys/types.h>. But I wonder if it's useful to define for one usage.
BTW we have 22 {tst_,}syscall(__NR_gettid) usages, 2 definitions like your
(#define gettid() syscall(__NR_gettid)) and 4 int gettid(void) functions.
If considered useful, it should be in include/lapi/.

...
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 SUSE LLC
> + * Author: Christian Amann <camann@suse.com>
> + */
> +
> +/*
> + * Description:
You can be more radical with doc cleanup. "Description:" or redundant line before */ can go away.

> + *
> + * This tests the rt_sigqueueinfo() syscall.
> + *
> + * It does so by creating a thread which registers the corresponding
> + * signal handler. After that the main thread sends a signal and data
> + * to the handler thread. If the correct signal and data is received,
> + * the test is successful.
> + *
> + */

Kind regards,
Petr
