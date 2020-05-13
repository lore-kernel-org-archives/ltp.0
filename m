From: Tejun Heo <tj@kernel.org>
Date: Wed, 13 May 2020 11:51:14 -0400
Subject: [LTP] 
 =?utf-8?q?=E2=9D=8C_FAIL=3A_Test_report_for_kernel=3F5=2E7?=
 =?utf-8?q?=2E0-rc5-51f14e2=2Ecki_=28arm-next=29?=
In-Reply-To: <1039472143.12305448.1589384415559.JavaMail.zimbra@redhat.com>
References: <cki.495C39BD1A.T35Z6VDJPY@redhat.com>
 <20200513060321.GA17433@willie-the-truck>
 <1322199095.22739428.1589365183678.JavaMail.zimbra@redhat.com>
 <1039472143.12305448.1589384415559.JavaMail.zimbra@redhat.com>
Message-ID: <20200513155114.GF16815@mtj.duckdns.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, May 13, 2020 at 11:40:15AM -0400, Jan Stancek wrote:
> In LTP issue above it was clear that memory controller is in use.
> Here it looks like some lingering reference to cpuset controller
> that can't be seen in sysfs.
> 
> It's triggered by podman tests actually:
> 1. run podman tests
> 2. mount -t cgroup -ocpuset cpuset /mnt/cpuset/ -> EBUSY
> 
> # mount | grep cgroup
> cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime,seclabel)
> 
> # grep cpuset -r /sys/fs/cgroup/
> /sys/fs/cgroup/cgroup.controllers:cpuset cpu io memory pids
> 
> And yet, v1 cgroup fails to mount:
> 
> # mount -t cgroup -ocpuset cpuset /mnt/cpuset/
> mount: /mnt/cpuset: cpuset already mounted or mount point busy.

While if a regression it may point to a newly introduced behavior, in
general, dynamically reassigning cgroup controllers to a different version
hierarchy after active use is not something fully supported. From cgroup2
documentation:

  A controller can be moved across hierarchies only after the controller is
  no longer referenced in its current hierarchy. Because per-cgroup
  controller states are destroyed asynchronously and controllers may have
  lingering references, a controller may not show up immediately on the v2
  hierarchy after the final umount of the previous hierarchy. Similarly, a
  controller should be fully disabled to be moved out of the unified
  hierarchy and it may take some time for the disabled controller to become
  available for other hierarchies; furthermore, due to inter-controller
  dependencies, other controllers may need to be disabled too.

  While useful for development and manual configurations, moving controllers
  dynamically between the v2 and other hierarchies is strongly discouraged
  for production use. It is recommended to decide the hierarchies and
  controller associations before starting using the controllers after system
  boot.

Thanks.

-- 
tejun
