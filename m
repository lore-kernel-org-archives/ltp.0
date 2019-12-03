From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 3 Dec 2019 11:49:17 +0100
Subject: [LTP] [PATCH 1/2] lib: add tst_request_hugepages
In-Reply-To: <20191128084506.7587-1-liwang@redhat.com>
References: <20191128084506.7587-1-liwang@redhat.com>
Message-ID: <20191203104917.GA2844@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Note: more and more tests need to configure hugepage before testing, so
> this is a start to add some useful hugetlb functions in global library
> for the whole LTP.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  include/tst_hugepage.h | 19 +++++++++++++++++++
>  include/tst_test.h     |  1 +
>  lib/tst_hugepage.c     | 43 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 63 insertions(+)
>  create mode 100644 include/tst_hugepage.h
>  create mode 100644 lib/tst_hugepage.c
> 
> diff --git a/include/tst_hugepage.h b/include/tst_hugepage.h
> new file mode 100644
> index 000000000..e06705bd0
> --- /dev/null
> +++ b/include/tst_hugepage.h
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Red Hat, Inc.
> + */
> +
> +#ifndef TST_HUGEPAGE__
> +#define TST_HUGEPAGE__
> +
> +/*
> + * Try to request the specified number of huge pages from system.
> + *
> + * Note: this depend on the status of system memory fragmentation.
> + *       0 - reserve fail
> + *       1 - reserve success
> + */
> +int tst_request_hugepages(long hpages);

Can we add this to the tst_test structure so that test case use this as:

static struct tst_test test = {
	...
	.needs_hugepages = 1,
	...
}

That way it will be included in the test metadata I'm working on.

> +#endif /* TST_HUGEPAGE_H */
> +
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 21c7dfbdb..7ec1ab865 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -37,6 +37,7 @@
>  #include "tst_coredump.h"
>  #include "tst_buffers.h"
>  #include "tst_capability.h"
> +#include "tst_hugepage.h"
>  
>  /*
>   * Reports testcase result.
> diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
> new file mode 100644
> index 000000000..00cf90843
> --- /dev/null
> +++ b/lib/tst_hugepage.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Red Hat, Inc.
> + */
> +
> +#define TST_NO_DEFAULT_MAIN
> +
> +#include "tst_test.h"
> +#include "tst_hugepage.h"
> +
> +int tst_request_hugepages(long hpages)
> +{
> +	int val;
> +	long mem_avail, max_hpages;
> +
> +	if (FILE_LINES_SCANF("/proc/meminfo",
> +				"MemAvailable: %ld", &mem_avail)) {
> +		/*
> +		 * Dropping caches and using "MemFree:" on kernel
> +		 * that doesn't have "MemAvailable:" in Meminfo
> +		 */
> +		tst_res(TINFO, "MemAvailable: not found in /proc/meminfo");
> +
> +		SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");
> +		mem_avail = SAFE_READ_MEMINFO("MemFree:");
> +	}
> +
> +	max_hpages = mem_avail / SAFE_READ_MEMINFO("Hugepagesize:");
> +
> +	if (hpages > max_hpages) {
> +		tst_res(TINFO, "Request %ld hugepages failed, memory too fragmented? "
> +				"The max hugepage available count %ld",
> +				hpages, max_hpages);
> +		return 0;

I guess that rest of the library functions returns non-zero on failure.

> +	}
> +
> +	SAFE_FILE_PRINTF("/proc/sys/vm/nr_hugepages", "%ld", hpages);
> +	SAFE_FILE_SCANF("/proc/sys/vm/nr_hugepages", "%d", &val);
> +	if (val != hpages)
> +		tst_brk(TBROK, "nr_hugepages = %d, but expect %ld", val, hpages);
> +
> +	return 1;

I guess that things will be more complicated than this. If there is
already a pool of hugepages allocated on the machine and some are used
this will utimatelly fail.

I rember that we changed some tests to increase the nr_hugepages if
needed instead of blindly writing values there.

Also this fails to cleanup after itself, we have to restore the system
after the test, which is one more reason why we need .needs_hugepages in
the tst_test structure because the test library can cleanup after the
test with that.

> +}
> -- 
> 2.20.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
