From: Li Wang <liwang@redhat.com>
Date: Mon, 31 May 2021 13:33:35 +0800
Subject: [LTP] [PATCH v2 6/6] sched/cgroup: Add cfs_bandwidth01
In-Reply-To: <87k0njjj11.fsf@suse.de>
References: <20210521102528.21102-1-rpalethorpe@suse.com>
 <20210521102528.21102-7-rpalethorpe@suse.com>
 <CAEemH2c2yTKbUyW5RQoyqOh2k0JFe3wNJwdcRfBkZD9w8SHG0w@mail.gmail.com>
 <87k0njjj11.fsf@suse.de>
Message-ID: <CAEemH2fww4Zwqh6E_C+R9erUpXbebKUzS2eHe4JT9LXnsgLUGQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

> >> +static void do_test(void)
> >> +{
> >> +       size_t i;
> >> +
> >> +       for (i = 0; i < ARRAY_SIZE(cg_workers); i++)
> >> +               fork_busy_procs_in_cgroup(cg_workers[i]);
> >> +
> >> +       tst_res(TPASS, "Scheduled bandwidth constrained workers");
> >> +
> >> +       sleep(1);
> >> +
> >> +       set_cpu_quota(cg_level2, 50);
> >
> > This test itself looks good.
> > But I got a series of warnings when testing on CGroup V1:
>
> Thanks for testing it.
>
> >
> > # uname -r
> > 4.18.0-296.el8.x86_64
> >
> > [root@dhcp-66-83-181 cfs-scheduler]# ./cfs_bandwidth01
> > tst_test.c:1313: TINFO: Timeout per run is 0h 05m 00s
> > tst_buffers.c:55: TINFO: Test is using guarded buffers
> > cfs_bandwidth01.c:48: TINFO: Set 'worker1/cpu.max' = '3000 10000'
> > cfs_bandwidth01.c:48: TINFO: Set 'worker2/cpu.max' = '2000 10000'
> > cfs_bandwidth01.c:48: TINFO: Set 'worker3/cpu.max' = '3000 10000'
> > cfs_bandwidth01.c:111: TPASS: Scheduled bandwidth constrained workers
> > cfs_bandwidth01.c:42: TBROK:
> > vdprintf(10</sys/fs/cgroup/cpu,cpuacct/ltp/test-8450/level2>,
> > 'cpu.cfs_quota_us', '%u'<5000>): EINVAL (22)
>
> I wonder if your kernel disallows setting this on a trunk node after it
> has been set on leaf nodes (with or without procs in)?

After looking a while, I think the CGrup V1 disallows the parent quota
less than the max value of its children.

This means we should set in level2 at least '3000/10000', just like what
we did for level3.

  cfs_bandwidth01.c:48: TINFO: Set 'worker1/cpu.max' = '3000 10000'
  cfs_bandwidth01.c:48: TINFO: Set 'worker2/cpu.max' = '2000 10000'
  cfs_bandwidth01.c:48: TINFO: Set 'worker3/cpu.max' = '3000 10000'

But in the failure, it shows level2 only set to 5000/100000 (far less than
3000/10000), that's because function set_cpu_quota changes the system
default value 'cpu.cfs_period_us' from 100000 to 10000.

To verify my suppose, I got all PASS when changing it back to default 100000.

--- a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
+++ b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
@@ -31,7 +31,7 @@ static struct tst_cgroup_group *cg_workers[3];
 static void set_cpu_quota(const struct tst_cgroup_group *const cg,
                          const float quota_percent)
 {
-       const unsigned int period_us = 10000;
+       const unsigned int period_us = 100000;
        const unsigned int quota_us = (quota_percent / 100) * (float)period_us;

        if (TST_CGROUP_VER(cg, "cpu") != TST_CGROUP_V1) {


# ./cfs_bandwidth01
tst_test.c:1313: TINFO: Timeout per run is 0h 05m 00s
tst_buffers.c:55: TINFO: Test is using guarded buffers
cfs_bandwidth01.c:48: TINFO: Set 'worker1/cpu.max' = '30000 100000'
cfs_bandwidth01.c:48: TINFO: Set 'worker2/cpu.max' = '20000 100000'
cfs_bandwidth01.c:48: TINFO: Set 'worker3/cpu.max' = '30000 100000'
cfs_bandwidth01.c:111: TPASS: Scheduled bandwidth constrained workers
cfs_bandwidth01.c:48: TINFO: Set 'level2/cpu.max' = '50000 100000'
cfs_bandwidth01.c:122: TPASS: Workers exited

Summary:
passed   2
failed   0
broken   0
skipped  0
warnings 0


> > unlinkat(10</sys/fs/cgroup/cpu,cpuacct/ltp/test-8450/level2>,
> > 'level3b', AT_REMOVEDIR): EBUSY (16)
> > tst_cgroup.c:896: TWARN:
> > unlinkat(9</sys/fs/cgroup/cpu,cpuacct/ltp/test-8450>, 'level2',
> > AT_REMOVEDIR): EBUSY (16)
> > tst_cgroup.c:766: TWARN: unlinkat(7</sys/fs/cgroup/cpu,cpuacct/ltp>,
> > 'test-8450', AT_REMOVEDIR): EBUSY (16)
>
> This happens because the child processes are still running at cleanup
> because we skipped stopping them. I guess I should fix that.

+1

Patchset looks good with adding the above two fixes.

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

