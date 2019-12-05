From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 5 Dec 2019 12:57:42 +0100
Subject: [LTP] [PATCH v2 1/2] lib: add .needs_hugepages to reserve
 hugepage
In-Reply-To: <20191205103342.5980-1-liwang@redhat.com>
References: <20191205103342.5980-1-liwang@redhat.com>
Message-ID: <20191205115742.GA5693@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Many of the ltp tests need to use hugepage in their testing, this makes
> the test can reserve hpages from system only via .needs_hugepages = xx.
> 
> If set non-zero number of needs_hugepages, the test will try to reserve
> an expected number huge page for testing in setup phase. If system does
> not support hugetlb or failed to get the expected number, test will set
> the global variable 'tst_no_hugepage' to 1.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  doc/test-writing-guidelines.txt | 38 +++++++++++++++++++++++-
>  include/tst_hugepage.h          | 27 +++++++++++++++++
>  include/tst_test.h              | 11 +++++++
>  lib/newlib_tests/.gitignore     |  1 +
>  lib/newlib_tests/test20.c       | 45 ++++++++++++++++++++++++++++
>  lib/tst_hugepage.c              | 52 +++++++++++++++++++++++++++++++++
>  lib/tst_test.c                  |  8 ++++-
>  7 files changed, 180 insertions(+), 2 deletions(-)
>  create mode 100644 include/tst_hugepage.h
>  create mode 100644 lib/newlib_tests/test20.c
>  create mode 100644 lib/tst_hugepage.c
> 
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index 546bb7a49..2832c3501 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -1854,7 +1854,43 @@ However a lot of problems can be solved by using 'tst_cap_action(struct
>  tst_cap  *cap)' directly which can be called at any time. This also helps if
>  you wish to drop a capability at the begining of setup.
>  
> -2.2.33 Reproducing race-conditions
> +2.2.33 Reserving hugepages
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Many of the ltp tests need to use hugepage in their testing, this makes the
> +test can reserve hugepages from system only via .needs_hugepages = xx.
> +
> +If set non-zero number of needs_hugepages, the test will try to reserve
> +an expected number hugepage for testing. If system does not support hugetlb
> +or failed to get the expected numbers, test will set the global variable
> +'tst_no_hugepage' to 1.
> +
> +Also, we do cleanup and restore work for the hpages resetting automatically.
> +
> +[source,c]
> +-------------------------------------------------------------------------------
> +#include "tst_test.h"
> +
> +static void run(void)
> +{
> +	...
> +
> +	if (tst_no_hugepage)
> +		...
> +	else
> +		TEST(do_hpage_test);
> +	...
> +}
> +
> +struct tst_test test = {
> +	...
> +	.test_all = run,
> +	.needs_hugepages = 2,
> +	...
> +};
> +-------------------------------------------------------------------------------
> +
> +2.2.34 Reproducing race-conditions
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Can we please avoid renumbering the paragraphs, i.e. can you add the
hugepages docs after this?

>  If a bug is caused by two tasks in the kernel racing and you wish to create a
> diff --git a/include/tst_hugepage.h b/include/tst_hugepage.h
> new file mode 100644
> index 000000000..66b8d1f03
> --- /dev/null
> +++ b/include/tst_hugepage.h
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Red Hat, Inc.
> + */
> +
> +#ifndef TST_HUGEPAGE__
> +#define TST_HUGEPAGE__
> +
> +#define PATH_HUGEPAGES	"/sys/kernel/mm/hugepages/"
> +#define PATH_NR_HPAGES	"/proc/sys/vm/nr_hugepages"
> +
> +/*
> + * Try to request the specified number of huge pages from system.
> + *
> + * Note: this depend on the status of system memory fragmentation.
> + *           -1	- reserve fail
> + *       hpages	- reserve success
> + */
> +int tst_request_hugepages(int hpages);
> +
> +/*
> + * If system does not support hugetlb or failed to reserve the expected
> + * number of hugepage, then this value will be set to 1.
> + */
> +extern unsigned int tst_no_hugepage;

Hmm, this needs a bit more thoughts.

So far all the needs_foo flags require the foo to be present on the
system, i.e. are hard requirements. In this case hugepages are soft
requirement, i.e. only part of the test will need that.

We probably need a better name for this than needs_hugepages in
tst_test. We may as well need a generic way how to describe that some of
the requirements are hard and some of them are soft. I will give it some
thoughts.

At least we should just call it request_hugepages in the tst_test
structure instead.

