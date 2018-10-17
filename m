From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 17 Oct 2018 16:27:45 -0400 (EDT)
Subject: [LTP] [PATCH] tracing/intel_pt: Fix build on older userspace.
In-Reply-To: <20181017153833.27187-1-chrubis@suse.cz>
References: <20181017153833.27187-1-chrubis@suse.cz>
Message-ID: <265925405.59368018.1539808065287.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> Older userspace linux headers do not have aux_* fields struct
> perf_event_mmap_page. This commit disables the test build if older
> headers were detected, the alternative would be adding a fallback
> definition to LTP but I doubt that it's worth the effort.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Ammy Yi <ammy.yi@intel.com>

ack, fixes build for me too

> ---
>  configure.ac                               |  1 +
>  m4/ltp-perf_event.m4                       | 13 +++++++++++++
>  testcases/kernel/tracing/pt_test/pt_test.c |  7 +++++++
>  3 files changed, 21 insertions(+)
>  create mode 100644 m4/ltp-perf_event.m4
> 
> diff --git a/configure.ac b/configure.ac
> index 0f0d8c17a..e81d2add5 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -229,6 +229,7 @@ LTP_CHECK_X_TABLES
>  LTP_CHECK_ATOMIC_MEMORY_MODEL
>  LTP_CHECK_TPACKET_V3
>  LTP_DETECT_HOST_CPU
> +LTP_CHECK_PERF_EVENT
>  
>  if test "x$with_numa" = xyes; then
>  	LTP_CHECK_SYSCALL_NUMA
> diff --git a/m4/ltp-perf_event.m4 b/m4/ltp-perf_event.m4
> new file mode 100644
> index 000000000..109ad4935
> --- /dev/null
> +++ b/m4/ltp-perf_event.m4
> @@ -0,0 +1,13 @@
> +dnl
> +dnl Copyright (c) 2018 Cyril Hrubis <chrubis@suse.cz>
> +dnl
> +dnl SPDX-License-Identifier: GPL-2.0-or-later
> +dnl
> +
> +dnl
> +dnl LTP_CHECK_PERF_EVENT
> +dnl ----------------------------
> +dnl
> +AC_DEFUN([LTP_CHECK_PERF_EVENT],[
> +AC_CHECK_MEMBERS([struct perf_event_mmap_page.aux_head],,,[#include
> <linux/perf_event.h>])
> +])
> diff --git a/testcases/kernel/tracing/pt_test/pt_test.c
> b/testcases/kernel/tracing/pt_test/pt_test.c
> index 517427992..abf575d37 100644
> --- a/testcases/kernel/tracing/pt_test/pt_test.c
> +++ b/testcases/kernel/tracing/pt_test/pt_test.c
> @@ -20,6 +20,9 @@
>  #include <stdio.h>
>  #include "tst_test.h"
>  #include "lapi/syscalls.h"
> +#include "config.h"
> +
> +#ifdef HAVE_STRUCT_PERF_EVENT_MMAP_PAGE_AUX_HEAD
>  
>  #define PAGESIZE 4096
>  #define INTEL_PT_MEMSIZE (17*PAGESIZE)
> @@ -157,3 +160,7 @@ static struct tst_test test = {
>  	.cleanup = cleanup,
>  	.needs_root = 1,
>  };
> +
> +#else
> +TST_TEST_TCONF("missing aux_* fields in struct perf_event_mmap_page");
> +#endif /* HAVE_STRUCT_PERF_EVENT_MMAP_PAGE_AUX_HEAD */
> --
> 2.16.4
> 
> 
> --
> Mailing list info: https://lists.linux.it/listinfo/ltp
> 
