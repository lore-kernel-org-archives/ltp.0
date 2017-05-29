From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 29 May 2017 11:53:25 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] syscalls: Add timer measurement library
In-Reply-To: <20170526123354.8564-1-chrubis@suse.cz>
References: <20170526123354.8564-1-chrubis@suse.cz>
Message-ID: <775099814.23313843.1496073205696.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> This commit adds a timer measurement library, mostly based on changes
> done to the pselect01.c test and changes all tests that measure timer
> precision to use it.
> 
> The timer testcases that measure timeouts now just define sampling function
> and
> optional setup and cleanup. The rest of the functionality is implemented in
> the
> lib/tst_timer_test.c library. This change not only removes fair amount of
> duplicated code but also allows us to tune thresholds and define testcases in
> a
> single place for all testcases.
> 
> The timer measurement library also supports for passing sleep time and
> number of iterations as a command-line parameters, can print nifty
> frequency plot into the terminal, as well as save test measurements into
> a text file.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  include/tst_timer.h                                |  26 ++
>  include/tst_timer_test.h                           |  74 ++++
>  lib/tst_timer_test.c                               | 434
>  +++++++++++++++++++++
>  runtest/syscalls                                   |   1 +
>  testcases/kernel/syscalls/.gitignore               |   1 +
>  .../syscalls/clock_nanosleep/clock_nanosleep01.c   |  67 +---
>  .../syscalls/clock_nanosleep/clock_nanosleep02.c   |  49 +++
>  .../kernel/syscalls/epoll_wait/epoll_wait02.c      | 125 ++----
>  testcases/kernel/syscalls/futex/futex_wait05.c     |  61 +--
>  testcases/kernel/syscalls/nanosleep/nanosleep01.c  |  56 +--
>  testcases/kernel/syscalls/poll/poll02.c            | 104 ++---
>  testcases/kernel/syscalls/pselect/pselect01.c      | 161 ++------
>  testcases/kernel/syscalls/select/select04.c        | 103 ++---
>  13 files changed, 746 insertions(+), 516 deletions(-)
>  create mode 100644 include/tst_timer_test.h
>  create mode 100644 lib/tst_timer_test.c
>  create mode 100644
>  testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep02.c
> 
> diff --git a/include/tst_timer.h b/include/tst_timer.h
> index f0a10bd45..0448f4428 100644
> --- a/include/tst_timer.h
> +++ b/include/tst_timer.h
> @@ -77,6 +77,32 @@ static inline struct timeval tst_us_to_timeval(long long
> us)
>  }
>  
>  /*
> + * Converts ms to struct timespec
> + */
> +static inline struct timespec tst_ms_to_timespec(long long us)

Hi,

us -> ms

> +{
> +	struct timespec ret;
> +
> +	ret.tv_sec = us / 1000;
> +	ret.tv_nsec = (us % 1000) * 1000000;
> +
> +	return ret;
> +}
> +

<snip>

> +
> +struct tst_timer_test {
> +	const char *scall;
> +	int (*sample)(int clk_id, long long usec);
> +	void (*setup)(void);
> +	void (*cleanup)(void);
> +};

I'd rather keep tst_test struct and expose some new function,
that would do all of this. 

void test_all()
{
    tst_timer_test("select()", test_sample_function);
}

void tst_timer_test(fn_name, test_sample_function)
{
  timer_parse_options();
  timer_setup();
  for n ... {
     do_timer_test(timer_tcases[n].usec, timer_tcases[n].samples, test_sample_function);
  }
  timer_cleanup();
}

What I'm afraid of is that we end up mirror-ing lot of functionality
in tst_test struct: needsroot, tmpdir, kernelversion, extra parameter


> +void do_timer_test(long long usec, unsigned int nsamples)
> +{
> +	long long trunc_mean, median;
> +	unsigned int discard = compute_discard(nsamples);
> +	unsigned int keep_samples = nsamples - discard;
> +	long long threshold = compute_threshold(usec, keep_samples);
> +	unsigned int i;
> +	int failed = 0;
> +
> +	tst_res(TINFO,
> +		"%s sleeping for %llius %u iterations, threshold %.2fus",
> +		timer_test->scall, usec, nsamples,
> +		1.00 * threshold / (keep_samples));
> +
> +	cur_sample = 0;
> +	for (i = 0; i < nsamples; i++) {
> +		if (timer_test->sample(CLOCK_REALTIME, usec)) {

Since we use resolution of monotonic clock, should we also
measure with it here?

> +			tst_res(TINFO, "sampling function failed, exitting");
> +			return;
> +		}
> +	}
> +
> +	qsort(samples, nsamples, sizeof(samples[0]), cmp);
> +
> +	write_to_file();
> +
> +	for (i = 0; samples[i] > 10 * usec; i++) {

This could also use a range check for length of samples array,
just in case all samples are outliners.

Regards,
Jan

