Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Date: Wed, 17 Mar 2010 15:35:11 +0530
From: Rishikesh K Rajak <risrajak@linux.vnet.ibm.com>
Message-ID: <20100317100511.GA23956@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [LTP] [ANNOUNCEMENT] February subversion of LTP has been released
	today
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
To: ltp-announce@lists.sourceforge.net
Cc: ltp-list@lists.sourceforge.net


Hi All,

It' great to work with you all. I am seeing little stability in build now with
latest ltp till today. And all credit goes to ltp community. This month instead
of releasing intermediate release i want to release a sub version of stable
release and please use this version in your production environment and post your
failures and patches to ltp-list.

You can directly download from : http://ltp.sourceforge.net/ under "FEBRUARY 2010
STABLE" link.

OR, directly from this link:
https://sourceforge.net/projects/ltp/files/LTP%20Source/ltp-20100228.1/ltp-full-20100228.1.tgz/download

I am releasing this as ltp-full-20100228.1 . I will really appreciate if many of
you will test this on your environment because it has major fixes w.r.t:
    - cpu hotplug
    - libevent 
    - Replace of pushd/popd
    - Container test
    - CPU controller testcases
    - New memory controller testcase (c0b8157365beb18a627fe197be6ab111e8281e86 )
    - Network test build failure
    - and many more...

Short summary:
- Total patches has been applied : 64
    - Patched which fixes :
	Build issue : 3
	Bug : 38
	Cleanup : 15
	Documentation:  8

Contributors:
    - Garrett Cooper
    - Rishikesh
    - Subrata
    - Matt Helsley
    - Yuki Yao
    - Shi Weihua
    - Maxin B. John
    - Sachin Sant
    - Naresh Kamboju
    - Mohamed Naufal Basheer

