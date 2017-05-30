From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 30 May 2017 14:15:02 +0200
Subject: [LTP] [RFC] [PATCH] syscalls: Add timer measurement library
In-Reply-To: <775099814.23313843.1496073205696.JavaMail.zimbra@redhat.com>
References: <20170526123354.8564-1-chrubis@suse.cz>
 <775099814.23313843.1496073205696.JavaMail.zimbra@redhat.com>
Message-ID: <20170530121501.GC24720@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +
> > +struct tst_timer_test {
> > +	const char *scall;
> > +	int (*sample)(int clk_id, long long usec);
> > +	void (*setup)(void);
> > +	void (*cleanup)(void);
> > +};
> 
> I'd rather keep tst_test struct and expose some new function,
> that would do all of this. 
> 
> void test_all()
> {
>     tst_timer_test("select()", test_sample_function);
> }
> 
> void tst_timer_test(fn_name, test_sample_function)
> {
>   timer_parse_options();
>   timer_setup();
>   for n ... {
>      do_timer_test(timer_tcases[n].usec, timer_tcases[n].samples, test_sample_function);
>   }
>   timer_cleanup();
> }
> 
> What I'm afraid of is that we end up mirror-ing lot of functionality
> in tst_test struct: needsroot, tmpdir, kernelversion, extra parameter

Hmm, we can also fill in the standard tst_test structure in the test
then "override" some of the fields in the timer test library.

I.e. test defines tst_test structure and the sampling function, timer
library main() stores and replaces setup & cleanup, sets the test
function then calls the tst_run_tcases() function. Does that sound
better?

> > +void do_timer_test(long long usec, unsigned int nsamples)
> > +{
> > +	long long trunc_mean, median;
> > +	unsigned int discard = compute_discard(nsamples);
> > +	unsigned int keep_samples = nsamples - discard;
> > +	long long threshold = compute_threshold(usec, keep_samples);
> > +	unsigned int i;
> > +	int failed = 0;
> > +
> > +	tst_res(TINFO,
> > +		"%s sleeping for %llius %u iterations, threshold %.2fus",
> > +		timer_test->scall, usec, nsamples,
> > +		1.00 * threshold / (keep_samples));
> > +
> > +	cur_sample = 0;
> > +	for (i = 0; i < nsamples; i++) {
> > +		if (timer_test->sample(CLOCK_REALTIME, usec)) {
> 
> Since we use resolution of monotonic clock, should we also
> measure with it here?

Ah, my bad, I've put wrong clock ID here by accident. Also I've been
thinking if we should use CLOCK_MONOTONIC_RAW if it's available then
fallback to CLOCK_MONOTONIC. Since CLOCK_MONOTONIC may be subject to
ntpd adjustements. Also can you try with CLOCK_MONOTONIC_RAW on moonshot
to see if that makes any difference?

> > +			tst_res(TINFO, "sampling function failed, exitting");
> > +			return;
> > +		}
> > +	}
> > +
> > +	qsort(samples, nsamples, sizeof(samples[0]), cmp);
> > +
> > +	write_to_file();
> > +
> > +	for (i = 0; samples[i] > 10 * usec; i++) {
> 
> This could also use a range check for length of samples array,
> just in case all samples are outliners.

Good catch.

-- 
Cyril Hrubis
chrubis@suse.cz
