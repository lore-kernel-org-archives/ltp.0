From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Jan 2020 15:31:33 +0100
Subject: [LTP] [PATCH v3 1/2] lib: add .request_hugepages to reserve
 hugepage
In-Reply-To: <20191218090202.26932-1-liwang@redhat.com>
References: <20191218090202.26932-1-liwang@redhat.com>
Message-ID: <20200122143133.GA29412@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Many of the ltp tests need to use hugepage in their testing, this allows
> the test can reserve hpages from system only via .request_hugepages = xx.
> 
> If set non-zero number of request_hugepages, test will try to reserve the
> expected number of hugepage for testing in setup phase. If system does not
> have enough hpage for using, it will try the best to reserve 80% available
> number of hpages. For a system without hugetlb supporting, variable
> 'tst_hugepage' will be set to 0.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
> 
> Notes:
>     v2 --> v3
>       * rename .needs_hugepages to .request_hugepages
>       * rename tst_no_hugepage to tst_hugepages
>       * makes tst_request_hugepages() return tst_hugepages
>       * call tst_sys_conf_save in tst_hugepage.c
> 
>  doc/test-writing-guidelines.txt | 38 ++++++++++++++++++++++
>  include/tst_hugepage.h          | 29 +++++++++++++++++
>  include/tst_test.h              | 13 ++++++++
>  lib/newlib_tests/.gitignore     |  1 +
>  lib/newlib_tests/test20.c       | 45 ++++++++++++++++++++++++++
>  lib/tst_hugepage.c              | 57 +++++++++++++++++++++++++++++++++
>  lib/tst_test.c                  |  6 ++--
>  7 files changed, 187 insertions(+), 2 deletions(-)
>  create mode 100644 include/tst_hugepage.h
>  create mode 100644 lib/newlib_tests/test20.c
>  create mode 100644 lib/tst_hugepage.c
> 
> diff --git a/doc/test-writing-guidelines.txt b/doc/test-writing-guidelines.txt
> index 546bb7a49..7875690b9 100644
> --- a/doc/test-writing-guidelines.txt
> +++ b/doc/test-writing-guidelines.txt
> @@ -1933,6 +1933,44 @@ specified by the user plus some other heuristics.
>  
>  For full documentation see the comments in 'include/tst_fuzzy_sync.h'.
>  
> +2.2.34 Reserving hugepages
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Many of the ltp tests need to use hugepage in their testing, this allows the
> +test can reserve hugepages from system only via .request_hugepages = xx.
> +
> +If set non-zero number of request_hugepages, test will try to reserve the
> +expected number of hugepage for testing in setup phase. If system does not
> +have enough hpage for using, it will try the best to reserve 80% available
> +number of hpages. With success test stores the reserved hugepage number in
> +'tst_hugepages. For the system without hugetlb supporting, variable
> +'tst_hugepages' will be set to 0.
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
> +	if (tst_hugepages == test.request_hugepages)
> +		TEST(do_hpage_test);
> +	else
> +		...
> +	...
> +}

I guess that it would be more instructive to check the value in the test
setup() here, because most of the test would just check if tst_hugepages
has been set to expected value.

static void setup(void)
{
	if (tst_hugepages != test.requested_hugepages)
		tst_brk(TCONF, "...");
}

