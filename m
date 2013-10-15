Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VW4i5-00047F-CM
	for ltp-list@lists.sourceforge.net; Tue, 15 Oct 2013 13:30:53 +0000
Date: Tue, 15 Oct 2013 15:30:37 +0200
From: chrubis@suse.cz
Message-ID: <20131015133036.GB25867@rei>
References: <1380881342-13025-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
In-Reply-To: <1380881342-13025-1-git-send-email-stanislav.kholmanskikh@oracle.com>
Subject: Re: [LTP] controllers/cpuset: promised patches
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net, miaox@cn.fujitsu.com


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!
> This a series promised in 'Re: [LTP] [PATCH V2 8/8] controllers/cpuset: reorganization'.

The patches looks good, but when I try to run it on SLES11 SP3 I got
failures in setup() in cpuset_funcs.sh:

TFAIL  :  Could not mount cgroup filesystem with
TWARN  :  /dev/cpuset already exists.. overwriting
mkdir: cannot create directory `/dev/cpuset': File exists
...


If I comment the code in the setup() the tests at least run, but I got a
lot of invalid arguments and errors (see bellow). This is machine with
two nodes and 24 Xeon CPUs.

And also if I su to root (not su -) the $USER stays set to whatever it
was before and the user_check() from cpuset_funcs.sh fails, but that is
easy to fix, it should use $EUID instead of $USER (as the
tst_require_root() in tst_res.c does).

-- 
Cyril Hrubis
chrubis@suse.cz

--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cpuset_logs.txt"

COMMAND:    /opt/ltp/bin/ltp-pan  -e -S   -a 16662     -n 16662  -p  -f /tmp/ltp-SNSFAaMESi/alltests -l /opt/ltp/results/LTP_RUN_ON-2013_Oct_15-15h_22m_59s.log  -C /opt/ltp/output/LTP_RUN_ON-2013_Oct_15-15h_22m_59s.failed
INFO: Restricted to cpuset_
LOG File: /opt/ltp/results/LTP_RUN_ON-2013_Oct_15-15h_22m_59s.log
FAILED COMMAND File: /opt/ltp/output/LTP_RUN_ON-2013_Oct_15-15h_22m_59s.failed
Running tests.......
<<<test_start>>>
tag=cpuset_base_ops stime=1381843380
cmdline="cpuset_base_ops_testset.sh"
contacts=""
analysis=exit
<<<test_output>>>
cpuset_base_ops    1  TPASS  :  cpus(READONLY): Get the expected string
cpuset_base_ops    2  TPASS  :  mems(READONLY): Get the expected string
cpuset_base_ops    3  TPASS  :  memory_pressure(READONLY): Get the expected string
cpuset_base_ops    4  TPASS  :  cpus: Get the expected string
cpuset_base_ops    5  TPASS  :  cpus: Get the expected string
cpuset_base_ops    6  TPASS  :  cpus: Get the expected string
cpuset_base_ops    7  TPASS  :  cpus: Get the expected string
cpuset_base_ops    8  TPASS  :  cpus: Get the expected string
cpuset_base_ops    9  TPASS  :  cpus: Get the expected string
cpuset_base_ops   10  TPASS  :  cpus: Get the expected string
cpuset_base_ops   11  TPASS  :  cpus: Get the expected string
cpuset_base_ops   12  TPASS  :  cpus: Get the expected string
cpuset_base_ops   13  TPASS  :  cpus: Get the expected string
cpuset_base_ops   14  TPASS  :  cpus: Get the expected string
cpuset_base_ops   15  TPASS  :  cpus: Get the expected string
cpuset_base_ops   16  TPASS  :  cpus: Get the expected string
cpuset_base_ops   17  TPASS  :  cpus: Get the expected string
cpuset_base_ops   18  TPASS  :  cpus: Get the expected string
cpuset_base_ops   19  TPASS  :  cpus: Get the expected string
cpuset_base_ops   20  TPASS  :  mems: Get the expected string
cpuset_base_ops   21  TPASS  :  mems: Get the expected string
cpuset_base_ops   22  TPASS  :  mems: Get the expected string
cpuset_base_ops   23  TFAIL  :  mems: Test result - 0 Expected string - "0-1"
cpuset_base_ops   24  TPASS  :  mems: Get the expected string
cpuset_base_ops   25  TPASS  :  mems: Get the expected string
cpuset_base_ops   26  TPASS  :  mems: Get the expected string
cpuset_base_ops   27  TFAIL  :  mems: Test result - 0 Expected string - "0-1"
cpuset_base_ops   28  TPASS  :  mems: Get the expected string
cpuset_base_ops   29  TPASS  :  mems: Get the expected string
cpuset_base_ops   30  TPASS  :  mems: Get the expected string
cpuset_base_ops   31  TPASS  :  mems: Get the expected string
cpuset_base_ops   32  TPASS  :  mems: Get the expected string
cpuset_base_ops   33  TPASS  :  mems: Get the expected string
cpuset_base_ops   34  TFAIL  :  cpu_exclusive: Test result - 1 Expected string - "0"
cpuset_base_ops   35  TFAIL  :  cpu_exclusive: Test result - 1 Expected string - "0"
cpuset_base_ops   36  TPASS  :  cpu_exclusive: Get the expected string
cpuset_base_ops   37  TPASS  :  cpu_exclusive: Get the expected string
cpuset_base_ops   38  TPASS  :  cpu_exclusive: Get the expected string
cpuset_base_ops   39  TPASS  :  cpu_exclusive: Get the expected string
cpuset_base_ops   40  TFAIL  :  mem_exclusive: Test result - 1 Expected string - "0"
cpuset_base_ops   41  TFAIL  :  mem_exclusive: Test result - 1 Expected string - "0"
cpuset_base_ops   42  TPASS  :  mem_exclusive: Get the expected string
cpuset_base_ops   43  TPASS  :  mem_exclusive: Get the expected string
cpuset_base_ops   44  TPASS  :  mem_exclusive: Get the expected string
cpuset_base_ops   45  TPASS  :  mem_exclusive: Get the expected string
cpuset_base_ops   46  TPASS  :  mem_hardwall: Get the expected string
cpuset_base_ops   47  TPASS  :  mem_hardwall: Get the expected string
cpuset_base_ops   48  TPASS  :  mem_hardwall: Get the expected string
cpuset_base_ops   49  TPASS  :  mem_hardwall: Get the expected string
cpuset_base_ops   50  TPASS  :  mem_hardwall: Get the expected string
cpuset_base_ops   51  TPASS  :  mem_hardwall: Get the expected string
cpuset_base_ops   52  TPASS  :  memory_migrate: Get the expected string
cpuset_base_ops   53  TPASS  :  memory_migrate: Get the expected string
cpuset_base_ops   54  TPASS  :  memory_migrate: Get the expected string
cpuset_base_ops   55  TPASS  :  memory_migrate: Get the expected string
cpuset_base_ops   56  TPASS  :  memory_migrate: Get the expected string
cpuset_base_ops   57  TPASS  :  memory_migrate: Get the expected string
cpuset_base_ops   58  TPASS  :  memory_spread_page: Get the expected string
cpuset_base_ops   59  TPASS  :  memory_spread_page: Get the expected string
cpuset_base_ops   60  TPASS  :  memory_spread_page: Get the expected string
cpuset_base_ops   61  TPASS  :  memory_spread_page: Get the expected string
cpuset_base_ops   62  TPASS  :  memory_spread_page: Get the expected string
cpuset_base_ops   63  TPASS  :  memory_spread_page: Get the expected string
cpuset_base_ops   64  TPASS  :  memory_spread_slab: Get the expected string
cpuset_base_ops   65  TPASS  :  memory_spread_slab: Get the expected string
cpuset_base_ops   66  TPASS  :  memory_spread_slab: Get the expected string
cpuset_base_ops   67  TPASS  :  memory_spread_slab: Get the expected string
cpuset_base_ops   68  TPASS  :  memory_spread_slab: Get the expected string
cpuset_base_ops   69  TPASS  :  memory_spread_slab: Get the expected string
cpuset_base_ops   70  TPASS  :  sched_load_balance: Get the expected string
cpuset_base_ops   71  TPASS  :  sched_load_balance: Get the expected string
cpuset_base_ops   72  TPASS  :  sched_load_balance: Get the expected string
cpuset_base_ops   73  TPASS  :  sched_load_balance: Get the expected string
cpuset_base_ops   74  TPASS  :  sched_load_balance: Get the expected string
cpuset_base_ops   75  TPASS  :  sched_load_balance: Get the expected string
cpuset_base_ops   76  TPASS  :  memory_pressure_enabled: Get the expected string
cpuset_base_ops   77  TPASS  :  memory_pressure_enabled: Get the expected string
cpuset_base_ops   78  TPASS  :  memory_pressure_enabled: Get the expected string
cpuset_base_ops   79  TPASS  :  memory_pressure_enabled: Get the expected string
cpuset_base_ops   80  TPASS  :  memory_pressure_enabled: Get the expected string
cpuset_base_ops   81  TPASS  :  memory_pressure_enabled: Get the expected string
mkdir: cannot create directory `/dev/cpuset/sub_cpuset': File exists
mkdir: cannot create directory `/dev/cpuset/sub_cpuset': File exists
mkdir: cannot create directory `/dev/cpuset/sub_cpuset': File exists
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=4 cstime=3
<<<test_end>>>
<<<test_start>>>
tag=cpuset_inherit stime=1381843381
cmdline="cpuset_inherit_testset.sh"
contacts=""
analysis=exit
<<<test_output>>>
cpuset_inherit    1  TFAIL  :  cpus: Test result -  Expected string - "EMPTY"
cpuset_inherit    2  TFAIL  :  cpus: Test result -  Expected string - "EMPTY"
cpuset_inherit    3  TFAIL  :  cpus: Test result -  Expected string - "EMPTY"
cpuset_inherit    4  TFAIL  :  mems: Test result -  Expected string - "EMPTY"
cpuset_inherit    5  TFAIL  :  mems: Test result -  Expected string - "EMPTY"
cpuset_inherit    6  TFAIL  :  mems: Test result -  Expected string - "EMPTY"
cpuset_inherit    7  TFAIL  :  cpu_exclusive: Test result - 0 Expected string - "0"
cpuset_inherit    8  TFAIL  :  cpu_exclusive: Test result - 0 Expected string - "0"
cpuset_inherit    9  TFAIL  :  mem_exclusive: Test result - 0 Expected string - "0"
cpuset_inherit   10  TFAIL  :  mem_exclusive: Test result - 0 Expected string - "0"
cpuset_inherit   11  TFAIL  :  mem_hardwall: Test result - 0 Expected string - "0"
cpuset_inherit   12  TFAIL  :  mem_hardwall: Test result - 0 Expected string - "0"
cpuset_inherit   13  TFAIL  :  memory_migrate: Test result - 0 Expected string - "0"
cpuset_inherit   14  TFAIL  :  memory_migrate: Test result - 0 Expected string - "0"
cpuset_inherit   15  TFAIL  :  memory_spread_page: Test result - 0 Expected string - "0"
cpuset_inherit   16  TFAIL  :  memory_spread_page: Test result - 0 Expected string - "1"
cpuset_inherit   17  TFAIL  :  memory_spread_slab: Test result - 0 Expected string - "0"
cpuset_inherit   18  TFAIL  :  memory_spread_slab: Test result - 0 Expected string - "1"
cpuset_inherit   19  TFAIL  :  sched_load_balance: Test result - 1 Expected string - "1"
cpuset_inherit   20  TFAIL  :  sched_load_balance: Test result - 1 Expected string - "1"
cpuset_inherit   21  TFAIL  :  sched_relax_domain_level: Test result - -1 Expected string - "-1"
cpuset_inherit   22  TFAIL  :  sched_relax_domain_level: Test result - -1 Expected string - "-1"
cpuset_inherit   23  TFAIL  :  sched_relax_domain_level: Test result - -1 Expected string - "-1"
cpuset_inherit   24  TFAIL  :  sched_relax_domain_level: Test result - -1 Expected string - "-1"
cpuset_inherit   25  TFAIL  :  sched_relax_domain_level: Test result - -1 Expected string - "-1"
cpuset_inherit   26  TFAIL  :  sched_relax_domain_level: Test result - -1 Expected string - "-1"
cpuset_inherit   27  TFAIL  :  sched_relax_domain_level: Test result - -1 Expected string - "-1"
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=3 cstime=3
<<<test_end>>>
<<<test_start>>>
tag=cpuset_exclusive stime=1381843381
cmdline="cpuset_exclusive_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_exclusive_test.sh: line 38: echo: write error: Device or resource busy
cpuset_exclusive    1  TFAIL  :  Break the exclusive feature.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
cpuset_exclusive    2  TPASS  :  Exclusive test succeeded.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
cpuset_exclusive    3  TPASS  :  Exclusive test succeeded.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_exclusive_test.sh: line 62: echo: write error: Device or resource busy
cpuset_exclusive    4  TFAIL  :  Break the exclusive feature.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
cpuset_exclusive    5  TPASS  :  Exclusive test succeeded.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_exclusive_test.sh: line 81: echo: write error: Invalid argument
cpuset_exclusive    6  TFAIL  :  Break the exclusive feature.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_exclusive_test.sh: line 94: echo: write error: Invalid argument
cpuset_exclusive    7  TFAIL  :  Break the exclusive feature.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_exclusive_test.sh: line 106: echo: write error: Invalid argument
cpuset_exclusive    8  TFAIL  :  Break the exclusive feature.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_exclusive_test.sh: line 118: echo: write error: Invalid argument
cpuset_exclusive    9  TFAIL  :  Break the exclusive feature.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_exclusive_test.sh: line 131: echo: write error: Device or resource busy
cpuset_exclusive   10  TFAIL  :  Break the exclusive feature.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
cpuset_exclusive   11  TPASS  :  Exclusive test succeeded.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
cpuset_exclusive   12  TPASS  :  Exclusive test succeeded.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_exclusive_test.sh: line 155: echo: write error: Device or resource busy
cpuset_exclusive   13  TFAIL  :  Break the exclusive feature.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
cpuset_exclusive   14  TPASS  :  Exclusive test succeeded.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_exclusive_test.sh: line 174: echo: write error: Invalid argument
cpuset_exclusive   15  TFAIL  :  Break the exclusive feature.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_exclusive_test.sh: line 187: echo: write error: Invalid argument
cpuset_exclusive   16  TFAIL  :  Break the exclusive feature.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_exclusive_test.sh: line 199: echo: write error: Invalid argument
cpuset_exclusive   17  TFAIL  :  Break the exclusive feature.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_exclusive_test.sh: line 211: echo: write error: Invalid argument
cpuset_exclusive   18  TFAIL  :  Break the exclusive feature.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=3 cstime=0
<<<test_end>>>
<<<test_start>>>
tag=cpuset_hierarchy stime=1381843381
cmdline="cpuset_hierarchy_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
cpuset_hierarchy    0  TINFO  :  father cpus 
cpuset_hierarchy    0  TINFO  :  child cpus 
cpuset_hierarchy    1  TPASS  :  Hierarchy test succeeded.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
cpuset_hierarchy    0  TINFO  :  father cpus 
cpuset_hierarchy    0  TINFO  :  child cpus 
cpuset_hierarchy    2  TPASS  :  Hierarchy test succeeded.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 69: echo: write error: Invalid argument
cpuset_hierarchy    3  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 81: echo: write error: Invalid argument
cpuset_hierarchy    4  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 93: echo: write error: Invalid argument
cpuset_hierarchy    5  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 105: echo: write error: Invalid argument
cpuset_hierarchy    6  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 117: echo: write error: Invalid argument
cpuset_hierarchy    7  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 129: echo: write error: Invalid argument
cpuset_hierarchy    8  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 141: echo: write error: Invalid argument
cpuset_hierarchy    9  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 154: echo: write error: Invalid argument
cpuset_hierarchy   10  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 167: echo: write error: Invalid argument
cpuset_hierarchy   11  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 180: echo: write error: Invalid argument
cpuset_hierarchy   12  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 193: echo: write error: Invalid argument
cpuset_hierarchy   13  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 206: echo: write error: Invalid argument
cpuset_hierarchy   14  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 219: echo: write error: Invalid argument
cpuset_hierarchy   15  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 232: echo: write error: Invalid argument
cpuset_hierarchy   16  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
cpuset_hierarchy    0  TINFO  :  father mems 
cpuset_hierarchy    0  TINFO  :  child mems 
cpuset_hierarchy   17  TPASS  :  Hierarchy test succeeded.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
cpuset_hierarchy    0  TINFO  :  father mems 
cpuset_hierarchy    0  TINFO  :  child mems 
cpuset_hierarchy   18  TPASS  :  Hierarchy test succeeded.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 271: echo: write error: Invalid argument
cpuset_hierarchy   19  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 283: echo: write error: Invalid argument
cpuset_hierarchy   20  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 295: echo: write error: Invalid argument
cpuset_hierarchy   21  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 307: echo: write error: Invalid argument
cpuset_hierarchy   22  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 319: echo: write error: Invalid argument
cpuset_hierarchy   23  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 331: echo: write error: Invalid argument
cpuset_hierarchy   24  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 343: echo: write error: Invalid argument
cpuset_hierarchy   25  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 356: echo: write error: Invalid argument
cpuset_hierarchy   26  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 369: echo: write error: Invalid argument
cpuset_hierarchy   27  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 382: echo: write error: Invalid argument
cpuset_hierarchy   28  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 395: echo: write error: Invalid argument
cpuset_hierarchy   29  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 408: echo: write error: Invalid argument
cpuset_hierarchy   30  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 421: echo: write error: Invalid argument
cpuset_hierarchy   31  TFAIL  :  Break the hierarchy limit.
mkdir: cannot create directory `/dev/cpuset/father': File exists
mkdir: cannot create directory `/dev/cpuset/father/child': File exists
/opt/ltp/testcases/bin/cpuset_hierarchy_test.sh: line 434: echo: write error: Invalid argument
cpuset_hierarchy   32  TFAIL  :  Break the hierarchy limit.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=3 cstime=2
<<<test_end>>>
<<<test_start>>>
tag=cpuset_syscall stime=1381843381
cmdline="cpuset_syscall_testset.sh"
contacts=""
analysis=exit
<<<test_output>>>
/opt/ltp/testcases/bin/cpuset_syscall_testset.sh: line 63: echo: write error: Invalid argument
cpuset_syscall    1  TFAIL  :  set /dev/cpuset/0/mems as 0 fail.
/opt/ltp/testcases/bin/cpuset_syscall_testset.sh: line 63: echo: write error: Invalid argument
cpuset_syscall    2  TFAIL  :  set /dev/cpuset/0/mems as 0 fail.
/opt/ltp/testcases/bin/cpuset_syscall_testset.sh: line 63: echo: write error: Invalid argument
cpuset_syscall    3  TFAIL  :  set /dev/cpuset/0/mems as 0 fail.
/opt/ltp/testcases/bin/cpuset_syscall_testset.sh: line 63: echo: write error: Invalid argument
cpuset_syscall    4  TFAIL  :  set /dev/cpuset/0/mems as 0 fail.
/opt/ltp/testcases/bin/cpuset_syscall_testset.sh: line 63: echo: write error: Invalid argument
cpuset_syscall    5  TFAIL  :  set /dev/cpuset/0/mems as 0 fail.
/opt/ltp/testcases/bin/cpuset_syscall_testset.sh: line 63: echo: write error: Invalid argument
cpuset_syscall    6  TFAIL  :  set /dev/cpuset/0/mems as 0 fail.
/opt/ltp/testcases/bin/cpuset_syscall_testset.sh: line 63: echo: write error: Invalid argument
cpuset_syscall    7  TFAIL  :  set /dev/cpuset/0/mems as 0 fail.
/opt/ltp/testcases/bin/cpuset_syscall_testset.sh: line 63: echo: write error: Invalid argument
cpuset_syscall    8  TFAIL  :  set /dev/cpuset/0/mems as 0-1 fail.
/opt/ltp/testcases/bin/cpuset_syscall_testset.sh: line 63: echo: write error: Invalid argument
cpuset_syscall    9  TFAIL  :  set /dev/cpuset/0/mems as 0-1 fail.
/opt/ltp/testcases/bin/cpuset_syscall_testset.sh: line 63: echo: write error: Invalid argument
cpuset_syscall   10  TFAIL  :  set /dev/cpuset/0/mems as 0 fail.
/opt/ltp/testcases/bin/cpuset_syscall_testset.sh: line 63: echo: write error: Invalid argument
cpuset_syscall   11  TFAIL  :  set /dev/cpuset/0/mems as 0 fail.
/opt/ltp/testcases/bin/cpuset_syscall_testset.sh: line 63: echo: write error: Invalid argument
cpuset_syscall   12  TFAIL  :  set /dev/cpuset/0/mems as 0-1 fail.
/opt/ltp/testcases/bin/cpuset_syscall_testset.sh: line 63: echo: write error: Invalid argument
cpuset_syscall   13  TFAIL  :  set /dev/cpuset/0/mems as 0-1 fail.
/opt/ltp/testcases/bin/cpuset_syscall_testset.sh: line 63: echo: write error: Invalid argument
cpuset_syscall   14  TFAIL  :  set /dev/cpuset/0/mems as 0 fail.
/opt/ltp/testcases/bin/cpuset_syscall_testset.sh: line 63: echo: write error: Invalid argument
cpuset_syscall   15  TFAIL  :  set /dev/cpuset/0/mems as 0 fail.
/opt/ltp/testcases/bin/cpuset_syscall_testset.sh: line 63: echo: write error: Invalid argument
cpuset_syscall   16  TFAIL  :  set /dev/cpuset/0/mems as 0-1 fail.
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=2 cstime=1
<<<test_end>>>
<<<test_start>>>
tag=cpuset_sched_domains stime=1381843382
cmdline="cpuset_sched_domains_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
cpuset_sched_domains    0  TINFO  :  root group load balance test
cpuset_sched_domains    0  TINFO  :       sched load balance: 0
cpuset_sched_domains    0  TINFO  :  CPU hotplug:
cpuset_check_domains    1  TPASS  :  check_sched_domains passed
cpuset_sched_domains    1  TPASS  :  partition sched domains succeeded.
cpuset_sched_domains    0  TINFO  :  root group load balance test
cpuset_sched_domains    0  TINFO  :       sched load balance: 1
cpuset_sched_domains    0  TINFO  :  CPU hotplug:
cpuset_check_domains    1  TPASS  :  check_sched_domains passed
cpuset_sched_domains    2  TPASS  :  partition sched domains succeeded.
cpuset_sched_domains    0  TINFO  :  root group load balance test
cpuset_sched_domains    0  TINFO  :       sched load balance: 0
cpuset_sched_domains    0  TINFO  :  CPU hotplug:
cpuset_check_domains    1  TPASS  :  check_sched_domains passed
cpuset_sched_domains    3  TPASS  :  partition sched domains succeeded.
cpuset_sched_domains    0  TINFO  :  root group load balance test
cpuset_sched_domains    0  TINFO  :       sched load balance: 0
cpuset_sched_domains    0  TINFO  :  CPU hotplug:
cpuset_check_domains    1  TPASS  :  check_sched_domains passed
cpuset_sched_domains    4  TPASS  :  partition sched domains succeeded.
cpuset_sched_domains    0  TINFO  :  root group load balance test
cpuset_sched_domains    0  TINFO  :       sched load balance: 1
cpuset_sched_domains    0  TINFO  :  CPU hotplug:
cpuset_check_domains    1  TPASS  :  check_sched_domains passed
cpuset_sched_domains    5  TPASS  :  partition sched domains succeeded.
cpuset_sched_domains    0  TINFO  :  root group load balance test
cpuset_sched_domains    0  TINFO  :       sched load balance: 1
cpuset_sched_domains    0  TINFO  :  CPU hotplug:
cpuset_check_domains    1  TPASS  :  check_sched_domains passed
cpuset_sched_domains    6  TPASS  :  partition sched domains succeeded.
cpuset_sched_domains    0  TINFO  :  general group load balance test
cpuset_sched_domains    0  TINFO  :  root group info:
cpuset_sched_domains    0  TINFO  :       sched load balance: 0
cpuset_sched_domains    0  TINFO  :  general group info:
cpuset_sched_domains    0  TINFO  :       cpus: -
cpuset_sched_domains    0  TINFO  :       sched load balance: 1
cpuset_sched_domains    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_sched_domains    7  TFAIL  :  set general group parameter failed.
cpuset_sched_domains    0  TINFO  :  general group load balance test
cpuset_sched_domains    0  TINFO  :  root group info:
cpuset_sched_domains    0  TINFO  :       sched load balance: 0
cpuset_sched_domains    0  TINFO  :  general group info:
cpuset_sched_domains    0  TINFO  :       cpus: 1
cpuset_sched_domains    0  TINFO  :       sched load balance: 0
cpuset_sched_domains    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_sched_domains    8  TFAIL  :  set general group parameter failed.
cpuset_sched_domains    0  TINFO  :  general group load balance test
cpuset_sched_domains    0  TINFO  :  root group info:
cpuset_sched_domains    0  TINFO  :       sched load balance: 1
cpuset_sched_domains    0  TINFO  :  general group info:
cpuset_sched_domains    0  TINFO  :       cpus: -
cpuset_sched_domains    0  TINFO  :       sched load balance: 1
cpuset_sched_domains    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_sched_domains    9  TFAIL  :  set general group parameter failed.
cpuset_sched_domains    0  TINFO  :  general group load balance test
cpuset_sched_domains    0  TINFO  :  root group info:
cpuset_sched_domains    0  TINFO  :       sched load balance: 1
cpuset_sched_domains    0  TINFO  :  general group info:
cpuset_sched_domains    0  TINFO  :       cpus: 1
cpuset_sched_domains    0  TINFO  :       sched load balance: 1
cpuset_sched_domains    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_sched_domains   10  TFAIL  :  set general group parameter failed.
cpuset_sched_domains    0  TINFO  :  general group load balance test
cpuset_sched_domains    0  TINFO  :  root group info:
cpuset_sched_domains    0  TINFO  :       sched load balance: 0
cpuset_sched_domains    0  TINFO  :  general group info:
cpuset_sched_domains    0  TINFO  :       cpus: 1,2
cpuset_sched_domains    0  TINFO  :       sched load balance: 0
cpuset_sched_domains    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_sched_domains   11  TFAIL  :  set general group parameter failed.
cpuset_sched_domains    0  TINFO  :  general group load balance test
cpuset_sched_domains    0  TINFO  :  root group info:
cpuset_sched_domains    0  TINFO  :       sched load balance: 0
cpuset_sched_domains    0  TINFO  :  general group info:
cpuset_sched_domains    0  TINFO  :       cpus: 1,2
cpuset_sched_domains    0  TINFO  :       sched load balance: 1
cpuset_sched_domains    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_sched_domains   12  TFAIL  :  set general group parameter failed.
cpuset_sched_domains    0  TINFO  :  general group load balance test
cpuset_sched_domains    0  TINFO  :  root group info:
cpuset_sched_domains    0  TINFO  :       sched load balance: 0
cpuset_sched_domains    0  TINFO  :  general group info:
cpuset_sched_domains    0  TINFO  :       cpus: 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23
cpuset_sched_domains    0  TINFO  :       sched load balance: 1
cpuset_sched_domains    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_sched_domains   13  TFAIL  :  set general group parameter failed.
cpuset_sched_domains    0  TINFO  :  general group load balance test
cpuset_sched_domains    0  TINFO  :  root group info:
cpuset_sched_domains    0  TINFO  :       sched load balance: 0
cpuset_sched_domains    0  TINFO  :  general group1 info:
cpuset_sched_domains    0  TINFO  :       cpus: 1
cpuset_sched_domains    0  TINFO  :       sched load balance: 1
cpuset_sched_domains    0  TINFO  :  general group2 info:
cpuset_sched_domains    0  TINFO  :       cpus: 0
cpuset_sched_domains    0  TINFO  :       sched load balance: 1
cpuset_sched_domains    0  TINFO  :  CPU hotplug: none
cpuset_sched_domains    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_sched_domains   14  TFAIL  :  set general group1 parameter failed.
cpuset_sched_domains    0  TINFO  :  general group load balance test
cpuset_sched_domains    0  TINFO  :  root group info:
cpuset_sched_domains    0  TINFO  :       sched load balance: 0
cpuset_sched_domains    0  TINFO  :  general group1 info:
cpuset_sched_domains    0  TINFO  :       cpus: 1,2
cpuset_sched_domains    0  TINFO  :       sched load balance: 1
cpuset_sched_domains    0  TINFO  :  general group2 info:
cpuset_sched_domains    0  TINFO  :       cpus: 0-3
cpuset_sched_domains    0  TINFO  :       sched load balance: 0
cpuset_sched_domains    0  TINFO  :  CPU hotplug: none
cpuset_sched_domains    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_sched_domains   15  TFAIL  :  set general group1 parameter failed.
cpuset_sched_domains    0  TINFO  :  general group load balance test
cpuset_sched_domains    0  TINFO  :  root group info:
cpuset_sched_domains    0  TINFO  :       sched load balance: 0
cpuset_sched_domains    0  TINFO  :  general group1 info:
cpuset_sched_domains    0  TINFO  :       cpus: 1,2
cpuset_sched_domains    0  TINFO  :       sched load balance: 1
cpuset_sched_domains    0  TINFO  :  general group2 info:
cpuset_sched_domains    0  TINFO  :       cpus: 0,3
cpuset_sched_domains    0  TINFO  :       sched load balance: 1
cpuset_sched_domains    0  TINFO  :  CPU hotplug: none
cpuset_sched_domains    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_sched_domains   16  TFAIL  :  set general group1 parameter failed.
cpuset_sched_domains    0  TINFO  :  general group load balance test
cpuset_sched_domains    0  TINFO  :  root group info:
cpuset_sched_domains    0  TINFO  :       sched load balance: 0
cpuset_sched_domains    0  TINFO  :  general group1 info:
cpuset_sched_domains    0  TINFO  :       cpus: 1,2
cpuset_sched_domains    0  TINFO  :       sched load balance: 1
cpuset_sched_domains    0  TINFO  :  general group2 info:
cpuset_sched_domains    0  TINFO  :       cpus: 1,3
cpuset_sched_domains    0  TINFO  :       sched load balance: 1
cpuset_sched_domains    0  TINFO  :  CPU hotplug: none
cpuset_sched_domains    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_sched_domains   17  TFAIL  :  set general group1 parameter failed.
cpuset_sched_domains    0  TINFO  :  general group load balance test
cpuset_sched_domains    0  TINFO  :  root group info:
cpuset_sched_domains    0  TINFO  :       sched load balance: 0
cpuset_sched_domains    0  TINFO  :  general group1 info:
cpuset_sched_domains    0  TINFO  :       cpus: 1,2
cpuset_sched_domains    0  TINFO  :       sched load balance: 1
cpuset_sched_domains    0  TINFO  :  general group2 info:
cpuset_sched_domains    0  TINFO  :       cpus: 1,3
cpuset_sched_domains    0  TINFO  :       sched load balance: 1
cpuset_sched_domains    0  TINFO  :  CPU hotplug: offline
cpuset_sched_domains    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_sched_domains   18  TFAIL  :  set general group1 parameter failed.
cpuset_sched_domains    0  TINFO  :  general group load balance test
cpuset_sched_domains    0  TINFO  :  root group info:
cpuset_sched_domains    0  TINFO  :       sched load balance: 0
cpuset_sched_domains    0  TINFO  :  general group1 info:
cpuset_sched_domains    0  TINFO  :       cpus: 1,2
cpuset_sched_domains    0  TINFO  :       sched load balance: 1
cpuset_sched_domains    0  TINFO  :  general group2 info:
cpuset_sched_domains    0  TINFO  :       cpus: 1,3
cpuset_sched_domains    0  TINFO  :       sched load balance: 1
cpuset_sched_domains    0  TINFO  :  CPU hotplug: online
cpuset_sched_domains    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_sched_domains   19  TFAIL  :  set general group1 parameter failed.
<<<execution_status>>>
initiation_status="ok"
duration=6 termination_type=exited termination_id=1 corefile=no
cutime=10 cstime=9
<<<test_end>>>
<<<test_start>>>
tag=cpuset_load_balance stime=1381843388
cmdline="cpuset_load_balance_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
cpuset_load_balance    0  TINFO  :  general group load balance test
cpuset_load_balance    0  TINFO  :  root group info:
cpuset_load_balance    0  TINFO  :       sched load balance: 0
cpuset_load_balance    0  TINFO  :  general group info:
cpuset_load_balance    0  TINFO  :       cpus: -
cpuset_load_balance    0  TINFO  :       sched load balance: 1
cpuset_load_balance    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_load_balance    1  TFAIL  :  set general group parameter failed.
cpuset_load_balance    0  TINFO  :  general group load balance test
cpuset_load_balance    0  TINFO  :  root group info:
cpuset_load_balance    0  TINFO  :       sched load balance: 0
cpuset_load_balance    0  TINFO  :  general group info:
cpuset_load_balance    0  TINFO  :       cpus: 1
cpuset_load_balance    0  TINFO  :       sched load balance: 0
cpuset_load_balance    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_load_balance    2  TFAIL  :  set general group parameter failed.
cpuset_load_balance    0  TINFO  :  general group load balance test
cpuset_load_balance    0  TINFO  :  root group info:
cpuset_load_balance    0  TINFO  :       sched load balance: 1
cpuset_load_balance    0  TINFO  :  general group info:
cpuset_load_balance    0  TINFO  :       cpus: -
cpuset_load_balance    0  TINFO  :       sched load balance: 1
cpuset_load_balance    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_load_balance    3  TFAIL  :  set general group parameter failed.
cpuset_load_balance    0  TINFO  :  general group load balance test
cpuset_load_balance    0  TINFO  :  root group info:
cpuset_load_balance    0  TINFO  :       sched load balance: 1
cpuset_load_balance    0  TINFO  :  general group info:
cpuset_load_balance    0  TINFO  :       cpus: 1
cpuset_load_balance    0  TINFO  :       sched load balance: 1
cpuset_load_balance    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_load_balance    4  TFAIL  :  set general group parameter failed.
cpuset_load_balance    0  TINFO  :  general group load balance test
cpuset_load_balance    0  TINFO  :  root group info:
cpuset_load_balance    0  TINFO  :       sched load balance: 0
cpuset_load_balance    0  TINFO  :  general group info:
cpuset_load_balance    0  TINFO  :       cpus: 1,2
cpuset_load_balance    0  TINFO  :       sched load balance: 0
cpuset_load_balance    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_load_balance    5  TFAIL  :  set general group parameter failed.
cpuset_load_balance    0  TINFO  :  general group load balance test
cpuset_load_balance    0  TINFO  :  root group info:
cpuset_load_balance    0  TINFO  :       sched load balance: 0
cpuset_load_balance    0  TINFO  :  general group info:
cpuset_load_balance    0  TINFO  :       cpus: 1,2
cpuset_load_balance    0  TINFO  :       sched load balance: 1
cpuset_load_balance    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_load_balance    6  TFAIL  :  set general group parameter failed.
cpuset_load_balance    0  TINFO  :  general group load balance test
cpuset_load_balance    0  TINFO  :  root group info:
cpuset_load_balance    0  TINFO  :       sched load balance: 0
cpuset_load_balance    0  TINFO  :  general group info:
cpuset_load_balance    0  TINFO  :       cpus: 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23
cpuset_load_balance    0  TINFO  :       sched load balance: 1
cpuset_load_balance    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_load_balance    7  TFAIL  :  set general group parameter failed.
cpuset_load_balance    0  TINFO  :  general group load balance test
cpuset_load_balance    0  TINFO  :  root group info:
cpuset_load_balance    0  TINFO  :       sched load balance: 0
cpuset_load_balance    0  TINFO  :  general group1 info:
cpuset_load_balance    0  TINFO  :       cpus: 1
cpuset_load_balance    0  TINFO  :       sched load balance: 1
cpuset_load_balance    0  TINFO  :  general group2 info:
cpuset_load_balance    0  TINFO  :       cpus: 0
cpuset_load_balance    0  TINFO  :       sched load balance: 1
cpuset_load_balance    0  TINFO  :  CPU hotplug: none
cpuset_load_balance    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_load_balance    8  TFAIL  :  set general group1 parameter failed.
cpuset_load_balance    0  TINFO  :  general group load balance test
cpuset_load_balance    0  TINFO  :  root group info:
cpuset_load_balance    0  TINFO  :       sched load balance: 0
cpuset_load_balance    0  TINFO  :  general group1 info:
cpuset_load_balance    0  TINFO  :       cpus: 1,2
cpuset_load_balance    0  TINFO  :       sched load balance: 1
cpuset_load_balance    0  TINFO  :  general group2 info:
cpuset_load_balance    0  TINFO  :       cpus: 0-3
cpuset_load_balance    0  TINFO  :       sched load balance: 0
cpuset_load_balance    0  TINFO  :  CPU hotplug: none
cpuset_load_balance    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_load_balance    9  TFAIL  :  set general group1 parameter failed.
cpuset_load_balance    0  TINFO  :  general group load balance test
cpuset_load_balance    0  TINFO  :  root group info:
cpuset_load_balance    0  TINFO  :       sched load balance: 0
cpuset_load_balance    0  TINFO  :  general group1 info:
cpuset_load_balance    0  TINFO  :       cpus: 1,2
cpuset_load_balance    0  TINFO  :       sched load balance: 1
cpuset_load_balance    0  TINFO  :  general group2 info:
cpuset_load_balance    0  TINFO  :       cpus: 0,3
cpuset_load_balance    0  TINFO  :       sched load balance: 1
cpuset_load_balance    0  TINFO  :  CPU hotplug: none
cpuset_load_balance    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_load_balance   10  TFAIL  :  set general group1 parameter failed.
cpuset_load_balance    0  TINFO  :  general group load balance test
cpuset_load_balance    0  TINFO  :  root group info:
cpuset_load_balance    0  TINFO  :       sched load balance: 0
cpuset_load_balance    0  TINFO  :  general group1 info:
cpuset_load_balance    0  TINFO  :       cpus: 1,2
cpuset_load_balance    0  TINFO  :       sched load balance: 1
cpuset_load_balance    0  TINFO  :  general group2 info:
cpuset_load_balance    0  TINFO  :       cpus: 1,3
cpuset_load_balance    0  TINFO  :       sched load balance: 1
cpuset_load_balance    0  TINFO  :  CPU hotplug: none
cpuset_load_balance    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_load_balance   11  TFAIL  :  set general group1 parameter failed.
cpuset_load_balance    0  TINFO  :  general group load balance test
cpuset_load_balance    0  TINFO  :  root group info:
cpuset_load_balance    0  TINFO  :       sched load balance: 0
cpuset_load_balance    0  TINFO  :  general group1 info:
cpuset_load_balance    0  TINFO  :       cpus: 1,2
cpuset_load_balance    0  TINFO  :       sched load balance: 1
cpuset_load_balance    0  TINFO  :  general group2 info:
cpuset_load_balance    0  TINFO  :       cpus: 1,3
cpuset_load_balance    0  TINFO  :       sched load balance: 1
cpuset_load_balance    0  TINFO  :  CPU hotplug: offline
cpuset_load_balance    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_load_balance   12  TFAIL  :  set general group1 parameter failed.
cpuset_load_balance    0  TINFO  :  general group load balance test
cpuset_load_balance    0  TINFO  :  root group info:
cpuset_load_balance    0  TINFO  :       sched load balance: 0
cpuset_load_balance    0  TINFO  :  general group1 info:
cpuset_load_balance    0  TINFO  :       cpus: 1,2
cpuset_load_balance    0  TINFO  :       sched load balance: 1
cpuset_load_balance    0  TINFO  :  general group2 info:
cpuset_load_balance    0  TINFO  :       cpus: 1,3
cpuset_load_balance    0  TINFO  :       sched load balance: 1
cpuset_load_balance    0  TINFO  :  CPU hotplug: online
cpuset_load_balance    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_load_balance   13  TFAIL  :  set general group1 parameter failed.
<<<execution_status>>>
initiation_status="ok"
duration=1 termination_type=exited termination_id=1 corefile=no
cutime=5 cstime=6
<<<test_end>>>
<<<test_start>>>
tag=cpuset_hotplug stime=1381843389
cmdline="cpuset_hotplug_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
cpuset_hotplug    1  TFAIL  :  task's allowed list isn't expected.(Result: 0-31, Expect: 0-23)
/opt/ltp/testcases/bin/cpuset_funcs.sh: line 238: 19057 Killed                  /bin/cat /dev/zero > /dev/null 2>&1
cpuset_hotplug    2  TFAIL  :  task's allowed list isn't expected.(Result: 0-31, Expect: 0-23)
/opt/ltp/testcases/bin/cpuset_hotplug_test.sh: line 259: 19116 Killed                  /bin/cat /dev/zero > /dev/null 2>&1
cpuset_hotplug    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_hotplug    3  TFAIL  :  set general group parameter failed.
cpuset_hotplug    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_hotplug    4  TFAIL  :  set general group parameter failed.
cpuset_hotplug    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_hotplug    5  TFAIL  :  set general group parameter failed.
cpuset_hotplug    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_hotplug    6  TFAIL  :  set general group parameter failed.
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=1 cstime=29
<<<test_end>>>
<<<test_start>>>
tag=cpuset_memory stime=1381843389
cmdline="cpuset_memory_testset.sh"
contacts=""
analysis=exit
<<<test_output>>>
cpuset_memory    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_memory    1  TFAIL  :  set general group parameter failed.
cpuset_memory    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_memory    2  TFAIL  :  set general group parameter failed.
cpuset_memory    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_memory    3  TFAIL  :  set general group parameter failed.
cpuset_memory    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_memory    4  TFAIL  :  set general group parameter failed.
cpuset_memory    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_memory    5  TFAIL  :  set general group parameter failed.
cpuset_memory    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_memory    6  TFAIL  :  set general group parameter failed.
cpuset_memory    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_memory    7  TFAIL  :  set general group parameter failed.
cpuset_memory    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_memory    8  TFAIL  :  set general group parameter failed.
cpuset_memory    9  TPASS  :  Cpuset memory allocation test succeeded.
cpuset_memory   10  TFAIL  :  Allocated memory was moved to the Node#1(Expect: Node#0).
cpuset_memory   11  TPASS  :  Cpuset memory allocation test succeeded.
/opt/ltp/testcases/bin/cpuset_memory_testset.sh: line 387: echo: write error: Invalid argument
cpuset_memory   12  TFAIL  :  allocate memory on the Node#(Expect: Node#1).
/opt/ltp/testcases/bin/cpuset_memory_testset.sh: line 387: echo: write error: Invalid argument
cpuset_memory   13  TFAIL  :  allocate memory on the Node#(Expect: Node#1).
cpuset_memory   14  TPASS  :  Cpuset memory allocation test succeeded.
cpuset_memory   15  TPASS  :  Cpuset memory allocation test succeeded.
cpuset_memory   16  TPASS  :  Cpuset memory allocation test succeeded.
cpuset_memory    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_memory   17  TFAIL  :  set general group1's parameter failed.
cpuset_memory    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_memory   18  TFAIL  :  set general group1's parameter failed.
<<<execution_status>>>
initiation_status="ok"
duration=26 termination_type=exited termination_id=1 corefile=no
cutime=3 cstime=5
<<<test_end>>>
<<<test_start>>>
tag=cpuset_memory_pressure stime=1381843415
cmdline="cpuset_memory_pressure_testset.sh"
contacts=""
analysis=exit
<<<test_output>>>
cpuset_memory_pressure    1  TPASS  :  Cpuset memory pressure test succeeded.
cpuset_memory_pressure    2  TPASS  :  Cpuset memory pressure test succeeded.
cpuset_memory_pressure    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_memory_pressure    3  TFAIL  :  set general group parameter failed.
cpuset_memory_pressure    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_memory_pressure    4  TFAIL  :  set general group parameter failed.
cpuset_memory_pressure    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_memory_pressure    5  TFAIL  :  set general group parameter failed.
cpuset_memory_pressure    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_memory_pressure    6  TFAIL  :  set general group parameter failed.
<<<execution_status>>>
initiation_status="ok"
duration=5 termination_type=exited termination_id=1 corefile=no
cutime=290 cstime=271
<<<test_end>>>
<<<test_start>>>
tag=cpuset_memory_spread stime=1381843420
cmdline="cpuset_memory_spread_testset.sh"
contacts=""
analysis=exit
<<<test_output>>>
100+0 records in
100+0 records out
104857600 bytes (105 MB) copied, 0.116792 s, 898 MB/s
cpuset_memory_spread    1  TPASS  :  Cpuset memory spread page test succeeded.
cpuset_memory_spread    2  TPASS  :  Cpuset memory spread page test succeeded.
cpuset_memory_spread    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_memory_spread    3  TFAIL  :  set general group parameter failed.
cpuset_memory_spread    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_memory_spread    4  TFAIL  :  set general group parameter failed.
cpuset_memory_spread    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_memory_spread    5  TFAIL  :  set general group parameter failed.
cpuset_memory_spread    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_memory_spread    6  TFAIL  :  set general group parameter failed.
cpuset_memory_spread    0  TINFO  :  /bin/echo: write error: Invalid argument
cpuset_memory_spread    7  TFAIL  :  set general group parameter failed.
incrementing stop
<<<execution_status>>>
initiation_status="ok"
duration=7 termination_type=exited termination_id=1 corefile=no
cutime=6 cstime=88
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20130904-53-g4982156

       ###############################################################

            Done executing testcases.
            LTP Version:  20130904-53-g4982156
       ###############################################################


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--OXfL5xGRrasGEqWY--

