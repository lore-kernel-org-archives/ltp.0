Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anders.roxell@linaro.org>) id 1V6Q3l-0006sA-9a
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 19:03:13 +0000
Received: from mail-lb0-f175.google.com ([209.85.217.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1V6Q3j-0005mC-Fd
	for ltp-list@lists.sourceforge.net; Mon, 05 Aug 2013 19:03:13 +0000
Received: by mail-lb0-f175.google.com with SMTP id 13so2384677lba.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 05 Aug 2013 12:03:04 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
Date: Mon,  5 Aug 2013 21:02:53 +0200
Message-Id: <1375729379-16469-1-git-send-email-anders.roxell@linaro.org>
Subject: [LTP] [PATCHv2 0/6] update make install when enable realtime test
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net
Cc: patches@linaro.org

Hi,

Split up previous patch sent to this mailing list.

/Anders

Anders Roxell (6):
  realtime/(func|perf)/: rename run.sh to run_auto.sh
  added run_auto.sh to install targets for realtime tests
  realtime tests: added additional install targets
  realtime tests: created Makefiles for profiles/scripts
  realtime: only build tests if needed
  Remove reference to "java", missed in commit 78596957

 testcases/realtime/func/async_handler/Makefile     |    1 +
 testcases/realtime/func/gtod_latency/Makefile      |    1 +
 testcases/realtime/func/hrtimer-prio/Makefile      |    1 +
 testcases/realtime/func/hrtimer-prio/run.sh        |   12 ------
 testcases/realtime/func/hrtimer-prio/run_auto.sh   |   10 +++++
 testcases/realtime/func/matrix_mult/Makefile       |    1 +
 testcases/realtime/func/measurement/Makefile       |    1 +
 testcases/realtime/func/measurement/run.sh         |   19 ---------
 testcases/realtime/func/measurement/run_auto.sh    |   19 +++++++++
 testcases/realtime/func/periodic_cpu_load/Makefile |    1 +
 testcases/realtime/func/pi-tests/Makefile          |    1 +
 testcases/realtime/func/pi_perf/Makefile           |    1 +
 testcases/realtime/func/prio-preempt/Makefile      |    1 +
 testcases/realtime/func/prio-wake/Makefile         |    1 +
 .../realtime/func/pthread_kill_latency/Makefile    |    1 +
 testcases/realtime/func/rt-migrate/Makefile        |    1 +
 testcases/realtime/func/sched_football/Makefile    |    1 +
 testcases/realtime/func/sched_jitter/Makefile      |    1 +
 testcases/realtime/func/sched_latency/Makefile     |    1 +
 testcases/realtime/func/thread_clock/Makefile      |    1 +
 testcases/realtime/perf/latency/Makefile           |    1 +
 testcases/realtime/perf/latency/run.sh             |   45 --------------------
 testcases/realtime/perf/latency/run_auto.sh        |   45 ++++++++++++++++++++
 testcases/realtime/profiles/Makefile               |   26 +++++++++++
 testcases/realtime/run.sh                          |   16 ++++---
 testcases/realtime/scripts/Makefile                |   26 +++++++++++
 testcases/realtime/scripts/run_c_files.sh          |    7 ++-
 testscripts/test_realtime.sh                       |   18 +++++---
 28 files changed, 169 insertions(+), 91 deletions(-)
 delete mode 100644 testcases/realtime/func/hrtimer-prio/run.sh
 create mode 100644 testcases/realtime/func/hrtimer-prio/run_auto.sh
 delete mode 100644 testcases/realtime/func/measurement/run.sh
 create mode 100644 testcases/realtime/func/measurement/run_auto.sh
 delete mode 100755 testcases/realtime/perf/latency/run.sh
 create mode 100755 testcases/realtime/perf/latency/run_auto.sh
 create mode 100644 testcases/realtime/profiles/Makefile
 create mode 100644 testcases/realtime/scripts/Makefile

-- 
1.7.10.4


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
