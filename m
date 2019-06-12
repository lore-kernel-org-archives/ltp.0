From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 12 Jun 2019 14:22:43 +0200
Subject: [LTP] [PATCH v4 ltp] Add 4 more cases for Intel PT.
In-Reply-To: <20190604045343.32162-1-ammy.yi@intel.com>
References: <20190604045343.32162-1-ammy.yi@intel.com>
Message-ID: <20190612122243.GC4906@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

> 1. Add Intel PT sanpshot mode test.
> 2. Add Intel PT exclude user trace mode test.
> 3. Add Intel PT exclude kernel trace mode test.
> 4. Add Intel PT disable branch trace mode test.

> Signed-off-by: Ammy Yi <ammy.yi@intel.com>
> ---
>  runtest/tracing                            |  4 ++
>  testcases/kernel/tracing/pt_test/pt_test.c | 70 ++++++++++++++++++++++++------
>  2 files changed, 60 insertions(+), 14 deletions(-)

> diff --git a/runtest/tracing b/runtest/tracing
> index 504132d70..d2700ca57 100644
> --- a/runtest/tracing
> +++ b/runtest/tracing
> @@ -4,3 +4,7 @@ ftrace_regression02	ftrace_regression02.sh
>  ftrace-stress-test	ftrace_stress_test.sh 90
>  dynamic_debug01		dynamic_debug01.sh
>  pt_full_trace_basic pt_test
> +pt_snapshot_trace_basic pt_test -m
> +pt_ex_user pt_test -e user
> +pt_ex_kernel pt_test -e kernel
> +pt_disable_branch pt_test -b
> diff --git a/testcases/kernel/tracing/pt_test/pt_test.c b/testcases/kernel/tracing/pt_test/pt_test.c
> index 5feb1aa63..2cc44f1a5 100644
> --- a/testcases/kernel/tracing/pt_test/pt_test.c
> +++ b/testcases/kernel/tracing/pt_test/pt_test.c
> @@ -6,14 +6,14 @@
>   */

>  /*
> - * This test will check if Intel PT(Intel Processer Trace) full trace mode is
> - * working.
> + * This test will check if Intel PT(Intel Processer Trace) is working.
>   *
>   * Intel CPU of 5th-generation Core (Broadwell) or newer is required for the test.
>   *
>   * kconfig requirement: CONFIG_PERF_EVENTS
>   */

> +
>  #include <sched.h>
>  #include <stdlib.h>
>  #include <stdio.h>
> @@ -40,22 +40,38 @@ int fde = -1;
>  //map head and size
>  uint64_t **bufm;
>  long buhsz;
> +static char *str_mode;
> +static char *str_exclude_info;
> +static char *str_branch_flag;
> +int mode = 1;

> -static uint64_t **create_map(int fde, long bufsize)
> +static uint64_t **create_map(int fde, long bufsize, int flag)
>  {
>  	uint64_t **buf_ev;
> +	int pro_flag;
>  	struct perf_event_mmap_page *pc;

>  	buf_ev = SAFE_MALLOC(2*sizeof(uint64_t *));
>  	buf_ev[0] = NULL;
>  	buf_ev[1] = NULL;
> -	buf_ev[0] = SAFE_MMAP(NULL, INTEL_PT_MEMSIZE, PROT_READ | PROT_WRITE,
> +	if (flag == 1) {
> +		tst_res(TINFO, "memory will be r/w for full trace mode!");
> +		pro_flag = PROT_READ | PROT_WRITE;
> +	} else {
> +		tst_res(TINFO, "memory will be r only for snapshot mode!");
> +		pro_flag = PROT_READ;
> +	}
> +	buf_ev[0] = SAFE_MMAP(fde, INTEL_PT_MEMSIZE, PROT_READ | PROT_WRITE,
>  							MAP_SHARED, fde, 0);

../../../../include/tst_safe_macros.h:255:32: warning: passing argument 3 of ‘safe_mmap’ makes pointer from integer without a cast [-Wint-conversion]
  safe_mmap(__FILE__, __LINE__, (addr), (length), (prot), \
                                ^~~~~~
pt_test.c:64:14: note: in expansion of macro ‘SAFE_MMAP’
  buf_ev[0] = SAFE_MMAP(fde, INTEL_PT_MEMSIZE, PROT_READ | PROT_WRITE,
              ^~~~~~~~~
../../../../include/tst_safe_macros.h:240:37: note: expected ‘void *’ but argument is of type ‘int’
                               void *addr, size_t length,
                               ~~~~~~^~~~
Also didn't get why 1st parameter isn't NULL.
BTW there is a function (if it helps, probably not):
void *tst_get_bad_addr(void (*cleanup_fn) (void));

...

> +	attr.exclude_kernel	= 0;
> +	attr.exclude_user	= 0;
> +
> +	if (str_exclude_info && !strcmp(str_exclude_info, "user")) {
> +		tst_res(TINFO, "Intel PT will exclude user trace.");
> +		attr.exclude_user = 1;
> +	}
> +	if (str_exclude_info && !strcmp(str_exclude_info, "kernel")) {
> +		tst_res(TINFO, "Intel PT will exclude kernel trace.");
> +		attr.exclude_kernel = 1;
> +	}

Code Cyril suggested in v3 is really better (but this could be fixed
during merging):
	if (str_exclude) {
		if (!strcmp(str_exclude, "user")) {
			tst_res(TINFO, "Excluding user trace");
			attr.exclude_user = 1;
		} else if (!strcmp(str_exclude, "kernel")) {
			tst_res(TINFO, "Excluding kernel trace");
			attr.exclude_kernel = 1;
		} else {
			tst_brk(TBROK, "Invalid -e '%s'", str_exclude);
		}
	}


Kind regards,
Petr
