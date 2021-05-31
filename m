From: Li Wang <liwang@redhat.com>
Date: Mon, 31 May 2021 14:02:30 +0800
Subject: [LTP] [PATCH v2 6/6] sched/cgroup: Add cfs_bandwidth01
In-Reply-To: <CAEemH2fww4Zwqh6E_C+R9erUpXbebKUzS2eHe4JT9LXnsgLUGQ@mail.gmail.com>
References: <20210521102528.21102-1-rpalethorpe@suse.com>
 <20210521102528.21102-7-rpalethorpe@suse.com>
 <CAEemH2c2yTKbUyW5RQoyqOh2k0JFe3wNJwdcRfBkZD9w8SHG0w@mail.gmail.com>
 <87k0njjj11.fsf@suse.de>
 <CAEemH2fww4Zwqh6E_C+R9erUpXbebKUzS2eHe4JT9LXnsgLUGQ@mail.gmail.com>
Message-ID: <CAEemH2dTr7vDjdEJ3TsoPnQMM6TSk7-0dPX0yC2Emd1z+8vDFg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> > > [root@dhcp-66-83-181 cfs-scheduler]# ./cfs_bandwidth01
> > > tst_test.c:1313: TINFO: Timeout per run is 0h 05m 00s
> > > tst_buffers.c:55: TINFO: Test is using guarded buffers
> > > cfs_bandwidth01.c:48: TINFO: Set 'worker1/cpu.max' = '3000 10000'
> > > cfs_bandwidth01.c:48: TINFO: Set 'worker2/cpu.max' = '2000 10000'
> > > cfs_bandwidth01.c:48: TINFO: Set 'worker3/cpu.max' = '3000 10000'
> > > cfs_bandwidth01.c:111: TPASS: Scheduled bandwidth constrained workers
> > > cfs_bandwidth01.c:42: TBROK:
> > > vdprintf(10</sys/fs/cgroup/cpu,cpuacct/ltp/test-8450/level2>,
> > > 'cpu.cfs_quota_us', '%u'<5000>): EINVAL (22)
> >
> > I wonder if your kernel disallows setting this on a trunk node after it
> > has been set on leaf nodes (with or without procs in)?
>
> After looking a while, I think the CGrup V1 disallows the parent quota
> less than the max value of its children.
>
> This means we should set in level2 at least '3000/10000', just like what
> we did for level3.
>
>   cfs_bandwidth01.c:48: TINFO: Set 'worker1/cpu.max' = '3000 10000'
>   cfs_bandwidth01.c:48: TINFO: Set 'worker2/cpu.max' = '2000 10000'
>   cfs_bandwidth01.c:48: TINFO: Set 'worker3/cpu.max' = '3000 10000'
>
> But in the failure, it shows level2 only set to 5000/100000 (far less than
> 3000/10000), that's because function set_cpu_quota changes the system
> default value 'cpu.cfs_period_us' from 100000 to 10000.

Or, just reverse the code order to set cfs_period_us first, that also works.

--- a/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
+++ b/testcases/kernel/sched/cfs-scheduler/cfs_bandwidth01.c
@@ -38,10 +38,10 @@ static void set_cpu_quota(const struct
tst_cgroup_group *const cg,
                SAFE_CGROUP_PRINTF(cg, "cpu.max",
                                   "%u %u", quota_us, period_us);
        } else {
-               SAFE_CGROUP_PRINTF(cg, "cpu.max",
-                                  "%u", quota_us);
                SAFE_CGROUP_PRINTF(cg, "cpu.cfs_period_us",
                                  "%u", period_us);
+               SAFE_CGROUP_PRINTF(cg, "cpu.max",
+                                  "%u", quota_us);
        }


-- 
Regards,
Li Wang

