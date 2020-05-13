From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 13 May 2020 11:40:15 -0400 (EDT)
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel=095=2E7?=
 =?utf-8?q?=2E0-rc5-51f14e2=2Ecki_=28arm-next=29?=
In-Reply-To: <1322199095.22739428.1589365183678.JavaMail.zimbra@redhat.com>
References: <cki.495C39BD1A.T35Z6VDJPY@redhat.com>
 <20200513060321.GA17433@willie-the-truck>
 <1322199095.22739428.1589365183678.JavaMail.zimbra@redhat.com>
Message-ID: <1039472143.12305448.1589384415559.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> >        Kernel repo: https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
> >            Commit: 51f14e2c02e8 - Merge branch 'for-next/core' into for-kernelci
> >
> > I'm struggling a bit with this one, please can you confirm that it's not
> > an issue on your end? The failures are related to /dev/cpuset:
> > 
> >   mem.c:760: BROK: mount /dev/cpuset: EBUSY (16)
> >   ...
> >   safe_macros.c:172: BROK: mem.c:750: mkdir(/dev/cpuset,0777) failed:
> >   EEXIST
> >   (17)
> > 
> >   https://cki-artifacts.s3.us-east-2.amazonaws.com/datawarehouse/2020/05/12/564910/LTP/aarch64_2_ltp_mm.fail.log
> > 
> > But we haven't been anywhere near that in the arm64 tree afaik.
> > 
> 
> Hi,
> 
> I suspect this is an LTP bug:
> 
> https://github.com/linux-test-project/ltp/issues/611

[CC cgroups & LTP]

In LTP issue above it was clear that memory controller is in use.
Here it looks like some lingering reference to cpuset controller
that can't be seen in sysfs.

It's triggered by podman tests actually:
1. run podman tests
2. mount -t cgroup -ocpuset cpuset /mnt/cpuset/ -> EBUSY

# mount | grep cgroup
cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,seclabel)

# grep cpuset -r /sys/fs/cgroup/
/sys/fs/cgroup/cgroup.controllers:cpuset cpu io memory pids

And yet, v1 cgroup fails to mount:

# mount -t cgroup -ocpuset cpuset /mnt/cpuset/
mount: /mnt/cpuset: cpuset already mounted or mount point busy.

Fail state persists also after I disable all controllers and move
all processes to root:

# cat /sys/fs/cgroup/cgroup.subtree_control
# ll /sys/fs/cgroup/
total 0
-r--r--r--. 1 root root 0 May 13 10:35 cgroup.controllers
-rw-r--r--. 1 root root 0 May 13 10:44 cgroup.max.depth
-rw-r--r--. 1 root root 0 May 13 10:44 cgroup.max.descendants
-rw-r--r--. 1 root root 0 May 13 10:58 cgroup.procs
-r--r--r--. 1 root root 0 May 13 10:44 cgroup.stat
-rw-r--r--. 1 root root 0 May 13 11:00 cgroup.subtree_control
-rw-r--r--. 1 root root 0 May 13 10:44 cgroup.threads
-rw-r--r--. 1 root root 0 May 13 10:44 cpu.pressure
-r--r--r--. 1 root root 0 May 13 10:44 cpuset.cpus.effective
-r--r--r--. 1 root root 0 May 13 10:44 cpuset.mems.effective
-rw-r--r--. 1 root root 0 May 13 10:44 io.cost.model
-rw-r--r--. 1 root root 0 May 13 10:44 io.cost.qos
-rw-r--r--. 1 root root 0 May 13 10:44 io.pressure
-rw-r--r--. 1 root root 0 May 13 10:44 memory.pressure

# mount -t cgroup -ocpuset cpuset /mnt/cpuset/
mount: /mnt/cpuset: cpuset already mounted or mount point busy

If I reboot and don't run any podman tests, v1 cgroup mounts fine:

# cat /sys/fs/cgroup/cgroup.controllers
cpuset cpu io memory pids
# mount -t cgroup -ocpuset cpuset /mnt/cpuset/
# cat /sys/fs/cgroup/cgroup.controllers
cpu io memory pids
# umount /mnt/cpuset/
# cat /sys/fs/cgroup/cgroup.controllers
cpuset cpu io memory pids

