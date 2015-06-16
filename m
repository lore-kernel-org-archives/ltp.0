Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z4qol-000335-18
	for ltp-list@lists.sourceforge.net; Tue, 16 Jun 2015 13:22:19 +0000
Date: Tue, 16 Jun 2015 15:21:09 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150616132109.GA17408@rei.suse.de>
References: <1434444799-29951-1-git-send-email-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1434444799-29951-1-git-send-email-liwang@redhat.com>
Subject: Re: [LTP] [PATCH] futex: regression test for take hugepages into
 account when generating futex_key
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
To: Li Wang <liwang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +#if __i386__ || __x86_64__
> +#define HUGE_SIZE (2 * 1024 * 1024)
> +
> +#elif __powerpc__ || __powerpc64__
> +#define HUGE_SIZE (16 * 1024 * 1024)
> +
> +#elif __s390__ || __s390x__
> +#define HUGE_SIZE (1 * 1024 * 1024)
> +
> +#else
> +#define HUGE_SIZE (2 * 1024 * 1024)
> +#endif

Can we use Hugepagesize from /proc/meminfo instead?

> +#define PATH_NR_HUGEPAGES "/proc/sys/vm/nr_hugepages"
> +
> +const char *TCID = "futex_wake04";
> +const int TST_TOTAL = 1;
> +
> +static futex_t *futex1, *futex2;
> +
> +static long th2_wait_time;
> +static int th2_wait_done;
> +
> +static long orig_hugepages;
> +
> +static void setup(void)
> +{
> +	tst_require_root(NULL);
> +	tst_tmpdir();
> +
> +	SAFE_FILE_SCANF(NULL, PATH_NR_HUGEPAGES, "%ld", &orig_hugepages);
> +	SAFE_FILE_PRINTF(NULL, PATH_NR_HUGEPAGES, "%d", 1);
> +
> +	TEST_PAUSE;
> +}
> +
> +static void cleanup(void)
> +{
> +	SAFE_FILE_PRINTF(NULL, PATH_NR_HUGEPAGES, "%ld", orig_hugepages);
> +
> +	tst_rmdir();
> +}
> +
> +static void *wait_thread1(void *arg LTP_ATTRIBUTE_UNUSED)
> +{
> +	futex_wait(futex1, *futex1, NULL, 0);
> +
> +	return NULL;
> +}
> +
> +static void *wait_thread2(void *arg LTP_ATTRIBUTE_UNUSED)
> +{
> +	struct timeval tv;
> +
> +	gettimeofday(&tv, NULL);
> +	th2_wait_time = tv.tv_sec;
> +	futex_wait(futex2, *futex2, NULL, 0);

Eh, futex_wait can have timeout parameter. Why don't you set the timeout
here and fail the test if the futex timeouted? That would be the
simplest solution.

> +	th2_wait_done = 1;
> +	tst_resm(TPASS, "Hi hydra, thread2 awake!");
> +
> +	return NULL;
> +}
> +
> +static void wakeup_thread2(void)
> +{
> +	void *addr;
> +	int pgsz, wait_max_time = 30;
> +	pthread_t th1, th2;
> +	struct timeval tv;
> +
> +	/*allocate some shared memory*/
> +	addr = mmap(NULL,
> +			HUGE_SIZE,
> +			PROT_READ | PROT_WRITE,
> +			MAP_SHARED | MAP_ANONYMOUS | MAP_HUGETLB,
> +			-1,
> +			0);
> +	if (addr == MAP_FAILED) {
> +		printf("errno=%d\n", errno);
> +		perror("mmap");
> +		if (errno == ENOMEM) {
> +			tst_brkm(TBROK | TERRNO, NULL,
> +				"Probably system didn't actually create any huge pages.");
> +		}
> +	}
> +
> +	pgsz = getpagesize();
> +
> +	/*apply the first subpage to futex1*/
> +	futex1 = addr;
> +	*futex1 = 0;
> +	/*apply the second subpage to futex2*/
> +	futex2 = (futex_t *)((char *)addr + pgsz);
> +	*futex2 = 0;
> +
> +	/*thread1 block on futex1 first,then thread2 block on futex2*/
> +	pthread_create(&th1, NULL, wait_thread1, NULL);
> +	sleep(2);
> +	pthread_create(&th2, NULL, wait_thread2, NULL);
> +	sleep(2);

No sleeps in testcases, you have to use proper synchronization
primitives.

If you need to run the test in several threads have a look at
futex_wake03.c how to assert that threads are sleeping on futex.

If the bug can be reproduced using child processes as well, you can use
TST_PROCESS_STATE_WAIT() to ensure children are sleeping in kernel and
tst_record_childstatus() to propagate the test result from child
process.

> +	/*try to wake up thread2*/
> +	futex_wake(futex2, 1, 0);
> +
> +	/*see if thread2 can be woke up*/
> +	while (!th2_wait_done) {
> +		gettimeofday(&tv, NULL);
> +		/*thread2 block over 30 secs, test fail*/
> +		if (tv.tv_sec > (th2_wait_time + wait_max_time)) {
> +			tst_resm(TFAIL,
> +				"Bug: wait_thread2 did not wake after %ld secs.",
> +				tv.tv_sec - th2_wait_time);
> +			break;
> +		}
> +	}
> +
> +	munmap(addr, HUGE_SIZE);

SAFE_MUNMAP()


You should also wake the second thread here and join both of them,
otherwise with test looping the program will create more and more
threads until it fails.

> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int lc;
> +
> +	tst_parse_opts(argc, argv, NULL, NULL);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++)
> +		wakeup_thread2();
> +
> +	cleanup();
> +	tst_exit();
> +}
> -- 
> 1.8.3.1
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
