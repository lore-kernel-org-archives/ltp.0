From: Li Wang <liwang@redhat.com>
Date: Thu, 27 May 2021 21:26:00 +0800
Subject: [LTP] [PATCH v2 6/6] sched/cgroup: Add cfs_bandwidth01
In-Reply-To: <20210521102528.21102-7-rpalethorpe@suse.com>
References: <20210521102528.21102-1-rpalethorpe@suse.com>
 <20210521102528.21102-7-rpalethorpe@suse.com>
Message-ID: <CAEemH2c2yTKbUyW5RQoyqOh2k0JFe3wNJwdcRfBkZD9w8SHG0w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, May 21, 2021 at 6:26 PM Richard Palethorpe via ltp
<ltp@lists.linux.it> wrote:
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  runtest/sched                                 |   1 +
>  .../kernel/sched/cfs-scheduler/.gitignore     |   1 +
>  testcases/kernel/sched/cfs-scheduler/Makefile |   4 +-
>  .../sched/cfs-scheduler/cfs_bandwidth01.c     | 175 ++++++++++++++++++
>  4 files changed, 179 insertions(+), 2 deletions(-)
>  create mode 100644 testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
>
> diff --git a/runtest/sched b/runtest/sched
> index bfc4f2711..592898723 100644
> --- a/runtest/sched
> +++ b/runtest/sched
> @@ -6,6 +6,7 @@ pth_str03 pth_str03
>  time-schedule01                time-schedule
>  trace_sched01          trace_sched -c 1
>
> +cfs_bandwidth01 cfs_bandwidth01 -i 5
>  hackbench01 hackbench 50 process 1000
>  hackbench02 hackbench 20 thread 1000
>
> diff --git a/testcases/kernel/sched/cfs-scheduler/.gitignore b/testcases/kernel/sched/cfs-scheduler/.gitignore
> index db2759e4f..c5dacd6ef 100644
> --- a/testcases/kernel/sched/cfs-scheduler/.gitignore
> +++ b/testcases/kernel/sched/cfs-scheduler/.gitignore
> @@ -1 +1,2 @@
>  /hackbench
> +cfs_bandwidth01
> diff --git a/testcases/kernel/sched/cfs-scheduler/Makefile b/testcases/kernel/sched/cfs-scheduler/Makefile
> index aa3bf8459..2ffe1f7f9 100644
> --- a/testcases/kernel/sched/cfs-scheduler/Makefile
> +++ b/testcases/kernel/sched/cfs-scheduler/Makefile
> @@ -18,8 +18,8 @@
>
>  top_srcdir             ?= ../../../..
>
> -include $(top_srcdir)/include/mk/env_pre.mk
> +include $(top_srcdir)/include/mk/testcases.mk
>
> -LDLIBS                 += -lpthread
> +hackbench: LDLIBS                      += -lpthread
>
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
> new file mode 100644
> index 000000000..7c988730e
> --- /dev/null
> +++ b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/* Copyright (c) 2021 SUSE LLC <rpalethorpe@suse.com> */
> +/*\
> + *
> + * [Description]
> + *
> + * Creates a multi-level CGroup hierarchy with the cpu controller
> + * enabled. The leaf groups are populated with "busy" processes which
> + * simulate intermittent cpu load. They spin for some time then sleep
> + * then repeat.
> + *
> + * Both the trunk and leaf groups are set cpu bandwidth limits. The
> + * busy processes will intermittently exceed these limits. Causing
> + * them to be throttled. When they begin sleeping this will then cause
> + * them to be unthrottle.
> + *
> + * The test is known to reproduce an issue with an update to
> + * SLE-15-SP1 (kernel 4.12.14-197.64, bsc#1179093).
> + */
> +
> +#include <stdlib.h>
> +
> +#include "tst_test.h"
> +#include "tst_cgroup.h"
> +#include "tst_timer.h"
> +
> +static const struct tst_cgroup_group *cg_test;
> +static struct tst_cgroup_group *cg_level2, *cg_level3a, *cg_level3b;
> +static struct tst_cgroup_group *cg_workers[3];
> +
> +static void set_cpu_quota(const struct tst_cgroup_group *const cg,
> +                         const float quota_percent)
> +{
> +       const unsigned int period_us = 10000;
> +       const unsigned int quota_us = (quota_percent / 100) * (float)period_us;
> +
> +       if (TST_CGROUP_VER(cg, "cpu") != TST_CGROUP_V1) {
> +               SAFE_CGROUP_PRINTF(cg, "cpu.max",
> +                                  "%u %u", quota_us, period_us);
> +       } else {
> +               SAFE_CGROUP_PRINTF(cg, "cpu.max",
> +                                  "%u", quota_us);
> +               SAFE_CGROUP_PRINTF(cg, "cpu.cfs_period_us",
> +                                 "%u", period_us);
> +       }
> +
> +       tst_res(TINFO, "Set '%s/cpu.max' = '%d %d'",
> +               tst_cgroup_group_name(cg), quota_us, period_us);
> +}
> +
> +static struct tst_cgroup_group *
> +mk_cpu_cgroup(const struct tst_cgroup_group *const cg_parent,
> +             const char *const cg_child_name,
> +             const float quota_percent)
> +{
> +       struct tst_cgroup_group *const cg =
> +               tst_cgroup_group_mk(cg_parent, cg_child_name);
> +
> +       set_cpu_quota(cg, quota_percent);
> +
> +       return cg;
> +}
> +
> +static void busy_loop(const unsigned int sleep_ms)
> +{
> +       for (;;) {
> +               tst_timer_start(CLOCK_MONOTONIC_RAW);
> +               while (!tst_timer_expired_ms(20))
> +                       ;
> +
> +               const int ret = tst_checkpoint_wait(0, sleep_ms);
> +
> +               if (!ret)
> +                       exit(0);
> +
> +               if (errno != ETIMEDOUT)
> +                       tst_brk(TBROK | TERRNO, "tst_checkpoint_wait");
> +       }
> +}
> +
> +static void fork_busy_procs_in_cgroup(const struct tst_cgroup_group *const cg)
> +{
> +       const unsigned int sleeps_ms[] = {3000, 1000, 10};
> +       const pid_t worker_pid = SAFE_FORK();
> +       size_t i;
> +
> +       if (worker_pid)
> +               return;
> +
> +       for (i = 0; i < ARRAY_SIZE(sleeps_ms); i++) {
> +               const pid_t busy_pid = SAFE_FORK();
> +
> +               if (!busy_pid)
> +                       busy_loop(sleeps_ms[i]);
> +
> +               SAFE_CGROUP_PRINTF(cg, "cgroup.procs", "%d", busy_pid);
> +       }
> +
> +       tst_reap_children();
> +
> +       exit(0);
> +}
> +
> +static void do_test(void)
> +{
> +       size_t i;
> +
> +       for (i = 0; i < ARRAY_SIZE(cg_workers); i++)
> +               fork_busy_procs_in_cgroup(cg_workers[i]);
> +
> +       tst_res(TPASS, "Scheduled bandwidth constrained workers");
> +
> +       sleep(1);
> +
> +       set_cpu_quota(cg_level2, 50);

This test itself looks good.
But I got a series of warnings when testing on CGroup V1:

# uname -r
4.18.0-296.el8.x86_64

[root@dhcp-66-83-181 cfs-scheduler]# ./cfs_bandwidth01
tst_test.c:1313: TINFO: Timeout per run is 0h 05m 00s
tst_buffers.c:55: TINFO: Test is using guarded buffers
cfs_bandwidth01.c:48: TINFO: Set 'worker1/cpu.max' = '3000 10000'
cfs_bandwidth01.c:48: TINFO: Set 'worker2/cpu.max' = '2000 10000'
cfs_bandwidth01.c:48: TINFO: Set 'worker3/cpu.max' = '3000 10000'
cfs_bandwidth01.c:111: TPASS: Scheduled bandwidth constrained workers
cfs_bandwidth01.c:42: TBROK:
vdprintf(10</sys/fs/cgroup/cpu,cpuacct/ltp/test-8450/level2>,
'cpu.cfs_quota_us', '%u'<5000>): EINVAL (22)
tst_cgroup.c:896: TWARN:
unlinkat(11</sys/fs/cgroup/cpu,cpuacct/ltp/test-8450/level2/level3a>,
'worker1', AT_REMOVEDIR): EBUSY (16)
tst_cgroup.c:896: TWARN:
unlinkat(11</sys/fs/cgroup/cpu,cpuacct/ltp/test-8450/level2/level3a>,
'worker2', AT_REMOVEDIR): EBUSY (16)
tst_cgroup.c:896: TWARN:
unlinkat(14</sys/fs/cgroup/cpu,cpuacct/ltp/test-8450/level2/level3b>,
'worker3', AT_REMOVEDIR): EBUSY (16)
tst_cgroup.c:896: TWARN:
unlinkat(10</sys/fs/cgroup/cpu,cpuacct/ltp/test-8450/level2>,
'level3a', AT_REMOVEDIR): EBUSY (16)
tst_cgroup.c:896: TWARN:
unlinkat(10</sys/fs/cgroup/cpu,cpuacct/ltp/test-8450/level2>,
'level3b', AT_REMOVEDIR): EBUSY (16)
tst_cgroup.c:896: TWARN:
unlinkat(9</sys/fs/cgroup/cpu,cpuacct/ltp/test-8450>, 'level2',
AT_REMOVEDIR): EBUSY (16)
tst_cgroup.c:766: TWARN: unlinkat(7</sys/fs/cgroup/cpu,cpuacct/ltp>,
'test-8450', AT_REMOVEDIR): EBUSY (16)

-- 
Regards,
Li Wang

