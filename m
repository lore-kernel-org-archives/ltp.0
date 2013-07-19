Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anders.roxell@linaro.org>) id 1V08Av-0005ui-Ta
	for ltp-list@lists.sourceforge.net; Fri, 19 Jul 2013 10:44:37 +0000
Received: from mail-lb0-f176.google.com ([209.85.217.176])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1V08Au-00019V-2r
	for ltp-list@lists.sourceforge.net; Fri, 19 Jul 2013 10:44:37 +0000
Received: by mail-lb0-f176.google.com with SMTP id z5so3274546lbh.21
	for <ltp-list@lists.sourceforge.net>;
	Fri, 19 Jul 2013 03:44:29 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
Date: Fri, 19 Jul 2013 12:44:18 +0200
Message-Id: <1374230659-21101-1-git-send-email-anders.roxell@linaro.org>
Subject: [LTP] [PATCH] update make install when enable realtime test suite
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: patches@linaro.org

Hi,

I was trying to enable --with-realtime-testsuite and run that.
However, I had some issues with installing the realtime tests and
problem with running testscripts/test_realtime.sh script.
This patch resolves the problem I had.


/Anders

Anders Roxell (1):
  realtime-testsuite: update the install rule

 testcases/realtime/func/async_handler/Makefile     |  1 +
 testcases/realtime/func/gtod_latency/Makefile      |  1 +
 testcases/realtime/func/hrtimer-prio/Makefile      |  1 +
 testcases/realtime/func/hrtimer-prio/run.sh        | 12 ----------
 testcases/realtime/func/hrtimer-prio/run_auto.sh   | 10 +++++++++
 testcases/realtime/func/matrix_mult/Makefile       |  1 +
 testcases/realtime/func/measurement/Makefile       |  1 +
 testcases/realtime/func/measurement/run.sh         | 19 ----------------
 testcases/realtime/func/measurement/run_auto.sh    | 19 ++++++++++++++++
 testcases/realtime/func/periodic_cpu_load/Makefile |  1 +
 testcases/realtime/func/pi-tests/Makefile          |  1 +
 testcases/realtime/func/pi_perf/Makefile           |  1 +
 testcases/realtime/func/prio-preempt/Makefile      |  1 +
 testcases/realtime/func/prio-wake/Makefile         |  1 +
 .../realtime/func/pthread_kill_latency/Makefile    |  1 +
 testcases/realtime/func/rt-migrate/Makefile        |  1 +
 testcases/realtime/func/sched_football/Makefile    |  1 +
 testcases/realtime/func/sched_jitter/Makefile      |  1 +
 testcases/realtime/func/sched_latency/Makefile     |  1 +
 testcases/realtime/func/thread_clock/Makefile      |  1 +
 testcases/realtime/perf/latency/Makefile           |  1 +
 testcases/realtime/profiles/Makefile               | 26 ++++++++++++++++++++++
 testcases/realtime/run.sh                          | 16 ++++++++-----
 testcases/realtime/scripts/Makefile                | 26 ++++++++++++++++++++++
 testcases/realtime/scripts/run_c_files.sh          |  7 ++++--
 testscripts/test_realtime.sh                       | 18 +++++++++------
 26 files changed, 124 insertions(+), 46 deletions(-)
 delete mode 100644 testcases/realtime/func/hrtimer-prio/run.sh
 create mode 100644 testcases/realtime/func/hrtimer-prio/run_auto.sh
 delete mode 100644 testcases/realtime/func/measurement/run.sh
 create mode 100644 testcases/realtime/func/measurement/run_auto.sh
 create mode 100644 testcases/realtime/profiles/Makefile
 create mode 100644 testcases/realtime/scripts/Makefile

-- 
1.8.1.2


------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
