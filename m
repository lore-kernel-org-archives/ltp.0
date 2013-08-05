Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anders.roxell@linaro.org>) id 1V6Inc-0007GY-7v
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 11:18:04 +0000
Received: from mail-lb0-f180.google.com ([209.85.217.180])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1V6Ina-0006P9-DF
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 11:18:04 +0000
Received: by mail-lb0-f180.google.com with SMTP id a16so1936948lbj.25
	for <ltp-list@lists.sourceforge.net>;
	Mon, 05 Aug 2013 04:17:55 -0700 (PDT)
Date: Mon, 5 Aug 2013 13:21:41 +0200
From: Anders Roxell <anders.roxell@linaro.org>
Message-ID: <20130805112141.GB4640@nexon.se>
References: <1374230659-21101-1-git-send-email-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1374230659-21101-1-git-send-email-anders.roxell@linaro.org>
Subject: Re: [LTP] [PATCH] update make install when enable realtime test
	suite
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
To: ltp-list@lists.sourceforge.net
Cc: patches@linaro.org

Ping

/Anders

On 2013-07-19 12:44, Anders Roxell wrote:
> Hi,
> 
> I was trying to enable --with-realtime-testsuite and run that.
> However, I had some issues with installing the realtime tests and
> problem with running testscripts/test_realtime.sh script.
> This patch resolves the problem I had.
> 
> 
> /Anders
> 
> Anders Roxell (1):
>   realtime-testsuite: update the install rule
> 
>  testcases/realtime/func/async_handler/Makefile     |  1 +
>  testcases/realtime/func/gtod_latency/Makefile      |  1 +
>  testcases/realtime/func/hrtimer-prio/Makefile      |  1 +
>  testcases/realtime/func/hrtimer-prio/run.sh        | 12 ----------
>  testcases/realtime/func/hrtimer-prio/run_auto.sh   | 10 +++++++++
>  testcases/realtime/func/matrix_mult/Makefile       |  1 +
>  testcases/realtime/func/measurement/Makefile       |  1 +
>  testcases/realtime/func/measurement/run.sh         | 19 ----------------
>  testcases/realtime/func/measurement/run_auto.sh    | 19 ++++++++++++++++
>  testcases/realtime/func/periodic_cpu_load/Makefile |  1 +
>  testcases/realtime/func/pi-tests/Makefile          |  1 +
>  testcases/realtime/func/pi_perf/Makefile           |  1 +
>  testcases/realtime/func/prio-preempt/Makefile      |  1 +
>  testcases/realtime/func/prio-wake/Makefile         |  1 +
>  .../realtime/func/pthread_kill_latency/Makefile    |  1 +
>  testcases/realtime/func/rt-migrate/Makefile        |  1 +
>  testcases/realtime/func/sched_football/Makefile    |  1 +
>  testcases/realtime/func/sched_jitter/Makefile      |  1 +
>  testcases/realtime/func/sched_latency/Makefile     |  1 +
>  testcases/realtime/func/thread_clock/Makefile      |  1 +
>  testcases/realtime/perf/latency/Makefile           |  1 +
>  testcases/realtime/profiles/Makefile               | 26 ++++++++++++++++++++++
>  testcases/realtime/run.sh                          | 16 ++++++++-----
>  testcases/realtime/scripts/Makefile                | 26 ++++++++++++++++++++++
>  testcases/realtime/scripts/run_c_files.sh          |  7 ++++--
>  testscripts/test_realtime.sh                       | 18 +++++++++------
>  26 files changed, 124 insertions(+), 46 deletions(-)
>  delete mode 100644 testcases/realtime/func/hrtimer-prio/run.sh
>  create mode 100644 testcases/realtime/func/hrtimer-prio/run_auto.sh
>  delete mode 100644 testcases/realtime/func/measurement/run.sh
>  create mode 100644 testcases/realtime/func/measurement/run_auto.sh
>  create mode 100644 testcases/realtime/profiles/Makefile
>  create mode 100644 testcases/realtime/scripts/Makefile
> 
> -- 
> 1.8.1.2
> 

-- 
Anders Roxell
anders.roxell@linaro.org
M: +46 709 71 42 85 | IRC: roxell

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
