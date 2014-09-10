Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XRjf4-0000oQ-2Y
	for ltp-list@lists.sourceforge.net; Wed, 10 Sep 2014 15:18:22 +0000
Date: Wed, 10 Sep 2014 17:18:05 +0200
From: chrubis@suse.cz
Message-ID: <20140910151804.GA16633@rei>
References: <8a36059fe9afea205712b2a1c9a0ca678b22b927.1410353116.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8a36059fe9afea205712b2a1c9a0ca678b22b927.1410353116.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] add clock_gettime04
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +#define SAFE_PTHREAD(fn, ...) do { \
> +	int ret = fn(__VA_ARGS__); \
> +	if (ret) { \
> +		TEST_ERRNO = ret; \
> +		tst_brkm(TBROK | TTERRNO, cleanup, #fn); \
                                   ^
				 We have TRERRNO for the case of pthread
				 functions.
> +	} \
> +} while (0)
> +
> +char *TCID = "clock_gettime04";
> +int TST_TOTAL = 1;
> +
> +static volatile sig_atomic_t done_testing;
> +static int opt_testtime;
> +static char *opt_testtimestr;
> +static option_t options[] = {
> +	{"T:", &opt_testtime, &opt_testtimestr},

There is no need to use both opt_testtime and opt_testtimestr, you can
do just:

	if (opt_testtimestr) {
		...
	}

> +	{NULL, NULL, NULL}
> +};
> +static pthread_mutex_t exit_mutex = PTHREAD_MUTEX_INITIALIZER;
> +
> +static void setup(void);
> +static void cleanup(void);
> +
> +static void sigproc(int sig)
> +{
> +	(void) sig;
> +	done_testing = 1;
> +}

Shouldn't we rather do:

	if (!done_testing)
		done_testing = 1;

Because as far as I can see the alarm may stil fire between
one of the threads set done_testing to 2 and the if (done_testing == 1)
message.

> +int64_t get_thread_cpu_time(pthread_t thread)
> +{
> +	clockid_t clockid;
> +	int ret;
> +	struct timespec tp;
> +
> +	SAFE_PTHREAD(pthread_getcpuclockid, thread, &clockid);
> +
> +	ret = clock_gettime(clockid, &tp);
> +	if (ret)
> +		tst_brkm(TBROK | TERRNO, cleanup, "clock_gettime: %d", ret);
> +
> +	return (tp.tv_sec * NANOSECS_PER_SEC) + tp.tv_nsec;
> +}
> +
> +static void *child(void *arg)
> +{
> +	struct timespec tim;
> +	int64_t t, t_last = 0;
> +	int check_own_cpu_time = *(int *)arg;
> +
> +	tim.tv_sec = 0;
> +	tim.tv_nsec = 5000;
> +
> +	while (!done_testing) {
> +		nanosleep(&tim, NULL);
> +
> +		if (!check_own_cpu_time)
> +			continue;
> +
> +		t = get_thread_cpu_time(pthread_self());
> +		if (t < t_last) {
> +			tst_resm(TFAIL, "t: %" PRId64 " < t_last: %"
> +				PRId64,	t, t_last);
> +			done_testing = 2;
> +		} else {
> +			t_last = t;
> +		}
> +	}
> +
> +	SAFE_PTHREAD(pthread_mutex_lock, &exit_mutex);
> +	SAFE_PTHREAD(pthread_mutex_unlock, &exit_mutex);
> +
> +	return NULL;
> +}
> +
> +static void test(int seconds)
> +{
> +	int i, child_check_cpu_time[] = { 0, 1 };
> +	pthread_t thread[THREAD_COUNT];
> +	clockid_t clockid[THREAD_COUNT];
> +	int64_t thread_time[THREAD_COUNT], cur_time;
> +
> +	done_testing = 0;
> +	alarm(seconds);
> +
> +	/* create children and make every 2nd child check its own
> +	 * cpu time as well. */
> +	for (i = 0; i < THREAD_COUNT; i++) {
> +		SAFE_PTHREAD(pthread_create, &thread[i], NULL, child,
> +			&child_check_cpu_time[i % 2]);
> +		SAFE_PTHREAD(pthread_getcpuclockid, thread[i], &clockid[i]);
> +		tst_resm(TINFO, "thread no.: %d clockid: %d", i, clockid[i]);
> +	}
> +
> +	for (i = 0; i < THREAD_COUNT; i++)
> +		thread_time[i] = get_thread_cpu_time(thread[i]);
> +
> +	SAFE_PTHREAD(pthread_mutex_lock, &exit_mutex);

Hmm, shouldn't this mutex be locked before we create the threads
because otherwise some threads may have exited allready.

> +	/* check periodically that cpu time of each thread
> +	 * doesn't go backwards */
> +	while (!done_testing) {
> +		for (i = 0; i < THREAD_COUNT; i++) {
> +			cur_time = get_thread_cpu_time(thread[i]);
> +			if (cur_time < thread_time[i]) {
> +				tst_resm(TFAIL, "cpu clock time went backwards "
> +						"thread no. %d, clock id: %d"
> +						" previous value: %" PRId64
> +						" current value: %" PRId64,
> +						i, clockid[i], thread_time[i],
> +						cur_time);
> +				done_testing = 2;
> +				break;
> +			}
> +			thread_time[i] = cur_time;
> +		}
> +	}
> +
> +	/* allow children to exit now */
> +	SAFE_PTHREAD(pthread_mutex_unlock, &exit_mutex);
> +
> +	for (i = 0; i < THREAD_COUNT; i++)
> +		SAFE_PTHREAD(pthread_join, thread[i], NULL);
> +
> +	if (done_testing == 1)
> +		tst_resm(TPASS, "Test completed, cpu times of all "
> +				"thread clocks were monotonic");
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int testtime = DEFAULT_TEST_TIME;
> +	const char *msg = NULL;
> +
> +	msg = parse_opts(argc, argv, options, NULL);
> +	if (msg)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	if (opt_testtime) {
> +		testtime = atoi(opt_testtimestr);
> +		if (testtime <= 0) {
> +			tst_brkm(TBROK, NULL, "Invalid arg for -T: %s",
> +				opt_testtimestr);
> +		}
> +	}
> +
> +	setup();
> +
> +	test(testtime);

Shouldn't the test(testtime) be still inside the for () loop with
TEST_LOOPING() because otherwise the test will gladly accept and ignore
the standard parameters (-i -I etc).

Otherwise it looks OK to me.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Want excitement?
Manually upgrade your production database.
When you want reliability, choose Perforce
Perforce version control. Predictably reliable.
http://pubads.g.doubleclick.net/gampad/clk?id=157508191&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