> +#endif /* TST_HUGEPAGE_H */
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 21c7dfbdb..995c7c821 100644
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
> @@ -148,6 +149,16 @@ struct tst_test {
>  	 */
>  	int all_filesystems:1;
>  
> +	/*
> +	 * If set non-zero number of needs_hugepages, the test will try to reserve
> +	 * an expected number huge page for testing in setup phase. If system does
> +	 * not support hugetlb or failed to get the expected number, test will set
> +	 * the global variable 'tst_no_hugepage' to 1.
> +	 *
> +	 * Also, we do cleanup and restore work for the hpages resetting automatically.
> +	 */
> +	unsigned int needs_hugepages;
> +
>  	/*
>  	 * If set non-zero denotes number of test variant, the test is executed
>  	 * variants times each time with tst_variant set to different number.
> diff --git a/lib/newlib_tests/.gitignore b/lib/newlib_tests/.gitignore
> index d4aa4935f..ab3a92c4c 100644
> --- a/lib/newlib_tests/.gitignore
> +++ b/lib/newlib_tests/.gitignore
> @@ -23,6 +23,7 @@ tst_strstatus
>  test17
>  test18
>  test19
> +test20
>  tst_expiration_timer
>  test_exec
>  test_exec_child
> diff --git a/lib/newlib_tests/test20.c b/lib/newlib_tests/test20.c
> new file mode 100644
> index 000000000..9331788ba
> --- /dev/null
> +++ b/lib/newlib_tests/test20.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Li Wang <liwang@redhat.com>
> + */
> +
> +/*
> + * Tests .needs_hugepages + .save_restore
> + */
> +
> +#include "tst_test.h"
> +#include "tst_hugepage.h"
> +#include "tst_sys_conf.h"
> +
> +static const char * const save_restore[] = {
> +	"!/proc/sys/kernel/numa_balancing",
> +	NULL,
> +};
> +
> +static void do_test(void) {
> +
> +	int val, hpages;
> +
> +	tst_res(TINFO, "tst_no_hugepage = %u", tst_no_hugepage);
> +	SAFE_FILE_PRINTF("/proc/sys/kernel/numa_balancing", "1");
> +
> +	hpages = test.needs_hugepages;
> +	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%d", &val);
> +	if (val != hpages)
> +		tst_brk(TBROK, "nr_hugepages = %d, but expect %d", val, hpages);
> +	else
> +		tst_res(TPASS, "test .needs_hugepges");
> +
> +	hpages = tst_request_hugepages(3);
> +	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%d", &val);
> +	if (val != hpages)
> +		tst_brk(TBROK, "nr_hugepages = %d, but expect %d", val, hpages);
> +	else
> +		tst_res(TPASS, "tst_request_hugepages");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = do_test,
> +	.needs_hugepages = 2,
> +	.save_restore = save_restore,
> +};
> diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
> new file mode 100644
> index 000000000..3f574b8e3
> --- /dev/null
> +++ b/lib/tst_hugepage.c
> @@ -0,0 +1,52 @@
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
> +unsigned int tst_no_hugepage;
> +
> +int tst_request_hugepages(int hpages)
> +{
> +	int val;
> +	long mem_avail, max_hpages;
> +
> +	if (access(PATH_HUGEPAGES, F_OK)) {
> +		tst_res(TCONF, "Huge page is not supported.");
> +		tst_no_hugepage = 1;

I guess that it will make more sense to call it tst_hugepages and set it
to a number of hugepages that we were able to reserve. I.e. set it to 0
here and to hpages at the end.

That way we can do if (tst_hugepages) or if (!tst_hugepages) in
testcases as well.

> +		return -1;
> +	}
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
> +		tst_res(TINFO, "Request %d hugepages failed, memory too fragmented? "
> +				"The max hugepage available count %ld",
> +				hpages, max_hpages);
> +		tst_no_hugepage = 1;
> +		return -1;
> +	}
> +
> +	SAFE_FILE_PRINTF(PATH_NR_HPAGES, "%d", hpages);
> +	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%d", &val);
> +	if (val != hpages)
> +		tst_brk(TBROK, "nr_hugepages = %d, but expect %d", val, hpages);
> +
> +	return hpages;
> +}
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 8d7dee2cc..ae012a0b3 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -890,6 +890,11 @@ static void do_setup(int argc, char *argv[])
>  	if (tst_test->all_filesystems)
>  		tst_test->needs_device = 1;
>  
> +	if (tst_test->needs_hugepages) {
> +		tst_sys_conf_save("?/proc/sys/vm/nr_hugepages");

Can we call this from the tst_hugepage.c instead and only if we actually
written to that file?

> +		tst_request_hugepages(tst_test->needs_hugepages);
> +	}
> +
>  	setup_ipc();
>  
>  	if (tst_test->bufs)
> @@ -1006,7 +1011,8 @@ static void do_cleanup(void)
>  		tst_rmdir();
>  	}
>  
> -	if (tst_test->save_restore)
> +	if (tst_test->save_restore ||
> +		(tst_test->needs_hugepages && !tst_no_hugepage))
>  		tst_sys_conf_restore(0);

We can call the tst_sys_conf_restore() unconditionally here, if nothing
has been saved it's no-op.

>  	if (tst_test->restore_wallclock)

Otherwise it looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