Let's test this stable tree in different environment and post your all type of
failures here. So that it can be merged to March mnoth end release.



 ChangeLog                                          | 1157 +++++++++++++++++++-
 IDcheck.sh                                         |   35 +-
 TODO                                               |   31 +-
 runltp                                             |    4 +-
 runltplite.sh                                      |    2 +-
 runtest/controllers                                |    1 +
 runtest/cpuhotplug                                 |    2 +-
 runtest/io                                         |    2 +-
 scripts/git2changelog.sh                           |   28 +
 testcases/commands/ade/ar/ar01                     |    2 +-
 testcases/commands/ade/ld/ld01                     |    2 +-
 testcases/commands/ade/ldd/ldd01                   |    2 +-
 testcases/commands/ade/nm/nm01                     |    2 +-
 testcases/commands/ade/objdump/objdump01           |    2 +-
 testcases/commands/ade/size/size01                 |    2 +-
 testcases/commands/at/at_allow01                   |    2 +-
 testcases/commands/at/at_deny01                    |    2 +-
 testcases/commands/cron/cron02                     |    2 +-
 testcases/commands/cron/cron03                     |    2 +-
 testcases/commands/cron/cron_allow01               |    2 +-
 testcases/commands/cron/cron_deny01                |    2 +-
 testcases/commands/cron/cron_dirs_checks01         |    2 +-
 testcases/commands/su/su01                         |    2 +-
 testcases/commands/su/su01_s1                      |    2 +-
 testcases/commands/unzip/unzip_tests.sh            |    4 +-
 testcases/kernel/Makefile                          |   11 +-
 testcases/kernel/containers/Makefile               |    2 +
 testcases/kernel/containers/check_for_unshare.c    |   55 +
 ...{cgroup_fj_testcases => cgroup_fj_testcases.sh} |    0
 .../kernel/controllers/freezer/libcgroup_freezer   |   73 +-
 .../kernel/controllers/freezer/run_freezer.sh      |    3 +-
 testcases/kernel/controllers/memcg/README          |   10 +
 .../kernel/controllers/memcg/control/Makefile      |   33 +
 .../kernel/controllers/memcg/control/mem_process.c |  141 +++
 .../memcg/control/memcg_control_test.sh            |  157 +++
 .../memcg/functional/memcg_function_test.sh        |    3 +-
 .../memcg/regression/memcg_regression_test.sh      |    3 +-
 .../controllers/memcg/stress/memcg_stress_test.sh  |    3 +-
 testcases/kernel/fs/acls/acl_test01                |    2 +-
 testcases/kernel/hotplug/cpu_hotplug/Makefile      |   31 +
 .../hotplug/cpu_hotplug/functional/hotplug01.sh    |  233 +++--
 .../hotplug/cpu_hotplug/functional/hotplug02.sh    |   80 +-
 .../hotplug/cpu_hotplug/functional/hotplug03.sh    |  170 ++--
 .../hotplug/cpu_hotplug/functional/hotplug04.sh    |   98 +-
 .../cpu_hotplug/functional/hotplug06.sar.sh        |  125 +--
 .../hotplug/cpu_hotplug/functional/hotplug06.sh    |   22 +-
 .../cpu_hotplug/functional/hotplug06.top.sh        |   93 +-
 .../hotplug/cpu_hotplug/functional/hotplug07.sh    |  108 +-
 .../kernel/hotplug/cpu_hotplug/include/hotplug.fns |    4 +-
 .../hotplug/cpu_hotplug/include/testsuite.fns      |    2 +-
 testcases/kernel/hotplug/cpu_hotplug/runtests.sh   |    7 +-
 .../hotplug/cpu_hotplug/tools/do_disk_write_loop   |   16 +-
 .../hotplug/cpu_hotplug/tools/do_kcompile_loop     |   14 +-
 .../kernel/hotplug/cpu_hotplug/tools/do_spin_loop  |    2 +-
 testcases/kernel/io/aio/aio02/runfstests.sh        |   50 +-
 testcases/kernel/io/direct_io/README               |    2 +-
 testcases/kernel/io/stress_floppy/stress_floppy    |    2 +-
 .../kernel/sched/sched_stress/sched_stress.sh      |    2 +-
 testcases/kernel/security/filecaps/Makefile        |    2 +-
 testcases/kernel/syscalls/libevent/Makefile.in     |    3 +-
 testcases/kernel/syscalls/libevent/buffer.c        |    5 +
 testcases/kernel/syscalls/link/link06.c            |   18 +-
 testcases/kernel/syscalls/link/link07.c            |   19 +-
 testcases/network/generate.sh                      |    2 +-
 testcases/network/multicast/mc_opts/mc_opts        |    2 +-
 testcases/network/tcp_cmds/arp/arp01               |    2 +-
 testcases/network/tcp_cmds/echo/Makefile           |    2 +-
 testcases/network/tcp_cmds/echo/echo01             |    2 +-
 testcases/network/tcp_cmds/finger/finger01         |    2 +-
 testcases/network/tcp_cmds/ftp/ftp01               |    2 +-
 testcases/network/tcp_cmds/ftp/ftp02               |    2 +-
 testcases/network/tcp_cmds/ftp/ftp02_s1            |    2 +-
 testcases/network/tcp_cmds/ftp/ftp03               |    2 +-
 testcases/network/tcp_cmds/ftp/ftp04               |    2 +-
 testcases/network/tcp_cmds/ftp/ftp05               |    2 +-
 testcases/network/tcp_cmds/host/host01             |    2 +-
 testcases/network/tcp_cmds/netstat/netstat01       |    2 +-
 testcases/network/tcp_cmds/perf_lan/perf_lan       |    2 +-
 testcases/network/tcp_cmds/ping/ping01             |    2 +-
 testcases/network/tcp_cmds/rcp/rcp01               |    2 +-
 testcases/network/tcp_cmds/rdist/rdist01           |    2 +-
 testcases/network/tcp_cmds/rlogin/rlogin01         |    2 +-
 testcases/network/tcp_cmds/rsh/rsh01               |    2 +-
 testcases/network/tcp_cmds/rwho/rwho01             |    2 +-
 testcases/network/tcp_cmds/sendfile/sendfile01     |    2 +-
 testcases/network/tcp_cmds/ssh/ssh01               |    2 +-
 testcases/network/tcp_cmds/ssh/ssh01_s1            |    2 +-
 testcases/network/tcp_cmds/ssh/ssh02               |    2 +-
 testcases/network/tcp_cmds/ssh/ssh02_s1            |    2 +-
 testcases/network/tcp_cmds/ssh/ssh03               |    2 +-
 testcases/network/tcp_cmds/ssh/ssh03_s1            |    2 +-
 testcases/network/tcp_cmds/tcpdump/tcpdump01       |    2 +-
 testcases/network/tcp_cmds/telnet/telnet01         |    2 +-
 tools/make-file.sh                                 |    2 +-
 94 files changed, 2282 insertions(+), 680 deletions(-)
 create mode 100755 scripts/git2changelog.sh
 create mode 100644 testcases/kernel/containers/check_for_unshare.c
 rename testcases/kernel/controllers/cgroup_fj/{cgroup_fj_testcases =>
cgroup_fj_testcases.sh} (100%)
 create mode 100644 testcases/kernel/controllers/memcg/control/Makefile
 create mode 100644 testcases/kernel/controllers/memcg/control/mem_process.c
 create mode 100644
testcases/kernel/controllers/memcg/control/memcg_control_test.sh
 create mode 100644 testcases/kernel/hotplug/cpu_hotplug/Makefile
-- 
Thanks & Regards
Rishi
LTP Maintainer
IBM, LTC, Bangalore
Please join IRC #ltp @ irc.freenode.net

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