> +struct tst_test test = {
> +	...
> +	.test_all = run,
> +	.request_hugepages = 2,
> +	...
> +};
> +-------------------------------------------------------------------------------
> +
>  2.3 Writing a testcase in shell
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>  
> diff --git a/include/tst_hugepage.h b/include/tst_hugepage.h
> new file mode 100644
> index 000000000..10e0eaf47
> --- /dev/null
> +++ b/include/tst_hugepage.h
> @@ -0,0 +1,29 @@
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
> + * Try the best to request a specified number of huge pages from system,
> + * it will store the reserved hpage number in tst_hugepages.
> + *
> + * Note: this depend on the status of system memory fragmentation.
> + */
> +int tst_request_hugepages(int hpages);
> +
> +/*
> + * This variable is used for recording the number of hugepages which system can
> + * provides. It will be equal to 'hpages' if tst_request_hugepages on success,
> + * otherwise set it to a number of hugepages that we were able to reserve.
> + *
> + * If system does not support hugetlb, then it will be set to 0.
> + */
> +extern unsigned int tst_hugepages;
> +
> +#endif /* TST_HUGEPAGE_H */
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 21c7dfbdb..1026a422a 100644
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
> @@ -148,6 +149,18 @@ struct tst_test {
>  	 */
>  	int all_filesystems:1;
>  
> +	/*
> +	 * If set non-zero number of request_hugepages, test will try to reserve the
> +	 * expected number of hugepage for testing in setup phase. If system does not
> +	 * have enough hpage for using, it will try the best to reserve 80% available
> +	 * number of hpages. With success test stores the reserved hugepage number in
> +	 * 'tst_hugepages. For the system without hugetlb supporting, variable
> +	 * 'tst_hugepages' will be set to 0.
> +	 *
> +	 * Also, we do cleanup and restore work for the hpages resetting automatically.
> +	 */
> +	unsigned int request_hugepages;
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
> index 000000000..92e230976
> --- /dev/null
> +++ b/lib/newlib_tests/test20.c
> @@ -0,0 +1,45 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2019 Li Wang <liwang@redhat.com>
> + */
> +
> +/*
> + * Tests .request_hugepages + .save_restore
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
> +	tst_res(TINFO, "tst_hugepages = %u", tst_hugepages);
> +	SAFE_FILE_PRINTF("/proc/sys/kernel/numa_balancing", "1");
> +
> +	hpages = test.request_hugepages;
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
> +	.request_hugepages = 2,
> +	.save_restore = save_restore,
> +};
> diff --git a/lib/tst_hugepage.c b/lib/tst_hugepage.c
> new file mode 100644
> index 000000000..c4385b9c6
> --- /dev/null
> +++ b/lib/tst_hugepage.c
> @@ -0,0 +1,57 @@
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
> +unsigned int tst_hugepages;
> +
> +int tst_request_hugepages(int hpages)
> +{
> +	int val;
> +	long mem_avail, max_hpages;
> +
> +	if (access(PATH_HUGEPAGES, F_OK)) {
> +		tst_res(TCONF, "Huge page is not supported.");

I guess that this is something the test has to decide, i.e. I wouldn't
print anything here.

> +		tst_hugepages = 0;
> +		goto out;
> +	}
> +
> +	tst_hugepages = hpages;
> +
> +	SAFE_FILE_PRINTF("/proc/sys/vm/drop_caches", "3");

Shouldn't we drop the caches only if MemAvailable is not present in
/proc/meminfo?

> +	if (FILE_LINES_SCANF("/proc/meminfo",
> +				"MemAvailable: %ld", &mem_avail)) {
> +		/*
> +		 * Using "MemFree:" on kernel that doesn't have
> +		 * "MemAvailable:" in Meminfo
> +		 */
> +		tst_res(TINFO, "MemAvailable: not found in /proc/meminfo");
> +
> +		mem_avail = SAFE_READ_MEMINFO("MemFree:");
> +	}
> +
> +	max_hpages = mem_avail / SAFE_READ_MEMINFO("Hugepagesize:");
> +
> +	if (hpages > max_hpages) {
> +		tst_res(TINFO, "Requested number(%d) of hugepages is too large, "
> +				"limiting to 80%% of the max hugepage count %ld",
> +				hpages, max_hpages);
> +		tst_hugepages = max_hpages * 0.8;

Why 80%?

Also I guess that we should check here that max_hpages * 0.8 > 1,
otherwise there is no reason to continue.

> +	}
> +
> +	tst_sys_conf_save("?/proc/sys/vm/nr_hugepages");
> +	SAFE_FILE_PRINTF(PATH_NR_HPAGES, "%d", tst_hugepages);
> +	SAFE_FILE_SCANF(PATH_NR_HPAGES, "%d", &val);
> +	if (val != tst_hugepages)
> +		tst_brk(TBROK, "nr_hugepages = %d, but expect %d", val, tst_hugepages);
> +
> +	tst_res(TINFO, "%d hugepage(s) reserved", tst_hugepages);
> +out:
> +	return tst_hugepages;
> +}
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 8d7dee2cc..9a24cffc5 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -890,6 +890,9 @@ static void do_setup(int argc, char *argv[])
>  	if (tst_test->all_filesystems)
>  		tst_test->needs_device = 1;
>  
> +	if (tst_test->request_hugepages)
> +		tst_request_hugepages(tst_test->request_hugepages);
> +
>  	setup_ipc();
>  
>  	if (tst_test->bufs)
> @@ -1006,8 +1009,7 @@ static void do_cleanup(void)
>  		tst_rmdir();
>  	}
>  
> -	if (tst_test->save_restore)
> -		tst_sys_conf_restore(0);
> +	tst_sys_conf_restore(0);
>  
>  	if (tst_test->restore_wallclock)
>  		tst_wallclock_restore();
> -- 
> 2.20.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
