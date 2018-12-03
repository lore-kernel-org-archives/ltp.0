From: Cristian Marussi <cristian.marussi@arm.com>
Date: Mon, 3 Dec 2018 08:51:12 +0000
Subject: [LTP] [PATCH] cgroup_regression_test.sh: fixed test_5
In-Reply-To: <20181121134021.52225-1-cristian.marussi@arm.com>
References: <20181121134021.52225-1-cristian.marussi@arm.com>
Message-ID: <71f43407-6a11-11e6-b8d3-06dc97f0b653@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Hi

On 21/11/2018 13:40, Cristian Marussi wrote:
> test_5 checked for possible regressions using a pair of cgroups mounts
> operations designed to expose a kernel crash; the trigger being the
> attempt to co-mount and mount the same cgroup subsystem onto two
> distinct fs hierarchies: the expected failure in the second mount
> attempt was not properly handled in 2.6.29-rc2 and lead to a kernel
> crash.
> Unfortunately the test assumed that the randomly chosen subsystems
> were NOT already mounted somewhere when attempting the first co-mount:
> this assumption is falsified when userspace is configured to mount all
> available subsystems at /sysfs on boot (systemd).
> So the test was failing straight away during the setup phase:
> 
> cgroup_regression_test    5  TFAIL  :  ltpapicmd.c:188: mount pids and hugetlb failed
> 
> Being not trivial to forcibly release and unmount the populated
> /sysfs cgroups once booted, the script has been reviewed to detect
> this condition upfront and cope with it dynamically:
> 
>  - if not already mounted: co-mount + failing mount (as before)
>  - already mounted: use existing mntpoint + failing co-mount
> 
> Since the original fix was on a 2.6.29 kernel the surrounding cgroup
> code has changed a lot and so the patch was no more trivially 'revertable'
> for testing purposes: as such this reviewed test script has been verified
> using a QEMU x86_64 instance running a Kernel 2.6.39 with and without
> the known fix as detailed in test_5 comments.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

any update on this ?

Thanks

Cristian
