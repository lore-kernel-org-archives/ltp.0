Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Qm6dj-0007nh-03
	for ltp-list@lists.sourceforge.net; Wed, 27 Jul 2011 16:07:19 +0000
Date: Wed, 27 Jul 2011 18:10:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110727161000.GA21916@saboteur.suse.cz>
References: <145b91763d3c2670cd736cc7fa3072c9a6db219a.1311676572.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <145b91763d3c2670cd736cc7fa3072c9a6db219a.1311676572.git.czhang@redhat.com>
Subject: Re: [LTP] [PATCH] [syscalls] getrusage04: new testcase
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> +#define RUSAGE_THREAD 1

Shouldn't this be set in system headers?

And even if not, it probably would be on newer systems so better way
should be:

#ifndef RUSAGE_THREAD
#define RUSAGE_THREAD 1
#endif

> +static void busyloop(int wait);
> +static void setup(void);
> +static void cleanup(void);
> +
> +int main(int argc, char *argv[])
> +{
> +	struct rusage usage;
> +	unsigned long ulast, udelta, slast, sdelta;
> +	int i, lc;
> +	char *msg;
> +
> +	msg = parse_opts(argc, argv, NULL, NULL);
> +	if (msg != NULL)
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +
> +	setup();
> +
> +	for (lc = 0; TEST_LOOPING(lc); lc++) {
> +		Tst_count = 0; i = 0;
> +		ulast = 0, slast = 0;
> +		SAFE_GETRUSAGE(cleanup, RUSAGE_THREAD, &usage);
> +		tst_resm(TINFO, "utime:%12luus; stime:%12luus",
> +			usage.ru_utime.tv_usec, usage.ru_stime.tv_usec);
> +		while (i < RECORD_MAX) {
> +			SAFE_GETRUSAGE(cleanup, RUSAGE_THREAD, &usage);
> +			udelta = usage.ru_utime.tv_usec - ulast;
> +			sdelta = usage.ru_stime.tv_usec - slast;
> +			if (udelta > 0 || sdelta > 0) {
> +				i++;
> +				tst_resm(TINFO, "utime:%12luus; stime:%12luus",
> +					    usage.ru_utime.tv_usec,
> +					    usage.ru_stime.tv_usec);
> +				if (udelta > 1000+BIAS_MAX)
> +					tst_brkm(TFAIL, cleanup,
> +						    "utime increased > 1000us:"
> +						    " delta = %luus", udelta);
> +				if (sdelta > 1000+BIAS_MAX)
> +					tst_brkm(TFAIL, cleanup,
> +						    "stime increased > 1000us:"
> +						    " delta = %luus", sdelta);
> +			}
> +			ulast = usage.ru_utime.tv_usec;
> +			slast = usage.ru_stime.tv_usec;

Hmm, you are actually looping the test for RECORD_MAX and then the whole
test in test loop. Is there really need for that redundancy?  Shouldn't
be running the test with -i 20 sufficient?

> +			busyloop(100000);
> +		}
> +	}
> +	cleanup();
> +	tst_exit();
> +}
> +
> +static void busyloop(int wait)
> +{
> +	int i, j = 0;
> +
> +	for (i = 0; i < wait; i++)
> +		j = j * 3 + 11;

The j = j * 3 + 11 line would likely by removed by compiler
optimalization.

Also if you wan't to create bussy loop that loops for some microseconds
you can use posix timers for that. Something like:


void sighandler(int sig)
{
	signal_flag = 0;
}

void bussy_loop(void)
{
	while (signal_flag);
}

...


timer_create()

...

signal_flag = 1;
timer_settime();
bussy_loop();

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Got Input?   Slashdot Needs You.
Take our quick survey online.  Come on, we don't ask for help often.
Plus, you'll get a chance to win $100 to spend on ThinkGeek.
http://p.sf.net/sfu/slashdot-survey
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
